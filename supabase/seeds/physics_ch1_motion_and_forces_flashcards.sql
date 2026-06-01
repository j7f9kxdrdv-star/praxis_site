-- ============================================================
-- Praxist Prep — Flashcard Seed
-- Deck: Motion & Forces
-- Section: physics · Topic: Physics
--
-- Coverage: SI base units and derived units; the electron volt;
-- vectors vs scalars with examples of each; graphical (tip-to-
-- tail) vector addition; the component method for vector
-- addition with Pythagorean magnitude and tangent direction;
-- vector subtraction and scalar multiplication; the dot
-- product and cross product (with the right-hand rule);
-- displacement vs distance, velocity vs speed, and average vs
-- instantaneous values for each; acceleration with V-T graph
-- interpretation and the deceleration concept; force as a
-- vector with SI unit the newton; Newton's law of universal
-- gravitation with G = 6.67 × 10⁻¹¹ N·m²/kg²; the distinction
-- between mass (scalar, kg) and weight (vector, N) with the
-- W = mg formula; friction (overview, static inequality
-- 0 ≤ fₛ ≤ μₛN, kinetic equation fₖ = μₖN, and the μₛ > μₖ
-- rule); mass as a measure of inertia; Newton's three laws
-- with their vector formulations; the four kinematic
-- equations for constant acceleration and when to use each;
-- free fall and terminal velocity; projectile motion with the
-- independence of horizontal and vertical components and the
-- key high-yield point that horizontal velocity stays constant;
-- gravity components on a frictionless incline (mg sin θ and
-- mg cos θ); circular motion with tangential velocity,
-- centripetal acceleration v²/r, and centripetal force as a
-- role rather than a separate force type; uniform circular
-- motion; free body diagrams; translational and rotational
-- equilibrium with their conditions ΣF = 0 and Στ = 0;
-- torque τ = rF sin θ; and the standard CCW-positive /
-- CW-negative torque sign convention.
--
-- All cards are CLOZE-format. Card content is ORIGINAL Praxist
-- Prep prose written from the underlying physics, re-sourced
-- from the OpenStax College Physics 2e textbook references
-- in the companion verification.md file; no prose is lifted
-- from any third-party source, and no images are bundled
-- with this deck (a text-only deck was chosen because the
-- equations and concepts render cleanly in cloze text with
-- Unicode subscripts and superscripts, and the .apkg-bundled
-- images came from non-redistributable third-party websites).
--
-- Subtopic ordering follows the AAMC content outline
-- (Foundation 4A: Translational motion, forces, work, energy,
-- and equilibrium in living systems), NOT the source .docx's
-- chapter ordering.
--
-- This deck is the cadence reference for subsequent Physics
-- chapters under v6 (per the prompt's style-anchor rule for
-- new subjects).
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
           'Motion & Forces',
           'Kinematics and Dynamics',
           'Motion, Forces & Equilibrium',
           'Chapter 1 — Motion & Forces',
           'Chapter 1 — Kinematics and Dynamics'
         );

  -- Insert deck
  INSERT INTO flashcard_decks (section, topic, subtopic, title, description, sort_order)
  VALUES (
    'physics',
    'Physics',
    'motion_and_forces',
    'Motion & Forces',
    'SI units; vectors and scalars; vector operations (graphical and component methods, dot and cross products, right-hand rule); displacement, velocity, speed, and acceleration; force, gravity, friction, mass vs weight; Newton''s three laws; the four kinematic equations for constant acceleration; free fall, terminal velocity, and projectile motion; inclined planes; circular motion with centripetal acceleration and force; free body diagrams; translational and rotational equilibrium; and torque.',
    1
  )
  RETURNING id INTO deck;

  -- Insert cards
  INSERT INTO flashcards (deck_id, position, card_type, cloze_text, cloze_count) VALUES

  -- ── 1. Units ─────────────────────────────────────────────
  (deck,  0, 'cloze',
   'The {{c1::SI (Système International) system}} defines seven base units from which all other physical units are derived: the {{c2::meter (length), kilogram (mass), second (time), ampere (electric current), kelvin (temperature), mole (amount of substance), and candela (luminous intensity)}}.', 2),

  (deck,  1, 'cloze',
   '{{c1::Base units}} are the seven foundational SI units (meter, kilogram, second, etc.) from which every other unit is built. {{c2::Derived units}} are constructed by combining base units — for example, m/s for velocity, m/s² for acceleration, and kg·m/s² (the newton) for force.', 2),

  (deck,  2, 'cloze',
   'An {{c1::electron volt (eV)}} is the energy an electron gains when accelerated through a potential difference of {{c2::one volt}}; it is the practical energy unit at the atomic scale, where the joule is too large.', 2),

  -- ── 2. Vectors vs Scalars ────────────────────────────────
  (deck,  3, 'cloze',
   'A {{c1::vector}} is a physical quantity with both {{c2::magnitude}} and {{c2::direction}}; common vector examples include {{c3::displacement, velocity, acceleration, and force}}.', 3),

  (deck,  4, 'cloze',
   'A {{c1::scalar}} is a physical quantity with {{c2::magnitude only}} — no direction. Scalar examples include {{c3::distance, speed, mass, energy, pressure, and the coefficients of friction}}.', 3),

  -- ── 3. Vector Graphical Addition ─────────────────────────
  (deck,  5, 'cloze',
   'In the {{c1::tip-to-tail method}}, vectors are added graphically by moving each successive vector so its {{c2::tail starts at the previous vector''s tip}}, keeping all magnitudes and directions intact. The {{c3::resultant vector}} then connects the very first tail to the very last tip.', 3),

  -- ── 4. Vector Component Method ───────────────────────────
  (deck,  6, 'cloze',
   'Any vector can be {{c1::resolved into perpendicular components}} (typically along the x- and y-axes); these components carry signs (positive or negative) indicating which way along each axis the vector points.', 1),

  (deck,  7, 'cloze',
   'To add vectors by the component method: (1) resolve each vector into x- and y-components, (2) add the x-components separately and the y-components separately, (3) the resultant''s components are {{c1::Rₓ = Aₓ + Bₓ}} and {{c1::Ry = Ay + By}}.', 1),

  (deck,  8, 'cloze',
   'After computing the resultant''s components, its magnitude is obtained from the {{c1::Pythagorean theorem}}: R = √(Rₓ² + Ry²). Its direction (the angle from the +x axis) is given by {{c2::θ = tan⁻¹(Ry/Rₓ)}}.', 2),

  -- ── 5. Vector Subtraction & Scalar Multiplication ────────
  (deck,  9, 'cloze',
   'Vector subtraction is performed by reversing the direction of the subtracted vector and adding: {{c1::A − B = A + (−B)}}, where −B has the same magnitude as B but points in the opposite direction.', 1),

  (deck, 10, 'cloze',
   'When a vector is multiplied by a scalar n, the resulting vector has magnitude {{c1::|n| times the original}}. If n is {{c2::positive}}, the new vector is parallel to the original; if n is {{c3::negative}}, the new vector is antiparallel.', 3),

  -- ── 6. Dot and Cross Products ────────────────────────────
  (deck, 11, 'cloze',
   'The {{c1::dot product (scalar product)}} of two vectors yields a {{c2::scalar}}: A·B = |A||B|cos θ, where θ is the angle between them. Work — the dot product of force and displacement — is the classic physics example.', 2),

  (deck, 12, 'cloze',
   'The {{c1::cross product (vector product)}} of two vectors yields a new {{c2::vector}} whose magnitude is |A||B|sin θ. The resulting vector is always {{c3::perpendicular to the plane}} containing the two input vectors. Torque — the cross product of position and force — is the classic example.', 3),

  (deck, 13, 'cloze',
   'The direction of a cross product A × B is given by the {{c1::right-hand rule}}: point your fingers along A, curl them toward B, and your thumb points in the direction of A × B.', 1),

  -- ── 7. Displacement, Distance, Velocity, Speed ───────────
  (deck, 14, 'cloze',
   '{{c1::Displacement}} is the vector from a starting point to an ending point — fully determined by those two locations alone, regardless of the path actually taken. {{c2::Distance}} is a scalar reflecting the total path length and is always ≥ |displacement|.', 2),

  (deck, 15, 'cloze',
   '{{c1::Velocity}} is a vector measuring the rate of change of {{c2::displacement}} with respect to time; its SI unit is {{c3::meters per second (m/s)}}, and its direction matches the direction of the displacement.', 3),

  (deck, 16, 'cloze',
   '{{c1::Speed}} is a scalar — the magnitude of velocity for instantaneous values, but the ratio of {{c2::distance traveled to elapsed time}} for averages. Average speed and the magnitude of average velocity are NOT generally equal, because distance ≥ |displacement|.', 2),

  (deck, 17, 'cloze',
   'Average velocity is the {{c1::displacement divided by elapsed time}}: v̄ = Δx/Δt. Its direction matches the direction of the displacement vector.', 1),

  (deck, 18, 'cloze',
   '{{c1::Instantaneous velocity}} is the limit of average velocity as Δt approaches zero; geometrically, it is the {{c2::slope of the position-vs-time graph}} at that instant.', 2),

  -- ── 8. Acceleration ──────────────────────────────────────
  (deck, 19, 'cloze',
   '{{c1::Acceleration}} is the vector rate of change of {{c2::velocity}}: ā = Δv/Δt. Its SI unit is {{c3::meters per second squared (m/s²)}}, and it points in the same direction as the net force producing it.', 3),

  (deck, 20, 'cloze',
   'When acceleration points {{c1::opposite}} to the velocity, the object slows down — this case is sometimes called {{c2::deceleration}}, but it is just acceleration with a negative sign relative to the chosen direction of motion.', 2),

  (deck, 21, 'cloze',
   'On a velocity-vs-time graph, the {{c1::slope}} at any instant gives the acceleration. A positive slope means acceleration parallel to velocity (speeding up); a negative slope means acceleration antiparallel to velocity (slowing down or reversing direction).', 1),

  -- ── 9. Forces — Gravity, Friction, Mass vs Weight ────────
  (deck, 22, 'cloze',
   'A {{c1::force}} is any push or pull that can cause an object to accelerate. Force is a {{c2::vector}}, and its SI unit is the {{c3::newton (N) = kg·m/s²}}.', 3),

  (deck, 23, 'cloze',
   'Newton''s law of universal gravitation: every pair of masses attracts each other with a force {{c1::F_g = Gm₁m₂/r²}}, where {{c2::G = 6.67 × 10⁻¹¹ N·m²/kg²}} is the universal gravitational constant and r is the distance between the centers of the two masses.', 2),

  (deck, 24, 'cloze',
   '{{c1::Mass}} quantifies an object''s {{c2::inertia}} — its resistance to acceleration — and is a {{c3::scalar}} with SI unit the {{c4::kilogram}}. Mass is independent of location. {{c5::Weight}}, by contrast, is the gravitational force on that mass; it is a {{c3::vector}} measured in {{c6::newtons}}.', 6),

  (deck, 25, 'cloze',
   'On a planet, the weight of an object is given by {{c1::W = mg}}, where m is the object''s mass and g is the {{c2::local acceleration due to gravity}} (≈ 9.8 m/s² on Earth''s surface). Note: lowercase g is acceleration; uppercase G is the universal gravitational constant — they are different quantities.', 2),

  (deck, 26, 'cloze',
   '{{c1::Friction}} is a contact force that opposes the {{c2::relative motion (or attempted relative motion)}} of surfaces in contact; it arises from microscopic interactions between the two surfaces. Friction always points along the contact surface, never perpendicular to it.', 2),

  (deck, 27, 'cloze',
   'The static friction force is not a single value — it ranges from zero up to a maximum: {{c1::0 ≤ fₛ ≤ μₛN}}, where μₛ is the coefficient of static friction and N is the normal force. Static friction matches whatever opposing force is applied, up to the μₛN limit; beyond that, the object slips.', 1),

  (deck, 28, 'cloze',
   'Once an object is actually sliding, kinetic friction takes over and has a single fixed magnitude for given materials: {{c1::fₖ = μₖN}}, with μₖ a unitless coefficient depending on the two materials in contact.', 1),

  (deck, 29, 'cloze',
   'For any given pair of surfaces, the {{c1::coefficient of static friction is always greater than the coefficient of kinetic friction (μₛ > μₖ)}}. That is why it takes more force to start an object sliding than to keep it sliding once started.', 1),

  -- ── 10. Newton's Three Laws ──────────────────────────────
  (deck, 30, 'cloze',
   'In Newtonian physics, {{c1::mass}} is the measure of an object''s {{c2::inertia}} — its resistance to a change in velocity. The greater the mass, the larger the force required to produce a given acceleration.', 2),

  (deck, 31, 'cloze',
   'Newton''s first law (the law of {{c1::inertia}}) states that an object maintains its current state of motion — at rest if at rest, in constant velocity if moving — unless a {{c2::net external force}} changes it. Equivalently, {{c3::F_net = 0 implies a = 0}}.', 3),

  (deck, 32, 'cloze',
   'Newton''s second law states that the net force on an object equals its mass times its acceleration: {{c1::F_net = ma}}. Because F and a are both vectors, they always point in the {{c2::same direction}}.', 2),

  (deck, 33, 'cloze',
   'Newton''s third law: when object A exerts a force on object B, object B simultaneously exerts an equal-magnitude {{c1::opposite-direction}} force back on A — mathematically, {{c2::F_AB = −F_BA}}. These two forces act on {{c3::different objects}} and cannot cancel each other out.', 3),

  -- ── 11. Kinematic Equations & Linear Motion ──────────────
  (deck, 34, 'cloze',
   'The four kinematic equations apply only when {{c1::acceleration is constant}} — they cannot be used during intervals where the net force changes. For variable acceleration, calculus or piecewise analysis is required.', 1),

  (deck, 35, 'cloze',
   'For motion with constant acceleration, the final velocity after time t is {{c1::v = v₀ + at}}, where v₀ is the initial velocity and a is the constant acceleration. Use this when displacement is not given but time, initial velocity, and acceleration are.', 1),

  (deck, 36, 'cloze',
   'For motion with constant acceleration, displacement from the starting point is {{c1::x = v₀t + ½at²}}. Use this when final velocity is not given but time is.', 1),

  (deck, 37, 'cloze',
   'For motion with constant acceleration, the time-independent kinematic equation is {{c1::v² = v₀² + 2aΔx}}. Use this when time is not given but initial velocity, final velocity, and displacement are all involved.', 1),

  (deck, 38, 'cloze',
   'When acceleration is constant, the average velocity is just the arithmetic mean of the initial and final velocities: {{c1::v̄ = (v₀ + v)/2}}. Displacement can then be written as {{c2::x = v̄t}}.', 2),

  -- ── 12. Free Fall & Projectile Motion ────────────────────
  (deck, 39, 'cloze',
   'An object is in {{c1::free fall}} when the only force acting on it is gravity. Near Earth''s surface (with air resistance neglected), it accelerates downward at a constant {{c2::g ≈ 9.8 m/s²}} regardless of its mass.', 2),

  (deck, 40, 'cloze',
   'In real free fall through air, an object also experiences a {{c1::drag force}} that grows with speed. When drag balances weight, the net force is zero and the object continues at a constant speed called the {{c2::terminal velocity}}.', 2),

  (deck, 41, 'cloze',
   'In projectile motion (2D motion under gravity alone), the horizontal and vertical motions are mathematically {{c1::independent}}. Gravity acts only along the {{c2::vertical}} axis, while no force acts along the horizontal axis (with air resistance neglected).', 2),

  (deck, 42, 'cloze',
   'Because no horizontal force acts on a projectile (ignoring air resistance), the {{c1::horizontal velocity remains constant}} throughout the flight. Only the {{c2::vertical}} velocity changes — by g (≈ 9.8 m/s²) downward each second.', 2),

  -- ── 13. Inclined Planes & Circular Motion ────────────────
  (deck, 43, 'cloze',
   'On a frictionless incline of angle θ, gravity decomposes into two components: a {{c1::parallel}} component along the slope, F∥ = {{c2::mg sin θ}} (driving the object down the slope), and a {{c1::perpendicular}} component pressing into the surface, F⊥ = {{c3::mg cos θ}} (balanced by the normal force from the slope).', 3),

  (deck, 44, 'cloze',
   'For an object moving along a circular path, the instantaneous velocity vector is always {{c1::tangent}} to the circle at the object''s current position — perpendicular to the radius at that point. If the centripetal force were suddenly removed, the object would continue in a straight line along this tangent.', 1),

  (deck, 45, 'cloze',
   'Even when an object moves at constant speed in a circle, its direction is constantly changing, so it must be accelerating. This {{c1::centripetal acceleration}} has magnitude {{c2::aₐ = v²/r}} and always points {{c3::toward the center}} of the circular path.', 3),

  (deck, 46, 'cloze',
   'In any circular motion, the net inward force is called the {{c1::centripetal force}}. This is not a separate kind of force — it is whatever actual force (gravity, tension, normal, friction, electromagnetic) happens to be directed toward the center of the circle. Its magnitude is {{c2::F_c = mv²/r}}.', 2),

  (deck, 47, 'cloze',
   '{{c1::Uniform circular motion}} is the special case where speed is constant. The tangential force is then {{c2::zero}} (no change in speed), while the centripetal force is what continually redirects the velocity toward the center.', 2),

  -- ── 14. Mechanical Equilibrium & Torque ──────────────────
  (deck, 48, 'cloze',
   'A {{c1::free body diagram}} is a sketch isolating a single object and showing every external force acting on it as a labeled arrow. Drawing one is the standard first step in any Newton''s-law problem.', 1),

  (deck, 49, 'cloze',
   'An object is in {{c1::translational equilibrium}} when the vector sum of all forces on it is zero: {{c2::ΣF = 0}}. This is the {{c3::first condition of equilibrium}}; the object then has constant velocity (which may be zero).', 3),

  (deck, 50, 'cloze',
   'An object is in {{c1::rotational equilibrium}} when the vector sum of all torques on it is zero: {{c2::Στ = 0}}. This is the {{c3::second condition of equilibrium}}; the object then has constant angular velocity (usually zero on MCAT problems).', 3),

  (deck, 51, 'cloze',
   'The {{c1::torque}} produced by a force applied at distance r from the pivot is τ = {{c2::rF sin θ}}, where θ is the angle between the lever arm and the force vector. Torque is the {{c3::cross product}} of the position vector and the force vector.', 3),

  (deck, 52, 'cloze',
   'By standard convention, torques producing {{c1::counterclockwise}} rotation are taken as {{c2::positive}}, and torques producing {{c1::clockwise}} rotation are taken as {{c2::negative}}. In rotational equilibrium, the positive and negative torques cancel exactly.', 2);

  RAISE NOTICE 'Seeded deck % with % cards.', deck, (SELECT COUNT(*) FROM flashcards WHERE deck_id = deck);
END $$;
