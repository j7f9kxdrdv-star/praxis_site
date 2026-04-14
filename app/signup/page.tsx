"use client";

import { useState } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import { supabase } from "@/lib/supabase";

export default function SignupPage() {
  const router = useRouter();
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [firstName, setFirstName] = useState("");
  const [lastName, setLastName] = useState("");
  const [showPassword, setShowPassword] = useState(false);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  async function handleSignup(e: React.FormEvent) {
    e.preventDefault();
    setError("");
    setLoading(true);

    const { error } = await supabase.auth.signUp({
      email,
      password,
      options: {
        data: {
          first_name: firstName,
          last_name: lastName,
        },
      },
    });

    if (error) {
      setError(error.message);
      setLoading(false);
      return;
    }

    router.push("/check-email");
  }

  async function handleGoogleSignup() {
    const { error } = await supabase.auth.signInWithOAuth({
      provider: "google",
      options: {
        redirectTo: `${window.location.origin}/dashboard`,
      },
    });

    if (error) {
      setError(error.message);
    }
  }

  return (
    <div
      className="min-h-screen font-body text-as-on-surface flex items-center justify-center p-4"
      style={{
        backgroundImage:
          "linear-gradient(rgba(28, 28, 19, 0.4), rgba(28, 28, 19, 0.4)), url('/hero-library.jpg')",
        backgroundSize: "cover",
        backgroundPosition: "center",
        backgroundAttachment: "fixed",
      }}
    >
      <main className="w-full max-w-md">
        {/* Brand Header */}
        <div className="mb-12 flex justify-center">
          <Link href="/" className="flex items-center gap-3">
            <img
              src="/logo-white.png"
              alt="Praxist Prep logo"
              className="h-11 w-auto"
            />
            <span className="font-headline italic text-[44px] leading-[44px] text-white drop-shadow-md">
              Praxist Prep
            </span>
          </Link>
        </div>

        {/* Signup Form Box */}
        <section className="border border-as-outline-variant p-8 md:p-12 rounded-xl shadow-sm bg-as-surface">
          <header className="mb-10 text-center">
            <h1 className="font-headline italic text-4xl text-as-primary mb-3">
              Create your account
            </h1>
            <p className="text-as-secondary font-body">
              Begin your journey to academic excellence.
            </p>
          </header>

          {/* Error message */}
          {error && (
            <div className="mb-4 rounded-lg bg-as-error-container border border-as-error/20 px-4 py-3 text-sm text-as-on-error-container">
              {error}
            </div>
          )}

          <form onSubmit={handleSignup} className="space-y-6">
            {/* Name row */}
            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <label
                  htmlFor="firstName"
                  className="font-body font-bold text-[10px] uppercase tracking-widest text-as-secondary block"
                >
                  First name
                </label>
                <input
                  id="firstName"
                  name="firstName"
                  type="text"
                  autoComplete="given-name"
                  value={firstName}
                  onChange={(e) => setFirstName(e.target.value)}
                  placeholder="Jane"
                  className="w-full bg-as-surface-bright border-2 border-as-on-surface/10 px-4 py-3.5 rounded-lg focus:ring-1 focus:ring-as-primary focus:border-as-primary transition-all duration-200 outline-none placeholder:text-as-secondary/40"
                />
              </div>
              <div className="space-y-2">
                <label
                  htmlFor="lastName"
                  className="font-body font-bold text-[10px] uppercase tracking-widest text-as-secondary block"
                >
                  Last name
                </label>
                <input
                  id="lastName"
                  name="lastName"
                  type="text"
                  autoComplete="family-name"
                  value={lastName}
                  onChange={(e) => setLastName(e.target.value)}
                  placeholder="Doe"
                  className="w-full bg-as-surface-bright border-2 border-as-on-surface/10 px-4 py-3.5 rounded-lg focus:ring-1 focus:ring-as-primary focus:border-as-primary transition-all duration-200 outline-none placeholder:text-as-secondary/40"
                />
              </div>
            </div>

            {/* Email */}
            <div className="space-y-2">
              <label
                htmlFor="email"
                className="font-body font-bold text-[10px] uppercase tracking-widest text-as-secondary block"
              >
                Email address
              </label>
              <input
                id="email"
                name="email"
                type="email"
                autoComplete="email"
                required
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                placeholder="name@university.edu"
                className="w-full bg-as-surface-bright border-2 border-as-on-surface/10 px-4 py-3.5 rounded-lg focus:ring-1 focus:ring-as-primary focus:border-as-primary transition-all duration-200 outline-none placeholder:text-as-secondary/40"
              />
            </div>

            {/* Password */}
            <div className="space-y-2">
              <label
                htmlFor="password"
                className="font-body font-bold text-[10px] uppercase tracking-widest text-as-secondary block"
              >
                Password
              </label>
              <div className="relative">
                <input
                  id="password"
                  name="password"
                  type={showPassword ? "text" : "password"}
                  autoComplete="new-password"
                  required
                  minLength={8}
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  placeholder="••••••••"
                  className="w-full bg-as-surface-bright border-2 border-as-on-surface/10 px-4 py-3.5 rounded-lg focus:ring-1 focus:ring-as-primary focus:border-as-primary transition-all duration-200 outline-none placeholder:text-as-secondary/40 pr-12"
                />
                <button
                  type="button"
                  onClick={() => setShowPassword(!showPassword)}
                  className="absolute right-4 top-1/2 -translate-y-1/2 text-as-secondary/60 hover:text-as-primary transition-colors"
                  aria-label={showPassword ? "Hide password" : "Show password"}
                >
                  {showPassword ? (
                    <svg
                      className="w-5 h-5"
                      fill="none"
                      viewBox="0 0 24 24"
                      strokeWidth={1.5}
                      stroke="currentColor"
                    >
                      <path
                        strokeLinecap="round"
                        strokeLinejoin="round"
                        d="M3.98 8.223A10.477 10.477 0 001.934 12C3.226 16.338 7.244 19.5 12 19.5c.993 0 1.953-.138 2.863-.395M6.228 6.228A10.45 10.45 0 0112 4.5c4.756 0 8.773 3.162 10.065 7.498a10.523 10.523 0 01-4.293 5.774M6.228 6.228L3 3m3.228 3.228l3.65 3.65m7.894 7.894L21 21m-3.228-3.228l-3.65-3.65m0 0a3 3 0 10-4.243-4.243m4.242 4.242L9.88 9.88"
                      />
                    </svg>
                  ) : (
                    <svg
                      className="w-5 h-5"
                      fill="none"
                      viewBox="0 0 24 24"
                      strokeWidth={1.5}
                      stroke="currentColor"
                    >
                      <path
                        strokeLinecap="round"
                        strokeLinejoin="round"
                        d="M2.036 12.322a1.012 1.012 0 010-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178z"
                      />
                      <path
                        strokeLinecap="round"
                        strokeLinejoin="round"
                        d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"
                      />
                    </svg>
                  )}
                </button>
              </div>
              <p className="text-[11px] text-as-secondary/60">
                Must be at least 8 characters
              </p>
            </div>

            {/* Terms agreement */}
            <p className="text-xs text-as-secondary/70 leading-relaxed">
              By creating an account, you agree to our{" "}
              <Link
                href="#"
                className="font-semibold text-as-primary hover:text-as-surface-tint transition-colors"
              >
                Terms of Use
              </Link>{" "}
              and{" "}
              <Link
                href="#"
                className="font-semibold text-as-primary hover:text-as-surface-tint transition-colors"
              >
                Privacy Policy
              </Link>
            </p>

            {/* Submit */}
            <button
              type="submit"
              disabled={loading}
              className="w-full bg-as-primary text-as-on-primary font-body font-bold text-base py-4 rounded-lg shadow-md hover:bg-as-primary/95 active:scale-[0.98] transition-all duration-150 disabled:opacity-50 disabled:cursor-not-allowed"
            >
              {loading ? "Creating account..." : "Create Account"}
            </button>
          </form>

          {/* Divider */}
          <div className="relative py-6">
            <div className="absolute inset-0 flex items-center">
              <div className="w-full h-px bg-as-outline-variant/50" />
            </div>
            <div className="relative flex justify-center text-[10px]">
              <span className="px-4 bg-as-surface text-as-secondary/60 font-body uppercase tracking-widest">
                or continue with
              </span>
            </div>
          </div>

          {/* Social logins */}
          <div className="grid grid-cols-2 gap-4">
            <button
              type="button"
              onClick={handleGoogleSignup}
              className="flex items-center justify-center gap-3 bg-as-surface-bright border border-as-outline-variant py-3 rounded-lg hover:bg-as-surface-container transition-colors font-semibold text-xs text-as-on-surface"
            >
              <svg className="w-4 h-4" viewBox="0 0 24 24">
                <path
                  d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92a5.06 5.06 0 01-2.2 3.32v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.1z"
                  fill="#4285F4"
                />
                <path
                  d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"
                  fill="#34A853"
                />
                <path
                  d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z"
                  fill="#FBBC05"
                />
                <path
                  d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"
                  fill="#EA4335"
                />
              </svg>
              Google
            </button>
            <button
              type="button"
              className="flex items-center justify-center gap-3 bg-as-surface-bright border border-as-outline-variant py-3 rounded-lg hover:bg-as-surface-container transition-colors font-semibold text-xs text-as-on-surface"
            >
              <svg className="w-4 h-4" fill="currentColor" viewBox="0 0 24 24">
                <path d="M18.71 19.5c-.83 1.24-1.71 2.45-3.05 2.47-1.34.03-1.77-.79-3.29-.79-1.53 0-2 .77-3.27.82-1.31.05-2.3-1.32-3.14-2.53C4.25 17 2.94 12.45 4.7 9.39c.87-1.52 2.43-2.48 4.12-2.51 1.28-.02 2.5.87 3.29.87.78 0 2.26-1.07 3.8-.91.65.03 2.47.26 3.64 1.98-.09.06-2.17 1.28-2.15 3.81.03 3.02 2.65 4.03 2.68 4.04-.03.07-.42 1.44-1.38 2.83M13 3.5c.73-.83 1.94-1.46 2.94-1.5.13 1.17-.34 2.35-1.04 3.19-.69.85-1.83 1.51-2.95 1.42-.15-1.15.41-2.35 1.05-3.11z" />
              </svg>
              Apple
            </button>
          </div>

          {/* Login link */}
          <footer className="mt-10 text-center">
            <p className="text-sm text-as-secondary">
              Already have an account?{" "}
              <Link
                href="/login"
                className="text-as-primary font-bold hover:underline underline-offset-4 decoration-1"
              >
                Log in
              </Link>
            </p>
          </footer>
        </section>

        {/* Footer links */}
        <footer className="mt-12">
          <nav className="flex justify-center gap-6 text-[10px] font-body uppercase tracking-widest text-white/70">
            <Link href="#" className="hover:text-white transition-colors">
              Privacy
            </Link>
            <Link href="#" className="hover:text-white transition-colors">
              Terms
            </Link>
            <Link href="#" className="hover:text-white transition-colors">
              Support
            </Link>
          </nav>
        </footer>
      </main>
    </div>
  );
}
