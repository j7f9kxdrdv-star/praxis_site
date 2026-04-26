"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { useDashboard } from "./DashboardShell";

interface NavItem {
  label: string;
  href: string;
  icon: React.ReactNode;
}

interface NavGroup {
  label: string | null;
  items: NavItem[];
}

const navGroups: NavGroup[] = [
  {
    label: null,
    items: [
      {
        label: "Dashboard",
        href: "/dashboard",
        icon: (
          <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.6" strokeLinecap="round" strokeLinejoin="round">
            <path d="M3 12l9-8 9 8" />
            <path d="M5 10v10h14V10" />
          </svg>
        ),
      },
    ],
  },
  {
    label: "Study",
    items: [
      {
        label: "Practice",
        href: "/dashboard/practice",
        icon: (
          <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.6" strokeLinecap="round" strokeLinejoin="round">
            <path d="M4 4h10l6 6v10H4z" />
            <path d="M14 4v6h6" />
            <path d="M8 14h8M8 18h5" />
          </svg>
        ),
      },
      {
        label: "Flashcards",
        href: "/dashboard/flashcards",
        icon: (
          <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.6" strokeLinecap="round" strokeLinejoin="round">
            <rect x="3" y="6" width="16" height="12" rx="2" />
            <path d="M7 3h14v12" />
          </svg>
        ),
      },
      {
        label: "Lessons",
        href: "/dashboard/lessons",
        icon: (
          <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.6" strokeLinecap="round" strokeLinejoin="round">
            <path d="M4 4h7a4 4 0 014 4v12H8a4 4 0 01-4-4z" />
            <path d="M20 4h-3a4 4 0 00-4 4v12h4a3 3 0 003-3z" />
          </svg>
        ),
      },
    ],
  },
  {
    label: "Progress",
    items: [
      {
        label: "Study Plan",
        href: "/dashboard/plan",
        icon: (
          <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.6" strokeLinecap="round" strokeLinejoin="round">
            <rect x="3" y="5" width="18" height="16" rx="2" />
            <path d="M3 9h18M8 3v4M16 3v4" />
            <path d="M8 14l2 2 4-4" />
          </svg>
        ),
      },
      {
        label: "Analytics",
        href: "/dashboard/analytics",
        icon: (
          <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.6" strokeLinecap="round" strokeLinejoin="round">
            <path d="M4 20V10M10 20V4M16 20v-7M22 20H2" />
          </svg>
        ),
      },
    ],
  },
];

function daysUntil(dateStr: string | null): number | null {
  if (!dateStr) return null;
  const target = new Date(dateStr + "T00:00:00");
  const today = new Date();
  today.setHours(0, 0, 0, 0);
  const diff = Math.ceil((target.getTime() - today.getTime()) / (1000 * 60 * 60 * 24));
  return diff >= 0 ? diff : null;
}

function formatTestDate(dateStr: string | null): string | null {
  if (!dateStr) return null;
  const d = new Date(dateStr + "T00:00:00");
  return d.toLocaleDateString("en-US", { month: "short", day: "numeric" });
}

export default function Sidebar() {
  const pathname = usePathname();
  const { profile, user } = useDashboard();

  const initial =
    (profile?.first_name?.[0] ||
      user.user_metadata?.first_name?.[0] ||
      user.email?.[0] ||
      "M").toUpperCase();
  const displayName =
    profile?.first_name ||
    user.user_metadata?.first_name ||
    user.email?.split("@")[0] ||
    "Student";

  const days = daysUntil(profile?.mcat_test_date || null);
  const testDateLabel = formatTestDate(profile?.mcat_test_date || null);

  return (
    <aside
      className="hidden lg:flex lg:flex-col lg:w-56 sticky top-0 h-screen px-[18px] pt-8 pb-[22px] z-10 shrink-0"
      style={{
        background: "var(--color-prax-cream)",
        borderRight: "1px solid var(--color-prax-cream-border)",
        fontFamily: "var(--font-prax-sans)",
      }}
    >
      {/* Logo */}
      <Link href="/" className="flex items-center gap-2.5 mb-9 pl-2">
        <img
          src="/logo-green.png"
          alt="Praxist Prep logo"
          className="h-9 w-auto"
        />
        <div
          className="leading-[1.02] font-semibold"
          style={{
            fontFamily: "var(--font-prax-serif)",
            fontSize: 20,
            color: "var(--color-prax-green)",
          }}
        >
          Praxist
          <br />
          Prep
        </div>
      </Link>

      {/* Navigation groups */}
      <nav className="flex flex-col gap-0.5">
        {navGroups.map((group, gi) => (
          <div key={gi} className={group.label ? "mb-[18px]" : "mb-2"}>
            {group.label && (
              <div
                className="font-semibold uppercase pl-3 mb-2 mt-1"
                style={{
                  fontSize: 9,
                  letterSpacing: "0.22em",
                  color: "var(--color-prax-ink-mute)",
                }}
              >
                {group.label}
              </div>
            )}
            {group.items.map((item) => {
              const isActive =
                item.href === "/dashboard"
                  ? pathname === "/dashboard"
                  : pathname.startsWith(item.href);
              return (
                <Link
                  key={item.href}
                  href={item.href}
                  className="relative flex items-center gap-3 py-2 px-3 rounded-lg text-[13px] cursor-pointer"
                  style={{
                    color: isActive
                      ? "var(--color-prax-green)"
                      : "var(--color-prax-ink-soft)",
                    background: isActive
                      ? "var(--color-prax-cream-card)"
                      : "transparent",
                    border: isActive
                      ? "1px solid var(--color-prax-cream-border)"
                      : "1px solid transparent",
                    fontWeight: isActive ? 600 : 500,
                  }}
                >
                  {isActive && (
                    <div
                      className="absolute top-1/2 -translate-y-1/2"
                      style={{
                        left: -18,
                        width: 3,
                        height: 16,
                        background: "var(--color-prax-green)",
                        borderRadius: 2,
                      }}
                    />
                  )}
                  <span className="opacity-90">{item.icon}</span>
                  <span>{item.label}</span>
                </Link>
              );
            })}
          </div>
        ))}
      </nav>

      <div className="flex-1" />

      {/* Test-day countdown */}
      {days !== null && testDateLabel && (
        <div
          className="px-3.5 py-3 mb-3"
          style={{
            background: "var(--color-prax-cream-card)",
            border: "1px solid var(--color-prax-cream-border)",
            borderRadius: 10,
          }}
        >
          <div
            className="font-semibold uppercase mb-1.5"
            style={{
              fontSize: 9,
              letterSpacing: "0.18em",
              color: "var(--color-prax-ink-mute)",
            }}
          >
            Test Day
          </div>
          <div className="flex items-baseline gap-1.5">
            <div
              className="leading-none font-medium"
              style={{
                fontFamily: "var(--font-prax-serif)",
                fontSize: 22,
                color: "var(--color-prax-green)",
              }}
            >
              {days}
            </div>
            <div
              className="text-[10.5px]"
              style={{ color: "var(--color-prax-ink-soft)" }}
            >
              days · {testDateLabel}
            </div>
          </div>
        </div>
      )}

      {/* User block */}
      <div className="flex items-center gap-2.5 pl-0.5">
        <div
          className="grid place-items-center"
          style={{
            width: 30,
            height: 30,
            borderRadius: "50%",
            background: "var(--color-prax-green-deep)",
            color: "var(--color-prax-cream)",
            fontSize: 12,
            fontWeight: 600,
          }}
        >
          {initial}
        </div>
        <div>
          <div
            className="text-[12px] font-semibold leading-[1.1]"
            style={{ color: "var(--color-prax-ink)" }}
          >
            {displayName}
          </div>
          <div
            className="mt-0.5"
            style={{
              fontSize: 9.5,
              letterSpacing: "0.08em",
              color: "var(--color-prax-ink-mute)",
            }}
          >
            Support · Settings
          </div>
        </div>
      </div>
    </aside>
  );
}
