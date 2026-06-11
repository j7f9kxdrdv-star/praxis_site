# Verification — Organic Chemistry Chapter 9: Carboxylic Acid Derivatives

## Deck metadata
- **Title:** Carboxylic Acid Derivatives
- **Section:** `organic_chemistry`
- **Topic:** Organic Chemistry
- **Subtopic:** carboxylic acid derivatives
- **Sort order:** 9
- **Total cards:** 28

## Subtopic distribution
| Subtopic | Cards | Positions | Share |
|---|---|---|---|
| 9.1 Amides, Esters, and Anhydrides | 10 | 0–9 | 36% |
| 9.2 Reactivity Principles | 8 | 10–17 | 28% |
| 9.3 Nucleophilic Acyl Substitution Reactions ★ | 10 | 18–27 | 36% |

Subtopic 9.3 flagged high-yield in the source.

## v6 compliance checks
- ✅ All cards original Praxis Prep prose synthesized from textbook framing
- ✅ Every card uses cloze format `{{cN::…}}`
- ✅ `cloze_count` equals the number of distinct cN groups per card
- ✅ Card length: every answer prose ≤ ~38 words
- ✅ Cloze groups per card: ≤ 3 distinct cN labels everywhere
- ✅ Parallel concepts clozed together where appropriate
- ✅ Idempotent: prior versions deleted under all historical title spellings before insert

## Source disposition
- 54 source .apkg notes audited
- 24 consolidations (massive duplication: amide formation 2x, ester formation 3x, anhydride formation 3x, reactivity ranking 2x, transesterification 3x, saponification 3x, β-lactam strain 3x)
- 6 new gap-fill cards added (lactam Greek-letter ring-size mapping precision, amide H-bonding N-H availability nuance, anhydride high-reactivity electronic reasoning, amide low-reactivity nitrogen-lone-pair reasoning, penicillin pharmacology connection, why amides resist hydrolysis standalone)
- 16 image-only source notes converted to text-only cards (derivative structures, mechanism diagrams, transesterification, saponification panels) — per Ch 3–8 precedent
- 8 .docx autocorrect typos silently corrected:
  - Para 3: sentence cut off mid-word ("hydrogen ass...") completed
  - Para 7: "n-" → "N-" italic convention
  - Paras 11–12: lactam Greek-letter convention restated precisely (β = 4-membered including N, C=O, α-C, β-C)
  - Para 28: "cyclic anhydrates" → "cyclic anhydrides"
  - Para 34: "Enhydrides" → "Anhydrides"
  - Para 35: "carbon monooxygen" → "carbonyl oxygen"
  - Para 55: "And hydrides" → "Anhydrides"
  - Para 58: "one esser simply transformed" → "one ester is simply transformed"

## Scientific accuracy verification
- ✅ Condensation = two molecules join + loss of small molecule (H₂O) — LibreTexts
- ✅ Amide formation from CA + ammonia/amine — LibreTexts
- ✅ Amide -amide suffix; N- italic prefix for nitrogen-substituted alkyls — LibreTexts
- ✅ Lactam Greek-letter ring-size convention (β = 4, γ = 5, δ = 6) — LibreTexts
- ✅ Amide H-bonding depends on primary/secondary (N-H available) vs tertiary — verified
- ✅ Ester formation by Fischer esterification (CA + alcohol, acid catalysis) — LibreTexts
- ✅ Ester -oate naming + alkyl-from-alcohol prefix; lactones = cyclic esters — verified
- ✅ Triglycerides = glycerol + 3 fatty acids via ester bonds — OpenStax Biology
- ✅ Saponification = base-catalyzed triglyceride hydrolysis → glycerol + carboxylate salt soap — LibreTexts (cross-references Ch 8 saponification cards)
- ✅ Anhydride = condensation dimer of two CAs; symmetric vs asymmetric naming conventions — LibreTexts
- ✅ Reactivity ranking anhydride > ester > amide — LibreTexts
- ✅ Anhydride reactivity driven by 3 EWG O's + carboxylate LG — LibreTexts
- ✅ Amide low reactivity from N lone pair donation → partial C=N double-bond character — LibreTexts
- ✅ Steric hindrance, induction, conjugation as 3 reactivity modulators — LibreTexts
- ✅ β-lactam ring strain (angle + torsional) from 4-membered ring — LibreTexts
- ✅ Penicillin mechanism: β-lactam strain + bacterial transpeptidase covalent inhibition — standard pharmacology
- ✅ NAS general mechanism (nucleophile → carbonyl C → tetrahedral intermediate → LG departure) — LibreTexts (callback to Ch 8 card 11)
- ✅ Anhydride cleavage: amine → amide+CA; alcohol → ester+CA; water → 2 CA — LibreTexts
- ✅ Transesterification: alcohol nucleophile swaps alkoxy group, either acidic or basic conditions — LibreTexts
- ✅ Amides resist hydrolysis without strongly acidic/basic + heat — LibreTexts
- ✅ Acidic amide hydrolysis: carbonyl O protonation → water nucleophile → CA + ammonium — verified
- ✅ Basic amide hydrolysis: hydroxide nucleophile → carboxylate anion + amine — verified
- ✅ Heating dicarboxylic acid → cyclic anhydride; 5/6-membered preferred — LibreTexts

## AAMC scope coverage
- **CP 4D — Reactivity (NAS as unifying mechanism, derivative reactivity ranking, β-lactam strain)** ✓
- **CP 5A — Bonding (amide resonance, partial C-N double-bond character)** ✓
- **CP 5E — Acid/base (acidic vs basic amide hydrolysis mechanisms)** ✓
- **BB 1B — Macromolecules (amide bonds as peptide bonds in proteins)** ✓
- **BB 2C — Lipid metabolism (triglyceride saponification, ester chemistry of fats)** ✓
- **BB 1D — Pharmacology (β-lactam antibiotic mechanism)** ✓

## Cross-deck linkage
- All three derivative formations reinforce OrgChem Ch 8 (Carboxylic Acids) cards 13–20 — Ch 9 frames them from the *derivative perspective* with added reactivity reasoning
- NAS mechanism reinforces Ch 8 card 11 with explicit tetrahedral-intermediate + LG-departure mechanics
- Amide resonance reinforces Ch 8 card 15 with the electronic reasoning for low reactivity
- Saponification reinforces Ch 8 cards 23–25 with the specific triglyceride mechanism
- β-lactam strain content sets up future pharmacology discussions of antibiotic resistance and mechanism-based drug inactivation
- Per user direction, all crossover content retained for spaced-repetition reinforcement with derivative-specific framing

## Post-deployment QA
- [ ] Run SQL in Supabase (no prerequisite migration)
- [ ] Confirm `RAISE NOTICE 'Seeded deck <uuid> with 28 cards.'` fires
- [ ] Spot-check deck appears in admin UI under Organic Chemistry, sort order 9 (after Ch 8 Carboxylic Acids; completing the original chapter sequence)
- [ ] Render cards 3, 9 on device to confirm 3-cN-group layouts render correctly
- [ ] Verify special characters (α, β, γ, δ, π, →, ⁻, ⁺, °, ², ₂, –) render cleanly on mobile
