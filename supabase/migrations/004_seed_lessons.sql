-- ============================================================
-- Praxis Prep — Seed Course Lessons
-- Run this AFTER 003_phase2_schema.sql
-- ============================================================

-- =====================
-- BIO/BIOCHEM LESSONS
-- =====================

INSERT INTO lessons (section, topic, title, content, sort_order, estimated_minutes) VALUES

('bio_biochem', 'Amino Acids & Proteins', 'Introduction to Amino Acids',
'## Amino Acids: The Building Blocks of Life

Amino acids are the fundamental building blocks of proteins. There are **20 standard amino acids** that are encoded by the genetic code, and understanding their properties is essential for the MCAT.

### Basic Structure

Every amino acid shares the same core structure:
- A central **alpha carbon** (Cα)
- An **amino group** (-NH₂)
- A **carboxyl group** (-COOH)
- A **hydrogen atom**
- A unique **R group** (side chain) — this is what makes each amino acid different

### Categories of Amino Acids

Amino acids are classified by their R groups:

**Nonpolar (hydrophobic):** Glycine, Alanine, Valine, Leucine, Isoleucine, Proline, Phenylalanine, Tryptophan, Methionine
- These tend to be found in the interior of proteins, away from water

**Polar uncharged:** Serine, Threonine, Cysteine, Tyrosine, Asparagine, Glutamine
- Can form hydrogen bonds with water

**Positively charged (basic):** Lysine (pKa ~10.5), Arginine (pKa ~12.5), Histidine (pKa ~6.0)
- Carry a positive charge at physiological pH (7.4)
- Histidine is special — its pKa is close to physiological pH, so it can act as both a proton donor and acceptor

**Negatively charged (acidic):** Aspartate (pKa ~3.7), Glutamate (pKa ~4.1)
- Carry a negative charge at physiological pH

### Key Concepts to Remember

1. **Zwitterion form:** At physiological pH, amino acids exist as zwitterions — the amino group is protonated (NH₃⁺) and the carboxyl group is deprotonated (COO⁻)

2. **Peptide bonds:** Amino acids link together through peptide bonds (a type of amide bond) formed by a dehydration reaction between the carboxyl group of one amino acid and the amino group of the next

3. **Essential amino acids:** 9 amino acids cannot be synthesized by the human body and must come from diet: His, Ile, Leu, Lys, Met, Phe, Thr, Trp, Val

4. **Sulfur-containing amino acids:** Methionine (thioether) and Cysteine (thiol group — can form disulfide bonds)',
1, 20),

('bio_biochem', 'Amino Acids & Proteins', 'Protein Structure & Folding',
'## The Four Levels of Protein Structure

Proteins are not just linear chains — they fold into precise three-dimensional shapes that determine their function. Understanding the four levels of protein structure is critical for the MCAT.

### Primary Structure (1°)
The **linear sequence** of amino acids in a polypeptide chain, held together by peptide bonds. This sequence is determined by the gene that encodes the protein.

- Written from N-terminus (amino end) to C-terminus (carboxyl end)
- Even a single amino acid change can dramatically affect function (e.g., sickle cell anemia: Glu → Val at position 6 of β-globin)

### Secondary Structure (2°)
Local folding patterns stabilized by **hydrogen bonds** between backbone atoms (not side chains).

**Alpha helix (α-helix):**
- Right-handed coil
- H-bonds form between C=O of residue n and N-H of residue n+4
- Side chains project outward from the helix

**Beta sheet (β-sheet):**
- Extended strands lying side by side
- Can be parallel (same direction) or antiparallel (opposite directions)
- Antiparallel sheets have stronger H-bonds

### Tertiary Structure (3°)
The overall **3D shape** of a single polypeptide chain, determined by interactions between side chains:

- **Hydrophobic interactions** (nonpolar R groups cluster in the interior)
- **Hydrogen bonds** (between polar side chains)
- **Ionic bonds / salt bridges** (between charged side chains)
- **Disulfide bonds** (covalent S-S bonds between cysteine residues)
- **Van der Waals forces** (weak attractions between all atoms)

### Quaternary Structure (4°)
The arrangement of **multiple polypeptide subunits** into a functional complex.

- Example: Hemoglobin has 4 subunits (2α + 2β)
- Not all proteins have quaternary structure — only those with multiple subunits

### Denaturation
Loss of 3D structure (secondary, tertiary, quaternary) due to:
- Heat, extreme pH, detergents, heavy metals, urea
- Primary structure is NOT affected — the peptide bonds remain intact
- Some proteins can refold (renature) when conditions return to normal',
2, 25),

('bio_biochem', 'Enzyme Kinetics', 'Enzyme Fundamentals',
'## How Enzymes Work

Enzymes are biological catalysts — they speed up chemical reactions without being consumed. Nearly all enzymes are proteins (with some RNA exceptions called ribozymes).

### Key Principles

1. **Enzymes lower the activation energy (Ea)** — they do NOT change the overall free energy (ΔG) of the reaction or the equilibrium
2. **Enzymes are specific** — each enzyme typically catalyzes one reaction or type of reaction
3. **Enzymes are not consumed** — they are recycled after each reaction

### The Active Site

The active site is a pocket or cleft where the substrate binds and the reaction occurs.

**Lock and Key Model:** The substrate fits perfectly into the active site (like a key in a lock)

**Induced Fit Model (more accurate):** The active site changes shape slightly when the substrate binds, creating a tighter fit — like a glove molding to a hand

### Michaelis-Menten Kinetics

The Michaelis-Menten equation describes the relationship between reaction rate and substrate concentration:

**v = (Vmax × [S]) / (Km + [S])**

- **Vmax** = maximum reaction velocity (when all enzyme molecules are saturated)
- **Km** = Michaelis constant = the substrate concentration at which v = Vmax/2
- **Low Km** = high affinity (enzyme binds substrate tightly, reaches half-max at low [S])
- **High Km** = low affinity

### Important Graph Features
- At low [S]: rate increases almost linearly (first-order kinetics)
- At high [S]: rate plateaus at Vmax (zero-order kinetics)
- The curve is hyperbolic (not sigmoidal — that would be allosteric enzymes)

### Enzyme Inhibition

**Competitive inhibition:**
- Inhibitor binds the active site (competes with substrate)
- Km increases (apparent lower affinity)
- Vmax unchanged (can be overcome by adding more substrate)

**Uncompetitive inhibition:**
- Inhibitor binds only the enzyme-substrate complex
- Both Km and Vmax decrease

**Noncompetitive inhibition:**
- Inhibitor binds an allosteric site (not the active site)
- Km unchanged
- Vmax decreases (some enzyme molecules are permanently inactivated)',
3, 30),

('bio_biochem', 'Cell Biology', 'The Cell Cycle',
'## The Cell Cycle: From One Cell to Two

The cell cycle is the ordered series of events that leads to cell division. Understanding this process is essential — it connects to genetics, cancer biology, and molecular biology on the MCAT.

### Overview

The cell cycle has two main phases:
1. **Interphase** (G1 → S → G2) — the cell grows and copies its DNA
2. **M Phase** (Mitosis + Cytokinesis) — the cell divides

### Interphase (~90% of the cell cycle)

**G1 Phase (Gap 1):**
- Cell grows in size
- Organelles are duplicated
- Cell performs its normal functions
- **G1 checkpoint** (Restriction point): cell decides whether to proceed to S phase
- If conditions are not favorable, cell enters **G0** (quiescent state — may be temporary or permanent)

**S Phase (Synthesis):**
- **DNA replication** occurs — each chromosome goes from 1 chromatid to 2 sister chromatids
- Centrosome is duplicated
- DNA content doubles: 2n → 4n (in terms of DNA amount, not chromosome number)

**G2 Phase (Gap 2):**
- Cell continues to grow
- Prepares for mitosis (synthesizes proteins needed for division)
- **G2 checkpoint:** verifies DNA replication was completed correctly

### M Phase

**Mitosis** (division of the nucleus) proceeds through:

1. **Prophase:** Chromatin condenses into visible chromosomes. Nuclear envelope begins to break down. Spindle fibers form.
2. **Prometaphase:** Nuclear envelope fully breaks down. Kinetochore microtubules attach to centromeres.
3. **Metaphase:** Chromosomes align at the metaphase plate. **Metaphase checkpoint:** ensures all chromosomes are properly attached to spindle fibers.
4. **Anaphase:** Sister chromatids separate and move to opposite poles.
5. **Telophase:** Nuclear envelopes reform. Chromosomes decondense. Spindle disassembles.

**Cytokinesis** (division of the cytoplasm):
- Animal cells: cleavage furrow pinches the cell in two
- Plant cells: cell plate forms between the two daughter cells

### Key Regulators

- **Cyclins + CDKs (cyclin-dependent kinases):** drive the cell cycle forward
- **p53 (tumor suppressor):** halts the cell cycle if DNA damage is detected; triggers apoptosis if damage cannot be repaired
- **Rb (retinoblastoma protein):** blocks entry into S phase until appropriate signals are received',
4, 25),

-- =====================
-- CHEM/PHYS LESSONS
-- =====================

('chem_phys', 'General Chemistry', 'Acids, Bases, and Buffers',
'## Acids, Bases, and Buffers

Acid-base chemistry is one of the highest-yield topics on the MCAT. You will see it in general chemistry, organic chemistry, biochemistry, and even biology passages.

### Definitions

**Brønsted-Lowry:**
- Acid = proton (H⁺) donor
- Base = proton acceptor

**Lewis:**
- Acid = electron pair acceptor
- Base = electron pair donor (broader definition — includes molecules without H)

### The pH Scale

pH = -log[H⁺]

- pH < 7 = acidic
- pH = 7 = neutral
- pH > 7 = basic

Important relationship: **pH + pOH = 14** (at 25°C)

### Strong vs. Weak Acids

**Strong acids** dissociate completely: HCl, HBr, HI, HNO₃, H₂SO₄, HClO₄
- If you have 0.1 M HCl, then [H⁺] = 0.1 M and pH = 1

**Weak acids** partially dissociate: CH₃COOH (acetic acid), H₂CO₃, HF
- Equilibrium expression: Ka = [H⁺][A⁻] / [HA]
- pKa = -log(Ka)
- Lower pKa = stronger weak acid

### Buffers

A buffer resists changes in pH when small amounts of acid or base are added.

**Components:** A weak acid + its conjugate base (or a weak base + its conjugate acid)

**Henderson-Hasselbalch Equation:**
pH = pKa + log([A⁻]/[HA])

**Key insights:**
- Buffer is most effective when pH = pKa (because [A⁻] = [HA])
- Effective buffering range: pKa ± 1
- Adding acid converts A⁻ → HA (base absorbs the acid)
- Adding base converts HA → A⁻ (acid absorbs the base)

### Titrations

**Strong acid + strong base:** equivalence point at pH 7
**Weak acid + strong base:** equivalence point at pH > 7 (conjugate base is basic)
**Weak base + strong acid:** equivalence point at pH < 7

At the **half-equivalence point:** pH = pKa (exactly half the acid has been converted to conjugate base)',
1, 25),

('chem_phys', 'General Chemistry', 'Thermodynamics & Equilibrium',
'## Thermodynamics: Energy and Spontaneity

Thermodynamics tells us whether a reaction CAN happen (is it energetically favorable?) — not how fast it happens (that is kinetics).

### The Laws of Thermodynamics

**First Law:** Energy cannot be created or destroyed, only transferred or converted (conservation of energy)
- ΔU = q + w (change in internal energy = heat + work)

**Second Law:** The total entropy of the universe always increases for spontaneous processes
- ΔS(universe) = ΔS(system) + ΔS(surroundings) > 0

**Third Law:** The entropy of a perfect crystal at absolute zero (0 K) is zero

### Gibbs Free Energy

**ΔG = ΔH - TΔS**

This is the master equation for predicting spontaneity:

| ΔH | ΔS | ΔG | Spontaneous? |
|---|---|---|---|
| - | + | Always - | Always spontaneous |
| + | - | Always + | Never spontaneous |
| - | - | Depends on T | Spontaneous at low T |
| + | + | Depends on T | Spontaneous at high T |

- **ΔG < 0:** spontaneous (exergonic)
- **ΔG > 0:** nonspontaneous (endergonic)
- **ΔG = 0:** at equilibrium

### Enthalpy (ΔH)

- **Exothermic (ΔH < 0):** releases heat to surroundings (bonds formed are stronger than bonds broken)
- **Endothermic (ΔH > 0):** absorbs heat from surroundings

### Equilibrium

At equilibrium, the forward and reverse reaction rates are equal (not the concentrations!).

**ΔG° = -RT ln(K)**

- Large K (>> 1): products favored, ΔG° is very negative
- Small K (<< 1): reactants favored, ΔG° is positive
- K = 1: ΔG° = 0

**Le Chatelier''s Principle:** If a system at equilibrium is disturbed, it shifts to counteract the disturbance
- Add reactant → shifts right (toward products)
- Remove product → shifts right
- Increase temperature for exothermic reaction → shifts left
- Increase pressure → shifts toward fewer moles of gas',
2, 30),

('chem_phys', 'Physics', 'Forces and Motion',
'## Newtonian Mechanics: Forces and Motion

Mechanics is the foundation of MCAT physics. Master these concepts and the math becomes straightforward.

### Newton''s Three Laws

**First Law (Inertia):**
An object at rest stays at rest, and an object in motion stays in motion at constant velocity, unless acted upon by a net external force.

**Second Law:**
**F = ma**
- The net force on an object equals its mass times its acceleration
- This is the most important equation in mechanics
- Units: 1 Newton (N) = 1 kg·m/s²

**Third Law:**
For every action, there is an equal and opposite reaction.
- If you push on a wall with 10 N, the wall pushes back on you with 10 N
- The forces act on DIFFERENT objects

### Kinematics Equations (constant acceleration)

1. v = v₀ + at
2. x = x₀ + v₀t + ½at²
3. v² = v₀² + 2a(x - x₀)

**Free fall:** a = g = 9.8 m/s² (downward)
- On the MCAT, you can approximate g ≈ 10 m/s²

### Common Forces

**Weight:** W = mg (always points downward)

**Normal force:** Perpendicular to the surface of contact. On a flat surface, N = mg.

**Friction:**
- Static friction: fs ≤ μs × N (prevents motion)
- Kinetic friction: fk = μk × N (opposes motion)
- μs > μk (harder to start moving than to keep moving)

**Tension:** Force transmitted through a string, rope, or cable. Same throughout an ideal (massless) rope.

### Inclined Planes

For an object on a ramp at angle θ:
- Component of gravity parallel to ramp: mg sin θ
- Component of gravity perpendicular to ramp: mg cos θ
- Normal force: N = mg cos θ

### Work and Energy

**Work:** W = F × d × cos θ
- Only the component of force in the direction of displacement does work

**Kinetic Energy:** KE = ½mv²

**Potential Energy:** PE = mgh (gravitational)

**Conservation of Energy:** KE₁ + PE₁ = KE₂ + PE₂ (when only conservative forces act)',
3, 25),

-- =====================
-- PSYCH/SOC LESSONS
-- =====================

('psych_soc', 'Psychology', 'Learning and Memory',
'## Learning and Memory

Learning and memory are among the most tested topics in the Psych/Soc section. Understanding the different types of learning and memory systems will give you a strong foundation.

### Classical Conditioning (Pavlov)

A neutral stimulus becomes associated with an unconditioned stimulus to produce a conditioned response.

**Key terms:**
- **Unconditioned Stimulus (US):** naturally triggers a response (food)
- **Unconditioned Response (UR):** natural response to US (salivation to food)
- **Conditioned Stimulus (CS):** previously neutral stimulus that now triggers a response (bell)
- **Conditioned Response (CR):** learned response to CS (salivation to bell)

**Important phenomena:**
- **Acquisition:** the CS-US pairing is learned
- **Extinction:** CS is presented without US → CR gradually disappears
- **Spontaneous recovery:** after extinction, CR can briefly reappear
- **Generalization:** responding to stimuli similar to the CS
- **Discrimination:** learning to respond only to the specific CS

### Operant Conditioning (Skinner)

Behavior is shaped by its consequences.

**Reinforcement (increases behavior):**
- Positive reinforcement: add something pleasant (give a treat)
- Negative reinforcement: remove something unpleasant (take away pain)

**Punishment (decreases behavior):**
- Positive punishment: add something unpleasant (give a shock)
- Negative punishment: remove something pleasant (take away phone)

**Schedules of reinforcement:**
- Fixed ratio: reward after set number of responses (every 5th purchase is free)
- Variable ratio: reward after unpredictable number (slot machines) — most resistant to extinction
- Fixed interval: reward after set time (paycheck every 2 weeks)
- Variable interval: reward after unpredictable time (checking email)

### Memory Systems

**Sensory Memory → Short-Term/Working Memory → Long-Term Memory**

**Sensory memory:**
- Iconic (visual): ~0.5 seconds
- Echoic (auditory): ~3-4 seconds

**Short-term / Working memory:**
- Capacity: 7 ± 2 items (Miller''s magic number)
- Duration: ~20-30 seconds without rehearsal
- Can be extended through chunking and rehearsal

**Long-term memory:**
- **Explicit (declarative):** conscious recall
  - Episodic: personal experiences ("my first day of school")
  - Semantic: facts and general knowledge ("the capital of France")
- **Implicit (nondeclarative):** unconscious
  - Procedural: skills and habits (riding a bike)
  - Priming: exposure to one stimulus influences response to another

### Brain Structures in Memory

- **Hippocampus:** formation of new explicit memories (damage = anterograde amnesia)
- **Amygdala:** emotional memories
- **Cerebellum:** procedural memories
- **Prefrontal cortex:** working memory',
1, 30),

('psych_soc', 'Psychology', 'Sensation and Perception',
'## Sensation and Perception

Sensation is the process of detecting stimuli from the environment. Perception is how we interpret and organize that sensory information. The MCAT loves testing the distinction.

### Key Concepts

**Sensation:** The physical process of sensory receptors detecting stimuli
**Perception:** The brain''s interpretation of sensory signals

**Transduction:** Converting physical energy (light, sound, pressure) into neural signals (action potentials)

### Thresholds

**Absolute threshold:** The minimum stimulus intensity needed to detect a stimulus 50% of the time
- Example: the faintest sound you can hear in a quiet room

**Difference threshold (JND - Just Noticeable Difference):** The minimum change in stimulus needed to detect a difference

**Weber''s Law:** The JND is proportional to the original stimulus intensity
- ΔI/I = constant
- Example: if you''re holding 10 lbs and need to add 1 lb to notice (10%), then if holding 100 lbs, you''d need to add 10 lbs

**Signal Detection Theory:** Detection depends not just on stimulus strength but also on:
- Background noise
- Observer''s expectations
- Motivation (consequences of hits vs. misses)

### Vision

**Path of light:** Cornea → Pupil → Lens → Retina → Optic nerve → Brain

**Photoreceptors:**
- **Rods:** detect light/dark, peripheral vision, work in low light, high sensitivity
- **Cones:** detect color, central vision (fovea), need bright light, high acuity

**Color vision theories:**
- **Trichromatic theory (Young-Helmholtz):** three types of cones (red, green, blue) — explains color detection at the receptor level
- **Opponent-process theory:** color is processed in opposing pairs (red-green, blue-yellow, black-white) — explains afterimages

### Hearing

**Path of sound:** Outer ear → Tympanic membrane → Ossicles (malleus, incus, stapes) → Oval window → Cochlea → Basilar membrane → Hair cells → Auditory nerve

**Pitch perception:**
- **Place theory:** different frequencies activate different locations on the basilar membrane (works for high frequencies)
- **Frequency theory:** the rate of neural firing matches the sound frequency (works for low frequencies)

### Gestalt Principles of Perception

Our brain organizes visual information using these rules:
- **Figure-ground:** we distinguish objects (figure) from background (ground)
- **Proximity:** objects near each other are grouped together
- **Similarity:** similar objects are grouped together
- **Continuity:** we perceive smooth, continuous patterns
- **Closure:** we fill in gaps to see complete figures',
2, 25),

('psych_soc', 'Sociology', 'Social Structures and Stratification',
'## Social Structures and Stratification

Sociology on the MCAT focuses on how social systems influence health, behavior, and access to resources. This is high-yield material.

### Social Stratification

Social stratification is the hierarchical arrangement of individuals in society based on wealth, power, and prestige.

### Key Theoretical Perspectives

**Functionalism (Durkheim, Parsons):**
- Society is a system of interconnected parts that work together
- Stratification serves a purpose: motivates people to fill important roles
- Davis-Moore thesis: inequality is functional because it ensures the most qualified people fill the most important positions

**Conflict Theory (Marx, Weber):**
- Society is characterized by competition for limited resources
- Stratification results from exploitation and power imbalances
- Marx: class is determined by relationship to means of production (bourgeoisie vs. proletariat)
- Weber: stratification is multidimensional — class (economics), status (prestige), party (political power)

**Symbolic Interactionism (Mead, Goffman):**
- Focuses on micro-level interactions
- People construct meaning through social interactions
- Goffman''s dramaturgical analysis: social life is like a theater (front stage vs. back stage behavior)

### Social Class and Health

This is critical for the MCAT — social factors have enormous impacts on health:

- **Lower SES → worse health outcomes** (higher rates of chronic disease, lower life expectancy)
- Mechanisms: reduced access to healthcare, increased exposure to environmental toxins, chronic stress, food deserts, lower health literacy

### Social Mobility

- **Intergenerational mobility:** change in social class between generations (son of a laborer becomes a doctor)
- **Intragenerational mobility:** change within one''s own lifetime
- **Structural mobility:** movement due to changes in society (industrialization creates new middle-class jobs)

### Key Concepts

**Social reproduction:** the tendency for social structures to perpetuate themselves across generations (wealthy families stay wealthy)

**Cultural capital (Bourdieu):** knowledge, skills, education, and advantages that give a person higher status — not just money, but the "right" accent, manners, cultural knowledge

**Social capital:** the networks and relationships that provide access to opportunities

**Intersectionality:** multiple aspects of identity (race, class, gender, sexuality) overlap and interact to create unique experiences of privilege or disadvantage',
3, 25),

-- =====================
-- CARS LESSONS
-- =====================

('cars', 'Critical Analysis', 'CARS Strategy and Approach',
'## CARS: How to Approach Passages

The Critical Analysis and Reasoning Skills section is unique on the MCAT — it tests your ability to analyze arguments, not your content knowledge. Many students find it the most challenging section because you can''t just memorize facts.

### The CARS Mindset

1. **You are a detective, not a debater.** Your job is to understand what the author thinks, not what you think.
2. **The answer is always in the passage.** Never use outside knowledge to answer a question.
3. **The author always has a viewpoint.** Even "neutral" passages have a perspective — find it.

### Reading Strategy

**First pass (3-4 minutes per passage):**
- Read actively, not passively — constantly ask "what is the author''s point?"
- After each paragraph, mentally summarize the main idea in 5-7 words
- Note the author''s tone: positive, negative, neutral, skeptical, enthusiastic, critical?
- Identify the thesis — usually in the first or last paragraph
- Don''t get stuck on difficult vocabulary — use context clues

**What to look for:**
- **Central thesis:** What is the author''s main argument?
- **Evidence:** What supports the thesis?
- **Tone/attitude:** How does the author feel about the subject?
- **Structure:** How is the argument organized? (chronological, compare/contrast, cause/effect, problem/solution)

### Question Types

**1. Main Idea questions:**
"The central thesis of the passage is..."
- Should match the overall argument, not just one paragraph
- Correct answer is usually moderate in tone (not extreme)

**2. Detail/Retrieval questions:**
"According to the passage, the author states that..."
- Go back to the passage and find the specific reference
- The answer is usually a paraphrase, not a direct quote

**3. Inference questions:**
"It can be inferred from the passage that..."
- The answer must be supported by passage evidence
- Correct inferences are small logical steps, not big leaps

**4. Strengthen/Weaken questions:**
"Which of the following would most weaken the author''s argument?"
- Identify what the argument depends on
- The correct answer attacks that foundation

**5. Application questions:**
"The author would most likely agree with which of the following?"
- Stay consistent with the author''s established viewpoint and values

### Common Traps

- **Extreme language:** "always," "never," "all" — these are usually wrong
- **Outside knowledge:** tempting but irrelevant — stick to the passage
- **Half-right answers:** correct about the topic but wrong about the detail
- **Opposite answers:** says the reverse of what the passage states (easy to fall for under time pressure)',
1, 20),

('cars', 'Critical Analysis', 'Identifying Arguments and Evidence',
'## Identifying Arguments and Evidence

The MCAT CARS section is fundamentally about analyzing arguments. If you can identify the argument structure, you can answer most questions.

### What Is an Argument?

An argument consists of:
1. **Claim (conclusion):** What the author wants you to believe
2. **Evidence (premises):** The reasons or support for the claim
3. **Assumptions:** Unstated beliefs that connect the evidence to the claim

### Signal Words

Learn to spot these — they tell you what role each sentence plays:

**Claim signals:** "therefore," "thus," "consequently," "it follows that," "this shows that," "in conclusion"

**Evidence signals:** "because," "since," "given that," "studies show," "for example," "research indicates"

**Contrast signals:** "however," "although," "despite," "on the other hand," "nevertheless," "conversely"

**Concession signals:** "admittedly," "while it is true that," "granted" — the author acknowledges the other side before arguing against it

### Types of Evidence

**Empirical evidence:** studies, data, statistics, experiments
- "A 2019 study found that..."

**Expert testimony:** quotes or references to authorities
- "According to Dr. Smith..."

**Anecdotal evidence:** individual stories or examples
- "Consider the case of..."

**Logical reasoning:** deductive or inductive arguments
- "If A causes B, and B causes C, then A causes C"

### Evaluating Arguments

For strengthen/weaken questions, ask yourself:

**To weaken an argument:**
- Does the evidence actually support the conclusion?
- Are there alternative explanations?
- Is the sample representative?
- Does the author commit any logical fallacies?

**To strengthen an argument:**
- What additional evidence would make the conclusion more convincing?
- What would eliminate alternative explanations?

### Common Logical Fallacies

- **Ad hominem:** attacking the person, not the argument
- **Straw man:** misrepresenting an argument to make it easier to attack
- **False dichotomy:** presenting only two options when more exist
- **Slippery slope:** assuming one event will inevitably lead to extreme consequences
- **Appeal to authority:** using someone''s status rather than evidence
- **Correlation ≠ causation:** just because two things occur together doesn''t mean one caused the other
- **Hasty generalization:** drawing broad conclusions from insufficient evidence',
2, 20);
