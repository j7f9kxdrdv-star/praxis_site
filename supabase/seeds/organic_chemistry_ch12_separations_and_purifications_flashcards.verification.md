# Verification — Organic Chemistry Chapter 12: Separations and Purifications

## Deck metadata
- **Title:** Organic Chemistry Chapter 12: Separations and Purifications
- **Section:** `organic_chemistry`
- **Topic:** Organic Chemistry
- **Chapter number:** 12
- **Sort order:** 12
- **Total cards:** 41

## Subtopic distribution
| Subtopic | Cards | Positions | Share |
|---|---|---|---|
| 12.1 Solubility-Based Methods | 12 | 1–12 | 29% |
| 12.2 Distillation | 7 | 13–19 | 17% |
| 12.3 Chromatography ★ high-yield | 22 | 20–41 | 54% |

## v6 compliance checks
- ✅ All cards original Praxis Prep prose synthesized from textbook framing; no verbatim or near-verbatim lifts from .apkg/.docx
- ✅ Every card uses cloze format `{{cN::…}}`
- ✅ `cloze_count` equals number of distinct cN groups per card
- ✅ Card length: every answer prose ≤ ~30 words
- ✅ Cloze groups per card: ≤ 4 distinct cN labels everywhere
- ✅ Parallel concepts clozed together:
  - Card 6: aqueous base/aqueous acid + conjugate base/conjugate acid (parallel acid–base extraction symmetry)
  - Card 26: TLC and paper chromatography (parallel technique pair)
  - Card 31: ion-exchange / size-exclusion / affinity + charge / size / binding (parallel triplet of specialized columns)
- ✅ Idempotent: prior versions deleted under all historical title spellings before insert

## Source disposition
- 43 source .apkg notes audited
- 11 consolidations executed (duplicate distillation, GC, chromatography polarity premise, HPLC trio)
- 8 new gap-fill cards added (rotary evaporator, denser layer drains first, boiling chips, TLC visualization, R_f formula, column mobile-phase mechanics, affinity release, GC volatility requirement)
- 1 factual correction silently applied (.apkg #34 "nonpolar card" → "nonpolar stationary phase")
- 4 image-only source notes converted to text-only cards (vacuum filtration, TLC plate, packed column, ion-exchange beads — none required the diagram to teach the concept)
- 7 .docx autocorrect typos silently corrected against textbook (Solut­ability, indigestion, Greed crystallization, Fraction, displace punctuation, drawer, pollutant)

## Scientific accuracy verification
- ✅ Simple distillation BP cutoffs (<150 °C, ≥25 °C apart) — LibreTexts Nichols
- ✅ Vacuum distillation rationale (lower pressure → lower BP → avoids degradation) — LibreTexts Nichols
- ✅ Fractional distillation mechanism (repeated condense–revaporize in column) — LibreTexts Nichols
- ✅ Boiling chips prevent superheating/bumping — LibreTexts Nichols
- ✅ Worked examples both use clean pairs that satisfy the rules taught on cards 14–16
- ✅ Retention factor formula `R_f = distance(spot) / distance(solvent front)`, range 0–1 — LibreTexts Analytical
- ✅ Reverse-phase polarity flip (nonpolar stationary + polar mobile) — LibreTexts; corrects source error
- ✅ Size-exclusion direction: large molecules elute first because they cannot enter pores — LibreTexts
- ✅ Ion-exchange release via pH/salt change — LibreTexts
- ✅ Affinity release via buffer change to disrupt binding — LibreTexts
- ✅ GC-MS function and HPLC modern characteristics — LibreTexts + AAMC outline
- ✅ Acid–base extraction symmetry (acid → aqueous base; base → aqueous acid) — OpenStax Chemistry 2e
- ✅ Recrystallization mechanism (slow cool, impurities stay in solution at low concentration) — LibreTexts Nichols
- ✅ Terminology standardized to **retention factor** (AAMC + LibreTexts), not "retardation factor"

## AAMC scope coverage (CP 4D — Separation and Purification Methods)
- ✅ Extraction (liquid–liquid, acid–base)
- ✅ Distillation (simple, vacuum, fractional)
- ✅ Chromatography (TLC, paper, column, GC, HPLC, plus ion-exchange / size-exclusion / affinity / reverse-phase / GC-MS)
- ✅ Filtration (gravity, vacuum) and recrystallization
- ✅ Rotary evaporation as standard solvent-removal tool

## Post-deployment QA
- [ ] Run SQL in Supabase
- [ ] Confirm `RAISE NOTICE 'Seeded deck <uuid> with 41 cards.'` fires
- [ ] Spot-check deck appears in admin UI under Organic Chemistry → Chapter 12
- [ ] Render cards 6, 26, 31 on device to confirm parallel-cloze blanks reveal together
