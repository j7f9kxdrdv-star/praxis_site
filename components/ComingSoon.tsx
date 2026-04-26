"use client";

import { useState } from "react";
import Link from "next/link";
import MolecularBg from "@/components/dashboard/MolecularBg";

/**
 * Coming-soon waitlist landing.
 *
 * Rendered at `/` while the site is in "preview" launch mode and the visitor
 * is not authenticated. Captures emails into `waitlist_signups` via
 * /api/waitlist. The "Sign in →" pill in the header is the founder's way past
 * this gate (and any pre-created early-access user can also use it).
 */
export default function ComingSoon() {
  const [email, setEmail] = useState("");
  const [status, setStatus] = useState<
    "idle" | "submitting" | "success" | "error"
  >("idle");
  const [errorMsg, setErrorMsg] = useState("");

  async function onSubmit(e: React.FormEvent) {
    e.preventDefault();
    if (status === "submitting") return;

    const trimmed = email.trim();
    if (!trimmed || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(trimmed)) {
      setErrorMsg("Please enter a valid email address.");
      setStatus("error");
      return;
    }

    setStatus("submitting");
    setErrorMsg("");

    try {
      const res = await fetch("/api/waitlist", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ email: trimmed, source: "coming_soon" }),
      });
      if (!res.ok) {
        const data = await res.json().catch(() => ({}));
        throw new Error(data?.error || "Could not save your email — try again.");
      }
      setStatus("success");
    } catch (err) {
      setStatus("error");
      setErrorMsg(err instanceof Error ? err.message : "Something went wrong.");
    }
  }

  return (
    <main
      className="relative min-h-screen w-full overflow-hidden flex flex-col"
      style={{
        background: "var(--color-prax-cream)",
        fontFamily: "var(--font-prax-sans)",
        color: "var(--color-prax-ink)",
      }}
    >
      <MolecularBg variant="hex" opacity={0.08} />

      {/* Top — wordmark only, no nav */}
      <header className="relative z-[1] flex items-center justify-between px-6 sm:px-10 lg:px-16 py-8">
        <div className="flex items-center gap-3">
          {/* eslint-disable-next-line @next/next/no-img-element */}
          <img
            src="/logo-green.png"
            alt="Praxist Prep logo"
            className="h-9 w-auto"
          />
          <div
            className="leading-[1.02] font-semibold"
            style={{
              fontFamily: "var(--font-prax-serif)",
              fontSize: 22,
              color: "var(--color-prax-green)",
            }}
          >
            Praxist
            <br />
            Prep
          </div>
        </div>

        <div className="flex items-center gap-5">
          <div className="hidden sm:flex items-center gap-2.5">
            <div className="relative w-2 h-2">
              <div
                className="absolute inset-0 rounded-full"
                style={{ background: "var(--color-prax-green-soft)" }}
              />
              <div
                className="absolute inset-0 rounded-full animate-prax-pulse"
                style={{ background: "var(--color-prax-green-soft)" }}
              />
            </div>
            <div
              className="font-semibold uppercase whitespace-nowrap"
              style={{
                fontSize: 10,
                letterSpacing: "0.22em",
                color: "var(--color-prax-ink-mute)",
              }}
            >
              Coming soon
            </div>
          </div>

          {/* Discreet sign-in for the founder / early-access users.
              Public visitors will see it, but /signup is gated so the only
              people who can actually log in are users we've created accounts
              for. */}
          <Link
            href="/login"
            className="font-semibold uppercase whitespace-nowrap transition-colors hover:opacity-100"
            style={{
              fontSize: 10,
              letterSpacing: "0.22em",
              color: "var(--color-prax-green)",
              opacity: 0.75,
              padding: "6px 12px",
              borderRadius: 999,
              border: "1px solid var(--color-prax-cream-border)",
              background: "var(--color-prax-cream-card)",
            }}
          >
            Sign in →
          </Link>
        </div>
      </header>

      {/* Centered hero */}
      <section className="relative z-[1] flex-1 flex items-center justify-center px-6 sm:px-10 lg:px-16 pb-20">
        <div className="w-full max-w-[680px] text-center">
          <div
            className="font-semibold uppercase mx-auto mb-6"
            style={{
              fontSize: 10.5,
              letterSpacing: "0.28em",
              color: "var(--color-prax-ink-mute)",
            }}
          >
            Praxist Prep · MCAT
          </div>

          <h1
            className="font-medium m-0"
            style={{
              fontFamily: "var(--font-prax-serif)",
              fontSize: "clamp(36px, 5.5vw, 56px)",
              lineHeight: 1.08,
              color: "var(--color-prax-green)",
              letterSpacing: "-0.015em",
            }}
          >
            Still preparing your individualized MCAT prep course.
          </h1>

          <p
            className="italic mt-6 mx-auto"
            style={{
              fontFamily: "var(--font-prax-serif)",
              fontSize: "clamp(15px, 2vw, 18px)",
              lineHeight: 1.55,
              color: "var(--color-prax-ink-soft)",
              maxWidth: 520,
            }}
          >
            Enter your email to be notified the moment it&apos;s ready.
          </p>

          {/* Form */}
          {status !== "success" ? (
            <form
              onSubmit={onSubmit}
              className="mt-10 mx-auto flex flex-col sm:flex-row items-stretch gap-3 max-w-[520px]"
            >
              <input
                type="email"
                inputMode="email"
                autoComplete="email"
                required
                placeholder="you@example.com"
                value={email}
                onChange={(e) => {
                  setEmail(e.target.value);
                  if (status === "error") setStatus("idle");
                }}
                disabled={status === "submitting"}
                className="flex-1 outline-none transition-colors"
                style={{
                  background: "var(--color-prax-cream-card)",
                  border: "1px solid var(--color-prax-cream-border)",
                  borderRadius: 999,
                  padding: "14px 22px",
                  fontSize: 15,
                  color: "var(--color-prax-ink)",
                }}
              />
              <button
                type="submit"
                disabled={status === "submitting"}
                className="cursor-pointer transition-opacity"
                style={{
                  background: "var(--color-prax-green)",
                  color: "var(--color-prax-cream)",
                  border: "none",
                  borderRadius: 999,
                  padding: "14px 28px",
                  fontSize: 13.5,
                  fontWeight: 600,
                  letterSpacing: "0.02em",
                  opacity: status === "submitting" ? 0.7 : 1,
                  whiteSpace: "nowrap",
                }}
              >
                {status === "submitting" ? "Sending…" : "Notify me"}
              </button>
            </form>
          ) : (
            <div
              className="mt-10 mx-auto rounded-2xl text-center px-6 py-5 max-w-[520px]"
              style={{
                background: "var(--color-prax-green)",
                color: "var(--color-prax-cream)",
              }}
            >
              <div
                className="font-medium"
                style={{
                  fontFamily: "var(--font-prax-serif)",
                  fontSize: 20,
                }}
              >
                You&apos;re on the list.
              </div>
              <div
                className="italic mt-1.5"
                style={{
                  fontFamily: "var(--font-prax-serif)",
                  fontSize: 14,
                  color: "rgba(246,244,227,0.75)",
                }}
              >
                We&apos;ll email you the moment Praxist Prep opens.
              </div>
            </div>
          )}

          {status === "error" && errorMsg && (
            <div
              className="mt-3 italic"
              style={{
                fontFamily: "var(--font-prax-serif)",
                fontSize: 13,
                color: "var(--color-prax-danger, #a64432)",
              }}
            >
              {errorMsg}
            </div>
          )}

          <div
            className="mt-12 italic"
            style={{
              fontFamily: "var(--font-prax-serif)",
              fontSize: 12,
              color: "var(--color-prax-ink-mute)",
            }}
          >
            — Built deliberately. Tempered by practice. —
          </div>
        </div>
      </section>

      {/* Footer */}
      <footer
        className="relative z-[1] px-6 sm:px-10 lg:px-16 pb-8"
        style={{ fontSize: 11, color: "var(--color-prax-ink-mute)" }}
      >
        <div className="flex items-center justify-between flex-wrap gap-2">
          <span>© {new Date().getFullYear()} Praxist Prep</span>
          <span className="opacity-70">All rights reserved</span>
        </div>
      </footer>
    </main>
  );
}
