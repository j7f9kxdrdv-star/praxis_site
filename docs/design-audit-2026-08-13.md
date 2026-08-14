# Praxist Prep — Design & Trust Audit

Verified findings from a six-lens code audit (mobile behaviour, palette tokens, typography, contrast/accessibility, component consistency, copy & trust), each checked by an independent adversarial verifier that rejected mis-cited or taste-based claims. Live-browser measurements were taken separately at phone width.

**109 verified findings** — 6 broken, 34 high, 48 medium, 21 polish.


## BROKEN (6)

### 1. Dashboard home never renders its loading state — returning users see all-zeros and new-user onboarding copy on every page load

**Surface:** dashboard · **File:** `app/dashboard/page.tsx:333` · **Effort:** small

**Evidence.** VERIFIED. `const [loading, setLoading] = useState(true);` (333) and `setLoading(false);` (604) are the only two references to `loading` in the 1,449-line file — it is never read in the render tree, and there is no `if (loading)` guard before the return at 636. Meanwhile `const isNewUser = stats.totalQuestions === 0;` (630) is derived from state initialised to all zeros (314-322), and drives hero copy at 853-855 (`isNewUser ? "Begin with your first practice session."`) and 879-881 (`"We'll start surfacing personalized drills once you've answered a few questions."`). The fetch runs six sequential `await supabase` calls (350-605), two of them inside pagination loops. Every sibling page guards its render: analytics/page.tsx:619, plan/page.tsx:224, lessons/page.tsx:103, flashcards/[deckId]/page.tsx:127, practice/session/[id]/page.tsx:423.

**Why it matters.** This is the first authenticated screen. A student with a long streak and 1,200 answered questions is greeted with brand-new-user copy and a wall of zeros for the full duration of six sequential round-trips, then the page snaps to real data. It reads as data loss, not as loading. DashboardShell's own gate (DashboardShell.tsx:80-89) only covers auth/profile, so it does not mask this.

**Fix.** Add an `if (loading) return (...)` guard before line 636 rendering the PraxPage shell with skeleton cards (reuse the analytics/page.tsx:619-633 pattern). At minimum gate `isNewUser` on `!loading` so onboarding copy cannot render while data is in flight.

### 2. Analytics page header overflows its container by 161px at 375px and the period controls are clipped off-screen and unreachable

**Surface:** dashboard · **File:** `components/dashboard/PraxUI.tsx:385` · **Effort:** medium

**Evidence.** VERIFIED BY MEASUREMENT, not inference. I rebuilt the exact header (PraxUI.tsx:355-386 + analytics/page.tsx:639-720) at 375x812 with Instrument Serif loaded and measured via getBoundingClientRect: header content width 488px against a client width of 327px; the `right` column is 278.3px wide and its right edge lands at x=512 — 137px past the 375px viewport. Mechanism: PraxUI.tsx:355 `flex items-start justify-between gap-4` with no `min-w-0` on the title column, PraxUI.tsx:385 `<div className="shrink-0">` on the right column, and a fixed `fontSize: 44` inline style (364) that no media query can reach, applied to the unbreakable word `title="Performance."` (194px measured). The right column holds two pill groups including two native `<input type="date">` (analytics/page.tsx:685, 707). PraxPage's wrapper is `overflow-hidden` (PraxUI.tsx:45), so this clips rather than scrolls — document.scrollWidth stayed at 375 while the header's scrollWidth was 488.

**Why it matters.** Mobile-first is the house rule. On a phone the student sees roughly half of the period selector: 'All Time' and the second date input are cut off with no way to scroll to them, so the Analytics page cannot be re-scoped on mobile at all. Because the parent clips, there is no scrollbar to hint that anything is missing.

**Fix.** In PraxUI.tsx:355 add `min-w-0` to the title column and make the header `flex-col sm:flex-row`; change 385 to `shrink-0 max-sm:w-full` so `right` drops below the title on phones. Change the h1 at 364 to `fontSize: "clamp(28px, 7.5vw, 44px)"` (ComingSoon.tsx:179 already uses `clamp(34px, 4.2vw, 50px)`). In analytics/page.tsx, collapse the custom date range behind a disclosure below `sm` rather than rendering two date inputs inline.

### 3. Homepage nav CTA is placed in grid column 2 and overlaps the wordmark at 375px

**Surface:** marketing · **File:** `components/MarketingHome.tsx:96` · **Effort:** small

**Evidence.** CONFIRMED. Line 96 is `<div className="max-w-screen-2xl mx-auto px-8 grid grid-cols-3 items-center">` — three equal 1fr tracks, 103.7px each at 375px (375 − 64px of px-8 = 311). The middle nav-link div (line 107) is `hidden lg:flex`, so below 1024px it is display:none and is NOT a grid item. That leaves two items: the logo Link (line 97) in column 1 and the CTA container (line 133, `flex items-center gap-4 justify-self-end` — no explicit column placement) in COLUMN 2, ending at x≈239 with ~104px of dead space to its right. The wordmark span (line 103) is `text-[32px] leading-9`, which overflows its 103.7px track and runs under the pill. The CTA itself (line 141, `px-6` + `tracking-widest` inside a 103.7px track) then wraps to three lines, which is what makes it tall enough to collide vertically. This is the overlap already confirmed by live inspection; included here because the root cause is the grid column count, not the label length.

**Why it matters.** The brand name is obscured by a button in the first viewport every phone visitor sees, on a site whose stated aesthetic is premium/academic/trustworthy.

**Fix.** Line 96: `grid grid-cols-[1fr_auto] lg:grid-cols-3` so below lg the logo and CTA are the only two tracks and the CTA sizes to its content (which also stops the three-line wrap). Then drop the wordmark to `text-xl sm:text-2xl lg:text-[32px]` on line 103. Verify at 375px that the logo's right edge is left of the CTA's left edge.

### 4. Homepage has no mobile navigation at all — no links, no hamburger

**Surface:** marketing · **File:** `components/MarketingHome.tsx:107` · **Effort:** medium

**Evidence.** CONFIRMED. Line 107 `hidden lg:flex` hides Curriculum/QBank/Analytics/Pricing below 1024px; line 135 `hidden sm:inline-block` hides Sign In below 640px. Grepping the whole file for `menu|hamburger|mobileOpen|isOpen` returns zero matches — there is no mobile menu markup or state anywhere in MarketingHome.tsx. Only the wordmark and the Create-an-Account pill remain at 375px. components/Navigation.tsx (used on /pricing) already has the working pattern: mobile menu button at lines 304-339 (`lg:hidden p-2`, toggles `mobileMenuOpen`) and an accordion panel at lines 384+.

**Why it matters.** A phone visitor on the launch homepage cannot reach Pricing or Sign In from the nav at all. app/page.tsx renders MarketingHome for every visitor once NEXT_PUBLIC_LAUNCH_MODE=live, so this is the launch-day homepage.

**Fix.** Add a hamburger + slide-down panel to MarketingHome's nav mirroring components/Navigation.tsx:304-339 and 384+, or replace the bespoke nav with the shared `<Navigation />` component so the two marketing surfaces stop diverging.

### 5. The public site ships two unrelated brands: the homepage is green Academic Sanctuary, /pricing is brown/coral legacy

**Surface:** marketing · **File:** `app/pricing/page.tsx:95` · **Effort:** large

**Evidence.** VERIFIED. components/MarketingHome.tsx:90 roots the homepage in `bg-as-surface font-body text-as-tertiary` and paints accents with --as-primary #003630. app/pricing/page.tsx:95 opens with `className="bg-cream"` (--cream #FAF7F2); grep counts ZERO `-as-*` uses in the file against 42 legacy uses (bg-cream x5, bg-navy x5, text-navy x12, text-gold x14, text-coral x2, text-sage x2, bg-sand x1, border-navy x1). The headers differ too: MarketingHome.tsx:92-148 is a fixed transparent nav whose CTA is `bg-as-primary-container text-as-primary-fixed` labelled "Create an Account" (line 141), while app/pricing/page.tsx:2 imports components/Navigation.tsx — a `sticky top-0 bg-cream/92 backdrop-blur-md border-b border-gray-200` bar (Navigation.tsx:224) whose CTA is `bg-coral ... hover:bg-coral-dark` labelled "Start Free Trial" (Navigation.tsx:297-301). Navigation.tsx is imported by exactly one file, pricing.

**Why it matters.** The "Pricing" link in the homepage nav (MarketingHome.tsx:127-128) is the highest-intent click on the marketing site, and it lands the visitor on what reads as a different company: cream vs off-white background, brown vs green dark tone, terracotta vs green accent, a different header component, and different CTA wording. For a brand whose stated differentiator is trust, a mid-funnel identity break is the most credibility-damaging defect on the site.

**Fix.** Make Academic Sanctuary the only marketing palette. (1) Rewrite app/pricing/page.tsx with the AS mapping: bg-cream→bg-as-surface, bg-sand→bg-as-surface-container, text-navy/bg-navy→text-as-primary/bg-as-primary, text-coral and text-gold accents→text-as-primary (or --as-primary-fixed-dim on dark), text-sage→text-as-primary, gray-900/600/400/200→as-on-surface/as-on-surface-variant/as-outline/as-outline-variant. (2) Extract MarketingHome.tsx:92-148 into components/MarketingNav.tsx and render it from both / and /pricing, then delete components/Navigation.tsx so the two pages share one header. (3) Once nothing references them, delete the legacy block in app/globals.css:4-25 and its @theme mappings at lines 87-108, remapping --background/--foreground to var(--as-surface)/var(--as-on-surface).

### 6. Apple sign-up/sign-in button is inert — no onClick handler at all

**Surface:** marketing · **File:** `app/signup/page.tsx:297` · **Effort:** small

**Evidence.** Verified. app/signup/page.tsx:297-305 is `<button type="button" className="flex items-center justify-center gap-3 bg-as-surface-bright border border-as-outline-variant py-3 rounded-lg hover:bg-as-surface-container ...">` rendering the Apple logo and label "Apple" with no onClick, while the sibling Google button at :272-274 has `onClick={handleGoogleSignup}`. The identical dead Apple button is at app/login/page.tsx:290-298 (finding originally cited 290-305; corrected). No `disabled` attribute and full hover styling, so it presents as live.

**Why it matters.** A user who picks Apple on the last step of the funnel clicks a control that visibly responds to hover and press and then does nothing — no error, no redirect, no recovery path. This is on both signup and login.

**Fix.** Wire it to `supabase.auth.signInWithOAuth({ provider: "apple", ... })` mirroring handleGoogleSignup (app/signup/page.tsx:43-54), or remove the Apple button from both pages and let Google span full width.


## HIGH (34)

### 1. Five different reds render as "error" across the app, including Tailwind's high-chroma defaults on warm cream

**Surface:** both · **File:** `app/dashboard/analytics/daily/page.tsx:22` · **Effort:** medium

**Evidence.** VERIFIED; trimmed from the original claim of seven to the five that actually render (--scarlet #BB0000 at globals.css:7 and --color-prax-danger #a64432 at globals.css:155 both have zero uses repo-wide, so they are dead code, not rendered variants — see the unused-token finding). Rendered: (1) `bg-as-error-container border border-as-error/20 text-as-on-error-container` = #ffdad6 on #93000a at app/login/page.tsx:96 and app/signup/page.tsx:95; (2) #b94a4a via `var(--color-prax-red, #b94a4a)` in six dashboard files; (3) `bg-[#a8432c] hover:bg-[#96371f]` for the "Again" grade button, components/flashcards/StudySurface.tsx:48; (4) Tailwind defaults — `bg-red-50 text-red-600` at app/dashboard/analytics/daily/page.tsx:287 and weekly/page.tsx:375, the STATUS_COLORS maps `bg-red-50 text-red-600` / `bg-red-100 text-red-700` at daily/page.tsx:21-22 and weekly/page.tsx:20-21, and `bg-red-500` bars at daily/page.tsx:85; (5) #e8a594 for the waitlist error, components/ComingSoon.tsx:284. Success and warning fragment the same way: `text-green-600` at practice/session/[id]/page.tsx:673 and :770, `bg-emerald-100 text-emerald-700` at daily/page.tsx:19, `#0b6f56` at StudySurface.tsx:51, --as-primary; and `bg-amber-50 text-amber-700` at daily/page.tsx:21, `bg-amber-500` at :85, `#87621d` at StudySurface.tsx:49, --color-prax-gold #b88746.

**Why it matters.** Tailwind's red-600 and emerald-100 are high-chroma modern web colors; dropped into the muted cream-and-green analytics dashboard they read as chrome from a different app. And a student who hits a #ffdad6 login error, a #b94a4a settings error and a #fef2f2/#e7000b analytics error in one session gets no consistent visual signal for "something went wrong."

**Fix.** Define `--color-danger`, `--color-warning`, `--color-success` plus `-container`/`-on-container` pairs once in the `@theme inline` block of app/globals.css, in the AS hue family (danger #a64432, warning #b88746, success #0b6f56 are already in the file as prax values). Then replace the STATUS_COLORS emerald/amber/red entries at daily/page.tsx:19-23 and weekly/page.tsx:17-22, the inline `bg-red-50 text-red-600` at daily:287 and weekly:375, the bar colors at daily:85, the three arbitrary hexes at StudySurface.tsx:48-51, ComingSoon.tsx:284, and the green-600 checks at practice/session/[id]/page.tsx:673,770. Add a grep guard against bare `red-\d`, `emerald-\d`, `amber-\d`, `green-\d` in components.

### 2. `font-label` is a phantom utility — 23 elements silently fall back to the body font

**Surface:** both · **File:** `app/globals.css:157` · **Effort:** small

**Evidence.** VERIFIED. The `@theme inline` block opens at app/globals.css:86 and defines exactly six family tokens at lines 157-162: `--font-serif`, `--font-sans`, `--font-headline`, `--font-body`, `--font-prax-serif`, `--font-prax-sans`. `grep -n label app/globals.css` returns nothing — there is no `--font-label` token and no hand-written `.font-label` rule anywhere in the stylesheet. Yet `font-label` is written 23 times: components/MarketingHome.tsx:109,115,121,127,135,141,172,190,196,248,335,393,430,471,509,530,548,554,560,566,572,580 and components/dashboard/BottomTabs.tsx:149. The class produces zero CSS.

**Why it matters.** Every uppercase micro-label, every nav link and every CTA on the public homepage was authored as a third, distinct 'label' face and instead inherits whatever the ancestor sets. The marketing surface runs a two-family system while the source reads as a three-family system, so nobody can tell by reading the code what the labels are actually set in, and a future attempt to give labels their own face will look like it is already done.

**Fix.** Either add `--font-label: var(--font-be-vietnam);` (or whichever face was intended) to the `@theme inline` block at app/globals.css:162, or delete all 23 `font-label` occurrences so the source states the truth.

### 3. Newsreader is loaded without an italic, so all 19 italic headings are browser-faked obliques

**Surface:** both · **File:** `app/layout.tsx:25` · **Effort:** small

**Evidence.** VERIFIED EMPIRICALLY, not just from the loader call. `Newsreader({ variable: "--font-newsreader", subsets: ["latin"] })` at app/layout.tsx:25-28 omits `style`, which next/font/google defaults to `['normal']`. I read the generated font CSS the repo already built — `.next/dev/static/chunks/[next]_internal_font_google_newsreader_*.css` — and every one of its four `@font-face` blocks says `font-style: normal; font-weight: 200 800`. No italic face is downloaded. Meanwhile `font-headline` is combined with `italic` in 15 places: app/login/page.tsx:77 and :86, app/signup/page.tsx:76 and :85, components/MarketingHome.tsx:274,303,318,350,356,362,368,418,443, app/dashboard/analytics/daily/page.tsx:92, app/dashboard/analytics/weekly/page.tsx:129 — plus four nested `<span className="italic">` inside `font-headline` headings at MarketingHome.tsx:178,238,461,525. The same file proves the author knows the option: Fraunces (line 35) and Instrument_Serif (line 41) both pass `style: ["normal", "italic"]`, and I confirmed Instrument Serif's generated CSS does contain `font-style: italic`.

**Why it matters.** A synthetic oblique is a mechanical shear of the roman; the true Newsreader italic has different letterforms. At 44px on the login and signup wordmarks over a photographic background the fake slant is plainly visible. This is the most-repeated 'premium academic' gesture on the site and it is counterfeit in all 19 places.

**Fix.** Add `style: ["normal", "italic"]` to the Newsreader loader at app/layout.tsx:25-28. Note the original suggestion to do the same for Manrope is wrong: I checked Manrope's generated CSS (7 faces, all `font-style: normal`) — Google Fonts ships no Manrope italic at all, so `italic` at components/MarketingHome.tsx:382 can only ever be synthetic and should simply be removed.

### 4. Instrument Serif ships weight 400 only but is rendered at 500/600 — faux-bold on both wordmarks

**Surface:** both · **File:** `app/layout.tsx:41` · **Effort:** small

**Evidence.** VERIFIED. `Instrument_Serif({ variable: "--font-instrument-serif", weight: "400", subsets: ["latin"], style: ["normal","italic"] })` at app/layout.tsx:41-46 loads a single weight, and its generated CSS confirms it: five `@font-face` blocks, every one `font-weight: 400`. It is then rendered heavier in five places, all via inline `fontFamily` so the pairing is invisible to a class-name grep: components/ComingSoon.tsx:102-107 (`className="leading-[1.02] font-semibold"` + `fontFamily: "var(--font-prax-serif)"`, fontSize 22 — the coming-soon wordmark), ComingSoon.tsx:175-183 (`className="font-medium m-0"`, the page h1), ComingSoon.tsx:257-261, components/dashboard/Sidebar.tsx:176-181 (`className="leading-[1.02] font-semibold"`, the dashboard wordmark), Sidebar.tsx:273-278. Note the finding's original line cite of 42 for the loader is off by one; it is 41.

**Why it matters.** The browser synthesizes bold by smearing the 400 outline, thickening strokes unevenly and destroying the high-contrast thick/thin that is the reason to pick Instrument Serif. It lands on the two highest-value pieces of type on the site: the coming-soon wordmark and the dashboard wordmark seen on every authenticated page.

**Fix.** Drop `font-semibold`/`font-medium` from the five call sites and let Instrument Serif render at its native 400, or swap to a serif that actually ships the weights.

### 5. One wordmark, four typefaces and five sizes across seven files

**Surface:** both · **File:** `components/MarketingHome.tsx:103` · **Effort:** medium

**Evidence.** VERIFIED, every cite opened. components/Navigation.tsx:237 `"text-[32px] leading-9 font-serif text-navy"` (DM Serif Display, roman, 32px); components/MarketingHome.tsx:103 `"font-headline font-bold text-[32px] leading-9 tracking-tight ..."` (Newsreader, bold, 32px); MarketingHome.tsx:544 `"text-[28px] leading-7 font-headline font-bold"`; app/pricing/page.tsx:454 `"font-serif text-[28px] leading-7 text-white"` (DM Serif, 28px); app/login/page.tsx:77 and app/signup/page.tsx:76 `"font-headline italic text-[44px] leading-[44px]"`; app/check-email/page.tsx:29 `"text-[32px] leading-9 font-serif text-navy"`; components/ComingSoon.tsx:101-112 (Instrument Serif, 22px, semibold, broken onto two lines); components/dashboard/Sidebar.tsx:175-186 (Instrument Serif, 20px, semibold, two lines). Four faces: DM Serif Display, Newsreader roman, Newsreader (faux) italic, Instrument Serif.

**Why it matters.** The wordmark is the one piece of type that must be identical everywhere. A visitor moving homepage -> signup -> check-email sees the brand name in three different treatments in three clicks (Newsreader bold 32px, Newsreader italic 44px, DM Serif roman 32px), and an authenticated user then sees a fourth. This reads as an unfinished site, which is exactly the credibility problem a premium-academic positioning cannot afford.

**Fix.** Extract a single `<Wordmark size="sm|md|lg" />` component into /components, pick one face and one lockup (one line or two, not both), and replace all seven inlined versions with it.

### 6. There is no type scale — 373 off-scale font-size declarations across 30+ distinct values, including six half-pixel steps

**Surface:** both · **File:** `app/globals.css:157` · **Effort:** large

**Evidence.** VERIFIED BY COUNT. `grep -n -- '--text-' app/globals.css` returns nothing, so no scale tokens are defined and Tailwind's default is intact — and bypassed 373 times. Exactly 178 arbitrary `text-[Npx]` utilities across 14 distinct values (7.5, 8, 9, 10, 10.5, 11, 11.5, 12, 13, 13.5, 14, 28, 32, 44 — the top five being 10px x54, 9px x28, 11px x26, 12px x21, 14px x19) and exactly 195 inline `fontSize:` numerals across 27 more (8, 9, 9.5, 10, 10.5, 11, 11.5, 12, 12.5, 13, 13.5, 14, 14.5, 15, 16, 17, 18, 20, 22, 24, 30, 32, 38, 44, 48, 52, 56). Twelve distinct sizes live between 9px and 15px alone. Half-pixel one-offs spot-checked and confirmed at app/dashboard/page.tsx:180 (`fontSize: 10.5`) and :732 (`11.5`), app/dashboard/analytics/page.tsx:950 (`9.5`), app/dashboard/flashcards/page.tsx:1189 (`text-[11.5px]`), components/dashboard/Sidebar.tsx:283 (`text-[10.5px]`), components/ComingSoon.tsx:167 (`fontSize: 10.5`).

**Why it matters.** Thirty sizes is not a scale, it is per-component improvisation. Nothing lines up optically between two cards written a week apart, half-pixel sizes round inconsistently across devices and DPI, and the 195 inline `fontSize` values are invisible to every Tailwind tool and violate the 'Tailwind utility classes only' convention in CLAUDE.md. Practically, no one can change 'the small label size' anywhere — there are eleven of them.

**Fix.** Define a `--text-*` ladder in the `@theme inline` block (6-8 steps, nothing below 12px), then sweep the arbitrary and inline values onto it. Start with app/dashboard/page.tsx, app/dashboard/practice/page.tsx and app/dashboard/analytics/page.tsx, which hold the bulk of the inline values.

### 7. "Free trial" is the primary CTA on six surfaces, but no trial or billing exists anywhere in the codebase

**Surface:** both · **File:** `app/pricing/page.tsx:366` · **Effort:** medium

**Evidence.** Verified. app/pricing/page.tsx:365-366 answers "Is there a free trial?" with "Yes — the Complete plan comes with a free trial so you can experience everything before you commit." Same promise as CTA label at app/pricing/page.tsx:203 and :428 ("Start Your Free Trial →"), components/Navigation.tsx:300 and :479 ("Start Free Trial"), app/login/page.tsx:309 ("Start free trial"). All route to /signup. `grep -rni stripe app components lib` returns zero matches. app/signup/page.tsx:18-41 only calls supabase.auth.signUp then router.push("/check-email") — no plan selection, no trial state, no billing surface (app/dashboard/settings/page.tsx has none either).

**Why it matters.** The highest-intent click on the site promises a free trial and delivers a bare account form with no plan and no confirmation a trial began. It is also a claim the business currently cannot honor. Note: /pricing and /signup are redirect-gated in preview mode (next.config.ts:31-32), so this lands the moment NEXT_PUBLIC_LAUNCH_MODE flips to live.

**Fix.** Until billing ships, change every trial CTA to a truthful neutral label ("Create an Account" / "Get Started", matching MarketingHome.tsx:144) and rewrite the FAQ answer at app/pricing/page.tsx:364-367. When billing ships, carry the selected plan into /signup and state trial terms there.

### 8. Signup makes users agree to a Terms of Use and Privacy Policy that are href="#" — no legal page exists site-wide

**Surface:** both · **File:** `app/signup/page.tsx:234` · **Effort:** medium

**Evidence.** Verified. app/signup/page.tsx:231-246 reads "By creating an account, you agree to our Terms of Use and Privacy Policy" with both `<Link>`s at `href="#"` (lines 234 and 241). Same dead links at app/signup/page.tsx:325/328/331 (Privacy/Terms/Support), app/login/page.tsx:318/321/324, components/MarketingHome.tsx:573 (Privacy), app/pricing/page.tsx:490/491 (Privacy/Terms). `find app -type d -name privacy -o -name terms -o -name legal` returns nothing — the routes do not exist.

**Why it matters.** The site binds users to documents that do not exist and cannot be read, on the same screen where it collects name, email, and password. There is no reachable privacy policy anywhere, while the live pre-launch page collects emails.

**Fix.** Add /privacy and /terms routes with real content and point all the link sites at them. If the documents are not written yet, remove the agreement sentence at app/signup/page.tsx:231-246 rather than asserting agreement to nothing.

### 9. Bottom tab bar covers the last ~26px of every dashboard page on notched iPhones

**Surface:** dashboard · **File:** `components/dashboard/DashboardShell.tsx:103` · **Effort:** small

**Evidence.** CONFIRMED. Line 103: `<main className="flex-1 pb-16 lg:pb-0 lg:px-16 lg:py-16 max-w-[1440px]">` reserves a fixed 64px. components/dashboard/BottomTabs.tsx:133 is `lg:hidden fixed bottom-0 ... pb-[env(safe-area-inset-bottom)]` wrapping an inner row of `h-14` (line 134) = 56px. On an iPhone X-and-later the safe-area inset is 34px, so the bar occupies 90px while only 64px is reserved — a 26px overlap.

**Why it matters.** The bottom 26px of every dashboard page sits under an opaque backdrop-blurred bar on exactly the devices this installable PWA targets, making trailing CTAs and last list rows unreachable.

**Fix.** Line 103: replace `pb-16` with `pb-[calc(3.5rem+env(safe-area-inset-bottom))]` so the reserved space tracks the bar's real height.

### 10. Analytics trend chart renders geometrically distorted at phone width

**Surface:** dashboard · **File:** `app/dashboard/analytics/page.tsx:1195` · **Effort:** medium

**Evidence.** CONFIRMED. Lines 1192-1196: `<svg className="w-full overflow-visible" viewBox="0 0 1000 300" preserveAspectRatio="none" style={{ height: 220 }}>`. It sits in `<div className="flex-1 min-w-0">` (line 1191) inside a `flex gap-3` row (line 1170) whose sibling is a `shrink-0 w-8` axis-label column — so at 375px the svg gets roughly 235px of width against a fixed 220px height. That is x-scale 0.235 vs y-scale 0.733, a 3.1x non-uniform scale. Consequently `strokeWidth="3.5"` (line 1228) paints ~2.6px on horizontal runs and ~0.8px on vertical ones, and the `r="5"` data points (line 1242) render as ~2.4 x 7.3px ellipses rather than circles.

**Why it matters.** The score-trend chart is the centerpiece of the analytics page and visibly deforms on phones — uneven line weight and oval dots — undermining the data-you-can-trust message.

**Fix.** Drop `preserveAspectRatio="none"` and derive the viewBox width from a measured container width (ResizeObserver or an aspect-ratio box); or keep the fixed viewBox and add `vector-effect="non-scaling-stroke"` to the path plus transform-compensated dot radii.

### 11. The authenticated dashboard composites two design systems on one screen — the flashcards layout and sidebar are prax, the deck pages inside them are Academic Sanctuary

**Surface:** dashboard · **File:** `app/dashboard/flashcards/layout.tsx:21` · **Effort:** large

**Evidence.** VERIFIED with exact token counts. app/dashboard/flashcards/layout.tsx:21 wraps every flashcards sub-page in `style={{ background: "var(--color-prax-cream)" }}` (#f6f4e3). Inside it, app/dashboard/flashcards/page.tsx has 80 `prax-` refs and 0 `-as-*`; one click deeper app/dashboard/flashcards/[deckId]/page.tsx:165 renders `<h1 className="font-headline text-3xl sm:text-4xl text-as-primary">` with 38 `-as-*` and 0 prax. Same split for [deckId]/study/page.tsx (39 as / 0 prax), flashcards/session/page.tsx (42 / 0), plan/page.tsx (46 / 0) versus dashboard/page.tsx (0 as / 111 prax), practice/page.tsx (0 / 120), analytics/page.tsx (0 / 134). components/dashboard/DashboardShell.tsx:101 sets the shell to `bg-as-surface-container-low font-body` while the Sidebar it renders is styled at components/dashboard/Sidebar.tsx:162-166 with `background: var(--color-prax-cream)` and `fontFamily: var(--font-prax-sans)`, and its wordmark at Sidebar.tsx:174-184 uses `var(--font-prax-serif)` (Instrument Serif) in `var(--color-prax-green)` #054f46.

**Why it matters.** On a desktop deck-detail screen the user sees an Instrument Serif #054f46 sidebar wordmark next to a Newsreader #003630 page heading. The two creams are one hex unit apart so the backgrounds hide the split, but the two serif faces do not — the chrome and the content read as different products, and it happens on flashcards, the flagship feature.

**Fix.** Pick AS as the survivor and convert the prax pages, or as an immediate stopgap alias the prax tokens to AS values in app/globals.css:142-155 (`--color-prax-cream: var(--as-surface-container-low)`, `--color-prax-green: var(--as-primary-container)`, `--color-prax-green-deep: var(--as-primary)`, `--color-prax-ink: var(--as-on-surface)`, `--color-prax-cream-border: var(--as-outline-variant)`) so both halves resolve identically without touching the ~500 call sites. Separately unify the type: point `--font-prax-serif` (globals.css:161) at `var(--font-newsreader)` so one serif runs through the authenticated app.

### 12. Answered question numbers are invisible in the exam review navigator (1.61:1)

**Surface:** dashboard · **File:** `app/dashboard/practice/session/[id]/page.tsx:985` · **Effort:** small

**Evidence.** VERIFIED. Line 985: `? "bg-[#ccc] text-white cursor-not-allowed"` inside the Review Screen overlay (`{showNav && ...}`, line 950). White #ffffff on #cccccc = 1.61:1 (recomputed). Text is `text-sm font-semibold` (14px), needs 4.5:1. Matching legend swatch at line 1003.

**Why it matters.** Once a student answers a question, its number in the Review Screen becomes effectively unreadable — they cannot tell question 7 from 17 when scanning a full-length exam. Lowest ratio found anywhere in the codebase, inside the paid practice-exam experience. (Severity lowered from 'broken': grid position still implies the number and the disabled state is conveyed by the swatch fill, so nothing is functionally lost — but the numerals are unreadable.)

**Fix.** Darken the answered swatch to ~#6b6b6b (white on #6b6b6b = 5.3:1) or keep #ccc and switch the numeral to `text-[#333]` (11.1:1). Update the legend swatch at line 1003 to match.

### 13. --color-prax-ink-mute is 3.28:1 and is the dashboard's default label colour

**Surface:** dashboard · **File:** `app/globals.css:148` · **Effort:** small

**Evidence.** VERIFIED. Line 148 `--color-prax-ink-mute: #7a8a82;`. Recomputed: 3.28:1 on --color-prax-cream #f6f4e3, 3.41:1 on --color-prax-cream-card #fbf8eb, 2.94:1 on --color-prax-cream-deep #efe7d1. 78 references across 11 files (analytics 15, dashboard/page 14, practice 10, flashcards 10, admin 12, Sidebar 6, settings 4, support 3, PraxUI 2, FlashcardsBg 2). Applied most notably via `SmallCaps` at components/dashboard/PraxUI.tsx line 80 — `fontSize: 10, letterSpacing: "0.22em"` — the standard section label on every dashboard screen. (Original finding cited PraxUI line 82; the fontSize is on line 80.)

**Why it matters.** Every eyebrow, section header, form-field label, stat caption and helper string in the authenticated product fails WCAG 1.4.3 — and at 9.5-10px with 0.22em tracking these are already the hardest strings on the page. A systemic failure, not a one-off.

**Fix.** Darken the token to ~#5f6f68 (4.6:1 on cream) or #5a6a63 (5.0:1). One line in globals.css fixes all call sites at once; re-check the 10px SmallCaps afterwards.

### 14. Practice exam correct/incorrect glyphs and verdict line fail contrast (3.22:1 and 3.81:1)

**Surface:** dashboard · **File:** `app/dashboard/practice/session/[id]/page.tsx:673` · **Effort:** small

**Evidence.** VERIFIED. Line 673 `<span className="shrink-0 mt-0.5 text-green-600 text-sm">✓</span>`, line 677 `text-red-500` ✗. Tailwind 4.2.2 green-600 = oklch(62.7% .194 149.214) = #00a63e = 3.22:1 on the `bg-white` answer pane (line 618); red-500 = #fb2c36 = 3.81:1. Both 14px text glyphs needing 4.5:1. The same pair colours the 13px bold "X is correct" verdict at lines 770-771.

**Why it matters.** After every submission the ✓/✗ and the verdict line are the most important feedback on the screen, and they are the lowest-contrast elements in the pane — the body copy beside them is #333 at 12.6:1. Students reviewing a 59-question block will misread which choice was keyed.

**Fix.** Move to `text-green-700` (#008236, 4.95:1) and `text-red-600` (#e7000b, ~4.8:1) or a darker #c81e1e. The green radio ring at line 711 is non-text and may stay at 3.22:1 but should match for consistency.

### 15. Mobile bottom tab bar: 4.06:1 labels, active state signalled by colour alone, no aria-current

**Surface:** dashboard · **File:** `components/dashboard/BottomTabs.tsx:150` · **Effort:** small

**Evidence.** VERIFIED. Line 150 `isActive ? "text-as-primary" : "text-as-outline"` on a `text-[10px] font-medium` label (line 149). --as-outline #6f7976 on the bar's `bg-as-surface-container-low/95` #f6f4e4 = 4.06:1 (recomputed) — below 4.5:1 for 10px text. The six icons (lines 12, 31, 50, 75, 94, 113) do the same two-colour swap with no shape/fill change, and the `<Link>` at line 142 has no `aria-current`, no weight change, no underline, no pill.

**Why it matters.** This is the primary navigation on phones and mobile-first is the project's hard rule. Five of the six labels sit under the contrast floor at any moment, and the only 'you are here' cue is dark-green vs grey-green — indistinguishable with deuteranopia and completely absent from the accessibility tree (WCAG 1.4.1 + 4.1.2).

**Fix.** Use `text-as-on-surface-variant` (#3f4946 = 8.42:1, not the 8.9 originally claimed) for inactive labels, add `aria-current={isActive ? "page" : undefined}` on the Link at line 142, and add a non-colour active affordance such as a 2px top rule or a filled pill behind the icon.

### 16. prax-gold is the 'needs attention' signal at 2.58–2.99:1

**Surface:** dashboard · **File:** `app/dashboard/page.tsx:224` · **Effort:** small

**Evidence.** VERIFIED. Line 224 `color: empty ? "var(--color-prax-gold)" : "var(--color-prax-ink-mute)"` on an 11px empty-state CTA. --color-prax-gold #b88746 (globals.css line 153) recomputed: 2.88:1 on cream #f6f4e3, 2.99:1 on cream-card #fbf8eb, 2.58:1 on cream-deep #efe7d1. Same token at line 261 (5px attention dot), line 280 (SubjectRow percentage), line 298 (progress-bar fill over the cream-deep track).

**Why it matters.** Gold is the product's only warning colour — it marks the weakest subjects and the empty stat cards. Under 3:1 it is quieter than the neutral text around it, so the one thing the dashboard is trying to pull the eye toward is the thing that recedes. The 5px dot and the bar fill also fail the 3:1 non-text threshold (WCAG 1.4.11).

**Fix.** Darken --color-prax-gold to about #8a6320 (4.8:1 on cream) for text and keep #b88746 only for large fills. Note the SubjectRow already bumps fontWeight when `attention` is true (line 268), so the non-colour cue is partly there — extend it to the dot.

### 17. Sidebar Support/Settings links are 9.5px at 3.28:1

**Surface:** dashboard · **File:** `components/dashboard/Sidebar.tsx:318` · **Effort:** small

**Evidence.** VERIFIED. Line 318 `fontSize: 9.5, letterSpacing: "0.08em"` on the wrapper for the two `<Link>`s at 322-336, each `style={{ color: "var(--color-prax-ink-mute)" }}`; the separating `·` at line 329 is the same. Sidebar background is `var(--color-prax-cream)` (line 163) → 3.28:1 recomputed.

**Why it matters.** 9.5px is the smallest text in the product, roughly two-thirds the size at which 4.5:1 would still be comfortable. Settings and Support are the two places a confused or frustrated student needs to reach, and they are the least visible elements in the whole navigation.

**Fix.** Raise to 11px and use --color-prax-ink-soft #4a5d56 (6.34:1 on cream). The hover state already adds an underline, so only the resting state needs the change.

### 18. Both dashboard modals lack dialog semantics, focus trapping, and Escape-to-close

**Surface:** dashboard · **File:** `app/dashboard/flashcards/page.tsx:1030` · **Effort:** medium

**Evidence.** VERIFIED; line corrected from 1029 to 1030. `<div className="fixed inset-0 z-50 flex items-end sm:items-center justify-center">` at line 1030, backdrop `<div className="absolute inset-0" style={{ background: "rgba(28, 28, 19, 0.45)" }} onClick={onClose} />` at 1032-1036, plain `<div>` card at 1038. No `role="dialog"`, no `aria-modal`, no `aria-labelledby` pointing at the `<h3>`, no focus move on open, no focus restore, no Escape handler. The Build-your-session modal at app/dashboard/practice/page.tsx line 1377 is structurally identical.

**Why it matters.** When either modal opens, keyboard focus stays behind it — Tab walks invisible background links while a screen reader keeps reading the obscured dashboard. There is no Escape exit and the backdrop dismiss is a click-only `<div>` with no keyboard equivalent. Both modals hold settings a student needs (daily card limits, custom session builder).

**Fix.** Add `role="dialog" aria-modal="true" aria-labelledby` to the card div, focus the close button on mount, restore focus to the trigger on unmount, add an Escape listener. Extract once as a shared `PraxModal` in components/dashboard/PraxUI.tsx since both call sites are near-identical.

### 19. The dashboard is a half-finished palette migration: 10 pages render the old Academic Sanctuary look, 8 render the new Prax look, and they are one click apart

**Surface:** dashboard · **File:** `app/dashboard/flashcards/[deckId]/page.tsx:165` · **Effort:** large

**Evidence.** VERIFIED by token census across all 20 dashboard page/layout files (counts = occurrences of `-as-` vs `prax-`). as-* only, zero prax-*: lessons/page.tsx (20), lessons/[section]/page.tsx (17), lessons/[section]/[id]/page.tsx (27), plan/page.tsx (46), analytics/daily/page.tsx (59), analytics/weekly/page.tsx (83), flashcards/[deckId]/page.tsx (38), flashcards/[deckId]/study/page.tsx (39), flashcards/session/page.tsx (42), practice/session/[id]/page.tsx (18). prax-* only, zero as-*: page.tsx (111), practice/page.tsx (120), analytics/page.tsx (134), flashcards/page.tsx (80), settings (25), support (26), admin/flashcards (10), admin/flashcards/[deckId] (18). Concretely: flashcards/page.tsx:283-286 renders `<PageHeader title="Flashcards." />` = Instrument Serif 44px in `--color-prax-green` #054f46 with PraxCard surfaces; clicking a deck lands on flashcards/[deckId]/page.tsx:165 `<h1 className="font-headline text-3xl sm:text-4xl text-as-primary mb-2">` = Newsreader 30px in `--as-primary` #003630, with stat cards at :182 `bg-as-surface-container-lowest rounded-2xl border border-as-outline-variant/15` (pure #ffffff, 16px radius) against PraxCard's warm #fbf8eb at 12-20px. (Original finding said 6 prax pages; the real count is 8.)

**Why it matters.** Both palettes are green-on-cream, so this does not read as 'two products' — it reads as one product that is subtly broken. Heading typeface, heading colour, card fill and card radius all change when a student takes one step deeper into the same feature. Analytics -> Daily Report and Flashcards -> deck are the two most-travelled drill-downs in the app.

**Fix.** Pick prax-* as the single dashboard system and port the 10 as-* pages onto PraxPage/PageHeader/PraxCard. Start with the two that break a flow mid-journey: flashcards/[deckId]/page.tsx and analytics/daily+weekly. Then delete the --as-* block from globals.css:29-57 and 111-139 so it cannot be reintroduced.

### 20. app/dashboard/lessons/page.tsx is a stub — 177 lines against 1,369-1,820 for its siblings — and its section filter silently hides MCAT sections that have no lessons

**Surface:** dashboard · **File:** `app/dashboard/lessons/page.tsx:88` · **Effort:** large

**Evidence.** VERIFIED, whole file read. 177 lines vs practice 1,820 / analytics 1,749 / dashboard 1,449 / flashcards 1,369. (a) No design system: no PraxPage/PageHeader/PraxCard import; container is `max-w-3xl mx-auto px-4 sm:px-6 py-6 sm:py-10` (112) and the h1 is `font-headline text-2xl sm:text-3xl text-as-primary` (113) — Newsreader 24px, versus PageHeader's Instrument Serif 44px green. (b) Emoji icons `🧬 ⚗️ 🧠 📖` at 25, 31, 38, 44, rendered `text-2xl` in a 48px gradient tile (138), where Sidebar.tsx:25-93 uses 17px `strokeWidth="1.6"` SVGs for the same concepts. (c) `const { data: lessons } = await supabase...` (57-59) discards the error object entirely, so a failed fetch is indistinguishable from an empty bank. (d) Empty state is a bare `<div className="text-center py-16">` with one grey sentence and no CTA (169-173), versus the flashcards hub's PraxCard empty state at flashcards/page.tsx:313-347. (e) `sectionOrder.filter((key) => sectionMap.has(key))` at 87-88 drops any of the four MCAT sections with zero lessons.

**Why it matters.** Lessons is one of three items in the Sidebar 'Study' group and one of the mobile tabs, so it sits at the same prominence as Practice and Flashcards, but looks like an earlier, different product. Worse, (e) actively misinforms: a student whose bank only has Bio content sees a single card and no indication the other three sections exist, and (c) shows that same screen after a network failure.

**Fix.** Rebuild on PraxPage + PageHeader + PraxCard to match flashcards/page.tsx. Replace the four emoji with Sidebar-style 1.6-weight stroke SVGs. Render all four `sectionOrder` entries always, with a 'Coming soon' state for zero-lesson sections instead of filtering. Capture and surface the Supabase error. Give the empty state the PraxCard treatment used at flashcards/page.tsx:313.

### 21. Signup drops the user from Academic Sanctuary green into the legacy brown palette mid-flow at /check-email

**Surface:** marketing · **File:** `app/check-email/page.tsx:18` · **Effort:** small

**Evidence.** VERIFIED line by line. app/signup/page.tsx:57-58 renders the signup screen as `font-body text-as-on-surface` over a library photo tinted `rgba(28, 28, 19, 0.4)`, with 56 `-as-*` uses; on success app/signup/page.tsx:40 calls `router.push("/check-email")`. app/check-email/page.tsx:18 is `className="min-h-screen bg-sand flex flex-col"` (--sand #F0E8DC) with `text-navy` at lines 29 and 53, `bg-amber/10` at line 37 and `text-amber` at line 39, `text-gray-600` at 56, `bg-sand text-gray-500` at 61, `bg-navy hover:bg-navy-light` at 68, and `hover:text-coral` at 77 and 80 — 10 legacy uses, zero AS uses. Its "Go to Log In" button (line 68) returns the user to app/login/page.tsx, which is AS again (login/page.tsx:58, 84-88).

**Why it matters.** The three screens a brand-new user sees in sequence are green, brown, green. This is the moment the account is created, when trust matters most, and the confirmation page looks like it belongs to a different site. The amber envelope at lines 37-39 compounds it — a warning-family hue used decoratively on a success screen.

**Fix.** Convert app/check-email/page.tsx to AS: line 18 `bg-sand`→`bg-as-surface-container`; lines 29/53 `text-navy`→`text-as-primary` and `font-serif`→`font-headline` to match /login and /signup; line 35 `border-gray-200`→`border-as-outline-variant`; lines 37/39 `bg-amber/10`+`text-amber`→`bg-as-primary/10`+`text-as-primary`; line 56 `text-gray-600`→`text-as-on-surface-variant`; line 61 `bg-sand`+`text-gray-500`→`bg-as-surface-container-high`+`text-as-on-surface-variant`; line 68 `bg-navy hover:bg-navy-light`→`bg-as-primary hover:bg-as-primary-container`; lines 76-81 `text-gray-400`/`hover:text-coral`→`text-as-outline`/`hover:text-as-primary`.

### 22. Marketing footer and captions use strong tokens at 20-60% alpha, landing at 1.5:1 to 2.9:1 contrast

**Surface:** marketing · **File:** `components/MarketingHome.tsx:580` · **Effort:** small

**Evidence.** VERIFIED, ratios recomputed from the composited sRGB values. components/MarketingHome.tsx:580 is `text-[9px] font-label uppercase tracking-[0.3em] text-as-primary/20` inside the `bg-as-surface-container-low` footer (line 539): #003630 at 20% over #f6f4e4 composites to #C5CEC0 = 1.46:1 (the original 1.54 was slightly off; still far under the 4.5:1 AA floor). Lines 548, 554, 560, 566, 572 set the five footer nav links to `text-[9px] ... text-as-primary/40` = #94A89C on the same footer = 2.28:1. Line 396 renders "Praxist Prep Student" as `text-xs text-as-tertiary/50` on the `bg-white` testimonial card (line 376): #2f2f2f at 50% over white = #979797 = 2.92:1. Line 509 sets the "Growth Velocity" caption to `text-as-secondary/60` at `text-[7.5px]` — 2.61:1 over --as-surface, at a size no one can read regardless.

**Why it matters.** At 375px these are the smallest type on the page and the whole footer link row plus the copyright read as blank space. The specific token misuse is that the palette already ships --as-outline #6f7976 and --as-on-surface-variant #3f4946 for exactly this de-emphasis role and both clear 4.5:1, so the alpha modifiers are solving an already-solved problem badly.

**Fix.** Swap the alpha modifiers for the muted tokens: line 580 `text-as-primary/20`→`text-as-outline`; lines 548/554/560/566/572 `text-as-primary/40`→`text-as-outline` (keep `hover:text-as-primary`); line 396 `text-as-tertiary/50`→`text-as-on-surface-variant`; line 509 `text-as-secondary/60`→`text-as-on-surface-variant`. Raise lines 509 and 580 above 9px while you are in there.

### 23. Hero h1 and closing h2 render at identical size on every viewport below 1024px, including the mandated 375px target

**Surface:** marketing · **File:** `components/MarketingHome.tsx:175` · **Effort:** small

**Evidence.** VERIFIED. The hero h1 at components/MarketingHome.tsx:175 is `"font-headline text-5xl md:text-6xl lg:text-[5.5rem] leading-[0.95] ..."`. The closing CTA h2 at components/MarketingHome.tsx:523 is `"font-headline text-5xl md:text-6xl text-as-primary leading-tight ..."`. Below `md` both resolve to text-5xl = 48px; between `md` and `lg` both resolve to text-6xl = 60px. The h1 only outgrows the h2 at `lg`, where `lg:text-[5.5rem]` = 88px applies. The other two h2s also run different ramps from each other and from this one: line 236 is `text-4xl md:text-5xl`, line 338 is `text-4xl md:text-5xl lg:text-6xl`.

**Why it matters.** On a phone — the viewport CLAUDE.md makes mandatory and primary — the page has no dominant headline. The hero promise and a mid-scroll CTA carry exactly equal typographic weight, so the hierarchy the desktop design depends on does not exist for most visitors. The three-way h2 disagreement means there is no repeatable section-heading rule to fall back on either.

**Fix.** Give the h1 a mobile step the h2s never reach (e.g. `text-[2.75rem] sm:text-5xl md:text-6xl lg:text-[5.5rem]`) and collapse the three h2s at lines 236, 338 and 523 onto one ramp such as `text-3xl md:text-4xl lg:text-5xl`.

### 24. 7.5px type at 2.55:1 contrast on the marketing homepage, plus an 8px hero eyebrow

**Surface:** marketing · **File:** `components/MarketingHome.tsx:509` · **Effort:** small

**Evidence.** VERIFIED, and the contrast is worse than originally claimed — I recomputed it. components/MarketingHome.tsx:509 sets the analytics-dial caption as `"font-label uppercase tracking-[0.3em] text-as-secondary/60 mt-3 text-[7.5px]"`. I traced its container to line 457, `bg-as-surface-container-low` = `#f6f4e4` (app/globals.css:40), and the text is `--as-secondary` = `#5e5f58` (globals.css:32) at 60% alpha. Composited that is **2.55:1** — far below the 4.5:1 AA floor, at 7.5px, uppercase, 0.3em tracked. components/MarketingHome.tsx:172 sets the hero eyebrow as `"inline-block font-label text-[8px] uppercase tracking-[0.4em] mb-4 font-bold text-as-surface-bright/70 text-shadow-hero"` — 8px at 70% opacity over a playing video. These are the two smallest sizes in the codebase and both sit on the public homepage.

**Why it matters.** 7.5px uppercase at 2.55:1 is not readable at arm's length by anyone, and the 0.3em tracking pushes the letters apart without making any of them bigger. The 8px eyebrow is the first line of copy in the hero, over moving video at 70% opacity. Both fail on a phone, the viewport the house rules make primary. A prep company whose own marketing copy is unreadable undercuts the claim of caring about the student experience.

**Fix.** Floor uppercase micro-labels at 11px. Change MarketingHome.tsx:509 to `text-[11px] tracking-[0.18em]` and drop the `/60` to full `text-as-secondary`; change MarketingHome.tsx:172 to `text-[11px] tracking-[0.25em]` and raise the opacity.

### 25. Coming-soon email capture has its focus ring removed and is labelled only by placeholder

**Surface:** marketing · **File:** `components/ComingSoon.tsx:218` · **Effort:** small

**Evidence.** VERIFIED with one correction. Lines 206-227: the input has `placeholder="you@example.com"` (line 211), no `<label>`, no `aria-label`, no `id`; class is `"flex-1 outline-none transition-colors placeholder:opacity-50"` (line 218) with no `focus:` or `focus-visible:` replacement anywhere in the file. CORRECTION to the original claim: the accessible name is NOT empty — per the accname spec `placeholder` is a fallback, so AT announces "you@example.com, edit". The defect is placeholder-as-label (WCAG 3.3.2) plus the stripped focus ring (2.4.7), not a nameless field. Note `lib/launch-mode.ts` defaults to preview, so this is what an unauthenticated visitor sees.

**Why it matters.** This input is the only conversion action on the pre-launch homepage. A keyboard user Tabbing from the 'Sign in' pill gets zero visual indication that focus landed there — the field is pixel-identical focused and unfocused. The placeholder label also disappears the moment the user starts typing, so there is no persistent field identification.

**Fix.** Add `id="waitlist-email"` plus a visually-hidden `<label htmlFor="waitlist-email">Email address</label>` (or `aria-label="Email address"`), and replace `outline-none` with `focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[var(--color-prax-cream)]`.

### 26. Pricing comparison table: 'not included' dash is 1.47:1 and the check icons carry no text alternative

**Surface:** marketing · **File:** `app/pricing/page.tsx:313` · **Effort:** small

**Evidence.** VERIFIED with corrections. Line 313 `<span className="text-gray-300">—</span>`; `gray-300` is not defined in globals.css (only 900/600/400/200/100/50) so it resolves to Tailwind 4.2.2 default #d1d5dc = 1.47:1 on the `bg-white` table (line 261). Checks at line 300 use `text-sage` #8FAF9F on white = 2.39:1 (fails the 3:1 non-text threshold) with no `<title>`, `aria-label` or `sr-only`. CORRECTIONS: (a) the row data at lines 277-285 has NO row with `comp: false`, so the second dash at line 334 never renders — only the Essentials column shows dashes, in 5 rows, not 9; (b) 'nine feature rows unreadable in both directions' is overstated.

**Why it matters.** The Compare Plans table is the page's core purchasing argument. Low-vision users cannot see the 1.47:1 em-dashes at all, so the five Complete-only features look like they might be in both tiers; screen-reader users hear an empty cell for both the check and the dash because neither carries an accessible name.

**Fix.** Replace the `—` with `text-gray-600` (#6B5E52, 6.27:1 on white), darken the check icons off `text-sage`, and add `<span className="sr-only">Included</span>` / `"Not included"` in each cell.

### 27. Marketing footer links are 2.28:1 and the copyright line is 1.46:1

**Surface:** marketing · **File:** `components/MarketingHome.tsx:548` · **Effort:** small

**Evidence.** VERIFIED. `text-[9px] font-label uppercase tracking-widest text-as-primary/40` at lines 548, 554, 560, 566, 572; footer is `bg-as-surface-container-low` (#f6f4e4, line 539). --as-primary #003630 @40% over #f6f4e4 = 2.28:1 (recomputed). Copyright at line 580 uses `text-as-primary/20` = 1.46:1.

**Why it matters.** Five footer navigation links (Curriculum, QBank, Analytics, Pricing, Privacy) render at 9px at half the required ratio; the copyright at 1.46:1 is essentially invisible. Nav and legal text dissolving at the bottom of the homepage reads as an unfinished page.

**Fix.** Use `text-as-primary/70` for the links — recomputed at 5.05:1, NOT the 7.0:1 originally claimed — and raise the font size from 9px to at least 11px. The hover state already goes to full `text-as-primary`, so only the resting state needs work.

### 28. Marketing stat captions, testimonial attribution and 'Growth Velocity' at 2.54–3.68:1

**Surface:** marketing · **File:** `components/MarketingHome.tsx:351` · **Effort:** small

**Evidence.** VERIFIED with one number corrected. `text-as-tertiary/60 text-sm font-light uppercase tracking-wider` at lines 351, 357, 363, 369, inside the section at line 330 (`bg-as-surface-container-low` #f6f4e4): --as-tertiary #2f2f2f @60% = 3.68:1. Line 396 `text-as-tertiary/50` on the white quote card = 2.92:1. Line 509 `text-as-secondary/60` at `text-[7.5px]` sits on a `bg-as-surface-container-low` card (line 457), giving 2.54:1 — the original finding said 2.55:1 against the wrong background. Feature-card copy at 281/289/305/320 uses `text-as-tertiary/70` = 4.90:1 and passes, so the palette is inconsistent with itself.

**Why it matters.** The Always/Custom/Honest/Affordable captions are the payoff lines of the Student Stories section and the attribution is what makes the testimonial credible social proof. 'Growth Velocity' at 7.5px and 2.54:1 is legible to almost nobody. Faint uppercase font-light at these ratios reads as a rendering glitch, not restraint.

**Fix.** Standardise marketing muted text on `text-as-tertiary/70` (4.90:1 on container-low, 5.01:1 on surface), which the feature cards already use. Bump the 7.5px 'Growth Velocity' label to 10px and full `text-as-secondary`.

### 29. Pricing page uses three colours below the floor: gray-400 (2.98–3.18:1), the coral pill (3.45:1), sage checks (2.39:1)

**Surface:** marketing · **File:** `app/pricing/page.tsx:116` · **Effort:** small

**Evidence.** VERIFIED with one sub-claim dropped. Line 116 `text-xs font-bold tracking-[0.1em] uppercase text-gray-400` on the `bg-white` card (line 115): --gray-400 #9C8E82 = 3.18:1. Same token at line 128 (`/month`), 139 ('What's included'), and line 246 (fine print) which sits on the `bg-cream` section from line 111 = 2.98:1. Pricing eyebrow pill at line 97, `text-coral #B8704A` on `bg-[#FDF0EB]` = 3.45:1 at 12px bold. Included-feature checks at line 156, `text-sage` #8FAF9F on white = 2.39:1 (fails the 3:1 graphics threshold). DROPPED: line 390's `text-gray-400` FAQ chevron is a non-text icon at 3.18:1 and passes 1.4.11.

**Why it matters.** The `/month` qualifier beside the $79 price, the 'What's included' header, and the cancellation fine print all fail — on the page where a visitor decides between $79 and $199 a month. The sage checkmarks are the visual proof of what each tier contains and are the faintest marks on the card. The dark tier beside it uses `text-white/85` at 10.33:1, so the two cards read as different quality levels of design.

**Fix.** Retire --gray-400 for text (keep it for borders); use --gray-600 #6B5E52 (6.27:1 on white, 5.87:1 on cream). Darken the pill text to --coral-dark #9E5F3C and the check icons to a darker sage or text-navy.

### 30. The public funnel crosses three palettes in four clicks: home (as-*) -> pricing (legacy navy/coral) -> signup (as-*) -> check-email (legacy sand/navy)

**Surface:** marketing · **File:** `app/pricing/page.tsx:95` · **Effort:** large

**Evidence.** VERIFIED. components/MarketingHome.tsx:90 `className="bg-as-surface font-body text-as-tertiary ..."` — surface #fcfae9, CTA `bg-as-primary-container` #034f46 (141). app/pricing/page.tsx:95 `<section className="bg-cream">`, :97 `text-coral bg-[#FDF0EB] border border-[#F5C8BA]`, :100 `font-serif text-3xl md:text-5xl text-navy`, :115 `bg-white border border-gray-200 rounded-3xl`, :133 `rounded-full border-2 border-navy` — the legacy `--navy` #3B2A1A / `--coral` #B8704A / `--cream` #FAF7F2 block at globals.css:9-16. app/signup/page.tsx:58 returns to as-* over the library photo. app/check-email/page.tsx:18 `bg-sand` (#F0E8DC), :29 `font-serif text-navy`, :35 `bg-white rounded-2xl border border-gray-200`. Pricing is the only public page still on the pre-rebrand scheme.

**Why it matters.** Pricing is the highest-intent public page. A prospect comparing tiers and then signing up watches the brand colour change twice — deep green, then warm brown plus terracotta, then deep green, then warm brown again. CLAUDE.md asks for a restrained palette with the deep brand colour used sparingly; there are currently two competing brand colours on the conversion path.

**Fix.** Port app/pricing/page.tsx and app/check-email/page.tsx onto the as-* tokens MarketingHome/login/signup already use (navy -> as-primary, coral -> as-primary-container or the gold accent, cream/sand -> as-surface, gray-200 -> as-outline-variant), then remove the legacy block from globals.css:7-25 / 90-108.

### 31. The "Praxist Prep" wordmark is set in three different serif typefaces across five public and shell surfaces

**Surface:** marketing · **File:** `components/MarketingHome.tsx:103` · **Effort:** medium

**Evidence.** VERIFIED, all five call sites opened. MarketingHome.tsx:103 `font-headline font-bold text-[32px] leading-9 tracking-tight` = Newsreader, bold, upright, 32px. Navigation.tsx:237 and check-email/page.tsx:29 `text-[32px] leading-9 font-serif text-navy` = DM Serif Display, 32px, navy (`--font-serif` maps to `--font-dm-serif`, globals.css:157). login/page.tsx:77 and signup/page.tsx:76 `font-headline italic text-[44px] leading-[44px] text-white drop-shadow-md` = Newsreader italic 44px. ComingSoon.tsx:101-112 `fontFamily: var(--font-prax-serif), fontSize: 22` with a literal `<br />` between "Praxist" and "Prep" = Instrument Serif, two-line lockup; Sidebar.tsx:174-185 repeats that lockup at 20px. Three families — Newsreader, DM Serif Display, Instrument Serif — two of them at the identical 32px size on adjacent pages.

**Why it matters.** Navigation.tsx is rendered on /pricing and MarketingHome on /, so home -> pricing alone swaps the wordmark between two different serifs at the same size; continuing to signup and then check-email adds a third. Size and treatment variation between a hero lockup and a nav mark is defensible; three typefaces for the company name is not, and it is the single element a 'premium, trustworthy' read depends on most.

**Fix.** Extract one `<Wordmark size tone="light"|"dark" />` component in /components, fix the typeface to a single choice (Instrument Serif matches Sidebar and ComingSoon and is where the brand is heading), and replace all five call sites.

### 32. Pricing sells "Pre-made Anki flashcard decks" — the product ships its own in-app SRS and there is no Anki export

**Surface:** marketing · **File:** `app/pricing/page.tsx:214` · **Effort:** small

**Evidence.** Verified. The $199 tier feature list includes "Pre-made Anki flashcard decks" (app/pricing/page.tsx:214); the comparison table has a tier-differentiating row `{ feature: "Pre-made Anki cards", ess: false, comp: true }` (:282); the FAQ at :373-374 says "They're ready to import into the free Anki app — no setup required." `grep -rni anki app components lib` returns only those three marketing strings plus two incidental code comments (lib/flashcards/cloze.ts:113, lib/flashcards/scheduler.ts:107). No .apkg export and no deck-download route exist; the real feature is the in-app engine under app/dashboard/flashcards/ and components/flashcards/.

**Why it matters.** A paid, tier-gating feature that does not exist, and it points customers at a competitor's app instead of the study runtime the business actually built. A Complete subscriber asking for their .apkg files has no answer.

**Fix.** Replace all three strings with the real capability — e.g. "Pre-built cloze flashcard decks with built-in spaced repetition" — and rewrite the FAQ to describe the in-app scheduler. If Anki export is planned, mark it as coming, not included.

### 33. Practice-exam claims contradict each other on the pricing page: "Full-length practice exams" vs "Limited"

**Surface:** marketing · **File:** `app/pricing/page.tsx:279` · **Effort:** medium

**Evidence.** Verified, same $79 Essentials tier: metadata at :10 says "Practice ($79/mo) for unlimited questions and exams"; Course JSON-LD at :36 says "Unlimited MCAT practice questions and full-length practice exams"; the tier card at :144 lists "Full-length practice exams" unqualified; the comparison table at :279 says `{ feature: "Practice exams", ess: "Limited", comp: "4 full-length" }`. Separately, no full-length exam mode exists — `grep -rni "full-length" app components` outside pricing hits only a Navigation menu description (components/Navigation.tsx:58), and app/dashboard/practice/page.tsx only builds custom filtered question sessions (sections + difficulty), with app/dashboard/practice/session/[id]/page.tsx running them.

**Why it matters.** A prospect reads "Full-length practice exams" in the $79 card, scrolls one section, and is told the same tier is "Limited" with no number. The contradiction is inside a single scroll on the page whose only job is the purchase decision, and the "unlimited" wording is emitted as Google Course structured data, so the unsupported claim can surface in search results.

**Fix.** Pick one true number per tier and use it in the card, the table, the metadata (:10) and both JSON-LD blocks (:36, :61). Until a full-length exam mode ships, describe what exists — timed custom question sets.

### 34. 18 dead href="#" entries in the mega-menu, plus three anchors (#faq, #approach, #results) that exist on no page

**Surface:** marketing · **File:** `components/Navigation.tsx:30` · **Effort:** medium

**Evidence.** Verified: `grep -c 'href: "#"' components/Navigation.tsx` returns exactly 18. Corrected line list (the original finding mis-cited a few): Courses 30, 36, 42, 48, 59, 65, 71, 82, 89; Resources 101, 107, 113, 124, 130, 136; About 149, 172, 178. The three non-# menu links point at anchors that do not exist: "#approach" (:155), "#results" (:161), "#faq" (:281 desktop and :460 mobile). `grep -rn 'id="faq"' app components` and the same for approach/results all return nothing; the only section ids are features, stories, services, analytics (components/MarketingHome.tsx:219, 330, 409, 456). Navigation is imported only by app/pricing/page.tsx:2 and rendered at :91, and that page has none of those ids.

**Why it matters.** On the pricing page — the page a buyer opens with questions — the entire top navigation is inert. Opening "Courses" shows nine richly described programs, all of which do nothing on click, and "FAQ" does nothing even though that page's FAQ section is 250 lines further down. This reads as broken, not unfinished.

**Fix.** Give the FAQ section at app/pricing/page.tsx:350 an `id="faq"` so that link works, then either point each mega-menu item at real content or cut the menu down to routes that exist (Pricing, FAQ, Log In, Sign Up). Descriptions of unbuilt features should not be clickable.


## MEDIUM (48)

### 1. `font-label` is applied 23 times but no `--font-label` theme key exists, so the utility is never generated

**Surface:** both · **File:** `components/MarketingHome.tsx:109` · **Effort:** small

**Evidence.** VERIFIED. app/globals.css:157-162 defines only --font-serif, --font-sans, --font-headline, --font-body, --font-prax-serif, --font-prax-sans; there is no --font-label. No tailwind.config.* exists (confirmed) and postcss.config.mjs loads only @tailwindcss/postcss, so Tailwind 4 CSS-first config emits a `font-*` utility only for a matching `--font-*` key — `.font-label` is never emitted. It is nevertheless applied at components/MarketingHome.tsx lines 109, 115, 121, 127, 135, 141, 172, 190, 196, 248, 335, 393, 430, 471, 509, 530, 548, 554, 560, 566, 572, 580 and components/dashboard/BottomTabs.tsx:149 — 23 occurrences.

**Why it matters.** Severity lowered from high: nothing renders visibly broken today, because all 23 sites inherit Manrope from the `font-body` root at MarketingHome.tsx:90. The defect is that the class reads as intentional in source, so the file lies about its own type system — and the day anyone defines `--font-label`, 23 sites across the nav, hero, footer and mobile tab bar change typeface at once with no diff to explain it.

**Fix.** Decide and commit: either add `--font-label: var(--font-inter);` (or whichever face was intended) to the `@theme inline` block in app/globals.css near line 160, or delete all 23 occurrences. Do not leave it half-declared. Same audit applies to any other invented utility — grep `font-`, `bg-`, `text-` prefixes against the `--color-*`/`--font-*` keys in globals.css.

### 2. gray-300, gray-500 and gray-700 are not in the theme, so they render Tailwind's cool default grays beside the project's warm overrides

**Surface:** both · **File:** `app/dashboard/lessons/[section]/[id]/page.tsx:125` · **Effort:** medium

**Evidence.** VERIFIED; primary anchor moved from the pricing dashes to the lesson body copy, which is the visible instance. app/globals.css:103-108 overrides only six steps of the gray scale — --color-gray-900/600/400/200/100/50 mapped to warm browns (#2E2520, #6B5E52, #9C8E82, #E8DFD4, #F0E8DC, #FAF7F2). Every other step still resolves to Tailwind's built-in cool neutral, because overriding individual keys does not clear the namespace. Three unmapped steps are in use: `text-gray-700` on whole paragraphs and lists at app/dashboard/lessons/[section]/[id]/page.tsx:87, :125, :136, :149; `text-gray-300` at app/pricing/page.tsx:313 and :334 (the not-included dashes), app/dashboard/plan/page.tsx:321 and :379 (hover borders), app/dashboard/lessons/[section]/page.tsx:166; `text-gray-500` at app/check-email/page.tsx:61.

**Why it matters.** gray-700 is a blue-slate (~#364153) and it is setting entire paragraphs of lesson body copy on a warm cream surface — a full block of cool-toned text in a warm layout, which is visible without hunting for it. The pricing-table instance is subtler (a single em-dash at line 313 next to warm #2E2520 at line 294), but the scale is a trap either way: it looks complete, so any future gray-800 or gray-50 silently mixes temperature again.

**Fix.** Stop shadowing Tailwind's `gray` namespace. Either rename the six warm tokens so they cannot collide (e.g. --color-ink-900/600/400, --color-parchment-200/100/50) and update the ~41 call sites, or replace them outright with the AS neutrals: gray-900→as-on-surface, gray-700/600→as-on-surface-variant, gray-500/400→as-outline, gray-300/200/100→as-outline-variant / as-surface-container. Fix the four lessons paragraphs first.

### 3. The document body paints legacy cream #FAF7F2, which no surface in the app uses

**Surface:** both · **File:** `app/globals.css:166` · **Effort:** small

**Evidence.** VERIFIED. app/globals.css:165-168 sets `body { background: var(--background); color: var(--foreground); }` with --background: #FAF7F2 and --foreground: #2E2520 (lines 5-6), both legacy. Every actual surface paints over it: components/MarketingHome.tsx:90 `bg-as-surface` (#fcfae9), components/dashboard/DashboardShell.tsx:101 `bg-as-surface-container-low` (#f6f4e4), app/dashboard/flashcards/layout.tsx:21 prax cream (#f6f4e3), components/ComingSoon.tsx:61 `background: "#0a0a0a"`. app/layout.tsx:148 gives the body `min-h-full flex flex-col font-sans` and no background of its own; `<html>` at line 146 has `h-full antialiased` and no background. app/layout.tsx:131 declares `themeColor: "#003630"`, and app/page.tsx:45 returns `null` until the auth check resolves.

**Why it matters.** Anywhere the page background shows through — iOS rubber-band overscroll, below short pages, and the pre-auth blank frame from app/page.tsx:45 — the user gets a cream from a palette nothing else uses, under a #003630 status bar. Against the AS surfaces the delta is small; against the #0a0a0a ComingSoon page it is a full-width cream band on every overscroll bounce, which on mobile is constant.

**Fix.** Set `body { background: var(--as-surface); color: var(--as-on-surface); }` and mirror the background on `html` so overscroll matches. Redefine globals.css:5-6 as aliases (`--background: var(--as-surface)`, `--foreground: var(--as-on-surface)`) so the two cannot drift. Give app/page.tsx a surface-colored placeholder instead of `return null` at line 45.

### 4. Uppercase micro-labels: same size, same role, nine different tracking values

**Surface:** both · **File:** `components/MarketingHome.tsx:248` · **Effort:** medium

**Evidence.** VERIFIED including the adjacent-element cases, which are the ones a user actually sees side by side. Identical 9px uppercase labels get different tracking within one file: components/MarketingHome.tsx:135 and :548 use `tracking-widest` (0.1em) while :248 and :580 use `tracking-[0.3em]` — 3x the letterspacing at the same size for the same kind of label. In the same sticky sidebar panel in app/dashboard/flashcards/session/page.tsx, line 613 is `"text-[9px] font-bold uppercase tracking-[0.2em] text-as-outline mb-1.5"` while lines 632, 638 and 642 are `"text-[9px] font-bold uppercase tracking-widest text-as-outline mt-0.5"` — visible in one screenful. Across app/ and components/ I counted nine tracking values in use: `tracking-wide` (5), `tracking-wider` (29), `tracking-widest` (47), and arbitrary 0.08em (1), 0.1em (3), 0.15em (4), 0.2em (17), 0.3em (6), 0.4em (1). `tracking-widest` and `tracking-[0.1em]` are the same value written two ways and both are in use.

**Why it matters.** Letterspacing on uppercase should be a single function of size so every label in the product reads as one voice. Nine values means adjacent labels on the same screen look like they came from different design systems.

**Fix.** Define two or three label recipes in the `@theme inline` block (e.g. `label-xs` = 11px/0.18em, `label-sm` = 12px/0.14em) and sweep the uppercase call sites onto them, starting with components/MarketingHome.tsx and app/dashboard/flashcards/session/page.tsx.

### 5. No prefers-reduced-motion handling anywhere — including two infinite animations and mouse-tracking parallax

**Surface:** both · **File:** `app/globals.css:174` · **Effort:** small

**Evidence.** VERIFIED. `grep -rn "prefers-reduced-motion|motion-reduce|motion-safe" app components lib` returns zero matches. globals.css: `@keyframes fadeInUp` (174), `@keyframes praxPulse` + `.animate-prax-pulse { animation: praxPulse 2s ease-out infinite }` (189-196), `.reveal-element { transform: translateY(-40px); transition ... 1.4s }` (199-208), `.btn-magnetic:hover { transform: translateY(-4px) }` (218), `.card-hover:hover { transform: translateY(-8px) }` (226), `html { scroll-behavior: smooth }` (170). components/MarketingHome.tsx lines 56-63 scale and translate the hero video on every scroll event; lines 69-80 make every `.btn-magnetic` chase the cursor. components/flashcards/RotateGate.tsx line 42 runs `animation: "pxt-tip 2.2s ease-in-out infinite"`.

**Why it matters.** Two never stop: the green 'Active now' pulse (rendered on every dashboard page via ActiveNowPill, PraxUI.tsx ~404) and the rotating-phone prompt. For a user with vestibular sensitivity, the homepage's 1.4s translateY reveals plus cursor-following buttons plus scroll-driven video scaling is exactly the combination that triggers nausea — on the first page they land on. (Severity lowered from 'high': WCAG 2.3.3 is AAA and the infinite animations are small decorative elements, so this is a real but non-blocking gap.)

**Fix.** Add to globals.css: `@media (prefers-reduced-motion: reduce) { *, *::before, *::after { animation-duration: 0.01ms !important; animation-iteration-count: 1 !important; transition-duration: 0.01ms !important; scroll-behavior: auto !important } }`, and guard the JS in MarketingHome.tsx with `if (window.matchMedia('(prefers-reduced-motion: reduce)').matches) return;` before attaching the scroll and mousemove listeners.

### 6. No skip link, and MarketingHome has no <main> landmark

**Surface:** both · **File:** `components/MarketingHome.tsx:88` · **Effort:** small

**Evidence.** VERIFIED; line corrected from 90 to 88 (`return ( <div className="bg-as-surface font-body …">` at line 88). It contains `<nav>` (line 90), `<header>` (151), four `<section>`s and a `<footer>` (539) but never a `<main>`. `grep -rn "<main"` finds it only in app/login/page.tsx:68, app/signup/page.tsx:67, app/pricing/page.tsx:93, components/ComingSoon.tsx:57 and components/dashboard/DashboardShell.tsx:103. app/check-email/page.tsx has none. No skip-to-content link exists anywhere in app/ or components/.

**Why it matters.** A screen-reader user landing on the homepage has no 'main content' landmark to jump to, and a keyboard user must Tab through the wordmark, nav links and CTAs on every marketing page — and on the dashboard through the logo plus six-to-seven sidebar links plus Support/Settings/Log out — before reaching any page content. WCAG 2.4.1.

**Fix.** Wrap MarketingHome's content (from the `<header>` at 151 through the CTA section) in `<main id="main">`, do the same in check-email, and add `<a href="#main" className="sr-only focus:not-sr-only …">Skip to content</a>` as the first child in app/layout.tsx and components/dashboard/DashboardShell.tsx.

### 7. Emoji used as product iconography on Lessons, Study Plan and every pricing-page nav dropdown, while every other nav surface uses hand-drawn stroke SVGs

**Surface:** both · **File:** `app/dashboard/lessons/page.tsx:25` · **Effort:** medium

**Evidence.** VERIFIED, and the count is higher than reported. Emoji as the primary icon: lessons/page.tsx:25 `"🧬"`, :31 `"⚗️"`, :38 `"🧠"`, :44 `"📖"`, rendered `text-2xl` inside a 48px gradient tile (138-141). plan/page.tsx:17-19 `lesson: "📖"`, `practice: "📝"`, `review: "🔄"`, rendered at :419, plus `"📋"` at :363. components/Navigation.tsx carries 21 emoji `icon:` entries (27-175, not 18 as reported — ⭐ at :158 was missed), rendered at Navigation.tsx:365 `<span className="text-xl mt-0.5">{item.icon}</span>` and :433 for sub-items. Against this: Sidebar.tsx:25-93 and BottomTabs.tsx:10-126 define every icon as a hand-tuned `<svg strokeWidth="1.6">` / `strokeWidth={1.5}` line glyph, including icons for the same Lessons and Plan destinations.

**Why it matters.** Emoji are rendered by the OS: full-colour, unstyleable, and visually different on iOS vs Android vs Windows — the opposite of the restrained monochrome line set the Sidebar establishes two inches to the left of them. On /pricing, 21 colour emoji sit in the dropdowns of the most conversion-critical page on the public site.

**Fix.** Replace the four section emoji in lessons/page.tsx and the four task-type emoji in plan/page.tsx with stroke SVGs matching Sidebar.tsx's 1.6-weight set (the Practice/Flashcards/Lessons/Plan glyphs already exist there and can be lifted into a shared icon module). Do the same for Navigation.tsx's dropdown items, or drop icons from those menus entirely.

### 8. Brand name drops the T — "Praxis" appears in four public places, including inside the testimonial

**Surface:** both · **File:** `components/MarketingHome.tsx:383` · **Effort:** small

**Evidence.** Verified by grep for /Praxis\b/ excluding Praxist — exactly five hits: components/MarketingHome.tsx:383 "What set Praxis apart wasn't a score guarantee"; app/pricing/page.tsx:190 "The full Praxis experience"; app/pricing/page.tsx:421 "see for yourself what makes Praxis different"; components/Navigation.tsx:160 "Real experiences from real Praxis students"; plus app/dashboard/support/page.tsx:15 "Praxis Prep uses spaced repetition". Canonical name is lib/seo.ts:11 `SITE_NAME = "Praxist Prep"`.

**Why it matters.** The wrong name is printed fourteen lines above the correct one in the same testimonial card (MarketingHome.tsx:397 says "Praxist Prep Student"), and the pricing CTA misnames the company in the last sentence before the buy button. It reads as copy pasted from an earlier brand.

**Fix.** Replace the four public instances with "Praxist"/"Praxist Prep" and fix the dashboard support answer. Import SITE_NAME from lib/seo.ts in prose that names the brand so it cannot drift again.

### 9. Shared dashboard primitives hardcode desktop pixel sizes in inline styles, so no breakpoint can scale them down

**Surface:** dashboard · **File:** `components/dashboard/PraxUI.tsx:364` · **Effort:** medium

**Evidence.** CONFIRMED. PageHeader's h1 carries `style={{ fontFamily: "var(--font-prax-serif)", fontSize: 44, lineHeight: 1.05, ... }}` (line 364) — an inline style, which no Tailwind breakpoint can override. PraxCard's `primary` variant does the same at line 183: `padding: "32px 36px"`. Both values are duplicated inline on the dashboard home at app/dashboard/page.tsx:655 (fontSize 44) and :796 (padding "32px 36px"), with a 38px serif hero at :845. PraxPage's container is `px-6 py-8 lg:px-12 lg:py-10` (PraxUI.tsx:56), so at 375px a primary card has 327px of width and 72px of horizontal padding — 22% of the card is padding, leaving 255px of content. (The original claim of 3-5 line wraps is overstated: a 44px serif title in 327px typically wraps to two lines.)

**Why it matters.** These two primitives back every dashboard page, so the violation is systemic and cannot be corrected per-page because the values are inline rather than utility classes.

**Fix.** PraxUI.tsx:364 — move sizing to classes: `text-[28px] sm:text-[36px] lg:text-[44px]`, removing fontSize from the style object. PraxUI.tsx:183 — `p-6 sm:p-8 lg:px-9 lg:py-8` as a className on the primary variant, dropping `padding`. Then delete the duplicated inline values at app/dashboard/page.tsx:655, 796, 845.

### 10. Weekly goal progress is deleted on mobile rather than relaid out

**Surface:** dashboard · **File:** `app/dashboard/page.tsx:933` · **Effort:** medium

**Evidence.** CONFIRMED with a correction. Line 933 `<div className="text-center pr-3 hidden lg:block">` wraps the 140px weekly-goal ring; `weeklyGoalPct` (line 619) and `weeklyGoalRemaining` (line 623) appear only at lines 950, 968, 994 — all inside that hidden block, so the goal target and percent are invisible below 1024px. Correction to the original finding: mobile users are not blind to the underlying number — the Activity StatCard at line 750 renders `stats.questionsThisWeek` with the hint "Questions this week". What is lost on phones is the goal itself and the progress against it. The same delete-don't-relayout pattern strips the right-hand summary column on two more pages: app/dashboard/flashcards/page.tsx:646 and app/dashboard/practice/page.tsx:748 (both `hidden lg:block` library totals).

**Why it matters.** The weekly question goal is a value the student explicitly sets in Settings, and its only progress feedback is desktop-only — on the device where most study check-ins happen, the goal appears nowhere.

**Fix.** Below lg, render the goal as a compact horizontal bar with "{questionsThisWeek} of {weeklyGoal} · {weeklyGoalRemaining} to go" beneath the hero copy instead of `hidden lg:block`. Apply the same treatment at flashcards/page.tsx:646 and practice/page.tsx:748.

### 11. Analytics is unreachable from the mobile tab bar

**Surface:** dashboard · **File:** `components/dashboard/BottomTabs.tsx:6` · **Effort:** small

**Evidence.** CONFIRMED. The `tabs` array beginning at line 6 contains exactly six entries — Home (line 8), Practice (27), Cards (46), Lessons (71), Plan (90), Account (109). No Analytics. The only other navigation is components/dashboard/Sidebar.tsx, which lists Analytics at line 86 but whose `<aside>` is `hidden lg:flex` (line 161). The sole mobile entry point is the text link at app/dashboard/page.tsx:728-737, styled `fontSize: 11.5`.

**Why it matters.** A whole top-level section of the product is reachable on a phone only via one 11.5px text link on the home screen; a student who navigates away has no path back to it.

**Fix.** Swap a lower-value tab (Lessons or Plan) for Analytics in BottomTabs, promote the "Detailed Analytics" link into a proper tappable card, or add a "More" tab opening a sheet with Analytics and Support.

### 12. Study-plan day selector never scrolls the selected day into view

**Surface:** dashboard · **File:** `app/dashboard/plan/page.tsx:299` · **Effort:** small

**Evidence.** CONFIRMED. Line 299: `<div className="flex gap-2 mb-6 overflow-x-auto pb-2">` holding seven buttons each `min-w-[4rem] px-3 py-2.5` (line 316) — minimum row width 7x64 + 6x8 = 496px against ~327px of usable width, so only about five days are visible. getWeekDates() (lines 22-42) always starts the strip on Monday, while `selectedDay` initialises to today (lines 54-56), and grepping the file shows no `scrollIntoView` anywhere. So from Friday through Sunday the selected day is off-screen on load with nothing indicating it exists.

**Why it matters.** For three days out of seven a phone user opens the study plan and cannot see which day is selected, on the strip that is the primary navigation for the whole page.

**Fix.** Add a `useEffect` that calls `scrollIntoView({ inline: 'center', block: 'nearest' })` on the selected day button when `selectedDay` changes, plus a right-edge gradient fade so the off-screen days are discoverable.

### 13. `--color-prax-red` is undefined; six error call sites silently render a hardcoded #b94a4a while the real `--color-prax-danger` token is dead

**Surface:** dashboard · **File:** `app/dashboard/settings/page.tsx:256` · **Effort:** small

**Evidence.** VERIFIED. app/globals.css:155 defines `--color-prax-danger: #a64432;` and grep finds zero references to it outside globals.css. Six places instead reference an undefined variable with a literal fallback — all with the identical string `var(--color-prax-red, #b94a4a)`: app/dashboard/settings/page.tsx:256 and :321, app/dashboard/flashcards/page.tsx:1118, app/dashboard/support/page.tsx:271, app/dashboard/admin/flashcards/[deckId]/page.tsx:219 and :307.

**Why it matters.** Severity lowered from high: the fallback works, so nothing looks broken. But the rendered error red is #b94a4a, a value that appears in no palette and is not the #a64432 the design system specifies, and it cannot be changed from globals.css. Anyone who later defines `--color-prax-red` shifts six screens at once without knowing.

**Fix.** Replace all six occurrences with `var(--color-prax-danger)` (or the unified `--color-danger` from the semantic-token fix) and drop the inline #b94a4a fallbacks. Add danger to the token doc comment at components/dashboard/PraxUI.tsx:3-17, which currently lists cream/ink/green/gold and omits it.

### 14. Lesson body copy is the smallest type on the widest measure — 14px at ~94 characters per line

**Surface:** dashboard · **File:** `app/dashboard/lessons/[section]/[id]/page.tsx:149` · **Effort:** small

**Evidence.** VERIFIED, every line cite exact. This merges two of the submitted findings because the fixes conflict and must be made together. Lesson prose is `<p key={i} className="text-sm text-gray-700 leading-relaxed">` at line 149, with list items on the same treatment at :125 and :136 and table cells dropping to `text-xs` at :87. The container chain is line 279 `"max-w-3xl mx-auto px-4 sm:px-6 py-6 sm:py-10"` (768px cap minus 48px padding = 720px) wrapping line 310 `"bg-as-surface-container-lowest rounded-2xl border ... p-6 sm:p-8 mb-6"` (minus 64px = 656px of text width). At 14px that is 46.9em, roughly 94 characters per line. Meanwhile the marketing pages selling this content set prose at `text-base md:text-lg` (components/MarketingHome.tsx:182) and `text-lg md:text-xl` (MarketingHome.tsx:341). The same 656px/14px geometry recurs on the pricing FAQ: app/pricing/page.tsx:351 -> :383 -> :403 `"mt-4 text-sm text-gray-600 leading-relaxed"`.

**Why it matters.** The comfortable measure for continuous reading is 45-75 characters; 94 is 25% past the ceiling, past where the eye reliably finds the return sweep. And the hierarchy is inverted against the product: a student reads one marketing paragraph at 18px, then hours of lesson content at 14px — a UI-chrome size, not a long-form reading size. This is what a student pays $199/month to read.

**Fix.** Do both at once, or the wider size makes the measure worse: promote the lesson `<p>`/`<li>` at lines 125, 136 and 149 to `text-base`, lift table cells at :87 to `text-sm`, and cap the reading column with `max-w-[65ch]` on those elements (or narrow line 279 to `max-w-2xl`). Add `max-w-[65ch]` to the FAQ answer at app/pricing/page.tsx:403.

### 15. The dashboard page title spans 24px to 48px across pages, and only two are bold

**Surface:** dashboard · **File:** `app/dashboard/analytics/weekly/page.tsx:347` · **Effort:** small

**Evidence.** VERIFIED — I read every cited line. app/dashboard/practice/session/[id]/page.tsx:451 `"font-headline text-2xl text-as-primary mb-2"`; app/dashboard/plan/page.tsx:232, app/dashboard/lessons/page.tsx:113, app/dashboard/lessons/[section]/page.tsx:100 and app/dashboard/lessons/[section]/[id]/page.tsx:304 all `"font-headline text-2xl sm:text-3xl text-as-primary"`; app/dashboard/flashcards/[deckId]/page.tsx:165 `"font-headline text-3xl sm:text-4xl text-as-primary mb-2"`; app/dashboard/flashcards/[deckId]/study/page.tsx:464 and app/dashboard/flashcards/session/page.tsx:544 `"font-headline text-3xl mb-3"`; app/dashboard/analytics/daily/page.tsx:257 and weekly/page.tsx:347 `"font-headline text-4xl sm:text-5xl font-bold text-as-primary leading-tight"` — the only h1s in the app carrying `font-bold`.

**Why it matters.** A student moving between Lessons, Flashcards and Analytics sees the page title double in size and gain weight for no reason the interface explains — it reads as three products stitched together. Because the size carries no meaning, the title also stops working as the landmark that tells you where you are.

**Fix.** Pick one h1 recipe — `font-headline text-2xl sm:text-3xl text-as-primary` matches the plurality (four pages) — and apply it to the outliers, dropping `font-bold` from the two analytics pages.

### 16. Lesson body text uses `text-gray-700`, which falls through to stock Tailwind cool slate on a warm cream card

**Surface:** dashboard · **File:** `app/dashboard/lessons/[section]/[id]/page.tsx:149` · **Effort:** small

**Evidence.** VERIFIED against the compiled output, not just the source. app/globals.css:103-108 maps only six shades of the gray ramp — 900, 600, 400, 200, 100, 50. I grepped the repo's own built CSS in .next and found the split plainly: `.text-gray-600{color:var(--gray-600)}` (the custom warm `#6B5E52` at globals.css:21) but `.text-gray-700{color:var(--color-gray-700)}`, and `--color-gray-700` resolves to Tailwind's stock `#364153` — a blue-slate. `gray-700` is used for all lesson prose and nowhere else in the codebase: app/dashboard/lessons/[section]/[id]/page.tsx:87 (table cells), :125 (bullets), :136 (numbered items), :149 (paragraphs). Related: app/check-email/page.tsx:61 `text-gray-500`, also outside the overridden ramp. (I dropped the finding's `text-gray-300` cites — app/pricing/page.tsx:313/:334 are em-dashes in a comparison table and app/dashboard/lessons/[section]/page.tsx:166 is an SVG icon, none of them running text.)

**Why it matters.** Every word of lesson content renders in a blue-tinted slate sitting on the warm `--as-surface-container-lowest` cream card. Warm ground plus cool text is the specific combination that makes a page look dirty rather than neutral, and it is inconsistent with the marketing pages one route away that use the warm `--gray-600`. The half-overridden ramp is a trap: `text-gray-600` is on-brand, `text-gray-700` silently is not.

**Fix.** Change the four lesson call sites to `text-as-on-surface-variant`, or add `--color-gray-700` (and 500, 300) to app/globals.css to complete the ramp.

### 17. Support-page form labels are unassociated <div>s, leaving placeholder text as the accessible name

**Surface:** dashboard · **File:** `app/dashboard/support/page.tsx:329` · **Effort:** small

**Evidence.** VERIFIED with the consequence corrected. Line 329 `function Label({ children })` returns a `<div className="text-[11px] font-semibold uppercase mb-1.5">`, not a `<label>`. `Field` (line 297) emits `<div><Label>{label}</Label><input … /></div>` with no `id`/`htmlFor` pairing; the message `<textarea>` at line 254 sits under a bare `<Label>Message</Label>`. CORRECTION: the original claim of 'zero accessible name' is wrong — all three controls carry a `placeholder` ("What's this about?", "you@example.com", "Tell us what you need help with…"), which the accname spec uses as a fallback. The defect is that the visible label is not programmatically associated and the name evaporates once the user types (WCAG 1.3.1 / 3.3.2), not that the fields are nameless. Severity lowered accordingly. app/dashboard/settings/page.tsx line 427 solves the identical problem correctly with `<label className="block">`.

**Why it matters.** The support form is how a paying student reaches a human when something breaks. A screen-reader user hears the placeholder rather than the label, and once they start typing the field has no persistent identification. The same file family solves this two different ways, which is the kind of inconsistency that produces the next bug.

**Fix.** Change `Label` to render `<label htmlFor={...}>`, or simplest: mirror settings/page.tsx and wrap the whole field in `<label className="block">…</label>` so association is implicit. Give the textarea at line 254 a matching id.

### 18. Analytics custom date range: two unlabelled date inputs with the focus ring removed

**Surface:** dashboard · **File:** `app/dashboard/analytics/page.tsx:683` · **Effort:** small

**Evidence.** VERIFIED. Line 683 `<input type="date" value={customFrom} … className="px-3 py-1.5 rounded-full border-0 outline-none cursor-pointer" style={{ fontSize: 10, … }} />` and the identical second input at line 703. Neither has a label, `aria-label`, `id`, or `title`; both use `border-0 outline-none` with no `focus:`/`focus-visible:` replacement; both render at fontSize 10. Unlike the support-form inputs there is no placeholder fallback — `type="date"` does not support one — so these genuinely have no accessible name.

**Why it matters.** A screen reader announces two adjacent date fields separated by an en-dash with no way to tell start from end. A keyboard user Tabbing through the period selector gets no visual focus feedback because `outline-none` strips the browser default and nothing replaces it — they cannot tell which field will receive their typing.

**Fix.** Add `aria-label="Start date"` / `aria-label="End date"`, drop `outline-none` (or add `focus-visible:outline-2 focus-visible:outline-[var(--color-prax-green)]`), and raise the 10px size to at least 12px.

### 19. Question figures have no accessible name — inline SVG lacks role/label, image fallback uses a constant alt

**Surface:** dashboard · **File:** `components/QuestionFigure.tsx:38` · **Effort:** medium

**Evidence.** VERIFIED. Lines 36-41: `<figure className="mb-6">` wrapping `<div className="… [&_svg]:w-full" dangerouslySetInnerHTML={{ __html: sanitizeSvg(svg) }} />` — no `role="img"`, no `aria-label`, no `<figcaption>`, no guarantee of an `<svg><title>`. The URL escape hatch at line 51 uses the constant `alt="Question figure"`. (The original finding's speculation about how AT would traverse the injected SVG is unverifiable here; the missing role/label is factual, so severity is lowered to medium.)

**Why it matters.** These figures carry the data the question is asking about — per the project's own rule, data questions must reason from the data rather than read it back. 'Question figure' tells a blind student nothing, so the question becomes unanswerable rather than merely harder.

**Fix.** Accept a `figureAlt`/`figure_alt` field on the question record and render it as `<figcaption className="sr-only">` plus `role="img" aria-label={...}` on the SVG wrapper. Until that column exists, at minimum add `role="img"` and pass a per-question description instead of the constant string at line 51.

### 20. Exam timer pause/resume button is announced as '▐▐'

**Surface:** dashboard · **File:** `app/dashboard/practice/session/[id]/page.tsx:544` · **Effort:** small

**Evidence.** VERIFIED. Lines 544-550: `<button onClick={() => setTimerRunning(!timerRunning)} className="hover:text-white/80 transition-colors" title={timerRunning ? "Pause timer" : "Resume timer"}>{timerRunning ? "▐▐" : "▶"}</button>`. Because the button has text content, the accessible name comes from that content and the helpful `title` on line 547 is ignored as a name source.

**Why it matters.** A screen reader announces 'button, ▐▐' or reads the glyph as 'black right-pointing triangle'. During a timed full-length exam, the control that stops the clock is the one a student most needs to identify unambiguously. components/flashcards/StudySurface.tsx line 107 does this correctly with `aria-label={starred ? "Unstar card" : "Star card"}`.

**Fix.** Add `aria-label={timerRunning ? "Pause timer" : "Resume timer"}` to the button and wrap the glyph in a `aria-hidden="true"` span.

### 21. Deck status dot conveys three states with no text alternative and a 1.83:1 untouched ring

**Surface:** dashboard · **File:** `app/dashboard/flashcards/page.tsx:1304` · **Effort:** small

**Evidence.** VERIFIED. Line 1304 `function DeckStatusDot({ status }: { status: "untouched" | "in-progress" | "caught-up" })` renders three bare `<div>`s (hollow ring / filled green circle / filled circle with a check) at 14x14 with no `aria-label`, `title`, `role="img"` or `sr-only` text. Called at line 1247 as the first child of the deck `<Link>`, and again at line 874. The untouched ring uses `border: "1.5px solid var(--color-prax-ink-mute)"` at `opacity: 0.55` = 1.83:1 against the cream-card background (recomputed), failing the 3:1 non-text threshold (WCAG 1.4.11).

**Why it matters.** Across a 44+ deck library the dot is the only at-a-glance indicator of untouched / in-progress / caught-up, and it is entirely absent from the link's accessible name. The untouched ring is also barely visible to a sighted low-vision user.

**Fix.** Add `<span className="sr-only">{status === "untouched" ? "Not started" : status === "caught-up" ? "Caught up" : "In progress"}</span>` inside the dot wrapper, and drop the 0.55 opacity on the untouched ring so its outline reaches 3:1.

### 22. Seven distinct loading treatments across the dashboard, from a full-screen takeover to a bare unlabelled spinner to a plain sentence

**Surface:** dashboard · **File:** `components/dashboard/DashboardShell.tsx:82` · **Effort:** medium

**Evidence.** VERIFIED by grep. (1) DashboardShell.tsx:82-88 — full-screen `min-h-screen bg-as-surface`, 8px spinner plus 'Loading your dashboard...'. (2) A copy-pasted `min-h-[60vh]` centred bare spinner with no label, in 11 places (original finding said 9): lessons/page.tsx:105, lessons/[section]/page.tsx:70, lessons/[section]/[id]/page.tsx:272, plan/page.tsx:224, flashcards/[deckId]/page.tsx:129, flashcards/[deckId]/study/page.tsx:416, flashcards/session/page.tsx:470 and :722, analytics/daily/page.tsx:231, analytics/weekly/page.tsx:321. (3) analytics/page.tsx:619-633 — the same spinner but inside `<PraxPage bgVariant="study">`, so background and chrome are present. (4) practice/session/[id]/page.tsx:423-435 — `fixed inset-0 z-[200]` dark overlay, white spinner, 'Loading your exam…'. (5) admin/flashcards/page.tsx:159-162 and admin/flashcards/[deckId]/page.tsx:196 — no spinner, just `<div className="text-[14px]">Loading decks…</div>`. (6) practice/page.tsx:926 and flashcards/page.tsx:820 — inline subtitle text 'Loading library…' inside an otherwise-rendered page. (7) dashboard/page.tsx — none at all (see the separate finding). I dropped app/page.tsx:44 `if (!authChecked) return null;` from this list: the comment at 40-43 documents it as a deliberate anti-flash guard for the ComingSoon/MarketingHome dispatch, i.e. intended behaviour.

**Why it matters.** Loading is the state users see most often on a data-heavy product over mobile networks. The same ~400ms wait is a full-screen takeover on one page, a bare unlabelled spinner floating in 60vh on the next, a sentence on a third, and stale zeros on the home page. It makes the app feel assembled rather than designed.

**Fix.** Add `PraxSpinner` and `PraxPageLoading` (spinner plus label, rendered inside the PraxPage shell so the background and header do not pop in) to components/dashboard/PraxUI.tsx. Replace all 11 `min-h-[60vh]` copies, the two admin text states, and DashboardShell's own block with it.

### 23. Every error message in the Prax-palette pages references `--color-prax-red`, which is not defined; the real `--color-prax-danger` token is used nowhere

**Surface:** dashboard · **File:** `app/globals.css:155` · **Effort:** small

**Evidence.** VERIFIED by grep across app/ and components/. globals.css:155 defines `--color-prax-danger: #a64432;` — zero usages anywhere. Six sites instead reference the non-existent `--color-prax-red` and silently fall back to the literal: settings/page.tsx:256 and :321, support/page.tsx:271, flashcards/page.tsx:1118, admin/flashcards/[deckId]/page.tsx:219 and :307, all `var(--color-prax-red, #b94a4a)`. Three other error styles coexist: login/page.tsx:96 and signup/page.tsx:95 `mb-4 rounded-lg bg-as-error-container border border-as-error/20 px-4 py-3 text-sm text-as-on-error-container` (#ffdad6 fill, #ba1a1a border); analytics/daily/page.tsx:287 and analytics/weekly/page.tsx:375 `bg-red-50 text-red-600 text-sm px-5 py-3 rounded-2xl` (stock Tailwind #fef2f2 / #dc2626); and settings/support's bare small text with no container at all.

**Why it matters.** Four reds in play (#b94a4a, #ba1a1a, #dc2626, and the unused #a64432) and three container treatments. A validation failure on Settings is a small unbordered red sentence; the identical failure on Login is a full bordered alert block. Users learn error styling as a signal, and inconsistent styling means they miss errors. The undefined token also means the intended brand red has never shipped.

**Fix.** Point the six sites at `--color-prax-danger` (or alias `--color-prax-red` to it) so there is one red. Add a `PraxAlert` component to PraxUI.tsx with `tone="error"|"success"` using the login/signup container recipe, and replace the six bare-text sites plus the two `bg-red-50` sites.

### 24. Dashboard pages use five different page containers and three different mobile gutters, so content shifts horizontally as you move between tabs

**Surface:** dashboard · **File:** `app/dashboard/lessons/page.tsx:112` · **Effort:** medium

**Evidence.** VERIFIED by grep. Recipe A (full-bleed, 24px mobile gutter): `px-6 py-8 lg:px-12 lg:py-10` at PraxUI.tsx:56, dashboard/page.tsx:647, practice/page.tsx:460, flashcards/page.tsx:277. Recipe B (16px gutter, 672px cap): `max-w-2xl mx-auto px-4 sm:px-6` at flashcards/[deckId]/page.tsx:147, flashcards/[deckId]/study/page.tsx:461, flashcards/session/page.tsx:539. Recipe C (16px gutter, 768px cap): `max-w-3xl mx-auto px-4 sm:px-6 py-6 sm:py-10` at lessons/page.tsx:112, lessons/[section]/page.tsx:85, lessons/[section]/[id]/page.tsx:279, plan/page.tsx:231. Recipe D (16px gutter, 896px cap, taller rhythm): `max-w-4xl mx-auto px-4 sm:px-6 py-8 sm:py-12` at analytics/daily/page.tsx:238, analytics/weekly/page.tsx:328. Recipe E (20px gutter, flush-left, no centring): `px-5 py-8 lg:px-0 lg:py-0` with `max-w-[680px]` at settings/page.tsx:161, `max-w-[720px]` at support/page.tsx:101, `max-w-[1100px]` at admin/flashcards/page.tsx:120.

**Why it matters.** On a 375px phone the left edge of content jumps between 16px, 20px and 24px as the user moves between bottom tabs — a visible jitter that reads as sloppiness without the user being able to name it. On desktop the same content is variously full-bleed, centred at 672/768/896px, or flush-left at 680/720/1100px.

**Fix.** Standardise on PraxPage plus a `PraxContent maxWidth="reading"|"wide"|"full"` wrapper exposing at most two caps, and fix the mobile gutter at one value (24px, matching PraxPage) everywhere.

### 25. Two competing page-header patterns inside the dashboard: Instrument Serif 44px green vs DM Serif Display 32px near-black, hand-retyped three times

**Surface:** dashboard · **File:** `app/dashboard/settings/page.tsx:174` · **Effort:** small

**Evidence.** VERIFIED. Pattern 1 — `PageHeader` (PraxUI.tsx:343-388): `SmallCaps` eyebrow at `fontSize: 10, letterSpacing: 0.22em` (PraxUI.tsx:80-81), h1 `fontFamily: var(--font-prax-serif)` Instrument Serif, `fontSize: 44`, `color: var(--color-prax-green)` #054f46, italic 16px serif subtitle. Used by practice/page.tsx:461, flashcards/page.tsx:283, analytics/page.tsx:735. Pattern 2 — hand-rolled and copy-pasted three times: settings/page.tsx:162-189 (eyebrow 165, h1 174), support/page.tsx:102-129 (eyebrow 104, h1 113), admin/flashcards/page.tsx:121-148 (eyebrow 123, h1 132). Each is an 11px/0.22em eyebrow — 1px off the shared SmallCaps because it was retyped — then `<h1 className="font-serif mb-2" style={{ fontSize: 32, fontWeight: 500, color: "var(--color-prax-ink)" }}>`, i.e. DM Serif Display (globals.css:157) at 32px in near-black #1a2723, then a non-italic 14px sans description.

**Why it matters.** Two serif families, two sizes, two colours and italic-vs-upright subtitles for exactly the same structural role inside one authenticated product. Settings and Support are ordinary user destinations, not admin-only, so a student moving from Flashcards to Settings sees the page title change face, size and colour.

**Fix.** Extend `PageHeader` with an optional `size="lg"|"sm"` and use it at settings/page.tsx:162, support/page.tsx:102 and admin/flashcards/page.tsx:121, deleting the three hand-rolled blocks. Whatever the size, keep one serif and one colour.

### 26. analytics/daily and analytics/weekly are near-clones with byte-identical helpers, a 40px card radius used nowhere else, and stock Tailwind red/amber/emerald

**Surface:** dashboard · **File:** `app/dashboard/analytics/daily/page.tsx:83` · **Effort:** medium

**Evidence.** VERIFIED by diffing both files. `SectionBar` is byte-identical at daily:83-102 and weekly:120-139, down to `accuracy >= 80 ? "bg-as-primary" : accuracy >= 65 ? "bg-amber-500" : "bg-red-500"`. `parseReportSections` (daily:37, weekly:53), `ReportSection` (daily:55, weekly:92) and `TopicRow` (daily:105, weekly:142) are duplicated too, and TopicRow has already drifted: `py-3` + `w-24` (daily:108, 115) vs `py-3.5` + `w-20` (weekly:145, 155). Both pages use a card radius found nowhere else in the codebase: `rounded-[2.5rem]` = 40px, at 14 sites (daily:291, 356, 375, 411, 428, 460; weekly:379, 452, 510, 529, 589, 608, 630, 663) against PraxCard's 20/16/12px (PraxUI.tsx:182, 190, 196) on the Analytics hub these are reached from. Off-palette stock colours: `bg-emerald-100 text-emerald-700` / `bg-amber-50 text-amber-700` / `bg-red-50 text-red-600` / `bg-red-100 text-red-700` in the STATUS_COLORS map (daily:19-23, weekly:19-23), `border-red-100` and `border-emerald-100` (daily:411, 428; weekly:589, 608), `bg-white/30` (weekly:534, 540, 557).

**Why it matters.** These two pages are one click from the Analytics hub and look like a different app: near-pill 40px cards instead of 12-20px, and a red/amber/emerald semantic set (#dc2626 / #f59e0b / #059669) that clashes with the restrained cream-and-green scheme everywhere else. The duplicated helpers mean every fix must be applied twice, and one has already drifted.

**Fix.** Extract `parseReportSections`, `ReportSection`, `SectionBar` and `TopicRow` into components/dashboard/ReportUI.tsx and import into both pages. Replace `rounded-[2.5rem]` with PraxCard, and map red/amber/emerald onto `--color-prax-danger`, `--color-prax-gold` and `--color-prax-green-soft`.

### 27. The gray-* scale is only half-overridden, so `text-gray-900` and `text-gray-700` on the same page resolve to different colour families

**Surface:** dashboard · **File:** `app/dashboard/lessons/[section]/[id]/page.tsx:149` · **Effort:** small

**Evidence.** VERIFIED. globals.css:20-25 overrides only `--gray-900: #2E2520`, `--gray-600: #6B5E52`, `--gray-400: #9C8E82`, `--gray-200: #E8DFD4`, `--gray-100`, `--gray-50` — warm browns from the legacy marketing palette, re-exported at :103-108. `gray-300`, `gray-500`, `gray-700` and `gray-800` are not overridden; Tailwind 4's `@theme inline` merges rather than replaces, so those steps fall through to the stock cool grays (gray-700 = #364153, a blue-tinted slate). Every prose element in the lesson renderer uses that fall-through: paragraphs at lessons/[section]/[id]/page.tsx:149 (original finding cited 147), bullets at :125, numbered items at :136, table cells at :87 — cool #364153 body text on the warm `--as-surface` #fcfae9, with headings on the same page in `--as-primary` green. plan/page.tsx mixes both families inside one form: `text-gray-900` (warm #2E2520) on labels at :250, :257, :265 and `border-gray-300` (cool #d1d5db) on the day-selector at :321 and the task checkboxes at :379. Also lessons/[section]/page.tsx:166 `text-gray-300`. I recomputed contrast: #364153 on #fcfae9 is 9.5:1, so this is a hue-consistency defect, not a legibility one.

**Why it matters.** 'gray' is not one scale in this codebase — it is a warm brown scale with cool holes in it, and nothing in the class name signals which you get. The Study Plan's checkbox borders sit visibly cooler than the labels above them, and the lesson reader — the longest-read text in the product — renders thousands of words of blue-slate body copy on warm cream while every other reading surface uses a warm or green-tinted ink (`--as-on-surface` #1c1c13, `--color-prax-ink-soft` #4a5d56).

**Fix.** Ban `gray-*` inside app/dashboard/** — replace with `--as-*` or `--color-prax-*` tokens (lessons body copy -> `text-as-on-surface/80`). If the legacy scale must stay for marketing, either complete it (define 300/500/700/800) or add `--color-gray-*: initial` so unfilled steps fail loudly instead of silently going cool.

### 28. Marketing tap targets are 14-20px tall, well under the 44px minimum

**Surface:** marketing · **File:** `components/MarketingHome.tsx:547` · **Effort:** small

**Evidence.** CONFIRMED. MarketingHome footer links (lines 547-577) are `text-[9px] font-label uppercase tracking-widest` with no padding — line-box height ~14px. The hero secondary link "Explore Curriculum" (lines 194-198) is `text-[10px]` with no padding, ~15px tall. On /pricing, the FAQ `<summary>` at app/pricing/page.tsx:385 is the only toggle-able region and is ~20px tall (the surrounding `py-5` at line 383 is on `<details>`, so tapping the padding does not toggle), and the footer links at app/pricing/page.tsx:467-491 are `block text-sm` in `space-y-2.5`, ~20px tall. ComingSoon's "Sign in →" pill (components/ComingSoon.tsx:143-158, inline `padding: "6px 12px"`, `fontSize: 10`) is ~29px tall. The original finding also cited the /pricing hamburger; that one measures 40x40 (`p-2` around `h-6 w-6`, Navigation.tsx:305-307) and is close enough to standard that I dropped it.

**Why it matters.** Apple and Android both specify ~44px minimums; a 14px-tall link is missed often enough on a phone that the site reads as broken rather than the tap as imprecise.

**Fix.** Add vertical padding without changing type size: `py-3 -my-3` on the MarketingHome footer links and hero secondary link, `py-2` on the pricing FAQ summary, `py-2.5` on the pricing footer links, and bump ComingSoon's pill padding to `10px 14px`.

### 29. Coming-soon email input is 15px, which triggers iOS Safari auto-zoom on focus

**Surface:** marketing · **File:** `components/ComingSoon.tsx:224` · **Effort:** small

**Evidence.** CONFIRMED. The waitlist input's inline style block (lines 219-226) sets `fontSize: 15`. iOS Safari zooms the viewport whenever a focused input computes below 16px, and app/layout.tsx sets no `maximum-scale` to suppress it. The signup and login inputs use Tailwind defaults and compute to 16px, so they are unaffected — this is the outlier.

**Why it matters.** This is the single conversion action on the page the public currently sees in preview mode (app/page.tsx renders ComingSoon for unauthenticated visitors). Tapping the field jerks the page into a zoomed state the visitor must pinch back out of.

**Fix.** Line 224: `fontSize: 16`. Do not add `maximum-scale=1` to the viewport meta — that breaks pinch-zoom accessibility.

### 30. Password-visibility toggle is a 20x20px tap target on login and signup

**Surface:** marketing · **File:** `app/signup/page.tsx:183` · **Effort:** small

**Evidence.** CONFIRMED. The button opens at line 183 with `className="absolute right-4 top-1/2 -translate-y-1/2 text-as-secondary/60 ..."` (line 186) and no padding of its own; its only content is a `w-5 h-5` svg, so the hit area is 20x20px next to an input that is ~52px tall (`px-4 py-3.5`, line 181). Identical markup at app/login/page.tsx:170-176.

**Why it matters.** Show/hide password is the main recovery move when a mobile keyboard mistypes a password, and a 20px target beside a 52px field is missed often enough to cause failed sign-ins on the two highest-intent pages.

**Fix.** Add `p-3 -m-3` (or `w-11 h-11 grid place-items-center`) to the button in both files, keeping the icon at `w-5 h-5`, and change `right-4` to `right-1` to compensate.

### 31. Marketing cards start at desktop padding, leaving ~211px of content at 375px

**Surface:** marketing · **File:** `components/MarketingHome.tsx:413` · **Effort:** small

**Evidence.** CONFIRMED. Line 413: `p-12 md:p-16` with `min-h-[450px] md:min-h-[500px]` — the padding scale has no base step below 48px, so `p-12` applies at 375px. Section container is `px-8` (line 410), so the card is 311px wide and 96px of that is horizontal padding → 215px of content. Its h3 (line 418) is `font-headline text-4xl italic` with no smaller base, i.e. 36px serif in a 215px column. The testimonial card at line 377 is likewise `p-12 md:p-16`; the three feature cards at lines 267, 296 and 311 are `p-10` with no base step.

**Why it matters.** "Generous whitespace" designed at desktop becomes a squeezed ~215px text column on a phone, shattering headline copy into ragged lines and undercutting the premium feel.

**Fix.** Add a base step: `p-6 sm:p-10 md:p-16` on lines 377 and 413, `p-6 sm:p-10` on lines 267/296/311, and `text-2xl sm:text-3xl md:text-4xl` on the h3 at line 418.

### 32. Hero headline wraps to three lines and splits the italic accent phrase

**Surface:** marketing · **File:** `components/MarketingHome.tsx:175` · **Effort:** small

**Evidence.** CONFIRMED. Line 175: `font-headline text-5xl md:text-6xl lg:text-[5.5rem] leading-[0.95] ...` — the base step is `text-5xl` (48px), applied at 375px. The markup intends two lines via the explicit `<br />` at line 177 ("Learn. Apply." / italic "Master the MCAT."), but at 48px serif the 16-character italic phrase needs roughly 370px against the 311px available inside the hero's `px-8` container (line 170), so it breaks to "Master the / MCAT." and the lockup becomes three lines.

**Why it matters.** The designed two-line lockup becomes a three-line stack with the accent phrase broken mid-thought, which reads as an accident rather than typography — in the first viewport of the homepage.

**Fix.** Line 175: `text-[2.25rem] sm:text-5xl md:text-6xl lg:text-[5.5rem]` so the italic line fits on one line at 375px.

### 33. Signup name row is a hard two-column grid at every width

**Surface:** marketing · **File:** `app/signup/page.tsx:102` · **Effort:** medium

**Evidence.** CONFIRMED. Line 102: `<div className="grid grid-cols-2 gap-4">` with no `grid-cols-1 sm:` base. At 375px the page wrapper is `p-4` (line 58) around a `max-w-md` main, so each cell is ~131px; the inputs carry `px-4` and `border-2`, leaving roughly 95px of visible text at 16px. The correct pattern already exists in this codebase — app/dashboard/settings/page.tsx uses `grid-cols-1 sm:grid-cols-2` at lines 204, 218, 233 and 289.

**Why it matters.** Most real surnames exceed ~10 characters at 16px and scroll out of view while being typed, on the form that gates every new account.

**Fix.** Line 102: `grid grid-cols-1 sm:grid-cols-2 gap-4`, matching the settings-page convention.

### 34. The pricing comparison table renders the identical "included" checkmark in sage green for one plan and coral for the other

**Surface:** marketing · **File:** `app/pricing/page.tsx:321` · **Effort:** small

**Evidence.** VERIFIED, and narrowed. In one table body the Essentials cell draws its check as `className="w-4 h-4 text-sage mx-auto"` (app/pricing/page.tsx:300, --sage #8FAF9F) and the Complete cell draws the same check for the same `row.comp === true` boolean as `className="w-4 h-4 text-coral mx-auto"` (line 321, --coral #B8704A). Both cells sit on light backgrounds — the Complete column is `bg-navy/5` (line 318), a 5% tint, not a dark card — so there is no contrast justification for the hue change. The not-included dash is `text-gray-300` in both (313, 334). I dropped the original claim that lines 156 and 225 are a third split: line 156's sage check is on white but line 225's gold check is inside the `bg-navy` featured card (line 176), so that pair is legitimate on-dark adaptation. --sage is used in exactly two places, both in this file.

**Why it matters.** Color is carrying meaning in this table — green reads as yes — and switching it to terracotta in the adjacent column implies the two checkmarks mean different things when they encode the identical boolean. On the pricing comparison, ambiguity about what each tier includes is directly costly.

**Fix.** Use one affirmative color for both checkmark sites (lines 300 and 321) — the `--color-success` token from the semantic-token fix, or `text-as-primary` under the AS reconciliation. If the Complete column needs visual emphasis, get it from the `bg-navy/5` cell tint that is already there, not from the glyph hue. Retire --sage (globals.css:14) once both sites are converted.

### 35. Heading levels skip and invert on the homepage — seven h4s and an h5 appear before the first h3

**Surface:** marketing · **File:** `components/MarketingHome.tsx:274` · **Effort:** small

**Evidence.** VERIFIED by grepping every heading tag in document order: h1 at 175, h2 at 236, h4 at 274, 303 and 318 (`"font-headline text-2xl text-as-primary italic"`), h2 at 338, h4 at 350, 356, 362 and 368, h5 at 393 (`"font-label font-bold text-sm text-as-primary uppercase tracking-widest"`), and only then the first h3 at 418 (followed by 443, 460) and a final h2 at 523. Seven h4s and one h5 are emitted before any h3 exists.

**Why it matters.** The outline a screen reader builds announces level-4 and level-5 headings nested under a level-2 with nothing in between, so a user navigating by heading cannot tell which cards belong to which section. It also means the levels carry no styling meaning — an h4 here is just 'the 24px italic one' — so there is no heading system to inherit.

**Fix.** Renumber to the visual hierarchy: the card titles at 274, 303, 318 and the stat words at 350-368 become h3, and the testimonial attribution at 393 becomes a plain `<p>` or `<cite>` since it is not a section heading at all.

### 36. /check-email drops out of the signup flow's type system mid-flow

**Surface:** marketing · **File:** `app/check-email/page.tsx:53` · **Effort:** small

**Evidence.** VERIFIED including the navigation link. app/signup/page.tsx:40 is `router.push("/check-email")`, so this is the very next screen after account creation. Signup sets its wordmark at :76 `"font-headline italic text-[44px] leading-[44px] text-white drop-shadow-md"` and its h1 at :85 `"font-headline italic text-4xl text-as-primary mb-3"` — Newsreader, italic, Academic Sanctuary tokens. check-email sets its wordmark at :29 `"text-[32px] leading-9 font-serif text-navy"` and its h1 at :53 `"font-serif text-2xl text-navy mb-3"` — DM Serif Display, roman, legacy palette, on `bg-white`/`bg-sand` cards. Different family, different style, 44px->32px and 36px->24px, in one navigation step.

**Why it matters.** This is the highest-anxiety moment in the funnel: the user has just handed over an email and password and is waiting to be told it worked. Landing on a page that looks like it belongs to a different company is exactly when a new user wonders whether something went wrong. It is also the last page before they leave for their inbox.

**Fix.** Restyle app/check-email/page.tsx to match app/signup/page.tsx — the same wordmark component, `font-headline` h1 on `text-as-primary`, and Academic Sanctuary surface tokens instead of `cream`/`navy`/`gray-*`.

### 37. Marketing mega-menu triggers do nothing on keyboard — dropdown opens on hover only

**Surface:** marketing · **File:** `components/Navigation.tsx:248` · **Effort:** small

**Evidence.** VERIFIED with impact corrected. The three dropdown triggers at line 248 are `<button className={...}>` with no onClick, onKeyDown or onFocus; the only opener is the wrapper `<div onMouseEnter={() => handleMouseEnter(item.key)} onMouseLeave={handleMouseLeave}>` at lines 243-247, so `activeDropdown` is only ever set by a pointer. No `aria-expanded`, `aria-haspopup` or `aria-controls`. CORRECTIONS: (a) Navigation.tsx is imported only by app/pricing/page.tsx line 2 — it is not the homepage nav; (b) every one of the 15 submenu items in `menuData` (lines 21-200) has `href: "#"`, i.e. they are dead placeholders, so no real destination is lost. The defect is that Tab+Enter on 'Courses'/'Resources'/'About' produces no response at all (WCAG 2.1.1, 4.1.2), not that content is unreachable. Severity lowered from 'broken' accordingly.

**Why it matters.** A keyboard or screen-reader user on /pricing focuses three buttons that announce no state and do nothing when activated. It also means the mega menu can never be QA'd or made functional by keyboard once the placeholder hrefs are filled in.

**Fix.** Add `onClick={() => setActiveDropdown(activeDropdown === item.key ? null : item.key)}` and `aria-expanded={activeDropdown === item.key}` / `aria-haspopup="true"` to the button at line 248, keep the hover handlers as a pointer enhancement, and close on Escape. The mobile menu at line 389 already uses onClick correctly — mirror that pattern.

### 38. Heading levels skip from h2 to h4 across the homepage and pricing page

**Surface:** marketing · **File:** `components/MarketingHome.tsx:274` · **Effort:** small

**Evidence.** VERIFIED. MarketingHome.tsx: `<h1>` at 175, `<h2>` at 236, then `<h4>` at 274, 303, 318 — h3 skipped. After the `<h2>` at 338 come `<h4>` at 350, 356, 362, 368 and `<h5>` at 393; an `<h3>` first appears at 418, out of order relative to the h4s above it. app/pricing/page.tsx repeats it: `<h2>` at 416, then `<h4>` at 463, 474, 484 with no intervening h3.

**Why it matters.** Screen-reader users navigate long marketing pages by heading level (the H key in NVDA/JAWS). Skipped and out-of-order levels make the outline read as though content is missing between sections, and the three feature cards appear nested two levels below their actual parent. WCAG 1.3.1.

**Fix.** Promote the card headings at 274/303/318 and 350/356/362/368 to `<h3>`, re-order the `<h3>` at 418, and change the pricing footer column headings at 463/474/484 to `<h3>`. Pure tag change — the visual sizes come from utility classes and stay identical.

### 39. Two entirely separate site navigations: the 488-line Navigation.tsx is used only by /pricing, and the homepage hand-rolls its own with different links and a different CTA label

**Surface:** marketing · **File:** `components/Navigation.tsx:185` · **Effort:** medium

**Evidence.** VERIFIED. Grep for `Navigation` shows exactly one consumer: app/pricing/page.tsx:2 (import) and :91 (render). components/MarketingHome.tsx:92-148 defines its own `<nav>` inline. They disagree on nearly everything: links are Courses / Resources / About / Pricing / FAQ (Navigation.tsx:215-217 and dropdowns) vs Curriculum / QBank / Analytics / Pricing (MarketingHome.tsx:108-131); the primary CTA is 'Start Free Trial' in `bg-coral` -> /signup (Navigation.tsx:296-301) vs 'Create an Account' in `bg-as-primary-container` -> /signup (MarketingHome.tsx:140-145); the secondary is 'Log In' with `border-2 border-navy` vs 'Sign In' with `border-2 border-as-surface-bright/30`; the header is `sticky ... h-[68px]` cream with a bottom border vs `fixed ... bg-transparent py-6` in a `grid grid-cols-3`. app/check-email/page.tsx:20-32 is a third hand-rolled header. The already-confirmed 375px overlap has its mechanism here: MarketingHome.tsx:96 `max-w-screen-2xl mx-auto px-8 grid grid-cols-3` gives each column (375-64)/3 = 104px, so the 32px wordmark overflows its column and the `justify-self-end` CTA cannot clear it.

**Why it matters.** The site's navigation changes structure, colour and even the name of its primary action between the homepage and the pricing page. A visitor who clicked 'Create an Account' on the homepage and browses to Pricing is offered 'Start Free Trial' — different words, colour and shape for the same destination — which reads as two different companies' pages stitched together.

**Fix.** Pick one nav. Either port MarketingHome onto Navigation.tsx with a `transparent`/`solid` variant prop (it carries the mega-menus), or delete Navigation.tsx and extract MarketingHome's nav into components/MarketingNav.tsx for the pricing page. Reconcile the link set and settle on one CTA label. Replace `grid grid-cols-3` at MarketingHome.tsx:96 with `flex items-center justify-between` plus an `lg:` guard on the centre links.

### 40. Homepage runs a named student testimonial and "Our students tell us" social proof while the site's default mode is a pre-launch waitlist

**Surface:** marketing · **File:** `components/MarketingHome.tsx:382` · **Effort:** medium

**Evidence.** Verified as written. components/MarketingHome.tsx:382-398 presents a quoted testimonial attributed to "Sarah M." with an "SM" initials avatar and the role "Praxist Prep Student", describing someone who "actually picked up the phone" — no phone-support channel exists in the product (support is messaging per app/pricing/page.tsx:370). Lines 343-345 assert "Our students tell us the difference isn't just the material." Meanwhile lib/launch-mode.ts:29 defaults to "preview" when NEXT_PUBLIC_LAUNCH_MODE is unset (it is unset in .env.local), and app/page.tsx:51 then renders ComingSoon, whose H1 at components/ComingSoon.tsx:185 is "Still preparing your individualized MCAT prep course." app/pricing/page.tsx:177-180 also stamps "Most Popular" on the $199 tier. I cannot verify from code whether the quote is real; what is verifiable is that the site is in pre-launch mode and the quoted service (phone support) is not one the product offers.

**Why it matters.** A product still behind a waitlist gate cannot have a most-popular plan or students describing phone calls it does not make. Most visitors will have seen the waitlist page first, so the mismatch is available to them, and the brand's own pillar at :362-365 is "Honest — Real talk, no empty promises."

**Fix.** Substitute a real, attributable quote (beta testers count, with their words and consent) that describes a channel that exists, or replace the card with a founder's-note panel until real quotes exist. Drop "Most Popular" from app/pricing/page.tsx:177-181 until usage data supports it.

### 41. Hero copy promises an outcome: "the support to score higher"

**Surface:** marketing · **File:** `components/MarketingHome.tsx:183` · **Effort:** small

**Evidence.** Verified. components/MarketingHome.tsx:182-186: "Built by someone who's been through it. Praxist Prep gives you the strategies, structure, and support to score higher — without the burnout." The construction states the score increase as the delivered result of buying. Severity lowered from high: this is not a guarantee of a specific score or point increase (the letter of the CLAUDE.md ban), but it does promise an outcome that depends on the student's performance.

**Why it matters.** It is the first sentence of body copy on the page, and it undercuts the site's own positioning: the testimonial at :383 sells "What set Praxis apart wasn't a score guarantee," and the value pillar at :362-365 is "Honest — Real talk, no empty promises."

**Fix.** Promise the process, not the result — e.g. "…gives you the strategies, structure, and support to study like someone who knows the exam — without the burnout."

### 42. Homepage feature image is an AI-tool placeholder hotlinked from Google's CDN, with placeholder alt text

**Surface:** marketing · **File:** `components/MarketingHome.tsx:257` · **Effort:** small

**Evidence.** Verified. components/MarketingHome.tsx:256-261 renders a plain `<img alt="Abstract neural visualization" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAGngQhgmBhwkLsbCvjf9z8jAoUbJ3wrFLs0bRr83m_...">`. `grep -rn 'src="https://' app components` returns this as the only remote image on the site; every other asset is local (/hero-video.mp4, /logo-white.png, /coming-soon-hero.jpg). I re-checked the URL: HTTP 200, content-type image/png. It bypasses next/image entirely (no width/height, no optimization) unlike app/pricing/page.tsx:447 which uses `<Image>`. Severity lowered from high — the asset currently resolves, so this is a live dependency risk plus an a11y/perf defect, not a present breakage.

**Why it matters.** The largest visual in the homepage's first content section depends on a third-party design-tool export that can expire without warning; when it does, the flagship "Structure designed for your cognitive journey" section renders a broken-image box in production. The alt text is generic placeholder wording.

**Fix.** Download or commission the asset, commit it to /public, serve through next/image with explicit width/height, and write alt text describing the actual subject.

### 43. Question-bank access is described three different ways across the pricing page

**Surface:** marketing · **File:** `app/pricing/page.tsx:213` · **Effort:** small

**Evidence.** Verified. Essentials card lists "Thousands of practice questions" (:145); the Complete card, under the header "Everything in Essentials, plus" (:208), lists "Complete question bank access" (:213), implying Essentials is partial; the comparison table gives "Practice questions" a plain checkmark for both tiers (:278); and the page metadata at :10 calls the $79 tier "unlimited questions."

**Why it matters.** Listing "Complete question bank access" under "Everything in Essentials, plus" tells the reader the cheaper tier is gated, while the table two sections later says both tiers get the same thing. Whichever is true, one of these is costing a sale.

**Fix.** State the same fact in all three places. If both tiers get the full bank, delete :213 from the Complete list; if Essentials is capped, put the cap in both the card and the table.

### 44. Nav labels "Curriculum" and "QBank" jump to sections that contain neither

**Surface:** marketing · **File:** `components/MarketingHome.tsx:110` · **Effort:** medium

**Evidence.** Verified. "Curriculum" → href="#features" (components/MarketingHome.tsx:108-113) lands on `<section id="features">` at :219, whose heading is "Structure designed for your cognitive journey" and whose three cards are Expert Data, Empathetic Assessment, Mindful Milestones — no subject list, no chapter list. "QBank" → href="#services" (:114-119) lands on `<section id="services">` at :409, which holds the mentorship panel, "Essential focus, no fluff," and the analytics panel; the phrase "question bank" appears nowhere in it. The hero's "Explore Curriculum" link (:194-198) points at the same anchor, and the footer repeats both at :549 and :557.

**Why it matters.** The two nav items a serious MCAT shopper clicks first — what do you teach, how many questions do you have — scroll to abstractions and answer neither, while the product's actual large question bank is never mentioned on the homepage.

**Fix.** Either add real Curriculum and QBank sections (subject coverage, question counts, a sample question) and point the anchors there, or rename the nav items to match what the sections say. The bank's scale is a substantiable proof point currently going unused.

### 45. The two public pages render entirely different navigations, with different wordmark treatment and different primary CTA labels

**Surface:** marketing · **File:** `components/MarketingHome.tsx:144` · **Effort:** medium

**Evidence.** Verified. The homepage nav (components/MarketingHome.tsx:107-145) shows Curriculum / QBank / Analytics / Pricing with "Sign In" + "Create an Account", a transparent fixed bar and a 32px sans wordmark (:103). /pricing renders components/Navigation.tsx:215-301: Courses / Resources / About / Pricing / FAQ with "Log In" + "Start Free Trial", a sticky cream bar and a 32px serif wordmark (:237). Every one of these targets /signup: "Create an Account" (:144), "Begin Your Journey" (:192), "Connect with a Mentor" (:432), "Explore Your Performance Data" (:474), "Start Your Story" (:532), "Get Started" (app/pricing/page.tsx:136), "Start Your Free Trial" (:203, :428), "Start Free Trial" (Navigation.tsx:300, :479).

**Why it matters.** A visitor moving from the homepage to Pricing sees the navigation, wordmark treatment, and both button labels change — it reads as two companies' sites stitched together, and it makes the primary action ambiguous (is "Create an Account" the same thing as "Start Free Trial"?).

**Fix.** Have /pricing render the same navigation component as the homepage, and settle on one primary and one secondary label sitewide (e.g. "Create an Account" / "Sign In").

### 46. Invented "82% Growth Velocity" metric presented beside dashboard copy

**Surface:** marketing · **File:** `components/MarketingHome.tsx:508` · **Effort:** small

**Evidence.** Verified. components/MarketingHome.tsx:480-512 draws a progress ring with hardcoded `strokeDasharray="502"` / `strokeDashoffset="90"` and a literal `<span className="font-headline text-5xl text-as-primary">82%</span>` over the caption "Growth Velocity". `grep -rni "growth velocity" app components` returns only this one line — the metric does not exist in app/dashboard/analytics/ or anywhere else in the product.

**Why it matters.** It sits directly beside "Data should inspire confidence, not anxiety. Our dashboard provides a human-readable look at your growth" (:463-467), so a reader reasonably takes 82% as a real dashboard reading, and it names a metric the dashboard does not have. Trivially disprovable once a user signs in.

**Fix.** Label it unambiguously as an illustration, or replace the ring with a real anonymized screenshot of the analytics page. If a growth metric is real, name it exactly as the dashboard names it.

### 47. Homepage footer copyright is hardcoded to 2025 while every other footer renders the current year

**Surface:** marketing · **File:** `components/MarketingHome.tsx:581` · **Effort:** small

**Evidence.** Verified. components/MarketingHome.tsx:580-582 is the literal `&copy; 2025 Praxist Prep. All rights reserved.` components/ComingSoon.tsx:309 renders `© {new Date().getFullYear()} Praxist Prep` and app/pricing/page.tsx:497 renders `&copy; {new Date().getFullYear()} Praxist Prep.` Today is 2026-08-13, so the waitlist and pricing footers say 2026 and the homepage says 2025. Severity lowered from high — real and verified, but small blast radius.

**Why it matters.** A visitor who lands on the waitlist page (2026), gets past the gate to the marketing home (2025), then clicks Pricing (2026) watches the site's own date change. A stale copyright year is the classic signal of an abandoned site.

**Fix.** Replace the literal with `{new Date().getFullYear()}`, or hoist a shared `<SiteFooter>` so the year lives in one place.

### 48. Billing promises (prorated upgrades, cancellation windows) published with no billing system behind them

**Surface:** marketing · **File:** `app/pricing/page.tsx:362` · **Effort:** small

**Evidence.** Verified. app/pricing/page.tsx:362 "You can upgrade from Essentials to Complete at any time. The difference is prorated so you only pay for what you use." :247 "All plans billed monthly. Cancel anytime — no questions asked." :378 "Cancel anytime, no questions asked. Your access continues through the end of your current billing period." :105 "No hidden fees, no long-term contracts — cancel anytime." `grep -rni stripe app components lib` returns nothing, and app/dashboard/settings/page.tsx has no billing surface.

**Why it matters.** These are specific contractual commitments about proration and cancellation windows published before any system exists to honor them; whatever billing eventually does will have to match four sentences already in public.

**Fix.** Trim to what is certainly true ("monthly, cancel anytime") and drop the proration mechanics from the FAQ until the implementation defines them. Revisit all four strings the day billing lands.


## POLISH (21)

### 1. Fourteen tokens are declared and never used, and `--as-inverse-primary` has no @theme mapping so no utility for it can exist

**Surface:** both · **File:** `app/globals.css:54` · **Effort:** small

**Evidence.** VERIFIED by grepping every .tsx for each token. `--as-inverse-primary: #94d2c6;` is declared at app/globals.css:54, but the `@theme inline` block maps --color-as-inverse-surface (135) and --color-as-inverse-on-surface (136) and then jumps straight to --color-as-error (137) — there is no --color-as-inverse-primary, so no utility can be generated for it. Zero-use tokens confirmed at 0 hits each across app/ and components/: legacy --scarlet (7), --scarlet-dark (8), --plum (18), --warm-brown (19), --gray-50 (25); AS --as-on-primary-container (31), --as-secondary-container (33), --as-on-secondary-container (34), --as-surface-dim (38), --as-surface-variant (44), --as-inverse-surface (52), --as-inverse-on-surface (53), --as-inverse-primary (54); prax --color-prax-danger (155).

**Why it matters.** Severity lowered from medium: nothing renders wrong. But fourteen dead entries make the palette file unusable as a source of truth — a contributor cannot tell which of the ~60 tokens are real, and --as-on-primary-container sitting next to the actually-used --as-primary-fixed invites picking the wrong one. CLAUDE.md's "deep brand color used sparingly" is nominally --scarlet #BB0000, which has never rendered anywhere.

**Fix.** Delete the fourteen declarations and their @theme mappings, or move the Material-reserved AS roles behind a labelled `/* reserved, unused */` block. Add `--color-as-inverse-primary: var(--as-inverse-primary);` at globals.css:137 if the token is meant to survive, otherwise delete line 54 too. Keep the :root and @theme blocks in the same order so a missing mapping is visible by eye.

### 2. Nine hex values are declared under two or three token names, including two creams and two greens one to three units apart

**Surface:** both · **File:** `app/globals.css:142` · **Effort:** medium

**Evidence.** VERIFIED against the file. Exact duplicates: #FAF7F2 is --background (5), --cream (16) and --gray-50 (25); #F0E8DC is --sand (15) and --gray-100 (24); #2E2520 is --foreground (6) and --gray-900 (20); #fcfae9 is --as-surface (36) and --as-surface-bright (37); #e5e3d3 is --as-surface-container-highest (43) and --as-surface-variant (44). Near-duplicates across palettes: --color-prax-cream #f6f4e3 (142) vs --as-surface-container-low #f6f4e4 (40); --color-prax-green #054f46 (149) vs --as-primary-container #034f46 (29); --color-prax-green-deep #033830 (150) vs --as-primary #003630 (28). Both greens are re-expressed a third time as rgb literals: rgba(3,56,48,…) in components/dashboard/PraxUI.tsx and FlashcardsBg.tsx, and rgba(0,54,48,…) at globals.css:220 and :252, components/flashcards/StudySurface.tsx and ~25 places in components/dashboard/MolecularBg.tsx.

**Why it matters.** Severity lowered from medium: no pixel is wrong today. The consequence is structural — #f6f4e3 next to #f6f4e4 is invisible, which is exactly why the two design systems could grow to ~500 call sites without anyone noticing they were separate. Darkening the brand green today means editing two tokens plus roughly thirty rgb literals across five files, and missing one leaves a stale patch.

**Fix.** Collapse the exact duplicates to one declaration with the rest as var() aliases (`--cream: var(--background)`, `--gray-50: var(--background)`, `--as-surface-bright: var(--as-surface)`, `--as-surface-variant: var(--as-surface-container-highest)`). Alias the cross-palette near-duplicates per the dashboard reconciliation. Replace the rgb literals with `color-mix(in srgb, var(--as-primary) 18%, transparent)` so shadows and overlays track the token.

### 3. One-off colors that match no token, including cool grays inside shared question and flashcard content

**Surface:** both · **File:** `components/MathText.tsx:161` · **Effort:** small

**Evidence.** VERIFIED; primary anchor moved from pricing to MathText, which is the higher-traffic instance. components/MathText.tsx:161 renders table headers as `border border-[#bbb] bg-[#f3f4f6] px-3 py-1.5 font-semibold text-[#333]` and :176 renders cells as `border border-[#d5d5d5] … text-[#333]` — #f3f4f6 is a cool neutral, and none of these four values exist in globals.css. components/QuestionFigure.tsx:38 and :52 hardcode `border-[#ddd]` on figure containers. On the marketing side, app/pricing/page.tsx:97 uses `bg-[#FDF0EB] border border-[#F5C8BA]`, tints of --coral that exist nowhere in globals.css, and :414 uses `bg-[radial-gradient(circle,rgba(242,190,106,0.12)_0%,transparent_70%)]` — #F2BE6A, which matches neither --gold #C8994B nor --amber #D4A84B nor --color-prax-gold #b88746, making it a fourth gold.

**Why it matters.** None of these can be found from the palette file, so each survives any future rebrand untouched. The MathText and QuestionFigure ones are the most durable because they render inside every practice question and flashcard — a cool #f3f4f6 table header and #bbb borders sit in the middle of warm cream content on the most-viewed screens in the product, and they render identically on both the AS and prax surfaces regardless of which palette wins.

**Fix.** In components/MathText.tsx:161,176 and components/QuestionFigure.tsx:38,52 replace the neutrals with `var(--as-outline-variant)` for borders, `var(--as-surface-container)` for the header fill and `var(--as-on-surface)` for text, so shared content inherits the surviving palette. Add container/tint tokens for the marketing accent rather than inlining at pricing/page.tsx:97, and reduce the line 414 glow to `color-mix(in srgb, var(--color-prax-gold) 12%, transparent)`.

### 4. Seven font families load on every route; Fraunces serves only a decorative background and has no utility class

**Surface:** both · **File:** `app/layout.tsx:35` · **Effort:** medium

**Evidence.** VERIFIED. app/layout.tsx:14-51 loads DM Serif Display, Inter, Newsreader, Manrope, Fraunces, Instrument Serif and Be Vietnam Pro, and app/layout.tsx:146 attaches all seven `.variable` classes to `<html>` on every route. Fraunces is loaded at app/layout.tsx:35 with `weight: ["400","500"]` and `style: ["normal","italic"]` (four files), but `grep -n fraunces app/globals.css` returns nothing — `--font-fraunces` is never mapped into the `@theme inline` block, so no `font-*` utility exists for it. Its only consumers are raw `fontFamily="var(--font-fraunces), Fraunces, serif"` attributes on decorative SVG glyphs in components/dashboard/MolecularBg.tsx (lines 681, 691, 700, 710, 746, 755, 765, 774, 784, 793, 803, 812).

**Why it matters.** CLAUDE.md calls for a restrained palette and a serif-headings/sans-body pairing. Seven families is the opposite, and three of them (DM Serif, Newsreader, Instrument Serif) are competing serifs doing the same job on different surfaces — the root cause of the wordmark inconsistency above. Four Fraunces files declared at the root layout also means they are preloaded on routes that never paint a Fraunces glyph.

**Fix.** Subset the loaders to the two families each surface actually needs, and move Fraunces (and any other decoration-only face) into the route segment that uses it rather than the root layout.

### 5. Logo alt text duplicates the adjacent wordmark in nine places

**Surface:** both · **File:** `components/Navigation.tsx:232` · **Effort:** small

**Evidence.** VERIFIED — all nine confirmed by grep. `alt="Praxist Prep logo"` at Navigation.tsx:232 (inside the `<Link href="/">` that also renders the `Praxist Prep` wordmark span at line 237), MarketingHome.tsx:100 and :543, ComingSoon.tsx:98, dashboard/Sidebar.tsx:172, app/login/page.tsx:74, app/signup/page.tsx:73, app/pricing/page.tsx:449, app/check-email/page.tsx:24.

**Why it matters.** The home link is announced as 'Praxist Prep logo Praxist Prep, link' on every page of both surfaces. It is the first thing a screen-reader user hears on each navigation. The image is decorative here because the adjacent text already carries the name (WCAG H67).

**Fix.** Set `alt=""` on all nine logo images where a text wordmark is adjacent. Keep a real alt only where a logo ever appears without accompanying text.

### 6. Roughly nine distinct corner radii are in use for the same card/panel role

**Surface:** both · **File:** `components/dashboard/PraxUI.tsx:182` · **Effort:** medium

**Evidence.** VERIFIED by grep, with one correction. The system defines three (PraxUI.tsx:182 `borderRadius: 20` primary, :190 `16` secondary, :196 `12` tertiary). In practice, for card-and-panel surfaces: 8px (`rounded-lg`, support/page.tsx:150), 10px (dashboard/page.tsx:1305, flashcards/page.tsx:1242, practice/page.tsx:1030/1157/1596), 12px (`rounded-xl`, dashboard/page.tsx:157, lessons/page.tsx:138, support/page.tsx:193), 14px (dashboard/page.tsx:1366, flashcards/page.tsx:868, practice/page.tsx:475/960), 16px (`rounded-2xl`, lessons/page.tsx:134, flashcards/[deckId]/page.tsx:182, check-email/page.tsx:35), 20px, 24px (`rounded-3xl`, pricing/page.tsx:115, 176), and 40px (`rounded-[2.5rem]`, 14 sites in analytics/daily and analytics/weekly). I dropped the reported 18px: MolecularBg.tsx:542 and :830 are decorative background shapes, not card surfaces, so that citation was a misread. Buttons are more consistent at 999 but still mix in `rounded-lg`, `rounded-xl` and `rounded-2xl`.

**Why it matters.** Radius is one of the two or three cues that make a set of screens read as one product. Nine values for one role means nothing reads as deliberate, and the 40px analytics cards in particular look like a different design language from the hub that links to them.

**Fix.** Declare a radius scale as tokens in globals.css (`--radius-chip: 12px`, `--radius-card: 16px`, `--radius-card-lg: 20px`, `--radius-pill: 999px`), have PraxCard consume them, and sweep the outliers — 8/10/14/24/40 — onto the nearest step.

### 7. `font-label` is not a defined token — 23 usages are silent no-ops — and the font it was presumably meant to name (Fraunces) is downloaded on every page for nothing

**Surface:** both · **File:** `components/MarketingHome.tsx:109` · **Effort:** small

**Evidence.** VERIFIED. globals.css's `@theme inline` block (86-163) defines exactly six font tokens at :157-162 — `--font-serif`, `--font-sans`, `--font-headline`, `--font-body`, `--font-prax-serif`, `--font-prax-sans`. There is no `--font-label`, and there is no tailwind.config file (postcss.config.mjs loads `@tailwindcss/postcss` only), so globals.css is the entire theme and `font-label` generates no CSS. It appears 23 times: 22 in components/MarketingHome.tsx (nav links 109/115/121/127, both nav CTAs 135/141, hero eyebrow 172, hero CTAs 190/196, section kickers 248/335/393, 430, 471, 509, 530, footer links 548-580) and once at components/dashboard/BottomTabs.tsx:149. Separately, app/layout.tsx:35-40 loads `Fraunces` with two weights and both styles and applies the variable at :146, but there is no `--font-fraunces` entry in the @theme block, so no utility exposes it; its only consumers are twelve `fontFamily="var(--font-fraunces), Fraunces, serif"` attributes on `<text>` nodes in components/dashboard/MolecularBg.tsx (681, 691, 700, 710, 746, 755, 765, 774, 784, 793, 803, 812) — decorative element symbols in the dashboard background at 0.07 opacity. That is seven Google families loaded site-wide.

**Why it matters.** Nothing is visibly broken today — the 23 sites silently inherit Manrope from `font-body` on the wrapper at MarketingHome.tsx:90 — but the two halves are clearly one unfinished wiring: a label typeface was loaded and referenced and never connected. Meanwhile Fraunces ships to every marketing visitor, who never sees a single Fraunces glyph, purely to letter a background pattern nobody can read.

**Fix.** Decide one way. Either add `--font-label: var(--font-fraunces);` to the @theme inline block so the 23 sites start paying for the download, or delete the 23 `font-label` occurrences and drop Fraunces from app/layout.tsx:35-40, letting MolecularBg's `serif` fallback handle the background glyphs.

### 8. `--sidebar-w` and its comment describe a 288px sidebar that is actually 224px, and the CSS consuming it is dead

**Surface:** dashboard · **File:** `app/globals.css:59` · **Effort:** small

**Evidence.** VERIFIED. app/globals.css:59-60 reads `/* Dashboard sidebar width (matches components/dashboard/Sidebar.tsx lg:w-72 = 18rem = 288px) */` then `--sidebar-w: 288px;`. components/dashboard/Sidebar.tsx:161 is `className="hidden lg:flex lg:flex-col lg:w-56 sticky top-0 h-screen …"` — lg:w-56 = 14rem = 224px, a 64px discrepancy. The only consumer is `.bg-canvas { left: var(--sidebar-w, 288px); }` (globals.css:70), and `grep -rn BackgroundCanvas app components` returns only components/dashboard/BackgroundCanvas.tsx:10-11 itself — no page imports it.

**Why it matters.** Severity lowered from medium: nothing renders, so nothing is currently wrong on screen. But the comment is a confidently-worded false statement about another file, which a non-technical founder or a future agent will trust; and if BackgroundCanvas is ever wired up, the tiled glyph background starts 64px right of the sidebar edge, leaving a bare stripe down the left of every lg+ dashboard screen.

**Fix.** Either delete globals.css:59-84 (token, comment, .bg-canvas rules, and the max-width:1023px override) along with components/dashboard/BackgroundCanvas.tsx, or set `--sidebar-w: 224px` and correct the comment to `lg:w-56 = 14rem`. If keeping it, drive the sidebar off the token (`style={{ width: "var(--sidebar-w)" }}`) so they cannot diverge again. Same file also carries `.harvey-card` (276-284, zero uses, with its own hardcoded #FCFAE9) and `.animate-fade-in-up` / `@keyframes fadeInUp` (174-187, zero uses) — both confirmed dead.

### 9. Analytics charts and the SRS grade buttons hardcode hexes that already exist as tokens

**Surface:** dashboard · **File:** `app/dashboard/analytics/weekly/page.tsx:465` · **Effort:** small

**Evidence.** VERIFIED at every cited line. app/dashboard/analytics/weekly/page.tsx:465-466 `stopColor="#003630"` in the area gradient, :470 `stroke="#bfc9c5"` on the gridlines, :476 `stroke="#003630"` on the trend line, :488 `stroke="#003630"` and :489 `fill="#003630"` on the data points. #003630 is --as-primary (globals.css:28) and #bfc9c5 is --as-outline-variant (globals.css:48), both used as classes elsewhere in the same file (`text-as-outline` at line 458). components/flashcards/StudySurface.tsx:48-51 mixes the same way inside one literal: `bg-[#a8432c]`, `bg-[#87621d]`, `bg-as-primary`, `bg-[#0b6f56]` — three arbitrary hexes and one token in a four-item GRADES array.

**Why it matters.** Severity lowered from medium: the rendered colors are correct today, so this is invisible until someone moves a token. Then the brand green in the flagship analytics chart stays behind. StudySurface is the worse of the two because the array reads as if all four entries are tokens, so the three hexes will be overlooked.

**Fix.** SVG presentation attributes accept CSS variables — change weekly/page.tsx:465-466 to `stopColor="var(--as-primary)"`, :470 to `stroke="var(--as-outline-variant)"`, and :476/:488/:489 to `var(--as-primary)`. For StudySurface.tsx:48-51, define the four SRS grades as tokens in the `@theme inline` block (--color-grade-again/hard/medium/easy) and use `bg-grade-again` etc. so all four entries are consistent.

### 10. Lesson content switches from serif to sans between h2 and h3 mid-document

**Surface:** dashboard · **File:** `app/dashboard/lessons/[section]/[id]/page.tsx:115` · **Effort:** small

**Evidence.** VERIFIED, exact lines. In the markdown renderer, `## ` produces `<h2 className="font-headline text-xl text-as-primary mt-8 mb-3 first:mt-0">` at line 108 — Newsreader serif at 20px. `### ` produces `<h3 key={i} className="font-semibold text-base text-as-primary mt-6 mb-2">` at line 115 — no family class at all, so it inherits the body sans at 16px. The page h1 at :304 is `font-headline`. So within one rendered lesson the heading family is serif, serif, then sans.

**Why it matters.** An h3 looks like bolded body copy rather than a heading. Since h3 is what breaks up the longest lessons, the subsections stop registering as structure and the content reads as an undifferentiated wall — precisely where the serif/sans contrast should be doing work.

**Fix.** Change line 115 to `"font-headline text-base text-as-primary mt-6 mb-2"` so h1, h2 and h3 stay in the serif and differ only by size.

### 11. Flashcard grade sub-labels at 9px sit at 4.21:1 and 4.43:1

**Surface:** dashboard · **File:** `components/flashcards/StudySurface.tsx:186` · **Effort:** small

**Evidence.** VERIFIED with numbers corrected. Line 186 `<span className="text-[9px] font-medium opacity-80 normal-case tracking-normal">` shows the next-interval preview. Recomputed: white @80% on Hard #87621d (line 49) = 4.21:1 and on Again #a8432c (line 48) = 4.43:1 — both marginal fails. Easy #0b6f56 = 4.54:1, which PASSES (the original finding listed 4.55:1 yet still flagged it). Medium uses bg-as-primary and passes comfortably. Full-opacity labels are fine at 5.53/5.99/6.14:1. Severity lowered to polish: two marginal misses of under 0.3, with the real issue being the 9px size.

**Why it matters.** The interval preview ('10m · 2', '4d · 3') is what lets a student grade a card deliberately rather than guessing, and it is the smallest text in the product.

**Fix.** Drop `opacity-80` (white on #87621d is 5.53:1 at full opacity) and raise the size to 10px. Zero layout cost.

### 12. login and signup use background-attachment: fixed, which iOS Safari does not honor

**Surface:** marketing · **File:** `app/signup/page.tsx:64` · **Effort:** small

**Evidence.** CONFIRMED as code; user-visible impact is milder than originally claimed, so downgraded from medium. Line 64 sets `backgroundAttachment: "fixed"` inside the style object on the page wrapper (lines 58-65), identical at app/login/page.tsx:65. Mobile Safari does not implement fixed attachment the way desktop does — it sizes the image against the initial containing block and does not repaint on scroll — so the photo crops differently than intended and can shift during scroll. Both pages do scroll at 375px.

**Why it matters.** A background that crops or shifts unexpectedly on the two highest-intent pages reads as sloppiness, though a 40% dark overlay sits on top of it so the effect is subtle.

**Fix.** Remove `backgroundAttachment: "fixed"` from both files, or move the photo to a `fixed inset-0 -z-10` sibling div with the auth card layered above it.

### 13. Pricing comparison table overflows its overflow-hidden wrapper with no way to scroll

**Surface:** marketing · **File:** `app/pricing/page.tsx:261` · **Effort:** small

**Evidence.** CONFIRMED but overstated; downgraded from high. Line 261 `<div className="bg-white rounded-2xl border border-gray-200 overflow-hidden">` wraps `<table className="w-full text-sm">` (line 262) inside a `max-w-3xl px-6` container (line 254) = 327px at 375px. Cell padding is `px-6` on the feature column (lines 265, 294) plus `px-4` on both value columns (268, 271, 297, 318) = 112px. Summing per-column min-content widths (longest words "explanations", "Essentials", "Complete") plus that padding lands at ~330px, so the table exceeds the wrapper by only a few pixels and `overflow-hidden` clips it with no scroll possible. What gets cut is the right padding and the `rounded-tr-2xl` corner of the highlighted "Complete" column (line 271) — not the cell text. The original claim that the conversion instrument is visibly clipped is not supported at 375px.

**Why it matters.** Harmless at 375px, but the layout has zero headroom: any narrower viewport (320px), larger system font, or longer feature label starts clipping actual content with no scroll escape.

**Fix.** Put an `overflow-x-auto` div between the rounded card and the table (keeping `overflow-hidden` on the outer card only for corner rounding), and reduce mobile cell padding to `px-3 md:px-6` / `px-2 md:px-4`.

### 14. Marketing section vertical rhythm never scales down — 128px of padding at mobile

**Surface:** marketing · **File:** `components/MarketingHome.tsx:219` · **Effort:** small

**Evidence.** CONFIRMED as code; downgraded from medium because the value is defensible as an editorial choice. Line 219 `bg-as-surface py-32 md:py-40` — `py-32` (128px) is the base and therefore applies at 375px. Same shape at line 330 (`py-32 md:py-48`), line 409 (`py-32 md:py-40`) and line 521 (`py-40 md:py-48`, i.e. 160px at mobile). Every marketing section pairs 128-160px above with the same below, so roughly 256px of empty cream separates adjacent sections on an 812px-tall screen.

**Why it matters.** Desktop whitespace values applied unchanged at 375px force the visitor to scroll through nearly a third of a screen of nothing between ideas — the literal shape of the mobile-first violation CLAUDE.md prohibits, though the brand does call for generous whitespace.

**Fix.** Add a base step per section: `py-16 sm:py-24 md:py-40` at lines 219 and 409, `py-16 sm:py-24 md:py-48` at line 330, `py-20 sm:py-28 md:py-48` at line 521.

### 15. ComingSoon expresses --color-prax-cream as a raw rgba literal nine times and duplicates #0a0a0a across two files

**Surface:** marketing · **File:** `components/ComingSoon.tsx:136` · **Effort:** medium

**Evidence.** VERIFIED at every line. `rgba(246,244,227,…)` is #f6f4e3, i.e. --color-prax-cream (app/globals.css:142), and appears nine times in components/ComingSoon.tsx at lines 136 (0.6), 153 (0.25), 169 (0.55), 194 (0.7), 220 (0.06), 221 (0.18), 270 (0.75), 296 (0.4) and 307 (0.4) — while the same file correctly writes `var(--color-prax-cream)` at lines 106, 149, 181, 225, 233 and 253. Line 61 and line 117 hardcode `background: "#0a0a0a"` (plus rgba(10,10,10,…) at line 89), the same black components/MarketingHome.tsx:151 writes as `bg-[#0a0a0a]` — one value, two expressions, no token. The file styles almost entirely through inline `style={{…}}` objects rather than Tailwind utilities, against the CLAUDE.md convention.

**Why it matters.** Nine alpha variants of one token mean a palette change needs nine hand-edits in this file alone, and the two spellings of #0a0a0a let the pre-launch page and the live hero drift apart. Inline styles also cannot be responsive, which matters on a page whose left panel switches from 42vh to full height at lg (line 65).

**Fix.** Add a token for the near-black (e.g. `--color-prax-ink-inverse: #0a0a0a`) and use it at ComingSoon.tsx:61, 89, 117 and MarketingHome.tsx:151. Replace the nine rgba literals with `color-mix(in srgb, var(--color-prax-cream) 60%, transparent)` etc., or convert the file to Tailwind classes with opacity modifiers. Same treatment for `rgba(28, 28, 19, 0.4)` at app/login/page.tsx:62 and app/signup/page.tsx:61, which is --as-on-surface #1c1c13.

### 16. Body copy set in Manrope Light at 14px with 70% opacity

**Surface:** marketing · **File:** `components/MarketingHome.tsx:281` · **Effort:** small

**Evidence.** VERIFIED with the contrast recomputed — and the recomputation weakens the accessibility half of the original claim, so I have kept this at polish. Five feature-card paragraphs use `"text-as-tertiary/70 font-light text-sm leading-relaxed"` — components/MarketingHome.tsx:281, :289, :305, :320 and :446. That is Manrope 300 (the loaded face is variable 200-800, so 300 is a real instance, not synthetic) at 14px in `--as-tertiary` `#2f2f2f` (globals.css:35) at 70% over `--as-surface-container-low` `#f6f4e4` (globals.css:40). I computed the composited ratio at **4.90:1** — it passes AA 4.5 with a thin margin, not the sub-threshold failure implied. `font-light` is applied to fourteen text elements on the page (also :182, :240, :341, :351, :357, :363, :369, :421, :463).

**Why it matters.** Weight 300 was drawn for display sizes; at 14px the stems thin toward hairlines, and the 70% opacity leaves only a 0.4 margin over the AA floor. On a phone in daylight — the primary viewport per the house rules — these paragraphs go faint. CLAUDE.md asks the sans to carry readability, and Light at 14px is the one combination that gives that up.

**Fix.** Drop `font-light` on the five 14px paragraphs at lines 281, 289, 305, 320 and 446 (Manrope 400 at 14px still reads light against the serif headings) and raise `/70` to `/80`, which measures 6.61:1. Keep `font-light` only at `text-lg` and above.

### 17. Pricing-page mobile nav toggle has no aria-expanded

**Surface:** marketing · **File:** `components/Navigation.tsx:305` · **Effort:** small

**Evidence.** VERIFIED with scope corrected. Line 305 `<button type="button" className="lg:hidden p-2 text-gray-600" onClick={() => setMobileMenuOpen(!mobileMenuOpen)} aria-label="Toggle menu">` — label present, but no `aria-expanded={mobileMenuOpen}` and no `aria-controls` for the panel at line 386. Same omission on the accordion triggers at line 389. CORRECTION: Navigation.tsx is imported only by app/pricing/page.tsx, so this is the phone navigation on /pricing, not on the homepage (MarketingHome.tsx ships its own nav at line 90). Severity lowered accordingly.

**Why it matters.** A screen-reader user cannot tell whether the menu is open or closed — 'Toggle menu, button' reads identically in both states — so they toggle blind and may close a menu they just opened. WCAG 4.1.2.

**Fix.** Add `aria-expanded={mobileMenuOpen}` and `aria-controls="mobile-menu"` on line 305 with a matching `id="mobile-menu"` on the panel div at line 386, and `aria-expanded={mobileExpanded === item.key}` on the section buttons at line 389.

### 18. check-email helper text and footer links at 3.98:1 and 2.62:1

**Surface:** marketing · **File:** `app/check-email/page.tsx:61` · **Effort:** small

**Evidence.** VERIFIED. Line 61 `<div className="bg-sand rounded-xl px-4 py-3 text-xs text-gray-500 mb-8">` — `gray-500` is not defined in globals.css so it resolves to Tailwind 4.2.2's default oklch(55.1% .027 264.364) = #6a7282, which on --sand #F0E8DC is 3.98:1 at 12px (recomputed). The Terms/Privacy links at line 76 use `text-gray-400` #9C8E82 on the same bg-sand page background (line 18) = 2.62:1; hover to `text-coral` = 3.17:1, still failing.

**Why it matters.** The spam-folder hint is the one piece of troubleshooting on a page whose entire job is unblocking a stuck signup, and it is the faintest text in the card. gray-500 also leaks Tailwind's cool blue-grey into an otherwise warm cream palette.

**Fix.** Use --gray-600 #6B5E52 for the hint and for the footer links; the cream/sand backgrounds cannot support gray-400 for any text.

### 19. `backgroundAttachment: "fixed"` on the login and signup heroes behaves differently on iOS Safari, where most signups happen

**Surface:** marketing · **File:** `app/signup/page.tsx:64` · **Effort:** small

**Evidence.** VERIFIED. app/signup/page.tsx:57-66 and app/login/page.tsx:58-67 are identical: `style={{ backgroundImage: "linear-gradient(rgba(28,28,19,0.4), rgba(28,28,19,0.4)), url('/hero-library.jpg')", backgroundSize: "cover", backgroundPosition: "center", backgroundAttachment: "fixed" }}` on a `min-h-screen ... flex items-center justify-center p-4` wrapper (backgroundAttachment at signup:64 and login:65). Mobile Safari does not honour `background-attachment: fixed`; it falls back to scroll behaviour, so `cover` sizes the image to the element box rather than the viewport. Because the wrapper is `min-h-screen` and the signup form grows taller than the viewport once name/email/password and the terms copy are in, the visible crop on iPhone differs from the desktop crop and shifts as the URL bar collapses.

**Why it matters.** These are the two conversion pages and the last impression before a student hands over money. The defect is a wrong photo crop and a background that drifts while scrolling rather than anything broken, but it is entirely avoidable and only shows up on the platform most signups come from.

**Fix.** Drop `backgroundAttachment: "fixed"` from app/login/page.tsx:65 and app/signup/page.tsx:64, or move the photo to a `fixed inset-0 -z-10` layer with `object-cover`, which behaves correctly on iOS.

### 20. "Mindful Milestones — our projections" implies a score projection the product does not make

**Surface:** marketing · **File:** `components/MarketingHome.tsx:320` · **Effort:** small

**Evidence.** Verified. components/MarketingHome.tsx:318-323: heading "Mindful Milestones" over "Our projections provide clarity and peace of mind, allowing you to focus on the work instead of the worry." No projection or forecast feature exists — grepping app/dashboard and components/dashboard for project/forecast/predict returns only flashcard session-size math (app/dashboard/flashcards/page.tsx:263-266) and one further unbacked copy string, "simulated exams and predictive analytics" (app/dashboard/page.tsx:1405). The related "Score Calculator — Estimate your MCAT score from practice results" menu entry (components/Navigation.tsx:104-107) is one of the 18 dead href="#" links. Severity lowered from medium: the reading of "projections" as score prediction is an inference, though the absence of any projection feature is fact.

**Why it matters.** It claims a capability that does not exist, and in an MCAT context "projections" plus "peace of mind" reads as a predicted score — one notch below a guarantee, in territory the brand rules out.

**Fix.** Retitle to the real capability (progress milestones, mastery by difficulty tier) and drop "projections" unless a projection feature ships with a stated methodology.

### 21. Waitlist email capture has no privacy statement or link

**Surface:** marketing · **File:** `components/ComingSoon.tsx:202` · **Effort:** small

**Evidence.** Verified. The form at components/ComingSoon.tsx:202-247 posts an email with only the label at :197 "Enter your email to be notified the moment it's ready." Below it: the tagline at :299 and a footer at :305-311 containing only "© {year} Praxist Prep" and "All rights reserved" — no privacy link, no "we won't share your email," no unsubscribe note. This is the default public view (lib/launch-mode.ts:29 defaults to preview; app/page.tsx:51 renders ComingSoon), and no privacy policy route exists anywhere.

**Why it matters.** It is the only conversion on the pre-launch site and the only page most visitors currently reach, and it asks for a personal identifier with zero reassurance about what happens to it.

**Fix.** Add a line under the button: "One email when we open. No spam, no sharing." — linked to the privacy policy once one exists.

