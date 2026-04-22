"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";

const navItems = [
  {
    label: "Dashboard",
    href: "/dashboard",
    icon: (
      <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor">
        <path strokeLinecap="round" strokeLinejoin="round" d="M2.25 12l8.954-8.955a1.126 1.126 0 011.591 0L21.75 12M4.5 9.75v10.125c0 .621.504 1.125 1.125 1.125H9.75v-4.875c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125V21h4.125c.621 0 1.125-.504 1.125-1.125V9.75M8.25 21h8.25" />
      </svg>
    ),
  },
  {
    label: "Practice",
    href: "/dashboard/practice",
    icon: (
      <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor">
        <path strokeLinecap="round" strokeLinejoin="round" d="M16.862 4.487l1.687-1.688a1.875 1.875 0 112.652 2.652L10.582 16.07a4.5 4.5 0 01-1.897 1.13L6 18l.8-2.685a4.5 4.5 0 011.13-1.897l8.932-8.931zm0 0L19.5 7.125M18 14v4.75A2.25 2.25 0 0115.75 21H5.25A2.25 2.25 0 013 18.75V8.25A2.25 2.25 0 015.25 6H10" />
      </svg>
    ),
  },
  {
    label: "Flashcards",
    href: "/dashboard/flashcards",
    icon: (
      <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor">
        <path strokeLinecap="round" strokeLinejoin="round" d="M3.75 8.25a2.25 2.25 0 012.25-2.25h12a2.25 2.25 0 012.25 2.25v8.25a2.25 2.25 0 01-2.25 2.25h-12A2.25 2.25 0 013.75 16.5V8.25z" />
        <path strokeLinecap="round" strokeLinejoin="round" d="M7.5 3.75h9M6 21h12" opacity="0.6" />
      </svg>
    ),
  },
  {
    label: "Lessons",
    href: "/dashboard/lessons",
    icon: (
      <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor">
        <path strokeLinecap="round" strokeLinejoin="round" d="M12 6.042A8.967 8.967 0 006 3.75c-1.052 0-2.062.18-3 .512v14.25A8.987 8.987 0 016 18c2.305 0 4.408.867 6 2.292m0-14.25a8.966 8.966 0 016-2.292c1.052 0 2.062.18 3 .512v14.25A8.987 8.987 0 0018 18a8.967 8.967 0 00-6 2.292m0-14.25v14.25" />
      </svg>
    ),
  },
  {
    label: "Study Plan",
    href: "/dashboard/plan",
    icon: (
      <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor">
        <path strokeLinecap="round" strokeLinejoin="round" d="M6.75 3v2.25M17.25 3v2.25M3 18.75V7.5a2.25 2.25 0 012.25-2.25h13.5A2.25 2.25 0 0121 7.5v11.25m-18 0A2.25 2.25 0 005.25 21h13.5A2.25 2.25 0 0021 18.75m-18 0v-7.5A2.25 2.25 0 015.25 9h13.5A2.25 2.25 0 0121 11.25v7.5" />
      </svg>
    ),
  },
  {
    label: "Analytics",
    href: "/dashboard/analytics",
    icon: (
      <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor">
        <path strokeLinecap="round" strokeLinejoin="round" d="M3 13.125C3 12.504 3.504 12 4.125 12h2.25c.621 0 1.125.504 1.125 1.125v6.75C7.5 20.496 6.996 21 6.375 21h-2.25A1.125 1.125 0 013 19.875v-6.75zM9.75 8.625c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125v11.25c0 .621-.504 1.125-1.125 1.125h-2.25a1.125 1.125 0 01-1.125-1.125V8.625zM16.5 4.125c0-.621.504-1.125 1.125-1.125h2.25C20.496 3 21 3.504 21 4.125v15.75c0 .621-.504 1.125-1.125 1.125h-2.25a1.125 1.125 0 01-1.125-1.125V4.125z" />
      </svg>
    ),
  },
];

export default function Sidebar() {
  const pathname = usePathname();

  return (
    <aside className="hidden lg:flex lg:flex-col lg:w-72 bg-as-surface-container-low h-screen sticky top-0 p-8">
      {/* Logo */}
      <div className="mb-16 px-4">
        <Link href="/" className="flex items-center gap-2">
          <img
            src="/logo-green.png"
            alt="Praxist Prep logo"
            className="h-9 w-auto"
          />
          <h1 className="font-headline text-[32px] leading-9 font-semibold tracking-[0.015em] text-as-primary">
            Praxist Prep
          </h1>
        </Link>
      </div>

      {/* Navigation */}
      <nav className="flex-1 space-y-1">
        {navItems.map((item) => {
          const isActive =
            item.href === "/dashboard"
              ? pathname === "/dashboard"
              : pathname.startsWith(item.href);

          return (
            <Link
              key={item.href}
              href={item.href}
              className={`flex items-center gap-4 py-3 px-4 rounded-xl text-sm transition-colors ${
                isActive
                  ? "text-as-primary font-medium bg-as-surface/50"
                  : "text-as-secondary hover:text-as-primary hover:bg-as-surface/30"
              }`}
            >
              {item.icon}
              <span className="tracking-[0.015em]">{item.label}</span>
            </Link>
          );
        })}
      </nav>

      {/* Bottom section */}
      <div className="mt-auto space-y-8">
        <Link
          href="/dashboard/practice"
          className="w-full py-4 px-6 bg-as-primary-container text-white rounded-2xl font-medium text-sm tracking-[0.015em] flex items-center justify-center gap-2 shadow-sm hover:bg-as-primary transition-colors"
        >
          Start Daily Drill
        </Link>
        <div className="flex items-center justify-between px-4 text-[11px] font-semibold uppercase tracking-widest text-as-secondary/40">
          <Link href="#" className="hover:text-as-primary transition-colors">Support</Link>
          <span className="block w-1 h-1 rounded-full bg-as-secondary/20" />
          <Link href="#" className="hover:text-as-primary transition-colors">Privacy</Link>
          <span className="block w-1 h-1 rounded-full bg-as-secondary/20" />
          <Link href="/dashboard/settings" className="hover:text-as-primary transition-colors">Settings</Link>
        </div>
      </div>
    </aside>
  );
}
