-- ============================================================
-- Praxist Prep — Flashcard Seed
-- Deck: Energy, Work & Simple Machines
-- Section: physics · Topic: Physics
--
-- Coverage: energy as a system property with SI unit the joule
-- (kg·m²/s²); kinetic energy K = ½mv² with the doubled-speed
-- quadruples-K consequence; gravitational potential energy
-- U = mgh with the datum / reference-point concept; elastic
-- potential energy U = ½kx² stored in a deformed spring;
-- chemical and electric potential energy in brief; total
-- mechanical energy E = K + U; conservative vs non-conservative
-- forces (path independence, examples, closed-loop test);
-- conservation of mechanical energy (ΔE = 0 with conservative
-- forces only; W_nc = ΔE in general) and how it relates to
-- the broader first law of thermodynamics; work as energy
-- transfer through W = Fd cos θ (dot product of force and
-- displacement; perpendicular component does zero work;
-- positive vs negative work); power as the rate of energy
-- transfer P = W/t with watt = J/s and the simplified P = Fv
-- form; the work-energy theorem W_net = ΔK and its distinction
-- from total mechanical energy conservation; pressure-volume
-- work (area under the P-V curve, sign convention, isovolumetric
-- and isobaric processes); the six classical simple machines
-- (inclined plane, wedge, screw, lever, wheel-and-axle, pulley)
-- with mechanical advantage MA = F_out/F_in, the force-distance
-- trade-off, inclined plane and pulley specifics, and the
-- definition of efficiency (W_out/W_in × 100%, less than 100%
-- in real machines due to non-conservative losses).
--
-- All cards are CLOZE-format. Card content is ORIGINAL Praxist
-- Prep prose written from the underlying physics, re-sourced
-- from the OpenStax College Physics 2e textbook references in
-- the companion verification.md file; no prose is lifted from
-- any third-party source. Text-only deck (no images bundled);
-- equations render using Unicode subscripts and superscripts.
--
-- Subtopic ordering follows the AAMC content outline
-- (Foundation 4A: Translational motion, forces, work, energy,
-- and equilibrium in living systems), NOT the source .docx's
-- chapter ordering. Style follows the Physics Ch1 cadence
-- reference (physics_ch1_motion_and_forces_flashcards.sql).
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
  DELETE FROM flashcard_decks
   WHERE section = 'physics'
     AND title   IN (
           'Energy, Work & Simple Machines',
           'Work and Energy',
           'Energy & Work',
           'Chapter 2 — Energy, Work & Simple Machines',
           'Chapter 2 — Work and Energy'
         );

  -- Insert deck
  INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
  VALUES (
    'physics',
    'Physics',
    'energy_work_and_simple_machines',
    'Energy, Work & Simple Machines',
    'Energy and its forms (kinetic, gravitational PE, elastic PE, chemical, electric); total mechanical energy and its conservation; conservative vs non-conservative forces; work as the dot product of force and displacement; power; the work-energy theorem; pressure-volume work (isovolumetric and isobaric); and the six classical simple machines with mechanical advantage and efficiency.',
    2
  )
  RETURNING id INTO deck;

  -- Insert cards
  INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES

  -- ── 1. Energy Concept and Joule ──────────────────────────
  (deck,  0, 'cloze',
   'Energy is the capacity of a system to {{c1::do work}} or bring about change. Its SI unit is the {{c2::joule (J)}}, which is also the unit of work — both measure the same physical quantity expressed in base units as {{c3::kg·m²/s²}}.', 3),

  (deck,  1, 'cloze',
   'Energy comes in many interconvertible forms: {{c1::kinetic}} (motion), {{c2::potential}} (configuration), thermal, chemical, electrical, and others. The total energy of an isolated system is conserved, though it can shift between these forms freely.', 2),

  -- ── 2. Kinetic Energy ────────────────────────────────────
  (deck,  2, 'cloze',
   'The {{c1::kinetic energy}} of an object is the energy associated with its motion: {{c2::K = ½mv²}}, with mass m in kilograms and speed v in meters per second. K has SI unit of joules, like all energy forms.', 2),

  (deck,  3, 'cloze',
   'Because kinetic energy scales with the {{c1::square}} of speed, doubling an object''s speed {{c2::quadruples (×4)}} its kinetic energy. By contrast, doubling the mass merely {{c3::doubles}} the kinetic energy (linear scaling).', 3),

  (deck,  4, 'cloze',
   'Kinetic energy is a {{c1::scalar}} that depends on the magnitude of velocity (speed), not its direction. Two objects with the same mass moving at the same speed in opposite directions therefore have {{c2::identical kinetic energies}}.', 2),

  -- ── 3. Gravitational Potential Energy ────────────────────
  (deck,  5, 'cloze',
   'Gravitational potential energy near Earth''s surface is {{c1::Ug = mgh}}, where m is mass, g is the acceleration due to gravity (≈ 9.8 m/s²), and h is the {{c2::height above a chosen reference level}} (called the datum).', 2),

  (deck,  6, 'cloze',
   'Gravitational potential energy is always {{c1::relative to a chosen reference level}} — the datum. The choice of datum is arbitrary, because only differences in PE between two heights are physically meaningful (ΔU = mgΔh is independent of where you set zero).', 1),

  -- ── 4. Elastic Potential Energy ──────────────────────────
  (deck,  7, 'cloze',
   'The elastic potential energy stored in a spring deformed from its equilibrium position is {{c1::U = ½kx²}}, where {{c2::k}} is the spring constant (a material property in N/m) and x is the magnitude of the displacement from equilibrium.', 2),

  (deck,  8, 'cloze',
   'In U = ½kx², the displacement x is measured {{c1::from the spring''s equilibrium position}}, not from any external reference. Because x is squared, elastic PE is always {{c2::non-negative}} regardless of whether the spring is stretched or compressed.', 2),

  -- ── 5. Chemical and Electric Potential Energy ────────────
  (deck,  9, 'cloze',
   '{{c1::Chemical potential energy}} is energy stored in the chemical bonds of molecules. It is released or absorbed when bonds break and form — for example, during the {{c2::metabolism of food}} in the body or the combustion of a fuel.', 2),

  (deck, 10, 'cloze',
   '{{c1::Electric (electrostatic) potential energy}} arises from the position of charged particles relative to one another. Like charges store positive PE (released when they fly apart); unlike charges store {{c2::negative}} PE relative to infinite separation.', 2),

  -- ── 6. Total Mechanical Energy ───────────────────────────
  (deck, 11, 'cloze',
   'The {{c1::total mechanical energy}} of an object or system is the sum of its kinetic energy and its potential energy: {{c2::E = K + U}}. The potential energy term may include gravitational, elastic, or other forms depending on which conservative forces are present.', 2),

  -- ── 7. Conservative vs Non-Conservative Forces ───────────
  (deck, 12, 'cloze',
   'A {{c1::conservative force}} is one whose work depends only on the {{c2::start and end positions}}, not on the path taken between them. Equivalently: when an object traverses a closed loop and returns to its starting point, a conservative force does {{c3::zero net work}}.', 3),

  (deck, 13, 'cloze',
   'The three most important conservative forces in introductory physics are {{c1::gravity, the electrostatic (Coulomb) force, and the spring (elastic) force}}. Each has an associated potential energy function (mgh, kQ₁Q₂/r, ½kx²).', 1),

  (deck, 14, 'cloze',
   'A {{c1::non-conservative force}} is one whose work is {{c2::path-dependent}} — more work is required along a longer route than a shorter one between the same two endpoints. Non-conservative forces {{c3::dissipate}} mechanical energy, usually converting it to heat.', 3),

  (deck, 15, 'cloze',
   'Common non-conservative forces include {{c1::friction, air resistance (drag), and viscous drag in fluids}}. Each removes mechanical energy from the system and converts it to thermal energy, sound, or other non-recoverable forms.', 1),

  (deck, 16, 'cloze',
   'To test whether a force is conservative: have the object traverse a {{c1::closed loop}} back to its starting position. If the system returns with the same mechanical energy it started with, the force is {{c2::conservative}}; if it has lost energy, the force is {{c3::non-conservative}}.', 3),

  -- ── 8. Conservation of Mechanical Energy ─────────────────
  (deck, 17, 'cloze',
   'When only {{c1::conservative}} forces do work on a system, mechanical energy is conserved: {{c2::ΔE = ΔK + ΔU = 0}}. Equivalently, K + U has the same value at every point in the motion — any decrease in one form shows up as an increase in the other.', 2),

  (deck, 18, 'cloze',
   'When {{c1::non-conservative}} forces act, mechanical energy is generally lost. The work done by non-conservative forces equals the {{c2::change in total mechanical energy}}: Wnc = ΔE = ΔK + ΔU (typically negative when friction or drag dissipates energy).', 2),

  (deck, 19, 'cloze',
   'Conservation of {{c1::mechanical}} energy is a special case requiring no non-conservative forces. The broader principle — the {{c2::first law of thermodynamics}} — states that {{c3::total energy (mechanical + thermal + chemical + …)}} of an isolated system is always conserved, even when mechanical energy alone is not.', 3),

  -- ── 9. Work — Definition and Formula ─────────────────────
  (deck, 20, 'cloze',
   '{{c1::Work}} is the mechanism by which energy is transferred between systems through the application of a force over a distance. Its SI unit is the {{c2::joule}} — the same unit as energy, reflecting the fact that work IS energy in transit.', 2),

  (deck, 21, 'cloze',
   'Work done by a constant force F over a displacement d is {{c1::W = Fd cos θ}}, where θ is the angle between the force vector and the displacement vector. This is the {{c2::dot product}} of F and d — a scalar, despite both inputs being vectors.', 2),

  (deck, 22, 'cloze',
   'Because W = Fd cos θ, only the component of force {{c1::parallel}} (cos θ > 0) or {{c1::antiparallel}} (cos θ < 0) to the displacement does work. A force component perpendicular to the displacement contributes {{c2::zero}} work.', 2),

  (deck, 23, 'cloze',
   'A force applied perpendicular to the displacement (θ = 90°) does {{c1::zero}} work. The classic example: a {{c2::centripetal force}} in uniform circular motion is always perpendicular to the tangent velocity, so it does no work on the orbiting object even while constantly redirecting it.', 2),

  (deck, 24, 'cloze',
   'When a force has a component {{c1::parallel}} to the displacement, the work it does is {{c2::positive}} — the force adds energy to the object. When it has a component {{c1::antiparallel}} to the displacement (like friction during forward motion), the work is {{c2::negative}} — the force removes energy.', 2),

  (deck, 25, 'cloze',
   'The SI unit of work is the {{c1::joule (J)}}, defined as one newton-meter (1 J = 1 N·m). In base units, 1 J = {{c2::kg·m²/s²}} — identical to the SI unit of energy, since work is simply energy in transit.', 2),

  -- ── 10. Power ────────────────────────────────────────────
  (deck, 26, 'cloze',
   '{{c1::Power}} is the rate at which energy is transferred or work is done: {{c2::P = W/t = ΔE/t}}. Power tells you how *fast* a given amount of work is accomplished — a more powerful engine does the same amount of work in less time.', 2),

  (deck, 27, 'cloze',
   'The SI unit of power is the {{c1::watt (W)}}, defined as {{c2::one joule per second}} (1 W = 1 J/s). Common multiples include the kilowatt (1 kW = 1000 W) for engines and appliances, and the horsepower (1 hp ≈ 746 W) in older mechanical contexts.', 2),

  (deck, 28, 'cloze',
   'For an object moving at constant velocity v under a constant force F applied parallel to the motion, the power delivered by the force simplifies to {{c1::P = Fv}}. This follows directly from substituting W = Fd into P = W/t with d/t = v.', 1),

  (deck, 29, 'cloze',
   '{{c1::Average}} power is the total work divided by the total time interval (W/Δt). {{c2::Instantaneous}} power is the limit as Δt → 0 — the rate of work at a specific moment. Average and instantaneous power are equal only when the power delivered is {{c3::constant}} throughout the interval.', 3),

  -- ── 11. Work-Energy Theorem ──────────────────────────────
  (deck, 30, 'cloze',
   'The {{c1::work-energy theorem}} states that the net work done on an object by all forces equals its change in kinetic energy: {{c2::Wnet = ΔK = Kf − Ki}}. This holds regardless of which kinds of forces are involved — conservative or non-conservative.', 2),

  (deck, 31, 'cloze',
   'The work-energy theorem (Wnet = ΔK) relates net work to {{c1::kinetic energy only}} — not potential, not total mechanical energy. By contrast, the broader energy-conservation principle (ΔE = Wnc when E = K + U) relates non-conservative work to {{c2::total mechanical}} energy.', 2),

  -- ── 12. P-V Work, Simple Machines, Efficiency ────────────
  (deck, 32, 'cloze',
   'For a gas undergoing a thermodynamic process, the work done equals the {{c1::area under the curve}} on a pressure-vs-volume (P-V) graph. The exact area depends on the path taken, so different processes between the same two endpoints can do {{c2::different amounts of work}}.', 2),

  (deck, 33, 'cloze',
   'Sign convention for P-V work: when a gas {{c1::expands}} (ΔV > 0), it does {{c2::positive}} work on the surroundings. When a gas is {{c1::compressed}} (ΔV < 0), the surroundings do positive work on it, and we say the work done by the gas is {{c2::negative}}.', 2),

  (deck, 34, 'cloze',
   'In an {{c1::isovolumetric (isochoric)}} process, volume stays constant — the curve is a vertical line on a P-V diagram enclosing no area. Therefore the work done is {{c2::W = 0}}, regardless of how much the pressure changes.', 2),

  (deck, 35, 'cloze',
   'In an {{c1::isobaric}} process, pressure stays constant — the curve is a horizontal line. The enclosed rectangle gives work {{c2::W = PΔV}}, positive when the gas expands and negative when it is compressed.', 2),

  (deck, 36, 'cloze',
   'The six classical simple machines are the {{c1::inclined plane, wedge, screw, lever, wheel-and-axle, and pulley}}. Each provides {{c2::mechanical advantage}} by trading reduced force for increased distance.', 2),

  (deck, 37, 'cloze',
   '{{c1::Mechanical advantage}} of a simple machine is the ratio of the output force it produces to the input force applied: {{c2::MA = Fout / Fin}}.', 2),

  (deck, 38, 'cloze',
   'Simple machines do not create energy — they only redistribute it. For an ideal (frictionless) machine, the work done by the input equals the work done by the output: {{c1::Fin × din = Fout × dout}}. So a higher mechanical advantage always comes with a longer input-distance trade-off.', 1),

  (deck, 39, 'cloze',
   'For a frictionless inclined plane of length L and height h, the mechanical advantage is {{c1::MA = L/h}} (equivalently, 1/sin θ where θ is the incline angle). A gentler incline (smaller θ, longer L for a given h) gives larger mechanical advantage.', 1),

  (deck, 40, 'cloze',
   'A single fixed pulley merely changes the {{c1::direction}} of the applied force without reducing its magnitude — its mechanical advantage is {{c2::1}}. To lift a load of weight W with a single fixed pulley, you must pull down with a force of magnitude W.', 2),

  (deck, 41, 'cloze',
   'In a pulley system, the mechanical advantage equals the number of {{c1::rope segments directly supporting the load}}. A two-rope system halves the required effort (MA = 2); a four-rope system quarters it (MA = 4). The effort distance increases by the same factor.', 1),

  (deck, 42, 'cloze',
   'The {{c1::efficiency}} of a real machine is the ratio of its useful work output to the work input, usually expressed as a percentage: {{c2::Efficiency = (Wout / Win) × 100%}}. For an ideal frictionless machine, efficiency = 100%; real machines are always less.', 2),

  (deck, 43, 'cloze',
   'Real machines fall short of 100% efficiency because some input energy is lost to {{c1::non-conservative forces}} — friction in joints and bearings, deformation of cables, drag in surrounding air. The lost energy is converted to {{c2::heat (and sometimes sound)}}, leaving the system unable to do useful work.', 2);

  RAISE NOTICE 'Seeded deck % with % cards.', deck, (SELECT COUNT(*) FROM flashcards WHERE deck_id = deck);
END $$;
