"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { supabase } from "@/lib/supabase";
import { useDashboard } from "@/components/dashboard/DashboardShell";

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

  const [signingOut, setSigningOut] = useState(false);

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
