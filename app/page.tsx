import Navigation from "@/components/Navigation";

export default function Home() {
  return (
    <>
      <Navigation />

      <main className="flex-1">
        {/* ── Hero ── */}
        <section className="relative bg-gray-900 text-white overflow-hidden">
          {/* Subtle gradient overlay */}
          <div className="absolute inset-0 bg-gradient-to-br from-gray-900 via-gray-900 to-scarlet/20" />
          <div className="relative mx-auto max-w-7xl px-6 lg:px-8 py-28 md:py-40">
            <div className="max-w-2xl">
              <p className="text-scarlet font-semibold text-sm tracking-widest uppercase mb-4">
                MCAT Prep, Redefined
              </p>
              <h1 className="font-serif text-4xl md:text-6xl font-bold leading-tight tracking-tight">
                Your MCAT Score
                <br />
                Shouldn&rsquo;t Hold
                <br />
                You Back.
              </h1>
              <p className="mt-6 text-lg md:text-xl text-gray-300 leading-relaxed max-w-lg">
                Built by someone who&rsquo;s been through it. Praxis Prep gives
                you the strategies, structure, and support to score higher —
                without the burnout.
              </p>
              <div className="mt-10 flex flex-col sm:flex-row gap-4">
                <a
                  href="#cta"
                  className="rounded-full bg-scarlet px-8 py-3.5 text-sm font-semibold text-white shadow-lg hover:bg-scarlet-dark transition-colors text-center"
                >
                  Start Prepping Today
                </a>
                <a
                  href="#why"
                  className="rounded-full border border-white/20 px-8 py-3.5 text-sm font-semibold text-white hover:bg-white/10 transition-colors text-center"
                >
                  Learn More
                </a>
              </div>
            </div>
          </div>
        </section>

        {/* ── Social Proof Bar ── */}
        <section className="bg-gray-50 border-b border-gray-200">
          <div className="mx-auto max-w-7xl px-6 lg:px-8 py-8">
            <div className="grid grid-cols-2 md:grid-cols-4 gap-8 text-center">
              <div>
                <p className="text-3xl md:text-4xl font-serif font-bold text-scarlet">
                  1:1
                </p>
                <p className="mt-1 text-sm text-gray-600">
                  Personal Mentorship
                </p>
              </div>
              <div>
                <p className="text-3xl md:text-4xl font-serif font-bold text-scarlet">
                  24/7
                </p>
                <p className="mt-1 text-sm text-gray-600">
                  Student Support
                </p>
              </div>
              <div>
                <p className="text-3xl md:text-4xl font-serif font-bold text-scarlet">
                  50%
                </p>
                <p className="mt-1 text-sm text-gray-600">
                  Less Than Big Prep
                </p>
              </div>
              <div>
                <p className="text-3xl md:text-4xl font-serif font-bold text-scarlet">
                  100%
                </p>
                <p className="mt-1 text-sm text-gray-600">
                  Personalized Plans
                </p>
              </div>
            </div>
          </div>
        </section>

        {/* ── Why Praxis ── */}
        <section id="why" className="bg-white">
          <div className="mx-auto max-w-7xl px-6 lg:px-8 py-24 md:py-32">
            <div className="text-center max-w-3xl mx-auto mb-16">
              <p className="text-scarlet font-semibold text-sm tracking-widest uppercase mb-3">
                Why Praxis Prep
              </p>
              <h2 className="font-serif text-3xl md:text-5xl font-bold text-gray-900 tracking-tight">
                We&rsquo;ve Been Where You Are
              </h2>
              <p className="mt-6 text-lg text-gray-600 leading-relaxed">
                Most prep companies are built by test-prep corporations. Praxis
                was built by someone who recently sat in your seat, took the
                exam, and learned exactly what works — and what doesn&rsquo;t.
              </p>
            </div>

            <div className="grid md:grid-cols-3 gap-8 lg:gap-12">
              {/* Card 1 */}
              <div className="bg-gray-50 rounded-2xl p-8 lg:p-10">
                <div className="w-12 h-12 rounded-xl bg-scarlet/10 flex items-center justify-center mb-6">
                  <svg className="w-6 h-6 text-scarlet" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" d="M12 18v-5.25m0 0a6.01 6.01 0 001.5-.189m-1.5.189a6.01 6.01 0 01-1.5-.189m3.75 7.478a12.06 12.06 0 01-4.5 0m3.75 2.383a14.406 14.406 0 01-3 0M14.25 18v-.192c0-.983.658-1.823 1.508-2.316a7.5 7.5 0 10-7.517 0c.85.493 1.509 1.333 1.509 2.316V18" />
                  </svg>
                </div>
                <h3 className="font-serif text-xl font-bold text-gray-900 mb-3">
                  Strategy Over Memorization
                </h3>
                <p className="text-gray-600 leading-relaxed">
                  The MCAT isn&rsquo;t about cramming facts. We teach you how to
                  think through problems, manage your time, and approach each
                  section with a clear game plan.
                </p>
              </div>

              {/* Card 2 */}
              <div className="bg-gray-50 rounded-2xl p-8 lg:p-10">
                <div className="w-12 h-12 rounded-xl bg-scarlet/10 flex items-center justify-center mb-6">
                  <svg className="w-6 h-6 text-scarlet" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" d="M3.75 3v11.25A2.25 2.25 0 006 16.5h2.25M3.75 3h-1.5m1.5 0h16.5m0 0h1.5m-1.5 0v11.25A2.25 2.25 0 0118 16.5h-2.25m-7.5 0h7.5m-7.5 0l-1 3m8.5-3l1 3m0 0l.5 1.5m-.5-1.5h-9.5m0 0l-.5 1.5M9 11.25v1.5M12 9v3.75m3-6v6" />
                  </svg>
                </div>
                <h3 className="font-serif text-xl font-bold text-gray-900 mb-3">
                  Personalized Study Plans
                </h3>
                <p className="text-gray-600 leading-relaxed">
                  No two students are the same. We build a prep schedule around
                  your strengths, weaknesses, timeline, and life — not a
                  one-size-fits-all curriculum.
                </p>
              </div>

              {/* Card 3 */}
              <div className="bg-gray-50 rounded-2xl p-8 lg:p-10">
                <div className="w-12 h-12 rounded-xl bg-scarlet/10 flex items-center justify-center mb-6">
                  <svg className="w-6 h-6 text-scarlet" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" d="M18 18.72a9.094 9.094 0 003.741-.479 3 3 0 00-4.682-2.72m.94 3.198l.001.031c0 .225-.012.447-.037.666A11.944 11.944 0 0112 21c-2.17 0-4.207-.576-5.963-1.584A6.062 6.062 0 016 18.719m12 0a5.971 5.971 0 00-.941-3.197m0 0A5.995 5.995 0 0012 12.75a5.995 5.995 0 00-5.058 2.772m0 0a3 3 0 00-4.681 2.72 8.986 8.986 0 003.74.477m.94-3.197a5.971 5.971 0 00-.94 3.197M15 6.75a3 3 0 11-6 0 3 3 0 016 0zm6 3a2.25 2.25 0 11-4.5 0 2.25 2.25 0 014.5 0zm-13.5 0a2.25 2.25 0 11-4.5 0 2.25 2.25 0 014.5 0z" />
                  </svg>
                </div>
                <h3 className="font-serif text-xl font-bold text-gray-900 mb-3">
                  Real Mentorship
                </h3>
                <p className="text-gray-600 leading-relaxed">
                  You&rsquo;re not just getting content — you&rsquo;re getting a
                  mentor who understands the pressure, the stakes, and what it
                  takes to reach your target score.
                </p>
              </div>
            </div>
          </div>
        </section>

        {/* ── Student Stories ── */}
        <section id="results" className="bg-gray-50">
          <div className="mx-auto max-w-7xl px-6 lg:px-8 py-24 md:py-32">
            <div className="grid md:grid-cols-2 gap-16 items-center">
              <div>
                <p className="text-scarlet font-semibold text-sm tracking-widest uppercase mb-3">
                  Student Stories
                </p>
                <h2 className="font-serif text-3xl md:text-5xl font-bold text-gray-900 tracking-tight">
                  We Show Up for Our Students
                </h2>
                <p className="mt-6 text-lg text-gray-600 leading-relaxed">
                  We can&rsquo;t take your test for you — but we can make sure
                  you never feel alone preparing for it. Our students tell us
                  the difference isn&rsquo;t just the material. It&rsquo;s
                  having someone in their corner who genuinely cares.
                </p>
                <div className="mt-10 grid grid-cols-2 gap-6">
                  <div className="border-l-4 border-scarlet pl-4">
                    <p className="text-2xl font-serif font-bold text-gray-900">
                      Always
                    </p>
                    <p className="text-sm text-gray-600 mt-1">
                      Available when you need us
                    </p>
                  </div>
                  <div className="border-l-4 border-scarlet pl-4">
                    <p className="text-2xl font-serif font-bold text-gray-900">
                      Custom
                    </p>
                    <p className="text-sm text-gray-600 mt-1">
                      Every plan built for you
                    </p>
                  </div>
                  <div className="border-l-4 border-scarlet pl-4">
                    <p className="text-2xl font-serif font-bold text-gray-900">
                      Honest
                    </p>
                    <p className="text-sm text-gray-600 mt-1">
                      Real talk, no empty promises
                    </p>
                  </div>
                  <div className="border-l-4 border-scarlet pl-4">
                    <p className="text-2xl font-serif font-bold text-gray-900">
                      Affordable
                    </p>
                    <p className="text-sm text-gray-600 mt-1">
                      Premium prep, fair price
                    </p>
                  </div>
                </div>
              </div>

              {/* Testimonial card */}
              <div className="bg-white rounded-2xl p-8 lg:p-10 shadow-sm border border-gray-200">
                <svg className="w-10 h-10 text-scarlet/30 mb-6" fill="currentColor" viewBox="0 0 24 24">
                  <path d="M14.017 21v-7.391c0-5.704 3.731-9.57 8.983-10.609l.995 2.151c-2.432.917-3.995 3.638-3.995 5.849h4v10h-9.983zm-14.017 0v-7.391c0-5.704 3.748-9.57 9-10.609l.996 2.151c-2.433.917-3.996 3.638-3.996 5.849h3.983v10h-9.983z" />
                </svg>
                <blockquote className="text-lg text-gray-900 leading-relaxed font-medium">
                  &ldquo;What set Praxis apart wasn&rsquo;t a score guarantee —
                  it was having someone who actually picked up the phone when I
                  was spiraling before my exam. They walked me through it, calmed
                  me down, and helped me show up ready. I couldn&rsquo;t have
                  done it without that support.&rdquo;
                </blockquote>
                <div className="mt-8 flex items-center gap-4">
                  <div className="w-12 h-12 rounded-full bg-scarlet/10 flex items-center justify-center">
                    <span className="text-scarlet font-serif font-bold text-lg">
                      S
                    </span>
                  </div>
                  <div>
                    <p className="font-semibold text-gray-900">Sarah M.</p>
                    <p className="text-sm text-gray-600">
                      Praxis Prep Student
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>

        {/* ── Our Approach ── */}
        <section id="approach" className="bg-white">
          <div className="mx-auto max-w-7xl px-6 lg:px-8 py-24 md:py-32">
            <div className="text-center max-w-3xl mx-auto mb-16">
              <p className="text-scarlet font-semibold text-sm tracking-widest uppercase mb-3">
                Our Approach
              </p>
              <h2 className="font-serif text-3xl md:text-5xl font-bold text-gray-900 tracking-tight">
                How Praxis Works
              </h2>
              <p className="mt-6 text-lg text-gray-600 leading-relaxed">
                A clear, structured path from where you are to the score you
                need — no fluff, no filler.
              </p>
            </div>

            <div className="grid md:grid-cols-4 gap-8">
              {[
                {
                  step: "01",
                  title: "Diagnostic Assessment",
                  desc: "We start by understanding exactly where you stand with a full-length practice exam and detailed score analysis.",
                },
                {
                  step: "02",
                  title: "Custom Study Plan",
                  desc: "Based on your diagnostic, timeline, and goals, we create a week-by-week plan tailored specifically to you.",
                },
                {
                  step: "03",
                  title: "Guided Preparation",
                  desc: "Work through high-yield content, practice questions, and strategy sessions with direct mentor support.",
                },
                {
                  step: "04",
                  title: "Test Day Confidence",
                  desc: "Full-length practice exams, timing drills, and mindset coaching so you walk in ready — not anxious.",
                },
              ].map((item) => (
                <div key={item.step} className="text-center md:text-left">
                  <p className="text-5xl font-serif font-bold text-scarlet/15 mb-4">
                    {item.step}
                  </p>
                  <h3 className="font-serif text-lg font-bold text-gray-900 mb-2">
                    {item.title}
                  </h3>
                  <p className="text-gray-600 text-sm leading-relaxed">
                    {item.desc}
                  </p>
                </div>
              ))}
            </div>
          </div>
        </section>

        {/* ── FAQ ── */}
        <section id="faq" className="bg-gray-50">
          <div className="mx-auto max-w-3xl px-6 lg:px-8 py-24 md:py-32">
            <div className="text-center mb-16">
              <p className="text-scarlet font-semibold text-sm tracking-widest uppercase mb-3">
                FAQ
              </p>
              <h2 className="font-serif text-3xl md:text-4xl font-bold text-gray-900 tracking-tight">
                Common Questions
              </h2>
            </div>

            <div className="space-y-6">
              {[
                {
                  q: "Who is Praxis Prep for?",
                  a: "Anyone preparing for the MCAT — whether you're just starting out, retaking the exam, or looking to push your score into the 515+ range. Our approach works for all levels.",
                },
                {
                  q: "What makes Praxis different from other prep companies?",
                  a: "Two things: the experience and the price. We give you real, personal mentorship from someone who's recently been through the MCAT — not a faceless corporation. And we do it at a fraction of the cost of the big prep companies. We'd rather invest in your experience than in marketing promises.",
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
                  a: "That's exactly what we're here for. Prep is hard, and tough stretches are normal. Your mentor will adjust your plan, work through problem areas with you, and make sure you're never stuck alone. We're in your corner the entire way.",
                },
              ].map((item, i) => (
                <details
                  key={i}
                  className="group bg-white rounded-xl border border-gray-200 px-6 py-5"
                >
                  <summary className="flex items-center justify-between cursor-pointer list-none">
                    <span className="font-semibold text-gray-900">
                      {item.q}
                    </span>
                    <svg
                      className="w-5 h-5 text-gray-400 group-open:rotate-180 transition-transform"
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
                  <p className="mt-4 text-gray-600 leading-relaxed">
                    {item.a}
                  </p>
                </details>
              ))}
            </div>
          </div>
        </section>

        {/* ── Final CTA ── */}
        <section id="cta" className="bg-gray-900 text-white">
          <div className="mx-auto max-w-7xl px-6 lg:px-8 py-24 md:py-32 text-center">
            <h2 className="font-serif text-3xl md:text-5xl font-bold tracking-tight">
              Ready to Raise Your Score?
            </h2>
            <p className="mt-6 text-lg text-gray-300 max-w-2xl mx-auto leading-relaxed">
              Join the students who stopped stressing about the MCAT and started
              seeing real progress. Your medical school journey starts here.
            </p>
            <div className="mt-10 flex flex-col sm:flex-row gap-4 justify-center">
              <a
                href="#"
                className="rounded-full bg-scarlet px-10 py-4 text-base font-semibold text-white shadow-lg hover:bg-scarlet-dark transition-colors"
              >
                Get Started — It&rsquo;s Free to Apply
              </a>
            </div>
            <p className="mt-4 text-sm text-gray-400">
              No commitment required. Let&rsquo;s see where you stand.
            </p>
          </div>
        </section>
      </main>

      {/* ── Footer ── */}
      <footer className="bg-gray-900 border-t border-white/10 text-white">
        <div className="mx-auto max-w-7xl px-6 lg:px-8 py-12">
          <div className="flex flex-col md:flex-row justify-between items-center gap-6">
            <div>
              <p className="font-serif text-xl font-bold text-white">
                Praxis Prep
              </p>
              <p className="text-sm text-gray-400 mt-1">
                MCAT prep that actually works.
              </p>
            </div>
            <div className="flex gap-6 text-sm text-gray-400">
              <a href="#" className="hover:text-white transition-colors">
                Privacy
              </a>
              <a href="#" className="hover:text-white transition-colors">
                Terms
              </a>
              <a href="#" className="hover:text-white transition-colors">
                Contact
              </a>
            </div>
          </div>
          <div className="mt-8 border-t border-white/10 pt-8 text-center text-sm text-gray-500">
            &copy; {new Date().getFullYear()} Praxis Prep. All rights reserved.
          </div>
        </div>
      </footer>
    </>
  );
}
