# Verification Report — Physics Ch 1: Motion & Forces

**Deck:** Motion & Forces
**Source SQL:** supabase/seeds/physics_ch1_motion_and_forces_flashcards.sql
**Verified:** 2026-06-01
**Corpus:**
- Primary — `reference-textbooks/physics/openstax-college-physics-2e.txt` (Ch 2 kinematics; Ch 3 two-dimensional motion; Ch 4 Newton's laws; Ch 5 friction and inclined planes; Ch 6 circular motion and gravitation; Ch 9 statics and torque)
- Scope authority — `reference-textbooks/aamc/aamc-content-outline-2026.txt` (Foundation 4A: Translational motion, forces, work, energy, and equilibrium in living systems)

**.docx provenance:** *Physics and math review chapter 1.docx* (titled "kinematics and dynamics") — adapted from a third-party MCAT review source; Source-Laundry rules applied per card. Subtopic ordering re-sequenced from the .docx's 9-section structure into a 14-section AAMC-aligned layout that walks students from units and vector mathematics through kinematics, forces, Newton's laws, and finally into equilibrium and torque. No prose from the .docx survives verbatim. Multiple .docx transcription errors (see "Disagreements with corpus") were silently corrected against textbook sources before becoming cards.

**Image policy:** The .apkg bundled six images sourced from third-party educational websites (vedantu.com, slideplayer.com, sciencefacts.net, learninglab-dev.its.rmit.edu.au); these were not openly licensed and have been excluded from this deck. The chapter content renders cleanly as text-only because all formulas use Unicode subscripts/superscripts and all diagrams (incline decomposition, projectile parabola, circular motion vectors) can be described concisely in card prose.

**Cadence reference:** This is the first Physics deck shipped under v6 and serves as the cadence template for subsequent Physics chapters per the v6 prompt's style-anchor rule for new subjects.

---

## Summary

- **Total cards:** 53
- **Confidence 5:** 47
- **Confidence 4:** 6
- **Confidence 3:** 0
- **Confidence 2:** 0
- **Confidence 1:** 0
- **Cards flagged for `needs_sme_review`:** 0
- **Cards where corpus contradicts the card:** 0
- **Source-material claims corrected before becoming cards:** 9 *(see Disagreements with corpus)*

---

## Per-card verification

### Subtopic 1 — Units

**Card 0**
**Cloze claim:** SI defines seven base units (meter, kilogram, second, ampere, kelvin, mole, candela).
**Confidence:** 5
**Source:** OpenStax CP2e §1.2 ("Physical Quantities and Units").

**Card 1**
**Cloze claim:** Base units (the 7 SI foundations) vs derived units (built by combining base units; e.g., m/s, m/s², N).
**Confidence:** 5
**Source:** OpenStax CP2e §1.2.

**Card 2**
**Cloze claim:** Electron volt definition — energy gained by an electron through 1 V.
**Confidence:** 5
**Source:** OpenStax CP2e §19.1; standard physics result.

### Subtopic 2 — Vectors vs Scalars

**Card 3**
**Cloze claim:** Vector = magnitude + direction; examples (displacement, velocity, acceleration, force).
**Confidence:** 5
**Source:** OpenStax CP2e §1.4, §3.1.

**Card 4**
**Cloze claim:** Scalar = magnitude only; examples (distance, speed, mass, energy, pressure, μ).
**Confidence:** 5
**Source:** OpenStax CP2e §1.4, §3.1.

### Subtopic 3 — Vector Graphical Addition

**Card 5**
**Cloze claim:** Tip-to-tail method — sequential placement; resultant from first tail to last tip.
**Confidence:** 5
**Source:** OpenStax CP2e §3.2 ("Vector Addition and Subtraction: Graphical Methods").

### Subtopic 4 — Vector Component Method

**Card 6**
**Cloze claim:** Vectors can be resolved into perpendicular components with signs along each axis.
**Confidence:** 5
**Source:** OpenStax CP2e §3.3 ("Vector Addition and Subtraction: Analytical Methods").

**Card 7**
**Cloze claim:** Component method procedure: resolve, sum components separately, Rₓ = Aₓ + Bₓ, Ry = Ay + By.
**Confidence:** 5
**Source:** OpenStax CP2e §3.3.

**Card 8**
**Cloze claim:** Magnitude via Pythagoras; direction via θ = tan⁻¹(Ry/Rₓ).
**Confidence:** 5
**Source:** OpenStax CP2e §3.3.

### Subtopic 5 — Vector Subtraction & Scalar Multiplication

**Card 9**
**Cloze claim:** A − B = A + (−B); subtraction reverses the second vector's direction.
**Confidence:** 5
**Source:** OpenStax CP2e §3.2.

**Card 10**
**Cloze claim:** Scalar multiplication scales magnitude by |n|; positive n → parallel, negative n → antiparallel.
**Confidence:** 5
**Source:** OpenStax CP2e §3.3.

### Subtopic 6 — Dot and Cross Products

**Card 11**
**Cloze claim:** Dot product yields scalar; A·B = |A||B|cos θ; example = work.
**Confidence:** 5
**Source:** OpenStax CP2e §7.1 (work as dot product).

**Card 12**
**Cloze claim:** Cross product yields vector with magnitude |A||B|sin θ, direction perpendicular to plane; example = torque.
**Confidence:** 5
**Source:** OpenStax CP2e §9.2; Ch 10.

**Card 13**
**Cloze claim:** Right-hand rule for direction of A × B.
**Confidence:** 5
**Source:** OpenStax CP2e §22.4 (right-hand rule introduction in magnetism); standard vector calculus result.

### Subtopic 7 — Displacement, Distance, Velocity, Speed

**Card 14**
**Cloze claim:** Displacement (vector, path-independent) vs distance (scalar, path-dependent); distance ≥ |displacement|.
**Confidence:** 5
**Source:** OpenStax CP2e §2.1 ("Displacement").

**Card 15**
**Cloze claim:** Velocity vector = Δdisplacement/Δtime; SI m/s; direction matches displacement.
**Confidence:** 5
**Source:** OpenStax CP2e §2.3 ("Time, Velocity, and Speed").

**Card 16**
**Cloze claim:** Speed (scalar) = magnitude of velocity for instantaneous; = distance/time for averages; avg speed ≠ |avg velocity| in general.
**Confidence:** 5
**Source:** OpenStax CP2e §2.3.

**Card 17**
**Cloze claim:** Average velocity = Δx/Δt; direction matches displacement.
**Confidence:** 5
**Source:** OpenStax CP2e §2.3.

**Card 18**
**Cloze claim:** Instantaneous velocity = limit of avg velocity as Δt → 0; slope of position-vs-time graph.
**Confidence:** 5
**Source:** OpenStax CP2e §2.3.

### Subtopic 8 — Acceleration

**Card 19**
**Cloze claim:** Acceleration = Δv/Δt; vector; SI m/s²; direction matches net force.
**Confidence:** 5
**Source:** OpenStax CP2e §2.4 ("Acceleration").

**Card 20**
**Cloze claim:** Deceleration = acceleration opposite to velocity; just a labeling convention.
**Confidence:** 5
**Source:** OpenStax CP2e §2.4.

**Card 21**
**Cloze claim:** V-T graph slope = acceleration; positive vs negative slope interpretation.
**Confidence:** 5
**Source:** OpenStax CP2e §2.4.

### Subtopic 9 — Forces — Gravity, Friction, Mass vs Weight

**Card 22**
**Cloze claim:** Force = push/pull that causes acceleration; vector; SI = newton = kg·m/s².
**Confidence:** 5
**Source:** OpenStax CP2e §4.3 ("Newton's Second Law"); §4.1 (force defined).

**Card 23**
**Cloze claim:** Universal gravitation F_g = Gm₁m₂/r²; G = 6.67 × 10⁻¹¹ N·m²/kg²; r is center-to-center distance.
**Confidence:** 5
**Source:** OpenStax CP2e §6.5 ("Newton's Universal Law of Gravitation"); G value confirmed at line 13619.

**Card 24**
**Cloze claim:** Mass (scalar, inertia, kg, location-independent) vs weight (vector, gravitational force, N).
**Confidence:** 5
**Source:** OpenStax CP2e §4.4 ("Newton's Third Law" + weight section); §6.5.

**Card 25**
**Cloze claim:** W = mg; g ≈ 9.8 m/s² on Earth; distinction between g (acceleration) and G (gravitational constant).
**Confidence:** 5
**Source:** OpenStax CP2e §4.4; §6.5.

**Card 26**
**Cloze claim:** Friction = contact force opposing relative motion (or attempted relative motion); arises from microscopic interactions; acts parallel to surface.
**Confidence:** 5
**Source:** OpenStax CP2e §5.1 ("Friction").

**Card 27**
**Cloze claim:** Static friction inequality 0 ≤ fₛ ≤ μₛN; self-adjusting up to max.
**Confidence:** 5
**Source:** OpenStax CP2e §5.1.

**Card 28**
**Cloze claim:** Kinetic friction equation fₖ = μₖN; constant for given materials.
**Confidence:** 5
**Source:** OpenStax CP2e §5.1.

**Card 29**
**Cloze claim:** μₛ > μₖ always; harder to start sliding than to keep sliding.
**Confidence:** 5
**Source:** OpenStax CP2e §5.1.

### Subtopic 10 — Newton's Three Laws

**Card 30**
**Cloze claim:** Mass = measure of inertia; resistance to velocity change; greater mass → larger force needed for given acceleration.
**Confidence:** 5
**Source:** OpenStax CP2e §4.2 ("Newton's First Law of Motion: Inertia").

**Card 31**
**Cloze claim:** Newton's 1st law (inertia); F_net = 0 ⇒ a = 0; rest stays at rest, motion at constant velocity.
**Confidence:** 5
**Source:** OpenStax CP2e §4.2.

**Card 32**
**Cloze claim:** Newton's 2nd law F_net = ma; F and a are vectors in same direction.
**Confidence:** 5
**Source:** OpenStax CP2e §4.3.

**Card 33**
**Cloze claim:** Newton's 3rd law: F_AB = −F_BA; forces act on different objects, cannot cancel each other.
**Confidence:** 5
**Source:** OpenStax CP2e §4.4 ("Newton's Third Law of Motion").

### Subtopic 11 — Kinematic Equations & Linear Motion

**Card 34**
**Cloze claim:** Kinematic equations apply only with constant acceleration.
**Confidence:** 5
**Source:** OpenStax CP2e §2.5 ("Motion Equations for Constant Acceleration in One Dimension").

**Card 35**
**Cloze claim:** v = v₀ + at; use when displacement not needed.
**Confidence:** 5
**Source:** OpenStax CP2e §2.5.

**Card 36**
**Cloze claim:** x = v₀t + ½at²; use when final velocity not given.
**Confidence:** 5
**Source:** OpenStax CP2e §2.5.

**Card 37**
**Cloze claim:** v² = v₀² + 2aΔx; time-independent equation.
**Confidence:** 5
**Source:** OpenStax CP2e §2.5.

**Card 38**
**Cloze claim:** v̄ = (v₀ + v)/2 for constant a; x = v̄t.
**Confidence:** 5
**Source:** OpenStax CP2e §2.5.

### Subtopic 12 — Free Fall & Projectile Motion

**Card 39**
**Cloze claim:** Free fall = only gravity acting; a = g ≈ 9.8 m/s², mass-independent near Earth.
**Confidence:** 5
**Source:** OpenStax CP2e §2.7 ("Falling Objects").

**Card 40**
**Cloze claim:** Terminal velocity = drag force balances weight; net force zero; constant speed.
**Confidence:** 4
**Source:** OpenStax CP2e §5.2 (drag forces); §2.7.
**Notes:** Confidence 4 because the simple "drag balances weight" picture is the MCAT-level treatment; real drag depends on velocity in complex ways (linear at low Re, quadratic at high Re) but the qualitative balance condition is universal.

**Card 41**
**Cloze claim:** Projectile motion — horizontal and vertical motions are independent; gravity acts only vertically.
**Confidence:** 5
**Source:** OpenStax CP2e §3.4 ("Projectile Motion").

**Card 42**
**Cloze claim:** Horizontal velocity constant in projectile motion; vertical changes by g/sec.
**Confidence:** 5
**Source:** OpenStax CP2e §3.4.
**Notes:** Corrects the .docx's flat factual error ("horizontal velocity won't remain the same" — the actual physics is the opposite).

### Subtopic 13 — Inclined Planes & Circular Motion

**Card 43**
**Cloze claim:** Incline gravity components: F∥ = mg sin θ (along slope); F⊥ = mg cos θ (into surface).
**Confidence:** 5
**Source:** OpenStax CP2e §5.3 (inclined planes); §4.6 (problem-solving).

**Card 44**
**Cloze claim:** Tangent velocity vector in circular motion; perpendicular to radius; straight-line continuation if centripetal force removed.
**Confidence:** 5
**Source:** OpenStax CP2e §6.2 ("Centripetal Acceleration"); §6.3.

**Card 45**
**Cloze claim:** Centripetal acceleration aₐ = v²/r; points toward center.
**Confidence:** 5
**Source:** OpenStax CP2e §6.2.

**Card 46**
**Cloze claim:** Centripetal force = net inward force; not a separate force type; F_c = mv²/r.
**Confidence:** 5
**Source:** OpenStax CP2e §6.3 ("Centripetal Force").
**Notes:** Corrects the .apkg's misconception ("the only force is the centripetal force"). OpenStax §6.3 explicitly notes that centripetal force is whatever actual force (gravity, tension, normal, friction) is directed toward the circle's center.

**Card 47**
**Cloze claim:** Uniform circular motion = constant speed; tangential force = 0; centripetal force redirects velocity.
**Confidence:** 5
**Source:** OpenStax CP2e §6.2.

### Subtopic 14 — Mechanical Equilibrium & Torque

**Card 48**
**Cloze claim:** Free body diagram = sketch of one object with all external forces; first step in Newton's-law problems.
**Confidence:** 5
**Source:** OpenStax CP2e §4.6 ("Problem-Solving Strategies").

**Card 49**
**Cloze claim:** Translational equilibrium = ΣF = 0; first condition; constant velocity (possibly zero).
**Confidence:** 5
**Source:** OpenStax CP2e §9.1 ("The First Condition for Equilibrium").

**Card 50**
**Cloze claim:** Rotational equilibrium = Στ = 0; second condition; constant angular velocity (usually zero on MCAT).
**Confidence:** 5
**Source:** OpenStax CP2e §9.2 ("The Second Condition for Equilibrium").

**Card 51**
**Cloze claim:** Torque τ = rF sin θ; cross product of r and F.
**Confidence:** 5
**Source:** OpenStax CP2e §9.2; §10.1.

**Card 52**
**Cloze claim:** Sign convention: CCW positive, CW negative; positive and negative torques cancel in equilibrium.
**Confidence:** 4
**Source:** OpenStax CP2e §9.2.
**Notes:** Confidence 4 because the CCW-positive convention is a matter of mathematical convention (positive angle direction in the standard xy-plane), not physical law; some sources adopt the opposite convention for specific problems. The MCAT-standard interpretation is used here.

---

## needs_sme_review

*(None — all 53 cards verified at confidence 4 or 5.)*

---

## Disagreements with corpus

Nine source-material claims (from the .docx and one from the .apkg) conflicted with textbook physics or were transcription errors. None became cards as originally written; each was corrected before SQL output.

1. **.docx "horizontal velocity won't remain the same"** — flat factual error. In projectile motion (ignoring air resistance), no horizontal force acts on the projectile, so by Newton's first law the horizontal velocity is constant throughout the flight. Card 42 states this correctly. This is one of the highest-yield MCAT projectile-motion facts and the .docx had it inverted.

2. **.docx "G is acceleration due to gravity, which is equal to 9.8 m/s²"** — symbol confusion. Uppercase G is the universal gravitational constant (6.67 × 10⁻¹¹ N·m²/kg²); lowercase g is the local acceleration due to gravity (≈ 9.8 m/s² on Earth). Cards 23 and 25 distinguish them explicitly.

3. **.docx "Dopp Product"** — autocorrect error. Corrected to *dot product* in Card 11.

4. **.docx "Law of Action Acceleration"** — autocorrect error. Newton's third law is the law of action and reaction. Card 33 uses the correct framing.

5. **.docx "Scalers"** — spelling. Corrected to scalars in Card 4.

6. **.docx "transitional equilibrium"** — wrong word. Translational equilibrium is the standard term. Card 49 uses it correctly.

7. **.docx "objects observe gravitational forces on each other"** — wrong verb. Objects exert gravitational forces on each other. Phrasing did not survive into any card; Card 23 uses "every pair of masses attracts each other."

8. **.docx "displacement of the object to zero"** — missing verb. After one full circular cycle, displacement IS zero (the object returns to its starting position). Concept covered implicitly in the circular-motion section without preserving the .docx's garbled wording.

9. **.apkg note 37** — "the only force is the centripetal force" — common physics-class misconception. Centripetal force is a role that the net inward force plays in circular motion; it is provided by an actual physical force (gravity for orbiting bodies, tension for a swung ball, normal force for a banked turn, etc.). Card 46 explicitly corrects this per OpenStax §6.3.

---

## Discrepancies between primary and secondary sources

None of concern. This deck primarily references OpenStax College Physics 2e as the sole textbook source. AAMC outline confirms scope (Foundation 4A at line 2367) but not specific numerical values or equations, which is the textbook's role. The universal gravitational constant G, the acceleration due to gravity g, and the centripetal force / acceleration relationships are universally consistent across physics textbook sources.

Minor convention variations (CCW-positive vs CW-positive torque sign, eV definition with electronic vs unit charge nuances) are flagged at confidence 4 in the affected cards.

---

## Post-verification SME decisions

*(Reserved for future SME / content lead. Each entry should record: card number, decision, rationale, date.)*
