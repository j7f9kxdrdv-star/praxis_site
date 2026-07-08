# Verification — Biochemistry Ch3: Non-enzymatic Protein Function & Protein Analysis (Batch 3 — in-scope depth (O2-binding, signaling, quantitation))

**Source SQL:** /Users/mikkonieveras/praxis-prep/.claude/worktrees/elegant-shaw/supabase/scripts/biochemistry_ch3_depth_batch3.sql
**Corpus:** LibreTexts Biochemistry (primary); AAMC 2026 content outline (scope)

## Summary
- Questions: 24
- Difficulty: {'hard': 13, 'medium': 11}
- Cognitive skill: {4: 4, 2: 19, 1: 1}
- Subtopics: {'Oxygen-Binding Proteins': 8, 'Signal Transduction': 4, 'Quantitative Analysis': 3, '2D Electrophoresis': 2, 'Ion-Exchange Chromatography': 2, 'Size-Exclusion Chromatography': 2, 'Affinity Chromatography': 2, 'Multi-Step Purification': 1}

## Per-question
### Q1 — Oxygen-Binding Proteins (hard, Skill 4)
**Stem:** A physiologist tabulates the fractional O2 saturation of adult hemoglobin (Hb) at several oxygen partial pressures, chosen to bracket the values encountered in the pulmonary capillaries and in peripheral tissues:

| \(P_{O_2}\) (mmHg) | Physiological site | Hb saturation (%) |
|---|---|---|
| 100 | alveolar/arterial blood | 98 |
| 40  | resting-muscle capillary  | 75 |
| 20  | exercising-muscle capillary | 32 |

Blood arriving from the lungs enters tissue capillaries at 98% saturation. Using only the tabulated values, which statement is best supported by the data?

(Assume blood equilibrates with the local \(P_{O_2}\) at each site and that Hb concentration is constant throughout.)  
**Answer:** A · **Foundation:** 1A · **Confidence:** 5  
**Answer citation:** Line 20419-20420: "hemoglobin is saturated with O2 at the high concentration found in the lungs, but it releases much of its bound O2 in respiring tissues in which O2 is much lower." Line 20391-20392: "Plots of Y (fractional saturation) vs L (pO2) are hyperbolic for myoglobin (Mb), but sigmoidal for Hb, suggesting cooperative binding of oxygen to Hb."  
**Distractor citation 1:** Choice B — Line 20419-20421: Hb "is saturated with O2 at the high concentration found in the lungs, but it releases much of its bound O2 in respiring tissues in which O2 is much lower"; the released fraction tracks the steep sigmoidal region at low tissue pO2, not simply the largest pressure drop (Line 20391: curve is "sigmoidal for Hb").  
**Distractor citation 2:** Choice C — Line 20391-20392: the Hb curve is "sigmoidal," not linear, so O2 release is not proportional to the pO2 drop; Line 20533: "As oxygen binds, the next oxygen seems to bind with higher affinity," the cooperativity that makes the curve nonlinear.  
**Distractor citation 3:** Choice D — Line 20419-20420: Hb "releases much of its bound O2 in respiring tissues in which O2 is much lower," so Hb-bound O2 (not a dissolved pool) is the source delivered to tissue across the physiological pO2 range.  

### Q2 — Oxygen-Binding Proteins (medium, Skill 2)
**Stem:** A physiologist measures the fractional O2 saturation of two purified O2-binding proteins across a range of O2 partial pressures. One protein is found in skeletal muscle; the other circulates in blood. The table below shows each protein's percent saturation at the pO2 typical of the lungs (~100 mmHg) and of metabolically active tissue (~30 mmHg):

| Protein | % saturation at 100 mmHg (lungs) | % saturation at 30 mmHg (tissue) |
|---------|----------------------------------|----------------------------------|
| Protein X | 98% | 60% |
| Protein Y | 97% | 91% |

Based on these data, which protein is the O2 transporter that carries O2 through the blood, and what is the correct reason?  
**Answer:** A · **Foundation:** 1A · **Confidence:** 5  
**Answer citation:** Line 20419-20421: "Note that hemoglobin is saturated with O2 at the high concentration found in the lungs, but it releases much of its bound O2 in respiring tissues in which O2 is much lower. In contrast, myoglobin only releases significant bound oxygen at much lower O2 concentrations. Hence, myoglobin is designed for dioxygen storage." Line 20390-20392: "Plots of Y (fractional saturation) vs L (pO2) are hyperbolic for myoglobin (Mb), but sigmoidal for Hb, suggesting cooperative binding of oxygen to Hb."  
**Distractor citation 1:** Choice B (reversed_relationship): Line 20079-20080: "Myoglobin is found in the muscles and serves as a storage protein for oxygen transported by hemoglobin." Myoglobin's higher affinity makes it the store, not the transporter — the reverse of the claim that higher affinity aids transport.  
**Distractor citation 2:** Choice C (partial_truth): Line 20419: "hemoglobin is saturated with O2 at the high concentration found in the lungs" — Hb (Protein X) must bind O2 well at high pO2, contradicting the claim that its affinity is 'low at all pressures'; its value comes from cooperativity (line 20390-20392, 'sigmoidal ... cooperative binding').  
**Distractor citation 3:** Choice D (misconception): Line 20420-20421: "myoglobin only releases significant bound oxygen at much lower O2 concentrations. Hence, myoglobin is designed for dioxygen storage." — Mb (Protein Y) loads readily but fails to unload at tissue pO2, so ease of lung-loading does not make it a transporter.  

### Q3 — Oxygen-Binding Proteins (medium, Skill 2)
**Stem:** During a bout of intense sprinting, an exercise physiologist samples the interstitial fluid of a subject's contracting quadriceps. Relative to resting values, the local capillary blood shows a pH drop from 7.40 to 7.20 and a rise in dissolved CO2, while the partial pressure of O2 in the muscle tissue has fallen sharply. The physiologist wants to describe how these local conditions alter the hemoglobin oxygen-dissociation curve within this capillary bed and what that alteration accomplishes for the sprinting muscle. Which prediction is correct?  
**Answer:** A · **Foundation:** 1A · **Confidence:** 5  
**Answer citation:** Line 20487: "Decreasing pH shifts the oxygen binding curves to the right (to decreased oxygen affinity)." Lines 20497-20498: "The binding of H+ and CO2 helps shift the equilibrium to the deoxyHb form, facilitating the release of oxygen to the tissues. It is in respiring tissues that CO2 and H+ levels are high." Line 20617: "The oxygen concentration at which Y = 0.5 is defined as P50."  
**Distractor citation 1:** Choice B (reversed): Lines 20505-20507 establish the opposite direction — "When deoxyHb with bound H+ and CO2 reaches the lungs, they dissociate as O2 builds. In the lungs, deoxyHb is converted to oxyHb." i.e., higher affinity / left shift belongs to the lungs, not acidic active tissue; contradicted by line 20487 "Decreasing pH shifts the oxygen binding curves to the right."  
**Distractor citation 2:** Choice C (partial truth): Line 20436-20437 ties the rightward shift to "lowering the apparent affinity of Hb for oxygen" which "regulate[s] the binding of dioxygen," and lines 20497-20498 state this is "facilitating the release of oxygen to the tissues" — so a right shift enhances (not reduces) unloading, making the stated consequence wrong.  
**Distractor citation 3:** Choice D (misconception): Line 20422: "the affinity of Hb for dioxygen, but not Mb, depends on pH. This is called the Bohr effect." Lines 20435-20437 note protons and CO2 "shift the binding curves of Hb for oxygen to the right" and "regulate the binding of dioxygen to Hb" within respiring tissue, refuting the claim that they act only in the lungs.  

### Q4 — Oxygen-Binding Proteins (hard, Skill 2)
**Stem:** A physiologist studies a healthy sea-level resident who ascends to a high-altitude research station, where the partial pressure of inspired O2 is markedly reduced. Over several days of acclimatization, glycolytic flux in the person's erythrocytes increases and the intracellular concentration of 2,3-bisphosphoglycerate (2,3-BPG) rises substantially above its sea-level value, while hemoglobin concentration and body temperature remain unchanged. The physiologist measures whole-blood oxygen–hemoglobin equilibrium curves before ascent and after acclimatization:

  • Before ascent: P50 = 26 mmHg
  • After acclimatization: P50 = 32 mmHg

In peripheral capillaries of actively respiring muscle, the local O2 partial pressure is about 20–30 mmHg. Compared with the sea-level condition, which single statement best describes how the acclimatized state affects hemoglobin's O2 affinity and the fraction of bound O2 that hemoglobin releases to this muscle tissue?  
**Answer:** A · **Foundation:** 1A · **Confidence:** 5  
**Answer citation:** Line 20492–20494: "Bisphosphoglycerate (BPG), a strongly negatively charged ligand, binds in a pocket lined with Lys 82, His 2, and His 143 (all on the beta chain). It fits into a cavity between the β subunits of the Hb tetramer in the T state. Notice that all these allosteric effectors lead to the formation of more salt bridges, which stabilize the T or deoxy state." Line 20435–20436: "Protons (decreasing pH), carbon dioxide, and bisphosphoglycerate, all allosteric ligands that bind distal to the oxygen binding sites on the heme, shift the binding curves of Hb for oxygen to the right, lowering the apparent affinity of Hb for oxygen." Line 20617: "The oxygen concentration at which Y = 0.5 is defined as P50."  
**Distractor citation 1:** Choice B (reversed affinity): contradicted by Line 20435–20436 stating these ligands "shift the binding curves of Hb for oxygen to the right, lowering the apparent affinity of Hb for oxygen" — right-shift means higher P50 = lower affinity, not higher.  
**Distractor citation 2:** Choice C (decreased affinity but less unloading): contradicted by Line 20497 (analogous effector logic) "The binding of H+ and CO2 helps shift the equilibrium to the deoxyHb form, facilitating the release of oxygen to the tissues"; lower affinity (T-state stabilization, Line 20494) facilitates release, so unloading increases, not decreases.  
**Distractor citation 3:** Choice D (increased affinity, more unloading): contradicted by Line 20493–20494 — BPG stabilizes the T (deoxy, low-affinity) state, not the R (high-affinity) state, so affinity decreases; and by Line 20436 that BPG lowers apparent O2 affinity.  

### Q5 — Oxygen-Binding Proteins (medium, Skill 2)
**Stem:** At the placenta, maternal and fetal blood are separated by a thin membrane across which O2 diffuses. Researchers measured the P50 (the partial pressure of O2 at which the protein is half-saturated) for the two hemoglobins present at this interface under identical conditions:

| Hemoglobin | P50 |
|---|---|
| Maternal HbA | 27 mmHg |
| Fetal HbF | 19 mmHg |

Consider a region of the placental interface where the local O2 partial pressure is such that both hemoglobins are exposed to the same pO2. Based on these data, which statement correctly describes the net movement of O2 and the reason for it?  
**Answer:** A · **Foundation:** 1A · **Confidence:** 5  
**Answer citation:** Line 20379: "Fetal hemoglobin has a higher affinity for dioxygen than adult hemoglobin." Line 20617: "The oxygen concentration at which Y = 0.5 is defined as P50."  
**Distractor citation 1:** Choice B (reversed_relationship): Line 20379 "Fetal hemoglobin has a higher affinity for dioxygen than adult hemoglobin" — a lower P50 (line 20617) indicates higher, not weaker, affinity, so the grip is stronger and net transfer is maternal-to-fetal, opposite to this choice.  
**Distractor citation 2:** Choice C (partial_truth): Line 20617 "The oxygen concentration at which Y = 0.5 is defined as P50" establishes that readier O2 loading corresponds to a LOWER P50; combined with line 20379's higher fetal affinity, HbF's P50 is lower, contradicting this choice's 'higher P50' premise.  
**Distractor citation 3:** Choice D (misconception): Lines 20375-20379 show that Hb binding curves differ by protein, and line 20379 gives HbF a higher affinity, so at equal pO2 the two hemoglobins are NOT equally saturated, refuting the equilibrium claim.  

### Q6 — Oxygen-Binding Proteins (hard, Skill 4)
**Stem:** A physiology lab measures the oxygen-binding behavior of four hemoglobin samples under standardized conditions and reports the partial pressure of O₂ at which each sample is exactly half-saturated:

| Sample | Half-saturation O₂ pressure (mm Hg) |
|--------|--------------------------------------|
| W      | 19                                   |
| X      | 26                                   |
| Y      | 31                                   |
| Z      | 12                                   |

All four samples were tested at the same temperature and total hemoglobin concentration, and each generated a normal sigmoidal saturation curve. In a respiring tissue capillary where the local O₂ pressure is low, which sample would release (unload) the greatest fraction of its bound oxygen to the surrounding tissue?  
**Answer:** A · **Foundation:** 1A · **Confidence:** 5  
**Answer citation:** Line 20617: "The oxygen concentration at which Y = 0.5 is defined as P50." Line 20487: "Decreasing pH shifts the oxygen binding curves to the right (to decreased oxygen affinity)." Lines 20524-20526: "H+ and CO2 binding shift the O2 binding curve in ways that lower the affinity for O2, leading to its release"; "facilitating the release of oxygen to the tissues." Line 20418-20419: hemoglobin "releases much of its bound O2 in respiring tissues in which O2 is much lower" — establishes that lower affinity (higher P50) maximizes unloading at low tissue pO2.  
**Distractor citation 1:** Choice B (reversed): Line 20617 defines P50 as O2 at half-saturation; a LOW P50 means half-saturation is reached at low pO2 = HIGH affinity. Line 20417-20419 notes myoglobin, with higher affinity, "only releases significant bound oxygen at much lower O2" — high-affinity proteins unload the LEAST, so Z (lowest P50) is the worst unloader, not the best.  
**Distractor citation 2:** Choice C (misconception): No textbook basis links proximity of P50 to the median with delivery. Line 20487 and 20526 tie affinity/unloading strictly to the direction of the shift (higher P50 = lower affinity = more release); a mid-range value is merely intermediate.  
**Distractor citation 3:** Choice D (partial truth): Line 20524-20526 states release is driven by lowered affinity ("lower the affinity for O2, leading to its release"), not by matching P50 to a specific tissue pO2. The coincidence between 26 mm Hg and a resting-tissue value is irrelevant; Y (P50 = 31) still delivers a greater fraction than X.  

### Q7 — Oxygen-Binding Proteins (medium, Skill 2)
**Stem:** A team studies a purified tetrameric hemoglobin using stopped-flow equipment that lets them add exactly one O2 molecule per tetramer and then measure how fast a second O2 binds to the same tetramer. In the fully deoxygenated sample, the initial O2 association is slow. After a single O2 has bound to one subunit, the researchers observe that a second O2 binds to a neighboring, still-empty subunit much faster than the first O2 did. No allosteric effectors (H+, CO2, or BPG) were added, and the total protein concentration was unchanged throughout. Which statement best accounts for the faster binding of the second O2 in this experiment?  
**Answer:** A · **Foundation:** 1A · **Confidence:** 5  
**Answer citation:** Line 20017-20018 and 20030-20032: cooperative binding in hemoglobin proceeds via structural transitions between the T (tense/deoxy) and R (relaxed/oxy) states that affect oxygen affinity. Line 20391-20392: 'binding of the first oxygen facilitates binding of the second.' Line 20482-20486: heme Fe pulled into the ring on O2 binding causes a ~0.2 nm shift that propagates to subunit interfaces, sliding them to the oxy/R conformation.  
**Distractor citation 1:** Choice B — Line 20422 and 20435-20437: the Bohr effect is that decreasing pH / H+, CO2, and BPG are allosteric ligands that shift the curve right, LOWERING O2 affinity (opposite direction), and are heterotropic effectors; the stem states no effectors were added.  
**Distractor citation 2:** Choice C — Line 20452 and 20480-20481: the T and R states are stabilized by salt bridges and H-bonds that are broken reversibly on oxygenation, i.e., noncovalent interactions — no covalent linking of subunits and binding is reversible.  
**Distractor citation 3:** Choice D — Line 20391-20392: cooperativity means the first O2 facilitates subsequent binding (sites go from low to higher affinity), contradicting a fixed high-to-low hierarchy in which later O2 would bind weaker leftover sites and thus more slowly.  

### Q8 — Oxygen-Binding Proteins (hard, Skill 2)
**Stem:** A previously healthy adult is brought to the emergency department after being trapped in a smoke-filled room. Arterial blood gas analysis shows a normal dissolved-oxygen tension (PaO₂ 95 mm Hg) but a carboxyhemoglobin fraction of 40%, meaning roughly 40% of the heme sites are occupied by carbon monoxide rather than dioxygen. A hematologist notes that on this patient's blood, the P₅₀ of the hemoglobin population still carrying dioxygen is markedly lower than the normal value of 26 mm Hg. Compared with a healthy person who has the same PaO₂ but no carbon monoxide exposure, how is oxygen delivery to peripheral tissues most accurately described, and why?  
**Answer:** A · **Foundation:** 1A · **Confidence:** 5  
**Answer citation:** Line 20175-20176: 'Carbon monoxide (CO)... also bind to the sixth coordination site, but with higher affinity than dioxygen, which can lead to CO poisoning' establishes CO occupies heme sites, reducing capacity. Line 20436: 'shift the binding curves of Hb for oxygen to the right, lowering the apparent affinity' — the inverse (left-shift) therefore raises affinity. Line 20419-20420: 'hemoglobin... releases much of its bound O2 in respiring tissues in which O2 is much lower' establishes that delivery depends on unloading, which a higher-affinity/lower-P50 curve impairs. Line 20617: 'The oxygen concentration at which Y = 0.5 is defined as P50' anchors the P50 = affinity relationship.  
**Distractor citation 1:** Choice B partial truth: Line 20175-20176 confirms CO occupies sites (capacity loss) but Line 20436 and 20419-20420 show the remaining sites do NOT unload normally when affinity rises, contradicting 'unloads normally.'  
**Distractor citation 2:** Choice C reversed relationship: Line 20419-20420 ('releases much of its bound O2 in respiring tissues') shows delivery requires release; higher affinity (a left-shift, inverse of the right-shift lowering affinity at Line 20436) reduces release, so delivery is not preserved.  
**Distractor citation 3:** Choice D misconception: Line 20419-20421 shows tissue O2 supply comes from hemoglobin-bound O2 released in tissues, not from dissolved plasma O2; a normal dissolved PaO2 cannot substitute for lost hemoglobin-bound capacity.  

### Q9 — Signal Transduction (medium, Skill 2)
**Stem:** A hormone-triggered pathway in a liver cell proceeds through four steps, with the following stoichiometry measured experimentally:

- Step 1: One hormone molecule binds one receptor, activating that single receptor (1 → 1).
- Step 2: Each activated receptor, before it is switched off, activates 70 molecules of a G protein (1 → 70).
- Step 3: Each activated G protein switches on exactly one molecule of a membrane enzyme (1 → 1).
- Step 4: Each activated membrane enzyme, before it is inactivated, catalyzes the synthesis of 500 small intracellular signaling molecules (1 → 500).

A researcher wants to test four separate single mutations, each of which alters exactly one feature of one step, to see which produces the largest reduction in the total number of intracellular signaling molecules generated per hormone molecule that binds. Which mutation would reduce that total output the MOST?

- Mutation W: causes each activated receptor to activate 35 G proteins instead of 70 (Step 2).
- Mutation X: causes each activated G protein to switch on 2 membrane enzymes instead of 1 (Step 3).
- Mutation Y: causes each hormone molecule to bind 2 receptors instead of 1 (Step 1).
- Mutation Z: makes each activated G protein switch on its one membrane enzyme 3 times faster, without changing the 1-to-1 ratio (Step 3 rate).  
**Answer:** A · **Foundation:** 3B · **Confidence:** 5  
**Answer citation:** Line 9814–9815: "Using reporter-carrying secondary antibodies for detection is an amplification step since several secondary antibodies can bind to a single primary antibody... This strategy for signal amplification..." — establishes that a one-to-many (fan-out) step is what constitutes amplification, and that adding more such multiplying steps compounds the signal.  
**Distractor citation 1:** Line 322–346 (MAPK cascade): "reactions of three enzymes involved in cell signaling in the mitogen activated protein kinase (MAPK) cascade system... MAPKKK-P in turn is an active protein kinase that doubly phosphorylates MAPKK... MAPKK-PP is in turn yet another downstream kinase, which doubly phosphorylates MAPK" — describes successive catalytic tiers where each active enzyme acts on multiple downstream molecules, the basis for distinguishing amplifying (one-to-many) from one-to-one steps.  
**Distractor citation 2:** Line 46942–46944 (GPCR): "GPCRs are cell receptors that span the membrane seven times... They bind ligands (neurotransmitters, hormones, etc.)... and, through propagated conformational changes, alter the cytoplasmic domain where they functionally interact with a heterotrimeric G protein." — anchors the receptor→G-protein activation step used in the modeled cascade and shows receptor binding as the upstream trigger, not itself the amplifying event.  
**Distractor citation 3:** Line 9812–9813: "Still, additional amplification steps may be desired to increase the signal and sensitivity of the experiment. In such cases, the secondary antibody may instead carry 'linker molecules'... which can recruit more reporter molecules in subsequent steps." — supports that only genuinely multiplicative (one-to-many) steps add amplification, grounding why altering a one-to-one step does not scale total output the way altering a fan-out step does.  

### Q10 — Signal Transduction (hard, Skill 2)
**Stem:** A cultured epithelial cell line expresses a G-protein-coupled receptor (GPCR) that, upon binding a peptide hormone, activates a stimulatory G-protein (Gsα) whose GTP-bound form stimulates adenylate cyclase to convert ATP into cAMP; the cAMP then activates protein kinase A (PKA). Researchers generate a variant cell line ("Mut") carrying a single amino-acid substitution in the catalytic residue of Gsα that is required for hydrolysis of the bound GTP; the substitution abolishes this hydrolytic step but does not alter GTP binding or the ability of Gsα to contact adenylate cyclase. Intracellular cAMP was measured in the parental ("WT") and Mut lines under matched conditions:

| Cell line | No hormone (nM cAMP) | + Hormone (nM cAMP) |
|-----------|----------------------|----------------------|
| WT        | 15                   | 480                  |
| Mut       | 470                  | 495                  |

Starting from the "no hormone" state, a saturating dose of a competitive antagonist that occupies the hormone-binding pocket of the GPCR (preventing hormone from binding, and having no effect on Gsα or adenylate cyclase) is now added to the Mut line. Which result for intracellular cAMP in the Mut line is expected, and why?  
**Answer:** A · **Foundation:** 3B · **Confidence:** 5  
**Answer citation:** Line 46454: "GTPase activity. The GTP-bound form is active, while the GDP form is inactive. Point mutations that attenuate or prevent GTP cleavage leave the protein continually activated, contributing to oncogenesis." (grounds that a GTPase-dead Gsα is constitutively active and keeps stimulating its effector — the correct outcome A.)  
**Distractor citation 1:** Choice B — Lines 46942-46944: "They bind ligands (neurotransmitters, hormones, etc.) ... and, through propagated conformational changes, alter the cytoplasmic domain where they functionally interact with a heterotrimeric G protein." This establishes the receptor→G-protein order, but line 46454 shows the GTP-locked mutant no longer requires that upstream receptor input, so a receptor-level antagonist cannot shut the pathway off (B is wrong).  
**Distractor citation 2:** Choice C — Line 46454: "The GTP-bound form is active, while the GDP form is inactive." A mutant that cannot cleave GTP stays GTP-bound (active), directly refuting the claim that it is trapped in an inactive GDP-bound state (C reverses this rule).  
**Distractor citation 3:** Choice D — Lines 46261-46262: "Explain how transmembrane receptors, including GPCRs and receptor tyrosine kinases, transduce extracellular signals into intracellular responses through conformational changes and downstream signaling cascades." The described cascade (receptor → Gsα → adenylate cyclase → cAMP → PKA) contains no hormone-dependent inhibitory brake on cyclase, so blocking the receptor cannot raise output above the stimulated level (D is unsupported).  

### Q11 — Signal Transduction (medium, Skill 2)
**Stem:** The insulin receptor is a receptor tyrosine kinase. On binding insulin, two receptor molecules are brought together in the membrane, and only once they are paired does the cytoplasmic kinase domain of an activated receptor transfer phosphate onto tyrosine residues located on the cytoplasmic tail of the other receptor in the pair. A researcher expresses three receptor variants in cultured cells and, after adding a saturating dose of insulin, measures (1) whether the receptor accumulates as pairs in the membrane and (2) the amount of phosphotyrosine detected on the receptor's cytoplasmic tail:

  Variant | Extracellular domain | Cytoplasmic kinase domain | Paired in membrane? | Phosphotyrosine on tail?
  Wild type | normal | catalytically active | Yes | High
  Variant 1 | mutation blocks insulin-induced pairing | catalytically active | No | None detected
  Variant 2 | normal | active site mutated (cannot bind ATP) | Yes | None detected

Both Variant 1 and Variant 2 fail to recruit the downstream adaptor proteins that normally bind the phosphorylated tail. Variant 1 shows no phosphotyrosine even though, on its own, its kinase domain is fully capable of catalysis. Which statement best explains this result?  
**Answer:** A · **Foundation:** 3B · **Confidence:** 5  
**Answer citation:** Line 46834-46836: "two monomeric copies of the kinase form a dimer in the membrane, activating a tyrosine kinase cytoplasmic domain, which typically phosphorylates (using ATP as a substrate), the other member of the dimer in an 'autophosphorylation' reaction." — autophosphorylation is intermolecular (one receptor acts on the other), so a receptor that cannot dimerize has no partner substrate.  
**Distractor citation 1:** Choice B — Line 46261-46262: "Explain how transmembrane receptors, including GPCRs and receptor tyrosine kinases, transduce extracellular signals into intracellular responses through conformational changes and downstream signaling cascades." The signal is transduced across the membrane by conformational change/dimerization; the ligand does not enter the cell to activate the kinase.  
**Distractor citation 2:** Choice C — Line 46830-46835: "A protein kinase is a protein enzyme that phosphorylates a protein substrate... two monomeric copies of the kinase form a dimer... which typically phosphorylates (using ATP as a substrate), the other member of the dimer." ATP binding is a property of the individual kinase active site (stated catalytically active in Variant 1); dimerization supplies the substrate, not the ATP.  
**Distractor citation 3:** Choice D — Line 46834-46836 describes phosphate transfer to the partner subunit as the mechanism generating phosphotyrosine; the text provides no phosphatase step, so a phosphatase-removal explanation is unsupported and the true cause is that no phosphate is transferred at all.  

### Q12 — Signal Transduction (hard, Skill 2)
**Stem:** A heterotrimeric G protein-coupled receptor activates its cognate Gα subunit, which then stimulates a downstream effector enzyme that produces a diffusible second messenger. A researcher engineers two versions of this Gα subunit and expresses each in otherwise identical cells:

- Variant WT: the native Gα.
- Variant Q→L: a single substitution at the catalytic glutamine in the switch-II region that positions the water molecule used to cleave the terminal phosphate of the bound guanine nucleotide.

Each cell line is given a 30-second pulse of agonist, after which the agonist is thoroughly washed out at t = 0. Intracellular second-messenger concentration (arbitrary units) is then recorded:

  Time after washout (min):   0     2      5     15
  WT:                        95    40     12     4
  Q→L:                       98    92     90    88

Assuming receptor number, effector abundance, and messenger-degrading machinery are equal in both lines, which statement best accounts for the Q→L data?  
**Answer:** A · **Foundation:** 3B · **Confidence:** 5  
**Answer citation:** Line 46454-46455: "The GTP-bound form is active, while the GDP form is inactive. Point mutations that attenuate or prevent GTP cleavage leave the protein continually activated, contributing to oncogenesis." Also line 50103-50104: for the analogous Ran GTPase, "the Ran bound GTP is hydrolyzed to GDP, causing the complex to dissociate" — establishing that GTP→GDP hydrolysis is the off-switch that terminates the active state.  
**Distractor citation 1:** Choice B (reversed active/inactive states) is refuted by line 46454: "The GTP-bound form is active, while the GDP form is inactive."  
**Distractor citation 2:** Choice C (βγ dimer / exchange-block) is refuted by line 46454-46455, which locates activity in the GTP-bound α subunit and attributes continual activation to loss of "GTP cleavage," not to an exchange defect or to βγ; and by lines 50136-50138 which distinguish hydrolysis from nucleotide exchange as separate steps (a cytoplasmic protein "promotes GTP → GDP exchange").  
**Distractor citation 3:** Choice D (faster hydrolysis prolongs signaling) is refuted by line 46454-46455: because "prevent[ing] GTP cleavage leave[s] the protein continually activated," cleavage (hydrolysis) is what ends activation, so faster cleavage would shorten — not prolong — the active state.  

### Q13 — Quantitative Analysis (hard, Skill 4)
**Stem:** A researcher runs a purified protein of unknown mass on an SDS-PAGE gel alongside a set of molecular-weight standards. After staining, the relative migration distance (Rf, the distance a band travels divided by the distance traveled by the tracking dye) is measured for each band. The standards give the following data:

| Standard | Molecular weight | Rf |
|---|---|---|
| 1 | 97.4 kDa | 0.20 |
| 2 | 66.2 kDa | 0.30 |
| 3 | 45.0 kDa | 0.40 |
| 4 | 31.0 kDa | 0.50 |
| 5 | 21.5 kDa | 0.60 |

The unknown protein migrates with an Rf of 0.44. Based on the standard data, which value is the best estimate of the unknown protein's molecular weight?  
**Answer:** A · **Foundation:** 5C · **Confidence:** 5  
**Answer citation:** Line 7490-7492: "The molecular weight of an unknown protein can be determined by comparing the protein's position on an SDS polyacrylamide gel with a series of known molecular weight standards, from which a linear plot of the ln Mr vs Rf can be used to calculate unknown molecular weights."  
**Distractor citation 1:** Line 7492 (Choice B — MW must be interpolated on the log axis, not linearly): "a linear plot of the ln Mr vs Rf can be used to calculate unknown molecular weights" — the linear relationship is in ln Mr (log MW), so treating raw MW as linear in Rf is invalid.  
**Distractor citation 2:** Line 7490-7491 (Choice C — the unknown's position must be compared to the standards by interpolation, not equated to one band): "The molecular weight of an unknown protein can be determined by comparing the protein's position on an SDS polyacrylamide gel with a series of known molecular weight standards."  
**Distractor citation 3:** Line 7486-7487 (Choice D — mobility/migration is set by sieving as a defined function of size; the migration reference must be applied consistently): "Since the amount of SDS bound per unit protein mass is constant, the overall charge density on all proteins is similar, so the electrophoretic mobility is only determined by sieving effects."  

### Q14 — Quantitative Analysis (medium, Skill 2)
**Stem:** A researcher purifying a 45-kDa enzyme runs two samples from the same purification, side by side, on a single Coomassie-stained SDS-PAGE gel. Densitometry of the 45-kDa band gives an integrated intensity of 4,200 arbitrary units in Lane A and 8,300 arbitrary units in Lane B. From this gel alone, the researcher wants to claim that Lane B contains roughly twice as much of the enzyme as Lane A. Which additional piece of information would most directly justify converting the ~2:1 intensity ratio into a valid statement about the relative amounts of enzyme loaded?  
**Answer:** A · **Foundation:** 5C · **Confidence:** 5  
**Answer citation:** Line 24221: "the resulting colorimetric or fluorescent signal is proportional to the amount of analyte present, enabling quantification" — establishes that measured signal (band intensity) scales with protein amount, the basis for converting an intensity ratio to an amount ratio once loading and linear range are controlled. Line 8775: "The disadvantages of this technique are its small dynamic range" — grounds the linear/dynamic-range caveat that limits proportional readout.  
**Distractor citation 1:** Choice B — Line 6987: "Gel filtration can determine the molecular weight of an unknown, spherical (globular) protein compared to a standard curve" and Lines 7980–7981 ("SDS standardizes the electrophoretic mobility of proteins so that separation is primarily based on molecular weight") show migration/ladder comparison establishes molecular-weight identity, a distinct question from quantitation.  
**Distractor citation 2:** Choice C — Line 7787: "This technique is 10-50 X more sensitive than Coomassie Blue staining" — silver stain's advantage is detection sensitivity, not quantitative accuracy or linearity.  
**Distractor citation 3:** Choice D — Lines 7980–7981: "By binding to proteins and imparting a uniform negative charge, SDS standardizes the electrophoretic mobility of proteins so that separation is primarily based on molecular weight" — denaturation/SDS coating governs separation by size, not the intensity-to-amount conversion.  

### Q15 — Quantitative Analysis (hard, Skill 4)
**Stem:** A researcher runs a size-exclusion (gel-filtration) column and, using the same conditions, first generates a calibration curve from five globular protein standards. The elution volume (V_e, the volume at the center of each protein's peak) for each standard is:

| Standard        | Native MW (kDa) | V_e (mL) |
|-----------------|-----------------|----------|
| Thyroglobulin   | 669             | 9.8      |
| Aldolase        | 158             | 12.7     |
| Conalbumin      | 75              | 14.2     |
| Ovalbumin       | 44              | 15.3     |
| Ribonuclease A  | 13.7            | 17.6     |

A single unknown globular protein, run on the same column under identical conditions, elutes as one symmetric peak centered at V_e = 13.45 mL. Which value is the best estimate of the unknown's native molecular weight?  
**Answer:** A · **Foundation:** 5C · **Confidence:** 5  
**Answer citation:** Line 6987-6989: "Gel filtration can determine the molecular weight of an unknown, spherical (globular) protein compared to a standard curve generated from other globular proteins of known molecular weight." and Line 7493: "ln Mr is a linear function of Kavg, the distribution coefficient when the gel is run under denaturing conditions." — establishes the log-linear MW-vs-elution calibration used to interpolate the answer (~109 kDa).  
**Distractor citation 1:** Choice B (117 kDa, linear-in-MW error): contradicted by Line 7492-7493 "a linear plot of the ln Mr vs Rf ... ln Mr is a linear function of Kavg" — the calibration is linear in the logarithm of MW, not in MW itself, so arithmetic averaging of masses is wrong.  
**Distractor citation 2:** Choice C (75 kDa, nearest-standard error): contradicted by Line 6987-6988 which describes interpolating an unknown against a continuous "standard curve," not matching it to the closest single standard; Line 6961 ("Elution volumes (Ve) for different size macromolecules") shows Ve varies continuously with size.  
**Distractor citation 3:** Choice D (200 kDa, reversed relationship): contradicted by Line 6926-6930 and 6962 — "Large species that cannot enter the pores ... elute in the void volume (V0)" (small Ve), while "Very small species ... elute near Vt" (large Ve); larger MW elutes in a smaller volume, so a protein eluting after the 158 kDa standard must be lighter, not heavier.  

### Q16 — 2D Electrophoresis (hard, Skill 2)
**Stem:** A researcher separates a four-protein mixture by two-dimensional gel electrophoresis. The first dimension is run across an immobilized pH gradient (pH 3 at the left edge, pH 10 at the right edge), after which the strip is laid horizontally atop a uniform SDS-polyacrylamide slab and the second dimension is run downward. The measured properties of the four proteins are:

| Protein | pI  | Molecular mass (kDa) |
|---------|-----|----------------------|
| W       | 4.2 | 68                   |
| X       | 8.9 | 15                   |
| Y       | 4.5 | 14                   |
| Z       | 8.6 | 71                   |

After staining, one spot appears in the upper-right corner of the developed gel (near the top edge, toward the right side). Which protein produced that spot?  
**Answer:** A · **Foundation:** 5C · **Confidence:** 5  
**Answer citation:** Line 7823-7825: 'Two-dimensional gel electrophoresis (2-DE) separates a protein mixture according to two different molecular properties in each dimension. The most commonly used is based on a first-dimension separation by isoelectric focusing (IEF) and a second dimension by molecular weight using SDS-PAGE.' Line 7813-7814: 'The migration will lead to a region where the pH matches the pI. There, the protein will have a net charge of zero and stop. Thus, amphoteric molecules are located in narrow bands where the pI coincides with the pH.'  
**Distractor citation 1:** Choice B (reversed pH axis): Line 7809-7814: 'The remaining ampholytes will migrate to their isoelectric points... The migration will lead to a region where the pH matches the pI. There, the protein will have a net charge of zero and stop.' — a protein focuses where gel pH = pI, so an acidic pI (4.2) focuses at the low-pH (left) end, not the right.  
**Distractor citation 2:** Choice C (reversed mass axis): Line 7825-7827 'a second dimension by molecular weight using SDS-PAGE... proteins are coated with SDS for separation based on molecular weight' combined with Line 7490 'Mobility becomes only a function of the molecular weight of the protein and not its shape' — SDS gives uniform charge density so small proteins migrate farther (toward the bottom), not less; a 15 kDa protein sits near the bottom, not the top.  
**Distractor citation 3:** Choice D (both axes reversed): Line 7813-7814 'the protein will have a net charge of zero and stop. Thus, amphoteric molecules are located in narrow bands where the pI coincides with the pH' (acidic pI 4.5 → left, not right) and Line 7825-7827 mass-based second-dimension separation (14 kDa → bottom, not top) — Y is displaced from the observed spot on both axes.  

### Q17 — 2D Electrophoresis (medium, Skill 2)
**Stem:** A proteomics lab is analyzing a cell lysate. On a standard 1D SDS-PAGE gel, two proteins of interest, Protein X and Protein Y, both migrate as a single overlapping band at an apparent molecular weight of 45 kDa. Suspecting the band contains two distinct species, a researcher measures the isoelectric points of the purified proteins and finds pI = 5.2 for Protein X and pI = 8.6 for Protein Y. The lysate is then re-run using two-dimensional gel electrophoresis, in which isoelectric focusing across a pH 3–11 gradient precedes the SDS-PAGE step. Which of the following best describes the expected result for Protein X and Protein Y on the 2D gel, and the reason for it?  
**Answer:** A · **Foundation:** 5C · **Confidence:** 5  
**Answer citation:** Line 7823-7825: "Two-dimensional gel electrophoresis (2-DE) separates a protein mixture according to two different molecular properties in each dimension. The most commonly used is based on a first-dimension separation by isoelectric focusing (IEF) and a second dimension by molecular weight using SDS-PAGE." Line 7828: the second-dimension SDS-PAGE is run "at 90° to the direction of the initial isoelectric focusing experiment," i.e., IEF sets horizontal position first. Line 7813-7814: "The migration will lead to a region where the pH matches the pI. There, the protein will have a net charge of zero and stop."  
**Distractor citation 1:** Choice B — Line 7980-7981: "By binding to proteins and imparting a uniform negative charge, SDS standardizes the electrophoretic mobility of proteins so that separation is primarily based on molecular weight." (Since both are ~45 kDa, the size dimension cannot resolve them.)  
**Distractor citation 2:** Choice C — Line 7980-7982: SDS-PAGE separation is "primarily based on molecular weight," while "Isoelectric Focusing (IEF): Separates proteins based on their isoelectric points (pI)" — the dimensions are independent, not both charge-based.  
**Distractor citation 3:** Choice D — Line 7811-7814: "Proteins initially in regions with a pH below their isoelectric point are positively charged and migrate toward the cathode... The migration will lead to a region where the pH matches the pI. There, the protein will have a net charge of zero and stop" — proteins halt at their pI, not at the anode.  

### Q18 — Ion-Exchange Chromatography (hard, Skill 2)
**Stem:** A purification protocol calls for capturing a recombinant enzyme (isoelectric point pI = 9.4) directly from a clarified cell lysate. The technician equilibrates a chromatography column and loads the sample in a buffer held at pH 7.4, then washes with several column volumes of the same low-salt buffer. To ensure the enzyme is retained on the resin (rather than washing straight through with the flow-through fraction), which resin should the technician have packed into the column?

A. A resin bearing covalently attached diethylaminoethyl (DEAE) groups, which are protonated and positively charged at pH 7.4
B. A resin bearing covalently attached carboxymethyl (CM) groups, which are deprotonated and negatively charged at pH 7.4
C. A resin bearing covalently attached quaternary ammonium groups, which carry a fixed positive charge at pH 7.4
D. A resin bearing porous, uncharged cross-linked dextran beads that fractionate solutes strictly by hydrodynamic radius  
**Answer:** B · **Foundation:** 5C · **Confidence:** 5  
**Answer citation:** Line 7008: 'cation exchange resins carry a negative charge and are used to separate positively charged molecules (cations).' Line 6994-6995: 'positively charged proteins will bind to a resin containing negatively charged groups, like the carboxymethyl group, CM (-OCH2COO-).' Line 7811: 'Proteins initially in regions with a pH below their isoelectric point are positively charged.'  
**Distractor citation 1:** Choice A (DEAE): Line 7004-7005: 'negatively charged proteins will bind to a resin containing positively charged groups, like the diethylaminoethyl group, DEAE (-OCH2CH2NH(C2H5)2+)' — confirms DEAE is positive (anion exchanger), which retains net-negative, not net-positive, proteins.  
**Distractor citation 2:** Choice C (quaternary ammonium): Line 7005 & 7007: 'a quaternary ethyl amino group, QAE' and 'Anion exchange resins carry a positive charge and are used to retain and separate negatively charged compounds (anions)' — a fixed-positive resin is an anion exchanger, not a binder of net-positive proteins.  
**Distractor citation 3:** Choice D (size exclusion): Line 6851 & 6863-6864: 'size exclusion chromatography, in which proteins can be separated according to their size/shape'; the beads 'have tiny openings/pores' — separates by size, carries no fixed charge, cannot retain by charge.  

### Q19 — Ion-Exchange Chromatography (medium, Skill 2)
**Stem:** A biochemist loads a mixture of four purified proteins onto a carboxymethyl (CM) cation-exchange column that has been equilibrated in a pH 6.0 buffer. After the unbound material washes through, the column is developed with a continuous gradient that raises the NaCl concentration from 0 M to 1.0 M. Each protein's net charge at pH 6.0 and its molecular weight are given below:

| Protein | Net charge at pH 6.0 | Molecular weight (kDa) |
|---------|----------------------|------------------------|
|   W     |        +2            |          64            |
|   X     |        +8            |          18            |
|   Y     |        +4            |          45            |
|   Z     |        +6            |          30            |

Assuming the four proteins bind the resin only through their net charge, which protein requires the highest NaCl concentration to elute and therefore appears in the last collected fraction?  
**Answer:** B · **Foundation:** 5C · **Confidence:** 5  
**Answer citation:** Line 7011-7012: "solute molecules will exchange with the buffer ions as each competes for the binding sites on the resin. The length of retention for each solute depends upon the strength of its charge. The most weakly charged compounds will elute first, followed by those with successively stronger charges." Line 7003: "The most positively charged protein will be eluted last, at the highest salt concentration." Line 7026-7027: proteins "can be eluted by increasing the Na+ concentration in the elution buffer stepwise or by using a salt concentration gradient."  
**Distractor citation 1:** Choice A (reversed relationship): Line 7012 states "The most weakly charged compounds will elute first," so the +2 protein W elutes first, not last — the reverse of the correct ranking.  
**Distractor citation 2:** Choice C (size-exclusion confusion): Lines 7006-7009 establish that ion exchange "separates compounds based on their ionic charge," not molecular weight; the separation of proteins by size is a different technique (size-exclusion, line 6865-6867), so ordering by the 45 kDa mass is invalid.  
**Distractor citation 3:** Choice D (partial truth): Line 7012 requires ranking by "successively stronger charges," and line 7003 specifies "The most positively charged protein will be eluted last"; Z (+6) is strong but not the maximum, so it elutes just before X (+8) rather than last.  

### Q20 — Size-Exclusion Chromatography (hard, Skill 2)
**Stem:** A biochemist loads a mixture of four purified proteins onto a size-exclusion column whose beads have a defined pore-size distribution. All four proteins are compact, globular, and behave identically except for their native molecular masses:

- Aldolase: 158 kDa
- Ovalbumin: 44 kDa
- Ribonuclease A: 14 kDa
- Thyroglobulin: 669 kDa

The column is run isocratically, and the eluate is collected in numbered fractions as it leaves the column (fraction 1 first, higher-numbered fractions later). Absorbance at 280 nm is used to detect each protein as a discrete peak. Assuming none of the proteins is large enough to be fully excluded and all resolve as separate peaks, which protein's peak appears in the earliest-numbered fraction?  
**Answer:** A · **Foundation:** 5C · **Confidence:** 5  
**Answer citation:** Lines 6864-6868: "Large proteins that can't enter the pores flow around the beads and elute faster than small ones that enter the pores... they move through the column and elute at much higher volumes than larger proteins, which can't enter the pores." Line 6962: "Large species that cannot enter the pores in the beads flow around it and elute in the void volume (V0), which is about 35-40% of Vt."  
**Distractor citation 1:** Choice B (small = fast reversal): Lines 6865-6868 state small proteins "enter the pores" and "elute at much higher volumes than larger proteins," i.e., last, contradicting the intuitive fast-small expectation; line 6882: "smaller molecules that pass through the beads will elute from the column later."  
**Distractor citation 2:** Choice C (no intermediate optimum): Lines 6961-6963 describe a monotonic relationship — large species elute at V0, very small near Vt — with elution volume increasing continuously with decreasing size; there is no efficiency maximum at intermediate mass.  
**Distractor citation 3:** Choice D (A280 is detection, not retention): Lines 6859-6860: "proteins are detected as they elute from the column by measuring absorbance at 280 nm, where aromatic amino [acids absorb]" — establishing A280 as a detection method, distinct from the size-based retention mechanism of lines 6864-6868.  

### Q21 — Size-Exclusion Chromatography (hard, Skill 2)
**Stem:** A biochemist purifies a 45 kDa monomeric enzyme and characterizes it on a size-exclusion column (void volume V_o = 8.0 mL, total volume V_t = 20.0 mL). Detecting eluate at 280 nm, she finds the native enzyme elutes as a single sharp peak centered at 14.0 mL. She then treats an identical amount of the same enzyme with a chaotropic agent that disrupts its tertiary structure without cleaving any peptide bonds, and re-injects it onto the same column equilibrated in that agent. Assuming no adsorption to the resin, which elution volume is the enzyme most likely to show in the second run, and why?  
**Answer:** A · **Foundation:** 5C · **Confidence:** 5  
**Answer citation:** Line 6985-6986: "If you separate two proteins of equal mass but one is highly elongated, and the other is spherical, the elongated one, with a large RS, would elute first (assuming that both don't elute together in the void volume, V0)." Also line 6982-6984: "the Rs for a protein molecule that was not spherical would be much larger than the Rs for another protein molecule of identical molecular weight that was spherical. Hence, the Ve and the K values for a solute on a gel filtration column would best be related to the Stokes radius since Rs values consider both size and shape." And line 14002: an unfolded/denatured state is "larger than the native state... as studied by hydrodynamic techniques."  
**Distractor citation 1:** Choice B (reversed): Line 6981-6984 establishes larger Rs -> more frictional resistance and exclusion; contra the claim, a larger radius is excluded from pore volume rather than threading deeper. Lines 6926-6933 show larger solutes have K near 0 (elute near Vo), smaller solutes K near 1 (elute near Vt).  
**Distractor citation 2:** Choice C (misconception): Line 6984 "Ve and K values... would best be related to the Stokes radius since Rs values consider both size and shape"; line 6987-6989 notes shape contributions must be removed by denaturing standards to use mass — proving mass alone does not set Ve.  
**Distractor citation 3:** Choice D (adjacent fact): Line 6964-6965: "If a species adsorbs to the column bead via noncovalent interactions... it may elute after Vt (purple bell-shaped curve)." This is the beyond-Vt mechanism, but it requires adsorption, which the stem explicitly excludes.  

### Q22 — Affinity Chromatography (medium, Skill 2)
**Stem:** A researcher lyses bacteria that overexpress a recombinant enzyme and loads the clarified lysate onto a column packed with nitrilotriacetic-acid resin that has been charged with Ni²⁺. After the sample fully enters the resin, the column is washed with several bed volumes of binding buffer (pH 8.0, 20 mM imidazole). Four abundant proteins in the lysate have the following properties:

| Protein | Fusion tag present | Net charge at pH 8.0 | Molecular weight |
|---------|-------------------|----------------------|------------------|
| W | FLAG peptide (DYKDDDDK) | −6 | 28 kDa |
| X | six consecutive His residues | +2 | 45 kDa |
| Y | none | −11 | 92 kDa |
| Z | glutathione S-transferase | +4 | 26 kDa |

Assuming each tag folds and is solvent-exposed, which protein is expected to remain bound to the resin after the wash step is complete?  
**Answer:** B · **Foundation:** 5C · **Confidence:** 5  
**Answer citation:** Line 7206-7207: "The Ni-Nitrilotriacetic binds the His tag by chelating the nickel ion with the six histidine imidazole groups on the His-tagged protein." and Line 7051-7052: "protein P1 has an affinity for ligand Z and will bind to the column, while proteins P2 and P3 will pass through the column."  
**Distractor citation 1:** Choice A (FLAG): Line 7189-7190 lists "antibodies to the His, FLAG, HA peptide tags" as separate affinity resins — FLAG is captured by an anti-FLAG antibody bead, not Ni-NTA; Line 7199 "FLAG peptide: DYKDDDDK."  
**Distractor citation 2:** Choice C (charge/size): Line 7966-7967 "Ion Exchange Chromatography: Separates proteins based on their net charge," distinct from affinity; Line 6714 lists "size, charge, hydrophobicity, and binding affinity" as separate properties, so charge/size do not confer Ni-NTA affinity.  
**Distractor citation 3:** Choice D (GST): Line 7207-7208 "Glutathione binds to a protein tag, Glutathione S-transferase (GST), which is fused to the target." — GST is captured on immobilized glutathione, not on nickel resin.  

### Q23 — Affinity Chromatography (hard, Skill 2)
**Stem:** A researcher purifies a recombinant esterase on an affinity column whose beads carry a covalently attached small-molecule inhibitor that occupies the enzyme's active site. After the sample is loaded and contaminants are washed away, the bound esterase is split across four identical columns, and a different elution buffer is applied to each. The researcher measures the amount of protein recovered from each column and the specific activity (units of esterase activity per milligram) of that recovered protein:

Column 1 — buffer at pH 2.5: 95% of protein recovered; specific activity 4 U/mg
Column 2 — buffer containing 6 M guanidinium chloride: 97% of protein recovered; specific activity 2 U/mg
Column 3 — buffer with a high concentration of the same free inhibitor added: 88% of protein recovered; specific activity 210 U/mg
Column 4 — buffer with elevated NaCl (1 M): 15% of protein recovered; specific activity 205 U/mg

The researcher needs the largest possible quantity of catalytically active esterase. Which elution condition best meets this goal, and why?  
**Answer:** A · **Foundation:** 5C · **Confidence:** 5  
**Answer citation:** Line 7052: "Protein P1 can then be eluted from the column using high concentrations of free ligand Z." Line 7260-7261: elution by decreasing pH "decreases the affinity of the tag for the resin" (contrasting harsh vs. competitive elution). Line 7031-7032: resin "derivatized with a group that binds to a specific site" such as one that "binds to the active site of an enzyme (such as benzamidine-agarose, which is used to purify trypsin)."  
**Distractor citation 1:** Choice B (pH): Line 7260-7261: eluting "by decreasing pH (typically to 4.5), which decreases the affinity of the tag for the resin" — low-pH elution is an alternative that alters affinity, and pushing pH to extremes disrupts native structure (contrast with the gentle free-ligand elution at Line 7052).  
**Distractor citation 2:** Choice C (guanidinium/denaturant): Line 7979-7980 distinguishes "native and denaturing methods"; denaturants remove protein by unfolding it, forfeiting the native, active form that competitive elution preserves (Line 7052).  
**Distractor citation 3:** Choice D (high salt / ionic strength): Line 7966-7967: for Ion Exchange Chromatography proteins "are eluted by altering the ionic strength or pH of the buffer" — high salt is the ion-exchange elution mechanism, not the mechanism for a ligand binding "a specific site" (Line 7031), so it is misapplied here.  

### Q24 — Multi-Step Purification (medium, Skill 1)
**Stem:** A researcher purifying an enzyme monitors purification level (fold-increase in specific activity relative to the crude lysate) after each step. Cation-exchange chromatography is run first and improves the purification level from 1 to 12. The researcher then runs the pooled active fractions over a second, identical cation-exchange column under the same buffer and gradient conditions, and observes the following:

  Step 1 — Crude lysate: purification level = 1
  Step 2 — Cation exchange #1: purification level = 12
  Step 3 — Cation exchange #2 (identical column): purification level = 13

A colleague suggests replacing the second cation-exchange step with size-exclusion chromatography, after which the purification level rises to 47. Which statement best accounts for the negligible improvement contributed by the second cation-exchange column compared with the size-exclusion column?  
**Answer:** A · **Foundation:** 5C · **Confidence:** 5  
**Answer citation:** Line 6851-6855: 'size exclusion chromatography, in which proteins can be separated according to their size/shape or molecular weight; ion exchange chromatography, in which proteins are separated by their charge/isoelectric point; ... affinity chromatography, in which proteins are separated based on binding to a ligand' — each method resolves on a distinct, independent property, which is why an orthogonal step removes contaminants a repeated step cannot. Line 7371-7372: 'in a good protein purification scheme, the specific activity should go up substantially with each level of purification, as the amount of your protein of interest makes up a greater percentage of the total protein.'  
**Distractor citation 1:** Choice B — Line 7373-7377: specific activity can drop if 'your protein of interest is being denatured or degraded and is no longer biologically active,' but the data show a rise (12 to 13) and later 47, so denaturation is not the cause; misapplied here.  
**Distractor citation 2:** Choice C — Line 7366-7367: 'some protein won\'t bind with 100% efficiency to your column matrix' relates to binding/capacity and yield, a distinct issue from resolving power/purity, which is what the purification level measures (Line 7355-7356).  
**Distractor citation 3:** Choice D — Line 6851-6852 explicitly assigns size exclusion to 'size/shape or molecular weight' and ion exchange to 'charge/isoelectric point,' so claiming size-exclusion separates by charge reverses the textbook basis of separation.  

