"use client";

// ─── Onboarding ────────────────────────────────────────────────────────────
//
// Three questions about INTENT, then a screen showing what was DERIVED from
// them. The derivation is the point: daily card limits and a weekly question
// goal are not things a student can sensibly pick on day one, and leaving them
// on defaults is how one account ended up set to 5,000 new cards a day and
// another to a 150-review ceiling their hours could triple.
//
// EVERY DERIVED NUMBER IS SHOWN BEFORE IT IS SAVED, and every one is editable.
// Nobody should discover a setting they never chose weeks later.
//
// SKIPPING LEAVES FIELDS NULL rather than guessing. The dashboard already has
// an honest "not yet" for each of them, and a guessed target score would be an
// ambition invented on a student's behalf.

import { useEffect, useMemo, useState } from "react";
import { useRouter } from "next/navigation";
import { supabase } from "@/lib/supabase";
import {
  recommendLimits,
  measurePace,
  suggestedWeeklyQuestions,
} from "@/lib/dashboard/recommendedLimits";
import { dailyQuestionTarget } from "@/lib/dashboard/checklist";
import { SmallCaps, praxBtnGreenOnCream } from "@/components/dashboard/PraxUI";
import MolecularBg from "@/components/dashboard/MolecularBg";

const STEPS = ["exam", "target", "hours", "plan"] as const;
type Step = (typeof STEPS)[number];

const MIN_SCORE = 472;
const MAX_SCORE = 528;

export default function Onboarding() {
  const router = useRouter();
  const [step, setStep] = useState<Step>("exam");
  const [firstName, setFirstName] = useState("");
  const [userId, setUserId] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const [examDate, setExamDate] = useState("");
  const [target, setTarget] = useState("");
  const [hours, setHours] = useState("");

  // A lower bound on card-blanks available to introduce. Only ever compared
  // against a daily limit, so counting cards rather than blanks is safe: a
  // cloze card holds one blank or several, never none.
  const [cardCount, setCardCount] = useState(0);

  // Editable on the last screen, seeded from the derivation.
  const [reviewLimit, setReviewLimit] = useState("");
  const [newLimit, setNewLimit] = useState("");
  const [weeklyGoal, setWeeklyGoal] = useState("");

  useEffect(() => {
    (async () => {
      const { data } = await supabase.auth.getUser();
      if (!data.user) {
        router.replace("/login");
        return;
      }
      setUserId(data.user.id);

      const [{ data: profile }, { count }] = await Promise.all([
        supabase
          .from("profiles")
          .select("first_name, mcat_test_date, target_mcat_score, study_hours_per_week")
          .eq("id", data.user.id)
          .maybeSingle(),
        // head: true asks the server for the count and sends back no rows.
        supabase.from("flashcards").select("id", { count: "exact", head: true }),
      ]);

      if (profile) {
        setFirstName(profile.first_name ?? "");
        // Prefill whatever is already answered, so an existing account sent
        // through this once is not made to retype what it has.
        setExamDate(profile.mcat_test_date ?? "");
        setTarget(profile.target_mcat_score != null ? String(profile.target_mcat_score) : "");
        setHours(profile.study_hours_per_week != null ? String(profile.study_hours_per_week) : "");
      }
      setCardCount(count ?? 0);
      setLoading(false);
    })();
  }, [router]);

  // The derivation, from the engine the dashboard uses rather than numbers
  // invented here. A student at this screen has no review history, so demand
  // and stability are genuinely zero and the pace falls back to its documented
  // default, which measurePace reports honestly as unmeasured.
  const derived = useMemo(() => {
    const h = Number(hours);
    if (!Number.isFinite(h) || h <= 0) return null;
    return recommendLimits({
      meanStability: 0,
      relearningShare: 0,
      dailyDemand: 0,
      studyHoursPerWeek: h,
      pace: measurePace([]),
      cardsDue: 0,
      unseenBlanks: cardCount,
      seenBlanks: 0,
      currentReviewLimit: 0,
      currentNewLimit: 0,
    });
  }, [hours, cardCount]);

  useEffect(() => {
    if (!derived || derived.blocked) return;
    setReviewLimit(String(derived.reviewLimit ?? ""));
    setNewLimit(String(derived.newLimit ?? ""));
    setWeeklyGoal(
      String(suggestedWeeklyQuestions(derived.basis.minutesPerDay, derived.basis.cardMinutesPerDay)),
    );
  }, [derived]);

  /** Catch a bad answer on the screen it was typed on, not four screens later. */
  function problemWith(s: Step): string | null {
    if (s === "target" && target.trim() !== "") {
      const n = Number(target);
      if (!Number.isInteger(n) || n < MIN_SCORE || n > MAX_SCORE) {
        return `MCAT scores run from ${MIN_SCORE} to ${MAX_SCORE}.`;
      }
    }
    if (s === "hours" && hours.trim() !== "") {
      const n = Number(hours);
      if (!Number.isFinite(n) || n <= 0 || n > 100) {
        return "Hours a week should be between 1 and 100.";
      }
    }
    return null;
  }

  const index = STEPS.indexOf(step);

  function goNext() {
    const problem = problemWith(step);
    if (problem) {
      setError(problem);
      return;
    }
    setError(null);
    setStep(STEPS[Math.min(index + 1, STEPS.length - 1)]);
  }

  function goBack() {
    setError(null);
    setStep(STEPS[Math.max(index - 1, 0)]);
  }

  async function finish(applyPlan: boolean) {
    if (!userId) return;
    for (const s of STEPS) {
      const problem = problemWith(s);
      if (problem) {
        setStep(s);
        setError(problem);
        return;
      }
    }

    setSaving(true);
    setError(null);

    // Anything left blank stays NULL. Nothing is invented on their behalf.
    const update: Record<string, unknown> = { onboarding_completed: true };
    if (examDate.trim()) update.mcat_test_date = examDate.trim();
    if (target.trim()) update.target_mcat_score = Number(target);
    if (hours.trim()) update.study_hours_per_week = Number(hours);
    if (applyPlan && derived && !derived.blocked) {
      if (Number(reviewLimit) > 0) update.daily_review_limit = Number(reviewLimit);
      if (Number(newLimit) >= 0) update.daily_new_card_limit = Number(newLimit);
      if (Number(weeklyGoal) > 0) update.weekly_question_goal = Number(weeklyGoal);
    }

    const { error: dbErr } = await supabase.from("profiles").update(update).eq("id", userId);
    if (dbErr) {
      setSaving(false);
      setError(dbErr.message || "That did not save. Please try again.");
      return;
    }
    router.replace("/dashboard");
  }

  if (loading) {
    return (
      <div
        className="min-h-screen flex items-center justify-center"
        style={{ background: "var(--color-prax-cream)" }}
      >
        <div
          className="w-8 h-8 border-2 rounded-full animate-spin"
          style={{ borderColor: "var(--color-prax-green)", borderTopColor: "transparent" }}
        />
      </div>
    );
  }

  const planReady = Boolean(derived && !derived.blocked);

  return (
    <div
      className="relative min-h-screen overflow-hidden"
      style={{
        background: "var(--color-prax-cream)",
        fontFamily: "var(--font-prax-sans)",
        color: "var(--color-prax-ink)",
      }}
    >
      <MolecularBg opacity={0.05} variant="hex" />

      <div className="relative z-[1] min-h-screen flex items-center justify-center px-5 py-12 sm:px-8">
        <div className="w-full" style={{ maxWidth: 540 }}>
          {/* Four segments, one per question. Quiet enough to be a rule. */}
          <div className="flex items-center gap-1.5 mb-9" aria-hidden="true">
            {STEPS.map((s, i) => (
              <div
                key={s}
                className="flex-1"
                style={{
                  height: 2,
                  borderRadius: 1,
                  background:
                    i <= index ? "var(--color-prax-green)" : "var(--color-prax-cream-border)",
                  transition: "background 240ms ease",
                }}
              />
            ))}
          </div>

          {step === "exam" && (
            <Screen
              eyebrow={firstName ? `Welcome, ${firstName}` : "Welcome"}
              title="When do you sit the MCAT?"
              note="This sets the order of your daily plan. Skip it if you have not booked a date yet, and add it in Settings when you do."
            >
              <Field label="Test date" type="date" value={examDate} onChange={setExamDate} />
            </Screen>
          )}

          {step === "target" && (
            <Screen
              eyebrow="Question 2 of 3"
              title="What score are you working toward?"
              note="Optional. Your dashboard uses it to say whether your progress is tracking toward that score. Without one, it stays quiet on the question rather than guessing."
            >
              <Field
                label={`Target score (${MIN_SCORE} to ${MAX_SCORE})`}
                type="number"
                value={target}
                onChange={setTarget}
                placeholder="e.g. 512"
                inputMode="numeric"
              />
            </Screen>
          )}

          {step === "hours" && (
            <Screen
              eyebrow="Question 3 of 3"
              title="How many hours a week can you study?"
              note="Be honest rather than ambitious. Your whole daily plan is worked out from this number, so one you will actually hit produces a plan that fits."
            >
              <Field
                label="Hours per week"
                type="number"
                value={hours}
                onChange={setHours}
                placeholder="e.g. 15"
                inputMode="decimal"
              />
            </Screen>
          )}

          {step === "plan" && (
            <Screen
              eyebrow="Your starting plan"
              title={planReady ? "Here is what that works out to." : "We need your hours first."}
              note={
                planReady
                  ? `About ${derived!.basis.cardMinutesPerDay} minutes of flashcards a day, plus questions. Change anything that looks wrong, now or later in Settings.`
                  : "Go back a step and add your weekly hours, and we can suggest where to start."
              }
            >
              {planReady ? (
                <>
                  <Field
                    label="New cards a day"
                    type="number"
                    value={newLimit}
                    onChange={setNewLimit}
                    inputMode="numeric"
                    hint={derived!.newReason}
                  />
                  <Field
                    label="Card reviews a day"
                    type="number"
                    value={reviewLimit}
                    onChange={setReviewLimit}
                    inputMode="numeric"
                    hint="A ceiling, not a quota. You will only be asked for the cards that are actually due, which on day one is none of them."
                  />
                  <Field
                    label="Practice questions a week"
                    type="number"
                    value={weeklyGoal}
                    onChange={setWeeklyGoal}
                    inputMode="numeric"
                    hint={`Roughly ${dailyQuestionTarget(Number(weeklyGoal) || 0)} a day, spread across seven.`}
                  />
                </>
              ) : (
                <p
                  className="m-0"
                  style={{ fontSize: 13.5, lineHeight: 1.6, color: "var(--color-prax-ink-soft)" }}
                >
                  You can also set these later. Your dashboard fills in as you study.
                </p>
              )}
            </Screen>
          )}

          {error && (
            <p
              role="alert"
              className="m-0 mt-5"
              style={{ fontSize: 13, color: "var(--color-prax-danger)" }}
            >
              {error}
            </p>
          )}

          <div className="flex items-center gap-4 mt-8 flex-wrap">
            {step !== "plan" ? (
              <button onClick={goNext} style={praxBtnGreenOnCream}>
                Continue
              </button>
            ) : (
              <button
                onClick={() => finish(true)}
                disabled={saving}
                style={{ ...praxBtnGreenOnCream, opacity: saving ? 0.6 : 1 }}
              >
                {saving ? "Saving" : planReady ? "Start studying" : "Finish"}
              </button>
            )}
            {index > 0 && (
              <button onClick={goBack} style={textBtn}>
                Back
              </button>
            )}
            <button
              onClick={() => finish(false)}
              disabled={saving}
              style={{ ...textBtn, marginLeft: "auto" }}
            >
              Skip for now
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}

/* ─────────────── pieces ─────────────── */

function Screen({
  eyebrow,
  title,
  note,
  children,
}: {
  eyebrow: string;
  title: string;
  note: string;
  children: React.ReactNode;
}) {
  return (
    <div>
      <SmallCaps className="mb-3">{eyebrow}</SmallCaps>
      <h1
        className="font-normal m-0 text-[30px] sm:text-[36px]"
        style={{
          fontFamily: "var(--font-prax-serif)",
          lineHeight: 1.12,
          letterSpacing: "-0.01em",
          color: "var(--color-prax-green)",
          textWrap: "balance",
        }}
      >
        {title}
      </h1>
      <p
        className="m-0 mt-3 mb-8"
        style={{
          fontSize: 14,
          lineHeight: 1.65,
          color: "var(--color-prax-ink-soft)",
          maxWidth: "54ch",
        }}
      >
        {note}
      </p>
      {children}
    </div>
  );
}

function Field({
  label,
  type,
  value,
  onChange,
  placeholder,
  inputMode,
  hint,
}: {
  label: string;
  type: string;
  value: string;
  onChange: (v: string) => void;
  placeholder?: string;
  inputMode?: "numeric" | "decimal";
  hint?: string;
}) {
  return (
    <label className="block mb-5">
      <span
        className="block font-semibold uppercase mb-2"
        style={{ fontSize: 10, letterSpacing: "0.16em", color: "var(--color-prax-ink-mute)" }}
      >
        {label}
      </span>
      <input
        type={type}
        value={value}
        placeholder={placeholder}
        inputMode={inputMode}
        onChange={(e) => onChange(e.target.value)}
        className="w-full"
        style={{
          background: "var(--color-prax-cream-card)",
          border: "1px solid var(--color-prax-cream-border)",
          borderRadius: 10,
          padding: "13px 15px",
          fontSize: 16, // 16px or larger, or iOS Safari zooms the page on focus.
          fontFamily: "inherit",
          color: "var(--color-prax-ink)",
          fontVariantNumeric: "tabular-nums",
        }}
      />
      {hint && (
        <span
          className="block mt-2"
          style={{ fontSize: 12.5, lineHeight: 1.5, color: "var(--color-prax-ink-mute)" }}
        >
          {hint}
        </span>
      )}
    </label>
  );
}

const textBtn: React.CSSProperties = {
  background: "transparent",
  border: "none",
  padding: "6px 2px",
  fontSize: 12.5,
  fontWeight: 600,
  letterSpacing: "0.08em",
  color: "var(--color-prax-ink-mute)",
  cursor: "pointer",
};
