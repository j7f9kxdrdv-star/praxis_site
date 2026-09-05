"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { supabase } from "@/lib/supabase";
import { useDashboard } from "@/components/dashboard/DashboardShell";

interface OfficialScore {
  id: string;
  exam_date: string;
  total_score: number;
  score_cp: number | null;
  score_cars: number | null;
  score_bb: number | null;
  score_ps: number | null;
}

const SUBSCRIPTION_LABELS: Record<string, string> = {
  free: "Early access, free until billing opens",
  practice: "Practice ($79/mo)",
  self_paced: "Self-Paced Course ($199/mo)",
};

export default function SettingsPage() {
  const router = useRouter();
  const { user, profile, refreshProfile } = useDashboard();

  // Profile form state
  const [firstName, setFirstName] = useState("");
  const [lastName, setLastName] = useState("");
  const [mcatDate, setMcatDate] = useState("");
  const [studyHours, setStudyHours] = useState<string>("");
  const [weeklyGoal, setWeeklyGoal] = useState<string>("");
  // Their actual recent pace, shown as a hint so the goal they pick is grounded.
  const [recentPace, setRecentPace] = useState<number | null>(null);

  const [savingProfile, setSavingProfile] = useState(false);
  const [profileSaved, setProfileSaved] = useState(false);
  const [profileError, setProfileError] = useState<string | null>(null);


  // Password form state
  const [newPassword, setNewPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [showPassword, setShowPassword] = useState(false);
  const [changingPassword, setChangingPassword] = useState(false);
  const [passwordSaved, setPasswordSaved] = useState(false);
  const [passwordError, setPasswordError] = useState<string | null>(null);

  // Official MCAT results the student chooses to report. This is the only data
  // that can ever calibrate the score estimate against reality, and it cannot
  // be collected retroactively, so the form exists before the predictor that
  // will eventually use it.
  const [officialScores, setOfficialScores] = useState<OfficialScore[]>([]);
  const [examDate, setExamDate] = useState("");
  const [totalScore, setTotalScore] = useState("");
  const [scoreCp, setScoreCp] = useState("");
  const [scoreCars, setScoreCars] = useState("");
  const [scoreBb, setScoreBb] = useState("");
  const [scorePs, setScorePs] = useState("");
  const [savingScore, setSavingScore] = useState(false);
  const [scoreSaved, setScoreSaved] = useState(false);
  const [scoreError, setScoreError] = useState<string | null>(null);

  const [signingOut, setSigningOut] = useState(false);

  useEffect(() => {
    async function loadScores() {
      const { data } = await supabase
        .from("official_mcat_scores")
        .select("id, exam_date, total_score, score_cp, score_cars, score_bb, score_ps")
        .eq("user_id", user.id)
        .order("exam_date", { ascending: false });
      setOfficialScores((data as OfficialScore[]) || []);
    }
    loadScores();
  }, [user.id]);

  async function saveOfficialScore(e: React.FormEvent) {
    e.preventDefault();
    setSavingScore(true);
    setScoreError(null);

    const total = Number(totalScore);
    if (!examDate) {
      setScoreError("Which date did you sit the exam?");
      setSavingScore(false);
      return;
    }
    if (!Number.isInteger(total) || total < 472 || total > 528) {
      setScoreError("Total score must be a whole number between 472 and 528.");
      setSavingScore(false);
      return;
    }

    const sections = [
      ["C/P", scoreCp],
      ["CARS", scoreCars],
      ["B/B", scoreBb],
      ["P/S", scorePs],
    ] as const;
    const parsed: Record<string, number | null> = {};
    for (const [label, raw] of sections) {
      if (!raw.trim()) {
        parsed[label] = null;
        continue;
      }
      const v = Number(raw);
      if (!Number.isInteger(v) || v < 118 || v > 132) {
        setScoreError(`${label} must be a whole number between 118 and 132.`);
        setSavingScore(false);
        return;
      }
      parsed[label] = v;
    }

    // If all four sections are given they must add up. Catching a typo here is
    // worth it, because a wrong outcome is worse than a missing one: it would
    // quietly bias every future calibration.
    const given = Object.values(parsed).filter((v) => v !== null) as number[];
    if (given.length === 4) {
      const sum = given.reduce((a, b) => a + b, 0);
      if (sum !== total) {
        setScoreError(
          `Your section scores add up to ${sum}, but you entered ${total} as the total.`
        );
        setSavingScore(false);
        return;
      }
    }

    const { error } = await supabase.from("official_mcat_scores").upsert(
      {
        user_id: user.id,
        exam_date: examDate,
        total_score: total,
        score_cp: parsed["C/P"],
        score_cars: parsed["CARS"],
        score_bb: parsed["B/B"],
        score_ps: parsed["P/S"],
      },
      { onConflict: "user_id,exam_date" }
    );

    setSavingScore(false);
    if (error) {
      setScoreError(error.message || "Save failed");
      return;
    }

    const { data } = await supabase
      .from("official_mcat_scores")
      .select("id, exam_date, total_score, score_cp, score_cars, score_bb, score_ps")
      .eq("user_id", user.id)
      .order("exam_date", { ascending: false });
    setOfficialScores((data as OfficialScore[]) || []);
    setExamDate("");
    setTotalScore("");
    setScoreCp("");
    setScoreCars("");
    setScoreBb("");
    setScorePs("");
    setScoreSaved(true);
    setTimeout(() => setScoreSaved(false), 2500);
  }

  // Hydrate form from profile when it loads
  useEffect(() => {
    if (!profile) return;
    setFirstName(profile.first_name || "");
    setLastName(profile.last_name || "");
    setMcatDate(profile.mcat_test_date || "");
    setStudyHours(
      profile.study_hours_per_week !== null &&
        profile.study_hours_per_week !== undefined
        ? String(profile.study_hours_per_week)
        : ""
    );
    setWeeklyGoal(
      profile.weekly_question_goal !== null &&
        profile.weekly_question_goal !== undefined
        ? String(profile.weekly_question_goal)
        : ""
    );
  }, [profile]);

  // Last 7 days of practice, to suggest a realistic goal.
  useEffect(() => {
    let active = true;
    (async () => {
      const since = new Date();
      since.setDate(since.getDate() - 7);
      const { count } = await supabase
        .from("question_attempts")
        .select("*", { count: "exact", head: true })
        .eq("user_id", user.id)
        .gte("created_at", since.toISOString());
      if (active) setRecentPace(count ?? 0);
    })();
    return () => {
      active = false;
    };
  }, [user.id]);

  async function saveProfile(e: React.FormEvent) {
    e.preventDefault();
    setSavingProfile(true);
    setProfileError(null);
    setProfileSaved(false);

    const studyHoursNum = studyHours.trim() === "" ? null : Number(studyHours);
    if (studyHoursNum !== null && (isNaN(studyHoursNum) || studyHoursNum < 0)) {
      setProfileError("Study hours per week must be a non-negative number.");
      setSavingProfile(false);
      return;
    }

    const weeklyGoalNum = weeklyGoal.trim() === "" ? null : Number(weeklyGoal);
    if (
      weeklyGoalNum !== null &&
      (!Number.isInteger(weeklyGoalNum) || weeklyGoalNum < 1 || weeklyGoalNum > 2000)
    ) {
      setProfileError("Weekly question goal must be a whole number between 1 and 2000.");
      setSavingProfile(false);
      return;
    }

    const { error } = await supabase
      .from("profiles")
      .update({
        first_name: firstName.trim() || null,
        last_name: lastName.trim() || null,
        mcat_test_date: mcatDate.trim() || null,
        study_hours_per_week: studyHoursNum,
        weekly_question_goal: weeklyGoalNum,
      })
      .eq("id", user.id);

    setSavingProfile(false);

    if (error) {
      setProfileError(error.message || "Save failed");
      return;
    }

    setProfileSaved(true);
    await refreshProfile();
    setTimeout(() => setProfileSaved(false), 2500);
  }

  async function changePassword(e: React.FormEvent) {
    e.preventDefault();
    setPasswordError(null);
    setPasswordSaved(false);

    if (newPassword.length < 8) {
      setPasswordError("Password must be at least 8 characters.");
      return;
    }
    if (newPassword !== confirmPassword) {
      setPasswordError("Passwords don't match.");
      return;
    }

    setChangingPassword(true);
    const { error } = await supabase.auth.updateUser({ password: newPassword });
    setChangingPassword(false);

    if (error) {
      setPasswordError(error.message || "Couldn't update password");
      return;
    }

    setPasswordSaved(true);
    setNewPassword("");
    setConfirmPassword("");
    setTimeout(() => setPasswordSaved(false), 2500);
  }

  async function signOut() {
    setSigningOut(true);
    await supabase.auth.signOut();
    router.push("/");
  }

  return (
    <div className="font-body px-5 py-8 lg:px-0 lg:py-0 max-w-[680px]">
      <div className="mb-8">
        <div
          className="text-[11px] uppercase mb-2 font-semibold"
          style={{
            letterSpacing: "0.22em",
            color: "var(--color-prax-ink-mute)",
          }}
        >
          Your Account
        </div>
        <h1
          className="font-serif mb-2"
          style={{
            fontSize: 32,
            fontWeight: 500,
            color: "var(--color-prax-ink)",
            lineHeight: 1.15,
          }}
        >
          Settings
        </h1>
        <p
          className="text-[14px]"
          style={{ color: "var(--color-prax-ink-soft)" }}
        >
          Update your profile, change your password, or sign out.
        </p>
      </div>

      {/* ─────────── Profile section ─────────── */}
      <Section title="Profile">
        <form onSubmit={saveProfile} className="space-y-4">
          <ReadOnlyField label="Email" value={user.email || ""} />
          <ReadOnlyField
            label="Subscription"
            value={
              SUBSCRIPTION_LABELS[profile?.subscription_tier || "free"] ||
              profile?.subscription_tier ||
              "Free"
            }
          />
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <TextField
              label="First name"
              value={firstName}
              onChange={setFirstName}
              autoComplete="given-name"
            />
            <TextField
              label="Last name"
              value={lastName}
              onChange={setLastName}
              autoComplete="family-name"
            />
          </div>
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <TextField
              label="MCAT test date"
              type="date"
              value={mcatDate}
              onChange={setMcatDate}
            />
            <TextField
              label="Study hours per week"
              type="number"
              value={studyHours}
              onChange={setStudyHours}
              placeholder="e.g. 15"
            />
          </div>
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <div>
              <TextField
                label="Weekly question goal"
                type="number"
                value={weeklyGoal}
                onChange={setWeeklyGoal}
                placeholder="e.g. 100"
              />
              <div
                className="mt-1.5 text-[12px]"
                style={{ color: "var(--color-prax-ink-mute)" }}
              >
                {recentPace === null
                  ? "Drives the progress ring on your dashboard."
                  : `You answered ${recentPace} question${recentPace === 1 ? "" : "s"} in the last 7 days. Pick a target that stretches you a little.`}
              </div>
            </div>
          </div>

          {profileError && (
            <div
              className="text-[12px]"
              style={{ color: "var(--color-prax-red, #b94a4a)" }}
            >
              {profileError}
            </div>
          )}

          <div className="flex items-center gap-3 pt-1">
            <button
              type="submit"
              disabled={savingProfile}
              className="px-5 py-2 rounded-lg font-semibold text-[13px] disabled:opacity-50"
              style={{
                background: "var(--color-prax-green)",
                color: "#fff",
              }}
            >
              {savingProfile ? "Saving…" : "Save profile"}
            </button>
            {profileSaved && (
              <span
                className="text-[12px]"
                style={{ color: "var(--color-prax-green)" }}
              >
                ✓ Saved
              </span>
            )}
          </div>
        </form>
      </Section>

      {/* ─────────── Password section ─────────── */}
      <Section title="Change password">
        <form onSubmit={changePassword} className="space-y-4">
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <TextField
              label="New password"
              type={showPassword ? "text" : "password"}
              value={newPassword}
              onChange={setNewPassword}
              placeholder="At least 8 characters"
              autoComplete="new-password"
            />
            <TextField
              label="Confirm new password"
              type={showPassword ? "text" : "password"}
              value={confirmPassword}
              onChange={setConfirmPassword}
              autoComplete="new-password"
            />
          </div>
          <label
            className="flex items-center gap-2 text-[12px] cursor-pointer"
            style={{ color: "var(--color-prax-ink-soft)" }}
          >
            <input
              type="checkbox"
              checked={showPassword}
              onChange={(e) => setShowPassword(e.target.checked)}
            />
            Show passwords
          </label>

          {passwordError && (
            <div
              className="text-[12px]"
              style={{ color: "var(--color-prax-red, #b94a4a)" }}
            >
              {passwordError}
            </div>
          )}

          <div className="flex items-center gap-3 pt-1">
            <button
              type="submit"
              disabled={
                changingPassword || newPassword === "" || confirmPassword === ""
              }
              className="px-5 py-2 rounded-lg font-semibold text-[13px] disabled:opacity-50"
              style={{
                background: "var(--color-prax-green)",
                color: "#fff",
              }}
            >
              {changingPassword ? "Updating…" : "Update password"}
            </button>
            {passwordSaved && (
              <span
                className="text-[12px]"
                style={{ color: "var(--color-prax-green)" }}
              >
                ✓ Password updated
              </span>
            )}
          </div>
        </form>
      </Section>

      {/* ─────────── Sign out ─────────── */}
      {/* ─────────── Official MCAT score ─────────── */}
      <Section title="Your official MCAT score">
        <p
          className="text-[13px] mb-4"
          style={{ color: "var(--color-prax-ink-soft)", lineHeight: 1.55 }}
        >
          If you have taken the real MCAT, adding your score here is the single
          most useful thing you can do for the accuracy of our estimates. We
          compare what Praxist predicted against what actually happened. Your
          score is private, is never shown to other students, and adding it is
          entirely optional.
        </p>

        {officialScores.length > 0 && (
          <div className="mb-5">
            {officialScores.map((sc) => (
              <div
                key={sc.id}
                className="flex items-baseline gap-3 py-2.5"
                style={{ borderTop: "1px solid var(--color-prax-cream-border)" }}
              >
                <span
                  className="font-serif"
                  style={{ fontSize: 20, color: "var(--color-prax-green)" }}
                >
                  {sc.total_score}
                </span>
                <span
                  className="text-[11px] font-semibold uppercase"
                  style={{ letterSpacing: "0.14em", color: "var(--color-prax-ink-mute)" }}
                >
                  {new Date(sc.exam_date + "T00:00:00").toLocaleDateString(undefined, {
                    year: "numeric",
                    month: "long",
                    day: "numeric",
                  })}
                </span>
                {sc.score_cp !== null && (
                  <span
                    className="text-[11px] ml-auto"
                    style={{ color: "var(--color-prax-ink-mute)" }}
                  >
                    {sc.score_cp} / {sc.score_cars} / {sc.score_bb} / {sc.score_ps}
                  </span>
                )}
              </div>
            ))}
          </div>
        )}

        <form onSubmit={saveOfficialScore} className="space-y-4">
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <TextField
              label="Exam date"
              type="date"
              value={examDate}
              onChange={setExamDate}
            />
            <TextField
              label="Total score (472 to 528)"
              type="number"
              value={totalScore}
              onChange={setTotalScore}
              placeholder="e.g. 512"
            />
          </div>

          <div>
            <div
              className="text-[11px] font-semibold uppercase mb-2"
              style={{ letterSpacing: "0.14em", color: "var(--color-prax-ink-mute)" }}
            >
              Section scores, optional
            </div>
            <div className="grid grid-cols-2 sm:grid-cols-4 gap-3">
              <TextField label="C/P" type="number" value={scoreCp} onChange={setScoreCp} placeholder="118-132" />
              <TextField label="CARS" type="number" value={scoreCars} onChange={setScoreCars} placeholder="118-132" />
              <TextField label="B/B" type="number" value={scoreBb} onChange={setScoreBb} placeholder="118-132" />
              <TextField label="P/S" type="number" value={scorePs} onChange={setScorePs} placeholder="118-132" />
            </div>
          </div>

          {scoreError && (
            <div className="text-[12px]" style={{ color: "var(--color-prax-red, #b94a4a)" }}>
              {scoreError}
            </div>
          )}

          <div className="flex items-center gap-3 pt-1">
            <button
              type="submit"
              disabled={savingScore}
              className="px-5 py-2 rounded-lg font-semibold text-[13px] disabled:opacity-50"
              style={{ background: "var(--color-prax-green)", color: "#fff" }}
            >
              {savingScore ? "Saving…" : "Add score"}
            </button>
            {scoreSaved && (
              <span className="text-[12px]" style={{ color: "var(--color-prax-green)" }}>
                ✓ Thank you
              </span>
            )}
          </div>
        </form>
      </Section>

      <Section title="Sign out">
        <p
          className="text-[13px] mb-3"
          style={{ color: "var(--color-prax-ink-soft)" }}
        >
          End your session on this device. You'll need to sign back in to
          study.
        </p>
        <button
          onClick={signOut}
          disabled={signingOut}
          className="px-5 py-2 rounded-lg font-semibold text-[13px] disabled:opacity-50"
          style={{
            background: "transparent",
            color: "var(--color-prax-ink)",
            border: "1px solid var(--color-prax-cream-border)",
          }}
        >
          {signingOut ? "Signing out…" : "Sign out"}
        </button>
      </Section>
    </div>
  );
}

/* ─────────────── tiny field helpers ─────────────── */

function Section({
  title,
  children,
}: {
  title: string;
  children: React.ReactNode;
}) {
  return (
    <div
      className="mb-5 px-5 py-5 rounded-xl"
      style={{
        background: "var(--color-prax-cream-card)",
        border: "1px solid var(--color-prax-cream-border)",
      }}
    >
      <h2
        className="font-serif mb-4"
        style={{
          fontSize: 18,
          fontWeight: 500,
          color: "var(--color-prax-ink)",
        }}
      >
        {title}
      </h2>
      {children}
    </div>
  );
}

function TextField({
  label,
  value,
  onChange,
  type = "text",
  placeholder,
  autoComplete,
}: {
  label: string;
  value: string;
  onChange: (v: string) => void;
  type?: string;
  placeholder?: string;
  autoComplete?: string;
}) {
  return (
    <label className="block">
      <div
        className="text-[11px] font-semibold uppercase mb-1.5"
        style={{
          letterSpacing: "0.14em",
          color: "var(--color-prax-ink-mute)",
        }}
      >
        {label}
      </div>
      <input
        type={type}
        value={value}
        onChange={(e) => onChange(e.target.value)}
        placeholder={placeholder}
        autoComplete={autoComplete}
        className="w-full px-3 py-2 rounded-lg text-[14px]"
        style={{
          background: "var(--color-prax-cream)",
          color: "var(--color-prax-ink)",
          border: "1px solid var(--color-prax-cream-border)",
        }}
      />
    </label>
  );
}

function ReadOnlyField({ label, value }: { label: string; value: string }) {
  return (
    <div>
      <div
        className="text-[11px] font-semibold uppercase mb-1.5"
        style={{
          letterSpacing: "0.14em",
          color: "var(--color-prax-ink-mute)",
        }}
      >
        {label}
      </div>
      <div
        className="w-full px-3 py-2 rounded-lg text-[14px]"
        style={{
          background: "var(--color-prax-cream)",
          color: "var(--color-prax-ink-soft)",
          border: "1px dashed var(--color-prax-cream-border)",
        }}
      >
        {value}
      </div>
    </div>
  );
}
