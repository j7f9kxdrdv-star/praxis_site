-- ════════════════════════════════════════════════════════════════════
-- General Chemistry Chapter 8 — The Gas Phase
-- ════════════════════════════════════════════════════════════════════
-- Section: chemistry
-- Topic:   General Chemistry
-- Subtopic slug: the_gas_phase
-- Sort order: 8
--
-- Coverage (AAMC-aligned order):
--    1. Gas Properties & Pressure
--    2. STP, Molar Volume & the Ideal Gas
--    3. The Ideal Gas Law
--    4. The Simple Gas Laws
--    5. Gas Mixtures: Dalton's & Henry's Laws
--    6. Kinetic Molecular Theory & Molecular Speeds
--    7. Real Gases
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose. Facts cross-verified against OpenStax
-- Chemistry (Atoms First) 2e. Scope: AAMC Gas Phase (GC) — gas properties & pressure,
-- STP/molar volume, the ideal gas law, the simple gas laws, Dalton's/Henry's laws,
-- kinetic molecular theory & molecular speeds, and real-gas deviations. The 298 K
-- thermodynamic standard state & Cv/Cp (Ch 7 Thermochemistry) and Raoult's law /
-- colligative properties (Ch 9 Solutions) are out of scope. See companion .verification.md.
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    DELETE FROM flashcard_decks
    WHERE section = 'chemistry'
      AND title IN (
          'The Gas Phase',
          'Gases',
          'General Chemistry Review Chapter Eight: The Gas Phase'
      );

    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'chemistry',
        'General Chemistry',
        'the_gas_phase',
        'The Gas Phase',
        'Gas properties, pressure units and the mercury barometer, STP and molar volume, the ideal gas law (PV=nRT) with gas density and molar mass, the simple gas laws (Boyle, Charles, Gay-Lussac, Avogadro) and the combined gas law, gas mixtures (Dalton''s and Henry''s laws, partial pressure, mole fraction), kinetic molecular theory with average kinetic energy, root-mean-square speed and Graham''s law, and real-gas deviations with the van der Waals correction.',
        8
    )
    RETURNING id INTO deck;

    -- ── Gas Properties & Pressure ─────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     'Pressure is defined as {{c1::force per unit area}}.',
     1),
    (deck, 1, 'cloze',
     'The SI unit of pressure is the {{c1::pascal (Pa)}}, defined as one {{c1::newton per square meter (N/m²)}}.',
     1),
    (deck, 2, 'cloze',
     '1 atm = {{c1::760}} mmHg = {{c1::760}} torr = {{c2::101.325}} kPa.',
     2),
    (deck, 3, 'cloze',
     'A mercury {{c1::barometer}} measures {{c2::atmospheric}} pressure by the height of the mercury column it supports.',
     2),
    (deck, 4, 'cloze',
     'A {{c1::manometer}} measures the pressure of a gas enclosed in a container, whereas a barometer measures atmospheric pressure.',
     1),
    (deck, 5, 'cloze',
     'As atmospheric pressure {{c1::decreases}} with altitude (e.g., up a mountain), the mercury column in a barometer {{c1::falls}}.',
     1),
    (deck, 6, 'cloze',
     'The lowest temperature theoretically attainable is called {{c1::absolute zero}}, which corresponds to {{c1::0 K}}.',
     1),
    (deck, 7, 'cloze',
     'For gas-law calculations, temperature must be in {{c1::kelvin (absolute)}}, obtained by adding {{c2::273.15}} to the Celsius value.',
     2),
    (deck, 8, 'cloze',
     'Because their particles are far apart, gases are the {{c1::least dense}} state of matter and are easily {{c2::compressed}}.',
     2);

    -- ── STP, Molar Volume & the Ideal Gas ─────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 9, 'cloze',
     'Standard temperature and pressure (STP) is defined as {{c1::273 K (0 °C)}} and {{c2::1 atm}}.',
     2),
    (deck, 10, 'cloze',
     'One mole of an ideal gas at STP fills roughly {{c1::22.4 L}}, a value known as the standard molar volume.',
     1),
    (deck, 11, 'cloze',
     'An ideal gas is a hypothetical construct whose particles have {{c1::negligible volume}} and exert {{c2::no intermolecular forces}}.',
     2),
    (deck, 12, 'cloze',
     'At identical temperature and pressure, equal volumes of any two gases hold {{c1::the same number of molecules}} (Avogadro''s law).',
     1);

    -- ── The Ideal Gas Law ─────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 13, 'cloze',
     'The ideal gas law combines the four simple gas laws into one equation: {{c1::PV = nRT}}.',
     1),
    (deck, 14, 'cloze',
     'In PV = nRT, the gas constant R equals {{c1::0.0821 L·atm·mol⁻¹·K⁻¹}} or, in energy units, {{c2::8.314 J·mol⁻¹·K⁻¹}}.',
     2),
    (deck, 15, 'cloze',
     'The temperature T in PV = nRT must always be expressed on the {{c1::absolute (Kelvin)}} scale.',
     1),
    (deck, 16, 'cloze',
     'Rearranging PV = nRT expresses a gas''s density as ρ = {{c1::PM/RT}}, where M is the molar mass.',
     1),
    (deck, 17, 'cloze',
     'Solving the gas-density relation for molar mass gives M = {{c1::ρRT/P}}.',
     1),
    (deck, 18, 'cloze',
     'A gas whose pressure, volume, and temperature are accurately described by PV = nRT is said to show {{c1::ideal behavior}}.',
     1);

    -- ── The Simple Gas Laws ───────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 19, 'cloze',
     'For a fixed amount of gas at constant temperature, {{c1::Boyle''s law applies: pressure and volume are inversely proportional, so P₁V₁ = P₂V₂}}.',
     1),
    (deck, 20, 'cloze',
     'For a fixed amount of gas at constant pressure, {{c1::Charles''s law applies: volume and absolute temperature are directly proportional, so V₁/T₁ = V₂/T₂}}.',
     1),
    (deck, 21, 'cloze',
     'For a fixed amount of gas at constant volume, {{c1::Gay-Lussac''s law applies: pressure and absolute temperature are directly proportional, so P₁/T₁ = P₂/T₂}}.',
     1),
    (deck, 22, 'cloze',
     'At constant temperature and pressure, {{c1::Avogadro''s law applies: a gas''s volume and number of moles are directly proportional, so V/n stays constant}}.',
     1),
    (deck, 23, 'cloze',
     'For a fixed amount of gas compared across two states, the ideal gas law reduces to the {{c1::combined gas law: P₁V₁/T₁ = P₂V₂/T₂}}.',
     1),
    (deck, 24, 'cloze',
     'Each simple gas law is the ideal gas law (PV = nRT) with {{c1::two}} of its four variables held constant.',
     1),
    (deck, 25, 'cloze',
     'The combined gas law, P₁V₁/T₁ = P₂V₂/T₂, is valid only when the {{c1::amount of gas (number of moles, n)}} is held constant.',
     1);

    -- ── Gas Mixtures: Dalton's & Henry's Laws ─────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 26, 'cloze',
     'The total pressure of a non-reacting gas mixture equals the sum of its components'' partial pressures; this is {{c1::Dalton''s law}}.',
     1),
    (deck, 27, 'cloze',
     'For a mixture of ideal gases, the total pressure is Ptotal = {{c1::P₁ + P₂ + P₃ + …}}',
     1),
    (deck, 28, 'cloze',
     'Each gas in a mixture acts independently, exerting the {{c1::partial pressure}} it would produce if it alone occupied the container.',
     1),
    (deck, 29, 'cloze',
     'The partial pressure of component i in a gas mixture is Pᵢ = {{c1::χᵢ × Ptotal}}.',
     1),
    (deck, 30, 'cloze',
     'The mole fraction of component i is χᵢ = {{c1::nᵢ / ntotal}}.',
     1),
    (deck, 31, 'cloze',
     'The relationship between the amount of a gas dissolved in a liquid and that gas''s partial pressure above the liquid is described by {{c1::Henry''s law}}.',
     1),
    (deck, 32, 'cloze',
     'The amount of a gas dissolved in a liquid is {{c1::directly proportional}} to that gas''s partial pressure above the solution.',
     1);

    -- ── Kinetic Molecular Theory & Molecular Speeds ───────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 33, 'cloze',
     'Kinetic molecular theory assumes the volume of the gas particles themselves is {{c1::negligible}} compared with the space between them.',
     1),
    (deck, 34, 'cloze',
     'Kinetic molecular theory assumes gas particles exert {{c1::no attractive or repulsive}} forces on one another.',
     1),
    (deck, 35, 'cloze',
     'Kinetic molecular theory treats all collisions of gas particles as {{c1::elastic}}.',
     1),
    (deck, 36, 'cloze',
     'Kinetic molecular theory assumes gas particles are in {{c1::continuous, random}} motion, travelling in straight lines until they collide.',
     1),
    (deck, 37, 'cloze',
     'In kinetic molecular theory, the average kinetic energy of gas molecules is directly proportional to the {{c1::absolute (Kelvin)}} temperature.',
     1),
    (deck, 38, 'cloze',
     'The average kinetic energy of a single gas molecule is KEavg = {{c1::(3/2)kB T}}, set only by the absolute temperature.',
     1),
    (deck, 39, 'cloze',
     'Boltzmann''s constant, kB, equals the ideal gas constant R divided by {{c1::Avogadro''s number}}.',
     1),
    (deck, 40, 'cloze',
     'The root-mean-square speed of gas molecules is urms = {{c1::√(3RT/M)}}, where M is the molar mass in kg/mol.',
     1),
    (deck, 41, 'cloze',
     'At the same temperature, all gases have equal average kinetic energy, yet lighter (lower-mass) molecules move {{c1::faster}} than heavier ones.',
     1),
    (deck, 42, 'cloze',
     'By Graham''s law, two gases'' effusion rates relate as rate₁/rate₂ = {{c1::√(M₂/M₁)}}.',
     1),
    (deck, 43, 'cloze',
     '{{c1::Diffusion}} is the net movement of gas molecules from high to low concentration, whereas {{c1::effusion}} is escape through a tiny opening into a vacuum.',
     1);

    -- ── Real Gases ────────────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 44, 'cloze',
     'Real gases deviate most from ideal behavior at {{c1::high}} pressure and {{c1::low}} temperature.',
     1),
    (deck, 45, 'cloze',
     'At moderately high pressure, a real gas occupies {{c1::less}} volume than the ideal gas law predicts because intermolecular {{c1::attractions}} become significant.',
     1),
    (deck, 46, 'cloze',
     'At extremely high pressure, a real gas occupies {{c1::more}} volume than the ideal gas law predicts because the molecules'' own {{c1::finite size}} becomes significant.',
     1),
    (deck, 47, 'cloze',
     'In the van der Waals equation, the constant {{c1::a}} corrects for the strength of intermolecular {{c1::attractions}}.',
     1),
    (deck, 48, 'cloze',
     'In the van der Waals equation, the constant {{c1::b}} corrects for the finite {{c1::size}} of the gas molecules themselves.',
     1),
    (deck, 49, 'cloze',
     'The van der Waals equation of state is {{c1::(P + an²/V²)(V − nb) = nRT}}.',
     1);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 50;
END $$;
