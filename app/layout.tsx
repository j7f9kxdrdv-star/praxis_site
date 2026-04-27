import type { Metadata } from "next";
import { DM_Serif_Display, Inter, Newsreader, Manrope, Fraunces, Instrument_Serif, Be_Vietnam_Pro } from "next/font/google";
import "./globals.css";
import {
  SITE_URL,
  SITE_NAME,
  DEFAULT_TITLE,
  DEFAULT_DESCRIPTION,
  DEFAULT_OG_IMAGE,
} from "@/lib/seo";
import { isLive } from "@/lib/launch-mode";

const dmSerif = DM_Serif_Display({
  variable: "--font-dm-serif",
  weight: "400",
  subsets: ["latin"],
});

const inter = Inter({
  variable: "--font-inter",
  subsets: ["latin"],
});

const newsreader = Newsreader({
  variable: "--font-newsreader",
  subsets: ["latin"],
});

const manrope = Manrope({
  variable: "--font-manrope",
  subsets: ["latin"],
});

const fraunces = Fraunces({
  variable: "--font-fraunces",
  weight: ["400", "500"],
  subsets: ["latin"],
  style: ["normal", "italic"],
});

const instrumentSerif = Instrument_Serif({
  variable: "--font-instrument-serif",
  weight: "400",
  subsets: ["latin"],
  style: ["normal", "italic"],
});

const beVietnamPro = Be_Vietnam_Pro({
  variable: "--font-be-vietnam",
  weight: ["400", "500", "600", "700"],
  subsets: ["latin"],
});

/**
 * Site-wide metadata. Per-page files can override individual fields by
 * exporting their own `metadata` object — Next merges by key.
 *
 * `robots` is launch-mode-aware: in preview mode we hard-block crawlers so
 * the coming-soon page doesn't get indexed as our canonical content. Once
 * we flip to live, we let crawlers in.
 */
export const metadata: Metadata = {
  metadataBase: new URL(SITE_URL),
  title: {
    default: DEFAULT_TITLE,
    template: `%s — ${SITE_NAME}`,
  },
  description: DEFAULT_DESCRIPTION,
  applicationName: SITE_NAME,
  keywords: [
    "MCAT prep",
    "MCAT tutoring",
    "MCAT course",
    "premed MCAT",
    "MCAT mentorship",
    "affordable MCAT prep",
    "personalized MCAT prep",
  ],
  authors: [{ name: SITE_NAME }],
  alternates: {
    canonical: "/",
  },
  openGraph: {
    type: "website",
    siteName: SITE_NAME,
    title: DEFAULT_TITLE,
    description: DEFAULT_DESCRIPTION,
    url: SITE_URL,
    locale: "en_US",
    images: [DEFAULT_OG_IMAGE],
  },
  twitter: {
    card: "summary_large_image",
    title: DEFAULT_TITLE,
    description: DEFAULT_DESCRIPTION,
    images: [DEFAULT_OG_IMAGE.url],
  },
  robots: isLive()
    ? {
        index: true,
        follow: true,
        googleBot: {
          index: true,
          follow: true,
          "max-image-preview": "large",
          "max-snippet": -1,
        },
      }
    : { index: false, follow: false },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html
      lang="en"
      className={`${dmSerif.variable} ${inter.variable} ${newsreader.variable} ${manrope.variable} ${fraunces.variable} ${instrumentSerif.variable} ${beVietnamPro.variable} h-full antialiased`}
    >
      <body className="min-h-full flex flex-col font-sans">
        {/* Organization structured data — helps Google show a knowledge panel
            and link the brand across queries. JSON-LD is the format Google
            recommends; placing it in the body is fine. */}
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{
            __html: JSON.stringify({
              "@context": "https://schema.org",
              "@type": "Organization",
              name: SITE_NAME,
              url: SITE_URL,
              logo: `${SITE_URL}/logo-green.png`,
              description: DEFAULT_DESCRIPTION,
            }),
          }}
        />
        {children}
      </body>
    </html>
  );
}
