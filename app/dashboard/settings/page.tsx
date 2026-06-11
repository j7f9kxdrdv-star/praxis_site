"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { supabase } from "@/lib/supabase";
import { useDashboard } from "@/components/dashboard/DashboardShell";

const SUBSCRIPTION_LABELS: Record<string, string> = {
  free: "Free",
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

  const [savingProfile, setSavingProfile] = useState(false);
  const [profileSaved, setProfileSaved] = useState(false);
  const [profileError, setProfileError] = useState<string | null>(null);

  // Daily flashcard limits state
  const [newCardLimit, setNewCardLimit] = useState<string>("");
  const [reviewLimit, setReviewLimit] = useState<string>("");
  const [savingLimits, setSavingLimits] = useState(false);
  const [limitsSaved, setLimitsSaved] = useState(false);
  const [limitsError, setLimitsError] = useState<string | null>(null);

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
    setNewCardLimit(String(profile.daily_new_card_limit ?? 25));
    setReviewLimit(String(profile.daily_review_limit ?? 150));
  }, [profile]);

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

    const { error } = await supabase
      .from("profiles")
      .update({
        first_name: firstName.trim() || null,
        last_name: lastName.trim() || null,
        mcat_test_date: mcatDate.trim() || null,
        study_hours_per_week: studyHoursNum,
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

  async function saveLimits(e: React.FormEvent) {
    e.preventDefault();
    setSavingLimits(true);
    setLimitsError(null);
    setLimitsSaved(false);

    const newCardNum = Number(newCardLimit);
    const reviewNum = Number(reviewLimit);

    if (!Number.isInteger(newCardNum) || newCardNum < 0) {
      setLimitsError("New cards per day must be a whole number ≥ 0.");
      setSavingLimits(false);
      return;
    }
    if (!Number.isInteger(reviewNum) || reviewNum < 0) {
      setLimitsError("Reviews per day must be a whole number ≥ 0.");
      setSavingLimits(false);
      return;
    }

    const { error } = await supabase
      .from("profiles")
      .update({
        daily_new_card_limit: newCardNum,
        daily_review_limit: reviewNum,
      })
      .eq("id", user.id);

    setSavingLimits(false);

    if (error) {
      setLimitsError(error.message || "Save failed");
      return;
    }

    setLimitsSaved(true);
    await refreshProfile();
    setTimeout(() => setLimitsSaved(false), 2500);
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

      {/* ─────────── Daily flashcard limits ─────────── */}
      <Section title="Daily flashcard limits">
        <p
          className="text-[13px] mb-4"
          style={{ color: "var(--color-prax-ink-soft)" }}
        >
          Cap how many cards you see each day so review doesn&apos;t pile up.
          The session picker respects these in <em>Due</em> mode (the main
          daily study flow); <em>Cram</em> and <em>Starred</em> ignore them
          on purpose.
        </p>
        <form onSubmit={saveLimits} className="space-y-4">
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <TextField
              label="New cards per day"
              type="number"
              value={newCardLimit}
              onChange={setNewCardLimit}
              placeholder="e.g. 25"
            />
            <TextField
              label="Reviews per day"
              type="number"
              value={reviewLimit}
              onChange={setReviewLimit}
              placeholder="e.g. 150"
            />
          </div>
          <p
            className="text-[12px]"
            style={{ color: "var(--color-prax-ink-mute)" }}
          >
            A <strong>new card</strong> is one you&apos;ve never reviewed
            before. A <strong>review</strong> is a card you&apos;ve seen that
            is now due to come back. Set either to 0 to pause that category
            entirely.
          </p>

          {limitsError && (
            <div
              className="text-[12px]"
              style={{ color: "var(--color-prax-red, #b94a4a)" }}
            >
              {limitsError}
            </div>
          )}

          <div className="flex items-center gap-3 pt-1">
            <button
              type="submit"
              disabled={savingLimits}
              className="px-5 py-2 rounded-lg font-semibold text-[13px] disabled:opacity-50"
              style={{
                background: "var(--color-prax-green)",
                color: "#fff",
              }}
            >
              {savingLimits ? "Saving…" : "Save limits"}
            </button>
            {limitsSaved && (
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
