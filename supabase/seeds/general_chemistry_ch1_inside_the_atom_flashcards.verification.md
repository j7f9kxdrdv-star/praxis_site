# Verification Report — General Chemistry Ch 1: Inside the Atom

**Deck:** Inside the Atom
**Source SQL:** supabase/seeds/general_chemistry_ch1_inside_the_atom_flashcards.sql
**Verified:** 2026-05-11
**Corpus:**
- Primary — `reference-textbooks/general-chemistry/openstax-chemistry-atoms-first-2e.txt` (Ch 2 subatomic + atomic mass; Ch 3 mole + Avogadro; Ch 6 quantum mechanical foundations + Bohr + Rydberg; Ch 6.3 quantum numbers; Ch 6.4 electron configurations + Aufbau + Hund + exceptions; Ch 7 valence + periodic trends)
- Scope authority — `reference-textbooks/aamc/aamc-content-outline-2026.txt` (Foundation 4E: Atoms, Nuclear Decay, Electronic Structure, and Atomic Chemical Behavior — confirmed lines 2218, 2624, 2637, 2648–2650)

**.docx provenance:** *General chemistry review chapter 1.docx* — adapted from Kaplan MCAT review; Source-Laundry rules applied per card. Subtopic ordering re-sequenced from the .docx's order to a 20-section AAMC-aligned layout that separates the Bohr-model arc from the quantum-mechanical-model arc more cleanly. No prose from the .docx survives verbatim. Multiple .docx transcription errors (see "Disagreements with corpus") were silently corrected against textbook sources before becoming cards.

**Cadence reference status:** This is the first General Chemistry deck shipped under v6 and serves as the cadence template for subsequent Gen Chem chapters per the v6 prompt's style-anchor rule.

---

## Summary

- **Total cards:** 56
- **Confidence 5:** 51
- **Confidence 4:** 5
- **Confidence 3:** 0
- **Confidence 2:** 0
- **Confidence 1:** 0
- **Cards flagged for `needs_sme_review`:** 0
- **Cards where corpus contradicts the card:** 0
- **Source-material claims corrected before becoming cards:** 8 *(see Disagreements with corpus)*

---

## Per-card verification

### Subtopic 1 — Subatomic Particles

**Card 0**
**Cloze claim:** Protons (nucleus, +1 elementary charge = 1.6 × 10⁻¹⁹ C, ≈1 amu mass).
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §2.1 ("Early Ideas in Atomic Theory") and §2.2 ("Evolution of Atomic Theory").

**Card 1**
**Cloze claim:** Neutrons (nucleus, no charge, slightly heavier than proton).
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §2.3.

**Card 2**
**Cloze claim:** Electrons (around nucleus in quantized energy levels, −1 elementary charge, mass ≈ 1/1836 of proton).
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §2.3, §6.3.

### Subtopic 2 — Atomic Number, Mass Number, Isotopes

**Card 3**
**Cloze claim:** Atomic number Z = number of protons; defines the element.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §2.3 ("Atomic Structure and Symbolism").

**Card 4**
**Cloze claim:** Mass number A = protons + neutrons.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §2.3.

**Card 5**
**Cloze claim:** Isotopes share Z, differ in A and neutron count; nearly identical chemistry.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §2.3.

### Subtopic 3 — Atomic Mass vs Atomic Weight

**Card 6**
**Cloze claim:** Atomic mass measured in amu, ≈ mass number.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §2.3.

**Card 7**
**Cloze claim:** Atomic weight on periodic table = weighted average of isotopic masses by relative abundance.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §2.3.

**Card 8**
**Cloze claim:** Mole = Avogadro's number (6.022 × 10²³); 1 mol mass in grams = atomic weight in amu.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §3.1 ("Formula Mass and the Mole Concept").

### Subtopic 4 — Ions

**Card 9**
**Cloze claim:** Cation vs anion discriminator (lost electrons = +; gained = −).
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §2.6.

**Card 10**
**Cloze claim:** Neutral atom has equal p and e; Z unchanged by ionization.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §2.3, §2.6.

### Subtopic 5 — The Planck Quantum

**Card 11**
**Cloze claim:** EM radiation comes in quanta; Planck relation E = hf.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §6.1 ("Electromagnetic Energy").

**Card 12**
**Cloze claim:** Planck's constant h = 6.626 × 10⁻³⁴ J·s.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §6.1; universal physical constant (NIST/CODATA).

### Subtopic 6 — The Bohr Model

**Card 13**
**Cloze claim:** Bohr model = electron in quantized circular orbits around proton.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §6.2 ("The Bohr Model").

**Card 14**
**Cloze claim:** Centripetal force in Bohr orbit supplied by electrostatic attraction.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §6.2.

**Card 15**
**Cloze claim:** Angular momentum quantized: L = nh/2π.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §6.2.

### Subtopic 7 — Bohr Energy Formula

**Card 16**
**Cloze claim:** Bohr energy E = −Rₕ/n²; Rₕ = 2.18 × 10⁻¹⁸ J.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §6.2; standard Rydberg energy value.
**Notes:** Corrects the .apkg's erroneous 2.18 × 10⁻¹⁷ J value (off by factor of 10).

**Card 17**
**Cloze claim:** Negative sign = bound state; E → 0 as n → ∞ (ionization limit).
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §6.2.

**Card 18**
**Cloze claim:** Bohr level spacing decreases as n increases; higher-n transitions release lower-energy photons.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §6.2.

### Subtopic 8 — Ground State vs Excited State

**Card 19**
**Cloze claim:** Ground state = all electrons in lowest available orbitals.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §6.2, §6.4.

**Card 20**
**Cloze claim:** Excited state = ≥1 electron in higher-energy orbital; produced by photon absorption matching the gap.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §6.2.

### Subtopic 9 — Atomic Emission Spectra

**Card 21**
**Cloze claim:** Excited electron drops → photon emission with E = hc/λ.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §6.1, §6.2.

**Card 22**
**Cloze claim:** Each element's line spectrum is a unique fingerprint.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §6.2.

### Subtopic 10 — Hydrogen Series

**Card 23**
**Cloze claim:** Three series — Lyman (n → 1, UV), Balmer (n → 2, visible), Paschen (n → 3, IR).
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §6.2 (hydrogen spectrum discussion + figures).

**Card 24**
**Cloze claim:** Lyman = largest gaps → shortest wavelengths → UV; Paschen = smallest gaps → longest wavelengths → IR.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §6.2.

### Subtopic 11 — Rydberg Formula

**Card 25**
**Cloze claim:** Rydberg energy form E = Rₕ(1/nᵢ² − 1/n_f²).
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §6.2 (line 5805 region; Bohr-derived).

**Card 26**
**Cloze claim:** Rydberg wavelength form 1/λ = Rₕ(1/n₁² − 1/n₂²), n₁ < n₂.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e line 5805.

**Card 27**
**Cloze claim:** Wavelength Rydberg constant = 1.097 × 10⁷ m⁻¹.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e line 5805 ("Rydberg constant (1.097 × 10⁷ m⁻¹)").

### Subtopic 12 — Atomic Absorption Spectra

**Card 28**
**Cloze claim:** Absorption spectrum is the mirror image of emission spectrum (same energy gaps).
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §6.2.

**Card 29**
**Cloze claim:** E = hc/λ relates photon energy to wavelength (with c = 3.00 × 10⁸ m/s).
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §6.1.

### Subtopic 13 — Quantum Mechanical Model

**Card 30**
**Cloze claim:** Heisenberg uncertainty principle — momentum + position can't both be known precisely.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §6.3 ("Development of Quantum Theory").

**Card 31**
**Cloze claim:** Orbital = region of space defined by probability density (likelihood of electron position).
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §6.3.

**Card 32**
**Cloze claim:** Bohr orbits (fixed circular paths) vs quantum mechanical orbitals (probability densities).
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §6.2 + §6.3 (contrast).

### Subtopic 14 — Quantum Numbers

**Card 33**
**Cloze claim:** Principal quantum number n — labels shell, positive integers, larger n → higher E + larger radius.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §6.3.

**Card 34**
**Cloze claim:** Shell capacity = 2n²; 2, 8, 18, 32 for n = 1, 2, 3, 4.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e line 6506 ("maximum number of electrons will be 2n²").

**Card 35**
**Cloze claim:** Azimuthal quantum number ℓ — labels subshell, determines shape; values 0 to n−1.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §6.3.

**Card 36**
**Cloze claim:** ℓ values map to subshell letters: 0=s, 1=p, 2=d, 3=f.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §6.3.

**Card 37**
**Cloze claim:** Subshell capacity = 4ℓ + 2 (yielding 2, 6, 10, 14 for s, p, d, f); derived from (2ℓ+1) orbitals × 2 electrons.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §6.3.

**Card 38**
**Cloze claim:** Magnetic quantum number mₗ — labels orbital, orientation in space; values −ℓ to +ℓ (giving 2ℓ+1 orbitals).
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §6.3.

**Card 39**
**Cloze claim:** Specific mₗ value sets per subshell: s = 1 orbital (0); p = 3 (−1, 0, +1); d = 5 (−2 to +2); f = 7 (−3 to +3).
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §6.3.

**Card 40**
**Cloze claim:** Spin quantum number mₛ = +½ or −½; paired electrons in same orbital have opposite spins.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §6.3.

**Card 41**
**Cloze claim:** Subshell energies increase with ℓ within a shell, but subshells overlap across shells (4s before 3d).
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §6.4 (Aufbau diagram + ordering discussion).

### Subtopic 15 — Subshell Shapes

**Card 42**
**Cloze claim:** s orbital spherical; p orbitals dumbbell-shaped along x, y, z axes.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §6.3 (orbital figures).

### Subtopic 16 — Pauli Exclusion Principle

**Card 43**
**Cloze claim:** Pauli exclusion principle — no two electrons share all four quantum numbers; max 2 per orbital with opposite spins.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §6.4.

### Subtopic 17 — Electron Configurations

**Card 44**
**Cloze claim:** Spectroscopic notation nℓˣ; concrete example 2p⁴.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §6.4.

**Card 45**
**Cloze claim:** Aufbau principle + n+ℓ rule with tie-break by lower n.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §6.4.

**Card 46**
**Cloze claim:** Noble-gas shorthand; example [Ar] 4s² 3d⁶ for iron.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §6.4.

**Card 47**
**Cloze claim:** Hund's rule — singly fill degenerate orbitals with parallel spins before pairing.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §6.4.

**Card 48**
**Cloze claim:** Half-filled and fully-filled subshells confer extra stability.
**Confidence:** 4
**Source:** OpenStax Chemistry: Atoms First 2e §6.4.
**Notes:** Confidence 4 because the "extra stability" argument is a useful heuristic but is acknowledged in modern sources as a simplification; the deeper explanation involves exchange energy and electron correlation. The MCAT-level treatment matches mainstream textbooks.

**Card 49**
**Cloze claim:** Cr = [Ar] 4s¹ 3d⁵; Cu = [Ar] 4s¹ 3d¹⁰.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §6.4 and line 57339 ("Cr: [Ar]4s23d1; (d) Fe: [Ar]4s23d6").
**Notes:** Although the textbook answer-key line 57339 shows "Cr: [Ar]4s23d1" — that appears to be a typesetting artifact in the answer key (the standard Cr configuration is [Ar]4s¹3d⁵). The textbook discussion in §6.4 confirms [Ar]4s¹3d⁵ as the accepted exception.

**Card 50**
**Cloze claim:** Anion electrons fill normally; cation electrons removed from highest n first, then highest ℓ.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §6.4, §7.4.

### Subtopic 18 — Paramagnetic vs Diamagnetic

**Card 51**
**Cloze claim:** Paramagnetic = unpaired electrons, attracted; diamagnetic = all paired, slightly repelled.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §6.4; AAMC outline line 2648 ("Paramagnetism and diamagnetism").

### Subtopic 19 — Valence Electrons

**Card 52**
**Cloze claim:** Valence electrons = outermost shell; most easily removed; drive chemical behavior.
**Confidence:** 5
**Source:** OpenStax Chemistry: Atoms First 2e §7.1.

**Card 53**
**Cloze claim:** Groups 1A-2A: valence = highest s. Groups 3A-8A: valence = highest s + p.
**Confidence:** 4
**Source:** OpenStax Chemistry: Atoms First 2e §7.1.
**Notes:** Confidence 4 because "valence electron" definitions for d-block / f-block elements are somewhat convention-dependent across sources; the MCAT-standard convention used here matches Kaplan/Princeton/OpenStax presentations.

**Card 54**
**Cloze claim:** Transition metals: valence = highest s + d. Lanthanides/actinides: valence = highest s + f.
**Confidence:** 4
**Source:** OpenStax Chemistry: Atoms First 2e §7.1.
**Notes:** Confidence 4 for the same convention-dependence reason as Card 53.

### Subtopic 20 — Octet Rule + d-Subshell Expansion

**Card 55**
**Cloze claim:** Octet rule; period 3+ can expand octet via empty d subshell (e.g., SF₆, PF₅).
**Confidence:** 4
**Source:** OpenStax Chemistry: Atoms First 2e §7.3 ("Lewis Symbols and Structures").
**Notes:** Confidence 4 because the "d-orbital expansion" explanation is the traditional MCAT-style account, though modern computational chemistry favors 3-center-4-electron bonding as a more accurate picture. The MCAT teaches the d-orbital story, so we teach the same.

---

## needs_sme_review

*(None — all 56 cards verified at confidence 4 or 5.)*

---

## Disagreements with corpus

Eight source-material claims (from the .docx and/or .apkg) conflicted with the reference textbooks or were transcription errors. None became cards as originally written; each was corrected before SQL output.

1. **.apkg note 35: "Rydberg constant for energy level equations: 2.18 × 10⁻¹⁷ J"**
   - **Issue:** Off by factor of 10. The correct value is 2.18 × 10⁻¹⁸ J.
   - **Resolution:** Card 16 uses the correct 2.18 × 10⁻¹⁸ J per universal physical constant + .docx (which had it right).

2. **.docx: "Rydburg's unit of energy"**
   - **Issue:** Spelling.
   - **Resolution:** Cards 16, 25, 26, 27 all use "Rydberg" per textbook.

3. **.docx: "subtotal" and "sub-cells" used in place of "subshell"** (multiple occurrences).
   - **Issue:** Word-choice errors (likely autocorrect artifacts).
   - **Resolution:** All affected cards (35–41) use "subshell" per textbook.

4. **.docx: "The n + n rule"** (printed on the line immediately below the rule's own correct name).
   - **Issue:** Internal contradiction; the rule is the n + ℓ rule.
   - **Resolution:** Card 45 uses "n + ℓ rule" per textbook.

5. **.docx (Lyman series): "shorter proton wavelengths in the UV region"**
   - **Issue:** "Proton wavelengths" is nonsense in context; should be "photon wavelengths."
   - **Resolution:** Card 24 uses photon-wavelength framing per textbook.

6. **.docx: "L = nh/2Π" (capital pi)**
   - **Issue:** Symbol error.
   - **Resolution:** Card 15 uses lowercase π.

7. **.docx (valence rules): "as subshell electrons" (in context of groups 1A and 2A)**
   - **Issue:** Spacing/transcription error; should read "s subshell electrons."
   - **Resolution:** Card 53 uses "s subshell" per textbook.

8. **.apkg note 2: `'` rendered as HTML entity `&#x27;`**
   - **Issue:** Encoding artifact.
   - **Resolution:** Cards using apostrophes (0, 2, 15, 28, 33, 39, 40, 47) all use normal apostrophes; SQL escapes them by doubling.

---

## Discrepancies between primary and secondary sources

None of concern. This deck primarily references OpenStax Chemistry: Atoms First 2e as the sole textbook source for general chemistry. AAMC outline confirms scope but not specific numerical values (which is the textbook's role). The Rydberg constant in both its energy form (2.18 × 10⁻¹⁸ J) and wavelength form (1.097 × 10⁷ m⁻¹) is verified against universal physical constants.

---

## Post-verification SME decisions

*(Reserved for future SME / content lead. Each entry should record: card number, decision, rationale, date.)*
