import DashboardShell from "@/components/dashboard/DashboardShell";
import TimezoneInitializer from "@/components/dashboard/TimezoneInitializer";

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
  return (
    <DashboardShell>
      {/*
        Mounted once for every authenticated page under /dashboard, which is
        the earliest reliable point at which a browser is present AND we know
        who the learner is. It renders nothing and writes only when the stored
        timezone is NULL.
      */}
      <TimezoneInitializer />
      {children}
    </DashboardShell>
  );
}
