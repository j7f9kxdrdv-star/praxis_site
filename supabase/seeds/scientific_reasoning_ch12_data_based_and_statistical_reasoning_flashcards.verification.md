# Verification — Scientific Reasoning Chapter 12: Data-Based and Statistical Reasoning

## Deck metadata
- **Title:** Data-Based and Statistical Reasoning
- **Section:** `scientific_reasoning`
- **Topic:** Scientific Reasoning
- **Subtopic:** data based and statistical reasoning
- **Sort order:** 12
- **Total cards:** 42

## Subtopic distribution
| Subtopic | Cards | Positions | Share |
|---|---|---|---|
| 12.1 Measures of Central Tendency | 5 | 0–4 | 12% |
| 12.2 Distributions | 6 | 5–10 | 14% |
| 12.3 Measures of Variability and Outliers | 8 | 11–18 | 19% |
| 12.4 Probability | 5 | 19–23 | 12% |
| 12.5 Hypothesis Testing | 8 | 24–31 | 19% |
| 12.6 Charts, Graphs, and Tables ★ | 7 | 32–38 | 17% |
| 12.7 Correlation and Causation | 3 | 39–41 | 7% |

## v6 compliance checks
- ✅ All cards original Praxis Prep prose synthesized from textbook framing; no verbatim or near-verbatim lifts from .apkg/.docx
- ✅ Every card uses cloze format `{{cN::…}}`
- ✅ `cloze_count` equals number of distinct cN groups per card
- ✅ Card length: every answer prose ≤ ~38 words
- ✅ Cloze groups per card: ≤ 3 distinct cN labels everywhere
- ✅ Parallel concepts clozed together:
  - Card 9 (skew + CT ordering): both directions of skew (mean>median>mode AND mean<median<mode) under c1 as parallel pair
  - Card 19 (independent vs dependent): both terms parallel under c1
  - Card 18 (outlier causes): all three causes parallel under c1
  - Card 27 (decision rule): reject/fail-to-reject parallel under c2
  - Card 30 (Type II + power): "power" tied to Type II under c1
  - Card 33 (bar vs histogram): parallel terms + parallel data types
  - Card 37 (semi-log vs log-log): parallel plot types + parallel relationship types
  - Card 39 (positive vs negative correlation): parallel terms + parallel directions
  - Card 16 (IQR rule): both bounds parallel under c1
- ✅ Idempotent: prior versions deleted under all historical title spellings before insert

## Source disposition
- 58 source .apkg notes audited
- 27 consolidations executed (heavy duplication — almost every concept appeared twice in the .apkg)
- 9 new gap-fill cards added (median position formula, standard normal distribution, SD ≈ ¼ range shortcut, Bessel's n−1 correction, at-least-one shortcut, null vs alternative split, Type I and II error isolation, bar vs histogram distinction)
- 5 image-only source notes ported to text (pie chart, bar graph, line graph, two skewed-distribution diagrams)
- 8 .docx autocorrect typos silently corrected ("Database" → "Data-Based" in title, three stray "?" autocorrects, "Quarttiles" → "Quartiles", "medium" → "median", garbled outlier-handling sentence, garbled correlation sentence, "where a correlation is efficient" → "correlation coefficient")
- 1 .docx factual error silently corrected (para 58: "from the median" → "from the mean" for the 3-SD outlier rule — the .apkg correctly says "from the mean")
- Maps + tables as separate chart-type cards dropped (low yield); their content folded conceptually
- "Statistical vs practical significance" omitted because it is already covered in Ch 11 deck card 38

## Scientific accuracy verification
- ✅ Mean / median / mode formulas and use-case guidance — OpenStax Introductory Statistics Ch. 2
- ✅ Median position (n+1)/2; even-n median = mean of two middle values — standard
- ✅ Outlier impact on mean (but not median) — OpenStax
- ✅ Normal distribution symmetry, mean=median=mode coincidence — OpenStax Ch. 6
- ✅ 68-95-99 empirical rule — OpenStax
- ✅ Standard normal (μ=0, σ=1) and Z-transformation — OpenStax
- ✅ Skew direction follows tail; mean pulled toward tail — OpenStax
- ✅ Positive skew: mean > median > mode; negative skew: mean < median < mode — verified
- ✅ Bimodal distribution: two peaks; often analyzed as two distributions — standard
- ✅ Range = max − min; sensitivity to outliers — OpenStax
- ✅ SD ≈ ¼ × range — empirical rule corollary; standard MCAT shortcut
- ✅ IQR = Q3 − Q1; resistant to outliers — OpenStax
- ✅ Sample SD formula (sum squared deviations / (n−1), then √); Bessel's correction provides unbiased estimator — OpenStax
- ✅ 1.5 × IQR Tukey rule and 3-SD rule for outliers — OpenStax
- ✅ Three outlier causes; handling protocol decided pre-study — OpenStax Ch. 2
- ✅ Independence, dependence, mutual exclusivity, exhaustiveness — OpenStax Ch. 3
- ✅ AND rule (product for independent events); OR rule (inclusion-exclusion); at-least-one (complement) shortcut — OpenStax Ch. 3
- ✅ Null hypothesis as equality; alternative directional vs non-directional — OpenStax Ch. 9
- ✅ p-value as P(data or more extreme | H₀); smaller p ⇒ stronger evidence — OpenStax
- ✅ Decision rule p vs α; α = 0.05 conventional — OpenStax
- ✅ Type I (false positive, rate α) and Type II (false negative, rate β); power = 1 − β — OpenStax
- ✅ Confidence interval construction; 95% standard; wider CI = higher confidence — OpenStax Ch. 8
- ✅ Pie / bar / histogram / box / line / semi-log / log-log chart-type conventions — OpenStax + standard
- ✅ Bar (categorical) vs histogram (continuous numerical) distinction — OpenStax
- ✅ Box plot anatomy: Q1, median, Q3, whiskers to non-outlier extremes within 1.5 × IQR — OpenStax Ch. 2
- ✅ Slope m = Δy / Δx — standard
- ✅ Semi-log linearizes exponential; log-log linearizes power-law — verified
- ✅ Linear data least likely to need log-axis transformation — standard
- ✅ Positive vs negative correlation directions — OpenStax Ch. 12
- ✅ r ∈ [−1, +1]; sign indicates direction; magnitude indicates strength; 0 = no linear relationship — OpenStax
- ✅ Correlation ≠ causation; Hill's criteria callback to Ch 11 — Belmont / SIRS framework

## AAMC scope coverage
- **AAMC SIRS Skill 4 (Data-Based and Statistical Reasoning):** entire deck ✓
- **Descriptive statistics:** central tendency, variability, outliers ✓
- **Distributions:** normal, skewed, bimodal; empirical rule ✓
- **Probability:** independence, mutual exclusivity, AND/OR rules ✓
- **Inferential statistics:** hypothesis testing, Type I/II errors, power, confidence intervals ✓
- **Data visualization:** all major chart types + axis transformations ✓
- **Correlation:** r interpretation; correlation ≠ causation ✓

## Cross-deck linkage
- Card 41 explicitly references Hill's criteria from the Ch 11 deck card 18 — students who studied Ch 11 will recognize the connection
- "Statistical vs practical significance" intentionally omitted here because Ch 11 deck card 38 already covers it cleanly

## Post-deployment QA
- [ ] Run SQL in Supabase (no prerequisite migration — section already exists)
- [ ] Confirm `RAISE NOTICE 'Seeded deck <uuid> with 42 cards.'` fires
- [ ] Spot-check deck appears in admin UI under Scientific Reasoning → Chapter 12 (after "Reasoning About Research Design")
- [ ] Render parallel-cloze cards (9, 18, 33, 37, 39) on device to confirm parallel blanks reveal together
- [ ] Verify special characters (α, β, Δ, ×, −, ⁻¹, ², √, ¼, ≥, ≤, ★) render cleanly on mobile
