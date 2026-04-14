import Navigation from "@/components/Navigation";
import Image from "next/image";
import Link from "next/link";

export default function PricingPage() {
  return (
    <>
      <Navigation />

      <main className="flex-1">
        {/* ── Header ── */}
        <section className="bg-cream">
          <div className="mx-auto max-w-7xl px-6 lg:px-8 pt-16 pb-12 md:pt-24 md:pb-16 text-center">
            <span className="inline-block text-xs font-semibold tracking-[0.1em] uppercase text-coral bg-[#FDF0EB] border border-[#F5C8BA] rounded-full px-3.5 py-1 mb-4">
              Pricing
            </span>
            <h1 className="font-serif text-3xl md:text-5xl text-navy tracking-tight">
              Simple, Honest Pricing
            </h1>
            <p className="mt-4 text-base md:text-lg text-gray-600 max-w-xl mx-auto leading-relaxed">
              Premium MCAT prep at a fraction of the cost. No hidden fees, no
              long-term contracts — cancel anytime.
            </p>
          </div>
        </section>

        {/* ── Pricing Cards ── */}
        <section className="bg-cream">
          <div className="mx-auto max-w-4xl px-6 lg:px-8 pb-24 md:pb-32">
            <div className="grid md:grid-cols-2 gap-6 items-start">
              {/* Tier 1: Practice */}
              <div className="bg-white border border-gray-200 rounded-3xl p-8 md:p-10 hover:shadow-lg transition-shadow">
                <p className="text-xs font-bold tracking-[0.1em] uppercase text-gray-400 mb-2">
                  Essentials
                </p>
                <h2 className="font-serif text-xl text-navy mb-1">
                  Practice Exams + Question Bank
                </h2>
                <p className="text-sm text-gray-600 mb-6">
                  Everything you need to test yourself and track your progress.
                </p>

                <div className="mb-6">
                  <span className="font-serif text-5xl text-navy">$79</span>
                  <span className="text-sm text-gray-400 ml-1">/month</span>
                </div>

                <a
                  href="/signup"
                  className="block w-full rounded-full border-2 border-navy py-3 text-sm font-semibold text-navy text-center hover:bg-navy hover:text-white transition-colors mb-8"
                >
                  Get Started
                </a>

                <div className="border-t border-gray-200 pt-6">
                  <p className="text-xs font-semibold uppercase tracking-wider text-gray-400 mb-4">
                    What&rsquo;s included
                  </p>
                  <ul className="space-y-3">
                    {[
                      "Full-length practice exams",
                      "Thousands of practice questions",
                      "Detailed answer explanations",
                      "Performance analytics",
                      "Score tracking over time",
                      "Mobile-friendly access",
                    ].map((item) => (
                      <li
                        key={item}
                        className="flex items-start gap-3 text-sm text-gray-600"
                      >
                        <svg
                          className="w-4 h-4 text-sage mt-0.5 flex-shrink-0"
                          fill="none"
                          viewBox="0 0 24 24"
                          strokeWidth={2.5}
                          stroke="currentColor"
                        >
                          <path
                            strokeLinecap="round"
                            strokeLinejoin="round"
                            d="M4.5 12.75l6 6 9-13.5"
                          />
                        </svg>
                        {item}
                      </li>
                    ))}
                  </ul>
                </div>
              </div>

              {/* Tier 2: Self-Paced Course (Featured) */}
              <div className="relative bg-navy rounded-3xl p-8 md:p-10 text-white">
                <div className="absolute -top-3.5 left-1/2 -translate-x-1/2">
                  <span className="bg-gradient-to-r from-coral to-gold text-white text-xs font-bold tracking-[0.08em] uppercase px-4 py-1.5 rounded-full whitespace-nowrap">
                    Most Popular
                  </span>
                </div>

                <p className="text-xs font-bold tracking-[0.1em] uppercase text-white/50 mb-2">
                  Complete
                </p>
                <h2 className="font-serif text-xl text-gold mb-1">
                  Self-Paced Course
                </h2>
                <p className="text-sm text-white/60 mb-6">
                  The full Praxis experience — content, practice, and personal
                  support.
                </p>

                <div className="mb-6">
                  <span className="font-serif text-5xl text-white">$199</span>
                  <span className="text-sm text-white/50 ml-1">/month</span>
                </div>

                <a
                  href="/signup"
                  className="block w-full rounded-full bg-white py-3 text-sm font-bold text-navy text-center hover:bg-cream hover:-translate-y-0.5 transition-all mb-8"
                >
                  Start Your Free Trial &rarr;
                </a>

                <div className="border-t border-white/12 pt-6">
                  <p className="text-xs font-semibold uppercase tracking-wider text-white/50 mb-4">
                    Everything in Essentials, plus
                  </p>
                  <ul className="space-y-3">
                    {[
                      "4 full-length practice exams",
                      "Complete question bank access",
                      "Pre-made Anki flashcard decks",
                      "Full content review curriculum",
                      "1:1 personal support",
                      "Custom study plan",
                      "Priority response times",
                    ].map((item) => (
                      <li
                        key={item}
                        className="flex items-start gap-3 text-sm text-white/85"
                      >
                        <svg
                          className="w-4 h-4 text-gold mt-0.5 flex-shrink-0"
                          fill="none"
                          viewBox="0 0 24 24"
                          strokeWidth={2.5}
                          stroke="currentColor"
                        >
                          <path
                            strokeLinecap="round"
                            strokeLinejoin="round"
                            d="M4.5 12.75l6 6 9-13.5"
                          />
                        </svg>
                        {item}
                      </li>
                    ))}
                  </ul>
                </div>
              </div>
            </div>

            {/* Fine print */}
            <p className="text-center text-xs text-gray-400 mt-8">
              All plans billed monthly. Cancel anytime — no questions asked.
            </p>
          </div>
        </section>

        {/* ── Comparison ── */}
        <section className="bg-sand">
          <div className="mx-auto max-w-3xl px-6 lg:px-8 py-20 md:py-28">
            <div className="text-center mb-12">
              <h2 className="font-serif text-2xl md:text-3xl text-navy tracking-tight">
                Compare Plans
              </h2>
            </div>

            <div className="bg-white rounded-2xl border border-gray-200 overflow-hidden">
              <table className="w-full text-sm">
                <thead>
                  <tr className="border-b border-gray-200">
                    <th className="text-left py-4 px-6 font-semibold text-navy">
                      Feature
                    </th>
                    <th className="text-center py-4 px-4 font-semibold text-navy">
                      Essentials
                    </th>
                    <th className="text-center py-4 px-4 font-semibold text-gold bg-navy/5 rounded-tr-2xl">
                      Complete
                    </th>
                  </tr>
                </thead>
                <tbody className="text-gray-600">
                  {[
                    { feature: "Practice questions", ess: true, comp: true },
                    { feature: "Practice exams", ess: "Limited", comp: "4 full-length" },
                    { feature: "Answer explanations", ess: true, comp: true },
                    { feature: "Performance analytics", ess: true, comp: true },
                    { feature: "Pre-made Anki cards", ess: false, comp: true },
                    { feature: "Content review", ess: false, comp: true },
                    { feature: "Custom study plan", ess: false, comp: true },
                    { feature: "1:1 personal support", ess: false, comp: true },
                    { feature: "Priority response", ess: false, comp: true },
                  ].map((row, i) => (
                    <tr
                      key={row.feature}
                      className={
                        i < 8 ? "border-b border-gray-100" : ""
                      }
                    >
                      <td className="py-3.5 px-6 text-gray-900 font-medium">
                        {row.feature}
                      </td>
                      <td className="py-3.5 px-4 text-center">
                        {row.ess === true ? (
                          <svg
                            className="w-4 h-4 text-sage mx-auto"
                            fill="none"
                            viewBox="0 0 24 24"
                            strokeWidth={2.5}
                            stroke="currentColor"
                          >
                            <path
                              strokeLinecap="round"
                              strokeLinejoin="round"
                              d="M4.5 12.75l6 6 9-13.5"
                            />
                          </svg>
                        ) : row.ess === false ? (
                          <span className="text-gray-300">—</span>
                        ) : (
                          <span className="text-xs">{row.ess}</span>
                        )}
                      </td>
                      <td className="py-3.5 px-4 text-center bg-navy/5">
                        {row.comp === true ? (
                          <svg
                            className="w-4 h-4 text-coral mx-auto"
                            fill="none"
                            viewBox="0 0 24 24"
                            strokeWidth={2.5}
                            stroke="currentColor"
                          >
                            <path
                              strokeLinecap="round"
                              strokeLinejoin="round"
                              d="M4.5 12.75l6 6 9-13.5"
                            />
                          </svg>
                        ) : row.comp === false ? (
                          <span className="text-gray-300">—</span>
                        ) : (
                          <span className="text-xs font-medium text-navy">
                            {row.comp}
                          </span>
                        )}
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>
        </section>

        {/* ── FAQ ── */}
        <section className="bg-cream">
          <div className="mx-auto max-w-3xl px-6 lg:px-8 py-20 md:py-28">
            <div className="text-center mb-12">
              <h2 className="font-serif text-2xl md:text-3xl text-navy tracking-tight">
                Pricing Questions
              </h2>
            </div>

            <div className="space-y-4">
              {[
                {
                  q: "Can I switch plans later?",
                  a: "Absolutely. You can upgrade from Essentials to Complete at any time. The difference is prorated so you only pay for what you use.",
                },
                {
                  q: "Is there a free trial?",
                  a: "Yes — the Complete plan comes with a free trial so you can experience everything before you commit.",
                },
                {
                  q: "What does 1:1 support look like?",
                  a: "You'll have direct access to your mentor via messaging. They'll review your progress, help you adjust your study plan, and answer questions about content or strategy. Think of it as having someone in your corner throughout your prep.",
                },
                {
                  q: "How do the Anki cards work?",
                  a: "We provide pre-built Anki decks covering high-yield MCAT topics. They're ready to import into the free Anki app — no setup required. Spaced repetition is one of the most effective study methods, and we've done the work of building the cards for you.",
                },
                {
                  q: "What's your cancellation policy?",
                  a: "Cancel anytime, no questions asked. Your access continues through the end of your current billing period.",
                },
              ].map((item, i) => (
                <details
                  key={i}
                  className="group bg-white rounded-2xl border border-gray-200 px-6 py-5"
                >
                  <summary className="flex items-center justify-between cursor-pointer list-none">
                    <span className="font-semibold text-sm text-navy">
                      {item.q}
                    </span>
                    <svg
                      className="w-4 h-4 text-gray-400 group-open:rotate-180 transition-transform flex-shrink-0 ml-4"
                      fill="none"
                      viewBox="0 0 24 24"
                      strokeWidth={2}
                      stroke="currentColor"
                    >
                      <path
                        strokeLinecap="round"
                        strokeLinejoin="round"
                        d="M19.5 8.25l-7.5 7.5-7.5-7.5"
                      />
                    </svg>
                  </summary>
                  <p className="mt-4 text-sm text-gray-600 leading-relaxed">
                    {item.a}
                  </p>
                </details>
              ))}
            </div>
          </div>
        </section>

        {/* ── CTA ── */}
        <section className="relative bg-gradient-to-br from-navy to-navy-light text-white overflow-hidden">
          <div className="absolute bottom-[-100px] left-[-100px] w-[400px] h-[400px] rounded-full bg-[radial-gradient(circle,rgba(242,190,106,0.12)_0%,transparent_70%)]" />
          <div className="relative mx-auto max-w-7xl px-6 lg:px-8 py-20 md:py-28 text-center">
            <h2 className="font-serif text-3xl md:text-4xl tracking-tight">
              Still Not Sure?
            </h2>
            <p className="mt-4 text-base text-white/65 max-w-lg mx-auto leading-relaxed">
              Start with the free trial and see for yourself what makes
              Praxis different.
            </p>
            <div className="mt-8 flex flex-col sm:flex-row gap-3.5 justify-center">
              <a
                href="/signup"
                className="rounded-full bg-white text-navy px-10 py-3.5 text-sm font-bold hover:bg-cream hover:-translate-y-0.5 transition-all"
              >
                Start Your Free Trial &rarr;
              </a>
              <a
                href="#"
                className="rounded-full border-2 border-white/40 text-white px-10 py-3.5 text-sm font-semibold hover:border-white transition-colors"
              >
                Talk to Us
              </a>
            </div>
          </div>
        </section>
      </main>

      {/* ── Footer ── */}
      <footer className="bg-navy text-white/60">
        <div className="mx-auto max-w-7xl px-6 lg:px-8 py-14">
          <div className="grid grid-cols-2 md:grid-cols-4 gap-10 mb-12">
            <div className="col-span-2 md:col-span-1">
              <div className="flex items-center gap-1.5 mb-3">
                <Image
                  src="/logo-white.png"
                  alt="Praxist Prep logo"
                  width={22}
                  height={42}
                  className="h-7 w-auto"
                />
                <span className="font-serif text-[28px] leading-7 text-white">
                  Praxist Prep
                </span>
              </div>
              <p className="text-sm text-white/55 leading-relaxed max-w-[260px]">
                MCAT prep built by someone who&rsquo;s been through it.
              </p>
            </div>
            <div>
              <h4 className="text-xs font-semibold uppercase tracking-wider text-white mb-4">
                Product
              </h4>
              <div className="space-y-2.5">
                <a href="#" className="block text-sm text-white/55 hover:text-gold transition-colors">Courses</a>
                <a href="#" className="block text-sm text-white/55 hover:text-gold transition-colors">Practice Exams</a>
                <a href="#" className="block text-sm text-white/55 hover:text-gold transition-colors">Question Bank</a>
                <Link href="/pricing" className="block text-sm text-white/55 hover:text-gold transition-colors">Pricing</Link>
              </div>
            </div>
            <div>
              <h4 className="text-xs font-semibold uppercase tracking-wider text-white mb-4">
                Resources
              </h4>
              <div className="space-y-2.5">
                <a href="#" className="block text-sm text-white/55 hover:text-gold transition-colors">Blog</a>
                <a href="#" className="block text-sm text-white/55 hover:text-gold transition-colors">MCAT Guides</a>
                <a href="#" className="block text-sm text-white/55 hover:text-gold transition-colors">Test Dates</a>
              </div>
            </div>
            <div>
              <h4 className="text-xs font-semibold uppercase tracking-wider text-white mb-4">
                Company
              </h4>
              <div className="space-y-2.5">
                <a href="#" className="block text-sm text-white/55 hover:text-gold transition-colors">Our Story</a>
                <a href="#" className="block text-sm text-white/55 hover:text-gold transition-colors">Contact</a>
                <a href="#" className="block text-sm text-white/55 hover:text-gold transition-colors">Privacy</a>
                <a href="#" className="block text-sm text-white/55 hover:text-gold transition-colors">Terms</a>
              </div>
            </div>
          </div>
          <div className="border-t border-white/10 pt-6 text-center">
            <p className="text-xs text-white/40">
              &copy; {new Date().getFullYear()} Praxist Prep. All rights reserved.
            </p>
          </div>
        </div>
      </footer>
    </>
  );
}
