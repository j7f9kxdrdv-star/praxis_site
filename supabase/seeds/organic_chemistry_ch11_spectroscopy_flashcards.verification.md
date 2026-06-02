# Verification Report — Organic Chemistry Ch 11: Spectroscopy

**Deck:** Spectroscopy
**Source SQL:** supabase/seeds/organic_chemistry_ch11_spectroscopy_flashcards.sql
**Verified:** 2026-06-02

## Summary

- Total cards: 51
- Confidence 5: 50
- Confidence 4: 1
- Confidence 3: 0
- Confidence 2: 0
- Confidence 1: 0
- `needs_sme_review`: 0
- Dropped during editorial pass: 0
- Split for length compliance: 0
- Consolidated for redundancy: ~10 source notes → ~5 cards

**Length-compliance check (per v6 CARD LENGTH & FOCUS rule):**
- All 51 cards confirmed ≤ 40 words of answer prose
- All 51 cards confirmed ≤ 4 cloze blanks
- One discrete concept per card — no over-budget exceptions used
- **Parallel-concept clozing rule applied throughout**: 4 vibration types (sym/asym × bend/stretch), stretch vs bend, alcohol vs COOH O-H, HOMO/LUMO pair, energy gap → wavelength, α/β nuclear states, downfield/upfield, splitting patterns (singlet/doublet/triplet/quartet)

**Primary references:**
- LibreTexts Organic Chemistry (IR Spectroscopy; UV-Vis Spectroscopy; NMR Spectroscopy)
- AAMC Content Outline 2026, Foundation 5D Concept 4 (Spectroscopy)

## Per-card verification

### Card 0 — IR overview
**Cloze claim:** IR measures absorption of IR light → vibrational excitation; used to identify functional groups.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry (IR Spectroscopy Introduction).

### Card 1 — IR wavelength range
**Cloze claim:** ~700 nm to 1 mm; organic spectroscopy uses mid-IR.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

### Card 2 — IR spectrum plot
**Cloze claim:** % transmittance vs wavenumber (cm⁻¹); scan range 4000-400 cm⁻¹.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

### Card 3 — Four vibration modes
**Cloze claim:** Symmetric/asymmetric stretch and bend.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry (IR Vibrational Modes).

### Card 4 — Stretch vs bend
**Cloze claim:** Stretch changes bond length; bend changes bond angle.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

### Card 5 — Dipole change rule
**Cloze claim:** Vibration must change bond dipole moment to be IR-active.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

### Card 6 — Symmetric molecules don't absorb
**Cloze claim:** N₂, O₂, H₂ don't absorb IR; no dipole change.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

### Card 7 — Transmittance
**Cloze claim:** Fraction of incident light reaching detector; absorption = dip in transmittance.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

### Card 8 — Fingerprint region range
**Cloze claim:** 1500-400 cm⁻¹; unique peak pattern per molecule.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

### Card 9 — Fingerprint region use
**Cloze claim:** Confirms identity by pattern matching; functional groups appear above 1500 cm⁻¹.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

### Card 10 — O-H stretch broadness
**Cloze claim:** Broad due to hydrogen bonding spreading frequencies.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

### Card 11 — O-H alcohol vs COOH
**Cloze claim:** Alcohol O-H ~3300 cm⁻¹; COOH O-H ~3000 cm⁻¹ (broader).
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

### Card 12 — Why COOH O-H is shifted (CORRECTED)
**Cloze claim:** Adjacent carbonyl pulls electron density out of O-H bond, weakening it → lower wavenumber.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry. **Correction:** .docx para 18 has "lowerwave number" typo; corrected to standard "lower wavenumber" terminology.

### Card 13 — C=O peak
**Cloze claim:** Sharp, intense peak ~1700 cm⁻¹; in aldehydes, ketones, COOH, esters, amides.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

### Card 14 — N-H stretch (CORRECTED)
**Cloze claim:** ~3300 cm⁻¹ sharp peak (vs O-H broad); in amines, imines, amides.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry. **Correction:** .docx para 20 has "End-to-H" autocorrect; corrected to N-H.

### Card 15 — IR diagnostic summary
**Cloze claim:** ~3300 broad = O-H; ~3300 sharp = N-H; ~1700 sharp = C=O.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

### Card 16 — UV-Vis overview
**Cloze claim:** Absorption of UV/visible light excites electrons to antibonding orbitals.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry (UV-Vis Spectroscopy Introduction).

### Card 17 — UV spectrum plot
**Cloze claim:** Absorbance vs wavelength (nm); λ_max = peak absorbance.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

### Card 18 — UV-excitable electrons
**Cloze claim:** π electrons or nonbonding electrons.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

### Card 19 — Inert solvent for UV
**Cloze claim:** Inert, non-absorbent solvent to avoid background interference.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

### Card 20 — HOMO/LUMO definitions
**Cloze claim:** HOMO = highest occupied; LUMO = lowest empty.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

### Card 21 — UV excitation HOMO → LUMO
**Cloze claim:** Electron promoted from HOMO to LUMO; photon energy must match gap.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

### Card 22 — Smaller gap → longer wavelength
**Cloze claim:** Smaller HOMO-LUMO gap → longer λ absorbed (toward visible).
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

### Card 23 — π → π* and n → π* transitions
**Cloze claim:** π → π* in alkenes/aromatics; n → π* for carbonyl nonbonding electrons.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

### Card 24 — Conjugation lowers gap (CORRECTED)
**Cloze claim:** Increased conjugation lowers gap → λ_max ↑ (red shift).
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry. **Correction:** .docx para 33 has "Conjugation chips see absorption spectrum" autocorrect garble; corrected.

### Card 25 — λ_max reveals conjugation extent
**Cloze claim:** Longer conjugation → larger λ_max.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

### Card 26 — NMR overview
**Cloze claim:** Probes magnetic environments of ¹H/¹³C nuclei to determine structure.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry (NMR Spectroscopy Introduction).

### Card 27 — α vs β nuclear states
**Cloze claim:** Lower-energy α aligned WITH field; higher-energy β aligned AGAINST it.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

### Card 28 — Resonance condition
**Cloze claim:** RF pulse energy must match α→β gap; flip = resonance.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

### Card 29 — Chemical shift definition
**Cloze claim:** δ in ppm of operating frequency; scale comparable across field strengths.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

### Card 30 — TMS calibration (CORRECTED)
**Cloze claim:** Tetramethylsilane = 0 ppm reference.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry. **Correction:** .docx para 43 has "Tetramethylsaline" autocorrect — saline is wrong (NaCl); silane (Si(CH₃)₄) is correct.

### Card 31 — ppm field-independence
**Cloze claim:** 5 ppm is the same δ on 60 MHz or 600 MHz instrument.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

### Card 32 — Downfield vs upfield
**Cloze claim:** Left = downfield (higher δ); right = upfield (lower δ).
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

### Card 33 — Deshielding mechanism
**Cloze claim:** EW group pulls electron density away from proton; nucleus feels external field more.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

### Card 34 — Deshielding direction
**Cloze claim:** Deshielded → downfield; shielded → upfield.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

### Card 35 — ¹H NMR + MRI
**Cloze claim:** Proton NMR most common; MRI uses same principle.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

### Card 36 — Chemically equivalent protons
**Cloze claim:** Same magnetic environment → single combined peak.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

### Card 37 — Ethanol example
**Cloze claim:** CH₃-CH₂-OH = 3 distinct sets of equivalent H → 3 peaks.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

### Card 38 — Integration
**Cloze claim:** Area under peak ∝ number of protons producing peak.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

### Card 39 — Spin-spin coupling
**Cloze claim:** Interaction between magnetic moments of neighboring non-equivalent protons → multiplets.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

### Card 40 — n+1 rule
**Cloze claim:** n non-equivalent neighbors → n+1 peaks; 3 neighbors → quartet.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

### Card 41 — Splitting pattern names
**Cloze claim:** 0/1/2/3 neighbors → singlet/doublet/triplet/quartet.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

### Card 42 — Coupling constant J
**Cloze claim:** Spacing between split peaks; in Hz; coupled protons share J value.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

### Card 43 — sp³ H range
**Cloze claim:** 0-3 ppm.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

### Card 44 — sp² H range
**Cloze claim:** 4.6-6.0 ppm (vinyl/alkene H).
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

### Card 45 — sp H range
**Cloze claim:** 2.0-3.0 ppm (terminal alkyne H); ring-current shielding makes it counterintuitively similar to sp³.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

### Card 46 — α-to-carbonyl H
**Cloze claim:** ~2-3 ppm; moderately deshielded by C=O.
**Confidence:** 4
**Source:** LibreTexts Organic Chemistry. Standard MCAT-prep value; OpenStax frames α-protons more broadly across functional groups.

### Card 47 — Aromatic H
**Cloze claim:** 6.0-8.5 ppm; deshielded by ring current.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

### Card 48 — Aldehyde H
**Cloze claim:** 9-10 ppm; deshielded by C=O.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

### Card 49 — Carboxylic acid H (CORRECTED)
**Cloze claim:** 10.5-12 ppm; most deshielded common proton on MCAT NMR spectra.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry. **Correction:** .docx para 58 has "These shielded carbosilic acids" — two autocorrects (shielded should be deshielded; carbosilic should be carboxylic). Corrected.

### Card 50 — Deshielding summary rule
**Cloze claim:** More electron density pulled away → more deshielded → further downfield.
**Confidence:** 5
**Source:** LibreTexts Organic Chemistry.

## needs_sme_review

None. All 51 cards rated confidence 4 or 5.

## Disagreements with corpus

No material factual disagreements. The chapter outline (.docx) and Anki deck (.apkg) were factually consistent with LibreTexts; issues were limited to autocorrect typos and minor grammatical errors.

The one confidence-4 card (46 α-to-carbonyl proton chemical shift) uses standard MCAT-prep framing; the exact shift range depends on the specific carbonyl context (ketone vs ester vs amide) and the broader α-to-carbonyl range is sometimes cited as 2.0-2.7 ppm in introductory texts.

## Discrepancies between primary and secondary sources

None encountered. LibreTexts Organic Chemistry treats IR, UV-Vis, and NMR spectroscopy consistently across its relevant chapters.

## Source-material discrepancies corrected during editorial pass

The chapter outline document contained multiple autocorrect typos. The Anki deck was factually sound but had 9 back-field images. All issues were corrected against the reference textbook before any card was written:

1. .docx para 14 — "must resulting in" → "must result in" (grammar).
2. .docx para 18 — "lowerwave number" → "lower wavenumber" (missing space; Card 12).
3. .docx para 20 — "End-to-H bonds" → N-H bonds (autocorrect; Card 14).
4. .docx para 33 — "Conjugation chips see absorption spectrum" → "Conjugation shifts the absorption spectrum" (autocorrect garble; Card 24).
5. .docx para 43 — "Tetramethylsaline" → tetramethylsilane (TMS) (autocorrect; Card 30).
6. .docx para 55 — "more than four shifts" → "more than four lines/peaks" (autocorrect).
7. .docx para 58 — "These shielded carbosilic acids" → "Deshielded carboxylic acids" (two autocorrects in one phrase; Card 49).
8. **9 .apkg back-field images** (IR spectra of carboxylic acids, NMR shift charts, fingerprint region highlights) — stripped per text-only deck policy; conceptual content preserved in card prose.

---

## Post-verification SME decisions

*(Empty section reserved for future SME or content owner to log overrides, retentions, or revisions made after the report was generated.)*
