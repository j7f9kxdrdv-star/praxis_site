"use client";

import { useState } from "react";
import Link from "next/link";

export default function Navigation() {
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);

  return (
    <header className="sticky top-0 z-50 bg-white/95 backdrop-blur-sm border-b border-gray-200">
      <nav className="mx-auto max-w-7xl px-6 lg:px-8">
        <div className="flex h-20 items-center justify-between">
          {/* Logo */}
          <Link href="/" className="flex items-center gap-2">
            <span className="text-2xl font-serif font-bold text-scarlet tracking-tight">
              Praxis Prep
            </span>
          </Link>

          {/* Desktop nav links */}
          <div className="hidden md:flex items-center gap-8">
            <Link
              href="#why"
              className="text-sm font-medium text-gray-600 hover:text-scarlet transition-colors"
            >
              Why Praxis
            </Link>
            <Link
              href="#results"
              className="text-sm font-medium text-gray-600 hover:text-scarlet transition-colors"
            >
              Student Stories
            </Link>
            <Link
              href="#approach"
              className="text-sm font-medium text-gray-600 hover:text-scarlet transition-colors"
            >
              Our Approach
            </Link>
            <Link
              href="#faq"
              className="text-sm font-medium text-gray-600 hover:text-scarlet transition-colors"
            >
              FAQ
            </Link>
          </div>

          {/* Desktop CTA */}
          <div className="hidden md:flex items-center gap-4">
            <Link
              href="#cta"
              className="rounded-full bg-scarlet px-6 py-2.5 text-sm font-semibold text-white shadow-sm hover:bg-scarlet-dark transition-colors"
            >
              Get Started
            </Link>
          </div>

          {/* Mobile menu button */}
          <button
            type="button"
            className="md:hidden p-2 text-gray-600"
            onClick={() => setMobileMenuOpen(!mobileMenuOpen)}
            aria-label="Toggle menu"
          >
            {mobileMenuOpen ? (
              <svg className="h-6 w-6" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor">
                <path strokeLinecap="round" strokeLinejoin="round" d="M6 18L18 6M6 6l12 12" />
              </svg>
            ) : (
              <svg className="h-6 w-6" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor">
                <path strokeLinecap="round" strokeLinejoin="round" d="M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5" />
              </svg>
            )}
          </button>
        </div>

        {/* Mobile menu */}
        {mobileMenuOpen && (
          <div className="md:hidden border-t border-gray-200 py-4 space-y-3">
            <Link
              href="#why"
              className="block text-sm font-medium text-gray-600 hover:text-scarlet py-2"
              onClick={() => setMobileMenuOpen(false)}
            >
              Why Praxis
            </Link>
            <Link
              href="#results"
              className="block text-sm font-medium text-gray-600 hover:text-scarlet py-2"
              onClick={() => setMobileMenuOpen(false)}
            >
              Student Stories
            </Link>
            <Link
              href="#approach"
              className="block text-sm font-medium text-gray-600 hover:text-scarlet py-2"
              onClick={() => setMobileMenuOpen(false)}
            >
              Our Approach
            </Link>
            <Link
              href="#faq"
              className="block text-sm font-medium text-gray-600 hover:text-scarlet py-2"
              onClick={() => setMobileMenuOpen(false)}
            >
              FAQ
            </Link>
            <Link
              href="#cta"
              className="block rounded-full bg-scarlet px-6 py-2.5 text-sm font-semibold text-white text-center shadow-sm hover:bg-scarlet-dark transition-colors mt-4"
              onClick={() => setMobileMenuOpen(false)}
            >
              Get Started
            </Link>
          </div>
        )}
      </nav>
    </header>
  );
}
