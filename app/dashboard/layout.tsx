import DashboardShell from "@/components/dashboard/DashboardShell";

export const metadata = {
  // The root layout appends the site name via its title template, so this is
  // just the page name. Writing it out again produced "Dashboard · Praxist
  // Prep · Praxist Prep" in the browser tab.
  title: "Dashboard",
  // The dashboard and everything under it is auth-gated. Tell crawlers not
  // to index it so private course content never shows up in search results.
  robots: { index: false, follow: false },
};

export default function DashboardLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return <DashboardShell>{children}</DashboardShell>;
}
