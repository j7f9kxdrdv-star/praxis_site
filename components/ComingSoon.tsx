"use client";

import { useState } from "react";
import Link from "next/link";
import Image from "next/image";

/**
 * Coming-soon waitlist landing.
 *
 * Rendered at `/` while the site is in "preview" launch mode and the visitor
 * is not authenticated. Captures emails into `waitlist_signups` via
 * /api/waitlist. The "Sign in →" pill in the header is the founder's way past
 * this gate (and any pre-created early-access user can also use it).
 *
 * Layout: full-bleed split screen — photo on the left, black panel on the
 * right with the wordmark, copy, email form, and sign-in. Stacks on mobile.
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
      className="relative min-h-screen w-full grid grid-cols-1 lg:grid-cols-[65%_35%]"
      style={{
        fontFamily: "var(--font-prax-sans)",
        background: "#0a0a0a",
      }}
    >
      {/* Left — full-bleed photo */}
      <div className="relative w-full h-[42vh] lg:h-screen lg:sticky lg:top-0">
        <Image
          src="/coming-soon-hero.jpg"
          alt="Two students studying together at a lamp-lit desk"
          fill
          priority
          sizes="(max-width: 1024px) 100vw, 65vw"
          className="object-cover"
        />
        {/* Subtle vignette so the logo reads cleanly on the image */}
        <div
          className="pointer-events-none absolute inset-0"
          style={{
            background:
              "linear-gradient(180deg, rgba(0,0,0,0.45) 0%, rgba(0,0,0,0) 30%, rgba(0,0,0,0) 70%, rgba(0,0,0,0.4) 100%)",
          }}
        />
        {/* Desktop only — fade the right edge of the photo into the black panel
            so the divider disappears. Bottom fade on mobile (where panels
            stack) is handled by the vignette above. */}
        <div
          className="pointer-events-none absolute inset-0 hidden lg:block"
          style={{
            background:
              "linear-gradient(90deg, rgba(10,10,10,0) 60%, rgba(10,10,10,0.6) 82%, #0a0a0a 100%)",
          }}
        />

        {/* Logo + brand — overlays the photo */}
        <div className="absolute top-6 left-6 sm:top-8 sm:left-10 lg:top-10 lg:left-12 flex items-center gap-3 z-[1]">
          {/* eslint-disable-next-line @next/next/no-img-element */}
          <img
            src="/logo-white.png"
            alt="Praxist Prep logo"
            className="h-9 w-auto"
          />
          <div
            className="leading-[1.02] font-semibold"
            style={{
              fontFamily: "var(--font-prax-serif)",
              fontSize: 22,
              color: "var(--color-prax-cream)",
            }}
          >
            Praxist
            <br />
            Prep
          </div>
        </div>
      </div>

      {/* Right — black panel with copy + form */}
      <div className="relative flex flex-col" style={{ background: "#0a0a0a" }}>
        {/* Top-right corner — coming soon indicator + sign in */}
        <div className="flex items-center justify-end gap-5 px-6 sm:px-10 lg:px-12 pt-6 sm:pt-8 lg:pt-10">
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
                color: "rgba(246,244,227,0.6)",
              }}
            >
              Coming soon
            </div>
          </div>

          <Link
            href="/login"
            className="font-semibold uppercase whitespace-nowrap transition-opacity hover:opacity-100"
            style={{
              fontSize: 10,
              letterSpacing: "0.22em",
              color: "var(--color-prax-cream)",
              opacity: 0.85,
              padding: "6px 12px",
              borderRadius: 999,
              border: "1px solid rgba(246,244,227,0.25)",
              background: "transparent",
            }}
          >
            Sign in →
          </Link>
        </div>

        {/* Centered content */}
        <div className="flex-1 flex items-center px-6 sm:px-10 lg:px-12 py-12 lg:py-16">
          <div className="w-full max-w-[520px] mx-auto lg:mx-0">
            <div
              className="font-semibold uppercase mb-6"
              style={{
                fontSize: 10.5,
                letterSpacing: "0.28em",
                color: "rgba(246,244,227,0.55)",
              }}
            >
              Praxist Prep · MCAT
            </div>

            <h1
              className="font-medium m-0"
              style={{
                fontFamily: "var(--font-prax-serif)",
                fontSize: "clamp(34px, 4.2vw, 50px)",
                lineHeight: 1.08,
                color: "var(--color-prax-cream)",
                letterSpacing: "-0.015em",
              }}
            >
              Still preparing your individualized MCAT prep course.
            </h1>

            <p
              className="italic mt-5"
              style={{
                fontFamily: "var(--font-prax-serif)",
                fontSize: "clamp(15px, 1.5vw, 17px)",
                lineHeight: 1.55,
                color: "rgba(246,244,227,0.7)",
              }}
            >
              Enter your email to be notified the moment it&apos;s ready.
            </p>

            {/* Form */}
            {status !== "success" ? (
              <form
                onSubmit={onSubmit}
                className="mt-8 flex flex-col sm:flex-row items-stretch gap-3"
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
                  className="flex-1 outline-none transition-colors placeholder:opacity-50"
                  style={{
                    background: "rgba(246,244,227,0.06)",
                    border: "1px solid rgba(246,244,227,0.18)",
                    borderRadius: 999,
                    padding: "14px 22px",
                    fontSize: 15,
                    color: "var(--color-prax-cream)",
                  }}
                />
                <button
                  type="submit"
                  disabled={status === "submitting"}
                  className="cursor-pointer transition-opacity"
                  style={{
                    background: "var(--color-prax-cream)",
                    color: "var(--color-prax-ink)",
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
                className="mt-8 rounded-2xl px-6 py-5"
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
                  color: "#e8a594",
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
                color: "rgba(246,244,227,0.4)",
              }}
            >
              — Built deliberately. Tempered by practice. —
            </div>
          </div>
        </div>

        {/* Footer */}
        <footer
          className="px-6 sm:px-10 lg:px-12 pb-6 lg:pb-8 flex items-center justify-between flex-wrap gap-2"
          style={{ fontSize: 11, color: "rgba(246,244,227,0.4)" }}
        >
          <span>© {new Date().getFullYear()} Praxist Prep</span>
          <span className="opacity-70">All rights reserved</span>
        </footer>
      </div>
    </main>
  );
}
