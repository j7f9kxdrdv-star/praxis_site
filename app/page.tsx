import Image from "next/image";
import Navigation from "@/components/Navigation";

export default function Home() {
  return (
    <>
      <Navigation />

      <main className="flex-1">
        {/* ── Hero ── */}
        <section className="relative overflow-hidden bg-cream">
          {/* Hero image with overlay */}
          <div className="relative w-full h-[520px] md:h-[620px]">
            <Image
              src="/hero-library.jpg"
              alt="Student studying in a university library"
              fill
              className="object-cover object-center"
              priority
            />
            <div className="absolute inset-0 bg-gradient-to-t from-[#2E2520]/80 via-[#2E2520]/40 to-transparent" />
            <div className="absolute inset-0 bg-gradient-to-r from-[#2E2520]/60 to-transparent" />

            {/* Hero text overlaid on image */}
            <div className="relative z-10 h-full flex items-end">
              <div className="mx-auto max-w-7xl px-6 lg:px-8 pb-14 md:pb-20 w-full">
                <div className="max-w-2xl">
                  <div className="flex items-center gap-2 text-amber text-xs font-semibold tracking-[0.12em] uppercase mb-5">
                    <span className="block w-6 h-0.5 bg-amber" />
                    MCAT Prep, Reimagined
                  </div>
                  <h1 className="font-serif text-4xl md:text-6xl text-white leading-tight tracking-tight">
                    Your MCAT Score
                    <br />
                    Shouldn&rsquo;t Hold
                    <br />
                    <em className="italic text-amber">You Back.</em>
                  </h1>
                  <p className="mt-6 text-lg md:text-xl text-white/80 leading-relaxed max-w-lg">
                    Built by someone who&rsquo;s been through it. Praxis Prep
                    gives you the strategies, structure, and support to score
                    higher — without the burnout.
                  </p>
                  <div className="mt-10 flex flex-col sm:flex-row gap-3.5">
                    <a
                      href="#cta"
                      className="rounded-full bg-amber px-8 py-3.5 text-sm font-semibold text-navy shadow-[0_4px_16px_rgba(212,168,75,0.35)] hover:bg-gold hover:-translate-y-0.5 transition-all text-center"
                    >
                      Start Your Free Trial &rarr;
                    </a>
                    <a
                      href="#why"
                      className="rounded-full border-2 border-white/50 px-8 py-3.5 text-sm font-semibold text-white hover:bg-white hover:text-navy transition-colors text-center"
                    >
                      See How It Works
                    </a>
                  </div>
                  <p className="mt-5 text-xs text-white/50 flex items-center gap-1.5">
                    <svg width="14" height="14" viewBox="0 0 14 14" fill="none">
                      <circle cx="7" cy="7" r="6.5" stroke="currentColor" />
                      <path
                        d="M7 4v3l2 2"
                        stroke="currentColor"
                        strokeLinecap="round"
                      />
                    </svg>
                    No credit card required &middot; Cancel anytime
                  </p>
                </div>
              </div>
            </div>
          </div>
        </section>

        {/* ── Social Proof Bar ── */}
        <section className="bg-navy py-6">
          <div className="mx-auto max-w-7xl px-6 lg:px-8">
            <div className="flex flex-wrap items-center justify-between gap-6 text-center">
              {[
                { num: "1:1", label: "Personal Mentorship" },
                { num: "24/7", label: "Student Support" },
                { num: "50%", label: "Less Than Big Prep" },
                { num: "100%", label: "Personalized Plans" },
              ].map((stat, i, arr) => (
                <div
                  key={stat.label}
                  className="flex items-center gap-6 mx-auto md:mx-0"
                >
                  <div>
                    <p className="text-2xl md:text-3xl font-serif text-amber">
                      {stat.num}
                    </p>
                    <p className="text-xs text-white/60 mt-0.5">
                      {stat.label}
                    </p>
                  </div>
                  {i < arr.length - 1 && (
                    <div className="hidden md:block w-px h-10 bg-white/15" />
                  )}
                </div>
              ))}
            </div>
          </div>
        </section>

        {/* ── Why Praxis ── */}
        <section id="why" className="bg-cream">
          <div className="mx-auto max-w-7xl px-6 lg:px-8 py-24 md:py-32">
            <div className="text-center max-w-xl mx-auto mb-14">
              <span className="inline-block text-xs font-semibold tracking-[0.1em] uppercase text-coral bg-[#F5E6DB] border border-[#E5CBBA] rounded-full px-3.5 py-1 mb-4">
                Why Praxis Prep
              </span>
              <h2 className="font-serif text-3xl md:text-4xl text-navy tracking-tight">
                We&rsquo;ve Been Where You Are
              </h2>
              <p className="mt-3 text-base text-gray-600 leading-relaxed">
                Most prep companies are built by test-prep corporations. Praxis
                was built by someone who recently sat in your seat.
              </p>
            </div>

            <div className="grid md:grid-cols-3 gap-7">
              {[
                {
                  icon: "📚",
                  bg: "#F5E6DB",
                  title: "Strategy Over Memorization",
                  desc: "We teach you how to think through problems, manage your time, and approach each section with a clear game plan.",
                },
                {
                  icon: "📅",
                  bg: "#F0EAD6",
                  title: "Personalized Study Plans",
                  desc: "We build a prep schedule around your strengths, weaknesses, timeline, and life — not a one-size-fits-all curriculum.",
                },
                {
                  icon: "🤝",
                  bg: "#F2E8EF",
                  title: "Real Mentorship",
                  desc: "You're getting a mentor who understands the pressure, the stakes, and what it takes to reach your target score.",
                },
              ].map((card) => (
                <div
                  key={card.title}
                  className="bg-white border border-gray-200 rounded-2xl p-8 hover:shadow-lg hover:-translate-y-1 transition-all"
                >
                  <div
                    className="w-[52px] h-[52px] rounded-[14px] flex items-center justify-center text-2xl mb-5"
                    style={{ background: card.bg }}
                  >
                    {card.icon}
                  </div>
                  <h3 className="font-serif text-lg text-navy mb-2">
                    {card.title}
                  </h3>
                  <p className="text-sm text-gray-600 leading-relaxed">
                    {card.desc}
                  </p>
                </div>
              ))}
            </div>
          </div>
        </section>

        {/* ── Student Stories ── */}
        <section id="results" className="bg-sand">
          <div className="mx-auto max-w-7xl px-6 lg:px-8 py-24 md:py-32">
            <div className="grid md:grid-cols-2 gap-16 items-center">
              <div>
                <span className="inline-block text-xs font-semibold tracking-[0.1em] uppercase text-coral bg-[#F5E6DB] border border-[#E5CBBA] rounded-full px-3.5 py-1 mb-4">
                  Student Stories
                </span>
                <h2 className="font-serif text-3xl md:text-4xl text-navy tracking-tight">
                  We Show Up for Our Students
                </h2>
                <p className="mt-4 text-base text-gray-600 leading-relaxed">
                  We can&rsquo;t take your test for you — but we can make sure
                  you never feel alone preparing for it. Our students tell us
                  the difference isn&rsquo;t just the material. It&rsquo;s
                  having someone in their corner who genuinely cares.
                </p>
                <div className="mt-10 grid grid-cols-2 gap-6">
                  {[
                    { word: "Always", desc: "Available when you need us" },
                    { word: "Custom", desc: "Every plan built for you" },
                    { word: "Honest", desc: "Real talk, no empty promises" },
                    { word: "Affordable", desc: "Premium prep, fair price" },
                  ].map((item) => (
                    <div
                      key={item.word}
                      className="border-l-4 border-coral pl-4"
                    >
                      <p className="text-xl font-serif text-navy">
                        {item.word}
                      </p>
                      <p className="text-xs text-gray-600 mt-1">{item.desc}</p>
                    </div>
                  ))}
                </div>
              </div>

              <div className="bg-white rounded-2xl p-8 lg:p-10 shadow-sm border border-gray-200">
                <div className="text-coral/30 text-4xl mb-4">&ldquo;</div>
                <blockquote className="text-base text-gray-900 leading-relaxed italic">
                  What set Praxis apart wasn&rsquo;t a score guarantee — it was
                  having someone who actually picked up the phone when I was
                  spiraling before my exam. They walked me through it, calmed me
                  down, and helped me show up ready.
                </blockquote>
                <div className="mt-8 flex items-center gap-3">
                  <div className="w-11 h-11 rounded-full bg-gradient-to-br from-coral to-amber flex items-center justify-center text-white font-semibold text-sm">
                    SM
                  </div>
                  <div>
                    <p className="font-semibold text-sm text-navy">Sarah M.</p>
                    <p className="text-xs text-gray-400">
                      Praxis Prep Student
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>

        {/* ── Our Approach ── */}
        <section id="approach" className="bg-cream">
          <div className="mx-auto max-w-7xl px-6 lg:px-8 py-24 md:py-32">
            <div className="text-center max-w-xl mx-auto mb-14">
              <span className="inline-block text-xs font-semibold tracking-[0.1em] uppercase text-coral bg-[#F5E6DB] border border-[#E5CBBA] rounded-full px-3.5 py-1 mb-4">
                How It Works
              </span>
              <h2 className="font-serif text-3xl md:text-4xl text-navy tracking-tight">
                From sign-up to test day in 4 steps
              </h2>
              <p className="mt-3 text-base text-gray-600">
                We handle the structure. You handle the studying.
              </p>
            </div>

            <div className="grid grid-cols-2 md:grid-cols-4 gap-6">
              {[
                {
                  step: "1",
                  title: "Tell Us Your Goals",
                  desc: "Enter your target score, test date, and how many hours per week you can study.",
                },
                {
                  step: "2",
                  title: "Get Your Study Plan",
                  desc: "We generate a personalized week-by-week schedule tailored to your timeline.",
                },
                {
                  step: "3",
                  title: "Learn & Practice",
                  desc: "Work through lessons, practice questions, and strategy sessions with mentor support.",
                },
                {
                  step: "4",
                  title: "Walk In Confident",
                  desc: "Full-length practice exams, timing drills, and mindset coaching so you're ready.",
                },
              ].map((item) => (
                <div key={item.step} className="text-center py-8 px-5">
                  <div className="w-[52px] h-[52px] rounded-full bg-gradient-to-br from-coral to-amber text-white font-serif text-xl flex items-center justify-center mx-auto mb-5 shadow-[0_4px_16px_rgba(184,112,74,0.35)]">
                    {item.step}
                  </div>
                  <h3 className="font-serif text-base text-navy mb-2">
                    {item.title}
                  </h3>
                  <p className="text-sm text-gray-600 leading-relaxed">
                    {item.desc}
                  </p>
                </div>
              ))}
            </div>
          </div>
        </section>

        {/* ── FAQ ── */}
        <section id="faq" className="bg-sand">
          <div className="mx-auto max-w-3xl px-6 lg:px-8 py-24 md:py-32">
            <div className="text-center mb-14">
              <span className="inline-block text-xs font-semibold tracking-[0.1em] uppercase text-coral bg-[#F5E6DB] border border-[#E5CBBA] rounded-full px-3.5 py-1 mb-4">
                FAQ
              </span>
              <h2 className="font-serif text-3xl md:text-4xl text-navy tracking-tight">
                Common Questions
              </h2>
            </div>

            <div className="space-y-4">
              {[
                {
                  q: "Who is Praxis Prep for?",
                  a: "Anyone preparing for the MCAT — whether you're just starting out, retaking the exam, or looking to push your score higher. Our approach works for all levels.",
                },
                {
                  q: "What makes Praxis different from other prep companies?",
                  a: "Two things: the experience and the price. We give you real, personal mentorship from someone who's recently been through the MCAT — not a faceless corporation. And we do it at a fraction of the cost of the big prep companies.",
                },
                {
                  q: "How long should I prep for the MCAT?",
                  a: "Most students study for 3-6 months, depending on their starting point and target score. We'll help you determine the right timeline during your diagnostic assessment.",
                },
                {
                  q: "Do you offer one-on-one tutoring?",
                  a: "Yes. Every Praxis student gets access to direct mentorship. We believe personalized guidance is the key differentiator between good and great scores.",
                },
                {
                  q: "What if I'm struggling during the program?",
                  a: "That's exactly what we're here for. Prep is hard, and tough stretches are normal. Your mentor will adjust your plan, work through problem areas with you, and make sure you're never stuck alone.",
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

        {/* ── Final CTA ── */}
        <section
          id="cta"
          className="relative bg-gradient-to-br from-navy to-warm-brown text-white overflow-hidden"
        >
          <div className="absolute bottom-[-100px] left-[-100px] w-[400px] h-[400px] rounded-full bg-[radial-gradient(circle,rgba(212,168,75,0.12)_0%,transparent_70%)]" />
          <div className="relative mx-auto max-w-7xl px-6 lg:px-8 py-20 md:py-28 text-center">
            <h2 className="font-serif text-3xl md:text-5xl tracking-tight">
              Ready to Start Prepping?
            </h2>
            <p className="mt-4 text-base text-white/65 max-w-xl mx-auto leading-relaxed">
              Join the students who stopped stressing about the MCAT and started
              seeing real progress. Your medical school journey starts here.
            </p>
            <div className="mt-10 flex flex-col sm:flex-row gap-3.5 justify-center">
              <a
                href="#"
                className="rounded-full bg-amber text-navy px-10 py-3.5 text-sm font-bold hover:bg-gold hover:-translate-y-0.5 transition-all"
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
            <p className="mt-4 text-xs text-white/40">
              No credit card required &middot; Cancel anytime
            </p>
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
                  src="/logo.png"
                  alt="Praxis Prep logo"
                  width={22}
                  height={42}
                  className="h-10 w-auto brightness-0 invert"
                />
                <span className="font-serif text-lg text-white">
                  Praxis Prep
                </span>
              </div>
              <p className="text-sm text-white/55 leading-relaxed max-w-[260px]">
                MCAT prep built by someone who&rsquo;s been through it.
                Affordable, personal, and effective.
              </p>
            </div>
            <div>
              <h4 className="text-xs font-semibold uppercase tracking-wider text-white mb-4">
                Product
              </h4>
              <div className="space-y-2.5">
                <a href="#" className="block text-sm text-white/55 hover:text-amber transition-colors">Courses</a>
                <a href="#" className="block text-sm text-white/55 hover:text-amber transition-colors">Practice Exams</a>
                <a href="#" className="block text-sm text-white/55 hover:text-amber transition-colors">Question Bank</a>
                <a href="#" className="block text-sm text-white/55 hover:text-amber transition-colors">Mentorship</a>
              </div>
            </div>
            <div>
              <h4 className="text-xs font-semibold uppercase tracking-wider text-white mb-4">
                Resources
              </h4>
              <div className="space-y-2.5">
                <a href="#" className="block text-sm text-white/55 hover:text-amber transition-colors">Blog</a>
                <a href="#" className="block text-sm text-white/55 hover:text-amber transition-colors">MCAT Guides</a>
                <a href="#" className="block text-sm text-white/55 hover:text-amber transition-colors">Test Dates</a>
                <a href="#" className="block text-sm text-white/55 hover:text-amber transition-colors">Score Calculator</a>
              </div>
            </div>
            <div>
              <h4 className="text-xs font-semibold uppercase tracking-wider text-white mb-4">
                Company
              </h4>
              <div className="space-y-2.5">
                <a href="#" className="block text-sm text-white/55 hover:text-amber transition-colors">Our Story</a>
                <a href="#" className="block text-sm text-white/55 hover:text-amber transition-colors">Contact</a>
                <a href="#" className="block text-sm text-white/55 hover:text-amber transition-colors">Privacy</a>
                <a href="#" className="block text-sm text-white/55 hover:text-amber transition-colors">Terms</a>
              </div>
            </div>
          </div>
          <div className="border-t border-white/10 pt-6 flex flex-col md:flex-row justify-between items-center gap-4">
            <p className="text-xs text-white/40">
              &copy; {new Date().getFullYear()} Praxis Prep. All rights
              reserved.
            </p>
          </div>
        </div>
      </footer>
    </>
  );
}
