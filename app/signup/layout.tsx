import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Get Started",
  description: "Create your Praxist Prep account.",
  robots: { index: false, follow: true },
  alternates: { canonical: "/signup" },
};

export default function SignupLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return children;
}
