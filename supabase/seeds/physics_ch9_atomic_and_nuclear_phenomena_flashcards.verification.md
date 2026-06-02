# Verification — Physics Chapter 9: Atomic and Nuclear Phenomena

## Deck metadata
- **Title:** Atomic and Nuclear Phenomena
- **Section:** `physics`
- **Topic:** Physics
- **Subtopic:** atomic and nuclear phenomena
- **Sort order:** 9
- **Total cards:** 40

## Subtopic distribution
| Subtopic | Cards | Positions | Share |
|---|---|---|---|
| 9.1 Photoelectric Effect | 9 | 0–8 | 22% |
| 9.2 Absorption and Emission of Light | 5 | 9–13 | 12% |
| 9.3 Nuclear Forces, Binding Energy, and Mass Defect | 7 | 14–20 | 18% |
| 9.4 Nuclear Reactions | 5 | 21–25 | 12% |
| 9.5 Radioactive Decay | 9 | 26–34 | 23% |
| 9.6 Half-Life and Exponential Decay | 5 | 35–39 | 13% |

## v6 compliance checks
- ✅ All cards original Praxis Prep prose synthesized from textbook framing; no verbatim or near-verbatim lifts from .apkg/.docx
- ✅ Every card uses cloze format `{{cN::…}}`
- ✅ `cloze_count` equals the number of distinct cN groups per card
- ✅ Card length: every answer prose ≤ ~32 words
- ✅ Cloze groups per card: ≤ 4 distinct cN labels everywhere
- ✅ Parallel concepts clozed together:
  - Card 17 (position 16): four fundamental forces — all 4 names parallel under c1
  - Card 24 (position 23): fusion / fission and small / large nuclei — parallel c1 + c2
  - Card 33 (position 32): antineutrino ↔ β⁻ and neutrino ↔ β⁺ — parallel c1 + c2
- ✅ Idempotent: prior versions deleted under all historical title spellings before insert

## Source disposition
- 54 source .apkg notes audited
- 19 major consolidations executed (heavy duplication across photoelectric, decay modes, fusion/fission, binding energy)
- 14 new gap-fill cards added (frequency-vs-intensity rule, standalone E=hf, IR and UV-Vis specifics, weak nuclear force, binding energy per nucleon stability peak, isotopic notation, Z/A meanings, Coulomb barrier in fusion, alpha-particle and positron identity cards, antineutrino vs neutrino convention card, fraction-remaining (½)^n)
- 4 image-only source notes converted to text-only cards (alpha/beta⁻/beta⁺/gamma decay equation diagrams — all reproducible as inline text)
- .docx autocorrect typos silently corrected ("photoelectro", "HF and HFT", incomplete sentences)

## Scientific accuracy verification
- ✅ Photoelectric effect — frequency (not intensity) gates emission — OpenStax College Physics 2e Ch. 29
- ✅ E = hf, W = h·f_T, K_max = hf − W — OpenStax
- ✅ Bohr discrete energy levels + photon energy = ΔE — OpenStax College Physics 2e Ch. 30
- ✅ IR probes vibrations / functional groups; UV-Vis probes electronic transitions / conjugation — OpenStax + cross-checked against organic chemistry references already used this session
- ✅ Fluorescence: multi-step relaxation re-emits longer-wavelength light — OpenStax
- ✅ Strong force: short-range, holds nucleons together — OpenStax University Physics Vol. 3
- ✅ Weak force: short-range, governs beta decay — OpenStax University Physics Vol. 3
- ✅ Mass defect ↔ binding energy via E = mc² — OpenStax
- ✅ Binding energy per nucleon peaks near iron-56 — OpenStax
- ✅ All five decay modes with correct Z and A bookkeeping:
  - α: Z−2, A−4 ✓
  - β⁻: Z+1, A unchanged ✓ (n → p + e⁻ + ν̄)
  - β⁺: Z−1, A unchanged ✓ (p → n + e⁺ + ν)
  - γ: Z and A unchanged ✓
  - electron capture: Z−1, A unchanged ✓ (e⁻ + p → n + ν)
- ✅ Antineutrino with β⁻, neutrino with β⁺ — standard physics convention, matches AAMC
- ✅ Positron = electron mass, charge +1 — OpenStax
- ✅ t½ = 0.693/λ = ln 2 / λ — OpenStax
- ✅ n(t) = n₀ · e^(−λt) — OpenStax
- ✅ Fraction remaining = (½)^n — standard identity
- ✅ 7–8 half-lives ≈ <1% remaining — standard MCAT heuristic
- ✅ Fusion requires extreme T/P to overcome Coulomb barrier — OpenStax

## AAMC scope coverage (CP 4D — Atomic and Nuclear Phenomena)
- ✅ Photoelectric effect (threshold frequency, work function, max KE)
- ✅ Atomic absorption and emission spectra (Bohr model)
- ✅ IR and UV-Vis spectroscopy (concept-level)
- ✅ Fluorescence
- ✅ Nuclear binding energy and mass–energy equivalence
- ✅ Nuclear forces (strong and weak)
- ✅ Nuclear reactions (fusion, fission, isotopic notation)
- ✅ All five radioactive decay modes
- ✅ Half-life and exponential decay (formula, fraction-remaining, complete-decay heuristic)

## Post-deployment QA
- [ ] Run SQL in Supabase
- [ ] Confirm `RAISE NOTICE 'Seeded deck <uuid> with 40 cards.'` fires
- [ ] Spot-check deck appears in admin UI under Physics → Chapter 9
- [ ] Render cards 17, 24, 33 on device to confirm parallel-cloze blanks reveal together
- [ ] Verify equation formatting (E = hf, K_max = hf − W, E = mc², t½ = 0.693/λ, n = n₀ · e^(−λt), (½)^n) renders cleanly on mobile
