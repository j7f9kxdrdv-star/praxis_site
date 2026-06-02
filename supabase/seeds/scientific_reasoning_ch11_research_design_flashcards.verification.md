# Verification — Scientific Reasoning Chapter 11: Reasoning About Research Design

## Deck metadata
- **Title:** Reasoning About Research Design
- **Section:** `scientific_reasoning` *(new top-level section)*
- **Topic:** Scientific Reasoning
- **Subtopic:** research design
- **Sort order:** 11
- **Total cards:** 38

## Subtopic distribution
| Subtopic | Cards | Positions | Share |
|---|---|---|---|
| 11.1 Scientific Method + FINER | 4 | 0–3 | 11% |
| 11.2 Basic Science Research ★ | 6 | 4–9 | 16% |
| 11.3 Human Subjects Research — Designs ★ | 10 | 10–19 | 26% |
| 11.4 Sources of Error | 6 | 20–25 | 16% |
| 11.5 Research Ethics | 7 | 26–32 | 18% |
| 11.6 Populations, Samples, Validity, Significance | 5 | 33–37 | 13% |

## v6 compliance checks
- ✅ All cards original Praxis Prep prose synthesized from textbook framing; no verbatim or near-verbatim lifts from .apkg/.docx
- ✅ Every card uses cloze format `{{cN::…}}`
- ✅ `cloze_count` equals the number of distinct cN groups per card
- ✅ Card length: every answer prose ≤ ~35 words
- ✅ Cloze groups per card: ≤ 3 distinct cN labels everywhere
- ✅ Parallel concepts clozed together:
  - Card 3 (FINER): all 5 criteria parallel under c1
  - Card 6 (IV vs DV): role + action parallel under c1 + c2
  - Card 7 (controls): positive/negative + expected/unexpected change parallel
  - Card 9 (accuracy vs precision): parallel terms + parallel definitions
  - Card 11 (experimental vs observational): parallel approach + outcome
  - Card 13 (single vs double blind): parallel level names
  - Card 18 (Hill's criteria list): all 9 criteria parallel under c1
  - Card 22 (bias vs confounding): parallel terms + parallel phases
  - Card 27 (four ethics principles): all 4 parallel under c1
  - Card 35 (parameter vs statistic): parallel terms + parallel source types
  - Card 37 (internal vs external validity): parallel terms + parallel definitions
  - Card 38 (statistical vs clinical significance): parallel terms + parallel definitions
- ✅ Idempotent: prior versions deleted under all historical title spellings before insert

## Section migration
- **Prerequisite migration:** `supabase/migrations/20260602_add_scientific_reasoning_section.sql`
- Adds `'scientific_reasoning'` to the `flashcard_decks_section_check` CHECK constraint
- Frontend `SECTIONS` array in `app/dashboard/flashcards/page.tsx` updated to render the new section between Physics and Psych/Soc

## Source disposition
- 43 source .apkg notes audited
- 9 consolidations (internal/external validity, statistical/clinical significance, bias, confounding, scientific-method phases, accuracy/precision, controls, MCAT-passage cards folded into card 11)
- 12 new gap-fill cards added (hypothesis as if–then, experimentation vs observation, placebo effect standalone, systematic error standalone, randomization purpose, single vs double blinding, why blinding matters, bias vs confounding distinction, nonmaleficence standalone, autonomy standalone, respect for persons expanded with IRB + vulnerable populations, random sampling as gold standard)
- 0 image-only notes (.apkg had no images for this chapter)
- 9 .docx autocorrect typos silently corrected (multiple "casual" → "causal", "Binding" → "Blinding", "Co-founding" → "Confounding", "cofounders" → "confounders", "Equip-pose" → "Equipoise", "Nonmalefiance" → "Nonmaleficence")
- 1 .apkg absolutism softened — note #20 ("Human subjects research is often observational, not experiment-based") reframed to acknowledge both RCTs (experimental) and observational designs

## Scientific accuracy verification
- ✅ 8-step scientific method in 3 phases — OpenStax Psychology 2e Ch. 2
- ✅ FINER criteria — standard MCAT framing
- ✅ Hypothesis as if-then — OpenStax
- ✅ IV manipulated / DV measured — OpenStax
- ✅ Positive vs negative control logic — OpenStax + Concepts of Biology
- ✅ Placebo effect assessed via negative control — OpenStax
- ✅ Accuracy (validity) ≠ precision (reliability) — OpenStax
- ✅ Experimental → causation; observational → correlation only — AAMC SIRS framework
- ✅ Randomization controls between-group confounding — OpenStax
- ✅ Single vs double blinding — OpenStax
- ✅ Cohort (forward from exposure), cross-sectional (snapshot), case-control (backward from outcome) — standard epidemiology
- ✅ Hill's 9 criteria correctly listed — standard epidemiology
- ✅ Selection / detection / Hawthorne / confounding bias — OpenStax
- ✅ Bias as collection-phase error vs confounding as analysis-phase error — standard framing
- ✅ Four core principles (beneficence, nonmaleficence, autonomy, justice) — Belmont Report + OpenStax
- ✅ Respect for persons + informed consent + IRB + vulnerable populations — Belmont Report
- ✅ Equipoise definition — standard medical-ethics framing
- ✅ Parameter (population) ≠ statistic (sample) — OpenStax statistics
- ✅ Internal vs external validity — OpenStax
- ✅ Statistical ≠ clinical significance — OpenStax + standard EBM framework

## AAMC scope coverage
- **Scientific Inquiry and Reasoning Skills (SIRS) framework:**
  - Skill 1 (Knowledge of scientific concepts) — definitions and frameworks ✓
  - Skill 2 (Scientific reasoning and problem-solving) — causation, study design choice ✓
  - Skill 3 (Reasoning about the design and execution of research) — every card ✓
  - Skill 4 (Data-based and statistical reasoning) — validity, significance, sampling ✓
- **Ethics:** Belmont Report principles, IRB protections, vulnerable populations ✓

## Post-deployment QA
- [ ] Run migration `20260602_add_scientific_reasoning_section.sql` first
- [ ] Run seed SQL second; confirm `RAISE NOTICE 'Seeded deck <uuid> with 38 cards.'` fires
- [ ] Hard-refresh the dashboard
- [ ] Confirm a new **Scientific Reasoning** section appears between Physics and Psych/Soc with 1 deck · 38 cards
- [ ] Confirm "Reasoning About Research Design" deck opens and renders all cards
- [ ] Spot-check parallel-cloze cards (3, 4, 17, 26, 37) on device to confirm parallel blanks reveal together
