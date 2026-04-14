import Image from "next/image";
import Link from "next/link";

export default function CheckEmailPage() {
  return (
    <div className="min-h-screen bg-sand flex flex-col">
      {/* Header */}
      <div className="px-6 py-5">
        <Link href="/" className="inline-flex items-center gap-2">
          <Image
            src="/logo-green.png"
            alt="Praxist Prep logo"
            width={30}
            height={58}
            className="h-9 w-auto"
          />
          <span className="text-[32px] leading-9 font-serif text-navy">Praxist Prep</span>
        </Link>
      </div>

      {/* Centered card */}
      <div className="flex-1 flex items-center justify-center px-6 pb-12">
        <div className="w-full max-w-md bg-white rounded-2xl border border-gray-200 shadow-sm px-8 py-10 md:px-10 text-center">
          {/* Email icon */}
          <div className="w-16 h-16 rounded-full bg-amber/10 flex items-center justify-center mx-auto mb-6">
            <svg
              className="w-8 h-8 text-amber"
              fill="none"
              viewBox="0 0 24 24"
              strokeWidth={1.5}
              stroke="currentColor"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                d="M21.75 6.75v10.5a2.25 2.25 0 01-2.25 2.25h-15a2.25 2.25 0 01-2.25-2.25V6.75m19.5 0A2.25 2.25 0 0019.5 4.5h-15a2.25 2.25 0 00-2.25 2.25m19.5 0v.243a2.25 2.25 0 01-1.07 1.916l-7.5 4.615a2.25 2.25 0 01-2.36 0L3.32 8.91a2.25 2.25 0 01-1.07-1.916V6.75"
              />
            </svg>
          </div>

          <h1 className="font-serif text-2xl text-navy mb-3">
            Check your email
          </h1>
          <p className="text-sm text-gray-600 leading-relaxed mb-6">
            We&rsquo;ve sent a confirmation link to your email address. Click
            the link to verify your account and get started with Praxist Prep.
          </p>

          <div className="bg-sand rounded-xl px-4 py-3 text-xs text-gray-500 mb-8">
            Didn&rsquo;t receive the email? Check your spam folder or wait a few
            minutes for it to arrive.
          </div>

          <Link
            href="/login"
            className="inline-flex items-center justify-center w-full rounded-xl bg-navy py-3.5 text-sm font-semibold text-white hover:bg-navy-light transition-colors"
          >
            Go to Log In
          </Link>
        </div>
      </div>

      {/* Footer */}
      <div className="px-6 py-4 flex justify-center gap-6 text-xs text-gray-400">
        <Link href="#" className="hover:text-coral transition-colors">
          Terms of Use
        </Link>
        <Link href="#" className="hover:text-coral transition-colors">
          Privacy Policy
        </Link>
      </div>
    </div>
  );
}
