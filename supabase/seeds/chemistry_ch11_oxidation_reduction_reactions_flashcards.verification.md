# Verification — General Chemistry Chapter 11: Oxidation-Reduction Reactions

## Deck metadata
- **Title:** General Chemistry Chapter 11: Oxidation-Reduction Reactions
- **Section:** `chemistry`
- **Topic:** General Chemistry
- **Subtopic:** oxidation reduction reactions
- **Sort order:** 11
- **Total cards:** 30

## Subtopic distribution
| Subtopic | Cards | Positions | Share |
|---|---|---|---|
| 11.1 Redox Fundamentals | 7 | 0–6 | 23% |
| 11.2 Assigning Oxidation Numbers | 9 | 7–15 | 30% |
| 11.3 Balancing Redox Reactions | 4 | 16–19 | 13% |
| 11.4 Ionic Equations and Reaction Types | 7 | 20–26 | 23% |
| 11.5 Redox Titrations | 3 | 27–29 | 10% |

## v6 compliance checks
- ✅ All cards original Praxis Prep prose synthesized from textbook framing; no verbatim or near-verbatim lifts from .apkg/.docx
- ✅ Every card uses cloze format `{{cN::…}}`
- ✅ `cloze_count` equals the number of distinct cN groups per card
- ✅ Card length: every answer prose ≤ ~32 words
- ✅ Cloze groups per card: ≤ 4 distinct cN labels everywhere
- ✅ Parallel concepts clozed together:
  - Card 2 (position 1): OIL RIG halves — "Oxidation Is Loss" / "Reduction Is Gain" both c1
  - Card 4 (position 3): oxidizing agent ↔ reduced; reducing agent ↔ oxidized — parallel c1 + c2 pairs
  - Card 11 (position 10): Group IA / Group IIA + their oxidation numbers — parallel c1 + c2
  - Card 25 (position 24): four reaction families — all 4 names parallel under c1
- ✅ Idempotent: prior versions deleted under all historical title spellings before insert

## Source disposition
- 29 source .apkg notes audited
- 13 consolidations executed (heavy oxidation-number rule duplication; agent definitions)
- 10 new gap-fill cards added (OIL RIG mnemonic, simultaneity rule, NaBH₄ vs LiAlH₄ contrast, oxidation-number rationale, half-reaction overview + step-by-step framework, splitting rules for ionic equations, four reaction families parallel card, "double-displacement ≠ redox" reasoning)
- 8 image-only source notes converted to text-only cards (oxidizing/reducing agent schematics, half-reaction method panels, periodic-table group strips)
- 8 .docx autocorrect typos silently corrected ("SN2 Plus" → "Sn²⁺", "Lindor's" → "Lindlar's", "CrO3,Na2, Cr2, O7" → "CrO₃ and Na₂Cr₂O₇", "Pyrimidine chlorochromate" → "Pyridinium chlorochromate", "NAD+ FADH" → "NAD⁺ and FAD", garbled "each group of a element" rule for Group IIA, garbled double-displacement sentence, "Redox citations" → "Redox titrations")

## Scientific accuracy verification
- ✅ OIL RIG mnemonic — standard
- ✅ Oxidation = electron loss; reduction = electron gain — OpenStax Atoms First 2e Ch. 4
- ✅ Oxidizing/reducing agent definitions and symmetry — OpenStax
- ✅ Common oxidizing/reducing agent lists trimmed to AAMC-relevant items — OpenStax + cross-checked with our existing Organic Chemistry decks
- ✅ NaBH₄ vs LiAlH₄ selectivity (NaBH₄ → aldehydes/ketones only; LiAlH₄ → also carboxylic acids, esters, amides) — LibreTexts Organic Chemistry
- ✅ All 8 oxidation-number rules verified:
  - Free element / diatomic = 0 ✓
  - Monatomic ion = its charge ✓
  - Group IA = +1, Group IIA = +2 ✓
  - Group VIIA = −1 (with electronegativity exception) ✓
  - Hydrogen = +1 except −1 with metals ✓
  - Oxygen = −2 except −1 in peroxides and +2 in OF₂ ✓
  - Sum in neutral compound = 0 ✓
  - Sum in polyatomic ion = charge of ion ✓
- ✅ OF₂ exception correctly attributed to fluorine's higher electronegativity than oxygen
- ✅ Half-reaction (ion-electron) method procedure verified — OpenStax Ch. 16 and LibreTexts General Chemistry
- ✅ Basic-solution balancing approach (balance as acidic, then add OH⁻ to neutralize H⁺) — standard textbook treatment
- ✅ Complete vs net ionic equations, spectator ions — OpenStax Ch. 4
- ✅ Aqueous strong electrolytes split; solids/liquids/gases/weak electrolytes stay together — OpenStax
- ✅ Double-displacement reactions usually not redox (ions retain oxidation states) — OpenStax
- ✅ Disproportionation Cl₂ + OH⁻ example (the chemistry of household bleach formation) — LibreTexts
- ✅ Potentiometric titration measures emf via voltmeter — OpenStax Ch. 16

## AAMC scope coverage
- **CP 4A — Atomic / molecular structure:** oxidation states ✓
- **CP 5E — Acid–base equilibria and electrochemistry:**
  - Redox reactions and electron transfer ✓
  - Half-reactions and balancing ✓
  - Common oxidizing and reducing agents (conceptual level) ✓
  - Redox titrations (indicator and potentiometric) ✓
- **CP 5D — Stoichiometry:** complete vs net ionic equations, spectator ions, reaction families ✓

## Post-deployment QA
- [ ] Run SQL in Supabase
- [ ] Confirm `RAISE NOTICE 'Seeded deck <uuid> with 30 cards.'` fires
- [ ] Spot-check deck appears in admin UI under General Chemistry → Chapter 11 (between Acids and Bases and Electrochemistry)
- [ ] Render cards 2, 4, 11, 25 on device to confirm parallel-cloze blanks reveal together
- [ ] Verify special characters (₂, ²⁻, ⁻, ⁺, →, ²) render cleanly on mobile
