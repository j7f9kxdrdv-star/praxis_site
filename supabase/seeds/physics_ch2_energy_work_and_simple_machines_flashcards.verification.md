# Verification Report — Physics Ch 2: Energy, Work & Simple Machines

**Deck:** Energy, Work & Simple Machines
**Source SQL:** supabase/seeds/physics_ch2_energy_work_and_simple_machines_flashcards.sql
**Verified:** 2026-06-01
**Corpus:**
- Primary — `reference-textbooks/physics/openstax-college-physics-2e.txt` (Ch 7 Work, Energy, and Energy Resources; Ch 9.5 Simple Machines; Ch 15.1–15.2 P-V work and first law of thermodynamics)
- Scope authority — `reference-textbooks/aamc/aamc-content-outline-2026.txt` (Foundation 4A: Translational motion, forces, work, energy, and equilibrium in living systems)

**.docx provenance:** *Physics and math review chapter two.docx* (titled "work and energy") — adapted from a third-party MCAT review source; Source-Laundry rules applied per card. Subtopic ordering re-sequenced from the .docx's 2-section structure into a 12-section AAMC-aligned layout that walks students from the energy concept through individual energy types, conservation principles, work, power, the work-energy theorem, and finally into P-V work and simple machines. No prose from the .docx survives verbatim. Multiple .docx transcription errors and one conceptual confusion (treating the first law of thermodynamics as a statement about mechanical energy specifically) were silently corrected against textbook sources before becoming cards.

**Image policy:** The .apkg contained no images — text-only deck by source design. All equations render using Unicode subscripts and superscripts.

**Within-subject style:** Follows the cadence reference established by `physics_ch1_motion_and_forces_flashcards.sql` per the v6 prompt's within-subject style continuity rule.

---

## Summary

- **Total cards:** 44
- **Confidence 5:** 38
- **Confidence 4:** 6
- **Confidence 3:** 0
- **Confidence 2:** 0
- **Confidence 1:** 0
- **Cards flagged for `needs_sme_review`:** 0
- **Cards where corpus contradicts the card:** 0
- **Source-material claims corrected before becoming cards:** 9 *(see Disagreements with corpus)*

---

## Per-card verification

### Subtopic 1 — Energy Concept and Joule

**Card 0**
**Cloze claim:** Energy = capacity to do work; SI unit joule = kg·m²/s²; same unit as work.
**Confidence:** 5
**Source:** OpenStax CP2e §7.1 ("Work: The Scientific Definition"); §7.6.

**Card 1**
**Cloze claim:** Energy forms (kinetic, potential, thermal, chemical, electrical) are interconvertible; total energy conserved in isolated system.
**Confidence:** 5
**Source:** OpenStax CP2e §7.9 ("World Energy Use"); §15.2.

### Subtopic 2 — Kinetic Energy

**Card 2**
**Cloze claim:** K = ½mv²; mass in kg, speed in m/s; SI unit joules.
**Confidence:** 5
**Source:** OpenStax CP2e §7.2 ("Kinetic Energy and the Work-Energy Theorem").

**Card 3**
**Cloze claim:** K ∝ v² → doubling speed quadruples K; doubling mass merely doubles K.
**Confidence:** 5
**Source:** OpenStax CP2e §7.2; standard quadratic-scaling consequence.

**Card 4**
**Cloze claim:** K is scalar; depends on |v|, not direction; two objects same mass + opposite directions same K.
**Confidence:** 5
**Source:** OpenStax CP2e §7.2; standard scalar-energy result.

### Subtopic 3 — Gravitational Potential Energy

**Card 5**
**Cloze claim:** U_g = mgh; h measured from datum (chosen reference level).
**Confidence:** 5
**Source:** OpenStax CP2e §7.3 ("Gravitational Potential Energy").

**Card 6**
**Cloze claim:** PE is relative to chosen datum; only ΔU is physically meaningful.
**Confidence:** 5
**Source:** OpenStax CP2e §7.3 (potential energy reference-point discussion).

### Subtopic 4 — Elastic Potential Energy

**Card 7**
**Cloze claim:** U = ½kx²; k = spring constant in N/m; x = displacement from equilibrium.
**Confidence:** 5
**Source:** OpenStax CP2e §16.2–16.3 ("Hooke's Law" and "Energy in Hooke's Law of Deformation").

**Card 8**
**Cloze claim:** x measured from equilibrium position; U non-negative because x is squared.
**Confidence:** 5
**Source:** OpenStax CP2e §16.3.

### Subtopic 5 — Chemical and Electric Potential Energy

**Card 9**
**Cloze claim:** Chemical PE stored in bonds; released/absorbed during bond changes (metabolism, combustion).
**Confidence:** 5
**Source:** OpenStax CP2e §7.7 (energy types and conversions).

**Card 10**
**Cloze claim:** Electric PE arises from charge positions; like charges store positive PE; unlike charges negative relative to infinite separation.
**Confidence:** 4
**Source:** OpenStax CP2e §19.1 ("Electric Potential Energy: Potential Difference").
**Notes:** Confidence 4 because the sign of electric PE depends on the chosen zero reference; the typical convention (zero at infinite separation, positive PE for like-charge proximity) is what's used here, but conventions can vary across MCAT-prep sources.

### Subtopic 6 — Total Mechanical Energy

**Card 11**
**Cloze claim:** E_mech = K + U; potential term includes gravitational, elastic, or other conservative-force PEs.
**Confidence:** 5
**Source:** OpenStax CP2e §7.4–7.5.

### Subtopic 7 — Conservative vs Non-Conservative Forces

**Card 12**
**Cloze claim:** Conservative force = path-independent work; zero work over closed loops.
**Confidence:** 5
**Source:** OpenStax CP2e §7.4 ("Conservative Forces and Potential Energy").

**Card 13**
**Cloze claim:** Three classic conservative forces: gravity, electrostatic, spring; each has an associated PE function.
**Confidence:** 5
**Source:** OpenStax CP2e §7.4.

**Card 14**
**Cloze claim:** Non-conservative force = path-dependent work; dissipates mechanical energy.
**Confidence:** 5
**Source:** OpenStax CP2e §7.5 ("Nonconservative Forces").

**Card 15**
**Cloze claim:** Common non-conservative forces: friction, air resistance, viscous drag.
**Confidence:** 5
**Source:** OpenStax CP2e §7.5; §5.2 (drag forces).

**Card 16**
**Cloze claim:** Closed-loop test for conservativeness — energy preserved over closed path = conservative.
**Confidence:** 5
**Source:** OpenStax CP2e §7.4.

### Subtopic 8 — Conservation of Mechanical Energy

**Card 17**
**Cloze claim:** With only conservative forces, ΔE_mech = ΔK + ΔU = 0; K + U constant throughout motion.
**Confidence:** 5
**Source:** OpenStax CP2e §7.4.

**Card 18**
**Cloze claim:** W_nc = ΔE_mech = ΔK + ΔU when non-conservative forces act; typically negative.
**Confidence:** 5
**Source:** OpenStax CP2e §7.5.

**Card 19**
**Cloze claim:** Mechanical energy conservation is a special case; first law of thermodynamics is the broader universal energy conservation principle.
**Confidence:** 5
**Source:** OpenStax CP2e §15.2 ("The First Law of Thermodynamics"); §7.6 (energy conservation discussion).
**Notes:** Corrects the .docx's conceptual confusion that "the first law of thermodynamics accounts for the conservation of mechanical energy" — the first law is broader and includes thermal and chemical energy as well.

### Subtopic 9 — Work — Definition and Formula

**Card 20**
**Cloze claim:** Work = energy transfer through force over distance; SI unit joule (same as energy).
**Confidence:** 5
**Source:** OpenStax CP2e §7.1.

**Card 21**
**Cloze claim:** W = Fd cos θ; dot product of F and d; scalar.
**Confidence:** 5
**Source:** OpenStax CP2e §7.1.

**Card 22**
**Cloze claim:** Only parallel/antiparallel components of F do work; perpendicular components contribute zero.
**Confidence:** 5
**Source:** OpenStax CP2e §7.1.

**Card 23**
**Cloze claim:** Perpendicular force (θ = 90°) does zero work; centripetal force in circular motion is the classic example.
**Confidence:** 5
**Source:** OpenStax CP2e §7.1; §6.3 (centripetal force).

**Card 24**
**Cloze claim:** Positive work (parallel) adds energy; negative work (antiparallel) removes energy.
**Confidence:** 5
**Source:** OpenStax CP2e §7.1.

**Card 25**
**Cloze claim:** Joule = N·m = kg·m²/s²; same unit as energy.
**Confidence:** 5
**Source:** OpenStax CP2e §7.1; standard SI definitions.

### Subtopic 10 — Power

**Card 26**
**Cloze claim:** Power = rate of work / energy transfer; P = W/t = ΔE/t.
**Confidence:** 5
**Source:** OpenStax CP2e §7.7 ("Power").

**Card 27**
**Cloze claim:** Watt = J/s; kilowatt common; horsepower ≈ 746 W.
**Confidence:** 5
**Source:** OpenStax CP2e §7.7.
**Notes:** Standard SI definitions; horsepower conversion factor universal.

**Card 28**
**Cloze claim:** P = Fv for constant force parallel to motion at constant velocity.
**Confidence:** 5
**Source:** OpenStax CP2e §7.7 (P = Fv derivation).

**Card 29**
**Cloze claim:** Average power = W/Δt; instantaneous power = limit as Δt → 0; equal only when power constant.
**Confidence:** 5
**Source:** OpenStax CP2e §7.7.

### Subtopic 11 — Work-Energy Theorem

**Card 30**
**Cloze claim:** W_net = ΔK = K_f − K_i; holds regardless of force types.
**Confidence:** 5
**Source:** OpenStax CP2e §7.2 (Kinetic Energy and the Work-Energy Theorem).

**Card 31**
**Cloze claim:** W-E theorem relates net work to KE only; energy-conservation principle relates W_nc to total mechanical energy.
**Confidence:** 5
**Source:** OpenStax CP2e §7.2 and §7.5 contrast.

### Subtopic 12 — P-V Work, Simple Machines, Efficiency

**Card 32**
**Cloze claim:** P-V work = area under curve; path-dependent.
**Confidence:** 5
**Source:** OpenStax CP2e §15.1 ("The First Law of Thermodynamics" — P-V work discussion).

**Card 33**
**Cloze claim:** Sign convention — expansion (ΔV > 0) → positive work by gas; compression → negative work by gas.
**Confidence:** 4
**Source:** OpenStax CP2e §15.1.
**Notes:** Confidence 4 because sign conventions for thermodynamic work vary across sources — the "work done BY the system" convention used here is the physics/MCAT-standard, but chemistry sources sometimes use "work done ON the system" with the opposite sign. The MCAT physics convention is used.

**Card 34**
**Cloze claim:** Isovolumetric (isochoric) process: V constant → vertical line on P-V → no enclosed area → W = 0.
**Confidence:** 5
**Source:** OpenStax CP2e §15.1.

**Card 35**
**Cloze claim:** Isobaric process: P constant → horizontal line → rectangular area → W = PΔV.
**Confidence:** 5
**Source:** OpenStax CP2e §15.1.

**Card 36**
**Cloze claim:** Six classical simple machines: inclined plane, wedge, screw, lever, wheel-and-axle, pulley.
**Confidence:** 5
**Source:** OpenStax CP2e §9.5 ("Simple Machines"); standard physics classification.
**Notes:** Corrects the .apkg note 20 which incorrectly split "wheel and axle" into two separate machines (yielding 7 instead of the canonical 6).

**Card 37**
**Cloze claim:** Mechanical advantage MA = F_out / F_in; numerical example.
**Confidence:** 5
**Source:** OpenStax CP2e §9.5.

**Card 38**
**Cloze claim:** Force-distance trade-off: F_in × d_in = F_out × d_out for ideal frictionless machine; higher MA → longer input distance.
**Confidence:** 5
**Source:** OpenStax CP2e §9.5.

**Card 39**
**Cloze claim:** Inclined plane MA = L/h = 1/sin θ; gentler incline gives larger MA.
**Confidence:** 5
**Source:** OpenStax CP2e §9.5 (inclined plane analysis).

**Card 40**
**Cloze claim:** Single fixed pulley changes direction only; MA = 1.
**Confidence:** 5
**Source:** OpenStax CP2e §9.5 (pulleys).

**Card 41**
**Cloze claim:** Pulley system MA = number of rope segments supporting the load; effort distance scales by same factor.
**Confidence:** 4
**Source:** OpenStax CP2e §9.5.
**Notes:** Confidence 4 because the "count supporting ropes" rule is the standard simplification for ideal pulley analysis; real pulley systems can have additional complications (friction at axles, rope mass) that the rule glosses over. The MCAT-level treatment matches.

**Card 42**
**Cloze claim:** Efficiency = (W_out / W_in) × 100%; ideal = 100%; real < 100%.
**Confidence:** 5
**Source:** OpenStax CP2e §9.5; standard machine-efficiency definition.

**Card 43**
**Cloze claim:** Real machines < 100% efficiency due to non-conservative forces (friction, drag, deformation); lost energy → heat.
**Confidence:** 4
**Source:** OpenStax CP2e §9.5 and §7.5 (non-conservative dissipation).
**Notes:** Confidence 4 because the categorization of "deformation" as a loss mechanism is somewhat informal — strictly, energy stored elastically in cable stretch is recoverable in principle, but in practice (with internal damping in real cables) it is dissipated as heat. The MCAT-level treatment matches mainstream physics texts.

---

## needs_sme_review

*(None — all 44 cards verified at confidence 4 or 5.)*

---

## Disagreements with corpus

Nine source-material claims (from the .docx and one from the .apkg) conflicted with textbook physics or were transcription errors. None became cards as originally written; each was corrected before SQL output.

1. **.docx "the first law of thermodynamics accounts for the conservation of mechanical energy"** — conceptually confused. The first law of thermodynamics is the broader principle of total energy conservation (mechanical + thermal + chemical + ...); mechanical energy conservation is a *special case* requiring only conservative forces. Card 19 distinguishes the two principles per OpenStax CP2e §15.2.

2. **.docx "isocohoric process"** — autocorrect error. The standard term is *isochoric* (= isovolumetric). Card 34 uses the correct terminology.

3. **.docx "para-diagram"** — autocorrect error. The intended word is *paradigm*. Phrasing did not survive into any card; the force-distance trade-off principle (the underlying concept the .docx was groping toward) is in Card 38.

4. **.docx "the percentage of work put into the system that becomes unstable is due to non-conservative or external forces"** — wrong word ("becomes unstable" → "is dissipated"). Card 43 uses correct terminology with the underlying mechanism (heat conversion via non-conservative forces) explicit.

5. **.docx "If volume stays consistent as pressure changes"** — wrong word ("consistent" → "constant"). The isovolumetric process is correctly characterized in Card 34.

6. **.docx "The work done by the non-conservative forces will exactly equal the amount of energy lost from the system"** — sign-convention ambiguity. The correct statement is that W_nc equals the *change* in mechanical energy, which is negative when energy is lost. Card 18 states this with the appropriate sign convention.

7. **.docx four simple machines (wheel and axle, lever, pulley, screw)** — incomplete. The standard list includes six machines (adding inclined plane and wedge). Card 36 uses the canonical six per OpenStax CP2e §9.5.

8. **.docx "we see that work has been done on a gas"** — wrong word ("see" → "say"). Did not survive into any card.

9. **.apkg note 20** — listed seven simple machines by incorrectly splitting "wheel and axle" into two separate entries. Card 36 uses the correct six-machine list from note 48, dropping note 20.

---

## Discrepancies between primary and secondary sources

None of concern. This deck primarily references OpenStax College Physics 2e as the sole textbook source. AAMC outline confirms scope (Foundation 4A) but not specific numerical values or formulas, which is the textbook's role. The kinetic energy formula, gravitational PE formula, work-energy theorem, conservation principles, and simple-machine classifications are universally consistent across physics textbook sources.

Minor convention variations are flagged at confidence 4 in the affected cards (electric PE sign conventions, P-V work sign conventions, pulley supporting-rope rule, non-conservative loss categorization).

---

## Post-verification SME decisions

*(Reserved for future SME / content lead. Each entry should record: card number, decision, rationale, date.)*
