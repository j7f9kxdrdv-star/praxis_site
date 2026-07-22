-- ════════════════════════════════════════════════════════════════════
-- Physics Chapter 6 — Circuits
-- ════════════════════════════════════════════════════════════════════
-- Section: physics
-- Topic:   Physics
-- Subtopic slug: circuits
-- Sort order: 6
--
-- Coverage (AAMC-aligned order):
--    1. Current & Conduction
--    2. Voltage, EMF & Batteries
--    3. Resistance, Ohm's Law & Resistivity
--    4. Kirchhoff's Laws, Resistor Networks & Power
--    5. Capacitance, Capacitors & Dielectrics
--    6. Circuit Meters
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose, cross-verified against OpenStax College
-- Physics 2e. Scope: AAMC 4C Circuit Elements (PHY) — current & conduction, voltage/emf
-- & batteries, resistance/Ohm's law/resistivity, Kirchhoff's laws + resistor networks +
-- power, capacitance/capacitors/dielectrics, and circuit meters. Out of scope: ELECTRO-
-- CHEMISTRY (galvanic/electrolytic cells, reduction potentials, Faraday → Gen Chem Ch 12);
-- NERVE-CELL electrophysiology (action potentials, myelin, Nodes of Ranvier → Biology); and
-- MAGNETISM + electrostatics fundamentals (→ Physics Ch 5).
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    DELETE FROM flashcard_decks
    WHERE section = 'physics'
      AND title IN (
          'Circuits',
          'Physics Review Chapter Six: Circuits'
      );

    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'physics',
        'Physics',
        'circuits',
        'Circuits',
        'Electric current and conduction (metallic and electrolytic); voltage, electromotive force, and a battery''s terminal voltage and internal resistance; resistance, Ohm''s law, and resistivity; Kirchhoff''s junction and loop rules with resistors in series and parallel and power dissipation; capacitance, the parallel-plate capacitor, capacitors in series and parallel, dielectrics, and stored energy; and the ammeter, voltmeter, and ohmmeter.',
        6
    )
    RETURNING id INTO deck;

    -- ── Current & Conduction ──────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     'Electric current is the {{c1::rate at which charge flows}} through a given cross-section of a conductor.',
     1),
    (deck, 1, 'cloze',
     'Electric current in equation form is {{c1::I = ΔQ/Δt}}, where ΔQ is the charge and Δt is the time interval.',
     1),
    (deck, 2, 'cloze',
     'The SI unit of electric current is the {{c1::ampere (A)}}, equivalent to {{c1::one coulomb per second (1 C/s)}}.',
     1),
    (deck, 3, 'cloze',
     'By convention, current is treated as the flow of {{c1::positive}} charge from the {{c1::high}}-potential terminal to the {{c1::low}}-potential terminal.',
     1),
    (deck, 4, 'cloze',
     'In a metal wire the real charge carriers are {{c1::electrons}}, which drift from {{c2::low}} potential toward {{c2::high}} potential.',
     2),
    (deck, 5, 'cloze',
     'Materials that let charge flow freely are {{c1::conductors}}, while materials whose charges are bound and cannot carry current are {{c1::insulators}}.',
     1),
    (deck, 6, 'cloze',
     'Metallic conduction moves charge through a solid lattice via {{c1::free electrons}}, whereas electrolytic conduction moves it through a solution via {{c1::mobile ions}}.',
     1),
    (deck, 7, 'cloze',
     'Conductivity (σ) relates to resistivity (ρ) by {{c1::σ = 1/ρ}}, and its SI unit is {{c2::siemens per meter (S/m)}}.',
     2);

    -- ── Voltage, EMF & Batteries ──────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 8, 'cloze',
     'The quantity that drives current through a circuit is a {{c1::potential difference}}, or {{c1::voltage}}, measured in {{c1::volts (V)}}.',
     1),
    (deck, 9, 'cloze',
     'A source''s emf is the electrical energy it supplies {{c1::per unit charge}} to drive current through a circuit.',
     1),
    (deck, 10, 'cloze',
     'The voltage a source such as a battery supplies to a circuit is its {{c1::electromotive force}} ({{c1::emf}}), symbol {{c1::ε}}.',
     1),
    (deck, 11, 'cloze',
     'For a real battery with internal resistance r, the terminal voltage it delivers is {{c1::V = ε − Ir}} (ε = emf, I = current).',
     1),
    (deck, 12, 'cloze',
     'A larger {{c1::internal resistance}} lowers both the {{c2::current}} and the {{c2::terminal voltage}} a battery can deliver to its load.',
     2),
    (deck, 13, 'cloze',
     'With no current flowing, a source''s {{c1::terminal voltage}} exactly equals its emf; once it drives current, that {{c1::terminal voltage}} falls below the emf.',
     1);

    -- ── Resistance, Ohm's Law & Resistivity ───────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 14, 'cloze',
     'The property that limits current flow through a material is called {{c1::resistance}}, measured in {{c1::ohms (Ω)}}.',
     1),
    (deck, 15, 'cloze',
     'One ohm is defined as {{c1::one volt per ampere (1 Ω = 1 V/A)}}.',
     1),
    (deck, 16, 'cloze',
     'A resistor is a circuit component that {{c1::slows the flow of electrons without stopping it}}.',
     1),
    (deck, 17, 'cloze',
     'By Ohm''s law, for a fixed resistance the current through a resistor is {{c1::directly proportional}} to the voltage across it.',
     1),
    (deck, 18, 'cloze',
     'Ohm''s law relates voltage V, current I, and resistance R as {{c1::V = IR (equivalently I = V/R)}}.',
     1),
    (deck, 19, 'cloze',
     'For a uniform wire, resistance is {{c1::R = ρL/A}}, where ρ is resistivity, L is length, and A is cross-sectional area.',
     1),
    (deck, 20, 'cloze',
     'A wire''s resistance {{c1::increases}} with higher resistivity and greater length, and {{c1::decreases}} with larger cross-sectional area.',
     1),
    (deck, 21, 'cloze',
     'In a metal, resistance and temperature change in the {{c1::same}} direction, so heating the wire {{c1::raises}} its resistance.',
     1);

    -- ── Kirchhoff's Laws, Resistor Networks & Power ───────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 22, 'cloze',
     'Kirchhoff''s junction rule states that the current flowing {{c1::into}} any junction equals the current flowing {{c1::out of}} it, expressing conservation of {{c2::charge}}.',
     2),
    (deck, 23, 'cloze',
     'Written in symbols, Kirchhoff''s junction rule is {{c1::ΣI_in = ΣI_out}}.',
     1),
    (deck, 24, 'cloze',
     'Kirchhoff''s loop rule states that around any closed loop the sum of the voltage {{c1::sources}} equals the sum of the voltage {{c1::drops}}, expressing conservation of {{c2::energy}}.',
     2),
    (deck, 25, 'cloze',
     'For resistors in series, the equivalent resistance is {{c1::R_eq = R₁ + R₂ + R₃ + …}}.',
     1),
    (deck, 26, 'cloze',
     'In a series circuit, every resistor carries the same {{c1::current}}, because the charge follows one unbranched path.',
     1),
    (deck, 27, 'cloze',
     'For resistors in parallel, the equivalent resistance comes from {{c1::1/R_eq = 1/R₁ + 1/R₂ + …}}.',
     1),
    (deck, 28, 'cloze',
     'Combining resistors in parallel yields an equivalent resistance that is {{c1::smaller than the smallest}} individual resistor in the combination.',
     1),
    (deck, 29, 'cloze',
     'Each resistor in a parallel arrangement has the same {{c1::voltage}} across it, since each connects directly across the source.',
     1),
    (deck, 30, 'cloze',
     'The power dissipated by a resistor is {{c1::P = IV = I²R = V²/R}}, where I is current, V is voltage, and R is resistance.',
     1);

    -- ── Capacitance, Capacitors & Dielectrics ─────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 31, 'cloze',
     'A capacitor stores both {{c1::electric charge}} and {{c2::electrical potential energy}}.',
     2),
    (deck, 32, 'cloze',
     'For charge Q held at voltage V, a capacitor''s capacitance is C = {{c1::Q/V}}.',
     1),
    (deck, 33, 'cloze',
     'The SI unit of capacitance is the {{c1::farad}}, equal to one {{c1::coulomb per volt}}.',
     1),
    (deck, 34, 'cloze',
     'A parallel-plate capacitor has C = {{c1::ε₀A/d}}, where A is the plate area, d the plate separation, and ε₀ the permittivity of free space.',
     1),
    (deck, 35, 'cloze',
     'Increasing a capacitor''s plate area {{c1::raises}} its capacitance, whereas increasing the plate separation {{c1::lowers}} it.',
     1),
    (deck, 36, 'cloze',
     'Capacitors in series combine as {{c1::1/C_eq = 1/C₁ + 1/C₂ + …}}.',
     1),
    (deck, 37, 'cloze',
     'Capacitors in parallel combine as {{c1::C_eq = C₁ + C₂ + …}}.',
     1),
    (deck, 38, 'cloze',
     'Combining capacitors in series {{c1::decreases}} the equivalent capacitance, while combining them in parallel {{c1::increases}} it.',
     1),
    (deck, 39, 'cloze',
     'An {{c1::insulator}} placed between a capacitor''s plates raises its capacitance by a factor {{c2::κ, the dielectric constant}}.',
     2),
    (deck, 40, 'cloze',
     'A dielectric reduces the {{c1::electric field}} between the plates, letting them hold more {{c2::charge}} at the same voltage.',
     2),
    (deck, 41, 'cloze',
     'The energy stored in a capacitor is U = {{c1::½CV² = Q²/(2C)}}.',
     1);

    -- ── Circuit Meters ────────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 42, 'cloze',
     'An {{c1::ammeter}} measures {{c1::current}} and is connected in {{c2::series}} within the circuit.',
     2),
    (deck, 43, 'cloze',
     'An ammeter must have {{c1::very low (negligible)}} resistance so it does not disturb the current it is measuring.',
     1),
    (deck, 44, 'cloze',
     'A {{c1::voltmeter}} measures the potential difference across a component and is connected in {{c1::parallel}} with it.',
     1),
    (deck, 45, 'cloze',
     'Because it is connected in parallel with the element being measured, a voltmeter must have {{c1::very high (large)}} resistance.',
     1),
    (deck, 46, 'cloze',
     'An ohmmeter measures resistance; unlike an ammeter or voltmeter it is {{c1::self-powered}}, and is used only when {{c1::no other current}} flows through the component.',
     1);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 47;
END $$;
