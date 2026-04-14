"use client";

import { useEffect, useRef } from "react";
import Link from "next/link";

export default function Home() {
  const navRef = useRef<HTMLElement>(null);
  const heroVideoRef = useRef<HTMLVideoElement>(null);
  const heroContentRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    // Scroll reveal
    const observer = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            entry.target.classList.add("active");
          }
        });
      },
      { threshold: 0.1, rootMargin: "0px 0px -50px 0px" }
    );

    document.querySelectorAll(".reveal-element").forEach((el) => observer.observe(el));

    // Nav scroll + hero parallax
    function onScroll() {
      const scrollY = window.scrollY;
      const nav = navRef.current;
      const heroImage = heroVideoRef.current;
      const heroContent = heroContentRef.current;

      if (nav) {
        if (scrollY > 60) {
          nav.classList.add("nav-scrolled");
          nav.classList.remove("py-6");
        } else {
          nav.classList.remove("nav-scrolled");
          nav.classList.add("py-6");
        }
      }

      if (heroImage) {
        heroImage.style.opacity = String(Math.max(0, 0.7 - scrollY / 1000));
        heroImage.style.transform = `scale(${1.05 + scrollY * 0.00015}) translateY(${scrollY * 0.12}px)`;
      }

      if (heroContent) {
        heroContent.style.opacity = String(Math.max(0, 1 - scrollY / 800));
        heroContent.style.transform = `translateY(${scrollY * 0.15}px)`;
      }
    }

    window.addEventListener("scroll", onScroll, { passive: true });

    // Magnetic buttons
    document.querySelectorAll(".btn-magnetic").forEach((btn) => {
      const el = btn as HTMLElement;
      el.addEventListener("mousemove", (e: MouseEvent) => {
        const rect = el.getBoundingClientRect();
        const x = (e.clientX - rect.left - rect.width / 2) * 0.15;
        const y = (e.clientY - rect.top - rect.height / 2) * 0.15;
        el.style.transform = `translate(${x}px, ${y}px) translateY(-4px)`;
      });
      el.addEventListener("mouseleave", () => {
        el.style.transform = "";
      });
    });

    return () => {
      observer.disconnect();
      window.removeEventListener("scroll", onScroll);
    };
  }, []);

  return (
    <div className="bg-as-surface font-body text-as-tertiary antialiased selection:bg-as-primary/10 scroll-smooth">
      {/* Navigation */}
      <nav
        ref={navRef}
        className="fixed top-0 left-0 right-0 z-[100] transition-all duration-700 bg-transparent py-6"
      >
        <div className="max-w-screen-2xl mx-auto px-8 grid grid-cols-3 items-center">
          <Link href="/" className="flex items-center gap-3 justify-self-start">
            <img
              src="/logo-white.png"
              alt="Praxist Prep logo"
              className="h-9 w-auto transition-all duration-700 nav-logo-img"
            />
            <span className="font-headline font-bold text-[32px] leading-9 tracking-tight transition-all duration-700 text-as-surface-bright nav-logo-text">
              Praxist Prep
            </span>
          </Link>
          <div className="hidden lg:flex items-center justify-center gap-8">
            <Link
              className="font-label uppercase text-as-surface-bright/70 transition-all duration-500 hover:opacity-100 nav-link text-[11px] font-extrabold tracking-[0.15em]"
              href="#features"
            >
              Curriculum
            </Link>
            <Link
              className="font-label uppercase text-as-surface-bright/70 transition-all duration-500 hover:opacity-100 nav-link text-[11px] font-extrabold tracking-[0.15em]"
              href="#services"
            >
              QBank
            </Link>
            <Link
              className="font-label uppercase text-as-surface-bright/70 transition-all duration-500 hover:opacity-100 nav-link text-[11px] font-extrabold tracking-[0.15em]"
              href="#analytics"
            >
              Analytics
            </Link>
            <Link
              className="font-label uppercase text-as-surface-bright/70 transition-all duration-500 hover:opacity-100 nav-link text-[11px] font-extrabold tracking-[0.15em]"
              href="/pricing"
            >
              Pricing
            </Link>
          </div>
          <div className="flex items-center gap-4 justify-self-end">
            <Link
              className="nav-cta-outline btn-magnetic border-2 border-as-surface-bright/30 text-as-surface-bright px-6 py-2 rounded-full font-label font-bold text-[9px] uppercase tracking-widest transition-all duration-500 hidden sm:inline-block"
              href="/login"
            >
              Sign In
            </Link>
            <Link
              className="nav-cta btn-magnetic bg-as-primary-container text-as-primary-fixed px-6 py-2 rounded-full font-label font-bold text-[9px] uppercase tracking-widest border-2 border-as-primary-container"
              href="/signup"
            >
              Get Started
            </Link>
          </div>
        </div>
      </nav>

      {/* Hero Section */}
      <header className="relative min-h-[90vh] flex items-center overflow-hidden bg-[#0a0a0a]">
        <div className="absolute inset-0 z-0 overflow-hidden">
          <video
            ref={heroVideoRef}
            className="w-full h-full object-cover scale-105 brightness-[0.7]"
            autoPlay
            loop
            muted
            playsInline
            preload="auto"
            onLoadedMetadata={(e) => {
              (e.target as HTMLVideoElement).playbackRate = 0.35;
            }}
          >
            <source src="/hero-video.mp4" type="video/mp4; codecs=hvc1" />
            <source src="/hero-video-h264.mp4" type="video/mp4" />
          </video>
          <div className="absolute inset-x-0 bottom-0 h-2/3 hero-dissolve-mask pointer-events-none" />
        </div>
        <div className="relative z-10 max-w-screen-2xl mx-auto w-full px-8 pt-12 pb-32">
          <div ref={heroContentRef} className="max-w-3xl">
            <span className="inline-block font-label text-[8px] uppercase tracking-[0.4em] mb-4 font-bold text-as-surface-bright/70 text-shadow-hero reveal-element stagger-1">
              MCAT prep, redefined
            </span>
            <h1 className="font-headline text-5xl md:text-6xl lg:text-[5.5rem] leading-[0.95] tracking-tight mb-8 text-as-surface-bright text-shadow-hero reveal-element stagger-2">
              Learn. Apply.
              <br />
              <span className="italic font-normal text-as-primary-fixed-dim">
                Master the MCAT.
              </span>
            </h1>
            <p className="text-base md:text-lg max-w-lg font-light leading-relaxed mb-10 text-as-surface-bright/90 text-shadow-hero reveal-element stagger-3">
              Built by someone who&apos;s been through it. Praxist Prep gives you the
              strategies, structure, and support to score higher — without the
              burnout.
            </p>
            <div className="flex flex-wrap items-center gap-10 reveal-element stagger-4">
              <Link
                href="/signup"
                className="btn-magnetic bg-as-primary-container text-as-primary-fixed px-8 py-4 rounded-lg font-label font-bold text-[10px] uppercase tracking-widest shadow-xl shadow-black/40 border-2 border-as-primary-container"
              >
                Begin Your Journey
              </Link>
              <Link
                href="#features"
                className="group flex items-center gap-3 font-label font-bold text-[10px] uppercase tracking-widest hover:text-white transition-all text-as-surface-bright/80 text-shadow-hero"
              >
                Explore Curriculum
                <svg
                  className="w-3 h-3 group-hover:translate-x-1 transition-transform"
                  fill="none"
                  viewBox="0 0 24 24"
                  strokeWidth={2}
                  stroke="currentColor"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    d="M13.5 4.5L21 12m0 0l-7.5 7.5M21 12H3"
                  />
                </svg>
              </Link>
            </div>
          </div>
        </div>
      </header>

      {/* Narrative Feature 1 */}
      <section id="features" className="bg-as-surface py-32 md:py-40 overflow-hidden relative z-20">
        <div className="max-w-7xl mx-auto px-8">
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-24 lg:gap-32 mb-20">
            <div className="space-y-10">
              <svg
                className="w-6 h-6 text-as-primary reveal-element stagger-1"
                fill="none"
                viewBox="0 0 24 24"
                strokeWidth={1.5}
                stroke="currentColor"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  d="M9.813 15.904L9 18.75l-.813-2.846a4.5 4.5 0 00-3.09-3.09L2.25 12l2.846-.813a4.5 4.5 0 003.09-3.09L9 5.25l.813 2.846a4.5 4.5 0 003.09 3.09L15.75 12l-2.846.813a4.5 4.5 0 00-3.09 3.09zM18.259 8.715L18 9.75l-.259-1.035a3.375 3.375 0 00-2.455-2.456L14.25 6l1.036-.259a3.375 3.375 0 002.455-2.456L18 2.25l.259 1.035a3.375 3.375 0 002.455 2.456L21.75 6l-1.036.259a3.375 3.375 0 00-2.455 2.456z"
                />
              </svg>
              <h2 className="font-headline text-4xl md:text-5xl text-as-primary leading-tight reveal-element stagger-2">
                Structure designed for <br />
                <span className="italic">your cognitive journey.</span>
              </h2>
              <p className="text-base text-as-tertiary/80 leading-relaxed font-light max-w-md reveal-element stagger-3">
                We believe study plans should adapt to the student, not the other
                way around. Our methodology focuses on identifying your unique
                cognitive hurdles and providing the specific strategies to clear
                them.
              </p>
              <div className="flex items-center gap-4 reveal-element stagger-4">
                <Link
                  className="group inline-flex items-center gap-4 font-label text-[9px] uppercase tracking-[0.3em] font-bold text-as-primary"
                  href="#"
                >
                  Our Philosophy of Prep
                  <span className="w-10 h-px bg-as-primary/20 group-hover:w-16 transition-all duration-500" />
                </Link>
              </div>
            </div>
            <div className="reveal-element stagger-2">
              <img
                alt="Abstract neural visualization"
                className="w-full aspect-video object-cover rounded-2xl shadow-2xl grayscale brightness-90 hover:grayscale-0 transition-all duration-1000 border-2 border-as-on-surface"
                src="https://lh3.googleusercontent.com/aida-public/AB6AXuAGngQhgmBhwkLsbCvjf9z8jAoUbJ3wrFLs0bRr83m_BYN5hp-uKr_nOwblM_K5TpF0lAgM9T1qDdhp_shSfGxc2b85SIr7ORyABCP9luhrg10z4pakQLTauaAJ3mZ0iBQicd77wpY-wuv8THVWL-Gs1A2EUKiooCbzxLHOrp7O5WpehpJ51quPSo6_a9EGY0Z6Ky_Mtlll3xvJVbDxjwgwV8B-EMXvglsdz1eQC_B0K5IQuyDjHpK6tGOFdsmdokUE2Hf0aYG7XoI"
              />
            </div>
          </div>

          {/* Feature Cards */}
          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            <div className="bg-as-surface-container-low p-10 rounded-2xl reveal-element border-2 border-as-on-surface flex flex-col h-full card-hover stagger-1">
              <div className="flex items-center gap-4 mb-6">
                <div className="w-10 h-10 rounded-lg bg-as-primary/5 flex items-center justify-center text-as-primary border border-as-primary/20">
                  <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" d="M3 13.125C3 12.504 3.504 12 4.125 12h2.25c.621 0 1.125.504 1.125 1.125v6.75C7.5 20.496 6.996 21 6.375 21h-2.25A1.125 1.125 0 013 19.875v-6.75zM9.75 8.625c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125v11.25c0 .621-.504 1.125-1.125 1.125h-2.25a1.125 1.125 0 01-1.125-1.125V8.625zM16.5 4.125c0-.621.504-1.125 1.125-1.125h2.25C20.496 3 21 3.504 21 4.125v15.75c0 .621-.504 1.125-1.125 1.125h-2.25a1.125 1.125 0 01-1.125-1.125V4.125z" />
                  </svg>
                </div>
                <h4 className="font-headline text-2xl text-as-primary italic">Expert Data</h4>
              </div>
              <div className="space-y-4">
                <div className="flex gap-3">
                  <svg className="w-4 h-4 text-as-primary flex-shrink-0 mt-0.5" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" d="M6.75 3v2.25M17.25 3v2.25M3 18.75V7.5a2.25 2.25 0 012.25-2.25h13.5A2.25 2.25 0 0121 7.5v11.25m-18 0A2.25 2.25 0 005.25 21h13.5A2.25 2.25 0 0021 18.75m-18 0v-7.5A2.25 2.25 0 015.25 9h13.5A2.25 2.25 0 0121 11.25v7.5" />
                  </svg>
                  <p className="text-as-tertiary/70 font-light text-sm leading-relaxed">
                    <strong>Weekly Reports:</strong> Detailed breakdowns of growth trajectory.
                  </p>
                </div>
                <div className="flex gap-3">
                  <svg className="w-4 h-4 text-as-primary flex-shrink-0 mt-0.5" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" d="M9 12.75L11.25 15 15 9.75M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                  </svg>
                  <p className="text-as-tertiary/70 font-light text-sm leading-relaxed">
                    <strong>Personalized Focus:</strong> Pinpoint study areas based on performance.
                  </p>
                </div>
              </div>
            </div>

            <div className="bg-as-surface-container-low p-10 rounded-2xl reveal-element border-2 border-as-on-surface flex flex-col h-full card-hover stagger-2">
              <div className="flex items-center gap-4 mb-6">
                <div className="w-10 h-10 rounded-lg bg-as-primary/5 flex items-center justify-center text-as-primary border border-as-primary/20">
                  <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" d="M9.813 15.904L9 18.75l-.813-2.846a4.5 4.5 0 00-3.09-3.09L2.25 12l2.846-.813a4.5 4.5 0 003.09-3.09L9 5.25l.813 2.846a4.5 4.5 0 003.09 3.09L15.75 12l-2.846.813a4.5 4.5 0 00-3.09 3.09z" />
                  </svg>
                </div>
                <h4 className="font-headline text-2xl text-as-primary italic">Empathetic Assessment</h4>
              </div>
              <p className="text-as-tertiary/70 font-light text-sm leading-relaxed">
                We seek to understand the reasoning behind wrong answers, helping you
                rewire your approach for long-term retention.
              </p>
            </div>

            <div className="bg-as-surface-container-low p-10 rounded-2xl reveal-element border-2 border-as-on-surface flex flex-col h-full card-hover stagger-3">
              <div className="flex items-center gap-4 mb-6">
                <div className="w-10 h-10 rounded-lg bg-as-primary/5 flex items-center justify-center text-as-primary border border-as-primary/20">
                  <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" d="M9 12.75L11.25 15 15 9.75M21 12c0 1.268-.63 2.39-1.593 3.068a3.745 3.745 0 01-1.043 3.296 3.745 3.745 0 01-3.296 1.043A3.745 3.745 0 0112 21c-1.268 0-2.39-.63-3.068-1.593a3.746 3.746 0 01-3.296-1.043 3.745 3.745 0 01-1.043-3.296A3.745 3.745 0 013 12c0-1.268.63-2.39 1.593-3.068a3.745 3.745 0 011.043-3.296 3.746 3.746 0 013.296-1.043A3.746 3.746 0 0112 3c1.268 0 2.39.63 3.068 1.593a3.746 3.746 0 013.296 1.043 3.746 3.746 0 011.043 3.296A3.745 3.745 0 0121 12z" />
                  </svg>
                </div>
                <h4 className="font-headline text-2xl text-as-primary italic">Mindful Milestones</h4>
              </div>
              <p className="text-as-tertiary/70 font-light text-sm leading-relaxed">
                Our projections provide clarity and peace of mind, allowing you to
                focus on the work instead of the worry.
              </p>
            </div>
          </div>
        </div>
      </section>

      {/* Student Stories */}
      <section id="stories" className="bg-as-surface-container-low py-32 md:py-48 overflow-hidden">
        <div className="max-w-7xl mx-auto px-8">
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-20 lg:gap-32 items-center">
            <div className="space-y-12">
              <div className="reveal-element stagger-1">
                <span className="inline-block bg-as-primary/5 text-as-primary font-label text-[10px] uppercase tracking-[0.3em] font-bold px-4 py-2 rounded-full mb-8">
                  Student Stories
                </span>
                <h2 className="font-headline text-4xl md:text-5xl lg:text-6xl text-as-primary leading-[1.1] mb-8">
                  We Show Up for Our Students
                </h2>
                <p className="text-lg md:text-xl text-as-tertiary/70 font-light leading-relaxed max-w-xl">
                  We can&apos;t take your test for you — but we can make sure you never
                  feel alone preparing for it. Our students tell us the difference
                  isn&apos;t just the material. It&apos;s having someone in their corner who
                  genuinely cares.
                </p>
              </div>
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-x-12 gap-y-10 reveal-element stagger-2">
                <div className="border-l-2 border-as-primary/30 pl-6">
                  <h4 className="font-headline text-2xl text-as-primary mb-2 italic">Always</h4>
                  <p className="text-as-tertiary/60 text-sm font-light uppercase tracking-wider">
                    Available when you need us
                  </p>
                </div>
                <div className="border-l-2 border-as-primary/30 pl-6">
                  <h4 className="font-headline text-2xl text-as-primary mb-2 italic">Custom</h4>
                  <p className="text-as-tertiary/60 text-sm font-light uppercase tracking-wider">
                    Every plan built for you
                  </p>
                </div>
                <div className="border-l-2 border-as-primary/30 pl-6">
                  <h4 className="font-headline text-2xl text-as-primary mb-2 italic">Honest</h4>
                  <p className="text-as-tertiary/60 text-sm font-light uppercase tracking-wider">
                    Real talk, no empty promises
                  </p>
                </div>
                <div className="border-l-2 border-as-primary/30 pl-6">
                  <h4 className="font-headline text-2xl text-as-primary mb-2 italic">Affordable</h4>
                  <p className="text-as-tertiary/60 text-sm font-light uppercase tracking-wider">
                    Premium prep, fair price
                  </p>
                </div>
              </div>
            </div>

            <div className="reveal-element stagger-3">
              <div className="bg-white p-12 md:p-16 rounded-3xl shadow-xl shadow-as-primary/5 relative border-2 border-as-on-surface">
                <span className="font-headline text-8xl text-as-primary/10 absolute top-8 left-8 leading-none">
                  &ldquo;
                </span>
                <div className="relative z-10">
                  <p className="font-body text-xl md:text-2xl text-as-tertiary leading-relaxed italic mb-10">
                    &ldquo;What set Praxis apart wasn&apos;t a score guarantee — it was
                    having someone who actually picked up the phone when I was
                    spiraling before my exam. They walked me through it, calmed me
                    down, and helped me show up ready.&rdquo;
                  </p>
                  <div className="flex items-center gap-5">
                    <div className="w-14 h-14 rounded-full bg-as-primary/10 flex items-center justify-center font-headline text-xl text-as-primary font-bold border border-as-primary/20">
                      SM
                    </div>
                    <div>
                      <h5 className="font-label font-bold text-sm text-as-primary uppercase tracking-widest">
                        Sarah M.
                      </h5>
                      <p className="text-xs text-as-tertiary/50 uppercase tracking-wider mt-1">
                        Praxist Prep Student
                      </p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Bento Grid of Services */}
      <section id="services" className="bg-as-surface py-32 md:py-40">
        <div className="max-w-7xl mx-auto px-8">
          <div className="grid grid-cols-1 md:grid-cols-12 gap-10 md:gap-12">
            {/* Mentorship */}
            <div className="md:col-span-7 group bg-as-primary text-as-surface p-12 md:p-16 rounded-2xl flex flex-col justify-between min-h-[450px] md:min-h-[500px] card-hover reveal-element border-2 border-as-primary">
              <div>
                <svg className="w-8 h-8 mb-10 opacity-40 reveal-element stagger-1" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor">
                  <path strokeLinecap="round" strokeLinejoin="round" d="M20.25 8.511c.884.284 1.5 1.128 1.5 2.097v4.286c0 1.136-.847 2.1-1.98 2.193-.34.027-.68.052-1.02.072v3.091l-3-3c-1.354 0-2.694-.055-4.02-.163a2.115 2.115 0 01-.825-.242m9.345-8.334a2.126 2.126 0 00-.476-.095 48.64 48.64 0 00-8.048 0c-1.131.094-1.976 1.057-1.976 2.192v4.286c0 .837.46 1.58 1.155 1.951m9.345-8.334V6.637c0-1.621-1.152-3.026-2.76-3.235A48.455 48.455 0 0011.25 3c-2.115 0-4.198.137-6.24.402-1.608.209-2.76 1.614-2.76 3.235v6.226c0 1.621 1.152 3.026 2.76 3.235.577.075 1.157.14 1.74.194V21l4.155-4.155" />
                </svg>
                <h3 className="font-headline text-4xl italic mb-6 reveal-element stagger-2">
                  Guidance from those who&apos;ve walked the path.
                </h3>
                <p className="text-as-surface/70 text-lg leading-relaxed max-w-sm font-light reveal-element stagger-3">
                  Connect with mentors who remember exactly what it&apos;s like to be in
                  your seat. We offer more than just tutoring; we offer the support
                  system needed to navigate the psychological rigors of the MCAT.
                </p>
              </div>
              <div className="pt-10 reveal-element stagger-4">
                <Link
                  href="/signup"
                  className="btn-magnetic bg-as-surface-bright text-as-primary px-8 py-3.5 rounded-lg font-label font-bold text-[10px] uppercase tracking-widest hover:bg-white border-2 border-as-primary inline-block"
                >
                  Connect with a Mentor
                </Link>
              </div>
            </div>

            {/* High Yield */}
            <div className="md:col-span-5 group bg-as-surface-container-high p-10 md:p-12 rounded-2xl flex flex-col justify-between card-hover reveal-element stagger-2 border-2 border-as-on-surface">
              <svg className="w-6 h-6 text-as-primary mb-8 reveal-element stagger-1" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor">
                <path strokeLinecap="round" strokeLinejoin="round" d="M12 3c2.755 0 5.455.232 8.083.678.533.09.917.556.917 1.096v1.044a2.25 2.25 0 01-.659 1.591l-5.432 5.432a2.25 2.25 0 00-.659 1.591v2.927a2.25 2.25 0 01-1.244 2.013L9.75 21v-6.568a2.25 2.25 0 00-.659-1.591L3.659 7.409A2.25 2.25 0 013 5.818V4.774c0-.54.384-1.006.917-1.096A48.32 48.32 0 0112 3z" />
              </svg>
              <div>
                <h3 className="font-headline text-3xl text-as-primary italic mb-4 reveal-element stagger-2">
                  Essential focus, no fluff.
                </h3>
                <p className="text-as-tertiary/70 text-sm leading-relaxed font-light reveal-element stagger-3">
                  Your time is your most valuable asset. We curate content to focus
                  on high-yield concepts, ensuring your energy is spent where it will
                  have the most significant impact on your journey.
                </p>
              </div>
            </div>

            {/* Analytics */}
            <div
              id="analytics"
              className="md:col-span-12 group bg-as-surface-container-low p-12 md:p-20 rounded-2xl flex flex-col lg:flex-row items-center gap-16 md:gap-24 card-hover reveal-element stagger-3 border-2 border-as-primary"
            >
              <div className="flex-1 space-y-8 text-center lg:text-left">
                <h3 className="font-headline text-4xl text-as-primary reveal-element stagger-1">
                  Insight that <span className="italic">empowers your journey.</span>
                </h3>
                <p className="text-as-tertiary/80 text-lg font-light leading-relaxed max-w-lg mx-auto lg:mx-0 reveal-element stagger-2">
                  Data should inspire confidence, not anxiety. Our dashboard provides
                  a human-readable look at your growth, focusing on your developing
                  mastery across all difficulty tiers and identifying where you need
                  more support.
                </p>
                <div className="pt-4 reveal-element stagger-3">
                  <Link
                    className="group inline-flex items-center gap-6 font-label text-[10px] uppercase tracking-[0.3em] font-bold text-as-primary"
                    href="/signup"
                  >
                    Explore Your Performance Data
                    <span className="w-10 h-px bg-as-primary/20 group-hover:w-16 transition-all duration-500" />
                  </Link>
                </div>
              </div>
              <div className="flex-shrink-0 reveal-element stagger-4">
                <div className="relative w-56 h-56 flex items-center justify-center">
                  <svg className="w-full h-full -rotate-90">
                    <circle
                      className="text-as-primary/5"
                      cx="50%"
                      cy="50%"
                      fill="none"
                      r="80"
                      stroke="currentColor"
                      strokeWidth="1"
                    />
                    <circle
                      className="text-as-primary"
                      cx="50%"
                      cy="50%"
                      fill="none"
                      r="80"
                      stroke="currentColor"
                      strokeDasharray="502"
                      strokeDashoffset="90"
                      strokeWidth="2"
                      style={{
                        transition:
                          "stroke-dashoffset 2s cubic-bezier(0.16, 1, 0.3, 1)",
                      }}
                    />
                  </svg>
                  <div className="absolute inset-0 flex flex-col items-center justify-center">
                    <span className="font-headline text-5xl text-as-primary">82%</span>
                    <span className="font-label uppercase tracking-[0.3em] text-as-secondary/60 mt-3 text-[7.5px]">
                      Growth Velocity
                    </span>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Call to Action */}
      <section className="bg-as-surface py-40 md:py-48 border-t border-as-primary/5">
        <div className="max-w-4xl mx-auto px-8 text-center">
          <h2 className="font-headline text-5xl md:text-6xl text-as-primary leading-tight mb-12 reveal-element stagger-1">
            Begin your journey with{" "}
            <span className="italic">genuine support.</span>
          </h2>
          <div className="reveal-element stagger-2">
            <Link
              href="/signup"
              className="btn-magnetic bg-as-primary text-as-on-primary px-16 py-6 rounded-lg font-label font-bold text-[11px] uppercase tracking-[0.3em] border-2 border-as-primary inline-block"
            >
              Start Your Story
            </Link>
          </div>
        </div>
      </section>

      {/* Footer */}
      <footer className="bg-as-surface-container-low py-16 border-t border-as-primary/5 reveal-element">
        <div className="max-w-screen-2xl mx-auto px-8">
          <div className="flex flex-col md:flex-row justify-between items-center gap-12 pb-12 border-b border-as-primary/5">
            <div className="flex items-center gap-2 reveal-element stagger-1">
              <img src="/logo-green.png" alt="Praxist Prep logo" className="h-7 w-auto" />
              <span className="text-[28px] leading-7 font-headline font-bold text-as-primary">Praxist Prep</span>
            </div>
            <div className="flex flex-wrap justify-center gap-10 reveal-element stagger-2">
              <Link
                className="text-[9px] font-label uppercase tracking-widest text-as-primary/40 hover:text-as-primary transition-colors"
                href="#features"
              >
                Curriculum
              </Link>
              <Link
                className="text-[9px] font-label uppercase tracking-widest text-as-primary/40 hover:text-as-primary transition-colors"
                href="#services"
              >
                QBank
              </Link>
              <Link
                className="text-[9px] font-label uppercase tracking-widest text-as-primary/40 hover:text-as-primary transition-colors"
                href="#analytics"
              >
                Analytics
              </Link>
              <Link
                className="text-[9px] font-label uppercase tracking-widest text-as-primary/40 hover:text-as-primary transition-colors"
                href="/pricing"
              >
                Pricing
              </Link>
              <Link
                className="text-[9px] font-label uppercase tracking-widest text-as-primary/40 hover:text-as-primary transition-colors"
                href="#"
              >
                Privacy
              </Link>
            </div>
          </div>
          <div className="pt-8 flex flex-col md:flex-row justify-between items-center gap-6 reveal-element stagger-3">
            <p className="text-[9px] font-label uppercase tracking-[0.3em] text-as-primary/20">
              &copy; 2025 Praxist Prep. All rights reserved.
            </p>
          </div>
        </div>
      </footer>
    </div>
  );
}
