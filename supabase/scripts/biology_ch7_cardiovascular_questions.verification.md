# Biology Ch7 — The Cardiovascular System · Verification Report

**Batch 1 of 4 — 25 questions (the heart).**
Reference text: `reference-textbooks/biology/openstax-anatomy-physiology-2e.txt` (cited as AP:line).
Scope authority: `reference-textbooks/aamc/aamc-content-outline-2026.txt`.
All questions: Foundation 3B · content category "Organ Systems" · discipline biology.

## Chapter-level summary (batch 1)

| Metric | Result | Target |
|---|---|---|
| Difficulty | easy 7 · hard 8 · medium 10 | 27/40/33 |
| Answer letter | A 6 · B 7 · C 7 · D 5 | ~25% each |
| Cognitive skill | S1 3 · S2 18 · S4 4 | mixed |
| Confidence | conf4 1 · conf5 24 | only 4-5 ship |
| Topic axis | easy 6 · hard 4 · medium 15 | — |
| Structural axis | easy 7 · hard 8 · medium 10 | — |
| Distractor categories | adjacent_fact 10 · misconception 18 · partial_truth 14 · process_step_confusion 14 · reversed_relationship 17 · scale_unit_error 2 | none >40% |
| Data-driven | 16% | 15-20% |
| Roman numeral | 0% | 10-15% (deficit carried to batches 2-4) |

**Known deficits carried forward:** Roman-numeral format at 0% (heart mechanics suits it poorly; to be placed in capillary exchange, hemodynamics and coagulation). Skill 3 absent (to be placed in the experimentally-framed units). Answer letter D at 20%, to be biased upward in batch 2.

**Scope boundaries enforced** (verified by automated scan, zero hits): hemoglobin curve/cooperativity/Bohr/2,3-BPG/fetal Hb/CO poisoning (Biochem Ch3) · CO2 forms/carbonic anhydrase/chloride shift/bicarbonate buffering/alveolar gradients (Bio Ch6) · ADH/aldosterone/ANP/EPO/renin (Bio Ch5) · ABO genotypes (Bio Ch12) · gap junctions/intercalated discs/autorhythmicity (Bio Ch11) · foramen ovale/ductus arteriosus (Bio Ch3).

**Adversarial audit:** all 25 questions were re-examined by an independent pass that re-greped every citation. All 25 were modified. Material catches: one stem-echo release-blocker (Q1), one fabricated textbook quotation (Q3), one factually wrong explanation clause (Q6, right ventricle filling), one citation drawn from the wrong chapter (Q8), and several off-by-a-few line references.

---

## Q1 — Pulmonary And Systemic Circuits In Series

**Stem.** A drug is injected into a vein in a patient's forearm. An enzyme on the endothelial lining of every capillary bed in the body destroys the drug. Which capillary bed most likely destroys the largest fraction of the injected dose?

- **A.** The coronary capillaries
- **B.** The hepatic capillaries
- **C.** The pulmonary capillaries  ← **KEY**
- **D.** The cerebral capillaries

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic easy / structural easy) |
| Estimated time | 60 s |
| Confidence | 5 |

**Correct answer (C): The pulmonary capillaries**

Citations: openstax-anatomy-physiology-2e.txt:35762 'There are two distinct but linked circuits in the human circulation called the pulmonary and systemic circuits.'; :35777 'The right ventricle pumps deoxygenated blood into the pulmonary trunk, which leads toward the lungs'; :35790-35792 'The capillaries will ultimately unite to form venules, joining to form ever-larger veins, eventually flowing into the two major systemic veins, the superior vena cava and the inferior vena cava, which return blood to the right atrium. The blood in the superior and inferior venae cavae flows into the right atrium, which pumps blood into the right ventricle.'; :38378 'Arteries and veins transport blood in two distinct circuits: the systemic circuit and the pulmonary circuit'; :38057 'coronary arteries are the first to branch off the aorta'; :41263-41265 hepatic portal system; :39470-39492 Table 20.3 resting flows (Heart \(250\), Brain \(750\), Total \(5800\ \text{mL/min}\))

**Distractors**

- **(A)** `process_step_confusion` · _proximity mistaken for circuit order_ — Assumes that the bed fed by the very first arterial branch is the first bed the injected blood reaches. The coronary arteries are the first branches off the aorta, which places the coronary capillaries downstream of the entire pulmonary circuit and the left heart. They receive only about \(250\ \text{mL/min}\) of a \(5800\ \text{mL/min}\) resting cardiac output.
  - Citation: openstax-anatomy-physiology-2e.txt:38057 'coronary arteries are the first to branch off the aorta'; :39478 'Heart 250 350 750'; :39492 'Total 5800 9500 17,500'
- **(B)** `adjacent_fact` · _oral first pass metabolism imported into an IV scenario_ — Transfers hepatic first pass metabolism, which is real for orally absorbed drugs, to an intravenous route. The hepatic portal vein drains the gastrointestinal tract and spleen into the liver sinusoids, but a forearm vein empties into the superior vena cava instead. The liver is therefore reached only after the pulmonary circuit and the systemic arteries.
  - Citation: openstax-anatomy-physiology-2e.txt:41263-41265 'travel to the liver for processing. They do so via the hepatic portal system ... the initial capillaries from the stomach, small intestine, large intestine, and spleen lead to the hepatic portal vein and end in specialized capillaries within the liver, the hepatic sinusoids'
- **(D)** `misconception` · _perfusion priority mistaken for perfusion order_ — Confuses the brain's protected, nearly constant blood supply with being first in the circuit. Cerebral capillaries are supplied by the internal carotid and vertebral arteries, which arise from the aorta and its branches and therefore lie in the systemic circuit. Constant priority perfusion of about \(750\ \text{mL/min}\) does not place the brain upstream of the lungs.
  - Citation: openstax-anatomy-physiology-2e.txt:23916-23918 'The very first branches off the aorta supply the heart ... The next branches give rise to the common carotid arteries, which further branch into the internal carotid arteries'; :23926 'vessels that supply the CNS are the vertebral arteries'; :39462 'Only the brain receives a more or less constant supply of blood'; :39480 'Brain 750 750 750'

**Readback check.** Does not read back. The stem supplies only an injection site and a uniform enzyme property, and states no conclusion about circuit order. All four options are genuine capillary beds that the drug eventually reaches, so discrimination rests entirely on knowing that the circuits are in series and that all venous return traverses the lung before any systemic bed. No option is self-justifying, and none can be eliminated without circuit knowledge. AUDIT CHANGE (release-blocker fixed): the original stem read 'destroyed by an enzyme present on the endothelium of all systemic and pulmonary capillaries,' which handed the key's distinctive word 'pulmonary' to the student, a clear STEM ECHO; the original readback_check compounded this by falsely asserting that 'pulmonary' appeared nowhere in the stem. The stem now reads 'every capillary bed in the body,' so the word appears in no part of the stem. Also corrected: pulmonary trunk citation :35779 to :35777, cerebral arterial citation range :23918-23931 to :23916-23926 (the circle of Willis lines cited originally do not state the arterial origin claimed), and the phrase 'first pass route' removed from the Choice B block since the term was doing rhetorical rather than mechanistic work.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because the entire injected dose must cross the lung's exchange vessels before any systemic bed receives a single molecule of it. Blood leaving a forearm vein travels through the superior vena cava to the right atrium, passes into the right ventricle, and is ejected into the pulmonary trunk. The two circuits are arranged in series, so the lung capillaries are the first exchange vessels the drug meets, and they are exposed to \(100\ \%\) of the dose at its peak concentration. Every systemic bed lies downstream and receives only its own fractional share of the resting cardiac output of \(5800\ \text{mL/min}\), so each destroys correspondingly less drug.
>
> (Choice A) The coronary capillaries are supplied by the right and left coronary arteries, which are the first vessels to branch off the aorta. That position places them downstream of the lungs and the left heart, not upstream of them. At rest the myocardium receives roughly \(250\ \text{mL/min}\) of a \(5800\ \text{mL/min}\) cardiac output, so it is exposed to only a few percent of the dose.
>
> (Choice B) The hepatic capillaries are the first bed encountered by a drug absorbed from the gastrointestinal tract, because the hepatic portal vein carries that blood directly into the liver sinusoids. That route does not apply to an intravenous injection, which enters the systemic veins downstream of the gut. The liver is reached only after the drug has already crossed the lungs and the systemic arteries.
>
> (Choice C) Correct. Because the two circuits are in series, the whole of cardiac output traverses the lung on every circuit, which makes the pulmonary capillary bed the only one guaranteed to see the entire dose. This is why lung exposure to an intravenously administered agent is far higher than its exposure at any single systemic organ, and why an endothelial enzyme distributed uniformly across all beds removes the most drug in the lung.
>
> (Choice D) The cerebral capillaries are fed by the internal carotid and vertebral arteries, which arise from the aorta and its branches. Although cerebral perfusion is protected and held near \(750\ \text{mL/min}\), priority of perfusion does not alter the order of the circuits. The brain is a systemic bed and is reached only after blood has passed through the lungs and the left heart.
>
> This is a Knowledge of Scientific Concepts and Principles question because you must recall the series arrangement of the pulmonary and systemic circuits and the path blood follows from a peripheral vein.

---

## Q2 — Role In Thermoregulation

**Stem.** During maximal exercise in a warm room, a healthy adult's integumentary blood flow rises from \(500\) to \(1900\ \text{mL/min}\) while renal flow falls from \(1100\) to \(600\ \text{mL/min}\). The same person then repeats the identical maximal workload in a \(4\ ^\circ\text{C}\) room. Which change is most likely in the second trial?

- **A.** Integumentary flow rises more than in the warm trial.
- **B.** Integumentary flow rises less than in the warm trial.  ← **KEY**
- **C.** Cerebral flow rises more than in the warm trial.
- **D.** Skeletal muscle flow rises less than in the warm trial.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 90 s |
| Confidence | 5 |

**Correct answer (B): Integumentary flow rises less than in the warm trial.**

Citations: openstax-anatomy-physiology-2e.txt:39466-39468 'the values for the distribution of blood to the integument may seem surprising. During exercise, the body distributes more blood to the body surface where it can dissipate the excess heat generated by increased activity into the environment.'; :39482 'Integument 500 1500 1900'; :39484 'Kidney 1100 900 600'; :39480 'Brain 750 750 750'; :39459-39462 'cardiovascular system engages in resource allocation, because there is not enough blood flow to distribute blood equally to all tissues simultaneously ... Only the brain receives a more or less constant supply of blood'; :8489-8490 'arterioles in the dermis dilate so that excess heat carried by the blood can dissipate through the skin and into the surrounding environment'; :8497 'the dermal blood vessels constrict to minimize heat loss in response to low temperatures'; :8500 'When body temperatures drop, the arterioles constrict to minimize heat loss'

**Distractors**

- **(A)** `reversed_relationship` · _direction of cutaneous response inverted_ — Inverts the direction of the cutaneous thermoregulatory response. Dermal arterioles dilate to dissipate excess heat and constrict in response to low temperature, so a \(4\ ^\circ\text{C}\) room opposes the exercise induced cutaneous hyperemia rather than amplifying it.
  - Citation: openstax-anatomy-physiology-2e.txt:8489-8490 'arterioles in the dermis dilate so that excess heat carried by the blood can dissipate through the skin and into the surrounding environment'; :8497 'the dermal blood vessels constrict to minimize heat loss in response to low temperatures'; :8500 'When body temperatures drop, the arterioles constrict to minimize heat loss'
- **(C)** `misconception` · _brain treated as a demand-responsive bed_ — Treats cerebral perfusion as adjustable with activity or ambient conditions. Cerebral flow is \(750\ \text{mL/min}\) at rest, at mild exercise, and at maximal exercise, because only the brain receives a more or less constant supply of blood whatever the activity. The cerebral bed therefore does not rise in either trial, so it cannot rise more in the cold one.
  - Citation: openstax-anatomy-physiology-2e.txt:39480 'Brain 750 750 750'; :39462 'Only the brain receives a more or less constant supply of blood'
- **(D)** `misconception` · _cold vasoconstriction generalized to every bed_ — Generalizes cold induced vasoconstriction to all vascular beds, including working muscle. Skeletal muscle perfusion is governed by local metabolic vasodilators released by active tissue, and the workload is unchanged between trials, so muscle flow does not fall because the room is cold. Cutaneous arterioles, not muscle arterioles, are the thermoregulatory effectors.
  - Citation: openstax-anatomy-physiology-2e.txt:39476 'Skeletal muscle 1200 4500 12,500'; :39685-39689 'Opening of the sphincter is triggered in response to decreased oxygen concentrations; increased carbon dioxide concentrations; increasing levels of lactic acid or other byproducts of cellular metabolism ... These conditions in turn stimulate the release of NO, a powerful vasodilator'

**Readback check.** Does not read back. The stem gives numeric flows for the warm trial only and asserts nothing about the cold trial, so the key describes a condition the stem never characterizes. The key shares no distinctive wording with the stem beyond the neutral term 'integumentary flow,' which appears identically in the reversed distractor, so echo cannot discriminate. A student who believes skin hyperemia during exercise is metabolic rather than thermoregulatory has no basis to choose the direction and finds choice A equally attractive. AUDIT CHANGE: choice C originally read 'Cerebral flow rises above its resting value,' which broke the parallel comparative frame used by A, B, and D and made C partly discardable on form rather than on physiology; it now reads 'Cerebral flow rises more than in the warm trial,' which is parallel, still unambiguously false (brain flow is \(750\ \text{mL/min}\) in both trials), and no longer eliminable without knowing that cerebral flow is held constant. The (Choice C) block and the C distractor rationale were rewritten to match. Also changed: the phrase 'override sympathetic tone' in the (Choice D) block was reworded to 'override neural constrictor input' to keep the item clear of the Ch4 autonomic-division scope boundary, and the citation for the precapillary sphincter passage corrected from :39687-39689 to :39685-39689.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because the large exercise rise in skin blood flow serves heat dissipation rather than skin metabolism, and a \(4\ ^\circ\text{C}\) environment sharply reduces the flow needed to shed that heat. The integument has a low metabolic rate, so its perfusion is not driven by working tissue demand the way skeletal muscle perfusion is. During exercise in warm conditions the body deliberately routes extra blood to the body surface so that the heat generated by contracting muscle can be dissipated into the environment. In cold air the gradient between skin and environment is far larger, so each milliliter of cutaneous blood unloads much more heat, and cold itself drives dermal arteriolar constriction to protect the core. The predicted result is a smaller rise in integumentary flow at an identical workload.
>
> (Choice A) This reverses the thermoregulatory logic. Dermal arterioles dilate when the body must dump heat and constrict when body temperature falls, so a cold room opposes rather than reinforces the cutaneous hyperemia of exercise. A larger rise than in the warm trial would require the cold room to increase, rather than reduce, the amount of blood the surface must carry to clear the same heat load.
>
> (Choice B) Correct. Cutaneous flow during exercise is a thermoregulatory allocation, not a metabolic one, so it scales with the heat that must be moved to the surface rather than with the workload alone. Cold exposure both increases heat transfer per unit of skin flow and triggers dermal arteriolar constriction, so the integument's share of cardiac output rises less. The blood not sent to the skin remains available to the beds that are metabolically active.
>
> (Choice C) Cerebral flow does not rise in either trial. It measures \(750\ \text{mL/min}\) at rest, at mild exercise, and at maximal exercise, because the brain is the one bed that receives a more or less constant supply of blood whatever the activity. Ambient temperature imposes no thermoregulatory duty on the cerebral circulation, so cerebral flow cannot rise more in the cold trial than in the warm one.
>
> (Choice D) Skeletal muscle flow is set by the workload and by local metabolic vasodilation in the active muscle, and the workload is identical in the two trials. Cold induced vasoconstriction acts on cutaneous arterioles, not on the arterioles of contracting muscle, where local metabolic signals override neural constrictor input. If anything, diverting less blood to the skin leaves slightly more available to muscle.
>
> This is a Scientific Reasoning and Problem Solving question because you must predict how a change in ambient temperature alters the allocation of cardiac output during exercise.

---

## Q3 — Equal Flow Through Two Circuits

**Stem.** An adult has a small persistent opening in the interventricular septum. Peak systolic pressure in the left ventricle is roughly five times that in the right ventricle. Which consequence for the two circuits is most likely?

- **A.** Pulmonary blood flow exceeds systemic blood flow.  ← **KEY**
- **B.** Systemic blood flow exceeds pulmonary blood flow.
- **C.** Pulmonary and systemic blood flows remain equal.
- **D.** Pulmonary blood flow falls below its resting value.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 95 s |
| Confidence | 5 |

**Correct answer (A): Pulmonary blood flow exceeds systemic blood flow.**

Citations: openstax-anatomy-physiology-2e.txt:35762 'There are two distinct but linked circuits in the human circulation called the pulmonary and systemic circuits.'; :35907-35911 'Although the ventricles on the right and left sides pump the same amount of blood per contraction, the muscle of the left ventricle is much thicker and better developed than that of the right ventricle. In order to overcome the high resistance required to pump blood into the long systemic circuit, the left ventricle must generate a great amount of pressure. The right ventricle does not need to generate as much pressure, since the pulmonary circuit is shorter and provides less resistance.'; :35953 'Between the two ventricles is a second septum known as the interventricular septum.'; :36096-36097 'Blood, like any fluid, flows from higher pressure to lower pressure areas'; :36019-36026 'Septal defects are not uncommon in individuals and may be congenital or caused by various disease processes. Tetralogy of Fallot ... ventricular septal defect (opening), and right ventricular hypertrophy'; :35777 'The right ventricle pumps deoxygenated blood into the pulmonary trunk'

**Distractors**

- **(B)** `reversed_relationship` · _shunt direction inverted_ — Reverses the direction of flow across the defect. Blood flows from higher pressure to lower pressure areas, and the stem states that peak left ventricular pressure is about five times right ventricular pressure, so the shunt runs left to right. Systemic flow could exceed pulmonary flow only if the right ventricle developed the higher pressure.
  - Citation: openstax-anatomy-physiology-2e.txt:36096-36097 'Blood, like any fluid, flows from higher pressure to lower pressure areas'; :35907-35911 'the left ventricle must generate a great amount of pressure. The right ventricle does not need to generate as much pressure'
- **(C)** `misconception` · _series equal-flow rule applied to a shunted heart_ — Applies the equal output rule of a normal heart to a heart in which the circuits are no longer purely in series. The two ventricles pump the same amount of blood per contraction only because their circuits are connected end to end; a septal opening creates a parallel channel that breaks that constraint.
  - Citation: openstax-anatomy-physiology-2e.txt:35907 'Although the ventricles on the right and left sides pump the same amount of blood per contraction'; :35762 'There are two distinct but linked circuits in the human circulation called the pulmonary and systemic circuits.'
- **(D)** `partial_truth` · _correct for obstructed right ventricular outflow_ — True under a different condition, namely obstruction of right ventricular outflow. In tetralogy of Fallot, an opening in the interventricular septum caused by blockage of the pulmonary trunk at the pulmonary semilunar valve sends relatively low oxygen blood from the right ventricle into the left ventricle and reduces pulmonary flow. With an isolated opening, normal pulmonary resistance, and the left to right gradient the stem specifies, pulmonary flow rises instead.
  - Citation: openstax-anatomy-physiology-2e.txt:36020-36024 'Tetralogy of Fallot is a congenital condition ... it occurs when there is an opening in the interventricular septum caused by blockage of the pulmonary trunk, normally at the pulmonary semilunar valve. This allows blood that is relatively low in oxygen from the right ventricle to flow into the left ventricle'

**Readback check.** Does not read back. The stem supplies two pieces of data, an anatomical opening and a pressure ratio, and states no conclusion about flow in either circuit. The key requires two inferential steps the stem does not perform: deducing shunt direction from the pressure gradient, then applying the series arrangement to see that the right ventricle now ejects venous return plus shunt. The answer students are most drilled to give, that the two flows stay equal, is offered as choice C, so ONLY-REAL-OPTION does not apply and the key is not self-justifying. AUDIT CHANGE: the citations field carried a fabricated quotation, ':35948 Located between the two ventricles is a second septum known as the interventricular septum'; the textbook sentence at :35953 actually begins 'Between the two ventricles,' and line 35948 is not that sentence. Corrected to :35953 with verbatim wording. The tetralogy citation was also shifted from :36021-36026 to its true span :36019-36026. Two explanation blocks were strengthened rather than left as bare assertions: (Choice B) now names the oxygen consequence that would accompany a right to left shunt, and (Choice D) was rewritten so it identifies the missing condition (no outflow obstruction) instead of appearing to eliminate itself. AUDIT NOTE, considered and retained: choices A, B, and C form an exhaustive comparison set while D compares pulmonary flow to its own baseline. This was examined for a test-wise shortcut and kept, because narrowing to A, B, or C still leaves the student needing the shunt-direction and series reasoning to choose among them, and D remains the strongest partial-truth trap available for this stem.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because blood crosses the septal opening from the higher pressure left ventricle into the right ventricle, so the right ventricle ejects the systemic venous return plus the shunted volume. In an intact heart the pulmonary and systemic circuits are strictly in series, which forces the two ventricles to move the same volume per minute. An interventricular opening creates a parallel connection between the circuits, and blood, like any fluid, flows from higher pressure to lower pressure areas. Because the left ventricle must generate far greater pressure to drive blood through the long, high resistance systemic circuit, the pressure gradient across the defect points from left to right. The shunted volume is recirculated through the lungs, so pulmonary flow now exceeds systemic flow and the right ventricle and pulmonary vessels carry a chronic volume load.
>
> (Choice A) Correct. The extra volume delivered across the defect adds to the systemic venous return that the right ventricle already receives, so pulmonary flow is the sum of the two. Because the shunted blood has already been oxygenated, oxygen saturation measured in the right ventricle exceeds that in the right atrium, which is how such openings are localized.
>
> (Choice B) This describes a right to left shunt, which requires right ventricular pressure to exceed left ventricular pressure. The stem states the opposite pressure relationship, so the gradient across the opening cannot point that way. Right to left shunting develops only with obstruction of right ventricular outflow or with a very large rise in pulmonary vascular resistance, and it would also lower the oxygen saturation of blood leaving the left ventricle.
>
> (Choice C) Equality of pulmonary and systemic flow is a consequence of the two circuits being connected only in series, not an inviolable rule of circulation. The two ventricles pump the same amount of blood per contraction precisely because their circuits are joined end to end. The septal opening supplies a parallel path between the circuits, which removes the very constraint that produces equal flows.
>
> (Choice D) Pulmonary flow falls below normal when outflow from the right side is obstructed. In tetralogy of Fallot the opening in the interventricular septum is accompanied by blockage of the pulmonary trunk at the pulmonary semilunar valve, which sends relatively low oxygen blood from the right ventricle into the left ventricle and reduces flow through the lungs. The stem describes an isolated opening with a left to right gradient and no outflow obstruction, so pulmonary flow rises instead.
>
> This is a Scientific Reasoning and Problem Solving question because you must combine the pressure gradient across the defect with the series arrangement of the circuits to predict which circuit carries the larger flow.

---

## Q4 — Flow Redistribution And Vascular Resistance

**Stem.** Between rest and maximal exercise in a healthy adult, cardiac output rises from \(5.8\) to \(17.5\ \text{L/min}\) and mean arterial pressure rises from \(90\) to \(115\ \text{mm Hg}\). Over the same interval, blood flow rises from \(1200\) to \(12{,}500\ \text{mL/min}\) in skeletal muscle and from \(500\) to \(1900\ \text{mL/min}\) in the integument, falls from \(1100\) to \(600\ \text{mL/min}\) in the kidney, and holds at \(750\ \text{mL/min}\) in the brain. In which bed must vascular resistance have increased even though its flow did NOT fall?

- **A.** The skeletal muscle bed
- **B.** The cutaneous bed
- **C.** The renal bed
- **D.** The cerebral bed  ← **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic medium / structural hard) |
| Estimated time | 130 s |
| Confidence | 5 |
| Hard-tier gate | Gate met on three conditions firmly and a fourth arguably; hard tier retained. (1) CONCEPT CHAINING: the student must link the flow, pressure, and resistance relationship to the regional redistribution data and then to the idea that unchanged flow does not imply unchanged resistance, three distinct reasoning steps. (2) DATA-TO-MECHANISM: no value can be read off; each bed's resistance change must be derived by comparing its flow ratio with the \(1.3\) fold pressure ratio, and the answer is a statement about vascular tone rather than a number in the stem. (3) TRUE PARTIAL-TRUTH TRAP: choice C, the renal bed, is fully correct under the question 'in which bed did resistance increase' and fails only on the NOT fall clause. (4) 510-TEMPTING DISTRACTOR: choice B is where a well-prepared student lands after one subtle error, either normalizing the \(3.8\) fold skin flow rise against the \(3.0\) fold cardiac output rise and concluding the skin bed was restrained, or importing cold-stress cutaneous vasoconstriction into an exercise scenario. The original draft claimed all four conditions were met without qualification; condition (4) is genuine but weaker than (3) here, since the strongest trap for a well-prepared student is C, and that overlap is now stated rather than concealed. |

**Correct answer (D): The cerebral bed**

Citations: openstax-anatomy-physiology-2e.txt:39470-39492 Table 20.3 'Skeletal muscle 1200 4500 12,500 / Heart 250 350 750 / Brain 750 750 750 / Integument 500 1500 1900 / Kidney 1100 900 600 / Gastrointestinal 1400 1100 600 / Total 5800 9500 17,500'; :38872-38875 'Blood flow refers to the movement of blood through a vessel, tissue, or organ ... Ventricular contraction ejects blood into the major arteries, resulting in flow from regions of higher pressure to regions of lower pressure'; :39064-39065 'One of several things this equation allows us to do is calculate the resistance in the vascular system. Normally this value is extremely difficult to measure, but it can be calculated from this known relationship'; :39142-39143 'The vascular tone of the vessel is the contractile state of the smooth muscle and the primary determinant of diameter, and thus of resistance and flow. The effect of vessel diameter on resistance is inverse'; :38920-38921 'Mean arterial pressure (MAP) represents the average pressure of blood in the arteries, that is, the average force driving blood into vessels that serve the tissues'; :39462 'Only the brain receives a more or less constant supply of blood whether you are active, resting, thinking, or engaged in any other activity.'; :39704-39710 'The myogenic response is a localized process that serves to stabilize blood flow in the capillary network that follows that arteriole ... When blood flow is too high, the smooth muscle will contract in response to the increased stretch, prompting vasoconstriction that reduces blood flow.' (The mean arterial pressures of \(90\) and \(115\ \text{mm Hg}\) are supplied as stem measurements; the textbook reference blood pressure of \(120/80\ \text{mm Hg}\) is at :38892.)

**Distractors**

- **(A)** `misconception` · _high flow read as high resistance work_ — Assumes that the bed handling the largest flow increase must be the one raising resistance. Because resistance is proportional to driving pressure divided by flow, a tenfold flow rise against a \(1.3\) fold pressure rise means resistance fell to about one eighth of its resting value. Active muscle arterioles dilate in response to local metabolites, they do not constrict.
  - Citation: openstax-anatomy-physiology-2e.txt:39476 'Skeletal muscle 1200 4500 12,500'; :39685-39689 'Opening of the sphincter is triggered in response to decreased oxygen concentrations; increased carbon dioxide concentrations; increasing levels of lactic acid ... These conditions in turn stimulate the release of NO, a powerful vasodilator'
- **(B)** `misconception` · _cold-stress cutaneous constriction applied to exercise_ — Applies the cold stress cutaneous response to a heat producing situation. Cutaneous flow rises by a factor of about \(3.8\), faster than the roughly threefold rise in cardiac output, so cutaneous resistance fell to about one third of rest. During exercise the body sends more blood to the body surface precisely so the excess heat can be dissipated, so the skin bed dilates rather than constricts.
  - Citation: openstax-anatomy-physiology-2e.txt:39482 'Integument 500 1500 1900'; :39466-39468 'During exercise, the body distributes more blood to the body surface where it can dissipate the excess heat generated by increased activity into the environment.'; :8497 'the dermal blood vessels constrict to minimize heat loss in response to low temperatures'
- **(C)** `partial_truth` · _right resistance direction, disqualified by the flow condition_ — Correct on resistance but disqualified by the stated condition. Renal resistance did rise, by roughly a factor of \(2.3\), yet renal flow fell from \(1100\) to \(600\ \text{mL/min}\) as the cardiovascular system reallocated flow away from the kidney. The question asks for a bed whose resistance rose while flow did NOT fall, which the kidney does not satisfy.
  - Citation: openstax-anatomy-physiology-2e.txt:39484 'Kidney 1100 900 600'; :39459-39460 'cardiovascular system engages in resource allocation, because there is not enough blood flow to distribute blood equally to all tissues simultaneously'

**Readback check.** Does not read back. The stem supplies only raw flows and pressures and never uses the words 'resistance,' 'dilate,' or 'constrict,' so there is no premise for the key to restate and no phrase for it to echo. Answering requires forming a pressure to flow ratio for each bed and comparing it with the \(1.3\) fold pressure ratio, which cannot be done from the stem's surface. The key is not the only genuine member of its category, since the renal bed also shows a real resistance increase. AUDIT NOTE on the exclusion clause: choice C can be ruled out by reading that renal flow fell, without any physiology, so it is data-eliminable for a careful reader. It is retained deliberately because it is the highest-frequency wrong answer here, not a throwaway option, and because the clause is what punishes the target misconception, namely that unchanged flow implies unchanged resistance. A student holding that misconception will not select the brain and will hunt for a bed whose flow fell. AUDIT CHANGE: the citation ':39068-39070' for the resistance calculation does not exist at those lines and was corrected to :39064-39065; the citation ':38893-38897' for the reference blood pressure was corrected to :38892; the vessel diameter citation was widened from :39143-39146 to :39142-39143 to include the vascular tone sentence that the argument actually uses; the myogenic citation was corrected from :39704-39709 to :39704-39710; the precapillary sphincter citation was corrected from :39687-39690 to :39685-39689; and 'sympathetic drive' in the (Choice B) block was reworded to 'neural constrictor signals' to keep the item clear of the Ch4 autonomic-division scope boundary. All numeric ratios were recomputed and confirmed: brain \(1.28\), kidney \(2.34\), integument \(0.34\), skeletal muscle \(0.12\).

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because cerebral flow is unchanged while the pressure driving it is higher, and that combination is possible only if cerebral vascular resistance rose. Flow through any bed equals the pressure difference across it divided by that bed's resistance, so resistance is proportional to driving pressure divided by flow. Mean arterial pressure rises by a factor of about \(1.3\), so a bed whose flow is unchanged must have raised its resistance by that same factor of about \(1.3\). Skeletal muscle flow rises roughly tenfold and cutaneous flow nearly fourfold, both far outpacing the pressure rise, so resistance in those two beds fell steeply. Renal resistance did rise, by a factor of roughly \(2.3\), but renal flow fell from \(1100\) to \(600\ \text{mL/min}\), which the question excludes.
>
> (Choice A) Skeletal muscle flow rises from \(1200\) to \(12{,}500\ \text{mL/min}\), an increase of about tenfold, while the driving pressure rises only about \(1.3\) fold. Resistance therefore falls to roughly one eighth of its resting value. This drop reflects local metabolic vasodilation, in which falling oxygen and rising carbon dioxide, lactic acid, potassium, and hydrogen ion open the arterioles and precapillary sphincters of active muscle.
>
> (Choice B) Cutaneous flow rises from \(500\) to \(1900\ \text{mL/min}\), a factor of about \(3.8\), which is faster than the roughly threefold rise in cardiac output, so the skin's share of the output grows and its resistance falls to about one third of rest. Cutaneous arterioles do constrict under neural constrictor signals during cold exposure, but during heat producing exercise the dominant signal is dilation so that surface heat can be dissipated. Applying the cold response to these exercise data gives the wrong direction.
>
> (Choice C) Renal resistance genuinely did increase, by a factor of roughly \(2.3\), so this bed is correct on the resistance half of the question. It fails the stated condition, because renal flow fell from \(1100\) to \(600\ \text{mL/min}\) as blood was redistributed away from the kidney. The question asks specifically for a bed whose resistance rose while its flow did not fall.
>
> (Choice D) Correct. The brain is the one bed that receives a more or less constant supply of blood whether a person is active or resting, and it holds \(750\ \text{mL/min}\) here at both rest and maximal exercise. Holding flow constant against a higher perfusion pressure requires the cerebral vessels to oppose that pressure more strongly, so resistance must have risen by about the same factor as the pressure. The local mechanism is myogenic: when flow and wall stretch increase, arteriolar smooth muscle contracts, producing vasoconstriction that reduces flow back toward its set point.
>
> This is a Data-based and Statistical Reasoning question because you must combine tabulated flows with the measured change in perfusion pressure to infer the direction of the resistance change in each of four vascular beds.

---

## Q5 — Atrioventricular Valve Anchoring

**Stem.** In an isolated perfused heart, a drug selectively paralyzes the papillary muscles of the left ventricle while the surrounding ventricular myocardium continues to contract normally. Which valve malfunction is most likely to result?

- **A.** The aortic valve fails to close completely
- **B.** The mitral valve fails to close completely  ← **KEY**
- **C.** The aortic valve fails to open completely
- **D.** The mitral valve fails to open completely

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic easy / structural easy) |
| Estimated time | 60 s |
| Confidence | 5 |

**Correct answer (B): The mitral valve fails to close completely**

Citations: /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-anatomy-physiology-2e.txt L36098-36099: "the papillary muscles also contract, generating tension on the chordae tendineae. This prevents the flaps of the valves from being forced into the atria and regurgitation of the blood back into the atria"; L36173: "two cusps of the mitral valve are attached by chordae tendineae to two papillary muscles that project from the wall"; L36217: "The aortic and pulmonary semilunar valves lack the chordae tendineae and papillary muscles associated with the" atrioventricular valves; L36257: "Prolapse may occur if the chordae tendineae are damaged or broken, causing the closure mechanism to fail."; L36262: "Stenosis is a condition in which the heart valves become rigid and may calcify over time."; L36266-36268: "Occasionally, one or more of the chordae tendineae will tear or the papillary muscle itself may die as a component of a myocardial infarction (heart attack). In this case, the patient's condition will deteriorate dramatically and rapidly"; L37055: "When this occurs, blood flows from the atria into the ventricles, pushing open the tricuspid and mitral valves."

**Distractors**

- **(A)** `misconception` · _wrong valve class for the named structure_ — The aortic valve has no papillary muscles or chordae tendineae, so their paralysis cannot affect its closure; semilunar cusps seal passively when blood fills their pockets from the arterial side.
  - Citation: openstax-anatomy-physiology-2e.txt L36217: "The aortic and pulmonary semilunar valves lack the chordae tendineae and papillary muscles associated with the" atrioventricular valves
- **(C)** `adjacent_fact` · _real lesion of the other valve class, wrong cause_ — Failure to open at the aortic valve is stenosis, a chronic rigidity of leaflet tissue, and that valve is not anchored by papillary muscles in the first place.
  - Citation: openstax-anatomy-physiology-2e.txt L36262: "Stenosis is a condition in which the heart valves become rigid and may calcify over time."
- **(D)** `process_step_confusion` · _closure support confused with active opening_ — Correct valve but wrong function: papillary tension resists eversion during closure and does not pull the cusps open, so the mitral cusps still open passively during filling.
  - Citation: openstax-anatomy-physiology-2e.txt L37055: "When this occurs, blood flows from the atria into the ventricles, pushing open the tricuspid and mitral valves."

**Readback check.** Not readback. The stem describes only an experimental manipulation and never names a valve, a direction of flow, or what the papillary muscles do. The key shares no distinctive wording with the stem. The four choices form a two by two grid of valve identity (mitral or aortic) crossed with failure mode (closure or opening); all four name real left-sided valve lesions, and none can be eliminated without knowing that papillary muscles anchor only the atrioventricular cusps and that their role is to resist eversion rather than to pull the cusps open. AUDIT CHANGE: the original failure-mode axis read 'stiffen and resist opening,' which a student could dismiss with no topic knowledge at all because an acute drug cannot calcify leaflet tissue, collapsing the item to a coin flip between two choices; it was replaced with 'fails to open completely,' which encodes the live misconception that papillary muscles pull the atrioventricular cusps open. The stem's trailing phrase 'during the next ventricular contraction' was deleted because it flagged which choices were off-window. Key relettered from A to B for answer balance, all four explanation blocks rewritten to match, and L36266-36268 added to citations.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because the papillary muscles and chordae tendineae are the only structures holding the atrioventricular cusps in their closed plane once ventricular pressure exceeds atrial pressure. When the left ventricle contracts, pressure inside the chamber climbs rapidly above the pressure in the relaxed left atrium, and blood pushes upward against the undersurface of the mitral cusps. Normally the papillary muscles contract at that same moment, tensing the chordae tendineae so the cusps cannot be forced back into the atrium. With the papillary muscles paralyzed the chordae remain slack, the cusps are driven backward, and the valve no longer seals.
>
> (Choice A) The aortic valve carries no papillary muscles or chordae tendineae, so paralyzing that apparatus cannot affect how its cusps close. Semilunar cusps are pocket-like folds that seal passively when blood fills them from the arterial side. Their closure is driven by the pressure gradient across them, not by tension from ventricular muscle.
>
> (Choice B) The mitral cusps are attached by chordae tendineae to two papillary muscles that project from the left ventricular wall, and that arrangement exists specifically to keep the cusps from being forced into the atrium during contraction. Loss of papillary tension is functionally equivalent to torn chordae, which produces a prolapsed valve and regurgitation. Death of a papillary muscle during a myocardial infarction causes exactly this failure, and the patient deteriorates rapidly.
>
> (Choice C) This pairs the wrong valve with the wrong function. The aortic valve has no papillary attachments at all, and it opens passively as soon as ventricular pressure exceeds aortic pressure. Failure to open at that valve is stenosis, a chronic rigidity of the leaflet tissue rather than a consequence of losing muscle tension.
>
> (Choice D) This names the correct valve but the wrong function. The papillary muscles do not pull the mitral cusps apart; the cusps are pushed open passively when atrial pressure exceeds ventricular pressure during filling. An acutely paralyzed papillary muscle leaves the leaflet tissue entirely normal in flexibility, so the valve still opens freely.
>
> This is a Knowledge of Scientific Concepts and Principles question because you must recall that the papillary muscles and chordae tendineae anchor only the atrioventricular cusps and act to prevent their eversion during ventricular contraction.

---

## Q6 — Semilunar Valve Competence

**Stem.** Scarring leaves a patient's aortic valve cusps unable to seal, so blood leaks backward out of the aorta each time the ventricles relax. Resting forward cardiac output is maintained. Which measurement is most likely elevated in this patient?

- **A.** Right ventricular end diastolic volume
- **B.** Aortic diastolic pressure
- **C.** Left ventricular end diastolic volume  ← **KEY**
- **D.** Right atrial end diastolic volume

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic easy / structural easy) |
| Estimated time | 70 s |
| Confidence | 5 |

**Correct answer (C): Left ventricular end diastolic volume**

Citations: /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-anatomy-physiology-2e.txt L36176-36178: "At the base of the aorta is the aortic semilunar valve, or the aortic valve, which prevents backflow from the aorta." and "When the ventricle relaxes and blood attempts to flow back into the ventricle from the aorta, blood will fill the cusps of the valve, causing it to close"; L37020-37021: "the ventricles contain approximately 130 mL blood in a resting adult in a standing position. This volume is known as the end diastolic volume (EDV) or preload."; L37036: "This quantity is referred to as stroke volume. Stroke volume will normally be in the range of 70" to "80 mL."; L36139: "The left ventricle is the major pumping chamber for the systemic circuit; it ejects blood into the aorta through the" aortic semilunar valve; L36059: "The right atrium serves as the receiving chamber for blood returning to the heart from the systemic circulation."; L37001-37002: "Blood is flowing into the right atrium from the superior and inferior venae cavae and the coronary sinus."; L36985: "regions that are higher in pressure to regions that are lower in pressure"

**Distractors**

- **(A)** `adjacent_fact` · _correct measurement, wrong side of the heart_ — The right ventricle is on the far side of the circulation from the aortic valve and is filled by systemic venous return, so no part of the regurgitant stream reaches it and its filling volume is unchanged.
  - Citation: openstax-anatomy-physiology-2e.txt L36059: "The right atrium serves as the receiving chamber for blood returning to the heart from the systemic circulation."
- **(B)** `reversed_relationship` · _right variable, wrong direction of change_ — Backward drainage out of the aorta during relaxation removes volume from the aorta, so aortic diastolic pressure falls rather than rises.
  - Citation: openstax-anatomy-physiology-2e.txt L36176: "At the base of the aorta is the aortic semilunar valve, or the aortic valve, which prevents backflow from the aorta."
- **(D)** `adjacent_fact` · _receiving chamber on the wrong circuit_ — The right atrium is loaded by systemic venous congestion arriving through the venae cavae and coronary sinus, not by a left-sided semilunar leak that empties directly into the left ventricle.
  - Citation: openstax-anatomy-physiology-2e.txt L37001-37002: "Blood is flowing into the right atrium from the superior and inferior venae cavae and the coronary sinus."

**Readback check.** Not readback. The stem states only that the aortic cusps leak; it never names a chamber, never says where the leaked blood goes, and never mentions volume or filling. The student must supply the fact that the aortic valve separates the left ventricle from the aorta and then infer that the regurgitant volume adds to diastolic filling. The key repeats no stem phrase, and all four choices are real, routinely reported hemodynamic measurements. Two distractors are right-sided, which a student can exclude once they place the aortic valve on the left, but chamber and pathway laterality is precisely the content this unit tests, so that elimination is topic knowledge rather than test-wiseness; the item is tiered easy accordingly. AUDIT CHANGE: the choice A block wrongly stated that right ventricular filling depends on 'pulmonary venous return' (the right ventricle is filled by systemic venous return); corrected. Two distractor citations pointed at L36130, which describes left atrial contraction and does not support claims about the right heart; rebased on L36059 and L37001-37002. L37036 added to support the stroke volume figure quoted in the choice C block.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because the leaking valve returns blood to the chamber immediately upstream of it, adding to the volume that arrives normally from the left atrium. The aortic semilunar valve sits at the base of the aorta and exists to prevent backflow into the left ventricle. When its cusps cannot seal, blood in the aorta flows down its pressure gradient back into the relaxed left ventricle at the same time that blood is entering through the mitral valve. The volume present at the end of filling, normally about \(130\ \text{mL}\), therefore rises above normal, and the ventricle must eject this larger total each beat to keep forward delivery at its usual value.
>
> (Choice A) The right ventricle lies on the opposite side of the circulation from the leaking valve and is filled by blood returning through the systemic veins. The regurgitant stream never leaves the left side of the heart, so it adds no volume to this chamber. Right ventricular filling would change only if systemic venous return changed, and the stem states that resting forward output is maintained.
>
> (Choice B) This reverses the direction of the effect. Blood draining backward out of the aorta during ventricular relaxation removes volume from the aorta, so aortic pressure falls further than normal between beats. Aortic diastolic pressure in this patient is characteristically low rather than elevated.
>
> (Choice C) An incompetent aortic valve allows regurgitant blood to join normal mitral inflow, so the left ventricle ends filling overloaded with volume. Because the leak recurs on every beat, the chamber operates chronically at an elevated end diastolic volume. Total ejected volume must exceed the usual \(70\ \text{mL}\) to \(80\ \text{mL}\) so that forward delivery remains adequate.
>
> (Choice D) The right atrium is the receiving chamber for blood returning from the systemic circulation through the venae cavae and the coronary sinus, and it is separated from the leaking valve by the entire systemic and pulmonary circuits. A left-sided semilunar leak does not load it directly. Right atrial volume rises with systemic venous congestion, which this lesion does not initially produce.
>
> This is a Scientific Reasoning and Problem Solving question because you must predict how loss of one-way flow at a single valve redistributes blood volume within the cardiac cycle.

---

## Q7 — Murmur Timing And Valve Lesions

**Stem.** A clinician records a murmur that begins immediately after the first heart sound and stops at the second heart sound. Echocardiography shows that all four valve orifices reach normal cross-sectional area when they open. Which valve lesion most likely produces this murmur?

- **A.** Aortic regurgitation
- **B.** Pulmonary stenosis
- **C.** Mitral stenosis
- **D.** Mitral regurgitation  ← **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 95 s |
| Confidence | 5 |

**Correct answer (D): Mitral regurgitation**

Citations: /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-anatomy-physiology-2e.txt L37078-37080: "S1 is the sound created by the closing of the atrioventricular valves during ventricular contraction" and "The second heart sound, S2, is the sound of the closing of the semilunar valves during ventricular diastole"; L37106: "The term murmur is used to describe an unusual sound coming from the heart that is caused by the turbulent flow" of blood; L36259-36260: "results in regurgitation, when the blood flows backward from its normal path. Using a stethoscope, the disruption to the normal flow of blood produces a heart murmur."; L36262-36263: "Stenosis is a condition in which the heart valves become rigid and may calcify over time. The loss of flexibility of the valve interferes with normal function"; L36249-36250: "mitral regurgitation is the most common, detected in approximately 2 percent of the population"; L37026: "blood to flow back toward the atria, closing the tricuspid and mitral valves."; L37048: "The semilunar valves close to prevent backflow into the heart."; L37055: "When this occurs, blood flows from the atria into the ventricles, pushing open the tricuspid and mitral valves."

**Distractors**

- **(A)** `process_step_confusion` · _right lesion type, wrong phase of the cycle_ — Backward flow across the aortic valve only begins once ventricular pressure drops below aortic pressure, placing the turbulence after S2 rather than between S1 and S2.
  - Citation: openstax-anatomy-physiology-2e.txt L37048: "The semilunar valves close to prevent backflow into the heart."
- **(B)** `partial_truth` · _correct on timing, killed by the imaging datum_ — Pulmonary stenosis genuinely produces a murmur inside this interval, so it is correct on timing, but a stenotic valve cannot reach normal opening area and the echocardiogram excludes it.
  - Citation: openstax-anatomy-physiology-2e.txt L36262-36263: "Stenosis is a condition in which the heart valves become rigid and may calcify over time. The loss of flexibility of the valve interferes with normal function"
- **(C)** `reversed_relationship` · _same valve, opposite malfunction_ — Correct valve but opposite defect: obstruction to filling produces turbulence while the ventricles relax, after S2, and a stenotic orifice contradicts the normal opening areas.
  - Citation: openstax-anatomy-physiology-2e.txt L37055: "When this occurs, blood flows from the atria into the ventricles, pushing open the tricuspid and mitral valves."

**Readback check.** Not readback. The stem gives only a timing landmark and an orifice-area measurement; it never names a phase of the cycle, a direction of flow, or a valve. The key repeats no distinctive stem wording. All four choices are genuine valve lesions, and two of them survive the timing filter, so the student must additionally apply the definition of stenosis to the orifice data. Nothing can be eliminated by test-wiseness because the choice set is balanced two stenoses to two regurgitations and two mitral to two non-mitral. AUDIT CHANGE: the choice B block claimed pulmonary stenosis generates turbulence 'in exactly this window,' which overstates the match because a pulmonic ejection murmur tapers before S2; softened to 'during ventricular ejection, which falls inside the interval described.' The partial-truth trap is preserved intact because the imaging datum, not the timing, is the decisive discriminator. 'Valve openings' changed to 'valve orifices' in the stem for precision. All citations verified verbatim against the source.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because a murmur confined between the two heart sounds is turbulence occurring during ventricular contraction, and mitral regurgitation is the only listed lesion that disturbs systolic flow without narrowing an orifice. S1 is produced by closure of the atrioventricular valves as the ventricles begin to contract, and S2 by closure of the semilunar valves as the ventricles begin to relax. The interval between them is therefore ventricular systole, when the atrioventricular valves should be sealed and the semilunar valves open. Turbulence in that window requires either backward flow through an atrioventricular valve or obstructed forward flow through a semilunar valve, and normal opening areas eliminate every stenosis.
>
> (Choice A) Aortic regurgitation drives blood from the aorta back into the left ventricle only once ventricular pressure has fallen below aortic pressure, which occurs after S2. Its turbulence therefore occupies the interval from S2 to the following S1. It cannot fill the systolic window described in the stem.
>
> (Choice B) Pulmonary stenosis does generate turbulence during ventricular ejection, which falls inside the interval described, so timing alone would not exclude it. The imaging finding is what decides the question: a stenotic valve is by definition rigid and fails to reach its normal opening area. Normal opening areas at all four valves rule out stenosis anywhere in the heart.
>
> (Choice C) Mitral stenosis obstructs flow from the left atrium into the left ventricle, and that flow occurs during ventricular filling, after S2. Its murmur is therefore diastolic rather than systolic. The lesion is additionally excluded by the reported normal opening areas.
>
> (Choice D) An incompetent mitral valve lets blood escape backward into the left atrium throughout ventricular contraction, producing turbulent flow that lasts from S1 until the semilunar valves close at S2. Because the defect is one of closure rather than opening, the leaflets still separate to normal area during filling, matching the echocardiogram. Mitral regurgitation is also the most frequently encountered of the valve disorders, detected in roughly \(2\ \text{percent}\) of the population.
>
> This is a Scientific Reasoning and Problem Solving question because you must convert an auscultatory timing landmark into a statement about which valves are open and then select the lesion compatible with the imaging data.

---

## Q8 — Pressure Overload And Chamber Remodeling

**Stem.** A child is born with a rigid pulmonary valve whose opening is about one third of normal cross-sectional area. Resting cardiac output measured in the aorta is normal. Which structural change is most likely to develop over the following years?

- **A.** Thickening of the right ventricular wall  ← **KEY**
- **B.** Thickening of the left ventricular wall
- **C.** Thickening of the left atrial wall
- **D.** Thickening of the right atrial wall

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 85 s |
| Confidence | 5 |

**Correct answer (A): Thickening of the right ventricular wall**

Citations: /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-anatomy-physiology-2e.txt L37625: "Damage to the valves, such as stenosis, which makes them harder to open will also increase afterload."; L36028-36029: "infundibular stenosis (rigidity of the pulmonary valve)" and "right ventricular hypertrophy (enlargement of the right ventricle)"; L35907-35909: "the muscle of the left ventricle is much thicker and better developed than that of the right ventricle. In order to overcome the high resistance required to pump blood into the long systemic circuit, the left ventricle must generate a great amount of" pressure; L35910-35911: "The right ventricle does not need to generate as much pressure, since the pulmonary circuit is shorter and provides less resistance."; L36262-36264: "Stenosis is a condition in which the heart valves become rigid and may calcify over time. The loss of flexibility of the valve interferes with normal function and may cause the heart to work harder to propel blood through the valve"; L36130: "This atrial contraction accounts for approximately 20" percent of ventricular filling

**Distractors**

- **(B)** `misconception` · _default to the left ventricle for any valve disease_ — The left ventricle sits downstream of the pulmonary valve and its load is set by systemic resistance; assuming the thick-walled systemic pump absorbs every added workload ignores where the obstruction actually lies.
  - Citation: openstax-anatomy-physiology-2e.txt L35907-35909: "the muscle of the left ventricle is much thicker and better developed than that of the right ventricle. In order to overcome the high resistance required to pump blood into the long systemic circuit, the left ventricle must generate a great amount of" pressure
- **(C)** `adjacent_fact` · _real remodeling pattern from the wrong lesion_ — Left atrial remodeling is a real response to elevated left-sided filling pressure such as mitral disease, but a pulmonary outflow obstruction does not raise left atrial pressure.
  - Citation: openstax-anatomy-physiology-2e.txt L36170: "Located at the opening between the left atrium and left ventricle is the mitral valve"
- **(D)** `partial_truth` · _correct chamber only in the late decompensated state_ — The right atrium can enlarge late once the right ventricle fails, but it is a low pressure receiving chamber supplying only about a fifth of ventricular filling and it never ejects against a semilunar valve.
  - Citation: openstax-anatomy-physiology-2e.txt L36130: "left atrium will contract, pumping blood into the ventricle. This atrial contraction accounts for approximately 20" percent of ventricular filling

**Readback check.** Not readback. The stem names a valve and an orifice area but no chamber, no pressure, and no adaptation. The key names a chamber that never appears in the stem, so there is no echo. All four choices are the same grammatical form applied to the four chambers, and each names a chamber that genuinely can thicken or enlarge in some cardiac disease, so no choice is eliminable without knowing that the pulmonary valve is the right ventricular outflow valve and that pressure load drives wall thickening. AUDIT CHANGE: the draft supported the remodeling mechanism with L17863, a line from the skeletal muscle chapter about hypertrophy from physical training; that citation does not speak to cardiac remodeling and framing the answer around muscle-fiber protein addition drifts into Chapter 11 territory, which is off limits for this chapter. It was removed and the mechanism is now framed hemodynamically, anchored on the afterload statement at L37625, the ventricular wall thickness comparison at L35907-35911, and the explicit pairing of pulmonary valve rigidity with right ventricular hypertrophy at L36028-36029. The tetralogy citation range was corrected from L36027-36029 to L36028-36029. The meta-reference to 'the textbook' was removed from student-facing prose.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because the right ventricle is the chamber that must force blood through the narrowed pulmonary valve, and a chamber that chronically ejects against a raised pressure develops a thicker wall. A stenotic valve is harder to open and therefore increases the afterload against which the chamber immediately upstream must eject. The right ventricle sits directly behind the pulmonary valve and pumps into the pulmonary trunk through it, so it alone must generate the extra pressure needed to hold output at its normal value. The same relationship explains the normal heart: the left ventricle, which pumps into the high resistance systemic circuit, carries a far thicker wall than the right ventricle, which faces the low resistance pulmonary circuit.
>
> (Choice A) The right ventricle is the chamber upstream of the obstruction and the only one whose required ejection pressure rises. Wall thickening is the standard adaptation to a chronically elevated pressure load, exactly as pressure load explains the normally thick left ventricular wall. The same pairing appears in tetralogy of Fallot, in which rigidity of the pulmonary valve is accompanied by enlargement of the right ventricle.
>
> (Choice B) The left ventricle lies downstream of the pulmonary valve, separated from it by the pulmonary capillary bed and the left atrium, and its load is set by systemic resistance rather than by the pulmonary valve. The stem states that output measured in the aorta is normal, so the left ventricle is performing its usual amount of work. It has no stimulus to thicken.
>
> (Choice C) The left atrium remodels when left-sided filling pressures rise, as occurs with mitral valve disease, because it is the chamber immediately upstream of the mitral orifice. A pulmonary outflow obstruction does not raise left atrial pressure and if anything limits pulmonary venous return. The change is on the wrong side of the circulation.
>
> (Choice D) The right atrium does lie upstream of the right ventricle, and it can enlarge late if the right ventricle eventually fails and the tricuspid valve begins to leak. However, atria are low pressure receiving chambers whose contraction supplies only about \(20\ \text{percent}\) of ventricular filling, and they never eject against a semilunar valve. Right atrial thickening is not the primary adaptation to pulmonary valve stenosis.
>
> This is a Scientific Reasoning and Problem Solving question because you must locate the chamber immediately upstream of an obstructed valve and predict its structural adaptation to increased pressure work.

---

## Q9 — Pressure Gradients Across Valves

**Stem.** During catheterization, peak left ventricular pressure is \(190\ \text{mm Hg}\) while peak aortic pressure in the same ejection is \(120\ \text{mm Hg}\). At the end of ventricular filling, left atrial and left ventricular pressures are both \(8\ \text{mm Hg}\). These measurements are most consistent with which lesion?

- **A.** Aortic regurgitation
- **B.** Mitral stenosis
- **C.** Aortic stenosis  ← **KEY**
- **D.** Mitral regurgitation

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic medium / structural hard) |
| Estimated time | 125 s |
| Confidence | 5 |
| Hard-tier gate | Re-verified on audit; meets all four. (1) CONCEPT CHAINING: the student must link valve position within the pathway, which phase each valve is open, and the pressure-gradient rule for flow before any choice can be evaluated. (2) DATA-TO-MECHANISM: no single number yields the answer; two differences must be computed, \(190-120=70\ \text{mm Hg}\) during ejection and \(8-8=0\ \text{mm Hg}\) during filling, and then translated into a statement about which orifice resists flow. (3) TRUE PARTIAL-TRUTH TRAP: mitral stenosis is exactly correct about the mechanism, that an obstructed valve sustains a gradient across itself, and would be the key if the two filling pressures differed. (4) 510-TEMPTING DISTRACTOR: mitral stenosis is where a well-prepared student lands after grasping the gradient concept but not checking which pair of pressures actually differs. |

**Correct answer (C): Aortic stenosis**

Citations: /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-anatomy-physiology-2e.txt L36985: "regions that are higher in pressure to regions that are lower in pressure"; L36262-36264: "Stenosis is a condition in which the heart valves become rigid and may calcify over time. The loss of flexibility of the valve interferes with normal function and may cause the heart to work harder to propel blood through the valve"; L37625: "Damage to the valves, such as stenosis, which makes them harder to open will also increase afterload."; L37031-37033: "the contraction of the ventricular muscle has raised the pressure within the ventricle to the point that it is greater than the pressures in the pulmonary trunk and the aorta. Blood is pumped from the heart, pushing open the pulmonary and aortic semilunar valves."; L37055: "When this occurs, blood flows from the atria into the ventricles, pushing open the tricuspid and mitral valves."; L36139: "The left ventricle is the major pumping chamber for the systemic circuit; it ejects blood into the aorta through the" aortic semilunar valve

**Distractors**

- **(A)** `reversed_relationship` · _same valve, opposite direction of malfunction_ — A leaking aortic valve equalizes aortic and ventricular pressure during relaxation and widens pulse pressure; it does not obstruct ejection and cannot create a systolic pressure step across the valve.
  - Citation: openstax-anatomy-physiology-2e.txt L36259: "results in regurgitation, when the blood flows backward from its normal path"
- **(B)** `partial_truth` · _right principle applied to the untested valve_ — Correct mechanism at the wrong valve: an obstructed mitral valve would hold left atrial pressure above left ventricular pressure during filling, but both are recorded at \(8\ \text{mm Hg}\).
  - Citation: openstax-anatomy-physiology-2e.txt L37055: "When this occurs, blood flows from the atria into the ventricles, pushing open the tricuspid and mitral valves."
- **(D)** `adjacent_fact` · _real left-sided lesion measured at the wrong pair of sites_ — Backward flow into the left atrium during contraction would show up as a ventricle-to-atrium abnormality, not as a difference between ventricle and aorta.
  - Citation: openstax-anatomy-physiology-2e.txt L37026: "blood to flow back toward the atria, closing the tricuspid and mitral valves."

**Readback check.** Not readback. The stem supplies only raw catheter numbers and never states that a gradient exists, that a valve is obstructed, or which phase each measurement belongs to. The key shares no wording with the stem. All four choices are real lesions of the left heart, and the set is balanced two obstructive to two regurgitant and two aortic to two mitral, so it cannot be narrowed by category-spotting. Supplying pressure values is supplying data to reason from, not the conclusion. AUDIT CHANGE: the citation for the ejection-phase pressure sentence was listed as L37033-37034 but the passage actually sits at L37031-37033; corrected. Hard-tier gate independently re-verified against all four conditions and confirmed. Question content otherwise unchanged.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because a large pressure difference persists across the aortic valve while it is open, whereas no difference at all exists across the mitral valve while it is open. Blood moves only from higher to lower pressure, so when an open valve offers little resistance the two chambers it connects come close to equilibrium as blood passes through. During ejection the left ventricle generates \(190\ \text{mm Hg}\) but delivers only \(120\ \text{mm Hg}\) into the aorta, a \(70\ \text{mm Hg}\) penalty paid crossing the aortic orifice. Rigid, calcified leaflets that resist opening force precisely this pattern and make the heart work harder to propel blood through the valve, while the identical left atrial and left ventricular values of \(8\ \text{mm Hg}\) during filling show the mitral valve is offering essentially no resistance.
>
> (Choice A) An incompetent aortic valve allows blood to run backward from the aorta into the ventricle during relaxation, which tends to bring aortic and ventricular pressures toward each other in diastole and to widen the arterial pulse pressure. It does not obstruct forward ejection, so it cannot generate a \(70\ \text{mm Hg}\) step across the valve during systole. The record shows restricted forward flow, the opposite defect.
>
> (Choice B) This choice applies the right principle to the wrong valve. A stenotic mitral valve would keep left atrial pressure well above left ventricular pressure throughout filling, yet both chambers are recorded at \(8\ \text{mm Hg}\). The gradient in this patient appears during ejection, a phase in which the mitral valve is closed and contributing nothing to flow.
>
> (Choice C) A rigid aortic valve narrows the outlet from the left ventricle, so the ventricle must overshoot the arterial pressure by a large margin to move its stroke volume across. The measured \(70\ \text{mm Hg}\) systolic difference is that overshoot, and the aortic peak of \(120\ \text{mm Hg}\) shows the extra work buys only normal arterial pressure. The absence of any difference across the mitral valve during filling confirms the obstruction sits at the outflow, not the inflow.
>
> (Choice D) Mitral regurgitation sends part of the stroke volume backward into the left atrium during contraction, creating an abnormality between ventricle and atrium rather than between ventricle and aorta. It cannot create a pressure step across the aortic orifice. Mitral regurgitation would in any case leave ventricular and aortic pressures nearly equal during ejection, which is not what was measured.
>
> This is a Data-based and Statistical Reasoning question because you must compare paired pressure measurements taken across two different valves and determine which difference identifies an obstructed orifice.

---

## Q10 — Backward Transmission Of Pressure

**Stem.** A patient's mitral valve orifice is severely narrowed by calcification. Left ventricular wall thickness and peak left ventricular systolic pressure are normal, yet the patient becomes breathless with mild exertion and has no ankle swelling. Which sequence best explains the breathlessness?

- **A.** Left ventricular pressure rises, raising aortic and then systemic capillary pressure
- **B.** Left atrial pressure rises, raising pulmonary venous and then pulmonary capillary pressure  ← **KEY**
- **C.** Right ventricular output falls, lowering pulmonary arterial and then pulmonary capillary pressure
- **D.** Systemic venous pressure rises, raising right atrial and then systemic capillary pressure

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic medium / structural hard) |
| Estimated time | 120 s |
| Confidence | 5 |
| Hard-tier gate | Re-verified on audit; meets three. (1) CONCEPT CHAINING: requires connecting valve obstruction, backward transmission of pressure through two successive vascular segments, capillary filtration into lung tissue, and the resulting symptom. (2) DATA-TO-MECHANISM: the normal left ventricular wall thickness and systolic pressure and the absence of ankle swelling are the findings that select the pulmonary route and eliminate the left ventricular and systemic venous routes; without reasoning from them, two choices remain live. (4) 510-TEMPTING DISTRACTOR: choice D is where a well-prepared student lands by recalling that mitral stenosis eventually causes right heart failure and systemic congestion, and choice A traps a student who reflexively routes all left-sided valve disease through the left ventricle. Condition (3) is deliberately NOT claimed: neither surviving distractor is strictly correct for the question as asked, since neither systemic venous congestion nor an aortic pressure rise explains breathlessness under any condition. |

**Correct answer (B): Left atrial pressure rises, raising pulmonary venous and then pulmonary capillary pressure**

Citations: /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-anatomy-physiology-2e.txt L54653-54656: "the blood in the pulmonary circulation gets 'backed up,' starting with the left atrium, then into the pulmonary veins, and then into pulmonary capillaries. The resulting increased hydrostatic pressure within pulmonary capillaries, as blood is still coming in from the pulmonary arteries, causes fluid to be pushed out of them and into lung tissues."; L54645-54647: "Pulmonary edema is excess fluid in the air sacs of the lungs" and "Pulmonary edema can be life threatening, because it compromises gas exchange in the lungs"; L54640-54641: "In the limbs, the symptoms of edema include swelling of the subcutaneous tissues, an increase in the normal size of the limb"; L36262-36264: "Stenosis is a condition in which the heart valves become rigid and may calcify over time. The loss of flexibility of the valve interferes with normal function and may cause the heart to work harder to propel blood through the valve"; L36985: "regions that are higher in pressure to regions that are lower in pressure"; L36170: "Located at the opening between the left atrium and left ventricle is the mitral valve"; L37055: "When this occurs, blood flows from the atria into the ventricles, pushing open the tricuspid and mitral valves."

**Distractors**

- **(A)** `misconception` · _reflexively routing left-sided valve disease through the left ventricle_ — The obstruction lies upstream of the left ventricle, and the stated normal ventricular systolic pressure and wall thickness show the ventricle is not pressure-overloaded; systemic capillary congestion also cannot fill the alveoli.
  - Citation: openstax-anatomy-physiology-2e.txt L35907-35909: "the muscle of the left ventricle is much thicker and better developed than that of the right ventricle. In order to overcome the high resistance required to pump blood into the long systemic circuit"
- **(C)** `reversed_relationship` · _correct vascular bed, inverted pressure change_ — Falling pulmonary capillary pressure would reduce filtration out of the capillaries; only a rise in capillary hydrostatic pressure can push fluid into lung tissue.
  - Citation: openstax-anatomy-physiology-2e.txt L54654-54656: "The resulting increased hydrostatic pressure within pulmonary capillaries, as blood is still coming in from the pulmonary arteries, causes fluid to be pushed out of them and into lung tissues."
- **(D)** `process_step_confusion` · _correct backup mechanism on the wrong circuit_ — This is the right-sided congestion sequence, which produces dependent swelling such as ankle edema rather than alveolar fluid, and the stem records that ankle swelling is absent.
  - Citation: openstax-anatomy-physiology-2e.txt L54640-54641: "In the limbs, the symptoms of edema include swelling of the subcutaneous tissues, an increase in the normal size of the limb"

**Readback check.** Not readback. The stem names a narrowed valve and two clinical findings but never states which chamber is loaded, in which direction pressure travels, or where fluid accumulates. Keyword matching fails because choice C also contains 'pulmonary arterial' and 'pulmonary capillary pressure,' so the word 'breathless' cannot select the key by association. All four choices are real hemodynamic sequences that occur in some form of cardiac disease, and all four are the same grammatical shape. AUDIT CHANGE: the choice B block cited 'the textbook' as describing this order of congestion, which is a meta-reference in student-facing prose and also implied the source describes the sequence for mitral stenosis specifically when the source describes it for left-sided pump failure; the mechanism is now stated directly in the student's own terms while the identical left atrium to pulmonary vein to pulmonary capillary chain remains exactly what the source supports. Hard-gate justification restated and condition (3) explicitly withdrawn as unsupportable. All citations verified verbatim.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because a narrowed mitral orifice obstructs emptying of the left atrium, and the resulting pressure is transmitted backward through the pulmonary veins into the pulmonary capillaries. To drive the same volume through a smaller opening during filling, the left atrium must sustain a higher pressure than normal. Blood in the pulmonary circuit forms a continuous column, so congestion propagates in a fixed order: left atrium, then pulmonary veins, then pulmonary capillaries. Raised capillary hydrostatic pressure pushes fluid out of those capillaries into lung tissue, and fluid in the air sacs produces breathlessness that worsens with exertion.
>
> (Choice A) This routes the problem through the left ventricle, but the obstruction sits upstream of that chamber. The stem reports normal left ventricular systolic pressure and normal wall thickness, and a ventricle facing a raised ejection load would show both a higher systolic pressure and a thickened wall. Elevated systemic capillary pressure would also not explain fluid confined to the lungs.
>
> (Choice B) A stenotic mitral valve leaves the left atrium unable to empty freely, so left atrial pressure climbs and is transmitted backward to the pulmonary veins and then the pulmonary capillaries. Increased hydrostatic pressure within those capillaries pushes fluid out of them and into lung tissues, and excess fluid in the air sacs of the lungs is exactly what compromises breathing. Because the congestion is confined to the pulmonary bed, the ankles stay dry while the patient becomes breathless.
>
> (Choice C) This inverts the relationship between capillary pressure and fluid movement. A fall in pulmonary capillary pressure would reduce filtration out of the capillaries and could not put fluid into the air sacs. Congestion behind an obstructed mitral valve raises pulmonary pressures rather than lowering them.
>
> (Choice D) This is the sequence that follows right-sided failure, and it produces congestion in the systemic veins with dependent swelling such as ankle edema. The stem specifically records that ankle swelling is absent, which places the congestion in the pulmonary bed instead. Systemic capillary congestion also cannot fill the alveoli.
>
> This is a Scientific Reasoning and Problem Solving question because you must trace elevated pressure backward from an obstructed valve through the correct vascular bed and connect that congestion to the reported symptom.

---

## Q11 — Heart Sounds and Valve Closure

**Stem.** A stethoscope placed on a healthy resting adult detects a "lub" sound followed roughly \(0.3\ \text{s}\) later by a "dub" sound. During most of the interval between these two sounds, the heart is most likely:

- **A.** filling the ventricles through the atrioventricular valves
- **B.** contracting the atria to complete ventricular filling
- **C.** ejecting blood through the semilunar valves  ← **KEY**
- **D.** relaxing the ventricles at constant volume

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic easy / structural easy) |
| Estimated time | 60 s |
| Confidence | 5 |

**Correct answer (C): ejecting blood through the semilunar valves**

Citations: AP:37078-37081 'In a normal, healthy heart, there are only two audible heart sounds: S1 and S2. S1 is the sound created by the closing of the atrioventricular valves during ventricular contraction and is normally described as a "lub" ... The second heart sound, S2, is the sound of the closing of the semilunar valves during ventricular diastole and is described as a "dub".' | AP:37018-37019 'Ventricular systole ... may be conveniently divided into two phases, lasting a total of 270 ms.' | AP:37031-37033 'the contraction of the ventricular muscle has raised the pressure within the ventricle to the point that it is greater than the pressures in the pulmonary trunk and the aorta. Blood is pumped from the heart, pushing open the pulmonary and aortic semilunar valves.' | AP:37036 'Stroke volume will normally be in the range of 70 to 80 mL.' | AP:37020-37021 'the ventricles contain approximately 130 mL blood ... This volume is known as the end diastolic volume (EDV) or preload.'

**Distractors**

- **(A)** `process_step_confusion` · _right event, wrong phase of the cycle_ — Passive ventricular filling through the atrioventricular valves occurs in late ventricular diastole, after the second sound, when ventricular pressure has dropped below atrial pressure. During the interval between the sounds the ventricle is pressurized and those valves are shut.
  - Citation: AP:37054-37055 'Eventually, it drops below the pressure in the atria. When this occurs, blood flows from the atria into the ventricles, pushing open the tricuspid and mitral valves.'
- **(B)** `adjacent_fact` · _real event that immediately precedes the window_ — Atrial systole delivers the last 20 to 30 percent of ventricular filling and ends before ventricular systole begins, so it precedes the first heart sound rather than lying between the sounds.
  - Citation: AP:37013-37014 'Atrial contraction, also referred to as the "atrial kick," contributes the remaining 20 to 30 percent of filling ... Atrial systole lasts approximately 100 ms and ends prior to ventricular systole.'
- **(D)** `reversed_relationship` · _correct constant volume idea, reversed contraction direction_ — Constant ventricular volume does occur twice per cycle, but the relaxing version, isovolumic ventricular relaxation, starts only after semilunar valve closure. Within the interval described the ventricle is contracting at constant volume and then ejecting, not relaxing.
  - Citation: AP:37048-37050 'Since the atrioventricular valves remain closed at this point, there is no change in the volume of blood in the ventricle, so the early phase of ventricular diastole is called the isovolumic ventricular relaxation phase.'

**Readback check.** The stem supplies only two auditory landmarks and a time gap. It never states which valves generate the sounds, never states that closure (rather than opening) produces sound, and never names systole or diastole. The key shares no distinctive wording with the stem, and all four choices are genuine cardiac cycle events, so elimination requires knowing where each event sits in the cycle. AUDIT: the original main reasoning asserted that isovolumic contraction is the 'brief opening segment' as a bare fact; OpenStax gives only the 270 ms total and does not split the two phases, so this was rewritten as a mechanistic argument (isovolumic contraction ends as soon as ventricular pressure crosses arterial pressure) that the cited text does support. Three citation line ranges were off by one to four lines and were corrected against the file (37013-37015 to 37013-37014; 37054-37058 to 37054-37055; 37049-37051 to 37048-37050). Stem, options, and key unchanged.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because the two sounds mark closure of the atrioventricular valves and then closure of the semilunar valves, so the interval they bracket is ventricular systole, most of which is the ejection phase.
>
> The first sound is generated as the mitral and tricuspid valves are forced shut once ventricular pressure climbs above atrial pressure at the onset of ventricular contraction. The second sound is generated as the aortic and pulmonary valves are forced shut once ventricular pressure falls back below the pressure in the great arteries. Ventricular systole lasts about \(270\ \text{ms}\) in total and comprises two phases: isovolumic contraction ends the moment ventricular pressure exceeds aortic and pulmonary pressure, which a fully contracting ventricle reaches quickly, so the ejection phase occupies the larger share of the window. During that ejection phase roughly \(70\) to \(80\ \text{mL}\) leaves each ventricle.
>
> (Choice A) Filling of the ventricles through the open atrioventricular valves takes place during ventricular diastole, which is the interval after the "dub" and before the next "lub." Throughout the window described, ventricular pressure exceeds atrial pressure, so the mitral and tricuspid valves are held shut and passive filling cannot occur.
>
> (Choice B) Atrial contraction supplies the final \(20\) to \(30\) percent of ventricular filling and lasts about \(100\ \text{ms}\), ending as ventricular contraction begins. It therefore falls immediately before the first sound rather than between the two sounds.
>
> (Choice C) Correct. Both audible sounds arise from valve closure rather than valve opening, so they fence off the period during which the ventricles are contracting. Only the first fraction of that period is isovolumic contraction, when all four valves are shut and ventricular volume is fixed near the end diastolic volume of about \(130\ \text{mL}\). Once ventricular pressure exceeds aortic and pulmonary pressure the semilunar valves open and ejection fills the rest of the interval.
>
> (Choice D) Relaxation of the ventricles at unchanging volume is the isovolumic ventricular relaxation phase, which begins the instant the semilunar valves close. That phase therefore starts at the "dub" and lies after the interval in question; between the sounds the ventricle is contracting, not relaxing.
>
> This is a Scientific Reasoning and Problem Solving question because you must convert two auscultatory landmarks into the mechanical phase of the cardiac cycle that they bracket.

---

## Q12 — Conduction Block and Escape Rhythms

**Stem.** A complete block within the AV node prevents any impulse from leaving the node, including the node's own spontaneous discharges. The atria continue to depolarize at \(78\) beats per minute, and every conducting structure below the node is healthy. The ventricular rate will most likely be closest to:

- **A.** \(18\) beats per minute
- **B.** \(35\) beats per minute  ← **KEY**
- **C.** \(50\) beats per minute
- **D.** \(78\) beats per minute

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic medium / structural easy) |
| Estimated time | 60 s |
| Confidence | 5 |

**Correct answer (B): \(35\) beats per minute**

Citations: AP:36764-36767 'Without the SA node, the AV node would generate a heart rate of 40 to 60 beats per minute. If the AV node were blocked, the atrioventricular bundle would fire at a rate of approximately 30 to 40 impulses per minute. The bundle branches would have an inherent rate of 20 to 30 impulses per minute, and the Purkinje fibers would fire at 15 to 20 impulses per minute.' | AP:36761-36763 'The SA node, without nervous or endocrine control, would initiate a heart impulse approximately 80 to 100 times per minute ... the rate progressively slows as you proceed from the SA node to the Purkinje fibers.' | AP:36658-36660 'Arising from the AV node, the atrioventricular bundle, or bundle of His, proceeds through the interventricular septum before dividing into two atrioventricular bundle branches.' | AP:36769 'for most individuals, rates lower than 50 beats per minute would indicate a condition called bradycardia.' | AP:36928 'AV nodal blocks occur within the AV node.'

**Distractors**

- **(A)** `adjacent_fact` · _correct ladder, wrong rung (too far down)_ — 15 to 20 per minute is the Purkinje fiber rate. Purkinje fibers pace only when the atrioventricular bundle and bundle branches have also failed, but the stem states the conduction system below the node is healthy.
  - Citation: AP:36766-36767 'The bundle branches would have an inherent rate of 20 to 30 impulses per minute, and the Purkinje fibers would fire at 15 to 20 impulses per minute.'
- **(C)** `partial_truth` · _true for an SA block, not for a block that seals the AV node_ — 40 to 60 per minute is the AV node's own escape rate, which is what emerges after a total SA block leaves the node intact. Because no impulse can leave the node here, that rhythm cannot reach the ventricles.
  - Citation: AP:36938-36939 'Even in the event of a total SA block, the AV node will assume the role of pacemaker and continue initiating contractions at 40 to 60 contractions per minute.'
- **(D)** `misconception` · _ventricles must follow the atria_ — This assumes atrial impulses still reach the ventricles. In a third degree block there is no correlation between atrial activity and ventricular activity, so the ventricles cannot track the atrial rate.
  - Citation: AP:36937-36938 'In the third-degree or complete block, there is no correlation between atrial activity (the P wave) and ventricular activity (the QRS complex).'

**Readback check.** The stem supplies only the lesion site and the atrial rate. It never lists intrinsic rates, never names the atrioventricular bundle, and never states that a downstream pacemaker takes over. All four numbers are real values drawn from the pacemaker ladder or from the stated atrial rate, so no option is eliminable without the hierarchy. AUDIT: the original stem said only 'a complete block within the AV node,' which left Choice C genuinely defensible, because a block sited in the proximal node leaves AV nodal or junctional tissue below the lesion capable of pacing at 40 to 60 per minute. The stem now specifies that no impulse leaves the node, including its own spontaneous discharges, which makes the atrioventricular bundle the unambiguous escape site without naming it. Choice C's rationale and the main reasoning were reworded to match; options, key, and citations are otherwise unchanged and all four citation ranges verified correct against the file.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because with nothing escaping the AV node, the fastest surviving pacemaker below it is the atrioventricular bundle, which fires at roughly \(30\) to \(40\) impulses per minute.
>
> Every component of the conduction system can depolarize on its own, but the inherent rate falls progressively as the pathway descends toward the ventricles. Unregulated, the sinoatrial node fires about \(80\) to \(100\) times per minute, the AV node about \(40\) to \(60\), the atrioventricular bundle about \(30\) to \(40\), the bundle branches about \(20\) to \(30\), and the Purkinje fibers about \(15\) to \(20\). Because nothing can leave the node, neither the sinus impulse nor the node's own rhythm reaches the ventricles, so the first intact structure downstream takes command at its own inherent rate. The atria keep beating at \(78\) per minute with no fixed relationship to the ventricular beats, which is what defines a complete block.
>
> (Choice A) About \(15\) to \(20\) impulses per minute is the inherent rate of the Purkinje fibers, the slowest element of the ladder. Purkinje fibers assume pacemaker duty only when every faster site above them, including the atrioventricular bundle and both bundle branches, has also failed, which the stem excludes.
>
> (Choice B) Correct. The atrioventricular bundle lies immediately distal to the AV node and carries the impulse through the interventricular septum before dividing into the bundle branches. It is therefore the highest surviving pacemaker in this heart, and its inherent rate of roughly \(30\) to \(40\) per minute sets the ventricular rate. That rate falls below \(50\) per minute and so qualifies as bradycardia, a common reason an artificial pacemaker is implanted.
>
> (Choice C) About \(40\) to \(60\) beats per minute is the AV node's own inherent rate, and it is the rate observed after a total SA block leaves an intact AV node in charge. Here no impulse can leave the node, so that rhythm cannot be delivered to the ventricles and pacemaker function drops one level lower.
>
> (Choice D) A ventricular rate matching the atrial rate of \(78\) per minute would require an intact atrioventricular connection carrying each atrial impulse through to the ventricles. In a complete block, atrial and ventricular activity are dissociated, so the ventricles beat at whatever rate their own escape pacemaker generates.
>
> This is a Knowledge of Scientific Concepts and Principles question because you must recall the inherent firing rates of successive components of the cardiac conduction system and identify the fastest one lying below the lesion.

---

## Q13 — Isovolumic Contraction

**Stem.** During left heart catheterization, simultaneous pressures read left ventricle \(15\ \text{mmHg}\) and rising, left atrium \(10\ \text{mmHg}\), and aorta \(78\ \text{mmHg}\). The next valve event on this side of the heart will most likely be:

- **A.** opening of the aortic valve  ← **KEY**
- **B.** closure of the mitral valve
- **C.** opening of the mitral valve
- **D.** closure of the aortic valve

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 80 s |
| Confidence | 5 |

**Correct answer (A): opening of the aortic valve**

Citations: AP:37023-37028 'as the muscles in the ventricle contract, the pressure of the blood within the chamber rises, but it is not yet high enough to open the semilunar (pulmonary and aortic) valves ... This increase in pressure causes blood to flow back toward the atria, closing the tricuspid and mitral valves ... this initial phase of ventricular systole is known as isovolumic contraction.' | AP:37031-37033 'the contraction of the ventricular muscle has raised the pressure within the ventricle to the point that it is greater than the pressures in the pulmonary trunk and the aorta. Blood is pumped from the heart, pushing open the pulmonary and aortic semilunar valves.' | AP:37020-37021 'the ventricles contain approximately 130 mL blood ... known as the end diastolic volume (EDV) or preload.' | AP:37036-37038 'Stroke volume will normally be in the range of 70 to 80 mL ... there is still 50 to 60 mL of blood remaining in the ventricle ... known as the end systolic volume (ESV).'

**Distractors**

- **(B)** `process_step_confusion` · _event that has already happened_ — Mitral closure occurred earlier, when ventricular pressure first rose above atrial pressure. The data already show ventricular pressure above atrial pressure, so this event is behind, not ahead.
  - Citation: AP:37025-37026 'This increase in pressure causes blood to flow back toward the atria, closing the tricuspid and mitral valves.'
- **(C)** `partial_truth` · _correct only if ventricular pressure were falling_ — The mitral valve opens when ventricular pressure drops below atrial pressure in late ventricular diastole. Here ventricular pressure is rising, so that crossing is not the next one to occur.
  - Citation: AP:37054-37055 'pressure on the blood within the ventricles drops even further. Eventually, it drops below the pressure in the atria. When this occurs, blood flows from the atria into the ventricles, pushing open the tricuspid and mitral valves.'
- **(D)** `reversed_relationship` · _right valve, wrong direction of the gradient change_ — Aortic closure demands that ventricular pressure fall below aortic pressure, which is the reverse of the trend recorded. That closure marks the end of the previous ejection and the start of isovolumic relaxation.
  - Citation: AP:37046-37048 'When pressure within the ventricles drops below pressure in both the pulmonary trunk and aorta ... The semilunar valves close to prevent backflow into the heart.'

**Readback check.** The stem gives three raw pressure values and a direction of change. It never names a phase, never states which valves are open or shut, and never mentions the aortic valve. The key repeats no distinctive stem wording, and every choice names a real valve event on the left side of the heart. AUDIT: no readback, scope, accuracy, or ambiguity defect found. The four options form a clean valve by direction grid, so each distractor differs from the key in exactly one variable. Three citation ranges were off by one to three lines and were corrected against the file (37024-37029 to 37023-37028; 37026-37028 to 37025-37026; 37054-37057 to 37054-37055; 37046-37049 to 37046-37048). Stem, options, key, and explanation prose otherwise unchanged.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because the ventricle is already sealed at both ends and its pressure is climbing, so the next boundary it crosses is the aortic pressure that is holding the aortic valve shut.
>
> Heart valves are passive and follow the pressure gradient across them. Left ventricular pressure of \(15\ \text{mmHg}\) already exceeds left atrial pressure of \(10\ \text{mmHg}\), so blood has been pushed back toward the atrium and the mitral valve is shut. That same ventricular pressure is far below the aortic pressure of \(78\ \text{mmHg}\), so the aortic valve is also shut. With both valves closed and the muscle contracting, no blood can leave and ventricular volume is fixed near the end diastolic volume of about \(130\ \text{mL}\), which is the isovolumic contraction phase. Contraction continues to raise pressure, and once it passes \(78\ \text{mmHg}\) the aortic valve is pushed open and ejection begins.
>
> (Choice A) Correct. The aortic valve opens the moment ventricular pressure exceeds aortic pressure, converting isovolumic contraction into the ejection phase. Roughly \(70\) to \(80\ \text{mL}\) is then expelled, leaving an end systolic volume of about \(50\) to \(60\ \text{mL}\).
>
> (Choice B) Mitral closure has already occurred. It happens the instant ventricular pressure rises above atrial pressure, and the recorded values show that crossing has already taken place, which is also what generated the first heart sound.
>
> (Choice C) The mitral valve reopens only when ventricular pressure falls back below atrial pressure, which happens in late ventricular diastole after the ventricle has relaxed. The tracing shows ventricular pressure rising, not falling, so this event lies at the far end of the cycle.
>
> (Choice D) Closure of the aortic valve requires ventricular pressure to drop below aortic pressure, the opposite of the change under way. That crossing already occurred at the end of the previous ejection, and the valve cannot close again before it has opened.
>
> This is a Scientific Reasoning and Problem Solving question because you must convert a set of simultaneous pressure values into valve positions and then predict the next gradient reversal.

---

## Q14 — Purkinje Activation Sequence

**Stem.** In an isolated perfused heart, the ventricles are stimulated at the base near the atrioventricular septum instead of through the bundle branches and Purkinje network. Heart rate, the delay between atrial and ventricular contraction, and total ventricular activation time are unchanged. Compared with normal activation, this arrangement most likely produces:

- **A.** less complete emptying of the atria
- **B.** less complete filling of the ventricles
- **C.** less complete closure of the semilunar valves
- **D.** less complete emptying of the ventricles  ← **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 85 s |
| Confidence | 4 |

**Correct answer (D): less complete emptying of the ventricles**

Citations: AP:36670-36672 'Both bundle branches descend and reach the apex of the heart where they connect with the Purkinje fibers ... This passage takes approximately 25 ms.' | AP:36674-36680 'The Purkinje fibers are additional myocardial conductive fibers that spread the impulse to the myocardial contractile cells in the ventricles. They extend throughout the myocardium from the apex of the heart toward the atrioventricular septum and the base of the heart ... Since the electrical stimulus begins at the apex, the contraction also begins at the apex and travels toward the base of the heart, similar to squeezing a tube of toothpaste from the bottom. This allows the blood to be pumped out of the ventricles and into the aorta and pulmonary trunk.' | AP:36638 'The electrical event, the wave of depolarization, is the trigger for muscular contraction.' | BIO:53809-53810 'the Purkinje fibers conduct the impulse from the apex of the heart up the ventricular myocardium, and then the ventricles contract.'

**Distractors**

- **(A)** `process_step_confusion` · _attributes a ventricular change to the AV nodal step_ — Atrial emptying is protected by the AV nodal delay, an upstream step the stem holds unchanged. Changing where the ventricles are stimulated cannot shorten the time the atria have to contract.
  - Citation: AP:36650-36652 'This pause is critical to heart function, as it allows the atrial cardiomyocytes to complete their contraction that pumps blood into the ventricles before the impulse is transmitted to the cells of the ventricle itself.'
- **(B)** `misconception` · _confuses emptying with filling_ — Filling is set by the duration of diastole, by venous return, and by atrial contraction. The activation sequence determines how blood leaves the ventricle, not how it enters.
  - Citation: AP:37003-37004 'The two atrioventricular valves ... are both open, so blood flows unimpeded from the atria and into the ventricles. Approximately 70 to 80 percent of ventricular filling occurs by this method.'
- **(C)** `adjacent_fact` · _real valve behavior governed by a different variable_ — Semilunar valves close when ventricular pressure falls below great artery pressure. Their sealing is a pressure phenomenon and is independent of the geographic origin of the depolarization wave.
  - Citation: AP:37046-37048 'When pressure within the ventricles drops below pressure in both the pulmonary trunk and aorta ... The semilunar valves close to prevent backflow into the heart.'

**Readback check.** The stem states only where stimulation begins and which variables are controlled. It never mentions the apex to base direction of normal contraction, never mentions ejection efficiency, and never states any consequence. Two choices reference the ventricles, so no distinctive echo distinguishes the key, and all four name real cardiac events. AUDIT: the original control clause held 'filling pressures' constant, which let a student eliminate Choice B on the stem alone without any knowledge of the conduction system, badly weakening the item. The clause was replaced with 'heart rate, the delay between atrial and ventricular contraction, and total ventricular activation time are unchanged.' The atrial to ventricular delay had to be added because direct base stimulation would otherwise plausibly truncate atrial contraction and make Choice A defensible; eliminating A now requires knowing that the AV nodal pause protects atrial emptying, which is topic knowledge rather than free elimination. The Choice A and Choice B explanation blocks were rewritten to match, and two citation ranges were corrected (36653-36655 to 36650-36652 for the AV pause quote, which the draft had misattributed by three lines; 36637-36639 to 36638; 37046-37049 to 37046-37048).

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because normal ventricular contraction begins at the apex and sweeps upward toward the outflow valves, and reversing that direction drives blood away from the valves instead of through them.
>
> Both bundle branches descend through the interventricular septum all the way to the apex before connecting with the Purkinje fibers, which then spread the impulse from the apex back up toward the base. Because depolarization triggers contraction, the ventricular walls squeeze from the bottom upward, comparable to squeezing a tube of toothpaste from its closed end, and this directs blood toward the aortic and pulmonary openings at the base. Stimulating at the base first inverts that wringing motion, so the outflow region tightens before the apex does and blood is driven toward the apical dead end. The result is a larger residual volume left behind after contraction, meaning a higher end systolic volume and a smaller stroke volume.
>
> (Choice A) Atrial emptying is protected by the roughly \(100\ \text{ms}\) pause at the AV node, which gives the atria time to finish contracting before the ventricles are activated. The stem holds that atrial to ventricular delay unchanged, and where ventricular activation begins cannot shorten the time available for the atria to empty.
>
> (Choice B) Ventricular filling is set by the duration of diastole, which follows from the unchanged heart rate, and by the pressure gradient from atria to ventricles. Roughly \(70\) to \(80\) percent of that filling is passive and the remaining \(20\) to \(30\) percent comes from atrial contraction, neither of which depends on where ventricular activation starts.
>
> (Choice C) Semilunar valve closure is driven by the reversal of the pressure gradient between the ventricle and the great artery during ventricular relaxation. The valve leaflets seal according to that gradient, not according to the direction in which the depolarization wave travelled.
>
> (Choice D) Correct. Apical origin of contraction is the reason ventricular emptying is efficient, and it is a direct consequence of the anatomy of the bundle branches and the Purkinje network. With activation reversed, the apex contracts last and the blood it holds has already lost its exit path, so ejection is incomplete even though total activation time is unchanged.
>
> This is a Scientific Reasoning and Problem Solving question because you must connect the anatomical route of the conduction system to the mechanical direction of ventricular contraction and predict its effect on ejection.

---

## Q15 — Atrial Systole and Ventricular Filling

**Stem.** A patient develops atrial fibrillation, so the atrial myocardium no longer contracts as a coordinated unit. Ventricular activation, venous filling pressures, and heart rate are unchanged at \(72\) beats per minute. End diastolic volume will most likely fall by approximately:

- **A.** \(0\) to \(5\) percent
- **B.** \(20\) to \(30\) percent  ← **KEY**
- **C.** \(45\) to \(55\) percent
- **D.** \(70\) to \(80\) percent

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 75 s |
| Confidence | 5 |

**Correct answer (B): \(20\) to \(30\) percent**

Citations: AP:37012-37014 'At the start of atrial systole, the ventricles are normally filled with approximately 70 to 80 percent of their capacity due to inflow during diastole. Atrial contraction, also referred to as the "atrial kick," contributes the remaining 20 to 30 percent of filling.' | AP:37003-37004 'The two atrioventricular valves, the tricuspid and mitral valves, are both open, so blood flows unimpeded from the atria and into the ventricles. Approximately 70 to 80 percent of ventricular filling occurs by this method.' | AP:37582-37584 'the contraction of the atria, the atrial kick, plays a crucial role by providing the last 20 to 30 percent of ventricular filling.' | AP:37020-37021 'the ventricles contain approximately 130 mL blood in a resting adult in a standing position. This volume is known as the end diastolic volume (EDV) or preload.' | AP:36856-36857 'it may lead to either an arrhythmia, a deviation from the normal pattern of impulse conduction and contraction, or to fibrillation, an uncoordinated beating of the heart.'

**Distractors**

- **(A)** `misconception` · _atrial contraction is dispensable_ — Treating the atrial contribution as negligible ignores that it supplies the final 20 to 30 percent of ventricular filling. Losing it measurably reduces preload and therefore reduces ventricular stretch before contraction.
  - Citation: AP:37582-37584 'While much of the ventricular filling occurs while both atria and ventricles are in diastole, the contraction of the atria, the atrial kick, plays a crucial role by providing the last 20 to 30 percent of ventricular filling.'
- **(C)** `scale_unit_error` · _assumes atria and passive flow contribute equally_ — This treats the atria as supplying half of ventricular volume. Passive flow across the open atrioventricular valves already delivers roughly three quarters of the total before the atria contract at all.
  - Citation: AP:37004 'Approximately 70 to 80 percent of ventricular filling occurs by this method.'
- **(D)** `reversed_relationship` · _swaps the passive and active filling shares_ — 70 to 80 percent is the passive contribution, which is preserved here because venous pressures and diastolic time are unchanged. Assigning that share to atrial contraction inverts the two components.
  - Citation: AP:37012-37013 'At the start of atrial systole, the ventricles are normally filled with approximately 70 to 80 percent of their capacity due to inflow during diastole. Atrial contraction ... contributes the remaining 20 to 30 percent of filling.'

**Readback check.** The stem states only that atrial contraction is lost and that other determinants are held constant. It gives no filling percentages, no volumes, and no hint of magnitude. The key is a number the student must supply from knowledge of how ventricular filling is partitioned, and the largest distractor is the complementary share, so guessing by size fails. AUDIT: arithmetic error corrected in the main reasoning, where 130 mL reduced by 20 to 30 percent was stated as '95 to 105 mL' rather than the correct 90 to 105 mL. Choice A's supporting citation was swapped off AP:37602-37605, which frames the atrial kick through parasympathetic stimulation and so brushes the forbidden Biology Ch5 and Ch4 territory, onto AP:37582-37584, which makes the same point with no autonomic content; the Choice A prose was reworded to drop the autonomic framing while keeping the preload consequence, which is Ch7 material. The fibrillation citation was corrected from AP:36858-36859 to AP:36856-36857. Stem, options, and key unchanged.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because coordinated atrial contraction supplies only the final increment of ventricular filling, an increment of roughly \(20\) to \(30\) percent.
>
> While both chambers are relaxed, blood moves from the great veins through the atria and across the open atrioventricular valves into the ventricles purely down its pressure gradient, and this passive route accounts for about \(70\) to \(80\) percent of ventricular filling. Atrial systole then adds the last portion, the atrial kick, worth about \(20\) to \(30\) percent. Losing organized atrial contraction removes that increment alone, so a normal end diastolic volume near \(130\ \text{mL}\) drops to roughly \(90\) to \(105\ \text{mL}\). The passive component persists because venous filling pressures and diastolic duration are unchanged.
>
> (Choice A) A negligible drop would mean atrial contraction contributes essentially nothing to ventricular filling. Atrial contraction is in fact a measurable contributor, and losing it lowers preload enough to reduce the stretch on the ventricular wall before it contracts, which in turn reduces the force of that contraction.
>
> (Choice B) Correct. The atria act as booster pumps that top off a ventricle already about three quarters full. Because the lost increment is the final \(20\) to \(30\) percent, the drop in end diastolic volume matches that fraction, and the effect is felt most when diastole is short and passive filling is least complete.
>
> (Choice C) A halving of end diastolic volume would require the atria and the passive route to contribute about equally. The atria are thin walled reservoirs whose contraction supplements venous pressure rather than matching it, and passive inflow has already delivered roughly three quarters of the total before they contract.
>
> (Choice D) A drop of \(70\) to \(80\) percent is the size of the passive contribution, not the atrial one. Choosing it swaps the two shares, and a ventricle filling to only about a quarter of normal would not sustain circulation at all.
>
> This is a Scientific Reasoning and Problem Solving question because you must partition ventricular filling into its passive and active components and quantify the loss of one of them.

---

## Q16 — Accessory Atrioventricular Conduction

**Stem.** A patient has an extra strand of conducting tissue that crosses the cardiac skeleton and joins the right atrium directly to the right ventricle. During an episode of rapid atrial arrhythmia, the atria depolarize \(300\) times per minute. Compared with a person whose only atrioventricular connection is the AV node, this patient will most likely show:

- **A.** a higher ventricular rate and a higher stroke volume
- **B.** an unchanged ventricular rate and a lower stroke volume
- **C.** a higher ventricular rate and a lower stroke volume  ← **KEY**
- **D.** an unchanged ventricular rate and a higher stroke volume

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic hard / structural hard) |
| Estimated time | 110 s |
| Confidence | 5 |
| Hard-tier gate | Meets (1) CONCEPT CHAINING: requires linking the cardiac skeleton as an electrical insulator, the AV node's maximum transmission rate of about 220 per minute, and the inverse relationship between very high rate and diastolic filling time. Meets (3) TRUE PARTIAL-TRUTH TRAP: Choice B is exactly correct if the accessory strand has a long refractory period and does not conduct during the arrhythmia, which is a real clinical circumstance. Meets (4) 510-TEMPTING DISTRACTOR: Choice B is where a student lands after correctly reasoning that fast rates lower stroke volume but failing to recognize that the AV node no longer gates ventricular rate. Gate verified: three of four conditions genuinely met, hard tier upheld. |

**Correct answer (C): a higher ventricular rate and a lower stroke volume**

Citations: AP:36615-36616 'as the impulse reaches the atrioventricular septum, the connective tissue of the cardiac skeleton prevents the impulse from spreading into the myocardial cells in the ventricles except at the atrioventricular node.' | AP:36645-36646 'The septum prevents the impulse from spreading directly to the ventricles without passing through the AV node.' | AP:36649-36655 'it takes the impulse approximately 100 ms to pass through the node ... With extreme stimulation by the SA node, the AV node can transmit impulses maximally at 220 per minute. This establishes the typical maximum heart rate in a healthy young individual. Damaged hearts or those stimulated by drugs can contract at higher rates, but at these rates, the heart can no longer effectively pump blood.' | AP:37019 'It may be conveniently divided into two phases, lasting a total of 270 ms.' | AP:37036 'Stroke volume will normally be in the range of 70 to 80 mL.' | AP:37020-37021 'the ventricles contain approximately 130 mL blood ... known as the end diastolic volume (EDV) or preload.'

**Distractors**

- **(A)** `reversed_relationship` · _faster heart equals more output per beat_ — Very high rates truncate diastole, the interval during which the ventricle fills, so end diastolic volume and stroke volume both fall. The relationship between extreme rate and per beat output is inverse, not direct.
  - Citation: AP:36654-36655 'Damaged hearts or those stimulated by drugs can contract at higher rates, but at these rates, the heart can no longer effectively pump blood.'
- **(B)** `partial_truth` · _correct if the accessory strand did not conduct_ — This keeps the AV node as the gatekeeper of ventricular rate, which is true only when no functioning accessory connection exists. With a strand crossing the cardiac skeleton, atrial impulses reach the ventricles without passing through the node.
  - Citation: AP:36615-36616 'as the impulse reaches the atrioventricular septum, the connective tissue of the cardiac skeleton prevents the impulse from spreading into the myocardial cells in the ventricles except at the atrioventricular node.'
- **(D)** `misconception` · _predicts improved filling from an added conduction path_ — An accessory conduction strand adds an electrical route; it does not increase venous return, contractility, or the duration of diastole. Nothing in the scenario would raise the volume ejected per beat.
  - Citation: AP:37582-37584 'While much of the ventricular filling occurs while both atria and ventricles are in diastole, the contraction of the atria, the atrial kick, plays a crucial role by providing the last 20 to 30 percent of ventricular filling.'

**Readback check.** The stem describes an anatomical connection and an atrial rate. It never states that the AV node limits transmission rate, never gives a ventricular rate, and never mentions filling time or stroke volume determinants. The key repeats no distinctive stem wording, and every option is a real combination of hemodynamic outcomes, so both halves must be reasoned independently. AUDIT: distractor categories reassigned. Choice A was tagged misconception but its actual defect is inverting the true inverse relationship between extreme rate and stroke volume, so it is now reversed_relationship; Choice D, which predicts that an added electrical route improves pumping, is now misconception. Choice D's citation was swapped off AP:37020-37021, which states the normal EDV and does not support the claim about venous return, onto AP:37582-37584, which grounds filling in diastolic duration. One citation range was corrected (36644-36646 to 36645-36646). Note that Choice D differs from the key in both variables; this is the intended double negative corner of a two by two outcome grid, and Choices A and B each differ from the key in exactly one variable, so the single variable rule is satisfied. Stem, options, and key unchanged.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because the accessory strand removes the AV node's rate limiting gate, letting far more atrial impulses reach the ventricles, and the resulting very short cycles leave almost no time for filling.
>
> The connective tissue of the cardiac skeleton normally insulates the ventricles so that the AV node is the sole electrical doorway between atria and ventricles. That doorway is deliberately slow: the impulse needs about \(100\ \text{ms}\) to cross the node, and even under maximal drive the node can pass no more than about \(220\) impulses per minute. At an atrial rate of \(300\) per minute, a normal AV node therefore fails to conduct a substantial share of the impulses and the ventricular rate stays well below the atrial rate. A strand that crosses the cardiac skeleton bypasses this filter, so the ventricles are driven at a much higher rate; near \(300\) beats per minute each cycle lasts only about \(200\ \text{ms}\), which is shorter than a normal ventricular systole of \(270\ \text{ms}\), so diastolic filling time collapses, end diastolic volume falls far below \(130\ \text{mL}\), and stroke volume falls well below the usual \(70\) to \(80\ \text{mL}\).
>
> (Choice A) A rising stroke volume would require more blood in the ventricle at the start of each contraction. Extremely rapid rates shorten diastole, which is when the ventricle fills, so preload and therefore stroke volume both fall even though the rate climbs.
>
> (Choice B) This is what would be seen if the accessory strand failed to conduct during the arrhythmia, leaving the AV node in charge of the ventricular rate. The stem specifies a functioning direct atrial to ventricular connection, so the node no longer determines how many impulses reach the ventricles.
>
> (Choice C) Correct. The AV node's slow conduction is protective as well as mechanical: it both times ventricular contraction to follow atrial emptying and caps how fast the ventricles can be driven from above. Removing that cap allows atrial rates that far exceed the ceiling of about \(220\) per minute to reach the ventricles, and at such rates the heart can no longer pump blood effectively.
>
> (Choice D) An unchanged rate with a larger stroke volume would describe a heart that is filling better, which nothing in the scenario supports. Neither venous return nor the duration of diastole is altered by adding an electrical route, so there is no basis for a larger volume ejected per beat.
>
> This is a Scientific Reasoning and Problem Solving question because you must combine the insulating role of the cardiac skeleton, the rate ceiling imposed by AV nodal conduction, and the dependence of stroke volume on diastolic filling time.

---

## Q17 — Conduction Timing and the ECG

**Stem.** The table lists the time required for the cardiac impulse to cross each segment of the conduction system in a healthy adult and in a patient being evaluated for exertional fatigue.

| Segment | Healthy adult | Patient |
| --- | --- | --- |
| SA node to AV node | \(50\ \text{ms}\) | \(52\ \text{ms}\) |
| Through the AV node | \(100\ \text{ms}\) | \(104\ \text{ms}\) |
| AV bundle and bundle branches | \(25\ \text{ms}\) | \(27\ \text{ms}\) |
| Purkinje network to all ventricular muscle | \(75\ \text{ms}\) | \(196\ \text{ms}\) |

Which ECG finding is most consistent with the patient's data?

- **A.** a widened QRS complex with a normal PR interval  ← **KEY**
- **B.** a widened QRS complex with a prolonged PR interval
- **C.** a normal QRS complex with a prolonged PR interval
- **D.** a normal QRS complex with a normal PR interval

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic hard / structural hard) |
| Estimated time | 120 s |
| Confidence | 5 |
| Hard-tier gate | Meets (1) CONCEPT CHAINING: requires knowing the anatomical order of the conduction segments, the electrical boundaries of the PR interval, and what the QRS complex records, then combining all three. Meets (2) DATA-TO-MECHANISM: the student cannot read the answer off any single cell; the segments must be summed and assigned to the correct ECG interval before an ECG prediction can be made. Meets (4) 510-TEMPTING DISTRACTOR: Choice B is where a well prepared student lands after correctly noticing that total conduction time is markedly prolonged but failing to localize the excess to the ventricular segment alone. Gate verified: three of four conditions genuinely met, hard tier upheld. |

**Correct answer (A): a widened QRS complex with a normal PR interval**

Citations: AP:36610 'The impulse takes approximately 50 ms (milliseconds) to travel between these two nodes.' | AP:36649-36650 'These factors mean that it takes the impulse approximately 100 ms to pass through the node.' | AP:36670-36672 'Both bundle branches descend and reach the apex of the heart where they connect with the Purkinje fibers ... This passage takes approximately 25 ms.' | AP:36676-36677 'The Purkinje fibers have a fast inherent conduction rate, and the electrical impulse reaches all of the ventricular muscle cells in about 75 ms.' | AP:36803-36806 'The small P wave represents the depolarization of the atria ... The large QRS complex represents the depolarization of the ventricles.' | AP:36812-36816 'The PR interval starts at the beginning of the P wave and ends with the beginning of the QRS complex ... Should there be a delay in passage of the impulse from the SA node to the AV node, it would be visible in the PR interval.' | AP:36933-36934 'A first-degree or partial block indicates a delay in conduction between the SA and AV nodes. This can be recognized on the ECG as an abnormally long PR interval.'

**Distractors**

- **(B)** `partial_truth` · _correct on QRS, wrong on PR_ — Total conduction time is prolonged, but the three segments contained inside the PR interval add only 8 ms of excess relative to the healthy adult. Only the ventricular activation segment is materially abnormal, so the PR interval is effectively unaffected.
  - Citation: AP:36812-36815 'The PR interval starts at the beginning of the P wave and ends with the beginning of the QRS complex. The PR interval is more clinically relevant, as it measures the duration from the beginning of atrial depolarization (the P wave) to the initiation of the QRS complex.'
- **(C)** `reversed_relationship` · _assigns the delay to the wrong ECG interval_ — A long PR interval with a normal QRS reflects delay between the SA and AV nodes, which the data exclude. The recorded excess lies entirely below the bundle branches, in the Purkinje to myocardium step.
  - Citation: AP:36933-36934 'A first-degree or partial block indicates a delay in conduction between the SA and AV nodes. This can be recognized on the ECG as an abnormally long PR interval.'
- **(D)** `misconception` · _treats QRS width as independent of ventricular activation time_ — The QRS complex is the surface recording of ventricular depolarization, so its duration tracks how long that depolarization takes. A ventricular activation time of 196 ms is incompatible with a normal width complex.
  - Citation: AP:36805-36806 'The large QRS complex represents the depolarization of the ventricles, which requires a much stronger electrical signal because of the larger size of the ventricular cardiac muscle.'

**Readback check.** The table supplies raw timing values only. It never names an ECG interval, never states which segments the PR interval spans, and never states that the QRS records ventricular depolarization. Answering requires mapping the anatomy onto the waveform, and the arithmetic alone gives no hint about which interval widens. AUDIT: the explanation twice asserted that the patient's PR interval falls 'within normal limits,' a claim that depends on absolute reference values (roughly 120 to 200 ms) that OpenStax never states. Both instances were rewritten to argue relative to the healthy adult column, which the table does supply and which is how the item is meant to be solved. The citation to AP:36929-36930 on bundle branch blocks was dropped because the data localize the delay below the bundle branches, so citing it invited a misreading of the case as a bundle branch block. Three citation ranges were tightened to the exact supporting lines. Stem, table, options, and key unchanged. Noted for the record: the healthy column sums to 250 ms while AP:36680-36681 gives a total of about 225 ms, an internal inconsistency in OpenStax itself; the item never asks for a total and never cites the 225 ms figure, so no student path touches the discrepancy.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because every segment that lies inside the PR interval is nearly identical to the healthy adult, while the ventricular spread that the QRS complex records is roughly two and a half times longer than normal.
>
> The PR interval runs from the beginning of atrial depolarization to the beginning of the QRS complex, so it contains the internodal travel, the AV nodal pause, and passage through the atrioventricular bundle and branches. In this patient those three segments sum to \(52 + 104 + 27 = 183\ \text{ms}\) against \(50 + 100 + 25 = 175\ \text{ms}\) in the healthy adult, an excess of only \(8\ \text{ms}\), far too small to register as a prolonged PR interval. The QRS complex represents depolarization of the ventricles themselves, which is the Purkinje to myocardium segment, and that value rises from \(75\ \text{ms}\) to \(196\ \text{ms}\). Essentially all of the added \(129\ \text{ms}\) of total conduction time sits in that one ventricular step, so the tracing shows a wide QRS complex behind a PR interval that is effectively unchanged.
>
> (Choice A) Correct. Because the QRS waveform is the electrical signature of ventricular depolarization, its width scales directly with how long that depolarization takes. A Purkinje network conducting this slowly also activates the ventricular walls out of step with one another, which reduces the efficiency of ejection and fits the reported exertional fatigue.
>
> (Choice B) The patient's total conduction time is clearly prolonged, which makes it tempting to lengthen both intervals. However, the values localize almost the entire excess to the ventricular step; the three segments that fall inside the PR interval are prolonged by only \(8\ \text{ms}\) combined, a change too small to lengthen that interval appreciably.
>
> (Choice C) A prolonged PR interval with a normal QRS complex reverses which segments are abnormal. That pattern arises when conduction between the SA and AV nodes is delayed, as in a first degree block, and it is inconsistent with a nearly normal AV nodal time paired with a grossly prolonged ventricular activation time.
>
> (Choice D) Reading both intervals as normal ignores that the QRS complex is the direct recording of ventricular depolarization. A ventricular activation time of \(196\ \text{ms}\) cannot be contained within a normal width QRS complex.
>
> This is a Data-based and Statistical Reasoning question because you must map segment by segment timing values onto the ECG intervals that record them and determine which interval the abnormality falls inside.

---

## Q18 — Pacemaker Hierarchy

**Stem.** Sinus node disease slows a patient's SA node to \(25\) impulses per minute. Every other component of the conduction system is healthy and retains its normal inherent firing rate. The ventricular rate and the structure setting it will most likely be:

- **A.** \(25\) beats per minute, set by the SA node
- **B.** \(25\) beats per minute, set by the AV node
- **C.** \(30\) to \(40\) beats per minute, set by the atrioventricular bundle
- **D.** \(40\) to \(60\) beats per minute, set by the AV node  ← **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic hard / structural hard) |
| Estimated time | 105 s |
| Confidence | 5 |
| Hard-tier gate | Meets (1) CONCEPT CHAINING: requires the fastest pacemaker capture rule, recall of the AV node's inherent rate of 40 to 60 per minute, and the recognition that SA dominance is a consequence of rate rather than anatomy, chained together. Meets (3) TRUE PARTIAL-TRUTH TRAP: Choice A is exactly correct whenever the sinus rate exceeds the subsidiary pacemakers' inherent rates, which is the case in every healthy heart. Meets (4) 510-TEMPTING DISTRACTOR: Choice A is where a well prepared student lands after correctly reading that the SA node is still firing and assuming that a functioning SA node always drives the heart. Gate verified: three of four conditions genuinely met, hard tier upheld. |

**Correct answer (D): \(40\) to \(60\) beats per minute, set by the AV node**

Citations: AP:36587-36589 'When two independently beating embryonic cardiac muscle cells are placed together, the cell with the higher inherent rate sets the pace, and the impulse spreads from the faster to the slower cell to trigger a contraction. As more cells are joined together, the fastest cell continues to assume control of the rate.' | AP:36602-36604 'Normal cardiac rhythm is established by the sinoatrial (SA) node ... The SA node has the highest inherent rate of depolarization and is known as the pacemaker of the heart.' | AP:36759-36764 'Since the SA node is the pacemaker, it reaches threshold faster than any other component of the conduction system ... The SA node, without nervous or endocrine control, would initiate a heart impulse approximately 80 to 100 times per minute ... Without the SA node, the AV node would generate a heart rate of 40 to 60 beats per minute.' | AP:36938-36939 'Even in the event of a total SA block, the AV node will assume the role of pacemaker and continue initiating contractions at 40 to 60 contractions per minute, which is adequate to maintain consciousness.' | AP:36942 'the heart maintains a junctional rhythm, which originates in the AV node.'

**Distractors**

- **(A)** `partial_truth` · _correct whenever the sinus rate exceeds the subsidiary inherent rates_ — A functioning SA node drives the heart only while it reaches threshold before any other site. At 25 per minute it is far slower than a healthy AV node, so it is outpaced and loses control of the rhythm.
  - Citation: AP:36587-36589 'the cell with the higher inherent rate sets the pace, and the impulse spreads from the faster to the slower cell to trigger a contraction ... the fastest cell continues to assume control of the rate.'
- **(B)** `process_step_confusion` · _right pacemaker site, rate borrowed from the wrong source_ — A pacemaker that is not being captured from above fires at its own inherent rate, not at the rate of a slower upstream site. An AV node driving the heart therefore beats in the 40 to 60 per minute range.
  - Citation: AP:36764 'Without the SA node, the AV node would generate a heart rate of 40 to 60 beats per minute.'
- **(C)** `adjacent_fact` · _correct ladder rung, one level too low_ — 30 to 40 per minute belongs to the atrioventricular bundle, which pacemakes only if the AV node is also out of action. The stem states that every component other than the SA node is healthy.
  - Citation: AP:36764-36765 'If the AV node were blocked, the atrioventricular bundle would fire at a rate of approximately 30 to 40 impulses per minute.'

**Readback check.** The stem gives only the diseased sinus rate and a statement that the rest of the system is healthy. It never supplies the AV node's inherent rate, never states that a subsidiary pacemaker can take over, and never mentions junctional rhythm. The key's rate must be recalled independently, and the stem's own number appears in two distractors, so pattern matching on the stem misleads rather than helps. AUDIT: accuracy defect fixed. The original stem set the diseased sinus rate at 45 per minute, which sits inside the AV node's own inherent range of 40 to 60, so the key was not unambiguously correct; a sinus node at 45 can easily outpace an AV node at 42, and the keyed answer range even contained the stem's own number. The sinus rate was lowered to 25 per minute, which is below every inherent rate offered and collides with no distractor range, making the AV node the unambiguous winner of the capture race. Choices A and B were renumbered to 25, and the main reasoning plus the Choice A block were reworded accordingly ('reaches threshold first every cycle' replaces the hedged 'on most cycles,' which was only necessary because of the original overlap). Two citation ranges were widened to include the exact supporting sentence. Key, option order, and hard tier unchanged.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because pacemaker dominance goes to whichever coupled site reaches threshold first, and a diseased SA node at \(25\) per minute is now far slower than the healthy AV node's inherent rate of \(40\) to \(60\) per minute.
>
> When conducting elements are electrically joined, the one with the higher inherent rate sets the pace and its impulse spreads outward to capture the slower ones. The SA node normally holds that position because it has the highest inherent rate of depolarization, firing about \(80\) to \(100\) times per minute without nervous or endocrine input. That title is earned by rate, not granted by anatomy, so when disease drops the sinus rate to \(25\) while the AV node still depolarizes spontaneously in its usual \(40\) to \(60\) per minute range, the AV node reaches threshold first every cycle and captures the ventricles. The result is a junctional rhythm, a rhythm originating in the AV node, conducted normally through the atrioventricular bundle, bundle branches, and Purkinje fibers.
>
> (Choice A) A sinus driven rate of \(25\) per minute is exactly what would occur if the sinus rate still exceeded every other site's inherent rate, which is the ordinary situation in a healthy heart. Once the sinus rate falls below a subsidiary pacemaker's rate, the SA node can no longer capture the rest of the system before that pacemaker fires on its own.
>
> (Choice B) This pairs the correct pacemaker with the wrong rate. A site that has been captured from above beats at the rate imposed on it, but an AV node acting as the pacemaker is by definition not being captured, so it beats at its own inherent rate rather than at the sinus rate.
>
> (Choice C) About \(30\) to \(40\) per minute is the inherent rate of the atrioventricular bundle, the next rung below the AV node. That rung takes command only when the AV node itself is blocked or diseased, and the stem specifies that every element other than the SA node is healthy.
>
> (Choice D) Correct. Because the AV node's inherent rate of \(40\) to \(60\) per minute is adequate to maintain consciousness, patients whose sinus node fails often remain functional on a junctional rhythm. The conduction path below the AV node is unaffected, so the impulse still reaches the ventricles through the atrioventricular bundle and Purkinje network in the usual sequence.
>
> This is a Scientific Reasoning and Problem Solving question because you must apply the rule that the fastest coupled pacemaker captures the rest of the conduction system and determine which site now wins that race.

---

## Q19 — Cardiac Output Calculation

**Stem.** A resting adult has a stroke volume of \(70\ \text{mL}\) at a heart rate of \(75\ \text{bpm}\). During a febrile illness her heart rate rises to \(100\ \text{bpm}\) while her stroke volume falls to \(60\ \text{mL}\). Which value best approximates her cardiac output during the fever?

- **A.** \(4.2\ \text{L/min}\)
- **B.** \(5.25\ \text{L/min}\)
- **C.** \(6.0\ \text{L/min}\)  ← **KEY**
- **D.** \(7.0\ \text{L/min}\)

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic easy / structural easy) |
| Estimated time | 65 s |
| Confidence | 5 |

**Correct answer (C): \(6.0\ \text{L/min}\)**

Citations: openstax-anatomy-physiology-2e.txt:37145 'CO = HR × SV' (VERIFIED verbatim); :37139 heading 'Resting Cardiac Output' with :37141 'multiply stroke volume (SV), the amount of blood pumped by each ventricle, by heart rate (HR)' (VERIFIED); :37149 'A mean SV for a resting 70-kg (150-lb) individual would be approximately 70 mL' (VERIFIED); :37152 'An average resting HR would be approximately 75 bpm' (VERIFIED); :37163 'Using these numbers, the mean CO is 5.25 L/min, with a range of 4.0 to 8.0 L/min' (VERIFIED; source prints the range with a dash, transcribed here with 'to'); :37549 'the more rapidly the heart contracts, the shorter the filling time becomes, and the lower the EDV and preload are' (VERIFIED); openstax-biology-2e.txt:54026 'Cardiac output is the volume of blood pumped by the heart in one minute' (VERIFIED)

**Distractors**

- **(A)** `reversed_relationship` · _variable values swapped between the two terms_ — Computes \(60\ \text{bpm} \times 70\ \text{mL}\), assigning the new value of \(60\) to heart rate rather than to stroke volume. The stem specifies heart rate \(100\ \text{bpm}\) and stroke volume \(60\ \text{mL}\).
  - Citation: openstax-anatomy-physiology-2e.txt:37145 'CO = HR × SV'
- **(B)** `misconception` · _assumes opposing changes cancel exactly_ — Assumes the rate increase and stroke volume decrease offset perfectly. Because cardiac output is a product, cancellation requires \(100/75 = 70/60\), which is false, so output rises.
  - Citation: openstax-anatomy-physiology-2e.txt:37163 'Using these numbers, the mean CO is 5.25 L/min'
- **(D)** `process_step_confusion` · _updates only one of the two changed variables_ — Uses the new heart rate with the baseline stroke volume, \(100 \times 70\). The stem explicitly states stroke volume falls to \(60\ \text{mL}\) during the fever.
  - Citation: openstax-anatomy-physiology-2e.txt:37549 'the more rapidly the heart contracts, the shorter the filling time becomes, and the lower the EDV and preload are'

**Readback check.** PASS. The stem supplies only four raw measurements and never states the relationship among them, never names the formula, and never indicates the direction of the change. A student who does not know \(\text{CO} = \text{HR} \times \text{SV}\) cannot select among four numerically plausible values, three of which are products the stem's own numbers can generate. No key term is echoed and no premise is restated. AUDIT: re-verified all six citations by line, including the corrected quotation of :37141 (the draft attributed a definition sentence to :37139, which is only the section heading); added a supporting citation to distractor B and to distractor D; replaced 'normal resting range' with the explicit \(4.0\) to \(8.0\ \text{L/min}\) figure in the Choice C block. Question otherwise unchanged.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because cardiac output is the product of heart rate and stroke volume, and \(100\ \text{bpm} \times 60\ \text{mL} = 6000\ \text{mL/min}\), or \(6.0\ \text{L/min}\).
>
> Cardiac output is the volume ejected by a single ventricle each minute and is given by \(\text{CO} = \text{HR} \times \text{SV}\). At baseline this patient moves \(75\ \text{bpm} \times 70\ \text{mL} = 5250\ \text{mL/min}\), or \(5.25\ \text{L/min}\), the textbook mean for a resting adult. Fever multiplies heart rate by \(100/75 \approx 1.33\) and multiplies stroke volume by \(60/70 \approx 0.86\). Because cardiac output is a product, the net effect is \(1.33 \times 0.86 \approx 1.14\), a rise of roughly \(14\%\) to \(6.0\ \text{L/min}\).
>
> (Choice A) \(4.2\ \text{L/min}\) is the product \(60\ \text{bpm} \times 70\ \text{mL}\), which treats \(60\) as the new rate and leaves stroke volume at its baseline value. The stem assigns those numbers the other way: the rate rises to \(100\ \text{bpm}\) and the stroke volume falls to \(60\ \text{mL}\). Each variable must be substituted into its own term of \(\text{CO} = \text{HR} \times \text{SV}\), which gives \(6.0\ \text{L/min}\).
>
> (Choice B) \(5.25\ \text{L/min}\) is the baseline output and assumes the two changes cancel exactly. Cardiac output is a product rather than a sum, so exact cancellation would require the ratio \(100/75\) to equal \(70/60\), which it does not. The proportional rise in rate is larger than the proportional fall in stroke volume, so cardiac output increases.
>
> (Choice C) Correct. Substituting the febrile values gives \(100\ \text{bpm} \times 60\ \text{mL} = 6.0\ \text{L/min}\), about \(0.75\ \text{L/min}\) above baseline. This value still lies inside the normal resting range of \(4.0\) to \(8.0\ \text{L/min}\). A modest tachycardia can therefore raise total output even though each individual beat delivers less blood.
>
> (Choice D) \(7.0\ \text{L/min}\) is \(100\ \text{bpm} \times 70\ \text{mL}\) and keeps the baseline stroke volume. Stroke volume does not remain at \(70\ \text{mL}\); the stem states it falls to \(60\ \text{mL}\), consistent with the shorter cycle at \(100\ \text{bpm}\) allowing less ventricular filling. Using the stated value yields \(6.0\ \text{L/min}\).
>
> This is a Scientific Reasoning and Problem Solving question because you must apply the cardiac output relationship to two variables that change in opposite directions and predict the net result.

---

## Q20 — Diastolic Filling Time

**Stem.** In a resting adult at \(75\ \text{bpm}\), each cardiac cycle lasts about \(800\ \text{ms}\), and ventricular systole occupies about \(270\ \text{ms}\) of that cycle. A pacemaker then drives the same heart at \(150\ \text{bpm}\), and ventricular systole still occupies about \(250\ \text{ms}\). How does the time available for ventricular filling most likely change?

- **A.** From about \(530\ \text{ms}\) to about \(150\ \text{ms}\)  ← **KEY**
- **B.** From about \(530\ \text{ms}\) to about \(265\ \text{ms}\)
- **C.** From about \(800\ \text{ms}\) to about \(400\ \text{ms}\)
- **D.** From about \(270\ \text{ms}\) to about \(250\ \text{ms}\)

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic easy / structural easy) |
| Estimated time | 80 s |
| Confidence | 5 |

**Correct answer (A): From about \(530\ \text{ms}\) to about \(150\ \text{ms}\)**

Citations: openstax-anatomy-physiology-2e.txt:37019 'It may be conveniently divided into two phases, lasting a total of 270 ms' (VERIFIED); :37043 'It too is divided into two distinct phases and lasts approximately 430 ms' (VERIFIED); :37014 'Atrial systole lasts approximately 100 ms and ends prior to ventricular systole' (VERIFIED); :37013 'Atrial contraction, also referred to as the atrial kick, contributes the remaining 20 to 30 percent of filling' (VERIFIED; source prints the range with a dash); :37548 'One of the primary factors to consider is filling time, or the duration of ventricular diastole during which filling occurs' (VERIFIED); :37549 'The more rapidly the heart contracts, the shorter the filling time becomes, and the lower the EDV and preload are' (VERIFIED); :37026 'closing the tricuspid and mitral valves' (VERIFIED)

**Distractors**

- **(B)** `partial_truth` · _correct direction, proportional scaling error_ — Scales the filling interval by the same factor as cycle length. That interval is a remainder, not a fixed fraction, because ventricular systole is nearly constant and is subtracted first.
  - Citation: openstax-anatomy-physiology-2e.txt:37019 'lasting a total of 270 ms'
- **(C)** `process_step_confusion` · _whole cycle taken as the filling interval_ — Uses total cycle length as filling time. No filling occurs during ventricular systole, when the atrioventricular valves are closed.
  - Citation: openstax-anatomy-physiology-2e.txt:37026 'closing the tricuspid and mitral valves'
- **(D)** `reversed_relationship` · _systole reported in place of diastole_ — Reports the ejection interval instead of the filling interval, inverting the two phases of the cycle. These values are the quantities to be subtracted from cycle length.
  - Citation: openstax-anatomy-physiology-2e.txt:37548 'filling time, or the duration of ventricular diastole during which filling occurs'

**Readback check.** PASS. The stem gives cycle length and systole duration but never states the filling interval, never gives the new cycle length, and never asserts that the interval shrinks disproportionately. The student must convert \(150\ \text{bpm}\) to \(400\ \text{ms}\) and know that filling occupies the non-systolic remainder. No stem word is echoed in the key, which is a pair of computed numbers. AUDIT: fixed an accuracy overstatement. The draft asserted that filling occupies the whole \(530\ \text{ms}\); in fact the early phase of ventricular diastole is isovolumic relaxation, during which no filling occurs (:37047 to :37050). Reworded the key sentence and the Choice A block to describe the non-systolic interval as the time available for filling rather than as pure filling, and added :37548, where the textbook itself equates filling time with the duration of ventricular diastole. Added the atrial kick citation :37013 to justify why the interval is \(530\ \text{ms}\) rather than \(430\ \text{ms}\). Choice D was challenged as possibly eliminable without topic knowledge, since its numbers are lifted verbatim from the stem, but RETAINED: rejecting it requires knowing that ejection and filling are different phases, which is topic knowledge, and it is the standard systole and diastole inversion. Options unchanged.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because the interval available for filling is whatever part of the cycle lies outside ventricular systole, giving \(800 - 270 = 530\ \text{ms}\) at the slower rate and \(400 - 250 = 150\ \text{ms}\) at the paced rate.
>
> Cycle length is set entirely by rate: at \(150\ \text{bpm}\) each cycle lasts \(60/150 = 0.400\ \text{s}\), or \(400\ \text{ms}\). Ventricular systole is comparatively fixed, shortening only from \(270\) to \(250\ \text{ms}\), so nearly the entire loss of cycle length is subtracted from the filling interval. Doubling the rate halves the cycle, a \(50\%\) reduction, but cuts the filling interval by roughly \(72\%\). Because end diastolic volume is built during that interval, preload falls disproportionately as rate climbs.
>
> (Choice A) Correct. Subtracting systole from cycle length gives \(530\ \text{ms}\) at \(75\ \text{bpm}\) and \(150\ \text{ms}\) at \(150\ \text{bpm}\). The \(530\ \text{ms}\) figure matches the textbook cardiac cycle, in which ventricular diastole lasts about \(430\ \text{ms}\) and atrial systole adds about \(100\ \text{ms}\) more, the atrial kick supplying the final \(20\) to \(30\%\) of ventricular filling. The disproportionate squeeze on this interval is the reason very rapid rates lower end diastolic volume.
>
> (Choice B) \(265\ \text{ms}\) comes from scaling the original filling interval by the same factor as the cycle, \(530 \times (400/800)\). The filling interval does not scale proportionally with cycle length, because systole is nearly fixed and is subtracted first. Once the \(250\ \text{ms}\) of systole is removed from a \(400\ \text{ms}\) cycle, only \(150\ \text{ms}\) remains.
>
> (Choice C) \(800\) and \(400\ \text{ms}\) are the full cycle lengths, treating the entire cycle as available for filling. The ventricle cannot fill during systole, when the rising ventricular pressure has closed the tricuspid and mitral valves. The systolic interval must be subtracted before the filling interval is read off.
>
> (Choice D) \(270\) and \(250\ \text{ms}\) are the durations of ventricular systole, the ejection portion of the cycle rather than the filling portion. These are the values that must be subtracted, not the answer itself. Reading them as filling time inverts the two phases of the cycle.
>
> This is a Scientific Reasoning and Problem Solving question because you must convert heart rate to cycle length and partition the cycle to predict how preload is affected.

---

## Q21 — Contractility and Ejection Fraction

**Stem.** A patient in a cardiac intensive care unit receives a drug infusion that increases myocardial contractility. Heart rate, ventricular filling pressure, and arterial pressure remain unchanged during the infusion. Which combination of changes is most likely?

- **A.** Higher end systolic volume, lower stroke volume, lower ejection fraction
- **B.** Higher end diastolic volume, higher stroke volume, unchanged ejection fraction
- **C.** Lower end systolic volume, higher stroke volume, unchanged ejection fraction
- **D.** Lower end systolic volume, higher stroke volume, higher ejection fraction  ← **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 100 s |
| Confidence | 5 |

**Correct answer (D): Lower end systolic volume, higher stroke volume, higher ejection fraction**

Citations: openstax-anatomy-physiology-2e.txt:37589 'Contractility refers to the force of the contraction of the heart muscle, which controls SV, and is the primary parameter for impacting ESV' (VERIFIED); :37590 'The more forceful the contraction is, the greater the SV and smaller the ESV are' (VERIFIED); :37174 'To calculate ejection fraction, SV is divided by EDV' (VERIFIED); :37175 'Ejection fractions range from approximately 55 to 70 percent, with a mean of 58 percent' (VERIFIED; source prints the range with a dash, transcribed here with 'to'); :37020 'the ventricles contain approximately 130 mL blood in a resting adult in a standing position. This volume is known as the end diastolic volume (EDV) or preload' (VERIFIED); :37036 'Stroke volume will normally be in the range of 70 to 80 mL' and :37037 'there is still 50 to 60 mL of blood remaining in the ventricle following contraction' (VERIFIED); :37547 'Preload is another way of expressing EDV. Therefore, the greater the EDV is, the greater the preload is' (VERIFIED); :37565 'the greater the stretch of the ventricular muscle (within limits), the more powerful the contraction is, which in turn increases SV' (VERIFIED)

**Distractors**

- **(A)** `reversed_relationship` · _negative inotropic pattern substituted for positive_ — Describes what a negative inotropic influence produces. Increased contractility yields greater stroke volume and smaller end systolic volume.
  - Citation: openstax-anatomy-physiology-2e.txt:37590 'the greater the SV and smaller the ESV are'
- **(B)** `process_step_confusion` · _contractility misassigned to the filling limb_ — Places the change on end diastolic volume, the preload limb, but filling pressure and rate are held constant so preload is unchanged. Contractility is the primary parameter acting on end systolic volume. This combination would be correct after a fluid bolus, where a proportional rise in preload leaves ejection fraction flat.
  - Citation: openstax-anatomy-physiology-2e.txt:37589 'Contractility refers to the force of the contraction of the heart muscle, which controls SV, and is the primary parameter for impacting ESV'; :37547 'Preload is another way of expressing EDV'
- **(C)** `partial_truth` · _correct volumes, ejection fraction treated as fixed_ — Correct on both volume changes, but ejection fraction is stroke volume divided by end diastolic volume. With the denominator fixed and the numerator larger, the fraction must rise; it stays flat only when preload rises proportionally.
  - Citation: openstax-anatomy-physiology-2e.txt:37174 'To calculate ejection fraction, SV is divided by EDV'

**Readback check.** PASS. The stem names only the intervention and three clamped variables; it never states which volume contractility acts on, never mentions ejection fraction, and never gives a direction for any measured value. Choice C shares two of three clauses with the key, so the discrimination rests on knowing how ejection fraction is computed. AUDIT: rebuilt choice B, which broke twice. First, the original ('Lower end diastolic volume, higher stroke volume, higher ejection fraction') was internally contradictory, since a smaller starting volume with better emptying cannot be reconciled without external knowledge, so a test-wise student eliminated it by arithmetic alone with zero cardiac physiology. Second and worse, it was arguably DEFENSIBLE AS CORRECT: in an intact circulation a pure inotropic increase does modestly lower end diastolic volume over successive beats as residual volume drops, so the draft's own rebuttal ('makes the arithmetic impossible') was overstated. Replaced it with the preload pattern 'Higher end diastolic volume, higher stroke volume, unchanged ejection fraction', which is internally consistent, is unambiguously excluded by the stem's clamp on filling pressure, and is correct under the neighbouring condition of a fluid bolus. This also repaired a separate structural leak: in the original set the key was the only option in which all three values moved in the intuitively favourable direction, so a student with no knowledge could guess it on tone alone. Choices B and C now read just as favourably as the key. Each distractor probes a distinct failure (wrong direction, wrong limb, wrong ratio consequence). Rewrote the Choice B block. Note that the rebuilt structure arguably clears the hard gate on conditions 1 and 3, but the gate is a ceiling rather than a floor, so the item is retained at medium with estimated time raised from \(90\) to \(100\) seconds.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because a more forceful contraction empties the ventricle more completely, lowering end systolic volume and raising stroke volume, and because ejection fraction is stroke volume divided by an unchanged end diastolic volume, it must rise as well.
>
> Contractility is the force of contraction and is the primary parameter acting on end systolic volume, the blood left behind after ejection. With filling pressure and heart rate held constant, end diastolic volume stays near its resting value of roughly \(130\ \text{mL}\). If end systolic volume falls from about \(60\) to about \(45\ \text{mL}\), stroke volume rises from \(70\) to \(85\ \text{mL}\). Ejection fraction, calculated as stroke volume divided by end diastolic volume, therefore climbs from roughly \(54\%\) to roughly \(65\%\).
>
> (Choice A) A higher end systolic volume with a smaller stroke volume is the pattern produced by a negative inotropic influence, not a positive one. Weaker contractions leave more residual blood behind and eject less per beat, so ejection fraction falls as well. The stem specifies increased contractility, so every one of these changes runs in the opposite direction.
>
> (Choice B) A rise in end diastolic volume with a proportional rise in stroke volume and a flat ejection fraction is the signature of increased preload, as occurs with a fluid bolus or greater venous return. The stem holds ventricular filling pressure constant, so end diastolic volume cannot climb. Contractility raises stroke volume by improving emptying rather than by increasing filling, which is why it acts on end systolic volume instead.
>
> (Choice C) Lower end systolic volume with higher stroke volume is correct, but ejection fraction cannot stay flat under these conditions. Ejection fraction would remain unchanged only if end diastolic volume rose in exact proportion to stroke volume, which happens with a pure preload increase rather than a pure contractility increase. Because the denominator is fixed here, a larger numerator forces the fraction upward.
>
> (Choice D) Correct. Increased contractility drives ejection further, shrinking end systolic volume and widening the difference between end diastolic and end systolic volume. Because ejection fraction divides that widened difference by an unchanged end diastolic volume, it rises above the resting mean of about \(58\%\). This dissociation between preload and contractility is precisely what an inotropic agent exploits at the bedside.
>
> This is a Scientific Reasoning and Problem Solving question because you must trace a change in contractility through end systolic volume to stroke volume and then to a calculated ratio.

---

## Q22 — Afterload and Ventricular Wall Thickness

**Stem.** An adult has untreated systemic hypertension near \(180/110\ \text{mm Hg}\) for a decade. Her resting tissue oxygen demand over that period is unchanged. Which cardiac finding is most likely now?

- **A.** Left ventricular wall thickening with resting stroke volume markedly increased
- **B.** Left ventricular wall thickening with resting stroke volume near baseline  ← **KEY**
- **C.** Right ventricular wall thickening with resting stroke volume near baseline
- **D.** Left ventricular chamber dilation with resting stroke volume near baseline

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 95 s |
| Confidence | 5 |

**Correct answer (B): Left ventricular wall thickening with resting stroke volume near baseline**

Citations: openstax-anatomy-physiology-2e.txt:35907 'Although the ventricles on the right and left sides pump the same amount of blood per contraction, the muscle of the left ventricle is much thicker and better developed than that of the right ventricle. In order to overcome the high resistance required to pump blood into the long systemic circuit, the left ventricle must generate a great amount of pressure' (VERIFIED across :35907 to :35910); :35910 'The right ventricle does not need to generate as much pressure, since the pulmonary circuit is shorter and provides less resistance' (VERIFIED); :37623 'Afterload refers to the tension that the ventricles must develop to pump blood effectively against the resistance in the vascular system' (VERIFIED); :37624 'Any condition that increases resistance requires a greater afterload to force open the semilunar valves' (VERIFIED); :35749 to :35750 'exercise results in the addition of protein myofilaments that increase the size of the individual cells without increasing their numbers, a concept called hypertrophy' (VERIFIED; the passage is explicitly about cardiac muscle, introduced at :35747 'Cardiac muscle responds to exercise in a manner similar to that of skeletal muscle'); :36029 'right ventricular hypertrophy (enlargement of the right ventricle)' (VERIFIED; context is tetralogy of Fallot with pulmonary valve stenosis at :36028); :39196 to :39197 'This is a leading cause of hypertension and coronary heart disease, as it causes the heart to work harder to generate a pressure great enough to overcome the resistance' (VERIFIED); :37089 'S4, results from the contraction of the atria pushing blood into a stiff or hypertrophic ventricle, indicating failure of the left ventricle' (VERIFIED); :39779 'Chronically elevated blood pressure is known clinically as hypertension' (VERIFIED)

**Distractors**

- **(A)** `misconception` · _wall thickness treated as proportional to volume pumped_ — Assumes a thicker wall means more blood ejected per beat. Both ventricles pump the same volume despite very different wall thicknesses; thickness reflects the pressure generated, and resting output is set by unchanged tissue demand.
  - Citation: openstax-anatomy-physiology-2e.txt:35907 'Although the ventricles on the right and left sides pump the same amount of blood per contraction, the muscle of the left ventricle is much thicker'
- **(C)** `process_step_confusion` · _correct remodeling, wrong chamber_ — Assigns the pressure load to the right ventricle, which ejects into the low resistance pulmonary circuit. Right ventricular hypertrophy follows a pulmonary pressure load such as pulmonary valve stenosis.
  - Citation: openstax-anatomy-physiology-2e.txt:35910 'The right ventricle does not need to generate as much pressure, since the pulmonary circuit is shorter and provides less resistance'; :36028 'pulmonary infundibular stenosis (rigidity of the pulmonary valve)' with :36029 'right ventricular hypertrophy (enlargement of the right ventricle)'
- **(D)** `partial_truth` · _correct chamber, remodeling pattern for a volume load_ — Chamber dilation without added wall mass is the response to a chronic volume load, such as a shunt that returns extra blood to the ventricle. Hypertension is a pressure load, which builds wall mass instead.
  - Citation: openstax-anatomy-physiology-2e.txt:39197 'it causes the heart to work harder to generate a pressure great enough to overcome the resistance'

**Readback check.** PASS. The stem gives only a blood pressure value and a statement that oxygen demand is unchanged. It never names a ventricle, never mentions afterload, resistance, wall thickness, or hypertrophy, and never asserts what drives remodeling. Choices A and B share the identical first clause, so the student cannot key on the chamber alone. AUDIT: fixed a parallelism break that leaked the answer. Choices A, B and C all ended with 'resting stroke volume ...' while choice D ended with 'wall thickness near baseline', flagging D as the structural odd one out and inviting elimination on form rather than physiology. Rewrote D as 'Left ventricular chamber dilation with resting stroke volume near baseline'. This also restores a clean single variable lattice around the key: A differs only in the stroke volume slot, C only in the chamber slot, D only in the remodeling pattern slot. Rewrote the Choice D block so the absence of wall thickening is stated explicitly in prose now that the option no longer names it. Corrected the citation for the hypertrophy quotation, which spans :35749 to :35750 rather than sitting on one line, and confirmed the passage concerns cardiac and not skeletal muscle. Added :39196 to :39197 and :37089, which are the closest direct textbook support for a pressure load driving left ventricular wall change, since the source never states 'hypertension causes left ventricular hypertrophy' in one sentence and the claim rests on a chain of textbook facts.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because ventricular wall thickness tracks the pressure a chamber must generate rather than the volume it moves, and the left ventricle is the chamber facing the elevated systemic pressure while the volume it delivers each beat is still set by unchanged tissue demand.
>
> The left ventricle already carries a much thicker wall than the right in a healthy heart, and the reason is resistance in the systemic circuit, not a larger load of blood. Afterload is the tension a ventricle must develop to force open its semilunar valve against vascular resistance, so an aortic pressure of \(110\ \text{mm Hg}\) in diastole raises left ventricular afterload substantially. Cardiac muscle responds to a sustained load by adding contractile protein to existing cells, increasing wall mass without increasing cell number. Because resting oxygen demand is unchanged, the volume ejected per beat has no reason to grow; only the pressure needed to eject it has grown.
>
> (Choice A) Wall thickening is correct, but a markedly increased resting stroke volume is not. Cardiac output at rest is matched to metabolic demand, which the stem states is unchanged, so there is no stimulus to raise the volume ejected per beat. Wall mass in this setting reflects the pressure generated, not the volume moved.
>
> (Choice B) Correct. The left ventricle must overcome systemic resistance, so chronic hypertension is a pure pressure load on that chamber, and its myocardium thickens by hypertrophy. Resting stroke volume remains near normal because output continues to be matched to tissue demand. This is the same principle that makes the left ventricular wall thicker than the right in every healthy heart despite equal stroke volumes.
>
> (Choice C) The right ventricle ejects into the pulmonary circuit, which is short and low in resistance, so systemic hypertension does not raise the pressure it must generate. Right ventricular thickening instead follows a pulmonary pressure load, as occurs when the pulmonary valve is stenotic in tetralogy of Fallot. The chamber that hypertrophies is the one facing the raised resistance.
>
> (Choice D) Cavity enlargement without added wall mass is the remodeling a ventricle shows when it must handle a chronically excessive volume, such as with a shunt lesion or a regurgitant valve that returns extra blood to the chamber. Systemic hypertension imposes a pressure load rather than a volume load, so the myocardium adds contractile protein and thickens instead. The stem also fixes resting oxygen demand, removing any drive toward a larger chamber volume.
>
> This is a Scientific Reasoning and Problem Solving question because you must decide which ventricle bears the load and whether pressure or volume drives the remodeling.

---

## Q23 — Ejection Fraction and Cardiac Output

**Stem.** Echocardiography on a patient in a heart failure clinic reports an end diastolic volume of \(150\ \text{mL}\) and an ejection fraction of \(40\%\). His heart rate during the study is \(90\ \text{bpm}\). Which value best approximates his cardiac output?

- **A.** \(13.5\ \text{L/min}\)
- **B.** \(8.1\ \text{L/min}\)
- **C.** \(5.4\ \text{L/min}\)  ← **KEY**
- **D.** \(3.6\ \text{L/min}\)

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 85 s |
| Confidence | 5 |

**Correct answer (C): \(5.4\ \text{L/min}\)**

Citations: openstax-anatomy-physiology-2e.txt:37174 'To calculate ejection fraction, SV is divided by EDV. Despite the name, the ejection fraction is normally expressed as a percentage' (VERIFIED); :37175 'Ejection fractions range from approximately 55 to 70 percent, with a mean of 58 percent' (VERIFIED; source prints the range with a dash, transcribed here with 'to'); :37147 to :37148 'SV is normally measured using an echocardiogram to record EDV and ESV, and calculating the difference: SV = EDV minus ESV' (VERIFIED; the source prints a dash character for the subtraction, transcribed here as the word 'minus' to keep the record free of dash characters); :37145 'CO = HR × SV' (VERIFIED); :37038 'This volume of blood is known as the end systolic volume (ESV)' (VERIFIED); :37020 'the ventricles contain approximately 130 mL blood in a resting adult in a standing position' (VERIFIED); :37036 'Stroke volume will normally be in the range of 70 to 80 mL' (VERIFIED); :37163 'the mean CO is 5.25 L/min, with a range of 4.0 to 8.0 L/min' (VERIFIED)

**Distractors**

- **(A)** `process_step_confusion` · _end diastolic volume used as stroke volume_ — Multiplies end diastolic volume by rate, skipping the ejection fraction step. A ventricle never ejects its full contents; end systolic volume always remains.
  - Citation: openstax-anatomy-physiology-2e.txt:37147 to :37148 'calculating the difference: SV = EDV minus ESV'
- **(B)** `reversed_relationship` · _retained volume used in place of ejected volume_ — Uses the \(90\ \text{mL}\) end systolic volume, which is the blood not ejected. Cardiac output counts only the volume that leaves the ventricle.
  - Citation: openstax-anatomy-physiology-2e.txt:37038 'This volume of blood is known as the end systolic volume (ESV)'
- **(D)** `scale_unit_error` · _percentage read as a volume in milliliters_ — Treats the ejection fraction value \(40\) as \(40\ \text{mL}\) of stroke volume. Ejection fraction is a dimensionless ratio and must be multiplied by end diastolic volume to produce a volume.
  - Citation: openstax-anatomy-physiology-2e.txt:37174 'Despite the name, the ejection fraction is normally expressed as a percentage'

**Readback check.** PASS. The stem supplies three measured values and asks for a fourth; it never defines ejection fraction, never gives stroke volume, and never states the cardiac output relationship. Each of the three distractors is a product the stem's own numbers generate, so no choice can be eliminated without knowing that ejection fraction equals stroke volume over end diastolic volume. AUDIT: two fixes. First, a NOTATION RELEASE BLOCKER: the draft reproduced the textbook formula as 'SV = EDV – ESV' with a literal en dash, in both the distractor A citation and the citations field. Replaced with inline LaTeX \(\text{SV} = \text{EDV} - \text{ESV}\) in the explanation and with the word 'minus' inside the quoted citation, so no dash character survives anywhere in the record. Second, an accuracy error: the draft claimed this patient's 'absolute stroke volume is preserved', but \(60\ \text{mL}\) is below the textbook normal of \(70\) to \(80\ \text{mL}\) (:37036). Rewrote that sentence to attribute the preserved output to chamber dilation plus the elevated rate, and adjusted the Choice C block to state plainly that stroke volume is slightly subnormal. Also added the explicit \(4.0\) to \(8.0\ \text{L/min}\) range and the \(\text{SV} = \text{EDV} - \text{ESV}\) step to the main reasoning. Options and key unchanged; all four arithmetic values reconfirmed.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because an ejection fraction of \(40\%\) applied to an end diastolic volume of \(150\ \text{mL}\) gives a stroke volume of \(60\ \text{mL}\), and \(60\ \text{mL} \times 90\ \text{bpm} = 5400\ \text{mL/min}\), or \(5.4\ \text{L/min}\).
>
> Ejection fraction is stroke volume divided by end diastolic volume, so stroke volume is recovered by multiplying: \(0.40 \times 150\ \text{mL} = 60\ \text{mL}\). The remaining \(90\ \text{mL}\) is end systolic volume, the blood left in the ventricle after ejection, since \(\text{SV} = \text{EDV} - \text{ESV}\). Cardiac output then follows from \(\text{CO} = \text{HR} \times \text{SV}\). The result is notable clinically: an ejection fraction of \(40\%\) is well below the normal mean of about \(58\%\), yet output stays in the normal range because the dilated chamber holds \(150\ \text{mL}\) rather than the usual \(130\ \text{mL}\) and the rate is elevated to \(90\ \text{bpm}\).
>
> (Choice A) \(13.5\ \text{L/min}\) is \(150\ \text{mL} \times 90\ \text{bpm}\) and uses end diastolic volume as though the ventricle emptied completely each beat. No ventricle ejects its entire contents; a substantial end systolic volume always remains. The ejection fraction must be applied first to convert end diastolic volume into stroke volume.
>
> (Choice B) \(8.1\ \text{L/min}\) is \(90\ \text{mL} \times 90\ \text{bpm}\) and uses end systolic volume, the fraction retained rather than the fraction ejected. Cardiac output counts only blood that leaves the ventricle. Multiplying the ejected \(60\ \text{mL}\) by rate gives \(5.4\ \text{L/min}\).
>
> (Choice C) Correct. Stroke volume is \(0.40 \times 150\ \text{mL} = 60\ \text{mL}\), and \(60\ \text{mL} \times 90\ \text{bpm} = 5.4\ \text{L/min}\). This falls inside the normal resting range of \(4.0\) to \(8.0\ \text{L/min}\) even though the ejection fraction is depressed and the stroke volume itself sits just under the usual \(70\) to \(80\ \text{mL}\). Chamber enlargement combined with a modestly elevated rate can therefore keep resting output adequate while contractile performance is impaired.
>
> (Choice D) \(3.6\ \text{L/min}\) comes from treating the number \(40\) as a stroke volume in milliliters and multiplying by rate. Ejection fraction is a dimensionless percentage, not a volume, and must be multiplied by end diastolic volume to yield a volume. Doing so gives \(60\ \text{mL}\) per beat rather than \(40\ \text{mL}\).
>
> This is a Scientific Reasoning and Problem Solving question because you must invert the ejection fraction relationship to recover stroke volume before applying the cardiac output equation.

---

## Q24 — Heart Rate and Cardiac Output

**Stem.** During an electrophysiology study, a patient's heart is paced at four rates while ventricular filling pressure and myocardial contractility are held constant. Stroke volume is measured at each rate.

| Paced rate (\(\text{bpm}\)) | Stroke volume (\(\text{mL}\)) |
| --- | --- |
| \(70\) | \(72\) |
| \(120\) | \(70\) |
| \(160\) | \(48\) |
| \(200\) | \(33\) |

At which paced rate is cardiac output greatest?

- **A.** \(70\ \text{bpm}\)
- **B.** \(120\ \text{bpm}\)  ← **KEY**
- **C.** \(160\ \text{bpm}\)
- **D.** \(200\ \text{bpm}\)

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic medium / structural hard) |
| Estimated time | 120 s |
| Confidence | 5 |
| Hard-tier gate | Meets three of four gate conditions, reconfirmed after the data change. (1) CONCEPT CHAINING: the student must combine \(\text{CO} = \text{HR} \times \text{SV}\) with the dependence of stroke volume on diastolic filling time to explain why the products stop rising, since neither concept alone locates the maximum. (2) DATA-TO-MECHANISM: no output value is printed; four products must be derived from the table and the resulting non-monotonic pattern interpreted mechanistically. (4) 510-TEMPTING DISTRACTOR: choice C is the second largest product and sits at the upper bound of the range the textbook explicitly describes as one over which cardiac output remains stable, so a well-prepared student who recalls that passage and reasons that the higher rate must therefore be at least equal, without computing both products or noticing that venous return is clamped rather than rising, lands on it. Condition (3) is not claimed. |

**Correct answer (B): \(120\ \text{bpm}\)**

Citations: openstax-anatomy-physiology-2e.txt:37145 'CO = HR × SV' (VERIFIED); :37237 'as the HR rises, there is less time spent in diastole and consequently less time for the ventricles to fill with blood' (VERIFIED); :37239 'as HR continues to increase, SV gradually decreases due to decreased filling time' (VERIFIED); :37236 'Initially, physiological conditions that cause HR to increase also trigger an increase in SV. During exercise, the rate of blood returning to the heart increases' (VERIFIED, and the basis for the stem's clamp on filling pressure); :37243 'As HR increases from 120 to 160 bpm, CO remains stable, since the increase in rate is offset by decreasing ventricular filling time and, consequently, SV' (VERIFIED); :37244 'As HR continues to rise above 160 bpm, CO actually decreases as SV falls faster than HR increases' (VERIFIED); :37549 'The more rapidly the heart contracts, the shorter the filling time becomes, and the lower the EDV and preload are' (VERIFIED)

**Distractors**

- **(A)** `misconception` · _largest stroke volume mistaken for largest output_ — Selects the row with the highest stroke volume. Cardiac output is the product of rate and stroke volume, and \(70 \times 72 = 5.04\ \text{L/min}\) is the smallest of the four products.
  - Citation: openstax-anatomy-physiology-2e.txt:37145 'CO = HR × SV'
- **(C)** `partial_truth` · _second highest product at the top of the textbook target range_ — Yields \(7.68\ \text{L/min}\), the second largest product and the upper bound of the range over which cardiac output is described as stable during exercise, but below the \(8.40\ \text{L/min}\) at \(120\ \text{bpm}\). Choosing it requires assuming output still tracks rate rather than computing every product, and it overlooks that venous return is clamped here rather than rising as it would in exercise.
  - Citation: openstax-anatomy-physiology-2e.txt:37243 'As HR increases from 120 to 160 bpm, CO remains stable, since the increase in rate is offset by decreasing ventricular filling time'
- **(D)** `reversed_relationship` · _output assumed to rise monotonically with rate_ — Assumes the fastest rate gives the greatest output, but \(200 \times 33 = 6.60\ \text{L/min}\). Once stroke volume falls faster than rate rises, output declines.
  - Citation: openstax-anatomy-physiology-2e.txt:37244 'As HR continues to rise above 160 bpm, CO actually decreases as SV falls faster than HR increases'

**Readback check.** PASS. The table lists only paced rates and measured stroke volumes; no cardiac output value appears anywhere, and the stem never states where output peaks or that it eventually declines. Nothing can be read off the table directly. AUDIT: two substantive fixes. First and most serious, the draft's key and its nearest distractor differed by less than one percent (\(8.40\) against \(8.32\ \text{L/min}\)). In a stem that states stroke volume is MEASURED, a sub one percent separation falls inside any plausible measurement error, so choice C was genuinely defensible and the item was ambiguous rather than merely difficult. Changed the \(160\ \text{bpm}\) stroke volume from \(52\) to \(48\ \text{mL}\), moving that row to \(7.68\ \text{L/min}\) and opening a \(9.4\%\) margin, which is unambiguous while leaving C the second highest product and still strongly tempting. Second, the stem originally held VENOUS RETURN constant, which is physiologically impossible across rows where cardiac output changes, since venous return and cardiac output must be equal in the steady state. Replaced with ventricular filling pressure, a genuine experimental clamp, and moved the scenario from a healthy volunteer to an electrophysiology study, since pacing an untrained volunteer to \(200\ \text{bpm}\) is not a realistic protocol. Recomputed all four products, rewrote every choice block, added :37236 to justify why this preparation's curve declines across \(120\) to \(160\ \text{bpm}\) while the textbook's exercising subject plateaus (venous return rises in exercise and is clamped here), and rewrote the skill closer, which had described comparing 'closely spaced results' that no longer exist. Hard tier reconfirmed below.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because \(120\ \text{bpm} \times 70\ \text{mL} = 8.40\ \text{L/min}\), the largest of the four products, exceeding the \(7.68\ \text{L/min}\) produced at \(160\ \text{bpm}\).
>
> Cardiac output must be computed row by row: \(70 \times 72 = 5.04\), \(120 \times 70 = 8.40\), \(160 \times 48 = 7.68\), and \(200 \times 33 = 6.60\ \text{L/min}\). Output therefore rises steeply to \(120\ \text{bpm}\) and then falls, so the pattern is not a simple increase with rate. Because contractility and filling pressure are clamped, the only variable degrading stroke volume is the shrinking diastolic interval, which limits end diastolic volume and therefore preload. In an exercising person the same rate increase is accompanied by a rise in venous return that props stroke volume up, which is why cardiac output holds roughly steady from \(120\) to \(160\ \text{bpm}\) during exercise but declines across that span here.
>
> (Choice A) \(70\ \text{bpm}\) yields \(5.04\ \text{L/min}\), close to the resting mean for an adult, and is the smallest of the four values. Stroke volume is maximal in this row because filling time is long, but the rate is too low to maximize the product. Cardiac output is a product of both terms, so the largest stroke volume alone does not locate the peak.
>
> (Choice B) Correct. At \(120\ \text{bpm}\) stroke volume has barely declined from its resting value, so nearly the entire rate increase translates into output, giving \(8.40\ \text{L/min}\). Beyond this rate the diastolic interval becomes short enough that stroke volume falls faster than rate rises. This is why the middle of the range, rather than the top, defines a useful target rate for sustained aerobic work.
>
> (Choice C) \(160\ \text{bpm}\) yields \(7.68\ \text{L/min}\), the second largest value and the upper bound of the textbook target range, but still below the peak. Stroke volume has already collapsed from \(70\) to \(48\ \text{mL}\) because filling time has shrunk, which more than cancels the one third increase in rate. Selecting this row assumes output continues to track rate, which the computed products contradict.
>
> (Choice D) \(200\ \text{bpm}\) yields \(6.60\ \text{L/min}\), below the values at both \(120\) and \(160\ \text{bpm}\). Once stroke volume falls proportionally faster than heart rate rises, their product declines. The highest achievable rate is therefore not the rate of highest output.
>
> This is a Data-based and Statistical Reasoning question because you must derive a quantity that is absent from the table for every row and interpret the resulting non-monotonic pattern.

---

## Q25 — Matched Ventricular Outputs

**Stem.** In an anesthetized dog, an experimental manipulation causes the right ventricle to eject \(2\ \text{mL}\) more per beat than the left ventricle at a steady \(100\ \text{bpm}\). Which change is most likely over the following minute?

- **A.** Blood accumulates in the pulmonary vessels and left ventricular preload rises  ← **KEY**
- **B.** Blood accumulates in the pulmonary vessels and left ventricular afterload rises
- **C.** Blood drains from the pulmonary vessels and left ventricular preload falls
- **D.** Blood accumulates in the systemic veins and right ventricular preload rises

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic hard / structural hard) |
| Estimated time | 125 s |
| Confidence | 5 |
| Hard-tier gate | Meets three of four gate conditions, reconfirmed after the choice B rebuttal was tightened. (1) CONCEPT CHAINING: the answer requires linking the series arrangement of the pulmonary and systemic circuits to the location of the volume shift, then linking that shift to ventricular filling, then to the stretch dependent rise in contraction force that restores equal outputs. (3) TRUE PARTIAL-TRUTH TRAP: choice B is correct that pulmonary blood volume rises and correct that a load on the left ventricle is at issue; it is wrong only in naming afterload instead of preload, and it would be the right answer had the manipulation raised aortic pressure or systemic resistance instead. (4) 510-TEMPTING DISTRACTOR: choice D is where a well-prepared student lands after the single subtle error of associating any right ventricular abnormality with systemic venous congestion rather than tracking the direction of the volume shift. |

**Correct answer (A): Blood accumulates in the pulmonary vessels and left ventricular preload rises**

Citations: openstax-anatomy-physiology-2e.txt:37035 'Nevertheless, both ventricles pump the same amount of blood' (VERIFIED); :35907 'Although the ventricles on the right and left sides pump the same amount of blood per contraction, the muscle of the left ventricle is much thicker and better developed than that of the right ventricle' (VERIFIED); :37563 to :37564 'This principle states that, within physiological limits, the force of heart contraction is directly proportional to the initial length of the muscle fiber' (VERIFIED; the Frank-Starling passage begins at :37562); :37565 'the greater the stretch of the ventricular muscle (within limits), the more powerful the contraction is, which in turn increases SV' (VERIFIED); :39752 'As blood returns to the heart more quickly, preload rises and the Frank-Starling principle tells us that contraction of the cardiac muscle in the atria and ventricles will be more forceful' (VERIFIED); :37547 'Preload is another way of expressing EDV. Therefore, the greater the EDV is, the greater the preload is' (VERIFIED); :37623 'Afterload refers to the tension that the ventricles must develop to pump blood effectively against the resistance in the vascular system' (VERIFIED); :38378 'Arteries and veins transport blood in two distinct circuits: the systemic circuit and the pulmonary circuit' (VERIFIED)

**Distractors**

- **(B)** `process_step_confusion` · _correct compartment, preload and afterload interchanged_ — Correctly identifies that pulmonary volume rises but calls the resulting effect on the left ventricle an afterload increase. Blood arriving from the pulmonary veins fills the ventricle before contraction, which is preload; afterload is the tension developed against aortic pressure and systemic resistance, and the systemic circuit is losing volume here, so aortic pressure would if anything fall.
  - Citation: openstax-anatomy-physiology-2e.txt:37623 'Afterload refers to the tension that the ventricles must develop to pump blood effectively against the resistance in the vascular system'; :37547 'Preload is another way of expressing EDV'
- **(C)** `reversed_relationship` · _direction of the volume shift inverted_ — Blood accumulates where inflow exceeds outflow. The pulmonary circuit is receiving more per beat than the left ventricle removes, so its volume rises rather than drains.
  - Citation: openstax-anatomy-physiology-2e.txt:38378 'Arteries and veins transport blood in two distinct circuits: the systemic circuit and the pulmonary circuit'
- **(D)** `misconception` · _right sided problem equated with systemic venous congestion_ — Systemic venous volume falls, because the right ventricle is clearing the systemic veins faster than the left ventricle refills them, and right ventricular filling therefore declines. Systemic congestion follows an underperforming right ventricle, the opposite of the described case.

**Readback check.** PASS. The stem gives only a per beat output mismatch and a rate. It never names the pulmonary circuit, never mentions preload, afterload, or the series arrangement of the circuits, and never states where displaced blood goes. Three of four choices open with 'Blood accumulates' and two of four end with a preload increase, so no single surface feature identifies the key. AUDIT: closed an ambiguity in choice B. The draft rebutted B only by defining afterload, which left the option partly defensible, because as left ventricular stroke volume climbs under Frank-Starling the systemic pressure it works against does creep upward, so a strong student could argue afterload rises too. Added the decisive argument the draft omitted: the systemic compartment is LOSING the \(200\ \text{mL}\) that the pulmonary compartment gains, so aortic pressure trends down over this minute and left ventricular afterload cannot be said to rise. B is now unambiguously wrong while remaining a true partial truth trap, since it would be correct had the manipulation raised aortic pressure. Mirrored the addition in the distractor B rationale and added :37547 as a supporting citation there. Also corrected the Frank-Starling citation, whose quoted sentence spans :37563 to :37564 rather than sitting on :37564 alone. Stem, options and key unchanged; scope reconfirmed clean, since Frank-Starling is treated purely as a hemodynamic property of the pump and not as cardiac muscle histology, and no forbidden Ch3, Ch4, Ch5, Ch6, Ch11 or Ch12 material is touched.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because the two ventricles are pumps arranged in series, so a right ventricular output that exceeds left ventricular output shifts blood into the pulmonary circuit lying between them, and the larger pulmonary venous return increases filling of the left ventricle.
>
> The right ventricle discharges into the pulmonary circuit, which drains into the left atrium and then the left ventricle; the left ventricle discharges into the systemic circuit, which drains back to the right side. A per beat mismatch of \(2\ \text{mL}\) at \(100\ \text{bpm}\) moves \(200\ \text{mL}\) per minute out of the systemic compartment and into the pulmonary compartment. Rising pulmonary blood volume raises the pressure filling the left ventricle, which is by definition its preload. Greater ventricular stretch then produces a more forceful contraction, so left ventricular stroke volume climbs until it matches the right, which is why the two ventricles necessarily eject equal volumes over any sustained period despite very different ejection pressures.
>
> (Choice A) Correct. Blood displaced by the mismatch has nowhere to go except the vascular bed between the two pumps, so pulmonary blood volume rises and left ventricular end diastolic volume increases. The stretched left ventricle contracts more forcefully in proportion to its initial fiber length, raising its stroke volume. The mismatch is therefore self correcting, and this is the mechanism that keeps the outputs of the two ventricles matched under normal conditions.
>
> (Choice B) The first clause is right, but the load identified is wrong. Blood arriving from the pulmonary veins fills the left ventricle before it contracts, which is preload; afterload is the tension the left ventricle must develop against aortic pressure and systemic vascular resistance. Neither of those is raised here, and the systemic circuit is in fact losing the \(200\ \text{mL}\) that the pulmonary circuit gains, so aortic pressure would tend to fall rather than rise. Naming the load correctly matters because only a preload increase recruits the stretch dependent rise in stroke volume that restores balance.
>
> (Choice C) This reverses the direction of the volume shift. Blood accumulates where inflow exceeds outflow, and here the pulmonary circuit is receiving more per beat than the left ventricle removes. Pulmonary volume would drain only if the left ventricle were the higher output pump.
>
> (Choice D) Systemic venous volume falls rather than rises, because the right ventricle is removing blood from the systemic veins faster than the left ventricle returns it. For the same reason, right ventricular filling declines rather than increases. Systemic venous congestion arises when the right ventricle is the underperforming pump, which is the opposite of the situation described.
>
> This is a Scientific Reasoning and Problem Solving question because you must apply the series arrangement of the two circuits to locate where displaced blood collects and then predict the consequence for ventricular filling.

---



---

# BATCH 2 of 4 (25 questions): the vessels

Units: endothelium and vessel architecture . portal systems . pressure, resistance and flow . fluid dynamics (AAMC 4B).

## Batch 2 summary

| Metric | Batch 2 | Combined (50) | Target |
|---|---|---|---|
| Difficulty | easy 5 . hard 9 . medium 11 | easy 12 . hard 17 . medium 21 | 27/40/33 |
| Answer letter | A 7 . B 3 . C 6 . D 9 | A 13 . B 10 . C 13 . D 14 | ~25% each |
| Cognitive skill | S1 3 . S2 14 . S3 4 . S4 4 | S1 6 . S2 32 . S3 4 . S4 8 | mixed |
| Confidence | conf4 3 . conf5 22 | conf4 4 . conf5 46 | only 4-5 ship |
| Roman numeral | 5 (20%) | 5 (10%) | 10-15% |
| Distractor categories | adjacent_fact 9 . misconception 18 . partial_truth 19 . process_step_confusion 9 . reversed_relationship 16 . scale_unit_error 4 | | none >40% |

**Deficits cleared from batch 1:** Roman-numeral format now 20% in this batch (10% combined, on target). Skill 3 introduced with 4 experimental-design items (endothelial function in isolated vessel rings, bruit turbulence hypothesis, sphygmomanometry technique, tracer studies). Answer letter D lifted from 20% to 28% combined.

**New deficit for batches 3-4:** answer letter B fell to 12% in this batch (20% combined); bias B upward. Easy tier is 24% combined against a 27% target; add easy items.

**Scope boundaries:** automated scan for the seven forbidden territories returned zero hits. No subtopic is duplicated between batches 1 and 2.

**Adversarial audit:** all 25 re-examined with every citation re-greped against the source file.

---

## B2-Q1 — Venous Return and the Skeletal Muscle Pump

**Stem.** Recruits who stand motionless at attention for long periods sometimes lose consciousness, so they are trained instead to flex their legs slightly every few seconds. Which mechanism most directly propels blood out of the leg veins during this maneuver?

- **A.** Reflex contraction of the venous smooth muscle layer
- **B.** Simultaneous closure of venous valves throughout the limb
- **C.** Elastic recoil of the venous wall between contractions
- **D.** External compression of the veins by surrounding skeletal muscle  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic easy / structural easy) |
| Estimated time | 65 s |
| Confidence | 5 |

**Correct answer (D): External compression of the veins by surrounding skeletal muscle**

Citations: AP = /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-anatomy-physiology-2e.txt | AP:39265 'In many body regions, the pressure within the veins can be increased by the contraction of the surrounding skeletal' | AP:39266 'This mechanism, known as the skeletal muscle pump (Figure 20.15), helps the lower-pressure veins' | AP:39267 'counteract the force of gravity, increasing pressure to move blood back to the heart. As leg muscles contract, for' | AP:39268 'example during walking or running, they exert pressure on nearby veins with their numerous one-way valves. This' | AP:39269 'increased pressure causes blood to flow upward, opening valves superior to the contracting muscles so blood flows' | AP:39270 'Simultaneously, valves inferior to the contracting muscles close; thus, blood should not seep back' | AP:39271 'downward toward the feet. Military recruits are trained to flex their legs slightly while standing at attention for' | AP:39272 'prolonged periods. Failure to do so may allow blood to pool in the lower limbs rather than returning to the heart.' | AP:39273 'Consequently, the brain will not receive enough oxygenated blood, and the individual may lose consciousness.' | AP:39260 'the pressure in the atria during diastole is very low, often approaching zero when the atria are' | AP:38557 'However, those close to the heart have the thickest' | AP:38558 'walls, containing a high percentage of elastic fibers in all three of their tunics.'

**Distractors**

- **(A)** `misconception` . _attributes an externally applied force to the vessel itself_ — Venous smooth muscle tone is set by vasomotor outflow, not triggered by voluntary limb flexion; the propulsive force in the skeletal muscle pump comes from the surrounding muscle compressing the vein.
  - Citation: AP:39265 'In many body regions, the pressure within the veins can be increased by the contraction of the surrounding skeletal'; AP:38818 'sends sympathetic stimulation to the smooth muscles in the walls of the veins, causing'
- **(B)** `process_step_confusion` . _correct components, wrong sequence_ — Valves superior to the contracting muscle open while valves inferior to it close; the staggered, not simultaneous, response is what makes flow unidirectional.
  - Citation: AP:39269 to 39270 'opening valves superior to the contracting muscles so blood flows through. Simultaneously, valves inferior to the contracting muscles close'
- **(C)** `adjacent_fact` . _imports an arterial property into veins_ — Recoil is a feature of the large elastic arteries near the heart, whose tunics are rich in elastic fibers; in the venous tunica externa collagenous and smooth fibers predominate.
  - Citation: AP:38557 to 38558 'those close to the heart have the thickest walls, containing a high percentage of elastic fibers in all three of their tunics'; AP:38472 'Collagenous and smooth fibers' with AP:38474 'predominate' (Table 20.1, vein column)

**Readback check.** Stem content words: recruits, stand, motionless, attention, lose consciousness, trained, flex, legs, slightly, seconds, mechanism, propels, blood, leg veins, maneuver. Keyed option content words: external, compression, veins, surrounding, skeletal, muscle. Only 'veins' overlaps, and it appears in the question stem for all four options, so it discriminates nothing. 'Muscle' now appears in the key and in distractors A and C but nowhere in the stem, so a student cannot pattern-match limb flexion to the word muscle. The live discrimination is whether the force comes from outside the vessel (key) or from the vein wall itself (A and C). audit: rewrote the lead-in question from 'Which property of the leg veins makes this small repeated movement effective?' to a mechanism question, because the old key was the longest option and the only one naming two structures at once, which let a test-wise student pick it by completeness. All four options were rebuilt to equal length and parallel noun-phrase form, and 'valves' was removed from the key so that it no longer competes with distractor B. Also removed the word 'muscles' from the stem phrasing.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because the propulsive force in the skeletal muscle pump is applied from outside the vessel, by skeletal muscle squeezing a thin-walled vein, rather than generated by the vein itself. Pressure inside a lower limb vein is low, often only a few \(\text{mm Hg}\) above right atrial pressure, so in a motionless person gravity holds blood in the limb. Contraction of the surrounding muscle raises pressure inside the compressed segment, and the one-way valves then force the displaced volume toward the heart: valves superior to the squeezed segment open while valves inferior to it close. Repeating this with each slight flexion sustains filling of the heart and therefore cerebral perfusion.
>
> (Choice A) Venous smooth muscle can contract and stiffen the wall, and that venoconstriction does speed return of blood to the heart, but it is driven by vasomotor outflow rather than by voluntary limb movement. Slight flexion still moves blood in a limb whose venous tone is unchanged. The force at work in this maneuver originates outside the vessel wall.
>
> (Choice B) The valves do not all close at once. Compression opens the valves superior to the squeezed segment while closing those inferior to it, and that staggering is precisely what gives the flow a direction. Uniform closure everywhere would trap blood in place rather than advance it.
>
> (Choice C) Recoil is a property of the large elastic arteries near the heart, whose walls carry a high percentage of elastic fibers in all three tunics. In the venous tunica externa the collagenous and smooth fibers predominate, so recoil contributes little. A squeezed vein refills from upstream venular inflow, not from springback of its own wall.
>
> (Choice D) This is correct. The vein serves as a compressible, valved conduit while the surrounding muscle serves as the pump. This arrangement is why prolonged immobility permits pooling in the lower limbs and why walking rapidly restores venous return.
>
> This is a Knowledge of Scientific Concepts and Principles question because you must recall that leg veins are thin-walled and easily compressed, so that contraction of the surrounding skeletal muscle, and not the vein wall itself, supplies the force that drives blood toward the heart.

---

## B2-Q2 — Capillary Wall Architecture and Exchange

**Stem.** A tracer injected into a forearm vein appears in the interstitial fluid of a leg muscle within a minute, yet none of it escapes across the wall of the femoral artery on the way there. Which difference between capillary and arterial walls best accounts for this result?

- **A.** Capillary walls lack a basement membrane; arterial walls possess one
- **B.** Capillary endothelium lacks tight junctions; arterial endothelium has them
- **C.** Capillary walls are a single endothelial layer; arterial walls are multilayered  <- **KEY**
- **D.** Capillary endothelium is fenestrated everywhere; arterial endothelium is continuous

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic easy / structural easy) |
| Estimated time | 70 s |
| Confidence | 5 |

**Correct answer (C): Capillary walls are a single endothelial layer; arterial walls are multilayered**

Citations: AP = /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-anatomy-physiology-2e.txt | AP:38613 'The wall of a capillary consists of the endothelial layer surrounded by a basement membrane with occasional' | AP:38614 'smooth muscle fibers.' | AP:38611 'wide enough for an erythrocyte to squeeze through. Flow through capillaries is often described as microcirculation.' | AP:38630 'The most common type of capillary, the continuous capillary, is found in almost all vascularized tissues.' | AP:38631 'capillaries are characterized by a complete endothelial lining with tight junctions between endothelial cells.' | AP:38632 'Although a tight junction is usually impermeable and only allows for the passage of water and ions, they are often' | AP:38633 'incomplete in capillaries, leaving intercellular clefts that allow for exchange of water and other very small molecules' | AP:38647 'A fenestrated capillary is one that has pores (or fenestrations) in addition to tight junctions in the endothelial lining.' | AP:38649 'Fenestrated capillaries are common in the small intestine,' | AP:38494 'Next to the endothelium is the basement membrane, or basal lamina, that effectively binds the endothelium to the' | AP:38495 'The basement membrane provides strength while maintaining flexibility, and it is permeable,' | AP:38520 'The tunica media is the substantial middle layer of the vessel wall (see Figure 20.3). It is generally the thickest' | AP:38521 'layer in arteries, and it is much thicker in arteries than it is in veins.' | AP:39333 'Small molecules, such as gases, lipids, and lipid-soluble molecules, can diffuse' | AP:39334 'directly through the membranes of the endothelial cells of the capillary wall.' | AP:39336 'Glucose, ions, and larger molecules may also leave the blood through' | AP:39337 'intercellular clefts.' | BIO = openstax-biology-2e.txt:53884 'Capillaries consist of a single layer of epithelial cells, the tunica intima.'

**Distractors**

- **(A)** `misconception` . _denies a structure the vessel actually has_ — Capillaries do have a basement membrane beneath the endothelium; it provides strength while remaining permeable, so its presence does not prevent exchange.
  - Citation: AP:38613 to 38614 'The wall of a capillary consists of the endothelial layer surrounded by a basement membrane with occasional smooth muscle fibers.'; AP:38495 'The basement membrane provides strength while maintaining flexibility, and it is permeable'
- **(B)** `reversed_relationship` . _inverts which vessel has the junctional specialization_ — Continuous capillaries are defined by a complete endothelial lining with tight junctions; those junctions restrict rather than permit passage, and it is their incompleteness that leaves the clefts used for exchange.
  - Citation: AP:38631 'capillaries are characterized by a complete endothelial lining with tight junctions between endothelial cells.'; AP:38632 to 38633 'they are often incomplete in capillaries, leaving intercellular clefts that allow for exchange of water and other very small molecules'
- **(D)** `partial_truth` . _true of some capillary beds, generalized to all_ — Fenestrated capillaries exist but are confined to sites such as the small intestine, kidneys, choroid plexus, and endocrine structures; skeletal muscle is supplied by continuous capillaries.
  - Citation: AP:38649 to 38651 'Fenestrated capillaries are common in the small intestine, which is the primary site of nutrient absorption, as well as in the kidneys, which filter the blood. They are also found in the choroid plexus of the brain and many endocrine structures'; AP:38630 'The most common type of capillary, the continuous capillary, is found in almost all vascularized tissues.'

**Readback check.** Stem content words: tracer, injected, forearm vein, interstitial fluid, leg muscle, minute, escapes, wall, femoral artery, difference, capillary, arterial, walls. Keyed option adds: single, endothelial, layer, multilayered. None of those four appear in the stem. 'Capillary' and 'arterial' appear in every option and so cannot cue the key. All four options are structural claims about the same two vessels, so the observation alone does not select one. audit: moved the key from position A to position C to improve answer-letter balance across the unit; changed 'skeletal muscle' to 'leg muscle' in the stem so the phrase does not preview the continuous-capillary discussion in the explanation; changed 'within seconds' to 'within a minute' because arm-to-leg circulation time is roughly twenty to thirty seconds and the original figure was not defensible; and deleted the sentence stating that large vessels are nourished by their own vasa vasorum, which handed a student the exact fact tested by statement III of the Roman numeral item in this same unit.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because a capillary places only one endothelial cell layer and its basement membrane between plasma and interstitial fluid, whereas an artery places that same lining plus a thick tunica media and tunica externa in the path. Capillary lumens are only \(5\) to \(10\ \mu\text{m}\) across, narrow enough that the smallest barely admit an erythrocyte, and the wall is thin enough that gases, lipids, and other small molecules diffuse straight through the endothelial membranes while glucose, ions, and larger solutes leave through intercellular clefts or in vesicles. The tunica media is generally the thickest layer of an artery, so the same molecule faces a far longer diffusion path there, and arterial transit lasts a fraction of a second. The tested contrast is therefore the number of layers a molecule must cross, not the presence or absence of any single specialization.
>
> (Choice A) A capillary wall does include a basement membrane around the endothelial layer. That membrane provides strength while remaining flexible and permeable, so its presence does not obstruct exchange. Arteries carry a basement membrane beneath their endothelium as well, so this cannot distinguish the two vessels.
>
> (Choice B) Continuous capillaries, the type supplying skeletal muscle, are defined by a complete endothelial lining with tight junctions between the cells. Those junctions are often incomplete, and the intercellular clefts they leave are one route for water and small solutes. Junctions restrict rather than permit passage, so their absence is not what makes a capillary leaky.
>
> (Choice C) This is correct. The exchange properties of a capillary follow from a wall that is essentially one cell thick over a permeable basement membrane. Slow flow through the large combined cross-sectional area of the capillary beds adds time for that exchange to occur.
>
> (Choice D) Fenestrations occur at specific sites such as the small intestine, the kidneys, the choroid plexus, and several endocrine structures. Skeletal muscle is supplied by continuous capillaries, the most common type, which are not fenestrated. Exchange in this bed proceeds without pores in the endothelial cells.
>
> This is a Scientific Reasoning and Problem Solving question because you must connect an observed pattern of solute escape to the number of tissue layers a molecule must cross in each vessel type.

---

## B2-Q3 — Capillary Types and Permeability

**Stem.** Erythrocytes newly formed in red bone marrow must enter the circulation intact, and hepatocytes must release whole plasma proteins into the blood passing through the liver. Which feature of the exchange vessels serving these two organs makes both events possible?

- **A.** A complete endothelial lining joined by tight junctions
- **B.** Pores set within an otherwise continuous endothelial lining
- **C.** Wide intercellular gaps over an unbroken basement membrane
- **D.** Wide intercellular gaps over an incomplete basement membrane  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic hard / structural medium) |
| Estimated time | 90 s |
| Confidence | 5 |

**Correct answer (D): Wide intercellular gaps over an incomplete basement membrane**

Citations: AP = /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-anatomy-physiology-2e.txt | AP:38655 'A sinusoid capillary (or sinusoid) is the least common type of capillary. Sinusoid capillaries are flattened, and they' | AP:38656 'have extensive intercellular gaps and incomplete basement membranes, in addition to intercellular clefts and' | AP:38657 'fenestrations. This gives them an appearance not unlike Swiss cheese. These very large openings allow for the' | AP:38658 'passage of the largest molecules, including plasma proteins and even cells. Blood flow through sinusoids is very' | AP:38659 'slow, allowing more time for exchange of gases, nutrients, and wastes. Sinusoids are found in the liver and spleen,' | AP:38660 'bone marrow, lymph nodes (where they carry lymph, not blood), and many endocrine glands including the pituitary' | AP:38662 'For example, when bone marrow forms new blood cells, the cells must enter the blood supply and can' | AP:38663 'only do so through the large openings of a sinusoid capillary; they cannot pass through the small openings of' | AP:38664 'continuous or fenestrated capillaries. The liver also requires extensive specialized sinusoid capillaries in order to' | AP:38665 'process the materials brought to it by the hepatic portal vein from both the digestive tract and spleen, and to release' | AP:38666 'plasma proteins into circulation.' | AP:38631 'capillaries are characterized by a complete endothelial lining with tight junctions between endothelial cells.' | AP:38647 'A fenestrated capillary is one that has pores (or fenestrations) in addition to tight junctions in the endothelial lining.' | AP:38648 'These make the capillary permeable to larger molecules.' | AP:38611 'wide enough for an erythrocyte to squeeze through.' | AP:38626 'types of capillaries, which differ according to their degree of leakiness: continuous, fenestrated, and sinusoid'

**Distractors**

- **(A)** `adjacent_fact` . _names the wrong member of a known series_ — This describes the continuous capillary, whose incomplete tight junctions leave clefts admitting only water and very small molecules; such a wall retains both cells and large proteins.
  - Citation: AP:38631 'capillaries are characterized by a complete endothelial lining with tight junctions between endothelial cells.'; AP:38632 to 38633 'they are often incomplete in capillaries, leaving intercellular clefts that allow for exchange of water and other very small molecules'
- **(B)** `partial_truth` . _correct direction of increased permeability, insufficient magnitude_ — Fenestrations do admit larger molecules and are found in intestine, kidney, and endocrine tissue, but the textbook states that new blood cells cannot pass through the small openings of continuous or fenestrated capillaries.
  - Citation: AP:38647 to 38648 'A fenestrated capillary is one that has pores (or fenestrations) in addition to tight junctions in the endothelial lining. These make the capillary permeable to larger molecules.'; AP:38663 'they cannot pass through the small openings of'
- **(C)** `partial_truth` . _recalls one of the two required breaches (510-tempting)_ — An unbroken basement membrane remains a continuous sheet that a whole cell cannot cross; the textbook pairs the extensive intercellular gaps of a sinusoid with incomplete basement membranes.
  - Citation: AP:38655 to 38656 'Sinusoid capillaries are flattened, and they have extensive intercellular gaps and incomplete basement membranes, in addition to intercellular clefts and fenestrations.'

**Readback check.** Stem content words: erythrocytes, red bone marrow, circulation, intact, hepatocytes, whole plasma proteins, blood, liver, exchange vessels, two organs, possible. Keyed option content words: wide, intercellular, gaps, incomplete, basement, membrane. Zero overlap. The stem supplies only what must cross the wall and never how the wall is built, so a student who cannot rank the capillary types by permeability has no route to the key. audit: replaced the former Choice C, 'Rings of smooth muscle guarding the entrance to each vessel', because precapillary sphincters are a flow-control structure while the other three options were permeability descriptions, which made that option partly eliminable on category alone and violated the single-variable rule. The new Choice C differs from the key in exactly one term, the state of the basement membrane, which is the discriminating detail the textbook states explicitly. Also added the missing textbook citation for the liver half of the stem premise, which the draft asserted without support.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because sinusoid capillaries, the type serving bone marrow and liver, combine extensive intercellular gaps with incomplete basement membranes, and both features are required for intact cells and whole plasma proteins to leave the lumen. The three capillary types form a permeability series: continuous capillaries pass water and small solutes through incomplete tight junctions, fenestrated capillaries add pores that admit larger molecules, and sinusoids add openings large enough for the largest molecules and even cells. A newly made erythrocyte is roughly \(7\ \mu\text{m}\) across, and the narrowest capillaries barely admit one, so no pore or cleft in the other two types could release it. Flow through sinusoids is also very slow, which lengthens the time available for the transfer.
>
> (Choice A) A complete lining sealed by tight junctions describes the continuous capillary, the most common type and the one supplying skeletal muscle and, in its tightest form, the brain. Even where those junctions are incomplete, the resulting clefts admit only water and very small molecules. Such a wall would retain both an erythrocyte and a plasma protein inside the lumen.
>
> (Choice B) Fenestrated capillaries carry pores that widen access to larger molecules and are common in the small intestine, the kidneys, and several endocrine structures. Those pores are still far too small to release an intact cell. The liver and bone marrow require openings well beyond this size range.
>
> (Choice C) This option captures the gaps but keeps the basement membrane intact, and an unbroken basement membrane is itself a continuous sheet that a whole cell cannot cross. The textbook description of a sinusoid pairs the extensive intercellular gaps with incomplete basement membranes for exactly this reason. Widening the spaces between endothelial cells alone is not sufficient.
>
> (Choice D) This is correct. Both barriers are breached in a sinusoid, which is why marrow can deliver new blood cells to the circulation and the liver can release plasma proteins into it. Sinusoids also occur in the spleen, lymph nodes, and several endocrine glands where similar large-particle traffic is required.
>
> This is a Scientific Reasoning and Problem Solving question because you must match the size of the material being transported to the specific wall barriers that a given capillary type does or does not remove.

---

## B2-Q4 — Endothelial Control of Tissue Perfusion

**Stem.** A drug that blocks nitric oxide production in the cells lining blood vessels is infused into the artery supplying one skeletal muscle. That muscle then exercises, and local oxygen falls while lactic acid and hydrogen ions accumulate. How does blood flow through the treated muscle most likely compare with flow through an untreated muscle doing identical work?

- **A.** It rises, but by less than in the untreated muscle  <- **KEY**
- **B.** It rises by more than in the untreated muscle
- **C.** It rises by the same amount as in the untreated muscle
- **D.** It falls below its own pre-exercise resting value

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 90 s |
| Confidence | 5 |

**Correct answer (A): It rises, but by less than in the untreated muscle**

Citations: AP = /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-anatomy-physiology-2e.txt | AP:39685 'Opening of the sphincter is triggered in response to decreased oxygen concentrations; increased carbon' | AP:39686 'dioxide concentrations; increasing levels of lactic acid or other byproducts of cellular metabolism; increasing' | AP:39687 'concentrations of potassium ions or hydrogen ions (falling pH); inflammatory chemicals such as histamines;' | AP:39688 'and increased body temperature. These conditions in turn stimulate the release of NO, a powerful vasodilator,' | AP:39689 'from endothelial cells (see Figure 20.17).' | AP:39691 'the release of endothelins, powerful vasoconstricting peptides secreted by endothelial cells.' | AP:39697 'however, that dilation and constriction of the arterioles feeding the capillary beds is the primary control mechanism.' [CORRECTED: draft cited AP:39696, which reads 'allocated based upon the needs and metabolic state of the tissues as reflected in these parameters. Bear in mind,'] | AP:38599 'The muscle fibers in arterioles are normally slightly contracted, causing arterioles' [CORRECTED: draft cited AP:38601, which reads 'tone of skeletal muscle. In reality, all blood vessels exhibit vascular tone due to the partial contraction of smooth'] | AP:39540 'arterioles are normally partially constricted: With maximal stimulation,' | AP:38488 'recently, the endothelium was viewed simply as the boundary between the blood in the lumen and the walls of the' | AP:38489 'vessels. Recent studies, however, have shown that it is physiologically critical to such activities as helping to' | AP:38490 'regulate capillary exchange and altering blood flow.'

**Distractors**

- **(B)** `reversed_relationship` . _inverts the direction of the blocked mediator's action_ — Nitric oxide released from endothelial cells is a vasodilator, so blocking it cannot increase dilation; the constrictors from those same cells are the endothelins, which are not products of the blocked pathway.
  - Citation: AP:39688 'These conditions in turn stimulate the release of NO, a powerful vasodilator,'; AP:39691 'the release of endothelins, powerful vasoconstricting peptides secreted by endothelial cells.'
- **(C)** `partial_truth` . _true that metabolites act on muscle, false that the lining contributes nothing_ — Metabolites have some direct action, but the textbook route for this response passes through nitric oxide released by the lining cells, so blocking it must reduce the size of the flow increase rather than leave it unchanged.
  - Citation: AP:39685 to 39689 'Opening of the sphincter is triggered in response to decreased oxygen concentrations... These conditions in turn stimulate the release of NO, a powerful vasodilator, from endothelial cells'
- **(D)** `scale_unit_error` . _overshoots the magnitude of the predicted change_ — Losing one dilator pathway blunts the flow response but does not drive arterioles toward maximal constriction; resting arterioles are only partially constricted and remaining local influences hold diameter above rest.
  - Citation: AP:38599 'The muscle fibers in arterioles are normally slightly contracted, causing arterioles'; AP:39540 'arterioles are normally partially constricted: With maximal stimulation,'

**Readback check.** Stem content words: drug, blocks, nitric oxide, production, cells lining blood vessels, infused, artery, skeletal muscle, exercises, oxygen, lactic acid, hydrogen ions, accumulate, blood flow, treated, untreated, identical work. Keyed option content words: rises, less, untreated, muscle. 'Untreated' and 'muscle' appear in every option, so neither discriminates. The stem names the blocked molecule but never states what that molecule does to vessel diameter, which is the tested knowledge, and it never states the direction or size of the expected flow change. audit: rewrote all four options as bare parallel predictions and deleted the because-clauses. The former key read 'It rises less than normal, because arteriolar and sphincter dilation is blunted', which shared the root 'arteri-' with 'the artery supplying' in the stem and was the only option naming a vessel class. The former Choice B, 'because endothelin secretion is blocked as well', was a compound claim differing from the key in two ways at once; the endothelin point now lives in the explanation, and Choice B is a clean single-variable flip of the mediator's direction of action. Corrected two misnumbered citations, described in the citations field.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because the metabolic signals from exercising muscle produce vasodilation largely by prompting the vessel lining to release nitric oxide, so removing that step weakens the flow response without abolishing it. Falling oxygen and rising lactic acid, hydrogen ion, potassium ion, and temperature normally stimulate release of nitric oxide, a powerful vasodilator, from endothelial cells. That mediator diffuses the short distance to the surrounding smooth muscle and relaxes it, opening the precapillary sphincters and, more importantly, the feeding arterioles, which the textbook identifies as the primary control mechanism for tissue perfusion. With production blocked, the same metabolic stimulus reaches the same lining cells but generates far less relaxation, so flow still rises above rest through remaining influences while falling short of the untreated response.
>
> (Choice A) This is correct. The vessel lining acts as a chemical transducer that converts the metabolic state of the tissue into a change in vessel diameter. Blocking the mediator degrades that transduction, so the match between flow and demand becomes poorer without disappearing.
>
> (Choice B) Flow would exceed the untreated response only if the blocked molecule were a constrictor. Nitric oxide is the dilator in this pathway, whereas the constrictors released by the same lining cells are the endothelins, powerful vasoconstricting peptides that appear under the opposite metabolic conditions and are not products of the blocked pathway. Blocking a dilator cannot produce more dilation than normal.
>
> (Choice C) Metabolic byproducts do exert some direct relaxing action on vascular smooth muscle, so this option is not without basis. Its error is treating the lining cells as dispensable. Because a large share of the response is routed through nitric oxide released by those cells, removing it must shrink the flow increase rather than leave it untouched.
>
> (Choice D) Perfusion in an exercising muscle does not drop below its own resting value simply because one dilator pathway is disabled. Arteriolar smooth muscle is only partially constricted at rest, and nothing in this manipulation drives it toward maximal constriction. Remaining local influences still hold net diameter above the resting value.
>
> This is a Scientific Reasoning and Problem Solving question because you must trace a blocked signaling step through the local control of vessel diameter and predict both the direction and the magnitude of the resulting change in flow.

---

## B2-Q5 — Elastic Arteries and Diastolic Flow

**Stem.** A surgeon replaces a \(6\ \text{cm}\) length of a patient's aorta with a rigid synthetic tube of identical inner diameter. Heart rate and cardiac output are unchanged after the operation. How does blood flow in the artery just downstream of the graft most likely change?

- **A.** Peak flow during ejection falls; flow between ejections rises
- **B.** Peak flow during ejection rises; flow between ejections falls  <- **KEY**
- **C.** Peak flow during ejection is unchanged; flow between ejections falls
- **D.** Peak flow during ejection falls; flow between ejections falls

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic medium / structural hard) |
| Estimated time | 110 s |
| Confidence | 5 |
| Hard-tier gate | Meets three conditions. (1) CONCEPT CHAINING: loss of compliance to loss of the between-beat elastic drive to conservation of mean flow under a fixed cardiac output to a higher ejection-phase peak, three linked steps. (3) TRUE PARTIAL-TRUTH TRAP: Choice C is correct about the interval between ejections and fails only on the conservation step. (4) 510-TEMPTING DISTRACTOR: Choice D is where a strong student lands after applying the textbook statement that rigid artery walls greatly increase resistance to blood flow, without noticing that mean flow is pinned by the stated cardiac output. |

**Correct answer (B): Peak flow during ejection rises; flow between ejections falls**

Citations: AP = /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-anatomy-physiology-2e.txt | AP:38557 'However, those close to the heart have the thickest' | AP:38558 'walls, containing a high percentage of elastic fibers in all three of their tunics.' | AP:38559 'elastic artery (Figure 20.4). Vessels larger than 10 mm in diameter are typically elastic. Their abundant elastic' | AP:38564 'fibers allow them to expand, as blood pumped from the ventricles passes through them, and then to recoil after the' | AP:38565 'surge has passed. If artery walls were rigid and unable to expand and recoil, their resistance to blood flow would' | AP:38566 'greatly increase and blood pressure would rise to even higher levels, which would in turn require the heart to pump' | AP:38568 'and flow. Artery walls would have to become even thicker in response to this increased pressure. The elastic recoil' | AP:38569 'of the vascular wall helps to maintain the pressure gradient that drives the blood through the arterial system.' | AP:39036 'Compliance is the ability of any compartment to expand to accommodate increased content. A metal pipe, for' | AP:39037 'example, is not compliant, whereas a balloon is. The greater the compliance of an artery, the more effectively it is' | AP:39039 'more compliant than arteries and can expand to hold more blood. When vascular disease causes stiffening of' | AP:39040 'arteries, compliance is reduced and resistance to blood flow is increased.' | AP:39194 'Compliance allows an artery to expand when blood is pumped through it from the heart, and then to recoil after' | AP:39195 'the surge has passed. This helps promote blood flow.' | AP:39049 'relationships will make these relationships clearer, even if you are weak in math. Focus on the three critical' | AP:39050 'variables: radius (r), vessel length' [CORRECTED: draft cited AP:39046 for this sentence; line 39046 actually reads 'studies of the flow of fluids. Although understanding the math behind the relationships among the factors affecting', so the quotation was attached to a line that does not contain it]

**Distractors**

- **(A)** `reversed_relationship` . _inverts both halves of the prediction_ — A rigid conduit passes ejected volume onward immediately rather than storing it, so the ejection-phase peak rises; and because nothing is stored, forward flow between beats falls rather than rises.
  - Citation: AP:38564 to 38565 'fibers allow them to expand, as blood pumped from the ventricles passes through them, and then to recoil after the surge has passed.'
- **(C)** `partial_truth` . _correct about diastole, fails the conservation step (510-tempting)_ — Flow between ejections does fall, but leaving the ejection peak unchanged would lower mean flow, which cannot happen while cardiac output is held constant; the displaced volume must move during ejection.
  - Citation: AP:38568 to 38569 'The elastic recoil of the vascular wall helps to maintain the pressure gradient that drives the blood through the arterial system.'
- **(D)** `misconception` . _applies the stiffness-raises-resistance rule to mean flow that the stem has already fixed_ — Rigid walls do raise resistance and pressure, but that raises cardiac work rather than lowering mean flow here, because mean flow past the downstream point equals the cardiac output the stem holds constant.
  - Citation: AP:38565 to 38566 'If artery walls were rigid and unable to expand and recoil, their resistance to blood flow would greatly increase and blood pressure would rise to even higher levels'; AP:39049 to 39050 'Focus on the three critical variables: radius (r), vessel length'

**Readback check.** Stem content words: surgeon, replaces, 6 cm, aorta, rigid, synthetic tube, identical inner diameter, heart rate, cardiac output, unchanged, blood flow, artery, downstream, graft. Keyed option content words: peak, flow, ejection, rises, ejections, falls. Only 'flow' overlaps, and it appears in all four options. The stem states the manipulation and the constraint but never mentions elasticity, compliance, storage, or recoil, so the key cannot be read off it. audit: rebuilt all four options into a parallel two-by-two direction matrix and deleted every because-clause. Previously the key was the only option without a causal clause, which is a structural tell, and the distractor reasons made the options non-parallel. More seriously, the draft's Choice D explanation asserted that 'Stiffness of the wall does not by itself add resistance to steady flow through the segment', which contradicts the textbook twice over (AP:38565 to 38566 and AP:39039 to 39040 both state that rigid or stiffened arteries increase resistance to blood flow). That made the old Choice D textbook-defensible and the item ambiguous. Choice D is now eliminated on the airtight ground that mean flow equals the cardiac output the stem holds constant, and the explanation concedes the resistance point explicitly. Re-tiered from medium to hard, since the conservation step is a genuine second link and the resistance trap is endorsed by the textbook itself. Corrected the fabricated-looking citation described in the citations field.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because a compliant aorta stores part of each ejected volume in its stretched wall and returns that volume between beats, and a rigid segment can do neither. Elastic arteries contain a high percentage of elastic fibers in all three tunics, which lets the wall expand as blood is pumped from the ventricle and then recoil after the surge has passed, and that recoil helps maintain the pressure gradient that drives blood through the arterial system between contractions. Replacing part of the wall with rigid material removes its storage capacity, so the volume the aorta would have held is instead forced onward during ejection itself and less remains to be pushed forward afterward. Because the stem fixes cardiac output, average flow past the downstream point cannot change, so a fall in the interval between ejections must be matched by a rise during ejection. The net result is a more pulsatile downstream flow, which is the same reason stiffened arteries widen pulse pressure.
>
> (Choice A) This reverses both halves of the prediction. A rigid conduit cannot expand, so the volume a compliant aorta would have absorbed is transmitted onward immediately and the peak rises rather than falls. Forward movement between beats depends on release of stored elastic energy, so it falls rather than rises.
>
> (Choice B) This is correct. Loss of wall compliance shifts flow out of the interval between beats and into the ejection interval, while mean flow is preserved because cardiac output is unchanged. This is the redistribution that produces the sharp, narrow flow waveform seen downstream of a stiff arterial segment.
>
> (Choice C) The second half of this prediction is right: with no elastic energy stored, forward flow between ejections does fall. The error is leaving the ejection interval untouched, which would make the average flow fall even though cardiac output is stated to be constant. The volume must pass the downstream point at some time in the cycle, and with the graft in place it passes during ejection.
>
> (Choice D) A rigid segment genuinely does raise resistance and pressure, and the textbook notes that if artery walls were rigid their resistance to blood flow would greatly increase. That reasoning predicts a higher workload for the heart, not a lower mean flow here, because mean flow past the downstream point equals the cardiac output that the stem holds constant. Resistance also depends on radius, vessel length, and viscosity, all of which this graft matches.
>
> This is a Scientific Reasoning and Problem Solving question because you must apply the storage and recoil behavior of an elastic artery and then use the fixed cardiac output to determine how the lost volume is redistributed within the cardiac cycle.

---

## B2-Q6 — Testing Endothelial Function in Isolated Vessels

**Stem.** Rings cut from a rabbit artery are precontracted in an organ bath with a direct smooth muscle constrictor, to which every ring responds equally. Undisturbed rings then relax by \(80\%\) when acetylcholine is added, rings whose innermost cell layer was gently abraded relax by \(5\%\), and a nitric oxide donor relaxes both groups by about \(75\%\). Which conclusion do these results best support?

- **A.** Acetylcholine acts on the endothelium, which then releases a diffusible relaxant  <- **KEY**
- **B.** Abrasion destroyed the smooth muscle machinery that nitric oxide acts on
- **C.** Acetylcholine relaxes smooth muscle directly, and abrasion damaged that muscle
- **D.** Smooth muscle itself produces the relaxant in response to acetylcholine

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **hard** (topic hard / structural hard) |
| Estimated time | 120 s |
| Confidence | 5 |
| Hard-tier gate | Meets three conditions. (1) CONCEPT CHAINING: the student must combine three separate result rows, using two of them as controls, before the third becomes interpretable. (2) DATA-TO-MECHANISM: the numerical relaxation values are used to localize a signaling step to a specific cell layer, not merely read off. (4) 510-TEMPTING DISTRACTOR: Choice C is where a strong student lands after assuming acetylcholine must act on the contractile cells and forgetting to check the constrictor control. |

**Correct answer (A): Acetylcholine acts on the endothelium, which then releases a diffusible relaxant**

Citations: AP = /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-anatomy-physiology-2e.txt | AP:39535 'release acetylcholine, which in turn stimulates the vessels endothelial cells to release nitric oxide (NO), which' | AP:39536 'causes vasodilation.' | AP:38484 'The tunica intima (also called the tunica interna) is composed of epithelial and connective tissue layers. Lining the' | AP:38485 'tunica intima is the specialized simple squamous epithelium called the endothelium, which is continuous' | AP:38488 'recently, the endothelium was viewed simply as the boundary between the blood in the lumen and the walls of the' | AP:38489 'vessels. Recent studies, however, have shown that it is physiologically critical to such activities as helping to' | AP:38490 'regulate capillary exchange and altering blood flow.' | AP:39688 'These conditions in turn stimulate the release of NO, a powerful vasodilator,' | AP:39689 'from endothelial cells (see Figure 20.17).' | AP:38520 'The tunica media is the substantial middle layer of the vessel wall (see Figure 20.3). It is generally the thickest' | AP:38521 'layer in arteries, and it is much thicker in arteries than it is in veins. The tunica media consists of layers of smooth' | AP:38522 'muscle supported by connective tissue that is primarily made up of elastic fibers, most of which are arranged in' [CORRECTED: draft cited AP:38520 for 'The tunica media consists of layers of smooth muscle supported by connective tissue'; that sentence begins on line 38521] | [REMOVED: draft cited AP:36417 'endothelium-derived releasing factor, which also relaxes the smooth muscle in the tunica media of coronary'. That line is genuine but sits in the myocardial infarction treatment box of the heart chapter, not the blood vessels chapter, and was being used to support a blood vessels claim.]

**Distractors**

- **(B)** `process_step_confusion` . _contradicted by an explicit control result_ — The nitric oxide donor relaxed abraded rings by about \(75\%\), equal to intact rings, so the machinery through which nitric oxide relaxes the muscle plainly survived the abrasion.
  - Citation: AP:39535 to 39536 'release acetylcholine, which in turn stimulates the vessels endothelial cells to release nitric oxide (NO), which causes vasodilation.'
- **(C)** `partial_truth` . _correct under a different condition, namely if the muscle had been injured_ — The constrictor control shows every ring developed identical tension, so the smooth muscle was undamaged; a damaged muscle would have contracted less as well as relaxed less.
  - Citation: AP:38521 to 38522 'The tunica media consists of layers of smooth muscle supported by connective tissue that is primarily made up of elastic fibers'
- **(D)** `reversed_relationship` . _inverts the cellular source of the mediator_ — Removing the innermost cell layer while leaving the muscle intact abolished the response, which places production of the mediator in the lining rather than in the smooth muscle.
  - Citation: AP:39688 'These conditions in turn stimulate the release of NO, a powerful vasodilator,'; AP:39689 'from endothelial cells'

**Readback check.** Stem content words: rings, rabbit artery, precontracted, organ bath, direct smooth muscle constrictor, undisturbed, relax, 80%, acetylcholine, innermost cell layer, gently abraded, 5%, nitric oxide donor, both groups, 75%. Keyed option content words: acetylcholine, endothelium, releases, diffusible, relaxant. 'Acetylcholine' appears in the stem but also in distractors C and D, so it discriminates nothing. 'Endothelium' and 'diffusible' appear nowhere in the stem; the stem deliberately says 'innermost cell layer' rather than naming the tissue, and never states that the layer produces anything. audit: removed the citation to AP:36417, which comes from the myocardial infarction and nitroglycerine box in the heart chapter, not the blood vessels chapter, and which uses the nonstandard phrase 'endothelium-derived releasing factor'; the claim is fully supported by AP:39535 to 39536 within the correct chapter. Replaced the former Choice B wording 'the smooth muscle receptors that the nitric oxide donor targets', because nitric oxide acts on an intracellular enzyme rather than a surface receptor and the option was not scientifically clean. Replaced the former Choice D, 'Smooth muscle produces nitric oxide only while acetylcholine is present', with a version that differs from the key in exactly one variable, the cell of origin. Repaired an inverted causal clause in the main reasoning that read 'This is exactly why acetylcholine stimulates...', which presented the cause as though it were the consequence. Corrected the misnumbered tunica media citation described in the citations field.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because the two control results eliminate the smooth muscle as the site of the lost response, leaving the abraded cell layer as the necessary intermediary between acetylcholine and relaxation. Equal contraction to a direct constrictor establishes that abrasion left the smooth muscle able to develop tension, so the rubbed rings are not simply dead tissue. Equal relaxation to an exogenous nitric oxide donor establishes that the relaxing machinery downstream of nitric oxide is intact in both groups, so the defect lies upstream of the muscle rather than inside it. Because the only variable that differs between the groups is the presence of the innermost cell layer, acetylcholine must produce relaxation by acting on those cells, which release a diffusible mediator that crosses to the muscle. That inference matches the known pathway in which acetylcholine stimulates endothelial cells to release nitric oxide, which causes vasodilation.
>
> (Choice A) This is correct. The design isolates one variable, the presence of the lining, and includes a separate control for each of the two ways the result could have been an artifact. The inference that the mediator is diffusible follows from the fact that an externally supplied dose of that same mediator restores relaxation in the abraded rings.
>
> (Choice B) The nitric oxide donor relaxed the abraded rings by about \(75\%\), the same as the undisturbed rings. If abrasion had destroyed the machinery through which nitric oxide relaxes the muscle, the donor would have failed in that group. The observed result directly contradicts this claim.
>
> (Choice C) This is the interpretation a strong student reaches by assuming the neurotransmitter must act on the contractile cells themselves. It is ruled out by the constrictor control, which showed that every ring, abraded or not, developed the same tension. Damaged muscle would have contracted less as well as relaxed less.
>
> (Choice D) This places production of the mediator in the wrong cell. The response disappeared when the innermost layer was removed while the muscle was left demonstrably intact, so the muscle cannot be the source. A mediator made by the smooth muscle would have survived abrasion of the lining.
>
> This is a Reasoning about the Design and Execution of Research question because you must evaluate what each control in the protocol rules out and determine which single variable the remaining difference can be attributed to.

---

## B2-Q7 — Venoconstriction and Venous Resistance

**Stem.** After acute blood loss, smooth muscle in both the arterioles and the large veins of a limb contracts. Measurements show that flow through the arterioles falls, while flow through the veins rises. Which structural feature of the veins best accounts for this difference in outcome?

- **A.** Their valves are forced open by rising tension in the wall
- **B.** Their outer connective tissue tunic is the thickest of the three
- **C.** Their walls hold more elastic fibers, so they recoil rather than narrow
- **D.** Their irregular lumens become rounder, presenting less contact surface  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic hard / structural hard) |
| Estimated time | 115 s |
| Confidence | 5 |
| Hard-tier gate | Meets three conditions. (1) CONCEPT CHAINING: contraction to lumen shape change to resistance change to flow change, evaluated separately for two vessel classes. (2) DATA-TO-MECHANISM: the paired flow observations are the evidence from which the structural cause must be inferred, not values to be read off. (3) TRUE PARTIAL-TRUTH TRAP: Choice B states a genuinely correct fact about venous wall layering that simply fails to explain the observation. |

**Correct answer (D): Their irregular lumens become rounder, presenting less contact surface**

Citations: AP = /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-anatomy-physiology-2e.txt | AP:39313 'As previously discussed, vasoconstriction of an artery or arteriole decreases the radius, increasing resistance and' | AP:39314 'pressure, but decreasing flow. Venoconstriction, on the other hand, has a very different outcome. The walls of veins' [CORRECTED: draft cited AP:38313 for the vasoconstriction sentence; line 38313 actually reads 'atrioventricular node contribute to cardiac', so the citation was off by one thousand lines and landed in the heart chapter] | AP:39315 'are thin but irregular; thus, when the smooth muscle in those walls constricts, the lumen becomes more rounded.' | AP:39316 'The more rounded the lumen, the less surface area the blood encounters, and the less resistance the vessel offers.' | AP:39317 'Vasoconstriction increases pressure within a vein as it does in an artery, but in veins, the increased pressure' | AP:39318 'increases flow. Recall that the pressure in the atria, into which the venous blood will flow, is very low, approaching' | AP:39319 'zero for at least part of the relaxation phase of the cardiac cycle. Thus, venoconstriction increases the return of' | AP:39307 'flow. Since approximately 64 percent of the total blood volume resides in systemic veins, any action that increases' | AP:39308 'the flow of blood through the veins will increase venous return to the heart.' | AP:38820 'arterioles, venoconstriction may be likened to a stiffening of the vessel wall. This increases pressure on the blood' (the source places the word stiffening in quotation marks) | AP:38821 'within the veins, speeding its return to the heart.' | AP:38512 'in veins. In addition, many veins, particularly in the lower limbs, contain valves formed by sections of thickened' | AP:38513 'endothelium that are reinforced with connective tissue, extending into the lumen.' | AP:38548 'This is normally the thickest tunic in veins and may be thicker' | AP:38543 'This structure is not usually seen in smaller arteries, nor is it seen in veins.' [CORRECTED: draft cited AP:38542, which reads 'arteries is the external elastic membrane (also called the external elastic lamina), which also appears wavy in'] | AP:38511 'small openings that allow exchange of materials between the tunics. The internal elastic membrane is not apparent'

**Distractors**

- **(A)** `misconception` . _treats passive valves as an active driving force_ — Venous valves are passive folds of thickened endothelium reinforced with connective tissue that respond to the pressure difference across them; they enforce direction of flow but generate no propulsive force.
  - Citation: AP:38512 to 38513 'many veins, particularly in the lower limbs, contain valves formed by sections of thickened endothelium that are reinforced with connective tissue, extending into the lumen.'
- **(B)** `partial_truth` . _true statement about venous wall layering that does not explain the observation_ — The tunica externa is indeed normally the thickest tunic in a vein, but wall thickness says nothing about how lumen geometry, and therefore resistance, changes when the smooth muscle shortens.
  - Citation: AP:38548 'This is normally the thickest tunic in veins and may be thicker'; AP:38549 'than the tunica media in some larger arteries.'
- **(C)** `reversed_relationship` . _assigns an arterial wall composition to veins_ — Collagenous and smooth fibers predominate in the venous tunica externa, and veins lack the internal and external elastic membranes of larger arteries, so recoil is not the distinguishing venous property.
  - Citation: AP:38472 'Collagenous and smooth fibers' with AP:38474 'predominate' (Table 20.1, vein column); AP:38511 to 38512 'The internal elastic membrane is not apparent in veins.'; AP:38543 'This structure is not usually seen in smaller arteries, nor is it seen in veins.'

**Readback check.** Stem content words: acute blood loss, smooth muscle, arterioles, large veins, limb, contracts, measurements, flow, falls, rises, structural feature, difference, outcome. Keyed option content words: irregular, lumens, rounder, presenting, contact, surface. Zero overlap after revision. The stem supplies the two flow observations, which is data to reason from, and withholds any statement about lumen shape or resistance. All four options describe real properties of veins, so none can be eliminated without knowing how venous geometry changes on constriction. audit: removed the word 'blood' from the key, which previously read 'reducing the surface blood contacts' and echoed 'blood loss' in the stem. Corrected a citation that was off by exactly one thousand lines, described in the citations field, plus two other line-number errors. Also verified that the stem does not name sympathetic outflow or any hormone, keeping it clear of the Bio Ch4 and Bio Ch5 scope boundaries even though the textbook attributes venoconstriction to vasomotor sympathetic stimulation.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because the wall of a relaxed vein is thin but irregular, and contraction of its smooth muscle makes the lumen rounder, which lowers rather than raises the resistance the vessel offers. In an arteriole the lumen is already round, so contraction can only reduce the radius, and since resistance rises steeply as radius falls the result is less flow. In a vein the same contraction changes lumen shape, and the more rounded the lumen the less surface area the blood encounters and the less resistance the vessel offers. Constriction also raises pressure within the vein, and because atrial pressure approaches zero for at least part of the relaxation phase of the cardiac cycle, that higher upstream pressure across a lowered resistance increases flow toward the heart. This is how the roughly \(64\%\) of total blood volume that resides in the systemic veins is mobilized after hemorrhage.
>
> (Choice A) Venous valves are passive folds of thickened endothelium reinforced with connective tissue, and they open or close according to the pressure difference across them rather than according to tension in the surrounding wall. They enforce the direction of flow but add no propulsive force. Removing them would permit backflow, not abolish the observed increase.
>
> (Choice B) It is true that the tunica externa is normally the thickest tunic in a vein, unlike in most arteries. That fact describes what surrounds the vessel but does not explain why contraction lowers venous resistance while raising arteriolar resistance. Wall thickness alone predicts nothing about how lumen geometry changes when the muscle shortens.
>
> (Choice C) Veins are not richer in elastic fibers than arteries; in the venous tunica externa the collagenous and smooth fibers predominate, while a high percentage of elastic fibers is characteristic of the large arteries near the heart. Veins also lack the internal and external elastic membranes seen in larger arteries. Recoil is therefore not the property that distinguishes the venous response.
>
> (Choice D) This is correct. The change in lumen shape is what makes venous contraction behave oppositely to arteriolar contraction, and it is why increasing venous tone raises the volume of blood returned to the heart. The effect is often described as a stiffening of the venous wall rather than a true narrowing.
>
> This is a Scientific Reasoning and Problem Solving question because you must reason from an unexpected pair of flow measurements back to the difference in lumen geometry that lets one contraction produce opposite effects in two vessel classes.

---

## B2-Q8 — Consequences of Endothelial Denudation

**Stem.** A catheter strips the innermost cell layer from a \(2\ \text{cm}\) segment of a large muscular artery, leaving the deeper wall layers intact. Which of the following are expected at this segment?

I. Platelets adhere to exposed collagenous fibers.
II. Local release of a vasoconstricting peptide is lost.
III. Smooth muscle of the tunica media loses its nutrient supply.

- **A.** I only
- **B.** II and III only
- **C.** I and II only  <- **KEY**
- **D.** I, II, and III

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic hard / structural hard) |
| Estimated time | 120 s |
| Confidence | 5 |
| Hard-tier gate | Meets three conditions. (1) CONCEPT CHAINING: three separate mechanisms (platelet adhesion to subendothelial collagen, endothelial secretion of endothelins, and vasa vasorum routing) must each be traced from the same injury before the option set resolves. (3) TRUE PARTIAL-TRUTH TRAP: statement III rests on a true fact, that the media of a large vessel cannot be nourished by luminal diffusion alone, and is false only in attributing that supply to the luminal lining. (4) 510-TEMPTING DISTRACTOR: Choice D captures the strong student who assumes every wall function depends on the lining. |

**Correct answer (C): I and II only**

Citations: AP = /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-anatomy-physiology-2e.txt | AP:38484 'The tunica intima (also called the tunica interna) is composed of epithelial and connective tissue layers. Lining the' | AP:38485 'tunica intima is the specialized simple squamous epithelium called the endothelium, which is continuous' | AP:38486 'throughout the entire vascular system, including the lining of the chambers of the heart. Damage to this endothelial' | AP:38487 'lining and exposure of blood to the collagenous fibers beneath is one of the primary causes of clot formation.' [CORRECTED: draft attributed this whole sentence to AP:38486; it begins on 38486 and completes on 38487] | AP:38490 'regulate capillary exchange and altering blood flow. The endothelium releases local chemicals called endothelins' | AP:38491 'that can constrict the smooth muscle within the walls of the vessel to increase blood pressure.' | AP:34633 'platelets, which normally float free in the plasma, encounter the area of vessel rupture with the' | AP:34634 'exposed underlying connective tissue and collagenous fibers. The platelets begin to clump together, become spiked' | AP:34635 'and sticky, and bind to the exposed collagen and endothelial lining.' [CORRECTED: draft attributed the full platelet sentence to AP:34635; it begins on 34634] | AP:34862 'Thrombi are most commonly caused by vessel damage to the endothelial lining, which activates the clotting' | AP:38423 'remove waste from the vessel's cells. Further, the walls of the larger vessels are too thick for nutrients to diffuse' | AP:38424 'through to all of the cells. Larger arteries and veins contain small blood vessels within their walls known as the vasa' [CORRECTED: draft cited AP:38422 for the vasa vasorum definition; line 38422 actually reads 'relatively quickly, there is limited opportunity for blood in the lumen of the vessel to provide nourishment to or'] | AP:38425 '(the phrase vessels of the vessel, set off by dashes in the source, is elided here to honor the no-dash rule) to provide them with this critical exchange. Since the pressure within' | AP:38426 'arteries is relatively high, the vasa vasorum must function in the outer layers of the vessel (see Figure 20.3) or the' | AP:38427 'pressure exerted by the blood passing through the vessel would collapse it, preventing any exchange from' | AP:38432 'The lower pressure within veins allows the vasa vasorum to be located closer to the lumen.' | AP:39691 'the release of endothelins, powerful vasoconstricting peptides secreted by endothelial cells.'

**Distractors**

- **(A)** `partial_truth` . _recognizes the barrier role, misses the secretory role_ — Statement II is also correct: the endothelium releases endothelins that constrict the smooth muscle within the vessel wall, so a denuded segment has no local source of that constrictor.
  - Citation: AP:38490 to 38492 'The endothelium releases local chemicals called endothelins that can constrict the smooth muscle within the walls of the vessel to increase blood pressure.'
- **(B)** `process_step_confusion` . _pairs a correct consequence with an unrelated supply claim while discarding the best established one_ — Statement I is the classic consequence of endothelial damage and cannot be excluded, while statement III concerns a supply route that an intraluminal injury does not disturb.
  - Citation: AP:38486 to 38487 'Damage to this endothelial lining and exposure of blood to the collagenous fibers beneath is one of the primary causes of clot formation.'
- **(D)** `misconception` . _assumes all wall functions depend on the luminal lining (510-tempting)_ — The tunica media of a large vessel is nourished by vasa vasorum within the wall, which in arteries must lie in the outer layers because luminal pressure would collapse them, and are therefore unaffected by a catheter acting from the lumen.
  - Citation: AP:38424 'Larger arteries and veins contain small blood vessels within their walls known as the vasa'; AP:38426 to 38427 'the vasa vasorum must function in the outer layers of the vessel (see Figure 20.3) or the pressure exerted by the blood passing through the vessel would collapse it'

**Readback check.** Stem content words: catheter, strips, innermost cell layer, 2 cm, segment, large muscular artery, deeper wall layers, intact, expected. The Roman numeral statements introduce platelets, collagenous fibers, vasoconstricting peptide, tunica media, nutrient supply, none of which the stem asserts or hints at. The stem describes only the manipulation and supplies no information about what lies beneath the lining, what the lining secretes, or where wall nutrition comes from. audit: rewrote statement II. It previously read 'Locally triggered vasodilation is impaired', which made this the third item in an eight-item unit whose crux was endothelial nitric oxide, alongside the nitric oxide blockade item and the organ bath item. Statement II now tests endothelial secretion of the constrictor peptide, which is distinct content and widens the unit's coverage. Statement II is deliberately worded as 'a vasoconstricting peptide' rather than naming endothelin, because the word endothelin shares a visible root with endothelium and would have let a student judge the statement true from morphology alone. Corrected four line-number errors in the vasa vasorum and endothelium citations, described in the citations field.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because stripping the lining both exposes the underlying collagen to circulating platelets and removes the cells that secrete the wall's local constrictor peptide, while nourishment of the middle layer arrives from outside the vessel and is untouched. Statement I holds because damage to the endothelial lining and exposure of blood to the collagenous fibers beneath is one of the primary causes of clot formation, and platelets meeting exposed collagen clump together, become spiked and sticky, and bind to it. Statement II holds because the endothelium releases local chemicals called endothelins that constrict the smooth muscle within the vessel wall to increase blood pressure, so a denuded segment has no local source of them. Statement III fails because the wall of a large vessel is too thick for nutrients to diffuse through to all of its cells and is instead supplied by the vasa vasorum, small vessels running within the wall; in an artery these are confined to the outer layers, since luminal pressure would collapse them if they lay nearer the lumen, so a catheter acting from inside does not disturb them.
>
> (Choice A) This selects the clotting consequence and rejects the secretory one. It treats the lining only as a physical barrier over collagen. The same cells are an active chemical source, so their loss also removes a local influence on the diameter of the vessel.
>
> (Choice B) This accepts the secretory consequence but pairs it with a wall-nutrition claim that does not follow. It also discards the best established consequence of endothelial damage, which is platelet adhesion on exposed collagen. Both halves of this option are misjudged.
>
> (Choice C) This is correct. A barrier function and a secretory function are both lost when the lining is removed, and both losses act at the same segment. Nutrition of the deeper wall travels a separate route that this injury does not interrupt.
>
> (Choice D) This is the response of a student who assumes that every function of the vessel wall depends on the lining. The tunica media of a large artery is fed by vasa vasorum reaching it from the tunica externa, not by diffusion from the lumen. Because those vessels lie in the outer layers and are approached from outside, an injury delivered from inside the lumen leaves them intact.
>
> This is a Scientific Reasoning and Problem Solving question because you must evaluate three independent wall functions against a single anatomical injury and determine which of them depend on the layer that was removed.

---

## B2-Q9 — Hepatic Portal Route

**Stem.** A radiolabeled tracer is injected into a capillary in the wall of the jejunum. Investigators follow the label until it first reaches the inferior vena cava. Which vascular bed does the label most likely traverse along that route?

- **A.** The glomerular capillaries of the kidney
- **B.** The pulmonary capillaries of the lung
- **C.** The hepatic sinusoids of the liver  <- **KEY**
- **D.** The venous sinuses of the spleen

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic easy / structural easy) |
| Estimated time | 60 s |
| Confidence | 5 |

**Correct answer (C): The hepatic sinusoids of the liver**

Citations: AP:41263-41266 verbatim: 'Portal systems begin and end in capillaries. In this case, the initial capillaries from the stomach, small intestine, large intestine, and spleen lead to the hepatic portal vein and end in specialized capillaries within the liver, the hepatic sinusoids.' | AP:41274 verbatim: 'itself is relatively short, beginning at the level of L2 with the confluence of the superior mesenteric and splenic veins.' | AP:41275-41276 verbatim: 'The superior mesenteric vein receives blood from the small intestine, two-thirds of the large intestine, and the stomach.' | AP:41278-41279 verbatim: 'The splenic vein is formed from branches from the spleen, pancreas, and portions of the stomach, and the inferior mesenteric vein.' | AP:41285-41287 verbatim: 'This processed blood, as well as the systemic blood that came from the hepatic artery, exits the liver via the right, left, and middle hepatic veins, and flows into the inferior vena cava.' | AP:42519-42521 verbatim: 'Upon entering the spleen, the splenic artery splits into several arterioles (surrounded by white pulp) and eventually into sinusoids. Blood from the capillaries subsequently collects in the venous sinuses and leaves via the splenic vein.' | AP:31903-31912 verbatim: 'The human body has three portal systems: two venous (hypophyseal and hepatic) and one arterial (renal).'

**Distractors**

- **(A)** `adjacent_fact` . _right structure, wrong circuit_ — The glomerulus is a genuine first capillary bed, but of the renal portal system, and it is supplied by renal arteries arising from the aorta. Jejunal venous blood cannot reach the aorta without first crossing the liver, the vena cava, the right heart, and the lungs.
  - Citation: AP:52533-52535
- **(B)** `process_step_confusion` . _correct bed, later step_ — Pulmonary capillaries lie downstream of the inferior vena cava and the right ventricle, so they are reached only after the endpoint specified in the stem. The single varied feature is where the bed sits relative to the stated endpoint.
  - Citation: AP:41285-41287
- **(D)** `reversed_relationship` . _flow direction reversed_ — Splenic blood drains through the splenic vein into the hepatic portal vein, so the direction of flow is spleen to liver. The single varied feature is the direction of flow between two organs that both feed the portal vein.
  - Citation: AP:41278-41279

**Readback check.** Stem content words: radiolabeled, tracer, injected, capillary, wall, jejunum, investigators, follow, label, reaches, inferior vena cava, vascular bed, traverse, route. Keyed option content words: hepatic, sinusoids, liver. Zero overlap, so no stem echo. The stem names only an injection site and an endpoint, never the intervening anatomy, so a student who does not know intestinal venous drainage cannot answer from the stem. All four options name real vascular beds, so this is not an only-real-option item. AUDIT CHANGES: (1) added the missing interrogative sentence, since the draft stem was two declarative sentences with no question and therefore left the options grammatically orphaned; (2) reordered options so the key is C, correcting a batch-level answer-letter imbalance in which no item was keyed C and three were keyed D; (3) replaced 'The red pulp sinusoids of the spleen' with 'The venous sinuses of the spleen' because AP:42520 uses 'venous sinuses' and never uses the phrase 'red pulp sinusoids'; (4) changed 'capillary bed' to 'vascular bed' in the stem so the question wording covers the sinus option; (5) corrected citation AP:41278 to AP:41278-41279 and AP:41286-41287 to AP:41285-41287, both of which cut the quoted sentence short of its actual end.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because blood leaving the intestinal capillaries enters the hepatic portal vein and must cross a second capillary bed inside the liver before reaching the inferior vena cava. Portal systems begin and end in capillaries, and the hepatic portal system links the capillaries of the stomach, intestines, and spleen to the hepatic sinusoids. Blood from the jejunum collects in the superior mesenteric vein, which meets the splenic vein to form the hepatic portal vein. Only after the sinusoids drain into central veins and then the hepatic veins does this blood join the inferior vena cava. A label placed in a jejunal capillary therefore contacts liver tissue before it ever mixes with the general venous return.
>
> (Choice A) The glomerular capillaries sit in the renal circulation, which is fed by renal arteries arising from the aorta. A label in a jejunal capillary could reach the aorta only after traversing the liver, the vena cava, the right heart, the lungs, and the left heart. The glomerulus is the first bed of a different portal arrangement and lies nowhere on the route described.
>
> (Choice B) The pulmonary capillaries are reached only after blood has entered the inferior vena cava and passed through the right atrium and right ventricle. Because the trace ends at the inferior vena cava, the pulmonary bed lies beyond the endpoint rather than between the two points named. Placing it on this route confuses a later step with an intervening one.
>
> (Choice C) Blood from jejunal capillaries collects in the superior mesenteric vein, joins the hepatic portal vein, and perfuses the hepatic sinusoids. Those sinusoids are the second capillary bed of the hepatic portal system, and their outflow reaches the inferior vena cava by way of the right, left, and middle hepatic veins. Two capillary beds arranged in series is precisely what defines a portal system.
>
> (Choice D) Splenic blood collects in venous sinuses and leaves through the splenic vein, which meets the superior mesenteric vein to form the hepatic portal vein. Flow in that vessel therefore runs from the spleen toward the liver. Intestinal blood never enters the spleen on its way out of the abdomen, so the direction implied here is inverted.
>
> This is a Knowledge of Scientific Concepts and Principles question because you must recall the vessel sequence connecting an intestinal capillary bed to the inferior vena cava.

---

## B2-Q10 — Dual Blood Supply Of The Liver

**Stem.** At the porta hepatis, the hepatic portal vein supplies the liver with more oxygen each minute than the much smaller hepatic artery does. Its blood nonetheless carries less oxygen per \(100\ \text{mL}\) than the arterial blood alongside it. Which feature of the portal circuit best accounts for the lower oxygen content?

- **A.** Oxygen was extracted by the capillary beds of the digestive organs  <- **KEY**
- **B.** Oxygen was consumed within the wall of the portal vein itself
- **C.** Oxygen was diluted by water and nutrients absorbed from the gut
- **D.** Oxygen was never loaded because this blood bypasses the lungs

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic easy / structural medium) |
| Estimated time | 80 s |
| Confidence | 5 |

**Correct answer (A): Oxygen was extracted by the capillary beds of the digestive organs**

Citations: AP:48814 verbatim: 'The porta hepatis is where the hepatic artery and hepatic portal vein enter the liver.' | AP:48816-48818 verbatim: 'the hepatic artery delivers oxygenated blood from the heart to the liver. The hepatic portal vein delivers partially deoxygenated blood containing nutrients absorbed from the small intestine and actually supplies more oxygen to the liver than do the much smaller hepatic arteries.' | AP:48847-48848 verbatim: 'A hepatic sinusoid is an open, porous blood space formed by fenestrated capillaries from nutrient-rich hepatic portal veins and oxygen-rich hepatic arteries.' | AP:41283-41284 verbatim: 'Because of the hepatic portal system, the liver receives its blood supply from two different sources: from normal systemic circulation via the hepatic artery and from the hepatic portal vein.' | AP:41263-41266 verbatim: 'Portal systems begin and end in capillaries. In this case, the initial capillaries from the stomach, small intestine, large intestine, and spleen lead to the hepatic portal vein and end in specialized capillaries within the liver, the hepatic sinusoids.' | AP:41278-41279 verbatim: 'The splenic vein is formed from branches from the spleen, pancreas, and portions of the stomach, and the inferior mesenteric vein.'

**Distractors**

- **(B)** `misconception` . _oxygen loss relocated to the conduit_ — The single varied element is the site of oxygen loss, moved from the upstream capillary beds to the vein itself. A large vein wall consumes a negligible share of luminal oxygen, and portal blood is already oxygen poor at the moment the vein forms.
  - Citation: AP:48816-48818
- **(C)** `misconception` . _dilution substituted for extraction_ — The single varied element is the cause of the low reading, changed from extraction to dilution. Nutrient and water absorption is what makes portal blood nutrient rich; it does not appreciably lower oxygen carried per unit volume.
  - Citation: AP:48847-48848
- **(D)** `misconception` . _second systemic pass mistaken for pulmonary bypass_ — The single varied element is the point in the circuit at which oxygen is said to be missing, moved from the gut to the lungs. This blood reached the digestive organs as fully oxygenated systemic arterial blood, so it did traverse the pulmonary circuit.
  - Citation: AP:41263-41266

**Readback check.** Stem content words: porta hepatis, hepatic portal vein, supplies, liver, oxygen, each minute, smaller, hepatic artery, blood, carries, 100 mL, arterial, feature, portal circuit, accounts, lower, content. Keyed option content words: oxygen, extracted, capillary beds, digestive organs. The only shared word is 'oxygen', which opens all four options identically and therefore cannot discriminate; the keyed option's discriminating terms (extracted, capillary beds, digestive organs) are absent from the stem. The stem never states where portal blood comes from, so the causal link must be supplied by the student. All four options name real, topic-associated mechanisms of low oxygen content. AUDIT CHANGES: this item was rebuilt. (1) FACTUAL DEFECT: the draft premise (clamping the hepatic artery renders hepatocytes hypoxic while portal flow continues) is contradicted by the primary textbook at AP:48817-48818, which states the portal vein 'actually supplies more oxygen to the liver than do the much smaller hepatic arteries'; the premise was replaced by that textbook fact, now used as data to reason from rather than a false setup. (2) STEM ECHO: the draft stem used 'perfuse' while the keyed option used 'perfused'; both were removed from the stem. (3) The draft stem was two declarative sentences with no interrogative, leaving the 'It has already perfused...' options without an antecedent; an explicit question was added. (4) Options were rewritten to a single grammatical frame ('Oxygen was ...') varying only the site or mechanism of oxygen loss, so each distractor now differs from the key in exactly one way; the draft's 'higher pressure' and 'shunted past hepatocytes' options answered a different question than the one asked. (5) Citation AP:48847 corrected to AP:48847-48848, since the quoted sentence continues onto the next line.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because portal blood reaches the liver only after passing through the capillary networks of the stomach, intestines, pancreas, and spleen, which draw oxygen out of it before it ever arrives. Portal systems begin and end in capillaries, so by definition the blood entering the second bed has already been altered by the first. That is why the liver needs two inflows: an oxygen rich stream delivered by the hepatic artery and a partially deoxygenated but nutrient rich stream delivered by the hepatic portal vein. Content per unit volume and total delivery are separate quantities, so the portal vein can be the poorer blood and still the larger absolute oxygen source, because its volume of flow is far greater than that of the much smaller hepatic arteries.
>
> (Choice A) Portal blood enters the hepatic sinusoids only after perfusing the splanchnic capillaries, where the digestive organs extract oxygen for their own metabolism. Its oxygen content is therefore well below arterial values, which is exactly why a separate arterial supply exists at all. The large portal flow is what still makes this stream the greater absolute oxygen source.
>
> (Choice B) The wall of a large vein consumes a negligible fraction of the oxygen passing through its lumen, and thick vessel walls are served by their own small vessels rather than by the luminal stream. Assigning the deficit to the vein itself skips over the upstream capillary networks where extraction actually occurs. The oxygen content of portal blood is already low at the moment the vein is formed.
>
> (Choice C) Water and nutrients absorbed across the intestinal wall do enter the portal blood, but solute and fluid addition does not appreciably lower the oxygen carried per unit volume. Oxygen content is set by how much has been unloaded to tissue, not by what has been added to plasma. Nutrient loading explains why the portal vein is called nutrient rich, not why it is oxygen poor.
>
> (Choice D) This blood did pass through the lungs. It arrived at the digestive organs as fully oxygenated systemic arterial blood delivered by the mesenteric and splenic arteries, and only then lost oxygen to those tissues. Treating portal blood as though it had never been oxygenated confuses a second pass through the systemic circuit with a bypass of the pulmonary circuit.
>
> This is a Scientific Reasoning and Problem Solving question because you must apply the two beds in series arrangement of a portal system to explain the oxygen content of blood arriving at the second organ.

---

## B2-Q11 — Hypophyseal Portal Architecture

**Stem.** A tracer is released into the primary capillary plexus of the hypophyseal portal system in an anesthetized rat and followed to the secondary plexus in the anterior pituitary. Which of the following would most likely be observed?

I. The tracer arrives at the secondary plexus at a higher concentration than an equal dose given into a systemic vein.
II. The tracer reaches the secondary plexus without first passing through the heart.
III. The tracer passes through an arteriole located between the two plexuses.

- **A.** I only
- **B.** III only
- **C.** I and II only  <- **KEY**
- **D.** I and III only

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 95 s |
| Confidence | 5 |

**Correct answer (C): I and II only**

Citations: AP:31902-31903 verbatim: 'This network, called the hypophyseal portal system, allows hypothalamic hormones to be transported to the anterior pituitary without first entering the systemic circulation.' | AP:31903-31912 verbatim: 'The human body has three portal systems: two venous (hypophyseal and hepatic) and one arterial (renal).' | AP:31912-31916 verbatim: 'The hypophyseal portal system originates from the superior hypophyseal artery, which branches off the carotid arteries and transports blood to the hypothalamus. The branches of the superior hypophyseal artery form the hypophyseal portal system (see Figure 17.9). Hypothalamic releasing and inhibiting hormones travel through a primary capillary plexus to the portal veins, which carry them into the anterior pituitary.' | AP:52533-52535 verbatim: 'Since a capillary bed (the glomerulus) drains into a vessel that in turn forms a second capillary bed, the definition of a portal system is met. This is the only portal system in which an arteriole is found between the first and second capillary beds.' | BIO:49583-49584 verbatim: 'A portal system carries blood from one capillary network to another'

**Distractors**

- **(A)** `partial_truth` . _incomplete true set_ — Statement I is genuinely true, but statement II is equally true, so the single varied element is completeness of the true set. Undiluted delivery and cardiac bypass are two consequences of the same venous connection and cannot be separated.
  - Citation: AP:31902-31903
- **(B)** `misconception` . _false item selected alone_ — The single varied element is which statement is judged true. Statement III is false for this circuit, since an interposed arteriole is unique to the renal portal system, and selecting it alone also discards two correct statements.
  - Citation: AP:52533-52535
- **(D)** `adjacent_fact` . _cross-system feature transfer_ — The single varied element is the substitution of statement III for statement II. This transplants the renal system's defining feature onto the hypophyseal circuit, whose plexuses are joined by portal veins, which is why it is classified as venous.
  - Citation: AP:31903-31912

**Readback check.** Stem content words: tracer, released, primary capillary plexus, hypophyseal portal system, anesthetized rat, secondary plexus, anterior pituitary. The keyed option is a Roman numeral combination ('I and II only'), so no content word can echo. Each numbered statement supplies a testable claim rather than a conclusion, and discriminating among them requires knowing that only the renal portal system interposes an arteriole. A student who does not know that fact cannot separate statement III from statements I and II. AUDIT CHANGES: (1) the draft placed the primary capillary plexus 'within the infundibulum', but AP:31913-31916 locates the primary plexus where the superior hypophyseal artery delivers blood to the hypothalamus and describes the portal veins as the vessels carrying material onward, so the stem now identifies the plexus by its system membership rather than by a contested location; (2) option order was corrected to the standard single-item-then-combination sequence and the key moved to C, which also corrects a batch-level answer-letter imbalance; (3) explanation blocks were reordered to match; (4) 'Which of the following would be observed?' was hedged to 'would most likely be observed'; (5) citation AP:31914-31918 corrected to AP:31912-31916, because the quoted sentence ends at line 31916 and lines 31917 onward describe the secondary plexus rather than the primary one.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because the two plexuses are joined by veins that deliver the tracer directly and without systemic dilution, while an interposed arteriole belongs to the renal circuit alone. A portal system carries blood from one capillary network to another, so material entering the first plexus travels to the anterior pituitary without first entering the systemic circulation. Skipping systemic mixing keeps the delivered concentration far above what an equal dose spread through the whole blood volume would produce, which validates statement I. Bypassing the general circulation also means the tracer never traverses the right atrium, the right ventricle, or the lungs before arriving, which validates statement II. Statement III describes the renal arrangement, the only portal system in which an arteriole is found between the first and second capillary beds, whereas the hypophyseal and hepatic systems connect their beds through veins.
>
> (Choice A) Statement I is correctly accepted, but restricting the answer to I alone overlooks that portal delivery also bypasses the heart. Blood moving from the first plexus to the second never returns to the right atrium along the way, so statement II follows from the same venous connection that makes statement I true.
>
> (Choice B) Statement III is the one false item in the list, so selecting it alone both endorses an error and discards two correct statements. Placing an arteriole between the plexuses imports a feature of the renal circulation, where the efferent arteriole links the glomerulus to the peritubular capillaries. The hypophyseal beds are linked by portal veins instead.
>
> (Choice C) Statements I and II both follow from a venous connection between two capillary beds: no systemic dilution and no intervening trip through the heart. Statement III is excluded because an interposed arteriole occurs in only one of the three human portal systems, and this is not that one. The vessels crossing the infundibulum are portal veins, which is why this system is classified as venous rather than arterial.
>
> (Choice D) Statement I is correct, but pairing it with III transplants the unique renal arrangement onto the hypophyseal circuit. Because the connection between the two plexuses is venous, no arteriole intervenes. This response also omits statement II, which is true for the same reason statement I is.
>
> This is a Scientific Reasoning and Problem Solving question because you must apply the structural definition of a portal system to predict both the concentration and the route of a tracer.

---

## B2-Q12 — Peritubular Capillary Conditions

**Stem.** In a renal perfusion study, plasma protein concentration measures \(7.0\ \text{g/dL}\) in the renal artery, \(8.7\ \text{g/dL}\) in the efferent arteriole, and \(7.1\ \text{g/dL}\) in the renal vein. These values most directly predict which condition in the capillary bed fed by the efferent arteriole?

- **A.** A hydrostatic pressure high enough to drive net filtration
- **B.** A colloid osmotic pressure high enough to drive net uptake  <- **KEY**
- **C.** A colloid osmotic pressure lower than that in the renal artery
- **D.** A hydrostatic pressure as high as that in the glomerular capillaries

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 95 s |
| Confidence | 5 |

**Correct answer (B): A colloid osmotic pressure high enough to drive net uptake**

Citations: AP:52846-52848 verbatim: 'This means that red and white blood cells, platelets, albumins, and other proteins too large to pass through the filter remain in the capillary, creating an average colloid osmotic pressure of 30 mm Hg within the capillary.' | AP:52600-52601 verbatim: 'As blood passes through the glomerulus, 10 to 20 percent of the plasma filters between these sieve-like fingers to be captured by Bowman's capsule and funneled to the PCT.' | AP:53129-53132 verbatim: 'The glomerulus has a relatively high pressure inside its capillaries and can sustain this by dilating the afferent arteriole while constricting the efferent arteriole. This assures adequate filtration pressure even as the systemic blood pressure varies. Movement of water into the peritubular capillaries and vasa recta will be influenced primarily by osmolarity and concentration gradients.' | AP:52531-52533 verbatim: 'As the glomerular filtrate progresses through the nephron, these capillary networks recover most of the solutes and water, and return them to the circulation.' | AP:53947-53948 verbatim: 'peritubular capillaries second capillary bed of the renal portal system'

**Distractors**

- **(A)** `reversed_relationship` . _first-bed property assigned to second bed_ — The single varied element is which bed the driving force is assigned to. Net filtration driven by high hydrostatic pressure characterizes the upstream bed, whereas blood entering the bed beyond the efferent arteriole has already lost pressure across a capillary network and a resistance vessel.
  - Citation: AP:53129-53131
- **(C)** `misconception` . _dilution assumed instead of concentration_ — The single varied element is the direction of the reported change. The values rise rather than fall, so colloid osmotic pressure entering the second bed exceeds the arterial value; filtration removes a protein free fluid, which concentrates rather than dilutes the remaining plasma proteins.
  - Citation: AP:52846-52848
- **(D)** `misconception` . _series beds treated as isobaric_ — The single varied element is the assumed pressure relationship between the two beds. Beds in series separated by an arteriole cannot share the same hydrostatic pressure, because that vessel imposes a pressure drop, and equal pressures would abolish the reabsorptive behavior of the downstream bed.
  - Citation: AP:52533-52535

**Readback check.** Stem content words: renal perfusion study, plasma protein concentration, renal artery, efferent arteriole, renal vein, values, predict, condition, capillary bed. Keyed option content words: colloid, osmotic, pressure, high, drive, net, uptake. No overlap. The stem supplies raw measurements only and never names osmotic pressure or the direction of fluid movement, so the student must supply the protein to oncotic pressure link and then the direction of net flux. Options A and D are real hemodynamic states of the upstream bed, so none can be eliminated without topic knowledge. AUDIT CHANGES: (1) options B and D were reworded so all four share the frame 'A [pressure type] [qualifier]', restoring grammatical parallelism the draft lacked; (2) the explanation asserted 'Roughly one fifth of the plasma entering the first bed is filtered away' as a bare fact, which the textbook does not state in that form; it now reports the textbook's actual range of \(10\%\) to \(20\%\) and notes that the given data sit near the top of it, with AP:52600-52601 added as the supporting citation; (3) the misnumbered citation AP:52531-52532 was corrected to AP:52531-52533, since the quoted sentence ends with 'circulation' on line 52533; (4) citation AP:52847-52848 was expanded to AP:52846-52848 so the excerpt begins at the start of the sentence.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because concentrating plasma proteins raises colloid osmotic pressure, and a capillary bed entered by protein rich blood pulls fluid inward. Cells and medium to large proteins cannot cross the filtration membrane of the first bed, so they remain behind and generate an average colloid osmotic pressure of about \(30\ \text{mm Hg}\) inside those capillaries. Between \(10\%\) and \(20\%\) of the plasma entering that bed is filtered off as a protein free fluid, which leaves the same protein mass in a smaller plasma volume, and the rise from \(7.0\ \text{g/dL}\) to \(8.7\ \text{g/dL}\) records exactly that concentrating effect near the upper end of the filtered range. Blood entering the second bed therefore begins with an unusually strong inward osmotic pull, and water movement into the peritubular capillaries and vasa recta is influenced primarily by osmolarity and concentration gradients rather than by filtration pressure. Recovery of that fluid is what returns the concentration to \(7.1\ \text{g/dL}\) by the renal vein.
>
> (Choice A) High hydrostatic pressure driving net filtration describes the first bed, which sustains that pressure by dilating the arteriole feeding it while constricting the arteriole draining it. Blood reaching the second bed has already crossed a capillary network and a resistance vessel, so its hydrostatic pressure is low rather than high. Assigning the first bed's driving force to the second bed reverses the direction of net fluid movement.
>
> (Choice B) The stepwise rise in protein concentration across the first bed reflects loss of protein free filtrate, and retained protein is the source of colloid osmotic pressure. A bed supplied with concentrated plasma proteins therefore experiences a net inward pull. The subsequent fall toward \(7.1\ \text{g/dL}\) at the renal vein confirms that fluid was recovered into the blood downstream.
>
> (Choice C) The measurement moves upward, from \(7.0\ \text{g/dL}\) to \(8.7\ \text{g/dL}\), so colloid osmotic pressure entering the second bed is higher than in the renal artery, not lower. This reading treats filtration as though it removed protein along with water. The filtration membrane in fact retains the proteins, which is why the remaining plasma becomes more concentrated.
>
> (Choice D) Two capillary beds arranged in series are separated by a resistance vessel, so their hydrostatic pressures cannot be equal. The pressure drop across that arteriole is precisely what allows the downstream bed to reabsorb rather than filter. Equal pressures would abolish the recovery of solutes and water that the renal vein value documents.
>
> This is a Data-based and Statistical Reasoning question because you must interpret a set of measured concentrations and infer the pressure balance they create in the downstream bed.

---

## B2-Q13 — Renal Portal Hemodynamics

**Stem.** In an isolated kidney perfused at fixed pressure, a drug lowers total renal blood flow by \(10\%\) while raising the filtration rate into Bowman's space by \(20\%\). Fluid uptake by the peritubular capillaries increases at the same time. Which drug action most likely accounts for all three findings?

- **A.** Constriction of the arteriole upstream of the first capillary bed
- **B.** Dilation of the arteriole upstream of the first capillary bed
- **C.** Constriction of the venules downstream of the second capillary bed
- **D.** Constriction of the arteriole between the two capillary beds  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic hard / structural hard) |
| Estimated time | 130 s |
| Confidence | 5 |
| Hard-tier gate | Meets all four. (1) CONCEPT CHAINING: added resistance to raised upstream pressure to raised filtration, then separately to lowered downstream hydrostatic pressure plus raised downstream colloid osmotic pressure to increased uptake. (2) DATA-TO-MECHANISM: three quantitative findings must be reconciled with a single anatomic site of drug action rather than read off a value. (3) TRUE PARTIAL-TRUTH TRAP: Choice A genuinely lowers total flow and would be correct if the filtration datum were omitted; Choice B genuinely raises filtration and would be correct if the flow datum were omitted. (4) 510-TEMPTING DISTRACTOR: Choice B is where a strong student lands after anchoring on the filtration increase and neglecting the flow decrease. |

**Correct answer (D): Constriction of the arteriole between the two capillary beds**

Citations: AP:53129-53131 verbatim: 'The glomerulus has a relatively high pressure inside its capillaries and can sustain this by dilating the afferent arteriole while constricting the efferent arteriole. This assures adequate filtration pressure even as the systemic blood pressure varies.' | AP:52533-52535 verbatim: 'Since a capillary bed (the glomerulus) drains into a vessel that in turn forms a second capillary bed, the definition of a portal system is met. This is the only portal system in which an arteriole is found between the first and second capillary beds.' | AP:52594-52595 verbatim: 'The glomerulus is a high-pressure capillary bed between afferent and efferent arterioles.' | AP:53131-53132 verbatim: 'Movement of water into the peritubular capillaries and vasa recta will be influenced primarily by osmolarity and concentration gradients.' | AP:52846-52848 verbatim: 'other proteins too large to pass through the filter remain in the capillary, creating an average colloid osmotic pressure of 30 mm Hg within the capillary.' | AP:52532-52533 verbatim: 'these capillary networks recover most of the solutes and water, and return them to the circulation.'

**Distractors**

- **(A)** `partial_truth` . _correct flow effect, inverted pressure effect_ — The single varied element is the site of the added resistance, moved upstream of the first bed. That placement does lower total flow as observed, but it dissipates pressure before blood reaches the first bed, so filtration falls instead of rising by \(20\%\).
  - Citation: AP:53129-53131
- **(B)** `reversed_relationship` . _explains the headline datum, fails the flow datum_ — The single varied element is the identity of the vessel whose caliber changes. Dilating the vessel feeding the first bed does raise pressure there and increase filtration, but at fixed perfusion pressure it lowers total resistance and therefore raises organ flow, contradicting the measured \(10\%\) decline.
  - Citation: AP:52594-52595
- **(C)** `process_step_confusion` . _resistance placed on the wrong side_ — The single varied element is which side of the second bed the resistance sits on. Adding resistance beyond that bed reduces total flow but backs pressure up into it, which opposes fluid uptake, whereas the observed increase in uptake requires the resistance to sit upstream.
  - Citation: AP:53131-53132

**Readback check.** Stem content words: isolated kidney, perfused, fixed pressure, drug, total renal blood flow, filtration rate, Bowman's space, fluid uptake, peritubular capillaries. Keyed option content words: constriction, arteriole, between, two, capillary beds. The word 'capillaries' appears in the stem but 'capillary' appears in all four options, so it is not distinctive to the key. The discriminating terms (constriction, arteriole, between) are absent from the stem. The stem gives three measurements and no mechanism, so the student must reason from the data to the site of resistance, and every option describes a real vasoactive action. AUDIT CHANGES: (1) options were restructured so that the two upstream actions form a matched pair differing only in direction and the two constrictions differ only in site, tightening the single-variable relationship the draft violated; the key moved to D; (2) explanation blocks reordered to match; (3) the phrase 'the arrangement the textbook calls unique among human portal systems' was rewritten, since student-facing explanations should not reference the source text; (4) the misnumbered citation AP:52531-52532 was corrected to AP:52532-52533; (5) citation AP:52847 was corrected to AP:52846-52848, since the quoted clause continues onto the following line; (6) AP:52594-52595 was added to support the claim that the first bed is a high pressure bed sitting between two arterioles. No forbidden-scope agent is named: the stem says only 'a drug', keeping the item clear of the renin and angiotensin material that belongs to Biology Chapter 5.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because adding resistance between the two beds simultaneously raises pressure in the upstream bed and lowers it in the downstream bed, which is the only action that satisfies all three findings. Resistance placed after the first bed impedes its outflow, so total flow through the organ falls while pressure inside that high pressure bed rises and filtration increases. Because the added resistance dissipates pressure before blood reaches the second bed, hydrostatic pressure there falls, which favors uptake rather than filtration. The larger filtered fraction also concentrates the retained plasma proteins, so blood entering the second bed arrives with an elevated colloid osmotic pressure that pulls fluid inward, and water movement there is influenced primarily by osmolarity and concentration gradients. Opposite pressure changes in two beds are possible only because a resistance vessel sits between them, an arrangement unique to the renal circuit among human portal systems.
>
> (Choice A) Constricting the vessel that feeds the first bed correctly predicts the fall in total flow, so it accounts for one finding. However, it dissipates pressure before blood arrives at that bed, so pressure inside the bed falls and filtration would decrease rather than rise by \(20\%\). It also lowers the filtered fraction, so protein concentration entering the second bed would not rise.
>
> (Choice B) Dilating the vessel that feeds the first bed does raise pressure inside that bed and would increase filtration, which makes it superficially consistent with the filtration finding. At fixed perfusion pressure, though, lowering upstream resistance raises total organ flow rather than lowering it, contradicting the measured \(10\%\) decline. Anchoring on the filtration datum alone is what makes this response attractive.
>
> (Choice C) Constricting the vessels beyond the second bed does reduce total flow, but it backs pressure up into that bed by impeding its outflow. Higher hydrostatic pressure inside the second bed opposes uptake, so fluid recovery would fall rather than increase. The observed rise in uptake requires the added resistance to sit upstream of that bed.
>
> (Choice D) Constriction of the connecting arteriole raises hydrostatic pressure in the first bed and increases filtration, while imposing enough resistance to lower total flow through the organ. Downstream of that constriction, hydrostatic pressure falls and plasma protein concentration is elevated by the extra filtration, so both terms governing the second bed shift toward uptake. Every measured change follows from a single point of added resistance.
>
> This is a Scientific Reasoning and Problem Solving question because you must trace how one change in resistance produces opposite pressure effects in two capillary beds arranged in series.

---

## B2-Q14 — Sampling A Portal Circuit

**Stem.** A peptide released by hypothalamic neurons is undetectable in blood drawn from an arm vein, yet the anterior pituitary responds to it. Investigators want to measure the concentration of the peptide that is actually delivered to the anterior pituitary. Sampling blood from which site would best serve that measurement?

- **A.** The vessels crossing the infundibulum toward the gland  <- **KEY**
- **B.** The superior hypophyseal artery before it branches
- **C.** The venous channels draining the anterior pituitary
- **D.** The internal jugular vein on the same side

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **hard** (topic medium / structural hard) |
| Estimated time | 120 s |
| Confidence | 5 |
| Hard-tier gate | Meets three, with (1) and (4) carrying the item. (1) CONCEPT CHAINING: recognize that the undetectable systemic value implies non systemic transport, locate the segment where the substance travels undiluted, then match that segment to a sampling site. (4) 510-TEMPTING DISTRACTOR: Choice C attracts students who reason that blood leaving the target must have been exposed to the peptide, overlooking that outflow reports residual rather than delivered concentration. (3) TRUE PARTIAL-TRUTH TRAP, weaker but real: Choice B is the correct circuit and would be the right sample if the peptide entered the blood arterially rather than at the primary plexus. |

**Correct answer (A): The vessels crossing the infundibulum toward the gland**

Citations: AP:31900-31903 verbatim: 'Hypothalamic hormones are secreted by neurons, but enter the anterior pituitary through blood vessels (Figure 17.9). Within the infundibulum is a bridge of capillaries that connects the hypothalamus to the anterior pituitary. This network, called the hypophyseal portal system, allows hypothalamic hormones to be transported to the anterior pituitary without first entering the systemic circulation.' | AP:31912-31916 verbatim: 'The hypophyseal portal system originates from the superior hypophyseal artery, which branches off the carotid arteries and transports blood to the hypothalamus. The branches of the superior hypophyseal artery form the hypophyseal portal system (see Figure 17.9). Hypothalamic releasing and inhibiting hormones travel through a primary capillary plexus to the portal veins, which carry them into the anterior pituitary.' | AP:31916-31917 verbatim: 'Hormones produced by the anterior pituitary (in response to releasing hormones) enter a secondary capillary plexus, and from there drain into the circulation.' | BIO:49581-49584 verbatim: 'This capillary network is a part of the hypophyseal portal system that carries substances from the hypothalamus to the anterior pituitary and hormones from the anterior pituitary into the circulatory system. A portal system carries blood from one capillary network to another'

**Distractors**

- **(B)** `process_step_confusion` . _right circuit, upstream of the source_ — The single varied element is the sampling position relative to the source. This artery supplies the primary plexus, so it carries blood before the peptide has been added, and a sample there measures the input to the circuit rather than the concentration delivered to the target.
  - Citation: AP:31912-31916
- **(C)** `adjacent_fact` . _post-target outflow mistaken for delivery_ — The single varied element is the sampling position relative to the target. Outflow lies beyond the second plexus, so it reflects residual peptide after uptake and is mixed with the gland's own secreted hormones, and residual concentration cannot stand in for delivered concentration.
  - Citation: AP:31916-31917
- **(D)** `misconception` . _proximity confused with isolation_ — The single varied element is how far downstream the sample is taken. Jugular blood has already joined the general venous return and is diluted exactly as the arm vein sample was, and anatomic proximity to the head does not prevent systemic mixing.
  - Citation: AP:31900-31903

**Readback check.** Stem content words: peptide, released, hypothalamic neurons, undetectable, blood, arm vein, anterior pituitary, responds, measure, concentration, delivered, sampling, site. Keyed option content words: vessels, crossing, infundibulum, gland. None of the key's discriminating terms appear in the stem, and the stem names no vessel at all, so the student must know the circuit and then judge where within it the delivery concentration exists. All four sites are real vessels associated with this region, so none can be discarded on plausibility alone; note that option C repeats 'anterior pituitary' from the stem, which makes a distractor more tempting rather than giving the key away. AUDIT CHANGES: (1) MISNUMBERED CITATION: the draft cited AP:31918-31920 for the sentence about the secondary capillary plexus, but line 31918 is blank and 31920 is part of a figure caption; the sentence is actually at AP:31916-31917, and the citation was corrected in both the citations field and distractor C; (2) citation AP:31912-31918 was corrected to AP:31912-31916, the true end of the quoted passage; (3) option C was reworded from 'The venous sinus draining the anterior pituitary' to 'The venous channels draining the anterior pituitary', because the textbook describes anterior pituitary outflow as draining into the circulation without naming a specific sinus, and the looser wording keeps the distractor anchored to the cited text; (4) hard_gate_conditions was rewritten to state honestly which conditions carry the item, since the draft's partial-truth claim was the weakest of the three and should not be the load-bearing one.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because only the vessels running between the two plexuses carry the peptide at delivery concentration, after it has entered the blood and before the target tissue has removed any of it. A valid measurement of delivered concentration must sample the vessel lying immediately downstream of the source and immediately upstream of the target, and in this circuit those are the portal veins of the infundibular stalk. The undetectable arm vein value is itself the clue, because the peptide is transported to the anterior pituitary without first entering the systemic circulation, so any systemic sample understates delivery by the dilution factor of the whole blood volume. Sampling upstream of the source measures the peptide before it is added, and sampling the outflow measures what remains after the target tissue has taken it up and after mixing with the gland's own secretions.
>
> (Choice A) The vessels crossing the infundibulum receive the peptide from the primary plexus and carry it straight to the secondary plexus without an intervening systemic circuit. Blood drawn there is the only sample whose concentration equals what the anterior pituitary receives. Comparing that value with the arm vein value also quantifies directly how much dilution the portal route avoids.
>
> (Choice B) The superior hypophyseal artery is the correct circuit but the wrong point within it, because it supplies blood to the primary plexus before the peptide has entered. A sample there would read near zero for the same reason the arm vein does. It would therefore falsely suggest that no peptide reaches the gland at all.
>
> (Choice C) The venous channels draining the anterior pituitary lie beyond the target tissue, so their contents reflect what was left over after uptake rather than what was delivered. That outflow also carries hormones secreted by the gland itself, so a value measured there cannot be attributed to delivery. Outflow concentration is a residual, not an input.
>
> (Choice D) The internal jugular vein carries blood that has already joined the general venous return, so a sample there suffers exactly the dilution that made the arm vein sample uninformative. Anatomic proximity to the head does not undo mixing that has already occurred. The distinguishing feature of this circuit is that it bypasses the systemic circulation, and a jugular sample sits squarely inside that circulation.
>
> This is a Reasoning about the Design and Execution of Research question because you must select the sampling site whose measured concentration isolates the variable of interest rather than a diluted or post uptake value.

---

## B2-Q15 — Mean Arterial Pressure

**Stem.** During a routine clinic visit, a nurse records a brachial cuff pressure of \(142/70\ \text{mm Hg}\) in a resting adult. Which value most closely approximates this patient's mean arterial pressure?

- **A.** \(72\ \text{mm Hg}\)
- **B.** \(94\ \text{mm Hg}\)  <- **KEY**
- **C.** \(106\ \text{mm Hg}\)
- **D.** \(118\ \text{mm Hg}\)

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic easy / structural easy) |
| Estimated time | 65 s |
| Confidence | 5 |

**Correct answer (B): \(94\ \text{mm Hg}\)**

Citations: AP:38923 verbatim: 'MAP can be approximated by adding the diastolic pressure to one-third of the pulse pressure or systolic pressure' continuing at AP:38924 verbatim: 'minus the diastolic pressure:'. AP:38906 verbatim: 'As shown in Figure 20.10, the difference between the systolic pressure and the diastolic pressure is the pulse' continuing at AP:38907 verbatim: 'pressure. For example, an individual with a systolic pressure of 120 mm Hg and a diastolic pressure of 80 mm Hg'. AP:38908 verbatim: 'would have a pulse pressure of 40 mmHg.' AP:38929 to 38930 context (quoted in part rather than in full because the source line carries a Unicode minus and an en dash): AP:38929 states the worked example evaluates to 93.33 and begins 'Normally, the MAP falls within the range of', and AP:38930 gives that range as 70 to 110 mm Hg and states that a value below 60 mm Hg for an extended time leaves blood pressure too low to ensure circulation through the tissues, resulting in ischemia. AP:38020 verbatim: 'approximately 0.8 seconds. Beginning with all' (total cardiac cycle duration; the source gives no systole to diastole split, so no numeric split is asserted anywhere in this item). AAMC outline line 1828: 'Systolic and diastolic pressure'.

**Distractors**

- **(A)** `adjacent_fact` . _reports the neighboring derived quantity_ — \(72\ \text{mm Hg}\) is the pulse pressure, not the mean; the mean must lie between \(70\) and \(142\ \text{mm Hg}\).
  - Citation: AP:38906 to 38907 'the difference between the systolic pressure and the diastolic pressure is the pulse pressure'
- **(C)** `misconception` . _unweighted average of the two readings_ — \(106\ \text{mm Hg}\) assumes contraction and relaxation occupy equal time, but the approximation weights the diastolic value more heavily.
  - Citation: AP:38923 'MAP can be approximated by adding the diastolic pressure to one-third of the pulse pressure'
- **(D)** `process_step_confusion` . _applies the one third correction to the wrong anchor_ — \(118\ \text{mm Hg}\) subtracts one third of the pulse pressure from the systolic value instead of adding it to the diastolic value.
  - Citation: AP:38923 to 38924 'MAP can be approximated by adding the diastolic pressure to one-third of the pulse pressure or systolic pressure minus the diastolic pressure:'

**Readback check.** The stem supplies only the two cuff numbers and the phrase 'mean arterial pressure.' No content word from the key (a bare numeric value) appears in the stem, and \(94\) cannot be selected without knowing the diastole weighted approximation. All four options are physiologically real pressures derived from the same two inputs, so none can be eliminated on plausibility alone. AUDIT: stem and options unchanged. Two citation defects fixed: the normal mean arterial pressure range was cited to AP:38928, which is a blank line, and the text actually sits on AP:38929 to 38930; the AAMC outline entry 'Systolic and diastolic pressure' was cited to line 1827 and is actually on line 1828. One explanation defect fixed: the clause asserting that the ventricles spend 'roughly twice as long in diastole as in systole' and the parallel 'roughly two thirds of the cycle' clause in the Choice C block were unsupported numeric claims, since AP:38020 gives only the total cycle length of about 0.8 seconds and never states the systole to diastole split. Both were replaced with the weaker claim the source and standard physiology both sustain, that relaxation occupies the larger share of the resting cycle.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because mean arterial pressure is approximated as the diastolic pressure plus one third of the pulse pressure, which yields \(94\ \text{mm Hg}\). The pulse pressure here is \(142 - 70 = 72\ \text{mm Hg}\), one third of which is \(24\ \text{mm Hg}\), and adding that to the diastolic value of \(70\ \text{mm Hg}\) gives \(94\ \text{mm Hg}\). The one third weighting exists because at resting heart rates the heart spends a larger fraction of each cycle relaxed than contracting, so arterial pressure sits nearer the diastolic value for most of the cycle. A normal mean arterial pressure falls between \(70\) and \(110\ \text{mm Hg}\), and this value sits comfortably inside that window.
>
> (Choice A) \(72\ \text{mm Hg}\) is the pulse pressure, the arithmetic difference between the systolic and diastolic readings. Pulse pressure describes the amplitude of the pressure swing produced by each ejection, not the average force driving blood into the vessels that serve the tissues. Because the mean must lie between the diastolic and the systolic values, a number equal to their difference cannot be the mean.
>
> (Choice B) This value correctly weights the cardiac cycle: \(70 + (72/3) = 94\ \text{mm Hg}\). The same result follows from subtracting two thirds of the pulse pressure from the systolic value, since \(142 - 48 = 94\ \text{mm Hg}\). A mean sustained below roughly \(60\ \text{mm Hg}\) fails to perfuse tissue and produces ischemia, which is why this quantity, rather than the systolic number alone, is tracked in critically ill patients.
>
> (Choice C) \(106\ \text{mm Hg}\) is the unweighted average of \(142\) and \(70\). That calculation treats contraction and relaxation as occupying equal fractions of the cardiac cycle. Because relaxation occupies the larger share of the resting cycle, the true time average is pulled downward toward the diastolic value.
>
> (Choice D) \(118\ \text{mm Hg}\) results from subtracting one third of the pulse pressure from the systolic value instead of adding it to the diastolic value. That operation weights contraction more heavily than relaxation, reversing the actual weighting of the cardiac cycle. It also places the result above the unweighted average, which is impossible for a quantity weighted toward the diastolic end.
>
> This is a Scientific Reasoning and Problem Solving question because you must apply the mean arterial pressure approximation to a specific cuff reading rather than recall a definition.

---

## B2-Q16 — Pulse Pressure And Stroke Volume

**Stem.** A patient's cuff reading changes from \(122/78\ \text{mm Hg}\) at admission to \(96/82\ \text{mm Hg}\) two hours later. Over the same interval the heart rate rises from \(72\) to \(104\ \text{beats/min}\). This shift in the recorded pressures is most consistent with which underlying change?

- **A.** A fall in stroke volume  <- **KEY**
- **B.** A fall in total peripheral resistance
- **C.** A rise in arterial wall stiffness
- **D.** A rise in blood viscosity

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic easy / structural medium) |
| Estimated time | 70 s |
| Confidence | 5 |

**Correct answer (A): A fall in stroke volume**

Citations: AP:38910 to 38912 verbatim: 'Generally, a pulse pressure should be at least 25 percent of the systolic pressure. A pulse pressure below this level is described as low or narrow. This may occur, for example, in patients with a low stroke volume, which may be seen in congestive heart failure, stenosis of the aortic valve, or significant blood loss following trauma.' AP:38944 to 38945 verbatim: 'After blood is ejected from the heart, elastic fibers in the arteries help maintain a high-pressure gradient as they expand to accommodate the blood, then recoil.' AP:38526 to 38527 verbatim: 'Specifically in arteries, vasoconstriction decreases blood flow as the smooth muscle in the walls of the tunica media contracts, making the lumen narrower and increasing blood pressure. Similarly, vasodilation increases blood flow as the smooth muscle relaxes, allowing the lumen to widen and blood pressure to drop.' AP:39037 to 39038 verbatim: 'The greater the compliance of an artery, the more effectively it is able to expand to accommodate surges in blood flow without increased resistance or blood pressure.' AP:39109 to 39110 verbatim: 'The viscosity of blood is directly proportional to resistance and inversely proportional to flow; therefore, any condition that causes viscosity to increase will also increase resistance and decrease flow.' AP:39115 to 39116 verbatim: 'Normally the viscosity of blood does not change over short periods of time. The two primary determinants of blood viscosity are the formed elements and plasma proteins.' AAMC outline line 1828: 'Systolic and diastolic pressure'.

**Distractors**

- **(B)** `reversed_relationship` . _right variable, wrong direction of the diastolic effect_ — Reduced resistance speeds arterial runoff and lowers diastolic pressure, but the recorded diastolic value rose from \(78\) to \(82\ \text{mm Hg}\).
  - Citation: AP:38526 to 38527 'vasodilation increases blood flow as the smooth muscle relaxes, allowing the lumen to widen and blood pressure to drop'
- **(C)** `misconception` . _treats stiffening as narrowing the pressure swing_ — Reduced compliance raises the systolic peak and lowers the diastolic trough, widening rather than narrowing the swing, and it develops over years.
  - Citation: AP:39037 to 39038 'The greater the compliance of an artery, the more effectively it is able to expand to accommodate surges in blood flow without increased resistance or blood pressure.'
- **(D)** `adjacent_fact` . _real resistance determinant with no effect on amplitude_ — Viscosity changes shift mean arterial pressure through resistance, not the systolic to diastolic difference, and viscosity does not change over short periods.
  - Citation: AP:39109 to 39110 'The viscosity of blood is directly proportional to resistance and inversely proportional to flow' and AP:39115 'Normally the viscosity of blood does not change over short periods of time.'

**Readback check.** The stem gives only two cuff readings and a heart rate change. The keyed phrase 'stroke volume' does not appear anywhere in the stem, and neither does 'pulse pressure' or any word describing ejection. A student who does not know that pulse pressure tracks the volume ejected per beat cannot recover the key from the numbers. All four options name real determinants of arterial pressure discussed in the same textbook chapter. AUDIT: one fabricated citation fixed. The Choice D distractor cited AP:39100 for 'The viscosity of blood is directly proportional to resistance and inversely proportional to flow'; line AP:39100 actually reads 'includes intravenous fluid replacement.' and the quoted sentence is on AP:39109 to 39110. One mismatched citation fixed: the Choice B distractor cited AP:39172, a line about the uneven pressure drop along the vascular tree, which does not support the claim that falling resistance lowers diastolic pressure; it now cites AP:38526 to 38527, which states directly that vasodilation lets the lumen widen and blood pressure drop. The Choice D explanation clause 'Viscosity is set by hematocrit and plasma protein concentration' was reworded to the source's own terms (formed elements and plasma proteins) and now cites AP:39115 for the short term stability claim. Tier corrected from easy to medium on the structural axis: the item requires computing two pulse pressures, noting that the diastolic value moved opposite to the systolic value, and inferring an unmeasured variable, which is more than an easy structure.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because the pressure swing per beat collapsed from \(44\) to \(14\ \text{mm Hg}\), and that swing is generated by the volume the ventricle ejects into the arterial tree with each contraction. A larger ejected volume forces the elastic arterial wall further outward during contraction, lifting the systolic peak well above the diastolic floor, whereas a smaller ejected volume produces a smaller excursion. Here the systolic value fell by \(26\ \text{mm Hg}\) while the diastolic value actually rose slightly, a combination that points to less blood per beat with vasoconstriction holding the diastolic floor up. The accompanying tachycardia is the expected compensation, since a smaller volume per beat must be delivered more often to sustain flow.
>
> (Choice A) A narrow pulse pressure, conventionally under about \(25\%\) of the systolic value, is the classic signature of a reduced volume ejected per beat, as seen with aortic valve stenosis, congestive heart failure, or significant blood loss. Here \(14/96\) is roughly \(15\%\), well under that threshold, whereas the admission ratio of \(44/122\) was roughly \(36\%\). The rising heart rate and slightly rising diastolic pressure both fit a circulation defending its mean pressure while the volume ejected per beat falls.
>
> (Choice B) A fall in total peripheral resistance widens the lumen of the resistance vessels and lets blood drain out of the arteries faster between beats, so the diastolic pressure would drop rather than rise. The recorded diastolic value moved from \(78\) to \(82\ \text{mm Hg}\), the opposite direction. Widespread arteriolar dilation also tends to widen the pressure swing rather than compress it.
>
> (Choice C) Increased arterial wall stiffness raises the systolic peak, because less of the ejected volume is absorbed by wall expansion, and lowers the diastolic trough, because less elastic recoil sustains pressure between beats. That combination widens the pressure swing, whereas the swing here narrowed sharply. Arterial stiffening also develops over years, not over two hours.
>
> (Choice D) Higher blood viscosity raises resistance and lowers flow, and therefore tends to raise mean arterial pressure. It does not by itself compress the difference between the systolic and diastolic readings, which is governed mainly by the volume ejected per beat and by arterial compliance. Viscosity is set by the formed elements and the plasma proteins and does not change appreciably over short periods.
>
> This is a Scientific Reasoning and Problem Solving question because you must convert two cuff readings into a change in pressure amplitude and infer the hemodynamic variable responsible.

---

## B2-Q17 — Site Of Greatest Vascular Resistance

**Stem.** In an anesthetized dog, mean pressure is \(95\ \text{mm Hg}\) in the aorta, \(92\ \text{mm Hg}\) in a femoral artery, and \(32\ \text{mm Hg}\) at the entrance to the hindlimb capillary beds. An experimental compound is then infused while cardiac output is held constant, after which the same three sites read \(121\), \(118\), and \(24\ \text{mm Hg}\). The compound most likely acts on which vessel type?

- **A.** Elastic conducting arteries
- **B.** Capillaries
- **C.** Venules
- **D.** Arterioles  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 95 s |
| Confidence | 5 |

**Correct answer (D): Arterioles**

Citations: AP:39165 verbatim: 'the flow of blood from arteries. In fact, arterioles are the site of greatest resistance in the entire vascular network.' AP:39173 to 39174 verbatim: 'However, the site of the most precipitous drop, and the site of greatest resistance, is the arterioles.' AP:39172 to 39173 verbatim: 'blood pressure drops unevenly as blood travels from arteries to arterioles, capillaries, venules, and veins, and encounters greater resistance.' AP:38602 to 38603 verbatim: 'The importance of the arterioles is that they will be the primary site of both resistance and regulation of blood pressure. The precise diameter of the lumen of an arteriole at any given moment is determined by neural and chemical controls'. AP:38594 verbatim: 'The tunica media is restricted to one or two smooth muscle cell layers in thickness.' AP:38597 verbatim: 'With a lumen averaging 30 micrometers or less in diameter, arterioles are critical in slowing down' (the source line then carries an em dash, so the quotation is cut there). AP:38613 to 38614 verbatim: 'The wall of a capillary consists of the endothelial layer surrounded by a basement membrane with occasional smooth muscle fibers.' AP:38558 to 38559 verbatim: 'This type of artery is known as an elastic artery' and AP:38570 verbatim: 'elastic artery is also known as a conducting artery'. AP:38564 to 38565 verbatim: 'fibers allow them to expand, as blood pumped from the ventricles passes through them, and then to recoil after the surge has passed.' AP:38820 to 38821 and AP:38823 to 38824 support the venoconstriction and venous reserve claims. AAMC outline line 1837: 'Source of peripheral resistance'.

**Distractors**

- **(A)** `adjacent_fact` . _upstream vessel that rose in pressure passively_ — The aorta to femoral artery gradient stayed at \(3\ \text{mm Hg}\), and these vessels expand and recoil rather than regulate resistance.
  - Citation: AP:38564 to 38565 'fibers allow them to expand, as blood pumped from the ventricles passes through them, and then to recoil after the surge has passed.'
- **(B)** `misconception` . _smallest lumen assumed to be highest resistance_ — Capillary walls have no layered smooth muscle tunica media, and constricting them would raise rather than lower the measured capillary entrance pressure.
  - Citation: AP:38613 to 38614 'The wall of a capillary consists of the endothelial layer surrounded by a basement membrane with occasional smooth muscle fibers.'
- **(C)** `reversed_relationship` . _downstream constriction would raise the value that fell_ — Venular constriction dams blood into the capillary bed and raises entrance pressure, but the entrance pressure fell from \(32\) to \(24\ \text{mm Hg}\).
  - Citation: AP:38820 to 38821 'venoconstriction may be likened to a stiffening of the vessel wall. This increases pressure on the blood within the veins, speeding its return to the heart.'

**Readback check.** The stem names the aorta, a femoral artery, and the capillary beds, but never the arterioles, so no content word of the key appears in the stem. The word 'capillary' appears in the stem and points toward choice B, an intentional trap rather than a cue for the key. The key is recoverable only by computing the two segment gradients and knowing which vessel class sits between a named systemic artery and the capillaries. AUDIT: one readback defect fixed. The draft stem called the infused agent a 'vasoconstrictor', which made the key answerable from prior association alone, since 'a vasoconstrictor acts on arterioles' is a stock fact and the remaining options are vessels that either cannot constrict or would not be described that way. The agent is now an unlabeled 'experimental compound', so both the direction of the change and its location must be read out of the four pressure gradients. The site label 'a muscular artery of the hindlimb' was changed to 'a femoral artery' to remove the taxonomic hint that pointed at the muscular to capillary interval. Two citation ranges corrected: the arteriole importance sentence spans AP:38602 to 38603, not AP:38602 alone, and the elastic fiber expansion sentence spans AP:38564 to 38565, not AP:38564 alone. One explanation wording defect fixed: the Choice B block said capillaries 'lack the muscular tunica media', but AP:38613 to 38614 notes occasional smooth muscle fibers in the capillary wall, so the claim was narrowed to the absence of a layered smooth muscle tunica media.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because essentially all of the added pressure drop appeared between the femoral artery and the capillary entrance, and the arterioles are the vessels that occupy that position. Before the infusion, the gradient across that stretch was \(92 - 32 = 60\ \text{mm Hg}\); afterward it was \(118 - 24 = 94\ \text{mm Hg}\). Over the same interval the aorta to femoral artery gradient was unchanged at \(3\ \text{mm Hg}\), and at a fixed flow the pressure lost across any segment is proportional to that segment's resistance, so a gradient that grows by more than half while the upstream gradient stays flat localizes the added resistance to one segment.
>
> (Choice A) Elastic conducting arteries are dominated by elastic fibers rather than by regulated smooth muscle, so they expand and recoil rather than set resistance. The data confirm this directly: the gradient from the aorta to the femoral artery was \(3\ \text{mm Hg}\) both before and after the infusion. Pressure in these vessels rose passively because more resistance was added downstream, not because they themselves narrowed.
>
> (Choice B) The wall of a capillary is essentially an endothelial layer on a basement membrane rather than the layered smooth muscle tunica media that regulated constriction requires. The data also exclude this site: adding resistance within the capillaries would raise the pressure measured at the capillary entrance, and that value fell from \(32\) to \(24\ \text{mm Hg}\). Pressure builds up on the upstream side of any segment whose resistance increases.
>
> (Choice C) Venules lie downstream of the capillary beds, so constricting them dams blood back into the capillaries and raises the pressure at their entrance. The measured entrance pressure fell instead, which requires the new resistance to sit upstream. Venous constriction does contribute to circulatory regulation, but chiefly by pushing reserve volume back toward the heart rather than by producing this pressure profile.
>
> (Choice D) These vessels carry a tunica media of only one or two smooth muscle layers around a lumen averaging \(30\) micrometers or less, and they are the site of the most precipitous pressure drop and the greatest resistance in the entire vascular network. Their diameter is set moment to moment by neural and chemical control, so a modest change in radius raises upstream arterial pressure while simultaneously lowering the pressure delivered to the tissue. The reciprocal movement of the two measured values, up above and down below, is the fingerprint of a resistance change at this level.
>
> This is a Data-based and Statistical Reasoning question because you must compare pressure gradients across successive vascular segments before and after an intervention and locate where the resistance changed.

---

## B2-Q18 — Arterial Compliance And Pulse Pressure

**Stem.** A \(74\)-year-old patient whose aorta and large arteries have become stiff and poorly compliant is compared with a healthy \(24\)-year-old. Stroke volume, heart rate, and mean arterial pressure are the same in both. Which of the following is or are expected in the older patient?
I. A higher systolic pressure
II. A narrower pulse pressure
III. A lower diastolic pressure

- **A.** I only
- **B.** II only
- **C.** I and II only
- **D.** I and III only  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 85 s |
| Confidence | 5 |

**Correct answer (D): I and III only**

Citations: AP:39037 to 39041 verbatim: 'The greater the compliance of an artery, the more effectively it is able to expand to accommodate surges in blood flow without increased resistance or blood pressure. Veins are more compliant than arteries and can expand to hold more blood. When vascular disease causes stiffening of arteries, compliance is reduced and resistance to blood flow is increased. The result is more turbulence, higher pressure within the vessel, and reduced blood flow.' AP:39194 to 39196 verbatim: 'Compliance allows an artery to expand when blood is pumped through it from the heart, and then to recoil after the surge has passed. This helps promote blood flow. In arteriosclerosis, compliance is reduced, and pressure and resistance within the vessel increase.' AP:38564 to 38565 verbatim: 'fibers allow them to expand, as blood pumped from the ventricles passes through them, and then to recoil after the surge has passed. If artery walls were rigid and unable to expand and recoil, their resistance to blood flow would greatly increase and blood pressure would rise to even higher levels'. AP:38944 to 38945 verbatim: 'After blood is ejected from the heart, elastic fibers in the arteries help maintain a high-pressure gradient as they expand to accommodate the blood, then recoil.' AP:38906 to 38907 verbatim: 'the difference between the systolic pressure and the diastolic pressure is the pulse pressure'. AP:38914 to 38917 verbatim: 'A persistently high pulse pressure at or above 100 mm Hg may indicate excessive resistance in the arteries and can be caused by a variety of disorders. Chronic high resting pulse pressures can degrade the heart, brain, and kidneys, and warrant medical treatment.' AP:38911 verbatim: 'This may occur, for example, in patients with a low stroke volume, which may be seen'. AAMC outline line 1828: 'Systolic and diastolic pressure'.

**Distractors**

- **(A)** `partial_truth` . _correct systolic effect, misses the diastolic consequence_ — Item I is correct, but loss of elastic recoil also lowers the pressure sustained between beats, so item III is equally expected.
  - Citation: AP:38944 to 38945 'elastic fibers in the arteries help maintain a high-pressure gradient as they expand to accommodate the blood, then recoil'
- **(B)** `partial_truth` . _selects the one incorrect numeral alone_ — A narrowed pressure swing follows from a reduced volume ejected per beat, not from reduced compliance, which widens the swing.
  - Citation: AP:38911 'This may occur, for example, in patients with a low stroke volume'
- **(C)** `reversed_relationship` . _correct peak paired with inverted swing direction_ — A rising peak with a fixed mean forces the trough down, so the swing must widen; items I and II cannot both hold.
  - Citation: AP:39037 to 39038 'The greater the compliance of an artery, the more effectively it is able to expand to accommodate surges in blood flow without increased resistance or blood pressure.'

**Readback check.** The stem states the vessel condition (stiff, poorly compliant) and the held constant variables, but never uses the words 'systolic', 'diastolic', or 'pulse pressure'. The Roman numerals supply candidate directions, and two of the three are plausible, so no numeral can be resolved without knowing how compliance stores and returns energy across the cycle. Holding mean arterial pressure fixed removes the shortcut of assuming everything simply rises. AUDIT: stem, options and key unchanged, and the physiology was re-derived and confirmed (with stroke volume, heart rate and mean pressure all held equal, reduced compliance must raise the peak and lower the trough). Three citation ranges corrected: the compliance passage spans AP:39037 to 39041, not AP:39037 to 39040; the arteriosclerosis sentence spans AP:39194 to 39196, not AP:39194 to 39195; and the elastic recoil sentence spans AP:38944 to 38945 and AP:38564 to 38565 rather than the single lines cited. The Choice D closing clause was replaced with a claim the textbook states outright at AP:38914 to 38917 about persistently high pulse pressure, because the previous clause about isolated systolic hypertension in older adults is not asserted anywhere in the source.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because a stiff arterial wall both fails to absorb the ejected volume during contraction and fails to give that stored energy back during relaxation. In a compliant vessel, part of each ejected volume is accommodated by outward expansion of the wall, which blunts the peak reached during ventricular contraction. That stretched wall then recoils during ventricular relaxation, driving blood onward and holding the trough pressure up between beats. Remove the compliance and the same ejected volume produces a taller peak and a deeper trough, so item I and item III both follow, and because the pressure swing is the peak minus the trough, that swing widens rather than narrows, which makes item II incorrect.
>
> (Choice A) This option captures the correct effect on the peak but stops there. The loss of elastic recoil is not only a contraction phase phenomenon: without stored wall energy to drive flow between beats, pressure decays further before the next contraction arrives. Selecting item I alone ignores half of what compliance does across the cardiac cycle.
>
> (Choice B) Reducing compliance while holding the ejected volume constant widens the pressure swing, since the peak rises and the trough falls simultaneously. A narrowed swing arises instead when the volume ejected per beat falls, as in aortic valve stenosis or significant blood loss. This option therefore inverts the expected direction.
>
> (Choice C) Item I is correct, but pairing it with item II is internally inconsistent. If the peak rises while the mean is held fixed, the trough must fall, and a rising peak with a falling trough necessarily widens rather than narrows the swing. The two selected items cannot both be true under the stated conditions.
>
> (Choice D) A stiff conduit converts each ejection into a sharp pressure spike, so the peak climbs, and the absent recoil lets pressure fall further during relaxation, so the trough drops. Holding mean arterial pressure equal across the comparison isolates the shape of the waveform from its average, which is what makes both directions readable. This widened swing is why a persistently high pulse pressure at or above \(100\ \text{mm Hg}\) can degrade the heart, brain, and kidneys and warrants medical treatment.
>
> This is a Knowledge of Scientific Concepts and Principles question because you must recall how arterial wall compliance shapes the peak and the trough of the arterial pressure waveform.

---

## B2-Q19 — Sphygmomanometry Technique

**Stem.** A quality audit compares cuff pressures recorded by two technicians on the same resting patients. Technician 1 deflates at \(2\ \text{mm Hg}\) per second with the arm supported at heart level, whereas Technician 2 deflates at \(10\ \text{mm Hg}\) per second with the arm hanging in the seated patient's lap. Which of the following errors is or are expected in Technician 2's recorded values?
I. The rapid deflation causes the systolic value to be recorded below its true value
II. The rapid deflation causes the diastolic value to be recorded below its true value
III. The lowered arm position shifts both recorded values upward

- **A.** I only
- **B.** III only
- **C.** I and II only
- **D.** I and III only  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **hard** (topic medium / structural hard) |
| Estimated time | 115 s |
| Confidence | 4 |
| Hard-tier gate | Condition 1 CONCEPT CHAINING: the item requires linking discrete once per beat sampling of a continuously falling cuff pressure to opposite directions of error at the two endpoints, and then adding a separate hydrostatic column argument for limb position. Condition 3 TRUE PARTIAL-TRUTH TRAP: numeral II states the correct consequence of coarse sampling, which is genuinely true at the systolic endpoint, but applies it to the endpoint where the sign reverses. Condition 4 510-TEMPTING DISTRACTOR: choice C is exactly where a strong student lands after correctly deducing that missed beats lower the recorded systolic value and then extending that logic symmetrically to the diastolic value. |

**Correct answer (D): I and III only**

Citations: AP:38970 verbatim: 'Korotkoff. Turbulent blood flow through the vessels can be heard as a soft ticking while measuring blood pressure;'. AP:38976 verbatim: 'sphygmomanometer (a blood pressure cuff attached to a measuring device) and a stethoscope. The technique is as'. AP:38979 verbatim: 'The clinician wraps an inflatable cuff tightly around the patient's arm at about the level of the heart.' AP:38982 to 38983 verbatim: 'The clinician places the stethoscope on the patient's antecubital region and, while gradually allowing air within the cuff to escape, listens for the Korotkoff sounds.' AP:38988 verbatim: 'indicates systolic pressure. As more air is released from the cuff, blood is able to flow freely through the' (the source line opens with 'sound' followed by an em dash, so the quotation begins after it). AP:38989 to 38990 verbatim: 'brachial artery and all sounds disappear. The point at which the last sound is heard is recorded as the patient's diastolic pressure.' The direction of the deflation rate bias is derived from those two quoted endpoint definitions plus once per beat sound generation, and the hydrostatic effect is derived from the quoted requirement that the cuff sit at heart level; the source states the gradual deflation and heart level requirements but not the magnitude of the resulting error, hence confidence 4. AAMC outline line 1828: 'Systolic and diastolic pressure'.

**Distractors**

- **(A)** `partial_truth` . _correct deflation error, ignores limb position_ — Item I holds, but protocol places the cuff at heart level for a reason, and a dependent arm raises both recorded values through a hydrostatic offset.
  - Citation: AP:38979 'The clinician wraps an inflatable cuff tightly around the patient's arm at about the level of the heart.'
- **(B)** `partial_truth` . _correct position error, ignores sampling rate_ — Item III holds, but coarse once per beat sampling at \(10\ \text{mm Hg}\) per second also drives the first audible sound below the true upper endpoint.
  - Citation: AP:38988 'indicates systolic pressure. As more air is released from the cuff, blood is able to flow freely through the'
- **(C)** `reversed_relationship` . _applies the missed beat logic symmetrically_ — The last audible beat occurs while the cuff is still above the true diastolic value, so rapid deflation records the lower endpoint too high, not too low.
  - Citation: AP:38989 to 38990 'The point at which the last sound is heard is recorded as the patient's diastolic pressure.'

**Readback check.** The stem gives only the two protocol deviations and never states any direction of error, so no numeral can be resolved from the stem. The keyed combination requires two independent derivations, and the three numerals split so that neither a purely 'both endpoints move together' heuristic nor a single error source yields the key. AUDIT: one style violation fixed. The draft stem ran to four sentences, over the three sentence cap; the two technician descriptions were merged into one contrasting sentence. One quantitative overstatement fixed: the explanation asserted the cuff 'loses roughly 10 mm Hg between beats' at a deflation rate of 10 mm Hg per second, which is exact only at 60 beats per minute and is about 8 mm Hg at 72 beats per minute; the range 8 to 10 mm Hg is now given. The phrase 'well below heart level' was removed from the stem so that the student must recognize that a seated patient's lap sits below the heart rather than being told. All six sphygmomanometry citations were checked line by line against the source and every one is accurate as numbered.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because rapid deflation biases the upper endpoint downward and the lower endpoint upward, while a dependent arm adds a hydrostatic column that raises both readings. The audible Korotkoff sounds are produced by turbulent flow past the partially occluded brachial artery, and turbulence occurs only when a heartbeat drives blood through that constriction, so the falling cuff is effectively sampled once per beat. At \(2\ \text{mm Hg}\) per second the cuff loses under \(2\ \text{mm Hg}\) between beats and both endpoints land within a couple of \(\text{mm Hg}\) of truth, whereas at \(10\ \text{mm Hg}\) per second the cuff can lose \(8\) to \(10\ \text{mm Hg}\) between beats, so the first audible beat arrives only after the cuff has already sunk below the true peak and the last audible beat occurs while the cuff still sits well above the true trough. The arm position error is independent of timing, since the cuff senses local arterial pressure and lowering the arm below the heart adds the weight of the intervening blood column to that pressure.
>
> (Choice A) Item I is correctly identified, but this option discards the arm position entirely. Standard protocol places the cuff at about the level of the heart precisely because deviation from that level introduces a hydrostatic offset. A dependent arm inflates both numbers regardless of how carefully the cuff is deflated.
>
> (Choice B) Item III is correct, but omitting item I ignores the sampling problem created by fast deflation. The first audible sound marks the upper endpoint, and if the cuff pressure has already fallen close to \(10\ \text{mm Hg}\) by the time the next beat arrives, that endpoint is recorded too low. Two independent error sources are operating here, and only one of them is captured.
>
> (Choice C) The reasoning that fast deflation causes beats to be missed is right, but its consequence at the lower endpoint runs the other way. The recorded lower value is the cuff pressure at the last beat still able to generate turbulence, and coarse sampling means that beat occurs while the cuff remains substantially above the true value. Applying a uniform downward bias to both endpoints is the specific error in this option.
>
> (Choice D) Fast deflation compresses the true range from both sides, narrowing the recorded pressure difference, while the dependent arm translates the whole measurement upward by the hydrostatic column. The two errors are additive at the lower endpoint, where both push the value up, and partially offsetting at the upper endpoint, which is why an audit must control deflation rate and limb position separately. Correcting only one of the two would leave a systematic bias in the data set.
>
> This is a Reasoning about the Design and Execution of Research question because you must evaluate how two independent departures from standard sphygmomanometry protocol bias the recorded measurements.

---

## B2-Q20 — Mean Arterial Pressure And Total Peripheral Resistance

**Stem.** A patient in an intensive care unit receives an infusion of an experimental agent while a pacemaker holds heart rate constant. Mean arterial pressure falls from \(90\) to \(54\ \text{mm Hg}\), cardiac output rises from \(5.0\) to \(6.0\ \text{L/min}\), and right atrial pressure stays near \(0\ \text{mm Hg}\). Total peripheral resistance has most likely changed in which way?

- **A.** Reduced by roughly \(20\%\)
- **B.** Reduced by roughly \(40\%\)
- **C.** Reduced by roughly \(50\%\)  <- **KEY**
- **D.** Increased by roughly \(100\%\)

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic medium / structural hard) |
| Estimated time | 110 s |
| Confidence | 4 |
| Hard-tier gate | Condition 1 CONCEPT CHAINING: the solver must invert \(\text{MAP} = \text{CO} \times \text{TPR}\), recognize that a right atrial pressure near zero permits using mean arterial pressure as the full driving pressure, compute two resistance values, and form their ratio. Condition 3 TRUE PARTIAL-TRUTH TRAP: choice B is exactly correct under the slightly different condition of constant cardiac output, and it is wrong here only because output also moved. Condition 4 510-TEMPTING DISTRACTOR: choice B is likewise where a strong student lands after correctly identifying the pressure fall as the relevant signal and overlooking that the flow term moved too. |

**Correct answer (C): Reduced by roughly \(50\%\)**

Citations: AP:39064 to 39065 verbatim: 'One of several things this equation allows us to do is calculate the resistance in the vascular system. Normally this value is extremely difficult to measure, but it can be calculated from this known relationship:' (the displayed relationship, resistance equals the pressure difference divided by flow, is rendered as an image in the text extraction, and AP:39066 is blank). AP:39157 to 39159 verbatim: 'resistance is inversely proportional to the radius of the blood vessel (one-half of the vessel's diameter) raised to the fourth power (R = 1/r4). This means, for example, that if an artery or arteriole constricts to one-half of its original radius, the resistance to flow will increase 16 times.' AP:39078 to 39079 verbatim: 'Two of these variables, viscosity and vessel length, will change slowly in the body. Only one of these factors, the radius, can be changed rapidly by vasoconstriction and vasodilation'. AP:39165 verbatim: 'arterioles are the site of greatest resistance in the entire vascular network.' AP:39542 verbatim: 'sympathetic stimulation be suppressed. When it is, an arteriole can expand by as much as 150 percent.' AP:38929 to 38930 context: the normal mean arterial pressure range is given as 70 to 110 mm Hg. Confidence 4 because the equation supporting mean arterial pressure equals cardiac output times total peripheral resistance appears as an image rather than as quotable text. AAMC outline line 1837: 'Source of peripheral resistance'.

**Distractors**

- **(A)** `process_step_confusion` . _uses the flow term alone_ — Reading the \(20\%\) rise in output straight across silently assumes the driving pressure was unchanged when it fell by \(36\ \text{mm Hg}\).
  - Citation: AP:39064 'One of several things this equation allows us to do is calculate the resistance in the vascular system.'
- **(B)** `partial_truth` . _correct only under constant cardiac output_ — \(54/90 = 0.60\) is exactly right if output were fixed, but output rose to \(6.0\ \text{L/min}\), so the true reduction is larger.
  - Citation: AP:39065 'value is extremely difficult to measure, but it can be calculated from this known relationship:'
- **(D)** `reversed_relationship` . _inverts the resistance ratio_ — \(18.0/9.0\) reverses baseline and treatment; a circuit carrying more flow at a lower driving pressure cannot have higher resistance.
  - Citation: AP:39157 to 39158 'resistance is inversely proportional to the radius of the blood vessel (one-half of the vessel's diameter) raised to the fourth power'

**Readback check.** The stem supplies two pressure values, two flow values, and a near zero venous pressure, and never states any direction or magnitude for resistance. The key is a numeric fraction that no content word of the stem echoes. AUDIT: one readback defect fixed. The draft stem identified the infusion as 'a vasodilator acting only on arterioles', which handed the student the direction of the resistance change and made choice D eliminable on the drug label alone; the agent is now unlabeled, so direction and magnitude must both be computed. Setting changed from an anesthetized dog to an intensive care patient to remove a near duplicate framing with the arteriole localization item in the same unit. One factually wrong explanation clause fixed: the Choice C block stated that 'resistance varies with the fourth power of radius', which inverts the actual relationship; the source states resistance is inversely proportional to radius raised to the fourth power. One distractor rationale corrected: choice A was justified as \(1/1.2\), which is a \(17\%\) reduction rather than the \(20\%\) printed, so the rationale now describes the linear error of reading the \(20\%\) rise in output straight across. Two citation defects fixed: the normal mean arterial pressure range was cited to blank line AP:38928 and is on AP:38929 to 38930, and the resistance equation passage ends at AP:39065 rather than the blank AP:39066; the AAMC scope line is 1837.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because resistance is the driving pressure divided by flow, and both terms moved in the same direction of effect, so the resistance change is larger than either term alone suggests. Rearranging \(\text{MAP} = \text{CO} \times \text{TPR}\) gives \(\text{TPR} = \text{MAP} / \text{CO}\), and because right atrial pressure sits near \(0\ \text{mm Hg}\) the full mean arterial pressure serves as the driving pressure across the circuit. At baseline the resistance is \(90 / 5.0 = 18.0\) arbitrary resistance units and during the infusion it is \(54 / 6.0 = 9.0\) units, so the ratio is \(9.0 / 18.0 = 0.50\), a reduction of \(50\%\). Holding heart rate fixed removes rate driven changes in output, so the rise in flow reflects an easier path through the circuit rather than a faster pump.
>
> (Choice A) A reduction of roughly \(20\%\) matches the \(20\%\) rise in cardiac output and is what follows from attributing the entire change to flow while treating the driving pressure as unchanged. The data contradict that assumption, since the driving pressure fell by \(36\ \text{mm Hg}\). Ignoring a \(40\%\) fall in the numerator badly understates how much the circuit opened.
>
> (Choice B) A reduction of roughly \(40\%\) comes from using the pressure fall alone, since \(54 / 90 = 0.60\). This value would in fact be exactly correct if cardiac output had been held constant, which is why it is so tempting. Output rose instead, and a circuit that carries more flow at a lower driving pressure has dropped its resistance by more than the pressure decline alone indicates.
>
> (Choice C) Both terms of \(\text{TPR} = \text{MAP} / \text{CO}\) shifted toward lower resistance, so their effects compound: \(0.60\) from the pressure term multiplied by \(1/1.2\) from the flow term gives \(0.50\). A halving of resistance is physiologically reasonable for widespread arteriolar dilation, since resistance is inversely proportional to the fourth power of vessel radius and these vessels normally sit partially constricted. The result also illustrates that a falling arterial pressure does not by itself imply a failing pump.
>
> (Choice D) An increase of roughly \(100\%\) results from inverting the ratio and computing \(18.0 / 9.0\). Resistance cannot rise when a circuit simultaneously carries more flow at a lower driving pressure, since resistance is defined as that pressure difference divided by that flow. Both measured changes therefore force the direction downward.
>
> This is a Scientific Reasoning and Problem Solving question because you must rearrange the pressure, flow, and resistance relationship and combine two simultaneous measured changes into a single fractional result.

---

## B2-Q21 — Vessel Radius and Blood Flow

**Stem.** Two skeletal muscle beds are perfused in parallel from the same feed artery and drain into the same vein, so both experience the same driving pressure. The arterioles of bed X have twice the lumen radius of those in bed Y, while vessel lengths and blood viscosity are matched. If bed Y receives \(15\ \text{mL/min}\), bed X most likely receives approximately which flow?

- **A.** Approximately \(30\ \text{mL/min}\)
- **B.** Approximately \(60\ \text{mL/min}\)
- **C.** Approximately \(120\ \text{mL/min}\)
- **D.** Approximately \(240\ \text{mL/min}\)  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 4B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic easy / structural easy) |
| Estimated time | 60 s |
| Confidence | 5 |

**Correct answer (D): Approximately \(240\ \text{mL/min}\)**

Citations: AP:39157-39161 (verbatim, span corrected from the draft's AP:39158-39160) 'This is because resistance is inversely proportional to the radius of the blood vessel (one-half of the vessel's diameter) raised to the fourth power (R = 1/r4). This means, for example, that if an artery or arteriole constricts to one-half of its original radius, the resistance to flow will increase 16 times. And if an artery or arteriole dilates to twice its initial radius, then resistance in the vessel will decrease to 1/16 of its original value and flow will increase 16 times.' | AP:39079-39081 (verbatim) 'Only one of these factors, the radius, can be changed rapidly by vasoconstriction and vasodilation, thus dramatically impacting resistance and flow. Further, small changes in the radius will greatly affect flow, since it is raised to the fourth power in the equation.' | AP:39060-39061 (verbatim) 'r4 is the radius (one-half of the diameter) of the vessel to the fourth power.' listed among the terms of Poiseuille's equation alongside the pressure difference term on AP:39060. | AP:39165 (verbatim, span tightened from the draft's AP:39164-39165) 'In fact, arterioles are the site of greatest resistance in the entire vascular network.' | AAMC outline:2422 (verified) 'Viscosity: Poiseuille Flow' under Foundational Concept 4B (heading verified at AAMC outline:2414). File paths: /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-anatomy-physiology-2e.txt and /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/aamc/aamc-content-outline-2026.txt

**Distractors**

- **(A)** `misconception` . _linear radius scaling_ — Doubles the flow, treating flow as proportional to r rather than r to the fourth power; underestimates the true flow eightfold.
  - Citation: AP:39080-39081 (verified) 'Further, small changes in the radius will greatly affect flow, since it is raised to the fourth power in the equation.'
- **(B)** `scale_unit_error` . _area scaling substituted for flow scaling_ — Applies an r-squared dependence, which correctly describes cross-sectional area but not volumetric flow through a resistive tube.
  - Citation: AP:39153-39154 (verified) 'A decreased diameter means more of the blood contacts the vessel wall, and resistance increases, subsequently decreasing flow.'
- **(C)** `scale_unit_error` . _cubed instead of fourth power radius exponent_ — Applies an r-cubed dependence; no term in the flow relationship scales with the cube of the radius, so the flow gain is understated.
  - Citation: AP:39061 (verified) 'r4 is the radius (one-half of the diameter) of the vessel to the fourth power.'

**Readback check.** Stem content words: skeletal muscle beds, parallel, feed artery, vein, driving pressure, arterioles, bed X, bed Y, twice, lumen radius, vessel lengths, viscosity, matched, 15 mL/min. The keyed option's distinctive content is the number 240, which appears nowhere in the stem. All four options share the identical frame 'Approximately X mL/min', so no option is grammatically or semantically privileged. A student who does not know that flow scales with the fourth power of radius cannot recover the factor of 16, and the three wrong values correspond to real alternative exponents (first, second, third power) rather than nonsense. No definition-to-name, no stem echo, no self-justifying key. AUDIT CHANGES: (1) reframed the stem from a single bed constricted to half radius into a two-bed parallel comparison at doubled radius, because the original arithmetic (halve the radius, flow falls to one sixteenth of 320 mL/min) was duplicated almost verbatim by the 'Constriction' row of the Roman numeral item later in this same batch; (2) added vessel length to the list of matched variables, since the explanation relies on it being fixed and the original stem held only pressure and viscosity constant; (3) corrected a factually wrong explanation clause that called an r-cubed dependence 'the scaling of a volume', which is false for a tube (a vessel segment's volume scales as r squared at fixed length), and replaced it with an accurate statement that no term in the flow relationship scales with the cube of the radius; (4) repaired three misnumbered citations verified line by line against the source: the R = 1/r4 passage runs AP:39157-39161, not AP:39158-39160; the 'inversely proportional to the radius ... fourth power' quote spans AP:39157-39158, not AP:39158 alone; and the 'constricts to one-half' quote spans AP:39158-39159, not AP:39159 alone.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because flow varies with the fourth power of vessel radius, so a bed whose arterioles have twice the lumen radius carries sixteen times the flow at the same driving pressure.
>
> Poiseuille's relationship gives flow as \(Q = \Delta P \pi r^4 / 8 \eta \lambda\). With driving pressure, viscosity, and vessel length all matched between the two beds, flow depends only on \(r^4\), so scaling the radius by \(2\) scales flow by \(2^4 = 16\). That gives \(15\ \text{mL/min} \times 16 = 240\ \text{mL/min}\). This fourth power sensitivity is why arterioles, whose smooth muscle can change lumen radius within seconds, are the dominant control point for regional perfusion.
>
> (Choice A) \(30\ \text{mL/min}\) results from treating flow as directly proportional to radius and simply doubling. Radius enters the flow relationship raised to the fourth power, not the first, so this value underestimates the true flow eightfold. A linear correction badly understates how much perfusion a modest dilation can capture.
>
> (Choice B) \(60\ \text{mL/min}\) applies an \(r^2\) dependence, the scaling that governs cross-sectional area rather than volumetric flow. Cross-sectional area does rise fourfold here, but a wider lumen also places proportionally less blood in contact with the wall, so frictional resistance falls faster than area alone predicts.
>
> (Choice C) \(120\ \text{mL/min}\) follows from cubing the radius ratio, applying \(r^3\) where the flow relationship calls for \(r^4\). No term in Poiseuille's relationship scales with the cube of the radius, and a third power still understates how strongly arteriolar caliber governs perfusion.
>
> (Choice D) \(240\ \text{mL/min}\) correctly applies \(2^4 = 16\) to the flow in bed Y. It also illustrates the clinical point that two beds fed at identical pressure can differ in perfusion by more than an order of magnitude on the basis of arteriolar tone alone.
>
> This is a Scientific Reasoning and Problem Solving question because you must apply the fourth power dependence of flow on vessel radius to a specific numerical comparison.

---

## B2-Q22 — Total Cross-Sectional Area and Flow Velocity

**Stem.** The table describes a model systemic circuit in which volumetric flow through every segment is \(80\ \text{mL/s}\).

| Segment | Total cross-sectional area \((\text{cm}^2)\) | Mean velocity \((\text{cm/s})\) |
| --- | --- | --- |
| Aorta | \(2\) | \(40\) |
| Arterioles | \(200\) | \(0.4\) |
| Capillaries | \(2000\) | \(0.04\) |
| Venae cavae | \(4\) | \(20\) |

Chronic disease prunes the capillary bed so that total capillary cross-sectional area falls by half, while the length of each surviving capillary and the volumetric flow through the circuit stay the same. Which consequence for that capillary bed is most likely?

- **A.** Capillary velocity doubles, shortening the time available for exchange  <- **KEY**
- **B.** Capillary velocity halves, lengthening the time available for exchange
- **C.** Capillary velocity is unchanged, since volumetric flow is unchanged
- **D.** Capillary velocity doubles, lengthening the time available for exchange

| | |
|---|---|
| AAMC Foundation | 4B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 95 s |
| Confidence | 5 |

**Correct answer (A): Capillary velocity doubles, shortening the time available for exchange**

Citations: AP:39168-39171 (verbatim, verified) 'Figure 20.13 compares vessel diameter, total cross-sectional area, average blood pressure, and blood velocity through the systemic vessels. Notice in parts (a) and (b) that the total cross-sectional area of the body's capillary beds is far greater than any other type of vessel. Although the diameter of an individual capillary is significantly smaller than the diameter of an arteriole, there are vastly more capillaries in the body than there are other types of blood vessels.' | AP:39178-39180 (verbatim, verified) 'Part (d) shows that the velocity (speed) of blood flow decreases dramatically as the blood moves from arteries to arterioles to capillaries. This slow flow rate allows more time for exchange processes to occur. As blood flows through the veins, the rate of velocity increases, as blood is returned to the heart.' | AP:39299-39300 (verbatim, span corrected from the draft's AP:39300-39302) 'Although vessel diameter increases from the smaller venules to the larger veins and eventually to the venae cavae (singular = vena cava), the total cross-sectional area actually decreases.' | AAMC outline:2423 (verified) 'Continuity equation (A.v = constant)' under 4B. Table values are an explicitly labeled model, internally consistent in that each row's area times velocity equals 80 mL/s, and qualitatively ordered as the textbook describes (capillaries greatest total area and lowest velocity, venae cavae smaller total area and higher velocity than capillaries). File: /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-anatomy-physiology-2e.txt

**Distractors**

- **(B)** `reversed_relationship` . _inverted continuity relationship_ — Treats a smaller total cross-sectional area as slowing blood; at fixed volumetric flow, reduced area necessarily raises velocity.
  - Citation: AP:39178-39179 (verified) 'Part (d) shows that the velocity (speed) of blood flow decreases dramatically as the blood moves from arteries to arterioles to capillaries. This slow flow rate allows more time for exchange processes to occur.'
- **(C)** `misconception` . _volumetric flow conflated with linear velocity_ — Assumes that constant volume per unit time means constant speed; the same volume through half the area must travel twice as fast.
  - Citation: AP:39169-39171 (verified) 'the total cross-sectional area of the body's capillary beds is far greater than any other type of vessel. Although the diameter of an individual capillary is significantly smaller than the diameter of an arteriole, there are vastly more capillaries in the body than there are other types of blood vessels.'
- **(D)** `partial_truth` . _correct velocity change, inverted exchange consequence_ — Correctly doubles velocity but claims more exchange time; faster transit through a fixed capillary length shortens, not lengthens, contact time.
  - Citation: AP:39179 (verified) 'This slow flow rate allows more time for exchange processes to occur.'

**Readback check.** Stem content words: model systemic circuit, volumetric flow, 80 mL/s, total cross-sectional area, mean velocity, aorta, arterioles, capillaries, venae cavae, prunes, falls by half, length, stay the same. Keyed option's distinctive content words: doubles, shortening, exchange. None of these appears in the stem; 'exchange' was deliberately kept out of the stem wording. 'Velocity' and 'capillary' appear in the stem but also in all four options, so they carry no discriminating signal. All four options share the frame 'Capillary velocity ...', so no option stands out structurally. A student who does not grasp that area times velocity is constant cannot decide between doubling, halving, and no change, and cannot then infer the effect on residence time. Choice C intentionally echoes the stem premise, which makes it attractive rather than eliminable. AUDIT CHANGES: (1) added 'the length of each surviving capillary ... stay the same' to the stem, because the keyed reasoning depends on transit distance being fixed, and 'pruning a bed' could otherwise be read as altering individual capillary geometry; the explanation's original appeal to 'a capillary of unchanged length' was an unstated assumption and is now licensed by the stem; (2) labeled the table a model circuit, since the tabulated areas are internally consistent round numbers rather than measured human averages, and the draft stem asserted them as a description of an actual circuit; (3) corrected the misnumbered venae cavae citation from AP:39300-39302 to AP:39299-39300. All other citations in this item were checked line by line and are accurate as drafted.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because velocity equals volumetric flow divided by total cross-sectional area, so halving the capillary area at fixed flow doubles the speed at which blood traverses the bed.
>
> Every row of the table satisfies the same product: \(2 \times 40\), \(200 \times 0.4\), \(2000 \times 0.04\), and \(4 \times 20\) each equal \(80\ \text{mL/s}\). Capillary blood is slow not because an individual capillary is narrow but because capillaries collectively present an enormous combined cross-section. Dropping that area from \(2000\ \text{cm}^2\) to \(1000\ \text{cm}^2\) at unchanged flow raises velocity from \(0.04\ \text{cm/s}\) to \(0.08\ \text{cm/s}\). Because each surviving capillary is the same length as before, doubling the speed halves the residence time, and residence time is what diffusive exchange of gases, nutrients, and wastes depends on.
>
> (Choice A) Doubling velocity halves transit time through each capillary, so less time is available for solutes to diffuse across the wall. This is the physiological cost of capillary rarefaction even when total perfusion of the tissue is fully preserved.
>
> (Choice B) This reverses the relationship between area and velocity. Velocity would fall by half only if the combined cross-sectional area doubled; because area and velocity are inversely related at fixed volumetric flow, a shrinking bed speeds blood up rather than slowing it down.
>
> (Choice C) This confuses volumetric flow with linear velocity. Volumetric flow is indeed unchanged by assumption, but forcing the same volume per second through half the combined cross-section requires each unit of blood to move twice as fast.
>
> (Choice D) This gets the direction of the velocity change right but reverses its consequence. Longer exchange time accompanies slower flow, which is precisely why the normally vast capillary cross-section, and the crawl it produces, favors diffusion.
>
> This is a Data-based and Statistical Reasoning question because you must use the tabulated area and velocity values to determine how a change in one variable propagates to the other at constant flow.

---

## B2-Q23 — Blood Viscosity and Vascular Resistance

**Stem.** A patient with polycythemia vera has a hematocrit of \(65\%\), compared with \(45\%\) in a healthy control. Vessel radii, vessel lengths, and cardiac output are equivalent in the two individuals. Which pair of changes in the patient's systemic circulation is most likely?

- **A.** Vascular resistance falls, and cardiac workload falls
- **B.** Vascular resistance falls, and cardiac workload rises
- **C.** Vascular resistance rises, and cardiac workload rises  <- **KEY**
- **D.** Vascular resistance rises, and cardiac workload falls

| | |
|---|---|
| AAMC Foundation | 4B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 75 s |
| Confidence | 5 |

**Correct answer (C): Vascular resistance rises, and cardiac workload rises**

Citations: AP:39109-39110 (verbatim, verified) 'The viscosity of blood is directly proportional to resistance and inversely proportional to flow; therefore, any condition that causes viscosity to increase will also increase resistance and decrease flow.' | AP:39115-39117 (verbatim, verified) 'The two primary determinants of blood viscosity are the formed elements and plasma proteins. Since the vast majority of formed elements are erythrocytes, any condition affecting erythropoiesis, such as polycythemia or anemia, can alter viscosity.' | AP:33774-33776 (verbatim, verified) 'Blood is viscous and somewhat sticky to the touch. It has a viscosity approximately five times greater than water. Viscosity is a measure of a fluid's thickness or resistance to flow, and is influenced by the presence of the plasma proteins and formed elements within the blood.' | AP:33753 (verbatim, verified) 'normal blood, about 45 percent of a sample is erythrocytes.' | AP:34142-34144 (verbatim, verified) 'The primary drawback with polycythemia is not a failure to directly deliver enough oxygen to the tissues, but rather the increased viscosity of the blood, which makes it more difficult for the heart to circulate the blood.' | AP:34337-34338 (verbatim, span corrected from the draft's AP:34337-34339) 'a type of bone marrow disease called polycythemia vera (from the Greek vera = 'true') causes an excessive production of immature erythrocytes.' | AP:34338-34340 (verbatim, added) 'Polycythemia vera can dangerously elevate the viscosity of blood, raising blood pressure and making it more difficult for the heart to pump blood throughout the body.' | AP:39040-39041 (verbatim, added, replaces the draft's AP:34008-34009 blood doping citation) 'The result is more turbulence, higher pressure within the vessel, and reduced blood flow. This increases the work of the heart.' | AAMC outline:2422 (verified) 'Viscosity: Poiseuille Flow' under 4B. File: /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-anatomy-physiology-2e.txt

**Distractors**

- **(A)** `reversed_relationship` . _more cells read as easier flow_ — Reverses the viscosity-resistance relationship; a higher packed cell volume increases internal friction and therefore raises, not lowers, resistance.
  - Citation: AP:39109-39110 (verified) 'The viscosity of blood is directly proportional to resistance and inversely proportional to flow; therefore, any condition that causes viscosity to increase will also increase resistance and decrease flow.'
- **(B)** `process_step_confusion` . _mismatched resistance and workload directions_ — Combines falling resistance with rising ventricular work; at fixed output, lower resistance permits a lower ejection pressure and therefore less work.
  - Citation: AP:39040-39041 (verified) 'The result is more turbulence, higher pressure within the vessel, and reduced blood flow. This increases the work of the heart.'
- **(D)** `partial_truth` . _right resistance, wrong workload_ — Correctly raises resistance but assumes better oxygen carriage lightens the pump's load; mechanical work is set by pressure and volume, not oxygen content.
  - Citation: AP:34142-34144 (verified) 'The primary drawback with polycythemia is not a failure to directly deliver enough oxygen to the tissues, but rather the increased viscosity of the blood, which makes it more difficult for the heart to circulate the blood.'

**Readback check.** Stem content words: polycythemia vera, hematocrit, 65 percent, 45 percent, vessel radii, vessel lengths, cardiac output, equivalent. Keyed option's content words: vascular resistance, rises, cardiac workload, rises. The word 'cardiac' appears in the stem but is present in all four options ('cardiac workload'), so it carries no discriminating signal, and neither 'resistance' nor 'viscosity' nor 'rises' appears in the stem. The four options form a complete two by two grid, so no option is eliminable on grammar, plausibility, or category membership. A student who does not know that erythrocyte fraction drives viscosity has no route from the stem to the correct pairing. AUDIT CHANGES: (1) corrected the polycythemia vera citation span from AP:34337-34339 to AP:34337-34338 (the quoted sentence ends mid-line 34338) and added the directly on point AP:34338-34340 sentence, which states the pressure and pump consequences explicitly; (2) removed the AP:34008-34009 citation, which sits inside the synthetic erythropoietin blood doping feature box and therefore drew support from a hormone topic reserved for another live chapter, and replaced it with AP:39040-39041, which states the resistance to cardiac work link without touching that topic; (3) revised the Choice C block to track the newly cited sentence rather than the blood doping sentence about death in extreme cases. Stem and options are unchanged: no stem echo was found, and the two by two option grid was already clean.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because a packed cell volume of \(65\%\) makes blood substantially more viscous, and viscosity sits in the denominator of the flow relationship, so resistance rises and the ventricle must generate a higher pressure to move the same output.
>
> Erythrocytes are the overwhelming majority of the formed elements and are therefore the principal determinant of how thick blood is. At a normal packed cell volume near \(45\%\), blood is already about five times as viscous as water; pushing that fraction to \(65\%\) raises internal friction steeply. Because \(Q = \Delta P \pi r^4 / 8 \eta \lambda\) and both radii and lengths are matched between the two individuals, the entire difference in resistance is attributable to \(\eta\). Sustaining an unchanged cardiac output against a higher resistance demands a higher driving pressure, and the product of that pressure and the volume ejected is the mechanical work the ventricle performs.
>
> (Choice A) This treats a richer suspension of cells as easier to move. Adding formed elements increases friction within the fluid and against the vessel wall, so resistance climbs rather than falls, and the pump faces a larger load rather than a smaller one.
>
> (Choice B) This pairs the wrong direction of resistance with the right direction of workload. If resistance genuinely fell, the ventricle could eject the same output against a lower pressure and would therefore do less work, so the two halves of this choice contradict each other.
>
> (Choice C) Elevated packed cell volume raises viscosity, viscosity raises resistance, and higher resistance at fixed output raises ventricular work. Sustained over time this drives ventricular hypertrophy, and in severe polycythemia vera it raises blood pressure and makes it progressively harder for the heart to move blood through the body.
>
> (Choice D) This identifies the resistance change correctly but assumes the heart's task gets easier because each milliliter of blood now carries more oxygen. Oxygen content per unit volume does rise, yet the pump must still overcome a higher resistance, so its mechanical work increases rather than decreases.
>
> This is a Scientific Reasoning and Problem Solving question because you must trace a change in blood composition through its effect on viscosity to its mechanical consequence for the ventricle.

---

## B2-Q24 — Turbulence and Vascular Sound

**Stem.** A bruit is audible over a carotid artery partially narrowed by plaque. Investigators suspect the sound arises from turbulence at the narrowing rather than from vibration of the plaque itself. Which finding would best support the turbulence hypothesis?

- **A.** The bruit disappears after a graft reroutes blood around the plaque
- **B.** The bruit is reproduced by mechanically vibrating the plaque with no flow present
- **C.** The bruit is loudest at peak systolic ejection in every patient tested
- **D.** The bruit disappears when blood velocity past the unchanged plaque falls  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 4B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 85 s |
| Confidence | 4 |

**Correct answer (D): The bruit disappears when blood velocity past the unchanged plaque falls**

Citations: AP:38970 (verbatim, verified) 'Turbulent blood flow through the vessels can be heard as a soft ticking while measuring blood pressure;' and AP:38975 (verbatim, verified) 'these sounds are known as Korotkoff sounds.' The draft attributed both clauses to AP:38970 alone; they are split across a page header in the source. | AP:38985-38987 (verbatim, span corrected from the draft's AP:38985-38988) 'Initially, no sounds are heard since there is no blood flow through the vessels, but as air pressure drops, the cuff relaxes, and blood flow returns to the arm.' | AP:38988-38989 (verbatim, added) 'As more air is released from the cuff, blood is able to flow freely through the brachial artery and all sounds disappear.' This is the direct textbook parallel for the keyed observation: the sound is present only while blood is driven fast past a narrowed segment and vanishes when that condition is removed. | AP:37106-37107 (verbatim, verified) 'The term murmur is used to describe an unusual sound coming from the heart that is caused by the turbulent flow of blood.' | AAMC outline:2424 (verified) 'Concept of turbulence at high velocities' under 4B. The draft's AP:39039-39041 compliance citation was REMOVED from this item because it states that stiffening increases turbulence, which supported rather than refuted the draft's choice B. Confidence 4 rather than 5 because the critical velocity for turbulence is named by the AAMC outline and implied by the auscultation passage but is not given as an explicit numerical criterion in the OpenStax text. File: /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-anatomy-physiology-2e.txt

**Distractors**

- **(A)** `partial_truth` . _manipulation that removes both candidate causes_ — Bypassing the segment abolishes the flow disturbance and simultaneously removes the plaque from any moving stream, so it cannot separate the two hypotheses.
  - Citation: AP:37106-37107 (verified) 'The term murmur is used to describe an unusual sound coming from the heart that is caused by the turbulent flow of blood.'
- **(B)** `reversed_relationship` . _evidence favoring the competing hypothesis_ — A sound generated by vibrating the plaque with no blood moving cannot be turbulence, so this finding supports the very hypothesis the investigators are trying to rule out.
  - Citation: AP:38970 (verified) 'Turbulent blood flow through the vessels can be heard as a soft ticking while measuring blood pressure.'
- **(C)** `adjacent_fact` . _observation predicted by both hypotheses_ — Systolic accentuation is expected under either mechanism, since systole raises both velocity and pulsatile force on the plaque, so it discriminates nothing.
  - Citation: AP:38985-38987 (verified) 'Initially, no sounds are heard since there is no blood flow through the vessels, but as air pressure drops, the cuff relaxes, and blood flow returns to the arm.'

**Readback check.** Stem content words: bruit, carotid artery, partially narrowed, plaque, turbulence, narrowing, vibration. Keyed option's distinctive content words: blood, velocity, unchanged, falls. None of 'velocity', 'unchanged', or 'falls' appears in the stem, and 'blood' appears in choice A as well as in the key, so the fluid vocabulary does not single out the key. 'Bruit' is in all four options and 'plaque' is in three of four, so neither discriminates. All four choices are real, topic-associated observations about bruits; three of them could genuinely be observed and simply fail to support the stated hypothesis, so none can be eliminated without understanding that turbulence is velocity dependent. AUDIT CHANGES: (1) STEM ECHO FIXED. The draft key contained 'obstruction', which appeared twice in the draft stem and in no other option, giving the key a unique lexical bridge; the stem now says 'narrowed' and 'narrowing' and the key says 'plaque', a word shared with two distractors. The draft stem's phrase 'as blood passes the obstruction' was also removed so that 'blood' is not seeded in the stem. (2) AMBIGUITY FIXED. The draft's choice B ('the bruit grows louder when the plaque is stiffened at unchanged lumen diameter') was defensible as evidence FOR turbulence, because the textbook states at AP:39039-39041 that stiffening of vessels reduces compliance and produces more turbulence. Worse, the draft cited that very passage as the reason the choice was wrong, so the citation actively contradicted the rationale it was attached to. Choice B is now a bloodless mechanical vibration test, which supports the rival hypothesis with no turbulence reading available. (3) FACTUAL ERROR IN EXPLANATION FIXED. The draft's Choice A block claimed a bypass graft means 'the plaque no longer sits in the bloodstream', which is false: the native vessel and its plaque remain in place after a bypass. The block now says correctly that the plaque is no longer exposed to a rushing stream. (4) CITATION FIXED. The draft cited AP:38970 as containing the whole Korotkoff sentence, but the clause 'these sounds are known as Korotkoff sounds' sits at AP:38975 after an intervening page header; the two line numbers are now cited separately. The draft's AP:38985-38988 span was also one line long and is corrected to AP:38985-38987.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because lowering velocity while leaving the plaque and the lumen geometry untouched varies only the fluid variable, so loss of the sound isolates disturbed flow as its source.
>
> Circulatory sounds arise where flow past a narrowed or irregular segment becomes turbulent, and turbulence appears only above a critical velocity. A test discriminates between the two candidate sources only if it changes velocity while leaving the structural candidate in place and unaltered. If the bruit vanishes at reduced velocity even though the identical plaque still sits in the identical lumen, the plaque by itself cannot be producing the sound. The same principle underlies auscultatory blood pressure measurement, in which sound is heard only while blood is driven at high velocity past a partially compressed artery and disappears once flow through the vessel is free again.
>
> (Choice A) Rerouting blood around the plaque removes both candidate sources at once: no blood traverses the narrowing, and the plaque is no longer exposed to the rushing stream that could set it vibrating. A manipulation that eliminates both explanations simultaneously cannot distinguish between them, however dramatic the silence.
>
> (Choice B) Reproducing the sound by vibrating the plaque with no flow present is direct evidence for the competing explanation, since a sound generated in the complete absence of moving blood cannot be turbulence. This observation points in the opposite direction from the conclusion the investigators are trying to establish.
>
> (Choice C) Peak loudness during systole is predicted by both hypotheses, because systole delivers both the highest blood velocity and the strongest pulsatile force against the plaque. A finding compatible with both competing explanations supplies no discriminating evidence.
>
> (Choice D) Reducing velocity through an unchanged narrowing varies exactly one factor while the proposed alternative source is held fixed. Silencing of the bruit under that single manipulation is the observation that separates a flow generated sound from a structure generated one.
>
> This is a Reasoning about the Design and Execution of Research question because you must identify the manipulation that varies one candidate cause while holding the competing cause constant.

---

## B2-Q25 — Poiseuille Determinants of Vascular Resistance

**Stem.** An isolated vascular bed is perfused at a constant pressure difference of \(60\ \text{mm Hg}\), and steady flow is measured under four conditions.

| Condition | Relative arteriolar radius | Relative bed length | Relative viscosity | Flow \((\text{mL/min})\) |
| --- | --- | --- | --- | --- |
| Baseline | \(1.0\) | \(1.0\) | \(1.0\) | \(160\) |
| Constriction | \(0.5\) | \(1.0\) | \(1.0\) | \(10\) |
| Longer bed | \(1.0\) | \(2.0\) | \(1.0\) | \(80\) |
| Raised hematocrit | \(1.0\) | \(1.0\) | \(2.0\) | \(80\) |

Which of the statements below are supported by these measurements?

I. Halving arteriolar radius lowers flow more than doubling bed length and doubling viscosity together.
II. Doubling both bed length and viscosity from baseline would yield a flow near \(40\ \text{mL/min}\).
III. Restoring the constricted bed to \(160\ \text{mL/min}\) would require a perfusion pressure near \(240\ \text{mm Hg}\).

- **A.** I and II only  <- **KEY**
- **B.** I and III only
- **C.** II and III only
- **D.** I, II, and III

| | |
|---|---|
| AAMC Foundation | 4B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic hard / structural hard) |
| Estimated time | 145 s |
| Confidence | 5 |
| Hard-tier gate | Meets three of the four conditions, re-verified during audit. (1) CONCEPT CHAINING: the student must extract the radius exponent from the constriction row, combine two independent halving effects multiplicatively for statement II, compare that product against the constricted flow for statement I, and then invert the pressure-flow proportionality for statement III, four linked steps. (2) DATA-TO-MECHANISM: the tabulated flows are not read off as answers; they must be used to infer the underlying scaling law before any statement can be judged, and statement II asks for a value that appears nowhere in the table. (4) 510-TEMPTING DISTRACTOR: the \(240\ \text{mm Hg}\) figure in statement III is exactly where a strong student lands after applying an \(r^2\) instead of an \(r^4\) dependence, which makes both B and D attractive and makes the item discriminate sharply at the top of the scale. |

**Correct answer (A): I and II only**

Citations: AP:39079-39081 (verbatim, verified) 'Only one of these factors, the radius, can be changed rapidly by vasoconstriction and vasodilation, thus dramatically impacting resistance and flow. Further, small changes in the radius will greatly affect flow, since it is raised to the fourth power in the equation.' | AP:39077 (verbatim, verified) 'By examining this equation, you can see that there are only three variables: viscosity, vessel length, and radius,' | AP:39157-39161 (verbatim, span corrected from the draft's AP:39158-39161) 'This is because resistance is inversely proportional to the radius of the blood vessel (one-half of the vessel's diameter) raised to the fourth power (R = 1/r4). This means, for example, that if an artery or arteriole constricts to one-half of its original radius, the resistance to flow will increase 16 times. And if an artery or arteriole dilates to twice its initial radius, then resistance in the vessel will decrease to 1/16 of its original value and flow will increase 16 times.' | AP:39125-39126 (verbatim, verified) 'The length of a vessel is directly proportional to its resistance: the longer the vessel, the greater the resistance and the lower the flow.' | AP:39109-39110 (verbatim, verified) 'The viscosity of blood is directly proportional to resistance and inversely proportional to flow.' | AP:39165 (verbatim, span tightened from the draft's AP:39164-39165) 'In fact, arterioles are the site of greatest resistance in the entire vascular network.' | AP:39060-39061 (verified, span corrected from the draft's AP:39055-39062) lists the terms of Poiseuille's equation: the pressure difference term at AP:39060 and 'r4 is the radius (one-half of the diameter) of the vessel to the fourth power.' at AP:39061. | AAMC outline:2422 (verified) 'Viscosity: Poiseuille Flow' under 4B. All four table rows are internally consistent with flow proportional to r^4 divided by the product of viscosity and length at fixed pressure difference. File: /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-anatomy-physiology-2e.txt

**Distractors**

- **(B)** `scale_unit_error` . _squared instead of fourth power radius dependence_ — Accepts 240 mm Hg, which assumes resistance rose only fourfold; the constriction row already shows a sixteenfold flow penalty, requiring 960 mm Hg.
  - Citation: AP:39158-39159 (span corrected from the draft's AP:39159-39161) 'if an artery or arteriole constricts to one-half of its original radius, the resistance to flow will increase 16 times.'
- **(C)** `partial_truth` . _correct combination, rejected valid comparison_ — Correctly computes 40 mL/min but discards statement I, which the measured 10 mL/min value supports outright, while retaining the contradicted pressure claim.
  - Citation: AP:39077 (span corrected from the draft's AP:39077-39079) 'you can see that there are only three variables: viscosity, vessel length, and radius'
- **(D)** `misconception` . _all statements accepted without checking the pressure inversion_ — Endorses statement III, which would hold only under a squared radius dependence; flow is proportional to driving pressure, so restoration demands a sixteenfold pressure rise.
  - Citation: AP:39125-39126 (verified) 'The length of a vessel is directly proportional to its resistance: the longer the vessel, the greater the resistance and the lower the flow.'

**Readback check.** The answer options contain no content words at all, only Roman numeral combinations, so stem echo and definition-to-name failures are structurally impossible. Each Roman numeral statement requires an arithmetic result that is nowhere printed in the stem: statement II demands the product of two independently measured halvings, and statement III demands inversion of the pressure-flow proportionality. A student who does not understand that flow scales as radius to the fourth power and inversely with both length and viscosity cannot evaluate any of the three statements, and cannot distinguish 240 from 960 mm Hg. Each Roman numeral appears in exactly three of the four options, so no numeral can be resolved by elimination and partial credit guessing is not available. Arithmetic re-verified during audit: 160 times (0.5)^4 = 10; 160/2 = 80 for both the length and the viscosity rows; 160/4 = 40 for statement II; 10 < 40 so statement I is true; restoring 10 to 160 requires 16 times 60 = 960 mm Hg, so statement III is false; key A confirmed. AUDIT CHANGES: (1) three citation spans corrected after line by line verification. The R = 1/r4 passage runs AP:39157-39161, not the drafted AP:39158-39161, and the distractor B quote 'if an artery or arteriole constricts to one-half of its original radius, the resistance to flow will increase 16 times' spans AP:39158-39159, not AP:39159-39161. (2) The distractor C quote 'you can see that there are only three variables: viscosity, vessel length, and radius' sits entirely on AP:39077, not the drafted AP:39077-39079, and the trailing clause was trimmed because it contains a Greek character in the source that cannot be reproduced verbatim in ASCII. (3) The 'arterioles are the site of greatest resistance' quote is contained on AP:39165 alone, not the drafted AP:39164-39165, and the drafted AP:39055-39062 span for the equation terms is corrected to AP:39060-39061. (4) A redundancy note: the batch's easy radius item was rewritten during this audit into a dilation comparison, because its original stem duplicated this item's Constriction row computation almost exactly. Stem, table, statements, options, key, and difficulty tier are otherwise unchanged.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because statements I and II follow directly from the tabulated flows, while statement III underestimates the required perfusion pressure by a factor of four.
>
> The four rows isolate one variable at a time and reveal the exponents. Halving the radius takes flow from \(160\) to \(10\ \text{mL/min}\), a factor of \(1/16\), which is \((0.5)^4\) and therefore identifies a fourth power dependence on radius; doubling length and doubling viscosity each halve flow, identifying simple inverse dependences. Statement II combines those two inverse effects multiplicatively: \(160 \div (2 \times 2) = 40\ \text{mL/min}\). Statement I then compares the constricted bed at \(10\ \text{mL/min}\) with that combined value of \(40\ \text{mL/min}\), so radius change is by far the more powerful suppressor of flow, which is why arterioles rather than vessel length or blood thickness govern perfusion from moment to moment. Statement III fails because flow is directly proportional to the driving pressure, so lifting \(10\ \text{mL/min}\) back to \(160\ \text{mL/min}\) requires a sixteenfold pressure increase, from \(60\ \text{mm Hg}\) to \(960\ \text{mm Hg}\).
>
> (Choice A) I and II only is correct. Statement II is computed by multiplying the two independently measured halving effects, and statement I is then a direct numerical comparison between \(10\) and \(40\ \text{mL/min}\), both fully supported by the table.
>
> (Choice B) I and III only keeps the correct comparison in statement I but accepts \(240\ \text{mm Hg}\). That figure corresponds to a fourfold rise in resistance, the value obtained by squaring the radius ratio instead of raising it to the fourth power, and the table itself shows a sixteenfold flow penalty rather than a fourfold one.
>
> (Choice C) II and III only accepts the correct combined calculation but discards statement I, which the data support outright, and retains the pressure figure that the same data contradict. Statement I needs no assumption beyond the measured \(10\ \text{mL/min}\) and the computed \(40\ \text{mL/min}\).
>
> (Choice D) I, II, and III would be correct only if flow scaled with the square of radius. Because the measured constriction row already fixes the exponent at four, the required perfusion pressure is \(960\ \text{mm Hg}\), a value no physiological circulation could generate, which is the point of the item.
>
> This is a Data-based and Statistical Reasoning question because you must extract the scaling exponents from four one-variable perturbations and then invert the flow relationship to test a quantitative claim about driving pressure.

---



---

# BATCH 3 of 4 (25 questions): capillary exchange and blood

Units: endothelium and vessel architecture . portal systems . pressure, resistance and flow . fluid dynamics (AAMC 4B).

## Batch 2 summary

| Metric | Batch 2 | Combined (75) | Target |
|---|---|---|---|
| Difficulty | easy 8 . hard 5 . medium 12 | easy 20 . hard 22 . medium 33 | 27/40/33 |
| Answer letter | A 6 . B 10 . C 6 . D 3 | A 19 . B 20 . C 19 . D 17 | ~25% each |
| Cognitive skill | S1 3 . S2 18 . S3 2 . S4 2 | S1 9 . S2 50 . S3 6 . S4 10 | mixed |
| Confidence | conf4 1 . conf5 24 | conf4 5 . conf5 70 | only 4-5 ship |
| Roman numeral | 4 (16%) | 9 (12%) | 10-15% |
| Distractor categories | adjacent_fact 10 . misconception 16 . partial_truth 20 . process_step_confusion 11 . reversed_relationship 14 . scale_unit_error 4 | | none >40% |

**Deficits cleared from batch 1:** Roman-numeral format now 20% in this batch (10% combined, on target). Skill 3 introduced with 4 experimental-design items (endothelial function in isolated vessel rings, bruit turbulence hypothesis, sphygmomanometry technique, tracer studies). Answer letter D lifted from 20% to 28% combined.

**New deficit for batches 3-4:** answer letter B fell to 12% in this batch (20% combined); bias B upward. Easy tier is 24% combined against a 27% target; add easy items.

**Scope boundaries:** automated scan for the seven forbidden territories returned zero hits. No subtopic is duplicated between batches 1 and 2.

**Adversarial audit:** all 25 re-examined with every citation re-greped against the source file.

---

## B3-Q1 — Net Filtration Pressure at the Venular End

**Stem.** Blood enters a systemic capillary at a hydrostatic pressure of \(35\ \text{mm Hg}\) and leaves it at \(18\ \text{mm Hg}\), while the plasma colloid osmotic pressure holds near \(25\ \text{mm Hg}\) along the whole vessel. Interstitial hydrostatic and colloid osmotic pressures are negligible. At the venular end of this capillary, fluid most likely

- **A.** moves into the capillary under a net pressure of \(7\ \text{mm Hg}\).  <- **KEY**
- **B.** moves into the capillary under a net pressure of \(10\ \text{mm Hg}\).
- **C.** moves out of the capillary under a net pressure of \(7\ \text{mm Hg}\).
- **D.** moves out of the capillary under a net pressure of \(10\ \text{mm Hg}\).

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic easy / structural easy) |
| Estimated time | 55 s |
| Confidence | 5 |

**Correct answer (A): moves into the capillary under a net pressure of \(7\ \text{mm Hg}\).**

Citations: AP:39395 'When blood leaving an arteriole first enters a capillary bed, the CHP is quite high'; AP:39396-39397 'by the time the blood has reached the venous end, the CHP has dropped to approximately 18 mm Hg'; AP:39398 'the BCOP remains fairly constant at about 25 mm Hg throughout the length of the capillary'; AP:39402 'It is equal to the difference between the CHP and the BCOP.'; AP:39403 'when reabsorption is occurring, the NFP is a negative number.'; AP:39408-39409 'Close to the arterial end of the capillary, it is approximately 10 mm Hg, because the CHP of 35 mm Hg minus the BCOP of 25 mm Hg equals 10 mm Hg.'; AP:39411-39413 'At approximately the middle of the capillary, the CHP is about the same as the BCOP of 25 mm Hg, so the NFP drops to zero. At this point, there is no net change of volume'; AP:39414-39415 'Because the BCOP remains steady at 25 mm Hg, water is drawn into the capillary, that is, reabsorption occurs.'

**Distractors**

- **(B)** `partial_truth` . _right_direction_wrong_magnitude_ — Correct inward direction, but the magnitude of 10 mm Hg is the arteriolar end value produced by a hydrostatic pressure of 35 mm Hg, not the 18 mm Hg that applies here.
  - Citation: AP:39409
- **(C)** `reversed_relationship` . _sign_flip_ — Correct magnitude with the sign reversed. Treats the larger colloid osmotic pressure as though it drove fluid outward.
  - Citation: AP:39414-39415
- **(D)** `process_step_confusion` . _wrong_location_value_ — Transplants both the direction and the magnitude of the arteriolar end to the venular end, ignoring the fall in hydrostatic pressure along the capillary.
  - Citation: AP:39408-39409

**Readback check.** Keyed option content words: moves, into, capillary, net pressure, 7 mm Hg. The stem supplies 35, 18 and 25 mm Hg as data but never states 7, never states a direction, and never uses the words filtration or reabsorption. The referents capillary and mm Hg appear in all four options and are equally necessary to each. No stem echo, no restated premise, no self-justifying key. Audit: the option set was rebuilt as a clean two by two grid of direction (into, out of) crossed with magnitude (7, 10). The former choice D of 43 mm Hg (the sum of the two pressures) was dropped because it was an out of range outlier a student could discard on plausibility alone, and its own rationale conceded that no capillary pressure approaches that value. The replacement, inward at 10 mm Hg, is a genuine partial truth (right direction, arteriolar magnitude) and is not eliminable without topic knowledge. Key moved from B to A for answer letter balance across the unit. Citations AP:39396 and AP:39414 were corrected to the spans AP:39396-39397 and AP:39414-39415, since each quotation runs across a line break in the source file.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because at the venular end the inward colloid osmotic pressure of \(25\ \text{mm Hg}\) exceeds the outward hydrostatic pressure of \(18\ \text{mm Hg}\), leaving a net inward pressure of \(7\ \text{mm Hg}\). Net filtration pressure is capillary hydrostatic pressure minus blood colloid osmotic pressure, so \(18 - 25 = -7\ \text{mm Hg}\), and a negative value signifies reabsorption rather than filtration. Hydrostatic pressure falls along the capillary as fluid is lost from it, whereas the plasma proteins cannot cross the wall and therefore hold the colloid osmotic pressure nearly constant from one end to the other. The two opposing pressures are equal near the midpoint, so the upstream stretch of the vessel loses fluid and the downstream stretch regains it.
>
> (Choice A) At the venular end the values are \(18\ \text{mm Hg}\) pushing out and \(25\ \text{mm Hg}\) pulling in, so the net pressure of \(7\ \text{mm Hg}\) is directed inward and water is reabsorbed. This is the standard result for the downstream portion of a systemic capillary.
>
> (Choice B) The inward direction is right, but \(10\ \text{mm Hg}\) is the magnitude that belongs to the arteriolar end, where \(35\ \text{mm Hg}\) opposes \(25\ \text{mm Hg}\). The magnitude at any point depends on the local hydrostatic pressure, which here is \(18\ \text{mm Hg}\). Pairing the correct direction with a value carried over from the other end still gives the wrong net pressure.
>
> (Choice C) The magnitude of \(7\ \text{mm Hg}\) is arithmetically correct, but the direction assigned to it is inverted. Because the colloid osmotic pressure is the larger of the two values at this location, the resultant force points into the lumen. Outward movement here would require the local hydrostatic pressure to exceed \(25\ \text{mm Hg}\).
>
> (Choice D) Both the magnitude and the direction belong to the arteriolar end, where a hydrostatic pressure of \(35\ \text{mm Hg}\) against a colloid osmotic pressure of \(25\ \text{mm Hg}\) drives fluid outward at \(10\ \text{mm Hg}\). Applying those values downstream ignores the fall in hydrostatic pressure along the vessel. The question specifies the venular end.
>
> This is a Scientific Reasoning and Problem Solving question because you must combine two opposing pressure values into a signed net pressure and interpret its direction.

---

## B3-Q2 — Colloid Versus Crystalloid Osmotic Effects

**Stem.** An investigator perfuses an isolated capillary bed with a protein-free salt solution whose total solute osmolarity and inflow pressure match those of plasma. Compared with perfusion using whole plasma, the surrounding tissue most likely

- **A.** gains less fluid, because the perfusate exerts a stronger inward osmotic pull.
- **B.** gains no extra fluid, because the total osmolarity of the perfusate is matched.
- **C.** gains more fluid, because the perfusate exerts almost no inward osmotic pull.  <- **KEY**
- **D.** loses fluid to the capillary, because small solutes now drive reabsorption.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic medium / structural easy) |
| Estimated time | 55 s |
| Confidence | 5 |

**Correct answer (C): gains more fluid, because the perfusate exerts almost no inward osmotic pull.**

Citations: AP:39377-39378 'the formed elements of blood do not contribute to osmotic concentration gradients. Rather, it is the plasma proteins that play the key role.'; AP:39379-39380 'Solutes also move across the capillary wall according to their concentration gradient, but overall, the concentrations should be similar and not have a significant impact on osmosis.'; AP:39381-39382 'plasma proteins are not truly solutes, that is, they do not dissolve but are dispersed or suspended in their fluid medium, forming a colloid rather than a solution.'; AP:39384-39385 'The pressure created by the concentration of colloidal proteins in the blood is called the blood colloidal osmotic pressure (BCOP). Its effect on capillary exchange accounts for the reabsorption of water.'; AP:39385-39387 'The plasma proteins suspended in blood cannot move across the semipermeable capillary cell membrane, and so they remain in the plasma.'; AP:39361 'CHP is the force that drives fluid out of capillaries and into the tissues.'

**Distractors**

- **(A)** `reversed_relationship` . _inverted_effect_ — Assigns greater inward osmotic pull to the solution that has lost the only particles capable of exerting it, inverting the actual effect.
  - Citation: AP:39384-39385
- **(B)** `misconception` . _wrong_governing_variable_ — Treats total osmolarity as the determinant of transcapillary water movement, ignoring that the wall is freely permeable to the small solutes supplying most of it.
  - Citation: AP:39379-39380
- **(D)** `misconception` . _crystalloid_as_oncotic_ — Claims small solutes can drive reabsorption, but they move across the capillary wall until concentrations are similar on both sides.
  - Citation: AP:39379-39380

**Readback check.** Keyed option content words: gains, more fluid, perfusate, inward, osmotic pull. The stem supplies composition data (protein-free, matched osmolarity, matched inflow pressure) but never states that the inward pull is lost, never uses the words colloid, oncotic, filtration or reabsorption, and does not name the outcome. The referent perfusate appears in choices A, B and C, and the direction of tissue fluid change appears in all four. Data supplied to reason from, conclusion withheld. Audit: the word colloid was deleted from the key, both because it made the key the longest option and because it half handed over the mechanism; the key is now the shortest of the three parallel options and choices A and C differ only in the two variables under test. Key moved from B to C for answer letter balance. All five textbook citations were re-anchored to spans (AP:39377-39378, AP:39379-39380, AP:39381-39382, AP:39384-39385, AP:39385-39387) because every quotation crosses a line break in the source file.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because the inward pull across a capillary wall is generated by suspended plasma proteins, so a protein-free perfusate leaves hydrostatic pressure essentially unopposed and fluid accumulates in the tissue. Small ions and glucose move across the capillary wall down their gradients, so their concentrations end up similar on both sides and they contribute little to net water movement. Plasma proteins, in contrast, are too large to cross the wall and remain suspended in the lumen as a colloid, which is why they alone set up an effective osmotic gradient. With the inward pull near zero, the net pressure stays outward along the entire length of the vessel instead of reversing near the midpoint, and interstitial volume rises continuously.
>
> (Choice A) A protein-free solution has less osmotic holding power across the capillary wall, not more, because the particles it does contain equilibrate across that wall. Matching total osmolarity with small solutes does not create a sustained gradient. The predicted direction of change in tissue fluid is therefore backwards.
>
> (Choice B) Total osmolarity is the wrong quantity to match, because the capillary wall is freely permeable to the small solutes that supply most of it. An osmotic gradient holds water in place only when the barrier restricts the solute in question. Equal osmolarity therefore does not predict equal fluid balance here.
>
> (Choice C) Removing the plasma proteins removes essentially all of the effective inward pull, so hydrostatic pressure filters fluid outward along the whole capillary and the tissue swells. Isolated organs perfused with protein-free solutions become waterlogged for exactly this reason.
>
> (Choice D) Small solutes cross the capillary wall down their concentration gradients and reach similar concentrations on both sides, so they cannot sustain reabsorption. Net movement of fluid from tissue back into the lumen requires an inward pull that outlasts equilibration. Without proteins, no such pull exists.
>
> This is a Scientific Reasoning and Problem Solving question because you must predict how removing one class of solute from the perfusate alters net capillary fluid movement.

---

## B3-Q3 — Comparing Starling Forces Across Capillary Beds

**Stem.** The table lists capillary hydrostatic pressure (CHP), interstitial fluid hydrostatic pressure (IFHP), and blood colloid osmotic pressure (BCOP) measured in four capillary segments sampled from different tissues. Interstitial colloid osmotic pressure is negligible in all four segments. In which segment does fluid most likely move on balance from the interstitial space into the capillary lumen?

| Segment | CHP (mm Hg) | IFHP (mm Hg) | BCOP (mm Hg) |
|---|---|---|---|
| W | 32 | 2 | 25 |
| X | 24 | 6 | 26 |
| Y | 30 | 4 | 24 |
| Z | 21 | 1 | 19 |

- **A.** Segment W
- **B.** Segment X  <- **KEY**
- **C.** Segment Y
- **D.** Segment Z

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 80 s |
| Confidence | 5 |

**Correct answer (B): Segment X**

Citations: AP:39359-39360 'the pressure exerted by blood against the wall of a capillary is called capillary hydrostatic pressure (CHP)'; AP:39361 'CHP is the force that drives fluid out of capillaries and into the tissues.'; AP:39364 'This opposing hydrostatic pressure is called the interstitial fluid hydrostatic pressure (IFHP).'; AP:39388-39389 'the BCOP is higher than the interstitial fluid colloidal osmotic pressure (IFCOP), which is always very low because interstitial fluid contains few proteins.'; AP:39402 'It is equal to the difference between the CHP and the BCOP.'; AP:39403 'when reabsorption is occurring, the NFP is a negative number.'

**Distractors**

- **(A)** `adjacent_fact` . _largest_magnitude_wrong_sign_ — Segment W has the largest net pressure in the table, but it is outward at +5 mm Hg, which is filtration rather than reabsorption.
  - Citation: AP:39403
- **(C)** `partial_truth` . _reduced_but_not_reversed_ — Segment Y has the second highest interstitial hydrostatic pressure, which does reduce filtration, but the net pressure of +2 mm Hg is still outward.
  - Citation: AP:39364
- **(D)** `misconception` . _single_column_heuristic_ — Selects the lowest capillary hydrostatic pressure as a shortcut, ignoring that this segment also has the lowest colloid osmotic pressure, leaving net filtration of +1 mm Hg.
  - Citation: AP:39402

**Readback check.** Keyed option content words: Segment, X. The key is a bare label carrying no scientific content, so no content word of the key can appear in the stem. The table supplies raw pressure values to reason from and states no direction of flow for any segment. No definition to name, no stem echo, no self-justifying key. Audit: arithmetic re-verified for all four rows (W +5, X -8, Y +2, Z +1); the item is also robust if a student applies the textbook two term form CHP minus BCOP, which gives W +7, X -2, Y +6, Z +2 and still isolates the same single negative row. Table rows were re-ordered so the reabsorbing segment sits second, moving the key from C to B for answer letter balance, and all four choice blocks were re-lettered to match. British spelling 'favours' corrected to 'favors'. Citation AP:39360 corrected to the span AP:39359-39360 and AP:39388 to AP:39388-39389, since both quotations cross a line break.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because segment X is the only one whose outward pressures fail to overcome the inward pull, giving a net pressure of \(-8\ \text{mm Hg}\) and therefore reabsorption. The net pressure equals the outward push, which is capillary hydrostatic pressure minus interstitial fluid hydrostatic pressure, minus the inward pull, which is blood colloid osmotic pressure once the negligible interstitial colloid osmotic pressure is dropped. Working through the table gives \(32 - 2 - 25 = +5\) for W, \(24 - 6 - 26 = -8\) for X, \(30 - 4 - 24 = +2\) for Y, and \(21 - 1 - 19 = +1\) for Z. Only a negative net pressure corresponds to movement from the interstitium into the lumen, so X is the single reabsorbing segment.
>
> (Choice A) Segment W has the highest capillary hydrostatic pressure in the table at \(32\ \text{mm Hg}\) and only \(2\ \text{mm Hg}\) of opposing interstitial hydrostatic pressure. Its net pressure of \(+5\ \text{mm Hg}\) is the strongest outward value shown. Fluid therefore leaves this segment for the tissue.
>
> (Choice B) Segment X combines the highest colloid osmotic pressure at \(26\ \text{mm Hg}\) with a modest hydrostatic pressure of \(24\ \text{mm Hg}\) and the highest interstitial hydrostatic pressure at \(6\ \text{mm Hg}\). The result, \(-8\ \text{mm Hg}\), is the only inward net pressure in the table.
>
> (Choice C) Segment Y yields \(+2\ \text{mm Hg}\), a small but genuinely outward net pressure. Its raised interstitial hydrostatic pressure of \(4\ \text{mm Hg}\) reduces filtration without reversing it. Movement remains from lumen to interstitium.
>
> (Choice D) Segment Z has the lowest capillary hydrostatic pressure in the table at \(21\ \text{mm Hg}\), which makes it superficially attractive. Its colloid osmotic pressure is also unusually low at \(19\ \text{mm Hg}\), however, so the balance still favors filtration at \(+1\ \text{mm Hg}\). A low hydrostatic value alone does not establish reabsorption.
>
> This is a Data-based and Statistical Reasoning question because you must extract three values per row from a table and combine them into a signed net pressure for each segment before comparing them.

---

## B3-Q4 — Manipulating the Filtration Balance Experimentally

**Stem.** In an isolated perfused limb, the rate at which lymph drains from the tissue tracks the net rate of capillary filtration. Each of the following changes is imposed separately, with all other conditions held constant. Which of the changes are expected to increase the rate of lymph drainage?

I. Raising the pressure in the venule that drains the limb
II. Perfusing with a solution containing half the normal albumin concentration
III. Constricting the arteriole that supplies the limb

- **A.** I only
- **B.** I and II only  <- **KEY**
- **C.** I and III only
- **D.** II and III only

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 85 s |
| Confidence | 5 |

**Correct answer (B): I and II only**

Citations: AP:39426-39427 'it is inevitable that more net fluid will exit the capillary through filtration at the arterial end than enters through reabsorption at the venous end'; AP:39428-39429 'Approximately 24 liters per day are filtered, whereas 20.4 liters are reabsorbed. This excess fluid is picked up by capillaries of the lymphatic system.'; AP:38769-38771 'Any blood that accumulates in a vein will increase the pressure within it, which can then be reflected back into the smaller veins, venules, and eventually even the capillaries. Increased pressure will promote the flow of fluids out of the capillaries and into the interstitial fluid.'; AP:33817-33819 'Albumin is also the most significant contributor to the osmotic pressure of blood; that is, its presence holds water inside the blood vessels and draws water from the tissues'; AP:38599 'referred to as resistance vessels'; AP:39165 'arterioles are the site of greatest resistance in the entire vascular network.'

**Distractors**

- **(A)** `partial_truth` . _one_force_only_ — Correctly identifies the venous pressure effect but omits the albumin effect, crediting only the hydrostatic half of the pressure balance.
  - Citation: AP:33817-33819
- **(C)** `reversed_relationship` . _upstream_downstream_inversion_ — Treats arteriolar constriction as raising capillary hydrostatic pressure, when constriction upstream of the capillary lowers the pressure delivered to it.
  - Citation: AP:39165
- **(D)** `process_step_confusion` . _wrong_pair_ — Retains the correct albumin item but pairs it with arteriolar constriction and drops the venous pressure item, confusing which end of the capillary bed a resistance change acts on.
  - Citation: AP:38599

**Readback check.** Keyed option content words: I, and, II, only. The key is a bare item set label with no scientific content, so no content word of the key can appear in the stem. The Roman numeral items state manipulations, not their consequences, and the stem states only the measurement relationship needed to interpret any of the four options. No stem echo, no restated premise. Audit: all three item directions re-verified against the textbook, and the option set keeps canonical ascending order so the key stays at B, which the unit level letter distribution needed. Citations re-anchored to spans (AP:39426-39427, AP:39428-39429, AP:38769-38771, AP:33817-33819) because each quotation crosses a line break; AP:38599 and AP:39165 were confirmed verbatim as single lines. Noted deliberately: item I uses venous congestion, which also appears in the two clinical items of this unit, but here it is one of three manipulations rather than the angle under test, and the discrimination demanded differs in each question. Confidence raised from 4 to 5 after verification.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because raising downstream venous pressure and diluting the perfusate albumin both increase net filtration, whereas constricting the supply arteriole lowers the pressure delivered to the capillary and reduces filtration. Lymph forms from the fraction of filtered fluid that is not reabsorbed, so anything that widens the gap between filtration and reabsorption raises lymph flow. Item I acts by raising the outward push, since pressure in a congested venule is reflected backwards into the capillary. Item II acts on the opposing side of the balance, lowering the inward pull that albumin supplies. Item III acts in the opposite direction, because arterioles are the resistance vessels of the circuit and tightening one drops the pressure reaching the capillary beyond it.
>
> (Choice A) Item I alone is incomplete because item II also raises net filtration. Halving the albumin concentration reduces the only force that pulls water back into the lumen, so filtration exceeds reabsorption by a wider margin and lymph flow rises. Selecting item I alone credits only the hydrostatic side of the balance.
>
> (Choice B) Item I raises capillary hydrostatic pressure by back transmission from the congested venule, and item II lowers blood colloid osmotic pressure by removing half the albumin. Both widen the filtration surplus that the lymphatics must carry away, so both increase lymph drainage.
>
> (Choice C) Item III is the one manipulation that lowers filtration. Arterioles are the site of greatest resistance, so constricting the supply arteriole produces a larger pressure drop before the blood reaches the capillary and leaves less hydrostatic pressure to drive fluid outward. Lymph drainage would fall rather than rise.
>
> (Choice D) This pairing keeps the correct item II but again treats arteriolar constriction as though it raised capillary pressure. Constriction upstream of an exchange vessel shields that vessel from arterial pressure instead of exposing it. It also omits item I, which does raise filtration.
>
> This is a Scientific Reasoning and Problem Solving question because you must predict the direction in which each separate manipulation shifts the balance of capillary pressures.

---

## B3-Q5 — Two Mechanisms of Interstitial Fluid Accumulation

**Stem.** Two individuals have swollen ankles. In the first, incompetent valves in the leg veins allow blood to pool in the lower limb; in the second, dietary protein intake has been severely inadequate for many months. The pressure changes that most likely drive the swelling in these two individuals are

- **A.** lowered plasma colloid osmotic pressure in the first, and lowered plasma colloid osmotic pressure in the second.
- **B.** lowered plasma colloid osmotic pressure in the first, and raised capillary hydrostatic pressure in the second.
- **C.** raised capillary hydrostatic pressure in the first, and lowered plasma colloid osmotic pressure in the second.  <- **KEY**
- **D.** raised capillary hydrostatic pressure in the first, and raised capillary hydrostatic pressure in the second.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 75 s |
| Confidence | 5 |

**Correct answer (C): raised capillary hydrostatic pressure in the first, and lowered plasma colloid osmotic pressure in the second.**

Citations: AP:38769-38771 'Any blood that accumulates in a vein will increase the pressure within it, which can then be reflected back into the smaller veins, venules, and eventually even the capillaries. Increased pressure will promote the flow of fluids out of the capillaries and into the interstitial fluid.'; AP:38776-38777 'Edema has many potential causes, including hypertension and heart failure, severe protein deficiency, renal failure, and many others.'; AP:54660-54662 'A decrease in the normal levels of plasma proteins results in a decrease of colloid osmotic pressure (which counterbalances the hydrostatic pressure) in the capillaries. This process causes loss of water from the blood to the surrounding tissues, resulting in edema.'; AP:33815 'Albumin is the most abundant of the plasma proteins. Manufactured by the liver'; AP:33817-33819 'Albumin is also the most significant contributor to the osmotic pressure of blood; that is, its presence holds water inside the blood vessels and draws water from the tissues'; AP:33819-33820 'This in turn helps to maintain both blood volume and blood pressure.'

**Distractors**

- **(A)** `partial_truth` . _one_mechanism_generalized_ — Correct for the protein deprived individual but wrong for the first, since pooling blood within a limb does not change plasma protein concentration.
  - Citation: AP:54660-54662
- **(B)** `reversed_relationship` . _swapped_assignment_ — Names both correct mechanisms but assigns each to the wrong individual, linking venous pooling to protein loss and protein deprivation to raised pressure.
  - Citation: AP:38769-38771
- **(D)** `partial_truth` . _one_mechanism_generalized_ — Correct for the venous pooling individual but wrong for the second, since severe protein deficiency does not raise capillary hydrostatic pressure.
  - Citation: AP:33819-33820

**Readback check.** Keyed option content words: raised, capillary hydrostatic pressure, lowered, plasma colloid osmotic pressure, first, second. Every one of these phrases appears in all four options, so none can distinguish the key. The stem contains neither pressure phrase, giving only the two situations (blood pooling behind incompetent valves; severely inadequate dietary protein). Data supplied, conclusion withheld. Audit: the stem lead in was made grammatical and less leading, from 'The capillary pressure change that most likely drives the swelling in each individual is' to 'The pressure changes that most likely drive the swelling in these two individuals are', which also strips the word capillary out of the stem. Options were re-ordered to group by the first term, moving the key from D to C for answer letter balance, and the choice blocks were re-lettered accordingly. The unsupported clause 'which is why treatment differs' was replaced with a claim the textbook does make, that the underlying cause must be identified. The former choice C clause asserting that protein deficiency 'tends to accompany reduced circulating volume' was re-grounded on the textbook statement that albumin helps maintain blood volume and blood pressure (AP:33819-33820). Citations re-anchored to spans AP:38769-38771, AP:38776-38777, AP:54660-54662 and AP:33817-33819.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because venous pooling raises the outward pressure inside the capillary, while chronic protein deprivation lowers the inward pull that plasma proteins supply. Blood trapped behind incompetent valves distends the vein and raises the pressure within it, and that pressure is reflected backwards through the venules into the capillary, so capillary hydrostatic pressure rises and filtration exceeds reabsorption. Inadequate dietary protein limits the raw material for hepatic albumin synthesis, and albumin is the dominant contributor to blood colloid osmotic pressure, so the inward pull that normally returns water at the venular end weakens. Both routes end in accumulated interstitial fluid, but they act on opposite sides of the pressure balance, which is why identifying the underlying cause matters clinically.
>
> (Choice A) A fall in colloid osmotic pressure does explain the second individual, but it cannot explain the first. Plasma protein concentration is unaffected by where blood pools within a limb. Attributing both cases to protein loss ignores the hydrostatic route entirely.
>
> (Choice B) This assigns each mechanism to the wrong individual. Pooling of blood behind failed valves does nothing to plasma protein concentration, and inadequate dietary protein does not raise the pressure inside capillaries. The two derangements are correctly named but swapped.
>
> (Choice C) Venous pooling raises pressure that is reflected back into the capillary, increasing filtration in the first individual, while chronic protein deprivation reduces circulating albumin and therefore the colloid osmotic pressure in the second. The two individuals swell for opposite reasons within the same pressure balance.
>
> (Choice D) Raised capillary hydrostatic pressure is correct for the first individual only. Severe protein deficiency does not raise arterial or venous pressure, and because albumin helps maintain blood volume and blood pressure, losing it tends to lower them. This option collapses two distinct mechanisms into one.
>
> This is a Scientific Reasoning and Problem Solving question because you must trace two different clinical situations to the specific pressure term each one alters.

---

## B3-Q6 — Protein Content of Accumulated Interstitial Fluid

**Stem.** Fluid is aspirated from a swollen limb in each of two individuals whose blood albumin levels are normal. In the first, the lymphatic vessels serving the limb were removed during surgery; in the second, an obstructed vein has raised venous pressure in the limb. Compared with the second sample, the first most likely contains

- **A.** a higher protein concentration, because escaped plasma protein is not carried away.  <- **KEY**
- **B.** a lower protein concentration, because added protein-poor filtrate dilutes it.
- **C.** a higher protein concentration, because the capillary wall has become leakier to protein.
- **D.** a lower protein concentration, because capillary hydrostatic pressure there is normal.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic hard / structural hard) |
| Estimated time | 105 s |
| Confidence | 5 |
| Hard-tier gate | Meets three of the four conditions. (1) CONCEPT CHAINING: a little protein escapes the capillary, lymph is its only return route, therefore interstitial protein is normally low, therefore abolishing lymphatic drainage raises it. (3) TRUE PARTIAL-TRUTH TRAP: choice B is entirely correct physiology for the second limb, applied to the wrong limb. (4) 510-TEMPTING DISTRACTOR: choice C names a real mechanism that produces exactly the keyed outcome and attracts anyone reasoning from outcome back to cause rather than from the situation given. |

**Correct answer (A): a higher protein concentration, because escaped plasma protein is not carried away.**

Citations: AP:42163-42165 'When the lymphatic system is damaged in some way, such as by being blocked by cancer cells or destroyed by injury, protein-rich interstitial fluid accumulates'; AP:42165-42166 'This inappropriate accumulation of fluid referred to as lymphedema may lead to serious medical consequences.'; AP:42161-42162 'This is where the lymphatic system comes into play. It drains the excess fluid and empties it back into the bloodstream via a series of vessels, trunks, and ducts.'; AP:39388-39389 'the BCOP is higher than the interstitial fluid colloidal osmotic pressure (IFCOP), which is always very low because interstitial fluid contains few proteins.'; AP:39385-39387 'The plasma proteins suspended in blood cannot move across the semipermeable capillary cell membrane, and so they remain in the plasma.'; AP:38770-38771 'Increased pressure will promote the flow of fluids out of the capillaries and into the interstitial fluid.'; AP:54658-54659 'Other causes of edema include damage to blood vessels and/or lymphatic vessels'; AP:39428-39429 'This excess fluid is picked up by capillaries of the lymphatic system.'

**Distractors**

- **(B)** `partial_truth` . _right_mechanism_wrong_case_ — States correct physiology for the second limb, where raised hydrostatic pressure adds protein-poor filtrate, but assigns it to the first limb and so reverses the comparison.
  - Citation: AP:39385-39387
- **(C)** `adjacent_fact` . _correct_outcome_wrong_cause_ — Increased capillary permeability does raise interstitial protein, but the situation describes removal of the lymphatic vessels, not damage to the capillary wall.
  - Citation: AP:54658-54659
- **(D)** `reversed_relationship` . _true_premise_inverted_conclusion_ — The premise that capillary hydrostatic pressure is normal is accurate, but a normal outward push means less dilution by protein-poor filtrate, so protein concentration would rise, not fall.
  - Citation: AP:39361

**Readback check.** Keyed option content words: higher, protein concentration, escaped, plasma protein, carried away. The stem contains none of them; it now avoids the words plasma, concentration, protein, leak, drain and any sense of removal that touches the key. All four options contain protein concentration, making it a shared referent equally necessary to each. The stem gives only the two situations and never states which force or which route is deranged. Audit: four changes. The key was shortened from 'because leaked capillary protein is no longer carried away' to 'because escaped plasma protein is not carried away' so it is no longer tied for the longest option (83 characters against 89 for choice C). The stem phrase 'whose plasma albumin concentrations are normal' became 'whose blood albumin levels are normal' to strip plasma and concentration out of the stem, and 'the lymphatic vessels draining the limb' became 'serving the limb' so no form of the word drain sits in the stem. Choice C's citation was moved off AP:42878, which sits in the immune chapter's inflammation section and was chapter drift, onto AP:54658-54659, which states that damage to blood vessels causes edema. The explanation was re-grounded: instead of asserting that capillary walls restrain protein imperfectly (which sits awkwardly beside AP:39386, where proteins cannot cross the wall), it now rests on the two statements the textbook does make, that interstitial fluid contains few proteins because lymph removes them and that lymphatic destruction produces protein-rich interstitial fluid. Scope confirmed against the AAMC outline, which lists under Lymphatic System both 'Equalization of fluid distribution' and 'Transport of proteins', so this is fluid balance rather than immunity.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because the lymphatic vessels are the route that returns escaped protein from the tissue spaces to the blood, so removing them lets that protein build up in the interstitium. Interstitial fluid normally contains few proteins precisely because lymph continuously carries away the small amount that leaves the capillary, and destroying the lymphatic drainage of a region leaves protein-rich fluid accumulating in the tissue. In the second limb that route is intact and the derangement is a raised outward push acting across a wall that still holds back plasma proteins, so the extra fluid delivered to the tissue is a protein-poor filtrate that dilutes the interstitial protein already present. The two limbs therefore differ measurably in the protein content of their fluid even though both look similar from the outside.
>
> (Choice A) With the lymphatic vessels gone, protein that has left the capillary has no exit and accumulates alongside the retained water, so the aspirate is comparatively protein-rich. This is the characteristic finding when lymphatic drainage is destroyed.
>
> (Choice B) Dilution by protein-poor filtrate is genuinely correct physiology, but it describes the second limb rather than the first. Raised capillary hydrostatic pressure pushes fluid across a wall that still retains plasma proteins, so the added fluid is low in protein and lowers the interstitial concentration. Applying that reasoning to the limb without lymphatics reverses the comparison.
>
> (Choice C) Increased permeability of the capillary wall would indeed raise interstitial protein, and damage to blood vessels is a recognized cause of tissue swelling. Nothing in this situation damages the capillary wall itself, however, since only the lymphatic vessels were taken out. The right outcome is reached by the wrong route.
>
> (Choice D) Capillary hydrostatic pressure is in fact normal in the first limb, so this premise is accurate. A normal outward push, however, means less protein-poor filtrate is added, which raises rather than lowers the relative protein concentration. The prediction contradicts its own starting point.
>
> This is a Scientific Reasoning and Problem Solving question because you must reason from two different derangements to a single measurable property of the accumulated fluid.

---

## B3-Q7 — Position of the Filtration Reabsorption Crossover

**Stem.** Along one systemic capillary, hydrostatic pressure falls steadily from \(35\ \text{mm Hg}\) at the arteriolar end to \(18\ \text{mm Hg}\) at the venular end. In an individual with liver failure the plasma colloid osmotic pressure is \(20\ \text{mm Hg}\) rather than the usual \(25\ \text{mm Hg}\), and interstitial pressures remain negligible. Compared with normal, the point along this capillary at which net fluid movement equals zero most likely

- **A.** moves toward the arteriolar end, so a larger fraction of the capillary reabsorbs.
- **B.** moves toward the arteriolar end, so a larger fraction of the capillary filters.
- **C.** moves toward the venular end, so a larger fraction of the capillary reabsorbs.
- **D.** moves toward the venular end, so a larger fraction of the capillary filters.  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic hard / structural hard) |
| Estimated time | 110 s |
| Confidence | 5 |
| Hard-tier gate | Meets three of the four conditions. (1) CONCEPT CHAINING: a weaker inward pull is met by the decaying hydrostatic profile only further downstream, so the zero point moves downstream, so the upstream stretch lengthens, and that stretch is the filtering one, so the tissue receives more fluid. (2) DATA-TO-MECHANISM: the two endpoint pressures and the linearity statement must be used quantitatively to place the crossover before any conclusion can be drawn. (4) 510-TEMPTING DISTRACTOR: choice C shifts the crossover in exactly the right direction and attracts any examinee who has not fixed which side of the crossover filters. |

**Correct answer (D): moves toward the venular end, so a larger fraction of the capillary filters.**

Citations: AP:39395 'When blood leaving an arteriole first enters a capillary bed, the CHP is quite high'; AP:39396-39397 'by the time the blood has reached the venous end, the CHP has dropped to approximately 18 mm Hg'; AP:39398 'the BCOP remains fairly constant at about 25 mm Hg throughout the length of the capillary'; AP:39408-39409 'Close to the arterial end of the capillary, it is approximately 10 mm Hg, because the CHP of 35 mm Hg minus the BCOP of 25 mm Hg equals 10 mm Hg.'; AP:39411-39413 'At approximately the middle of the capillary, the CHP is about the same as the BCOP of 25 mm Hg, so the NFP drops to zero. At this point, there is no net change of volume'; AP:39421-39423 'Net filtration occurs near the arterial end of the capillary since capillary hydrostatic pressure (CHP) is greater than blood colloidal osmotic pressure (BCOP). Net reabsorption occurs near the venous end since BCOP is greater than CHP.'; AP:54658-54661 'a decrease in osmotic pressure in chronic and severe liver disease, where the liver is unable to manufacture plasma proteins'

**Distractors**

- **(A)** `reversed_relationship` . _double_inversion_ — Both the shift direction and its consequence are inverted; an arteriolar shift with more reabsorption is what a rise in colloid osmotic pressure would produce, not a fall.
  - Citation: AP:39411-39413
- **(B)** `process_step_confusion` . _correct_outcome_wrong_shift_ — Identifies the correct consequence, more filtration, but pairs it with a shift toward the arteriolar end, which would shorten rather than lengthen the filtering stretch.
  - Citation: AP:39408-39409
- **(C)** `partial_truth` . _correct_shift_wrong_side_ — Places the crossover correctly toward the venule but labels the enlarged upstream stretch as reabsorbing, when reabsorption is the downstream behavior.
  - Citation: AP:39421-39423

**Readback check.** Keyed option content words: moves toward, venular end, larger fraction, capillary, filters. The phrases arteriolar end and venular end appear in the stem but also in all four options, where they are equally necessary to each, so they are shared referents rather than a giveaway. The words filters, filtration, reabsorbs and reabsorption never appear in the stem, and the stem states no direction of shift; it supplies only the pressure values and the linearity assumption. Audit: arithmetic re-verified, 10/17 = 0.588 and 15/17 = 0.882, matching the stated 59 percent, 88 percent, three fifths and seven eighths. Options were re-ordered to group by shift direction, moving the key from B to D for answer letter balance, and the choice blocks were re-lettered. The hard gate justification was corrected: it previously claimed a chaining link from failing hepatic protein synthesis to a lower colloid osmotic pressure, but the stem hands that value to the student, so the link was deleted and the chain restated from the point where the reasoning actually begins. British spelling 'behaviour' corrected to 'behavior' in two places. Citation AP:39411 was corrected to the span AP:39411-39413 and AP:39421 to AP:39421-39423, and the liver failure premise was grounded on AP:54658-54661.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because a lower colloid osmotic pressure is matched by the falling hydrostatic pressure only further downstream, pushing the crossover toward the venule and leaving more of the vessel in net filtration. Net movement is zero where hydrostatic pressure equals colloid osmotic pressure. Normally that occurs where hydrostatic pressure has fallen to \(25\ \text{mm Hg}\), which on a linear profile is \((35 - 25)/(35 - 18)\), or roughly \(59\%\) of the way along. With liver failure it occurs where hydrostatic pressure reaches \(20\ \text{mm Hg}\), which is \((35 - 20)/(35 - 18)\), or roughly \(88\%\) of the way along. Everything upstream of the crossover filters and everything downstream reabsorbs, so the filtering stretch grows from about three fifths to about seven eighths of the capillary and the surplus fluid burdening the tissue increases.
>
> (Choice A) Moving the crossover toward the arteriolar end would require hydrostatic pressure to fall below the colloid osmotic pressure sooner, which happens when colloid osmotic pressure rises rather than falls. The stated change is a fall from \(25\ \text{mm Hg}\) to \(20\ \text{mm Hg}\). Both the direction of the shift and the consequence are inverted here.
>
> (Choice B) The consequence is right but the direction of the shift is backwards. A larger filtering fraction can only arise if the crossover retreats toward the venular end, since filtration is the upstream behavior of the vessel. Shifting the crossover toward the arteriole would shrink the filtering stretch instead.
>
> (Choice C) The direction of the shift is right but the consequence is backwards. Filtration occupies the segment upstream of the crossover, where hydrostatic pressure still exceeds the colloid osmotic pull, and reabsorption occupies the segment downstream of it. Pushing the crossover toward the venule shortens the reabsorbing stretch rather than lengthening it.
>
> (Choice D) The crossover sits where hydrostatic pressure has decayed to the colloid osmotic value, so lowering that value from \(25\ \text{mm Hg}\) to \(20\ \text{mm Hg}\) delays the crossing until about \(88\%\) of the way to the venule. The stretch upstream of the crossover, which is the filtering stretch, therefore lengthens.
>
> This is a Scientific Reasoning and Problem Solving question because you must locate a crossover point on a stated pressure profile and translate its displacement into a change in capillary behavior.

---

## B3-Q8 — Daily Lymph Return Volume

**Stem.** Across all systemic capillary beds of a healthy adult, roughly \(24\ \text{L}\) of fluid is filtered into the interstitium each day while roughly \(20.4\ \text{L}\) is reabsorbed. If interstitial fluid volume stays constant across that day, what volume of fluid must the lymphatic vessels deliver to the subclavian veins?

- **A.** \(3.6\ \text{L}\)  <- **KEY**
- **B.** \(4.4\ \text{L}\)
- **C.** \(20.4\ \text{L}\)
- **D.** \(44.4\ \text{L}\)

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic easy / structural easy) |
| Estimated time | 60 s |
| Confidence | 5 |

**Correct answer (A): \(3.6\ \text{L}\)**

Citations: AP:39428-39429 "Approximately 24 liters per day are filtered, whereas 20.4 liters are reabsorbed." | AP:39426-39427 "Since overall CHP is higher than BCOP, it is inevitable that more net fluid will exit the capillary through filtration at the arterial end than enters through reabsorption at the venous end." | AP:39429-39431 "This excess fluid is picked up by capillaries of the lymphatic system. These extremely thin-walled vessels have copious numbers of valves that ensure unidirectional flow through ever-larger lymphatic vessels that eventually drain into the subclavian veins in the neck." | AP:39432 "Lymph may be thought of as recycled blood plasma." | AP:42160-42161 "Of this, 17 liters is reabsorbed directly by the blood vessels. But what happens to the remaining three liters? This is where the lymphatic system comes into play."

**Distractors**

- **(B)** `scale_unit_error` — Arises from mishandling the decimal places when subtracting 20.4 from 24; a lymphatic load this large would remove more fluid than the tissue receives, so interstitial volume would fall rather than stay constant.
  - Citation: AP:39428-39429
- **(C)** `process_step_confusion` — Reports the volume reabsorbed directly into the blood capillaries rather than the residual that the lymphatics must carry; that fluid never enters a lymphatic vessel.
  - Citation: AP:39428-39429
- **(D)** `misconception` — Adds the filtered and reabsorbed volumes instead of subtracting them, counting the same fluid twice and yielding a lymphatic load larger than the total volume leaving the capillaries.
  - Citation: AP:39426-39429

**Readback check.** Keyed option content words: 3.6, L. The stem contains 24, 20.4, filtered, reabsorbed, interstitium, lymphatic, subclavian. The numeral 3.6 appears nowhere in the stem and cannot be read off; it must be computed. The shared referents (fluid, volume, day) apply equally to all four numeric options. No definition to name, no stem echo, no restated premise, and all four options are real volumes drawn from the same data set. AUDIT CHANGES: (1) Removed the factually wrong clause 'Capillary hydrostatic pressure exceeds blood colloid osmotic pressure across most of a capillary's length'; AP:39411-39412 states CHP equals BCOP at approximately the middle of the capillary, so CHP exceeds BCOP over roughly the first half only. Replaced with the textbook's own overall framing at AP:39426. (2) Replaced distractor 2.4 L, which had no derivation from the supplied data, with 4.4 L, a decimal borrow slip on 24.0 minus 20.4. (3) Reordered options into ascending numeric order, which moves the key from B to A and helps correct a batch-wide skew in which four of six items were keyed B. (4) Corrected citation span AP:39428 to AP:39428-39429, since 'are reabsorbed' falls on line 39429.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because the lymphatic vessels must carry away exactly the fluid that is filtered but not reabsorbed, which is \(24\ \text{L}\) minus \(20.4\ \text{L}\), or \(3.6\ \text{L}\) per day. Taken over the capillary bed as a whole, capillary hydrostatic pressure is higher than blood colloid osmotic pressure, so more fluid leaves by filtration at the arterial end than returns by reabsorption at the venous end. For interstitial volume to hold steady, that daily surplus must leave the tissue by some other route, and the only such route is the lymphatic system, whose vessels drain into the subclavian veins in the neck. Fluid balance in a tissue is therefore a three way accounting: filtered out, reabsorbed back, and the remainder returned as lymph.
>
> (Choice A) This is the correct answer. The residual \(3.6\ \text{L}\) per day is precisely the load the lymphatic vessels return to the venous circulation, which is why lymph is often described as recycled plasma.
>
> (Choice B) A value of \(4.4\ \text{L}\) comes from mishandling the decimal places when \(20.4\ \text{L}\) is subtracted from \(24\ \text{L}\). A lymphatic load that large would remove more fluid than the tissue receives each day, so interstitial volume would fall rather than stay constant.
>
> (Choice C) A value of \(20.4\ \text{L}\) is the volume taken directly back into the blood capillaries at their venous ends, not the volume left over. That fluid never enters a lymphatic vessel at all, so counting it as lymph double counts the reabsorbed portion.
>
> (Choice D) A value of \(44.4\ \text{L}\) is the sum of the filtered and reabsorbed volumes rather than their difference. Adding the two counts the same fluid twice and would imply a lymphatic load larger than the total volume that ever leaves the capillaries.
>
> This is a Scientific Reasoning and Problem Solving question because you must apply conservation of fluid volume to the filtration and reabsorption rates supplied.

---

## B3-Q9 — Lacteal Routing Of Absorbed Lipid

**Stem.** A rat whose intestinal lymphatic vessels have been ligated is fed a meal containing radiolabeled glucose and radiolabeled long chain triglyceride. Blood drawn from a systemic vein over the next several hours most likely shows which pattern of label appearance?

- **A.** Both the glucose label and the triglyceride label appear at close to normal levels.
- **B.** The triglyceride label appears at close to normal levels, while the glucose label is greatly reduced.
- **C.** The glucose label appears at close to normal levels, while the triglyceride label is greatly reduced.  <- **KEY**
- **D.** Both the glucose label and the triglyceride label are greatly reduced.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic easy / structural easy) |
| Estimated time | 65 s |
| Confidence | 5 |

**Correct answer (C): The glucose label appears at close to normal levels, while the triglyceride label is greatly reduced.**

Citations: AP:48378-48381 "each villus contains a capillary bed composed of one arteriole and one venule, as well as a lymphatic capillary called a lacteal. The breakdown products of carbohydrates and proteins (sugars and amino acids) can enter the bloodstream directly, but lipid breakdown products are absorbed by the lacteals and transported to the bloodstream via the lymphatic system." | AP:49383-49385 "The free fatty acids and monoacylglycerides that enter the epithelial cells are reincorporated into triglycerides. The triglycerides are mixed with phospholipids and cholesterol, and surrounded with a protein coat. This new complex, called a chylomicron, is a water-soluble lipoprotein." | AP:49386-49389 "Too big to pass through the basement membranes of blood capillaries, chylomicrons instead enter the large pores of lacteals. The lacteals come together to form the lymphatic vessels. The chylomicrons are transported in the lymphatic vessels and empty through the thoracic duct into the subclavian vein of the circulatory system." | AP:42227-42228 "In the small intestine, lymphatic capillaries called lacteals are critical for the transport of dietary lipids and lipid-soluble vitamins to the bloodstream." | AAMC:1856 "Transport of proteins and large glycerides"

**Distractors**

- **(A)** `misconception` — Assumes chylomicrons can cross into the villus blood capillaries; they are too large to pass the capillary basement membrane and must use the lacteal.
  - Citation: AP:49386-49387
- **(B)** `reversed_relationship` — Swaps the two routes. Sugars enter the bloodstream directly from the villus capillaries and are unaffected by lymphatic ligation, whereas lipid is the label that falls.
  - Citation: AP:48379-48381
- **(D)** `partial_truth` — Correct that lipid appearance falls but wrongly extends lymphatic dependence to carbohydrate; sugars and amino acids enter the bloodstream directly.
  - Citation: AP:48379-48381

**Readback check.** Keyed option content words: glucose, normal, triglyceride, reduced. Glucose and triglyceride appear in the stem only as the two labels administered, and after revision both terms appear in all four options, so they are shared referents equally necessary to every choice. The stem never states which route either nutrient uses and never uses the words lacteal, chylomicron, or capillary. No definition to name, no self justifying key, and all four patterns are internally coherent outcomes. AUDIT CHANGES: (1) Rewrote options A and D to name both nutrients, since previously glucose and triglyceride appeared only in B and C, which narrowed the field to two options without topic knowledge. (2) Specified 'long chain triglyceride' in the stem, closing the objection that short and medium chain fatty acids are absorbed into portal blood and would still appear after lymphatic ligation. (3) Corrected AAMC:1855 to AAMC:1856; line 1855 reads 'Equalization of fluid distribution' and the quoted 'Transport of proteins and large glycerides' is on line 1856. (4) Tightened AP:42227-42229 to AP:42227-42228, the actual span of the quoted sentence. (5) Added AP:49383-49385 to support the newly stated chylomicron assembly step, and corrected the British spelling 'travelling'.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because sugars enter the villus blood capillaries directly, whereas absorbed long chain lipid is repackaged into chylomicrons that can leave the villus only through its lacteal. Each villus contains a capillary bed of one arteriole and one venule plus a single lymphatic capillary, the lacteal. Fatty acids and monoacylglycerides taken up by the absorptive epithelial cell are reincorporated into triglycerides and surrounded with a protein coat to form chylomicrons, which are too big to pass the basement membranes of blood capillaries and instead enter the large pores of the lacteals. From there the lipid travels in lymph and empties through the thoracic duct into the subclavian vein, so ligating the intestinal lymphatics removes the only export route available to dietary triglyceride while leaving the monosaccharide route intact.
>
> (Choice A) This outcome would require chylomicrons to enter the villus blood capillaries directly. Their size prevents that, so blocking the lacteal route must depress the appearance of the lipid label even though the sugar label is unaffected.
>
> (Choice B) This reverses the two absorption routes. Monosaccharides do not depend on lymphatic drainage and lipid does, so the label depressed by lymphatic ligation is the triglyceride label rather than the glucose label.
>
> (Choice C) This is the correct answer. Glucose reaches the systemic blood by way of the villus venule regardless of lymphatic patency, while triglyceride carried in chylomicrons is stranded when lacteal drainage is interrupted.
>
> (Choice D) This treats the lymphatic route as the common pathway for all absorbed nutrients. The breakdown products of carbohydrate and protein enter the bloodstream directly from the villus capillaries, so the glucose label is not expected to fall.
>
> This is a Scientific Reasoning and Problem Solving question because you must predict the outcome of an anatomical interruption from the absorption route each nutrient class uses.

---

## B3-Q10 — Starling Forces And Lymph Formation Rate

**Stem.** A cannula in the lymphatic vessel draining a resting skeletal muscle allows the rate of lymph formation in that muscle to be measured directly. Consider the following interventions:

I. Partial obstruction of the venous outflow from the muscle
II. Rapid infusion of a large volume of protein free isotonic saline into the systemic circulation
III. Intravenous infusion of a small volume of concentrated albumin that raises plasma protein concentration

Which of the interventions would most likely increase the measured rate?

- **A.** I only
- **B.** II only
- **C.** I and II only  <- **KEY**
- **D.** I and III only

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 95 s |
| Confidence | 5 |

**Correct answer (C): I and II only**

Citations: AP:38769-38771 "Any blood that accumulates in a vein will increase the pressure within it, which can then be reflected back into the smaller veins, venules, and eventually even the capillaries. Increased pressure will promote the flow of fluids out of the capillaries and into the interstitial fluid." | AP:54660-54662 "A decrease in the normal levels of plasma proteins results in a decrease of colloid osmotic pressure (which counterbalances the hydrostatic pressure) in the capillaries. This process causes loss of water from the blood to the surrounding tissues, resulting in edema." | AP:39388-39391 "the BCOP is higher than the interstitial fluid colloidal osmotic pressure (IFCOP), which is always very low because interstitial fluid contains few proteins. Thus, water is drawn from the tissue fluid back into the capillary, carrying dissolved molecules with it. This difference in colloidal osmotic pressure accounts for reabsorption." | AP:39426-39429 "more net fluid will exit the capillary through filtration at the arterial end than enters through reabsorption at the venous end ... This excess fluid is picked up by capillaries of the lymphatic system."

**Distractors**

- **(A)** `partial_truth` — Correctly credits venous obstruction but overlooks that a large protein free infusion dilutes plasma protein, lowering the colloid osmotic pressure that drives reabsorption.
  - Citation: AP:54660-54662
- **(B)** `misconception` — Rejects item I on the assumption that impeding outflow reduces filtration; blood accumulating in a vein raises pressure that is reflected back into the capillaries and promotes fluid movement into the tissue.
  - Citation: AP:38769-38771
- **(D)** `reversed_relationship` — Treats a rise in blood colloid osmotic pressure as promoting filtration; raising it strengthens reabsorption and reduces the residual the lymphatics carry.
  - Citation: AP:39388-39391

**Readback check.** Keyed option content words: I, II, only. The key carries no scientific content words at all, so a stem echo is structurally impossible. The stem supplies three interventions but never states the direction of their effect on filtration, reabsorption, or lymph formation, and it never uses the terms hydrostatic pressure, colloid osmotic pressure, or reabsorption. Each item must be independently evaluated against the filtration and reabsorption balance. AUDIT CHANGES: (1) Item III now specifies a small volume of concentrated albumin. As originally written, a large hyperoncotic infusion also expands plasma volume and raises capillary hydrostatic pressure, which made the direction of item III arguable and gave a defensible case for including it. (2) Replaced option D 'II and III only' with 'I and III only' so that one distractor isolates the item III reversal while correctly crediting item I, and replaced option C 'I and III only' position with the new key ordering. The option set now runs singles ascending then pairs ascending, moving the key from B to C and helping correct the batch wide skew toward B.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because both venous obstruction and plasma dilution widen the gap between filtration and reabsorption, whereas raising plasma protein concentration narrows it. Lymph is simply the filtered fluid that the blood capillaries fail to take back, so anything that increases net filtration increases lymph formation. Obstructing venous outflow raises pressure in the venules and reflects that pressure back into the capillaries, driving more fluid into the interstitial fluid. Diluting the plasma with protein free saline lowers blood colloid osmotic pressure, the force responsible for reabsorption, so less of the filtered fluid returns to the capillary. Concentrated albumin does the opposite by strengthening that reabsorptive force.
>
> (Choice A) Item I is correctly credited, since raised capillary pressure promotes the flow of fluid out of the capillaries and into the interstitial fluid. This choice overlooks item II, however, because reabsorption depends on plasma protein concentration, which a large protein free infusion dilutes.
>
> (Choice B) Item II is correctly credited, but this choice rejects item I. Obstructing venous outflow does not reduce filtration; blood accumulating upstream of the obstruction raises pressure in the venules and eventually the capillaries, which pushes additional fluid into the tissue.
>
> (Choice C) This is the correct answer. Items I and II raise net filtration through opposite arms of the same balance, one by raising the outward hydrostatic force and one by weakening the inward osmotic force, and both surpluses must leave the tissue as lymph.
>
> (Choice D) Item III raises blood colloid osmotic pressure, which is the force that draws fluid from the tissue back into the capillary. Strengthening it increases reabsorption and reduces the residual that the lymphatics must carry, so this intervention lowers rather than raises lymph formation.
>
> This is a Scientific Reasoning and Problem Solving question because you must apply the balance of hydrostatic and colloid osmotic forces to predict the direction of change under three separate perturbations.

---

## B3-Q11 — Cannulated Lymph Sampling As A Permeability Assay

**Stem.** Investigators cannulate the lymphatic vessel draining a dog hindlimb and find that lymph flow triples within minutes of infusing a test compound into the femoral artery. They cannot yet tell whether the compound raised capillary hydrostatic pressure or increased the permeability of the capillary wall. Which additional measurement would best distinguish these two possibilities?

- **A.** The rate of lymph flow from the opposite, uninfused hindlimb
- **B.** The protein concentration of the collected lymph relative to plasma  <- **KEY**
- **C.** Mean arterial pressure in the femoral artery during the infusion
- **D.** The increase in weight of the infused limb during the infusion

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 95 s |
| Confidence | 4 |

**Correct answer (B): The protein concentration of the collected lymph relative to plasma**

Citations: AP:39385-39387 "The plasma proteins suspended in blood cannot move across the semipermeable capillary cell membrane, and so they remain in the plasma." | AP:39388-39390 "the BCOP is higher than the interstitial fluid colloidal osmotic pressure (IFCOP), which is always very low because interstitial fluid contains few proteins." | AP:42162-42163 "Lymph is the term used to describe interstitial fluid once it has entered the lymphatic system." | AP:7042-7043 "Lymphatic capillaries are extremely permeable, allowing larger molecules and excess fluid from interstitial spaces to enter the lymphatic vessels." | AP:38769-38772 "Increased pressure will promote the flow of fluids out of the capillaries and into the interstitial fluid. The presence of excess tissue fluid around the cells leads to a condition called edema." | AP:38602-38605 "The importance of the arterioles is that they will be the primary site of both resistance and regulation of blood pressure. The precise diameter of the lumen of an arteriole at any given moment is determined by neural and chemical controls, and vasoconstriction and vasodilation in the arterioles are the primary mechanisms for distribution of blood flow." | AP:39172-39174 "blood pressure drops unevenly as blood travels from arteries to arterioles, capillaries, venules, and veins, and encounters greater resistance. However, the site of the most precipitous drop, and the site of greatest resistance, is the arterioles." | AP:39426-39429 "more net fluid will exit the capillary through filtration at the arterial end than enters through reabsorption at the venous end ... This excess fluid is picked up by capillaries of the lymphatic system."

**Distractors**

- **(A)** `adjacent_fact` — A legitimate control for systemic drift, but lymph flow in the untreated limb is unchanged under both hypotheses, so it identifies the effect as local without identifying its mechanism.
  - Citation: AP:39426-39429
- **(C)** `partial_truth` — Arterial pressure is not equivalent to capillary hydrostatic pressure. The arterioles carry the most precipitous pressure drop in the circulation, so a change in their tone alters capillary pressure at constant arterial pressure and this reading excludes neither mechanism.
  - Citation: AP:38602-38605 | AP:39172-39174
- **(D)** `process_step_confusion` — Limb weight tracks accumulated tissue fluid, which rises under either mechanism, so it quantifies the magnitude of net filtration rather than distinguishing its cause.
  - Citation: AP:38771-38772

**Readback check.** Keyed option content words: protein, concentration, lymph, plasma, relative. The stem contains lymphatic, lymph flow, capillary hydrostatic pressure, permeability, femoral artery, and compound. The word protein appears nowhere in the stem, and the stem deliberately states the permeability hypothesis without naming what the wall is permeable to, so the key introduces protein as new content. Lymph and plasma are shared referents needed to make any of the four measurements interpretable. No definition to name and no self justifying key. AUDIT CHANGES: (1) Replaced the citation for choice C. The draft cited AP:39364-39371, which defines interstitial fluid hydrostatic pressure and osmotic pressure and contains nothing about arteriolar control of capillary pressure. Substituted AP:38602-38605 and AP:39172-39174, which state that the arterioles are the primary site of resistance and regulation and the site of the most precipitous pressure drop. (2) Removed AP:42164-42165 ('protein-rich interstitial fluid accumulates') from the citation list; that line describes lymphedema and was unused here, where the reasoning depends on lymph being protein poor under normal conditions. (3) Reworded choice A citation to AP:39426-39429, which actually supports baseline lymph flow as the residual of filtration. (4) Minor wording polish to choice D and to the choice D explanation block.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because the two candidate mechanisms move lymph flow in the same direction but move the composition of that lymph in opposite directions. Plasma proteins normally cannot cross the capillary wall, so the fluid filtered into the tissue, and therefore the lymph formed from it, is protein poor compared with plasma. If the compound acted purely by raising capillary hydrostatic pressure, it would force out more of that same protein poor filtrate, so lymph flow would rise while the lymph to plasma protein ratio fell. If instead the wall became more permeable, colloid would escape alongside the water and the lymph to plasma protein ratio would climb toward one. Flow alone cannot separate the two, but the ratio can.
>
> (Choice A) Sampling the untreated limb is a reasonable control for systemic drift such as a change in blood pressure or temperature. Lymph flow there would be unchanged under either mechanism, however, so the comparison confirms that the effect is local without revealing how it was produced.
>
> (Choice B) This is the correct answer. A lymph to plasma protein ratio that rises toward unity indicates escape of colloid across a leakier wall, whereas a falling ratio indicates dilution by additional protein poor filtrate driven out by pressure.
>
> (Choice C) Capillary hydrostatic pressure is not fixed by arterial pressure. The arterioles are the site of the most precipitous pressure drop in the circulation, so dilating them delivers a larger share of arterial pressure to the capillary bed even when mean arterial pressure holds steady. An unchanged arterial reading would therefore rule out neither mechanism.
>
> (Choice D) Weight gain in the limb tracks the accumulation of fluid in the tissue, which increases whenever net filtration exceeds the capacity of reabsorption and lymphatic drainage. Both proposed mechanisms raise net filtration, so this measurement reports the size of the effect rather than its cause.
>
> This is a Reasoning about the Design and Execution of Research question because you must select the measurement that discriminates between two hypotheses that predict identical results for the variable already recorded.

---

## B3-Q12 — Countercurrent Vascular Heat Exchange In A Limb

**Stem.** In a whale swimming in near freezing water, each artery running out to the flipper is surrounded by a bundle of veins carrying blood back from the flipper tip. Compared with an arrangement in which those same veins run just beneath the skin of the flipper, this arrangement most likely does which of the following?

- **A.** Delivers warmer blood to the flipper tip, so more heat is lost to the water.
- **B.** Returns cooler blood to the core, so core temperature drops during a long dive.
- **C.** Raises the resistance to flow through the flipper, so flipper perfusion falls.
- **D.** Returns warmer blood to the core, so less heat is lost to the water.  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 90 s |
| Confidence | 5 |

**Correct answer (D): Returns warmer blood to the core, so less heat is lost to the water.**

Citations: BIO:43840-43843 "Some animals have adaptations to their circulatory system that enable them to transfer heat from arteries to veins, warming blood returning to the heart. This is called a countercurrent heat exchange; it prevents the cold venous blood from cooling the heart and other internal organs. This adaptation can be shut down in some animals to prevent overheating the internal organs." | BIO:54000-54002 "Living in cold water, whales need to maintain the temperature in their blood. This is achieved by the veins and arteries being close together so that heat exchange can occur. This mechanism is called a countercurrent heat exchanger." | BIO:43837-43840 "Vasodilation brings more blood and heat to the body surface, facilitating radiation and evaporative heat loss, which helps to cool the body. Vasoconstriction reduces blood flow in peripheral blood vessels, forcing blood toward the core and the vital organs found there, and conserving heat." | BIO:43844-43845 "similar adaptations can help cool endotherms when needed, such as dolphin flukes and elephant ears." | AP:39159-39160 "artery or arteriole constricts to one-half of its original radius, the resistance to flow will increase 16 times."

**Distractors**

- **(A)** `reversed_relationship` — Reverses the direction of heat transfer within the bundle; heat passes from the warmer arterial blood into the cooler returning venous blood, so the tip receives cooled blood.
  - Citation: BIO:43840-43842
- **(B)** `process_step_confusion` — States the opposite of the adaptation's purpose. Venous blood is warmed on its way back, which is what prevents cold blood from cooling the heart and other internal organs.
  - Citation: BIO:43841-43843
- **(C)** `adjacent_fact` — Vessel resistance is set chiefly by radius, which the described pairing does not change; reduced peripheral perfusion in the cold arises from vasoconstriction instead.
  - Citation: AP:39159-39160 | BIO:43839-43840

**Readback check.** Keyed option content words: warmer, core, heat, lost, water. The stem contains whale, near freezing, artery, flipper, bundle, veins, skin. The words heat, warmer, and core appear nowhere in the stem, and heat or temperature language appears in three of the four options, so no single option is signposted. Water and flipper are shared referents present in the competing options as well. No definition to name and no restated premise. AUDIT CHANGES: all five citations verified verbatim against BIO:43837-43845 and BIO:54000-54002 and are correct as drafted. Added AP:39159-39160 to support the resistance and radius claim in the choice C block, which previously rested on a citation about vasoconstriction alone. Changed 'can be bypassed' to 'can be shut down' to match the textbook's own description, and generalized 'arteriolar vasoconstriction' to 'vasoconstriction of the peripheral vessels', which is what BIO:43839-43840 actually states. Scope note for the parent: batch 1 used 'Role In Thermoregulation'; this item is retained because the assigned unit mandates capillary heat exchange and because the reasoning turns on countercurrent geometry rather than on surface vasodilation and vasoconstriction.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because placing outgoing and returning vessels in direct contact lets heat pass from the arterial blood into the venous blood before that heat can reach the surface and be lost. This countercurrent arrangement transfers heat from arteries to veins, warming the blood returning to the heart and preventing cold venous blood from cooling the core organs. The consequence at the far end of the limb is that arterial blood arrives already cooled, so the temperature difference between the flipper tip and the surrounding water is small and surface heat loss is modest. Routing the return through superficial veins instead would carry warm blood along the skin, where that heat is given up to the water rather than recaptured. The same anatomy can be shut down when an animal needs to dump heat, which is why structures such as flukes and ears can serve as radiators.
>
> (Choice A) This reverses the direction of heat flow within the vessel bundle. Heat moves down its gradient from the warmer arterial blood into the cooler returning venous blood, so the tip receives blood that is cooler, not warmer, than blood leaving the core.
>
> (Choice B) Returning blood is warmed rather than cooled as it passes alongside the artery, which is precisely how the arrangement protects the heart and internal organs. An arrangement that delivered chilled blood to the core would defeat the purpose of the adaptation.
>
> (Choice C) Wrapping veins around an artery does not appreciably change the radius of the artery, and resistance in a vessel is governed chiefly by radius. Reduced flipper perfusion in the cold is produced by vasoconstriction of the peripheral vessels, which is a separate mechanism from the anatomical pairing described.
>
> (Choice D) This is the correct answer. Heat carried outward in arterial blood is handed off to the adjacent venous blood and returned to the core, so the limb functions as a heat conserving exchanger rather than a radiator.
>
> This is a Scientific Reasoning and Problem Solving question because you must predict the thermal consequence of a described vascular geometry.

---

## B3-Q13 — Interstitial Protein Retention After Lymphatic Loss

**Stem.** Several weeks after the lymphatic vessels draining one arm are removed during surgery, that arm remains swollen, and fluid sampled from its tissue spaces contains far more albumin than fluid sampled from the opposite arm. Which consequence of the retained albumin best explains why fluid keeps accumulating in the arm?

- **A.** Blood colloid osmotic pressure falls as albumin leaves the plasma, so reabsorption drops in every capillary bed.
- **B.** Interstitial colloid osmotic pressure rises, so less of the filtered fluid is drawn back at the venous end.  <- **KEY**
- **C.** Interstitial fluid hydrostatic pressure rises as fluid collects, and that pressure opposes further filtration from the capillary.
- **D.** The retained albumin draws water out of the cells of the arm, so the swelling reflects lost cell volume.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic hard / structural hard) |
| Estimated time | 125 s |
| Confidence | 5 |
| Hard-tier gate | Meets (1) CONCEPT CHAINING: lymphatic removal to loss of protein clearance to rising colloid osmotic pressure outside the capillary to a narrowed reabsorption gradient to progressive accumulation. Meets (3) TRUE PARTIAL TRUTH TRAP: choice C is a factually correct statement about the Starling balance that is misapplied, since a rising tissue hydrostatic pressure limits swelling rather than sustaining it and follows from the accumulated fluid rather than from the retained albumin. Meets (4) 510 TEMPTING DISTRACTOR: choice A is the textbook hypoalbuminemic mechanism of edema, correct physiology in the wrong setting, failing only on locality and on the size of the plasma protein pool. |

**Correct answer (B): Interstitial colloid osmotic pressure rises, so less of the filtered fluid is drawn back at the venous end.**

Citations: AP:42163-42166 "When the lymphatic system is damaged in some way, such as by being blocked by cancer cells or destroyed by injury, protein-rich interstitial fluid accumulates ... in the tissue spaces. This inappropriate accumulation of fluid referred to as lymphedema may lead to serious medical consequences." | AP:39388-39391 "the BCOP is higher than the interstitial fluid colloidal osmotic pressure (IFCOP), which is always very low because interstitial fluid contains few proteins. Thus, water is drawn from the tissue fluid back into the capillary, carrying dissolved molecules with it. This difference in colloidal osmotic pressure accounts for reabsorption." | AP:39385-39387 "The plasma proteins suspended in blood cannot move across the semipermeable capillary cell membrane, and so they remain in the plasma." | AP:39363-39365 "As fluid exits a capillary and moves into tissues, the hydrostatic pressure in the interstitial fluid correspondingly rises. This opposing hydrostatic pressure is called the interstitial fluid hydrostatic pressure (IFHP)." | AP:7042-7043 "Lymphatic capillaries are extremely permeable, allowing larger molecules and excess fluid from interstitial spaces to enter the lymphatic vessels." | AP:54658-54662 "Other causes of edema include damage to blood vessels and/or lymphatic vessels, or a decrease in osmotic pressure in chronic and severe liver disease, where the liver is unable to manufacture plasma proteins ... A decrease in the normal levels of plasma proteins results in a decrease of colloid osmotic pressure (which counterbalances the hydrostatic pressure) in the capillaries." | AP:39429-39431 "This excess fluid is picked up by capillaries of the lymphatic system."

**Distractors**

- **(A)** `partial_truth` — Describes the real hypoalbuminemic mechanism of edema, but the plasma albumin pool is large and replenished, and a systemic fall in colloid osmotic pressure would cause generalized rather than single limb swelling.
  - Citation: AP:54658-54662
- **(C)** `reversed_relationship` — Interstitial hydrostatic pressure does rise and does oppose filtration, but that force limits swelling and predicts a plateau, the opposite of the continued accumulation described, and it follows from the accumulated fluid rather than from the retained albumin.
  - Citation: AP:39363-39365
- **(D)** `misconception` — Attributes the swelling to water shifting out of cells; colloid outside the capillary does not appreciably shrink cells, and the accumulated fluid arrives from the capillaries by filtration.
  - Citation: AP:39388-39390

**Readback check.** Keyed option content words: interstitial, colloid osmotic pressure, rises, filtered, drawn back, venous end. The stem contains lymphatic vessels, removed, swollen, tissue spaces, albumin, accumulating. Albumin is a shared referent that appears in the competing options and is equally necessary to all of them. The terms colloid osmotic pressure, reabsorption, filtration, capillary, and venous end appear nowhere in the stem, so the mechanism cannot be read back. The stem supplies a measured protein concentration to reason from and withholds the conclusion. AUDIT CHANGES: (1) Replaced the citation for choice C. The draft cited AP:39374-39379, which concerns osmotic concentration gradients and plasma proteins as colloid, not interstitial hydrostatic pressure. The supporting text is at AP:39363-39365. (2) Rewrote choice C, which previously ended 'so the excess fluid is driven back into the capillaries'. That clause made the option transparently non explanatory and undercut the claimed partial truth trap; the revised wording is a true statement whose flaw is that it is a brake on swelling and a consequence of the fluid rather than of the albumin. (3) Changed 'interstitial fluid sampled from it' to 'fluid sampled from its tissue spaces' in the stem, removing the word interstitial and tightening the readback margin against options B and C. (4) Rebalanced option lengths so the key is not the longest option; choice D is now the longest. (5) Added AP:7042-7043 to support the newly explicit claim that lymphatic capillaries clear escaped protein.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because reabsorption at the venous end depends on the colloid osmotic pressure of plasma exceeding that of the fluid outside the capillary, and trapped albumin erodes that difference. Normally the fluid in the tissue spaces contains few proteins, so its colloid osmotic pressure is very low and water is drawn from the tissue back into the capillary. A small quantity of albumin always escapes the capillaries, and the lymphatic capillaries, which are permeable to large molecules, normally clear it along with the surplus filtrate. Once those vessels are gone the escaped protein has no exit and its concentration in the tissue climbs, so the osmotic gradient that used to recover fluid shrinks. Net filtration then exceeds recovery by an ever larger margin, which is why protein rich fluid keeps building up rather than settling at a new steady volume.
>
> (Choice A) A generalized fall in plasma protein concentration is a genuine cause of swelling, as seen when the liver cannot manufacture plasma proteins. It cannot explain this case, because the plasma albumin pool is large and continually replenished, and a systemic fall in colloid osmotic pressure would produce widespread swelling rather than swelling confined to one arm.
>
> (Choice B) This is the correct answer. Rising colloid osmotic pressure outside the capillary narrows the gradient responsible for reabsorption, so a progressively larger share of the filtered fluid stays in the tissue.
>
> (Choice C) This statement is accurate on its own terms, because hydrostatic pressure in the tissue does rise as fluid collects and does oppose further filtration. That force acts as a brake on swelling rather than a cause of it, so it predicts that the limb would settle at a new stable volume. It is also a consequence of the accumulated fluid rather than of the retained albumin the question asks about.
>
> (Choice D) Albumin outside the capillary does not draw appreciable water out of cells, since cell volume is governed by small permeant solutes rather than by colloid. The accumulated fluid arrives from the capillaries by filtration, so the swollen limb reflects added extracellular volume rather than shrunken cells.
>
> This is a Scientific Reasoning and Problem Solving question because you must trace how a change in the protein concentration outside the capillary alters the balance of forces governing reabsorption.

---

## B3-Q14 — Plasma Fraction and Plasma Protein Content

**Stem.** Whole blood from a healthy adult is centrifuged. The packed erythrocyte column occupies \(45\%\) of the tube, and protein accounts for about \(7\%\) of the volume of the clear layer above it. Which value is closest to the percentage of whole blood volume made up by the protein in that clear layer?

- **A.** About \(0.4\%\)
- **B.** About \(4\%\)  <- **KEY**
- **C.** About \(7\%\)
- **D.** About \(13\%\)

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic easy / structural easy) |
| Estimated time | 65 s |
| Confidence | 5 |

**Correct answer (B): About \(4\%\)**

Citations: AP:33734 'One such test, called a hematocrit, measures the percentage of RBCs, clinically known as erythrocytes, in a blood sample.' | AP:33752-33753 'The volume of erythrocytes after centrifugation is also commonly referred to as packed cell volume (PCV). In normal blood, about 45 percent of a sample is erythrocytes.' | AP:33757 'So the mean plasma percentage is the percent of blood that is not erythrocytes' | AP:33794 'Like other fluids in the body, plasma is composed primarily of water: In fact, it is about 92 percent water.' | AP:33809 'About 7 percent of the volume of plasma' ... 'is made of proteins' (the ellipsis skips a clause the source sets off with dash punctuation, which is barred from these fields) | AP:33838-33839 'All of these nonprotein solutes combined contribute approximately 1 percent to the total volume of plasma.'

**Distractors**

- **(A)** `scale_unit_error` . _order of magnitude slip_ — Multiplying 7 percent by a plasma fraction of 0.55 changes the value only modestly, so a tenfold reduction is not a possible result; 0.4 percent is nearer the whole blood share of plasma's nonprotein solutes.
  - Citation: AP:33838-33839 'All of these nonprotein solutes combined contribute approximately 1 percent to the total volume of plasma.'
- **(C)** `process_step_confusion` . _skipped rescaling step_ — This applies the per plasma figure directly to whole blood and ignores the 45 percent of the tube occupied by erythrocytes, which contain no plasma protein.
  - Citation: AP:33752-33753 'The volume of erythrocytes after centrifugation is also commonly referred to as packed cell volume (PCV). In normal blood, about 45 percent of a sample is erythrocytes.'
- **(D)** `reversed_relationship` . _divided instead of multiplied_ — Dividing 7 percent by 0.55 makes whole blood appear richer in plasma protein than plasma itself, which is impossible when nearly half of whole blood volume is cells.
  - Citation: AP:33757 'So the mean plasma percentage is the percent of blood that is not erythrocytes'

**Readback check.** The key is a bare numeric value and carries no content words, so a stem echo is impossible. The stem supplies two measured percentages and never names plasma, protein content of whole blood, or the operation required. AUDIT NOTE ON WHAT CHANGED: this item REPLACES the original 'Hematocrit and Plasma Volume' cyclist question. Two defects forced the replacement. (1) CROSS-ITEM LEAKAGE AND REDUNDANCY: its key (plasma volume has fallen while erythrocyte number is fixed) is exactly the mechanism that question 7 hands the solver in its stem for patient A, and both items cited the same source line AP:34333-34335, so a solver who saw either item got the other free. (2) NUMBERS: a rise from \(44\%\) to \(52\%\) with fixed erythrocyte volume requires a \(27.5\%\) fall in plasma volume, which overstates the hemoconcentration produced by a single hot ride. A further defect in the original was that 'circulation' appeared in the stem and in the keyed option only, a weak echo. The replacement is built on verified composition figures instead.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because the \(7\%\) figure applies only to the liquid layer, which is a little more than half of whole blood, so the whole blood figure must be a little more than half of \(7\%\). The clear layer above the packed cells is plasma, and with an erythrocyte column of \(45\%\) the plasma fraction is \(100\% - 45\% = 55\%\). Protein occupies about \(7\%\) of plasma volume, so protein occupies \(0.55 \times 0.07 = 0.0385\), or roughly \(3.9\%\) of whole blood, which rounds to \(4\%\). Plasma is otherwise about \(92\%\) water, and all of its nonprotein solutes together contribute only about \(1\%\) of plasma volume. (Choice A) A value near \(0.4\%\) is roughly an order of magnitude too small and is closer to the whole blood share of plasma's nonprotein solutes than to its protein. Scaling \(7\%\) by \(0.55\) shifts the value only modestly, never by a factor of ten. (Choice B) Plasma makes up \(55\%\) of this sample, and \(7\%\) of that \(55\%\) is about \(3.9\%\). The answer must lie between half of \(7\%\) and \(7\%\) itself, and only this choice falls in that interval. (Choice C) A value of \(7\%\) applies the per plasma measurement directly to whole blood and ignores the \(45\%\) of the tube that erythrocytes occupy. Because that packed column holds no plasma protein, the whole blood figure must be smaller than the plasma figure. (Choice D) A value near \(13\%\) comes from dividing by \(0.55\) instead of multiplying by it. Dividing implies that whole blood is richer in plasma protein than plasma itself, which cannot hold when nearly half of whole blood volume is cells. This is a Scientific Reasoning and Problem Solving question because you must rescale a concentration expressed per unit of plasma into one expressed per unit of whole blood.

---

## B3-Q15 — Erythrocyte ATP Production

**Stem.** Washed human erythrocytes are suspended in a buffer containing \(5\ \text{mM}\) glucose. A dose of cyanide that abolishes ATP production in cultured hepatocytes leaves erythrocyte ATP unchanged, whereas an inhibitor of the glycolytic enzyme glyceraldehyde-3-phosphate dehydrogenase drives erythrocyte ATP nearly to zero within minutes. Which feature of mature erythrocytes best explains these results?

- **A.** An electron transport chain that cyanide cannot inhibit
- **B.** An absence of mitochondria and therefore of respiration  <- **KEY**
- **C.** An ATP reserve large enough to mask a loss of respiration
- **D.** A switch to glycolysis that occurs only when oxygen is scarce

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 80 s |
| Confidence | 5 |

**Correct answer (B): An absence of mitochondria and therefore of respiration**

Citations: AP:34079 'As an erythrocyte matures in the red bone marrow, it extrudes its nucleus and most of its other organelles.' | AP:34084-34085 'mature, circulating erythrocytes have few internal cellular structural components. Lacking mitochondria, for example, they rely on anaerobic respiration.' | AP:34085-34086 'This means that they do not utilize any of the oxygen they are transporting, so they can deliver it all to the tissues.' | AP:45936-45937 'Because erythrocytes do not contain mitochondria, glycolysis is the sole method by which these cells produce ATP.'

**Distractors**

- **(A)** `misconception` . _invents machinery the cell does not have_ — A cyanide resistant respiratory chain would still be a respiratory chain, and its presence contradicts the complete loss of ATP after a single glycolytic enzyme was blocked; the mature erythrocyte in fact carries no mitochondria at all.
  - Citation: AP:34084-34085 'mature, circulating erythrocytes have few internal cellular structural components. Lacking mitochondria, for example, they rely on anaerobic respiration.'
- **(C)** `partial_truth` . _buffering pool that cannot last_ — An ATP reserve could postpone but not prevent a fall, and the collapse within minutes under the glycolytic inhibitor shows turnover far too rapid for a masking reserve.
  - Citation: AP:45936-45937 'Because erythrocytes do not contain mitochondria, glycolysis is the sole method by which these cells produce ATP.'
- **(D)** `process_step_confusion` . _conditional anaerobiosis_ — Mature erythrocytes depend on glycolysis at all times because they retain no mitochondria to switch away from, and oxygen was not limiting in this buffer.
  - Citation: AP:34085-34086 'This means that they do not utilize any of the oxygen they are transporting, so they can deliver it all to the tissues.'

**Readback check.** Content words of key B: absence, mitochondria, respiration. None appears in the stem. The stem names cyanide, hepatocytes, glucose and a glycolytic enzyme, which are the data to reason from; 'cyanide' is shared with choice A, and 'glycolytic' points toward distractor D rather than toward the key. The stem states no conclusion about organelles or about which pathway supplies ATP. AUDIT NOTE ON WHAT CHANGED: (1) CITATION MISNUMBERED: the draft cited AP:34073 for 'As an erythrocyte matures in the red bone marrow, it extrudes its nucleus and most of its other organelles.' Line 34073 is blank; the sentence is at AP:34079. Corrected. (2) Two further citations were single-line but their quoted text spans two lines (AP:34084-34085 and AP:34085-34086, AP:45936-45937). Ranges corrected. (3) The distractor A citation supported the key rather than the distractor rationale, and the rationale asserted plant and fungal alternative oxidase biology that appears nowhere in either textbook; the rationale was rewritten to rest on the sourced fact that these cells lack mitochondria entirely, and the citation was repointed to AP:34084-34085. (4) The explanation clause 'the textbook states that' was removed; explanations should not reference the source text. Stem and options unchanged.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because a cell whose ATP is untouched by a respiratory poison but collapses when one cytoplasmic enzyme is blocked has no respiratory machinery to poison. Cyanide acts on the terminal oxidase of the electron transport chain, so a cell that ignores it is generating no ATP by oxidative phosphorylation. As an erythrocyte matures in red bone marrow it extrudes its nucleus and most of its other organelles, and because the mature cell contains no mitochondria, glycolysis is its only route to ATP. That single pathway explains why blocking one glycolytic enzyme empties the ATP pool within minutes, and it also means these cells consume none of the oxygen they carry. (Choice A) Human cells possess no cyanide insensitive terminal oxidase, so this choice invokes machinery these cells do not have. If any alternative respiratory chain were present, blocking a single glycolytic enzyme could not have driven ATP nearly to zero. (Choice B) Mature erythrocytes discard their organelles during maturation, leaving no mitochondria and therefore no oxidative phosphorylation for cyanide to act on. Every ATP molecule is made in the cytoplasm, so an inhibitor placed at glyceraldehyde-3-phosphate dehydrogenase halts the cell's entire supply. (Choice C) A stored pool of ATP could delay a decline but could not hold concentrations unchanged under continued exposure to cyanide. The collapse seen within minutes under the glycolytic inhibitor shows that ATP turns over far too fast for a reserve to hide a shutdown of respiration. (Choice D) This choice treats reliance on glycolysis as a conditional response to low oxygen, but a cell with no mitochondria has nothing to switch away from. Oxygen was not limiting in this buffer, yet the glycolytic inhibitor still removed the entire ATP supply. This is a Scientific Reasoning and Problem Solving question because you must infer the absence of an organelle from a cell's pattern of response to two different inhibitors.

---

## B3-Q16 — Plasma Proteins and Capillary Fluid Balance

**Stem.** A patient with advanced liver disease has normal capillary hydrostatic pressures of \(35\ \text{mm Hg}\) at the arterial end and \(18\ \text{mm Hg}\) at the venous end. The patient's blood colloid osmotic pressure, however, measures \(14\ \text{mm Hg}\) rather than the usual \(25\ \text{mm Hg}\). Which outcome is most likely in this patient's systemic capillary beds?

- **A.** Filtration continues along the entire length of each capillary.  <- **KEY**
- **B.** Reabsorption at the venous end proceeds more slowly than normal.
- **C.** Reabsorption at the venous end proceeds more rapidly than normal.
- **D.** Net fluid movement ceases because the two pressures now balance.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 85 s |
| Confidence | 5 |

**Correct answer (A): Filtration continues along the entire length of each capillary.**

Citations: AP:39409 'approximately 10 mm Hg, because the CHP of 35 mm Hg minus the BCOP of 25 mm Hg equals 10 mm Hg' | AP:39397 'end, the CHP has dropped to approximately 18 mm Hg.' | AP:39397-39398 'the plasma proteins remain suspended in the blood, so the BCOP remains fairly constant at about 25 mm Hg throughout the length of the capillary' | AP:39402 'It is equal to the difference between the CHP and the BCOP.' | AP:39411-39412 'At approximately the middle of the capillary, the CHP is about the same as the BCOP of 25 mm Hg, so the NFP drops to zero.' | AP:33815 'Albumin is the most abundant of the plasma proteins. Manufactured by the liver' | AP:33817-33819 'Albumin is also the most significant contributor to the osmotic pressure of blood; that is, its presence holds water inside the blood vessels' | AP:54660-54662 'A decrease in the normal levels of plasma proteins results in a decrease of colloid osmotic pressure (which counterbalances the hydrostatic pressure) in the capillaries. This process causes loss of water from the blood to the surrounding tissues, resulting in edema.'

**Distractors**

- **(B)** `partial_truth` . _right pattern, wrong sign_ — Slower reabsorption presumes the venous end net pressure is still negative, but 18 mm Hg now exceeds 14 mm Hg, so the sign has flipped and no reabsorption occurs.
  - Citation: AP:39397 'end, the CHP has dropped to approximately 18 mm Hg.'
- **(C)** `reversed_relationship` . _inverted protein effect_ — Faster inward movement of water would require a higher colloid osmotic pressure, whereas this patient's has fallen from 25 mm Hg to 14 mm Hg.
  - Citation: AP:54660-54662 'A decrease in the normal levels of plasma proteins results in a decrease of colloid osmotic pressure (which counterbalances the hydrostatic pressure) in the capillaries. This process causes loss of water from the blood to the surrounding tissues, resulting in edema.'
- **(D)** `misconception` . _false equilibrium_ — Exchange halts only where the two pressures are equal, as happens near the midpoint of a normal capillary, but here a 4 mm Hg difference persists even at the venous end.
  - Citation: AP:39411-39412 'At approximately the middle of the capillary, the CHP is about the same as the BCOP of 25 mm Hg, so the NFP drops to zero.'

**Readback check.** Content words of key A: filtration, continues, entire, length, capillary. 'Capillary' appears in the stem but is a shared referent that choice D also uses and that every choice depends on equally. 'Filtration' and 'continues' appear nowhere in the stem, which supplies three pressure values and no statement about the direction of fluid movement. AUDIT NOTE ON WHAT CHANGED: (1) OPTION LENGTH: the draft key was the longest option at 12 words against 10 for each distractor, a flagged defect; it was shortened to 9 words so the key is now the shortest. (2) The draft used 'arteriolar end' and 'venular end'; the source uses arterial end and venous end, and the terms were aligned to it. (3) PRONOUN NOT SUPPORTED BY THE STEM: the draft called the patient 'her' although no sex is stated; pronouns were removed. (4) CITATION RANGES: the draft cited AP:39398 for text beginning on 39397, AP:33817 for text running to 33819, and AP:54660 for text running to 54662. All corrected, and AP:39402 and AP:39411-39412 were added because they are the lines that actually state the net filtration pressure formula and the midpoint standstill asserted in the explanation. Numbers reverified: 35 minus 25 equals 10, 18 minus 25 equals negative 7, 18 minus 14 equals positive 4.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because with the opposing colloid pressure reduced to \(14\ \text{mm Hg}\), hydrostatic pressure exceeds it at every point along the vessel, so fluid never turns around. Net filtration pressure is capillary hydrostatic pressure minus blood colloid osmotic pressure, the interstitial pressures being small enough to neglect. Normally that yields \(35 - 25 = +10\ \text{mm Hg}\) at the arterial end, zero near the midpoint, and \(18 - 25 = -7\ \text{mm Hg}\) at the venous end, so fluid leaves early and is drawn back late. Here the venous end calculation becomes \(18 - 14 = +4\ \text{mm Hg}\), still positive, so fluid leaves over the whole length and accumulates in the interstitium as edema. Albumin, manufactured by the liver, is the single largest contributor to that colloid pressure, which is why a failing liver lowers it. (Choice A) Because the colloid pressure has fallen below even the venous end hydrostatic pressure, the difference stays positive from one end of the vessel to the other. Fluid therefore exits continuously with no reabsorption phase, and the lymphatic vessels cannot return all of it. (Choice B) This choice preserves the normal pattern and merely slows it, which requires the net pressure at the venous end to remain negative. With \(18\ \text{mm Hg}\) opposing only \(14\ \text{mm Hg}\), the sign of that difference has reversed, so no reabsorption occurs at all. (Choice C) More rapid reabsorption would require a larger colloid pressure pulling water inward, not a smaller one. This choice inverts the relationship between plasma protein concentration and the inward force. (Choice D) A standstill requires the two pressures to be equal, which normally occurs near the midpoint of a capillary where both are about \(25\ \text{mm Hg}\). In this patient a difference of \(4\ \text{mm Hg}\) remains even at the venous end, so exchange does not stop. This is a Scientific Reasoning and Problem Solving question because you must combine two opposing pressures at two locations and determine the sign of the result.

---

## B3-Q17 — Platelet Origin From Megakaryocytes

**Stem.** A drug destroys every megakaryocyte in a man's bone marrow while sparing all other marrow precursors and every formed element already in his blood. Which change is most likely over the following \(2\) weeks?

- **A.** His platelet count falls, because circulating platelets cannot replace themselves.  <- **KEY**
- **B.** His platelet count holds steady, because circulating platelets divide as they are lost.
- **C.** His platelet count holds steady, because the spleen regenerates its stored platelets.
- **D.** His platelet count falls, but only after several months of gradual decline.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic easy / structural easy) |
| Estimated time | 60 s |
| Confidence | 5 |

**Correct answer (A): His platelet count falls, because circulating platelets cannot replace themselves.**

Citations: AP:34551-34552 'A platelet is not a cell but rather a fragment of the cytoplasm of a cell called a megakaryocyte that is surrounded by a plasma membrane.' | AP:34555-34556 'These remain within bone marrow tissue (Figure 18.12) and ultimately form platelet-precursor extensions that extend through the walls of bone marrow capillaries' | AP:34558-34559 'Following platelet release, megakaryocyte remnants, which are little more than a cell nucleus, are consumed by macrophages.' (the same sentence pair gives an output of 2000 to 3000 platelets per megakaryocyte lifespan; the source prints that range with a dash character, which is barred from these fields) | AP:34562-34563 'After entering the circulation, approximately one-third migrate to the spleen for storage for later release in response to any rupture in a blood vessel.' | AP:34564 'Platelets remain only about 10 days, then are phagocytized by macrophages.'

**Distractors**

- **(B)** `misconception` . _fragment treated as a cell_ — Platelets are anucleate cytoplasmic fragments and carry no chromosomes, so they cannot enter mitosis and cannot maintain their own numbers in the blood.
  - Citation: AP:34551-34552 'A platelet is not a cell but rather a fragment of the cytoplasm of a cell called a megakaryocyte that is surrounded by a plasma membrane.'
- **(C)** `adjacent_fact` . _real splenic role, wrong process_ — About one third of platelets are stored in the spleen for later release, but the spleen stores rather than produces them, so the splenic pool is depleted alongside the circulating pool.
  - Citation: AP:34562-34563 'After entering the circulation, approximately one-third migrate to the spleen for storage for later release in response to any rupture in a blood vessel.'
- **(D)** `scale_unit_error` . _lifespan off by an order of magnitude_ — Platelets remain in circulation only about 10 days, so the count drops well within 2 weeks rather than after several months.
  - Citation: AP:34564 'Platelets remain only about 10 days, then are phagocytized by macrophages.'

**Readback check.** Content words of key A: platelet, count, falls, circulating, replace, themselves. 'Platelet count' opens all four options equally, and none of the key's other content words appears in the stem, which names only the drug, megakaryocytes, marrow precursors, formed elements and a time window. AUDIT NOTE ON WHAT CHANGED: the stem was replaced. (1) FACTUALLY SHAKY PREMISE: the draft stem had a hematologist find 'many leukocytes in mitosis' on a peripheral blood smear. Mature circulating leukocytes do not divide in the bloodstream, and mitotic figures on a peripheral smear are a pathological finding, so the comparison the item rested on was not sound; the draft explanation compounded this by asserting that 'leukocyte spindles in the same smear are visible.' (2) The draft distractor A, on the resolving power of light microscopy, was an optics claim with no textbook support and was not topic knowledge. The rewritten item keeps the same subtopic and difficulty but tests the consequence of megakaryocyte loss, which is supported line by line, and adds a verified lifespan figure at AP:34564. All citation line ranges were also corrected: the draft cited AP:34551, AP:34555, AP:34558 and AP:34562 for quotations that each run onto the following line.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because platelets are cytoplasmic fragments that cannot divide, so removing the cells that shed them cuts off the only source of new ones. A platelet is not a cell but a fragment of megakaryocyte cytoplasm surrounded by a bit of plasma membrane, released when megakaryocyte extensions reach through the walls of marrow capillaries. A single megakaryocyte sheds \(2{,}000\) to \(3{,}000\) such fragments over its lifespan, and the nucleus stays behind in the megakaryocyte remnant. Circulating platelets survive only about \(10\) days before macrophages remove them, so \(2\) weeks without megakaryocytes leaves the count clearly depressed. (Choice A) With no megakaryocytes left, no new fragments enter the blood, and the platelets already circulating carry no nucleus and so no chromosomes to replicate or partition. Clearance by macrophages continues at its normal rate, so the count falls steadily. (Choice B) Division of circulating platelets would require genetic material, which anucleate fragments do not carry. No formed element sustains its own numbers in the bloodstream this way; replacement always comes from marrow precursors. (Choice C) About one third of platelets are held in the spleen for later release, so the organ genuinely stores them, but storage is not production. Once megakaryocyte output stops, the splenic pool is drawn down along with the circulating pool. (Choice D) A delay of months would require a platelet lifespan of months, whereas platelets persist only about \(10\) days. A fall is therefore evident well inside the \(2\) week window described. This is a Knowledge of Scientific Concepts and Principles question because you must recall that platelets are anucleate megakaryocyte fragments with a lifespan of roughly \(10\) days.

---

## B3-Q18 — Erythrocyte Deformability and Capillary Transit

**Stem.** A woman inherits a defect in the erythrocyte membrane skeleton, so her circulating erythrocytes are rigid and cannot bend, although their diameter is unchanged at \(7\ \mu\text{m}\). Her aorta and large arteries remain unobstructed. Where in the circulation would these cells most likely first lodge?

- **A.** In capillaries, where the velocity of blood flow is lowest  <- **KEY**
- **B.** In arterioles, where resistance to blood flow is greatest
- **C.** In large veins, which hold most of the blood volume
- **D.** In the pulmonary trunk, where blood pressure is relatively low

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic easy / structural easy) |
| Estimated time | 65 s |
| Confidence | 5 |

**Correct answer (A): In capillaries, where the velocity of blood flow is lowest**

Citations: AP:38610-38611 'the smallest are just barely wide enough for an erythrocyte to squeeze through' (the same sentence gives a capillary lumen diameter of 5 to 10 micrometers; the source prints that range with a dash character, barred from these fields) | AP:34060-34061 'they are quite small cells, with a mean diameter of only about' (7 to 8 micrometers, same dash convention) | AP:34087-34089 'Erythrocytes do, however, contain some structural proteins that help the blood cells maintain their unique structure and enable them to change their shape to squeeze through capillaries. This includes the protein spectrin, a cytoskeletal protein element.' | AP:34098-34100 'the space within capillaries can be so minute that, despite their own small size, erythrocytes may have to fold in on themselves if they are to make their way through. Fortunately, their structural proteins like spectrin are flexible, allowing them to bend over themselves to a surprising degree, then spring back again when they enter a wider vessel.' | AP:39178-39179 'the velocity (speed) of blood flow decreases dramatically as the blood moves from arteries to arterioles to capillaries. This slow flow rate allows more time for exchange processes to occur.'

**Distractors**

- **(B)** `adjacent_fact` . _correct vessel fact, wrong question_ — Arterioles genuinely dominate systemic resistance, but an arteriolar lumen averages about 30 micrometers, roughly four times an erythrocyte's width, so a rigid cell passes without lodging.
  - Citation: AP:38597 'With a lumen averaging 30 micrometers or less in diameter' | AP:39173-39174 'the site of the most precipitous drop, and the site of greatest resistance, is the arterioles.'
- **(C)** `misconception` . _large reservoir mistaken for a bottleneck_ — Large veins hold most of the blood precisely because their wide lumens and thin walls let them distend, and distensibility prevents rather than causes obstruction.
  - Citation: AP:38806-38809 'systemic veins contain approximately 64 percent of the blood volume at any given time' ... 'The large lumens and relatively thin walls of veins make them far more distensible than arteries'
- **(D)** `partial_truth` . _true pressure claim, irrelevant to fit_ — The pulmonary trunk does carry blood at lower pressure than the aorta, but whether a cell of fixed width lodges depends on lumen size, and this is a conducting vessel far wider than one cell.
  - Citation: AP:35910-35911 'The right ventricle does not need to generate as much pressure, since the pulmonary circuit is shorter and provides less resistance.'

**Readback check.** Content words of key A: capillaries, velocity, blood, flow, lowest. None appears in the stem, which after revision names only the membrane skeleton, rigidity, a diameter, the aorta and large arteries. Every option now carries a true but non-justifying attribute of its vessel class, so the key does not supply its own reason and no option is eliminable without size knowledge. AUDIT NOTE ON WHAT CHANGED: three defects were fixed. (1) NUMBERS: the draft stem specified 'rigid spheres of normal volume.' A sphere holding a normal erythrocyte volume of about \(90\ \text{fL}\) has a diameter near \(5.6\ \mu\text{m}\), which is smaller than the \(7\) to \(8\ \mu\text{m}\) disc and sits inside the \(5\) to \(10\ \mu\text{m}\) capillary range, so the draft key's premise that the cells exceed the lumen was not secure. The stem now fixes diameter at \(7\ \mu\text{m}\) and removes deformability, which is the property the source actually links to capillary transit. (2) SELF-JUSTIFYING KEY: the draft key read 'capillaries, whose lumens are narrower than the cells themselves,' which stated its own reason and echoed 'cells' from the stem. (3) CITATIONS: the draft cited AP:38610, AP:34061, AP:34098 and AP:34073 for quotations that each begin or end on an adjacent line, and used a citation about capillary folding to support a claim about large veins. Ranges corrected, dedicated sources added for the vein, arteriole and pulmonary trunk descriptors, and numeric ranges moved outside the quotation marks because the source prints them with dash characters.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because capillaries are the only vessels whose lumen can be narrower than an erythrocyte, so passage there depends on the cell bending rather than on the vessel widening. A capillary lumen measures roughly \(5\) to \(10\ \mu\text{m}\) across, and the narrowest are just barely wide enough for an erythrocyte to squeeze through. A normal erythrocyte solves this by folding over itself and springing back on reaching a wider vessel, a maneuver permitted by flexible structural proteins such as spectrin. A cell locked into a rigid shape keeps its full \(7\ \mu\text{m}\) width and therefore wedges at the first point where the lumen falls below that value. (Choice A) Flow velocity is indeed lowest here, but the reason a rigid cell stops is dimensional: this is the only vessel class whose internal diameter approaches that of a single erythrocyte. The unobstructed aorta and large arteries have lumens hundreds of times wider. (Choice B) Arterioles do produce the most precipitous pressure drop and the greatest resistance in the systemic circuit, so the claim attached to this choice is accurate. Their lumens average about \(30\ \mu\text{m}\), however, roughly four times an erythrocyte's width, so a rigid cell passes through them. (Choice C) Systemic veins do hold about \(64\%\) of the blood volume, because their large lumens and thin walls make them highly distensible. Large lumens and distensibility work against obstruction rather than for it. (Choice D) The pulmonary trunk does carry blood at a lower pressure than the aorta, since the right ventricle faces less resistance. Pressure does not decide whether a cell of fixed width fits, and this is a conducting vessel far wider than any single cell. This is a Scientific Reasoning and Problem Solving question because you must match a change in cell mechanics to the one vessel dimension it constrains.

---

## B3-Q19 — Plasma Versus Serum

**Stem.** Two tubes of blood are drawn from the same donor in the same minute. Tube 1 contains an anticoagulant and is centrifuged at once, while tube 2 has no additive and is left standing for \(30\) minutes before centrifugation. Which measurement made on the clear fluid above the cells in tube 2 would be markedly lower than the same measurement on tube 1?

- **A.** Sodium ion concentration
- **B.** Albumin concentration
- **C.** Fibrinogen concentration  <- **KEY**
- **D.** Glucose concentration

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 75 s |
| Confidence | 5 |

**Correct answer (C): Fibrinogen concentration**

Citations: AP:33804-33805 'Serum, one of the specimen types included, refers to a sample of plasma after clotting factors have been removed.' | AP:33830 'Fibrinogen is the third of the three major groups of plasma proteins.' | AP:33831 'fibrinogen is produced by the liver. It is essential for blood clotting' | AP:33832-33833 'Fibrinogen accounts for about 7 percent of the total plasma protein volume' (clinical levels 0.2 to 0.45 g/dL; the source prints the range with a dash character, barred from these fields) | AP:33815 'Albumin is the most abundant of the plasma proteins.' | AP:33820-33821 'Albumin normally accounts for approximately 54 percent of the total plasma protein content' (clinical levels 3.5 to 5.0 g/dL, same dash convention) | AP:33836-33837 'plasma contains a wide variety of other substances. These include various electrolytes, such as sodium, potassium, and calcium ions' | AP:33838 'organic nutrients, such as vitamins, lipids, glucose, and amino acids' | BIO:53598 'The plasma component of blood without the coagulation factors is called the serum.'

**Distractors**

- **(A)** `adjacent_fact` . _real plasma solute, unaffected_ — Sodium is a small electrolyte that remains dissolved in the fluid phase and is not consumed by clot formation, so the two tubes give the same value.
  - Citation: AP:33836-33837 'plasma contains a wide variety of other substances. These include various electrolytes, such as sodium, potassium, and calcium ions'
- **(B)** `partial_truth` . _abundant protein assumed to be lost_ — Albumin dominates plasma protein by mass but is not incorporated into fibrin, so its concentration is essentially identical above a clot and above anticoagulated cells.
  - Citation: AP:33815 'Albumin is the most abundant of the plasma proteins.' | AP:33820-33821 'Albumin normally accounts for approximately 54 percent of the total plasma protein content' (clinical levels 3.5 to 5.0 g/dL)
- **(D)** `process_step_confusion` . _slow preanalytic drift mistaken for removal_ — Glucose is a nonprotein solute that coagulation does not remove, and cellular consumption over only 30 minutes is far too small to create a marked difference.
  - Citation: AP:33838 'organic nutrients, such as vitamins, lipids, glucose, and amino acids'

**Readback check.** The single content word of key C is fibrinogen, which does not appear in the stem. The stem deliberately avoids clot, clotting, fibrin, coagulation and serum. The only shared word is 'concentration', which appears in all four options equally. The stem describes a handling procedure and offers no explanation. AUDIT NOTE ON WHAT CHANGED: stem, options and key are unchanged and were confirmed correct, but THREE CITATIONS WERE MISNUMBERED and were repointed. (1) The albumin figures quoted as AP:33822 are at AP:33820-33821; line 33822 is the sentence about globulins. (2) The electrolyte text quoted as AP:33835 is at AP:33836-33837; line 33835 is the heading 'Other Plasma Solutes'. (3) The organic nutrients text quoted as AP:33836 is at AP:33838. Two further citations were single-line for two-line quotations (AP:33804-33805 and AP:33832-33833). Numeric ranges were moved outside the quotation marks because the source prints them with dash characters, which the notation rule bars. The explanation clause 'defined by the textbook as' was replaced, and the choice D reasoning was sharpened from 'that loss is small' to a stated magnitude.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because the untreated tube is allowed to coagulate, and the protein that is polymerized and trapped in the resulting mesh is removed from the fluid that is later assayed. Blood collected without an anticoagulant runs the coagulation cascade, which converts a soluble plasma protein into insoluble fibrin strands that become part of the packed mass at the bottom of the tube. The supernatant recovered from such a tube is serum, which is plasma from which the clotting factors have been removed. Fibrinogen normally accounts for about \(7\%\) of total plasma protein at \(0.2\) to \(0.45\ \text{g/dL}\), and essentially all of it is consumed during clot formation. (Choice A) Sodium is a small electrolyte that is neither a substrate nor a product of coagulation, so it stays dissolved in the fluid phase. Its concentration in the fluid from tube 2 matches that in tube 1. (Choice B) Albumin is the most abundant plasma protein at roughly \(54\%\) of total protein and \(3.5\) to \(5.0\ \text{g/dL}\), which makes it tempting whenever a protein is expected to change. It is not built into fibrin, however, so its concentration is essentially the same in both tubes. (Choice C) Coagulation in the additive free tube converts fibrinogen into fibrin, which is retained in the clot rather than in the supernatant. The assayed fluid is therefore serum, and its fibrinogen concentration is near zero against the anticoagulated sample from tube 1. (Choice D) Glucose is a nonprotein solute that is not removed by clot formation. Cells in an unseparated tube consume glucose slowly, but over \(30\) minutes that loss is a few percent at most and would not produce a marked difference. This is a Reasoning about the Design and Execution of Research question because you must predict how a specimen handling choice alters the analyte a measurement actually captures.

---

## B3-Q20 — Interpreting an Elevated Hematocrit

**Stem.** Two patients each have a hematocrit of \(54\%\). Patient A has been vomiting for \(3\) days and has lost \(4\ \text{kg}\) of body weight, while patient B has a stable weight and a marrow disorder that overproduces erythrocytes. Which of the following findings would be expected in patient A but NOT in patient B?

I. A total circulating erythrocyte volume that lies within the reference range
II. A plasma total protein concentration above the reference range
III. An immediate fall in hematocrit after infusion of \(2\ \text{L}\) of isotonic saline

- **A.** I only
- **B.** I and II only  <- **KEY**
- **C.** II and III only
- **D.** I, II, and III

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic hard / structural hard) |
| Estimated time | 110 s |
| Confidence | 5 |
| Hard-tier gate | Meets three of the four conditions. (1) CONCEPT CHAINING: the solver must link hematocrit as a ratio, to which term of that ratio moved in each patient, to the effect of a contracted plasma compartment on dissolved protein concentration, to the effect of volume expansion on the same ratio. (3) TRUE PARTIAL-TRUTH TRAP: statement III is entirely true of patient A and is the intuitive test for hemoconcentration, yet it is equally true of patient B and so fails the 'but NOT in patient B' requirement. (4) 510-TEMPTING DISTRACTOR: choice D is selected by anyone who checks each statement against patient A alone without testing it against patient B. |

**Correct answer (B): I and II only**

Citations: AP:33734 'One such test, called a hematocrit, measures the percentage of RBCs, clinically known as erythrocytes, in a blood sample.' | AP:34333-34335 'In contrast to anemia, an elevated RBC count is called polycythemia and is detected in a patient's elevated hematocrit. It can occur transiently in a person who is dehydrated; when water intake is inadequate or water losses are excessive, the plasma volume falls. As a result, the hematocrit rises.' | AP:34337-34338 'a type of bone marrow disease called polycythemia vera' ... 'causes an excessive production of immature erythrocytes.' | AP:33752-33753 'In normal blood, about 45 percent of a sample is erythrocytes.' | AP:33757 'So the mean plasma percentage is the percent of blood that is not erythrocytes' | AP:33809 'About 7 percent of the volume of plasma' ... 'is made of proteins' (the ellipsis skips a clause the source sets off with dash punctuation)

**Distractors**

- **(A)** `partial_truth` . _incomplete correct set_ — Statement I is correctly excluded for patient B, but statement II is equally specific to patient A because loss of plasma water concentrates the proteins dissolved in it.
  - Citation: AP:34333-34335 'It can occur transiently in a person who is dehydrated; when water intake is inadequate or water losses are excessive, the plasma volume falls. As a result, the hematocrit rises.'
- **(C)** `process_step_confusion` . _shared response mistaken for a discriminator_ — Statement III occurs in both patients because isotonic volume expansion enlarges the denominator of the ratio whatever the cause, and this option also discards the valid statement I.
  - Citation: AP:33757 'So the mean plasma percentage is the percent of blood that is not erythrocytes'
- **(D)** `misconception` . _all statements true of one patient assumed exclusive_ — Every statement is true of patient A, but the item demands findings absent in patient B, and dilution after a saline load lowers the erythrocyte fraction in patient B as well.
  - Citation: AP:34337-34338 'a type of bone marrow disease called polycythemia vera' ... 'causes an excessive production of immature erythrocytes.'

**Readback check.** The key is a combination label and carries no content words, so no echo is possible. Within the items, erythrocyte and hematocrit appear in the stem but are shared referents required by all three statements and by every option. The stem gives the two clinical situations and the identical measured value but states no consequence for erythrocyte mass, protein concentration, or the response to fluid loading. AUDIT NOTE ON WHAT CHANGED: (1) NUMBERS: the shared hematocrit was lowered from \(58\%\) to \(54\%\). With erythrocyte volume fixed, moving a female baseline near \(41\%\) to \(58\%\) requires a fall in plasma volume of roughly \(1.4\ \text{L}\), which a \(4\ \text{kg}\) loss cannot deliver; \(54\%\) requires about \(1.0\ \text{L}\), which matches a \(4\ \text{kg}\) loss distributed across the extracellular compartment. (2) EXPLANATION ERROR: the draft choice A block read 'Statement I is correctly identified as unique to patient A, since only he has an expanded erythrocyte mass,' which attaches the expanded mass to the wrong patient and uses a pronoun for a patient whose sex is never given. The block was rewritten and all invented pronouns were removed throughout. (3) Stem grammar was repaired ('patient B has a marrow disorder ... and whose weight is stable'). (4) CITATIONS: AP:33808 was misnumbered, the plasma protein sentence being at AP:33809, and the draft quoted it in a form the source sets off with dash punctuation; AP:34334 and AP:34338 and AP:33753 were single-line citations for multi-line quotations. All corrected.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because the two patients reach the same ratio by opposite routes, and only the findings that track a shrunken liquid compartment separate them. Hematocrit is packed erythrocyte volume divided by whole blood volume, so it rises either when the numerator grows or when the denominator shrinks. Patient A has lost fluid, so erythrocyte mass is unchanged while the plasma compartment has contracted, which also concentrates everything dissolved in that plasma. Patient B has generated extra erythrocytes with a normal plasma compartment, so erythrocyte mass is high while dissolved protein is normal. Statement III fails as a discriminator because expanding the plasma compartment dilutes erythrocytes in anyone, whatever raised the ratio in the first place. (Choice A) Statement I does discriminate, since only patient B carries an expanded erythrocyte mass. Stopping there overlooks statement II, which follows directly from the loss of plasma water and is equally specific to patient A. (Choice B) Statement I holds only for patient A, whose erythrocyte number never changed, whereas patient B has a genuinely enlarged erythrocyte mass. Statement II also holds only for patient A, because removing water from plasma concentrates the proteins dissolved in it, while patient B's plasma and its proteins are normal. Statement III is true of both patients, so it is excluded. (Choice C) Statement II is correctly recognized, but statement III describes a response shared by both patients, since adding isotonic fluid to the circulation dilutes erythrocytes whatever the cause of the high ratio. This option also discards statement I, one of the two genuine discriminators. (Choice D) This option treats the response to volume expansion as diagnostic, but a saline load lowers the erythrocyte fraction in patient B as well by enlarging the denominator of the ratio. A finding shared by both patients cannot distinguish between them. This is a Scientific Reasoning and Problem Solving question because you must decide which of several true findings actually discriminate between two mechanisms that produce an identical measured value.

---

## B3-Q21 — Anucleate Erythrocyte Lifespan

**Stem.** Spectrin, a cytoskeletal protein that lets an erythrocyte fold as it squeezes through a capillary, becomes progressively oxidized as the cell ages. Over its remaining weeks in the bloodstream, this mature erythrocyte most likely:

- **A.** replaces the protein by translating it on ribosomes retained from the reticulocyte stage.
- **B.** carries the altered protein until splenic macrophages engulf the whole cell.  <- **KEY**
- **C.** refolds the protein using chaperones driven by ATP from its own mitochondria.
- **D.** ruptures within a vessel so that the kidneys clear its freed globin chains.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic easy / structural medium) |
| Estimated time | 70 s |
| Confidence | 5 |

**Correct answer (B): carries the altered protein until splenic macrophages engulf the whole cell.**

Citations: AP:34079 "As an erythrocyte matures in the red bone marrow, it extrudes its nucleus and most of its other organelles. During the first day or two that it is in the circulation, an immature erythrocyte, known as a reticulocyte, will still typically contain remnants of organelles." | AP:34084 "mature, circulating erythrocytes have few internal cellular structural components. Lacking mitochondria, for example, they rely on anaerobic respiration." | AP:34086 "They also lack endoplasmic reticula and do not synthesize proteins." | AP:34088 "This includes the protein spectrin, a cytoskeletal protein element." | AP:34210 "Erythrocytes live up to 120 days in the circulation, after which the worn-out cells are removed by a type of myeloid phagocytic cell called a macrophage, located primarily within the bone marrow, liver, and spleen." | AP:34215 "Hemoglobin that is not phagocytized is broken down in the circulation, releasing alpha and beta chains that are removed from circulation by the kidneys." | AP:5025 "Without nuclei, the life span of RBCs is short, and so the body must produce new ones constantly."

**Distractors**

- **(A)** `adjacent_fact` . _true-of-an-earlier-stage_ — Ribosomal remnants exist only in the reticulocyte, for roughly the first day or two in the circulation, and are shed long before the cell ages.
  - Citation: AP:34079 "During the first day or two that it is in the circulation, an immature erythrocyte, known as a reticulocyte, will still typically contain remnants of organelles."
- **(C)** `adjacent_fact` . _assumes-standard-cell-metabolism_ — Mature erythrocytes lack mitochondria and depend on anaerobic respiration, so no oxidative phosphorylation is available to power refolding.
  - Citation: AP:34084 "Lacking mitochondria, for example, they rely on anaerobic respiration."
- **(D)** `partial_truth` . _minor-route-as-main-route_ — Hemoglobin that escapes phagocytosis is degraded in the circulation and cleared renally, but that is the minor route; worn-out cells are normally removed intact by macrophages.
  - Citation: AP:34215 "Hemoglobin that is not phagocytized is broken down in the circulation, releasing alpha and beta chains that are removed from circulation by the kidneys."

**Readback check.** Content words of key B: carries, altered, protein, splenic, macrophages, engulf, whole, cell. Stem words: spectrin, cytoskeletal, protein, erythrocyte, fold, squeezes, capillary, oxidized, ages, weeks, bloodstream, mature. Overlap is limited to 'protein' and the generic cell referent, both equally required by the other options. Neither 'macrophage' nor 'spleen' nor any statement of the anucleate condition appears in the stem, so the key is not restated or self-justifying. | AUDIT CHANGES: (1) OPTION-SET STRUCTURAL TELL FIXED. The original set was three repair mechanisms plus one removal option, so the key could be picked by the odd-one-out heuristic without topic knowledge. The nucleus/mRNA option was replaced with a second removal option (D, intravascular rupture with renal clearance of globin chains), which is textbook-real (AP:34215) but is the minor route, giving a two-repair versus two-removal split and a genuine partial-truth trap. (2) CITATION MISNUMBERED: 'AP:5023' does not contain the quoted sentence; line 5023 reads 'Other cells, such as mammalian red blood cells (RBCs), do not contain nuclei at all.' The quoted text begins at line 5025, now corrected. (3) CITATION OFF BY ONE: 'AP:34089' for 'This includes the protein spectrin...' corrected to AP:34088, where the sentence begins; 'AP:34080' for 'During the first day or two...' corrected to AP:34079, where that sentence begins. (4) Key B trimmed to the shortest option (11 words) so it cannot be selected as the most complete choice. (5) Structural axis raised from easy to medium to reflect the new partial-truth trap; topic axis and overall difficulty remain easy because the key is reachable from the single most basic fact in the unit.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because a mature erythrocyte has no ribosomes, no endoplasmic reticulum, and no nucleus, so a damaged structural protein cannot be replaced and the worn cell is eventually phagocytized whole. As an erythrocyte matures in the red bone marrow it extrudes its nucleus and most of its other organelles, and the ribosomal remnants that mark a reticulocyte are quickly shed during the first day or two in the circulation. From that point the cell cannot transcribe or translate anything, so oxidative damage to spectrin simply accumulates and the cell grows stiffer and less deformable. Erythrocytes live up to \(120\) days in the circulation, after which macrophages located primarily within the bone marrow, liver, and spleen remove the worn cell in its entirety and recycle its components.
>
> (Choice A) Reticulocytes do retain networks of ribosomes, the feature that gives them their name, but only during roughly the first day or two after release. Those remnants are shed long before the cell is weeks old. A cell partway through its lifespan therefore has no translational machinery at all.
>
> (Choice B) With no way to make a replacement, the cell carries the oxidized spectrin for the rest of its time in the vasculature, and the accumulating damage is what eventually marks it as worn out. Macrophages of the spleen, along with those of the liver and bone marrow, then engulf the whole cell. Its globin, iron, and the non-iron portion of heme are recycled or excreted rather than repaired in place.
>
> (Choice C) Mature erythrocytes lack mitochondria and rely on anaerobic respiration, which is useful because it keeps them from consuming the oxygen they are transporting. No oxidative phosphorylation occurs in these cells. Chaperone-driven refolding would in any case not reverse a covalent oxidative modification.
>
> (Choice D) Hemoglobin that escapes phagocytosis is broken down in the circulation, and the released alpha and beta chains are cleared by the kidneys, so this route is real. It is not the usual fate of an aged erythrocyte, which is removed intact by macrophages of the bone marrow, liver, and spleen. Intravascular rupture is the minor pathway rather than the expected one.
>
> This is a Knowledge of Scientific Concepts and Principles question because you must recall which organelles a mature erythrocyte lacks and how worn cells are normally cleared.

---

## B3-Q22 — Reticulocyte Count And Marrow Response

**Stem.** Two adults each have a hematocrit of \(28\%\) against a reference value near \(45\%\), but reticulocytes make up \(0.2\%\) of circulating erythrocytes in patient 1 and \(8\%\) in patient 2. Which conclusion do these values best support?

- **A.** Patient 1's marrow is responding vigorously, so patient 1's deficit arises after cells enter the blood.
- **B.** Patient 2's marrow is responding vigorously, so patient 2's deficit arises after cells enter the blood.  <- **KEY**
- **C.** Patient 2's marrow is responding vigorously, so patient 2's deficit arises within the marrow itself.
- **D.** Neither marrow is responding, so both deficits arise within the marrow itself.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 85 s |
| Confidence | 5 |

**Correct answer (B): Patient 2's marrow is responding vigorously, so patient 2's deficit arises after cells enter the blood.**

Citations: AP:34081 "Reticulocytes should comprise approximately 1-2 percent of the erythrocyte count and provide a rough estimate of the rate of RBC production, with abnormally low or high rates indicating deviations in the production of these cells." | AP:34079 "During the first day or two that it is in the circulation, an immature erythrocyte, known as a reticulocyte, will still typically contain remnants of organelles." | AP:33753 "normal blood, about 45 percent of a sample is erythrocytes. The hematocrit of any one sample can vary significantly, however, about 36-50 percent, according to gender and other factors." | AP:34260 "...can be broken down into three major groups: those caused by blood loss, those caused by faulty or decreased RBC production, and those caused by excessive destruction of RBCs." | AP:34266 "Reticulocyte counts are also important and may reveal inadequate production of RBCs."

**Distractors**

- **(A)** `reversed_relationship` . _patient-swap_ — It assigns vigorous output to the patient whose reticulocyte fraction is far below the reference range, inverting the data.
  - Citation: AP:34266 "Reticulocyte counts are also important and may reveal inadequate production of RBCs."
- **(C)** `partial_truth` . _right-premise-wrong-conclusion_ — It reads the elevated output correctly but then locates the lesion in the marrow, which an elevated output rules out.
  - Citation: AP:34260 "...can be broken down into three major groups: those caused by blood loss, those caused by faulty or decreased RBC production, and those caused by excessive destruction of RBCs."
- **(D)** `misconception` . _reference-range-blindness_ — It anchors on the low hematocrit and treats \(8\%\) as unremarkable, ignoring the reference fraction of \(1\%\) to \(2\%\) that makes patient 2's marrow hyperactive.
  - Citation: AP:34081 "Reticulocytes should comprise approximately 1-2 percent of the erythrocyte count."

**Readback check.** Content words of key B: patient 2, marrow, responding, vigorously, deficit, arises, after, cells, enter, blood. The stem supplies only numbers (hematocrit \(28\%\) against \(45\%\), reticulocytes \(0.2\%\) and \(8\%\)) and the patient labels. 'Marrow', 'responding', 'production', and 'destruction' appear nowhere in the stem, so the interpretive step is not stated for the examinee. Options A, B, and C are word-for-word identical except for the patient number and the site clause, so the key cannot be picked by phrase matching or by length. | AUDIT CHANGES: (1) DISTRACTOR D REPLACED. The original D ('the two values differ only because patient 2's cells are larger') was eliminable without topic knowledge because of the absolutist 'only' and its internal inconsistency, and it imported mean corpuscular volume, an off-axis index. New D ('Neither marrow is responding, so both deficits arise within the marrow itself') is a real misread that requires knowing the \(1\%\) to \(2\%\) reference range to reject. (2) OPTION A rewritten as an exact patient-swap of the key so that all conclusions share one template, restoring the single-variable rule. (3) LENGTH TELL FIXED: the original key was the longest option; A and B are now word-for-word equal in length. (4) CITATION OFF BY ONE: 'AP:34080' corrected to AP:34079 for the sentence beginning 'During the first day or two'. (5) CITATION QUOTE CORRECTED: line 34260 begins mid-sentence ('can be broken down into three major groups') because a page-break artifact splits the sentence from 'Anemia' on line 34255; the quote is now shown with a leading ellipsis rather than presented as a whole verbatim sentence on 34260. (6) Added AP:33753 to source the \(45\%\) hematocrit reference value used in the stem. Numeric check: even after correcting for the low denominator (\(28/45 = 0.62\)), patient 2's fraction is about \(5\%\) and patient 1's about \(0.1\%\), so the intended discrimination is robust.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because a reticulocyte fraction several times the normal \(1\%\) to \(2\%\) shows that patient 2's marrow is already delivering replacements at an accelerated rate, which places the cause of the low hematocrit downstream of the marrow. A reticulocyte is a newly released erythrocyte that still carries ribosomal remnants during its first day or two in the blood, so the proportion of circulating cells at that stage gives a rough estimate of the rate of erythrocyte production. Patient 1 has a large deficit with a fraction only a fifth of the lower end of the reference range, the pattern expected when production itself has failed. Patient 2 has the same deficit with output several times normal, so replacement is not the limiting step, and cells must be lost or destroyed once they are already in the circulation, as in hemorrhage or accelerated clearance by macrophages.
>
> (Choice A) This assigns the elevated output to the wrong patient. A value of \(0.2\%\) sits well below the reference fraction, so patient 1's marrow has not raised production at all despite a severe deficit. Patient 1's problem therefore lies in production rather than downstream of it.
>
> (Choice B) A fraction of \(8\%\) is several times the reference value, so patient 2's marrow is compensating rather than failing. The deficit must then arise after the cells are released, from bleeding or from accelerated destruction. Anemias are conventionally sorted into exactly these categories of blood loss, decreased production, and excessive destruction.
>
> (Choice C) The first clause reads patient 2's value correctly, but the conclusion contradicts it. A marrow that has raised its output several fold is by definition not the site of the failure. A marrow lesion predicts a low reticulocyte fraction, which is what patient 1 shows instead.
>
> (Choice D) This holds for patient 1 alone. Treating \(8\%\) as unremarkable ignores the reference fraction of \(1\%\) to \(2\%\), which is the only way to see that patient 2's marrow is hyperactive. The two patients arrive at the same hematocrit for opposite reasons.
>
> This is a Data-based and Statistical Reasoning question because you must compare two laboratory values against reference ranges and infer where in the erythrocyte lifecycle each patient's defect lies.

---

## B3-Q23 — Iron Recycling And Heme Breakdown

**Stem.** In a patient with a chronic hemolytic disorder, splenic and hepatic macrophages phagocytize erythrocytes at roughly three times the usual rate. Dietary iron intake is unchanged, the hematocrit stays near normal, and liver and kidney function are normal. Which of the following are expected consequences?

I. Plasma bilirubin bound to albumin rises.
II. Whole-body iron stores fall as heme iron is excreted in the bile.
III. Transferrin delivers a larger quantity of iron to the red bone marrow.

- **A.** I only
- **B.** I and III only  <- **KEY**
- **C.** II and III only
- **D.** I, II, and III

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 95 s |
| Confidence | 5 |

**Correct answer (B): I and III only**

Citations: AP:34210 "Erythrocytes live up to 120 days in the circulation, after which the worn-out cells are removed by a type of myeloid phagocytic cell called a macrophage, located primarily within the bone marrow, liver, and spleen." | AP:34214 "Globin, the protein portion of hemoglobin, is broken down into amino acids, which can be sent back to the bone marrow to be used in the production of new erythrocytes." | AP:34217 "The iron contained in the heme portion of hemoglobin may be stored in the liver or spleen, primarily in the form of ferritin or hemosiderin, or carried through the bloodstream by transferrin to the red bone marrow for recycling into new erythrocytes." | AP:34220 "The non-iron portion of heme is degraded into the waste product biliverdin, a green pigment, and then into another waste product, bilirubin, a yellow pigment. Bilirubin binds to albumin and travels in the blood to the liver, which uses it in the manufacture of bile." | AP:34194 "The bone marrow, liver, and spleen can store iron in the protein compounds ferritin and hemosiderin."

**Distractors**

- **(A)** `partial_truth` . _incomplete-set_ — It correctly accepts the bilirubin consequence but omits the increased transferrin-bound iron traffic toward the marrow.
  - Citation: AP:34218 "or carried through the bloodstream by transferrin to the red bone marrow for recycling into new erythrocytes."
- **(C)** `misconception` . _metal-and-pigment-conflation_ — It accepts item II, treating heme iron as excreted in bile, when only the non-iron portion of heme becomes bilirubin and enters bile.
  - Citation: AP:34220 "The non-iron portion of heme is degraded into the waste product biliverdin, a green pigment, and then into another waste product, bilirubin, a yellow pigment."
- **(D)** `partial_truth` . _accept-all_ — Two of the three items are genuinely expected, but item II contradicts the conservation of iron during erythrocyte recycling.
  - Citation: AP:34217 "The iron contained in the heme portion of hemoglobin may be stored in the liver or spleen, primarily in the form of ferritin or hemosiderin."

**Readback check.** Content words of the keyed combination (items I and III): bilirubin, albumin, transferrin, iron, red bone marrow. The stem supplies only the clearance rate, the clearing organs, the unchanged dietary iron, the stable hematocrit, and normal liver and kidney function. None of bilirubin, albumin, transferrin, ferritin, or marrow appears in the stem, so no item can be validated by echo. Item II is a real and commonly held claim about iron balance rather than an absurd option, so the set cannot be resolved without knowing the separate fates of globin, the iron, and the non-iron remnant of heme. | AUDIT CHANGES: (1) FACTUALLY UNSUPPORTED EXPLANATION CLAUSE REMOVED. The original Choice C block asserted that 'iron overload accompanies chronically increased erythrocyte turnover rather than iron depletion,' a clinical claim that is driven mainly by transfusion and increased absorption and is nowhere in the source text. It is replaced with the textbook-anchored statement that bile carries the pigment while the iron re-enters the body pool. (2) ITEM III MADE UNAMBIGUOUS. The original stem never established that erythropoiesis was elevated, so a careful examinee could argue the salvaged iron was merely being stored rather than delivered. The stem now states that the hematocrit stays near normal, which is data rather than a conclusion and forces production to match the tripled destruction. (3) ITEM I REASONING TIGHTENED with the flux argument (hepatic uptake scales with plasma concentration), since the stem stipulates normal liver function and the original explanation asserted the rise without justifying it. (4) SPELLING NORMALIZED: 'haem' changed to 'heme' throughout, matching the source text and United States usage. (5) FABRICATED-STYLE CITATION REMOVED: 'AP:35333' was quoted as a contiguous verbatim sentence, but that region is a two-column chapter summary whose text interleaves with the blood-typing column, so the quoted string is stitched from lines 35333, 35334, and 35336 and is not contiguous on any line. It is dropped in favor of the clean AP:34217 and AP:34220. (6) CITATION OFF BY ONE: distractor A's transferrin fragment corrected from AP:34217 to AP:34218, where that clause begins.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because accelerated phagocytosis raises both the pigment waste stream and the recycled iron stream, while the iron itself is conserved rather than excreted. When a macrophage degrades an engulfed erythrocyte, hemoglobin is dismantled along three routes: globin is broken down into amino acids that can be sent back to the marrow, the iron of the heme portion is stored as ferritin or hemosiderin in the liver or spleen or carried on transferrin to the red bone marrow, and the non-iron portion of heme becomes biliverdin and then bilirubin. Bilirubin binds albumin and travels in the blood to the liver, and because hepatic uptake scales with the plasma concentration, tripling the rate of delivery raises the steady state plasma level, so item I holds. A hematocrit held near normal against tripled destruction means the marrow is producing at roughly triple the usual rate, so salvaged iron is being drawn toward erythrocyte precursors and item III holds as well. Item II fails because it is the pigment, not the metal, that leaves the body in the bile.
>
> (Choice A) This accepts the bilirubin consequence but omits the iron traffic. Iron released by macrophage digestion does not sit still; it is either stored as ferritin and hemosiderin or mobilized on transferrin to the red bone marrow. With production tripled to hold the hematocrit steady, more of that iron moves toward the marrow, so item III is also expected.
>
> (Choice B) Item I follows because the non-iron portion of heme becomes biliverdin and then bilirubin, which binds albumin in the plasma at a level set by the rate of delivery. Item III follows from the recycling route, in which transferrin carries salvaged iron to the red bone marrow for building new erythrocytes. Item II is the only false statement, so items I and III alone are expected.
>
> (Choice C) This accepts the claim that heme iron is excreted in the bile. Bile carries bilirubin, the pigment derived from the non-iron portion of heme, while the iron re-enters the body pool in the liver, spleen, and bone marrow. Item I is also expected and should not have been dropped.
>
> (Choice D) Items I and III are correct, but item II treats the metal and the pigment as sharing one excretory path. Only the non-iron remnant of heme becomes bilirubin and enters the bile. The iron is retained and recycled, so whole body stores are not drained by macrophage clearance.
>
> This is a Knowledge of Scientific Concepts and Principles question because you must recall the separate fates of globin, heme iron, and the non-iron portion of heme after macrophages clear aged erythrocytes.

---

## B3-Q24 — Extramedullary Hemopoiesis

**Stem.** An adult with advanced marrow fibrosis has nearly all of the marrow space in the vertebrae, sternum, and pelvis replaced by scar tissue. Over the following months the liver and spleen enlarge substantially. Which explanation for that enlargement is best supported?

- **A.** Splenic and hepatic macrophages have increased their clearance of aged erythrocytes.
- **B.** Iron freed from degraded heme is accumulating as ferritin in both organs.
- **C.** Mature erythrocytes are being retained in both organs instead of circulating.
- **D.** Both organs have resumed producing erythrocytes and other formed elements.  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 85 s |
| Confidence | 5 |

**Correct answer (D): Both organs have resumed producing erythrocytes and other formed elements.**

Citations: AP:33898 "Prior to birth, hemopoiesis occurs in a number of tissues, beginning with the yolk sac of the developing embryo, and continuing in the fetal liver, spleen, lymphatic tissue, and eventually the red bone marrow." | AP:33899 "Following birth, most hemopoiesis occurs in the red marrow, a connective tissue within the spaces of spongy (cancellous) bone tissue." | AP:33901 "in adults, the process is largely restricted to the cranial and pelvic bones, the vertebrae, the sternum, and the proximal epiphyses of the femur and humerus." | AP:33904 "Throughout adulthood, the liver and spleen maintain their ability to generate the formed elements. This process is referred to as extramedullary hemopoiesis (meaning hemopoiesis outside the medullary cavity of adult bones)." | AP:33906 "When a disease such as bone cancer destroys the bone marrow, causing hemopoiesis to fail, extramedullary hemopoiesis may be initiated." | AP:34064 "Erythrocytes remain within the vascular network. Although leukocytes typically leave the blood vessels to perform their defensive functions, movement of erythrocytes from the blood vessels is abnormal." | AP:34194 "The bone marrow, liver, and spleen can store iron in the protein compounds ferritin and hemosiderin." | AP:34562 "After entering the circulation, approximately one-third migrate to the spleen for storage for later release in response to any rupture in a blood vessel."

**Distractors**

- **(A)** `process_step_confusion` . _destruction-for-production_ — It attributes the organ growth to the destruction limb of the erythrocyte lifecycle when the described lesion is on the production limb.
  - Citation: AP:34210 "the worn-out cells are removed by a type of myeloid phagocytic cell called a macrophage, located primarily within the bone marrow, liver, and spleen."
- **(B)** `adjacent_fact` . _true-fact-wrong-driver_ — Iron storage as ferritin in liver and spleen is real but is filled by erythrocyte turnover, which marrow fibrosis does not increase.
  - Citation: AP:34194 "The bone marrow, liver, and spleen can store iron in the protein compounds ferritin and hemosiderin."
- **(C)** `misconception` . _wrong-formed-element_ — Erythrocytes remain within the vascular network; it is platelets of which about one third are stored in the spleen for later release.
  - Citation: AP:34562 "After entering the circulation, approximately one-third migrate to the spleen for storage for later release in response to any rupture in a blood vessel."

**Readback check.** Content words of key D: organs, resumed, producing, erythrocytes, other, formed elements. Stem words: adult, marrow, fibrosis, vertebrae, sternum, pelvis, scar tissue, liver, spleen, enlarge, months. The only overlap is the liver and spleen referent, which every option requires equally, and 'erythrocytes' does not appear in the stem. Neither 'hemopoiesis', 'production', 'fetal', nor 'extramedullary' appears in the stem, and choices A, B, and C each name a genuine liver or spleen function tied to erythrocytes. | AUDIT CHANGES: (1) SELF-JUSTIFYING KEY TRIMMED. The original key read 'Both organs have resumed forming blood cells, a role they filled before birth,' whose trailing clause supplied its own justification and made the key the most complete option. The key is now a bare process statement matching the other three and is the shortest option at 10 words. (2) OPTIONS MADE PARALLEL: each is now a single process occurring in the liver and spleen, restoring the single-variable rule. (3) SPELLING NORMALIZED: 'haem' changed to 'heme' in option B and the explanation. (4) CITATION OFF BY ONE: 'AP:33900' corrected to AP:33899 for the sentence beginning 'Following birth, most hemopoiesis'; the adult-site clause is now cited separately and accurately as AP:33901. (5) Choice C block softened so it no longer implies erythrocytes are never present in splenic tissue; the claim is now that no withheld reserve of mature erythrocytes exists, with the one-third platelet reserve as the contrast. (6) SCOPE CHECKED: AAMC outline lines 1840 to 1841 place 'Erythrocyte production and destruction; spleen, bone marrow' squarely in this unit, and the item touches no reserved chapter.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because the liver and spleen retain throughout adulthood the ability to generate the formed elements, and they take that role back up when the marrow can no longer fill it. Before birth, blood cell formation begins in the yolk sac and continues in the fetal liver, spleen, and lymphatic tissue before shifting to the red bone marrow, and after birth the process is largely restricted to the cranial and pelvic bones, the vertebrae, the sternum, and the proximal epiphyses of the femur and humerus. Because the liver and spleen never lose the capacity, destruction of the marrow, whether by a disease such as bone cancer or by the fibrosis described here, can initiate blood cell formation outside the medullary cavity. The expanding population of precursor cells within those organs is what accounts for their progressive enlargement over months.
>
> (Choice A) Macrophages of the spleen and liver do clear worn erythrocytes, and states of accelerated clearance can enlarge the spleen. Nothing described here shortens erythrocyte survival, however. The lesion is a failure of production rather than a rise in destruction.
>
> (Choice B) Both organs do store iron as ferritin and hemosiderin, so the premise is real. That store is filled by erythrocyte turnover, which marrow scarring does not increase, and a static iron pool would not drive months of progressive growth. Nothing in the scenario gives iron deposition a reason to expand.
>
> (Choice C) Erythrocytes remain within the vascular network, and no reserve of mature erythrocytes is held back from the circulation in the way described. It is platelets, roughly one third of which migrate to the spleen for storage and later release. A withheld reserve would also be finite and would not explain growth continuing for months.
>
> (Choice D) The liver and spleen carried out blood cell formation during fetal life and keep that ability throughout adulthood. Loss of the marrow removes the normal site of production, and formation restarts outside the medullary cavity. Growth of that reactivated blood-forming tissue enlarges both organs.
>
> This is a Scientific Reasoning and Problem Solving question because you must connect the developmental history of blood cell formation sites to an organ finding in an adult whose marrow has failed.

---

## B3-Q25 — Erythrocyte Turnover And Survival Time

**Stem.** In a healthy adult, circulating erythrocytes survive about \(120\) days, and each newly released cell is counted as a reticulocyte for roughly its first day in the blood, giving a reticulocyte fraction near \(1\%\). A patient's erythrocyte survival is shortened to \(40\) days, yet the total circulating erythrocyte count remains normal and steady. The reticulocyte fraction in this patient is most likely closest to:

- **A.** \(0.3\%\)
- **B.** \(1\%\)
- **C.** \(3\%\)  <- **KEY**
- **D.** \(5\%\)

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic medium / structural hard) |
| Estimated time | 115 s |
| Confidence | 5 |
| Hard-tier gate | CONCEPT CHAINING: the examinee must chain steady state (production equals destruction) to daily output equals pool divided by lifespan, then to reticulocyte fraction equals transit time divided by lifespan, then substitute the new lifespan. DATA-TO-MECHANISM: the numeric givens \(120\) days, one day, \(1\%\), and \(40\) days must be converted into a turnover model rather than matched to a recalled reference range. 510-TEMPTING DISTRACTOR: choice B is the explicitly stated normal value and is chosen by anyone who treats the reticulocyte fraction as a fixed blood property, and choice D is produced by the textbook-accurate but stem-contradicting assumption of a two-day reticulocyte stage. |

**Correct answer (C): \(3\%\)**

Citations: AP:34210 "Erythrocytes live up to 120 days in the circulation, after which the worn-out cells are removed by a type of myeloid phagocytic cell called a macrophage, located primarily within the bone marrow, liver, and spleen." | AP:34186 "Production of erythrocytes in the marrow occurs at the staggering rate of more than 2 million cells per second." | AP:34079 "During the first day or two that it is in the circulation, an immature erythrocyte, known as a reticulocyte, will still typically contain remnants of organelles." | AP:34081 "Reticulocytes should comprise approximately 1-2 percent of the erythrocyte count and provide a rough estimate of the rate of RBC production, with abnormally low or high rates indicating deviations in the production of these cells."

**Distractors**

- **(A)** `reversed_relationship` . _inverted-proportionality_ — Dividing rather than multiplying by three treats shorter survival as reduced production, which cannot hold a stable erythrocyte count.
  - Citation: AP:34210 "Erythrocytes live up to 120 days in the circulation, after which the worn-out cells are removed by a type of myeloid phagocytic cell called a macrophage."
- **(B)** `misconception` . _reference-range-anchor_ — It treats the reticulocyte fraction as a fixed constant of blood instead of a ratio of daily marrow output to pool size.
  - Citation: AP:34081 "Reticulocytes should comprise approximately 1-2 percent of the erythrocyte count and provide a rough estimate of the rate of RBC production."
- **(D)** `scale_unit_error` . _wrong-transit-time_ — It applies a two-day reticulocyte transit, doubling the computed fraction, despite the stem stipulating one day.
  - Citation: AP:34079 "During the first day or two that it is in the circulation, an immature erythrocyte, known as a reticulocyte, will still typically contain remnants of organelles."

**Readback check.** The keyed option is the bare quantity \(3\%\) and contains no content words at all, so stem echo is structurally impossible. The stem supplies model inputs (survival time, reticulocyte transit time, the normal fraction, and the fact that the pool is stable) but never states the relationship between survival time and output, which is the reasoning the examinee must supply. All four values lie in a plausible clinical range and each is reachable by a specific defensible manipulation of the givens. | AUDIT CHANGES: (1) ARITHMETIC RE-VERIFIED. Fraction equals transit divided by lifespan: \(1/120 = 0.83\%\), consistent with the stem's 'near \(1\%\)'; \(1/40 = 2.5\%\), whose distance to \(3\%\) is \(0.5\) versus \(1.5\) to \(1\%\) and \(2.5\) to \(5\%\), so the key is unambiguous. Distractor derivations also check out: \(1/3\) of \(1\%\) is about \(0.3\%\), and \(2/40\) is \(5\%\). (2) CITATION OFF BY ONE: 'AP:34080' corrected to AP:34079 in both the citations string and distractor D, since the quoted sentence begins on 34079. (3) Distractor A's citation quote extended to the full source sentence instead of a truncated clause closed with an added period. (4) British spelling 'labelled' changed to 'labeled' in the Choice C block, which was also reworded to avoid the word entirely. (5) HARD GATE RE-CHECKED and upheld: concept chaining, data-to-mechanism, and a genuinely tempting distractor pair (B as the stated normal, D as the textbook 'day or two') give three of the four conditions.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because a steady pool size forces daily production to equal daily destruction, so a survival time cut to one third must be matched by roughly three times the daily output. If the pool holds \(N\) cells and each survives \(L\) days, then at steady state the marrow must release \(N/L\) cells per day. Because a cell is counted as a reticulocyte for its first day only, the reticulocyte fraction equals \((N/L \times 1\ \text{day})/N = 1/L\), which reproduces the normal value of \(1/120\), or about \(0.8\%\), rounded to \(1\%\) in the stem. Substituting \(L = 40\ \text{days}\) gives \(1/40 = 2.5\%\), and among the choices \(3\%\) is nearest. The elevated fraction is the visible sign that marrow output has risen to defend a normal erythrocyte count against faster removal.
>
> (Choice A) This is the normal value divided by three, which follows from treating shortened survival as evidence of reduced output. Steady state requires the opposite relationship, since a stable count with faster loss can only be maintained by faster replacement. A falling output would be accompanied by a falling erythrocyte count, which the stem excludes.
>
> (Choice B) This assumes the reticulocyte fraction is a fixed property of blood rather than a ratio that tracks turnover. The fraction is daily output divided by pool size, so it must change whenever survival time changes. Holding it at the reference value ignores the stated three-fold shortening.
>
> (Choice C) With the pool stable, daily replacement equals \(1/40\) of the pool, or \(2.5\%\) per day. Each of those cells spends its first day at the reticulocyte stage, so about \(2.5\%\) of circulating erythrocytes are reticulocytes at any moment. Of the values offered, \(3\%\) is the closest.
>
> (Choice D) This value follows from allowing a two-day reticulocyte stage, giving \(2/40\). Reticulocytes can indeed carry organelle remnants for the first day or two in the circulation, but the stem stipulates a one-day interval. Doubling the transit time doubles the computed fraction without justification.
>
> This is a Scientific Reasoning and Problem Solving question because you must build a steady-state turnover relationship from the given survival and transit times and apply it to a shortened lifespan.

---



---

# BATCH 4 of 4 (25 questions): coagulation, oxygen delivery, transfusion, baroreflex

Units: endothelium and vessel architecture . portal systems . pressure, resistance and flow . fluid dynamics (AAMC 4B).

## Batch 2 summary

| Metric | Batch 2 | Full chapter (100) | Target |
|---|---|---|---|
| Difficulty | easy 5 . hard 11 . medium 9 | easy 25 . hard 33 . medium 42 | 27/40/33 |
| Answer letter | A 3 . B 5 . C 5 . D 12 | A 22 . B 25 . C 24 . D 29 | ~25% each |
| Cognitive skill | S2 5 . S3 8 . S4 12 | S1 9 . S2 55 . S3 14 . S4 22 | mixed |
| Confidence | conf4 1 . conf5 24 | conf4 6 . conf5 94 | only 4-5 ship |
| Roman numeral | 2 (8%) | 11 (11%) | 10-15% |
| Distractor categories | adjacent_fact 10 . misconception 17 . partial_truth 22 . process_step_confusion 8 . reversed_relationship 13 . scale_unit_error 5 | | none >40% |

**Deficits cleared from batch 1:** Roman-numeral format now 20% in this batch (10% combined, on target). Skill 3 introduced with 4 experimental-design items (endothelial function in isolated vessel rings, bruit turbulence hypothesis, sphygmomanometry technique, tracer studies). Answer letter D lifted from 20% to 28% combined.

**New deficit for batches 3-4:** answer letter B fell to 12% in this batch (20% combined); bias B upward. Easy tier is 24% combined against a 27% target; add easy items.

**Scope boundaries:** automated scan for the seven forbidden territories returned zero hits. No subtopic is duplicated between batches 1 and 2.

**Adversarial audit:** all 25 re-examined with every citation re-greped against the source file.

---

## B4-Q1 — Immediate Vessel Narrowing After Injury

**Stem.** A researcher punctures a small arteriole in an anesthetized rat and records that visible blood loss slows sharply within \(15\) seconds, whereas a firm gelatinous mass is not present at the wound until roughly \(5\) minutes later. Which event most likely accounts for the reduction in blood loss observed at \(15\) seconds?

- **A.** Cross-linking of insoluble protein strands across the opening in the wall
- **B.** Conversion of a circulating precursor into an active clotting enzyme at the site
- **C.** Contraction of platelet proteins that draw the edges of the opening together
- **D.** Contraction of the smooth muscle in the wall around the opening  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic easy / structural easy) |
| Estimated time | 60 s |
| Confidence | 5 |

**Correct answer (D): Contraction of the smooth muscle in the wall around the opening**

Citations: /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-anatomy-physiology-2e.txt:34616 "There are three steps to the process: vascular spasm, the formation of a platelet plug, and coagulation (blood clotting)." | :34624 "When a vessel is severed or punctured, or when the wall of a vessel is damaged, vascular spasm occurs. In vascular spasm, the smooth muscle in the walls of the vessel contracts dramatically." | :34628 "The vascular spasm response is believed to be triggered by several chemicals called endothelins that are released by vessel-lining cells and by pain receptors in response to vessel injury." | :34630 "This phenomenon typically lasts for up to 30 minutes, although it can last for hours." | :34654 "The result is the production of a gelatinous but robust clot made up of a mesh of fibrin" | :34804 "The stabilized clot is acted upon by contractile proteins within the platelets. As these proteins contract, they pull on the fibrin threads, bringing the edges of the clot more tightly together"

**Distractors**

- **(A)** `process_step_confusion` . _terminal step placed first_ — Stabilization of the mesh by cross-linking occurs only after insoluble strands have been generated, which the data place at about \(5\) minutes.
  - Citation: openstax-anatomy-physiology-2e.txt:34800 "Then, thrombin converts factor I, the soluble fibrinogen, into the insoluble fibrin protein strands. Factor XIII then stabilizes the fibrin clot."
- **(B)** `partial_truth` . _true early event with no mechanical consequence_ — Enzyme activation does begin within seconds, but producing an active enzyme does not narrow the lumen or slow blood loss until strands are actually formed.
  - Citation: openstax-anatomy-physiology-2e.txt:34779 "The events in the extrinsic pathway are completed in a matter of seconds."
- **(C)** `process_step_confusion` . _clot retraction mistimed_ — Platelet contractile proteins act on an already stabilized clot to draw its edges together, an event that follows rather than precedes mesh formation.
  - Citation: openstax-anatomy-physiology-2e.txt:34804 "The stabilized clot is acted upon by contractile proteins within the platelets."

**Readback check.** Content words of key D: contraction, smooth muscle, wall, opening. Stem words: punctures, arteriole, blood loss, 15 seconds, gelatinous mass, 5 minutes. Neither 'contraction' nor 'smooth muscle' appears in the stem. 'Wall' and 'opening' are shared referents appearing in options A, C and D alike, so no distinctive key word is echoed. CHANGED: (1) removed the factually wrong explanation clause calling the spasm 'a purely mechanical event produced by the smooth muscle of the wall itself' and replaced it with the textbook account that the response is triggered by chemicals released from vessel-lining cells and pain receptors (:34628); (2) deleted the unsupported timing claim in the (Choice C) block that clot retraction 'develops over the hour following clot formation', since no retraction timescale appears anywhere in the source; (3) added the endothelin-trigger citation.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because contraction of the smooth muscle in the wall physically narrows the injured segment within seconds, long before any protein mesh exists. Hemostasis proceeds in three ordered steps: vascular spasm, formation of a platelet plug, and coagulation. The spasm is a dramatic contraction of the vessel's own smooth muscle, believed to be triggered by chemicals released from vessel-lining cells and from pain receptors, and it typically lasts up to \(30\) minutes. That timing makes it the only listed process able to reduce flow at \(15\) seconds. The firm gelatinous mass appearing at \(5\) minutes is the product of the coagulation step, so any process that depends on that mesh cannot explain the much earlier drop in blood loss. (Choice A) Cross-linking of insoluble strands is the terminal stabilizing event of coagulation and requires a mesh that the observation places at roughly \(5\) minutes. At \(15\) seconds essentially no strands are present to be linked together. This choice places the final step of the sequence at its beginning. (Choice B) Precursor activation does begin rapidly after tissue damage, so this option is partly reasonable on timing. However, generating an active enzyme does not by itself reduce the caliber of the opening or slow flow through it; it only initiates the chemistry that later yields strands. A measurable drop in blood loss at \(15\) seconds requires a mechanical change in the wall. (Choice C) Contraction of platelet proteins does pull the edges of a clot together, but this retraction acts on a clot that has already been stabilized. It therefore necessarily follows mesh formation rather than preceding it. Assigning it to the \(15\) second mark reverses the order of the sequence. (Choice D) When a vessel is severed or punctured, the smooth muscle in its wall contracts dramatically, constricting flow immediately and persisting for up to \(30\) minutes. This is the first of the three hemostatic steps and the only one available on a \(15\) second timescale. It therefore accounts for the sharp early reduction in blood loss. This is a Scientific Reasoning and Problem Solving question because you must match the timing of two hemostatic events and pick the one fast enough to slow bleeding within seconds of injury.

---

## B4-Q2 — Enzymatic Clot Dissolution

**Stem.** Two weeks after a deep bruise, a small clot inside a superficial vein has gradually disappeared and blood flow through that segment is normal. Imaging shows no new obstruction anywhere downstream. Which process most directly accounts for the clot's removal?

- **A.** Contractile proteins within platelets tightened the mesh and squeezed fluid out of it
- **B.** A circulating inactive protein was converted to an enzyme that digested the mesh  <- **KEY**
- **C.** Heparin on the vessel lining prevented further strands from being added to the mesh
- **D.** Liver-derived clotting factors were exhausted, so the mesh could not be maintained

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic easy / structural easy) |
| Estimated time | 65 s |
| Confidence | 5 |

**Correct answer (B): A circulating inactive protein was converted to an enzyme that digested the mesh**

Citations: /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-anatomy-physiology-2e.txt:34809 "To restore normal blood flow as the vessel heals, the clot must eventually be removed. Fibrinolysis is the gradual degradation of the clot." | :34811 "During this process, the inactive protein plasminogen is converted into the active plasmin, which gradually breaks down the fibrin of the clot." | :34804 "As these proteins contract, they pull on the fibrin threads, bringing the edges of the clot more tightly together" | :34820 "An anticoagulant is any substance that opposes coagulation. Several circulating plasma anticoagulants play a role in limiting the coagulation process to the region of injury" | :34826 "Heparin is also found on the surfaces of cells lining the blood vessels." | :34684 "Clotting factors are secreted primarily by the liver and the platelets." | :34881 "An embolus that is carried through the bloodstream can be large enough to block a vessel critical to a major organ."

**Distractors**

- **(A)** `process_step_confusion` . _retraction mistaken for removal_ — Clot retraction compacts an already stabilized clot and expresses fluid, but it does not eliminate the strands or reopen the lumen.
  - Citation: openstax-anatomy-physiology-2e.txt:34806 "This process also wrings out of the clot a small amount of fluid called serum"
- **(C)** `adjacent_fact` . _anticoagulation confused with lysis_ — Anticoagulants confine and limit new clot formation; they cannot degrade strands that have already been deposited.
  - Citation: openstax-anatomy-physiology-2e.txt:34820 "An anticoagulant is any substance that opposes coagulation."
- **(D)** `partial_truth` . _precursor depletion without degradation_ — Exhausting liver-derived precursors stops further clot enlargement, yet the assembled mesh is a stable structure that does not require ongoing factor supply to persist.
  - Citation: openstax-anatomy-physiology-2e.txt:34684 "Clotting factors are secreted primarily by the liver and the platelets."

**Readback check.** Content words of key B: circulating, inactive protein, converted, enzyme, digested, mesh. Stem words: bruise, clot, vein, disappeared, blood flow, imaging, obstruction, downstream, removal. Neither 'enzyme', 'inactive', 'converted' nor 'mesh' appears in the stem. 'Clot' is a shared referent, and options A, C and D all reference the same mesh or clot, so no distinctive key word is echoed. CHANGED: (1) FABRICATED CITATION FIXED. The draft cited :34871 as reading '...it is referred to as an embolus.' Line 34871 actually ends at the word 'an'; a page-break block follows and the word 'embolus' does not appear until line 34881. Replaced with the verified :34881 text. (2) Misnumbered citation :34685 corrected to :34684, where the sentence 'Clotting factors are secreted primarily by the liver and the platelets.' begins. (3) Removed the unsupported claim in (Choice A) that retraction 'occurs within hours of clot formation', since the source gives no retraction timescale.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because an inactive plasma protein is converted into an active protein-degrading enzyme that gradually breaks down the strands making up the clot. Once a vessel has healed, normal flow can only be restored if the existing mesh is physically destroyed rather than merely prevented from growing. Fibrinolysis accomplishes this by activating a circulating precursor into an enzyme that catabolizes the strands over days. The absence of any downstream obstruction rules out the alternative fate in which a fragment detaches and lodges elsewhere, leaving local dissolution as the explanation. Processes that only compact the clot or block its further enlargement leave the original mass in place. (Choice A) Contraction of platelet proteins does shrink a clot and wring fluid out of it, and this genuinely reduces clot volume. However, retraction concentrates rather than eliminates the strands, and it acts on the clot shortly after that clot is stabilized rather than over two weeks. A retracted clot still occupies the lumen and would not restore normal flow. (Choice B) Fibrinolysis converts an inactive circulating protein into an active enzyme that gradually breaks down the strands of the clot. This is the mechanism by which normal blood flow is restored as the vessel heals. The slow, progressive disappearance described fits this enzymatic degradation. (Choice C) Anticoagulants found on the surfaces of the cells lining vessels do limit the extension of clotting beyond the region of injury. Preventing new strands from being added, though, does nothing to the strands already deposited. The existing clot would persist and continue to obstruct the segment. (Choice D) Clotting factors are indeed secreted primarily by the liver and can be consumed during extensive clotting. Depleting the supply of precursors halts further clot growth but leaves the assembled mesh intact, because the mesh is not maintained by ongoing factor consumption. This would not restore flow through the segment. This is a Scientific Reasoning and Problem Solving question because you must use the absence of any downstream obstruction to eliminate mechanical dislodgement and infer how the mesh was broken down where it sat.

---

## B4-Q3 — Platelet Granule Release and Plug Growth

**Stem.** In a flow chamber, whole blood is perfused over a collagen-coated surface in the presence of a compound that blocks the emptying of platelet secretory granules. Compared with untreated blood, what is the most likely effect on the platelet aggregate that forms on the surface?

- **A.** Platelets attach normally, but few extra platelets are recruited and the aggregate stays thin  <- **KEY**
- **B.** Platelets fail to attach to the collagen at all, so no aggregate begins to form
- **C.** Platelets attach and recruit further platelets normally, but no reinforcing protein mesh forms
- **D.** Platelets build a larger aggregate than controls because inhibitory signals are retained inside them

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 80 s |
| Confidence | 5 |

**Correct answer (A): Platelets attach normally, but few extra platelets are recruited and the aggregate stays thin**

Citations: /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-anatomy-physiology-2e.txt:34633 "platelets, which normally float free in the plasma, encounter the area of vessel rupture with the exposed underlying connective tissue and collagenous fibers." | :34634 "The platelets begin to clump together, become spiked and sticky, and bind to the exposed collagen and endothelial lining." | :34636 "As platelets collect, they simultaneously release chemicals from their granules into the plasma that further contribute to hemostasis." | :34640 "adenosine diphosphate (ADP), which helps additional platelets to adhere to the injury site, reinforcing and expanding the platelet plug" | :34643 "prostaglandins and phospholipids, which also maintain vasoconstriction and help to activate further clotting chemicals" | :34654 "The result is the production of a gelatinous but robust clot made up of a mesh of fibrin"

**Distractors**

- **(B)** `misconception` . _secretion required for adhesion_ — Platelets bind exposed collagen directly on contact, so an inhibitor of granule emptying leaves the first adhesive step intact.
  - Citation: openstax-anatomy-physiology-2e.txt:34634 "The platelets begin to clump together, become spiked and sticky, and bind to the exposed collagen and endothelial lining."
- **(C)** `partial_truth` . _preserves the step the manipulation removes_ — Recruitment of additional platelets depends on released granule contents, so it cannot proceed normally when secretion is blocked; granule phospholipids also help activate further clotting chemicals, so the mesh is not the only casualty.
  - Citation: openstax-anatomy-physiology-2e.txt:34643 "prostaglandins and phospholipids, which also maintain vasoconstriction and help to activate further clotting chemicals"
- **(D)** `reversed_relationship` . _recruitment signal treated as inhibitory_ — Released granule contents recruit and activate additional platelets, so retaining them inside the cell would shrink rather than enlarge the aggregate.
  - Citation: openstax-anatomy-physiology-2e.txt:34640 "adenosine diphosphate (ADP), which helps additional platelets to adhere to the injury site"

**Readback check.** Content words of key A: attach normally, extra platelets, recruited, aggregate, thin. Stem words: flow chamber, whole blood, perfused, collagen-coated, compound, blocks, emptying, platelet secretory granules. Neither 'recruit' nor 'thin' appears in the stem. 'Platelets' and 'aggregate' are shared referents present in all four options, so no distinctive key word is echoed. CHANGED: (1) FACTUALLY WRONG EXPLANATION CLAUSE FIXED. The draft's (Choice C) block asserted that the fibrin mesh 'is generated by plasma clotting reactions rather than by granule emptying', which contradicts the source at :34643, where platelet granule prostaglandins and phospholipids 'help to activate further clotting chemicals'. Option C was rewritten so its false element is the claim of normal recruitment, and the rationale now rests on that clause while acknowledging that mesh formation would also be impaired. (2) Stem changed from 'prevents adhering platelets from emptying' to 'blocks the emptying of platelet secretory granules' to remove the near-synonym 'adhering' next to the key's 'attach'. (3) Added the :34643 citation.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because initial attachment depends on direct binding to exposed collagen, whereas enlargement of the aggregate depends on chemicals that platelets release once bound. Platelets that meet exposed collagenous fibers clump, become spiked and sticky, and bind directly to that surface, a step that requires no secretion. Once bound, they release granule contents including adenosine diphosphate, which helps additional platelets adhere at the injury site and thereby reinforces and expands the plug. Blocking secretion therefore separates these two functions: the first layer still forms, but the positive feedback that amplifies it is lost. The predicted result is a thin aggregate rather than a growing plug. (Choice A) Direct binding to collagenous fibers is a contact-dependent event and is unaffected by an inhibitor of secretion. Recruitment of further platelets, however, is driven by released granule contents, so it collapses when secretion is blocked. The aggregate consequently starts but fails to enlarge. (Choice B) Complete failure of attachment would occur if the collagen-binding step itself were disabled, which is not what this compound does. Platelets bind exposed collagen directly rather than through material they secrete. Attachment should therefore remain intact in the treated sample. (Choice C) This option preserves the very step the manipulation removes, because recruitment of additional platelets is driven by chemicals released from the granules. Granule contents also include phospholipids that help activate further clotting chemicals, so the reinforcing mesh would if anything be impaired as well rather than being the sole casualty. The option therefore misassigns which function survives the treatment. (Choice D) Granule contents released by platelets act to recruit and activate further platelets rather than to suppress them. Trapping those contents inside the cell would therefore reduce, not increase, aggregate size. This option inverts the direction of the signal. This is a Reasoning about the Design and Execution of Research question because you must predict how selectively blocking one secretory step in a flow chamber separates initial surface attachment from the amplification that normally follows it.

---

## B4-Q4 — Clot Retraction by Platelet Contraction

**Stem.** Whole blood from a healthy donor forms a solid clot in \(6\) minutes, and over the next hour the clot shrinks to about \(45\%\) of its original volume while clear fluid is expressed around it. Blood from a patient also forms a solid clot in \(6\) minutes, but the clot volume is unchanged after one hour, and the patient's platelet count and plasma coagulation protein concentrations are normal. Which platelet function is most likely impaired in the patient?

- **A.** Adhering to collagen exposed at a site of injury
- **B.** Releasing granule contents that recruit additional platelets
- **C.** Providing membrane surfaces on which activation reactions are accelerated
- **D.** Generating contractile force against the strands of the clot mesh  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 85 s |
| Confidence | 5 |

**Correct answer (D): Generating contractile force against the strands of the clot mesh**

Citations: /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-anatomy-physiology-2e.txt:34804 "The stabilized clot is acted upon by contractile proteins within the platelets. As these proteins contract, they pull on the fibrin threads, bringing the edges of the clot more tightly together" | :34806 "This process also wrings out of the clot a small amount of fluid called serum, which is blood plasma without its clotting factors." | :34635 "and sticky, and bind to the exposed collagen and endothelial lining." | :34640 "adenosine diphosphate (ADP), which helps additional platelets to adhere to the injury site" | :34688 "Some recent evidence indicates that activation of various clotting factors occurs on specific receptor sites on the surfaces of platelets."

**Distractors**

- **(A)** `adjacent_fact` . _real platelet function excluded by data_ — Impaired adhesion to collagen would lengthen the time to form a clot, but the patient's clot appears at the same \(6\) minutes as the control.
  - Citation: openstax-anatomy-physiology-2e.txt:34635 "and sticky, and bind to the exposed collagen and endothelial lining."
- **(B)** `adjacent_fact` . _recruitment defect excluded by normal clotting time_ — Loss of granule release impairs recruitment and plug expansion, which would slow clot appearance rather than leave a formed clot unable to shrink.
  - Citation: openstax-anatomy-physiology-2e.txt:34636 "they simultaneously release chemicals from their granules into the plasma that further contribute to hemostasis"
- **(C)** `partial_truth` . _true platelet role, wrong stage_ — Platelet surfaces do accelerate factor activation, but a defect there would prolong the clotting time, which is normal in this patient.
  - Citation: openstax-anatomy-physiology-2e.txt:34688 "Some recent evidence indicates that activation of various clotting factors occurs on specific receptor sites on the surfaces of platelets."

**Readback check.** Content words of key D: generating, contractile force, strands, clot mesh. Stem words: whole blood, donor, clot, 6 minutes, shrinks, 45%, volume, fluid expressed, platelet count, plasma coagulation protein concentrations. Neither 'contractile', 'force', 'strands' nor 'mesh' appears in the stem; 'shrinks' is an observation, not the mechanism. 'Platelet' and 'clot' are shared referents required by all four options. CHANGED: distractor A's citation was misnumbered. The draft cited :34634 for the fragment 'bind to the exposed collagen and endothelial lining', but that fragment sits entirely on line 34635 (line 34634 ends at 'become spiked'). Corrected to :34635. Content of stem, options and key unchanged.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because the shrinkage of a formed clot and the expression of fluid from it are produced by contractile proteins inside platelets pulling on the strands of the mesh. The patient forms a clot on schedule and has a normal platelet count and normal plasma proteins, so every step up to and including mesh formation is functioning. The single abnormality is that the formed clot never decreases in volume, isolating a defect that acts after the mesh is stabilized. Contractile proteins within platelets normally pull on the strands, drawing the edges of the clot together and wringing out a small volume of fluid. A failure of that contractile machinery reproduces exactly the pattern described. (Choice A) A defect in binding to exposed collagen would delay or prevent the initial plug and would show up as impaired clot formation. The patient's clot appears at \(6\) minutes, matching the control exactly. The data therefore exclude a problem with the adhesive step. (Choice B) Failure to release granule contents would blunt recruitment of further platelets and slow the appearance of a plug. Because clotting time is identical to control, recruitment cannot be the limiting defect here. This option addresses plug growth rather than the post-formation change in volume. (Choice C) Platelet membranes do serve as surfaces on which activation reactions are accelerated, so losing that function is physiologically meaningful. However, such a defect would prolong the time required to form the clot, which is normal in this patient. The observation of unchanged volume after an intact \(6\) minute clotting time points elsewhere. (Choice D) Contractile proteins within platelets act on the stabilized clot, pulling the strands so that the edges are drawn tightly together and fluid is expressed. Loss of this force leaves a clot that forms normally but never decreases in volume. This matches the patient's isolated abnormality. This is a Reasoning about the Design and Execution of Research question because you must use a comparison in which clotting time is held identical to isolate the step that fails only after the mesh has already formed.

---

## B4-Q5 — Cascade Amplification by Feedback Activation

**Stem.** An investigator adds the same trace dose of an active clotting enzyme to two tubes, one containing plasma and one containing purified fibrinogen at the same concentration in identical buffer. In the purified tube, fibrin accumulates at a steadily declining rate from the start, whereas in the plasma tube the rate of accumulation rises for the first \(60\) seconds before substrate becomes limiting. Which feature of plasma best accounts for the rising phase?

- **A.** Plasma contains a protein that cross-links the strands once they have formed
- **B.** Plasma proteins shield the added enzyme from degradation, prolonging its active lifetime
- **C.** Plasma supplies cofactors that the purified system lacks, speeding each catalytic cycle
- **D.** Plasma contains precursors that the added enzyme converts into more of itself  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic hard / structural hard) |
| Estimated time | 110 s |
| Confidence | 5 |
| Hard-tier gate | Meets three conditions, verified after the option rebuild. (1) DATA-TO-MECHANISM: the examinee must recognize that a rising rate against falling substrate implies growing enzyme concentration, then map that onto cascade feedback. (2) TRUE PARTIAL-TRUTH TRAP: choices A and C state genuinely correct facts about factor XIII cross-linking and about calcium as a required clotting cofactor, and each is defeated only by the shape rather than the magnitude of the curve. (3) 510-TEMPTING DISTRACTOR: choice B correctly identifies enzyme lifetime as a rate determinant and is discriminated only by noticing that preservation yields a flat rather than rising rate. |

**Correct answer (D): Plasma contains precursors that the added enzyme converts into more of itself**

Citations: /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-biology-2e.txt:43732 "The final factor, a protein called thrombin, converts inactive fibrinogen to fibrin. Thrombin also activates additional clotting factor molecules earlier in the cascade, resulting in the activation of even more thrombin. This positive feedback loop amplifies the cascade for faster, more effective formation of a blood clot." | /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-anatomy-physiology-2e.txt:34653 "The process is sometimes characterized as a cascade, because one event prompts the next as in a multi-level waterfall." | :34800 "Then, thrombin converts factor I, the soluble fibrinogen, into the insoluble fibrin protein strands. Factor XIII then stabilizes the fibrin clot." | :34687 "The calcium ion, considered factor IV, is derived from the diet and from the breakdown of bone."

**Distractors**

- **(A)** `adjacent_fact` . _true downstream stabilization offered as a rate cause_ — Cross-linking acts on strands that have already formed, so it alters clot durability rather than the rate at which new strands appear.
  - Citation: openstax-anatomy-physiology-2e.txt:34800 "Factor XIII then stabilizes the fibrin clot."
- **(B)** `partial_truth` . _enzyme preservation confused with enzyme generation_ — Preserving a fixed amount of enzyme can at best hold the rate steady; only an increase in enzyme quantity can make the rate climb while substrate falls.
  - Citation: openstax-biology-2e.txt:43733 "resulting in the activation of even more thrombin"
- **(C)** `adjacent_fact` . _real cofactor, wrong kinetic signature_ — A cofactor present at constant concentration from time zero raises the rate uniformly from the first instant rather than producing a progressive rise.
  - Citation: openstax-anatomy-physiology-2e.txt:34687 "The calcium ion, considered factor IV, is derived from the diet and from the breakdown of bone."

**Readback check.** Content words of key D: precursors, converts, more of itself. Stem words: investigator, trace dose, clotting enzyme, tubes, plasma, purified fibrinogen, buffer, fibrin, declining rate, rises, 60 seconds, substrate. Neither 'precursors' nor 'converts' appears in the stem, and the stem never states that enzyme quantity changes. 'Plasma' and 'enzyme' are shared referents used by all four options. CHANGED: (1) MISNUMBERED CITATION FIXED. Distractor A cited :34767 as containing 'XIII Fibrin-stabilizing factor ... Stabilizes fibrin; slows fibrinolysis'; line 34767 holds only the fragments 'Plasma' and 'Stabilizes fibrin; slows', and the factor name sits on 34768. Replaced with the verified prose sentence at :34800. (2) DEFECTIVE DISTRACTOR REPLACED. Draft option C read 'Platelet membranes in plasma concentrate the added enzyme close to its substrate'; because plasma is by definition the cell-free fraction, an examinee could discard it on a definitional technicality instead of the intended kinetic reasoning, violating the single-variable rule. Replaced with a cofactor option defeated purely by the shape of the time course. (3) Option D reworded so all four options open with 'Plasma' and every option is exactly twelve words, so the key is not the longest.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because a reaction rate that increases over time indicates that the amount of active enzyme is itself growing, which happens when the enzyme activates precursors that generate more of it. In the purified system the enzyme concentration is fixed, so the rate can only fall as substrate is consumed, and this is exactly what is observed. In plasma the rate climbs instead, which cannot be explained by any effect that merely preserves, accelerates or repositions a fixed quantity of enzyme. Coagulation is organized as a cascade in which the final enzyme also activates clotting factor molecules earlier in the sequence, producing still more of that enzyme. This positive feedback loop amplifies the cascade and is the only listed feature capable of increasing the amount of active enzyme during the reaction. (Choice A) A plasma protein that cross-links strands once they have formed is a genuine component of clot stabilization and makes the finished mesh more durable. Stabilizing a product, however, acts downstream of the reaction being timed and does not change how fast new strands appear. It cannot generate an accelerating rate. (Choice B) Protecting the enzyme from degradation would keep the rate from falling as quickly, which is a plausible-sounding effect. Even a perfectly protected enzyme, though, is present at a fixed amount and would at best sustain a constant rate against declining substrate. Sustaining a rate is not the same as increasing it. (Choice C) Plasma genuinely supplies cofactors that a purified preparation lacks, and calcium in particular is required throughout the clotting process. A cofactor present at a fixed concentration from the first instant would raise the rate uniformly rather than cause it to climb while substrate falls. The shape of the time course, not its magnitude, is what must be explained. (Choice D) The cascade is built so that the enzyme converting the soluble precursor into insoluble strands also activates factors earlier in the sequence. Each round therefore produces more of that same enzyme, so its concentration and the reaction rate both rise with time. This autocatalytic amplification is absent from the purified system, matching the divergence between the tubes. This is a Data-based and Statistical Reasoning question because you must compare the shapes of two fibrin accumulation curves and infer what the plasma tube supplies that a purified system cannot.

---

## B4-Q6 — Confinement of Clotting to the Injury Site

**Stem.** Clot formation at a small wound normally stays within the damaged segment rather than propagating along the vessel into healthy tissue. An investigator proposes three mechanisms that could contribute to this confinement.

I. Anticoagulants carried in the plasma inactivate activated clotting enzymes that are swept downstream from the wound
II. The undamaged lining bordering the wound keeps the collagenous fibers beneath it covered
III. Clotting factors are consumed at the wound faster than the liver can replace them, leaving none available downstream

Which of the proposed mechanisms would contribute to confinement?

- **A.** I only
- **B.** I and III only
- **C.** II and III only
- **D.** I and II only  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic medium / structural hard) |
| Estimated time | 105 s |
| Confidence | 5 |
| Hard-tier gate | Meets three conditions, verified honestly after the rebuild. (1) CONCEPT CHAINING: three mechanisms at different levels must each be evaluated and then combined, spanning plasma inhibitor chemistry, endothelial structure and trigger availability, and a quantitative claim about precursor supply. (2) TRUE PARTIAL-TRUTH TRAP: item III correctly names the liver as the source of clotting factors and invokes genuine factor consumption, and is defeated only by recognizing that the circulating pool far exceeds what a small wound uses and that real depletion causes bleeding rather than confinement. (3) 510-TEMPTING DISTRACTOR: choices B and C both attach item III, capturing the common reasoning that a reaction stops spreading because its reactants run out. |

**Correct answer (D): I and II only**

Citations: /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-anatomy-physiology-2e.txt:34820 "An anticoagulant is any substance that opposes coagulation. Several circulating plasma anticoagulants play a role in limiting the coagulation process to the region of injury and restoring a normal, clot-free condition of blood." | :38486 "Damage to this endothelial lining and exposure of blood to the collagenous fibers beneath is one of the primary causes of clot formation." | :34633 "platelets, which normally float free in the plasma, encounter the area of vessel rupture with the exposed underlying connective tissue and collagenous fibers." | :34684 "Clotting factors are secreted primarily by the liver and the platelets." | :34826 "Heparin is also found on the surfaces of cells lining the blood vessels."

**Distractors**

- **(A)** `partial_truth` . _chemical brake accepted, structural barrier ignored_ — It omits item II even though an undamaged lining withholds the exposed collagenous fibers that are a primary trigger for clot formation.
  - Citation: openstax-anatomy-physiology-2e.txt:38486 "Damage to this endothelial lining and exposure of blood to the collagenous fibers beneath is one of the primary causes of clot formation."
- **(B)** `misconception` . _confinement attributed to precursor depletion_ — It endorses item III, but the source attributes localization to circulating anticoagulants, and the circulating pool of liver-derived factors far exceeds what a small wound consumes; genuine depletion causes bleeding at distant sites rather than confinement.
  - Citation: openstax-anatomy-physiology-2e.txt:34684 "Clotting factors are secreted primarily by the liver and the platelets."
- **(C)** `adjacent_fact` . _genuine inhibitor discarded, pathological consumption retained_ — It drops item I even though plasma anticoagulants are explicitly described as limiting coagulation to the region of injury, and it retains the false depletion claim of item III.
  - Citation: openstax-anatomy-physiology-2e.txt:34820 "Several circulating plasma anticoagulants play a role in limiting the coagulation process to the region of injury"

**Readback check.** The keyed content is carried by items I and II: anticoagulants, inactivate, activated clotting enzymes, lining, collagenous fibers. Stem prose words: clot formation, wound, stays, damaged segment, propagating, vessel, healthy tissue, mechanisms, confinement. None of 'anticoagulant', 'collagen' or 'inactivate' appears in the stem prose, and the option labels are bare numerals carrying no content, so no distinctive key word is echoed. CHANGED: HARD GATE FAILURE REBUILT, not rubber-stamped. Draft item III read 'Substances released from platelet granules act only on the platelet that released them', which is defeated by a single recalled fact about adenosine diphosphate; the draft's gate claims of concept chaining and a true partial-truth trap were therefore inflated, and the item was honestly a medium. Item III was replaced with a clotting-factor consumption claim that rests on a real phenomenon and is refuted only by reasoning about scale and about the source's attribution of localization to circulating anticoagulants. The option set was recut from I only / II only / I and III / I and II to I only / I and III / II and III / I and II so that two options carry the false item and the key cannot be reached by elimination alone.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because plasma anticoagulants quench activated enzymes that leave the wound and an intact lining withholds the collagen that would otherwise activate platelets, whereas confinement does not depend on exhausting the supply of clotting factors. Several circulating plasma anticoagulants act specifically to limit the coagulation process to the region of injury and to restore a clot-free condition in the rest of the blood. Damage to the endothelial lining with exposure of the collagenous fibers beneath it is one of the primary causes of clot formation, so a border whose lining is intact simply presents no trigger. Item III fails on both scale and consequence: the circulating pool of liver-derived factors greatly exceeds what a small wound consumes, and a state in which those factors truly are depleted produces bleeding at distant sites rather than orderly localization. (Choice A) This selection accepts the plasma brake but discards the contribution of the intact lining. Because exposure of the underlying collagenous fibers is a primary trigger for clot formation, a border that keeps those fibers covered is itself a confinement mechanism. Omitting item II understates how localization is achieved. (Choice B) This selection pairs a correct mechanism with the claim that the factor supply runs out. Localization is attributed to inhibitors that inactivate enzymes leaving the injury, not to depletion of precursors, and depletion severe enough to halt clotting presents as bleeding elsewhere rather than as tidy confinement. Item III therefore cannot be part of the answer. (Choice C) This selection recognizes the structural barrier but rejects the plasma inhibitors while accepting factor depletion. Activated enzymes generated at the wound do enter flowing blood, and circulating anticoagulants are described as limiting coagulation to the region of injury. Dropping item I while keeping item III inverts which of the two is genuine. (Choice D) Items I and II operate at different levels and together explain localization: inhibitors in the plasma inactivate activated enzymes carried away from the wound, and the undamaged lining offers no exposed collagen to activate platelets. Item III is excluded because the supply of liver-derived factors is not the limiting quantity at a small wound. This pairing captures both the chemical and the structural basis of confinement. This is a Data-based and Statistical Reasoning question because you must weigh each proposed mechanism against the observation that clotting stops at the damaged segment and keep only those consistent with that limit.

---

## B4-Q7 — Platelet Plug Versus Fibrin Reinforcement

**Stem.** A standardized skin puncture in a patient stops bleeding at \(5\) minutes, within the \(2\) to \(9\) minute reference range, but the wound re-bleeds \(45\) minutes later. The patient's platelet count and collagen-induced platelet aggregation are both normal, whereas a plasma sample from the patient takes more than four times as long as control plasma to form a gel. Which defect best explains the combined findings?

- **A.** Failure of platelets to adhere to collagen exposed at the wound
- **B.** Failure of the injured arteriole to constrict after the puncture
- **C.** Failure to convert a soluble precursor protein into insoluble strands  <- **KEY**
- **D.** Failure to restrain the enzyme that dissolves an established clot

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic hard / structural hard) |
| Estimated time | 105 s |
| Confidence | 5 |
| Hard-tier gate | Meets three conditions. (1) CONCEPT CHAINING: the examinee must link a normal early plug to intact platelet function, then link the late re-bleed to a missing reinforcement step, and reconcile both with the plasma assay. (2) DATA-TO-MECHANISM: three separate quantitative results, one clinical and two laboratory, must be integrated before a mechanism can be selected. (3) TRUE PARTIAL-TRUTH TRAP and 510-TEMPTING DISTRACTOR: choice D explains delayed re-bleeding correctly and is defeated only by noticing that an enzyme acting on formed clots cannot quadruple the time to form the first gel. |

**Correct answer (C): Failure to convert a soluble precursor protein into insoluble strands**

Citations: /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-anatomy-physiology-2e.txt:34646 "A platelet plug can temporarily seal a small opening in a blood vessel. Plug formation, in essence, buys the body time while more sophisticated and durable repairs are being made." | :34652 "Those more sophisticated and more durable repairs are collectively called coagulation, the formation of a blood clot." | :34654 "The result is the production of a gelatinous but robust clot made up of a mesh of fibrin" | :34800 "Then, thrombin converts factor I, the soluble fibrinogen, into the insoluble fibrin protein strands." | :34635 "and sticky, and bind to the exposed collagen and endothelial lining." | :34624 "When a vessel is severed or punctured, or when the wall of a vessel is damaged, vascular spasm occurs. In vascular spasm, the smooth muscle in the walls of the vessel contracts dramatically." | :34811 "the inactive protein plasminogen is converted into the active plasmin, which gradually breaks down the fibrin of the clot"

**Distractors**

- **(A)** `adjacent_fact` . _adhesion defect excluded by the data_ — Impaired binding to exposed collagen would push the bleeding time outside the reference range, yet the patient stops bleeding at \(5\) minutes with normal collagen-induced aggregation.
  - Citation: openstax-anatomy-physiology-2e.txt:34635 "and sticky, and bind to the exposed collagen and endothelial lining."
- **(B)** `process_step_confusion` . _vessel wall defect invoked for a plasma finding_ — Loss of the constrictive response would affect the earliest phase of hemostasis in the body and cannot alter the gel time of an isolated plasma sample.
  - Citation: openstax-anatomy-physiology-2e.txt:34624 "When a vessel is severed or punctured, or when the wall of a vessel is damaged, vascular spasm occurs."
- **(D)** `partial_truth` . _hyperlysis explains re-bleed but not the assay_ — Unrestrained clot dissolution acts on a clot that has already formed and would cause late re-bleeding, but it does not explain plasma requiring more than four times the control time to gel.
  - Citation: openstax-anatomy-physiology-2e.txt:34809 "Fibrinolysis is the gradual degradation of the clot."

**Readback check.** Content words of key C: convert, soluble, precursor protein, insoluble strands. Stem words: skin puncture, bleeding, 5 minutes, reference range, re-bleeds, 45 minutes, platelet count, collagen-induced aggregation, plasma sample, four times, gel. Neither 'soluble', 'insoluble', 'precursor', 'strands' nor 'convert' appears in the stem. 'Failure of' or 'Failure to' opens all four options, and 'collagen' appears in the stem only as an eliminating datum for choice A. CHANGED: (1) Two misnumbered citations corrected. The quote beginning 'In vascular spasm' was cited to :34625 but begins on :34624; corrected. The fragment 'bind to the exposed collagen and endothelial lining' was cited to :34634 but sits entirely on :34635; corrected. (2) The citation quoting line 34654 was trimmed to its dash-free portion, since the source line contains em dashes that the notation rule forbids from appearing anywhere in the item. (3) The (Choice D) block was softened from the absolute claim that hyperlysis 'would not prolong the time required for plasma to gel in the first place' to the defensible statement that its action is exerted on an already formed clot, which avoids overreaching about fibrinogen degradation.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because the patient can build a platelet plug on time but cannot generate the insoluble strands that convert that temporary seal into a durable clot. A platelet plug can temporarily seal a small opening, buying time while more durable repairs are made, which explains why bleeding stops within the reference range. The normal platelet count and normal collagen-induced aggregation confirm that this first phase is intact. The markedly prolonged time for plasma to gel localizes the defect to the step in which a soluble protein is converted into insoluble strands. Without that mesh the unreinforced plug cannot withstand pressure, and bleeding resumes after roughly \(45\) minutes. (Choice A) A failure of platelets to bind exposed collagen would delay or abolish the initial seal, producing a bleeding time outside the reference range. The measured value of \(5\) minutes and the normal collagen-induced aggregation both argue against this. The adhesive step is functioning in this patient. (Choice B) Loss of the constrictive response would also impair the earliest reduction in blood loss and would not selectively affect a plasma test performed outside the body. The gel time abnormality involves plasma alone, which contains no vessel wall. Vascular narrowing cannot account for the laboratory finding. (Choice C) The prolonged plasma gel time identifies impaired conversion of a soluble protein into insoluble strands, and it is that mesh which traps platelets and blood cells to make the clot robust. Bleeding stops on schedule because the temporary plug forms normally, then resumes when the plug is not reinforced. Both halves of the clinical picture follow from this single defect. (Choice D) Unrestrained activity of the clot-dissolving enzyme is a real cause of delayed re-bleeding after an initially normal seal, which makes this option genuinely tempting. Its action, however, is exerted on a clot after that clot has formed, so it does not account for the patient's plasma requiring more than four times the control time to gel at all. The prolonged gel time points to failed strand production rather than accelerated strand removal. This is a Data-based and Statistical Reasoning question because you must read a normal bleeding time and normal platelet studies against a delayed re-bleed and localize the defect to the later stabilizing step.

---

## B4-Q8 — Vasomotor Changes Across the Clot Lifecycle

**Stem.** After a small arteriole is punctured, its diameter falls to about \(60\%\) of baseline within one minute and is still reduced when measured at \(30\) minutes. Serial imaging shows the diameter returning to baseline only as the clot occupying the site is subsequently removed. Which mechanism best accounts for both the persistence of the narrowing and the timing of its reversal?

- **A.** Mechanical compression of the vessel wall by the enlarging clot, relieved when the clot is digested
- **B.** Chemicals released by adhering platelets, later opposed by a vasodilator appearing during clot removal  <- **KEY**
- **C.** Sustained stretch of the vessel wall by rising upstream pressure, relieved when flow resumes
- **D.** Contraction of wall smooth muscle driven by plasma calcium, ending when the clot consumes it

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic hard / structural hard) |
| Estimated time | 100 s |
| Confidence | 5 |
| Hard-tier gate | Meets three conditions. (1) CONCEPT CHAINING: the examinee must connect platelet granule secretion to maintained vasoconstriction and then connect clot degradation to vasodilator release, spanning three phases of hemostasis. (2) DATA-TO-MECHANISM: a two-phase diameter time course must be mapped onto two distinct chemical events rather than one, and the coupling of the reversal to clot removal is the discriminating datum. (3) 510-TEMPTING DISTRACTOR: choice A pairs the correct timing of clot growth and removal with a mechanically wrong cause and is the natural answer for a student who never learned that platelet products sustain the constriction. |

**Correct answer (B): Chemicals released by adhering platelets, later opposed by a vasodilator appearing during clot removal**

Citations: /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/reference-textbooks/biology/openstax-anatomy-physiology-2e.txt:34624 "In vascular spasm, the smooth muscle in the walls of the vessel contracts dramatically." | :34628 "The vascular spasm response is believed to be triggered by several chemicals called endothelins that are released by vessel-lining cells and by pain receptors in response to vessel injury." | :34630 "This phenomenon typically lasts for up to 30 minutes, although it can last for hours." | :34642 "serotonin, which maintains vasoconstriction" | :34643 "prostaglandins and phospholipids, which also maintain vasoconstriction" | :34812 "Additionally, bradykinin, a vasodilator, is released, reversing the effects of the serotonin and prostaglandins from the platelets. This allows the smooth muscle in the walls of the vessels to relax and helps to restore the circulation." | :39691 "Platelet secretions and certain prostaglandins may also trigger constriction." | :34687 "The calcium ion, considered factor IV, is derived from the diet and from the breakdown of bone." | :39194 "Compliance allows an artery to expand when blood is pumped through it from the heart, and then to recoil after the surge has passed."

**Distractors**

- **(A)** `misconception` . _intraluminal clot as external compressor_ — A clot occupies the lumen rather than compressing the wall from outside, so it cannot produce a measured reduction in the diameter of the vessel itself.
  - Citation: openstax-anatomy-physiology-2e.txt:34654 "The result is the production of a gelatinous but robust clot made up of a mesh of fibrin"
- **(C)** `reversed_relationship` . _stretch offered as a cause of narrowing_ — Compliance allows a vessel to expand when the pressure inside it rises, so wall stretch produces distension and cannot account for a diameter held at \(60\%\) of baseline.
  - Citation: openstax-anatomy-physiology-2e.txt:39194 "Compliance allows an artery to expand when blood is pumped through it from the heart, and then to recoil after the surge has passed."
- **(D)** `scale_unit_error` . _clotting calcium requirement scaled to plasma depletion_ — Calcium participates in clotting and in contraction, but the quantity incorporated into a small clot is negligible against tightly regulated plasma calcium and could not time the reversal.
  - Citation: openstax-anatomy-physiology-2e.txt:34687 "The calcium ion, considered factor IV, is derived from the diet and from the breakdown of bone."

**Readback check.** Content words of key B: chemicals, released, adhering platelets, opposed, vasodilator. Stem words: arteriole, punctured, diameter, 60%, baseline, one minute, 30 minutes, serial imaging, clot, removed. Neither 'platelet', 'chemicals' nor 'vasodilator' appears in the stem, and the stem states only what the diameter does, never why. 'Clot' is a shared referent appearing in options A, B and D alike. CHANGED: (1) INTERNALLY CONTRADICTORY STEM FIXED. The draft asserted the diameter 'remains reduced for roughly 30 minutes' and then that 'over the following days the clot is degraded and the diameter returns to baseline', which are mutually exclusive; the stem now reports that the diameter is still reduced at 30 minutes and returns to baseline only as the clot is removed. (2) FACTUALLY WRONG EXPLANATION CLAUSE FIXED. The draft claimed the spasm 'would fade quickly if nothing sustained it', which contradicts the source at :34630 stating that vascular spasm typically lasts up to 30 minutes and can last hours; the reasoning now names endothelins as the trigger and platelet serotonin and prostaglandins as the maintaining chemicals. (3) UNSUPPORTED CITATION REPLACED. Distractor C cited :34868 on thrombus-induced local pressure rise to support the claim that pressure distends rather than narrows a vessel, which that line does not state, and the quoted sentence began with a word carried on :34867; replaced with the compliance passage at :39194. (4) Distractor D's citation to the garbled table row at :34716 was replaced with the prose sentence at :34687. (5) Option D reworded from 'Depolarization of wall smooth muscle by plasma calcium' to 'Contraction of wall smooth muscle driven by plasma calcium' for physiological accuracy.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because chemicals released by platelets at the wound maintain the vasoconstriction, and the later degradation of the clot liberates a vasodilator that reverses exactly those chemicals. The narrowing begins as a contraction of wall smooth muscle triggered by endothelins from vessel-lining cells and by pain receptors. Among the substances subsequently released from platelet granules are serotonin, which maintains vasoconstriction, and prostaglandins and phospholipids, which also maintain vasoconstriction. During degradation of the clot, bradykinin, a vasodilator, is released, reversing the effects of the serotonin and prostaglandins from the platelets and allowing the smooth muscle in the vessel wall to relax and the circulation to be restored. A single chemical scheme therefore explains both the maintained narrowing and the coupling of its reversal to clot removal. (Choice A) Compression by a growing clot is intuitively appealing because the clot and the narrowing appear together and resolve together. However, a clot forms inside the lumen and would narrow the channel rather than squeeze the muscular wall from outside, so it cannot produce a reduction in the diameter of the vessel itself. The observed narrowing reflects contraction of the wall. (Choice B) Substances released by platelets at the wound, including serotonin and prostaglandins, maintain vasoconstriction and so sustain the narrowing beyond its initial trigger. As the clot is later broken down, a vasodilator is released that specifically reverses the effects of those platelet products, letting the wall smooth muscle relax and the circulation be restored. This links both phases of the diameter record to one sequence of released chemicals. (Choice C) Wall stretch is a real determinant of vessel caliber, and pressure does rise proximal to an obstruction. Compliance, however, allows a vessel to expand when the pressure inside it rises, so stretch produces distension rather than the sustained \(40\%\) reduction in diameter recorded here. This option also leaves the timing of the reversal unexplained. (Choice D) Calcium is genuinely required throughout the clotting process and participates in smooth muscle contraction, which makes this option superficially plausible. The quantity of calcium incorporated into a small clot is negligible against a tightly regulated plasma concentration, so it could not fall far enough to release the vessel. The reversal is instead tied to the appearance of a vasodilator during clot degradation. This is a Data-based and Statistical Reasoning question because you must align a vessel diameter time course with the lifespan of the clot and infer which signals sustain the narrowing and which later reverse it.

---

## B4-Q9 — Oxygen Content Versus Percent Saturation

**Stem.** A woman with long-standing iron deficiency has a blood hemoglobin concentration of \(6\) g/dL, compared with about \(14\) g/dL in healthy adults. Her lungs are normal, her arterial \(P_{\text{O}_2}\) is \(98\) mm Hg, and pulse oximetry reads \(99\%\). Her exercise intolerance is most directly attributable to which feature of her arterial blood?

- **A.** A smaller fraction of its hemoglobin binding sites is occupied by oxygen.
- **B.** A smaller quantity of oxygen is dissolved in its plasma.
- **C.** A smaller total quantity of oxygen is carried in each unit volume.  <- **KEY**
- **D.** A smaller partial pressure of oxygen drives diffusion into her tissues.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic medium / structural easy) |
| Estimated time | 60 s |
| Confidence | 5 |

**Correct answer (C): A smaller total quantity of oxygen is carried in each unit volume.**

Citations: AP:45848 'amount of oxygen does dissolve in the blood and is transported in the bloodstream, but it is only about 1.5% of the' | AP:45882 'considering the blood as a whole, the percent of the available heme units that are bound to oxygen at a given time is' | AP:45884-45885 'In a healthy individual with normal hemoglobin levels, hemoglobin' / 'saturation generally ranges from 95 percent to 99 percent.' | AP:34147 'In determining oxygenation of tissues, the value of greatest interest in healthcare is the percent saturation;' | AP:34151 'Percent saturation is normally monitored using a device known as a pulse oximeter, which is applied to a thin part of' | AP:34158 'Oxygen levels are also directly monitored from free oxygen in the plasma typically following an arterial stick.' | AP:34266-34268 'The effects of the various' / 'anemias are widespread, because reduced numbers of RBCs or hemoglobin will result in lower levels of oxygen' / 'being delivered to body tissues.' | AAMC:1844 'Oxygen transport by blood'; AAMC:1846 'Oxygen content'

**Distractors**

- **(A)** `misconception` . _saturation mistaken for capacity_ — Saturation is the occupied fraction of the heme sites that exist; anemia lowers the number of sites, not the fraction filled. The stated oximetry value of 99 percent shows the fraction is normal.
  - Citation: AP:45882 'considering the blood as a whole, the percent of the available heme units that are bound to oxygen at a given time is' | AP:45884-45885 'In a healthy individual with normal hemoglobin levels, hemoglobin' / 'saturation generally ranges from 95 percent to 99 percent.'
- **(B)** `adjacent_fact` . _dissolved compartment overweighted_ — Dissolved oxygen is set by partial pressure, which is normal, and it constitutes only about 1.5 percent of total blood oxygen, so it cannot explain her symptoms.
  - Citation: AP:45848 'amount of oxygen does dissolve in the blood and is transported in the bloodstream, but it is only about 1.5% of the'
- **(D)** `partial_truth` . _pressure substituted for content_ — Arterial partial pressure is normal at 98 mm Hg, so the driving gradient is intact; the abnormality is the quantity of oxygen available per unit volume, not the pressure head.
  - Citation: AP:34158 'Oxygen levels are also directly monitored from free oxygen in the plasma typically following an arterial stick.'

**Readback check.** Key content words: smaller, total quantity of oxygen, carried, each unit volume. Stem words: iron deficiency, hemoglobin concentration, 6 g/dL, 14 g/dL, lungs, arterial P_O2, 98 mm Hg, pulse oximetry, 99 percent, exercise intolerance, arterial blood. Overlap is limited to 'oxygen' and 'blood', shared referents equally necessary to all four options. No definition-to-name, no stem echo, no restated premise, no self-justifying key. AUDIT CHANGES: (1) option C previously read 'present in each 100 mL' while the stem states hemoglobin in g/dL, the identical unit; all four options moved to the neutral phrase 'unit volume' to retire that resonance and keep the set parallel. (2) Explanation clause 'halving the hemoglobin concentration roughly halves' corrected, since 6/14 is 43 percent and not one half. (3) Explanation clause 'Partial pressure and content are independent descriptors' corrected to 'describe different properties', because content is not independent of partial pressure, it depends on it through saturation. (4) Citation AP:45847 for the 1.5 percent quotation corrected to AP:45848; AP:34266 and AP:34268 expanded to the verified range AP:34266-34268; AP:45884 expanded to AP:45884-45885.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because nearly all blood oxygen travels bound to hemoglobin, so a carrier concentration of \(6\) g/dL rather than \(14\) g/dL leaves each unit volume holding far less oxygen even when partial pressure and percent saturation are normal. Percent saturation reports the fraction of available heme sites that happen to be occupied, not how many sites exist. A pulse oximeter therefore reads normally in anemia, because the few hemoglobin molecules present are almost fully loaded. Arterial \(P_{\text{O}_2}\) reports only the oxygen physically dissolved in plasma, which is a trivial share of the total. Oxygen content, the amount each unit volume can surrender to working muscle, scales with hemoglobin concentration, and it is the only one of the three measurements that is abnormal in this woman. (Choice A) Percent saturation is the proportion of heme units bound to oxygen at a given moment, and the reading of \(99\%\) sits at the top of the normal range of \(95\%\) to \(99\%\). Iron deficiency reduces the number of binding sites available, not the fraction of them that is filled. Her hemoglobin is well loaded; there is simply too little of it. (Choice B) Dissolved oxygen tracks arterial \(P_{\text{O}_2}\), which is normal at \(98\) mm Hg, so the dissolved quantity is also normal. Even a large change in this compartment would matter little, because only about \(1.5\%\) of blood oxygen travels dissolved. Iron deficiency does not alter the solubility of oxygen in plasma. (Choice C) Content is set by hemoglobin concentration multiplied by the fraction of its sites occupied, plus a negligible dissolved term. With saturation preserved but carrier concentration at roughly \(43\%\) of normal, each unit volume of her arterial blood hands off correspondingly less oxygen to exercising tissue. This is the deficit that limits her exertion. (Choice D) Her arterial partial pressure of \(98\) mm Hg is normal, so the gradient available at the arterial end of a systemic capillary is intact. What is missing is the reservoir of bound oxygen that normally sustains that gradient as blood traverses the capillary. Partial pressure and content describe different properties of the same sample, and only content is abnormal here. This is a Scientific Reasoning and Problem Solving question because you must separate the fraction of binding sites occupied from the absolute amount of gas the blood can carry when the carrier protein is scarce.

---

## B4-Q10 — Dissolved Oxygen As A Fraction Of Content

**Stem.** An investigator has a healthy volunteer breathe an enriched gas mixture that raises arterial \(P_{\text{O}_2}\) from \(100\) mm Hg to \(300\) mm Hg while hemoglobin saturation holds steady at \(99\%\). Plasma dissolves \(0.003\) mL of oxygen per \(100\) mL of blood for each mm Hg of \(P_{\text{O}_2}\), and the volunteer's arterial oxygen content was \(20\) mL per \(100\) mL beforehand. By approximately what percentage does arterial oxygen content rise?

- **A.** \(3\%\)  <- **KEY**
- **B.** \(4.5\%\)
- **C.** \(30\%\)
- **D.** \(200\%\)

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 85 s |
| Confidence | 5 |

**Correct answer (A): \(3\%\)**

Citations: AP:45847 'Even though oxygen is transported via the blood, you may recall that oxygen is not very soluble in liquids. A small' | AP:45848 'amount of oxygen does dissolve in the blood and is transported in the bloodstream, but it is only about 1.5% of the' | AP:45733 'most of the oxygen is picked up by erythrocytes (red blood cells) and binds to a protein called hemoglobin, a process' | AP:45884-45885 'In a healthy individual with normal hemoglobin levels, hemoglobin' / 'saturation generally ranges from 95 percent to 99 percent.' | AAMC:1846 'Oxygen content'

**Distractors**

- **(B)** `process_step_confusion` . _total instead of increment_ — Divides the post-change dissolved quantity of 0.9 mL per 100 mL by 20 rather than the 0.6 mL per 100 mL increment, double counting the oxygen already dissolved at baseline.
- **(C)** `scale_unit_error` . _decimal slip in the solubility coefficient_ — Uses 0.03 instead of 0.003 mL per 100 mL per mm Hg, inflating the dissolved increment tenfold to 6 mL per 100 mL.
- **(D)** `misconception` . _content proportional to partial pressure_ — Treats oxygen content as tracking P_O2 directly; content is dominated by hemoglobin bound oxygen, which is already near maximal at 99 percent saturation.
  - Citation: AP:45848 'amount of oxygen does dissolve in the blood and is transported in the bloodstream, but it is only about 1.5% of the'

**Readback check.** Key is a numeric value, so no content words can be echoed from the stem. Stem supplies the solubility coefficient, both partial pressures, and the baseline content as data to compute from, never the conclusion. No definition-to-name, no stem echo, no restated premise, no self-justifying key. AUDIT CHANGES: arithmetic re-derived and confirmed (0.3 to 0.9 mL per 100 mL, increment 0.6, 0.6/20 = 3 percent; distractor values 0.9/20 = 4.5 percent, tenfold coefficient slip = 30 percent, proportional-to-pressure = 200 percent all check out). Citation AP:45847 for the 1.5 percent quotation corrected to AP:45848, and AP:45846 for 'Even though oxygen is transported via the blood' corrected to AP:45847; AP:45733 and AP:45884 quotations extended to their verified text. Scope confirmed clean of curve shape, Bohr, 2,3-BPG, fetal Hb and CO, since saturation is stipulated as fixed rather than discussed. Question stem and options otherwise unchanged.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because tripling the partial pressure adds only \(0.6\) mL of dissolved oxygen per \(100\) mL to a starting content of \(20\) mL per \(100\) mL. Dissolved oxygen equals the solubility coefficient multiplied by partial pressure. At \(100\) mm Hg the plasma holds \(0.003 \times 100 = 0.3\) mL per \(100\) mL, and at \(300\) mm Hg it holds \(0.003 \times 300 = 0.9\) mL per \(100\) mL, an increment of \(0.6\) mL per \(100\) mL. Because hemoglobin was already almost fully loaded, the bound compartment contributes essentially nothing further. The fractional gain is therefore \(0.6/20 = 0.03\), about \(3\%\), which is why supplemental oxygen adds little content once saturation is already high. (Choice A) The calculation uses the increment in the dissolved compartment, \(0.9 - 0.3 = 0.6\) mL per \(100\) mL, divided by the original content of \(20\) mL per \(100\) mL. This yields roughly \(3\%\). It illustrates that the dissolved fraction is a small share of total blood oxygen even at supranormal partial pressures. (Choice B) This value results from dividing the total dissolved quantity after the change, \(0.9\) mL per \(100\) mL, by \(20\) mL per \(100\) mL. That treats oxygen already dissolved at baseline as newly added. The \(0.3\) mL per \(100\) mL present at \(100\) mm Hg was part of the original \(20\) mL per \(100\) mL and cannot be counted twice. (Choice C) A tenfold error in the solubility coefficient, using \(0.03\) rather than \(0.003\) mL per \(100\) mL per mm Hg, produces an increment of \(6\) mL per \(100\) mL and an apparent \(30\%\) rise. The stated coefficient is small precisely because oxygen is poorly soluble in aqueous plasma. Carrying the decimal correctly keeps the dissolved contribution in the range of tenths of a milliliter. (Choice D) This assumes content rises in proportion to partial pressure, so that tripling \(P_{\text{O}_2}\) triples content. Content is dominated by the hemoglobin bound pool, which is already near its ceiling at \(99\%\) saturation and cannot triple. Partial pressure governs only the small dissolved term. This is a Data-based and Statistical Reasoning question because you must combine a solubility coefficient with the hemoglobin bound quantity and express the dissolved portion as a percentage of the total.

---

## B4-Q11 — Circulatory Hypoxia With Normal Arterial Content

**Stem.** Three days after a large myocardial infarction, a patient has an arterial \(P_{\text{O}_2}\) of \(95\) mm Hg, a hemoglobin saturation of \(98\%\), and a hemoglobin concentration of \(15\) g/dL, yet his hands are cool and his blood lactate is climbing. How would the oxygen content of blood sampled from his pulmonary artery most likely compare with normal?

- **A.** Higher than normal, because arterial content is preserved while fewer tissues are perfused.
- **B.** Higher than normal, because sluggish flow shortens the time available for oxygen to diffuse.
- **C.** Unchanged, because arterial saturation and hemoglobin concentration are both normal.
- **D.** Lower than normal, because blood lingers in tissues while oxygen demand persists.  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 80 s |
| Confidence | 5 |

**Correct answer (D): Lower than normal, because blood lingers in tissues while oxygen demand persists.**

Citations: AP:39847-39848 'Cardiogenic shock results from the inability of the heart to maintain cardiac output. Most often, it results from' / 'a myocardial infarction (heart attack), but it may also be caused by arrhythmias, valve disorders,' | AP:35777 'The right ventricle pumps deoxygenated blood into the pulmonary trunk, which leads toward the lungs and' | AP:45924-45925 'blood is said to be deoxygenated, some oxygen is still bound to hemoglobin in its red blood cells. This provides an' / 'oxygen reserve that can be used when tissues suddenly demand more oxygen.' | AP:45917-45918 'because some tissues have a higher metabolic rate than others. Highly active tissues, such as muscle, rapidly use' / 'oxygen to produce ATP, lowering the partial pressure of oxygen in the tissue to about 20 mm Hg.' | AP:37140 'Cardiac output (CO) is a measurement of the amount of blood pumped by each ventricle in one minute.' | AAMC:1846 'Oxygen content'

**Distractors**

- **(A)** `partial_truth` . _correct arterial premise, wrong venous conclusion_ — Arterial content really is preserved, but venous content is arterial content minus what tissues remove, and an unchanged whole-body demand met by less flow means more is removed per unit volume.
  - Citation: AP:39847-39848 'Cardiogenic shock results from the inability of the heart to maintain cardiac output. Most often, it results from' / 'a myocardial infarction (heart attack)'
- **(B)** `reversed_relationship` . _transit time inverted_ — Lower flow lengthens capillary transit time rather than shortening it, so more unloading occurs per unit volume, not less.
- **(C)** `misconception` . _arterial values assumed to fix venous values_ — Normal saturation and hemoglobin set arterial content only; venous content additionally depends on the extraction fraction, which rises when cardiac output falls.
  - Citation: AP:45924-45925 'blood is said to be deoxygenated, some oxygen is still bound to hemoglobin in its red blood cells. This provides an' / 'oxygen reserve that can be used when tissues suddenly demand more oxygen.'

**Readback check.** Key content words: lower, blood, lingers, tissues, oxygen demand, persists. Stem words: myocardial infarction, arterial P_O2, 95 mm Hg, hemoglobin saturation, 98 percent, hemoglobin concentration, 15 g/dL, hands cool, blood lactate climbing, pulmonary artery, oxygen content. Overlap is limited to 'blood' and 'oxygen', shared referents present in every option. The stem never states that flow is low or that extraction rises; those must be inferred from the cool hands and the lactate. No definition-to-name, no stem echo, no restated premise, no self-justifying key. AUDIT CHANGES: citation AP:45918 corrected to the verified range AP:45917-45918, since the quotation begins on 45917; AP:39847 expanded to AP:39847-39848 because the phrase 'a myocardial infarction (heart attack)' sits on 39848. Key re-checked as unambiguous: cool extremities plus lactate in the setting of a large infarct is low-output (cardiogenic) circulatory failure, in which pooled venous oxygen content is characteristically low, so choice A cannot be defended as a second correct answer here. Explanation main-reasoning sentence tightened for accuracy. Confidence raised from 4 to 5.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because a failing pump moves less blood per minute, so each unit volume must surrender a larger share of its oxygen to cover an unchanged tissue requirement. Blood in the pulmonary artery is the pooled venous return from the whole body, so its oxygen content reflects what the tissues left behind. Arterial content here is normal, since saturation and hemoglobin concentration are both normal, which means the problem is the rate at which that content is delivered rather than the content itself. When flow falls, capillary transit time lengthens and tissues keep drawing on the oxygen that venous blood normally carries in reserve, widening the difference between arterial and venous content. The cool skin and rising lactate mark a circulatory rather than a respiratory cause of tissue hypoxia. (Choice A) Preserved arterial content sets the starting point for each pass, not the endpoint. Redistribution of flow away from skin and toward vital organs does not reduce whole-body oxygen use, so the pooled venous sample is more depleted, not less. Venous content rises only when tissues extract less than usual. (Choice B) Reduced flow lengthens rather than shortens the time a red cell spends in a capillary. More time in contact with an oxygen consuming tissue permits more unloading, not less. The direction of this reasoning is inverted. (Choice C) Normal saturation and hemoglobin concentration fix the arterial content but say nothing about how much of that content is removed on each circuit. Venous content is arterial content minus extraction, and extraction is exactly what changes when the pump fails. A normal arterial blood gas is therefore compatible with a markedly abnormal venous sample. (Choice D) With cardiac output depressed, the same whole-body oxygen requirement is met from fewer liters of blood per minute, so each liter gives up more oxygen. Venous blood normally retains a reserve of bound oxygen, and that reserve is drawn down under these conditions. The pooled sample from the pulmonary artery is correspondingly oxygen poor. This is a Reasoning about the Design and Execution of Research question because you must decide what sampling blood downstream of the tissues adds when every arterial measurement is already normal, and predict which way that value shifts.

---

## B4-Q12 — Oxygen Delivery As Flow Times Content

**Stem.** A woman with chronic anemia has an arterial oxygen content of \(10\) mL per \(100\) mL of blood and a resting cardiac output of \(9.0\) L/min. After transfusion her arterial oxygen content is \(18\) mL per \(100\) mL and her resting cardiac output settles at \(5.5\) L/min. How does her whole-body oxygen delivery after transfusion compare with the value before transfusion?

- **A.** It is about \(40\%\) lower.
- **B.** It is about \(10\%\) lower.
- **C.** It is about \(80\%\) higher.
- **D.** It is about \(10\%\) higher.  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic hard / structural hard) |
| Estimated time | 115 s |
| Confidence | 5 |
| Hard-tier gate | Honestly meets three gate conditions. (1) CONCEPT CHAINING: the student must recognise delivery as a product, convert L/min to dL/min so that the units match the content, evaluate the product at two separate time points, then form a ratio; four linked steps, none of them prompted. (3) TRUE PARTIAL-TRUTH TRAP: choice C, about 80 percent higher, is the arithmetically correct content ratio 18/10 derived from stem data, and it is the right answer to a different question, namely what would happen if flow were held constant. (4) 510-TEMPTING DISTRACTOR: choice B, about 10 percent lower, is the exactly transposed ratio 900/990, so a student who computes both products correctly but divides in the wrong order lands on a plausible option of the correct magnitude. Note on what was NOT claimed: the earlier draft also asserted DATA-TO-MECHANISM, which is withdrawn, because the ask is a numeric comparison and the compensation mechanism is not required to reach the key. |

**Correct answer (D): It is about \(10\%\) higher.**

Citations: AP:37140 'Cardiac output (CO) is a measurement of the amount of blood pumped by each ventricle in one minute.' | AP:37145 'CO = HR x SV' (rendered in the source with a multiplication sign) | AP:34266-34269 'The effects of the various' / 'anemias are widespread, because reduced numbers of RBCs or hemoglobin will result in lower levels of oxygen' / 'being delivered to body tissues. Since oxygen is required for tissue functioning, anemia produces fatigue, lethargy,' / 'and an increased risk for infection.' | AP:34270-34271 'Lack of oxygen leaves the patient short of breath, even as the heart and lungs work harder' / 'in response to the deficit.' | AP:45848 'amount of oxygen does dissolve in the blood and is transported in the bloodstream, but it is only about 1.5% of the' | AAMC:1846 'Oxygen content'

**Distractors**

- **(A)** `partial_truth` . _one factor of the product only_ — Uses the flow ratio 5.5/9.0 alone, about 0.61, and ignores that arterial content rose from 10 to 18 mL per 100 mL.
- **(B)** `process_step_confusion` . _transposed ratio_ — Computes 900/990 rather than 990/900, giving the correct magnitude with the direction reversed.
- **(C)** `partial_truth` . _content change only_ — Uses the content ratio 18/10 alone, which would be correct only if cardiac output were unchanged; the stem states it fell from 9.0 to 5.5 L/min.
  - Citation: AP:37140 'Cardiac output (CO) is a measurement of the amount of blood pumped by each ventricle in one minute.'

**Readback check.** Key is a numeric comparison, so no content words can be echoed. The stem supplies two contents and two cardiac outputs as raw data and never states that delivery is a product or which direction it moves. No definition-to-name, no stem echo, no restated premise, no self-justifying key. AUDIT CHANGES: all four values re-derived and confirmed (90 x 10 = 900 mL/min, 55 x 18 = 990 mL/min, 990/900 = 1.10; distractors 5.5/9.0 = 0.61, 900/990 = 0.91, 18/10 = 1.8). Citation AP:45847 for the 1.5 percent quotation corrected to AP:45848; AP:34269 was credited with 'Lack of oxygen leaves the patient short of breath, even as the heart and lungs work harder in response to the deficit', which in fact sits on AP:34270-34271, so the range is corrected; AP:34266 and AP:34268 consolidated into the verified range AP:34266-34269. hard_gate_conditions rewritten to drop an overclaimed DATA-TO-MECHANISM condition; the item still clears the gate on three honest conditions and remains hard. Explanation phrase 'compensatory tachycardia and elevated output' trimmed to 'elevated output', since the stem gives cardiac output but not heart rate. Stem and options unchanged.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because delivery is the product of flow and content, and the near doubling of content is largely offset by the fall in cardiac output from \(9.0\) to \(5.5\) L/min. Oxygen delivery equals cardiac output multiplied by arterial oxygen content, so both terms must be carried through the calculation. Before transfusion, \(9.0\) L/min equals \(90\) dL/min, and \(90 \times 10 = 900\) mL of oxygen per minute. After transfusion, \(5.5\) L/min equals \(55\) dL/min, and \(55 \times 18 = 990\) mL of oxygen per minute. The ratio \(990/900 = 1.10\) corresponds to a gain of roughly \(10\%\), which explains why a high resting cardiac output in chronic anemia is a compensation that is withdrawn once carrying capacity is restored. (Choice A) This tracks the fall in flow alone, since \(5.5/9.0\) is about \(0.61\). It ignores the fact that each unit volume now carries \(18\) rather than \(10\) mL of oxygen per \(100\) mL. Flow is only one of the two factors in the delivery product. (Choice B) The magnitude is right but the direction is inverted, as \(900/990\) is about \(0.91\). This arises from dividing the pre transfusion delivery by the post transfusion value rather than the reverse. Delivery rose from \(900\) to \(990\) mL/min, so the comparison must be expressed as an increase. (Choice C) This tracks content alone, since \(18/10 = 1.8\). Holding cardiac output constant would indeed raise delivery by \(80\%\), but the stem states that output fell substantially once the anemia was corrected. Both factors change here, and their product changes far less than either factor alone. (Choice D) Multiplying flow by content at each time point gives \(900\) mL/min before and \(990\) mL/min after, an increase of about one tenth. The transfusion nearly doubled the oxygen carried per unit volume, but the elevated output that had been sustaining delivery was no longer required. The net effect on delivery is therefore modest. This is a Data-based and Statistical Reasoning question because you must multiply flow by content at two separate time points and express the difference as a percentage rather than judging either factor on its own.

---

## B4-Q13 — Regional Extraction Reserve

**Stem.** During a catheterization study, systemic arterial blood contains \(20\) mL of oxygen per \(100\) mL, blood leaving the myocardium through the coronary sinus contains \(5\) mL per \(100\) mL, and blood from a resting forearm vein contains \(15\) mL per \(100\) mL. If blood flow to each tissue were held exactly constant, the largest possible percentage increase in oxygen uptake would be closest to which pair of values?

- **A.** \(300\%\) for the myocardium and \(33\%\) for the forearm
- **B.** \(75\%\) for the myocardium and \(25\%\) for the forearm
- **C.** \(25\%\) for the myocardium and \(75\%\) for the forearm
- **D.** \(33\%\) for the myocardium and \(300\%\) for the forearm  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic hard / structural hard) |
| Estimated time | 125 s |
| Confidence | 5 |
| Hard-tier gate | Honestly meets three gate conditions. (1) CONCEPT CHAINING: arteriovenous difference for each tissue, then the theoretical ceiling of complete extraction, then a ratio of ceiling to current value, performed twice and compared; no step is signalled by the stem. (3) TRUE PARTIAL-TRUTH TRAP: choice B reports the resting extraction ratios of 75 percent and 25 percent, both correctly derived from the stem data and correctly paired with their tissues, but they answer a different question. (4) 510-TEMPTING DISTRACTOR: choice A carries the two correct percentages with the tissues transposed, which is exactly where a student who computes correctly but loses track of which sample came from which bed will land. Note on what was NOT claimed: the earlier draft asserted all four conditions; the DATA-TO-MECHANISM claim is withdrawn as borderline, since the ask terminates in a numeric pair rather than in a stated mechanism. Three honest conditions clear the gate, so the hard label stands. |

**Correct answer (D): \(33\%\) for the myocardium and \(300\%\) for the forearm**

Citations: AP:36441-36442 'The coronary sinus is a large, thin-walled vein on the posterior surface of the heart lying within the' / 'atrioventricular sulcus and emptying directly into the right atrium.' | AP:34133-34134 'Oxygen release depends on the need' / 'for oxygen in the surrounding tissues, so hemoglobin rarely if ever leaves all of its oxygen behind.' | AP:45924-45925 'blood is said to be deoxygenated, some oxygen is still bound to hemoglobin in its red blood cells. This provides an' / 'oxygen reserve that can be used when tissues suddenly demand more oxygen.' | AP:36950 'Normally, cardiac muscle metabolism is entirely aerobic. Oxygen from the lungs is brought to the heart, and every' | AP:45917-45918 'because some tissues have a higher metabolic rate than others. Highly active tissues, such as muscle, rapidly use' / 'oxygen to produce ATP, lowering the partial pressure of oxygen in the tissue to about 20 mm Hg.' | AAMC:1846 'Oxygen content'

**Distractors**

- **(A)** `reversed_relationship` . _correct values, transposed tissues_ — Assigns the large reserve to the myocardium, whose coronary sinus content of 5 mL per 100 mL shows it is already the heavier extractor, and the small reserve to the forearm.
  - Citation: AP:36441-36442 'The coronary sinus is a large, thin-walled vein on the posterior surface of the heart lying within the' / 'atrioventricular sulcus and emptying directly into the right atrium.'
- **(B)** `partial_truth` . _extraction ratio answering the wrong question_ — Reports the correctly computed resting extraction ratios of 15/20 and 5/20 rather than the fractional increase in uptake still achievable at fixed flow.
- **(C)** `reversed_relationship` . _inverted extraction ratios_ — Assigns 25 percent extraction to the myocardium and 75 percent to the forearm, contradicting the coronary sinus and forearm venous contents given.
  - Citation: AP:36950 'Normally, cardiac muscle metabolism is entirely aerobic.'

**Readback check.** Key is a numeric pair, so no content words can be echoed. The stem supplies three oxygen content values and never states which tissue extracts more, never uses the words extraction, reserve or ceiling, and does not indicate the direction of the answer. No definition-to-name, no stem echo, no restated premise, no self-justifying key. AUDIT CHANGES: all values re-derived and confirmed (myocardium 20 - 5 = 15, ceiling 20/15 = 1.33 so 33 percent; forearm 20 - 15 = 5, ceiling 20/5 = 4 so 300 percent; distractor ratios 15/20 = 75 percent and 5/20 = 25 percent). The word 'percentage' was added to the stem so the ask cannot be read as an absolute increase in millilitres. Citation AP:36949 for 'Normally, cardiac muscle metabolism is entirely aerobic' corrected to AP:36950, because 36949 is the section heading 'Cardiac Muscle Metabolism' and not the sentence; AP:45918 corrected to the range AP:45917-45918; AP:36441 expanded to AP:36441-36442 and AP:34133 to AP:34133-34134, since each quoted sentence spans two lines. hard_gate_conditions reduced from four claimed conditions to three verified ones.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because at fixed flow the ceiling on uptake is set by how much unextracted oxygen still remains in the venous effluent, and the coronary sinus sample has very little left. Uptake at constant flow is proportional to the difference between arterial and venous content, and the absolute maximum that difference could reach is the full arterial content of \(20\) mL per \(100\) mL. The myocardium already removes \(20 - 5 = 15\) mL per \(100\) mL, so its uptake could rise at most by a factor of \(20/15\), about \(1.33\), a gain near \(33\%\). The resting forearm removes only \(20 - 15 = 5\) mL per \(100\) mL, so its ceiling is \(20/5 = 4\), a gain of \(300\%\). A tissue that already extracts heavily at rest has almost no extraction reserve and must instead be supplied by raising its perfusion. (Choice A) The two figures are individually correct but assigned to the wrong tissues. The coronary sinus value of \(5\) mL per \(100\) mL signals near maximal extraction, which leaves the myocardium with the smaller reserve, while the forearm venous value of \(15\) mL per \(100\) mL signals a large untapped reserve. Matching each number to the correct sample reverses this pairing. (Choice B) These are the resting extraction ratios, \(15/20 = 75\%\) for the myocardium and \(5/20 = 25\%\) for the forearm. Both are computed correctly from the data, but an extraction ratio describes what a tissue is already doing, not how much further it could go. The remaining reserve is the complement of that ratio expressed relative to current uptake. (Choice C) This inverts the resting extraction ratios, assigning the low value to the myocardium and the high value to the forearm. The coronary sinus sample is the more oxygen depleted of the two, so the myocardium is the heavier extractor. The direction of the comparison is reversed. (Choice D) Working from the ceiling of complete extraction, the myocardium can raise uptake from a difference of \(15\) to at most \(20\) mL per \(100\) mL, roughly \(33\%\), whereas the forearm can go from \(5\) to \(20\) mL per \(100\) mL, a fourfold rise. These ceilings are theoretical, since hemoglobin rarely if ever surrenders all of its bound oxygen. The practical consequence is that increased myocardial work must be met chiefly by increased coronary flow. This is a Data-based and Statistical Reasoning question because you must convert two arteriovenous differences into extraction fractions and then into the proportional reserve each bed still has available.

---

## B4-Q14 — Widening Extraction At Peak Exercise

**Stem.** At peak exercise a physically fit young man has a cardiac output of \(20\) L/min and a whole-body oxygen consumption of \(3200\) mL/min, compared with \(5\) L/min and \(250\) mL/min at rest. Arterial blood carries \(20\) mL of oxygen per \(100\) mL in both states. The oxygen content of the mixed venous blood in his pulmonary artery at peak exercise is closest to which value?

- **A.** \(0\) mL per \(100\) mL
- **B.** \(4\) mL per \(100\) mL  <- **KEY**
- **C.** \(10\) mL per \(100\) mL
- **D.** \(15\) mL per \(100\) mL

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic hard / structural hard) |
| Estimated time | 120 s |
| Confidence | 5 |
| Hard-tier gate | Honestly meets three gate conditions. (1) CONCEPT CHAINING: the student must recognise the flow times difference relationship, invert it, convert L/min to dL/min so the units match the content, apply it to the peak state, then subtract from arterial content; five linked steps with no scaffolding. (3) TRUE PARTIAL-TRUTH TRAP: choice D, 15 mL per 100 mL, is a correctly computed value from data supplied in the same sentence, namely the resting mixed venous content, and it is wrong only because it belongs to the wrong physiological state. (4) 510-TEMPTING DISTRACTOR: the same choice D is what any student who treats extraction per unit volume as a constant will select, and choice C encodes the equally common default that tissues take about half of what arrives. Note on what was NOT claimed: the earlier draft asserted DATA-TO-MECHANISM; that is withdrawn, since the peak numbers alone suffice for the key and the resting pair functions mainly as trap bait rather than as a required mechanistic step. |

**Correct answer (B): \(4\) mL per \(100\) mL**

Citations: AP:37140 'Cardiac output (CO) is a measurement of the amount of blood pumped by each ventricle in one minute.' | AP:37145 'CO = HR x SV' (rendered in the source with a multiplication sign) | AP:37180 'approximately 130 mL due to increased strength of contraction. This would increase CO to approximately 19.5 L/' min | AP:39726-39728 'The heart is a muscle and, like any muscle, it responds dramatically to exercise. For a healthy young adult, cardiac' / 'output (heart rate x stroke volume) increases in the nonathlete from approximately 5.0 liters (5.25 quarts) per' / 'minute to a maximum of about 20 liters (21 quarts) per minute.' | AP:45917-45918 'because some tissues have a higher metabolic rate than others. Highly active tissues, such as muscle, rapidly use' / 'oxygen to produce ATP, lowering the partial pressure of oxygen in the tissue to about 20 mm Hg.' | AP:45924-45925 'blood is said to be deoxygenated, some oxygen is still bound to hemoglobin in its red blood cells. This provides an' / 'oxygen reserve that can be used when tissues suddenly demand more oxygen.' | AP:34133-34134 'Oxygen release depends on the need' / 'for oxygen in the surrounding tissues, so hemoglobin rarely if ever leaves all of its oxygen behind.' | AAMC:1846 'Oxygen content'

**Distractors**

- **(A)** `misconception` . _consumption equated with delivery_ — Assumes complete extraction, but peak delivery is 4000 mL/min against a consumption of 3200 mL/min, so oxygen still returns in venous blood.
  - Citation: AP:34133-34134 'Oxygen release depends on the need' / 'for oxygen in the surrounding tissues, so hemoglobin rarely if ever leaves all of its oxygen behind.'
- **(C)** `misconception` . _fixed one half extraction assumption_ — An arteriovenous difference of 10 mL per 100 mL across 200 dL/min supports only 2000 mL/min of consumption, not the stated 3200 mL/min.
- **(D)** `partial_truth` . _resting value carried into exercise_ — Correctly computes the resting mixed venous content of 15 mL per 100 mL but assumes extraction per unit volume is unchanged at peak effort, which would cap consumption at about 1000 mL/min and cannot reconcile a fourfold flow rise with a thirteenfold consumption rise.
  - Citation: AP:45924-45925 'blood is said to be deoxygenated, some oxygen is still bound to hemoglobin in its red blood cells. This provides an' / 'oxygen reserve that can be used when tissues suddenly demand more oxygen.'

**Readback check.** Key is a numeric value, so no content words can be echoed. The stem supplies cardiac output, consumption and arterial content for two states and never states the arteriovenous difference, the extraction fraction, or the direction in which venous content moves. No definition-to-name, no stem echo, no restated premise, no self-justifying key. AUDIT CHANGES: (1) the subject was described as a 'trained cyclist' with a peak cardiac output of 20 L/min, which contradicts the very source cited, AP:39726-39728, where 20 L/min is the nonathlete maximum and trained aerobic athletes exceed 30 L/min; changed to 'a physically fit young man' so the scenario and the citation agree. (2) The sample site was 'mixed venous blood' with no anatomical anchor; now specified as the mixed venous blood in the pulmonary artery. (3) Citation AP:39724 was misnumbered onto a blank line; the quoted sentence actually spans AP:39726-39728, and the range is corrected. This was the most serious citation defect in the unit. (4) AP:45918 corrected to AP:45917-45918 and AP:34133 to AP:34133-34134. (5) All arithmetic re-derived and confirmed: 200 dL/min, 3200/200 = 16, 20 - 16 = 4; resting 250/50 = 5 and 20 - 5 = 15; peak delivery 200 x 20 = 4000 mL/min; consumption ratio 3200/250 = 12.8. (6) Choice D block given the explicit 1000 mL/min figure so the refutation is checkable. (7) hard_gate_conditions rewritten to three verified conditions.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because consumption equals flow multiplied by the arteriovenous content difference, and at \(200\) dL/min a consumption of \(3200\) mL/min requires a difference of \(16\) mL per \(100\) mL. Rearranging, the arteriovenous difference equals consumption divided by cardiac output expressed in the same volume units. At rest, \(250\) mL/min divided by \(50\) dL/min gives \(5\) mL per \(100\) mL, so mixed venous content is \(20 - 5 = 15\) mL per \(100\) mL. At peak effort, \(3200\) mL/min divided by \(200\) dL/min gives \(16\) mL per \(100\) mL, so mixed venous content falls to \(20 - 16 = 4\) mL per \(100\) mL. Cardiac output rose only fourfold while consumption rose roughly thirteenfold, and the shortfall is covered by drawing down the oxygen that venous blood normally carries in reserve. (Choice A) Complete extraction would require consumption to equal delivery, which at peak is \(20\) mL per \(100\) mL multiplied by \(200\) dL/min, or \(4000\) mL/min. The stated consumption of \(3200\) mL/min is below that, so oxygen still returns to the right heart. Hemoglobin rarely if ever surrenders all of its bound oxygen. (Choice B) Dividing \(3200\) mL/min by \(200\) dL/min yields an arteriovenous difference of \(16\) mL per \(100\) mL, leaving \(4\) mL per \(100\) mL in the venous return. Compared with the resting difference of \(5\) mL per \(100\) mL, extraction has more than tripled. This widening is what allows consumption to outpace the rise in flow. (Choice C) This corresponds to extracting exactly half the arterial content, a common default assumption. That difference of \(10\) mL per \(100\) mL across \(200\) dL/min would support a consumption of only \(2000\) mL/min, well short of the \(3200\) mL/min stated. The extraction fraction is not fixed and rises steeply with exercise intensity. (Choice D) This is the resting mixed venous content, correctly derived from the resting flow and consumption. Holding it constant would mean extraction per unit volume never changes, so a fourfold rise in output could support only a fourfold rise in consumption, to about \(1000\) mL/min. The stem states a much larger rise in consumption, which forces venous content down. This is a Data-based and Statistical Reasoning question because you must rearrange the relationship among consumption, flow, and content to solve for the oxygen still present in blood returning from the tissues.

---

## B4-Q15 — Screening Donor Units Against A Recipient Antibody Profile

**Stem.** A trauma patient needs erythrocytes urgently, and a rapid screen shows that the patient's plasma agglutinates reagent cells displaying A alone and reagent cells displaying D alone, but not reagent cells displaying B alone. The antigens present on the cells in the four available units are listed.

| Unit | A antigen | B antigen | D antigen |
| --- | --- | --- | --- |
| W | present | absent | present |
| X | absent | present | present |
| Y | absent | absent | present |
| Z | absent | present | absent |

Which unit is least likely to have its cells agglutinated in this patient?

- **A.** Unit W
- **B.** Unit X
- **C.** Unit Y
- **D.** Unit Z  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic easy / structural easy) |
| Estimated time | 70 s |
| Confidence | 5 |

**Correct answer (D): Unit Z**

Citations: AP:34930-34931 verbatim: 'Because the arms of the Y-shaped antibodies attach randomly to more than one nonself erythrocyte surface, they form clumps of erythrocytes. This process is called agglutination.' | AP:34957-34958 verbatim: 'will cause agglutination and hemolysis if they ever encounter erythrocytes with B antigens. Similarly, an individual with type B blood has naturally-formed anti-A antibodies.' | AP:34960-34961 verbatim: 'People with type O blood lack antigens A and B on their erythrocytes, but both anti-A and anti-B antibodies circulate in their blood plasma.' | AP:34966-34967 verbatim: 'Although dozens of Rh antigens have been identified, only one, designated D, is clinically important.' | AP:35046-35047 verbatim: 'If the antigen is present, the antibodies will cause visible agglutination of the cells (Figure 18.16). The blood should also be tested for Rh antibodies.' | AP:35072-35073 verbatim: 'antibodies for this antigen may be present in the blood and trigger agglutination to some degree.' | AP:35063-35064 verbatim: 'Recall that type O erythrocytes do not display A or B antigens.'

**Distractors**

- **(A)** `reversed_relationship` . _a positive screening reaction read as evidence of compatibility_ — Unit W carries exactly the two antigens the patient's plasma reacted against. A reaction in the screen identifies an antigen as a target for circulating antibody, so it marks that unit as hazardous rather than as a match.
  - Citation: AP:35046-35047 'If the antigen is present, the antibodies will cause visible agglutination of the cells (Figure 18.16). The blood should also be tested for Rh antibodies.'
- **(B)** `partial_truth` . _one flagged antigen avoided read as compatibility achieved_ — Unit X genuinely avoids A, and the B antigen it carries is harmless because the screen against B cells was negative, but it still carries D and this patient's plasma agglutinated D-positive cells.
  - Citation: AP:35072-35073 'antibodies for this antigen may be present in the blood and trigger agglutination to some degree.'
- **(C)** `misconception` . _cells lacking A and B assumed acceptable for every recipient_ — Unit Y avoids both ABO antigens, which is why it is tempting, but it carries D and this patient's screen was positive against D-displaying cells, so these cells would be agglutinated.
  - Citation: AP:34966-34967 'Although dozens of Rh antigens have been identified, only one, designated D, is clinically important.' and AP:35063-35064 'Recall that type O erythrocytes do not display A or B antigens.'

**Readback check.** Content words of the keyed option: 'Unit', 'Z'. 'Unit' is the shared column label applied identically to W, X, Y and Z, and the letter Z appears only as one row label among four in the data table, so both are shared referents equally necessary to all four options. No distinctive content word of the key appears in the stem. The stem supplies screening data and antigen inventories to reason from and never states which antigen combination is acceptable, never names a donor or recipient category, and never states which antibodies are present (only the reactions from which they are inferred). PASS. CHANGED IN AUDIT: the original version failed criterion F rather than the readback rule. Its table contained one row with every antigen absent, so a test-wise solver could select the visually null row without any transfusion knowledge, and the item was also a bare 'unknown recipient' recall of the universal-donor label. The stem was rebuilt around a plasma antibody screen, and the table redesigned so that antigen counts are W=2, X=2, Y=1, Z=1, removing the count-based freebie and placing the key on a unit that does carry an antigen. Distractor Y is now the genuine trap (cells lacking A and B, but D positive), which a solver who equates 'no A and no B' with 'safe for anyone' will select. Subtopic renamed from 'Selecting An Unmatched Unit In An Emergency' to match the new framing. All citations re-verified line by line against the source file.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because the cells in unit Z display neither of the two antigens this patient's plasma reacts against, so the circulating antibodies have nothing on them to bind. Agglutination follows when antibody in the recipient plasma attaches to an antigen on a donated erythrocyte and ties neighboring cells into clumps, so a unit is acceptable only when it lacks every antigen the recipient holds antibody against. The screen identifies two such antibodies, one directed at A and one directed at D, while the absence of a reaction against B cells shows that no anti-B is circulating. A unit may therefore carry B without consequence, whereas any unit carrying A or D will be attacked. Screening the four rows against those two criteria leaves exactly one acceptable unit. (Choice A) The cells in unit W carry both of the antigens the screen flagged. A positive screening reaction marks an antigen as a hazard rather than as a match, so these cells present the largest number of targets on the shelf, not the fewest. Anti-A and anti-D in the patient's plasma would both find a target here. (Choice B) The cells in unit X lack A, which removes the antigen responsible for the strongest preformed reaction, and the B antigen they carry is harmless because the screen against B cells was negative. They also carry D, however, and this patient's plasma reacted against D. Avoiding one of the two flagged antigens is not sufficient. (Choice C) Cells lacking both A and B are widely assumed to be acceptable for any recipient, and as far as the ABO antigens go these are. They carry D, and the screen shows this patient holds antibody against D, so these cells would be agglutinated. Rh status has to be screened alongside the ABO antigens rather than after them. (Choice D) The cells in unit Z lack A and lack D, the two antigens against which this patient holds antibody, and the B antigen they do carry meets no antibody because the screen against B cells was negative. Nothing in the patient's plasma can attach to these cells, so no clumping is expected. This is the one unit on the shelf that satisfies both criteria. This is a Scientific Reasoning and Problem Solving question because you must translate a pattern of agglutination reactions into the set of antigens the patient cannot safely receive and screen each donor profile against it.

---

## B4-Q16 — Sensitization Timing After Rh Exposure

**Stem.** An Rh-negative man who has never been transfused receives one unit of Rh-positive packed red cells in week \(0\), and those cells survive with a normal lifespan. His plasma is then tested at intervals against reagent Rh-positive erythrocytes, with the results shown.

| Week | Agglutination of reagent Rh-positive cells |
| --- | --- |
| \(0\), before transfusion | none |
| \(1\) | none |
| \(6\) | strong |
| \(20\) | strong |

Which outcome is most likely if he receives a second unit of Rh-positive cells in week \(24\)?

- **A.** The transfused cells survive with a normal lifespan, as the first unit did
- **B.** His own erythrocytes are agglutinated while the transfused cells survive
- **C.** Destruction of the transfused cells begins several weeks after the infusion
- **D.** Destruction of the transfused cells begins immediately after the infusion  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 75 s |
| Confidence | 5 |

**Correct answer (D): Destruction of the transfused cells begins immediately after the infusion**

Citations: AP:35011-35012 verbatim, with the source's minus glyph rendered here as the word 'negative' and no other change: 'In contrast to the ABO group antibodies, which are preformed, antibodies to the Rh antigen are produced only in Rh-negative individuals after exposure to the antigen.' | AP:35012-35013 verbatim: 'This process, called sensitization, occurs following a transfusion with Rh-incompatible blood' | AP:35017 verbatim: 'After exposure, the immune system of the person who has given birth begins to generate anti-Rh antibodies.' | BIO:53637-53638 verbatim: 'The first exposure does not usually cause a reaction; however, at the second exposure, enough antibodies have built up in the blood to produce a reaction that causes agglutination and breakdown of red blood cells.' | AP:34966-34967 verbatim: 'Although dozens of Rh antigens have been identified, only one, designated D, is clinically important.' | AP:34930-34931 verbatim: 'Because the arms of the Y-shaped antibodies attach randomly to more than one nonself erythrocyte surface, they form clumps of erythrocytes. This process is called agglutination.'

**Distractors**

- **(A)** `misconception` . _first exposure outcome assumed to repeat_ — The uneventful first transfusion reflected the absence of anti-D at that time, not any inherent tolerance; the week \(6\) and week \(20\) reactivity shows the plasma now contains the antibody.
  - Citation: BIO:53637-53638 'The first exposure does not usually cause a reaction; however, at the second exposure, enough antibodies have built up in the blood to produce a reaction that causes agglutination and breakdown of red blood cells.'
- **(B)** `reversed_relationship` . _antibody turned against the host's own cells_ — Anti-D binds only cells displaying the D antigen, and this man's own erythrocytes are Rh-negative and therefore present no target for it.
  - Citation: AP:34966-34967 'Although dozens of Rh antigens have been identified, only one, designated D, is clinically important.'
- **(C)** `process_step_confusion` . _production lag mistaken for action lag_ — The multi-week delay belongs to generating antibody after a first exposure, which is what the week \(1\) to week \(6\) gap records; antibody already circulating binds its antigen with no waiting period, so no such delay applies to the second unit.
  - Citation: AP:35011-35012 'antibodies to the Rh antigen are produced only in Rh-negative individuals after exposure to the antigen'

**Readback check.** Content words of the keyed option: 'Destruction', 'transfused', 'cells', 'begins', 'immediately', 'infusion'. 'Transfused' and 'cells' appear in the stem, but both are shared referents present in three or four of the options and equally necessary to each; 'Destruction', 'begins', 'immediately' and 'infusion' appear nowhere in the stem. The stem supplies serologic reactivity data and never states that antibody is present, never names anti-D, and never states any timing of destruction. PASS. CHANGED IN AUDIT: options C and D previously read 'begin to be cleared several weeks after the infusion' and 'cleared within hours of the infusion'. Neither textbook states an hours timescale for a second-exposure reaction, so the key asserted a number the sources do not support; the pair was rewritten as 'begins several weeks after' versus 'begins immediately after', which is the discrimination the sources do support (preformed antibody acts without a production lag) and which also makes C and D differ by a single word. Option A was tightened to 'as the first unit did' for parallelism, and the corresponding explanation blocks were rewritten. The Rh minus glyph in the AP:35011-35012 quotation is now rendered as 'Rh-negative' with the substitution disclosed in the citation string, since the raw glyph is a non-ASCII character. All citations re-verified line by line.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because his plasma already holds anti-D by week \(20\), so a second unit of Rh-positive cells meets circulating antibody the moment it enters his vessels. Antibody against the D antigen behaves differently from anti-A and anti-B, which are present without any transfusion history; anti-D appears only after an Rh-negative person is exposed to Rh-positive cells. The table records exactly that sequence, with no reactivity before the first unit or one week after it, then strong reactivity by week \(6\) that persists at week \(20\). The first unit survived because the antibody had not yet been made, and the interval between week \(1\) and week \(6\) is the time that production took. A repeat exposure at week \(24\) is therefore a different situation, because the antibody no longer has to be generated before it can act. (Choice A) This restates what happened after the first unit, when no anti-D was present. The week \(6\) and week \(20\) results show that his plasma has changed since then, so the earlier outcome is not expected to repeat. Survival of Rh-positive cells depends on the absence of anti-D, and that condition no longer holds. (Choice B) Anti-D attaches only to cells that display the D antigen, and his own erythrocytes lack it. His antibody therefore has no target on his own cells however high its concentration climbs. The infused cells, not his own, are the ones carrying the antigen in question. (Choice C) A delay of several weeks is the interval needed to generate antibody after a first exposure, which is what the gap between week \(1\) and week \(6\) records. Antibody that is already circulating binds its antigen without any such waiting period. The delay belongs to antibody production, not to antibody action. (Choice D) Strong reactivity at weeks \(6\) and \(20\) shows that anti-D is in his plasma before the second unit is given. The antibody attaches to D on the newly infused cells as they enter the circulation, links them into clumps, and leads to their breakdown. No interval is needed for antibody to appear, so destruction starts at once. This is a Reasoning about the Design and Execution of Research question because you must judge which claim a serial antibody time course cannot support given that the first exposure produced no early cell destruction.

---

## B4-Q17 — Vessel Obstruction During A Mismatched Transfusion

**Stem.** Thirty minutes into a transfusion, a patient's plasma free hemoglobin has risen from \(3\ \text{mg/dL}\) to \(190\ \text{mg/dL}\), and the hematocrit is \(28\%\) against the \(29\%\) recorded before the \(300\ \text{mL}\) unit was started. Oxygen delivery measured in several organs is now well below its pre-transfusion value. Which consequence of the incompatibility most directly accounts for this decline?

- **A.** Free hemoglobin released from destroyed erythrocytes exceeds the rate at which the kidneys clear it
- **B.** Expansion of blood volume by the infused fluid dilutes the recipient's own erythrocytes
- **C.** Clumped erythrocytes lodge in and obstruct the small vessels supplying the tissues  <- **KEY**
- **D.** Destruction of the transfused erythrocytes leaves oxygen-carrying capacity at its pre-transfusion value

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 80 s |
| Confidence | 5 |

**Correct answer (C): Clumped erythrocytes lodge in and obstruct the small vessels supplying the tissues**

Citations: AP:34930-34931 verbatim: 'Because the arms of the Y-shaped antibodies attach randomly to more than one nonself erythrocyte surface, they form clumps of erythrocytes. This process is called agglutination.' | AP:34932-34933 verbatim: 'The clumps of erythrocytes block small blood vessels throughout the body, depriving tissues of oxygen and nutrients.' | AP:34934-34935 verbatim: 'As the erythrocyte clumps are degraded, in a process called hemolysis, their hemoglobin is released into the bloodstream. This hemoglobin travels to the kidneys, which are responsible for filtration of the blood.' | AP:34936 verbatim: 'However, the load of hemoglobin released can easily overwhelm the kidney's capacity to clear it, and the' | AP:34941 verbatim: 'patient can quickly develop kidney failure.' | AP:34905 verbatim: 'Describe the two basic physiological consequences of transfusion of incompatible blood' | AP:34926-34928 verbatim: 'Proteins called antibodies (immunoglobulins), which are produced by certain B lymphocytes called plasma cells, attach to the antigens on the plasma membranes of the infused erythrocytes and cause them to adhere to one another.'

**Distractors**

- **(A)** `adjacent_fact` . _real downstream complication offered as the cause_ — Hemoglobin overwhelming renal clearance is a genuine consequence of an incompatible transfusion and is the route to kidney failure, but hemoglobin delivered to the kidney does not obstruct perfusion of other organs and so cannot explain a systemic fall in oxygen delivery.
  - Citation: AP:34936 'However, the load of hemoglobin released can easily overwhelm the kidney's capacity to clear it, and the' and AP:34941 'patient can quickly develop kidney failure.'
- **(B)** `scale_unit_error` . _a real mechanism invoked at the wrong order of magnitude_ — Volume expansion does dilute the erythrocyte population, but the measured hematocrit moved only from \(29\%\) to \(28\%\), roughly a three percent loss of oxygen-carrying capacity, which cannot account for delivery falling well below baseline across several organs.
  - Citation: AP:34932-34933 'The clumps of erythrocytes block small blood vessels throughout the body, depriving tissues of oxygen and nutrients.'
- **(D)** `partial_truth` . _explains the flat hematocrit but not the deficit_ — It is true that destruction of the transfused cells leaves oxygen-carrying capacity at its starting value, which is why the hematocrit did not rise; remaining at baseline, however, cannot produce delivery below baseline.
  - Citation: AP:34934-34935 'As the erythrocyte clumps are degraded, in a process called hemolysis, their hemoglobin is released into the bloodstream.'

**Readback check.** Content words of the keyed option: 'Clumped', 'erythrocytes', 'lodge', 'obstruct', 'small', 'vessels', 'supplying', 'tissues'. None appears in the stem, which uses only 'plasma free hemoglobin', 'hematocrit', 'unit', 'oxygen delivery', 'organs', 'incompatibility' and 'decline'. 'Erythrocytes' does not appear in the stem at all, so there is not even a shared referent overlap. The stem gives three measurements to reason from and states no mechanism. PASS. CHANGED IN AUDIT: the stem previously reported the hematocrit as 'remains \(29\%\), unchanged', which is internally inconsistent with infusing \(300\ \text{mL}\) of fluid into a normal blood volume (roughly a six percent dilution) and let choice B be dismissed on a number the scenario could not actually produce; it now reads \(28\%\) against a prior \(29\%\), and choice B is refuted on magnitude instead, which is both true and quantitatively checkable. Option C was reworded from a six-word fragment to a parallel twelve-word mechanism statement and option D shortened, so the four options now run 15, 13, 12 and 12 words with the key tied for shortest rather than conspicuously clipped. The choice A citation was corrected: the original pointed at AP:34934-34941 for the renal overload claim, but the sentence carrying that claim is AP:34936, which is now cited alongside it.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because antibody links erythrocytes into aggregates that physically plug small vessels and cut perfusion to the tissue beyond them. Each antibody molecule has more than one binding site, so it can attach to antigens on separate cells and tie them together. The resulting clumps are far larger than a single deformable red cell and become stuck where vessel diameter is smallest, so the patient's own oxygenated erythrocytes can no longer reach tissue downstream. That mechanical blockage is what drives delivery below the starting point, since destruction of the donated cells alone could at worst leave delivery where it began. The failure of the hematocrit to rise after \(300\ \text{mL}\) of erythrocytes, together with the sharp rise in free hemoglobin, indicates that the donated cells were broken down rather than retained. (Choice A) A free hemoglobin load that outstrips renal clearance is a genuine consequence of this reaction and is the route to kidney injury. Hemoglobin arriving at the kidney does not, however, interfere with perfusion of other organs. This choice names a real downstream problem that cannot account for a systemic drop in delivery. (Choice B) Volume expansion does lower the concentration of circulating erythrocytes when it occurs. The hematocrit has moved by a single point, from \(29\%\) to \(28\%\), a change far too small to drive delivery well below baseline in several organs. Dilution is measurable here and is not remotely large enough to be the operating mechanism. (Choice C) Aggregates of linked erythrocytes obstruct small vessels throughout the body and deprive the tissues past them of oxygen and nutrients. Because those plugs stop the patient's own circulating erythrocytes as well as the donated ones, delivery falls below the pre-transfusion level rather than merely failing to rise. This is the only listed mechanism that produces a net loss relative to baseline. (Choice D) The infused cells were indeed broken down, which is why the hematocrit did not rise despite \(300\ \text{mL}\) of red cells. That accounts for the absence of any improvement in oxygen-carrying capacity, but staying at the starting value is not the same as dropping below it. This choice explains the flat hematocrit and stops short of explaining the observed deficit. This is a Reasoning about the Design and Execution of Research question because you must identify which measurement in the panel points to a second consequence that the rise in free hemoglobin alone cannot account for.

---

## B4-Q18 — Donor Plasma Antibody Load In Whole Blood

**Stem.** A recipient whose erythrocytes carry both the A and the B antigen, and whose plasma volume is \(3.0\ \text{L}\), receives one unit of whole blood from a donor whose erythrocytes carry neither antigen. The unit delivers \(250\ \text{mL}\) of donor plasma along with the donor erythrocytes. Which outcome is most likely in the hours after the infusion?

- **A.** Rapid agglutination and breakdown of the transfused erythrocytes
- **B.** Extensive breakdown of the recipient's own erythrocytes
- **C.** No agglutination of erythrocytes of either origin
- **D.** Limited breakdown of the recipient's own erythrocytes  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic hard / structural hard) |
| Estimated time | 115 s |
| Confidence | 5 |
| Hard-tier gate | Four conditions met, assessed after removing a cue that had been softening the item. (1) CONCEPT CHAINING: three linked inferences are required, namely that donated cells lacking A and B meet no antibody in a recipient displaying both antigens, that the plasma accompanying those cells contains both anti-A and anti-B, and that the recipient's own cells display both of those targets. (2) DATA-TO-MECHANISM: the \(250\ \text{mL}\) and \(3.0\ \text{L}\) figures must be combined (\(250/3250 = 7.7\%\), a \(13\)-fold dilution) and read as a fixed, unreplenished antibody supply to choose 'limited' over 'extensive'; the volumes are the only quantitative basis in the item for that magnitude call. (3) TRUE PARTIAL-TRUTH TRAP: choice B identifies the correct antibody source and the correct target population and fails only on magnitude. (4) 510-TEMPTING DISTRACTOR: choice C is what a strong student selects who has memorised that cells lacking A and B may be given to anyone and never asks what the accompanying plasma contains. The draft's claim that B and D are 'indistinguishable' without the arithmetic was overstated and has been dropped, since the qualitative principle that the infused volume is small also points toward 'limited'; the gate still clears on the remaining conditions. |

**Correct answer (D): Limited breakdown of the recipient's own erythrocytes**

Citations: AP:34959 verbatim: 'Individuals with type AB blood, which has both antigens, do not have naturally-formed antibodies to either of these.' | AP:34960-34961 verbatim: 'People with type O blood lack antigens A and B on their erythrocytes, but both anti-A and anti-B antibodies circulate in their blood plasma.' | AP:35063-35064 verbatim: 'Recall that type O erythrocytes do not display A or B antigens.' | AP:35065-35066 verbatim: 'will not encounter any erythrocyte surface antigens on the donated blood and therefore will not be provoked into a response.' | AP:35067-35069 verbatim: 'Also, introducing type O blood into an individual with type A, B, or AB blood will nevertheless introduce antibodies against both A and B antigens, as these are always circulating in the type O blood plasma.' | AP:35069-35071 verbatim: 'This may cause problems for the recipient, but because the volume of blood transfused is much lower than the volume of the patient's own blood, the adverse effects of the relatively few infused plasma antibodies are typically limited.' | Arithmetic worked independently: \(250\ \text{mL} / (3000 + 250)\ \text{mL} = 0.0769\), i.e. \(7.7\%\) of the donor concentration, an exactly \(13\)-fold dilution.

**Distractors**

- **(A)** `reversed_relationship` . _attack aimed at the donated cells instead of the host cells_ — The donated erythrocytes display neither A nor B, and the recipient forms antibody against neither antigen because both appear on their own cells, so nothing in the recipient plasma can bind the donated cells.
  - Citation: AP:34959 'Individuals with type AB blood, which has both antigens, do not have naturally-formed antibodies to either of these.' and AP:35065-35066 'will not encounter any erythrocyte surface antigens on the donated blood and therefore will not be provoked into a response.'
- **(B)** `partial_truth` . _right target cells, wrong magnitude_ — Donor plasma antibody genuinely targets the recipient's own erythrocytes, but \(250\ \text{mL}\) diluted into \(3250\ \text{mL}\) leaves it at about \(7.7\%\) of its donor concentration and it is not replenished, so the effect is limited rather than extensive.
  - Citation: AP:35069-35071 'This may cause problems for the recipient, but because the volume of blood transfused is much lower than the volume of the patient's own blood, the adverse effects of the relatively few infused plasma antibodies are typically limited.'
- **(C)** `misconception` . _cells lacking A and B assumed to make the whole unit inert_ — This would hold only for washed or resuspended cells; whole blood also carries the donor's plasma, which contains both anti-A and anti-B, and those antibodies do find targets on the recipient's cells.
  - Citation: AP:35067-35069 'Also, introducing type O blood into an individual with type A, B, or AB blood will nevertheless introduce antibodies against both A and B antigens, as these are always circulating in the type O blood plasma.'

**Readback check.** Content words of the keyed option: 'Limited', 'breakdown', 'recipient's', 'own', 'erythrocytes'. 'Recipient' and 'erythrocytes' appear in the stem. 'Erythrocytes' is a shared referent present in all four options and equally necessary to each. 'Recipient' is the structural subject of the scenario and appears in two options, including distractor B, the nearest competitor to the key, so it confers no directional advantage toward D over B. 'Limited', 'breakdown' and 'own' appear nowhere in the stem. The stem supplies antigen inventories and two volumes as data and never states a compatibility verdict, never names a donor or recipient category, and never says whether any reaction occurs. PASS. CHANGED IN AUDIT: the draft's readback note claimed 'recipient' was 'present in all four options', which is false (it appears only in B and D); the note is corrected above and the word retained on the reasoning given. More substantively, the draft split the donation into a whole blood unit and a saline-resuspended unit, which announced to the solver that donor plasma was the variable under test and thereby handed over the key insight the hard label depends on; the washed arm was removed so the plasma volume reads as ordinary composition data, and choice C's explanation was rewritten accordingly. The donor plasma volume was changed from \(180\ \text{mL}\) to \(250\ \text{mL}\), which is closer to the plasma content of a real whole blood unit and gives an exact \(13\)-fold dilution; the draft's arithmetic (\(180/3180 = 5.7\%\), \(17.7\)-fold) was itself correct and was re-derived independently before being replaced. All seven citations were re-verified line by line; the AP:35063 line containing em dashes was deliberately quoted only from its dash-free clause.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because the donor plasma carries anti-A and anti-B, which do find targets on the recipient's cells, but \(250\ \text{mL}\) of that plasma is diluted about \(13\)-fold on entering \(3.0\ \text{L}\) of recipient plasma. Compatibility has to be assessed in both directions whenever a unit carries plasma as well as cells. The donated erythrocytes display neither A nor B, and a person whose own cells display both antigens forms antibody against neither, so the donated cells themselves are not attacked. The plasma runs the other way: a donor whose cells lack both antigens carries both anti-A and anti-B, and the recipient's cells present both of those targets. Adding \(250\ \text{mL}\) to \(3.0\ \text{L}\) gives \(3250\ \text{mL}\) in total, leaving the infused antibody at roughly \(7.7\%\) of its donor concentration, and that fixed quantity is consumed as it binds rather than being replenished. (Choice A) The donated erythrocytes display neither A nor B, and the recipient forms antibody against neither antigen because both appear on their own cells. Nothing in the recipient plasma can attach to the donated cells, so they are not the population at risk. This choice assigns the reaction to the wrong side of the pairing. (Choice B) Antibody in the donor plasma does act on the recipient's own erythrocytes, so the target population is correctly identified here. The quantity is not: the infused antibody sits at roughly one thirteenth of its donor concentration and is not replenished, so it is consumed well before most of the recipient's cells have been bound. A reaction limited by antibody supply cannot clear an entire erythrocyte population. (Choice C) This would be the outcome if the donor plasma were removed and the cells resuspended before transfusion. Whole blood carries that plasma with it, and the anti-A and anti-B it contains do find targets on the recipient's cells. Some breakdown of the recipient's own erythrocytes therefore does occur. (Choice D) Anti-A and anti-B in the donor plasma bind the recipient's erythrocytes, which display both antigens, while the small infused volume caps how much binding can occur. Diluting \(250\ \text{mL}\) into \(3250\ \text{mL}\) leaves that antibody at about \(7.7\%\) of its starting concentration. The resulting breakdown is real but modest, which is why plasma-containing units of this kind are usually tolerated. This is a Data-based and Statistical Reasoning question because you must check compatibility in both directions and then use the infused donor plasma volume against the recipient plasma volume to gauge how large the reaction can be.

---

## B4-Q19 — Carotid Sinus Compression

**Stem.** A clinician presses firmly on the neck of a supine volunteer directly over one carotid sinus, deforming and stretching the sinus wall. Mean arterial pressure drops from \(94\) to \(79\) mm Hg within \(10\) seconds. Which combination of changes most likely produced the measured decrease?

- **A.** Cardiac output rises and total peripheral resistance rises
- **B.** Cardiac output falls and total peripheral resistance falls  <- **KEY**
- **C.** Cardiac output rises and total peripheral resistance falls
- **D.** Cardiac output falls and total peripheral resistance rises

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic medium / structural easy) |
| Estimated time | 60 s |
| Confidence | 5 |

**Correct answer (B): Cardiac output falls and total peripheral resistance falls**

Citations: openstax-anatomy-physiology-2e.txt:39553-39554 verbatim: 'When blood pressure increases, the baroreceptors are stretched more tightly and initiate action potentials at a higher rate. At lower blood pressures, the degree of stretch is lower and the rate of firing is slower.' | :39558-39560 verbatim: 'When blood pressure rises too high, the baroreceptors fire at a higher rate and trigger parasympathetic stimulation of the heart. As a result, cardiac output falls. Sympathetic stimulation of the peripheral arterioles will also decrease, resulting in vasodilation. Combined, these activities cause blood pressure to fall.' | :39548-39550 verbatim: 'Vascular baroreceptors are found primarily in sinuses (small cavities) within the aorta and carotid arteries: The aortic sinuses are found in the walls of the ascending aorta just superior to the aortic valve, whereas the carotid sinuses are in the base of the internal carotid arteries.' | :39525-39526 verbatim: 'The cardioinhibitor centers slow cardiac function by decreasing heart rate and stroke volume via parasympathetic stimulation from the vagus nerve.' | :39527-39528 verbatim: 'The vasomotor centers control vessel tone or contraction of the smooth muscle in the tunica media. Changes in diameter affect peripheral resistance, pressure, and flow, which affect cardiac output.' | All five line spans re-verified against the file during this audit.

**Distractors**

- **(A)** `reversed_relationship` . _Loop run backwards_ — Raising both cardiac output and peripheral resistance is the correction for an apparently low sensed pressure. Applied here it would drive arterial pressure up, contradicting the measured decrease from \(94\) to \(79\) mm Hg.
  - Citation: openstax-anatomy-physiology-2e.txt:39561-39563 'When blood pressure drops too low, the rate of baroreceptor firing decreases. This will trigger an increase in sympathetic stimulation of the heart, causing cardiac output to increase. It will also trigger sympathetic stimulation of the peripheral vessels, resulting in vasoconstriction.'
- **(C)** `partial_truth` . _One effector limb correct_ — Falling peripheral resistance is correct, but a simultaneous rise in cardiac output would partly cancel the pressure decrease rather than produce it. The reflex does not drive its two effectors in opposite directions.
  - Citation: openstax-anatomy-physiology-2e.txt:39558-39560 'As a result, cardiac output falls. Sympathetic stimulation of the peripheral arterioles will also decrease, resulting in vasodilation.'
- **(D)** `misconception` . _Vessels always constrict to defend perfusion_ — Falling cardiac output is correct, but arteriolar constriction would raise resistance and oppose the observed pressure decrease. When the sinus signal indicates excessive pressure, arteriolar tone is released rather than increased.
  - Citation: openstax-anatomy-physiology-2e.txt:39559-39560 'Sympathetic stimulation of the peripheral arterioles will also decrease, resulting in vasodilation. Combined, these activities cause blood pressure to fall.'

**Readback check.** Content words of the keyed option: 'cardiac output', 'total peripheral resistance', 'falls'. The stem contains 'carotid sinus', 'mean arterial pressure', 'drops', 'decrease'. Neither 'cardiac output' nor 'total peripheral resistance' appears anywhere in the stem, and the stem no longer contains the verb 'falls' at all. All four combinations are physiologically realizable states, and only choice A can be excluded by the pressure identity alone, which is itself topic knowledge. AUDIT CHANGES: (1) FACTUAL ERROR in the main reasoning repaired. The draft read 'a controller that moved only one of those two terms would be fighting its own correction', which is false. Moving only one term produces a weaker correction, not a self-opposing one; it is moving the two terms in OPPOSITE directions that is self-defeating. Reworded accordingly, and the parallel clause in the choice block was aligned. (2) STEM ECHO removed. The stem verb was 'falls', which appeared twice in the keyed option but only once or not at all in the distractors, so a test-wise student could have been cued by counting the word. The stem now reads 'drops' and 'decrease'. (3) Option grid reordered so the key is B rather than D, for answer-letter balance across the batch; the grid remains systematic (both-same pair first, then the mixed pair). (4) British spellings normalized to American ('centres' to 'centers', 'realisable' to 'realizable').

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because stretching the sinus wall makes the medullary centers behave as though arterial pressure were too high, and their corrective output lowers both the volume the heart delivers per minute and the tone of the resistance vessels. Arterial pressure is set jointly by how much blood the heart ejects per minute and how strongly the arterioles oppose its exit, so a controller that pushed those two terms in opposite directions would be working against itself. Stretch receptors in the sinus wall report wall deformation rather than luminal pressure as such, which is why external compression fools them into firing faster. The cardiovascular centers answer that faster afferent traffic by slowing the heart and weakening its contraction while at the same time releasing arteriolar tone. The recorded decrease of \(15\) mm Hg therefore represents a smaller minute output arriving in a wider, less resistant vascular bed. (Choice A) This pairing is the response appropriate to a sensed pressure that is too low, not too high. Raising both minute output and vessel tone would drive arterial pressure upward, whereas the volunteer's pressure was measured to decrease. It reverses the direction of the entire loop. (Choice B) Both effector limbs move in the same direction here, which is exactly how the loop corrects an apparently elevated pressure. Reduced output arriving in a dilated bed lowers pressure faster than either change alone. This matches the measured decrease. (Choice C) The vascular half of this pairing is correct, since releasing arteriolar tone does lower resistance and pressure. The cardiac half is not, because a rise in output would partly offset the vasodilation rather than reinforce it. A controller that drove its two effectors in opposing directions would blunt its own correction. (Choice D) The cardiac half of this pairing is correct, since the heart does slow and eject less. The vascular half describes constriction, which would raise resistance and oppose the observed pressure decrease. This reflects the common assumption that vessels always tighten to defend perfusion, when in fact the reflex releases arteriolar tone whenever sensed pressure is excessive. This is a Scientific Reasoning and Problem Solving question because you must trace an artificially applied stretch signal through the reflex arc to its simultaneous effects on both the heart and the vessels.

---

## B4-Q20 — Bidirectional Reflex Gain

**Stem.** In a resting volunteer (heart rate \(68\) beats per minute, mean arterial pressure \(93\) mm Hg), an infusion that raises mean arterial pressure by \(10\) mm Hg slows the heart by \(8\) beats per minute. The volunteer then stands, and mean arterial pressure transiently falls to \(78\) mm Hg, with reflex sensitivity unchanged across this range. Which heart rate is most likely recorded at that moment?

- **A.** \(56\) beats per minute
- **B.** \(68\) beats per minute
- **C.** \(80\) beats per minute  <- **KEY**
- **D.** \(84\) beats per minute

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 75 s |
| Confidence | 5 |

**Correct answer (C): \(80\) beats per minute**

Citations: openstax-anatomy-physiology-2e.txt:37325-37326 verbatim: 'increased pressure and stretch, the rate of baroreceptor firing increases, and the cardiac centers decrease sympathetic stimulation and increase parasympathetic stimulation. As pressure and stretch decrease, the rate of' (sentence continues after a page break at :37336-37337) verbatim: 'baroreceptor firing decreases, and the cardiac centers increase sympathetic stimulation and decrease parasympathetic stimulation.' | :39561-39562 verbatim: 'When blood pressure drops too low, the rate of baroreceptor firing decreases. This will trigger an increase in sympathetic stimulation of the heart, causing cardiac output to increase.' | :23919-23921 verbatim: 'The bases of the common carotids contain stretch receptors that immediately respond to the drop in blood pressure upon standing. The orthostatic reflex is a reaction to this change in body position, so that blood pressure is maintained against the increasing effect of gravity'

**Distractors**

- **(A)** `reversed_relationship` . _Sign of the correction not flipped_ — Computing \(68 - 12 = 56\) applies the slope in the direction observed during the infusion even though pressure moved the opposite way. Slowing the heart while pressure is falling would deepen the fall rather than correct it.
  - Citation: openstax-anatomy-physiology-2e.txt:39561-39562 'When blood pressure drops too low, the rate of baroreceptor firing decreases. This will trigger an increase in sympathetic stimulation of the heart, causing cardiac output to increase.'
- **(B)** `misconception` . _Pressure defended by vessels only_ — An unchanged rate assumes the correction is purely vascular. The cardiovascular centers change heart rate and vessel tone together, and the infusion data already proved the heart rate limb is active in this volunteer.
  - Citation: openstax-anatomy-physiology-2e.txt:28197-28198 'The sympathetic system then causes the heart to beat faster and the blood vessels to constrict.'
- **(D)** `scale_unit_error` . _Quantized rather than proportional scaling_ — Treating the \(15\) mm Hg fall as two full \(10\) mm Hg steps gives \(68 + 16 = 84\). Sensitivity is stated to be unchanged across the range, so the response is proportional and \(1.5\) units yields \(12\) beats per minute, not \(16\).
  - Citation: openstax-anatomy-physiology-2e.txt:39553-39554 'When blood pressure increases, the baroreceptors are stretched more tightly and initiate action potentials at a higher rate. At lower blood pressures, the degree of stretch is lower and the rate of firing is slower.'

**Readback check.** Content words of the keyed option: the numeral \(80\) and the unit phrase 'beats per minute'. The stem contains \(68\), \(8\), \(10\), \(93\) and \(78\); the value \(80\) appears nowhere in the stem and cannot be lifted from it. 'Beats per minute' is the shared unit carried by all four options. Arithmetic re-verified during this audit: \(93 - 78 = 15\); \(15/10 = 1.5\); \(1.5 \times 8 = 12\); \(68 + 12 = 80\) (key); \(68 - 12 = 56\) (choice A); \(68 + 16 = 84\) (choice D). The stipulation 'with reflex sensitivity unchanged across this range' is load-bearing and was confirmed present, since real baroreflex gain is asymmetric and without that clause the linear extrapolation would be contestable. AUDIT CHANGES: (1) FABRICATED LINE NUMBER corrected. The draft cited ':37333' for the continuation 'baroreceptor firing decreases, and the cardiac centers increase sympathetic stimulation and decrease parasympathetic stimulation.' Line 37333 in the source file is BLANK; the quoted text actually sits at lines 37336-37337, across a page break. Citation renumbered. (2) A second citation, ':28198', truncated a sentence that begins on line 28197 with the words 'The sympathetic'; renumbered to :28197-28198. (3) 'centres' normalized to 'centers', and 'fastest of the two' corrected to 'faster of the two'. Question content, options and key unchanged.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because the loop operates in both directions, so a \(15\) mm Hg fall speeds the heart by \(1.5 \times 8 = 12\) beats per minute above the resting value of \(68\). The infusion establishes the sensitivity of the loop: \(8\) beats per minute of heart rate change for every \(10\) mm Hg of pressure change. Standing moves pressure the other way, from \(93\) to \(78\) mm Hg, a fall of \(15\) mm Hg, which is \(1.5\) of those \(10\) mm Hg units. Because the receptors are stretched less at the lower pressure, they fire less, and the correction runs opposite to the correction seen during the infusion. The predicted rate is therefore \(68 + 12 = 80\) beats per minute. (Choice A) This value applies the measured slope in the same direction as the infusion, subtracting \(12\) beats per minute from \(68\). Slowing the heart when pressure has already fallen would drive pressure lower still, which is the opposite of a corrective response. The sign of the correction must flip when the sensed pressure moves the other way. (Choice B) Leaving heart rate untouched assumes that a falling pressure is corrected by vessel tone alone. In fact the cardiovascular centers adjust the heart and the resistance vessels together, and the heart rate limb is the faster of the two. An unchanged rate is also inconsistent with the sensitivity the infusion just demonstrated. (Choice C) A \(15\) mm Hg fall is \(1.5\) units of \(10\) mm Hg, so the heart speeds by \(1.5 \times 8 = 12\) beats per minute. Added to the resting \(68\), this predicts \(80\) beats per minute. This is the value consistent with a symmetric, linear loop. (Choice D) This value rounds the \(15\) mm Hg fall up to two complete \(10\) mm Hg steps and adds \(16\) beats per minute. The stem specifies that sensitivity is unchanged across the range, so the response scales continuously rather than in whole steps. Fractional pressure changes produce fractional rate changes. This is a Reasoning about the Design and Execution of Research question because you must extract a reflex gain from a controlled pressure challenge and apply that same gain when pressure moves the opposite way.

---

## B4-Q21 — Head-Up Tilt And Resistance Adjustment

**Stem.** Over the first minute of \(70^\circ\) head-up tilt, a volunteer's stroke volume falls from \(75\) to \(50\) mL, heart rate rises from \(64\) to \(80\) beats per minute, and mean arterial pressure holds steady at \(92\) mm Hg. Mean arterial pressure equals the product of cardiac output and total peripheral resistance. How must total peripheral resistance have changed over that minute?

- **A.** It falls by about \(17\%\)
- **B.** It is essentially unchanged
- **C.** It rises by about \(17\%\)
- **D.** It rises by about \(20\%\)  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic medium / structural hard) |
| Estimated time | 110 s |
| Confidence | 5 |
| Hard-tier gate | Meets three of four, re-verified rather than rubber-stamped. (1) CONCEPT CHAINING: stroke volume times heart rate gives cardiac output, cardiac output combines with the pressure identity to give resistance, and the result must then be expressed as a percentage change; three distinct steps, none of which can be skipped. (2) DATA-TO-MECHANISM: nothing about the reflex can be inferred until the two cardiac numbers are converted into minute output; the physiological conclusion (the vascular limb must act because the cardiac limb undershoots) emerges only from the arithmetic. (4) 510-TEMPTING DISTRACTOR: choice C is the fractional fall in cardiac output (\(16.7\%\)) used in place of its reciprocal (\(20\%\)), an error that survives every qualitative check and is only caught by working the product. Confirmed that no distractor is eliminable by structure: A, B, C and D are all real directions and magnitudes for a resistance change, and the two \(17\%\) options differ from each other by direction alone. |

**Correct answer (D): It rises by about \(20\%\)**

Citations: openstax-anatomy-physiology-2e.txt:39527-39528 verbatim: 'The vasomotor centers control vessel tone or contraction of the smooth muscle in the tunica media. Changes in diameter affect peripheral resistance, pressure, and flow, which affect cardiac output.' | :39561-39563 verbatim: 'When blood pressure drops too low, the rate of baroreceptor firing decreases. This will trigger an increase in sympathetic stimulation of the heart, causing cardiac output to increase. It will also trigger sympathetic stimulation of the peripheral vessels, resulting in vasoconstriction.' | :28196-28198 verbatim: 'When a person stands up, proprioceptors indicate that the body is changing position. A signal goes to the CNS, which then sends a signal to the upper thoracic spinal cord neurons of the sympathetic division. The sympathetic system then causes the heart to beat faster and the blood vessels to constrict.' | :28191-28192 verbatim: 'When you change position from sitting or lying down to standing, your cardiovascular system has to adjust for a new challenge, keeping blood pumping up into the head while gravity is pulling more and more blood down into the legs.' | :38920-38921 (source quotation marks around the word average stripped for rendering): 'Mean arterial pressure (MAP) represents the average pressure of blood in the arteries, that is, the average force driving blood into vessels that serve the tissues.' | Arithmetic worked independently and re-checked during audit: \(75 \times 64 = 4800\); \(50 \times 80 = 4000\); \(4800/4000 = 1.20\); \(800/4800 = 0.1667\); \(4000 \times 1.1667 = 4666.7\).

**Distractors**

- **(A)** `reversed_relationship` . _Resistance tracks output instead of opposing it_ — If resistance fell alongside cardiac output, the product would fall twice over and mean arterial pressure could not hold at \(92\) mm Hg. The measured stability of pressure requires the two terms to move in opposite directions.
  - Citation: openstax-anatomy-physiology-2e.txt:39562-39563 'It will also trigger sympathetic stimulation of the peripheral vessels, resulting in vasoconstriction.'
- **(B)** `misconception` . _Heart rate alone defends pressure_ — The heart rate rise from \(64\) to \(80\) recovers only part of the lost stroke volume, so output still drops from \(4800\) to \(4000\) mL/min. With resistance unchanged, pressure would have fallen by roughly one sixth rather than holding steady.
  - Citation: openstax-anatomy-physiology-2e.txt:39527-39528 'Changes in diameter affect peripheral resistance, pressure, and flow, which affect cardiac output.'
- **(C)** `scale_unit_error` . _Complement used where the reciprocal is required_ — This is \(800/4800 = 16.7\%\), the fractional fall in cardiac output, transplanted directly onto resistance. Preserving a product requires the reciprocal factor \(4800/4000 = 1.20\), so a \(17\%\) rise leaves pressure about \(3\%\) short of \(92\) mm Hg.
  - Citation: openstax-anatomy-physiology-2e.txt:38920-38921 'Mean arterial pressure (MAP) represents the average pressure of blood in the arteries, that is, the average force driving blood into vessels that serve the tissues.'

**Readback check.** Content words of the keyed option: 'rises', 'about', '20 percent'. The stem contains 'rises from \(64\) to \(80\)' and the numbers \(70\), \(75\), \(50\), \(64\), \(80\) and \(92\). 'Rises' is a bare direction word shared with choice C and cannot select between them, and the numeral \(20\) appears nowhere in the stem. The answer must be computed rather than read: the stem supplies raw measurements (data to reason from) and never states any conclusion about resistance. AUDIT CHANGES: every calculated value was recomputed independently and all are correct, so no numbers were altered. \(75 \times 64 = 4800\); \(50 \times 80 = 4000\); \(4800/4000 = 1.20\), a \(20\%\) rise (key D); \(800/4800 = 0.1667\), the \(16.7\%\) trap (choice C); the claim in the choice C block that a \(17\%\) rise leaves pressure about \(3\%\) short checks out, since \(4000 \times 1.1667 = 4666.7\) and \(4666.7/4800 = 0.972\), i.e. \(2.8\%\) below; the claim in the choice B block that pressure would fall by roughly one sixth checks out, since \(4000/4800 = 0.833\). One citation was adjusted: the source renders the word average inside quotation marks ('the "average" pressure of blood in the arteries'), which the draft silently dropped while calling the excerpt verbatim; the excerpt is now flagged as quote-marks-stripped rather than presented as an exact transcription.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because cardiac output fell from \(4.80\) to \(4.00\) L/min, and holding pressure constant requires resistance to rise by the reciprocal of that ratio, \(4.80 / 4.00 = 1.20\). Supine output is \(75 \text{ mL} \times 64 \text{ min}^{-1} = 4800\) mL/min, and upright output is \(50 \text{ mL} \times 80 \text{ min}^{-1} = 4000\) mL/min, so the faster heart recovers only part of the stroke volume lost to venous pooling in the legs. Since pressure is the product of output and resistance, and pressure did not move, the resistance term must have grown by exactly the factor by which output shrank. That factor is \(4800 / 4000 = 1.20\), a rise of \(20\%\). This is why the reflex constricts arterioles as well as speeding the heart: the cardiac limb alone leaves a deficit that only the vascular limb can close. (Choice A) A falling resistance would compound the falling output, and pressure would drop rather than hold at \(92\) mm Hg. This treats resistance as following cardiac output rather than opposing its decline. The direction of the vascular limb is inverted. (Choice B) An unchanged resistance would leave pressure proportional to output, and pressure would have fallen by roughly one sixth. The numbers show output did fall, so the faster heart rate by itself cannot account for the stable pressure. Some vascular adjustment is mathematically required. (Choice C) This value is the fractional fall in cardiac output, \(800 / 4800 = 16.7\%\), applied directly as the fractional rise needed in resistance. Restoring a product requires multiplying by the reciprocal, not by one plus the same fraction. Raising resistance by \(17\%\) would leave pressure about \(3\%\) below its supine value. (Choice D) The output ratio is \(4800 / 4000 = 1.20\), so resistance must rise by \(20\%\) for the product to be preserved. This is larger than the fractional fall in output because the two quantities are reciprocals, not complements. It is the only value consistent with an unchanged pressure of \(92\) mm Hg. This is a Data-based and Statistical Reasoning question because you must combine the measured changes in stroke volume and heart rate into a new flow and solve for the resistance change that holds pressure constant.

---

## B4-Q22 — Cutting The Afferent Limb

**Stem.** In an anesthetized animal, only the sensory nerves leaving the carotid and aortic sinuses are cut. The animal is then monitored alongside an unoperated control for several hours. Which of the following outcomes are most likely in the operated animal?

I. Systemic arterioles lose vasomotor tone and dilate maximally
II. Beat-to-beat variability in arterial pressure increases sharply
III. A moderate hemorrhage lowers arterial pressure more than it does in the control

- **A.** I only
- **B.** II only
- **C.** II and III only  <- **KEY**
- **D.** I and III only

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic hard / structural hard) |
| Estimated time | 115 s |
| Confidence | 4 |
| Hard-tier gate | Meets three of four AFTER the option set was rebuilt; the draft version did not honestly meet the gate and was re-engineered rather than re-tiered. (1) CONCEPT CHAINING: the student must separate the afferent limb from the tonically active efferent limb, then predict what removing only the error signal does to short-term pressure stability, then separately predict the response to an imposed volume loss. Under the corrected option set each of these three determinations is load-bearing: knowing item I is false leaves B and C and still requires a verdict on III; knowing item III is true leaves C and D and still requires a verdict on I. (3) TRUE PARTIAL-TRUTH TRAP: choice B accepts a genuinely true item and stops short, and choice D yokes a genuinely true item to a false one, so a student who correctly validates one true item is still funneled into a wrong option. (4) 510-TEMPTING DISTRACTOR: choice D is the strong attractor, because a student who correctly reasons that the animal cannot defend its pressure during hemorrhage naturally over-extends that conclusion to a collapse of vasomotor tone. |

**Correct answer (C): II and III only**

Citations: openstax-anatomy-physiology-2e.txt:39539-39540 verbatim: 'Recall that mild stimulation of the skeletal muscles maintains muscle tone. A similar phenomenon occurs with vascular tone in vessels. As noted earlier, arterioles are normally partially constricted' | :37254-37255 verbatim: 'During rest, both centers provide slight stimulation to the heart, contributing to autonomic tone.' | :39554-39555 verbatim: 'When the cardiovascular center in the medulla oblongata receives this input, it triggers a reflex that maintains homeostasis' (item II is an inference from this buffering principle; the source does not describe denervation directly) | :39798 and :39807 verbatim: 'In response to blood loss, stimuli from the baroreceptors trigger the cardiovascular centers to stimulate' ... 'sympathetic responses to increase cardiac output and vasoconstriction. This typically prompts the heart rate to' | :39546-39548 verbatim: 'Baroreceptors are specialized stretch receptors located within thin areas of blood vessels and heart chambers that respond to the degree of stretch caused by the presence of blood. They send impulses to the cardiovascular center to regulate blood pressure.' | :39549-39550 verbatim: 'The aortic sinuses are found in the walls of the ascending aorta just superior to the aortic valve, whereas the carotid sinuses are in the base of the internal carotid arteries.' | All spans re-verified against the file during this audit.

**Distractors**

- **(A)** `misconception` . _Sensor treated as the source of vessel tone_ — Item I is false because the operation cut only incoming sensory nerves, leaving the outflow to the vessels and the local wall mechanisms untouched, so arterioles stay partly constricted. Excluding items II and III also denies the reflex its two demonstrable roles, buffering ordinary pressure disturbances and mounting the compensatory response to blood loss.
  - Citation: openstax-anatomy-physiology-2e.txt:39539-39540 'As noted earlier, arterioles are normally partially constricted'
- **(B)** `partial_truth` . _Buffering deficit recognized, compensatory deficit missed_ — Item II is correct, since losing the error signal leaves ordinary perturbations uncorrected. Item III is wrongly excluded, because the response to bleeding is normally triggered by a fall in sensed pressure, and an animal blind to that fall cannot recruit the faster heart and constricted vessels that limit the pressure drop.
  - Citation: openstax-anatomy-physiology-2e.txt:39798 and :39807 'In response to blood loss, stimuli from the baroreceptors trigger the cardiovascular centers to stimulate' ... 'sympathetic responses to increase cardiac output and vasoconstriction.'
- **(D)** `partial_truth` . _Correct hemorrhage prediction over-extended to total loss of tone_ — Item III is correct, since the compensatory response to bleeding is normally recruited by a fall in sensed pressure that this animal cannot register. Item I remains false, because tonic outflow and local wall mechanisms keep arterioles partly constricted after an afferent cut, and an inability to correct pressure is not the same as an inability to maintain resting vessel tone.
  - Citation: openstax-anatomy-physiology-2e.txt:37254-37255 'During rest, both centers provide slight stimulation to the heart, contributing to autonomic tone.'

**Readback check.** Content words of the keyed option: the numerals 'II' and 'III' and the word 'only', which carry no content by themselves; the substance sits in the numbered items. Item II introduces 'beat-to-beat variability' and item III introduces 'hemorrhage', neither of which appears in the stem. The stem supplies only the surgical manipulation and the comparison design, which is data to reason from, not a conclusion. AUDIT CHANGES: (1) STRUCTURAL DEFECT, the most serious finding in this unit. In the draft, the false item I appeared in three of the four options (A, B and C) and the key was the single option lacking it, so one binary judgment on item I resolved the entire question by elimination and items II and III never had to be evaluated at all. That is a one-step question wearing a three-part costume, and it is exactly the failure mode the beta testers described as Hard feeling too easy; the draft's hard_gate_conditions asserted a partial-truth trap that the option set did not actually create. The option set was rebuilt to A 'I only', B 'II only', C 'II and III only', D 'I and III only', under which no single item verdict resolves the question and every item is load-bearing. The key moves from D to C. (2) SOURCE MISMATCH: the stem said 'aortic arch', but the cited textbook places these receptors in the aortic SINUSES, 'in the walls of the ascending aorta just superior to the aortic valve' (:39549-39550); the textbook uses 'aortic arch' only for the vessel segment and its three branches (:40081). Stem changed to 'the carotid and aortic sinuses'. (3) All four choice blocks rewritten for the new option set. (4) The citation supporting item II is now labelled honestly as an inference from the stated buffering principle rather than implied to be a direct statement, since the source asserts that the reflex maintains homeostasis but does not discuss denervation lability explicitly. (5) 'centres' normalized to 'centers', 'funnelled' to 'funneled'.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because removing the sensor removes the correction, not the standing outflow that sets vessel tone, so pressure becomes unstable and poorly defended against a volume challenge while arterioles retain their tone. The medullary centers discharge tonically at rest, and arterioles are held partly constricted by that background outflow together with local mechanisms in the vessel wall; cutting the incoming sensory nerves leaves every one of those outflow pathways physically intact. What is lost is the moment-to-moment error signal, so ordinary perturbations such as posture change, respiration and movement are no longer buffered and pressure swings widely, which is item II. It is also the loss of that error signal that disables the compensatory response to bleeding, since the fall in sensed pressure is normally what recruits a faster, harder-working heart and constricted vessels, which is item III. Item I confuses the loss of a corrective input with the loss of the effector pathway itself. (Choice A) Selecting item I alone treats the sensory input as the origin of all arteriolar tone and predicts a low but stable pressure. Arterioles are partly constricted at rest by ongoing outflow and by local wall mechanisms that the operation never touched. This choice also denies the reflex its two demonstrable roles, buffering ordinary pressure disturbances and mounting the compensatory response to blood loss. (Choice B) Item II is correctly accepted, since the absence of an error signal leaves ordinary perturbations uncorrected and pressure swings widely. Item III is wrongly rejected: the response to bleeding is normally recruited by a fall in sensed pressure, and an animal that cannot register that fall tolerates the same volume loss poorly. Recognizing the buffering deficit without recognizing the compensatory deficit captures only half of what the afferent cut removes. (Choice C) Items II and III both follow from the loss of the error signal while the effector limbs remain functional. Pressure becomes labile because nothing corrects ordinary disturbances, and a hemorrhage is poorly tolerated because nothing recruits the compensatory response. Item I is excluded because tonic outflow and local wall mechanisms preserve arteriolar tone. (Choice D) Item III is correctly accepted, since the compensatory response to bleeding depends on a pressure signal this animal can no longer register. Item I is not, because only the incoming sensory nerves were cut and the outflow that holds arterioles partly constricted is untouched. The appeal of this pairing lies in assuming that an animal which cannot defend its pressure must therefore have lost vessel tone entirely, when an inability to correct pressure is not the same as an inability to maintain resting tone. This is a Data-based and Statistical Reasoning question because you must evaluate several proposed outcomes of removing the sensory limb and keep only those consistent with losing moment to moment pressure buffering.

---

## B4-Q23 — Locating The Break In The Loop

**Stem.** A patient becomes lightheaded \(15\) seconds after standing, and mean arterial pressure falls from \(94\) to \(62\) mm Hg. The fall could arise either from a depleted circulating volume acting on an intact reflex or from a reflex whose output no longer reaches its effectors. Which additional bedside measurement best separates these two possibilities?

- **A.** The change in heart rate between supine and standing  <- **KEY**
- **B.** The change in pulse pressure between supine and standing
- **C.** The mean arterial pressure fall recorded on a repeat standing trial
- **D.** The mean arterial pressure reached after \(5\) minutes of continued standing

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic medium / structural hard) |
| Estimated time | 100 s |
| Confidence | 5 |
| Hard-tier gate | Meets two of four, stated honestly rather than inflated. (1) CONCEPT CHAINING: the student must build a predicted reading for each of four measurements under each of two candidate lesions, eight predictions in all, and then select the single measurement whose two predictions diverge; no step of that construction is optional. (3) TRUE PARTIAL-TRUTH TRAP: choice B is a genuinely abnormal and physiologically correct finding in this patient, and rejecting it requires recognizing that stroke volume falls under both candidates, not that the reasoning behind it is faulty. Note on honesty: the draft also claimed condition (4), the 510-tempting distractor, but cited choice B for it, which is the same feature already counted under condition (3); one option cannot satisfy two independent gate conditions, so (4) is NOT counted here. Two genuine conditions still clear the gate, and the item remains hard on the strength of the eight-prediction construction rather than on any single trap. |

**Correct answer (A): The change in heart rate between supine and standing**

Citations: openstax-anatomy-physiology-2e.txt:28195 verbatim: 'The reason for this is a sympathetic reflex that maintains the output of the heart in response to postural change.' | :28204-28205 verbatim: 'Sometimes this does not work properly. If the sympathetic system cannot increase cardiac output, then blood pressure into the brain will decrease, and a brief neurological loss can be felt.' | :28211-28212 verbatim: 'There are two basic reasons that orthostatic hypotension can occur. First, blood volume is too low and the sympathetic reflex is not effective.' | :28225-28226 verbatim: 'The second underlying cause of orthostatic hypotension is autonomic failure. There are several disorders that result in compromised sympathetic functions.' | :39807-39808 verbatim: 'sympathetic responses to increase cardiac output and vasoconstriction. This typically prompts the heart rate to increase to about 180 to 200 contractions per minute, restoring cardiac output to normal levels.' (numeral range rendered with 'to' in place of the source dash) | :38906-38907 verbatim: 'the difference between the systolic pressure and the diastolic pressure is the pulse pressure' and :38911 verbatim: 'This may occur, for example, in patients with a low stroke volume' | All spans re-verified against the file during this audit; the pulse pressure span was corrected from the draft's :38905-38908 and :38910-38911 to the exact lines carrying the quoted text.

**Distractors**

- **(B)** `partial_truth` . _Correct inference with no discriminating power_ — A narrowed pulse pressure genuinely signals a fallen stroke volume, so the inference behind this choice is sound. Stroke volume falls under both candidates, however, from inadequate filling in one and from unopposed venous pooling in the other, so the finding is shared and cannot separate them.
  - Citation: openstax-anatomy-physiology-2e.txt:38911-38912 'This may occur, for example, in patients with a low stroke volume, which may be seen in congestive heart failure, stenosis of the aortic valve, or significant blood loss following trauma.'
- **(C)** `adjacent_fact` . _Confirmation mistaken for discrimination_ — A second standing trial reproduces the same pressure fall under either candidate, since both a low circulating volume and an undelivered reflex output produce orthostatic hypotension on every attempt. Establishing that a finding is reproducible verifies the observation without indicating which limb of the loop is at fault.
  - Citation: openstax-anatomy-physiology-2e.txt:28211-28212 and :28225-28226 'There are two basic reasons that orthostatic hypotension can occur. First, blood volume is too low and the sympathetic reflex is not effective.' ... 'The second underlying cause of orthostatic hypotension is autonomic failure.'
- **(D)** `process_step_confusion` . _Duration mistaken for discrimination_ — Pressure stays low after prolonged standing under both candidates, since neither an underfilled circulation nor an undelivered reflex output corrects itself with time. Extending the observation confirms that the fall is sustained without indicating where the loop is broken.
  - Citation: openstax-anatomy-physiology-2e.txt:28207-28208 'The name for this is orthostatic hypotension, which means that blood pressure goes below the homeostatic set point when standing.'

**Readback check.** Content words of the keyed option: 'change', 'heart rate', 'supine', 'standing'. The phrase 'heart rate' does not appear anywhere in the stem; the stem refers only to 'effectors', 'mean arterial pressure' and 'lightheaded'. 'Supine' and 'standing' are the shared experimental referent. The stem supplies the two competing hypotheses and the pressure data but never states which variable distinguishes them. The key is also not the longest option: choices C and D are both longer. AUDIT CHANGES: (1) ELIMINABLE DISTRACTOR removed. The draft's choice A was 'Mean arterial pressure recorded while the patient is supine', but the stem already supplies that value, since the pressure 'falls from \(94\) to \(62\) mm Hg' makes \(94\) the supine reading. A student could therefore discard it as redundant with no physiology whatsoever, violating the rule that nothing be eliminable without topic knowledge. It was replaced with 'The mean arterial pressure fall recorded on a repeat standing trial', which is a real bedside manoeuvre, is not stated in the stem, and requires the student to recognize that reproducibility is not mechanism-specific. (2) Options reordered so the key is A rather than C, for answer-letter balance across the batch; A and B now sit adjacent as the perfectly parallel single-variable contrast (heart rate versus pulse pressure). (3) hard_gate_conditions corrected for double-counting, as described in that field. (4) Distractor set checked for a second defensible key: any measurement of an effector output (cutaneous vasoconstriction, jugular filling, response to a fluid challenge) would also discriminate and was deliberately excluded, so the three remaining distractors are all downstream pressure or flow consequences, which are shared by both candidates. (5) 'localises' normalized to 'localizes', 'recognising' to 'recognizing'.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because an intact loop working on an underfilled circulation drives a large rise in rate, whereas a loop whose output cannot reach the effectors leaves rate nearly flat despite the same pressure signal. A useful discriminating test must produce different readings under the two candidate mechanisms, and pressure itself cannot do that job because both candidates were defined by producing the same pressure fall. The rate response is the fastest and most visible output of the loop, so its presence or absence localizes the break: a marked tachycardia proves that the sensor, the integrator and the pathway to the heart are all working and that the problem lies upstream in the volume being circulated. A rate that barely moves while pressure drops by \(32\) mm Hg indicates that the signal is being generated but not delivered. This is why clinicians read the rate change and the pressure change together rather than the pressure alone. (Choice A) Rate is the quickest output of the loop, so its behaviour reports directly on whether the loop reaches its effectors. A steep rise localizes the fault to circulating volume, while a nearly unchanged rate localizes it to the delivery of the reflex output. Only this measurement is predicted to differ between the two candidates. (Choice B) Pulse pressure does narrow when stroke volume falls, so this measurement is genuinely abnormal here. It fails as a discriminator because stroke volume falls in both candidates, from a small filling volume in the first and from unopposed venous pooling in the second. A finding shared by both possibilities cannot separate them, however real it is. (Choice C) Repeating the provocation tests whether the finding is reproducible, and it will be, because both candidates produce a pressure fall on every attempt. Confirming that an abnormality is genuine is a different task from locating where the loop is broken. The second trial returns the same shared finding as the first. (Choice D) Prolonged standing does not distinguish them, because pressure remains low in both cases: neither an underfilled circulation nor an undelivered reflex output resolves with time. Waiting merely confirms that the pressure fall is sustained. It adds duration rather than discrimination. This is a Data-based and Statistical Reasoning question because you must determine which single bedside measurement separates two candidate explanations that produce the identical fall in pressure.

---

## B4-Q24 — Leukocyte Exit From The Microcirculation

**Stem.** An investigator perfuses an isolated venule with a fixed, recirculating volume of blood and then applies an agent that irreversibly cross-links the junctional proteins binding adjacent endothelial cells to one another, leaving the endothelial cells themselves structurally intact. In untreated control vessels, roughly \(200\) leukocytes per microscopic field accumulate in the surrounding tissue over \(60\) minutes. Relative to the controls, the treated preparation most likely shows:

- **A.** an increase in tissue leukocytes and a decrease in leukocytes within the lumen
- **B.** a decrease in tissue leukocytes and an increase in leukocytes within the lumen  <- **KEY**
- **C.** a decrease in tissue leukocytes and no change in leukocytes within the lumen
- **D.** no change in tissue leukocytes and no change in leukocytes within the lumen

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **medium** (topic easy / structural medium) |
| Estimated time | 80 s |
| Confidence | 5 |

**Correct answer (B): a decrease in tissue leukocytes and an increase in leukocytes within the lumen**

Citations: VERIFIED VERBATIM AGAINST SOURCE. openstax-anatomy-physiology-2e.txt:38707-38709 'Venules as well as capillaries are the primary sites of emigration or diapedesis, in which the white blood cells adhere to the endothelial lining of the vessels and then squeeze through adjacent cells to enter the tissue fluid.'; openstax-anatomy-physiology-2e.txt:34374 'in which they squeeze through adjacent cells in a blood vessel wall.'; openstax-anatomy-physiology-2e.txt:34368-34369 'One of the most distinctive characteristics of leukocytes is their movement. Whereas erythrocytes spend their days circulating within the blood vessels, leukocytes routinely leave the bloodstream to perform their defensive functions'; openstax-anatomy-physiology-2e.txt:34064-34065 'Erythrocytes remain within the vascular network. Although leukocytes typically leave the blood vessels to perform their defensive functions, movement of erythrocytes from the blood vessels is abnormal.'; openstax-anatomy-physiology-2e.txt:38703-38704 'Venules' / 'A venule is an extremely small vein' (fragment quoted only as far as it is dash free; the full sentence carries an en dash range that this pipeline forbids reproducing). Scope: aamc-content-outline-2026.txt:1827 'Endothelial cells' and aamc-content-outline-2026.txt:1838 'Composition of blood' with :1839 'Plasma, chemicals, blood cells'. No cited line reproduced here contains an em dash or en dash; lines 34425, 34426 opening clause, 34483, 34512 and 38704 do contain en dashes in the source and were therefore quoted only in dash free fragments or paraphrased.

**Distractors**

- **(A)** `reversed_relationship` . _direction flip on an experimental manipulation_ — Predicts that binding adjacent endothelial cells more tightly together increases leukocyte passage into the tissue, which inverts the effect of the manipulation. This is the pattern expected from an agent that loosened endothelial attachments.
  - Citation: openstax-anatomy-physiology-2e.txt:38707-38709 'Venules as well as capillaries are the primary sites of emigration or diapedesis, in which the white blood cells adhere to the endothelial lining of the vessels and then squeeze through adjacent cells to enter the tissue fluid.'
- **(C)** `partial_truth` . _half right two compartment prediction that ignores mass balance_ — Correctly predicts the fall in tissue leukocytes but wrongly holds the luminal count constant. In a fixed, recirculating perfusate, cells that are no longer removed into the tissue must accumulate in the lumen.
  - Citation: openstax-anatomy-physiology-2e.txt:34368-34369 'One of the most distinctive characteristics of leukocytes is their movement. Whereas erythrocytes spend their days circulating within the blood vessels, leukocytes routinely leave the bloodstream to perform their defensive functions'
- **(D)** `misconception` . _wrong anatomical route for crossing the vessel wall_ — Assumes leukocytes cross the wall through the endothelial cell bodies themselves, which would make the junctions irrelevant. The described route is adhesion followed by squeezing between adjacent cells, which the treatment specifically blocks.
  - Citation: openstax-anatomy-physiology-2e.txt:34374 'in which they squeeze through adjacent cells in a blood vessel wall.'

**Readback check.** Content words of keyed option B: 'decrease', 'tissue leukocytes', 'increase', 'leukocytes within the lumen'. The stem contains 'leukocytes' and 'tissue' only as shared referents that all four options require equally; 'lumen' appears nowhere in the stem. The directional words 'decrease' and 'increase' appear nowhere in the stem, and the stem's only directional verb is 'accumulate', which describes the control condition rather than the predicted result. The stem supplies the manipulation and a control value but never states that leukocytes exit between endothelial cells or that sealing that route blocks exit. All four options are the same two-compartment prediction differing only in direction, so no ONLY-REAL-OPTION or SELF-JUSTIFYING KEY violation exists; no definition is offered for a name and no premise is restated. CHANGED IN AUDIT: (1) Options reordered so the key is B rather than D, since both drafts in this unit keyed D, which is a pattern tell; explanation blocks and distractor entries relabeled to match. (2) Deleted the sentence 'Erythrocytes are unaffected because they normally remain inside the vascular network in any case' from the key block, which was off-topic filler about a cell type that appears in no option. (3) Citation 34368-34369 in the Choice C entry was misnumbered: the draft's quote ran through 'in the body's tissues', which sits on line 34370; the quote is now trimmed to end at line 34369 so it is verbatim within the cited range. (4) Citation 34064 corrected to 34064-34065, the true span of the quoted two sentences. (5) Citation 38707 in the Choice A entry corrected to 38707-38709. (6) Removed the draft's citation of line 38704 as 'A venule is an extremely small vein, generally 8 to 100 micrometers in diameter', which silently rewrote the source's en dash range '8-100' as 'to' inside quotation marks; the fragment is now quoted only as far as it is verbatim, and the diameter is not load-bearing. (7) Removed the draft's 34372-34374 citation, which presented the source text with its two em dashes replaced by commas inside quotation marks and mislabeled the alteration as a 'source page break'; line 34374 alone carries the operative clause verbatim and is dash free. (8) Re-tiered easy to medium, cognitive_skill 2 to 3, time 65 to 80 seconds.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because leukocytes leave a vessel by squeezing between neighboring endothelial cells, so locking those cells to one another closes the exit route and strands the leukocytes inside a closed perfusion loop. Venules and capillaries are the principal sites at which circulating leukocytes adhere to the endothelial lining and then push between adjacent cells to reach the tissue fluid. The agent leaves the endothelial cells themselves intact and does not alter perfusion, so the only variable changed is the passability of the space between neighboring cells. With that space sealed, the roughly \(200\) cells per field that would otherwise have crossed each hour never leave the vessel. Because the perfusate is a fixed volume that recirculates rather than being continuously replenished, cells that are no longer withdrawn into the tissue remain in that volume, so the luminal count climbs above the control value. (Choice A) Binding adjacent endothelial cells more tightly to one another narrows rather than widens the space between them, so tissue accumulation should fall rather than rise. A rise in tissue counts paired with a fall in luminal counts is the pattern expected from an agent that loosened those attachments. This choice therefore predicts the result of the opposite manipulation. (Choice B) is correct. Sealing the space between adjacent endothelial cells removes the route leukocytes use to reach the tissue, so tissue accumulation drops well below the control value of about \(200\) cells per field. Those cells stay in the fixed recirculating volume instead of being withdrawn from it, so the luminal leukocyte count rises above that of the controls. (Choice C) The tissue half of this prediction is sound, since sealing the space between neighboring endothelial cells does reduce the number of leukocytes reaching the surrounding tissue. The luminal half is not, because the preparation is perfused with a fixed volume that recirculates. Leukocytes that are no longer lost to the tissue stay in that volume, so their concentration rises rather than holding steady. (Choice D) This outcome would require leukocytes to cross the wall by some route other than the space between neighboring endothelial cells, such as passage through the endothelial cell bodies themselves. The route described for venules and capillaries is adhesion to the endothelial lining followed by passage between adjacent cells, and the treatment targets that passage while sparing the cells. Sealing it therefore alters both compartments rather than leaving them unchanged. This is a Reasoning about the Design and Execution of Research question because you must predict how blocking one step in a closed recirculating preparation redistributes cells between the two compartments being counted.

---

## B4-Q25 — Granulocyte Fraction Of A Differential Count

**Stem.** A hematology analyzer reports a total leukocyte concentration of \(8{,}000\) cells per \(\mu L\), with a differential of \(62.5\%\) neutrophils, \(28\%\) lymphocytes, \(6\%\) monocytes, \(3\%\) eosinophils, and \(0.5\%\) basophils. A reviewing hematologist records the absolute concentration of the leukocytes whose cytoplasm contains abundant, highly visible granules. That recorded value is closest to:

- **A.** \(280\) cells per \(\mu L\)
- **B.** \(2{,}720\) cells per \(\mu L\)
- **C.** \(5{,}000\) cells per \(\mu L\)
- **D.** \(5{,}280\) cells per \(\mu L\)  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **medium** (topic medium / structural medium) |
| Estimated time | 85 s |
| Confidence | 5 |

**Correct answer (D): \(5{,}280\) cells per \(\mu L\)**

Citations: VERIFIED VERBATIM AGAINST SOURCE. openstax-anatomy-physiology-2e.txt:34400-34401 'When scientists first began to observe stained blood slides, it quickly became evident that leukocytes could be divided into two groups, according to whether their cytoplasm contained highly visible granules:'; :34403 'Granular leukocytes contain abundant granules within the cytoplasm. They include neutrophils, eosinophils,' continuing at :34408 'and basophils (you can view their lineage from myeloid stem cells in Figure 18.4).'; :34409-34411 'While granules are not totally lacking in agranular leukocytes, they are far fewer and less obvious. Agranular leukocytes include monocytes, which mature into macrophages that are phagocytic, and lymphocytes, which arise from the lymphoid stem cell line.'; :34477-34479 'Agranular leukocytes contain smaller, less-visible granules in their cytoplasm than do granular leukocytes. The nucleus is simple in shape, sometimes with an indentation but without distinct lobes. There are two major types of agranulocytes: lymphocytes and monocytes'; :34359 'Typically there are only 5000 to 10,000 per microliter' (source renders the unit as the micro symbol) supports the \(8{,}000\) per \(\mu L\) total; :34426-34428 'They are called neutrophils because their granules show up most clearly with stains that are chemically neutral (neither acidic nor basic). The granules are numerous but quite fine and normally appear light lilac.'; :34454 'Basophils are the least common leukocytes, typically comprising less than one percent of the total leukocyte count.' PARAPHRASED RANGE CHECKS (these source lines contain en dashes, which this pipeline forbids reproducing, so they are stated rather than quoted): :34425 neutrophils normally comprise 50 to 70 percent of total leukocyte count; :34442 eosinophils typically represent 2 to 4 percent; :34483 lymphocytes account for about 20 to 30 percent of all leukocytes; :34512 monocytes normally represent 2 to 8 percent of the total leukocyte count. All five differential values in the stem fall inside these published ranges and sum to exactly 100 percent (62.5 + 28 + 6 + 3 + 0.5 = 100). ARITHMETIC RE-VERIFIED: 62.5 + 3 + 0.5 = 66 percent; 0.66 x 8000 = 5280; 0.34 x 8000 = 2720; 0.625 x 8000 = 5000; 0.035 x 8000 = 280. Scope: aamc-content-outline-2026.txt:1838 'Composition of blood' with :1839 'Plasma, chemicals, blood cells'.

**Distractors**

- **(A)** `misconception` . _stain name misread as absence of the feature_ — Equals \(3.5\%\) of the total, counting only eosinophils and basophils and excluding neutrophils on the assumption that a neutral staining cell lacks granules. Neutrophil granules are numerous but fine, and neutrophils are the most common granular leukocyte.
  - Citation: openstax-anatomy-physiology-2e.txt:34426-34428 'They are called neutrophils because their granules show up most clearly with stains that are chemically neutral (neither acidic nor basic). The granules are numerous but quite fine and normally appear light lilac.'
- **(B)** `reversed_relationship` . _complement of the requested class_ — Equals \(34\%\) of the total, the lymphocyte plus monocyte share, which is the agranular class rather than the granular one. It answers the mirror image of the question asked.
  - Citation: openstax-anatomy-physiology-2e.txt:34478-34479 'There are two major types of agranulocytes: lymphocytes and monocytes'
- **(C)** `partial_truth` . _most abundant member substituted for the whole class_ — Equals \(62.5\%\) of the total, the neutrophil share alone, treating the granular class as if neutrophils were its only member. Eosinophils and basophils are also granular and add \(3.5\%\), or \(280\) cells per \(\mu L\).
  - Citation: openstax-anatomy-physiology-2e.txt:34403 'Granular leukocytes contain abundant granules within the cytoplasm. They include neutrophils, eosinophils,' continuing at :34408 'and basophils (you can view their lineage from myeloid stem cells in Figure 18.4).'; :34425 'The most common of all the leukocytes, neutrophils'

**Readback check.** Content words of keyed option D: the numeral \(5{,}280\) and the unit 'cells per microliter'. Neither the value \(5{,}280\) nor the sum \(66\%\) appears anywhere in the stem; both must be produced by the examinee. The unit is a shared referent carried identically by all four options. The stem supplies raw differential data to reason from and never identifies neutrophils, eosinophils, or basophils as the granular class, so the conclusion is not handed over. Every distractor is arithmetically reachable from the same dataset, so none is eliminable without knowing which lineages are granular. CHANGED IN AUDIT: (1) Stem descriptor changed from 'whose cytoplasm is filled with abundant, readily stained granules' to 'whose cytoplasm contains abundant, highly visible granules', which is the source's own criterion; 'readily stained' was an editorial flourish that cut against the very trap the item sets, since neutrophil granules stain only with a neutral stain, and it created a defensible reading under which Choice A was arguable. (2) Removed the explanation clause 'all of which arise from myeloid stem cells in the red bone marrow' from the sentence contrasting the granular and agranular classes; monocytes are also of myeloid origin (line 34512), so the contrastive framing implied a false exclusivity. (3) Choice B explanation clause 'simple, unlobed nuclei' changed to 'nuclei that lack distinct lobes' to match the source, which says the nucleus is simple in shape and sometimes indented rather than strictly unlobed; monocyte nuclei are indented or horseshoe shaped. (4) Distractor A citation corrected from :34427 to :34426-34428, the true span of the quoted two sentences. (5) Distractor B citation corrected from :34479 to :34478-34479, since 'There are two major types of' sits on line 34478. (6) NOTATION RELEASE BLOCKER FIXED: the draft citations field quoted line 34512 verbatim as 'They normally represent 2-8 percent', reproducing the source en dash; that line and lines 34425, 34483 and 34426's opening clause all carry en dashes and are now paraphrased or quoted only in dash free fragments. (7) Stem sentence 2 reworded from 'A reviewer needs' to 'A reviewing hematologist records' for a concrete actor; still three sentences.

**Explanation (as shipped).**

> This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because neutrophils, eosinophils, and basophils together make up \(66\%\) of this differential, and \(0.66 \times 8{,}000 = 5{,}280\) cells per \(\mu L\). Stained blood smears divide leukocytes into two morphological classes according to whether the cytoplasm holds abundant, highly visible granules. The granular class comprises neutrophils, eosinophils, and basophils, while the agranular class comprises lymphocytes and monocytes. Summing the granular lineages here gives \(62.5\% + 3\% + 0.5\% = 66\%\), and applying that fraction to the reported total yields \(5{,}280\) cells per \(\mu L\). The reported total also falls within the usual range of \(5{,}000\) to \(10{,}000\) leukocytes per \(\mu L\), so no correction to the total is warranted. (Choice A) This value is \(3.5\%\) of the total, the combined eosinophil and basophil share, and so counts only the two least numerous granular lineages. It excludes neutrophils, whose granules are numerous but fine and are best revealed by chemically neutral stains rather than acidic or basic ones. Faint staining does not make those granules absent, so neutrophils belong in the sum. (Choice B) This value is \(34\%\) of the total, which is the combined lymphocyte and monocyte share. Those two cell types constitute the class with smaller, less visible granules and nuclei that lack distinct lobes. Reporting them answers the opposite half of the morphological division. (Choice C) This value is \(62.5\%\) of the total, the neutrophil share alone, and it reflects the common shorthand of treating the granular class as though neutrophils were its only member. Neutrophils are indeed the most abundant granular type in a normal differential, but eosinophils and basophils carry conspicuous granules as well. Omitting their combined \(3.5\%\) understates the requested concentration by \(280\) cells per \(\mu L\). (Choice D) is correct. Adding the three granular lineages gives \(62.5\% + 3\% + 0.5\% = 66\%\) of the reported leukocytes. Multiplying \(8{,}000\) cells per \(\mu L\) by \(0.66\) yields \(5{,}280\) cells per \(\mu L\). The remaining \(34\%\), or \(2{,}720\) cells per \(\mu L\), belongs to the agranular class. This is a Reasoning about the Design and Execution of Research question because you must decide which of the reported cell categories belong in the requested group before converting percentages into an absolute concentration.

---

