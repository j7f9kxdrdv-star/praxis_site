-- ============================================================
-- Praxist Prep — Flashcard Seed
-- Deck: Inside the Atom — From Nucleus to Quantum Shells
-- Section: chemistry · Topic: General Chemistry
--
-- Coverage: subatomic particles (protons, neutrons, electrons,
-- charges, locations, atomic & mass numbers, isotopes, valence,
-- ions); atomic mass vs atomic weight, Avogadro's number;
-- Rutherford / Planck / Bohr models, the Bohr energy equation,
-- photon emission and absorption, Rydberg formulas (wavelength
-- and energy forms), Lyman/Balmer/Paschen series; quantum
-- mechanical model — orbitals, Heisenberg, the four quantum
-- numbers, Pauli, Aufbau, n+l rule, Hund's rule, electron
-- configuration, paramagnetism vs diamagnetism.
--
-- All cards are CLOZE-format. Cards are original Praxist Prep
-- content (reworded from source material).
--
-- Idempotent: re-running deletes the prior version of this
-- deck and re-seeds. User review history attached to those
-- cards (flashcard_user_state, flashcard_reviews) cascades.
-- ============================================================

DO $$
DECLARE
  deck UUID;
BEGIN
  -- Wipe any prior copy of this deck
  -- (also matches older Kaplan-styled names in case any were previously seeded)
  DELETE FROM flashcard_decks
   WHERE section = 'chemistry'
     AND topic   = 'General Chemistry'
     AND title   IN (
       'Inside the Atom — From Nucleus to Quantum Shells',
       'Atomic Structure',
       'Chapter 1 — Atomic Structure'
     );

  -- Insert deck
  INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
  VALUES (
    'chemistry',
    'General Chemistry',
    'atoms_and_quantum_model',
    'Inside the Atom — From Nucleus to Quantum Shells',
    'Subatomic particles, isotopes and atomic mass, the Rutherford / Planck / Bohr models, hydrogen emission spectra, the Heisenberg principle, the four quantum numbers, and electron configuration rules.',
    1
  )
  RETURNING id INTO deck;

  -- Insert cards
  INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES

  -- ── Subatomic Particles ───────────────────────────────────
  (deck,  0, 'cloze',
   '{{c1::Protons}} carry a {{c2::positive}} charge, sit in the {{c3::nucleus}}, and the count of them in an atom — the atomic number — fixes its element identity.', 3),

  (deck,  1, 'cloze',
   '{{c1::Neutrons}} are electrically {{c2::neutral}}, share the nucleus with protons, and along with protons make up the bulk of an atom''s {{c3::mass}}.', 3),

  (deck,  2, 'cloze',
   '{{c1::Electrons}} carry a {{c2::negative}} charge and occupy regions of probability called {{c3::orbitals}} arranged in shells around the nucleus.', 3),

  (deck,  3, 'cloze',
   'One {{c1::atomic mass unit (amu)}} is defined as exactly {{c2::1/12 the mass of a carbon-12 atom}} — roughly the mass of a single proton or neutron.', 2),

  (deck,  4, 'cloze',
   'The {{c1::atomic number (Z)}} counts the protons in an atom and uniquely identifies the element, whereas the {{c2::mass number (A)}} counts the protons plus the neutrons.', 2),

  (deck,  5, 'cloze',
   '{{c1::Isotopes}} are atoms of the same element — same proton count — that differ in their number of {{c2::neutrons}}, giving each isotope a distinct mass number but identical chemistry.', 2),

  (deck,  6, 'cloze',
   'Electrons are organized into discrete energy {{c1::shells}} indexed by the principal quantum number {{c2::n}}, with shells closer to the nucleus held at lower energy.', 2),

  (deck,  7, 'cloze',
   '{{c1::Valence electrons}} are the electrons in an atom''s {{c2::outermost shell}}, and they govern the atom''s chemical reactivity and bonding behavior.', 2),

  (deck,  8, 'cloze',
   'An atom that has lost electrons becomes a positively charged {{c1::cation}}, while an atom that has gained electrons becomes a negatively charged {{c2::anion}}.', 2),

  -- ── Atomic Mass vs Atomic Weight ──────────────────────────
  (deck,  9, 'cloze',
   'The {{c1::atomic mass}} of a single atom is approximately equal to its mass number and is reported in {{c2::amu}}, where one amu is set to 1/12 the mass of a carbon-12 atom.', 2),

  (deck, 10, 'cloze',
   'An element''s {{c1::atomic weight}} on the periodic table is the {{c2::weighted average}} mass of its naturally occurring isotopes, using each isotope''s natural abundance as the weight.', 2),

  (deck, 11, 'cloze',
   'One mole of any substance contains {{c1::6.022 × 10²³}} particles — a quantity known as {{c2::Avogadro''s number (Nₐ)}} — which links atomic-scale and laboratory-scale masses.', 2),

  -- ── Rutherford, Planck & Bohr ─────────────────────────────
  (deck, 12, 'cloze',
   '{{c1::Rutherford''s}} gold-foil experiment showed that an atom''s positive charge and nearly all of its mass are concentrated in a tiny, dense {{c2::nucleus}}, with the rest of the atom being mostly empty space.', 2),

  (deck, 13, 'cloze',
   '{{c1::Planck}} resolved the blackbody radiation problem by proposing that energy is exchanged in discrete packets called {{c2::quanta}}, each quantum''s energy proportional to frequency through the constant h.', 2),

  (deck, 14, 'cloze',
   'Planck''s relation gives the energy of a photon as {{c1::E = hf}}, where h is Planck''s constant ≈ {{c2::6.626 × 10⁻³⁴ J·s}}.', 2),

  (deck, 15, 'cloze',
   '{{c1::Bohr''s}} hydrogen-atom model placed electrons in discrete circular orbits at {{c2::quantized}} energies; only transitions between those orbits are allowed, and each transition emits or absorbs a {{c3::photon}} whose energy equals the gap.', 3),

  (deck, 16, 'cloze',
   'Bohr postulated that an electron''s orbital {{c1::angular momentum}} in hydrogen is quantized to {{c2::L = nh / 2π}}, where n is the principal quantum number.', 2),

  (deck, 17, 'cloze',
   'In the Bohr model of hydrogen-like atoms, an electron in shell n has energy {{c1::E = −R/n²}}, where R is the Rydberg unit of {{c2::energy}}, ≈ {{c3::2.18 × 10⁻¹⁸ J}} (used for energy equations).', 3),

  (deck, 18, 'cloze',
   'An electron absorbs a photon of matching energy to enter an {{c1::excited state}}, and emits a photon when it falls back toward the {{c2::ground state}}.', 2),

  (deck, 19, 'cloze',
   'The energy of a photon expressed in terms of its wavelength is {{c1::E = hc/λ}}, where h is Planck''s constant and c is the speed of light, ≈ {{c2::3.00 × 10⁸ m/s}}.', 2),

  (deck, 20, 'cloze',
   'When an electron drops from a higher orbit to a lower one, the atom releases a photon whose energy equals the gap between the levels, producing the element''s characteristic {{c1::atomic emission spectrum}}.', 1),

  (deck, 21, 'cloze',
   'Because allowed electron transitions are discrete, only certain wavelengths appear in an element''s spectrum — a pattern called a {{c1::line spectrum}}.', 1),

  (deck, 22, 'cloze',
   'An atom absorbs only photons whose energy precisely matches an allowed electronic transition, generating an {{c1::absorption spectrum}} unique to that element.', 1),

  (deck, 23, 'cloze',
   'For hydrogen, the photon wavelength of any electron transition is given by {{c1::1/λ = R(1/n₁² − 1/n₂²)}}, with the Rydberg constant for wavelength ≈ {{c2::1.097 × 10⁷ m⁻¹}} (used for wavelength equations) and n₁ < n₂.', 2),

  (deck, 24, 'cloze',
   'Hydrogen''s emission lines are grouped by the final orbit: the {{c1::Lyman}} series ends at n = 1 (entirely UV), the {{c2::Balmer}} series ends at n = 2 (visible plus UV), and the {{c3::Paschen}} series ends at n = 3 (entirely IR).', 3),

  -- ── Quantum Mechanical Model of Atoms ─────────────────────
  (deck, 25, 'cloze',
   'An {{c1::orbital}} is a three-dimensional region of space where an electron of a given energy is most likely to be found, replacing Bohr''s notion of fixed circular orbits.', 1),

  (deck, 26, 'cloze',
   'The {{c1::Heisenberg uncertainty principle}} states that the {{c2::position}} and {{c2::momentum}} of a particle cannot both be known with arbitrary precision at the same time.', 2),

  (deck, 27, 'cloze',
   'The {{c1::Pauli exclusion principle}} forbids any two electrons in an atom from sharing the same set of all four {{c2::quantum numbers}}.', 2),

  (deck, 28, 'cloze',
   'The principal quantum number {{c1::n}} labels the electron shell and takes positive integer values starting at {{c2::1}}, with larger n meaning higher energy and a larger average distance from the nucleus.', 2),

  (deck, 29, 'cloze',
   'The maximum number of electrons a shell can hold is given by the formula {{c1::2n²}}, where n is the principal quantum number.', 1),

  (deck, 30, 'cloze',
   'The azimuthal (angular momentum) quantum number {{c1::l}} specifies an electron''s subshell and ranges from {{c2::0 to n − 1}}.', 2),

  (deck, 31, 'cloze',
   'Subshells are conventionally labeled by letter: {{c1::s}} for l = 0, {{c2::p}} for l = 1, {{c3::d}} for l = 2, and {{c4::f}} for l = 3.', 4),

  (deck, 32, 'cloze',
   'The maximum number of electrons a subshell can hold is given by {{c1::4l + 2}}, accounting for two electrons per orbital across the {{c2::2l + 1}} orbitals of that subshell.', 2),

  (deck, 33, 'cloze',
   'The magnetic quantum number {{c1::m_l}} specifies an orbital''s spatial orientation and takes integer values from {{c2::−l to +l}}, including zero.', 2),

  (deck, 34, 'cloze',
   'The spin quantum number {{c1::m_s}} describes an electron''s intrinsic spin orientation and takes only the values {{c2::+½ or −½}}.', 2),

  (deck, 35, 'cloze',
   'The {{c1::Aufbau principle}} states that electrons fill atomic orbitals in order of {{c2::increasing energy}}, populating lower-energy orbitals before higher-energy ones.', 2),

  (deck, 36, 'cloze',
   'The {{c1::n + l rule (Madelung rule)}} predicts orbital filling order: orbitals with the smaller {{c2::n + l}} sum fill first, and ties go to the orbital with the lower {{c3::n}}.', 3),

  (deck, 37, 'cloze',
   '{{c1::Hund''s rule}} requires that electrons occupy {{c2::degenerate}} orbitals singly, with {{c3::parallel spins}}, before any orbital is doubly occupied — minimizing electron–electron repulsion.', 3),

  (deck, 38, 'cloze',
   'In an electron configuration like 2p⁴, the leading number gives the {{c1::principal energy level}}, the letter designates the {{c2::subshell}}, and the superscript gives the {{c3::number of electrons}} occupying that subshell.', 3),

  (deck, 39, 'cloze',
   'Atoms or ions with at least one {{c1::unpaired}} electron are {{c2::paramagnetic}} and are weakly attracted to a magnetic field, whereas species with all electrons paired are {{c3::diamagnetic}} and weakly repelled.', 3);

  RAISE NOTICE 'Seeded deck % with % cards.', deck, (SELECT COUNT(*) FROM flashcards WHERE deck_id = deck);
END $$;
