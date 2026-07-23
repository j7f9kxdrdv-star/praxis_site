-- ============================================================
-- Praxist Prep — Flashcard Seed
-- Deck: Inside the Atom
-- Section: chemistry · Topic: General Chemistry
--
-- Coverage: subatomic particles (protons, neutrons, electrons —
-- charges, locations, masses, fundamental charge); atomic
-- number, mass number, isotopes; atomic mass vs atomic weight
-- (incl. Avogadro's number and the mole); cations vs anions;
-- the Planck quantum (E = hf, h = 6.626 × 10⁻³⁴ J·s); the Bohr
-- model (quantized circular orbits, electrostatic centripetal
-- force, angular momentum quantization L = nh/2π); the Bohr
-- energy formula E = −Rₕ/n² with Rₕ = 2.18 × 10⁻¹⁸ J and the
-- bound-state interpretation; ground state vs excited state;
-- atomic emission spectra (line spectra as element fingerprints);
-- the hydrogen series (Lyman → n=1 UV, Balmer → n=2 visible,
-- Paschen → n=3 IR) with energy/wavelength comparison; the
-- Rydberg formula in energy and wavelength forms (with
-- Rₕ = 1.097 × 10⁷ m⁻¹ for the wavelength form); atomic
-- absorption spectra and E = hc/λ; the quantum mechanical
-- model (Heisenberg uncertainty, orbitals as probability
-- densities, Bohr vs quantum orbital distinction); the four
-- quantum numbers (n, ℓ, mₗ, mₛ) with shell capacity 2n²,
-- subshell capacity 4ℓ+2, and the ℓ → s/p/d/f mapping;
-- subshell shapes (s spherical; p dumbbell on axes); the Pauli
-- exclusion principle; electron configurations and
-- spectroscopic notation, Aufbau principle + n+ℓ rule,
-- noble-gas shorthand, Hund's rule, half/fully-filled
-- stability, Cr/Cu exceptions, anion/cation filling rules;
-- paramagnetism vs diamagnetism; valence electrons by group
-- (1A-2A, 3A-8A, transition, lanthanide/actinide); and the
-- octet rule with d-subshell expansion in period 3+.
--
-- All cards are CLOZE-format. Cards are ORIGINAL Praxist Prep
-- content — written from the underlying chemistry and
-- re-sourced from the reference textbooks listed in the
-- companion verification.md file; no prose is lifted from any
-- third-party source.
--
-- Subtopic ordering follows the AAMC content outline
-- (Foundation 4E: Atoms, Nuclear Decay, Electronic Structure,
-- and Atomic Chemical Behavior), NOT the source .docx's
-- chapter ordering.
--
-- This deck is the cadence reference for subsequent General
-- Chemistry chapters under v6 (per the prompt's style-anchor
-- rule for new subjects).
--
-- Idempotent: re-running deletes the prior version of this
-- deck and re-seeds. User review history attached to those
-- cards (flashcard_user_state, flashcard_reviews) cascades.
-- ============================================================

DO $$
DECLARE
  deck UUID;
BEGIN
  -- Wipe any prior copy of this deck (across any historical titles)
  DELETE FROM flashcard_decks
   WHERE section = 'chemistry'
     AND title   IN (
           'Inside the Atom',
           'Inside the Atom — From Nucleus to Quantum Shells',
           'Atomic Structure',
           'Chapter 1 — Inside the Atom',
           'Chapter 1 — Atomic Structure'
         );

  -- Insert deck
  INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
  VALUES (
    'chemistry',
    'General Chemistry',
    'inside_the_atom',
    'Inside the Atom',
    'Subatomic particles and isotopes; atomic mass and the mole; the Planck quantum and Bohr model with quantized energies and angular momentum; atomic emission and absorption spectra and the Rydberg formula (energy and wavelength forms); the quantum mechanical model with Heisenberg uncertainty and orbital probability densities; the four quantum numbers; the Pauli exclusion principle, Aufbau, Hund''s rule, electron configurations with Cr/Cu exceptions; paramagnetism and diamagnetism; valence electrons by group; and octet-rule expansion.',
    1
  )
  RETURNING id INTO deck;

  -- Insert cards
  INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES

  -- ── 1. Subatomic Particles ───────────────────────────────
  (deck,  0, 'cloze',
   '{{c1::Protons}} sit in the nucleus, carry a charge of {{c2::+1 elementary unit (1.6 × 10⁻¹⁹ C)}}, and have a mass of approximately {{c3::one atomic mass unit}} — together with neutrons they account for essentially all of the atom''s mass.', 3),

  (deck,  1, 'cloze',
   '{{c1::Neutrons}} share the nucleus with protons, carry {{c2::no net charge}}, and have a mass only slightly larger than a proton; together with protons they make up nearly the entire mass of the atom.', 2),

  (deck,  2, 'cloze',
   '{{c1::Electrons}} occupy the space surrounding the nucleus in quantized energy levels, carry a charge of {{c2::−1 elementary unit}}, and have a mass roughly {{c3::1/1836}} that of a proton — small enough that the nucleus accounts for essentially all the atom''s mass.', 3),

  -- ── 2. Atomic Number, Mass Number, Isotopes ──────────────
  (deck,  3, 'cloze',
   'The {{c1::atomic number}} (Z) of an atom equals the number of {{c2::protons}} in its nucleus and is what {{c3::defines the element}} — change Z and you change which element you have.', 3),

  (deck,  4, 'cloze',
   'The {{c1::mass number}} (A) is the sum of the {{c2::protons and neutrons}} in the nucleus; it specifies the isotope but not the element.', 2),

  (deck,  5, 'cloze',
   'Atoms with the same {{c1::atomic number}} but different {{c2::mass numbers}} are {{c3::isotopes}}; they differ only in neutron count and share essentially identical chemistry, since chemistry depends on electron count rather than neutron count.', 3),

  -- ── 3. Atomic Mass vs Atomic Weight ──────────────────────
  (deck,  6, 'cloze',
   'The {{c1::atomic mass}} of a specific atom is measured in {{c2::atomic mass units (amu)}} and is approximately equal to its mass number — the sum of protons and neutrons.', 2),

  (deck,  7, 'cloze',
   'The {{c1::atomic weight}} listed on the periodic table is the {{c2::weighted average}} of the masses of an element''s naturally occurring isotopes — weighted by relative abundance, which is why most are non-integer values.', 2),

  (deck,  8, 'cloze',
   'A {{c1::mole}} is the number of items equal to {{c2::Avogadro''s number, 6.022 × 10²³}}; one mole of an element has a mass in grams numerically equal to its atomic weight in amu.', 2),

  -- ── 4. Ions ──────────────────────────────────────────────
  (deck,  9, 'cloze',
   'An atom that has {{c1::lost}} one or more electrons becomes positively charged and is called a {{c2::cation}}; an atom that has {{c1::gained}} electrons becomes negatively charged and is called an {{c2::anion}}.', 2),

  (deck, 10, 'cloze',
   'A {{c1::neutral atom}} contains equal numbers of {{c2::protons}} and {{c2::electrons}}; the elemental identity (Z) is fixed by proton count and is unchanged by ionization.', 2),

  -- ── 5. The Planck Quantum ────────────────────────────────
  (deck, 11, 'cloze',
   'Energy carried by electromagnetic radiation is delivered in discrete packets called {{c1::quanta}}; the energy of one photon is given by the {{c2::Planck relation, E = hf}}, where f is the frequency of the radiation.', 2),

  (deck, 12, 'cloze',
   'Planck''s constant has the value {{c1::h = 6.626 × 10⁻³⁴ J·s}} — the proportionality between a photon''s frequency and its energy and the fundamental quantum of action in quantum mechanics.', 1),

  -- ── 6. The Bohr Model ────────────────────────────────────
  (deck, 13, 'cloze',
   'In the {{c1::Bohr model}} of the hydrogen atom, a single electron travels around the central proton in {{c2::quantized circular orbits}}; only specific orbits are allowed, each corresponding to a discrete energy.', 2),

  (deck, 14, 'cloze',
   'In the Bohr model, the {{c1::centripetal force}} keeping the electron in its circular orbit is supplied by the {{c2::electrostatic attraction}} between the positive proton and the negative electron — far stronger than gravity at the atomic scale.', 2),

  (deck, 15, 'cloze',
   'Bohr postulated that the electron''s angular momentum is quantized as {{c1::L = nh/2π}}, where n is a positive integer (the principal quantum number) — only orbits satisfying this rule are allowed.', 1),

  -- ── 7. Bohr Energy Formula ───────────────────────────────
  (deck, 16, 'cloze',
   'In the Bohr model, the energy of an electron in the nᵗʰ allowed orbit of a hydrogen atom is given by {{c1::E = −Rₕ/n²}}, where Rₕ = {{c2::2.18 × 10⁻¹⁸ J}} is the Rydberg energy constant.', 2),

  (deck, 17, 'cloze',
   'The negative sign in E = −Rₕ/n² reflects that the electron is in a {{c1::bound state}} relative to a free electron at infinity (where E = 0); as n grows, the energy becomes less negative and approaches {{c2::zero}} in the limit of ionization.', 2),

  (deck, 18, 'cloze',
   'As n increases, the {{c1::spacing}} between adjacent Bohr energy levels {{c2::decreases}} — the levels crowd together near zero, meaning transitions between higher-n levels release lower-energy photons than transitions between lower-n levels.', 2),

  -- ── 8. Ground State vs Excited State ─────────────────────
  (deck, 19, 'cloze',
   'An atom is in its {{c1::ground state}} when every electron occupies the {{c2::lowest available}} energy orbital — the configuration with minimum total energy.', 2),

  (deck, 20, 'cloze',
   'When at least one electron is promoted to a {{c1::higher-energy}} orbital than its ground-state position, the atom is in an {{c2::excited state}} — produced by absorbing a photon whose energy exactly matches the gap.', 2),

  -- ── 9. Atomic Emission Spectra ───────────────────────────
  (deck, 21, 'cloze',
   'When an excited electron drops back to a lower energy level, the atom releases the energy difference as a {{c1::photon}} whose wavelength is given by {{c2::E = hc/λ}} — the physical basis of atomic emission spectra.', 2),

  (deck, 22, 'cloze',
   'Because each element has a unique set of energy levels, its emission produces a characteristic {{c1::line spectrum}} of discrete wavelengths — an optical {{c2::fingerprint}} that can be used to identify the element.', 2),

  -- ── 10. Hydrogen Series ──────────────────────────────────
  (deck, 23, 'cloze',
   'Hydrogen''s emission spectrum is sorted by the final energy level of the relaxing electron: {{c1::Lyman}} (n → 1, UV region), {{c1::Balmer}} (n → 2, visible region), and {{c1::Paschen}} (n → 3, IR region).', 1),

  (deck, 24, 'cloze',
   'Because Lyman transitions span the largest energy gaps (down to n = 1), Lyman photons have the {{c1::shortest wavelengths}} and lie in the {{c2::UV}} region; Paschen transitions have the smallest gaps, giving Paschen the {{c1::longest wavelengths}} in the {{c2::infrared}}.', 2),

  -- ── 11. Rydberg Formula ──────────────────────────────────
  (deck, 25, 'cloze',
   'The {{c1::Rydberg formula for energy}} predicts the photon energy of a hydrogen electron transition: {{c2::E = Rₕ(1/nᵢ² − 1/nf²)}}, where nᵢ and nf are the initial and final principal quantum numbers.', 2),

  (deck, 26, 'cloze',
   'The {{c1::Rydberg formula for wavelength}} predicts the photon wavelength of a hydrogen transition: {{c2::1/λ = Rₕ(1/n₁² − 1/n₂²)}}, with n₁ < n₂.', 2),

  (deck, 27, 'cloze',
   'For the wavelength form of the Rydberg formula, the Rydberg constant has the value {{c1::Rₕ = 1.097 × 10⁷ m⁻¹}} — a different numerical form of the same physical constant that appears as 2.18 × 10⁻¹⁸ J in the Bohr energy formula.', 1),

  -- ── 12. Atomic Absorption Spectra ────────────────────────
  (deck, 28, 'cloze',
   'Every element''s {{c1::absorption spectrum}} is the {{c2::mirror image}} of its emission spectrum — the wavelengths absorbed are exactly those the same atom would emit, because the energy gaps between levels are the same in either direction.', 2),

  (deck, 29, 'cloze',
   'A photon''s energy can be calculated from its wavelength using {{c1::E = hc/λ}}, where h is Planck''s constant, c is the speed of light (3.00 × 10⁸ m/s), and λ is the wavelength.', 1),

  -- ── 13. Quantum Mechanical Model ─────────────────────────
  (deck, 30, 'cloze',
   'The {{c1::Heisenberg uncertainty principle}} states that the {{c2::momentum}} and the {{c2::position}} of an electron cannot both be known with arbitrary precision at the same time — the more precisely one is determined, the less precisely the other can be known.', 2),

  (deck, 31, 'cloze',
   'In the quantum mechanical model, an {{c1::orbital}} is a region of space defined by a {{c2::probability density}} — the likelihood of finding the electron at a given location — rather than a fixed circular path.', 2),

  (deck, 32, 'cloze',
   'The {{c1::Bohr model}} pictures electrons in fixed circular orbits with well-defined radii — a useful first approximation but ultimately wrong. The {{c2::quantum mechanical model}} replaces these with probability-density orbitals consistent with the Heisenberg uncertainty principle.', 2),

  -- ── 14. Quantum Numbers ──────────────────────────────────
  (deck, 33, 'cloze',
   'The {{c1::principal quantum number (n)}} labels the shell of an electron; it takes positive integer values starting at 1, and the larger n is, the {{c2::higher}} the electron''s energy and the {{c2::larger}} its average distance from the nucleus.', 2),

  (deck, 34, 'cloze',
   'The maximum number of electrons that can occupy a shell of principal quantum number n is {{c1::2n²}} — giving 2 in n = 1, 8 in n = 2, 18 in n = 3, and 32 in n = 4.', 1),

  (deck, 35, 'cloze',
   'The {{c1::azimuthal (angular momentum) quantum number (ℓ)}} labels the subshell and determines its {{c2::shape}}; for a given n, ℓ takes integer values from {{c3::0 to n − 1}}.', 3),

  (deck, 36, 'cloze',
   'Subshells are named by their ℓ value: ℓ = 0 is the {{c1::s}} subshell, ℓ = 1 is {{c1::p}}, ℓ = 2 is {{c1::d}}, and ℓ = 3 is {{c1::f}}.', 1),

  (deck, 37, 'cloze',
   'The maximum electron capacity of a subshell is {{c1::4ℓ + 2}}, yielding 2 in s (ℓ=0), 6 in p (ℓ=1), 10 in d (ℓ=2), and 14 in f (ℓ=3) — the (2ℓ+1) orbitals per subshell times 2 electrons per orbital under Pauli.', 1),

  (deck, 38, 'cloze',
   'The {{c1::magnetic quantum number (mₗ)}} labels the specific orbital within a subshell and determines its {{c2::orientation in space}}; it takes integer values from {{c3::−ℓ to +ℓ}}, giving {{c3::(2ℓ + 1)}} orbitals per subshell.', 3),

  (deck, 39, 'cloze',
   'Number of orbitals (and allowed mₗ values) per subshell: {{c1::s = 1 orbital (mₗ = 0)}}, {{c1::p = 3 orbitals (mₗ = −1, 0, +1)}}, {{c1::d = 5 orbitals (mₗ = −2 to +2)}}, {{c1::f = 7 orbitals (mₗ = −3 to +3)}}.', 1),

  (deck, 40, 'cloze',
   'The {{c1::spin quantum number (mₛ)}} has only two allowed values, {{c2::+½ or −½}}, corresponding to the electron''s intrinsic spin. Two electrons in the same orbital must have {{c3::opposite spins}}.', 3),

  (deck, 41, 'cloze',
   'Within a shell, subshell energies increase with ℓ (s < p < d < f); but subshell energies overlap across shells — notably, the {{c1::4s}} subshell fills before {{c1::3d}} because its energy is lower despite the larger principal quantum number.', 1),

  -- ── 15. Subshell Shapes ──────────────────────────────────
  (deck, 42, 'cloze',
   'An {{c1::s orbital}} is {{c2::spherical}}, with the nucleus at its center; the three {{c1::p orbitals}} are {{c2::dumbbell-shaped}} and aligned along the x, y, and z axes.', 2),

  -- ── 16. Pauli Exclusion Principle ────────────────────────
  (deck, 43, 'cloze',
   'The {{c1::Pauli exclusion principle}} states that no two electrons in the same atom can share the same set of four quantum numbers — practically, each orbital holds a maximum of {{c2::two}} electrons, and those two must have {{c3::opposite spins}}.', 3),

  -- ── 17. Electron Configurations ──────────────────────────
  (deck, 44, 'cloze',
   'In spectroscopic notation, each subshell is written as {{c1::nℓˣ}}: the {{c2::principal quantum number}} gives the shell, the {{c2::letter}} (s, p, d, f) names the subshell, and the {{c2::superscript}} gives the electron count — e.g., 2p⁴ means four electrons in the 2p subshell.', 2),

  (deck, 45, 'cloze',
   'Electrons fill subshells from lowest to highest energy — the {{c1::Aufbau principle}}. The energy ordering is given by the {{c2::n + ℓ rule}}: lower n + ℓ fills first, and when two subshells tie, the one with lower {{c3::n}} fills first.', 3),

  (deck, 46, 'cloze',
   'An electron configuration can be abbreviated by writing the {{c1::noble gas}} that precedes the element in brackets, then listing only the subsequent subshells — e.g., iron is written as {{c2::[Ar] 4s² 3d⁶}}.', 2),

  (deck, 47, 'cloze',
   '{{c1::Hund''s rule}} states that within a degenerate subshell (e.g., the three p orbitals), electrons singly occupy separate orbitals with {{c2::parallel spins}} before any orbital is doubly filled — an arrangement that minimizes electron-electron repulsion.', 2),

  (deck, 48, 'cloze',
   '{{c1::Half-filled}} and {{c1::fully-filled}} subshells confer an extra stability not predicted by simple Aufbau ordering — the reason chromium and copper deviate from the textbook electron configuration.', 1),

  (deck, 49, 'cloze',
   'Two famous Aufbau exceptions driven by half/fully-filled stability: chromium adopts {{c1::[Ar] 4s¹ 3d⁵}} (rather than the predicted 4s² 3d⁴), and copper adopts {{c2::[Ar] 4s¹ 3d¹⁰}} (rather than 4s² 3d⁹).', 2),

  (deck, 50, 'cloze',
   'For an {{c1::anion}}, the extra electrons fill normally under Aufbau. For a {{c2::cation}}, start from the neutral atom''s configuration and remove electrons from the subshell with the {{c3::highest n}} first; if multiple subshells tie, remove from the {{c3::highest ℓ}}.', 3),

  -- ── 18. Paramagnetic vs Diamagnetic ──────────────────────
  (deck, 51, 'cloze',
   'An atom with {{c1::unpaired}} electrons is {{c2::paramagnetic}} — its electron spins align with an external magnetic field and it is weakly attracted to it. An atom with {{c1::only paired}} electrons is {{c2::diamagnetic}} and slightly repelled by a magnetic field.', 2),

  -- ── 19. Valence Electrons ────────────────────────────────
  (deck, 52, 'cloze',
   '{{c1::Valence electrons}} are those in the outermost energy shell — the electrons most loosely bound, most easily removed, and {{c2::available for chemical bonding}}. They dominate the chemical behavior of the element.', 2),

  (deck, 53, 'cloze',
   'For groups {{c1::1A and 2A}}, only the {{c2::highest s subshell}} electrons count as valence. For groups {{c1::3A through 8A}} (the p-block), valence electrons are those in the {{c2::highest s and p subshells}} combined.', 2),

  (deck, 54, 'cloze',
   'For {{c1::transition metals}}, valence electrons include those in the {{c2::highest s and d subshells}}. For the {{c1::lanthanide and actinide series}}, valence electrons include those in the {{c2::highest s and f subshells}}.', 2),

  -- ── 20. Octet Rule + d-Subshell Expansion ────────────────
  (deck, 55, 'cloze',
   'Atoms tend to fill their valence shell with eight electrons — the {{c1::octet rule}}. Period 3 and below can {{c2::expand the octet}} (hold more than 8 valence electrons) by using their empty {{c3::d subshell}}, which is why sulfur and phosphorus form compounds like SF₆ and PF₅.', 3);

  RAISE NOTICE 'Seeded deck % with % cards.', deck, (SELECT COUNT(*) FROM flashcards WHERE deck_id = deck);
END $$;
