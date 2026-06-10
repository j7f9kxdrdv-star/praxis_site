# Verification — Organic Chemistry Chapter 7: Aldehydes and Ketones II — Enolates

## Deck metadata
- **Title:** Aldehydes and Ketones II: Enolates
- **Section:** `organic_chemistry`
- **Topic:** Organic Chemistry
- **Subtopic:** aldehydes and ketones ii
- **Sort order:** 7
- **Total cards:** 21

## Subtopic distribution
| Subtopic | Cards | Positions | Share |
|---|---|---|---|
| 7.1 General Principles | 5 | 0–4 | 24% |
| 7.2 Enolate Chemistry | 10 | 5–14 | 48% |
| 7.3 Aldol Condensation | 6 | 15–20 | 28% |

## v6 compliance checks
- ✅ All cards original Praxis Prep prose synthesized from textbook framing
- ✅ Every card uses cloze format `{{cN::…}}`
- ✅ `cloze_count` equals the number of distinct cN groups per card
- ✅ Card length: every answer prose ≤ ~38 words
- ✅ Cloze groups per card: ≤ 3 distinct cN labels everywhere
- ✅ Parallel concepts clozed together:
  - Card 10 (3 strong bases): all 3 parallel under c1
  - Card 13 (kinetic vs thermodynamic enolate conditions): parallel under c1, c2, c3
  - Card 18 (condensation/dehydration vocabulary): both terms parallel under c1
- ✅ Idempotent: prior versions deleted under all historical title spellings before insert

## Source disposition
- 41 source .apkg notes audited
- 18 consolidations (heavy duplication — α-acidity, kinetic/thermo enolate, aldol mechanism each appeared 2–3 times)
- 7 new gap-fill cards added (callback to Ch 6 aldehyde > ketone reactivity, tautomerization process standalone, α-racemization standalone, common strong bases parallel card, kinetic vs thermo parallel card, β-hydroxy aldol product standalone, single-substrate constraint for clean aldol)
- 14 image-only source notes converted to text-only cards (tautomer structures, mechanism arrow-pushing, aldol panels) — per Ch 3–6 precedent
- 6 .docx autocorrect typos silently corrected:
  - Para 8: "negative torques" → "negative charge"
  - Para 19: "the key to the enol" → "the keto to the enol"
  - Para 20: "ketone enol forms" → "keto and enol forms"
  - Para 22: "lithium diisopropyl amide" → "lithium diisopropylamide (LDA)"
  - Para 49: "alpha beta unsaturated carbocation" → "α,β-unsaturated carbonyl"
  - Para 54: "retro all delve" → "retro-aldol"; "grease base" → "aqueous base"
- 1 .docx factual error silently corrected: the aldol example uses "acetyl halide" in paras 45–48 — this is the wrong substrate class for a classic base-catalyzed aldol. Cards teach the canonical aldol (enolate from an aldehyde/ketone attacking a second aldehyde/ketone) without naming the wrong specific molecule.

## Scientific accuracy verification
- ✅ α-carbon adjacent to carbonyl C; α-H attached to α-C — LibreTexts
- ✅ α-H acidity driven by EWG carbonyl + resonance stabilization of enolate — LibreTexts
- ✅ Enolate resonance: carbanion on α-C ↔ alkoxide on O (the more stable contributor with negative on O) — LibreTexts
- ✅ Ketone α-H slightly less acidic than aldehyde α-H due to EDG alkyl group destabilizing the enolate — verified
- ✅ Ketone less reactive than aldehyde toward nucleophiles via steric + electronic reasons — LibreTexts (reinforced from Ch 6)
- ✅ Tautomers differ in proton + double-bond placement — LibreTexts
- ✅ Keto >> enol at equilibrium; tautomerization catalyzed by acid or base — LibreTexts
- ✅ α-racemization: chiral α-C → racemic mixture via keto/enol interconversion — LibreTexts
- ✅ Strong base + carbonyl → enolate anion (better nucleophile than neutral enol) — LibreTexts
- ✅ Common enolate-forming bases: OH⁻, LDA, KH — LibreTexts
- ✅ Michael addition: enolate + α,β-unsaturated carbonyl → 1,4-conjugate addition — LibreTexts
- ✅ Kinetic enolate: less substituted α-C, low T, strong bulky base (LDA), forms fast — LibreTexts
- ✅ Thermodynamic enolate: more substituted α-C, higher T, weak reversible base, more stable — LibreTexts
- ✅ Enamines from secondary amines (primary amines give imines instead) — LibreTexts (cross-deck: Ch 6 card 18)
- ✅ Aldol addition mechanism (enolate + carbonyl → β-hydroxy carbonyl) — LibreTexts
- ✅ β-hydroxy carbonyl product (aldol) — LibreTexts
- ✅ Dehydration step (E1/E2) → α,β-unsaturated carbonyl makes it a condensation — LibreTexts
- ✅ "Condensation" = two molecules join with loss of small molecule; "dehydration" = water specifically — verified
- ✅ Mixed aldol gives product mixture unless single substrate used — LibreTexts
- ✅ Retro-aldol: reverse reaction, aqueous base + heat, cleaves α–β bond — LibreTexts

## AAMC scope coverage
- **CP 4D — Reactivity (enolate as nucleophile, aldol mechanism, Michael addition)** ✓
- **CP 5C — Stereochemistry (α-racemization)** ✓
- **CP 5E — Acid/base (α-H acidity)** ✓

## Cross-deck linkage
- α-hydrogen acidity reinforces OrgChem Ch 4 (card 6) with the full enolate mechanism framework
- Aldehyde > ketone reactivity (card 4) reinforces both OrgChem Ch 4 (card 33) and Ch 6 (card 6) with explicit two-reason explanation
- Imine ↔ enamine tautomerization reinforces OrgChem Ch 6 (card 18) with secondary-amine selectivity detail
- Enolate as foundation for aldol and Michael reactions sets up content that will appear in Ch 8+ (carboxylic acids and derivatives)
- Per user direction, all crossover content retained with enolate-specific framing

## Post-deployment QA
- [ ] Run SQL in Supabase (no prerequisite migration)
- [ ] Confirm `RAISE NOTICE 'Seeded deck <uuid> with 21 cards.'` fires
- [ ] Spot-check deck appears in admin UI under Organic Chemistry, sort order 7 (after Ch 6 Aldehydes and Ketones I)
- [ ] Render parallel-cloze cards (10, 13, 18) on device to confirm parallel blanks reveal together
- [ ] Verify special characters (α, β, π, →, ⁻, °, ₂, ₃, ₄) render cleanly on mobile
