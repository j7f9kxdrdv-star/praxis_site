# Verification Report — General Chemistry Ch 1: Inside the Atom — From Nucleus to Quantum Shells

**Deck:** Inside the Atom — From Nucleus to Quantum Shells
**Source SQL:** supabase/seeds/general_chemistry_ch1_inside_the_atom_flashcards.sql
**Section / Topic:** chemistry / General Chemistry
**Verified:** 2026-04-26
**Corpus:**
- openstax-chemistry-atoms-first-2e.txt (primary — atomic structure, quantum mechanics, electron configuration; Ch 2 §2.3 and Ch 3 throughout)
- openstax-college-physics-2e.txt (secondary — photon energy, Bohr model, Lyman/Balmer/Paschen series; Ch 30)

## Summary

- Total cards: 40
- Confidence 5: 32
- Confidence 4: 8
- Confidence 3: 0
- Confidence 2: 0
- Confidence 1: 0
- Cards flagged for needs_sme_review: 0
- Cards where corpus contradicts card: 0

## Per-card verification

### Card 0 — Proton fundamentals
**Cloze claim:** Protons carry positive charge, sit in the nucleus, and proton count = atomic number = element identity.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §2.3, lines 3689–3691; §2.3, lines 3711–3717.
**Excerpt:** "A proton has a mass of 1.0073 amu and a charge of 1+." / "the number of protons in the nucleus of an atom… defines the identity of an element and is called its atomic number."

### Card 1 — Neutron fundamentals
**Cloze claim:** Neutrons are neutral, share the nucleus, contribute to atomic mass.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §2.3, lines 3689–3690.
**Excerpt:** "A neutron is a slightly heavier particle with a mass 1.0087 amu and a charge of zero; as its name suggests, it is neutral."

### Card 2 — Electron fundamentals
**Cloze claim:** Electrons are negative, occupy probability regions called orbitals arranged in shells.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §2.3, lines 3690–3691; §3.3, lines 6300+ (orbital definition).
**Excerpt:** "The electron has a charge of 1− and is a much lighter particle…" / orbitals are described as "regions in space" of high probability for finding an electron.
**Notes:** "Orbitals" is used in the same card (Subatomic Particles subtopic) before the formal orbital definition card (Card 25, in the Quantum Mechanical Model subtopic). This is intentional — the term is introduced informally here and rigorously defined later.

### Card 3 — Atomic mass unit definition
**Cloze claim:** 1 amu = 1/12 the mass of a carbon-12 atom; ≈ mass of one proton or neutron.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §2.3, lines 3682–3685.
**Excerpt:** "The unified atomic mass unit is defined as exactly 1/12 of the mass of a single atom of the carbon-12 isotope."

### Card 4 — Atomic number vs mass number
**Cloze claim:** Atomic number Z = proton count (element identity); mass number A = protons + neutrons.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §2.3, lines 3711–3720.
**Excerpt:** "The number of protons in the nucleus… is called its atomic number (Z). The mass number (A) of an atom is the sum of the numbers of protons and neutrons in the nucleus."

### Card 5 — Isotopes
**Cloze claim:** Isotopes = same element (same Z), different neutron counts → different mass numbers, identical chemistry.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §2.3, lines 3739+.
**Excerpt:** "Atoms of the same element that differ only in the number of neutrons are called isotopes."

### Card 6 — Electron shells indexed by n
**Cloze claim:** Electrons live in discrete shells indexed by principal quantum number n; lower n = lower energy, closer to nucleus.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.3, lines 6260+; §3.4 throughout.
**Excerpt:** "Each shell is designated by a principal quantum number n… The smaller the n, the lower the energy and the closer the electron is, on average, to the nucleus."

### Card 7 — Valence electrons
**Cloze claim:** Valence electrons = outermost-shell electrons; govern reactivity and bonding.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.4, lines 6742–6745.
**Excerpt:** "The electrons in the outermost shell orbital(s) (highest value of n) are called valence electrons…"

### Card 8 — Cation vs anion
**Cloze claim:** Cation = lost electrons, positive charge; anion = gained electrons, negative charge.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §2.3, lines 3731–3735.
**Excerpt:** "atom that gains one or more electrons will exhibit a negative charge and is called an anion. Positively charged atoms… cation."

### Card 9 — Atomic mass of an atom
**Cloze claim:** Atomic mass ≈ mass number, reported in amu (1 amu = 1/12 carbon-12).
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §2.3, lines 3682–3691.

### Card 10 — Atomic weight (weighted average of isotopes)
**Cloze claim:** Atomic weight on the periodic table = weighted average of natural isotope masses, weighted by abundance.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §2.3, lines 3776+.
**Excerpt:** "The average mass of an atom of an element… called the average atomic mass… computed by multiplying the mass of each isotope by its fractional abundance."

### Card 11 — Avogadro's number
**Cloze claim:** 1 mole = 6.022 × 10²³ particles (Avogadro's number).
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §2.7, lines 4352–4355.
**Excerpt:** "A mole of substance is that amount in which there are 6.02214076 × 10²³ discrete entities… known as Avogadro's number (Nₐ)."

### Card 12 — Rutherford gold-foil → nuclear model
**Cloze claim:** Gold-foil scattering showed the atom's positive charge and nearly all of its mass are in a tiny dense nucleus; rest is mostly empty space.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §2.2, lines 3593–3613.
**Excerpt:** "A small, relatively heavy, positively charged body, the nucleus, must be at the center of each atom."

### Card 13 — Planck and quanta
**Cloze claim:** Planck resolved blackbody radiation by introducing discrete energy quanta with energy ∝ frequency via h.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.1, lines 5605–5621.
**Excerpt:** "Planck found that by restricting the vibrational energies to discrete values for each frequency…"
**Notes:** Original .apkg Note 10 said Planck "developed the concept of quantized energy levels." This phrasing was reframed — Planck quantized vibrational energies of oscillators (blackbody); Bohr was the one to apply quantization to atomic orbital energy levels. Per HARD RULE on facts vs source, the rewrite uses the more accurate framing.

### Card 14 — Planck's relation + h value
**Cloze claim:** E = hf; h ≈ 6.626 × 10⁻³⁴ J·s.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.1, line 5621.
**Excerpt:** "The value of Planck's constant is very small, 6.626 × 10⁻³⁴ joule seconds (J s)…"

### Card 15 — Bohr's model
**Cloze claim:** Electrons in fixed circular orbits at quantized energies; allowed transitions emit/absorb photons of matching energy.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.2, lines 5854–5895.
**Excerpt:** "Bohr… stipulated that the electron in a hydrogen atom could occupy any of a discrete set of orbits with a corresponding set of discrete energies… When an electron transitions from an excited state… the difference in energy is emitted as a photon."

### Card 16 — Bohr angular momentum
**Cloze claim:** Bohr quantized angular momentum: L = nh/(2π).
**Confidence:** 5
**Source:** openstax-college-physics-2e.txt Ch 30.3 (Bohr's theory of the hydrogen atom); openstax-chemistry-atoms-first-2e.txt §3.2 (Bohr postulates).
**Excerpt (physics):** "Bohr postulated that angular momentum L of the electron is quantized in units of h/2π."

### Card 17 — Bohr energy formula + Rydberg energy constant
**Cloze claim:** E = −R/n² for hydrogen-like atoms; Rydberg unit of energy R ≈ 2.18 × 10⁻¹⁸ J.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.2, lines 5895–5915.
**Excerpt:** "The energy expression for hydrogen-like atoms is a generalization of the hydrogen atom energy, in which Z is the nuclear charge… and k has a value of 2.179 × 10⁻¹⁸ J."
**Notes:** OpenStax uses 2.179 × 10⁻¹⁸ J; rounded to 3 sig figs = 2.18 × 10⁻¹⁸ J. The original .apkg had two cards for this constant — Note 22 with the correct value (2.18 × 10⁻¹⁸ J) and Note 40 with a typo (2.18 × 10⁻¹⁷ J). Note 40 was dropped per pre-flight discussion. The "(used for energy equations)" parenthetical disambiguates this from the Rydberg constant for wavelength on Card 23.

### Card 18 — Excited vs ground state
**Cloze claim:** Electron absorbs photon → excited state; emits photon → returns to ground state.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.2, lines 5876–5890.
**Excerpt:** "the atom is said to be in its ground electronic state… an excited electronic state (or simply an excited state)."
**Notes:** Original .apkg Note 15 used the SAME cloze group ({{c1}}) for both "excited state" and "ground state," which would hide them simultaneously and break the comparison. Fixed to {{c1}} and {{c2}} so they're independently testable.

### Card 19 — E = hc/λ
**Cloze claim:** Photon energy as a function of wavelength: E = hc/λ; c ≈ 3.00 × 10⁸ m/s.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.1 (E = hν, c = λν combined); openstax-college-physics-2e.txt Ch 29.
**Excerpt:** "the speed of light c (3.00 × 10⁸ m/s)" and the relation c = λν → E = hc/λ.

### Card 20 — Atomic emission spectrum
**Cloze claim:** Higher → lower transition emits a photon equal to the energy gap → element-specific emission spectrum.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.2, lines 5870–5885.

### Card 21 — Line spectrum
**Cloze claim:** Discrete allowed transitions → only specific wavelengths appear → line spectrum.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.1 (line spectrum / Balmer); §3.2.

### Card 22 — Absorption spectrum
**Cloze claim:** Atoms absorb only photons that match an allowed transition → element-specific absorption spectrum.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.1; §3.2 lines 5882–5885.
**Excerpt:** "if a photon is absorbed by an atom, the energy of the photon moves an electron from a lower energy orbit up to a more excited one."

### Card 23 — Rydberg formula for wavelength
**Cloze claim:** 1/λ = R(1/n₁² − 1/n₂²); R ≈ 1.097 × 10⁷ m⁻¹.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.1, lines 5803–5806.
**Excerpt:** "Johannes Rydberg generalized Balmer's work and developed an empirical formula… where n₁ and n₂ are integers, n₁ < n₂, and the Rydberg constant (1.097 × 10⁷ m⁻¹)."
**Notes:** The original .apkg Notes 32/33 wrote the formula as `1/λ = R(1/n₁ − 1/n₂)` — missing the squares in the denominators. This is a fact error in the source; the standard form has `1/n₁²` and `1/n₂²`. Corrected in this rewrite. The "(used for wavelength equations)" parenthetical disambiguates this Rydberg constant from the energy-form constant on Card 17.

### Card 24 — Lyman / Balmer / Paschen series
**Cloze claim:** Lyman ends at n=1 (UV), Balmer ends at n=2 (visible+UV), Paschen ends at n=3 (IR).
**Confidence:** 5
**Source:** openstax-college-physics-2e.txt Ch 30.3, lines 69347–69350.
**Excerpt:** "For the Lyman series, [n_f = 1]; for the Balmer series, [n_f = 2]; for the Paschen series, [n_f = 3]… The Lyman series is entirely in the UV, while part of the Balmer series is visible with the remainder UV. The Paschen series and all the rest are entirely IR."

### Card 25 — Orbital definition
**Cloze claim:** Orbital = 3D region of highest probability for finding an electron of given energy; replaces fixed orbits.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.3, lines 6295+.
**Excerpt:** "An atomic orbital is a region of space in which an electron of given energy is most likely to be found."

### Card 26 — Heisenberg uncertainty principle
**Cloze claim:** Cannot simultaneously know position and momentum with arbitrary precision.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.3, lines 6170–6177.
**Excerpt:** "It is fundamentally impossible to determine simultaneously and exactly both the momentum and the position of a particle."

### Card 27 — Pauli exclusion principle
**Cloze claim:** No two electrons in an atom share all four quantum numbers.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.4, lines 6580+.
**Excerpt:** "no two electrons in the same atom can have exactly the same set of all four quantum numbers."

### Card 28 — Principal quantum number n
**Cloze claim:** n = shell label, positive integers ≥ 1, larger n = higher energy / larger average distance.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.3, lines 6260+.
**Excerpt:** "The principal quantum number n… can be any positive integer (1, 2, 3, …)."

### Card 29 — Maximum electrons per shell = 2n²
**Cloze claim:** Max electrons in a shell of principal quantum number n is 2n².
**Confidence:** 4
**Source:** openstax-chemistry-atoms-first-2e.txt §3.3 / §3.4 (derivable from 2(2l+1) summed over l = 0…n−1, which the corpus develops).
**Notes:** OpenStax does not give the closed-form "2n²" identity in a single sentence the way Kaplan-style review books do — it builds it implicitly through orbital-counting tables and the 2(2l+1) per-subshell count. The 2n² formula is mathematically correct and standard. Confidence 4, not 5, because the closed form isn't quoted verbatim in OpenStax.

### Card 30 — Azimuthal quantum number l
**Cloze claim:** l = subshell quantum number, ranges 0 to n − 1.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.3, lines 6300+.
**Excerpt:** "the angular momentum quantum number l, an integer that can have any value from 0 up to n − 1."

### Card 31 — Subshell letters s/p/d/f
**Cloze claim:** l = 0 → s, l = 1 → p, l = 2 → d, l = 3 → f.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.3, lines 6310–6325.
**Excerpt:** "subshells are referred to by letters: l = 0 corresponds to the s subshell, l = 1 to the p subshell, l = 2 to the d subshell, and l = 3 to the f subshell."

### Card 32 — Maximum electrons per subshell = 4l + 2
**Cloze claim:** Max electrons in a subshell of azimuthal quantum number l is 4l + 2 (= 2 × (2l + 1)).
**Confidence:** 4
**Source:** openstax-chemistry-atoms-first-2e.txt §3.3, line 6339; §3.4, line 6535.
**Excerpt:** "of l (that is, in the same subshell) is 2l + 1." → multiplied by 2 (Pauli, two spin states per orbital) yields 4l + 2.
**Notes:** OpenStax states the orbital count per subshell as 2l + 1 and the per-orbital electron capacity as 2 (Pauli); the closed form 4l + 2 is the derivation. Standard in MCAT prep but not stated verbatim by OpenStax. Confidence 4.

### Card 33 — Magnetic quantum number m_l
**Cloze claim:** m_l = orbital orientation, integers from −l to +l (including 0).
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.3, lines 6335+.
**Excerpt:** "the magnetic quantum number m_l can have any integer value from −l to +l."

### Card 34 — Spin quantum number m_s
**Cloze claim:** m_s = electron spin orientation, only +½ or −½.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.3, lines 6395+.
**Excerpt:** "the spin quantum number m_s with values +½ or −½."

### Card 35 — Aufbau principle
**Cloze claim:** Aufbau = fill orbitals in order of increasing energy.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.4, lines 6630–6634.
**Excerpt:** "This procedure is called the Aufbau principle, from the German word Aufbau ('to build up')."

### Card 36 — n + l rule (Madelung rule)
**Cloze claim:** Smaller n + l fills first; ties broken by lower n.
**Confidence:** 4
**Source:** openstax-chemistry-atoms-first-2e.txt §3.4 (orbital ordering by energy); the n + l = "Madelung rule" naming is widespread in MCAT prep but not labeled by name in OpenStax.
**Notes:** OpenStax discusses the orbital-filling order and gives the canonical 1s, 2s, 2p, 3s, 3p, 4s, 3d… sequence, which the n + l rule reproduces. The naming attribution ("Madelung rule" / "n + l rule") is standard in chemistry pedagogy (Klechkowski–Madelung rule) and is included here because the user's chapter outline calls it out by name. Confidence 4 because the named principle isn't explicit in the corpus, even though the underlying ordering is.

### Card 37 — Hund's rule
**Cloze claim:** Electrons singly occupy degenerate orbitals with parallel spins before pairing.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.4, lines 6716–6725.
**Excerpt:** "the lowest-energy configuration for an atom with electrons within a set of degenerate orbitals is that having the maximum number of unpaired electrons" / "These three electrons have unpaired spins."

### Card 38 — Spectroscopic / electron-configuration notation
**Cloze claim:** In notation like 2p⁴: leading number = principal energy level (n), letter = subshell, superscript = number of electrons.
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.4, lines 6650+.
**Excerpt:** "Each electron configuration is written as a string of orbital symbols (e.g., 1s, 2p, 3d), with a superscript showing the number of electrons in that orbital or subshell."

### Card 39 — Paramagnetic vs diamagnetic
**Cloze claim:** Unpaired electrons → paramagnetic (attracted); all paired → diamagnetic (repelled).
**Confidence:** 5
**Source:** openstax-chemistry-atoms-first-2e.txt §3.4 (paramagnetism / diamagnetism, roughly lines 6940+).
**Excerpt:** "Materials with unpaired electrons are paramagnetic and weakly attracted to a magnetic field; materials with no unpaired electrons are diamagnetic and weakly repelled."

## needs_sme_review

None. All 40 cards reach confidence ≥ 4.

## Disagreements with corpus

| # | Issue | Resolution |
|---|---|---|
| Source Note 32/33 (Rydberg wavelength formula) | Source wrote `1/λ = R(1/n₁ − 1/n₂)` with no squares | OpenStax gives the standard form with `1/n₁²` and `1/n₂²`. Corrected on Card 23. |
| Source Note 40 (Rydberg energy constant) | Source wrote `2.18 × 10⁻¹⁷ J` | OpenStax gives `2.179 × 10⁻¹⁸ J`. Note 40 dropped per pre-flight; correct value retained on Card 17. |
| Source Note 15 (excited vs ground state) | Used same `{{c1}}` group for both contrasting concepts | Cloze grouping fixed to `{{c1}}` and `{{c2}}` on Card 18 so the comparison is testable. |
| Source Note 10 (Planck / quantized energy levels) | Source described Planck as "developing quantized energy levels" | Reframed on Card 13 — Planck quantized blackbody oscillator energies; orbital energy levels specifically are Bohr's contribution. |

## Discrepancies between primary and secondary sources

None. Where Cards 16, 19, and 24 drew from both OpenStax General Chemistry and OpenStax College Physics, the two sources agree on all values and naming.

---

## Post-verification SME decisions

*Empty section reserved for the user (or future SME) to log overrides, retentions, or revisions made after this report was written. Each entry: card number, decision, rationale, date.*
