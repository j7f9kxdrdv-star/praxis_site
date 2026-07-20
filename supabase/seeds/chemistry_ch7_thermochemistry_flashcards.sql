-- ════════════════════════════════════════════════════════════════════
-- General Chemistry Chapter 7 — Thermochemistry
-- ════════════════════════════════════════════════════════════════════
-- Section: chemistry
-- Topic:   General Chemistry
-- Subtopic slug: thermochemistry
-- Sort order: 7
--
-- Coverage (AAMC-aligned order):
--    1. Systems & State Functions
--    2. Heat, Enthalpy & Reaction Energetics
--    3. Calorimetry & Heat Capacity
--    4. Hess's Law & Bond Enthalpies
--    5. Entropy & the Second Law
--    6. Gibbs Free Energy & Spontaneity
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose, written from OpenStax Chemistry (Atoms
-- First) 2e (no source deck this chapter). Scope: AAMC Energy Changes in Chemical
-- Reactions — Thermochemistry/Thermodynamics (GC): systems & state functions, enthalpy,
-- calorimetry, Hess's law & bond energies, entropy & the second law, Gibbs free energy.
-- Out of scope: PHY-only items (PV-work, heat-transfer modes, thermal expansion),
-- kinetics (Ch 5), equilibrium math (Ch 6), full phase diagrams. See companion .verification.md.
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    DELETE FROM flashcard_decks
    WHERE section = 'chemistry'
      AND title IN (
          'Thermochemistry',
          'General Chemistry Review Chapter Seven: Thermochemistry'
      );

    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'chemistry',
        'General Chemistry',
        'thermochemistry',
        'Thermochemistry',
        'Thermodynamic systems and state functions, the first law and sign conventions, heat and enthalpy, endothermic and exothermic reactions, standard heats of reaction and formation, calorimetry (q=mcΔT) and heat capacity, heat of fusion and vaporization, Hess''s law and bond dissociation energies, entropy and the second and third laws, and Gibbs free energy with the criterion for spontaneity.',
        7
    )
    RETURNING id INTO deck;

    -- ── Systems & State Functions ─────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     'The {{c1::system}} is the specific portion of matter under study, while the {{c2::surroundings}} are everything else that can exchange heat or work with it.',
     2),
    (deck, 1, 'cloze',
     'An {{c1::open}} system can exchange both matter and energy with its surroundings.',
     1),
    (deck, 2, 'cloze',
     'A {{c1::closed}} system can exchange energy but not matter with its surroundings.',
     1),
    (deck, 3, 'cloze',
     'An {{c1::isolated}} system exchanges neither matter nor energy with its surroundings.',
     1),
    (deck, 4, 'cloze',
     'A property whose value depends only on a system''s present condition, not on the path taken to reach it, is called a {{c1::state function}}.',
     1),
    (deck, 5, 'cloze',
     '{{c1::Heat (q) and work (w)}} are path functions — their values depend on how a process is carried out, not just its initial and final states.',
     1),
    (deck, 6, 'cloze',
     'The first law of thermodynamics, a statement of energy {{c1::conservation}}, gives a system''s change in internal energy as ΔU = {{c2::q + w}}.',
     2),
    (deck, 7, 'cloze',
     'By convention, q is positive when heat flows {{c1::into the system}}, and w is positive when work is done {{c1::on the system}}.',
     1),
    (deck, 8, 'cloze',
     'The {{c1::zeroth}} law of thermodynamics states that if two systems are each in thermal equilibrium with a third, they are in thermal equilibrium with each other.',
     1);

    -- ── Heat, Enthalpy & Reaction Energetics ──────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 9, 'cloze',
     'Heat (q) is {{c1::thermal energy}} in transit, flowing between two objects only when they sit at {{c2::different temperatures}}.',
     2),
    (deck, 10, 'cloze',
     'Temperature is a quantitative measure of the {{c1::average kinetic energy}} of the particles in a sample.',
     1),
    (deck, 11, 'cloze',
     'An exothermic process {{c1::releases heat and has a negative ΔH (ΔH < 0)}}.',
     1),
    (deck, 12, 'cloze',
     'An endothermic process {{c1::absorbs heat and has a positive ΔH (ΔH > 0)}}.',
     1),
    (deck, 13, 'cloze',
     'Enthalpy (H) is a system''s heat content, so at {{c1::constant pressure}} its change equals the heat exchanged: ΔH = {{c1::qₚ}}.',
     1),
    (deck, 14, 'cloze',
     'For MCAT thermochemistry, the standard state is taken as {{c1::25 °C (298 K)}}, {{c2::1 atm}}, and {{c3::1 M}} for solutions.',
     3),
    (deck, 15, 'cloze',
     'The standard enthalpy of formation (ΔH°f) is the enthalpy change to form {{c1::1 mole}} of a compound from its {{c2::elements in their standard states}}.',
     2),
    (deck, 16, 'cloze',
     'The standard enthalpy of formation of a pure element in its most stable standard state is {{c1::zero (0 kJ/mol)}}.',
     1),
    (deck, 17, 'cloze',
     'The standard enthalpy of a reaction is found from tabulated formation enthalpies: ΔH°rxn = Σ ΔH°f({{c1::products}}) − Σ ΔH°f({{c1::reactants}}).',
     1);

    -- ── Calorimetry & Heat Capacity ───────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 18, 'cloze',
     '{{c1::Calorimetry}} is the experimental technique of measuring the heat that flows into or out of a system during a chemical or physical change.',
     1),
    (deck, 19, 'cloze',
     'The heat gained or lost by a substance whose temperature changes is {{c1::q = mcΔT}}, where c is the specific heat.',
     1),
    (deck, 20, 'cloze',
     '{{c1::Specific heat}} is the heat needed to raise one gram of a substance by 1 °C (equivalently 1 K).',
     1),
    (deck, 21, 'cloze',
     'Heat capacity (C) is the heat to raise an entire {{c1::object}}''s temperature by 1 °C; taken per {{c2::mole}} of substance, it is the {{c2::molar}} heat capacity.',
     2),
    (deck, 22, 'cloze',
     'Liquid water has an unusually high specific heat of about {{c1::4.18 J/(g·°C)}}, far greater than that of most metals.',
     1),
    (deck, 23, 'cloze',
     'A constant-pressure (coffee-cup) calorimeter measures {{c1::ΔH}}, whereas a constant-volume (bomb) calorimeter measures {{c1::ΔU}}.',
     1),
    (deck, 24, 'cloze',
     'During a phase change, added heat goes into overcoming intermolecular forces, so temperature stays {{c1::constant}} despite continued heating.',
     1),
    (deck, 25, 'cloze',
     'The heat to melt a solid into a liquid is the heat of {{c1::fusion}}; the heat to boil a liquid into a gas is the heat of {{c2::vaporization}}.',
     2),
    (deck, 26, 'cloze',
     'Melting and vaporization are both {{c1::endothermic}}, while the reverse changes, freezing and condensation, are both {{c1::exothermic}}.',
     1);

    -- ── Hess's Law & Bond Enthalpies ──────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 27, 'cloze',
     '{{c1::Hess''s law}} states that the ΔH of an overall reaction equals the sum of the ΔH values of its individual steps.',
     1),
    (deck, 28, 'cloze',
     'The fact that a reaction''s ΔH is identical whether it occurs directly or through intermediates shows that enthalpy is a {{c1::state function}} — the principle underlying Hess''s law.',
     1),
    (deck, 29, 'cloze',
     'Reversing the direction of a reaction {{c1::flips the sign of its ΔH}}.',
     1),
    (deck, 30, 'cloze',
     'Forming 1 mol NO₂ has ΔH = +33.2 kJ; forming 2 mol NO₂ has ΔH = {{c1::+66.4 kJ}}.',
     1),
    (deck, 31, 'cloze',
     'Bond dissociation energy — the energy to break one mole of a bond in the {{c1::gas}} phase — is always {{c2::positive}}.',
     2),
    (deck, 32, 'cloze',
     'Using bond energies, ΔHrxn ≈ Σ(bonds {{c1::broken}}) − Σ(bonds {{c1::formed}}).',
     1),
    (deck, 33, 'cloze',
     'Breaking a chemical bond {{c1::takes in energy (endothermic)}}, while forming a bond {{c1::gives off energy (exothermic)}}.',
     1),
    (deck, 34, 'cloze',
     'In terms of bond enthalpy, a reaction is exothermic (ΔH < 0) when the {{c1::product}} bonds are collectively stronger than the {{c1::reactant}} bonds.',
     1);

    -- ── Entropy & the Second Law ──────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 35, 'cloze',
     'Entropy (S) is a state function that measures a system''s {{c1::energy and matter dispersal}} — loosely, its {{c1::disorder}}.',
     1),
    (deck, 36, 'cloze',
     'On the molecular scale, a system''s entropy rises as the number of accessible {{c1::microstates}} increases.',
     1),
    (deck, 37, 'cloze',
     'By the second law of thermodynamics, ΔSuniv (system + surroundings) is {{c1::positive (> 0)}} for a spontaneous process and {{c2::zero}} at equilibrium.',
     2),
    (deck, 38, 'cloze',
     'For a given substance, the entropy of its phases follows {{c1::S(gas) > S(liquid) > S(solid)}}, reflecting greater freedom of particle motion.',
     1),
    (deck, 39, 'cloze',
     'A system''s entropy tends to increase when a solid {{c1::dissolves}}, when a substance is {{c2::heated}}, and when a reaction yields more moles of {{c3::gas}}.',
     3),
    (deck, 40, 'cloze',
     'The third law of thermodynamics states that a pure, perfect {{c1::crystalline solid}} has {{c2::zero entropy (S = 0) at 0 K}}.',
     2),
    (deck, 41, 'cloze',
     'The standard entropy change of a reaction is ΔS°rxn = {{c1::Σ nS°(products) − Σ nS°(reactants)}}, where n are the stoichiometric coefficients.',
     1);

    -- ── Gibbs Free Energy & Spontaneity ───────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 42, 'cloze',
     'At constant temperature and pressure, the Gibbs free energy change is ΔG = {{c1::ΔH − TΔS}}.',
     1),
    (deck, 43, 'cloze',
     'A process is spontaneous when {{c1::ΔG < 0}}, nonspontaneous when {{c1::ΔG > 0}}, and at equilibrium when {{c1::ΔG = 0}}.',
     1),
    (deck, 44, 'cloze',
     'A reaction with negative ΔH and positive ΔS is {{c1::spontaneous at all temperatures}}.',
     1),
    (deck, 45, 'cloze',
     'A reaction with positive ΔH and negative ΔS is {{c1::nonspontaneous at all temperatures}}.',
     1),
    (deck, 46, 'cloze',
     'When both ΔH and ΔS are negative, a reaction is spontaneous only at {{c1::low}} temperatures.',
     1),
    (deck, 47, 'cloze',
     'When both ΔH and ΔS are positive, a reaction is spontaneous only at {{c1::high}} temperatures.',
     1),
    (deck, 48, 'cloze',
     'The standard free energy change of reaction is ΔG°rxn = {{c1::Σ ΔG°f(products) − Σ ΔG°f(reactants)}}.',
     1),
    (deck, 49, 'cloze',
     'By definition, the standard free energy of formation ΔG°f of an element in its standard state equals {{c1::zero}}.',
     1);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 50;
END $$;
