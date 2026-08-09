-- ════════════════════════════════════════════════════════════════════
-- Physics Chapter 4 — Fluids
-- ════════════════════════════════════════════════════════════════════
-- Section: physics
-- Topic:   Physics
-- Subtopic slug: fluids
-- Sort order: 4
--
-- Coverage (AAMC-aligned order):
--    1. Fluids, Density & Pressure
--    2. Hydrostatic Pressure
--    3. Pascal's Principle & Hydraulics
--    4. Buoyancy & Archimedes
--    5. Surface Tension & Viscosity
--    6. Fluid Dynamics: Continuity & Bernoulli
--
-- Idempotent: re-running this script wipes any prior version of this deck
-- (matching multiple historical title spellings) and reseeds from scratch.
--
-- All cards are original Praxis Prep prose, cross-verified against OpenStax College
-- Physics 2e. Scope: AAMC 4B Fluids (PHY) — density & specific gravity, pressure,
-- hydrostatic pressure (Pascal's law, P = ρgh), buoyancy & Archimedes, surface tension,
-- viscosity & Poiseuille flow, turbulence, the continuity equation, and Bernoulli /
-- Venturi / pitot. Out of scope: the thermodynamic work W = PΔV (Physics Ch 3); and the
-- ANATOMY/PHYSIOLOGY of circulation and respiration — arteries/veins/heart (Biology Ch 7)
-- and breathing mechanics/airway resistance/surfactant (Biology Ch 6), which the AAMC
-- files as BIO. The GENERAL physics of flow resistance and continuity is kept here.
-- ════════════════════════════════════════════════════════════════════

DO $$
DECLARE
    deck UUID;
BEGIN
    DELETE FROM flashcard_decks
    WHERE section = 'physics'
      AND title IN (
          'Fluids',
          'Physics Review Chapter Four: Fluids'
      );

    INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
    VALUES (
        'physics',
        'Physics',
        'fluids',
        'Fluids',
        'The nature of fluids, density and specific gravity, and pressure; hydrostatic pressure with Pascal''s principle and hydraulics; buoyancy and Archimedes'' principle; surface tension with cohesion and adhesion; viscosity, laminar vs turbulent flow, and Poiseuille''s law; and fluid dynamics — the continuity equation, Bernoulli''s equation, the Venturi effect, and the pitot tube.',
        4
    )
    RETURNING id INTO deck;

    -- ── Fluids, Density & Pressure ────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 0, 'cloze',
     'A fluid is any substance that {{c1::can flow and take the shape of its container}}.',
     1),
    (deck, 1, 'cloze',
     'A fluid can exert {{c1::perpendicular}} forces on a surface but not {{c1::shear (parallel)}} forces.',
     1),
    (deck, 2, 'cloze',
     'The two states of matter classified as fluids are {{c1::liquids and gases}}.',
     1),
    (deck, 3, 'cloze',
     'For a substance of mass m and volume V, density is ρ = {{c1::m/V}}.',
     1),
    (deck, 4, 'cloze',
     'A volume V of fluid with density ρ has weight F(g) = {{c1::ρVg}}, where g is the gravitational acceleration.',
     1),
    (deck, 5, 'cloze',
     'Specific gravity, SG = {{c1::ρ / ρ of water}}, is {{c1::dimensionless}}.',
     1),
    (deck, 6, 'cloze',
     'For a force F applied perpendicular to area A, the pressure is P = {{c1::F/A}}.',
     1),
    (deck, 7, 'cloze',
     'Pressure is a {{c1::scalar}} quantity, yet the forces it produces always act {{c2::perpendicular}} to any surface.',
     2),
    (deck, 8, 'cloze',
     'The SI unit of pressure is the {{c1::pascal (Pa), equal to N/m²}}; other common units include {{c2::atm, mmHg, and torr}}.',
     2);

    -- ── Hydrostatic Pressure ──────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 9, 'cloze',
     'The pressure due to the weight of a fluid column of density ρ at depth h is {{c1::P = ρgh}} (g = the acceleration due to gravity).',
     1),
    (deck, 10, 'cloze',
     'In a static fluid, hydrostatic pressure {{c1::increases with depth}}.',
     1),
    (deck, 11, 'cloze',
     'Hydrostatic pressure at a point in a static fluid is produced by the {{c1::weight of the fluid lying above that point}}.',
     1),
    (deck, 12, 'cloze',
     'Hydrostatic pressure depends only on fluid density and depth — never on the {{c1::shape or total volume}} of the container.',
     1),
    (deck, 13, 'cloze',
     'Absolute (total) pressure at depth h is {{c1::P = P₀ + ρgh}}, where P₀ is the surface pressure (usually atmospheric).',
     1),
    (deck, 14, 'cloze',
     'Gauge pressure is absolute pressure {{c1::minus atmospheric pressure}}; in a static liquid it equals {{c2::ρgh}}.',
     2);

    -- ── Pascal's Principle & Hydraulics ───────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 15, 'cloze',
     'Pascal''s principle: a pressure change applied to an {{c1::enclosed}} fluid is transmitted {{c2::undiminished}} to every part of the fluid.',
     2),
    (deck, 16, 'cloze',
     'Because pressure is transmitted equally to both pistons of a hydraulic system, the forces obey {{c1::F₁/A₁ = F₂/A₂}}, where A is each piston''s cross-sectional area.',
     1),
    (deck, 17, 'cloze',
     'Since pressure is uniform throughout a hydraulic system, each piston''s output force is {{c1::directly proportional}} to its {{c2::cross-sectional area}}.',
     2),
    (deck, 18, 'cloze',
     'Because a hydraulic system conserves energy, the piston exerting the greater force must move through a correspondingly {{c1::smaller}} distance.',
     1);

    -- ── Buoyancy & Archimedes ─────────────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 19, 'cloze',
     'Archimedes'' principle states that the buoyant force on a submerged or floating object equals the {{c1::weight of the fluid it displaces}}.',
     1),
    (deck, 20, 'cloze',
     'The buoyant force is F(b) = {{c1::ρ(fluid)·V(disp)·g}}, where ρ(fluid) is the fluid''s density, V(disp) is the volume of fluid displaced, and g is the gravitational acceleration.',
     1),
    (deck, 21, 'cloze',
     'The buoyant force on an object in a fluid always points {{c1::opposite to gravity (upward)}}.',
     1),
    (deck, 22, 'cloze',
     'An object {{c1::floats}} if it is less dense than the surrounding fluid and {{c1::sinks}} if it is more dense.',
     1),
    (deck, 23, 'cloze',
     'A {{c1::fully submerged}} object displaces a fluid volume equal to its own volume.',
     1),
    (deck, 24, 'cloze',
     'A floating object displaces a weight of fluid equal to {{c1::its own weight}}.',
     1),
    (deck, 25, 'cloze',
     'A buoyant force acts on any object placed in a fluid, whether it {{c1::floats, sinks, or is suspended}}.',
     1);

    -- ── Surface Tension & Viscosity ───────────────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 26, 'cloze',
     '{{c1::Cohesion}} is the attractive force between molecules of the same substance, while {{c1::adhesion}} is the attractive force between molecules of different substances.',
     1),
    (deck, 27, 'cloze',
     'Surface tension arises from the {{c1::cohesive}} forces acting on the molecules at a liquid''s surface.',
     1),
    (deck, 28, 'cloze',
     'In a tube, the meniscus is {{c1::convex}} when cohesion exceeds adhesion, {{c1::concave}} when adhesion exceeds cohesion, and {{c1::flat}} when the two forces are equal.',
     1),
    (deck, 29, 'cloze',
     'A fluid''s internal resistance to flow, its internal friction, is called {{c1::viscosity}}.',
     1),
    (deck, 30, 'cloze',
     'Viscous drag — the retarding force an object feels from a fluid''s viscosity — is a {{c1::nonconservative}} force that {{c1::dissipates mechanical energy as heat}}.',
     1),
    (deck, 31, 'cloze',
     '{{c1::Laminar}} flow moves in smooth, orderly layers that do not mix, whereas {{c1::turbulent}} flow is chaotic with eddies and swirls.',
     1),
    (deck, 32, 'cloze',
     'Poiseuille''s law for laminar flow gives flow rate Q = {{c1::πr⁴ΔP/(8ηL)}}, where r is the tube radius, ΔP the pressure difference, η the viscosity, and L the tube length.',
     1),
    (deck, 33, 'cloze',
     'In Poiseuille''s law, flow rate is proportional to the tube radius raised to the {{c1::fourth}} power, so flow is extremely sensitive to small changes in radius.',
     1),
    (deck, 34, 'cloze',
     'Turbulence tends to appear once flow exceeds a {{c1::critical velocity}}, corresponding to a high {{c1::Reynolds number}}.',
     1),
    (deck, 35, 'cloze',
     'Flow resistance R is proportional to {{c1::ηL/r⁴}}, where η is the fluid''s viscosity, L the tube length, and r the tube radius.',
     1),
    (deck, 36, 'cloze',
     'For flow through a tube, the pressure drop ΔP equals {{c1::QR}}, where Q is the volume flow rate and R the resistance to flow.',
     1);

    -- ── Fluid Dynamics: Continuity & Bernoulli ────────────────────────
    INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES
    (deck, 37, 'cloze',
     'Volumetric flow rate equals a tube''s cross-sectional area times the fluid''s average flow speed: Q = {{c1::Av}}.',
     1),
    (deck, 38, 'cloze',
     'The continuity equation, {{c1::A₁v₁ = A₂v₂}}, requires an incompressible fluid''s flow rate to stay constant along a tube — expressing conservation of {{c2::mass}}.',
     2),
    (deck, 39, 'cloze',
     'By the continuity equation, an incompressible fluid speeds up where the tube {{c1::narrows}} and slows down where it {{c1::widens}}.',
     1),
    (deck, 40, 'cloze',
     'Bernoulli''s equation, {{c1::P + ½ρv² + ρgy = constant}} along a streamline, is the fluid-flow statement of conservation of {{c2::energy}}.',
     2),
    (deck, 41, 'cloze',
     'In Bernoulli''s equation P + ½ρv² + ρgy = constant, P is the {{c1::static}} pressure and ½ρv² is the {{c1::dynamic}} pressure.',
     1),
    (deck, 42, 'cloze',
     'Dynamic pressure is the {{c1::½ρv²}} term in Bernoulli''s equation, equal to a moving fluid''s {{c1::kinetic energy per unit volume}}.',
     1),
    (deck, 43, 'cloze',
     'At constant depth Bernoulli''s equation reduces to {{c1::P + ½ρv² = constant}}, so a fluid''s pressure is lowest where its speed is highest.',
     1),
    (deck, 44, 'cloze',
     'The {{c1::Venturi effect}} is the drop in pressure that occurs where a fluid speeds up through a constriction in a tube.',
     1),
    (deck, 45, 'cloze',
     'A {{c1::pitot tube}} measures a fluid''s flow speed from the difference between the stagnation pressure at a forward-facing opening and the fluid''s static pressure.',
     1);

    RAISE NOTICE 'Seeded deck % with % cards.', deck, 46;
END $$;
