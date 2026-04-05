"use client";

import { useState, useRef, useEffect } from "react";
import Link from "next/link";

type DropdownKey = "courses" | "resources" | "about" | null;

interface MenuItem {
  icon: string;
  title: string;
  desc: string;
  href: string;
}

interface MenuColumn {
  heading: string;
  items: MenuItem[];
}

const menuData: Record<string, MenuColumn[]> = {
  courses: [
    {
      heading: "Study Programs",
      items: [
        {
          icon: "🎯",
          title: "Complete MCAT Course",
          desc: "Full curriculum covering all four MCAT sections",
          href: "#",
        },
        {
          icon: "📖",
          title: "CARS Mastery",
          desc: "Dedicated training for Critical Analysis & Reasoning",
          href: "#",
        },
        {
          icon: "🧪",
          title: "Science Review",
          desc: "Bio, Biochem, Chem, Physics — high-yield content",
          href: "#",
        },
        {
          icon: "🧠",
          title: "Psych & Sociology",
          desc: "Behavioral sciences made approachable",
          href: "#",
        },
      ],
    },
    {
      heading: "Practice & Assessment",
      items: [
        {
          icon: "📝",
          title: "Practice Exams",
          desc: "Full-length timed tests that mirror the real MCAT",
          href: "#",
        },
        {
          icon: "❓",
          title: "Question Bank",
          desc: "Thousands of passage-based and discrete questions",
          href: "#",
        },
        {
          icon: "📊",
          title: "Diagnostic Assessment",
          desc: "Find out where you stand before you start",
          href: "#",
        },
      ],
    },
    {
      heading: "Support",
      items: [
        {
          icon: "👤",
          title: "1-on-1 Mentorship",
          desc: "Personal guidance from someone who's been there",
          href: "#",
        },
        {
          icon: "📅",
          title: "Custom Study Plans",
          desc: "A week-by-week schedule built around your life",
          href: "#",
        },
      ],
    },
  ],
  resources: [
    {
      heading: "Free Tools",
      items: [
        {
          icon: "📆",
          title: "MCAT Test Dates",
          desc: "Upcoming registration deadlines and test dates",
          href: "#",
        },
        {
          icon: "🧮",
          title: "Score Calculator",
          desc: "Estimate your MCAT score from practice results",
          href: "#",
        },
        {
          icon: "📋",
          title: "Study Schedule Builder",
          desc: "Create a free study plan in minutes",
          href: "#",
        },
      ],
    },
    {
      heading: "Learn",
      items: [
        {
          icon: "📰",
          title: "Blog",
          desc: "Tips, strategies, and student success stories",
          href: "#",
        },
        {
          icon: "📚",
          title: "MCAT Guides",
          desc: "In-depth breakdowns of every MCAT section",
          href: "#",
        },
        {
          icon: "🎙️",
          title: "Pre-Med Podcast",
          desc: "Conversations with students and admissions experts",
          href: "#",
        },
      ],
    },
  ],
  about: [
    {
      heading: "Company",
      items: [
        {
          icon: "💡",
          title: "Our Story",
          desc: "How a recent MCAT taker built something better",
          href: "#",
        },
        {
          icon: "🤝",
          title: "Our Approach",
          desc: "Why we focus on experience over empty promises",
          href: "#approach",
        },
        {
          icon: "⭐",
          title: "Student Stories",
          desc: "Real experiences from real Praxis students",
          href: "#results",
        },
      ],
    },
    {
      heading: "Connect",
      items: [
        {
          icon: "✉️",
          title: "Contact Us",
          desc: "Questions? We're always happy to talk",
          href: "#",
        },
        {
          icon: "📣",
          title: "Partner With Us",
          desc: "Pre-med clubs, advisors, and organizations",
          href: "#",
        },
      ],
    },
  ],
};

export default function Navigation() {
  const [activeDropdown, setActiveDropdown] = useState<DropdownKey>(null);
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);
  const [mobileExpanded, setMobileExpanded] = useState<DropdownKey>(null);
  const navRef = useRef<HTMLElement>(null);
  const timeoutRef = useRef<ReturnType<typeof setTimeout> | null>(null);

  useEffect(() => {
    function handleClickOutside(e: MouseEvent) {
      if (navRef.current && !navRef.current.contains(e.target as Node)) {
        setActiveDropdown(null);
      }
    }
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, []);

  function handleMouseEnter(key: DropdownKey) {
    if (timeoutRef.current) clearTimeout(timeoutRef.current);
    setActiveDropdown(key);
  }

  function handleMouseLeave() {
    timeoutRef.current = setTimeout(() => setActiveDropdown(null), 200);
  }

  function handleDropdownMouseEnter() {
    if (timeoutRef.current) clearTimeout(timeoutRef.current);
  }

  const navItems: { label: string; key: DropdownKey }[] = [
    { label: "Courses", key: "courses" },
    { label: "Resources", key: "resources" },
    { label: "About", key: "about" },
  ];

  return (
    <header
      ref={navRef}
      className="sticky top-0 z-50 bg-cream/92 backdrop-blur-md border-b border-gray-200"
    >
      <nav className="mx-auto max-w-7xl px-6 lg:px-8">
        <div className="flex h-[68px] items-center justify-between">
          {/* Logo */}
          <Link href="/" className="flex items-center gap-2.5">
            <div className="w-9 h-9 rounded-[10px] bg-gradient-to-br from-coral to-gold flex items-center justify-center text-white font-serif text-lg">
              P
            </div>
            <span className="text-xl font-serif text-navy">Praxis Prep</span>
          </Link>

          {/* Desktop nav */}
          <div className="hidden lg:flex items-center gap-1">
            {navItems.map((item) => (
              <div
                key={item.key}
                onMouseEnter={() => handleMouseEnter(item.key)}
                onMouseLeave={handleMouseLeave}
              >
                <button
                  className={`px-4 py-2 text-sm font-medium rounded-lg transition-colors flex items-center gap-1 ${
                    activeDropdown === item.key
                      ? "text-navy bg-sand"
                      : "text-gray-600 hover:text-navy"
                  }`}
                >
                  {item.label}
                  <svg
                    className={`w-3.5 h-3.5 transition-transform ${
                      activeDropdown === item.key ? "rotate-180" : ""
                    }`}
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
                </button>
              </div>
            ))}
            <Link
              href="#pricing"
              className="px-4 py-2 text-sm font-medium text-gray-600 hover:text-navy transition-colors"
            >
              Pricing
            </Link>
            <Link
              href="#faq"
              className="px-4 py-2 text-sm font-medium text-gray-600 hover:text-navy transition-colors"
            >
              FAQ
            </Link>
          </div>

          {/* Desktop CTAs */}
          <div className="hidden lg:flex items-center gap-3">
            <Link
              href="#"
              className="rounded-full border-2 border-navy px-5 py-2 text-sm font-semibold text-navy hover:bg-navy hover:text-white transition-colors"
            >
              Log In
            </Link>
            <Link
              href="#cta"
              className="rounded-full bg-coral px-5 py-2 text-sm font-semibold text-white shadow-sm hover:bg-coral-dark transition-colors"
            >
              Start Free Trial
            </Link>
          </div>

          {/* Mobile menu button */}
          <button
            type="button"
            className="lg:hidden p-2 text-gray-600"
            onClick={() => setMobileMenuOpen(!mobileMenuOpen)}
            aria-label="Toggle menu"
          >
            {mobileMenuOpen ? (
              <svg
                className="h-6 w-6"
                fill="none"
                viewBox="0 0 24 24"
                strokeWidth={1.5}
                stroke="currentColor"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  d="M6 18L18 6M6 6l12 12"
                />
              </svg>
            ) : (
              <svg
                className="h-6 w-6"
                fill="none"
                viewBox="0 0 24 24"
                strokeWidth={1.5}
                stroke="currentColor"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  d="M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5"
                />
              </svg>
            )}
          </button>
        </div>

        {/* Desktop Mega Menu Dropdown */}
        {activeDropdown && menuData[activeDropdown] && (
          <div
            className="hidden lg:block absolute left-0 right-0 top-[68px] bg-white border-b border-gray-200 shadow-lg"
            onMouseEnter={handleDropdownMouseEnter}
            onMouseLeave={handleMouseLeave}
          >
            <div className="mx-auto max-w-7xl px-6 lg:px-8 py-8">
              <div className="grid grid-cols-3 gap-10">
                {menuData[activeDropdown].map((column) => (
                  <div key={column.heading}>
                    <p className="text-xs font-semibold uppercase tracking-wider text-gray-400 mb-4">
                      {column.heading}
                    </p>
                    <div className="space-y-1">
                      {column.items.map((item) => (
                        <Link
                          key={item.title}
                          href={item.href}
                          className="flex items-start gap-3 rounded-xl p-3 hover:bg-sand transition-colors group"
                          onClick={() => setActiveDropdown(null)}
                        >
                          <span className="text-xl mt-0.5">{item.icon}</span>
                          <div>
                            <p className="text-sm font-semibold text-gray-900 group-hover:text-navy">
                              {item.title}
                            </p>
                            <p className="text-xs text-gray-400 mt-0.5">
                              {item.desc}
                            </p>
                          </div>
                        </Link>
                      ))}
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </div>
        )}

        {/* Mobile Menu */}
        {mobileMenuOpen && (
          <div className="lg:hidden border-t border-gray-200 bg-white absolute left-0 right-0 top-[68px] shadow-lg max-h-[calc(100vh-68px)] overflow-y-auto">
            <div className="px-6 py-4 space-y-1">
              {navItems.map((item) => (
                <div key={item.key}>
                  <button
                    className="flex items-center justify-between w-full py-3 text-sm font-medium text-gray-900"
                    onClick={() =>
                      setMobileExpanded(
                        mobileExpanded === item.key ? null : item.key
                      )
                    }
                  >
                    {item.label}
                    <svg
                      className={`w-4 h-4 text-gray-400 transition-transform ${
                        mobileExpanded === item.key ? "rotate-180" : ""
                      }`}
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
                  </button>
                  {mobileExpanded === item.key &&
                    item.key &&
                    menuData[item.key] && (
                      <div className="pl-4 pb-3 space-y-4">
                        {menuData[item.key!].map((column) => (
                          <div key={column.heading}>
                            <p className="text-xs font-semibold uppercase tracking-wider text-gray-400 mb-2">
                              {column.heading}
                            </p>
                            <div className="space-y-1">
                              {column.items.map((subItem) => (
                                <Link
                                  key={subItem.title}
                                  href={subItem.href}
                                  className="flex items-start gap-3 rounded-lg p-2 hover:bg-sand transition-colors"
                                  onClick={() => setMobileMenuOpen(false)}
                                >
                                  <span className="text-lg">
                                    {subItem.icon}
                                  </span>
                                  <div>
                                    <p className="text-sm font-medium text-gray-900">
                                      {subItem.title}
                                    </p>
                                    <p className="text-xs text-gray-400">
                                      {subItem.desc}
                                    </p>
                                  </div>
                                </Link>
                              ))}
                            </div>
                          </div>
                        ))}
                      </div>
                    )}
                </div>
              ))}
              <Link
                href="#pricing"
                className="block py-3 text-sm font-medium text-gray-900"
                onClick={() => setMobileMenuOpen(false)}
              >
                Pricing
              </Link>
              <Link
                href="#faq"
                className="block py-3 text-sm font-medium text-gray-900"
                onClick={() => setMobileMenuOpen(false)}
              >
                FAQ
              </Link>
              <div className="pt-4 border-t border-gray-200 space-y-3">
                <Link
                  href="#"
                  className="block rounded-full border-2 border-navy px-5 py-2.5 text-sm font-semibold text-navy text-center hover:bg-navy hover:text-white transition-colors"
                  onClick={() => setMobileMenuOpen(false)}
                >
                  Log In
                </Link>
                <Link
                  href="#cta"
                  className="block rounded-full bg-coral px-5 py-2.5 text-sm font-semibold text-white text-center shadow-sm hover:bg-coral-dark transition-colors"
                  onClick={() => setMobileMenuOpen(false)}
                >
                  Start Free Trial
                </Link>
              </div>
            </div>
          </div>
        )}
      </nav>
    </header>
  );
}
