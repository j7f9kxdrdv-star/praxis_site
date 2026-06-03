# Verification — Scientific Reasoning Chapter 10: Mathematics

## Deck metadata
- **Title:** Mathematics
- **Section:** `scientific_reasoning`
- **Topic:** Scientific Reasoning
- **Subtopic:** mathematics
- **Sort order:** 10 *(slots before Ch 11 Research Design and Ch 12 Statistics, matching the source book's chapter order)*
- **Total cards:** 34

## Subtopic distribution
| Subtopic | Cards | Positions | Share |
|---|---|---|---|
| 10.1 Arithmetic and Significant Figures | 7 | 0–6 | 21% |
| 10.2 Exponents and Logarithms | 12 | 7–18 | 35% |
| 10.3 Trigonometry | 7 | 19–25 | 21% |
| 10.4 Problem Solving | 8 | 26–33 | 24% |

## v6 compliance checks
- ✅ All cards original Praxis Prep prose synthesized from textbook framing; no verbatim or near-verbatim lifts from .apkg/.docx
- ✅ Every card uses cloze format `{{cN::…}}`
- ✅ `cloze_count` equals the number of distinct cN groups per card
- ✅ Card length: every answer prose ≤ ~38 words
- ✅ Cloze groups per card: ≤ 3 distinct cN labels everywhere
- ✅ Parallel concepts clozed together:
  - Card 2 (sig fig boundaries): both nonzero anchors parallel under c1
  - Card 17 (log product/quotient): parallel operations + parallel rules
  - Card 18 (log power/reciprocal): parallel operations + parallel rules
  - Card 19 (common vs natural log): parallel log types + parallel bases
  - Card 20 (SOH CAH TOA): three trig functions with parallel numerator and denominator pieces under c1 and c2
  - Card 27 (direct vs inverse): both relationship types parallel under c1
  - Card 28 (SI positive prefixes): all 6 prefix-abbreviation pairs parallel under c1
  - Card 29 (SI negative prefixes): all 6 prefix-abbreviation pairs parallel under c1
- ✅ Idempotent: prior versions deleted under all historical title spellings before insert

## Source disposition
- 45 source .apkg notes audited
- 22 consolidations executed (12 individual SI-prefix notes → 2 parallel-cloze cards, 6 trig-angle notes → 4 angle cards via boundary consolidation, several log-rule duplicates merged)
- 9 new gap-fill cards added (scientific notation definition, mult/div sig fig rule, add/sub sig fig rule, estimation strategy, common vs natural log, tan = sin/cos identity, inverse trig conceptual, F ↔ C conversion, C ↔ K conversion)
- 0 image-only notes (.apkg had no images)
- 5 .docx autocorrect typos / errors silently corrected:
  - Para 7: extra "?" on sig fig definition
  - Para 15: sentence ends mid-thought ("decimal points are maintained rather than maintaining significant" → restored to teach the correct rule)
  - Para 79: extra "?" on tangent definition
  - Para 110: trig table row "189" → "180" (typo for 180°)
  - Para 133: SI prefix kilo- abbreviation "H" → "k" (lowercase, per SI convention; the .apkg correctly has "k")

## Scientific accuracy verification
- ✅ Scientific notation form (significand × 10ⁿ) — OpenStax College Physics 2e Ch. 1
- ✅ Sig fig counting rules (between-nonzero, leading, trailing with/without decimal) — OpenStax
- ✅ Sig figs in arithmetic (mult/div fewest sig figs; add/sub fewest decimal places) — OpenStax
- ✅ Calculator-free estimation: compensating direction for multiplication; same direction for division — standard MCAT-prep guidance
- ✅ All 7 exponent rules verified — OpenStax College Algebra Ch. 1
- ✅ √2 ≈ 1.4142… (MCAT 1.4) and √3 ≈ 1.7321… (MCAT 1.7) — verified
- ✅ Square root estimation strategy (divide by perfect squares) — standard
- ✅ All 6 log rules verified — OpenStax College Algebra Ch. 6
- ✅ Common logarithm base 10; natural logarithm base e = 2.71828… — verified
- ✅ SOH CAH TOA definitions — OpenStax Algebra and Trigonometry Ch. 5
- ✅ tan θ = sin θ / cos θ identity — standard
- ✅ Inverse trig (sin⁻¹ etc.) returns angle from a ratio — OpenStax
- ✅ Special angle values:
  - 30°: sin = 1/2, cos = √3/2, tan = √3/3 ✓
  - 45°: sin = cos = √2/2, tan = 1 ✓
  - 60°: sin = √3/2 ≈ 0.87, cos = 1/2 = 0.5, tan = √3 ≈ 1.7 ✓
- ✅ Boundary angles:
  - 0°: (0, 1, 0) ✓
  - 90°: (1, 0, undefined) ✓ (tan 90° is undefined because cos 90° = 0)
  - 180°: (0, −1, 0) ✓
- ✅ Direct vs inverse relationship definitions — OpenStax
- ✅ All 12 SI prefixes verified with correct case-sensitive abbreviations (kilo = lowercase k; mega = uppercase M; etc.)
- ✅ Temperature conversions:
  - F = (9/5) C + 32; equivalently C = (5/9)(F − 32) ✓
  - K = C + 273.15 (rounded to 273 per MCAT convention) ✓
- ✅ All three system-of-equations methods (substitution, setting equal, elimination) — OpenStax College Algebra Ch. 11
- ✅ All .docx typos and the SI kilo-abbreviation case error silently corrected

## AAMC scope coverage
- **Math fluency is implicit in AAMC SIRS Skills 1–4** — every science section assumes the student can do sig figs, exponents/logs, basic trig, unit prefixes, temperature conversions, and simple algebra calculator-free
- **High-yield cross-section applications:**
  - Logarithms → pH calculations (gen chem), decibel scale (physics), Henderson-Hasselbalch (biochem)
  - Exponents → exponential decay (physics, nuclear), kinetics (biochem)
  - Trigonometry → projectile motion, optics, vector decomposition (physics)
  - SI prefixes → essentially every quantitative MCAT problem
  - Temperature conversions → thermodynamics (physics, chem)

## Cross-deck linkage
- Lives in the Scientific Reasoning section alongside Ch 11 (Research Design) and Ch 12 (Data-Based and Statistical Reasoning) — same source book and same cross-cutting "skills used across all MCAT sections" framing

## Post-deployment QA
- [ ] Run SQL in Supabase (no prerequisite migration — section already exists)
- [ ] Confirm `RAISE NOTICE 'Seeded deck <uuid> with 34 cards.'` fires
- [ ] Spot-check deck appears in admin UI under Scientific Reasoning, listed before Ch 11
- [ ] Render parallel-cloze cards (17, 18, 19, 20, 27, 28, 29) on device to confirm parallel blanks reveal together
- [ ] Verify special characters (×, ⁰, ¹², ⁻¹, °, θ, √, ≈, ε, μ, Δ) and superscripts/subscripts render cleanly on mobile
