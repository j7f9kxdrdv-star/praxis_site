# Verification — Organic Chemistry Chapter 3: Bonding

## Deck metadata
- **Title:** Bonding
- **Section:** `organic_chemistry`
- **Topic:** Organic Chemistry
- **Subtopic:** bonding
- **Sort order:** 3
- **Total cards:** 32

## Subtopic distribution
| Subtopic | Cards | Positions | Share |
|---|---|---|---|
| 3.1 Atomic Orbitals and Quantum Numbers | 9 | 0–8 | 28% |
| 3.2 Molecular Orbitals | 10 | 9–18 | 31% |
| 3.3 Hybridization and Resonance | 13 | 19–31 | 41% |

## v6 compliance checks
- ✅ All cards original Praxis Prep prose synthesized from textbook framing
- ✅ Every card uses cloze format `{{cN::…}}`
- ✅ `cloze_count` equals the number of distinct cN groups per card
- ✅ Card length: every answer prose ≤ ~40 words
- ✅ Cloze groups per card: ≤ 4 distinct cN labels everywhere (cards 2, 21, 22 sit at the max)
- ✅ Parallel concepts clozed together:
  - Card 0 (4 quantum numbers): all 4 parallel under c1
  - Card 5 (s/p/d orbital shapes): all 3 parallel under c1 + c2
  - Card 10 (bonding vs antibonding): parallel terms + parallel descriptors
  - Card 13 (single/double/triple): parallel under c1, c2, c3
  - Card 15 (rotation): single vs double/triple parallel under c1 + c2
  - Card 23 (s-character percentages): all 3 hybridizations parallel under c1 + c2
- ✅ Idempotent: prior versions deleted under all historical title spellings before insert

## Source disposition
- 39 source .apkg notes audited
- 14 consolidations (paired duplicate quantum-number cards, bonding/antibonding pairs, sigma/pi pairs, hybridization s-character pairs)
- 5 new gap-fill cards added (4-quantum-number overview, d-orbital shape, Pauli 2-electrons-per-orbital, pi-requires-sigma-first, resonance-restricts-rotation)
- 5 image-only cards from .apkg converted to text-only (sp² alkene structure, MO energy diagram, Schrödinger equation, sp hybrid orbital lobes, 1s/2s/3s radial node diagram) — all describable in text per user-approved decision
- 7 .docx autocorrect typos silently corrected:
  - Para 14: "A d-orbital it is composed of" → "is composed of"
  - Para 21: "bonding orbitals produced" → "bonding orbital is produced"
  - Para 22: same fix for antibonding
  - Para 27: garbled pi-bond/double-bond sentence restated cleanly
  - Para 39: "Double bonds and compounds" → "in compounds"
  - Para 48: "1 s- and 3 p-orbitals" formatting cleaned
  - Para 58: "These orbitals rules have" → "These orbitals have"

## Scientific accuracy verification
- ✅ Four quantum numbers (n, l, m_l, m_s) — OpenStax Chemistry: Atoms First 2e Ch. 3
- ✅ n = energy level + size; smaller n closer to nucleus — verified
- ✅ l = subshell shape; range 0 to n−1; 0/1/2/3 → s/p/d/f — verified
- ✅ m_l = orbital orientation; range −l to +l — verified
- ✅ m_s = spin; only ±1/2 — verified
- ✅ s spherical, p dumbbell with nuclear node, d cloverleaf with two nodes (plus the d_z² donut-and-lobe shape) — OpenStax + LibreTexts
- ✅ Node = zero probability region — OpenStax
- ✅ Pauli exclusion: 2 electrons per orbital with opposite spins — OpenStax
- ✅ Schrödinger equation framework; |ψ|² = probability density — OpenStax
- ✅ MO formation via constructive/destructive wave-function combination — OpenStax Ch. 8
- ✅ Bonding MO lower energy / more stable; antibonding higher / less stable — verified
- ✅ Sigma bond by head-to-head overlap; every single bond is sigma — LibreTexts Organic
- ✅ Pi bond by side-by-side p orbital overlap — LibreTexts
- ✅ Bond composition: single (1σ), double (1σ + 1π), triple (1σ + 2π) — verified
- ✅ Pi requires sigma first (geometric constraint — parallel p orbitals) — LibreTexts
- ✅ Single bond free rotation, double/triple restricted rotation — verified
- ✅ More bonds → shorter + stronger — verified
- ✅ Pi bond individually weaker than sigma; bond strengths additive overall — verified
- ✅ Partial double-bond character (resonance) also restricts rotation — LibreTexts
- ✅ Hybrid orbital formation by mixing s + p orbitals — OpenStax Ch. 8
- ✅ sp³: 1s + 3p, 109.5° tetrahedral, alkanes — verified
- ✅ sp²: 1s + 2p, 120° trigonal planar, 1 unhybridized p forms pi bond, alkenes — verified
- ✅ sp: 1s + 1p, 180° linear, 2 unhybridized p form 2 pi bonds, alkynes — verified
- ✅ s-character: sp³ 25%, sp² 33%, sp 50% — verified
- ✅ More s-character → shorter + stronger bonds — LibreTexts
- ✅ Resonance = delocalization of pi electrons or lone pairs — LibreTexts
- ✅ Conjugation requires alternating single and multiple bonds — verified
- ✅ Conjugated p orbital backbone enables continuous overlap — LibreTexts
- ✅ Delocalization increases stability — verified
- ✅ Conjugation enables UV absorption; more conjugation → longer wavelength — OpenStax (also covered in OrgChem Ch 11 Spectroscopy deck)
- ✅ Resonance forms differ only in electron placement, not atom positions — LibreTexts
- ✅ True electron density = weighted average favoring most stable resonance form — verified

## AAMC scope coverage
- **CP 4A — Atomic structure** (quantum numbers, orbitals, electronic configuration) ✓
- **CP 5A — Bonding** (MO theory, sigma/pi, hybridization) ✓
- **CP 5B — Stereochemistry support** (geometry from hybridization) ✓
- **CP 5C — Reaction support** (resonance and conjugation set up later reactivity chapters) ✓

## Cross-deck linkage
- Quantum number content reinforces General Chemistry Ch 1 (Inside the Atom)
- Sigma/pi bonding reinforces General Chemistry Ch 3 (Bonding & Chemical Interactions)
- UV absorption from conjugation reinforces Organic Chemistry Ch 11 (Spectroscopy) — particularly the UV-Vis card
- Per user direction, crossover cards retained for spaced-repetition reinforcement with organic-specific framing (alkane/alkene/alkyne mapping in the hybridization cards)

## Post-deployment QA
- [ ] Run SQL in Supabase (no prerequisite migration)
- [ ] Confirm `RAISE NOTICE 'Seeded deck <uuid> with 32 cards.'` fires
- [ ] Spot-check deck appears in admin UI under Organic Chemistry, sort order 3 (after Naming and Isomerism, before Nitrogen and Phosphorus)
- [ ] Render parallel-cloze cards (0, 5, 10, 13, 15, 23) on device to confirm parallel blanks reveal together
- [ ] Verify special characters (σ, π, ψ, ²⁻, ², °, ψ², —, ×) render cleanly on mobile
