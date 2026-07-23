-- ════════════════════════════════════════════════════════════════════
-- Physics Chapter 3 — Thermodynamics
-- ════════════════════════════════════════════════════════════════════
-- Section: physics
-- Topic:   Physics
-- Subtopic slug: thermodynamics
-- Sort order: 3
--
-- Coverage (AAMC-aligned order):
--    1. Temperature, Thermal Equilibrium & Expansion
--    2. Systems & State/Process Functions
--    3. First Law, Heat & Specific Heat
--    4. Thermodynamic Processes
--    5. Heat Transfer
--    6. Second Law & Entropy
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose, cross-verified against OpenStax College
-- Physics 2e. Scope: AAMC Thermochemistry/Thermodynamics (PHY) — the zeroth/first/second
-- laws, thermal expansion, systems & state/process functions, heat & specific heat,
-- the four thermodynamic processes, PV-diagram work, heat-transfer modes, and entropy.
-- Uses the PHYSICS first-law convention (ΔU = Q − W). Shared fundamentals overlap the
-- Chemistry Ch 7 Thermochemistry deck (cross-subject, framed for physics here); chemistry-
-- only content (enthalpy of formation, Hess's law, Gibbs spontaneity) stays in Ch 7.
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    DELETE FROM flashcard_decks
    WHERE section = 'physics'
      AND title IN (
          'Thermodynamics',
          'Physics Review Chapter Three: Thermodynamics'
      );

    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'physics',
        'Physics',
        'thermodynamics',
        'Thermodynamics',
        'The zeroth law and thermal equilibrium, temperature and thermal expansion, thermodynamic systems and state vs process functions, the first law in the physics form (ΔU = Q − W) with heat and specific heat, the four thermodynamic processes with PV-diagram work, the three modes of heat transfer, and the second law with entropy and irreversibility.',
        3
    )
    RETURNING id INTO deck;

    -- ── Temperature, Thermal Equilibrium & Expansion ──────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     'By the {{c1::zeroth}} law of thermodynamics, two objects each in thermal equilibrium with a third object are also in thermal equilibrium with each other.',
     1),
    (deck, 1, 'cloze',
     'Two objects reach thermal equilibrium once they settle at the {{c1::same temperature}}.',
     1),
    (deck, 2, 'cloze',
     'When two objects are in thermal equilibrium, the net heat that flows between them is {{c1::zero}}.',
     1),
    (deck, 3, 'cloze',
     'Temperature is a measure of the average {{c1::kinetic}} energy of a substance''s particles.',
     1),
    (deck, 4, 'cloze',
     '{{c1::Thermal expansion}} is why railroad tracks and bridges are built with gaps and why an alcohol thermometer''s column rises when heated.',
     1),
    (deck, 5, 'cloze',
     'For linear thermal expansion, {{c1::ΔL = αL₀ΔT}}, where α is the coefficient of linear expansion and L₀ is the original length.',
     1),
    (deck, 6, 'cloze',
     'For volumetric thermal expansion, {{c1::ΔV = βV₀ΔT}}, where β is the coefficient of volume expansion and V₀ is the original volume.',
     1),
    (deck, 7, 'cloze',
     'For an isotropic solid, the coefficient of volume expansion β relates to the coefficient of linear expansion α by {{c1::β ≈ 3α}}.',
     1);

    -- ── Systems & State/Process Functions ─────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 8, 'cloze',
     'In thermodynamics, the {{c1::system}} is the specific region under study, while its {{c1::surroundings}} are everything beyond that boundary.',
     1),
    (deck, 9, 'cloze',
     'An {{c1::isolated}} system exchanges neither matter nor energy with its surroundings.',
     1),
    (deck, 10, 'cloze',
     'A {{c1::closed}} system can exchange energy with its surroundings, but not matter.',
     1),
    (deck, 11, 'cloze',
     'An {{c1::open}} system exchanges both matter and energy with its surroundings.',
     1),
    (deck, 12, 'cloze',
     'A {{c1::state}} function''s value is determined only by the system''s current variables and is independent of the path taken to reach it.',
     1),
    (deck, 13, 'cloze',
     'State functions of a system include {{c1::pressure, volume, temperature, density, internal energy, and entropy}} — each fixed by the current state alone.',
     1),
    (deck, 14, 'cloze',
     '{{c1::Heat}} and {{c1::work}} are process (path) functions, since their values depend on the path taken between two states.',
     1);

    -- ── First Law, Heat & Specific Heat ───────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 15, 'cloze',
     'The first law of thermodynamics is the principle of {{c1::conservation of energy}} written for a system that exchanges heat and work with its surroundings.',
     1),
    (deck, 16, 'cloze',
     'In the physics sign convention, the first law of thermodynamics is written {{c1::ΔU = Q − W}}.',
     1),
    (deck, 17, 'cloze',
     'In ΔU = Q − W, Q is the {{c1::heat added to the system}} and W is the {{c2::work done by the system}}.',
     2),
    (deck, 18, 'cloze',
     'ΔU = Q − W (work by the system subtracted) is the {{c1::physics}} convention; {{c1::chemistry}} writes ΔU = q + w (work on the system added).',
     1),
    (deck, 19, 'cloze',
     'Under ΔU = Q − W, a positive W means the gas {{c1::expands and does work on the surroundings}}.',
     1),
    (deck, 20, 'cloze',
     'Heat is the spontaneous transfer of {{c1::energy}} from a hotter object to a cooler one, continuing until they reach {{c2::thermal equilibrium}}.',
     2),
    (deck, 21, 'cloze',
     'The {{c1::specific heat}} of a substance is the heat needed to raise the temperature of {{c2::1 gram}} of it by 1 °C (equivalently 1 K).',
     2),
    (deck, 22, 'cloze',
     'The heat exchanged as a substance''s temperature changes (no phase change) is {{c1::q = mcΔT}}: m is mass, c is specific heat, and ΔT is the temperature change.',
     1),
    (deck, 23, 'cloze',
     'Water''s specific heat is unusually high: {{c1::1 cal/(g·°C), about 4.18 J/(g·°C)}}.',
     1),
    (deck, 24, 'cloze',
     'During a phase change, {{c1::q = mL}} gives the energy transferred, where L is the {{c2::latent heat}} of the substance.',
     2),
    (deck, 25, 'cloze',
     'A phase change proceeds at {{c1::constant temperature}} because absorbed heat raises {{c2::intermolecular potential energy (breaking bonds), not kinetic energy}}.',
     2);

    -- ── Thermodynamic Processes ───────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 26, 'cloze',
     'For an ideal gas, an isothermal process holds temperature constant, giving an internal-energy change of ΔU = {{c1::0}}.',
     1),
    (deck, 27, 'cloze',
     'A thermodynamic process that exchanges no heat with its surroundings (Q = 0) is called {{c1::adiabatic}}.',
     1),
    (deck, 28, 'cloze',
     'A process carried out at constant {{c1::pressure}} is called {{c1::isobaric}}.',
     1),
    (deck, 29, 'cloze',
     'A process carried out at constant volume is called {{c1::isochoric}}.',
     1),
    (deck, 30, 'cloze',
     'In an isochoric process the volume is fixed, so ΔV = {{c1::0}} and the work done by the gas is W = {{c1::0}}.',
     1),
    (deck, 31, 'cloze',
     'The work done by a gas at constant pressure is W = {{c1::PΔV}}.',
     1),
    (deck, 32, 'cloze',
     'On a pressure-volume (PV) diagram, the work done as a gas changes state equals the {{c1::area under the curve}}.',
     1),
    (deck, 33, 'cloze',
     'On a PV diagram, when a gas returns to its starting state, the net work it does equals the {{c1::area enclosed by the loop}}.',
     1);

    -- ── Heat Transfer ─────────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 34, 'cloze',
     'Transfer of heat through direct physical contact between two materials is called {{c1::conduction}}.',
     1),
    (deck, 35, 'cloze',
     'Transfer of heat through the bulk movement of a fluid, such as a flowing liquid or gas, is called {{c1::convection}}.',
     1),
    (deck, 36, 'cloze',
     'Transfer of heat by electromagnetic waves, requiring no material medium, is called {{c1::radiation}}.',
     1),
    (deck, 37, 'cloze',
     'Conduction and convection transfer heat only through {{c1::a material medium}}; radiation is the only mode that requires none.',
     1);

    -- ── Second Law & Entropy ──────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 38, 'cloze',
     'The second law of thermodynamics says the total entropy of an {{c1::isolated}} system (and of the universe) tends to {{c2::increase}} over time.',
     2),
    (deck, 39, 'cloze',
     'Underlying the second law, a system''s energy {{c1::spontaneously}} moves from a {{c2::localized}} to a {{c2::dispersed}} state.',
     2),
    (deck, 40, 'cloze',
     'Entropy (symbol {{c1::S}}) is the thermodynamic measure of a system''s {{c2::disorder}}.',
     2),
    (deck, 41, 'cloze',
     'Statistically, entropy is greater for a macrostate with a larger number of accessible {{c1::microstates}}.',
     1),
    (deck, 42, 'cloze',
     'For a reversible process, the entropy change is {{c1::ΔS = Qrev/T}}, where Qrev is the heat exchanged reversibly and T is the {{c2::absolute}} temperature.',
     2),
    (deck, 43, 'cloze',
     'Every real, natural process is {{c1::irreversible}}; only an idealized, infinitely slow (quasi-static) change — like a very gradual phase change — approaches being {{c1::reversible}}.',
     1),
    (deck, 44, 'cloze',
     'For a reversible process, the total entropy change of the universe (system plus surroundings) equals {{c1::zero}}.',
     1);


    -- ── AAMC coverage gap-fill (2026-07-22) ──────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 45, 'cloze',
     'For a gas, molar heat capacity Cp (constant pressure) is {{c1::greater than}} Cv (constant volume) because some added heat does {{c1::expansion work (PΔV)}} rather than raising temperature.',
     1);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 46;
END $$;
