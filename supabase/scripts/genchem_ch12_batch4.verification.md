# GenChem Ch12 — Electrochemistry — Batch 4 of 4: Nernst equation & concentration cells, batteries, isoelectric focusing — Verification

AAMC foundations in this batch:
- 4C Electrochemistry (GC) (general-chemistry)
- 5C Separation and Purification Methods (BC) (biochemistry)

Source: OpenStax Chemistry: Atoms First 2e, Ch.16 (Electrochemistry). Every cell potential, sign/charge convention, Faraday/electron count, electrolysis mass/gas value, Nernst term, and ΔG/Keq result independently re-computed during verification.
18 questions · all confidence >=4 · adversarially re-verified (sign-convention + difficulty-justification lenses) · figure-free · cross-batch + cross-chapter deduped.
Final dedup audit: **PASS — 0 genuine conflicts** (internal + systematic recall-answer-leak sweep + cross-chapter vs Ch11/Ch10/Ch4).

## Q1 — Nernst Equation & Concentration Cells — easy — Skill 1 — 4C Electrochemistry (GC) (g69)
**Stem:** A galvanic cell is initially set up under standard conditions, so its potential equals the standard cell potential, \(E^{\circ}_{\text{cell}}\). The cell is then altered so that its reaction quotient becomes less than one (\(Q < 1\))—for example, by raising the concentration of a reactant ion or lowering the concentration of a product ion. The cell continues to operate at 298 K, where the Nernst equation takes the form \(E_{\text{cell}} = E^{\circ}_{\text{cell}} - \frac{0.0592}{n}\log Q\). Once \(Q < 1\), how does the new cell potential \(E_{\text{cell}}\) compare to the standard cell potential \(E^{\circ}_{\text{cell}}\)?

- A. \(E_{\text{cell}}\) is greater than \(E^{\circ}_{\text{cell}}\). ✅
- B. \(E_{\text{cell}}\) is less than \(E^{\circ}_{\text{cell}}\).
- C. \(E_{\text{cell}}\) is equal to \(E^{\circ}_{\text{cell}}\).
- D. The comparison cannot be determined without knowing the value of \(n\).

**Correct A**
**Distractors:** B=reversed_relationship; C=misconception; D=partial_truth

## Q2 — Nernst Equation & Concentration Cells — medium — Skill 2 — 4C Electrochemistry (GC) (g70)
**Stem:** A galvanic cell is constructed as \(\text{Zn(s)} \mid \text{Zn}^{2+}(1\ \text{M}) \parallel \text{Ag}^{+}(1\ \text{M}) \mid \text{Ag(s)}\), operating by the reaction \(\text{Zn(s)} + 2\,\text{Ag}^{+}(aq) \rightarrow \text{Zn}^{2+}(aq) + 2\,\text{Ag(s)}\), for which the reaction quotient is \(Q = \dfrac{[\text{Zn}^{2+}]}{[\text{Ag}^{+}]^{2}}\). Starting from these standard conditions, the \([\text{Ag}^{+}]\) in the cathode compartment is increased while \([\text{Zn}^{2+}]\) in the anode compartment is held fixed at \(1\ \text{M}\). According to the Nernst equation \(E_{\text{cell}} = E^{\circ}_{\text{cell}} - \frac{0.0592}{n}\log Q\) at 298 K, how does the measured cell voltage \(E_{\text{cell}}\) change?

- A. \(E_{\text{cell}}\) decreases, because raising \([\text{Ag}^{+}]\) raises \(Q\), making the \(-\frac{0.0592}{n}\log Q\) term more negative.
- B. \(E_{\text{cell}}\) increases, because raising \([\text{Ag}^{+}]\) lowers \(Q\), making the \(-\frac{0.0592}{n}\log Q\) term more positive. ✅
- C. \(E_{\text{cell}}\) is unchanged, because \(E^{\circ}_{\text{cell}}\) is an intensive property that does not depend on ion concentrations.
- D. \(E_{\text{cell}}\) decreases, because adding \(\text{Ag}^{+}\) supplies more product and drives the reaction toward completion, lowering its driving force.

**Correct B**
**Distractors:** A=reversed_relationship; C=misconception; D=process_step_confusion

## Q3 — Nernst Equation & Concentration Cells — medium — Skill 2 — 4C Electrochemistry (GC) (g71)
**Stem:** A galvanic concentration cell is constructed using two nickel electrodes, each immersed in a solution of \(\text{Ni}^{2+}\). One half-cell contains \(0.010\ \text{M}\ \text{Ni}^{2+}\) and the other contains \(0.10\ \text{M}\ \text{Ni}^{2+}\), connected by a salt bridge. The cell operates spontaneously by the half-reaction \(\text{Ni}^{2+} + 2e^- \rightarrow \text{Ni}\) (with \(n = 2\)). Using \(E_{\text{cell}} = E^{\circ}_{\text{cell}} - \frac{0.0592}{n}\log Q\) at 298 K, what is the cell voltage?

- A. \(-0.0296\ \text{V}\)
- B. \(+0.0592\ \text{V}\)
- C. \(+0.0296\ \text{V}\) ✅
- D. \(0\ \text{V}\)

**Correct C**
**Distractors:** A=reversed_relationship; B=process_step_confusion; D=misconception

## Q4 — Nernst Equation & Concentration Cells — medium — Skill 2 — 4C Electrochemistry (GC) (g72)
**Stem:** A silver concentration cell is constructed from two \(\text{Ag}/\text{Ag}^{+}\) half-cells connected by a wire and a salt bridge. Half-cell X contains \(0.020\ \text{M}\ \text{Ag}^{+}\) and half-cell Y contains \(0.40\ \text{M}\ \text{Ag}^{+}\); each half-cell holds an identical silver electrode. Because both electrodes are the same metal, \(E^{\circ}_{\text{cell}} = 0\), and the cell operates spontaneously as it drives the two \(\text{Ag}^{+}\) concentrations toward equality. As the cell discharges, which half-cell acts as the cathode, and in which direction do electrons travel through the external wire?

- A. Half-cell X is the cathode; electrons flow through the wire from X to Y.
- B. Half-cell X is the cathode; electrons flow through the wire from Y to X.
- C. Half-cell Y is the cathode; electrons flow through the wire from Y to X.
- D. Half-cell Y is the cathode; electrons flow through the wire from X to Y. ✅

**Correct D**
**Distractors:** A=misconception; B=reversed_relationship; C=process_step_confusion

## Q5 — Nernst Equation & Concentration Cells — medium — Skill 2 — 4C Electrochemistry (GC) (g73)
**Stem:** A galvanic concentration cell is built from two lead electrodes, one dipping into \(0.0050\ \text{M}\ \text{Pb}^{2+}\) and the other into \(0.25\ \text{M}\ \text{Pb}^{2+}\), connected by a salt bridge. The cell reaction is \(\text{Pb}^{2+} + 2e^- \rightleftharpoons \text{Pb}(s)\) at each electrode, for which \(E^{\circ}_{\text{cell}} = 0\), yet a voltmeter initially reads a positive voltage of about \(+0.050\ \text{V}\) that slowly decreases toward zero as the cell operates (using \(E_{\text{cell}} = E^{\circ}_{\text{cell}} - \frac{0.0592}{n}\log Q\) at \(298\ \text{K}\)). Which statement best explains both the initial positive reading and its decline to zero?

- A. Because \(E^{\circ}_{\text{cell}} = 0\) only removes the standard term, the nonzero reading comes entirely from the \(-\frac{0.0592}{n}\log Q\) term created by the concentration difference; reduction proceeds in the concentrated half-cell and oxidation in the dilute one, and as those concentrations converge \(Q \rightarrow 1\) so \(E_{\text{cell}} \rightarrow 0\) at equilibrium. ✅
- B. Because the two half-cells use the same metal, no electron transfer is thermodynamically possible; the positive reading comes from the salt bridge, and it falls as the salt bridge is depleted of ions.
- C. Because both electrodes are identical lead, \(E^{\circ}_{\text{cell}} = 0\); the meter reads zero from the start, and the small positive deflection is only instrument drift that settles back to zero as the device stabilizes.
- D. Because \(E^{\circ}_{\text{cell}} = 0\), the reaction is already at equilibrium; the positive reading reflects the dilute half-cell acting as the cathode, and the voltage falls as \(\text{Pb}^{2+}\) is consumed there until that side runs out.

**Correct A**
**Distractors:** B=partial_truth; C=misconception; D=reversed_relationship

## Q6 — Nernst Equation & Concentration Cells — hard — Skill 2 — 4C Electrochemistry (GC) (g74)
**Stem:** A galvanic Daniell-type cell is assembled at \(298\ \text{K}\) as \(\text{Zn}(s)\,|\,\text{Zn}^{2+}(0.0010\ \text{M})\,||\,\text{Cu}^{2+}(0.10\ \text{M})\,|\,\text{Cu}(s)\), for which the standard cell potential is \(E^{\circ}_{\text{cell}} = +1.10\ \text{V}\) and the cell transfers \(n = 2\) electrons. Using the Nernst equation in the form \(E_{\text{cell}} = E^{\circ}_{\text{cell}} - \frac{0.0592}{n}\log Q\), what is the cell potential under these non-standard conditions?

- A. \(+1.04\ \text{V}\)
- B. \(+1.16\ \text{V}\) ✅
- C. \(+1.22\ \text{V}\)
- D. \(+1.10\ \text{V}\)

**Correct B**
**Distractors:** A=reversed_relationship; C=process_step_confusion; D=misconception

## Q7 — Nernst Equation & Concentration Cells — hard — Skill 2 — 4C Electrochemistry (GC) (g75)
**Stem:** A galvanic cell is constructed according to the notation \(\text{Pb(s)}\,|\,\text{Pb}^{2+}(0.10\ \text{M})\,||\,\text{Ag}^{+}(0.0010\ \text{M})\,|\,\text{Ag(s)}\), which operates by the overall reaction \(\text{Pb(s)} + 2\,\text{Ag}^{+} \rightarrow \text{Pb}^{2+} + 2\,\text{Ag(s)}\). The standard cell potential is \(E^{\circ}_{\text{cell}} = +0.93\ \text{V}\) and the cell runs at \(298\ \text{K}\), where \(\frac{0.0592}{n}\log Q\) gives the Nernst correction. Which value most nearly equals the actual cell potential \(E_{\text{cell}}\) under these non-standard concentrations?

- A. \(+1.08\ \text{V}\)
- B. \(+0.90\ \text{V}\)
- C. \(+0.78\ \text{V}\) ✅
- D. \(+1.22\ \text{V}\)

**Correct C**
**Distractors:** A=reversed_relationship; B=process_step_confusion; D=scale_unit_error

## Q8 — Nernst Equation & Concentration Cells — hard — Skill 2 — 4C Electrochemistry (GC) (g76)
**Stem:** A galvanic concentration cell is built with two silver electrodes, each dipped in a solution of \(\text{AgNO}_3\). One half-cell contains \(0.0010\ \text{M}\ \text{Ag}^+\) and the other contains \(0.10\ \text{M}\ \text{Ag}^+\); the half-cells are joined by a salt bridge and the electrodes by an external wire. The relevant half-reaction is \(\text{Ag}^{+} + e^{-} \rightarrow \text{Ag}\) with \(E^{\circ} = +0.80\ \text{V}\), and at 298 K the Nernst equation may be used as \(E_{\text{cell}} = E^{\circ}_{\text{cell}} - \frac{0.0592}{n}\log Q\). At the instant the cell is connected, which value of \(E_{\text{cell}}\) and which direction of electron flow through the external wire are both correct?

- A. \(E_{\text{cell}} = +0.80\ \text{V}\); electrons flow through the wire from the \(0.10\ \text{M}\) electrode to the \(0.0010\ \text{M}\) electrode.
- B. \(E_{\text{cell}} = +0.118\ \text{V}\); electrons flow through the wire from the \(0.10\ \text{M}\) electrode to the \(0.0010\ \text{M}\) electrode.
- C. \(E_{\text{cell}} = +0.059\ \text{V}\); electrons flow through the wire from the \(0.0010\ \text{M}\) electrode to the \(0.10\ \text{M}\) electrode.
- D. \(E_{\text{cell}} = +0.118\ \text{V}\); electrons flow through the wire from the \(0.0010\ \text{M}\) electrode to the \(0.10\ \text{M}\) electrode. ✅

**Correct D**
**Distractors:** A=misconception; B=reversed_relationship; C=process_step_confusion

## Q9 — Nernst Equation & Concentration Cells — hard — Skill 2 — 4C Electrochemistry (GC) (g77)
**Stem:** Consider the galvanic cell \(\text{Cd(s)} \mid \text{Cd}^{2+}(0.10\ \text{M}) \parallel \text{Ag}^{+}(0.10\ \text{M}) \mid \text{Ag(s)}\), whose cell reaction is \(\text{Cd(s)} + 2\,\text{Ag}^{+} \rightarrow \text{Cd}^{2+} + 2\,\text{Ag(s)}\) with \(n = 2\). At 298 K the Nernst equation is \(E_{\text{cell}} = E^{\circ}_{\text{cell}} - \frac{0.0592}{2}\log Q\). Starting from the conditions above, four independent modifications are proposed, each a single tenfold concentration change: (A) lower \([\text{Cd}^{2+}]\) to \(0.010\ \text{M}\); (B) raise \([\text{Ag}^{+}]\) to \(1.0\ \text{M}\); (C) raise \([\text{Cd}^{2+}]\) to \(1.0\ \text{M}\); (D) lower \([\text{Ag}^{+}]\) to \(0.010\ \text{M}\). Which single change raises \(E_{\text{cell}}\) by the greatest amount?

- A. Raising \([\text{Ag}^{+}]\) to \(1.0\ \text{M}\), which increases \(E_{\text{cell}}\) by \(+0.0592\ \text{V}\) ✅
- B. Lowering \([\text{Cd}^{2+}]\) to \(0.010\ \text{M}\), which increases \(E_{\text{cell}}\) by \(+0.0296\ \text{V}\)
- C. Raising \([\text{Cd}^{2+}]\) to \(1.0\ \text{M}\), which increases \(E_{\text{cell}}\) by \(+0.0296\ \text{V}\)
- D. Lowering \([\text{Ag}^{+}]\) to \(0.010\ \text{M}\), which increases \(E_{\text{cell}}\) by \(+0.0592\ \text{V}\)

**Correct A**
**Distractors:** B=partial_truth; C=reversed_relationship; D=reversed_relationship

## Q10 — Batteries — easy — Skill 1 — 4C Electrochemistry (GC) (g78)
**Stem:** A nickel-cadmium (Ni-Cd) cell is a secondary cell, whereas a common alkaline cell is a primary cell that must be discarded once it dies. Which property of the Ni-Cd cell accounts for this difference?

- A. It produces a higher cell voltage than the alkaline cell, so it stores more energy per discharge.
- B. Its discharge (galvanic) reaction can be driven in reverse by an external power source, restoring the original reactants. ✅
- C. It operates without a salt bridge or porous separator, so its electrodes never become depleted.
- D. Its anode and cathode are made of the same metal, so the electrodes cannot be consumed during discharge.

**Correct B**
**Distractors:** A=adjacent_fact; C=misconception; D=misconception

## Q11 — Batteries — easy — Skill 1 — 4C Electrochemistry (GC) (g79)
**Stem:** A smartphone manufacturer is comparing two prototype lithium-ion batteries, A and B, that have exactly the same mass. Under identical testing conditions, battery B is found to store a larger total amount of electrical energy than battery A. Energy density is defined as the amount of energy a battery stores per unit mass. Based on this information, which battery has the greater energy density, and what does that imply for a phone of fixed battery mass?

- A. Both batteries have the same energy density, because energy density depends only on the battery's voltage and not on how much energy it stores.
- B. Battery A has the greater energy density, so for a fixed battery mass a phone using A can run longer between charges.
- C. Battery B has the greater energy density, so for a fixed battery mass a phone using B can run longer between charges. ✅
- D. Battery B has the greater energy density, but this means a phone using B must be made heavier to hold the additional energy.

**Correct C**
**Distractors:** A=misconception; B=reversed_relationship; D=partial_truth

## Q12 — Batteries — medium — Skill 2 — 4C Electrochemistry (GC) (g80)
**Stem:** A lead-acid battery in a car delivers about \(2\ \text{V}\) per cell. When the driver turns the key, the battery drives current through the starter motor to crank the engine. Once the engine is running, the alternator drives current back through the battery in the reverse direction to recharge it. Which statement correctly classifies the cell during these two operations and the sign of \(\Delta G\) for the cell reaction proceeding in each direction?

- A. The battery is an electrolytic cell with \(\Delta G > 0\) during both cranking and charging, because current flows through the cell in both operations.
- B. While cranking the starter the battery is an electrolytic cell with \(\Delta G > 0\); while being charged by the alternator it is a galvanic cell with \(\Delta G < 0\) for the reaction being driven.
- C. The battery is a galvanic cell with \(\Delta G < 0\) during both cranking and charging, because the same lead-acid chemistry is present in both operations.
- D. While cranking the starter the battery is a galvanic cell with \(\Delta G < 0\); while being charged by the alternator it is an electrolytic cell with \(\Delta G > 0\) for the reaction being driven. ✅

**Correct D**
**Distractors:** A=partial_truth; B=reversed_relationship; C=misconception

## Q13 — Batteries — medium — Skill 2 — 4C Electrochemistry (GC) (g81)
**Stem:** A common disposable flashlight battery uses a zinc-based redox reaction that releases electrical energy spontaneously as the cell is used. Once the reactants are consumed, the cell is discarded because its internal reaction cannot be practically driven in reverse by applying an external voltage. Which of the following correctly classifies this battery and describes how it operates?

- A. It is a primary cell that functions as a galvanic cell during use, converting chemical energy into electrical energy spontaneously, and it cannot be restored by an electrolytic recharging process. ✅
- B. It is a secondary cell that functions as a galvanic cell during use and can later be recharged by operating as an electrolytic cell.
- C. It is a primary cell that functions as an electrolytic cell during use, consuming electrical energy to drive a nonspontaneous reaction.
- D. It is a primary cell, but during normal use it operates as a galvanic cell only because an external power source continuously supplies the energy that drives its reaction.

**Correct A**
**Distractors:** B=misconception; C=reversed_relationship; D=partial_truth

## Q14 — Batteries — hard — Skill 2 — 4C Electrochemistry (GC) (g82)
**Stem:** A lead-acid car battery uses a \(\text{Pb}\) electrode and a \(\text{PbO}_2\) electrode immersed in aqueous \(\text{H}_2\text{SO}_4\). The relevant standard reduction potentials are \(\text{PbO}_2 + 4\text{H}^+ + \text{SO}_4^{2-} + 2e^- \rightarrow \text{PbSO}_4 + 2\text{H}_2\text{O}\), \(E^{\circ} = +1.69\ \text{V}\), and \(\text{PbSO}_4 + 2e^- \rightarrow \text{Pb} + \text{SO}_4^{2-}\), \(E^{\circ} = -0.36\ \text{V}\). During discharge the battery powers the car spontaneously; during recharge the alternator forces the reverse reactions. Tracking the \(\text{PbO}_2\)-based electrode (the electrode that is reduced as the battery discharges) through one complete discharge-then-recharge cycle, which statement correctly describes its electrode role, its half-reaction type, and its terminal sign in each mode?

- A. On discharge it is the cathode (reduction) and on recharge it becomes the anode (oxidation); it is the positive terminal during discharge but the negative terminal during recharge.
- B. On discharge it is the cathode (reduction) and on recharge it becomes the anode (oxidation); it is the positive terminal in both modes. ✅
- C. On discharge it is the cathode (reduction) and on recharge it remains the cathode (reduction); it is the positive terminal in both modes.
- D. On discharge it is the anode (oxidation) and on recharge it becomes the cathode (reduction); it is the negative terminal in both modes.

**Correct B**
**Distractors:** A=misconception; C=partial_truth; D=reversed_relationship

## Q15 — Isoelectric Focusing — easy — Skill 2 — 5C Separation and Purification Methods (BC) (g83)
**Stem:** In isoelectric focusing (IEF), a stable pH gradient is set up across a gel — acidic near the anode and increasingly basic toward the cathode — and a voltage is applied (the cathode is the negative electrode, the anode is the positive electrode). Unlike ordinary electrophoresis, where a charged species migrates continuously toward one electrode, in IEF each amino acid migrates only until it reaches the position where the local pH equals its isoelectric point (pI), at which point it stops and concentrates. Glycine (pI = 6.0) is deposited at a spot in the gel where the local pH is 3.0. Toward which electrode does glycine migrate, and what causes it to ultimately stop?

- A. Toward the cathode, continuing all the way to the cathode because the applied field drives it there regardless of the local pH
- B. Toward the anode, moving into progressively lower-pH regions until the local pH reaches 6.0, where its net charge becomes zero and it halts
- C. Toward the cathode, moving into progressively higher-pH regions until the local pH reaches 6.0, where its net charge becomes zero and it halts ✅
- D. Toward the anode, because the acidic region near the anode matches glycine's environment and stabilizes its neutral form there

**Correct C**
**Distractors:** A=misconception; B=reversed_relationship; D=process_step_confusion

## Q16 — Isoelectric Focusing — medium — Skill 2 — 5C Separation and Purification Methods (BC) (g84)
**Stem:** Aspartate (\(\text{pI} = 2.8\)) is loaded onto an immobilized pH gradient that runs from \(\text{pH}\ 2\) at the anode to \(\text{pH}\ 10\) at the cathode, and a constant electric field is applied across the strip. The aspartate migrates through the gradient and then comes to rest as a sharp band at the position where the local gradient pH is \(2.8\), where it remains as long as the field is on. Which of the following best explains why the aspartate stops migrating precisely at the \(\text{pH}\ 2.8\) band?

- A. The gel matrix has its smallest pore size at the \(\text{pH}\ 2.8\) band, so aspartate is sieved and physically trapped there by its size.
- B. At \(\text{pH}\ 2.8\) aspartate carries its maximum net charge, so the field grips it most tightly and anchors it at that point.
- C. Aspartate is least soluble at \(\text{pH}\ 2.8\), so it precipitates out of solution and can no longer move through the field.
- D. At \(\text{pH}\ 2.8\) the net charge on aspartate is zero, so the electric field exerts no net electrophoretic force (\(F = qE = 0\)) and migration halts. ✅

**Correct D**
**Distractors:** A=process_step_confusion; B=reversed_relationship; C=misconception

## Q17 — Isoelectric Focusing — medium — Skill 2 — 5C Separation and Purification Methods (BC) (g85)
**Stem:** During isoelectric focusing (IEF), a researcher loads a mixture of amino acids onto a gel containing a stable, continuous pH gradient that runs from low pH at the anode (positive electrode) to high pH at the cathode (negative electrode), then applies the field. One species is free arginine, a "basic" amino acid with \(\text{pI} = 10.8\). At the instant the field is switched on, this arginine is sitting in a region buffered to \(\text{pH} = 12.0\). Assuming the run continues until the system reaches its steady state, where in the gradient will the arginine ultimately come to rest, and what holds it there?

- A. It moves toward the anode until it reaches the \(\text{pH} = 10.8\) band, where its net charge becomes zero so the field no longer drives it; any drift away from that band re-ionizes it and pushes it back, holding it in place ✅
- B. It moves toward the cathode until it reaches the \(\text{pH} = 10.8\) band, where its net charge becomes zero; any drift away re-ionizes it and pushes it back, holding it in place
- C. It continues toward the anode all the way to the low-pH end of the gel, because once a molecule starts migrating in an applied field it keeps moving until it reaches the electrode
- D. It stops immediately at \(\text{pH} = 12.0\), because the high local pH neutralizes the basic side chain and a neutral molecule cannot migrate in any field

**Correct A**
**Distractors:** B=reversed_relationship; C=misconception; D=process_step_confusion

## Q18 — Isoelectric Focusing — hard — Skill 2 — 5C Separation and Purification Methods (BC) (g86)
**Stem:** In a fixed-pH electrophoresis chamber, a buffer holds the entire separation field at a uniform pH of 9.0 (this is not a pH gradient). A mixture containing aspartate (pI 2.8), glycine (pI 6.0), and lysine (pI 9.7) is loaded at the center, and a voltage is applied so that the cathode lies on the left and the anode lies on the right. A residue is net negative when the buffer pH lies above its pI and net positive when the pH lies below its pI, and its migration speed grows as the difference between the buffer pH and its pI increases. Which of the following correctly describes the migration of all three residues?

- A. Aspartate and glycine migrate toward the cathode (aspartate faster than glycine), while lysine migrates toward the anode.
- B. Aspartate and glycine migrate toward the anode (aspartate faster than glycine), while lysine migrates toward the cathode. ✅
- C. Aspartate and glycine migrate toward the anode (glycine faster than aspartate), while lysine migrates toward the cathode.
- D. Aspartate and glycine migrate toward the anode, while lysine also migrates toward the anode.

**Correct B**
**Distractors:** A=reversed_relationship; C=process_step_confusion; D=partial_truth

