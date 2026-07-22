-- ════════════════════════════════════════════════════════════════════
-- Physics Chapter 5 — Electrostatics and Magnetism
-- ════════════════════════════════════════════════════════════════════
-- Section: physics
-- Topic:   Physics
-- Subtopic slug: electrostatics_and_magnetism
-- Sort order: 5
--
-- Coverage (AAMC-aligned order):
--    1. Charge & Conductors
--    2. Coulomb's Law & Electric Field
--    3. Electric Potential Energy & Potential
--    4. Equipotential Lines & Dipoles
--    5. Magnetic Fields
--    6. Magnetic Force & the Lorentz Force
--    7. Magnetic Materials
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose, cross-verified against OpenStax College
-- Physics 2e. Scope: AAMC 4C Electrostatics (PHY) — charge, conductors/insulators,
-- Coulomb's law, electric field, electric potential energy & potential, equipotential
-- lines, and dipoles + Magnetism (PHY) — the magnetic field B, forces on moving charges,
-- the Lorentz force, and magnetic materials. Out of scope: CIRCUIT ELEMENTS — current,
-- resistance/Ohm's law, capacitance, resistivity (Physics Ch 6 Circuits); and the
-- electron-configuration basis of para/diamagnetism (Chemistry electronic structure).
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    DELETE FROM flashcard_decks
    WHERE section = 'physics'
      AND title IN (
          'Electrostatics and Magnetism',
          'Electrostatics & Magnetism',
          'Physics Review Chapter Five: Electrostatics and Magnetism'
      );

    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'physics',
        'Physics',
        'electrostatics_and_magnetism',
        'Electrostatics and Magnetism',
        'Electric charge, conductors and insulators; Coulomb''s law and the electric field with field lines; electric potential energy, electric potential, and voltage; equipotential lines and electric dipoles; magnetic fields and their sources with the tesla; the magnetic force on moving charges and currents and the Lorentz force; and the diamagnetic, paramagnetic, and ferromagnetic materials.',
        5
    )
    RETURNING id INTO deck;

    -- ── Charge & Conductors ───────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     'The SI unit of electric charge is the {{c1::coulomb}}, whose symbol is {{c1::C}}.',
     1),
    (deck, 1, 'cloze',
     'A proton carries a {{c1::positive}} charge, while an electron carries a {{c1::negative}} charge.',
     1),
    (deck, 2, 'cloze',
     'The fundamental unit of charge, carried by both protons and electrons, is e = {{c1::1.60×10⁻¹⁹ C}}.',
     1),
    (deck, 3, 'cloze',
     'In an isolated system, the total electric charge remains {{c1::constant}}.',
     1),
    (deck, 4, 'cloze',
     'Like charges {{c1::repel}} one another, while opposite charges {{c1::attract}}.',
     1),
    (deck, 5, 'cloze',
     'A material through which charge flows freely, such as a metal, is called a {{c1::conductor}}.',
     1),
    (deck, 6, 'cloze',
     'A material that holds charge in place and resists its flow, such as glass or rubber, is called an {{c1::insulator}}.',
     1);

    -- ── Coulomb's Law & Electric Field ────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 7, 'cloze',
     'Coulomb''s law gives the electrostatic force between two point charges separated by a distance r as {{c1::F = kq₁q₂/r²}}.',
     1),
    (deck, 8, 'cloze',
     'In Coulomb''s law, the proportionality constant k has the value {{c1::8.99×10⁹ N·m²/C²}}.',
     1),
    (deck, 9, 'cloze',
     'The electrostatic (Coulomb) force between two point charges is always directed {{c1::along the line joining their centers}}.',
     1),
    (deck, 10, 'cloze',
     'As two point charges are moved farther apart, the Coulomb force weakens in proportion to the {{c1::inverse square of the distance (1/r²)}}.',
     1),
    (deck, 11, 'cloze',
     'The electric field at a point is defined as {{c1::E = F/q}} — the {{c1::force per unit charge}} felt by a small positive test charge placed there.',
     1),
    (deck, 12, 'cloze',
     'The electric field a distance r from a point charge Q has magnitude {{c1::E = kQ/r²}}.',
     1),
    (deck, 13, 'cloze',
     'Electric field lines point {{c1::away from positive}} source charges and {{c1::toward negative}} source charges.',
     1),
    (deck, 14, 'cloze',
     'In an electric field, a {{c1::positive}} test charge moves in the direction of the field lines, while a {{c1::negative}} test charge moves opposite to them.',
     1);

    -- ── Electric Potential Energy & Potential ─────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 15, 'cloze',
     'The electric potential energy of two point charges q₁ and q₂ separated by distance r is {{c1::U = kq₁q₂/r}}, where k is Coulomb''s constant.',
     1),
    (deck, 16, 'cloze',
     'The {{c1::work}} done to move a charge from {{c2::infinity}} (its zero-energy reference) to a given point defines that charge''s electric potential energy.',
     2),
    (deck, 17, 'cloze',
     'Electric potential energy increases when two {{c1::like}} charges move toward each other or two {{c1::opposite}} charges move farther apart.',
     1),
    (deck, 18, 'cloze',
     'Electric potential energy decreases when two {{c1::opposite}} charges move toward each other or two {{c1::like}} charges move farther apart.',
     1),
    (deck, 19, 'cloze',
     'Electric potential: V = {{c1::U/q}}, where U is electric potential energy and q is charge.',
     1),
    (deck, 20, 'cloze',
     'For a point charge Q, the electric potential a distance r away is {{c1::V = kQ/r}}, where k is Coulomb''s constant.',
     1),
    (deck, 21, 'cloze',
     'Because the electric force is conservative, the potential difference between two points is {{c1::path-independent}}.',
     1),
    (deck, 22, 'cloze',
     'The SI unit of electric potential is the {{c1::volt}}, equal to one {{c1::joule per coulomb}}.',
     1),
    (deck, 23, 'cloze',
     'A positive charge spontaneously moves from {{c1::high}} potential toward {{c1::low}} potential.',
     1),
    (deck, 24, 'cloze',
     'A negative charge spontaneously moves from {{c1::low}} potential toward {{c1::high}} potential.',
     1),
    (deck, 25, 'cloze',
     'A charge moves spontaneously in whichever direction {{c1::decreases}} its electric potential energy.',
     1);

    -- ── Equipotential Lines & Dipoles ─────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 26, 'cloze',
     'Every point on an {{c1::equipotential}} line sits at the same {{c1::electric potential}}.',
     1),
    (deck, 27, 'cloze',
     'The electric field is everywhere {{c1::perpendicular}} to the equipotential lines.',
     1),
    (deck, 28, 'cloze',
     'Moving a charge between two points on the same equipotential line requires {{c1::zero}} work.',
     1),
    (deck, 29, 'cloze',
     'The work to move a charge between two equipotential lines depends only on the endpoints, not on the {{c1::path}}.',
     1),
    (deck, 30, 'cloze',
     'An electric {{c1::dipole}} is two equal and opposite charges held a fixed distance d apart.',
     1),
    (deck, 31, 'cloze',
     'For an electric dipole, the dipole moment is {{c1::p = qd}}, and it points from the {{c2::negative charge to the positive charge}}.',
     2),
    (deck, 32, 'cloze',
     'In a uniform electric field E, a dipole feels a torque {{c1::τ = pE·sinθ}}, where θ is the angle between p and E, rotating it into alignment.',
     1),
    (deck, 33, 'cloze',
     'In a uniform external field, an electric dipole experiences a torque but {{c1::no net translational force}}.',
     1);

    -- ── Magnetic Fields ───────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 34, 'cloze',
     'The two sources of a magnetic field are {{c1::permanent magnets}} and {{c2::moving electric charges (currents)}}.',
     2),
    (deck, 35, 'cloze',
     'Magnetic field strength (B) is measured in the SI unit {{c1::tesla (T)}}.',
     1),
    (deck, 36, 'cloze',
     'In the older unit system, 1 T = {{c1::10⁴}} gauss.',
     1),
    (deck, 37, 'cloze',
     'Outside a bar magnet, field lines emerge from the {{c1::north}} pole and enter the {{c1::south}} pole.',
     1),
    (deck, 38, 'cloze',
     'The magnetic field of a straight current-carrying wire forms {{c1::concentric circles}} in planes perpendicular to the wire.',
     1),
    (deck, 39, 'cloze',
     'Near a long straight wire, {{c1::B = μ₀I/(2πr)}}, where I is the current, r the distance from the wire, and μ₀ the permeability of free space.',
     1),
    (deck, 40, 'cloze',
     'At the center of a circular current loop, {{c1::B = μ₀I/(2r)}}, where I is the current and r is the loop''s radius.',
     1),
    (deck, 41, 'cloze',
     'By the right-hand rule for a wire, the thumb points along the {{c1::current}} and the curled fingers give the {{c1::magnetic field}}.',
     1);

    -- ── Magnetic Force & the Lorentz Force ────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 42, 'cloze',
     'The magnetic force on a charge moving through a field has magnitude {{c1::F = qvB·sinθ}}, where θ is the angle between the velocity v and the field B.',
     1),
    (deck, 43, 'cloze',
     'The magnetic force on a moving charge is maximum when its velocity is {{c1::perpendicular}} to B and zero when the velocity is {{c1::parallel or antiparallel}} to B.',
     1),
    (deck, 44, 'cloze',
     'The magnetic force on a moving charge always points {{c1::perpendicular to the plane containing v and B}}.',
     1),
    (deck, 45, 'cloze',
     'The right-hand rule gives the magnetic force direction on a positive charge; on a negative charge the force points in the {{c1::opposite}} direction.',
     1),
    (deck, 46, 'cloze',
     'The magnetic force on a straight current-carrying wire has magnitude {{c1::F = ILB·sinθ}}, where I is the current, L the wire''s length, and θ the angle between I and B.',
     1),
    (deck, 47, 'cloze',
     'A charge moving perpendicular to a uniform magnetic field follows uniform {{c1::circular motion}} at constant {{c1::speed}}, because the magnetic force is perpendicular to v and does no work.',
     1),
    (deck, 48, 'cloze',
     'For a charge in uniform circular motion in a magnetic field, the magnetic force supplies the {{c1::centripetal force}}, giving orbit radius {{c2::r = mv/(qB)}} (m = mass, q = charge).',
     2),
    (deck, 49, 'cloze',
     'The Lorentz force on a charge is the sum of the {{c1::electric force qE}} and the {{c1::magnetic force qvB·sinθ}}.',
     1);

    -- ── Magnetic Materials ────────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 50, 'cloze',
     '{{c1::Diamagnetic}} materials have all their electrons paired, so they carry no net magnetic moment and are weakly {{c2::repelled}} by a magnetic field.',
     2),
    (deck, 51, 'cloze',
     '{{c1::Paramagnetic}} materials have some unpaired electrons, giving each atom a net magnetic moment, so a magnetic field weakly {{c1::attracts}} them.',
     1),
    (deck, 52, 'cloze',
     '{{c1::Ferromagnetic}} materials, such as iron, cobalt, and nickel, can become strongly and permanently magnetic.',
     1),
    (deck, 53, 'cloze',
     'In ferromagnetic materials such as iron, cobalt, and nickel, atomic magnetic dipoles align within microscopic regions called {{c1::domains}}.',
     1);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 54;
END $$;
