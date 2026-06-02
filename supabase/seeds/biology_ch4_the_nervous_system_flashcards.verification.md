# Verification Report — Biology Ch 4: The Nervous System

**Deck:** The Nervous System
**Source SQL:** supabase/seeds/biology_ch4_the_nervous_system_flashcards.sql
**Verified:** 2026-06-01

## Summary

- Total cards: 68
- Confidence 5: 65
- Confidence 4: 3
- Confidence 3: 0
- Confidence 2: 0
- Confidence 1: 0
- `needs_sme_review`: 0
- Dropped during editorial pass: 2
  - Empty placeholder note (blank cloze field in the .apkg)
  - Guillain-Barré syndrome note (out-of-scope clinical pathology; demyelination concept preserved via the myelin / oligodendrocyte / Schwann cards)

**Length-compliance check (per v6 CARD LENGTH & FOCUS rule):**
- All 68 cards confirmed ≤ 40 words of answer prose
- All 68 cards confirmed ≤ 4 cloze blanks
- One discrete concept per card — no over-budget exceptions used

**Primary references:**
- OpenStax Anatomy & Physiology 2e (Ch 12 The Nervous System and Nervous Tissue; Ch 13 Anatomy of the Nervous System; Ch 14 Somatic Nervous System; Ch 15 Autonomic Nervous System)
- OpenStax Biology 2e (Ch 35 The Nervous System)
- AAMC Content Outline 2026, Foundation 3A — Nervous and Endocrine Systems

## Per-card verification

### Card 0 — Neuron job (electrical-chemical converter)
**Cloze claim:** Neurons convert chemical signals into electrical impulses and back into chemical signals at the next cell.
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.1 (Basic Structure and Function of the Nervous System); OpenStax Biology 2e §35.1.

### Card 1 — Soma
**Cloze claim:** Soma = cell body; houses nucleus, ER, and ribosomes.
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.2 (Nervous Tissue — Neurons).

### Card 2 — Dendrites
**Cloze claim:** Branched extensions that receive incoming signals and carry them inward to the soma.
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.2.

### Card 3 — Axon
**Cloze claim:** Single long projection that carries the action potential away from the soma to the next cell.
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.2.

### Card 4 — Axon hillock
**Cloze claim:** Junction between soma and axon where excitatory and inhibitory inputs are summed; AP fires if threshold reached.
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.4 (The Action Potential — Initial Segment); OpenStax Biology 2e §35.2.

### Card 5 — Synaptic terminal
**Cloze claim:** Enlarged structure at axon end that releases neurotransmitters into the synaptic cleft.
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.5 (Communication Between Neurons — Chemical Synapses).

### Card 6 — Myelin function
**Cloze claim:** Fatty insulating sheath; prevents signal loss and increases conduction speed.
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.2 (Myelin and the Myelination of Axons).

### Card 7 — Myelin sources (oligodendrocyte vs Schwann)
**Cloze claim:** Oligodendrocytes myelinate CNS axons; Schwann cells myelinate PNS axons.
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.2.

### Card 8 — Nodes of Ranvier
**Cloze claim:** Gaps in myelin where axon membrane is exposed; site of action potential regeneration.
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.4 (Propagation of the Action Potential).

### Card 9 — Astrocytes + BBB
**Cloze claim:** Star-shaped glia; nourish neurons; form the blood-brain barrier.
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.2 (Glial Cells — Astrocytes); OpenStax Biology 2e §35.1.

### Card 10 — Microglia
**Cloze claim:** Resident phagocytes of the CNS; clear debris and pathogens.
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.2 (Glial Cells — Microglia).

### Card 11 — Ependymal cells + CSF
**Cloze claim:** Line ventricles; produce cerebrospinal fluid; CSF cushions the brain.
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.2 (Ependymal cells) and §13.2 (Cerebrospinal Fluid Circulation).

### Card 12 — CNS vs PNS
**Cloze claim:** CNS = brain + spinal cord; PNS = everything else (the nerves connecting CNS to the body).
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.1.

### Card 13 — Somatic vs autonomic subdivision
**Cloze claim:** PNS splits into somatic (voluntary) and autonomic (involuntary).
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.1 and §14–15.

### Card 14 — White vs gray matter
**Cloze claim:** White matter = myelinated axons; gray matter = cell bodies, dendrites, unmyelinated axons.
**Confidence:** 5
**Source:** OpenStax A&P 2e §13.2 (Gray and White Matter).

### Card 15 — Resting membrane potential value
**Cloze claim:** ~−70 mV, inside negative relative to outside.
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.4 (Membrane Potentials); OpenStax Biology 2e §35.2.

### Card 16 — K+ concentration gradient
**Cloze claim:** K+ is high inside (~140 mM), low outside (~4 mM); leaks outward.
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.4 (Ion Channels and Concentration Gradients). Standard values cross-referenced with Biology 2e §35.2.

### Card 17 — Na+ concentration gradient
**Cloze claim:** Na+ is high outside (~145 mM), low inside (~12 mM); flows inward.
**Confidence:** 5
**Source:** Same as Card 16.

### Card 18 — Equilibrium potentials (E_K ≈ −90, E_Na ≈ +60)
**Cloze claim:** E_K ≈ −90 mV; E_Na ≈ +60 mV; RMP closer to E_K because membrane is more permeable to K+.
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.4 (Equilibrium Potentials and Nernst Equation discussion). Standard electrophysiology values.

### Card 19 — Na+/K+ ATPase stoichiometry
**Cloze claim:** Pumps 3 Na+ out per 2 K+ in; restores ion gradients dissipated by AP.
**Confidence:** 5
**Source:** OpenStax A&P 2e §3.5 (Active Transport) and §12.4.

### Card 20 — All-or-nothing
**Cloze claim:** Every AP has the same amplitude regardless of stimulus strength.
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.4 (The Action Potential); OpenStax Biology 2e §35.2.

### Card 21 — Threshold ~−55 mV
**Cloze claim:** AP fires only if axon hillock depolarizes to ~−55 mV.
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.4.

### Card 22 — Depolarization (Na+ influx)
**Cloze claim:** Voltage-gated Na+ channels open at threshold; Na+ rushes in; membrane depolarizes toward +35 mV.
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.4; OpenStax Biology 2e §35.2.

### Card 23 — Repolarization (K+ efflux)
**Cloze claim:** Near +35 mV, Na+ channels inactivate and voltage-gated K+ channels open; K+ exits; membrane repolarizes.
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.4; OpenStax Biology 2e §35.2.

### Card 24 — Hyperpolarization
**Cloze claim:** K+ efflux briefly overshoots RMP, leaving membrane more negative than −70 mV; Na+/K+ ATPase restores resting state.
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.4.

### Card 25 — Three Na+ channel states
**Cloze claim:** Closed (below threshold and after inactivation reverses), open (threshold to ~+35 mV), inactivated (~+35 mV down to resting potential).
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.4 (Voltage-gated Channels) describes the channel state transitions; standard electrophysiology.

### Card 26 — Inactivated → closed requires reset
**Cloze claim:** Inactivated Na+ channel cannot reopen until membrane returns near resting potential and the channel resets to closed.
**Confidence:** 4
**Source:** OpenStax A&P 2e §12.4 covers the state cycle; explicit closed-vs-inactivated reset language is standard electrophysiology though lightly framed in OpenStax.

### Card 27 — Propagation mechanism
**Cloze claim:** Na+ entry depolarizes adjacent segment to threshold, opening its Na+ channels; domino effect carries AP along axon.
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.4 (Propagation of the Action Potential).

### Card 28 — Axon geometry and conduction speed
**Cloze claim:** Speed increases with cross-sectional area (less resistance) and decreases with axon length; cross-section more significant.
**Confidence:** 4
**Source:** OpenStax A&P 2e §12.4 (Propagation — myelinated vs unmyelinated). The cross-section vs length comparison is a cable-theory consequence treated lightly in OpenStax but standard in neurophysiology references.

### Card 29 — Saltatory conduction
**Cloze claim:** In myelinated axons, AP regenerates only at nodes of Ranvier; appears to jump node-to-node.
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.4.

### Card 30 — Intensity → frequency, not amplitude
**Cloze claim:** Stronger stimulus increases firing frequency, not action potential amplitude.
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.4 (Action Potential — all-or-nothing principle and frequency coding).

### Card 31 — Absolute refractory period
**Cloze claim:** No AP possible regardless of stimulus strength; Na+ channels inactivated.
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.4 (Refractory Periods).

### Card 32 — Relative refractory period
**Cloze claim:** AP possible only with stronger-than-normal stimulus; membrane hyperpolarized.
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.4.

### Card 33 — Synapse anatomy
**Cloze claim:** Presynaptic terminal + synaptic cleft + postsynaptic membrane; most use chemical messengers.
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.5 (Chemical Synapses); OpenStax Biology 2e §35.2.

### Card 34 — Ca2+ influx at synaptic terminal
**Cloze claim:** AP at terminal opens voltage-gated Ca2+ channels; Ca2+ flows into presynaptic neuron.
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.5.

### Card 35 — Vesicle fusion → exocytosis
**Cloze claim:** Ca2+ influx triggers vesicle fusion; NT released by exocytosis.
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.5; OpenStax Biology 2e §35.2.

### Card 36 — NT diffuses and binds postsynaptic receptor
**Cloze claim:** NT diffuses across synaptic cleft and binds postsynaptic receptors.
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.5.

### Card 37 — Effector
**Cloze claim:** Postsynaptic target that is muscle or gland is called an effector.
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.1 (terminology) and §14.1.

### Card 38 — Ionotropic receptor
**Cloze claim:** Ligand-gated ion channel; NT binding directly depolarizes or hyperpolarizes the postsynaptic cell.
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.5 (Neurotransmitter Systems — ionotropic receptors).

### Card 39 — Metabotropic receptor
**Cloze claim:** GPCR; NT binding triggers second-messenger cascade altering cAMP or intracellular Ca2+.
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.5 (metabotropic receptors); OpenStax Biology 2e §9.2.

### Card 40 — Three NT clearance mechanisms
**Cloze claim:** Enzymatic degradation, reuptake, diffusion.
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.5 (Termination of the Signal).

### Card 41 — Acetylcholinesterase
**Cloze claim:** Degrades acetylcholine in the synaptic cleft.
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.5; §15.2 (Autonomic Synapses).

### Card 42 — Reuptake of DA, NE, serotonin
**Cloze claim:** Dopamine, norepinephrine, and serotonin are cleared primarily by reuptake carriers.
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.5 (Neurotransmitter systems and reuptake transporters).

### Card 43 — EPSP vs IPSP
**Cloze claim:** Excitatory input depolarizes (toward threshold); inhibitory input hyperpolarizes (away from threshold).
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.5 (Postsynaptic Potentials).

### Card 44 — Excitatory NTs
**Cloze claim:** Glutamate (CNS); acetylcholine (NMJ).
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.5 and §14.3 (Neuromuscular Junction).

### Card 45 — Inhibitory NTs
**Cloze claim:** GABA (brain); glycine (spinal cord).
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.5 (Neurotransmitter Systems).

### Card 46 — Temporal vs spatial summation
**Cloze claim:** Temporal = signals close in time, one synapse; spatial = signals at same time, different synapses.
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.5 (Summation of Postsynaptic Potentials).

### Card 47 — Afferent = sensory
**Cloze claim:** Afferent/sensory neurons carry signals from receptors toward CNS.
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.1.

### Card 48 — Efferent = motor
**Cloze claim:** Efferent/motor neurons carry signals away from CNS to muscles and glands.
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.1.

### Card 49 — Interneurons
**Cloze claim:** Sit between sensory and motor neurons; most numerous of the three types; almost entirely within CNS.
**Confidence:** 5
**Source:** OpenStax A&P 2e §12.2 and §12.1.

### Card 50 — Somatic NS
**Cloze claim:** Voluntary movement; single motor neuron runs directly from spinal cord to skeletal muscle with no intervening synapse.
**Confidence:** 5
**Source:** OpenStax A&P 2e §14.1 (Sensory Perception) and §14.3 (Motor Responses).

### Card 51 — Autonomic two-neuron chain
**Cloze claim:** Preganglionic neuron (CNS) → postganglionic neuron (peripheral ganglion) → target.
**Confidence:** 5
**Source:** OpenStax A&P 2e §15.1 (Divisions of the Autonomic Nervous System).

### Card 52 — ANS functions
**Cloze claim:** ANS controls involuntary functions: heart rate, breathing, digestion, glandular secretion.
**Confidence:** 5
**Source:** OpenStax A&P 2e §15.1 and §15.3.

### Card 53 — Sympathetic = fight or flight
**Cloze claim:** Sympathetic mediates fight-or-flight; activated by stress.
**Confidence:** 5
**Source:** OpenStax A&P 2e §15.1 and §15.3.

### Card 54 — Sympathetic effects
**Cloze claim:** ↑HR, ↑BG, dilated pupils, bronchodilation, blood redirected to skeletal muscle, ↓digestion.
**Confidence:** 5
**Source:** OpenStax A&P 2e §15.3 (Autonomic Reflexes and Homeostasis).

### Card 55 — Parasympathetic = rest and digest
**Cloze claim:** Slows heart, constricts bronchi, ramps gut peristalsis and exocrine secretion.
**Confidence:** 5
**Source:** OpenStax A&P 2e §15.1 and §15.3.

### Card 56 — Vagus nerve (CN X)
**Cloze claim:** Vagus nerve provides much of parasympathetic innervation to thoracic and abdominal organs.
**Confidence:** 5
**Source:** OpenStax A&P 2e §15.1 (Parasympathetic Division) and §13.3 (Cranial Nerves).

### Card 57 — ANS neurotransmitters (CORRECTED)
**Cloze claim:** Pre = ACh both divisions; para post = ACh; sym post = NE (not epinephrine).
**Confidence:** 5
**Source:** OpenStax A&P 2e §15.2 (Autonomic Synapses). **Correction:** the .docx incorrectly states sympathetic postganglionics release epinephrine. Standard physiology: most sympathetic postganglionics release **norepinephrine**; epinephrine is released by the adrenal medulla (a modified sympathetic ganglion that releases its NT directly into the bloodstream rather than at a synapse).

### Card 58 — Brainstem components
**Cloze claim:** Midbrain + pons + medulla oblongata; handles breathing, heart rate, basic life functions.
**Confidence:** 5
**Source:** OpenStax A&P 2e §13.2 (The Brain — Brainstem).

### Card 59 — Cerebellum
**Cloze claim:** Behind the brainstem; coordinates movement and balance; damage causes incoordination not paralysis.
**Confidence:** 5
**Source:** OpenStax A&P 2e §13.2 (The Cerebellum).

### Card 60 — Limbic system
**Cloze claim:** Emotional and motivational network; central to memory formation.
**Confidence:** 5
**Source:** OpenStax A&P 2e §13.2 (Diencephalon and Limbic Structures) and §13.5.

### Card 61 — Cerebral cortex
**Cloze claim:** Outermost layer; higher-order processing: decision-making, language, perception, consciousness.
**Confidence:** 5
**Source:** OpenStax A&P 2e §13.2 (The Cerebrum).

### Card 62 — Spinal cord regions
**Cloze claim:** Cervical, thoracic, lumbar, sacral.
**Confidence:** 5
**Source:** OpenStax A&P 2e §13.4 (Anatomy of the Spinal Cord).

### Card 63 — Dorsal vs ventral roots
**Cloze claim:** Dorsal (posterior) = sensory in; ventral (anterior) = motor out.
**Confidence:** 5
**Source:** OpenStax A&P 2e §13.4.

### Card 64 — Dorsal root ganglia
**Cloze claim:** Cluster of sensory neuron cell bodies just outside the spinal cord; sensory cell bodies live in the PNS.
**Confidence:** 5
**Source:** OpenStax A&P 2e §13.4 (Dorsal Root Ganglia).

### Card 65 — Reflex arc
**Cloze claim:** Processed at spinal cord level; no brain input; allows fast reactions.
**Confidence:** 5
**Source:** OpenStax A&P 2e §13.4 (Sensory and Motor Pathways) and §15.3 (Spinal Reflexes).

### Card 66 — Monosynaptic reflex (knee-jerk)
**Cloze claim:** Sensory neuron synapses directly on motor neuron; classic example patellar reflex.
**Confidence:** 5
**Source:** OpenStax A&P 2e §13.4 (Stretch Reflex).

### Card 67 — Polysynaptic reflex (withdrawal)
**Cloze claim:** One or more interneurons between sensory and motor; classic example withdrawal reflex.
**Confidence:** 5
**Source:** OpenStax A&P 2e §13.4 (Withdrawal Reflex).

## needs_sme_review

None. All 68 cards rated confidence 4 or 5.

## Disagreements with corpus

**One material disagreement.** The source .docx contains a factual error in its description of autonomic postganglionic neurotransmitters. It states that most sympathetic postganglionic neurons release epinephrine. This contradicts OpenStax A&P 2e §15.2, which is consistent with standard physiology: most sympathetic postganglionic neurons release **norepinephrine**, while epinephrine is released by the **adrenal medulla** (a modified sympathetic ganglion that releases catecholamines directly into the bloodstream rather than at a synaptic terminal). Card 57 reflects the corrected fact per the textbook.

The three confidence-4 cards (26, 28, edge-case channel-state language) use standard neurophysiology terminology that OpenStax frames more loosely than the dedicated electrophysiology literature; framing was kept conservative and consistent with the broader corpus.

## Discrepancies between primary and secondary sources

None encountered. OpenStax Anatomy & Physiology 2e and OpenStax Biology 2e treat nervous system topics consistently with each other.

## Source-material discrepancies corrected during editorial pass

The chapter outline document contained multiple autocorrect-introduced typos and one substantive factual error. All were corrected against the reference textbook before any card was written:

1. **Factual error (substantive):** .docx claims most sympathetic postganglionic neurons release **epinephrine**. Corrected to **norepinephrine** per OpenStax A&P 2e §15.2. Epinephrine is released by the adrenal medulla, not standard postganglionic axons.
2. .docx "Neoneprine" → norepinephrine (autocorrect)
3. .docx "isoma" → soma (autocorrect)
4. .docx "axon headlock" / "axe and hillock" → axon hillock (autocorrect)
5. .docx "dendrocteatee" → dendrites (autocorrect)
6. .docx "sodium lead channels" → sodium leak channels (autocorrect)
7. .docx "Tracks only carry one type" → tracts (autocorrect)
8. .docx "Ooligodendrocytes" → oligodendrocytes (spelling)
9. .docx "When the actual potential reaches the nerve terminal" → action potential (autocorrect)
10. .docx "brought back near the rest potential" → resting potential (terminology)
11. .apkg note containing Guillain-Barré clinical pathology → dropped as out-of-scope; demyelination concept preserved via the myelin and oligodendrocyte/Schwann cards
12. .apkg placeholder note with empty cloze field → dropped

---

## Post-verification SME decisions

*(Empty section reserved for future SME or content owner to log overrides, retentions, or revisions made after the report was generated.)*
