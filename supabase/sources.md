# Praxis Prep — Internal Source Canon for MCAT Content Verification

**Purpose.** This file is the internal, authoritative list of free, publicly-accessible sources
used to fact-check every flashcard and practice question Praxis Prep generates before it ships to
paying students. It exists for editors, content reviewers, and automated verification pipelines.

**This file is never shown to students.** It is not a "study resources" page. Students should be
directed to Praxis Prep's own materials; these sources are behind-the-scenes references.

**Selection bar.** A source appears here only if all of the following were verified by direct
fetch: (1) free to read without login, (2) authoritative authorship with institutional backing,
(3) MCAT-level depth, (4) stable hosting, (5) a specific URL / chapter / section can be cited for
any given fact.

**Verification date.** 2026-04-24. Re-verify links quarterly; any 404/410/paywall invalidates the
source until replaced.

---

## Master table

| Subject | Primary | Secondary | Tertiary | Notes |
|---|---|---|---|---|
| Biology | OpenStax **Biology 2e** | LibreTexts **Biology** library | OpenStax **Microbiology** (for micro topics) | Biology 2e covers the MCAT biology blueprint end-to-end. Use Microbiology for prokaryote/virology depth. |
| Biochemistry | LibreTexts **Biological Chemistry** bookshelf | OpenStax **Biology 2e** (metabolism/molecular bio chapters) | OpenStax **Chemistry 2e** (thermo/kinetics for enzyme kinetics) | No strong single free Biochem textbook equivalent to Lehninger/Stryer exists openly; Biological Chemistry shelf is the best free aggregate. See "Gaps." |
| General Chemistry | OpenStax **Chemistry 2e** (or **Chemistry: Atoms First 2e**) | LibreTexts **General Chemistry** bookshelf | NIST **Chemistry WebBook** (constants, thermo data) | NIST is for numerical verification, not pedagogy. |
| Organic Chemistry | LibreTexts **Organic Chemistry** bookshelf | OpenStax **Organic Chemistry** (McMurry, 2023) | — | LibreTexts is what's loaded in the local corpus; McMurry-on-OpenStax remains an excellent free alternative for spot-checking. |
| Physics | OpenStax **College Physics 2e** (algebra-based — MCAT level) | LibreTexts **College Physics** bookshelf | **HyperPhysics** (Georgia State) for concept maps | Use College Physics 2e (not University Physics) — MCAT is algebra/trig-based. |
| Psychology | OpenStax **Psychology 2e** | **Noba Project** modules | **APA Dictionary of Psychology** (dictionary.apa.org) for terminology | APA Dictionary is definitional, not explanatory; pair with OpenStax for mechanism/context. |
| Sociology | OpenStax **Introduction to Sociology 3e** | LibreTexts **Sociology** bookshelf | — | Thin free canon here; two sources suffice. |

---

## Detailed per-source notes

### OpenStax (Rice University)
- **Who/what:** Nonprofit publisher at Rice University. Each title has named faculty authors and
  a listed editorial/peer-review panel; all content is **CC-BY 4.0** and free to read in full
  online without registration.
- **Why it's the spine of this list:** It is the only free source that (a) covers every MCAT
  subject except biochemistry at the right depth, (b) has explicit peer review, and (c) is stable
  (Rice institutional backing, widely adopted in US undergrad courses).
- **Canonical URLs to cite from:**
  - Biology 2e — https://openstax.org/details/books/biology-2e
  - Microbiology — https://openstax.org/details/books/microbiology
  - Chemistry 2e — https://openstax.org/details/books/chemistry-2e
  - Chemistry: Atoms First 2e — https://openstax.org/details/books/chemistry-atoms-first-2e
  - Organic Chemistry (McMurry) — https://openstax.org/details/books/organic-chemistry
  - College Physics 2e — https://openstax.org/details/books/college-physics-2e
  - Psychology 2e — https://openstax.org/details/books/psychology-2e
  - Introduction to Sociology 3e — https://openstax.org/details/books/introduction-sociology-3e
- **Gaps:** No dedicated biochemistry textbook. No dedicated genetics textbook (genetics is
  covered inside Biology 2e but less deeply than Hartwell/Griffiths).
- **Currency:** All "2e" and "3e" editions are 2019–2023. Organic Chemistry (McMurry) was added
  in 2023. Stable topics — recency is not a concern.

### LibreTexts (UC Davis consortium)
- **Who/what:** Multi-institutional nonprofit originally seeded by UC Davis (Delmar Larsen) and
  NSF/Dept of Education funding. Content is remixed/curated by faculty across hundreds of
  institutions. Individual texts carry their own CC licenses (commonly **CC BY-NC-SA 4.0** for
  physics; varies elsewhere — **always check the per-page footer before quoting**).
- **Editorial note:** Weaker central editorial oversight than OpenStax. Quality varies across
  bookshelves. Best used as a **secondary** confirmation source, or when OpenStax has a gap
  (notably biochemistry).
- **Bookshelves we rely on:**
  - Biology — https://bio.libretexts.org/Bookshelves
  - Biological Chemistry — https://chem.libretexts.org/Bookshelves/Biological_Chemistry
  - General Chemistry — https://chem.libretexts.org/Bookshelves/General_Chemistry
  - Organic Chemistry — https://chem.libretexts.org/Bookshelves/Organic_Chemistry
  - College Physics — https://phys.libretexts.org/Bookshelves/College_Physics
  - Psychology — https://socialsci.libretexts.org/Bookshelves/Psychology
  - Sociology — https://socialsci.libretexts.org/Bookshelves/Sociology
- **Rule of use:** When LibreTexts and OpenStax disagree, treat OpenStax as the tiebreaker unless
  a LibreTexts page cites a primary source we can independently verify.

### NIST Chemistry WebBook
- **Who/what:** US National Institute of Standards and Technology. General Editor Peter J.
  Linstrom, compiled by NIST scientists. Last updated March 2025.
- **Use for:** Exact values — thermochemical constants, ionization energies, IR/UV spectra,
  standard reduction potentials, heats of formation. Not for pedagogy or explanation.
- **URL:** https://webbook.nist.gov/chemistry/
- **Caveat:** NIST reserves the right to charge for access in the future (explicit in site
  terms). Currently free; monitor quarterly.

### HyperPhysics (Georgia State University)
- **Who/what:** Authored by Dr. Rod Nave (Georgia State, now Emeritus as of Feb 2024). Hosted on
  GSU servers with stated long-term stability commitment.
- **Strengths:** Concept-map navigation makes it excellent for tracing physics relationships
  (e.g., how the ideal gas law connects to kinetic theory). MCAT-appropriate algebra-based depth.
- **Weaknesses:** No formal peer review beyond Nave. Last major content revisions predate 2020
  for many pages — flag as a **tertiary** source and cross-check against OpenStax College Physics
  before relying on it for anything quantitative.
- **URL:** http://hyperphysics.phy-astr.gsu.edu/hbase/hph.html (note: HTTP only — HTTPS cert is
  misconfigured; verification pipeline should allow HTTP for this host only).

### Noba Project
- **Who/what:** Founded by Ed and Carol Diener. Modules authored by named senior psychologists
  (Elizabeth Loftus, Susan Fiske, David Buss, etc.). **CC BY-NC-SA 4.0.**
- **Strengths:** Individual modules are often written by the researcher who developed the theory
  — excellent for canonical statements of e.g. memory reconsolidation, social cognition,
  self-determination theory. 105+ modules.
- **Weaknesses:** Module-by-module; no single continuous textbook spine. Pair with OpenStax
  Psychology 2e for curriculum coverage.
- **URL:** https://nobaproject.com/

### APA Dictionary of Psychology
- **Who/what:** American Psychological Association. Free web edition of the APA Dictionary. No
  paywall or mandatory login for the dictionary reading interface.
- **Use for:** Canonical term definitions — when a question hinges on the precise meaning of
  "proactive interference" vs. "retroactive interference," this is the authority.
- **Weaknesses:** Definitional only — no mechanism or experimental context.
- **URL:** https://dictionary.apa.org/

---

## Rejected candidates

- **Khan Academy MCAT** (khanacademy.org/test-prep/mcat) — As of 2026-04, Khan + AAMC have
  publicly stated the content is in an uncertain "rolling extension" status with no guaranteed
  lifespan past 2026 and no active revision. Failing the **stability** criterion. Videos may
  survive on YouTube but without Khan's site structure they aren't reliably citable. **Do not
  use for verification.** (Acceptable as a student-facing supplemental recommendation, but that's
  out of scope for this file.)
- **NCBI Bookshelf — Alberts *Molecular Biology of the Cell* (NBK21054)** — Hosted but explicitly
  "accessible by the search feature, but cannot be browsed" per publisher agreement. Fails
  **citable** (you cannot point a reviewer at a chapter URL). **Rejected.**
- **NCBI Bookshelf — Berg/Tymoczko/Stryer *Biochemistry* (NBK21154)** — Returns HTTP 410 Gone as
  of 2026-04-24. Content has been withdrawn. **Rejected.**
- **NCBI Bookshelf — Cooper *The Cell: A Molecular Approach* (NBK9841)** — Same search-only
  restriction as Alberts. **Rejected** for our purposes, though search-only hits are fine as
  supporting evidence if a reviewer manually confirms.
- **NCBI Bookshelf as a whole** — Still valuable for specific open-access titles (StatPearls,
  NLM guidelines), but the famous textbooks pre-med students associate with it are all
  search-restricted or withdrawn. Do not assume a bookshelf URL is browsable; verify per title.
- **Wikipedia** — Not considered. Crowd-sourced without the editorial oversight bar we set,
  despite often being accurate. Acceptable as a lead for finding primary sources, never as the
  source of record.
- **OpenStax *University Physics*** — Calculus-based; overshoots MCAT level. College Physics 2e
  is the right OpenStax physics title. Not rejected for quality, just for fit.

---

## Gaps flagged

1. **Biochemistry is the biggest gap.** There is no free, institutionally-backed, browsable
   equivalent of Lehninger or Stryer. Our workaround is LibreTexts Biological Chemistry (primary)
   + OpenStax Biology 2e metabolism chapters + OpenStax Chemistry 2e for enzyme kinetics. This is
   adequate but requires stitching. **Recommendation:** For high-stakes biochem content
   (metabolic pathway specifics, allosteric regulation details), a human SME should verify against
   a licensed copy of Lehninger in addition to the free sources. Budget this into the content QA
   workflow.
2. **Genetics depth.** OpenStax Biology 2e covers transmission and molecular genetics adequately
   for MCAT but is thinner than dedicated genetics texts on topics like pedigree analysis edge
   cases and population genetics math. LibreTexts Biology has supplementary genetics bookshelves
   — check them when a question is genetics-heavy.
3. **Sociology is under-resourced in the free canon generally.** OpenStax Intro to Sociology 3e
   + LibreTexts Sociology is the entire free-tier depth available. For MCAT sociology this is
   sufficient because the MCAT tests intro-level sociology, but don't expect to find deep free
   sources for stratification theory or demography nuance.
4. **Psychology — DSM/diagnostic criteria.** The DSM-5-TR is not free. For questions about
   diagnostic categories, use APA Dictionary for terminology and OpenStax Psychology 2e for
   framing, but verify any diagnostic-criteria claim against a licensed DSM in the QA workflow.
   Do not write questions that hinge on exact DSM thresholds sourced only from free materials.
5. **Organic chemistry spectroscopy.** LibreTexts Organic Chemistry and OpenStax Organic Chemistry (McMurry) both cover NMR, IR, MS
   adequately. For exact spectral data cross-checks, use NIST Chemistry WebBook rather than
   trusting a textbook figure.

---

## Review cadence

- **Quarterly:** Re-fetch every URL in this file. Any 4xx/5xx or paywall change pulls the source
  until resolved.
- **On edition bump:** When OpenStax publishes a new edition (e.g., Biology 3e), update the
  canonical URL and re-verify that references in the question bank still resolve.
- **On Khan Academy MCAT status change:** Revisit the rejection if AAMC and Khan publicly
  commit to a post-2026 timeline with active revision.
