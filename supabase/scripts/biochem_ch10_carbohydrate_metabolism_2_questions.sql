-- ════════════════════════════════════════════════════════════════════
-- Biochemistry Ch10 — Carbohydrate Metabolism II — 100 standalone questions
-- (PDH/acetyl-CoA & fuel sources, the citric acid cycle, the electron transport chain,
--  and oxidative phosphorylation / bioenergetics).
-- Foundation 1D; content categories: Citric Acid Cycle / Metabolism of Fatty Acids and Proteins /
--  Oxidative Phosphorylation / Principles of Bioenergetics. Grounded in LibreTexts Biochemistry.
-- Scope verified against the WHOLE cross-subject AAMC outline; cross-batch redundancy + readback remediated.
-- IDEMPOTENT: wipes the entire topic then re-inserts all 100.
-- ════════════════════════════════════════════════════════════════════

BEGIN;
DELETE FROM questions WHERE section = 'bio_biochem' AND topic = 'Carbohydrate Metabolism II';

-- Q1 [A1 · Pyruvate Dehydrogenase & Acetyl-CoA] easy skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Pyruvate Dehydrogenase & Acetyl-CoA', 'A researcher isolates respiring muscle mitochondria and adds \(^{14}\text{C}\)-labeled pyruvate in which only the carboxylate carbon carries the label. The mitochondria are supplied with CoA-SH and are competent to run the matrix enzyme that commits glycolytically-derived pyruvate to the citric acid cycle. After a brief incubation—before any labeled carbon can travel further into the cycle—the researcher recovers the acetyl unit now attached to CoA and separately traps any small labeled molecule that has left the carbon skeleton. Assuming only the committing enzyme acts, which set correctly describes the labeled species that has departed the skeleton and the electron carrier this same enzyme leaves reduced?', '[{"label": "A", "text": "One \\(^{14}\\text{CO}_2\\) departs and \\(\\text{NAD}^+\\) is reduced to \\(\\text{NADH}\\)"}, {"label": "B", "text": "One \\(^{14}\\text{CO}_2\\) departs and \\(\\text{FAD}\\) is reduced to \\(\\text{FADH}_2\\)"}, {"label": "C", "text": "Two \\(^{14}\\text{CO}_2\\) depart and \\(\\text{NAD}^+\\) is reduced to \\(\\text{NADH}\\)"}, {"label": "D", "text": "One \\(^{14}\\text{CO}_2\\) departs and \\(\\text{GDP}\\) is phosphorylated to \\(\\text{GTP}\\)"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Citric Acid Cycle.''

The answer is A because the committing enzyme that funnels glycolytically-derived pyruvate into the cycle is the pyruvate dehydrogenase complex, and its single reaction is an oxidative decarboxylation: pyruvate (three carbons) plus CoA-SH plus \(\text{NAD}^+\) yields acetyl-CoA (two carbons) plus one \(\text{CO}_2\) plus \(\text{NADH}\). Because only the carboxylate carbon is labeled, and that carboxylate carbon is precisely the one removed as \(\text{CO}_2\) in this step, exactly one \(^{14}\text{CO}_2\) leaves the skeleton while the surviving two-carbon acetyl unit is unlabeled. The step is an oxidation, so the substrate loses electrons and the paired nicotinamide carrier gains them—\(\text{NAD}^+\) is reduced to \(\text{NADH}\).

(Choice A) is correct: a three-carbon substrate becoming a two-carbon acetyl group can release only one carbon, and because the label sits on the carboxylate that this step removes, that single departing \(\text{CO}_2\) is the \(^{14}\text{C}\); the accompanying oxidation reduces \(\text{NAD}^+\) to \(\text{NADH}\), matching both carbon and electron bookkeeping.
(Choice B) is incorrect: although one \(\text{CO}_2\) is right, \(\text{FAD}\) is not the carrier the complex leaves reduced. \(\text{FAD}\) is used internally on the E3 component but is re-oxidized as it hands electrons to \(\text{NAD}^+\), so the reduced carrier delivered from the step is \(\text{NADH}\), not \(\text{FADH}_2\).
(Choice C) is incorrect: releasing two \(\text{CO}_2\) would require losing two carbons, but a three-carbon pyruvate becoming a two-carbon acetyl group can lose only one. Counting two \(\text{CO}_2\) confuses this single committing step with the two later decarboxylations that occur once carbon travels through the cycle proper.
(Choice D) is incorrect: no substrate-level phosphorylation occurs at this step. The \(\text{GDP} \rightarrow \text{GTP}\) event belongs to the succinyl-CoA to succinate reaction inside the cycle, not to the committing oxidative decarboxylation, which instead reduces \(\text{NAD}^+\).

As a Skill 2 (reasoning about and evaluating a described experimental scenario) item, the student must identify the unnamed committing enzyme, supply its oxidative-decarboxylation chemistry, and track a specific labeled carbon plus the correct electron carrier rather than read the mechanism off the stem.', 'easy', '1D', 'Citric Acid Cycle', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'adjacent_fact', 'FAD is internal to the E3 subunit, so the student names FADH2 as the exported reduced carrier' FROM q
  UNION ALL
  SELECT id, 'C', 'scale_unit_error', 'counts two CO2 by conflating the single PDH decarboxylation with the two later decarboxylations of the cycle' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'imports the GTP-producing substrate-level phosphorylation from the succinyl-CoA step into the PDH step' FROM q;

-- Q2 [A2 · Pyruvate Dehydrogenase & Acetyl-CoA] easy skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Pyruvate Dehydrogenase & Acetyl-CoA', 'A researcher fractionates a liver cell and measures where pyruvate is produced versus where it is converted to acetyl-CoA. She finds pyruvate is generated in one compartment but must be transported across a membrane before the acetyl-CoA-forming reaction can occur. Based on where each process occurs and how the two pathways connect, which statement best describes the acetyl-CoA-forming complex?', '[{"label": "A", "text": "It is a glycolytic enzyme that operates in the cytosol alongside the enzymes that make pyruvate"}, {"label": "B", "text": "It resides in the mitochondrial matrix and bridges glycolysis to the citric acid cycle after pyruvate is imported"}, {"label": "C", "text": "It resides in the intermembrane space and returns acetyl-CoA to the cytosol for glycolysis"}, {"label": "D", "text": "It is the first enzyme of the citric acid cycle and condenses pyruvate directly with oxaloacetate"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Citric Acid Cycle.''

The answer is B because the fractionation result forces a specific spatial logic: pyruvate is made by glycolysis in the cytosol, yet it must cross a membrane before the acetyl-CoA-forming reaction can proceed. The only consistent interpretation is that the complex lies inside the mitochondrion, in the matrix, so pyruvate produced in the cytosol has to be imported across the inner mitochondrial membrane before reacting. Functionally, this complex does not belong to glycolysis; it sits at the junction, converting the end product of glycolysis into the two-carbon fuel that feeds the citric acid cycle, which is why it is described as a bridge between the two pathways.

(Choice B) is correct: matrix localization explains the required transport step (cytosolic pyruvate imported inward), and the bridging role explains why glycolysis and the cycle are connected through, but not overlapping with, this complex.
(Choice A) is incorrect: if the complex were a cytosolic glycolytic enzyme, no membrane transport would be needed, directly contradicting the observation that pyruvate must be moved before the reaction can occur. This embodies the misconception that pyruvate-to-acetyl-CoA is the last step of glycolysis.
(Choice C) is incorrect: placing the complex in the intermembrane space and exporting acetyl-CoA back to the cytosol reverses the true direction of flux and ignores that acetyl-CoA is consumed by the matrix-localized cycle, not returned to glycolysis.
(Choice D) is incorrect: the first enzyme of the cycle condenses acetyl-CoA (not pyruvate) with oxaloacetate. Feeding pyruvate directly into that condensation skips the required decarboxylation and confuses two distinct steps.

As a Skill 2 (reasoning about scientific concepts) item, the student infers localization and pathway role from an experimental transport observation rather than reciting where PDH lives.', 'easy', '1D', 'Citric Acid Cycle', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'treats pyruvate-to-acetyl-CoA as the terminal cytosolic step of glycolysis' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'reverses flux direction, exporting acetyl-CoA to cytosol from intermembrane space' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'collapses PDH into citrate synthase, condensing pyruvate with OAA directly' FROM q;

-- Q3 [A3 · Pyruvate Dehydrogenase & Acetyl-CoA] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Pyruvate Dehydrogenase & Acetyl-CoA', 'Acetyl-CoA carries its acetyl group as a thioester (the acetyl carbon is bonded to the sulfur of coenzyme A). In many transfer reactions, acetyl-CoA readily hands its acetyl group off to an incoming nucleophile, and it does so far more readily than an ordinary oxygen ester such as ethyl acetate would. A student notes that oxygen and sulfur sit in the same group of the periodic table and asks why the two ester linkages should behave so differently. Which explanation best accounts for the thioester being the more reactive acyl donor?', '[{"label": "A", "text": "Sulfur is more electronegative than oxygen, so it withdraws electron density from the carbonyl and locks the acyl group in place until a strong nucleophile arrives"}, {"label": "B", "text": "The sulfur lone pairs donate strongly into the carbonyl, giving the thioester extra resonance stabilization that makes acyl transfer more favorable than for an oxygen ester"}, {"label": "C", "text": "The larger sulfur atom overlaps poorly with the carbonyl carbon, so the thioester gains little resonance stabilization and its acyl group is more easily transferred to a nucleophile"}, {"label": "D", "text": "The carbon-sulfur bond is shorter and stronger than a carbon-oxygen bond, so more energy is stored in the linkage and released when the acyl group is transferred"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Citric Acid Cycle.''

The answer is C because a thioester is a high-energy, reactive acyl donor precisely because it lacks the resonance stabilization that an ordinary oxygen ester enjoys. In an oxygen ester, the ester oxygen''s lone pair delocalizes efficiently into the carbonyl \(\pi\) system, stabilizing the ground state and making the acyl group reluctant to leave. Sulfur is a larger, more diffuse atom whose 3p lone pairs overlap poorly with the carbon 2p orbital of the carbonyl, so that resonance donation is weak. With little ground-state stabilization to give up, the thioester''s carbonyl carbon stays more electrophilic and the acyl group is transferred to an incoming nucleophile far more readily than from an oxygen ester. This is exactly why the cell uses coenzyme A: the thioester linkage stores free energy and keeps the acetyl group activated for transfer.

(Choice C) is correct: it correctly attributes the thioester''s greater reactivity to weak sulfur-to-carbonyl resonance overlap, which leaves the ground state destabilized relative to an oxygen ester and makes acyl transfer easier.
(Choice A) is incorrect: sulfur is actually slightly less electronegative than oxygen, not more, and the reactivity difference is driven by poor resonance overlap rather than by inductive electron withdrawal that would supposedly stabilize the linkage.
(Choice B) is incorrect: it reverses the true relationship. Strong lone-pair donation into the carbonyl is what stabilizes oxygen esters and makes them unreactive; if the thioester had extra resonance stabilization it would be less reactive, not more.
(Choice D) is incorrect: the reactivity of a thioester comes from poor ground-state resonance stabilization, not from an unusually short, strong C-S bond storing energy. In fact the C-S bond is longer and weaker than a C-O bond, and a stronger bond would be harder, not easier, to break — bond-enthalpy arguments confuse simple bond strength with the resonance effect that actually governs acyl-transfer reactivity.

As a Skill 2 (reasoning about scientific concepts) item, the student reasons from orbital-overlap and resonance principles to predict relative acyl-donor reactivity, rather than recalling a memorized statement that acetyl-CoA is high-energy.', 'medium', '1D', 'Citric Acid Cycle', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'claims sulfur is more electronegative and inductively locks the acyl group in place, inverting both the electronegativity fact and the reactivity direction' FROM q
  UNION ALL
  SELECT id, 'B', 'reversed_relationship', 'asserts strong sulfur resonance donation raises reactivity, reversing that resonance stabilization is what makes oxygen esters unreactive' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'attributes thioester reactivity to a short strong C-S bond storing energy, substituting simple bond enthalpy for the governing resonance effect' FROM q;

-- Q4 [A4 · Pyruvate Dehydrogenase & Acetyl-CoA] hard skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Pyruvate Dehydrogenase & Acetyl-CoA', 'In a well-fed resting hepatocyte, the mitochondrial ATP concentration climbs and stays high for an extended period. The pyruvate dehydrogenase complex is controlled by two enzymes that add or remove a phosphate group: one enzyme is stimulated by this high-energy state. Reasoning from how covalent modification changes the complex''s activity, what happens to the complex, and by which enzyme?', '[{"label": "A", "text": "PDH phosphatase is activated by high ATP and phosphorylates the complex, inactivating it"}, {"label": "B", "text": "PDH kinase is activated by high ATP and dephosphorylates the complex, activating it"}, {"label": "C", "text": "PDH phosphatase is activated by high ATP and dephosphorylates the complex, activating it"}, {"label": "D", "text": "PDH kinase is activated by high ATP and phosphorylates the complex, inactivating it"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Citric Acid Cycle.''

The answer is D because a sustained high-ATP state signals that the cell has ample energy and should not keep feeding carbon into oxidation. Under those conditions PDH kinase is the enzyme that is stimulated; a kinase adds a phosphate group, and phosphorylation of this particular complex switches it off. So rising ATP promotes kinase activity, the complex becomes phosphorylated, and its activity falls, throttling acetyl-CoA production when energy is already abundant. The logic requires pairing the correct enzyme identity (kinase, which phosphorylates) with the correct functional consequence (phosphorylation inactivates PDH).

(Choice D) is correct: high ATP activates PDH kinase, kinases phosphorylate, and phosphorylation of this complex inactivates it, all three links being internally consistent and matching an energy-replete state that should suppress fuel oxidation.
(Choice A) is incorrect: a phosphatase removes phosphate; it cannot phosphorylate. This mismatches the enzyme''s chemistry even though it lands on the correct ''inactivation'' outcome for the wrong reason.
(Choice B) is incorrect: a kinase adds phosphate, so it cannot dephosphorylate. Pairing the kinase with dephosphorylation and activation reverses both the chemistry and the physiological response to high ATP.
(Choice C) is incorrect: this is the classic reversal in which high ATP is wrongly said to activate the phosphatase and turn the complex on. In a high-energy state the phosphatase is not the stimulated enzyme (it is favored instead by high ADP, pyruvate, and Ca2+), and activating PDH would wastefully burn fuel the cell does not need.

As a Skill 2 (reasoning about scientific concepts) item, the student must integrate enzyme chemistry, the direction of covalent modification, and the physiological meaning of a high-ATP state, not simply recall which enzyme does what.', 'hard', '1D', 'Citric Acid Cycle', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'assigns phosphorylation to a phosphatase, ignoring that phosphatases remove phosphate' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'assigns dephosphorylation to a kinase, contradicting kinase chemistry' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'reverses the kinase/phosphatase roles so high ATP wrongly activates PDH' FROM q;

-- Q5 [A5 · Pyruvate Dehydrogenase & Acetyl-CoA] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Pyruvate Dehydrogenase & Acetyl-CoA', 'A cell abruptly begins rapid contraction: pyruvate floods in from accelerated glycolysis, ADP rises sharply as ATP is spent, and both acetyl-CoA and \(\text{NADH}\) are being consumed downstream faster than they accumulate, keeping their levels low. Considering the allosteric and product signals acting on the pyruvate dehydrogenase complex, how does flux through the complex change?', '[{"label": "A", "text": "Flux rises: pyruvate and ADP activate the complex while low acetyl-CoA and \\(\\text{NADH}\\) relieve product inhibition"}, {"label": "B", "text": "Flux falls: rising ADP and abundant pyruvate inhibit the complex despite the low product levels"}, {"label": "C", "text": "Flux falls: without acetyl-CoA and \\(\\text{NADH}\\) present to stimulate it, the complex stays off"}, {"label": "D", "text": "Flux is unchanged: rising substrate and falling product signals offset, leaving activity at baseline"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Citric Acid Cycle.''

The answer is A because every signal in this scenario points the same direction. Pyruvate (the substrate) and ADP (a low-energy-charge signal) both favor the active, dephosphorylated form of the complex by stimulating PDH phosphatase and inhibiting PDH kinase, so their sharp rise pushes activity up. At the same time, the two products that normally shut the complex down, acetyl-CoA and \(\text{NADH}\), are being drained faster than they build up, so their inhibition is relieved; the low \(\text{NADH}\) also means \(\text{NAD}^+\) (a required substrate) is plentiful. Abundant activators plus withdrawn inhibitors both act to raise flux, so the complex runs faster, generating more acetyl-CoA to meet the contracting cell''s demand.

(Choice A) is correct: it correctly identifies pyruvate and ADP as activators and recognizes that low acetyl-CoA and \(\text{NADH}\) remove product inhibition, so both categories of signal drive flux upward.
(Choice B) is incorrect: it mislabels ADP and pyruvate as inhibitors. These are activators; treating a low-energy-charge signal (ADP) as inhibitory reverses the regulatory logic.
(Choice C) is incorrect: it treats low acetyl-CoA and \(\text{NADH}\) as a lack of positive stimulus, but these molecules are inhibitors, so their absence relieves suppression rather than leaving the complex ''off.'' It also ignores the strong activation from pyruvate and ADP.
(Choice D) is incorrect: the signals do not offset; activators are up and inhibitors are down, so both effects reinforce increased flux rather than canceling to baseline.

As a Skill 2 (reasoning about scientific concepts) item, the student integrates multiple simultaneous allosteric and product signals into a net directional prediction rather than recalling an isolated regulator.', 'medium', '1D', 'Citric Acid Cycle', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'labels ADP and pyruvate as inhibitors, inverting their activating role' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'treats acetyl-CoA/NADH as required activators whose absence keeps PDH off' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'assumes opposing signals cancel rather than recognizing they reinforce' FROM q;

-- Q6 [A6 · Pyruvate Dehydrogenase & Acetyl-CoA] easy skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Pyruvate Dehydrogenase & Acetyl-CoA', 'A patient with severe chronic malnutrition is found to have a specific water-soluble vitamin deficiency. In their tissues, pyruvate builds up because the complex that would normally consume it is crippled at its very first catalytic step, where the substrate''s carboxyl carbon is removed. Reasoning from which cofactor is needed for that initial decarboxylation, which vitamin deficiency best explains the pyruvate accumulation?', '[{"label": "A", "text": "Niacin (B3), whose \\(\\text{NAD}^+\\) form accepts the carbon released as \\(\\text{CO}_2\\)"}, {"label": "B", "text": "Thiamine (B1), whose pyrophosphate form is required for the first decarboxylation step"}, {"label": "C", "text": "Pantothenate (B5), whose coenzyme A form performs the initial decarboxylation"}, {"label": "D", "text": "Riboflavin (B2), whose \\(\\text{FAD}\\) form removes the first carbon as \\(\\text{CO}_2\\)"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Citric Acid Cycle.''

The answer is B because the failing step is specifically the initial decarboxylation, and that reaction depends on thiamine pyrophosphate (TPP), the active form of vitamin B1. TPP is the cofactor that attacks the \(\alpha\)-keto acid and enables loss of the carboxyl carbon as \(\text{CO}_2\) at the E1 step. If thiamine is deficient, this first step stalls, the complex cannot process its substrate, and pyruvate accumulates upstream. The other listed cofactors act at later points (electron transfer or acetyl carriage), so their loss would not specifically block the first decarboxylation described.

(Choice B) is correct: thiamine pyrophosphate is the cofactor for the initial decarboxylation, so its deficiency directly stalls the first catalytic step and causes pyruvate to build up, matching the described lesion.
(Choice A) is incorrect: \(\text{NAD}^+\) (from niacin) is the terminal electron acceptor of the complex, not the agent of decarboxylation. Its role is redox, and it does not physically ''accept the carbon'' of \(\text{CO}_2\).
(Choice C) is incorrect: coenzyme A (from pantothenate) carries the acetyl group after decarboxylation; it does not perform the decarboxylation itself, so its deficiency would not specifically block the first step.
(Choice D) is incorrect: \(\text{FAD}\) (from riboflavin) participates in electron transfer within the complex, not in removing the first carbon as \(\text{CO}_2\). Assigning decarboxylation to \(\text{FAD}\) confuses redox chemistry with carbon removal.

As a Skill 2 (reasoning about scientific concepts) item, the student maps a described mechanistic lesion (blocked first decarboxylation) onto the specific cofactor responsible, rather than recalling a vitamin list.', 'easy', '1D', 'Citric Acid Cycle', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'adjacent_fact', 'picks NAD+ because it is the true terminal acceptor, misassigning it to decarboxylation' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'assigns the decarboxylation to CoA, which actually carries acetyl afterward' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'credits FAD with carbon removal, confusing electron transfer with decarboxylation' FROM q;

-- Q7 [A7 · Pyruvate Dehydrogenase & Acetyl-CoA] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Pyruvate Dehydrogenase & Acetyl-CoA', 'A fasting patient is mobilizing stored triacylglycerol, and each molecule is hydrolyzed into three long-chain fatty acids plus one glycerol. An investigator radiolabels the carbons of a single triacylglycerol molecule and later recovers some of that label in newly synthesized blood glucose. Reasoning from how each fragment is catabolized, which fragment of the triacylglycerol supplied the labeled carbon that reached glucose, and why could the other fragment not?', '[{"label": "A", "text": "The fatty acids, because their many two-carbon acetyl units are the richest carbon source, whereas glycerol is too small a molecule to contribute a usable skeleton for glucose"}, {"label": "B", "text": "The glycerol, because it is converted directly into pyruvate by pyruvate dehydrogenase, whereas the fatty acids are trapped as acetyl-CoA behind that irreversible step"}, {"label": "C", "text": "The glycerol, because it is phosphorylated and oxidized to dihydroxyacetone phosphate, a gluconeogenic intermediate, whereas the fatty acids yield acetyl-CoA, which cannot supply net carbon for glucose"}, {"label": "D", "text": "The fatty acids, because odd runs of their carbons form propionyl-CoA that enters as succinyl-CoA, whereas glycerol is diverted entirely into ketone bodies"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Citric Acid Cycle.''

The answer is C because a triacylglycerol is split into two chemically distinct kinds of fragment, and only one of them can donate carbon to new glucose. The glycerol backbone is phosphorylated by glycerol kinase and oxidized to dihydroxyacetone phosphate, a triose phosphate that sits squarely on the gluconeogenic pathway, so its carbons can be assembled into glucose. Each fatty acid, by contrast, undergoes \(\beta\)-oxidation to acetyl-CoA, and acetyl-CoA cannot yield net carbon for glucose: the pyruvate dehydrogenase step that would be needed to run acetyl carbons back toward the gluconeogenic branch point is irreversible, and acetyl carbons entering the cycle are matched by carbon lost as \(\text{CO}_2\). The label therefore reaches glucose through the glycerol, not through the fatty-acyl chains.

(Choice C) is correct: it identifies glycerol as glucogenic through dihydroxyacetone phosphate and correctly denies the fatty-acyl-derived acetyl-CoA any net contribution to glucose.
(Choice A) is incorrect: it reverses the truth. Abundant acetyl units are not what matters, because acetyl-CoA is not gluconeogenic; the small glycerol molecule, not the plentiful fatty-acid carbon, is the fragment that feeds glucose synthesis.
(Choice B) is incorrect: glycerol does supply glucose, but it does so as dihydroxyacetone phosphate, not by being turned into pyruvate by pyruvate dehydrogenase; pyruvate dehydrogenase runs pyruvate to acetyl-CoA irreversibly and does not act on glycerol at all.
(Choice D) is incorrect: it names the fatty acids and invokes propionyl-CoA, but even-chain fatty acids give only acetyl-CoA, and glycerol is a gluconeogenic substrate rather than a molecule shunted entirely into ketones.

As a Skill 2 (reasoning about scientific concepts) item, the student must partition a single molecule into its catabolic fates and decide which fragment can donate carbon to gluconeogenesis, rather than recalling a stored list of glucogenic substrates.', 'medium', '1D', 'Citric Acid Cycle', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'picks fatty acids for their abundant acetyl carbon and dismisses glycerol as too small, reversing which fragment is glucogenic' FROM q
  UNION ALL
  SELECT id, 'B', 'process_step_confusion', 'right fragment but wrong mechanism, routing glycerol through pyruvate dehydrogenase to pyruvate instead of through dihydroxyacetone phosphate' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'invokes odd-chain propionyl-CoA to make even-chain fatty acids glucogenic and wrongly consigns glycerol to ketone bodies' FROM q;

-- Q8 [A8 · Pyruvate Dehydrogenase & Acetyl-CoA] hard skill4 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Pyruvate Dehydrogenase & Acetyl-CoA', 'An investigator measures relative pyruvate dehydrogenase activity in isolated mitochondria while independently varying two intramitochondrial ratios. The results are shown:

| Condition | [ATP]/[ADP] | [NADH]/[NAD⁺] | Relative PDH activity (%) |
|-----------|-------------|----------------|----------------------------|
| 1 | Low | Low | 100 |
| 2 | High | Low | 42 |
| 3 | Low | High | 38 |
| 4 | High | High | 9 |

Based only on these data, what regulatory logic best accounts for the activity pattern?', '[{"label": "A", "text": "A high [ATP]/[ADP] ratio alone suppresses activity, while the [NADH]/[NAD⁺] ratio has no effect"}, {"label": "B", "text": "A high value of either ratio alone raises activity, and both high together raise it further"}, {"label": "C", "text": "A high [NADH]/[NAD⁺] ratio alone suppresses activity, while the [ATP]/[ADP] ratio has no effect"}, {"label": "D", "text": "A high value of either ratio alone suppresses activity, and both high together suppress it further"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Citric Acid Cycle.''

The answer is D because the four conditions isolate each variable and reveal that both ratios independently suppress activity. Starting from condition 1 (both ratios low) at 100%, raising [ATP]/[ADP] alone (condition 2) drops activity to 42%, and raising [NADH]/[NAD\(^+\)] alone (condition 3) drops it to 38%; each high ratio, by itself, sharply lowers activity. When both ratios are high (condition 4), activity falls further to 9%, lower than either single change alone, indicating the two suppressive effects compound rather than one masking the other. The data therefore support a model in which a high energy charge and a high reduced-redox state each inhibit the complex, and their effects compound when both are elevated.

(Choice D) is correct: it matches every row, high [ATP]/[ADP] alone and high [NADH]/[NAD\(^+\)] alone each cut activity, and the two together produce the lowest value, consistent with compounding suppression.
(Choice A) is incorrect: it claims [NADH]/[NAD\(^+\)] has no effect, but condition 3 (high [NADH]/[NAD\(^+\)] alone) drops activity to 38%, directly contradicting that claim.
(Choice B) is incorrect: it reverses the direction of the effect. If high ratios raised activity, condition 4 would be highest, yet it is the lowest at 9%.
(Choice C) is incorrect: it claims [ATP]/[ADP] has no effect, but condition 2 (high [ATP]/[ADP] alone) drops activity to 42%, showing that ratio clearly suppresses the enzyme.

At the Skill 4 (data-based reasoning) level, the student must isolate the effect of each variable across the table and infer a compounding suppression model purely from the reported activities.', 'hard', '1D', 'Citric Acid Cycle', 'biochemistry', 4, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'partial_truth', 'reads only the ATP row and ignores the NADH-only condition''s drop' FROM q
  UNION ALL
  SELECT id, 'B', 'reversed_relationship', 'reads high ratios as activating, contradicting the lowest value at condition 4' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'reads only the NADH row and ignores the ATP-only condition''s drop' FROM q;

-- Q9 [A9 · Pyruvate Dehydrogenase & Acetyl-CoA] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Pyruvate Dehydrogenase & Acetyl-CoA', 'A patient with untreated chronic thiamine deficiency presents with an elevated blood lactate and a metabolic acidosis. A clinician reasons that the deficiency cripples the pyruvate dehydrogenase complex, so its three-carbon substrate can no longer be oxidized to acetyl-CoA and instead backs up. Following the carbon that accumulates and its most likely anaerobic fate, which sequence best explains the acidosis?', '[{"label": "A", "text": "Pyruvate accumulates and is reduced to lactate, and the rising lactate produces a lactic acidosis"}, {"label": "B", "text": "Acetyl-CoA accumulates and is converted to lactate, which lowers blood pH"}, {"label": "C", "text": "Pyruvate accumulates and is carboxylated to oxaloacetate, and excess oxaloacetate acidifies the blood"}, {"label": "D", "text": "Lactate accumulates and is oxidized to pyruvate, and the pyruvate directly produces the acidosis"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Citric Acid Cycle.''

The answer is A because thiamine deficiency blocks the pyruvate dehydrogenase complex at its thiamine-pyrophosphate-dependent first step (E1), so pyruvate can no longer be committed to acetyl-CoA and accumulates upstream. When the aerobic exit for pyruvate is blocked and cellular demand continues, the cell disposes of pyruvate anaerobically by reducing it to lactate (regenerating \(\text{NAD}^+\) for glycolysis). The resulting rise in lactate is what produces the lactic acidosis and the observed low pH. The chain is therefore substrate backup (pyruvate) followed by its anaerobic reduction (lactate), matching both the biochemistry of the block and the clinical picture.

(Choice A) is correct: pyruvate is the substrate that accumulates when PDH fails, and its reduction to lactate directly accounts for the elevated lactate and acidosis.
(Choice B) is incorrect: acetyl-CoA is the product downstream of the blocked step, so it does not accumulate when the complex is crippled; it is the molecule the cell can no longer make. Lactate is not formed from acetyl-CoA.
(Choice C) is incorrect: although pyruvate can be carboxylated to oxaloacetate, that anaplerotic route consumes pyruvate rather than explaining a lactic acidosis, and oxaloacetate is not the acid measured. This misidentifies the acid and the dominant fate.
(Choice D) is incorrect: it reverses the redox direction. Under anaerobic stress the flux is reduction of pyruvate to lactate, not oxidation of lactate back to pyruvate; and pyruvate itself is not the acid producing the picture.

As a Skill 2 (reasoning about scientific concepts) item, the student traces a cofactor-failure lesion to the accumulating substrate and its anaerobic fate, connecting mechanism to a clinical acidosis rather than recalling a fact.', 'hard', '1D', 'Citric Acid Cycle', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'process_step_confusion', 'picks the downstream product acetyl-CoA as the accumulating species' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'diverts pyruvate to oxaloacetate and misnames it as the causative acid' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'reverses the lactate/pyruvate redox direction and misidentifies the acid' FROM q;

-- Q10 [B1 · Fatty-Acid & Amino-Acid Entry] easy skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Fatty-Acid & Amino-Acid Entry', 'A researcher follows a saturated fatty acyl-CoA through one turn of a repeating catabolic spiral in an isolated organelle. During each turn, the chain is shortened from its carboxyl end, one molecule of a two-carbon thioester is released, and two reduced electron carriers (one flavin-based, one nicotinamide-based) are generated. Based on this described chemistry, which combination correctly identifies the two-carbon product released each turn and the compartment in which the spiral runs?', '[{"label": "A", "text": "Malonyl-CoA, released in the mitochondrial matrix"}, {"label": "B", "text": "Acetyl-CoA, released in the mitochondrial matrix"}, {"label": "C", "text": "Acetyl-CoA, released in the cytosol"}, {"label": "D", "text": "Succinyl-CoA, released in the cytosol"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is B because the described spiral is beta-oxidation, and the reasoning is forced entirely by the chemistry in the stem rather than by a remembered label. A two-carbon unit is cleaved from the carboxyl end and leaves attached to coenzyme A as a thioester; the only two-carbon acyl-CoA that is a genuine product of chain shortening is acetyl-CoA. The co-generation of one flavin-based carrier (\(\text{FADH}_2\)) and one nicotinamide-based carrier (\(\text{NADH}\)) each turn matches the two oxidation steps of a single beta-oxidation cycle, and this oxidative machinery, together with the electron carriers it feeds into the electron transport chain, resides in the mitochondrial matrix.

(Choice B) is correct: a two-carbon thioester cleaved from a fatty acyl chain is acetyl-CoA, and the FADH2/NADH-producing spiral that generates it operates in the matrix, where those carriers can reach the inner-membrane electron transport chain.
(Choice A) is incorrect: malonyl-CoA is a three-carbon (dicarboxylic) intermediate of fatty-acid SYNTHESIS built by carboxylating acetyl-CoA; it is not a two-carbon product of chain shortening, so it fails the carbon count and the catabolic direction described.
(Choice C) is incorrect: it correctly names acetyl-CoA but places the spiral in the cytosol; a stem that generates matrix-destined FADH2 and NADH cannot be cytosolic, and the two-carbon-removing oxidation runs in the matrix, not the cytosol.
(Choice D) is incorrect: succinyl-CoA is a four-carbon TCA-cycle thioester, not the two-carbon unit the stem specifies, and it is generated inside the cycle rather than released by chain shortening in the cytosol.

As a Skill 2 (reasoning about scientific concepts) item, the student must map described features (two-carbon thioester, dual reduced carriers, chain shortening) onto the identity and location of the process instead of reciting a definition.', 'easy', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'adjacent_fact', 'confuses the synthesis intermediate malonyl-CoA with the catabolic two-carbon product' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'believes beta-oxidation occurs in the cytosol (textbook error) despite matrix-destined carriers' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'swaps a four-carbon TCA thioester for the two-carbon beta-oxidation product' FROM q;

-- Q11 [B2 · Fatty-Acid & Amino-Acid Entry] hard skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Fatty-Acid & Amino-Acid Entry', 'In a fed hepatocyte, insulin signaling has driven cytosolic malonyl-CoA to a high concentration as the cell commits carbon to fatty-acid synthesis. A long-chain fatty acyl-CoA is nonetheless present at the outer mitochondrial membrane. Given that malonyl-CoA allosterically inhibits carnitine palmitoyltransferase I (CPT-I), what is the most direct predicted consequence for that acyl-CoA?', '[{"label": "A", "text": "It crosses the inner membrane freely because malonyl-CoA inhibits only the intramitochondrial CPT-II step"}, {"label": "B", "text": "It is oxidized faster because inhibiting CPT-I relieves feedback on the downstream beta-oxidation enzymes"}, {"label": "C", "text": "Its entry into the matrix is blocked at the rate-limiting shuttle step, so its mitochondrial beta-oxidation is suppressed"}, {"label": "D", "text": "It is shunted directly into the matrix by carnitine without requiring CPT-I, so oxidation continues unchanged"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is C because the stem supplies every fact needed to trace the block. A long-chain fatty acyl-CoA cannot cross the inner mitochondrial membrane on its own; \(\text{CPT-I}\) on the outer membrane must first transfer the acyl group from \(\text{CoA}\) onto carnitine, the acyl-carnitine is then ferried across, and \(\text{CPT-II}\) inside regenerates the acyl-CoA. \(\text{CPT-I}\) is the rate-limiting, committed step of fatty-acid oxidation, and the stem states that malonyl-CoA is high and inhibits \(\text{CPT-I}\). With that gatekeeper shut down, the acyl group is never loaded onto carnitine, so the acyl-CoA is stranded on the cytosolic side and matrix beta-oxidation is suppressed. This is the reciprocal-regulation checkpoint: while the cell is building fat (high malonyl-CoA from active acetyl-CoA carboxylase), it should not simultaneously burn it.

(Choice C) is correct: inhibiting \(\text{CPT-I}\), the rate-limiting shuttle enzyme, prevents formation of acyl-carnitine, so the acyl group cannot enter the matrix and beta-oxidation is turned off — exactly the outcome expected when malonyl-CoA is high.
(Choice A) is incorrect: it misassigns the malonyl-CoA-sensitive, rate-limiting role to \(\text{CPT-II}\) and assumes long-chain acyl-CoA can cross the inner membrane on its own. Malonyl-CoA inhibits \(\text{CPT-I}\), not \(\text{CPT-II}\), and long-chain acyl-CoA is membrane-impermeant without the carnitine shuttle.
(Choice B) is incorrect: it reverses the direction of the effect. Blocking the committed entry step cannot accelerate downstream oxidation — with no substrate delivered to the matrix, the beta-oxidation enzymes have nothing to act on, so flux falls rather than rises.
(Choice D) is incorrect: it treats carnitine as a passive carrier that moves acyl groups without \(\text{CPT-I}\). Carnitine only accepts the acyl group because \(\text{CPT-I}\) catalyzes the transesterification; with \(\text{CPT-I}\) inhibited there is no acyl-carnitine to shuttle, so oxidation does not continue unchanged.

As a Skill 2 (reasoning about scientific concepts) item, this question asks you to chain localization, the rate-limiting identity of \(\text{CPT-I}\), and allosteric regulation by malonyl-CoA into a single predicted consequence rather than to recall a definition.', 'hard', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'process_step_confusion', 'misassigns the malonyl-CoA-sensitive rate-limiting role to CPT-II instead of CPT-I' FROM q
  UNION ALL
  SELECT id, 'B', 'reversed_relationship', 'treats inhibition of the entry step as if it accelerated downstream oxidation' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'believes carnitine transports acyl groups without CPT-I catalysis' FROM q;

-- Q12 [B3 · Fatty-Acid & Amino-Acid Entry] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Fatty-Acid & Amino-Acid Entry', 'Two isolated fuel molecules are fully oxidized to CO2 and water: a glucose unit (average carbon oxidation state near 0) and a fatty-acid unit whose interior carbons are largely -CH2- groups (average carbon far more reduced). Per carbon atom, the fatty-acid fuel yields substantially more ATP. Which statement best explains this difference by reasoning from oxidation state?', '[{"label": "A", "text": "The fatty-acid carbons are already partially oxidized, so fewer oxidation steps are needed and less O2 is consumed per carbon"}, {"label": "B", "text": "Glucose carbons hold more C-H bonds than fatty-acid carbons, but glucose loses that energy as heat during glycolysis"}, {"label": "C", "text": "The two fuels deliver identical electrons per carbon; the ATP difference comes only from fatty acids having more carbons overall"}, {"label": "D", "text": "The more reduced fatty-acid carbons carry more C-H bonds, so their complete oxidation releases more electrons to the electron transport chain per carbon"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is D because ATP yield tracks the number of electrons a fuel can hand to the electron transport chain, and that in turn tracks how reduced the carbons start out. The stem states the fatty-acid carbons are largely \(-\text{CH}_2-\), i.e., more reduced (more C-H bonds), whereas glucose carbons sit near oxidation state zero and already bear C-OH bonds. Complete oxidation of every carbon to \(\text{CO}_2\) means the more reduced fatty-acid carbons must give up more electrons on the way, and those electrons become NADH/\(\text{FADH}_2\) that drive oxidative phosphorylation. More electrons per carbon therefore means more ATP per carbon.

(Choice D) is correct: it correctly links greater carbon reduction (more C-H) to more electrons delivered to the electron transport chain, which is the direct cause of higher ATP per carbon.
(Choice A) is incorrect: it reverses the oxidation state, calling the fatty-acid carbons "partially oxidized," and it wrongly frames lower O2 use as the source of extra ATP, when in fact more reduced fuel consumes MORE O2 per carbon (RQ ~0.7 for fat vs ~1.0 for carbohydrate).
(Choice B) is incorrect: it reverses which fuel is more reduced (glucose carbons carry fewer C-H bonds than \(-\text{CH}_2-\) chains) and invents a heat-loss mechanism not supported by the stem.
(Choice C) is incorrect: it denies any per-carbon difference, but the stem explicitly gives a per-carbon ATP advantage, which cannot arise if electrons per carbon were identical.

As a Skill 2 (reasoning about scientific concepts) item, the student reasons from carbon oxidation state to electron availability to ATP yield rather than recalling a memorized "fat is 9 kcal/g" fact.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'calls fatty-acid carbons oxidized and treats lower O2 use as the energy source' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'believes glucose is more reduced than a -CH2- chain and invokes phantom heat loss' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'attributes the whole effect to carbon count while denying per-carbon differences' FROM q;

-- Q13 [B4 · Fatty-Acid & Amino-Acid Entry] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Fatty-Acid & Amino-Acid Entry', 'A prolonged-fasting patient must sustain blood glucose by gluconeogenesis from amino-acid carbon. A nutritionist notes that the catabolic skeletons of four amino acids differ: some yield only acetyl-CoA or acetoacetate, while others yield pyruvate or a TCA intermediate. Which amino acid CANNOT contribute net carbon to new glucose, and why?', '[{"label": "A", "text": "Leucine, because its skeleton yields only acetyl-CoA/acetoacetate, which give no net glucose in humans"}, {"label": "B", "text": "Alanine, because its transamination product pyruvate is committed to acetyl-CoA and lost as CO2"}, {"label": "C", "text": "Aspartate, because its skeleton enters as oxaloacetate, which is fully consumed by the citric-acid cycle"}, {"label": "D", "text": "Glutamate, because its skeleton enters as alpha-ketoglutarate, a carbon that bypasses gluconeogenic routes"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is A because the question hinges on where a carbon skeleton enters metabolism, not on a memorized list. Leucine is a purely ketogenic amino acid: its skeleton is degraded only to acetyl-CoA and acetoacetate. Acetyl-CoA cannot support NET glucose synthesis in humans, because the two carbons it delivers to the TCA cycle are released as two \(\text{CO}_2\) before oxaloacetate is regenerated, and humans lack a glyoxylate cycle that could salvage them. A skeleton that terminates as acetyl-CoA therefore has no gluconeogenic exit, so leucine cannot contribute net carbon to glucose.

(Choice A) is correct: leucine is purely ketogenic, ending as acetyl-CoA/acetoacetate, and acetyl-CoA gives no net glucose, so leucine cannot feed gluconeogenesis.
(Choice B) is incorrect: alanine transaminates to pyruvate, which is a direct gluconeogenic precursor (via pyruvate carboxylase to oxaloacetate); the claim that its pyruvate is obligately lost as CO2 is false, so alanine IS glucogenic.
(Choice C) is incorrect: aspartate enters as oxaloacetate, the very branch point for gluconeogenesis (via PEP carboxykinase); this carbon supports glucose rather than being merely "consumed," so aspartate is glucogenic, not the exception.
(Choice D) is incorrect: glutamate enters as \(\alpha\)-ketoglutarate, a TCA intermediate that can be converted through the cycle to oxaloacetate and on to glucose; this is anaplerotic glucogenic carbon, not a bypass of gluconeogenesis.

As a Skill 2 (reasoning about scientific concepts) item, the student must reason from entry point (acetyl-CoA vs pyruvate vs TCA intermediate) to gluconeogenic capacity, identifying the one skeleton with no net-glucose exit.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'believes pyruvate from a glucogenic amino acid is obligately oxidized rather than carboxylated to OAA' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'treats oxaloacetate entry as consumption, missing that OAA is the gluconeogenic exit' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'thinks alpha-ketoglutarate carbon cannot reach gluconeogenesis via the cycle' FROM q;

-- Q14 [B5 · Fatty-Acid & Amino-Acid Entry] hard skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Fatty-Acid & Amino-Acid Entry', 'A researcher feeds a starving hepatocyte two radiolabeled fatty acids in separate trials: an even-chain fatty acid and an odd-chain fatty acid. Each is fully broken down by beta-oxidation, and both trials generate acetyl-CoA that condenses with oxaloacetate to enter the citric acid cycle. Only carbon from the odd-chain fatty acid appears in newly made glucose. Which explanation best accounts for this difference by tracking where each fuel''s carbons enter and leave the cycle?', '[{"label": "A", "text": "The odd carbon lets beta-oxidation release one extra acetyl-CoA, and it is that additional acetyl unit, not any propionyl fragment, whose two carbons are exported from the cycle as new glucose"}, {"label": "B", "text": "Odd-chain oxidation yields propionyl-CoA, which is carboxylated and rearranged to succinyl-CoA, a four-carbon intermediate that raises the cycle pool so its three carbons emerge as net oxaloacetate for glucose"}, {"label": "C", "text": "Propionyl-CoA is shorter than acetyl-CoA, so it slips past both decarboxylation steps and reaches oxaloacetate without losing any carbon, unlike the longer even-chain acetyl units it competes with"}, {"label": "D", "text": "Only odd-chain oxidation switches on a human glyoxylate cycle, which bypasses both decarboxylations and routes the terminal three-carbon unit straight to oxaloacetate for gluconeogenesis"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is B because net glucose formation depends on whether a fuel adds net carbon to the four-carbon intermediate pool. An even-chain fatty acid yields only acetyl-CoA; each two-carbon acetyl unit condenses with oxaloacetate to form citrate, but the cycle then releases exactly two \(\text{CO}_2\) (at isocitrate dehydrogenase and \(\alpha\)-ketoglutarate dehydrogenase) before oxaloacetate is regenerated, so the emerging oxaloacetate carries no net new carbon and nothing can be pulled into gluconeogenesis. An odd-chain fatty acid, in its final round of \(\beta\)-oxidation, leaves a three-carbon propionyl-CoA. Propionyl-CoA is carboxylated to methylmalonyl-CoA and rearranged to succinyl-CoA, a four-carbon cycle intermediate; because those three carbons enter the four-carbon pool without an offsetting decarboxylation, they are anaplerotic and raise the pool. That extra carbon can leave as net oxaloacetate and be committed to glucose (the carbon added during carboxylation is later released at PEP carboxykinase, so the net glucogenic contribution is the original three propionyl carbons). Humans lack a glyoxylate cycle, so the even-chain acetyl carbons have no rescue route.

(Choice B) is correct: it tracks the carbons precisely, showing propionyl-CoA''s three carbons enter as succinyl-CoA and add net four-carbon intermediate, exportable as oxaloacetate for glucose, while even-chain acetyl-CoA is carbon-neutral.
(Choice A) is incorrect: odd-chain oxidation does not release an extra acetyl-CoA; its distinguishing product is the three-carbon propionyl-CoA, and acetyl-CoA (from either fatty acid) can never yield net glucose because its two carbons are matched by two \(\text{CO}_2\).
(Choice C) is incorrect: propionyl-CoA does not slip past the decarboxylations; it enters the cycle only after carboxylation and rearrangement to succinyl-CoA, and the even-chain problem is the two-in/two-out \(\text{CO}_2\) offset, not the size of the acetyl unit.
(Choice D) is incorrect: humans lack a glyoxylate cycle entirely, so invoking its activation reverses the true constraint; that plant/microbe pathway, if present, would be what lets even-chain acetyl carbons make net glucose.

As a Skill 2 (reasoning about scientific concepts) item, the student performs carbon accounting across cycle entry and exit to distinguish anaplerotic propionyl-CoA entry from acetyl-CoA''s carbon-neutral entry.', 'hard', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'process_step_confusion', 'imagines odd-chain oxidation yields an extra acetyl-CoA rather than propionyl-CoA, and credits that acetyl unit with making glucose' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'believes a smaller propionyl-CoA physically bypasses the two decarboxylations and reaches oxaloacetate without losing carbon' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'asserts humans possess an active glyoxylate cycle, reversing the actual constraint' FROM q;

-- Q15 [B6 · Fatty-Acid & Amino-Acid Entry] hard skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Fatty-Acid & Amino-Acid Entry', 'A student labels the two carbons of an acetyl group and follows them from citrate synthase around one turn of the citric-acid cycle until oxaloacetate is regenerated. She finds that by the time oxaloacetate reforms, two carbons have exited as CO2. From this carbon bookkeeping alone, what does she correctly conclude about even-chain fatty acids as a source of NET new glucose in humans?', '[{"label": "A", "text": "They yield net glucose, because the two labeled carbons themselves are retained in oxaloacetate and carried into the gluconeogenic pathway"}, {"label": "B", "text": "They yield net glucose, because each acetyl-CoA adds two carbons and only one CO2 is released per cycle turn"}, {"label": "C", "text": "They cannot yield net glucose, because the two acetyl carbons entering are offset by two CO2 lost before oxaloacetate reforms, so the oxaloacetate pool gains no net carbon for gluconeogenesis"}, {"label": "D", "text": "They cannot yield net glucose, because acetyl-CoA is unable to condense with oxaloacetate and therefore never enters the cycle"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is C because the conclusion follows from counting carbons, exactly as the stem sets up. Even-chain fatty acids are catabolized to acetyl-CoA, and each acetyl-CoA delivers two carbons when citrate synthase condenses it with oxaloacetate. Over one turn the cycle releases two \(\text{CO}_2\) (at isocitrate dehydrogenase and at \(\alpha\)-ketoglutarate dehydrogenase) before oxaloacetate is regenerated. Two carbons in, two carbons out: the oxaloacetate pool gains no net carbon from the acetyl group, so there is no surplus four-carbon skeleton to be withdrawn for gluconeogenesis. Because humans lack a glyoxylate cycle to bypass these decarboxylations, even-chain fatty acids give no net glucose.

(Choice C) is correct: it states the carbon balance accurately (two in, two out) and draws the right conclusion that no net carbon reaches gluconeogenesis.
(Choice A) is incorrect: whether or not the SAME labeled atoms persist for a turn (in fact, on the first turn the two CO2 carbons come from oxaloacetate, not from the acetyl group), the NET carbon added to the oxaloacetate pool is zero; net glucose synthesis depends on net carbon gain, not on tracking specific atoms, so the conclusion is wrong.
(Choice B) is incorrect: it undercounts the decarboxylations; the cycle loses TWO CO2 per turn, not one, so the arithmetic that would leave a net carbon is false.
(Choice D) is incorrect: acetyl-CoA does condense with oxaloacetate (that is the citrate synthase step named in the stem); the barrier is the downstream carbon loss, not a failure to enter the cycle.

As a Skill 2 (reasoning about scientific concepts) item, the student reaches the answer purely through carbon accounting around the cycle rather than by recalling the rule that fat is not gluconeogenic.', 'hard', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'conflates persistence of specific labeled atoms with net carbon gain for glucose' FROM q
  UNION ALL
  SELECT id, 'B', 'scale_unit_error', 'counts only one CO2 per turn instead of two, breaking the carbon balance' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'wrongly claims acetyl-CoA cannot condense with oxaloacetate to enter the cycle' FROM q;

-- Q16 [B7 · Fatty-Acid & Amino-Acid Entry] hard skill4 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Fatty-Acid & Amino-Acid Entry', 'In an indirect-calorimetry session, a resting fasted subject is measured over one hour. The instrument records 1.40 mol of CO2 produced and 2.00 mol of O2 consumed during that interval. Using the respiratory quotient (RQ = CO2 produced / O2 consumed), which fuel is this subject predominantly oxidizing, and on what numerical basis?', '[{"label": "A", "text": "Predominantly carbohydrate: RQ = 1.40 / 2.00 = 0.70, near the ~1.0 expected for carbohydrate oxidation"}, {"label": "B", "text": "Predominantly carbohydrate: the ratio 2.00 / 1.40 = 1.43 indicates the ~1.0 range for carbohydrate"}, {"label": "C", "text": "Predominantly fat: RQ = 2.00 / 1.40 = 1.43, and higher ratios indicate the more reduced fat fuel"}, {"label": "D", "text": "Predominantly fat: RQ = 1.40 / 2.00 = 0.70, near the ~0.7 expected for fatty-acid oxidation"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is D because the fuel is inferred from the measured ratio, not recalled. The respiratory quotient is defined as \(\text{CO}_2\) produced divided by \(\text{O}_2\) consumed, so RQ \(= 1.40 / 2.00 = 0.70\). Carbohydrate oxidation gives an RQ near 1.0 because glucose supplies its own oxygen-rich carbons, whereas fatty-acid oxidation gives an RQ near 0.7: fats are more reduced, so more \(\text{O}_2\) must be consumed per \(\text{CO}_2\) produced, pushing the ratio below 1. A measured value of 0.70 therefore points to predominant fat oxidation, consistent with a fasted resting subject.

(Choice D) is correct: it computes RQ correctly as 0.70 and matches it to the ~0.7 fat signature.
(Choice A) is incorrect: it computes the same 0.70 but then misassigns it to carbohydrate; a value of 0.70 is the fat marker, not the ~1.0 carbohydrate marker, so the interpretation contradicts the number.
(Choice B) is incorrect: it inverts the RQ definition (O2/CO2 = 1.43) and then reads that inverted value as the ~1.0 carbohydrate range, doubling an error; the correct RQ is 0.70.
(Choice C) is incorrect: it also inverts the ratio to 1.43 and, although it lands on "fat," it does so for the wrong reason (higher ratio) and from a mis-defined quotient; a genuinely higher RQ near 1.0 would indicate carbohydrate, not fat.

At the Skill 4 (data-based reasoning) level, the student must both apply the RQ definition to the measured values and map the resulting number onto the correct fuel, resisting inverted-ratio and mismatched-interpretation traps.', 'hard', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 4, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'computes RQ correctly but maps 0.70 to carbohydrate instead of fat' FROM q
  UNION ALL
  SELECT id, 'B', 'reversed_relationship', 'inverts the RQ definition to O2/CO2 and reads 1.43 as carbohydrate' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'inverts the ratio and justifies fat by a spuriously high value' FROM q;

-- Q17 [B8 · Fatty-Acid & Amino-Acid Entry] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Fatty-Acid & Amino-Acid Entry', 'A cell biologist confirms that a fatty acid is first activated to its CoA thioester by acyl-CoA synthetase at the cytosolic face of the outer mitochondrial membrane, but that the enzymes shortening the chain two carbons at a time operate in the mitochondrial matrix. Reasoning from this spatial split alone, why must a carnitine-based shuttle stand between the two compartments?', '[{"label": "A", "text": "Because long-chain fatty acyl-CoA cannot cross the inner mitochondrial membrane, carnitine carries the acyl group across so it can reach the matrix enzymes that oxidize it"}, {"label": "B", "text": "Because the outer membrane is impermeable to acyl-CoA, carnitine ferries it across the outer membrane before activation can occur"}, {"label": "C", "text": "Because activation and oxidation both occur in the matrix, carnitine merely recycles CoA back to the cytosol after the acyl-CoA is formed"}, {"label": "D", "text": "Because acyl-CoA synthetase works only inside the matrix, carnitine exports the fatty acid to the cytosol to be activated there"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is A because the need for a shuttle follows directly from the compartments named in the stem. Activation produces a long-chain fatty acyl-CoA on the cytosolic side, but the enzymes that shorten the chain sit in the matrix, and long-chain acyl-CoA cannot cross the INNER mitochondrial membrane on its own. To bridge that barrier, CPT-I transfers the acyl group from CoA to carnitine on the outer membrane, the acylcarnitine is translocated across the inner membrane, and CPT-II regenerates acyl-CoA in the matrix. The shuttle exists precisely because the activated species is stranded on the wrong side of the inner membrane from the oxidative machinery.

(Choice A) is correct: it identifies the impermeant species (long-chain acyl-CoA), the barrier (inner membrane), and the shuttle''s job (deliver the acyl group to matrix enzymes).
(Choice B) is incorrect: the barrier is the INNER membrane, not the outer, and activation happens BEFORE the shuttle, not after; the outer membrane is relatively permeable, so this misplaces both the barrier and the sequence.
(Choice C) is incorrect: activation is cytosolic/outer-membrane, not in the matrix, so its premise contradicts the stem; the shuttle''s role is to import the acyl group, not merely to recycle CoA outward.
(Choice D) is incorrect: it reverses the location of acyl-CoA synthetase, placing activation in the matrix, whereas the stem states activation occurs at the outer-membrane/cytosolic face.

As a Skill 2 (reasoning about scientific concepts) item, the student infers the necessity of the shuttle from the mismatch between where the fuel is activated and where it is oxidized, rather than reciting the shuttle''s steps.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'process_step_confusion', 'puts the permeability barrier at the outer membrane and reverses activation/shuttle order' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'mislocates activation to the matrix and reduces the shuttle to CoA recycling' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'places acyl-CoA synthetase in the matrix and reverses the transport direction' FROM q;

-- Q18 [C1 · Ketone Bodies & Ethanol] easy skill1 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Ketone Bodies & Ethanol', 'A fasting patient''s blood contains all three ketone bodies. A clinician notes that the patient''s hepatic mitochondria are highly reduced (a high NADH/NAD\(^+\) ratio), and separately observes that one ketone body is continuously lost in the patient''s breath because it is volatile and cannot be metabolized. Which single molecule is BOTH the ketone body whose blood level rises when the mitochondrial NADH/NAD\(^+\) ratio increases AND the one favored by that highly reduced state?', '[{"label": "A", "text": "Acetoacetate, because it is the oxidized ketone body and it accumulates whenever mitochondrial NADH is high"}, {"label": "B", "text": "\\(\\beta\\)-hydroxybutyrate, because it is the reduced ketone body favored when the matrix is highly reduced"}, {"label": "C", "text": "Acetone, because it is the volatile breath ketone and therefore the one that tracks the mitochondrial redox state"}, {"label": "D", "text": "Acetyl-CoA, because it is the reduced two-carbon precursor whose level rises with the NADH/NAD\\(^+\\) ratio"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is B because acetoacetate and \(\beta\)-hydroxybutyrate are interconverted by \(\beta\)-hydroxybutyrate dehydrogenase, an NAD\(^+\)-linked reaction (acetoacetate + NADH + H\(^+\) \(\rightleftharpoons\) \(\beta\)-hydroxybutyrate + NAD\(^+\)) whose position reflects the mitochondrial NADH/NAD\(^+\) ratio. Reducing acetoacetate to \(\beta\)-hydroxybutyrate consumes NADH, so a highly reduced matrix (high NADH/NAD\(^+\)) drives the equilibrium toward \(\beta\)-hydroxybutyrate, raising its blood level relative to acetoacetate. The stem''s clue about the volatile, non-metabolizable breath ketone identifies acetone and is deliberately separate — it is not the molecule sensitive to redox, so the reasoning must center on the acetoacetate/\(\beta\)-hydroxybutyrate redox couple rather than on the volatility clue.

(Choice B) is correct: \(\beta\)-hydroxybutyrate is the reduced member of the redox pair, and a high NADH/NAD\(^+\) ratio shifts the \(\beta\)-hydroxybutyrate dehydrogenase equilibrium toward it, so its level rises exactly when the matrix is highly reduced — satisfying both conditions in the stem.
(Choice A) is incorrect: acetoacetate is the oxidized partner, so a high NADH/NAD\(^+\) ratio depletes it as it is reduced to \(\beta\)-hydroxybutyrate; it falls, not rises, under the reduced state, reversing the redox relationship.
(Choice C) is incorrect: acetone is indeed the volatile ketone exhaled and cannot be metabolized, but it forms by spontaneous decarboxylation of acetoacetate and is not part of the NAD\(^+\)-linked redox couple, so it does not track the mitochondrial NADH/NAD\(^+\) ratio — this choice rewards latching onto the breath clue instead of the redox reasoning.
(Choice D) is incorrect: acetyl-CoA is the two-carbon precursor from which ketone bodies are built, not a ketone body itself, so it fails the identity condition regardless of how the redox state moves it.

As a Skill 1 (knowledge of scientific concepts) item, the student must apply the NAD\(^+\)-linked equilibrium between acetoacetate and \(\beta\)-hydroxybutyrate to a described redox state and resist a salient but off-target volatility clue, isolating the reduced ketone body that both is redox-sensitive and rises when the matrix is reduced.', 'easy', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 1, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'swaps oxidized/reduced partner — assumes the oxidized ketone rises when NADH is high' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'picks the volatile breath ketone using the salient volatility clue instead of the redox reasoning' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'treats the acetyl-CoA precursor as itself a ketone body' FROM q;

-- Q19 [C2 · Ketone Bodies & Ethanol] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Ketone Bodies & Ethanol', 'During a multi-day fast, a patient''s plasma insulin is low, adipose lipolysis has surged, and hepatic mitochondria are flooded with fatty-acyl-derived acetyl-CoA that exceeds the oxaloacetate available to condense it. Given this metabolic state, what is the most likely hepatic output and its physiological consequence?', '[{"label": "A", "text": "Increased glycogen synthesis, replenishing the hepatic stores depleted by the fast"}, {"label": "B", "text": "Suppressed ketogenesis, forcing the brain to rely entirely on glucose throughout the fast"}, {"label": "C", "text": "Increased ketone-body synthesis, providing a fuel the brain progressively adapts to oxidize"}, {"label": "D", "text": "Increased fatty-acid synthesis, storing the surplus acetyl-CoA as hepatic triglyceride"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is C because the described state — low insulin, high fatty-acid flux, and acetyl-CoA outpacing the oxaloacetate needed for TCA entry — is precisely the trigger for ketogenesis: the liver diverts excess acetyl-CoA into ketone bodies and exports them, and over days the brain up-regulates the machinery to oxidize ketones so it can spare glucose. The other outputs contradict the low-insulin, fuel-mobilizing conditions given.

(Choice C) is correct: low insulin plus surplus mitochondrial acetyl-CoA drives hepatic ketogenesis, and the brain adaptively shifts toward ketone oxidation during prolonged fasting.
(Choice A) is incorrect: glycogen synthesis is an insulin-driven fed-state anabolic process; with insulin low and stores already tapped, the liver is mobilizing, not storing, so this reverses the hormonal logic. Incoming acetyl-CoA also cannot make net glucose or glycogen in humans.
(Choice B) is incorrect: this predicts the opposite of the actual response — the state described is exactly what raises ketogenesis, and suppressing it would leave the glucose-limited brain without its adaptive alternative fuel.
(Choice D) is incorrect: fatty-acid synthesis is a fed-state, high-insulin, cytosolic malonyl-CoA-driven pathway; malonyl-CoA would block \(\beta\)-oxidation entirely, which is incompatible with the high fatty-acid oxidation flux the stem specifies.

As a Skill 2 (reasoning about scientific concepts) item, the student must map a described hormonal and substrate state to the correct pathway output rather than recall a definition of ketogenesis.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'treats low-insulin fasting liver as an anabolic storing organ' FROM q
  UNION ALL
  SELECT id, 'B', 'reversed_relationship', 'believes fasting suppresses rather than induces ketogenesis' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'confuses ketogenic fasting state with lipogenic fed state' FROM q;

-- Q20 [C3 · Ketone Bodies & Ethanol] hard skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Ketone Bodies & Ethanol', 'A biochemist notes that hepatocytes synthesize and release large quantities of ketone bodies during starvation yet derive essentially none of their own ATP from them, whereas cardiac and skeletal muscle readily oxidize the same molecules. Which explanation best accounts for the liver being a net producer but not a consumer of ketone bodies?', '[{"label": "A", "text": "Hepatocytes cannot take acetoacetate back up across the plasma membrane, so the ketones they release can never re-enter the cell to be used"}, {"label": "B", "text": "Hepatocytes hold their mitochondria too oxidized to sustain \\(\\beta\\)-oxidation, so no acetyl-CoA is generated to feed the TCA cycle from ketones"}, {"label": "C", "text": "Hepatocytes convert essentially all of the ketone bodies they encounter into acetone, a volatile form that cannot be oxidized for energy"}, {"label": "D", "text": "Hepatocytes lack the activity that reactivates acetoacetate to acetoacetyl-CoA, so they cannot channel ketone bodies back into acetyl-CoA for the TCA cycle"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is D because using a ketone body for energy (ketolysis) first requires reactivating acetoacetate to acetoacetyl-CoA, and hepatocytes lack this reactivating transferase activity. Without that first committed step, the liver has no route to convert circulating acetoacetate into acetyl-CoA for the TCA cycle, so it can only assemble ketone bodies from the acetyl-CoA that \(\beta\)-oxidation supplies during starvation and export them. Peripheral tissues such as cardiac and skeletal muscle retain that reactivating activity, which is why they oxidize the very molecules the liver cannot use — making the liver a dedicated producer and the periphery the consumer.

(Choice D) is correct: the missing step is the intracellular reactivation of acetoacetate to acetoacetyl-CoA, the first committed reaction of ketone utilization; because hepatocytes lack this activity, hepatic ketones must be exported to tissues that can complete ketolysis.
(Choice A) is incorrect: uptake is not the barrier, since acetoacetate and \(\beta\)-hydroxybutyrate are small, water-soluble acids that readily enter cells; placing the block at the membrane misidentifies the defect, which is an intracellular reactivation step, not transport.
(Choice B) is incorrect: this reverses the real situation, because the starving liver is a robust site of \(\beta\)-oxidation — that flux is precisely what generates the acetyl-CoA feeding ketogenesis — so the liver''s inability to consume ketones cannot stem from an absence of \(\beta\)-oxidation.
(Choice C) is incorrect: acetone is only a minor, spontaneous (non-enzymatic) decarboxylation product of acetoacetate that is exhaled rather than metabolized; it is not the fate of ketones a cell takes up, so this invents a pathway the liver does not run.

As a Skill 2 (reasoning about scientific concepts) item, the student must reason from a specific functional deficiency in ketone reactivation to the tissue''s net metabolic role rather than recall that "the liver makes ketones."', 'hard', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'process_step_confusion', 'places the block at membrane uptake instead of intracellular reactivation' FROM q
  UNION ALL
  SELECT id, 'B', 'reversed_relationship', 'denies hepatic beta-oxidation that actually drives ketogenesis' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'imagines acetone as the fate of utilized ketones' FROM q;

-- Q21 [C4 · Ketone Bodies & Ethanol] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Ketone Bodies & Ethanol', 'Two hepatic samples produce ketone bodies. Sample X has a high mitochondrial \(\text{NADH}/\text{NAD}^+\) ratio (strongly reduced), while Sample Y has a low ratio (more oxidized). Predict how the \(\beta\)-hydroxybutyrate-to-acetoacetate ratio compares between the two samples and why.', '[{"label": "A", "text": "Sample X favors \\(\\beta\\)-hydroxybutyrate because abundant NADH drives reduction of acetoacetate; Sample Y favors acetoacetate"}, {"label": "B", "text": "Sample Y favors \\(\\beta\\)-hydroxybutyrate because a more oxidized mitochondrion pushes acetoacetate toward its reduced form"}, {"label": "C", "text": "Both samples show the same ratio because the interconversion is fixed and does not respond to the redox state"}, {"label": "D", "text": "Sample X favors acetoacetate because a high NADH level oxidizes \\(\\beta\\)-hydroxybutyrate back to acetoacetate"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is A because the acetoacetate/\(\beta\)-hydroxybutyrate interconversion is an NADH-linked redox couple: acetoacetate + NADH is reduced to \(\beta\)-hydroxybutyrate + \(\text{NAD}^+\). A mitochondrion held in a strongly reduced state (high \(\text{NADH}/\text{NAD}^+\), Sample X) pushes this equilibrium toward the reduced ketone, so \(\beta\)-hydroxybutyrate predominates; the more oxidized Sample Y sits farther toward acetoacetate. The ratio therefore reports the redox state, and X must carry the higher \(\beta\)-hydroxybutyrate-to-acetoacetate ratio.

(Choice A) is correct: high NADH (Sample X) drives the reductive step toward \(\beta\)-hydroxybutyrate, while the oxidized Sample Y leaves more acetoacetate, exactly tracking the \(\text{NADH}/\text{NAD}^+\) ratio.
(Choice B) is incorrect: it assigns the reduced product to the more oxidized sample, inverting the redox dependence — an oxidized mitochondrion pulls toward acetoacetate, not toward \(\beta\)-hydroxybutyrate.
(Choice C) is incorrect: the interconversion is an equilibrium driven by the NADH/\(\text{NAD}^+\) couple, so it is not fixed; claiming redox-independence contradicts the very basis of the ratio.
(Choice D) is incorrect: it has the direction of the NADH-linked reaction backward — NADH is the reductant that generates \(\beta\)-hydroxybutyrate, so a high NADH level cannot oxidize it back to acetoacetate.

As a Skill 2 (reasoning about scientific concepts) item, the student must reason from a given redox scenario to the position of a coupled equilibrium rather than recall which ketone is "major."', 'hard', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'assigns the reduced product to the oxidized redox state' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'treats the ketone ratio as redox-independent and fixed' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'runs the NADH-linked reduction in the oxidizing direction' FROM q;

-- Q22 [C5 · Ketone Bodies & Ethanol] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Ketone Bodies & Ethanol', 'In hepatocytes, ethanol is oxidized in two sequential steps — first to acetaldehyde, then to acetate (which is later activated to acetyl-CoA). A student is asked what happens to the cytosolic pyridine-nucleotide pool as a large ethanol load is cleared through these two oxidations. What is the direct consequence?', '[{"label": "A", "text": "Each oxidation reduces \\(\\text{NADP}^+\\) to \\(\\text{NADPH}\\), so the biosynthetic reducing pool expands without affecting \\(\\text{NADH}/\\text{NAD}^+\\)"}, {"label": "B", "text": "Each oxidation reduces \\(\\text{NAD}^+\\) to \\(\\text{NADH}\\), so the cytosolic \\(\\text{NADH}/\\text{NAD}^+\\) ratio rises sharply"}, {"label": "C", "text": "Each oxidation consumes \\(\\text{NADH}\\) to regenerate \\(\\text{NAD}^+\\), so the \\(\\text{NADH}/\\text{NAD}^+\\) ratio falls"}, {"label": "D", "text": "The two steps have opposite redox effects that cancel, leaving the \\(\\text{NADH}/\\text{NAD}^+\\) ratio unchanged overall"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is B because both steps of ethanol clearance are oxidations of the carbon substrate, and each is coupled to the reduction of \(\text{NAD}^+\) to \(\text{NADH}\): ethanol to acetaldehyde generates one \(\text{NADH}\), and acetaldehyde to acetate generates another. Two \(\text{NADH}\) are produced per ethanol with no offsetting oxidation of the pool, so clearing a large ethanol load drives the cytosolic \(\text{NADH}/\text{NAD}^+\) ratio sharply upward.

(Choice B) is correct: two NAD\(^+\)-reducing oxidations in series raise \(\text{NADH}\) relative to \(\text{NAD}^+\), the defining redox signature of ethanol metabolism.
(Choice A) is incorrect: these oxidations use the \(\text{NAD}^+\)/\(\text{NADH}\) couple, not the \(\text{NADP}^+\)/\(\text{NADPH}\) biosynthetic couple; swapping in NADPH misidentifies the electron acceptor and wrongly leaves NADH untouched.
(Choice C) is incorrect: it reverses the direction of electron flow — the carbon is being oxidized, so the cofactor must be reduced (\(\text{NAD}^+\to\text{NADH}\)), not the reverse; the ratio rises, it does not fall.
(Choice D) is incorrect: both steps run in the same oxidative direction and both generate \(\text{NADH}\), so they reinforce rather than cancel — there is no opposing reduction to offset them.

As a Skill 2 (reasoning about scientific concepts) item, the student must reason from the direction of two coupled oxidations to the net shift in the redox pool rather than recall the names of the two dehydrogenases.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'adjacent_fact', 'swaps the NAD+ couple for the NADP+ biosynthetic couple' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'treats substrate oxidation as consuming rather than producing NADH' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'assumes sequential steps have canceling redox effects' FROM q;

-- Q23 [C6 · Ketone Bodies & Ethanol] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Ketone Bodies & Ethanol', 'A fasted individual binges on alcohol and, hours later, presents with hypoglycemia and early fatty change in the liver. Knowing that ethanol oxidation floods the cytosol with \(\text{NADH}\), which chain of redox-driven effects best explains both findings?', '[{"label": "A", "text": "Excess \\(\\text{NADH}\\) pulls lactate to pyruvate and malate to oxaloacetate, feeding gluconeogenesis, so glucose falls only because the liver diverts it into stored fat"}, {"label": "B", "text": "Excess \\(\\text{NADH}\\) accelerates the TCA cycle, and the extra ATP produced shuts down glycogenolysis, lowering blood glucose while sparing fatty acids from oxidation"}, {"label": "C", "text": "Excess \\(\\text{NADH}\\) pushes pyruvate to lactate and oxaloacetate to malate, starving gluconeogenesis of substrate, while the reductive state favors hepatic fat retention"}, {"label": "D", "text": "Excess \\(\\text{NADH}\\) directly inhibits insulin release, and the resulting insulin deficit both lowers glucose uptake and triggers hepatic fat deposition"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is C because a high cytosolic \(\text{NADH}/\text{NAD}^+\) ratio pushes the NADH-linked equilibria toward their reduced products: pyruvate is driven to lactate and oxaloacetate to malate. Both pyruvate and oxaloacetate are essential gluconeogenic substrates, so depleting them stalls glucose production and produces hypoglycemia in a fasted person who has no glycogen left. The same reduced state disfavors \(\beta\)-oxidation and favors triglyceride accumulation, giving the early fatty liver — both findings flow from one redox shift.

(Choice C) is correct: draining pyruvate and oxaloacetate into lactate and malate removes gluconeogenic substrate (hypoglycemia) while the reductive, anti-oxidative environment promotes hepatic fat retention (fatty liver).
(Choice A) is incorrect: it runs both NADH-linked reactions backward — high NADH drives pyruvate/OAA toward their reduced forms, not lactate/malate toward the oxidized forms — so it wrongly has gluconeogenesis being fed rather than starved.
(Choice B) is incorrect: a high NADH/\(\text{NAD}^+\) ratio actually slows the NAD\(^+\)-dependent TCA dehydrogenases rather than accelerating the cycle, and the hypoglycemia here is a gluconeogenic-substrate problem, not a glycogenolysis-shutdown from surplus ATP.
(Choice D) is incorrect: the mechanism is a mass-action redox effect on hepatic gluconeogenic substrates, not a direct block of pancreatic insulin secretion; an insulin-release effect substitutes an endocrine story for the redox one the stem sets up (and an insulin deficit would blunt glucose uptake, raising rather than lowering glucose).

As a Skill 2 (reasoning about scientific concepts) item, the student must trace a single redox perturbation through two coupled equilibria to two clinical outcomes rather than recall a fact about alcohol.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'runs the NADH-linked reactions in the oxidizing direction, feeding gluconeogenesis' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'thinks high NADH speeds the TCA cycle and blames ATP-driven glycogenolysis shutdown' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'substitutes a direct insulin-secretion block for the redox mechanism' FROM q;

-- Q24 [C7 · Ketone Bodies & Ethanol] hard skill4 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Ketone Bodies & Ethanol', 'Following a single high dose of ethanol, an investigator samples blood alcohol concentration over several hours once metabolism is fully underway:

| Time (h) | Blood ethanol (mg/dL) |
|---|---|
| 1 | 150 |
| 2 | 130 |
| 3 | 110 |
| 4 | 90 |
| 5 | 70 |

What kinetic order does the elimination follow over this interval, and what does that imply about the responsible enzyme?', '[{"label": "A", "text": "First-order — a constant fraction is removed per hour, indicating the enzyme is far below saturation so rate is proportional to ethanol concentration"}, {"label": "B", "text": "Second-order — the decline steepens over time, indicating the rate depends on the square of the ethanol concentration"}, {"label": "C", "text": "Zero-order — the concentration falls by a constant fraction per hour, indicating the enzyme rate is proportional to how much ethanol remains"}, {"label": "D", "text": "Zero-order — the concentration falls by a constant amount per hour, indicating the metabolizing enzyme is saturated so rate is independent of ethanol concentration"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is D because the data drop by a fixed 20 mg/dL each hour (150 to 130 to 110 to 90 to 70) — a constant absolute rate of decline that does not slow as the concentration falls. A constant amount removed per unit time, independent of the remaining concentration, is the defining signature of zero-order kinetics, which arises when the metabolizing enzyme is saturated and operating at \(V_{max}\). The correct reading must be derived from the equal successive differences in the table, not recalled.

(Choice D) is correct: equal 20 mg/dL decrements per hour show a concentration-independent (zero-order) rate, consistent with a saturated enzyme running at maximal velocity.
(Choice A) is incorrect: first-order elimination removes a constant fraction, which would give shrinking absolute drops (e.g., 150 to 105 to 73.5); the table''s constant absolute decrements rule this out even though ethanol is a classic saturation example.
(Choice B) is incorrect: the decline is linear, not steepening, so nothing in the data supports a rate rising with the square of concentration — this misreads a straight line as an accelerating curve.
(Choice C) is incorrect: it pairs the right order label (zero-order) with the wrong justification — a constant fraction and rate proportional to remaining ethanol describe first-order behavior, so the description contradicts the label and the data.

At the Skill 4 (data-based reasoning) level, the student must extract the pattern of successive differences from the table to assign the kinetic order and connect it to enzyme saturation, rather than recognizing a stated fact.', 'hard', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 4, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'reads constant-amount decline as constant-fraction (first-order) elimination' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'misinterprets a linear decline as an accelerating higher-order curve' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'right order label attached to a first-order justification' FROM q;

-- Q25 [C8 · Ketone Bodies & Ethanol] easy skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Ketone Bodies & Ethanol', 'In severe ketoacidosis, a clinician detects a sweet, fruity odor on the patient''s breath and reasons that one of the three ketone bodies is being lost through exhalation rather than used as fuel. Which property of that ketone body explains why it leaves in the breath instead of being oxidized like the other two?', '[{"label": "A", "text": "Acetone is a small, volatile, non-metabolizable molecule, so it escapes as a gas in exhaled air rather than being reactivated to acetyl-CoA"}, {"label": "B", "text": "Acetoacetate is the most volatile ketone body, so it evaporates from the blood into the alveoli and is exhaled before tissues can oxidize it"}, {"label": "C", "text": "\\(\\beta\\)-hydroxybutyrate is charged and non-volatile, so it is the ketone body that partitions into breath rather than being retained for fuel"}, {"label": "D", "text": "Acetone is volatile but is exhaled only because peripheral tissues lack the transferase needed to convert it back to acetyl-CoA"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is A because among the three ketone bodies, acetone is the odd one out: it forms by spontaneous decarboxylation of acetoacetate, has no CoA-reactivation pathway, and is a small, volatile neutral molecule. Because it cannot be funneled back to acetyl-CoA and readily enters the gas phase, it partitions into alveolar air and is exhaled, producing the fruity breath — whereas acetoacetate and \(\beta\)-hydroxybutyrate are non-volatile acids that peripheral tissues do oxidize for fuel.

(Choice A) is correct: acetone''s volatility combined with its lack of any metabolic reactivation route is exactly why it is lost in breath instead of serving as fuel.
(Choice B) is incorrect: acetoacetate is a non-volatile carboxylic acid that tissues actively use as fuel via ketolysis, so it is neither the volatile species nor the one exhaled — this misassigns acetone''s property to acetoacetate.
(Choice C) is incorrect: \(\beta\)-hydroxybutyrate is a charged, non-volatile acid (the major circulating fuel ketone), so it is retained and oxidized, not exhaled — the reasoning contradicts its physical properties.
(Choice D) is incorrect: it names acetone correctly but attributes its exhalation to a missing transferase in peripheral tissues; acetone is intrinsically non-metabolizable and volatile, so the loss is due to its own chemistry, not a tissue-enzyme deficiency.

As a Skill 2 (reasoning about scientific concepts) item, the student must reason from the distinguishing physical and metabolic properties of acetone to why it, unlike the other two ketone bodies, is exhaled rather than burned.', 'easy', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'assigns acetone''s volatility to acetoacetate' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'claims the non-volatile major fuel ketone is the exhaled one' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'right molecule, wrong cause (blames missing transferase not intrinsic volatility)' FROM q;

-- Q26 [D1 · Citric Acid Cycle: Reactions & Intermediates] easy skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Citric Acid Cycle: Reactions & Intermediates', 'A two-carbon acetyl unit, carried as a high-energy thioester on coenzyme A, enters the citric acid cycle by condensing with a four-carbon acceptor to form the cycle''s first six-carbon intermediate. This entry reaction is essentially irreversible under cellular conditions and represents the committed step of the cycle. Which feature of the reactants best explains why this condensation proceeds so far toward product?', '[{"label": "A", "text": "The four-carbon acceptor is itself a high-energy phosphate donor whose phosphoryl transfer drives the condensation forward"}, {"label": "B", "text": "Cleavage of the high-energy acetyl-CoA thioester bond releases free energy that makes the aldol-type condensation strongly favorable"}, {"label": "C", "text": "The reaction reduces \\(\\text{NAD}^+\\) to \\(\\text{NADH}\\), and the accompanying redox drop pulls the condensation forward"}, {"label": "D", "text": "A molecule of \\(\\text{CO}_2\\) is released, and the escaping gas is what makes this entry step irreversible"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Citric Acid Cycle.''

The answer is B because the thermodynamic push comes from the acetyl group being delivered as a thioester on coenzyme A. Thioester bonds are high-energy: their cleavage releases a large amount of free energy, and it is the coupling of that energy to the otherwise only modestly favorable carbon-carbon (aldol-type) condensation that makes formation of the six-carbon product strongly exergonic and effectively irreversible. Reasoning purely from carbon count, a two-carbon acetyl unit plus a four-carbon acceptor gives a six-carbon product, but carbon count alone does not explain the large negative \(\Delta G\); the thioester energy does.

(Choice B) is correct: cleavage of the energy-rich acetyl-CoA thioester bond is coupled to the condensation, supplying the free energy that drives the reaction far toward the six-carbon product and locks in the committed step.
(Choice A) is incorrect: this embodies a confusion with substrate-level phosphorylation. The four-carbon acceptor (oxaloacetate) is not a phosphate donor; no phosphoryl transfer occurs at entry, and the driving force is a thioester, not a phosphoanhydride.
(Choice C) is incorrect: no \(\text{NAD}^+\) is reduced at the entry step. The first \(\text{NADH}\) is not generated until the later oxidative decarboxylation of the six-carbon acid, so redox chemistry cannot be what drives this condensation.
(Choice D) is incorrect: no \(\text{CO}_2\) is lost during entry; carbon is conserved as a two-carbon plus four-carbon unit becomes a six-carbon product. Decarboxylations occur only at later steps, so escaping gas is not the source of irreversibility here.

As a Skill 2 (reasoning about scientific concepts) item, the student must connect the chemical nature of the thioester carrier to the thermodynamics of the committed condensation rather than recall an enzyme name.', 'easy', '1D', 'Citric Acid Cycle', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'acceptor as phosphate donor / SLP confusion' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'attributes later NADH-generating oxidation to entry step' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'imports decarboxylation into the condensation step' FROM q;

-- Q27 [D2 · Citric Acid Cycle: Reactions & Intermediates] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Citric Acid Cycle: Reactions & Intermediates', 'During a single turn of the citric acid cycle, a six-carbon intermediate is progressively degraded, and two molecules of \(\text{CO}_2\) are released before the four-carbon acceptor is regenerated. A student tracing the carbon skeleton wants to locate exactly where the two carbons leave. In which two transformations is \(\text{CO}_2\) actually lost?', '[{"label": "A", "text": "In the entry condensation that forms the six-carbon acid and in the final regeneration of the four-carbon acceptor"}, {"label": "B", "text": "In the isomerization of the six-carbon acid and in the substrate-level phosphorylation that yields the four-carbon acid"}, {"label": "C", "text": "In the two oxidative decarboxylations, first from the six-carbon acid to the five-carbon acid and then to the four-carbon thioester"}, {"label": "D", "text": "In the two dehydrogenation steps that reduce electron carriers, namely the succinate and malate oxidations"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Citric Acid Cycle.''

The answer is C because the two carbons leave precisely at the two oxidative decarboxylations, where the carbon skeleton shrinks. The six-carbon acid (isocitrate) is oxidatively decarboxylated to the five-carbon \(\alpha\)-ketoglutarate, releasing the first \(\text{CO}_2\); then \(\alpha\)-ketoglutarate is oxidatively decarboxylated to the four-carbon succinyl-CoA thioester, releasing the second \(\text{CO}_2\). Tracing carbon count, this is the only place the skeleton drops from six to five and then from five to four, so this is where the two \(\text{CO}_2\) must originate.

(Choice C) is correct: the two decarboxylations (six-carbon to five-carbon, then five-carbon to four-carbon) are exactly the two carbon-shedding steps, and each is also where an \(\text{NADH}\) is produced.
(Choice A) is incorrect: this misreads the bookkeeping. The entry condensation adds carbon (two plus four gives six) to form the six-carbon acid rather than removing it, and the final step reforms the four-carbon acceptor without releasing \(\text{CO}_2\), so no gas is lost at either point.
(Choice B) is incorrect: isomerization of the six-carbon acid rearranges atoms without changing carbon count, and the substrate-level phosphorylation step converts a four-carbon thioester to a four-carbon acid, so neither loses \(\text{CO}_2\).
(Choice D) is incorrect: this confuses dehydrogenation with decarboxylation. The succinate and malate oxidations remove electrons and hydrogens to reduce carriers, but the carbon skeleton stays at four carbons throughout, so no \(\text{CO}_2\) departs there.

As a Skill 2 (reasoning about scientific concepts) item, the student must locate carbon loss by following the shrinking skeleton rather than recalling a list.', 'medium', '1D', 'Citric Acid Cycle', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'places CO2 loss at entry/regeneration instead of decarboxylations' FROM q
  UNION ALL
  SELECT id, 'B', 'process_step_confusion', 'assigns CO2 loss to isomerization and SLP steps' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'confuses dehydrogenation with decarboxylation' FROM q;

-- Q28 [D3 · Citric Acid Cycle: Reactions & Intermediates] easy skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Citric Acid Cycle: Reactions & Intermediates', 'In one turn of the citric acid cycle, four oxidation steps reduce electron carriers, but the carriers are not all the same: three of the oxidations feed one carrier while a single oxidation feeds a different carrier. A student notes that the odd oxidation out is the one embedded in the inner mitochondrial membrane. How many \(\text{NADH}\) versus \(\text{FADH}_2\) are produced per turn, and which oxidation accounts for the \(\text{FADH}_2\)?', '[{"label": "A", "text": "Two \\(\\text{NADH}\\) and two \\(\\text{FADH}_2\\); the two decarboxylations produce the \\(\\text{FADH}_2\\)"}, {"label": "B", "text": "Three \\(\\text{NADH}\\) and one \\(\\text{FADH}_2\\); the malate-to-oxaloacetate oxidation produces the \\(\\text{FADH}_2\\)"}, {"label": "C", "text": "One \\(\\text{NADH}\\) and three \\(\\text{FADH}_2\\); the two decarboxylations and the succinate oxidation produce the \\(\\text{FADH}_2\\)"}, {"label": "D", "text": "Three \\(\\text{NADH}\\) and one \\(\\text{FADH}_2\\); the succinate-to-fumarate oxidation produces the \\(\\text{FADH}_2\\)"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Citric Acid Cycle.''

The answer is D because three of the four oxidations use \(\text{NAD}^+\) as acceptor and only one uses \(\text{FAD}\). The two oxidative decarboxylations (isocitrate to \(\alpha\)-ketoglutarate and \(\alpha\)-ketoglutarate to succinyl-CoA) and the terminal malate-to-oxaloacetate oxidation each reduce \(\text{NAD}^+\) to \(\text{NADH}\), giving three \(\text{NADH}\). The lone \(\text{FAD}\)-dependent oxidation is succinate to fumarate, whose enzyme (succinate dehydrogenase, Complex II) is membrane-embedded, so that step alone yields the single \(\text{FADH}_2\). The clue that the odd oxidation is in the inner membrane points directly to the succinate oxidation.

(Choice D) is correct: three \(\text{NAD}^+\)-reducing oxidations plus one \(\text{FAD}\)-reducing oxidation give 3 \(\text{NADH}\) + 1 \(\text{FADH}_2\), and the \(\text{FADH}_2\) comes from the membrane-bound succinate-to-fumarate step.
(Choice A) is incorrect: it miscounts the carriers and misassigns the \(\text{FADH}_2\). The decarboxylations reduce \(\text{NAD}^+\), not \(\text{FAD}\), and only one \(\text{FADH}_2\) is made per turn, not two.
(Choice B) is incorrect: the count of 3 \(\text{NADH}\) and 1 \(\text{FADH}_2\) is right, but the malate oxidation reduces \(\text{NAD}^+\); it is the succinate oxidation, not the malate oxidation, that uses \(\text{FAD}\). The membrane clue also excludes malate dehydrogenase, which is a soluble matrix enzyme.
(Choice C) is incorrect: this reverses the ratio entirely. Only one step uses \(\text{FAD}\), so producing three \(\text{FADH}_2\) and one \(\text{NADH}\) contradicts the fact that the two decarboxylations and the malate step are all \(\text{NAD}^+\)-linked.

As a Skill 2 (reasoning about scientific concepts) item, the student must reason about which oxidations pair with which carrier rather than memorizing a tally.', 'easy', '1D', 'Citric Acid Cycle', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'assigns FADH2 to decarboxylations and doubles the count' FROM q
  UNION ALL
  SELECT id, 'B', 'adjacent_fact', 'correct count but wrong FAD step (malate instead of succinate)' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'inverts NADH:FADH2 ratio' FROM q;

-- Q29 [D4 · Citric Acid Cycle: Reactions & Intermediates] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Citric Acid Cycle: Reactions & Intermediates', 'A student is tracing the first oxidative decarboxylation of the cycle. The six-carbon acid isocitrate is first oxidized to an unstable \(\beta\)-keto acid intermediate, which then loses \(\text{CO}_2\). The student reasons: "Oxidation plus loss of one carbon should give the four-carbon acceptor back, so the product must be oxaloacetate." What is the actual product of this transformation, and why is the student''s reasoning wrong?', '[{"label": "A", "text": "\\(\\alpha\\)-ketoglutarate, a five-carbon acid; only one carbon is lost as \\(\\text{CO}_2\\), so a six-carbon acid becomes a five-carbon acid, not a four-carbon acid"}, {"label": "B", "text": "Oxaloacetate; the student is correct because oxidative decarboxylation of a six-carbon acid always yields the four-carbon acceptor"}, {"label": "C", "text": "Succinyl-CoA, a four-carbon thioester; the single decarboxylation directly generates the thioester and the four-carbon skeleton"}, {"label": "D", "text": "Citrate; the oxidation regenerates the six-carbon tricarboxylic acid and no net carbon is lost"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Citric Acid Cycle.''

The answer is A because the arithmetic of a single decarboxylation forbids jumping from six carbons to four. Isocitrate (six carbons) is oxidized to the unstable \(\beta\)-keto acid oxalosuccinate, which loses one \(\text{CO}_2\) to become the five-carbon \(\alpha\)-ketoglutarate, along with the first \(\text{NADH}\). Losing only one carbon means a six-carbon acid must give a five-carbon product; oxaloacetate has four carbons and cannot be reached by a single decarboxylation. The student conflated the eventual four-carbon acceptor with the immediate product.

(Choice A) is correct: one \(\text{CO}_2\) is released, so the six-carbon isocitrate becomes the five-carbon \(\alpha\)-ketoglutarate (through the oxalosuccinate intermediate), producing the first \(\text{NADH}\).
(Choice B) is incorrect: this is the target misconception. Reaching oxaloacetate (four carbons) from isocitrate (six carbons) would require losing two carbons, but this single step sheds only one \(\text{CO}_2\), so the carbon count rules it out.
(Choice C) is incorrect: succinyl-CoA is the four-carbon thioester, but it is produced only after a second oxidative decarboxylation of \(\alpha\)-ketoglutarate; it cannot arise from isocitrate in one step, which would require losing two carbons and forming a thioester.
(Choice D) is incorrect: citrate is the six-carbon precursor that was isomerized to isocitrate before this step; an oxidative decarboxylation removes a carbon and cannot rebuild citrate, so no-net-carbon-loss is inconsistent with releasing \(\text{CO}_2\).

As a Skill 2 (reasoning about scientific concepts) item, the student must use single-step carbon accounting to reject a tempting but arithmetically impossible product.', 'hard', '1D', 'Citric Acid Cycle', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'isocitrate oxidized straight to oxaloacetate (two-carbon jump)' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'collapses two decarboxylations into one, yielding succinyl-CoA' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'treats oxidative decarboxylation as regenerating citrate' FROM q;

-- Q30 [D5 · Citric Acid Cycle: Reactions & Intermediates] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Citric Acid Cycle: Reactions & Intermediates', 'Most of the energy captured by the citric acid cycle leaves as reduced electron carriers, yet exactly one step of the cycle produces a nucleoside triphosphate directly, without the electron transport chain. This step converts a four-carbon thioester to a four-carbon acid. What makes this the only step able to phosphorylate a nucleotide on its own, and what nucleotide is formed?', '[{"label": "A", "text": "It is the only step that reduces a carrier, and the resulting \\(\\text{NADH}\\) is used to phosphorylate GDP to GTP within the enzyme"}, {"label": "B", "text": "Cleaving the high-energy thioester bond releases enough free energy to phosphorylate GDP to GTP directly, the cycle''s sole substrate-level phosphorylation"}, {"label": "C", "text": "It is the only step embedded in the inner membrane, so it taps the proton gradient to phosphorylate ADP to ATP"}, {"label": "D", "text": "Loss of \\(\\text{CO}_2\\) at this step provides the free energy needed to phosphorylate GDP to GTP directly, bypassing the chain"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Citric Acid Cycle.''

The answer is B because the four-carbon substrate is a thioester (succinyl-CoA), and thioester bonds store enough free energy that their cleavage can be coupled directly to phosphorylation. As succinyl-CoA is converted to succinate, the energy of the thioester bond is captured by phosphorylating GDP to GTP (which is readily interconverted with ATP by nucleoside-diphosphate kinase). No other cycle step carries a comparable activated bond positioned for phosphoryl transfer, so this is the only substrate-level phosphorylation and the only step that makes a nucleoside triphosphate without the electron transport chain.

(Choice B) is correct: the energy released by cleaving the succinyl-CoA thioester bond is coupled to GDP phosphorylation, yielding GTP directly by substrate-level phosphorylation.
(Choice A) is incorrect: it conflates redox chemistry with phosphorylation. This is not even the only carrier-reducing step, and \(\text{NADH}\) is not consumed to phosphorylate GDP here; \(\text{NADH}\) delivers electrons to the electron transport chain, a separate route, whereas this step''s energy source is the thioester bond.
(Choice C) is incorrect: the membrane-embedded step is the succinate-to-fumarate oxidation, not this one, and using the proton gradient describes oxidative phosphorylation, which is precisely the process this direct step bypasses.
(Choice D) is incorrect: no \(\text{CO}_2\) is lost at this four-carbon-to-four-carbon step; the decarboxylations occur earlier, so escaping gas cannot be the energy source for the phosphorylation.

As a Skill 2 (reasoning about scientific concepts) item, the student must link the activated-bond chemistry to why only this step phosphorylates a nucleotide directly.', 'medium', '1D', 'Citric Acid Cycle', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'NADH used to phosphorylate GDP (redox/SLP conflation)' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'attributes proton-gradient/oxidative phosphorylation to this step' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'imports decarboxylation energy into the SLP step' FROM q;

-- Q31 [D6 · Citric Acid Cycle: Reactions & Intermediates] hard skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Citric Acid Cycle: Reactions & Intermediates', 'In the Citric Acid Cycle, three oxidations reduce \(\text{NAD}^+\), but the succinate-to-fumarate oxidation reduces \(\text{FAD}\) instead. The succinate/fumarate couple has a standard reduction potential near \(0\ \text{V}\), whereas the \(\text{NAD}^+/\text{NADH}\) couple is near \(-0.32\ \text{V}\). Which statement best explains why this step uses \(\text{FAD}\) and why it occupies a special location in the mitochondrion?', '[{"label": "A", "text": "\\(\\text{NAD}^+\\) is used here just as elsewhere, but the resulting \\(\\text{NADH}\\) is relabeled \\(\\text{FADH}_2\\) once it reaches the membrane"}, {"label": "B", "text": "The succinate/fumarate couple is far more negative than \\(\\text{NAD}^+/\\text{NADH}\\) and would over-reduce \\(\\text{NAD}^+\\), so \\(\\text{FAD}\\) is used; the enzyme floats free in the matrix like the others"}, {"label": "C", "text": "For electrons to flow to \\(\\text{NAD}^+\\) the donor couple must be more negative than \\(\\text{NAD}^+/\\text{NADH}\\); succinate/fumarate is not, so \\(\\text{FAD}\\) accepts the electrons. The enzyme is Complex II, embedded in the inner membrane, feeding electrons directly into the electron transport chain"}, {"label": "D", "text": "\\(\\text{FAD}\\) is used because this step is a decarboxylation, and decarboxylations always pair with \\(\\text{FAD}\\); the enzyme is a soluble matrix protein"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Citric Acid Cycle.''

The answer is C because the carrier choice is dictated by thermodynamics. Electrons flow spontaneously from a donor to \(\text{NAD}^+\) only when the donor couple sits at a more negative reduction potential than the \(\text{NAD}^+/\text{NADH}\) couple (near \(-0.32\ \text{V}\)). The succinate/fumarate couple sits near \(0\ \text{V}\) — well above \(\text{NAD}^+/\text{NADH}\) — so it cannot reduce \(\text{NAD}^+\). \(\text{FAD}\), tightly bound in succinate dehydrogenase, accepts these electrons instead. That same enzyme is Complex II, embedded in the inner mitochondrial membrane, which is why this step is the direct membrane link between the cycle and the electron transport chain.

(Choice C) is correct: because succinate/fumarate is not negative enough to reduce \(\text{NAD}^+\), \(\text{FAD}\) is used, and the enzyme is the membrane-bound Complex II that delivers electrons straight into the electron transport chain.
(Choice A) is incorrect: carriers are not relabeled. \(\text{NADH}\) and \(\text{FADH}_2\) are chemically distinct molecules; this step genuinely reduces \(\text{FAD}\), it does not convert an \(\text{NADH}\) into an \(\text{FADH}_2\).
(Choice B) is incorrect: it inverts the thermodynamics. The couple''s potential is too high (near \(0\ \text{V}\), not negative enough), not too negative, and the enzyme is membrane-bound rather than free in the matrix.
(Choice D) is incorrect: this step is a dehydrogenation, not a decarboxylation, and no rule ties decarboxylations to \(\text{FAD}\); in fact the cycle''s two decarboxylations both reduce \(\text{NAD}^+\), and the enzyme is membrane-embedded, not soluble.

As a Skill 2 (reasoning about scientific concepts) item, the student must reason from the reduction-potential ordering to justify the carrier and connect the step to its membrane location.', 'hard', '1D', 'Citric Acid Cycle', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'carriers are interchangeable / NADH relabeled as FADH2' FROM q
  UNION ALL
  SELECT id, 'B', 'reversed_relationship', 'inverts the reduction-potential argument (too negative vs not negative enough)' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'calls the dehydrogenation a decarboxylation and invents an FAD rule' FROM q;

-- Q32 [D7 · Citric Acid Cycle: Reactions & Intermediates] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Citric Acid Cycle: Reactions & Intermediates', 'A mitochondrion contains only a trace amount of the four-carbon acceptor oxaloacetate, yet it can oxidize a large and continuous supply of acetyl groups through the cycle. The final step of each turn oxidizes malate back to oxaloacetate, producing the third \(\text{NADH}\). Which explanation accounts for how so little acceptor can process so many acetyl units?', '[{"label": "A", "text": "Oxaloacetate is consumed stoichiometrically with each acetyl group, so the trace pool limits the cycle to a few turns until more is synthesized"}, {"label": "B", "text": "Oxaloacetate is not actually required; acetyl-CoA can be oxidized on its own once the pool of acceptor runs out"}, {"label": "C", "text": "The trace oxaloacetate is converted to \\(\\text{CO}_2\\) each turn, and fresh acceptor is continuously imported from the cytosol to replace it"}, {"label": "D", "text": "Each turn regenerates oxaloacetate when malate is oxidized, so the same acceptor is reused catalytically and a trace pool can turn over many times"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Citric Acid Cycle.''

The answer is D because oxaloacetate functions catalytically, not as a consumed reactant. The cycle begins by condensing an acetyl group with oxaloacetate and ends by regenerating oxaloacetate when malate is oxidized (yielding the third \(\text{NADH}\)). Because each turn hands back the acceptor it started with, one molecule of oxaloacetate can be used over and over; a small standing pool therefore supports the oxidation of many acetyl units, exactly as a catalyst enables many reaction cycles without being used up.

(Choice D) is correct: the malate oxidation reforms oxaloacetate every turn, so the acceptor is recycled and a trace pool can turn over indefinitely to process a large flux of acetyl groups.
(Choice A) is incorrect: it treats oxaloacetate as a stoichiometric reactant that is used up. If that were true, the cycle would stall after a few turns, contradicting the observation that a trace pool sustains continuous oxidation because the acceptor is regenerated.
(Choice B) is incorrect: acetyl-CoA cannot be oxidized by the cycle without an acceptor to condense with; entry absolutely requires oxaloacetate, so the acceptor is not dispensable.
(Choice C) is incorrect: oxaloacetate is not turned into \(\text{CO}_2\) each turn, and the cycle does not depend on continuous cytosolic import to keep running; regeneration within the cycle, not replacement from outside, is what sustains flux under normal conditions.

As a Skill 2 (reasoning about scientific concepts) item, the student must recognize the catalytic, regenerated nature of the acceptor rather than treating it as consumed.', 'medium', '1D', 'Citric Acid Cycle', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'oxaloacetate consumed stoichiometrically, not catalytic' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'acetyl-CoA oxidized without an acceptor' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'oxaloacetate lost as CO2 and imported from cytosol' FROM q;

-- Q33 [D8 · Citric Acid Cycle: Reactions & Intermediates] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Citric Acid Cycle: Reactions & Intermediates', 'A researcher feeds cells acetyl-CoA in which both carbons of the acetyl group are isotopically labeled and follows a single turn of the citric acid cycle. Two \(\text{CO}_2\) molecules are released during that turn. Contrary to a common assumption, neither released \(\text{CO}_2\) carries the label in that first turn. What does this reveal about the origin of the carbons lost as \(\text{CO}_2\) in a given turn?', '[{"label": "A", "text": "The \\(\\text{CO}_2\\) carbons lost in the first turn come from the four-carbon acceptor (oxaloacetate), not from the acetyl group just added, so no label appears until a later turn"}, {"label": "B", "text": "The two \\(\\text{CO}_2\\) carbons are exactly the acetyl carbons just added, so the label should have appeared and the experiment must be somehow flawed or contaminated"}, {"label": "C", "text": "One released \\(\\text{CO}_2\\) is an acetyl carbon and the other is from the acceptor, so exactly half the label should appear in the first turn"}, {"label": "D", "text": "No carbons are truly lost; the two \\(\\text{CO}_2\\) molecules are reincorporated into oxaloacetate, so the label cannot be tracked at all"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Citric Acid Cycle.''

The answer is A because the carbons released as \(\text{CO}_2\) in a given turn derive from the four-carbon acceptor, not from the two-carbon acetyl unit added that turn. When the labeled acetyl carbons condense with oxaloacetate to form the six-carbon citrate, the two subsequent decarboxylations (isocitrate to \(\alpha\)-ketoglutarate, then \(\alpha\)-ketoglutarate to succinyl-CoA) remove carbons that trace back to the oxaloacetate skeleton. The acetyl-derived carbons are retained within the four-carbon products and are lost only in later turns. That is exactly why no label appears in the first-turn \(\text{CO}_2\): the experiment is behaving correctly rather than being flawed.

(Choice A) is correct: the \(\text{CO}_2\) carbons of a given turn come from the acceptor, and the freshly added acetyl carbons are retained and only released in subsequent turns, explaining the absence of label in the first-turn \(\text{CO}_2\).
(Choice B) is incorrect: this is the standard misconception that the acetyl carbons are immediately exhaled. The lack of label is real, not experimental error; the released carbons in the first turn are acceptor-derived.
(Choice C) is incorrect: the split is not one acetyl and one acceptor carbon; both first-turn \(\text{CO}_2\) carbons trace to the acceptor, so zero label (not half) appears in the first turn.
(Choice D) is incorrect: carbons are genuinely lost as \(\text{CO}_2\); they are not reincorporated into oxaloacetate within the turn, so labeling is trackable and the correct prediction is simply zero label in the first turn.

As a Skill 2 (reasoning about scientific concepts) item, the student must reason through carbon bookkeeping to see that the lost carbons are acceptor-derived, not the newly added acetyl carbons.', 'medium', '1D', 'Citric Acid Cycle', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'acetyl carbons immediately exhaled as CO2' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'half acetyl / half acceptor split of first-turn CO2' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'CO2 reincorporated, carbons never net lost' FROM q;

-- Q34 [D9 · Citric Acid Cycle: Reactions & Intermediates] hard skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Citric Acid Cycle: Reactions & Intermediates', 'In a rapidly growing cell, oxaloacetate and \(\alpha\)-ketoglutarate are continuously siphoned out of the cycle to build amino acids. Left unchecked, this withdrawal would slow the cycle. The cell counteracts it by carboxylating pyruvate to oxaloacetate. Which explanation best captures why the withdrawal slows flux and how the carboxylation reaction rescues it?', '[{"label": "A", "text": "Withdrawing oxaloacetate raises the available acceptor pool and speeds the cycle up, so the carboxylation reaction is needed to bring the flux back down"}, {"label": "B", "text": "Withdrawing oxaloacetate leaves too little acceptor for acetyl-CoA to condense with, slowing entry; carboxylating pyruvate to oxaloacetate (anaplerosis) refills the acceptor pool and restores flux"}, {"label": "C", "text": "Withdrawal has no net effect on flux because oxaloacetate is regenerated on every turn; the carboxylation reaction simply supplies extra \\(\\text{CO}_2\\) for the decarboxylation steps"}, {"label": "D", "text": "Withdrawing oxaloacetate slows the cycle, and the correct fix is to speed up the electron transport chain, which pulls the depleted intermediates forward without replacing any lost carbon"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Citric Acid Cycle.''

The answer is B because entry into the cycle requires oxaloacetate as the condensation partner for acetyl-CoA. Although oxaloacetate is normally regenerated each turn, biosynthetic withdrawal of intermediates drains the pool faster than it is replenished, leaving too little acceptor for acetyl-CoA to condense with, so flux falls. Anaplerosis restores the pool: carboxylating pyruvate to oxaloacetate adds carbon back into the cycle, replenishing the acceptor and allowing acetyl groups to keep entering. This is the classic replenishment that balances withdrawal for biosynthesis.

(Choice B) is correct: draining oxaloacetate starves the entry condensation, and carboxylating pyruvate to oxaloacetate (anaplerosis) refills the acceptor pool so flux recovers.
(Choice A) is incorrect: it reverses the effect of withdrawal. Removing oxaloacetate lowers, not raises, the acceptor pool, and the carboxylation reaction adds acceptor to speed the cycle up, not to slow it down.
(Choice C) is incorrect: regeneration each turn does not make the cycle immune to net withdrawal; siphoning intermediates for biosynthesis does deplete the pool, and the carboxylation replenishes carbon skeletons rather than merely supplying \(\text{CO}_2\).
(Choice D) is incorrect: speeding the electron transport chain cannot replace lost carbon skeletons. The bottleneck is the missing acceptor, which only carbon-adding anaplerosis, not faster electron transport, can restore.

As a Skill 2 (reasoning about scientific concepts) item, the student must reason about how intermediate depletion throttles entry and how carbon-replenishing anaplerosis rescues flux.', 'hard', '1D', 'Citric Acid Cycle', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'withdrawal raises acceptor / anaplerosis slows the cycle' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'regeneration makes withdrawal irrelevant; anaplerosis just supplies CO2' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'ETC speed-up substitutes for carbon replenishment' FROM q;

-- Q35 [E1 · Citric Acid Cycle: Energetics & Products] easy skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Citric Acid Cycle: Energetics & Products', 'A researcher tracks a single acetyl group as it enters the citric acid cycle and follows it through one complete turn. She records the redox and phosphorylation events: three separate dehydrogenation steps each hand a pair of electrons to \(\text{NAD}^+\); one dehydrogenation step is not energetic enough to reduce \(\text{NAD}^+\) and instead reduces an enzyme-bound flavin; and one step couples a thioester hydrolysis to a substrate-level phosphorylation. Two decarboxylations also occur. Assembling these events, what is the complete per-turn output of reduced carriers, high-energy nucleotide, and carbon released?', '[{"label": "A", "text": "2 NADH, 1 FADH2, 1 GTP, 3 CO2"}, {"label": "B", "text": "3 NADH, 2 FADH2, 1 GTP, 2 CO2"}, {"label": "C", "text": "3 NADH, 1 FADH2, 1 GTP, 2 CO2"}, {"label": "D", "text": "4 NADH, 1 FADH2, 0 GTP, 2 CO2"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Citric Acid Cycle.''

The answer is C because the described events map directly onto the per-turn tally. The three dehydrogenations that reduce \(\text{NAD}^+\) generate 3 NADH; the single dehydrogenation too weak to reduce \(\text{NAD}^+\) reduces a flavin to yield 1 \(\text{FADH}_2\) (the succinate-to-fumarate step at Complex II); the thioester-coupled substrate-level phosphorylation yields 1 GTP; and the two decarboxylations release 2 \(\text{CO}_2\). Assembled, one turn produces 3 NADH, 1 \(\text{FADH}_2\), 1 GTP, and 2 \(\text{CO}_2\).

(Choice C) is correct: three \(\text{NAD}^+\)-reducing dehydrogenations, one flavin-reducing dehydrogenation, one substrate-level phosphorylation, and two decarboxylations sum to exactly 3 NADH, 1 \(\text{FADH}_2\), 1 GTP, and 2 \(\text{CO}_2\).

(Choice A) is incorrect: it miscounts a \(\text{NAD}^+\)-reducing step as a decarboxylation, dropping to 2 NADH while inflating \(\text{CO}_2\) to 3. Only two carbons leave per turn, and all three \(\text{NAD}^+\)-reducing dehydrogenations described must be counted.

(Choice B) is incorrect: it double-counts flavin reduction. Only one step in the cycle is too weak to reduce \(\text{NAD}^+\) and instead uses a flavin, so only 1 \(\text{FADH}_2\) forms, not 2.

(Choice D) is incorrect: it converts the substrate-level phosphorylation into a fourth \(\text{NAD}^+\) reduction, giving 4 NADH and 0 GTP. The thioester-hydrolysis step described is a phosphorylation, not a dehydrogenation, so it yields GTP, not NADH.

As a Skill 2 (reasoning about scientific concepts) item, the student does not recite a memorized product list but instead maps each described chemical event onto its output and assembles the per-turn tally from those mechanistic cues.', 'easy', '1D', 'Citric Acid Cycle', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'process_step_confusion', 'swaps a dehydrogenation for a decarboxylation' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'double-counts flavin reduction' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'counts substrate-level phosphorylation as an NADH step' FROM q;

-- Q36 [E2 · Citric Acid Cycle: Energetics & Products] hard skill4 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Citric Acid Cycle: Energetics & Products', 'A metabolic-energetics worksheet asks a student to convert the per-turn output of the citric acid cycle into ATP equivalents using standard oxidative-phosphorylation conversion factors: each NADH is worth ~2.5 ATP, each FADH2 is worth ~1.5 ATP, and each GTP is worth 1 ATP. For one acetyl-CoA making a single pass through the cycle, what total ATP equivalent do these carriers and the GTP represent?', '[{"label": "A", "text": "8 ATP"}, {"label": "B", "text": "11 ATP"}, {"label": "C", "text": "9 ATP"}, {"label": "D", "text": "10 ATP"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Citric Acid Cycle.''

The answer is D because one turn of the cycle for a single acetyl-CoA yields 3 NADH, 1 \(\text{FADH}_2\), and 1 GTP, and applying the worksheet''s conversion factors gives \(3(2.5) + 1(1.5) + 1(1) = 7.5 + 1.5 + 1 = 10\) ATP equivalents. The two \(\text{CO}_2\) released carry no phosphorylation value, so they do not enter the sum.

(Choice D) is correct: \(3 \times 2.5 = 7.5\) from the three NADH, plus 1.5 from the one \(\text{FADH}_2\), plus 1 from the GTP, totals exactly 10 ATP equivalents.

(Choice A) is incorrect: 8 ATP results from valuing NADH at 2 and \(\text{FADH}_2\) at 1 (older whole-number conventions), giving \(3(2) + 1(1) + 1 = 8\). The prompt specifies the 2.5/1.5 factors, which must be used.

(Choice B) is incorrect: 11 ATP results from crediting \(\text{FADH}_2\) with the same 2.5 as NADH, giving \(3(2.5) + 1(2.5) + 1 = 11\); but \(\text{FADH}_2\) is only worth ~1.5 because it enters the chain at Complex II, downstream of Complex I, so fewer protons are pumped.

(Choice C) is incorrect: 9 ATP drops the GTP contribution, giving \(3(2.5) + 1(1.5) = 9\); the substrate-level GTP made at succinyl-CoA synthetase is a real product of the turn and must be included, bringing the total to 10, not 9.

At the Skill 4 (data-based reasoning) level, the student applies the given conversion factors to the per-turn carrier tally rather than recalling a headline ATP number.', 'hard', '1D', 'Citric Acid Cycle', 'biochemistry', 4, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'scale_unit_error', 'uses old whole-number 2/1 conversion factors' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'credits FADH2 with NADH''s 2.5-ATP value' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'omits the GTP from the sum' FROM q;

-- Q37 [E3 · Citric Acid Cycle: Energetics & Products] hard skill4 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Citric Acid Cycle: Energetics & Products', 'One molecule of glucose is fully committed to aerobic metabolism, and both pyruvate-derived acetyl-CoA molecules are oxidized. Considering ONLY the two turns of the citric acid cycle itself (excluding glycolysis and pyruvate dehydrogenase), and valuing each NADH at ~2.5 ATP, each FADH2 at ~1.5 ATP, and each GTP at 1 ATP, what is the total ATP equivalent produced by the cycle per glucose?', '[{"label": "A", "text": "20 ATP"}, {"label": "B", "text": "10 ATP"}, {"label": "C", "text": "25 ATP"}, {"label": "D", "text": "30 ATP"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Citric Acid Cycle.''

The answer is A because glucose yields two acetyl-CoA, so the cycle turns twice: the per-turn value of 10 ATP equivalents scales to \(2 \times 10 = 20\). Equivalently, two turns produce 6 NADH, 2 FADH2, and 2 GTP, giving \(6(2.5) + 2(1.5) + 2(1) = 15 + 3 + 2 = 20\) ATP.

(Choice A) is correct: doubling the per-turn tally and applying the conversion factors gives 20 ATP equivalents from the cycle alone per glucose.

(Choice B) is incorrect: 10 ATP is the yield for a single acetyl-CoA (one turn). Glucose supplies two acetyl-CoA, so the cycle runs twice and the value must be doubled.

(Choice C) is incorrect: 25 ATP adds the two NADH generated by pyruvate dehydrogenase, \(20 + 2(2.5) = 25\). Those carriers form before the acetyl-CoA enters the cycle, and the prompt restricts the tally to the cycle''s own two turns, so they must be excluded.

(Choice D) is incorrect: 30 ATP approximates the whole aerobic yield from glycolysis through oxidative phosphorylation, not the cycle-only contribution. The question isolates the citric acid cycle, which supplies 20 of those equivalents.

At the Skill 4 (data-based reasoning) level, the student scales the per-turn result by the two acetyl-CoA derived from glucose rather than recalling a total.', 'hard', '1D', 'Citric Acid Cycle', 'biochemistry', 4, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'scale_unit_error', 'reports per-turn value instead of doubling for glucose' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'adds the two pyruvate dehydrogenase NADH that form outside the cycle' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'confuses cycle-only yield with whole-pathway aerobic total' FROM q;

-- Q38 [E4 · Citric Acid Cycle: Energetics & Products] easy skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Citric Acid Cycle: Energetics & Products', 'A cell is treated with a poison that completely blocks the mitochondrial electron transport chain. Although molecular oxygen is not a direct substrate of any citric acid cycle enzyme, within minutes the cycle grinds to a halt. Which explanation best accounts for why blocking the electron transport chain shuts down a set of reactions that never directly touch oxygen?', '[{"label": "A", "text": "Oxygen normally binds citrate synthase directly, so removing electron flow starves the cycle of its committed first step."}, {"label": "B", "text": "Reduced electron carriers accumulate because the chain cannot reoxidize them, so \\(\\text{NAD}^+\\) and FAD are not regenerated for the cycle''s dehydrogenation steps."}, {"label": "C", "text": "The poison raises matrix ADP, which allosterically inhibits isocitrate dehydrogenase and stops the cycle."}, {"label": "D", "text": "Without electron flow the mitochondrial membrane depolarizes, allowing \\(\\text{CO}_2\\) to leak out and reverse the decarboxylation steps."}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Citric Acid Cycle.''

The answer is B because the cycle depends on the electron transport chain to reoxidize NADH and FADH2 back to \(\text{NAD}^+\) and FAD. Four of the cycle''s steps are oxidations that need an oxidized carrier as the electron acceptor: isocitrate dehydrogenase, \(\alpha\)-ketoglutarate dehydrogenase, and malate dehydrogenase each reduce \(\text{NAD}^+\), while succinate dehydrogenase reduces FAD. When the chain is blocked, these reduced carriers pile up and the oxidized forms disappear; without \(\text{NAD}^+\) and FAD as electron acceptors, the dehydrogenation steps cannot proceed, so the cycle stops even though no enzyme uses \(\text{O}_2\) directly. The dependence is indirect, through carrier regeneration.

(Choice B) is correct: it identifies the coupling — a blocked chain fails to regenerate oxidized carriers, and the dehydrogenases stall for lack of \(\text{NAD}^+\)/FAD.

(Choice A) is incorrect: no cycle enzyme, including citrate synthase, binds \(\text{O}_2\); citrate synthase condenses acetyl-CoA with oxaloacetate. This choice contradicts the stem''s own premise and invents a direct oxygen role that does not exist.

(Choice C) is incorrect: it reverses the regulatory logic. Rising ADP signals low energy charge and activates isocitrate dehydrogenase; it does not inhibit it. If anything, a blocked chain that raises ADP would speed the cycle, not stop it. The actual shutdown here is a redox-cofactor problem, not ADP-mediated inhibition.

(Choice D) is incorrect: the decarboxylations are effectively irreversible oxidative steps and are not reversed by \(\text{CO}_2\) leakage or membrane potential changes; the actual failure is depletion of oxidized electron carriers.

As a Skill 2 (reasoning about scientific concepts) item, the student reasons from the cycle''s coupling to the electron transport chain rather than from a memorized fact that the cycle is aerobic.', 'easy', '1D', 'Citric Acid Cycle', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'invents a direct oxygen substrate for a cycle enzyme' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'treats ADP as an inhibitor rather than activator of isocitrate dehydrogenase' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'claims oxidative decarboxylations are reversed by membrane depolarization' FROM q;

-- Q39 [E5 · Citric Acid Cycle: Energetics & Products] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Citric Acid Cycle: Energetics & Products', 'A textbook lists the citric acid cycle''s per-turn yield as "1 GTP," yet a summary table of cellular energy currency counts that same output as "1 ATP." A student worries the two sources disagree. Which reasoning best justifies treating the cycle''s GTP as energetically equivalent to one ATP?', '[{"label": "A", "text": "GTP is spontaneously hydrolyzed to GDP inside the matrix, releasing free phosphate that is captured by ATP synthase to make ATP."}, {"label": "B", "text": "GTP carries roughly 1.5 times the phosphoanhydride bond energy of ATP, so counting it as a single ATP conservatively understates the true yield."}, {"label": "C", "text": "Nucleoside-diphosphate kinase readily transfers the terminal phosphate between GTP and ADP, and the two nucleotides share essentially the same phosphoanhydride bond energy."}, {"label": "D", "text": "The succinyl-CoA synthetase step directly produces ATP in cardiac tissue, so the GTP label is simply a naming error with no energetic basis."}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Citric Acid Cycle.''

The answer is C because GTP and ATP have essentially equal phosphoanhydride bond energies, and nucleoside-diphosphate kinase interconverts them by transferring a terminal phosphate (GTP + ADP ⇌ GDP + ATP). Because that transfer is near-equilibrium and preserves the high-energy bond, one GTP is legitimately counted as one ATP without any energetic sleight of hand.

(Choice C) is correct: the near-equal bond energies plus the freely reversible kinase transfer make the GTP a one-to-one stand-in for ATP.

(Choice A) is incorrect: the equivalence does not require hydrolyzing GTP to free phosphate for ATP synthase. It is an enzyme-catalyzed phosphate transfer between intact nucleotides, not a hydrolysis-then-resynthesis pathway; this choice misroutes the mechanism.

(Choice B) is incorrect: GTP does not carry ~1.5 times ATP''s bond energy — the energies are essentially the same, which is exactly why the one-to-one count is valid rather than an underestimate.

(Choice D) is incorrect: while some tissues produce ATP directly at this step via an isoform, the GTP-to-ATP count is not merely a naming error; it rests on the genuine energetic equivalence and the interconverting kinase, which is the defensible justification.

As a Skill 2 (reasoning about scientific concepts) item, the student reasons about why the GTP-for-ATP substitution is energetically legitimate rather than accepting it as a stated convention.', 'medium', '1D', 'Citric Acid Cycle', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'process_step_confusion', 'routes equivalence through hydrolysis and ATP synthase' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'claims GTP has greater bond energy than ATP' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'dismisses equivalence as a mere naming error' FROM q;

-- Q40 [E6 · Citric Acid Cycle: Energetics & Products] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Citric Acid Cycle: Energetics & Products', 'A textbook models mitochondrial ATP output using a fixed "proton price": every electron pair funneled into the chain contributes protons to the intermembrane space in proportion to how many pumping complexes it drives, and ATP synthesis is directly proportional to those protons. In this model the pair from an NADH passes through all three pumping complexes and is credited with about 2.5 ATP. The cycle''s FADH2 hands its electron pair to the mobile carrier CoQ, from which the pair drives every remaining pumping complex on the way to O2. Using the same proportionality, roughly how many ATP should this FADH2 be credited with?', '[{"label": "A", "text": "About 0.8 ATP, because its electron pair drives one of the three pumping complexes that NADH''s pair drives."}, {"label": "B", "text": "About 2.5 ATP, because once the electrons reach CoQ they drive the same pumping complexes NADH''s electrons do."}, {"label": "C", "text": "About 1.25 ATP, because carrying half as many electrons as NADH halves the protons pumped at every complex."}, {"label": "D", "text": "About 1.5 ATP, because its electron pair drives two of the three pumping complexes that NADH''s pair drives."}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Citric Acid Cycle.''

The answer is D because, under the stated proportionality, the ATP credit tracks the fraction of pumping complexes an electron pair drives. NADH''s pair passes all three proton-pumping complexes (I, III, and IV) and earns \(\sim\)2.5 ATP. The cycle''s FADH2 (in succinate dehydrogenase, Complex II, which does not pump) delivers its pair to CoQ; from CoQ the pair still drives Complex III and Complex IV \(-\) two of the three pumping complexes. Scaling the credit by that fraction gives \(2.5 \times \tfrac{2}{3} \approx 1.7\), which rounds to the \(\sim\)1.5 ATP offered in choice A \(-\) the only value close to the model''s result. Two of three pumping sites, not a change in how many electrons are carried, sets the lower yield.

(Choice D) is correct: the FADH2 pair reaches CoQ and then drives Complexes III and IV \(-\) two of the three pumping complexes NADH''s pair drives \(-\) so the proportional credit is about \(\tfrac{2}{3}\) of 2.5, i.e. \(\sim\)1.5 ATP.

(Choice A) is incorrect: it counts only one pumping complex for the FADH2 pair. Entering at CoQ skips only Complex I; the pair still drives both Complex III and Complex IV, so two sites contribute, not one, and \(\tfrac{1}{3}\) of 2.5 (\(\sim\)0.8) undercounts.

(Choice B) is incorrect: it ignores the skipped site. Because the FADH2 pair enters at CoQ rather than at Complex I, it drives one fewer pumping complex than NADH''s pair and therefore cannot earn the full \(\sim\)2.5 ATP.

(Choice C) is incorrect: it assumes FADH2 delivers half as many electrons as NADH. Both carriers deliver a pair of electrons; the difference is the entry point (and thus the number of pumping complexes driven), not the size of the electron packet, so halving the yield to 1.25 does not apply.

As a Skill 2 (reasoning about scientific concepts) item, the student derives the \(\sim\)1.5 ATP figure by scaling the proton-proportional yield to the two of three pumping complexes the FADH2 pair drives, rather than recalling a fixed number.', 'medium', '1D', 'Citric Acid Cycle', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'process_step_confusion', 'counts only one pumping complex after CoQ (drops Complex III or IV)' FROM q
  UNION ALL
  SELECT id, 'B', 'partial_truth', 'assumes CoQ entry gives the full NADH yield, ignoring the skipped pumping site' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'treats FADH2 as carrying half the electrons of NADH, halving the pumping' FROM q;

-- Q41 [E7 · Citric Acid Cycle: Energetics & Products] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Citric Acid Cycle: Energetics & Products', 'The citric acid cycle is amphibolic: besides oxidizing acetyl groups, it exports intermediates for biosynthesis. In a differentiating erythroid precursor building large amounts of hemoglobin, one committed step of heme synthesis condenses glycine with a four-carbon activated succinyl compound to form \(\delta\)-aminolevulinate. Which cycle intermediate must the mitochondrion divert to supply that condensation, and from which cycle reaction is it drawn?', '[{"label": "A", "text": "Succinyl-CoA, generated when \\(\\alpha\\)-ketoglutarate is oxidatively decarboxylated by \\(\\alpha\\)-ketoglutarate dehydrogenase."}, {"label": "B", "text": "Succinate, released when succinyl-CoA synthetase cleaves the thioester to make GTP."}, {"label": "C", "text": "Oxaloacetate, regenerated when malate is oxidized by malate dehydrogenase."}, {"label": "D", "text": "Citrate, formed when acetyl-CoA condenses with oxaloacetate at citrate synthase."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Citric Acid Cycle.''

The answer is A because the four-carbon activated succinyl compound that condenses with glycine to begin heme synthesis is succinyl-CoA, and within the cycle succinyl-CoA is produced when \(\alpha\)-ketoglutarate dehydrogenase oxidatively decarboxylates \(\alpha\)-ketoglutarate (the second CO\(_2\)- and second NADH-releasing step). The stem specifies an activated (thioester) four-carbon unit, which fingerprints succinyl-CoA rather than free succinate; diverting it is a cataplerotic export that must be balanced by anaplerosis to sustain the cycle.

(Choice A) is correct: succinyl-CoA is the activated four-carbon acyl-CoA that condenses with glycine to form \(\delta\)-aminolevulinate, and it arises from the \(\alpha\)-ketoglutarate dehydrogenase reaction.

(Choice B) is incorrect: succinate is the product after succinyl-CoA synthetase has already cleaved the high-energy thioester to capture a GTP; it is not activated and cannot condense with glycine, so it is one step too far along the cycle.

(Choice C) is incorrect: oxaloacetate is also a four-carbon intermediate, but it is the acceptor for acetyl-CoA at citrate synthase rather than an activated acyl donor for heme; its amphibolic export feeds aspartate synthesis by transamination, a different pathway.

(Choice D) is incorrect: citrate is the six-carbon entry product exported for cytosolic fatty-acid synthesis, not a four-carbon activated unit, so it cannot supply the glycine-condensation step of the heme pathway.

As a Skill 2 (reasoning about scientific concepts) item, the student reasons from the described condensation chemistry and the cycle''s anabolic role to identify both the exported intermediate and the reaction that generates it, rather than restating a memorized definition.', 'medium', '1D', 'Citric Acid Cycle', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'process_step_confusion', 'picks the deactivated product one step downstream (succinate after thioester cleavage)' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'names oxaloacetate, a real four-carbon amphibolic export but for amino acids not heme' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'names citrate, the export for fatty-acid synthesis rather than heme' FROM q;

-- Q42 [E8 · Citric Acid Cycle: Energetics & Products] hard skill4 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Citric Acid Cycle: Energetics & Products', 'A researcher feeds a cell one molecule of glucose that has been uniformly labeled with the isotope ^{14}C at every carbon. The glucose is completely catabolized to two pyruvate, each pyruvate is oxidatively decarboxylated by the pyruvate dehydrogenase complex, and both resulting acetyl units are fully oxidized by the citric acid cycle. If the researcher traps every molecule of ^{14}CO2 released from the moment pyruvate is formed through the completion of the cycle turns, how many labeled CO2 molecules are collected per glucose, and at which decarboxylation steps are they lost?', '[{"label": "A", "text": "4 CO2: only the two cycle turns contribute (isocitrate dehydrogenase and α-ketoglutarate dehydrogenase, once each per turn); pyruvate dehydrogenase does not release CO2"}, {"label": "B", "text": "6 CO2: 2 from the two pyruvate dehydrogenase reactions plus 4 from the two cycle turns (isocitrate dehydrogenase and α-ketoglutarate dehydrogenase, once each per turn)"}, {"label": "C", "text": "8 CO2: the two pyruvate dehydrogenase reactions plus three decarboxylations per cycle turn (isocitrate dehydrogenase, α-ketoglutarate dehydrogenase, and malate dehydrogenase)"}, {"label": "D", "text": "2 CO2: one from each pyruvate dehydrogenase reaction; the citric acid cycle regenerates oxaloacetate and therefore releases no net CO2"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Citric Acid Cycle.''

The answer is B because the labeled carbons are lost only at oxidative decarboxylation steps, and there are three such steps in this pathway. One glucose yields two pyruvate, and each pyruvate is decarboxylated once by the pyruvate dehydrogenase complex (pyruvate(3C) \(\rightarrow\) acetyl-CoA(2C) + CO2), giving \(2 \times 1 = 2\) CO2. Each of the two acetyl units then drives one turn of the cycle, and each turn loses 2 CO2 at its two oxidative decarboxylations: isocitrate \(\rightarrow\) \(\alpha\)-ketoglutarate (isocitrate dehydrogenase) and \(\alpha\)-ketoglutarate \(\rightarrow\) succinyl-CoA (\(\alpha\)-ketoglutarate dehydrogenase). Two turns therefore lose \(2 \times 2 = 4\) CO2. Summing, \(2 + 4 = 6\) labeled CO2 per glucose.

(Choice B) is correct: tracing WHERE carbon is lost identifies exactly three decarboxylating steps — one at pyruvate dehydrogenase (occurring twice, once per pyruvate) and two per cycle turn (occurring across two turns) — for \(2 + 4 = 6\) CO2.

(Choice A) is incorrect: it omits the two pyruvate dehydrogenase decarboxylations, which occur before the cycle and each release a CO2. The prompt specifies trapping begins the moment pyruvate is formed, so those 2 CO2 must be counted; the total is 6, not 4.

(Choice C) is incorrect: it wrongly assigns a decarboxylation to malate dehydrogenase. That step (malate \(\rightarrow\) oxaloacetate) is an NAD\(^+\)-linked oxidation that produces the third NADH but releases no CO2. Only isocitrate dehydrogenase and \(\alpha\)-ketoglutarate dehydrogenase decarboxylate within the cycle, so each turn loses 2, not 3, CO2.

(Choice D) is incorrect: although the cycle does regenerate oxaloacetate, it still releases 2 CO2 per turn because the two carbons lost are not the same two that entered as acetyl-CoA on that turn — the cycle is not carbon-neutral per turn. Two turns thus release 4 CO2, which added to the 2 from pyruvate dehydrogenase gives 6.

At the Skill 4 (data-based reasoning) level, the student localizes carbon loss to specific decarboxylating enzymes and scales those steps across the pathway rather than recalling a memorized total.', 'hard', '1D', 'Citric Acid Cycle', 'biochemistry', 4, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'partial_truth', 'counts only the in-cycle decarboxylations, omitting the two PDH-released CO2' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'mistakes malate dehydrogenase for a decarboxylation, adding a third CO2 per turn' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'treats oxaloacetate regeneration as making the cycle carbon-neutral, so it releases no CO2' FROM q;

-- Q43 [F1 · Citric Acid Cycle: Regulation] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Citric Acid Cycle: Regulation', 'In an isolated mitochondrion, matrix ADP and NAD+ concentrations climb sharply while ATP and NADH concentrations fall. Isocitrate dehydrogenase is the rate-limiting enzyme of the citric acid cycle. Under these conditions, what happens to flux through the isocitrate dehydrogenase step?', '[{"label": "A", "text": "Flux decreases, because rising ADP and NAD+ both allosterically inhibit the enzyme"}, {"label": "B", "text": "Flux is unchanged, because ADP activation and NAD+ activation exactly cancel"}, {"label": "C", "text": "Flux increases, because rising ADP and NAD+ both allosterically activate the enzyme"}, {"label": "D", "text": "Flux increases, but only because falling ATP relieves the enzyme''s requirement for its substrate isocitrate"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Citric Acid Cycle.''

The answer is C because the described state is energy-depleted: high ADP and high NAD+ with low ATP and low NADH. Isocitrate dehydrogenase, the rate-limiting control point of the cycle, is allosterically activated by ADP, \(\text{Ca}^{2+}\), and \(\text{NAD}^+\) and inhibited by ATP and NADH. When both an activator (ADP) and the oxidized cofactor/activator (\(\text{NAD}^+\)) rise while both inhibitors (ATP, NADH) fall, every signal pushes the same direction, so flux through this step increases to regenerate ATP.

(Choice C) is correct: rising ADP and \(\text{NAD}^+\) are both activating signals for isocitrate dehydrogenase, and the simultaneous drop in the inhibitors ATP and NADH removes opposition, so flux rises.
(Choice A) is incorrect: it reverses the sign of the allosteric effects, treating ADP and \(\text{NAD}^+\) as inhibitors; in fact they are the activators, and ATP and NADH are the inhibitors.
(Choice B) is incorrect: ADP and \(\text{NAD}^+\) act in the same direction (both activate), so their effects add rather than cancel.
(Choice D) is incorrect: isocitrate dehydrogenase does not need ATP to bind isocitrate, and ATP is an allosteric inhibitor, not a factor gating substrate access; the reasoning invents a mechanism that does not exist.

As a Skill 2 (reasoning about scientific concepts) item, the student must map an energy-charge/redox state onto the specific allosteric responses of the rate-limiting enzyme and predict the direction of flux at that step.', 'medium', '1D', 'Citric Acid Cycle', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'swaps activators and inhibitors of isocitrate DH' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'believes opposing signals cancel when they actually reinforce' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'invents an ATP-gated substrate-binding mechanism' FROM q;

-- Q44 [F2 · Citric Acid Cycle: Regulation] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Citric Acid Cycle: Regulation', 'A cell is respiring steadily when succinyl-CoA begins to accumulate in the matrix because a downstream reaction has slowed. Citrate synthase catalyzes the committed entry step, condensing acetyl-CoA with oxaloacetate to form citrate. How does the buildup of succinyl-CoA affect entry of acetyl-CoA into the cycle at citrate synthase?', '[{"label": "A", "text": "It activates citrate synthase, pulling more acetyl-CoA in to clear the backlog"}, {"label": "B", "text": "It has no effect on citrate synthase, since succinyl-CoA acts only three steps later"}, {"label": "C", "text": "It inhibits citrate synthase by chemically consuming the oxaloacetate needed for condensation"}, {"label": "D", "text": "It inhibits citrate synthase, feeding a downstream signal back to throttle entry"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Citric Acid Cycle.''

The answer is D because citrate synthase is inhibited by ATP, NADH, citrate, and succinyl-CoA. Succinyl-CoA is generated several steps downstream of entry, so its accumulation is a signal that the cycle is already backed up; allosteric inhibition of citrate synthase by succinyl-CoA is therefore classic downstream feedback that slows further entry of acetyl-CoA until the backlog clears.

(Choice D) is correct: succinyl-CoA is a direct allosteric inhibitor of citrate synthase, so its buildup feeds back to reduce acetyl-CoA entry, matching intake to the cycle''s ability to process it.
(Choice A) is incorrect: it reverses the effect; a rising downstream intermediate signaling congestion should slow entry, not accelerate it, and succinyl-CoA is an inhibitor rather than an activator here.
(Choice B) is incorrect: feedback regulation does not require physical adjacency; succinyl-CoA acts allosterically on citrate synthase even though it is produced later in the cycle.
(Choice C) is incorrect: succinyl-CoA does not consume oxaloacetate; oxaloacetate is regenerated downstream and is not a chemical target of succinyl-CoA. The buildup acts by allosteric inhibition of the enzyme, not by depletion of the co-substrate, so this choice keeps the correct direction but corrupts the mechanism.

As a Skill 2 (reasoning about scientific concepts) item, the student must recognize a downstream intermediate as a feedback signal and reason about how it throttles the committed entry step rather than merely recalling an inhibitor list.', 'medium', '1D', 'Citric Acid Cycle', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'treats a downstream inhibitor as a feed-forward activator' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'assumes regulation requires adjacency in the pathway' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'gets the inhibition direction right but confuses allosteric inhibition with substrate consumption' FROM q;

-- Q45 [F3 · Citric Acid Cycle: Regulation] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Citric Acid Cycle: Regulation', 'The alpha-ketoglutarate dehydrogenase complex converts alpha-ketoglutarate to succinyl-CoA, releasing CO2 and reducing NAD+. In a mitochondrion where succinyl-CoA and NADH have both accumulated to high levels, how is the activity of this complex most directly affected, and by what regulatory logic?', '[{"label": "A", "text": "It is inhibited, because succinyl-CoA and NADH are its own reaction products acting as product inhibitors"}, {"label": "B", "text": "It is stimulated, because high product levels increase the local availability of its substrate alpha-ketoglutarate"}, {"label": "C", "text": "It is inhibited, because succinyl-CoA and NADH lower the matrix pH and denature the complex"}, {"label": "D", "text": "It is inhibited, but only NADH matters; succinyl-CoA is a substrate that would instead speed the enzyme up"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Citric Acid Cycle.''

The answer is A because the alpha-ketoglutarate dehydrogenase complex produces succinyl-CoA and NADH; both are product inhibitors of the complex (it is also inhibited by ATP and stimulated by ADP and \(\text{Ca}^{2+}\)). When the products it makes pile up, product inhibition slows the enzyme, preventing it from generating more of what the cell already has in excess.

(Choice A) is correct: succinyl-CoA and NADH are the direct products of the reaction, and their accumulation causes product inhibition, damping flux through this step.
(Choice B) is incorrect: high product does not raise substrate availability; if anything, product accumulation signals that substrate is being consumed faster than it can be cleared, and the enzyme is slowed, not sped up.
(Choice C) is incorrect: the inhibition is specific allosteric product inhibition, not a nonspecific pH-driven denaturation; NADH and succinyl-CoA at physiological levels do not denature the complex.
(Choice D) is incorrect: succinyl-CoA is a product, not a substrate, of alpha-ketoglutarate dehydrogenase, so it inhibits rather than accelerates the complex.

As a Skill 2 (reasoning about scientific concepts) item, the student must apply product-inhibition logic, identifying the accumulated species as this enzyme''s own products and predicting the resulting decrease in activity.', 'medium', '1D', 'Citric Acid Cycle', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'treats product buildup as raising substrate and activity' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'attributes inhibition to nonspecific pH denaturation' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'misclassifies succinyl-CoA product as a substrate' FROM q;

-- Q46 [F4 · Citric Acid Cycle: Regulation] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Citric Acid Cycle: Regulation', 'A skeletal muscle cell transitions from quiet rest to vigorous exercise. During intense contraction, \(\text{ATP}\) is rapidly hydrolyzed to \(\text{ADP}\) and \(\text{NADH}\) is rapidly reoxidized to \(\text{NAD}^+\) by the electron transport chain. Compared with rest, how does the overall rate of the citric acid cycle change during vigorous exercise, and why?', '[{"label": "A", "text": "It slows down, because using up \\(\\text{ATP}\\) leaves too little energy to drive the cycle''s condensation and oxidation steps"}, {"label": "B", "text": "It speeds up, because the rising \\(\\text{ADP}\\) and \\(\\text{NAD}^+\\) activate the regulated dehydrogenases while the falling \\(\\text{ATP}\\) and \\(\\text{NADH}\\) relieve inhibition"}, {"label": "C", "text": "It stays essentially constant, because the cycle runs at a fixed rate set only by how much acetyl-CoA is present"}, {"label": "D", "text": "It speeds up, because rising \\(\\text{ATP}\\) and \\(\\text{NADH}\\) from contraction allosterically activate isocitrate dehydrogenase"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Citric Acid Cycle.''

The answer is B because vigorous exercise is an energy-depleted state: \(\text{ATP}\) is consumed (so \(\text{ADP}\) rises) and \(\text{NADH}\) is reoxidized by the electron transport chain (so \(\text{NAD}^+\) rises). High \(\text{ADP}\) and \(\text{NAD}^+\) allosterically activate isocitrate dehydrogenase and \(\alpha\)-ketoglutarate dehydrogenase, while the falling \(\text{ATP}\) and \(\text{NADH}\) remove their inhibition (\(\text{Ca}^{2+}\) released during contraction reinforces this activation). The net result is that the cycle accelerates to supply the reduced cofactors that feed \(\text{ATP}\) production, matching output to demand.

(Choice B) is correct: the exercise state raises \(\text{ADP}\) and \(\text{NAD}^+\) (activators) and lowers \(\text{ATP}\) and \(\text{NADH}\) (inhibitors), so the regulated dehydrogenases run faster and the cycle speeds up.
(Choice A) is incorrect: the cycle is not "powered by" \(\text{ATP}\) that gets depleted; rather, \(\text{ATP}\) is an allosteric inhibitor, so its consumption (rising \(\text{ADP}\)) accelerates the cycle rather than starving it. The condensation step is driven by the acetyl-CoA thioester and the oxidation steps by \(\text{NAD}^+\)/\(\text{FAD}\), not by \(\text{ATP}\).
(Choice C) is incorrect: the cycle rate is not fixed; it is tightly regulated by energy charge and redox state at three control enzymes, so it varies strongly between rest and exercise.
(Choice D) is incorrect: it names the correct outcome for the wrong reason, claiming \(\text{ATP}\) and \(\text{NADH}\) rise and activate the enzyme; in fact exercise lowers \(\text{ATP}\) and \(\text{NADH}\), and those species are inhibitors, not activators, of isocitrate dehydrogenase.

As a Skill 2 (reasoning about scientific concepts) item, the student must translate a physiological state into its underlying nucleotide and redox ratios and predict the cycle''s overall response.', 'medium', '1D', 'Citric Acid Cycle', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'treats ATP as the fuel that powers the cycle' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'believes the cycle runs at a fixed unregulated rate' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'right direction, wrong signals (ATP/NADH as activators)' FROM q;

-- Q47 [F5 · Citric Acid Cycle: Regulation] hard skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Citric Acid Cycle: Regulation', 'When a muscle fiber is stimulated to contract, Ca2+ is released and matrix Ca2+ concentration rises, and this Ca2+ directly activates isocitrate dehydrogenase and the alpha-ketoglutarate dehydrogenase complex (as well as pyruvate dehydrogenase). Why is matrix Ca2+ a particularly appropriate signal for up-regulating the citric acid cycle at exactly these moments?', '[{"label": "A", "text": "Ca2+ is consumed stoichiometrically as a substrate in each turn of the cycle, so a larger supply of the ion directly forces more cycle turns"}, {"label": "B", "text": "Ca2+ binds and sequesters ATP inside the matrix, and it is this drop in ATP, rather than any direct enzyme binding, that accelerates the cycle"}, {"label": "C", "text": "The Ca2+ that triggers contraction, an ATP-spending event, also raises matrix Ca2+, so ATP-generating flux rises just as ATP demand rises"}, {"label": "D", "text": "A rise in Ca2+ signals that the muscle has returned to rest, so the cycle is up-regulated to rebuild depleted ATP stores before the next contraction"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Citric Acid Cycle.''

The answer is C because \(\text{Ca}^{2+}\) is the trigger for muscle contraction, and contraction is what spends ATP. By using the very same messenger to activate isocitrate dehydrogenase, the \(\alpha\)-ketoglutarate dehydrogenase complex, and pyruvate dehydrogenase, the cell ties up-regulation of ATP-producing flux to the moment ATP-consuming work begins. \(\text{Ca}^{2+}\) is thus a demand signal: it reports "work is happening now," so ATP supply is raised in step with demand.

(Choice C) is correct: because contraction both raises matrix \(\text{Ca}^{2+}\) and consumes ATP, \(\text{Ca}^{2+}\) activation of the cycle''s dehydrogenases couples supply to demand at the right instant.
(Choice A) is incorrect: \(\text{Ca}^{2+}\) is a regulatory (allosteric) activator, not a stoichiometric substrate; it is not consumed in the cycle''s reactions and no carbon or cofactor step uses it up.
(Choice B) is incorrect: \(\text{Ca}^{2+}\) activates the dehydrogenases directly by binding them, not by sequestering ATP; the mechanism described is fabricated.
(Choice D) is incorrect: it reverses the physiology; \(\text{Ca}^{2+}\) release accompanies contraction (active work), not rest, so it signals high demand rather than a resting rebuild.

As a Skill 2 (reasoning about scientific concepts) item, the student must reason about why a contraction-linked messenger is a valid proxy for ATP demand and how it aligns supply with need.', 'hard', '1D', 'Citric Acid Cycle', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'treats an allosteric activator as a consumed substrate' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'invents Ca2+/ATP sequestration as the mechanism' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'links Ca2+ rise to rest instead of contraction' FROM q;

-- Q48 [F6 · Citric Acid Cycle: Regulation] hard skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Citric Acid Cycle: Regulation', 'A student claims that because none of the eight enzymes of the citric acid cycle uses O2 as a chemical reactant, an isolated matrix preparation supplied with acetyl-CoA, oxaloacetate, ADP, and the cycle''s cofactors should run at a normal rate in a nitrogen atmosphere with no O2 present. In fact, after only a few turns the cycle grinds nearly to a halt. Which statement best explains why the cycle stops despite O2 never being a direct substrate of any of its enzymes?', '[{"label": "A", "text": "Isocitrate dehydrogenase and alpha-ketoglutarate dehydrogenase incorporate an oxygen atom from O2 into the CO2 they release, so their oxidative decarboxylations cannot proceed once O2 is removed from the preparation"}, {"label": "B", "text": "Succinate dehydrogenase, which is embedded in the inner membrane, binds O2 directly at its FAD site, so removing O2 blocks this single step while the other seven enzymes continue turning normally"}, {"label": "C", "text": "Without O2 the matrix cannot make the GTP produced at the succinyl-CoA synthetase step, and the loss of that substrate-level phosphorylation is what thermodynamically stalls the remaining reactions of the cycle"}, {"label": "D", "text": "The cofactors NAD+ and FAD are consumed as the dehydrogenase steps run, and without O2 as the electron-transport chain''s terminal acceptor there is no route to reoxidize the resulting NADH and FADH2, so the oxidized cofactors are never regenerated"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Citric Acid Cycle.''

The answer is D because the cycle''s oxidative steps do not consume O2 as a chemical reactant, but they do consume oxidized cofactor: three dehydrogenase steps reduce NAD+ to NADH and succinate dehydrogenase reduces FAD to FADH2. Each turn the pool of NAD+ and FAD is small and finite, so it must be continuously regenerated by handing electrons to the electron transport chain, which ultimately deposits them on O2 at Complex IV. Remove O2 and the chain has no terminal acceptor; the reduced carriers cannot be reoxidized, NAD+ and FAD are not regenerated, and the NAD+/FAD-dependent steps stall for lack of oxidized cofactor. This is the indirect O2 dependence: O2 is never a substrate of a cycle enzyme, yet the cycle cannot run without it.

(Choice D) is correct: the cycle''s dehydrogenases need NAD+ and FAD in the oxidized form, and only the O2-terminated chain can restore them; without O2 the cofactors stay reduced and the cycle halts, even though no cycle enzyme ever binds O2.
(Choice A) is incorrect: the oxygen atoms in the \(\text{CO}_2\) released by isocitrate dehydrogenase and alpha-ketoglutarate dehydrogenase come from the substrate''s carboxyl/carbonyl groups and water, not from molecular O2; these are oxidative decarboxylations in the redox sense (they reduce NAD+), not oxygenase reactions that insert atoms from O2.
(Choice B) is incorrect: succinate dehydrogenase (Complex II) passes its electrons through FAD to iron-sulfur centers and then to coenzyme Q, not to O2; it does not bind O2 at all, and no cycle enzyme does.
(Choice C) is incorrect: the GTP-forming succinyl-CoA synthetase step is a substrate-level phosphorylation that requires no O2 and would proceed for the turns that run; the cycle stops because oxidized NAD+/FAD cannot be regenerated, not because GTP synthesis fails.

At the Skill 2 (reasoning about scientific concepts) level, the student must distinguish a direct chemical substrate from an indirect requirement, reasoning that the cycle''s dependence on O2 is mediated entirely through the need to reoxidize its NAD+/FAD cofactors via the electron transport chain.', 'hard', '1D', 'Citric Acid Cycle', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'confuses oxidative decarboxylation with an oxygenase reaction that inserts O2-derived atoms into CO2' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'thinks succinate dehydrogenase binds O2 directly because it is membrane-bound and O2-adjacent' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'attributes the halt to loss of substrate-level GTP synthesis rather than to failed cofactor reoxidation' FROM q;

-- Q49 [F7 · Citric Acid Cycle: Regulation] hard skill4 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Citric Acid Cycle: Regulation', 'Isolated mitochondria from cardiac muscle are perfused at a fixed, saturating supply of acetyl-CoA and NAD\(^+\), with \([\text{ATP}]/[\text{ADP}]\) held constant. Matrix free \(\text{Ca}^{2+}\) is stepped up while citric acid cycle flux (measured as \(\text{CO}_2\) release, arbitrary units) is recorded:

| Matrix free \(\text{Ca}^{2+}\) (nM) | Cycle flux (a.u.) |
|---|---|
| 50 | 12 |
| 200 | 31 |
| 600 | 58 |
| 1200 | 61 |

Which interpretation best explains the pattern in the table?

\(\text{Ca}^{2+}\) rises when contractile work (and thus ATP demand) increases. Note that flux climbs steeply from 50 to 600 nM and then nearly plateaus.', '[{"label": "A", "text": "\\(\\text{Ca}^{2+}\\) allosterically activates isocitrate dehydrogenase and the \\(\\alpha\\)-ketoglutarate dehydrogenase complex, so rising \\(\\text{Ca}^{2+}\\) accelerates flux until those enzymes approach saturation"}, {"label": "B", "text": "\\(\\text{Ca}^{2+}\\) is a substrate consumed by the dehydrogenases, so flux rises only while \\(\\text{Ca}^{2+}\\) is being used up and then stops climbing once it runs out"}, {"label": "C", "text": "\\(\\text{Ca}^{2+}\\) inhibits citrate synthase, and the plateau reflects that inhibition fully overriding the earlier rise in cycle flux"}, {"label": "D", "text": "\\(\\text{Ca}^{2+}\\) speeds flux only by chelating the inhibitor ATP, so the plateau appears once all available ATP has been sequestered away"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Citric Acid Cycle.''

The answer is A because matrix \(\text{Ca}^{2+}\) is an allosteric activator of two of the cycle''s regulated dehydrogenases, isocitrate dehydrogenase and the \(\alpha\)-ketoglutarate dehydrogenase complex. As \(\text{Ca}^{2+}\) climbs from 50 to 600 nM, a larger fraction of these enzymes is in their active, \(\text{Ca}^{2+}\)-bound conformation, so flux rises steeply (12 to 58 a.u.). Above 600 nM the enzymes are nearly fully activated, so further \(\text{Ca}^{2+}\) adds little and flux plateaus (58 to 61 a.u.). Because both Ca2+-activated steps are oxidative decarboxylations, CO2 release is a valid readout of this activation. This is the mechanism that couples contractile demand to energy supply: work raises \(\text{Ca}^{2+}\), and \(\text{Ca}^{2+}\) speeds the cycle. All of this is consistent with the saturating substrate and fixed \([\text{ATP}]/[\text{ADP}]\) stated, so \(\text{Ca}^{2+}\) is the only variable driving the change.

(Choice A) is correct: it identifies \(\text{Ca}^{2+}\) as an allosteric activator of isocitrate dehydrogenase and the \(\alpha\)-ketoglutarate dehydrogenase complex and correctly attributes the plateau to those enzymes approaching saturation of activation.
(Choice B) is incorrect: \(\text{Ca}^{2+}\) is a regulatory effector, not a substrate that is oxidized or consumed by the dehydrogenases; the perfused \(\text{Ca}^{2+}\) is buffered and clamped at each level, and the plateau reflects enzyme saturation, not \(\text{Ca}^{2+}\) being "used up."
(Choice C) is incorrect: \(\text{Ca}^{2+}\) activates, rather than inhibits, the regulated dehydrogenases, so it does not slow the cycle; moreover flux increases with \(\text{Ca}^{2+}\), the opposite of what net inhibition of citrate synthase would produce.
(Choice D) is incorrect: \(\text{Ca}^{2+}\) does not act by chelating ATP; it binds and activates the dehydrogenases directly, and \([\text{ATP}]/[\text{ADP}]\) is explicitly held constant, so no ATP sequestration is occurring.

At the Skill 4 (data-based reasoning) level, the student must read a flux-versus-\(\text{Ca}^{2+}\) dose-response curve, recognize the rise-then-plateau shape as saturable enzyme activation, and map it onto the specific \(\text{Ca}^{2+}\)-activated regulatory steps of the cycle.', 'hard', '1D', 'Citric Acid Cycle', 'biochemistry', 4, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'treats Ca2+ regulator as a consumed substrate' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'casts Ca2+ as an inhibitor rather than activator' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'invents ATP chelation as the mechanism of Ca2+ action' FROM q;

-- Q50 [F8 · Citric Acid Cycle: Regulation] hard skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Citric Acid Cycle: Regulation', 'The citric acid cycle''s three primary regulatory control points are the reactions catalyzed by citrate synthase, isocitrate dehydrogenase, and the alpha-ketoglutarate dehydrogenase complex — all strongly exergonic, effectively irreversible steps. Steps such as the aconitase and fumarase reactions operate near equilibrium and are not major control points. Why does placing regulation at the irreversible steps give the cell the most effective control over cycle flux?', '[{"label": "A", "text": "Irreversible steps release no free energy, so regulating them costs the cell nothing in ATP"}, {"label": "B", "text": "An irreversible step runs far from equilibrium, so changing its enzyme''s activity directly changes net flux without being offset by the reverse reaction"}, {"label": "C", "text": "Near-equilibrium steps cannot be catalyzed by enzymes, so only the irreversible steps have enzymes available to regulate"}, {"label": "D", "text": "Regulating a near-equilibrium step would be more powerful, but those enzymes simply happen to lack allosteric sites in this pathway"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Citric Acid Cycle.''

The answer is B because a reaction with a large negative \(\Delta G\) runs far from equilibrium and essentially in one direction; its net rate is set by the amount and activity of its enzyme. Modulating that enzyme therefore changes net flux directly and cannot be blunted by an appreciable reverse reaction. A near-equilibrium step (small \(\Delta G\), like aconitase or fumarase) already runs close to balance, so nudging its enzyme mostly shifts a small forward/back difference and does little to set overall throughput. Placing citrate synthase, isocitrate dehydrogenase, and alpha-ketoglutarate dehydrogenase at the committed, irreversible points gives leverage over the whole cycle.

(Choice B) is correct: control at a far-from-equilibrium, irreversible step yields large, uncontested changes in net flux, which is exactly what effective regulation requires.
(Choice A) is incorrect: irreversible steps are irreversible precisely because they release a large amount of free energy; the premise that they release none is backwards.
(Choice C) is incorrect: near-equilibrium steps are fully enzyme-catalyzed (aconitase, fumarase); their unsuitability for control is about being close to equilibrium, not about lacking enzymes.
(Choice D) is incorrect: near-equilibrium steps are inherently poor control points because a reverse reaction can offset any change; the reason is thermodynamic, not a coincidental absence of allosteric sites.

At the Skill 2 (reasoning about scientific concepts) level, the student must reason from reaction reversibility and distance from equilibrium to why regulatory enzymes sit at the cycle''s committed, irreversible steps.', 'hard', '1D', 'Citric Acid Cycle', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'claims irreversible steps release no free energy' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'thinks near-equilibrium steps lack enzymes' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'blames missing allosteric sites rather than thermodynamics' FROM q;

-- Q51 [G1 · Electron Transport Chain: Complexes & Carriers] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Electron Transport Chain: Complexes & Carriers', 'A researcher describes a membrane-embedded pathway in which high-energy electrons are handed from one carrier to the next through a series of protein complexes while, at several of those complexes, protons are simultaneously moved from one side of the membrane to the other. The electrons ultimately arrive at molecular oxygen. Which statement best captures what this arrangement accomplishes energetically?', '[{"label": "A", "text": "Each electron transfer directly synthesizes one ATP, so the proton movement is an incidental byproduct with no stored energy."}, {"label": "B", "text": "The complexes pump protons to raise the electrons'' energy at each step, allowing the electrons to move toward carriers of lower electron affinity."}, {"label": "C", "text": "Energy released as electrons fall through the carriers is captured as a transmembrane proton gradient rather than being used to make ATP directly at each complex."}, {"label": "D", "text": "Oxygen donates the electrons at the start of the pathway, and the proton movement stores the energy needed to regenerate the reduced carriers."}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is C because the described flow, electrons dropping through a series of complexes to \(\text{O}_2\) while protons are pumped across the membrane, converts the free energy of the exergonic electron transfers into a stored electrochemical \(\text{H}^+\) gradient. ATP is not made at each complex; the gradient is the intermediate energy currency that a separate machine later uses.

(Choice C) is correct: the energy released as electrons move to progressively higher-affinity carriers is conserved by pumping \(\text{H}^+\), building the proton-motive force instead of directly phosphorylating ADP at each step.

(Choice A) is incorrect: electron transfers do not each mint an ATP; the whole point of pumping protons is to bank the energy in a gradient, so the proton movement is central, not incidental.

(Choice B) is incorrect: pumping protons does not raise the electrons'' energy, and electrons move toward carriers of higher electron affinity (more positive reduction potential), not lower.

(Choice D) is incorrect: \(\text{O}_2\) accepts electrons at the end of the chain as the terminal acceptor; it does not donate them at the start.

As a Skill 2 (reasoning about scientific concepts) item, the task is to interpret the described electron-and-proton flow as an energy-conversion device that stores redox energy in a gradient rather than recalling a definition.', 'medium', '1D', 'Oxidative Phosphorylation', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'ATP made directly at each complex' FROM q
  UNION ALL
  SELECT id, 'B', 'reversed_relationship', 'electrons flow toward lower affinity' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'O2 as electron donor not acceptor' FROM q;

-- Q52 [G2 · Electron Transport Chain: Complexes & Carriers] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Electron Transport Chain: Complexes & Carriers', 'A researcher lists standard reduction potentials for two mitochondrial redox couples: NAD+/NADH at about -0.32 V and FMN/FMNH2 at about -0.22 V. In Complex I, these two cofactors sit adjacent to each other and exchange electrons as respiration proceeds spontaneously toward O2. Given that electrons in the chain move spontaneously in the direction that releases free energy, what redox change must each of these two cofactors undergo when they react with each other?', '[{"label": "A", "text": "NADH is reduced to NADH2, while FMN is oxidized to FMN+."}, {"label": "B", "text": "FMNH2 is oxidized to FMN, and NAD+ is reduced to NADH."}, {"label": "C", "text": "NADH is oxidized to NAD+, and FMNH2 is oxidized to FMN."}, {"label": "D", "text": "NADH is oxidized to NAD+, and FMN is reduced to FMNH2."}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is D because a spontaneous electron transfer moves electrons from the couple with the more negative reduction potential to the one with the more positive reduction potential. The NAD+/NADH couple (\(-0.32\text{ V}\)) is more negative than the FMN/FMNH2 couple (\(-0.22\text{ V}\)), so electrons flow spontaneously from the NADH side to the FMN side. Losing electrons is oxidation, so NADH becomes \(\text{NAD}^+\); gaining electrons is reduction, so FMN becomes \(\text{FMNH}_2\).

(Choice D) is correct: because NADH sits at the more negative potential, it is the electron donor and is oxidized to \(\text{NAD}^+\), while FMN (more positive potential) is the acceptor and is reduced to \(\text{FMNH}_2\), consistent with spontaneous flow toward the higher-potential O2 downstream.

(Choice A) is incorrect: it reverses the direction implied by the potentials. NADH, at the more negative potential, donates electrons and is oxidized, not reduced; also ''\(\text{NADH}_2\)'' and ''\(\text{FMN}^+\)'' are not real species (NADH is already the reduced two-electron form and FMN is not oxidized to a cation here).

(Choice B) is incorrect: it describes electron flow from FMNH2 to NAD+, the reverse of the spontaneous direction. Electrons cannot move uphill from the more positive FMN couple to the more negative NAD+ couple without an input of energy, so this would be a non-spontaneous transfer.

(Choice C) is incorrect: it correctly oxidizes NADH but starts FMN in its already-reduced form (FMNH2) and oxidizes it, meaning FMN would give up electrons at the same time NADH does. Both cofactors cannot be simultaneously oxidized in a single electron transfer between them; the acceptor must be reduced.

As a Skill 2 (reasoning about scientific concepts) item, the task is to combine the two reduction potentials with the rule that spontaneous electron flow proceeds toward more positive potentials, then infer which cofactor is oxidized and which is reduced.', 'medium', '1D', 'Oxidative Phosphorylation', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'flow direction reversed / nonexistent species (NADH2, FMN+)' FROM q
  UNION ALL
  SELECT id, 'B', 'reversed_relationship', 'electrons pushed uphill from FMNH2 to NAD+' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'NADH right, but acceptor oxidized instead of reduced' FROM q;

-- Q53 [G3 · Electron Transport Chain: Complexes & Carriers] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Electron Transport Chain: Complexes & Carriers', 'Succinate dehydrogenase (Complex II) accepts electrons from succinate via bound FAD and passes them to coenzyme Q, but unlike the NADH-oxidizing complex it spans the membrane without pumping any protons. A student notes that electrons entering the chain through Complex II ultimately support less ATP synthesis than electrons entering from NADH. Which reasoning best explains that difference?', '[{"label": "A", "text": "Electrons from FADH2 enter at coenzyme Q and therefore skip the proton-pumping done at Complex I, so fewer protons are moved per pair of electrons reaching oxygen."}, {"label": "B", "text": "Electrons from FADH2 carry less energy at oxygen itself, so Complex IV pumps fewer protons for them than for NADH-derived electrons."}, {"label": "C", "text": "Complex II consumes ATP to push electrons uphill to coenzyme Q, directly subtracting from the cell''s ATP total."}, {"label": "D", "text": "FADH2 delivers only one electron to the chain whereas NADH delivers two, halving the number of protons pumped downstream."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is A because the yield difference is a bookkeeping consequence of the entry point: electrons from \(\text{FADH}_2\) join the chain at coenzyme Q, downstream of Complex I, so the protons that Complex I would have pumped for \(\text{NADH}\)-derived electrons are never moved. Both paths converge at Q and traverse the same Complex III and IV, so the missing Complex I contribution is exactly what lowers the proton count and thus the ATP (~1.5 vs ~2.5).

(Choice A) is correct: bypassing Complex I means fewer \(\text{H}^+\) pumped per electron pair, which is what shrinks the proton-motive force available for ATP synthesis.

(Choice B) is incorrect: once both sets of electrons reach coenzyme Q they follow the identical downstream route to \(\text{O}_2\), so Complex IV pumps the same for each; the electrons do not arrive at oxygen with different energies.

(Choice C) is incorrect: Complex II does not hydrolyze ATP to move electrons; the reaction (succinate to fumarate reducing FAD) is favorable and simply does not pump protons.

(Choice D) is incorrect: \(\text{FADH}_2\) and \(\text{NADH}\) both carry two electrons; the yield gap is about entry point, not the number of electrons delivered.

As a Skill 2 (reasoning about scientific concepts) item, the task is to connect Complex II''s entry point and lack of proton pumping to a lower downstream proton count rather than recalling the ATP numbers.', 'hard', '1D', 'Oxidative Phosphorylation', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'electrons differ in energy at O2' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'Complex II hydrolyzes ATP' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'FADH2 carries one electron' FROM q;

-- Q54 [G4 · Electron Transport Chain: Complexes & Carriers] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Electron Transport Chain: Complexes & Carriers', 'Complex III passes electrons from reduced coenzyme Q (QH2) to cytochrome c. Each cytochrome c is a heme protein whose single iron atom toggles between the Fe3+ and Fe2+ states as it works. A reduced QH2 molecule brings two electrons into Complex III. Given only how cytochrome c iron behaves, why must two separate cytochrome c molecules be reduced for each QH2 that is oxidized?', '[{"label": "A", "text": "Cytochrome c iron accepts two electrons at once, but half are lost to the membrane, so a spare molecule is needed to make up the deficit."}, {"label": "B", "text": "Each cytochrome c iron can accept only one electron at a time (Fe3+ to Fe2+), so carrying QH2''s two electrons requires two cytochrome c molecules."}, {"label": "C", "text": "Two cytochrome c molecules must bind simultaneously to hold QH2 in place; only one of them actually carries an electron onward."}, {"label": "D", "text": "Each cytochrome c carries two electrons, so two of them are needed to move the four electrons released when QH2 is oxidized."}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is B because the heme iron''s described \(\text{Fe}^{3+}/\text{Fe}^{2+}\) toggle changes by a single unit of charge, which is a one-electron redox event. Since one cytochrome c can therefore hold only one electron, the two electrons delivered by a single QH2 must be split between two separate cytochrome c molecules.

(Choice B) is correct: a one-electron carrier (\(\text{Fe}^{3+}\rightarrow\text{Fe}^{2+}\)) times two electrons per QH2 requires two cytochrome c acceptors.

(Choice A) is incorrect: the iron does not accept two electrons at once, and electrons are not ''lost to the membrane''; both are conserved and handed to two carriers.

(Choice C) is incorrect: the requirement for two cytochrome c comes from the one-electron capacity of each, not from a structural need to clamp QH2 with a non-carrying partner.

(Choice D) is incorrect: each cytochrome c carries one electron, not two, and QH2 delivers two electrons, not four, so the arithmetic in this option is wrong on both counts.

As a Skill 2 (reasoning about scientific concepts) item, the task is to reason from the single-unit \(\text{Fe}^{3+}/\text{Fe}^{2+}\) change to the one-electron capacity of cytochrome c and its stoichiometric consequence.', 'medium', '1D', 'Oxidative Phosphorylation', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'electrons lost to membrane' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'two bind for structural clamping' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'two electrons per cyt c / four per QH2' FROM q;

-- Q55 [G5 · Electron Transport Chain: Complexes & Carriers] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Electron Transport Chain: Complexes & Carriers', 'At the last complex of the chain, electrons arriving from cytochrome c are delivered to molecular oxygen, which is combined with protons to form water. A physiologist points out that if oxygen is unavailable, every carrier in the entire chain quickly becomes stuck. Which explanation best accounts for why oxygen availability governs the whole chain even though it acts only at the final step?', '[{"label": "A", "text": "Oxygen is needed at Complex I to accept electrons from NADH; without it the chain cannot start loading electrons in the first place."}, {"label": "B", "text": "Oxygen physically pumps the protons at Complex IV, so its absence stops the gradient but leaves the carriers free to keep cycling electrons."}, {"label": "C", "text": "Oxygen is the terminal sink that removes electrons from the chain; without it every upstream carrier stays reduced and can no longer accept more."}, {"label": "D", "text": "Oxygen continuously regenerates coenzyme Q; without it the mobile carrier is depleted and electrons pile up specifically at Complex II."}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is C because a chain of carriers can keep moving electrons only if the last carrier can offload them. \(\text{O}_2\) is that final acceptor; when it is absent, Complex IV cannot dispose of electrons, so it stays reduced, which means cytochrome c cannot unload onto it, which means Complex III backs up, and the block propagates upstream until every carrier is reduced and stalled.

(Choice C) is correct: as the terminal electron sink, \(\text{O}_2\) keeps electrons flowing; removing it causes the entire chain to fill with electrons and freeze.

(Choice A) is incorrect: \(\text{O}_2\) acts at Complex IV, not Complex I; \(\text{NADH}\) is oxidized at Complex I regardless of the terminal step, so oxygen is not what loads electrons at the start.

(Choice B) is incorrect: \(\text{O}_2\) does not pump protons; and if the carriers really could keep cycling, the chain would not stall, contradicting the observation.

(Choice D) is incorrect: coenzyme Q is regenerated by handing electrons to Complex III, not by oxygen, and a backup from loss of \(\text{O}_2\) is not confined to Complex II.

As a Skill 2 (reasoning about scientific concepts) item, the task is to reason that a terminal acceptor''s absence propagates backward through a sequential carrier chain, not to recall that oxygen is the final acceptor.', 'medium', '1D', 'Oxidative Phosphorylation', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'process_step_confusion', 'O2 acts at Complex I' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'O2 pumps protons / carriers keep cycling' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'O2 regenerates coenzyme Q' FROM q;

-- Q56 [G6 · Electron Transport Chain: Complexes & Carriers] easy skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Electron Transport Chain: Complexes & Carriers', 'Two different complexes reduce the same small, lipid-soluble molecule that then diffuses through the membrane to hand its electrons to the next complex. One of those two complexes oxidizes NADH; the other oxidizes succinate. What role does this shared mobile molecule play in the chain?', '[{"label": "A", "text": "It is a fixed protein subunit of Complex I that passes electrons only from NADH, never from succinate."}, {"label": "B", "text": "It is a water-soluble carrier in the intermembrane space that shuttles electrons from Complex III to Complex IV."}, {"label": "C", "text": "It splits the electron stream so that NADH-derived electrons go to Complex III while succinate-derived electrons go directly to oxygen."}, {"label": "D", "text": "It is a convergence point that collects electrons from both entry complexes and funnels them into a single downstream pathway toward Complex III."}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is D because the described molecule, a small lipid-soluble mobile carrier reduced by both the NADH-oxidizing complex (Complex I) and the succinate-oxidizing complex (Complex II), is coenzyme Q. Its defining function is to gather electrons from those two separate entry points and merge them into one stream delivered to Complex III.

(Choice D) is correct: coenzyme Q is where the Complex I and Complex II inputs converge before continuing downstream as a single pathway.

(Choice A) is incorrect: coenzyme Q is a mobile, membrane-diffusing carrier, not a fixed subunit, and it accepts electrons from both Complex I and Complex II.

(Choice B) is incorrect: that description fits cytochrome c (water-soluble, intermembrane-space, between III and IV), not the lipid-soluble carrier described here.

(Choice C) is incorrect: coenzyme Q merges the two inputs rather than splitting them, and succinate-derived electrons pass through Complex III, not directly to \(\text{O}_2\).

As a Skill 2 (reasoning about scientific concepts) item, the task is to identify the molecule''s convergence role from the two described entry points rather than to recall its name.', 'easy', '1D', 'Oxidative Phosphorylation', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'coenzyme Q is a fixed subunit' FROM q
  UNION ALL
  SELECT id, 'B', 'adjacent_fact', 'swapped with cytochrome c' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'Q splits stream / succinate to O2' FROM q;

-- Q57 [G7 · Electron Transport Chain: Complexes & Carriers] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Electron Transport Chain: Complexes & Carriers', 'Four carriers have the following standard reduction potentials: carrier W = +0.03 V, carrier X = +0.25 V, carrier Y = -0.32 V, and oxygen = +0.82 V. If these carriers are arranged into a spontaneous electron-transport sequence ending at oxygen, in what order will electrons pass, and which species is the strongest electron acceptor?', '[{"label": "A", "text": "Y then W then X then O2; oxygen is the strongest acceptor."}, {"label": "B", "text": "X then W then Y then O2; oxygen is the strongest acceptor."}, {"label": "C", "text": "O2 then X then W then Y; carrier Y is the strongest acceptor."}, {"label": "D", "text": "Y then X then W then O2; oxygen is the strongest acceptor."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is A because spontaneous electron flow proceeds from the most negative reduction potential toward the most positive, since each step must move electrons to a carrier with greater electron affinity. Ordering the potentials from low to high gives Y (\(-0.32\) V) then W (\(+0.03\) V) then X (\(+0.25\) V) then \(\text{O}_2\) (\(+0.82\) V), and the most positive potential, \(\text{O}_2\), is the strongest acceptor.

(Choice A) is correct: increasing reduction potential (\(-0.32 < +0.03 < +0.25 < +0.82\)) sets the order Y, W, X, \(\text{O}_2\), with \(\text{O}_2\) as the terminal, strongest acceptor.

(Choice B) is incorrect: it starts at X (\(+0.25\) V) and moves to more negative carriers, which is the reverse of spontaneous flow.

(Choice C) is incorrect: it places \(\text{O}_2\) first and calls Y the strongest acceptor, but \(\text{O}_2\) has the most positive potential and is the strongest acceptor, not the donor.

(Choice D) is incorrect: it swaps W and X, placing X (\(+0.25\) V) before W (\(+0.03\) V), which violates the increasing-potential ordering.

At the Skill 2 (reasoning about scientific concepts) level, the task is to derive the flow order from the given potentials using the rule that electrons move toward higher reduction potential, not to recall a fixed chain sequence.', 'hard', '1D', 'Oxidative Phosphorylation', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'high-to-low ordering' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'O2 first / Y strongest acceptor' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'W and X transposed' FROM q;

-- Q58 [G8 · Electron Transport Chain: Complexes & Carriers] easy skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Electron Transport Chain: Complexes & Carriers', 'One carrier in the chain is a small, water-soluble protein that rests on the intermembrane-space face of the inner membrane and moves along that surface between two of the large complexes. It carries a single heme group whose central iron toggles between the Fe³⁺ and Fe²⁺ oxidation states as it picks up and releases cargo. Based on this profile, which pair of complexes does this carrier connect, and how many electrons must it move per trip?', '[{"label": "A", "text": "It shuttles between Complex I and Complex III, carrying two electrons per trip."}, {"label": "B", "text": "It shuttles between Complex III and Complex IV, carrying one electron per trip."}, {"label": "C", "text": "It shuttles between Complex I and Complex II, carrying one electron per trip."}, {"label": "D", "text": "It shuttles between Complex IV and oxygen within the lipid bilayer, carrying two electrons per trip."}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is B because the profile given, a small water-soluble carrier resting on the intermembrane-space face of the inner membrane with a single heme, identifies cytochrome c. Because its heme iron cycles between only two adjacent oxidation states, \(\text{Fe}^{3+}\) and \(\text{Fe}^{2+}\), each pickup-and-release event transfers exactly one electron, and cytochrome c relays those single electrons from Complex III to Complex IV along that surface.

(Choice B) is correct: cytochrome c bridges Complex III and Complex IV, and the \(\text{Fe}^{3+}/\text{Fe}^{2+}\) toggle is a one-electron change, so a single electron moves per trip; this matches its water-soluble mobility on the intermembrane-space face of the inner membrane.

(Choice A) is incorrect: the Complex I to Complex III leg is served by coenzyme Q (ubiquinone), a lipid-soluble carrier that ferries two electrons within the membrane. Cytochrome c is water-soluble, sits on the membrane surface, and its heme iron toggles between just two states, so it can only move one electron, not two.

(Choice C) is incorrect: Complexes I and II both feed coenzyme Q independently and are not linked to each other by a shuttling protein, so no carrier bridges this pair; the electron count is right for cytochrome c but the complex pairing is not.

(Choice D) is incorrect: cytochrome c is water-soluble on the membrane surface, not embedded in the bilayer, and its one-electron \(\text{Fe}^{3+}/\text{Fe}^{2+}\) chemistry rules out two electrons per trip; \(\text{O}_2\) is reduced within Complex IV itself rather than reached by a separate surface shuttle.

At the Skill 2 (reasoning about scientific concepts) level, the task is to infer both the complex pair and the per-trip electron count from the carrier''s described location, solubility, and single-heme iron redox chemistry.', 'easy', '1D', 'Oxidative Phosphorylation', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'adjacent_fact', 'confused with coenzyme Q leg (two-electron lipid carrier)' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'carrier links Complex I and Complex II' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'bilayer-embedded shuttle reaching O2 / two electrons' FROM q;

-- Q59 [G9 · Electron Transport Chain: Complexes & Carriers] hard skill4 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Electron Transport Chain: Complexes & Carriers', 'In isolated, actively respiring mitochondria supplied with both an NADH-generating substrate (e.g., malate/pyruvate) and succinate, a drug is added that completely blocks Complex I, stopping electron transfer from its Fe-S clusters to coenzyme Q. The carriers upstream of this block are NADH and the Complex I flavin (FMN) and iron-sulfur components; the carriers downstream include coenzyme Q, Complex III, cytochrome c, and Complex IV. Assume no alternative route exists around Complex I itself. Immediately after the block, what happens to the redox state of the Complex I carriers and to oxygen consumption?', '[{"label": "A", "text": "The Complex I carriers become fully oxidized, but oxygen consumption continues at a reduced rate because succinate still feeds electrons into coenzyme Q through Complex II."}, {"label": "B", "text": "The Complex I carriers become fully reduced, and oxygen consumption falls to essentially zero because no electrons can reach Complex IV."}, {"label": "C", "text": "The Complex I carriers (FMN and Fe-S) become fully reduced, but oxygen consumption continues at a reduced rate because succinate still feeds electrons into coenzyme Q through Complex II."}, {"label": "D", "text": "The Complex I carriers become fully reduced, and oxygen consumption increases because electrons back up and are forced onto oxygen more rapidly."}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is C because rotenone-type inhibition blocks electron transfer from the Fe-S clusters of Complex I to coenzyme Q. NADH keeps delivering electrons to Complex I''s FMN and Fe-S clusters, but those electrons cannot exit to \(\text{CoQ}\), so the Complex I carriers accumulate electrons and become fully reduced. Crucially, coenzyme Q is a mobile carrier fed by two entry points: Complex I and Complex II (succinate dehydrogenase). Because succinate is present, Complex II keeps injecting electrons directly into \(\text{CoQ}\), which then flow to Complex III, cytochrome c, Complex IV, and finally \(\text{O}_2\). Oxygen consumption therefore continues, though at a reduced rate, since the NADH-derived flux through Complex I is lost while the succinate-derived flux persists.

(Choice C) is correct: the Complex I carriers back up and become reduced, yet \(\text{O}_2\) uptake continues because the Complex II entry point bypasses the block and keeps supplying electrons to the shared \(\text{CoQ}\) pool.

(Choice A) is incorrect: the carriers upstream of the block cannot offload their electrons, so they become reduced, not oxidized. The clause about continued \(\text{O}_2\) consumption via Complex II is correct, but the redox state assigned to Complex I is reversed.

(Choice B) is incorrect: this describes what a downstream block (e.g., at Complex III or IV, or cyanide at Complex IV) would do. A Complex I block leaves the Complex II entry to \(\text{CoQ}\) intact, so electrons still reach Complex IV and \(\text{O}_2\) consumption does not fall to zero.

(Choice D) is incorrect: a block cannot raise \(\text{O}_2\) consumption. Electrons backing up at Complex I are trapped there and cannot be "forced" onto \(\text{O}_2\); a rise in respiration is the signature of an uncoupler (e.g., DNP), not an inhibitor.

At the Skill 4 (data-based reasoning) level, the task is to infer, from the described block location, which carriers accumulate electrons and to recognize that a second \(\text{CoQ}\) entry point (Complex II via succinate) allows residual oxygen consumption to continue despite the block.', 'hard', '1D', 'Oxidative Phosphorylation', 'biochemistry', 4, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'Complex I carriers oxidized instead of reduced' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'treats a Complex I block like a downstream block; ignores Complex II bypass, O2 falls to zero' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'block raises O2 consumption (confuses inhibitor with uncoupler)' FROM q;

-- Q60 [H1 · Electron Transport Chain: Proton-Motive Force] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Electron Transport Chain: Proton-Motive Force', 'A researcher studies intact, actively respiring mitochondria. To probe the proton-motive force, she adds valinomycin, a lipid-soluble ionophore that carries K+ across the inner membrane. In the buffer, K+ is far more concentrated outside the matrix than inside, so once valinomycin is present K+ flows down its own gradient into the matrix. Electron transport and proton pumping are not otherwise disturbed. Compared with the untreated state, how should the two components of the proton-motive force change immediately after valinomycin is added?', '[{"label": "A", "text": "The pH gradient should shrink because inward K+ carries protons with it, while the membrane voltage is left largely intact."}, {"label": "B", "text": "Both the membrane voltage and the pH gradient should shrink equally, because K+ movement collapses the entire electrochemical gradient at once."}, {"label": "C", "text": "Neither component should change, because only H+ movement can alter a proton-motive force and valinomycin moves K+ rather than H+."}, {"label": "D", "text": "The membrane voltage should shrink because inward K+ neutralizes charge, while the pH gradient is left largely intact."}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is D because the proton-motive force is an electrochemical gradient with two separable parts: an electrical component (the membrane voltage, \(\Delta\Psi\), from net charge separation, with the matrix negative) and a chemical component (the pH gradient, from the higher \(\text{H}^+\) concentration in the intermembrane space). Valinomycin carries positively charged \(\text{K}^+\) into the matrix down the K+ gradient. Because \(\text{K}^+\) is a cation, its inward flow adds positive charge to the matrix and cancels the charge separation that the pumped protons had created, so the voltage component collapses. That inward movement of \(\text{K}^+\), however, does not change the \(\text{H}^+\) concentrations on either side, so the pH gradient is left essentially intact. The manipulation therefore selectively dissipates the electrical component while sparing the chemical component.

(Choice D) is correct: inward \(\text{K}^+\) neutralizes the charge separation, shrinking the voltage, while the pH gradient (set by \(\text{H}^+\) concentrations) is unaffected because valinomycin moves \(\text{K}^+\), not \(\text{H}^+\).

(Choice A) is incorrect: valinomycin transports \(\text{K}^+\), not \(\text{H}^+\), and \(\text{K}^+\) does not carry protons along with it, so the \(\text{H}^+\) concentrations and thus the pH gradient are unchanged; it is the voltage, not the pH gradient, that collapses.

(Choice B) is incorrect: the two components are physically distinct. Moving a non-proton cation dissipates only the charge (voltage) term; it cannot directly change the \(\text{H}^+\) concentration difference, so the pH gradient does not collapse alongside the voltage.

(Choice C) is incorrect: the electrical component responds to net charge across the membrane regardless of which ion carries it, so moving any cation such as \(\text{K}^+\) alters \(\Delta\Psi\); the voltage does not require \(\text{H}^+\) specifically.

As a Skill 2 (reasoning about scientific concepts) item, this question requires predicting how an ion-selective manipulation acts on each component of the electrochemical gradient rather than recalling a labeled definition.', 'medium', '1D', 'Oxidative Phosphorylation', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'attributes the collapse to the pH component instead of the voltage; assumes K+ drags protons' FROM q
  UNION ALL
  SELECT id, 'B', 'partial_truth', 'treats the two components as inseparable; collapses whole gradient' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'believes only H+ movement can affect the proton-motive force' FROM q;

-- Q61 [H2 · Electron Transport Chain: Proton-Motive Force] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Electron Transport Chain: Proton-Motive Force', 'A biochemist compares two mobile carriers in the electron transport chain. Carrier X has a more negative standard reduction potential than carrier Y. Assuming both are free to exchange electrons and no other constraints apply, which prediction about electron transfer between them is best supported, and why?', '[{"label": "A", "text": "Electrons flow spontaneously from X to Y, because electrons move toward the carrier with the higher (more positive) reduction potential and the transfer is exergonic."}, {"label": "B", "text": "Electrons flow spontaneously from Y to X, because electrons always move toward the carrier with the more negative reduction potential."}, {"label": "C", "text": "No net transfer occurs, because reduction potential governs only how tightly a carrier binds protons, not the direction of electron movement."}, {"label": "D", "text": "Electrons flow spontaneously from X to Y, but the transfer is endergonic and must be driven by energy released elsewhere in the chain."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is A because a more positive reduction potential means a greater tendency to gain electrons. Since carrier Y has the higher (less negative) potential, electrons move from the lower-potential carrier X to the higher-potential carrier Y. Moving electrons downhill in potential toward \(\text{O}_2\) is energy-releasing, so the transfer is exergonic (\(\Delta G < 0\)).

(Choice A) is correct: it identifies the direction as X to Y, toward the more positive potential, and correctly labels the transfer exergonic.

(Choice B) is incorrect: it reverses the rule. Electrons move toward more positive, not more negative, potential, so Y-to-X is the non-spontaneous direction.

(Choice C) is incorrect: reduction potential sets the direction of electron flow, not proton binding, so a difference in potential does produce net electron transfer.

(Choice D) is incorrect: the direction X to Y is correct, but flow toward higher potential releases free energy, making it exergonic rather than endergonic.

As a Skill 2 (reasoning about scientific concepts) item, this question requires applying the reduction-potential rule to predict both the direction and the energetic character of electron transfer rather than restating a memorized fact.', 'medium', '1D', 'Oxidative Phosphorylation', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'flow toward more negative potential' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'potential governs proton binding' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'right direction, wrong energetics' FROM q;

-- Q62 [H3 · Electron Transport Chain: Proton-Motive Force] hard skill4 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Electron Transport Chain: Proton-Motive Force', 'Two electron carriers have the following standard reduction potentials: cytochrome c, \(E^{\circ\prime} = +0.25\ \text{V}\); coenzyme Q, \(E^{\circ\prime} = +0.04\ \text{V}\). Treating the carrier that gains electrons as the reduction half-reaction and the carrier that loses electrons as the oxidation half-reaction, in which direction do electrons spontaneously transfer, and what is the sign of \(\Delta E\) for that spontaneous process?', '[{"label": "A", "text": "From cytochrome c to coenzyme Q, with \\(\\Delta E = +0.21\\ \\text{V}\\) (positive)."}, {"label": "B", "text": "From coenzyme Q to cytochrome c, with \\(\\Delta E = +0.21\\ \\text{V}\\) (positive)."}, {"label": "C", "text": "From coenzyme Q to cytochrome c, with \\(\\Delta E = -0.21\\ \\text{V}\\) (negative)."}, {"label": "D", "text": "From cytochrome c to coenzyme Q, with \\(\\Delta E = -0.29\\ \\text{V}\\) (negative)."}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is B because electrons move spontaneously toward the carrier with the higher reduction potential. Cytochrome c \((+0.25\ \text{V})\) exceeds coenzyme Q \((+0.04\ \text{V})\), so cytochrome c is reduced and coenzyme Q is oxidized: electrons flow from Q to cytochrome c. Computing \(\Delta E = E^{\circ\prime}_{\text{reduction (cyt c)}} - E^{\circ\prime}_{\text{oxidation (Q)}} = (+0.25) - (+0.04) = +0.21\ \text{V}\). A positive \(\Delta E\) corresponds to a negative \(\Delta G\), confirming a spontaneous transfer in that direction.

(Choice B) is correct: it gives the direction Q to cytochrome c and the correctly signed magnitude \(\Delta E = +0.21\ \text{V}\).

(Choice A) is incorrect: the magnitude \(+0.21\ \text{V}\) is right, but the direction is reversed; electrons cannot flow spontaneously from the higher-potential cytochrome c to the lower-potential coenzyme Q.

(Choice C) is incorrect: the direction Q to cytochrome c is right, but a spontaneous transfer has a positive \(\Delta E\), not negative.

(Choice D) is incorrect: it both reverses the direction and misuses the potentials, adding them rather than subtracting to get \(-0.29\ \text{V}\).

At the Skill 4 (data-based reasoning) level, this question requires extracting the two potentials, assigning reduction and oxidation half-reactions from the data, and computing the sign and size of \(\Delta E\) rather than recalling the carrier order.', 'hard', '1D', 'Oxidative Phosphorylation', 'biochemistry', 4, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'correct magnitude, reversed direction' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'spontaneous but negative delta E' FROM q
  UNION ALL
  SELECT id, 'D', 'scale_unit_error', 'added potentials instead of subtracting' FROM q;

-- Q63 [H4 · Electron Transport Chain: Proton-Motive Force] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Electron Transport Chain: Proton-Motive Force', 'A student maps the four respiratory complexes and notes that three of them pump protons across the inner membrane while one moves electrons into the chain without pumping any. Considering how each complex contributes to the proton gradient, which explanation best accounts for why one complex adds no protons while the others do?', '[{"label": "A", "text": "Complexes I, II, and III pump protons, but Complex IV does not, because oxygen reduction consumes the protons that would otherwise be pumped."}, {"label": "B", "text": "Complexes II, III, and IV pump protons, but Complex I does not, because NADH oxidation occurs on the matrix side where no translocation is possible."}, {"label": "C", "text": "Complexes I, III, and IV couple electron transfer to proton pumping, but Complex II (succinate dehydrogenase) only feeds electrons to coenzyme Q via FAD and does not translocate protons, so it adds nothing to the gradient."}, {"label": "D", "text": "All four complexes pump protons, but Complex II pumps into the matrix rather than the intermembrane space, so its contribution cancels the others."}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is C because the proton-pumping complexes are I, III, and IV, each of which links electron transfer to translocation of \(\text{H}^+\) into the intermembrane space. Complex II (succinate dehydrogenase) accepts electrons from succinate via enzyme-bound FAD and hands them to coenzyme Q, but this pathway is not coupled to any proton movement, so it contributes nothing to the gradient even though it does inject electrons into the chain.

(Choice C) is correct: it names I, III, and IV as the pumps and correctly identifies Complex II as the non-pumping entry point that only feeds electrons to coenzyme Q.

(Choice A) is incorrect: Complex IV does pump protons in addition to reducing \(\text{O}_2\); consuming protons at the active site does not make it a non-pumping complex.

(Choice B) is incorrect: Complex I is a proton pump; NADH is oxidized at Complex I and its electron transfer is coupled to translocation, so it is not the non-pumping complex.

(Choice D) is incorrect: Complex II does not pump at all, so there is no reverse pumping to cancel the gradient built by I, III, and IV.

As a Skill 2 (reasoning about scientific concepts) item, this question requires reasoning about which complexes couple electron transfer to proton translocation and why the succinate-entry complex leaves the gradient unchanged.', 'medium', '1D', 'Oxidative Phosphorylation', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'Complex IV labeled non-pumping' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'Complex I labeled non-pumping' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'Complex II pumps in reverse' FROM q;

-- Q64 [H5 · Electron Transport Chain: Proton-Motive Force] easy skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Electron Transport Chain: Proton-Motive Force', 'During active respiration, the proton-pumping complexes continuously move \(\text{H}^+\) from the matrix into the intermembrane space. As this pumping proceeds over time, what happens to the pH and the membrane voltage on the intermembrane-space side?', '[{"label": "A", "text": "The pH of the intermembrane space rises and its positive charge falls, because removing protons from the matrix leaves the intermembrane space less acidic."}, {"label": "B", "text": "The pH of the intermembrane space falls but its charge becomes more negative, because protons neutralize positive charge as they accumulate."}, {"label": "C", "text": "Both the pH and the charge of the intermembrane space stay constant, because each pumped proton is immediately balanced by a proton returning to the matrix."}, {"label": "D", "text": "The pH of the intermembrane space falls and its positive charge rises, because accumulating protons both increase acidity and add positive charge on that side."}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is D because each \(\text{H}^+\) pumped out raises the proton concentration in the intermembrane space, and higher \(\text{H}^+\) means lower pH (more acidic). Because a proton carries a positive charge, accumulating protons also make the intermembrane space more positively charged relative to the matrix, raising the membrane voltage across the inner membrane.

(Choice D) is correct: it links proton accumulation to falling pH and rising positive charge on the intermembrane-space side.

(Choice A) is incorrect: protons are added to the intermembrane space, not removed from it, so that side becomes more acidic, and its pH falls rather than rises.

(Choice B) is incorrect: the pH change is right, but protons are positive, so they raise the positive charge on that side rather than making it more negative.

(Choice C) is incorrect: during active pumping the gradient is being built, not held at steady balance, so pH and charge change rather than staying constant.

As a Skill 2 (reasoning about scientific concepts) item, this question requires reasoning from the act of proton pumping to its simultaneous effects on pH and charge rather than recalling the endpoint values.', 'easy', '1D', 'Oxidative Phosphorylation', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'pH rises as protons leave matrix' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'protons make charge more negative' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'steady-state balance, no change' FROM q;

-- Q65 [H6 · Electron Transport Chain: Proton-Motive Force] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Electron Transport Chain: Proton-Motive Force', 'After the electron transport chain has built a proton gradient, protons in the intermembrane space have both a higher concentration and a higher positive charge than those in the matrix. A student asks why this arrangement is described as a store of usable energy. Which explanation best captures the source of that stored energy?', '[{"label": "A", "text": "Because protons are held out of equilibrium, their return to the matrix down both the concentration and charge gradients releases free energy that can be harnessed."}, {"label": "B", "text": "Because the protons in the intermembrane space are chemically bonded to the membrane, and breaking those bonds during release liberates energy."}, {"label": "C", "text": "Because the higher temperature of the intermembrane space relative to the matrix drives protons back inward, and this heat flow is the stored energy."}, {"label": "D", "text": "Because protons flowing back to the matrix move up their electrochemical gradient, and climbing that gradient is what releases usable free energy."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is A because pumping has placed protons far from equilibrium: \(\text{H}^+\) is concentrated and positively charged on the intermembrane-space side. A system held away from equilibrium stores free energy, and when protons are allowed to flow back down both the concentration gradient and the charge gradient into the matrix, that free energy (\(\Delta G\)) is released and can be captured to do work.

(Choice A) is correct: it grounds the stored energy in the out-of-equilibrium electrochemical gradient whose relaxation releases free energy.

(Choice B) is incorrect: protons are not covalently bonded to the membrane; the energy is stored in a concentration and charge gradient, not in chemical bonds.

(Choice C) is incorrect: the gradient is electrochemical, not thermal; a temperature difference is not the basis of the proton-motive force.

(Choice D) is incorrect: protons flow back down, not up, their electrochemical gradient, and moving down the gradient (toward equilibrium) is what releases energy.

As a Skill 2 (reasoning about scientific concepts) item, this question requires reasoning about why an out-of-equilibrium gradient constitutes stored free energy rather than recalling that the gradient powers ATP synthesis.', 'medium', '1D', 'Oxidative Phosphorylation', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'energy stored in chemical bonds' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'thermal gradient instead of electrochemical' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'energy released climbing gradient' FROM q;

-- Q66 [H7 · Electron Transport Chain: Proton-Motive Force] hard skill4 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Electron Transport Chain: Proton-Motive Force', 'At Complex IV (cytochrome c oxidase), electrons arrive one at a time from reduced cytochrome c and are used to reduce molecular oxygen, the terminal electron acceptor, to water. If a sample of tissue fully reduces 3 molecules of \(\text{O}_2\) at this step, how many cytochrome c molecules must have been oxidized to supply the electrons, and how many water molecules are produced?', '[{"label": "A", "text": "12 cytochrome c oxidized and 3 water molecules produced."}, {"label": "B", "text": "12 cytochrome c oxidized and 6 water molecules produced."}, {"label": "C", "text": "6 cytochrome c oxidized and 6 water molecules produced."}, {"label": "D", "text": "24 cytochrome c oxidized and 6 water molecules produced."}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is B because you must supply two facts about Complex IV chemistry rather than read them off a given equation: First, reducing one \(\text{O}_2\) to water is a four-electron process: \(\text{O}_2 + 4\,e^- + 4\,\text{H}^+ \rightarrow 2\,\text{H}_2\text{O}\), so each \(\text{O}_2\) requires 4 electrons and yields 2 water molecules. Second, cytochrome c is a one-electron carrier (its heme iron cycles between \(\text{Fe}^{3+}\) and \(\text{Fe}^{2+}\), moving a single electron each time). Therefore each \(\text{O}_2\) requires 4 separate cytochrome c oxidation events. Scaling to 3 molecules of \(\text{O}_2\): cytochrome c oxidized \(= 3 \times 4 = 12\), and water \(= 3 \times 2 = 6\).

(Choice B) is correct: 4 one-electron cytochrome c per \(\text{O}_2\) gives 12, and 2 water per \(\text{O}_2\) gives 6.

(Choice A) is incorrect: the cytochrome c count is right, but it uses 1 water per \(\text{O}_2\) instead of 2, undercounting water as 3.

(Choice C) is incorrect: it treats cytochrome c as a two-electron carrier (like NADH or coenzyme Q), needing only 2 per \(\text{O}_2\) and halving the count to 6; cytochrome c actually carries one electron at a time. The water count of 6 is right, but the carrier logic is wrong.

(Choice D) is incorrect: it doubles the electrons required per \(\text{O}_2\) to 8, giving 24, which exceeds the 4-electron stoichiometry of oxygen reduction.

At the Skill 4 (data-based reasoning) level, this question requires combining the four-electron reduction of oxygen with the one-electron carrier property of cytochrome c and scaling the result, rather than recalling a single memorized number.', 'hard', '1D', 'Oxidative Phosphorylation', 'biochemistry', 4, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'scale_unit_error', 'one water per O2 instead of two' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'cytochrome c treated as a two-electron carrier' FROM q
  UNION ALL
  SELECT id, 'D', 'scale_unit_error', 'eight electrons per O2, doubled' FROM q;

-- Q67 [H8 · Electron Transport Chain: Proton-Motive Force] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Electron Transport Chain: Proton-Motive Force', 'A researcher measures the two components of the proton-motive force across the inner mitochondrial membrane of actively respiring mitochondria at 37 °C. The membrane potential (electrical component) is 140 mV, and the matrix is 0.6 pH units more alkaline than the intermembrane space (chemical component). At this temperature each pH unit of difference is worth about 61.5 mV. Treating the two components as additive, what is the total proton-motive force, and which component supplies the larger share of it?', '[{"label": "A", "text": "About 177 mV total, with the chemical (pH) component supplying the larger share."}, {"label": "B", "text": "About 103 mV total, because the chemical component is subtracted from the electrical component."}, {"label": "C", "text": "About 177 mV total, with the electrical (membrane-potential) component supplying the larger share."}, {"label": "D", "text": "About 61.5 mV total, because the pH difference alone sets the proton-motive force and the membrane potential is a separate quantity."}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is C because the proton-motive force is a single electrochemical gradient made of two additive parts: an electrical component (the membrane potential) and a chemical component (the pH difference), expressed in the same voltage units. The chemical part is the pH difference times the per-unit conversion: \(0.6 \times 61.5\ \text{mV} \approx 37\ \text{mV}\). Adding the two components gives \(140\ \text{mV} + 37\ \text{mV} \approx 177\ \text{mV}\). Because \(140\ \text{mV}\) is much larger than \(37\ \text{mV}\), the electrical component supplies the larger share (about four-fifths), which is characteristic of mammalian mitochondria.

(Choice C) is correct: converting the pH difference to \(\approx 37\ \text{mV}\) and adding the \(140\ \text{mV}\) membrane potential gives \(\approx 177\ \text{mV}\), and the electrical term is the larger of the two.

(Choice A) is incorrect: the total of \(\approx 177\ \text{mV}\) is right, but the chemical component is only \(\approx 37\ \text{mV}\) versus \(140\ \text{mV}\) electrical, so the pH term is the smaller share, not the larger one.

(Choice B) is incorrect: the two components add rather than oppose, because both the positive charge accumulated outside and the protons accumulated outside push protons back into the matrix in the same direction; subtracting them wrongly treats the components as antagonistic.

(Choice D) is incorrect: the pH difference is only one of the two components (and it contributes \(\approx 37\ \text{mV}\), not \(61.5\ \text{mV}\), since \(61.5\ \text{mV}\) is the per-pH-unit conversion factor, not the contribution itself); the membrane potential is not a separate, unrelated quantity but the electrical part of the same proton-motive force, so both must be included.

As a Skill 2 (reasoning about scientific concepts) item, this question requires converting the chemical component into voltage units and combining it additively with the electrical component to reason about the composition of the total proton-motive force.', 'medium', '1D', 'Oxidative Phosphorylation', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'partial_truth', 'correct total but names the smaller component as dominant' FROM q
  UNION ALL
  SELECT id, 'B', 'reversed_relationship', 'subtracts the two components instead of adding them' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'treats pH difference as the whole proton-motive force and grabs the per-unit conversion constant as the total' FROM q;

-- Q68 [I1 · Electron Transport Chain: Shuttles & Inhibitors] easy skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Electron Transport Chain: Shuttles & Inhibitors', 'A cell biologist tags the NADH produced in the cytosol during glycolysis with a fluorescent probe and tracks it. Even under fully aerobic conditions, the labeled NADH molecules never appear inside the mitochondrial matrix, yet the reducing equivalents they carry are clearly used to reduce O2 at the electron transport chain. Which explanation best accounts for how glycolytic reducing power reaches the electron transport chain despite the NADH itself staying in the cytosol?', '[{"label": "A", "text": "NADH freely diffuses across the inner mitochondrial membrane but is immediately re-oxidized to NAD+ upon entry, which prevents the probe from being detected in the matrix"}, {"label": "B", "text": "Glycolytic NADH is converted to FADH2 in the cytosol, and only FADH2 is small enough to cross the inner membrane and reach the chain"}, {"label": "C", "text": "The outer mitochondrial membrane blocks NADH, but once past it the NADH enters the matrix directly through Complex I"}, {"label": "D", "text": "The inner mitochondrial membrane is impermeable to NADH, so a shuttle system transfers only the electrons across the membrane while the NADH molecule remains behind"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is D because the observation to be explained is that the reducing power of cytosolic \(\text{NADH}\) reaches the electron transport chain while the labeled molecule itself never enters the matrix. That pattern is only consistent with a barrier that stops the whole molecule but not its electrons: the inner mitochondrial membrane is impermeable to \(\text{NADH}\), so a shuttle hands the electrons across and regenerates cytosolic \(\text{NAD}^+\) while the original \(\text{NADH}\) stays in the cytosol.

(Choice D) is correct: it matches both facts in the scenario — the molecule stays out (membrane impermeability) yet its electrons get in (a shuttle carries the reducing equivalents only).

(Choice A) is incorrect: if \(\text{NADH}\) freely diffused in and were re-oxidized inside, the labeled molecule would still be detected transiently in the matrix, contradicting the observation that it never appears there; the inner membrane is in fact impermeable to \(\text{NADH}\).

(Choice B) is incorrect: cytosolic \(\text{NADH}\) is not converted into a free \(\text{FADH}_2\) molecule that then diffuses across; \(\text{FADH}_2\) is enzyme-bound and also does not cross the membrane, so this invents a nonexistent mobile carrier.

(Choice C) is incorrect: the outer membrane is freely permeable to small molecules, and the barrier that matters here is the inner membrane; \(\text{NADH}\) does not pass through the inner membrane into the matrix and then dock onto Complex I from that side.

As a Skill 2 (reasoning about scientific concepts) item, the student must infer the need for an electron-only shuttle from the membrane-barrier evidence rather than recall the shuttle''s name.', 'easy', '1D', 'Oxidative Phosphorylation', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'NADH freely crosses inner membrane' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'NADH becomes a diffusible FADH2 carrier' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'confuses outer vs inner membrane barrier' FROM q;

-- Q69 [I2 · Electron Transport Chain: Shuttles & Inhibitors] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Electron Transport Chain: Shuttles & Inhibitors', 'In cardiac muscle, glycolytic reducing equivalents enter the mitochondrion via the malate-aspartate shuttle, which regenerates NADH inside the matrix. A researcher notes that each cytosolic NADH handled this way ultimately supports about 2.5 ATP — the same as a matrix NADH generated by the citric acid cycle. Why does routing the electrons through this shuttle preserve the full ~2.5 ATP yield per cytosolic NADH?', '[{"label": "A", "text": "Because the matrix NADH it produces donates electrons at Complex I, so they traverse all three proton-pumping complexes (I, III, and IV)"}, {"label": "B", "text": "Because the shuttle physically transports intact ATP molecules across the inner membrane along with the electrons"}, {"label": "C", "text": "Because matrix NADH delivers its electrons to coenzyme Q directly, skipping Complex I but still pumping the maximal number of protons"}, {"label": "D", "text": "Because the shuttle couples each NADH to Complex II, which pumps additional protons beyond those pumped by Complexes I, III, and IV"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is A because the ATP yield tracks how many proton-pumping complexes the electrons pass through. The malate-aspartate shuttle regenerates \(\text{NADH}\) in the matrix, and matrix \(\text{NADH}\) is oxidized by Complex I; its electrons therefore move through Complex I, then III, then IV — all three pumping complexes — building the full proton-motive force that supports about 2.5 ATP.

(Choice A) is correct: entry at Complex I means the electrons drive proton pumping at I, III, and IV, which is why the per-\(\text{NADH}\) yield equals that of a citric-acid-cycle \(\text{NADH}\).

(Choice B) is incorrect: the shuttle moves reducing equivalents, not intact ATP; ATP is synthesized later at ATP synthase from the proton gradient, not ferried across by the shuttle.

(Choice C) is incorrect: matrix \(\text{NADH}\) is oxidized AT Complex I, not downstream of it; electrons that skip Complex I (entering at coenzyme Q) pump fewer protons and give a lower yield, the opposite of what preserves 2.5 ATP.

(Choice D) is incorrect: Complex II does not pump protons at all, so coupling to Complex II could only lower the yield, and the shuttle does not feed Complex II in any case.

As a Skill 2 (reasoning about scientific concepts) item, the student must connect the entry point of the electrons to the number of pumping complexes traversed rather than recall a number.', 'medium', '1D', 'Oxidative Phosphorylation', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'shuttle carries intact ATP across membrane' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'matrix NADH enters at CoQ not Complex I' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'Complex II pumps protons' FROM q;

-- Q70 [I3 · Electron Transport Chain: Shuttles & Inhibitors] hard skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Electron Transport Chain: Shuttles & Inhibitors', 'In skeletal muscle, cytosolic NADH is handled by the glycerol-3-phosphate shuttle, which passes its electrons to an enzyme-bound FAD and delivers them into the chain at the level of coenzyme Q, downstream of Complex I. Each such cytosolic NADH ultimately supports only about 1.5 ATP rather than the ~2.5 ATP seen with the malate-aspartate shuttle. What is the mechanistic reason the glycerol-3-phosphate route yields less ATP per cytosolic NADH?', '[{"label": "A", "text": "The electrons are delivered to O2 at a different terminal acceptor that captures less free energy than water formation"}, {"label": "B", "text": "Entering at coenzyme Q bypasses Complex I, so the electrons drive proton pumping only at Complexes III and IV, not at all three of I, III, and IV"}, {"label": "C", "text": "The glycerol-3-phosphate shuttle consumes one ATP per NADH to move the electrons across the membrane, netting the cell less ATP"}, {"label": "D", "text": "FAD has a more negative reduction potential than NAD+, so electrons entering via FAD release less energy as they flow to O2"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is B because ATP yield depends on how many proton-pumping complexes the electrons traverse. By handing electrons to \(\text{FAD}\) and then to coenzyme Q — downstream of Complex I — the glycerol-3-phosphate shuttle skips one of the three pumping complexes. The electrons drive pumping only at Complexes III and IV, so fewer protons are translocated and the yield drops to about 1.5 ATP instead of 2.5.

(Choice B) is correct: bypassing Complex I removes one proton-pumping step, and the missing proton translocation is exactly what lowers the ATP produced per \(\text{NADH}\).

(Choice A) is incorrect: the terminal acceptor is still \(\text{O}_2\) reduced to water at Complex IV; the entry point changed, not the destination.

(Choice C) is incorrect: the reduced yield is not due to an ATP-consuming pumping step; the shuttle transfers electrons through redox reactions, and the deficit comes from skipping Complex I''s proton pumping, not from spending ATP.

(Choice D) is incorrect: this reverses the redox logic. In fact the \(\text{FAD}/\text{FADH}_2\) couple is LESS negative than \(\text{NAD}^+/\text{NADH}\), and a more negative potential would release more (not less) energy en route to \(\text{O}_2\). The lower yield comes from electrons entering the chain past Complex I, not from an intrinsic reduction-potential penalty of \(\text{FAD}\).

As a Skill 2 (reasoning about scientific concepts) item, the student must reason that a downstream entry point removes a pumping step, lowering the proton-motive force and thus the ATP yield.', 'hard', '1D', 'Oxidative Phosphorylation', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'different terminal acceptor than O2' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'shuttle spends ATP to pump electrons' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'misapplied FAD reduction-potential penalty' FROM q;

-- Q71 [I4 · Electron Transport Chain: Shuttles & Inhibitors] hard skill4 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Electron Transport Chain: Shuttles & Inhibitors', 'Complete oxidation of one glucose molecule generates 2 cytosolic NADH during glycolysis. A physiology student compares two tissues that differ only in which NADH shuttle they use. Using ~2.5 ATP per matrix-entering NADH (Complex I) and ~1.5 ATP per FAD-entering NADH (Complex II level), by how much does the total ATP per glucose differ between a tissue that sends both glycolytic NADH through the glycerol-3-phosphate shuttle and one that sends both through the malate-aspartate shuttle?', '[{"label": "A", "text": "1 ATP (≈31 versus ≈30)"}, {"label": "B", "text": "4 ATP (≈34 versus ≈30)"}, {"label": "C", "text": "2 ATP (≈32 for malate-aspartate versus ≈30 for glycerol-3-phosphate)"}, {"label": "D", "text": "0 ATP; the shuttle choice does not change the per-glucose total"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is C because the only variable is the two glycolytic \(\text{NADH}\). Each matrix-entering \(\text{NADH}\) (malate-aspartate) yields ~2.5 ATP, giving \(2 \times 2.5 = 5\) ATP; each \(\text{FAD}\)-entering \(\text{NADH}\) (glycerol-3-phosphate) yields ~1.5 ATP, giving \(2 \times 1.5 = 3\) ATP. The per-\(\text{NADH}\) difference is \(2.5 - 1.5 = 1.0\) ATP, and with two such \(\text{NADH}\) the totals differ by \(2 \times 1.0 = 2\) ATP, matching the familiar ~32 versus ~30 totals.

(Choice C) is correct: \(5 - 3 = 2\) ATP, the difference produced by routing two \(\text{NADH}\) through a shuttle that loses 1 ATP each relative to Complex I entry.

(Choice A) is incorrect: 1 ATP would result from only a single \(\text{NADH}\) differing, but glycolysis produces two cytosolic \(\text{NADH}\) per glucose, so the gap doubles to 2.

(Choice B) is incorrect: 4 ATP overcounts by assuming a 2-ATP penalty per \(\text{NADH}\) (as if the electrons skipped two pumping complexes); the actual penalty is ~1 ATP each because only Complex I is bypassed.

(Choice D) is incorrect: the shuttles differ in entry point (Complex I versus the Complex II level), so they yield different amounts of ATP; the choice of shuttle does change the total.

At the Skill 4 (data-based reasoning) level, the student must combine the two per-\(\text{NADH}\) yields with the count of glycolytic \(\text{NADH}\) to compute the difference rather than recall a memorized total.', 'hard', '1D', 'Oxidative Phosphorylation', 'biochemistry', 4, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'scale_unit_error', 'counts only one NADH instead of two' FROM q
  UNION ALL
  SELECT id, 'B', 'scale_unit_error', 'assumes 2-ATP penalty per NADH' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'shuttle choice is yield-neutral' FROM q;

-- Q72 [I5 · Electron Transport Chain: Shuttles & Inhibitors] hard skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Electron Transport Chain: Shuttles & Inhibitors', 'In an isolated mitochondrial preparation respiring on an NADH-linked substrate, a researcher adds antimycin A, which blocks Complex III. She then measures the redox state of the individual carriers and monitors O2 consumption. Which combination of results is expected immediately after the block?', '[{"label": "A", "text": "O2 consumption halts; carriers downstream of the block (cytochrome c, Complex IV) become fully reduced while NADH and coenzyme Q stay oxidized"}, {"label": "B", "text": "O2 consumption continues unchanged because Complex IV can still receive electrons directly from coenzyme Q, bypassing Complex III"}, {"label": "C", "text": "O2 consumption rises as electrons back up and are forced through Complex IV more rapidly, reducing all carriers simultaneously"}, {"label": "D", "text": "O2 consumption halts; carriers upstream of the block (NADH, Complex I, coenzyme Q) become fully reduced while cytochrome c and Complex IV stay oxidized"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is D because a block at Complex III cuts the chain in two. Electrons keep arriving from the NADH-linked substrate but cannot pass Complex III, so everything upstream — \(\text{NADH}\), Complex I, and coenzyme Q — accumulates in the reduced state. Nothing new reaches cytochrome c or Complex IV, so those downstream carriers give up their electrons to \(\text{O}_2\) and remain oxidized, and because no electrons reach Complex IV, \(\text{O}_2\) consumption stops.

(Choice D) is correct: upstream carriers back up (stay reduced) and downstream carriers stay oxidized, with \(\text{O}_2\) use halted — the signature of a mid-chain block.

(Choice A) is incorrect: it reverses the pattern. Carriers downstream of the block cannot be re-reduced because no electrons cross Complex III, so cytochrome c and Complex IV stay oxidized, not reduced.

(Choice B) is incorrect: coenzyme Q hands electrons to Complex III, not directly to Complex IV; there is no bypass, so respiration cannot continue.

(Choice C) is incorrect: with the chain severed, electrons cannot reach Complex IV at all, so \(\text{O}_2\) consumption falls to zero rather than rising, and downstream carriers stay oxidized.

As a Skill 2 (reasoning about scientific concepts) item, the student must reason from the location of the block to the redox state on each side and to the fate of \(\text{O}_2\) consumption.', 'hard', '1D', 'Oxidative Phosphorylation', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'reduced/oxidized sides flipped' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'CoQ bypasses Complex III to Complex IV' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'backup speeds up O2 use' FROM q;

-- Q73 [I6 · Electron Transport Chain: Shuttles & Inhibitors] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Electron Transport Chain: Shuttles & Inhibitors', 'Brown adipose tissue expresses thermogenin (UCP1), a channel that lets protons leak back across the inner mitochondrial membrane without passing through ATP synthase; the drug 2,4-dinitrophenol (DNP) does the same thing chemically. In a cell treated with such an agent, which set of consequences is expected?', '[{"label": "A", "text": "Electron transport and O2 consumption continue (even accelerate), but ATP synthesis falls and the released energy is dissipated as heat"}, {"label": "B", "text": "Electron transport stops because protons can no longer be pumped, so O2 consumption and ATP synthesis both cease"}, {"label": "C", "text": "ATP synthesis continues at the normal rate because the proton gradient is unaffected, but the cell overheats from excess electron flow"}, {"label": "D", "text": "O2 consumption falls while ATP synthesis rises, because the leaked protons are rerouted directly into ATP synthase"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is A because an uncoupler separates electron transport from ATP synthesis. Making the membrane leaky to protons collapses the gradient, so ATP synthase has little proton-motive force to work with and ATP output falls. But the pumps themselves are not blocked — in fact, with the gradient continually dissipated there is less backpressure, so electron transport and \(\text{O}_2\) consumption continue and can even speed up, and the energy that would have made ATP is released as heat.

(Choice A) is correct: uncoupling keeps electrons flowing to \(\text{O}_2\) while diverting the free energy into heat instead of ATP.

(Choice B) is incorrect: protons can still be pumped — the leak is a return path, not a block on the pumps — so electron transport and \(\text{O}_2\) consumption do not stop.

(Choice C) is incorrect: the whole point of an uncoupler is that the gradient IS dissipated; if the gradient were unaffected, ATP synthesis would proceed normally and no extra heat would be generated.

(Choice D) is incorrect: leaked protons bypass ATP synthase rather than being routed into it, so ATP synthesis falls, not rises, and \(\text{O}_2\) consumption increases rather than falling.

As a Skill 2 (reasoning about scientific concepts) item, the student must reason that dissipating the gradient uncouples respiration from phosphorylation, sustaining \(\text{O}_2\) use while producing heat instead of ATP.', 'hard', '1D', 'Oxidative Phosphorylation', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'uncoupler blocks the pumps' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'heat without gradient collapse' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'leaked protons boost ATP synthase' FROM q;

-- Q74 [I7 · Electron Transport Chain: Shuttles & Inhibitors] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Electron Transport Chain: Shuttles & Inhibitors', 'Two identical mitochondrial suspensions are respiring maximally. To the first, a researcher adds oligomycin, which blocks the proton channel of ATP synthase. To the second, she adds an uncoupler that makes the inner membrane leaky to protons. She measures O2 consumption in each. Which pattern of O2 consumption results, and why do the two agents affect respiration in opposite directions?', '[{"label": "A", "text": "Both agents lower O2 consumption, because each ultimately prevents ATP synthase from turning over and stops the chain from running"}, {"label": "B", "text": "Oligomycin lowers O2 consumption because the undischarged gradient exerts backpressure that stalls proton pumping, whereas the uncoupler raises it because dissipating the gradient removes that backpressure"}, {"label": "C", "text": "Oligomycin raises O2 consumption while the uncoupler lowers it, because blocking ATP synthase forces electrons through the chain faster"}, {"label": "D", "text": "Both agents raise O2 consumption, because interrupting normal ATP output always drives compensatory electron flow through the carriers"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is B because respiration rate depends on whether the proton gradient can discharge. Oligomycin blocks ATP synthase, so protons have nowhere to return; the gradient builds up and its backpressure opposes further pumping, slowing electron transport and lowering \(\text{O}_2\) consumption. An uncoupler provides an alternate return path, keeping the gradient low and removing backpressure, so the pumps run freely and \(\text{O}_2\) consumption rises. The two agents therefore move respiration in opposite directions.

(Choice B) is correct: it correctly links the undischarged gradient (backpressure) to reduced \(\text{O}_2\) use with oligomycin and the dissipated gradient (no backpressure) to increased \(\text{O}_2\) use with the uncoupler.

(Choice A) is incorrect: only oligomycin lowers \(\text{O}_2\) consumption; the uncoupler does not act through ATP synthase and actually raises respiration by dissipating the gradient.

(Choice C) is incorrect: it reverses both effects — oligomycin slows rather than speeds respiration (the gradient cannot discharge), and the uncoupler speeds rather than slows it.

(Choice D) is incorrect: oligomycin does not increase \(\text{O}_2\) consumption; its buildup of the gradient creates backpressure that decreases it, so the two agents are not equivalent.

As a Skill 2 (reasoning about scientific concepts) item, the student must reason from gradient backpressure to opposite respiratory outcomes rather than recall a fact.', 'medium', '1D', 'Oxidative Phosphorylation', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'uncoupler acts through ATP synthase' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'oligomycin speeds respiration' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'both agents raise O2 use' FROM q;

-- Q75 [I8 · Electron Transport Chain: Shuttles & Inhibitors] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Electron Transport Chain: Shuttles & Inhibitors', 'A tissue is exposed to cyanide, which blocks Complex IV and shuts down the electron transport chain. Within minutes, NADH and FADH2 accumulate because NAD+ and FAD are no longer being regenerated. Reasoning forward from this redox backup, what is the expected downstream effect on the cell''s central metabolism?', '[{"label": "A", "text": "The citric acid cycle accelerates to consume the excess NADH, boosting its dehydrogenase steps and raising ATP output to compensate for the blocked chain"}, {"label": "B", "text": "Glycolysis halts almost immediately because it relies on the electron transport chain to accept the electrons it strips from its substrates"}, {"label": "C", "text": "The citric acid cycle and pyruvate dehydrogenase stall for lack of NAD+/FAD, and the cell shifts to anaerobic glycolysis, using lactate dehydrogenase to regenerate NAD+"}, {"label": "D", "text": "Pyruvate dehydrogenase is allosterically activated by the high NADH, driving more acetyl-CoA into an accelerated citric acid cycle"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is C because the citric acid cycle and pyruvate dehydrogenase (PDH) require \(\text{NAD}^+\) and \(\text{FAD}\) as electron acceptors. When Complex IV is blocked, the chain cannot re-oxidize \(\text{NADH}\) and \(\text{FADH}_2\), so \(\text{NAD}^+/\text{FAD}\) run out and those oxidative pathways stall. To keep any ATP flowing, the cell falls back on anaerobic glycolysis, and lactate dehydrogenase reduces pyruvate to lactate specifically to regenerate cytosolic \(\text{NAD}^+\).

(Choice C) is correct: the redox backup starves the cycle and PDH of oxidized cofactors and forces the lactate-producing anaerobic route that regenerates \(\text{NAD}^+\).

(Choice A) is incorrect: the cycle cannot accelerate when its \(\text{NAD}^+\) and \(\text{FAD}\) acceptors are depleted; high \(\text{NADH}\) inhibits, not accelerates, the cycle.

(Choice B) is incorrect: glycolysis does not feed electrons directly to the chain; it can continue anaerobically as long as \(\text{NAD}^+\) is regenerated by lactate formation, which is exactly the fallback the cell uses.

(Choice D) is incorrect: high \(\text{NADH}\) inhibits PDH rather than activating it, so acetyl-CoA production slows rather than increasing.

As a Skill 2 (reasoning about scientific concepts) item, the student must trace the consequence from cofactor backup to the inhibition of oxidative pathways and the shift to lactate-producing glycolysis.', 'medium', '1D', 'Oxidative Phosphorylation', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'high NADH accelerates the cycle' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'glycolysis feeds ETC directly' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'high NADH activates PDH' FROM q;

-- Q76 [J1 · Oxidative Phosphorylation: ATP Synthase & Coupling] easy skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Oxidative Phosphorylation: ATP Synthase & Coupling', 'A well-fed cell has an intact electron transport chain, ample oxygen, and normal levels of ADP and inorganic phosphate. A mutation then arises in the membrane-embedded portion of ATP synthase that leaves its proton-conducting pathway permanently open, so protons flow through this channel back into the matrix without engaging the catalytic head. Assuming no other transporters or channels are altered, what is the most likely immediate consequence for the cell''s mitochondria?', '[{"label": "A", "text": "Oxygen consumption by the electron transport chain rises and ATP synthesis rises in parallel with it"}, {"label": "B", "text": "The electron transport chain halts because protons can no longer be pumped out of the matrix"}, {"label": "C", "text": "ATP synthesis continues at the normal rate because the catalytic head still binds ADP and phosphate"}, {"label": "D", "text": "Oxygen consumption by the electron transport chain rises while ATP synthesis falls, and heat is released"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is D because a permanently open proton channel that bypasses the catalytic head uncouples electron transport from ATP synthesis. Protons that the electron transport chain pumps into the intermembrane space now leak back through the defective channel without turning the catalytic machinery, so the proton-motive force is dissipated as heat rather than captured as \(\text{ATP}\). Because the gradient never builds up to oppose further pumping, respiratory control is lost and the chain speeds up: it consumes more \(\text{O}_2\) (the terminal electron acceptor) in an effort to rebuild the gradient. The result is high \(\text{O}_2\) consumption, low \(\text{ATP}\) output, and heat — the classic uncoupled state.

(Choice D) is correct: dissipating the gradient without doing phosphorylation work makes the electron transport chain run faster (more \(\text{O}_2\) used) while \(\text{ATP}\) synthesis drops and the energy exits as heat.
(Choice A) is incorrect: it wrongly assumes \(\text{O}_2\) use and \(\text{ATP}\) output stay coupled; the whole point of the leaky channel is that protons return without driving the catalytic head, so \(\text{ATP}\) synthesis falls even as respiration rises.
(Choice B) is incorrect: it reverses the effect on the chain. Collapsing the gradient removes the back-pressure that slows pumping, so the chain accelerates rather than halting; a chain halt would instead follow blocking a complex or removing \(\text{O}_2\).
(Choice C) is incorrect: even though the catalytic head is structurally intact, ATP synthesis requires proton flow to be routed through that head to drive its conformational cycle; when protons short-circuit past it, the head has no energy source and cannot phosphorylate \(\text{ADP}\) at the normal rate.

This item rewards Skill 2 reasoning: rather than recalling which fragment is the channel, you trace how a specific defect in proton coupling propagates through the chemiosmotic mechanism to predict the effects on respiration, ATP yield, and heat.', 'easy', '1D', 'Oxidative Phosphorylation', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'respiration and ATP stay coupled regardless' FROM q
  UNION ALL
  SELECT id, 'B', 'reversed_relationship', 'gradient collapse halts the chain instead of speeding it' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'intact catalytic head implies normal ATP output' FROM q;

-- Q77 [J2 · Oxidative Phosphorylation: ATP Synthase & Coupling] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Oxidative Phosphorylation: ATP Synthase & Coupling', 'In an experiment, mitochondria are supplied with abundant NADH, oxygen, ADP, and phosphate, and their electron transport chain and ATP synthase are both confirmed to be catalytically intact. An investigator then adds a lipophilic molecule that ferries protons freely across the inner membrane without passing through ATP synthase. ATP synthesis nearly stops even though every enzyme is undamaged. Which statement best explains why ATP output collapses under these conditions?', '[{"label": "A", "text": "The added molecule collapses the transmembrane proton gradient, the energy intermediate that ATP synthase depends on"}, {"label": "B", "text": "The added molecule chemically inactivates the F1 catalytic head, so ADP can no longer be phosphorylated"}, {"label": "C", "text": "The added molecule blocks electron flow at Complex IV, so no protons are ever pumped in the first place"}, {"label": "D", "text": "The added molecule depletes the pool of ADP available in the matrix, leaving no substrate for the phosphorylation reaction"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is A because the described molecule is an uncoupler: by shuttling \(\text{H}^+\) across the membrane outside of ATP synthase, it short-circuits and collapses the proton gradient. In chemiosmotic coupling the proton-motive force is the energy intermediate that carries energy from the electron transport chain to ATP synthase, so once the gradient is gone the intact synthase has no driving force and ATP synthesis stops — even though nothing has damaged the enzyme itself.

(Choice A) is correct: it identifies that eliminating the gradient (the energy carrier), not the enzyme, is what halts synthesis, which is exactly why an undamaged synthase can still fall idle.
(Choice B) is incorrect: the stem states both the ETC and ATP synthase remain catalytically intact, so the collapse cannot be attributed to inactivating \(F_1\).
(Choice C) is incorrect: a proton-ferrying uncoupler does not block electron transfer at Complex IV; electrons keep flowing (often faster), and protons are still pumped — they simply leak back without doing work.
(Choice D) is incorrect: the stem provides abundant ADP and phosphate, and a proton ionophore does not consume ADP, so substrate depletion is not the cause.

This item rewards Skill 2 reasoning: you must trace the causal chain of chemiosmotic coupling and recognize that destroying the gradient — the intermediate linking the ETC to the synthase — stops ATP synthesis without touching any enzyme.', 'medium', '1D', 'Oxidative Phosphorylation', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'attributes stop to enzyme damage' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'uncoupler treated as ETC blocker' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'invokes ADP substrate limit' FROM q;

-- Q78 [J3 · Oxidative Phosphorylation: ATP Synthase & Coupling] easy skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Oxidative Phosphorylation: ATP Synthase & Coupling', 'During active respiration, the electron transport chain has pumped protons out of the matrix so that their concentration is higher in the intermembrane space than in the matrix. When these protons subsequently pass through the F0 channel of ATP synthase to drive ATP formation, in which direction do they move and what is the energetic character of that movement?', '[{"label": "A", "text": "From the matrix into the intermembrane space, moving up their electrochemical gradient in an endergonic (energy-requiring) step"}, {"label": "B", "text": "From the intermembrane space into the matrix, moving down their electrochemical gradient in an exergonic (energy-releasing) step"}, {"label": "C", "text": "From the intermembrane space into the matrix, moving up their electrochemical gradient in an endergonic step that consumes ATP"}, {"label": "D", "text": "From the matrix into the intermembrane space, moving down their electrochemical gradient in an exergonic step"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is B because the stem states the protons were pumped out of the matrix and are now more concentrated in the intermembrane space; their return route through \(F_0\) must therefore run from that high-concentration compartment back into the matrix. Moving from high to low electrochemical potential means moving down their gradient, which is exergonic, and it is precisely this released free energy that pays for the endergonic phosphorylation of \(\text{ADP}\) to \(\text{ATP}\).

(Choice B) is correct: because the intermembrane space holds the higher \(\text{H}^+\) concentration, protons flow through \(F_0\) inward to the matrix, moving down their electrochemical gradient, and this downhill flux is exergonic (\(\Delta G < 0\)), supplying the energy that \(F_1\) uses to make \(\text{ATP}\).

(Choice A) is incorrect: it reverses both features. Protons do not travel from the matrix out to the intermembrane space through \(F_0\) (that outward, uphill movement is what the electron transport chain pumps perform, not the synthase), and their productive flow is downhill and exergonic, not uphill and endergonic.

(Choice C) is incorrect: although it gets the inward direction right, spontaneous downhill \(\text{H}^+\) flow releases free energy — it is exergonic, not an endergonic step, and it does not consume \(\text{ATP}\). The energy released by this flow is instead spent to synthesize \(\text{ATP}\).

(Choice D) is incorrect: it names the pumping direction (matrix to intermembrane space) rather than the return flow through ATP synthase. Movement in that outward direction would be up the gradient and endergonic; only the inward flow back into the matrix is the exergonic step that drives phosphorylation.

This question rewards Scientific Reasoning and Problem-Solving: you must reason from the described gradient (which compartment is high) to the direction of \(\text{H}^+\) flow through \(F_0\) and then to the sign of the free-energy change for that movement.', 'easy', '1D', 'Oxidative Phosphorylation', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'direction and energetics reversed' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'return flow consumes ATP' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'confuses pumping with return flow' FROM q;

-- Q79 [J4 · Oxidative Phosphorylation: ATP Synthase & Coupling] hard skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Oxidative Phosphorylation: ATP Synthase & Coupling', 'In the rotational (conformational) coupling model, protons flowing through F0 do not donate a phosphate to ADP directly. Instead, their passage turns a rotor, and this rotation is transmitted to the catalytic subunits of F1, cycling each active site through different shapes. Which description best captures how the energy of proton flow is ultimately stored in the phosphoanhydride bond of ATP under this model?', '[{"label": "A", "text": "A proton is transferred directly onto the terminal phosphate of ADP as it crosses F0, forming the new bond in a single chemical step"}, {"label": "B", "text": "The proton gradient is first converted into a high-energy phosphorylated enzyme intermediate, which then hands its phosphate to ADP"}, {"label": "C", "text": "Mechanical rotation drives sequential conformational changes in the F1 catalytic sites, and it is these shape changes that promote ATP formation and its release from the enzyme"}, {"label": "D", "text": "Proton flow heats the F1 head, and the resulting thermal energy is captured directly to condense ADP and phosphate"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is C because the coupling in this model is indirect and mechanical: proton flow through \(F_0\) spins a rotor, that rotation forces the \(F_1\) catalytic sites to cycle through distinct conformations, and it is the conformational changes themselves that favor formation of the \(\text{ATP}\) phosphoanhydride bond and its release. Energy is transduced motion-first (like a turbine), then converted to chemical bond energy through changing enzyme geometry, rather than by any direct chemical hand-off of a proton to ADP.

(Choice C) is correct: it names the two-step indirect transduction — rotation producing conformational changes in \(F_1\) that drive ATP formation and release — which is the essence of the rotational/turbine model.
(Choice A) is incorrect: it describes a direct chemical coupling in which a proton itself is placed onto ADP, contradicting the stem''s statement that protons do not donate phosphate directly.
(Choice B) is incorrect: a covalent phosphoenzyme intermediate is the hallmark of certain substrate-level or transport ATPase chemistries, not of the rotational mechanism, which stores energy in enzyme conformation rather than in a phosphorylated enzyme.
(Choice D) is incorrect: the model transduces mechanical rotation, not heat; capturing random thermal energy to build a specific bond would violate the directed, mechanochemical logic of the turbine model.

This item rewards Skill 2 reasoning: you must connect an abstract mechanism (rotation to conformational change) to an energetic outcome (bond formation), recognizing the coupling as indirect and mechanical rather than a direct chemical transfer.', 'hard', '1D', 'Oxidative Phosphorylation', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'direct proton-to-ADP transfer' FROM q
  UNION ALL
  SELECT id, 'B', 'adjacent_fact', 'phosphoenzyme intermediate imported' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'thermal energy drives synthesis' FROM q;

-- Q80 [J5 · Oxidative Phosphorylation: ATP Synthase & Coupling] hard skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Oxidative Phosphorylation: ATP Synthase & Coupling', 'In substrate-level phosphorylation (for example, at phosphoglycerate kinase), a phosphate group is transferred straight from a high-energy substrate onto ADP in a single enzyme-catalyzed step. Oxidative phosphorylation is instead classified as an indirect mechanism. Which statement best explains what makes oxidative phosphorylation indirect compared with substrate-level phosphorylation?', '[{"label": "A", "text": "A high-energy phosphorylated substrate hands its phosphate straight to ADP in one step, and the only added requirement is that molecular oxygen be present for the reaction"}, {"label": "B", "text": "Electrons from the chain are delivered directly onto ADP, and it is this reduction of ADP itself that creates the new phosphoanhydride bond of ATP"}, {"label": "C", "text": "ATP synthase pulls a phosphate straight off NADH and passes it to ADP, with no proton gradient or other energy carrier interposed in between"}, {"label": "D", "text": "Electron-transfer energy is first stored in a transmembrane proton gradient, and that gradient alone — not any phosphorylated substrate — drives the phosphorylation of ADP"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is D because ''indirect'' refers to an interposed energy intermediate. In substrate-level phosphorylation a phosphoryl group passes directly from a high-energy donor to \(\text{ADP}\). In oxidative phosphorylation, by contrast, the free energy released as electrons fall down the chain is first captured in the form of a proton gradient (the proton-motive force) across the inner membrane; ATP synthase then uses that stored gradient — not any phosphorylated substrate — to make \(\text{ATP}\). The gradient is the go-between that makes the coupling indirect.

(Choice D) is correct: it identifies the transmembrane proton gradient as the interposed store of energy that powers phosphorylation of \(\text{ADP}\), which is exactly what distinguishes the indirect, gradient-mediated mechanism from a direct phosphoryl transfer.
(Choice A) is incorrect: it actually describes direct (substrate-level) phosphorylation and merely adds an oxygen requirement, so it does not capture the indirect, gradient-mediated nature of oxidative phosphorylation.
(Choice B) is incorrect: \(\text{ADP}\) is not reduced by electrons; phosphorylation forms a phosphoanhydride bond from \(\text{ADP} + \text{P}_\text{i}\) and is not an electron-transfer (redox) event onto \(\text{ADP}\).
(Choice C) is incorrect: ATP synthase does not take a phosphate from \(\text{NADH}\); \(\text{NADH}\) donates electrons to the chain, no phosphate is ever transferred from \(\text{NADH}\) to \(\text{ADP}\), and denying any interposed carrier is the opposite of the indirect, gradient-mediated mechanism.

This item rewards Skill 2 reasoning: you must contrast two mechanisms and reason about what the proton gradient accomplishes, recognizing that an interposed energy carrier is what makes oxidative phosphorylation indirect.', 'hard', '1D', 'Oxidative Phosphorylation', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'partial_truth', 'describes direct transfer plus O2' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'ADP reduced by electrons' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'phosphate taken from NADH' FROM q;

-- Q81 [J6 · Oxidative Phosphorylation: ATP Synthase & Coupling] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Oxidative Phosphorylation: ATP Synthase & Coupling', 'A tightly coupled mitochondrion is oxidizing NADH with a large proton-motive force established across its inner membrane. Every ATP made by ATP synthase in the matrix must be exported to the cytosol by the adenine-nucleotide translocase, which swaps one matrix ATP (net charge about -4) for one cytosolic ADP (net charge about -3), while the phosphate carrier brings in each phosphate as part of a symport that depends on the same gradient. A student argues that the ATP delivered to the cytosol per NADH should exactly equal the number of ATP the synthase''s H+/ATP stoichiometry allows. What is the best reason the net cytosolic yield is instead slightly lower than that theoretical maximum?', '[{"label": "A", "text": "The exchange of the more-negative ATP for the less-negative ADP is driven by the membrane voltage, so exporting ATP and importing Pi spends part of the same proton-motive force that would otherwise drive the synthase"}, {"label": "B", "text": "The translocase and phosphate carrier hydrolyze one ATP each per transport cycle, directly consuming the synthase''s product before it reaches the cytosol"}, {"label": "C", "text": "Exporting ATP raises the matrix ATP concentration until product inhibition shuts the synthase down, so fewer ATP are ever synthesized in the first place"}, {"label": "D", "text": "Transporting the nucleotides makes the inner membrane leaky to protons, collapsing the gradient the way an uncoupler would"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is A because getting the finished ATP out to the cytosol is not free: the adenine-nucleotide translocase exchanges a matrix \(\text{ATP}^{4-}\) for a cytosolic \(\text{ADP}^{3-}\), a net movement of one negative charge outward that is favored by the membrane potential (matrix negative), and the phosphate carrier imports \(\text{P}_\text{i}\) in a manner that draws on the pH/proton component of the same gradient. Every unit of proton-motive force spent moving substrates and products across the membrane is force no longer available to push protons through \(F_0\). So even with the H+/ATP stoichiometry fixed, the proton budget is shared between synthesis and transport, and the net ATP delivered to the cytosol falls slightly below the theoretical maximum.

(Choice A) is correct: it identifies the transport of ADP, ATP, and \(\text{P}_\text{i}\) as an additional draw on the proton-motive force, which is exactly why the practical yield (about 30-32 ATP/glucose) sits below the value predicted from synthase stoichiometry alone.
(Choice B) is incorrect: the translocase and phosphate carrier are gradient-driven secondary transporters, not ATP-hydrolyzing pumps; they do not burn ATP per cycle, so this misnames the mechanism of the loss.
(Choice C) is incorrect: the loss is not product inhibition of the synthase. Export in fact keeps matrix ATP low and thereby sustains synthesis; the shortfall comes from spending gradient on transport, not from shutting the enzyme down.
(Choice D) is incorrect: carrier-mediated transport moves specific solutes through dedicated proteins and does not make the bilayer nonspecifically proton-permeable; equating it with an uncoupler confuses a coupled transport cost with a gradient-destroying leak.

This item rewards Skill 2 reasoning: you must trace how a downstream transport step draws on the shared proton-motive force to explain why measured cytosolic ATP yield is lower than the synthase''s stoichiometry alone would predict, rather than recalling a stated ATP count.', 'medium', '1D', 'Oxidative Phosphorylation', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'carrier framed as ATP-hydrolyzing pump' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'loss blamed on synthase product inhibition' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'coupled transport conflated with uncoupler leak' FROM q;

-- Q82 [J7 · Oxidative Phosphorylation: ATP Synthase & Coupling] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Oxidative Phosphorylation: ATP Synthase & Coupling', 'In tightly coupled mitochondria respiring on NADH with plenty of O2, an investigator adds oligomycin, a drug that binds ATP synthase and blocks proton passage through its F0 channel. Within seconds the rate of oxygen consumption by the electron transport chain drops sharply, even though the drug touches no electron-transport-chain complex. Which reasoning best accounts for this slowing of electron transport?', '[{"label": "A", "text": "Oligomycin has a second target at Complex IV, where it directly halts the transfer of electrons to oxygen and thereby stops the chain"}, {"label": "B", "text": "The blocked synthase leaves protons no route back to the matrix, so the gradient steepens until its backpressure opposes further pumping and electron flow slows"}, {"label": "C", "text": "With protons trapped, the matrix pH falls sharply, and this acidic matrix directly oxidizes NADH before Complex I can accept its electrons"}, {"label": "D", "text": "With the synthase blocked, ADP is consumed faster and its level falls, and a lower ADP level speeds rather than slows electron transport"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is B because in coupled mitochondria the electron transport chain and ATP synthase are linked through the shared proton gradient. When oligomycin plugs the F0 channel, protons have no route back to the matrix, so the proton-motive force grows. Pumping still more protons against this steepening gradient becomes energetically harder (backpressure), and because pumping is obligatorily coupled to electron transfer, the whole chain — and thus \(\text{O}_2\) consumption — slows. This is classic respiratory control: no ETC complex was inhibited by the drug; the coupling itself throttles respiration, and adding an uncoupler would restore fast electron flow.

(Choice B) is correct: it traces the linkage — blocked return of protons, rising gradient, backpressure opposing further pumping — so electron flow slows through coupling rather than through direct inhibition.
(Choice A) is incorrect: oligomycin is specific to ATP synthase and does not bind Complex IV, so the slowing is not a direct block of electron transfer to oxygen.
(Choice C) is incorrect: proton pumping raises \(\text{H}^+\) in the intermembrane space, not the matrix, and NADH is oxidized enzymatically by Complex I, not by matrix acidity, so this mechanism is fabricated.
(Choice D) is incorrect: blocking the synthase halts ATP synthesis, so ADP is not consumed and does not fall; moreover, under respiratory control a falling ADP level would slow, not speed, respiration, so both the fact and the direction are wrong.

This item rewards Skill 2 reasoning: you must reason across the coupling relationship, recognizing that impairing ATP synthase feeds back through the gradient to constrain electron transport.', 'medium', '1D', 'Oxidative Phosphorylation', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'adjacent_fact', 'oligomycin miscast as ETC inhibitor' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'matrix acidity oxidizes NADH' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'ADP effect and direction reversed' FROM q;

-- Q83 [J8 · Oxidative Phosphorylation: ATP Synthase & Coupling] hard skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Oxidative Phosphorylation: ATP Synthase & Coupling', 'ATP synthase is thermodynamically reversible: the direction it runs depends on the balance between the proton-motive force (favoring ATP synthesis as protons flow inward) and the phosphorylation potential (the tendency of accumulated ATP to be hydrolyzed). In which scenario would the enzyme most likely run in reverse — hydrolyzing ATP to pump protons out of the matrix?', '[{"label": "A", "text": "The proton gradient is steep and ATP is low relative to ADP and phosphate, so the proton-motive force greatly exceeds the phosphorylation potential"}, {"label": "B", "text": "Both the proton gradient and the ATP/ADP ratio are simultaneously at their maximum possible values, so the two opposing potentials perfectly balance"}, {"label": "C", "text": "The proton gradient has largely collapsed while ATP stays high relative to ADP and phosphate, so the phosphorylation potential exceeds the proton-motive force"}, {"label": "D", "text": "The membrane is fully impermeable and O2 is abundant, giving a large steep gradient that drives rapid forward ATP synthesis"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is C because the direction of the reversible enzyme is set by which force wins. The proton-motive force pushes the reaction toward synthesis (protons in, ATP made); the phosphorylation potential pushes toward hydrolysis. When the gradient collapses yet ATP stays high relative to \(\text{ADP}\) and \(P_i\), the phosphorylation potential exceeds the (now weak) proton-motive force, so the enzyme runs backward — hydrolyzing \(\text{ATP}\) to pump \(\text{H}^+\) outward in an attempt to rebuild the gradient.

(Choice C) is correct: a weak gradient combined with high ATP tilts the balance toward hydrolysis, which is exactly the condition that reverses the enzyme.
(Choice A) is incorrect: a steep gradient with low ATP is the classic forward-synthesis condition; here the proton-motive force dominates, so the enzyme makes ATP rather than hydrolyzing it.
(Choice B) is incorrect: if the two potentials perfectly balance, there is no net drive in either direction, so the enzyme would not run appreciably in reverse.
(Choice D) is incorrect: a large gradient with abundant O2 drives brisk forward synthesis, the opposite of the reverse (hydrolytic, proton-pumping) mode.

This item rewards Skill 2 reasoning: you must weigh two opposing thermodynamic drives and reason about which set of conditions flips the net direction of a reversible enzyme.', 'hard', '1D', 'Oxidative Phosphorylation', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'forward condition chosen for reverse' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'balanced potentials cause reversal' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'healthy forward synthesis' FROM q;

-- Q84 [J9 · Oxidative Phosphorylation: ATP Synthase & Coupling] hard skill4 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Oxidative Phosphorylation: ATP Synthase & Coupling', 'In a reconstituted vesicle system, ATP synthase requires 4 protons to translocate through F0 for each ATP it synthesizes. During one experimental interval, the electron transport chain pumps a total of 480 protons into the intermembrane space, and every one of those protons ultimately returns to the matrix through ATP synthase (no leak). Assuming the gradient is fully used for phosphorylation, how many ATP molecules can this system synthesize during the interval?', '[{"label": "A", "text": "480 ATP"}, {"label": "B", "text": "1,920 ATP"}, {"label": "C", "text": "124 ATP"}, {"label": "D", "text": "120 ATP"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is D because the yield is the number of translocated protons divided by the proton cost per ATP. With a stoichiometry of 4 \(\text{H}^+\) per \(\text{ATP}\) and 480 protons returning through the synthase, \(480 \div 4 = 120\) ATP molecules can be made.

(Choice D) is correct: dividing the 480 available protons by the 4-proton cost of each ATP gives 120 ATP.
(Choice A) is incorrect: 480 treats each proton as producing one ATP (a 1:1 ratio), ignoring that four protons are needed per ATP.
(Choice B) is incorrect: \(480 \times 4 = 1{,}920\) multiplies by the proton cost instead of dividing, inverting the ratio.
(Choice C) is incorrect: 124 comes from adding \(120 + 4\) rather than performing the division, mishandling the stoichiometric relationship.

This item rewards Skill 4 reasoning: you must derive the ATP yield from a given proton-to-ATP stoichiometry and a proton count, applying the correct ratio rather than recalling a number.', 'hard', '1D', 'Oxidative Phosphorylation', 'biochemistry', 4, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'assumes 1 H+ per ATP' FROM q
  UNION ALL
  SELECT id, 'B', 'reversed_relationship', 'multiplies instead of divides' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'adds ratio instead of dividing' FROM q;

-- Q85 [K1 · Oxidative Phosphorylation: Regulation] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Oxidative Phosphorylation: Regulation', 'An isolated preparation of respiring mitochondria is supplied with saturating O\(_2\), unlimited inorganic phosphate (P\(_\text{i}\)), and an oxidizable substrate that keeps NADH plentiful. A researcher then injects a large bolus of \(\text{ADP}\), raising its concentration well above the physiological resting level. Assuming the machinery is well-coupled, how should the rate of O\(_2\) consumption and the rate of \(\text{ATP}\) synthesis respond over the next several seconds?', '[{"label": "A", "text": "Both O\\(_2\\) consumption and \\(\\text{ATP}\\) synthesis accelerate together"}, {"label": "B", "text": "O\\(_2\\) consumption accelerates while \\(\\text{ATP}\\) synthesis falls"}, {"label": "C", "text": "Both O\\(_2\\) consumption and \\(\\text{ATP}\\) synthesis slow"}, {"label": "D", "text": "Both rates are unchanged because O\\(_2\\) and substrate are already saturating"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is A because, when O\(_2\), P\(_\text{i}\), and reducing equivalents are all in excess, the one remaining variable that limits oxidative phosphorylation is the supply of \(\text{ADP}\); a large \(\text{ADP}\) bolus removes that limitation, so \(\text{ATP}\) synthase runs faster, protons flood back into the matrix, the gradient is drawn down, the electron transport chain speeds up to rebuild it, and O\(_2\) consumption rises in lockstep with \(\text{ATP}\) output. This coupling of substrate-oxidation rate to \(\text{ADP}\) availability is respiratory control.

(Choice A) is correct: because the system is well-coupled, faster proton re-entry through \(F_0\) (more \(\text{ATP}\) made) is paid for by faster electron flow to O\(_2\), so the two rates rise together.

(Choice B) is incorrect: it separates electron flow from phosphorylation, which is what an uncoupler would do; in a well-coupled, non-leaky membrane the extra O\(_2\) consumed is precisely what drives the extra \(\text{ATP}\), so \(\text{ATP}\) synthesis cannot fall while O\(_2\) use climbs.

(Choice C) is incorrect: slowing would follow from removing \(\text{ADP}\) (high energy charge), not from adding it; raising \(\text{ADP}\) signals demand and speeds, rather than slows, oxphos.

(Choice D) is incorrect: saturating O\(_2\) and substrate are necessary but not sufficient for maximal flux — with little \(\text{ADP}\) the rate stays low, so adding \(\text{ADP}\) does change the rate rather than leaving it fixed.

This is a Scientific Reasoning and Problem Solving question because you must apply the principle of respiratory control to predict how flux responds when the rate-limiting substrate \(\text{ADP}\) is supplied.', 'medium', '1D', 'Oxidative Phosphorylation', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'treats coupled system as uncoupled' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'ADP addition read as slowing signal' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'substrate saturation mistaken for max flux' FROM q;

-- Q86 [K2 · Oxidative Phosphorylation: Regulation] easy skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Oxidative Phosphorylation: Regulation', 'A resting muscle cell has hydrolyzed very little \(\text{ATP}\) recently, so its \(\text{ATP}\) concentration is high and its \(\text{ADP}\) concentration is very low (a high energy charge). Given only this information about the cell''s energy state, what is the expected effect on the rate of oxidative phosphorylation?', '[{"label": "A", "text": "It runs faster, because abundant \\(\\text{ATP}\\) fuels the electron transport chain"}, {"label": "B", "text": "It slows, because the scarcity of \\(\\text{ADP}\\) limits \\(\\text{ATP}\\) synthase"}, {"label": "C", "text": "It is unaffected, because energy charge governs glycolysis but not oxphos"}, {"label": "D", "text": "It slows, because high \\(\\text{ATP}\\) directly blocks the flow of electrons to O\\(_2\\)"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is B because \(\text{ATP}\) synthase needs \(\text{ADP}\) (with P\(_\text{i}\)) as its substrate; when the energy charge is high, \(\text{ADP}\) is scarce, so the synthase has little to phosphorylate. With phosphorylation slowed, protons stop being returned to the matrix through \(F_0\), the gradient builds up and opposes further pumping, and the electron transport chain (and the citric acid cycle feeding it) backs up. Thus a high \(\text{ATP}\)/low \(\text{ADP}\) state slows oxidative phosphorylation.

(Choice B) is correct: \(\text{ADP}\) availability is the rate-governing input for oxphos, so its scarcity throttles the whole pathway.

(Choice A) is incorrect: \(\text{ATP}\) is the product, not a fuel for the chain, and abundant product signals that no more is needed; high \(\text{ATP}\) is associated with slowing, not speeding.

(Choice C) is incorrect: energy charge regulates oxidative phosphorylation directly through \(\text{ADP}\) supply, not only glycolysis, so oxphos is very much affected.

(Choice D) is incorrect: the slowdown is driven by lack of \(\text{ADP}\) substrate and by the built-up proton gradient opposing pumping, not by \(\text{ATP}\) acting as a direct chemical blocker of electron flow to O\(_2\); it names a plausible-sounding but wrong mechanism for a correct direction.

This is a Scientific Reasoning and Problem Solving question because you must reason from the cell''s energy charge to the resulting rate of oxidative phosphorylation.', 'easy', '1D', 'Oxidative Phosphorylation', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'ATP treated as ETC fuel' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'energy charge limited to glycolysis' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'right direction, wrong mechanism' FROM q;

-- Q87 [K3 · Oxidative Phosphorylation: Regulation] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Oxidative Phosphorylation: Regulation', 'During intense exercise, a region of muscle becomes hypoxic: O\(_2\) delivery to its mitochondria drops well below what oxidative phosphorylation demands, even though \(\text{ADP}\) is plentiful. As oxidative phosphorylation slows because O\(_2\) is the terminal electron acceptor, what is the most direct upstream consequence for the citric acid (TCA) cycle in these mitochondria?', '[{"label": "A", "text": "The TCA cycle accelerates as electron carriers are freed up"}, {"label": "B", "text": "The TCA cycle is unaffected, because it does not depend on O\\(_2\\)"}, {"label": "C", "text": "The TCA cycle slows, because NADH accumulates and inhibits it"}, {"label": "D", "text": "The TCA cycle slows, because ADP is consumed and can no longer activate it"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is C because O\(_2\) is the final electron acceptor of the chain; when it becomes limiting, electrons cannot be offloaded, the chain cannot re-oxidize its carriers, and \(\text{NADH}\) (and \(\text{FADH}_2\)) pile up. That accumulated \(\text{NADH}\) is a product-inhibitor of the \(\text{NAD}^+\)-dependent dehydrogenases of the TCA cycle, so a high \(\text{NADH}/\text{NAD}^+\) ratio slows the cycle. This transmission of an O\(_2\) shortage backward onto the TCA cycle is respiratory control.

(Choice C) is correct: the reduced carriers cannot be regenerated without O\(_2\), so \(\text{NADH}\) builds up and feedback-inhibits the cycle that produced it.

(Choice A) is incorrect: it assumes carriers are freed up, but low O\(_2\) does the opposite — carriers stay reduced (\(\text{NADH}\) rises) and \(\text{NAD}^+\) becomes scarce, so the cycle slows rather than accelerates.

(Choice B) is incorrect: although the TCA cycle uses no O\(_2\) in its own reactions, it depends on the chain to regenerate \(\text{NAD}^+\); losing O\(_2\) starves it of oxidized carrier and therefore does affect it.

(Choice D) is incorrect: the scenario states \(\text{ADP}\) is plentiful, so a loss of \(\text{ADP}\)-mediated activation is not the operative cause; the direct upstream signal here is \(\text{NADH}\) accumulation from the stalled chain.

This is a Scientific Reasoning and Problem Solving question because you must trace how an O\(_2\) limitation propagates upstream through the accumulation of \(\text{NADH}\) to the TCA cycle.', 'medium', '1D', 'Oxidative Phosphorylation', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'carriers wrongly freed, cycle speeds' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'TCA seen as O2-independent' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'ADP-activation cause despite plentiful ADP' FROM q;

-- Q88 [K4 · Oxidative Phosphorylation: Regulation] hard skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Oxidative Phosphorylation: Regulation', 'When a cell''s \(\text{ATP}\) demand suddenly rises, its \(\text{ADP}\) level climbs. For oxidative phosphorylation to actually run faster, the electron transport chain must be fed more \(\text{NADH}\), yet a higher demand alone does not create reducing equivalents. \(\text{ADP}\) resolves this by allosterically activating isocitrate dehydrogenase in the TCA cycle. How does this allosteric action let supply rise to meet demand?', '[{"label": "A", "text": "\\(\\text{ADP}\\) binds \\(\\text{ATP}\\) synthase directly, forcing it to spin faster independently of any change in \\(\\text{NADH}\\) supply"}, {"label": "B", "text": "\\(\\text{ADP}\\) inhibits isocitrate dehydrogenase, sparing citrate so it can be exported and later oxidized for more \\(\\text{NADH}\\)"}, {"label": "C", "text": "\\(\\text{ADP}\\) enlarges the proton gradient, and the larger gradient is what raises \\(\\text{NADH}\\) production in the matrix"}, {"label": "D", "text": "\\(\\text{ADP}\\) speeds the TCA cycle, generating more \\(\\text{NADH}\\) to feed the chain, so electron flow and \\(\\text{ATP}\\) synthesis rise together"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is D because the demand signal (rising \(\text{ADP}\)) and the supply pathway are linked through isocitrate dehydrogenase: \(\text{ADP}\) is a positive allosteric effector of that enzyme, so raising \(\text{ADP}\) accelerates the TCA cycle, which produces more \(\text{NADH}\) and \(\text{FADH}_2\). Those extra reduced carriers feed the electron transport chain, so proton pumping and O\(_2\) reduction speed up at the same time that \(\text{ATP}\) synthase — now well-supplied with \(\text{ADP}\) — runs faster. Supply and demand therefore rise in concert.

(Choice D) is correct: \(\text{ADP}\) recruits supply by activating a supply-limiting TCA enzyme, so more \(\text{NADH}\) reaches the chain exactly when more \(\text{ATP}\) is being made.

(Choice A) is incorrect: while \(\text{ADP}\) is indeed the synthase''s substrate, this choice ignores the stem''s point — that faster synthase demands more \(\text{NADH}\) supply; the chain cannot sustain higher flux without the reducing equivalents that \(\text{ADP}\)-activated isocitrate dehydrogenase provides.

(Choice B) is incorrect: it reverses the regulation — \(\text{ADP}\) activates, not inhibits, isocitrate dehydrogenase; inhibiting it would cut \(\text{NADH}\) supply and slow, not speed, oxphos.

(Choice C) is incorrect: enlarging the proton gradient does not create \(\text{NADH}\); in fact a larger gradient opposes further pumping and would slow the chain, so it cannot be the mechanism that raises \(\text{NADH}\) supply.

This is a Scientific Reasoning and Problem Solving question because you must reason about how a demand signal (\(\text{ADP}\)) recruits matching substrate supply through allosteric regulation.', 'hard', '1D', 'Oxidative Phosphorylation', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'partial_truth', 'ADP as synthase substrate ignores supply need' FROM q
  UNION ALL
  SELECT id, 'B', 'reversed_relationship', 'ADP inhibits rather than activates IDH' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'gradient size conflated with NADH production' FROM q;

-- Q89 [K5 · Oxidative Phosphorylation: Regulation] hard skill4 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Oxidative Phosphorylation: Regulation', 'In an oxygen-electrode experiment on isolated mitochondria, the trace shows O\(_2\) in the chamber declining. With substrate present but no added \(\text{ADP}\), O\(_2\) falls only slowly. The moment a measured pulse of \(\text{ADP}\) is injected, the trace steepens sharply (rapid O\(_2\) consumption); after a fixed interval the slope abruptly returns to the original slow rate, and a second \(\text{ADP}\) pulse reproduces the same burst. What do these features indicate about the mitochondria?', '[{"label": "A", "text": "The mitochondria are well-coupled: O\\(_2\\) consumption is under respiratory control, fast only while added \\(\\text{ADP}\\) lasts"}, {"label": "B", "text": "The mitochondria are uncoupled: O\\(_2\\) consumption stays maximal regardless of \\(\\text{ADP}\\)"}, {"label": "C", "text": "The substrate is exhausted after each pulse, which is why the fast phase ends"}, {"label": "D", "text": "\\(\\text{ATP}\\) synthase is inhibited, so \\(\\text{ADP}\\) drives O\\(_2\\) consumption only by leaking across the membrane"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is A because the trace shows the defining signature of respiratory control in coupled mitochondria: a slow basal O\(_2\) draw when \(\text{ADP}\) is absent (State 4), a sharp acceleration on adding \(\text{ADP}\) (State 3), and a return to the slow rate exactly when that \(\text{ADP}\) has been phosphorylated to \(\text{ATP}\) and run out. That the burst is reproduced by a second \(\text{ADP}\) pulse — with substrate still present — pins the fast phase to \(\text{ADP}\) availability, not to substrate. Only a coupled system ties O\(_2\) consumption to \(\text{ADP}\) this way.

(Choice A) is correct: the \(\text{ADP}\)-triggered burst that stops when \(\text{ADP}\) is used up is precisely respiratory control in well-coupled mitochondria.

(Choice B) is incorrect: an uncoupled preparation would consume O\(_2\) rapidly and continuously whether or not \(\text{ADP}\) is present, so it would not show a slow basal phase or an \(\text{ADP}\)-dependent burst.

(Choice C) is incorrect: if substrate exhaustion ended the fast phase, a second \(\text{ADP}\) pulse could not reproduce the burst; the reproducibility shows substrate remains and \(\text{ADP}\), not substrate, is limiting.

(Choice D) is incorrect: if \(\text{ATP}\) synthase were inhibited, adding \(\text{ADP}\) would not accelerate O\(_2\) consumption at all, because coupled O\(_2\) use requires proton return through the synthase; the strong \(\text{ADP}\) response argues the synthase is active, not blocked.

This is a Data-Based and Statistical Reasoning question because you must infer the coupled, respiratory-control state of the mitochondria from the shape and \(\text{ADP}\)-dependence of the O\(_2\) trace.', 'hard', '1D', 'Oxidative Phosphorylation', 'biochemistry', 4, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'coupled trace read as uncoupled' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'substrate exhaustion vs ADP depletion' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'synthase inhibition contradicts ADP burst' FROM q;

-- Q90 [K6 · Oxidative Phosphorylation: Regulation] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Oxidative Phosphorylation: Regulation', 'In a tightly coupled mitochondrial suspension oxidizing a substrate that feeds electrons into Complex I, careful measurement gives a P/O ratio (mol \(\text{ATP}\) synthesized per mol O atoms reduced, i.e., per \(\tfrac{1}{2}\,\text{O}_2\)) of about 2.5. A chemical uncoupler is then titrated in, and O\(_2\) consumption is measured to actually rise. If the suspension is given a fixed, limited amount of the same substrate and allowed to oxidize all of it in both conditions, how does adding the uncoupler change the total O\(_2\) consumed and the measured P/O ratio for that substrate?', '[{"label": "A", "text": "Total O\\(_2\\) consumed rises and the P/O ratio rises above 2.5, since faster respiration makes more \\(\\text{ATP}\\)"}, {"label": "B", "text": "Total O\\(_2\\) consumed stays about the same, but the P/O ratio falls toward zero"}, {"label": "C", "text": "Total O\\(_2\\) consumed falls and the P/O ratio stays near 2.5, because \\(\\text{ATP}\\) synthesis still gates electron flow"}, {"label": "D", "text": "Total O\\(_2\\) consumed rises and the P/O ratio stays near 2.5, since each pair of electrons still reduces the same amount of O\\(_2\\)"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is B because the P/O ratio counts \(\text{ATP}\) made per O atom reduced, so it measures how efficiently electron flow is captured as \(\text{ATP}\). A fixed amount of substrate carries a fixed number of electrons, and those electrons must ultimately be handed to O\(_2\) at Complex IV regardless of coupling; therefore the total O\(_2\) consumed to oxidize all of the substrate is essentially unchanged (the same electrons need the same terminal acceptor). What the uncoupler changes is the numerator: protons now leak back to the matrix instead of passing through \(\text{ATP}\) synthase, so almost no \(\text{ATP}\) is made per O consumed. With the numerator collapsing while the denominator holds, the P/O ratio falls toward zero even though the substrate is fully oxidized.

(Choice B) is correct: oxidizing the same electron-carrying substrate reduces the same total O\(_2\), but uncoupling divorces that electron flow from \(\text{ATP}\) synthesis, driving \(\text{ATP}\)-per-O — the P/O ratio — toward zero.

(Choice A) is incorrect: a higher instantaneous respiratory rate is not the same as more total \(\text{ATP}\); the uncoupler routes protons around the synthase, so \(\text{ATP}\) per O drops, and the P/O ratio cannot rise above the coupled value of 2.5 (uncoupling can only lower efficiency, never raise it).

(Choice C) is incorrect: it reverses the effect on respiration. Uncoupling relieves respiratory control by collapsing the gradient, so electron flow speeds up rather than slowing; O\(_2\) use is no longer gated by \(\text{ATP}\) synthesis, so total O\(_2\) does not fall.

(Choice D) is incorrect: it correctly notes that each electron pair still reduces the same O\(_2\), but wrongly concludes the P/O ratio is preserved. P/O depends on \(\text{ATP}\) made per O, and the leaked protons bypass the synthase, so the ratio falls even though the O\(_2\) stoichiometry per electron pair is unchanged.

This is a Scientific Reasoning and Problem Solving question because you must separate the two quantities that make up the P/O ratio — electron-driven O\(_2\) reduction versus proton-driven \(\text{ATP}\) synthesis — and reason about how an uncoupler acts on each independently.', 'medium', '1D', 'Oxidative Phosphorylation', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'faster respiration assumed to raise ATP yield and P/O' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'uncoupler wrongly slows respiration via retained respiratory control' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'correct O2 stoichiometry, wrong conclusion that P/O is preserved' FROM q;

-- Q91 [K7 · Oxidative Phosphorylation: Regulation] easy skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Oxidative Phosphorylation: Regulation', 'In a working cell, the concentrations of \(\text{ADP}\) and \(\text{ATP}\) move reciprocally: as \(\text{ATP}\) is spent, \(\text{ADP}\) rises. Suppose measurements show the \(\text{ADP}:\text{ATP}\) ratio climbing sharply in a tissue. What does this rising ratio signal, and how should oxidative phosphorylation respond?', '[{"label": "A", "text": "It signals an energy surplus, and oxphos should slow"}, {"label": "B", "text": "It signals an energy deficit, and oxphos should slow to conserve substrate"}, {"label": "C", "text": "It signals an energy deficit, and oxphos should speed up"}, {"label": "D", "text": "It signals an energy surplus, and oxphos should speed up to store the excess"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is C because \(\text{ADP}\) and \(\text{ATP}\) are reciprocally related: a rising \(\text{ADP}:\text{ATP}\) ratio means \(\text{ATP}\) is being consumed faster than it is replaced, which is the hallmark of an energy deficit (low energy charge). More \(\text{ADP}\) both signals demand and supplies \(\text{ATP}\) synthase with its substrate, so oxidative phosphorylation should speed up to restore \(\text{ATP}\).

(Choice C) is correct: a high \(\text{ADP}:\text{ATP}\) ratio marks an energy shortfall and drives oxphos faster to refill the \(\text{ATP}\) pool.

(Choice A) is incorrect: it reverses the meaning of the ratio — a high \(\text{ADP}:\text{ATP}\) ratio reflects deficit, not surplus, so the correct response is to speed up, not slow down.

(Choice B) is incorrect: it correctly reads the ratio as a deficit but then draws the wrong response; a deficit calls for making more \(\text{ATP}\), so oxphos speeds up rather than slowing.

(Choice D) is incorrect: it pairs a wrong reading (surplus) with the right direction (speed up) only by coincidence; a surplus would in fact slow oxphos, so the reasoning is internally inconsistent with the biology.

This is a Scientific Reasoning and Problem Solving question because you must reason from the \(\text{ADP}:\text{ATP}\) ratio to the energy-state signal it represents and the appropriate change in oxphos rate.', 'easy', '1D', 'Oxidative Phosphorylation', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'ratio read as surplus, slows' FROM q
  UNION ALL
  SELECT id, 'B', 'partial_truth', 'deficit correct, response wrong' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'surplus reading with speed-up' FROM q;

-- Q92 [K8 · Oxidative Phosphorylation: Regulation] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Oxidative Phosphorylation: Regulation', 'A student notes that pyruvate dehydrogenase (PDH), several TCA-cycle enzymes, the electron transport chain, and \(\text{ATP}\) synthase are all regulated by overlapping signals — the energy charge (\(\text{ATP}\)/\(\text{ADP}\)) and the redox state (\(\text{NADH}\)/\(\text{NAD}^+\)). Why must these four stages be co-regulated by these same signals rather than each being controlled independently?', '[{"label": "A", "text": "Because each stage produces \\(\\text{ATP}\\) by substrate-level phosphorylation and must share one \\(\\text{ATP}\\) pool equally"}, {"label": "B", "text": "Because O\\(_2\\) is consumed at every one of these stages, so O\\(_2\\) supply must gate them together"}, {"label": "C", "text": "Because these signals set the equilibrium constants of the reactions, forcing the stages to the same \\(\\Delta G\\)"}, {"label": "D", "text": "Because they operate as one sequential supply chain: mismatched rates would either starve the ETC of \\(\\text{NADH}\\) or let \\(\\text{NADH}\\) and \\(\\text{ATP}\\) accumulate uselessly"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is D because PDH, the TCA cycle, the electron transport chain, and \(\text{ATP}\) synthase form a single sequential pathway in which the output of each stage is the input of the next: PDH and the TCA cycle generate \(\text{NADH}\)/\(\text{FADH}_2\), the chain oxidizes those carriers to build the proton gradient, and \(\text{ATP}\) synthase spends the gradient on \(\text{ATP}\). If they ran at mismatched rates, either the chain would be starved of reducing equivalents or \(\text{NADH}\) and \(\text{ATP}\) would pile up with nowhere to go. Sharing the energy-charge and redox signals keeps supply matched to demand across all four stages.

(Choice D) is correct: because the stages are one linked supply chain, common signals prevent the bottlenecks and wasteful accumulation that independent control would cause.

(Choice A) is incorrect: most \(\text{ATP}\) here is made by oxidative (not substrate-level) phosphorylation at the synthase; the ETC and PDH do not make \(\text{ATP}\) by substrate-level phosphorylation, so a shared substrate-level \(\text{ATP}\) pool is not the reason.

(Choice B) is incorrect: O\(_2\) is consumed only at the end of the chain (reduction of O\(_2\) by complex IV), not at every stage, so O\(_2\) demand at each step is not the coupling principle.

(Choice C) is incorrect: allosteric signals change reaction rates, not the intrinsic equilibrium constants; \(K_\text{eq}\) and \(\Delta G^\circ\) are fixed thermodynamic properties that regulators do not reset, so this misstates how the control works.

This is a Scientific Reasoning and Problem Solving question because you must reason about why sequential, interdependent stages must be co-regulated by shared energy and redox signals.', 'medium', '1D', 'Oxidative Phosphorylation', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'adjacent_fact', 'substrate-level phosphorylation overextended' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'O2 consumed at every stage' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'regulators alter Keq/deltaG' FROM q;

-- Q93 [L1 · Oxidative Phosphorylation: ATP Yield & Bioenergetics] hard skill4 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Oxidative Phosphorylation: ATP Yield & Bioenergetics', 'A student totals the net ATP yield from the complete aerobic oxidation of one glucose molecule using the standard bookkeeping: glycolysis nets 2 ATP plus 2 NADH; pyruvate dehydrogenase generates 2 NADH; and the citric acid cycle generates 6 NADH, 2 FADH2, and 2 GTP. Assuming the malate-aspartate shuttle delivers the cytosolic NADH so that every NADH drives oxidative phosphorylation to yield ~2.5 ATP and every FADH2 yields ~1.5 ATP (and each GTP counts as 1 ATP-equivalent), what is the approximate net ATP yield per glucose?', '[{"label": "A", "text": "~32 ATP"}, {"label": "B", "text": "~24 ATP"}, {"label": "C", "text": "~30 ATP"}, {"label": "D", "text": "~38 ATP"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is A because summing every carrier with the malate-aspartate values gives ~32. Count the reduced carriers: 2 (glycolysis) + 2 (PDH) + 6 (TCA) = 10 NADH, plus 2 FADH2. At ~2.5 ATP/NADH that is 10 x 2.5 = 25 ATP; at ~1.5 ATP/FADH2 that is 2 x 1.5 = 3 ATP; oxidative phosphorylation therefore supplies ~28 ATP. Adding the substrate-level 2 ATP (glycolysis) + 2 GTP (TCA) = 4 gives 28 + 4 = ~32 ATP.

(Choice A) is correct: 25 (from NADH) + 3 (from FADH2) + 4 (substrate-level) = 32, the malate-aspartate result.
(Choice B) is incorrect: ~24 falls below even the oxidative-phosphorylation contribution alone (~28 ATP from the 10 NADH and 2 FADH2), so it can only be reached by omitting oxphos of several carriers; it is not consistent with the values given in the stem.
(Choice C) is incorrect: ~30 is the glycerol-3-phosphate-shuttle answer, in which the 2 cytosolic NADH are delivered as FADH2-equivalents (1.5 each) rather than 2.5 each, losing 2 ATP; the stem specifies malate-aspartate.
(Choice D) is incorrect: ~38 comes from the outdated ~3 ATP/NADH and ~2 ATP/FADH2 conventions, not the ~2.5 and ~1.5 values given in the stem.

This item rewards Skill 4 (Data-Based and Statistical Reasoning): the total is derived by combining the carrier counts with the stated per-carrier ATP values, not recalled.', 'hard', '1D', 'Oxidative Phosphorylation', 'biochemistry', 4, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'C', 'adjacent_fact', 'wrong-shuttle total' FROM q
  UNION ALL
  SELECT id, 'D', 'scale_unit_error', 'old 3/2 ATP conventions' FROM q
  UNION ALL
  SELECT id, 'B', 'process_step_confusion', 'omits oxphos of carriers' FROM q;

-- Q94 [L2 · Oxidative Phosphorylation: ATP Yield & Bioenergetics] hard skill4 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Oxidative Phosphorylation: ATP Yield & Bioenergetics', 'A student notes that if each mitochondrial NADH pumped enough protons to make a whole 3 ATP and each FADH2 made a whole 2 ATP, glucose should yield a tidy 36-38 ATP. Yet careful measurements in isolated mitochondria consistently land near 30-32 ATP per glucose. The student proposes four explanations. Which one correctly identifies why the measured number is both non-integer and lower than the classic 36-38?', '[{"label": "A", "text": "Two of the eight NADH generated per glucose are oxidized directly by molecular oxygen without passing through the electron-transport chain, removing their contribution from the total"}, {"label": "B", "text": "The protons that turn ATP synthase do not divide evenly into the number needed per ATP, and some of the gradient is spent leaking back across the membrane and paying to import ADP and Pi and export ATP, so the true P/O ratios are fractional and the net yield falls below the integer estimate"}, {"label": "C", "text": "The gradient built by proton pumping is fully consumed making ATP, but the tricarboxylic acid cycle releases three CO2 per glucose instead of the expected number, so less carbon reaches the chain"}, {"label": "D", "text": "ATP synthase hydrolyzes roughly one in six ATP molecules back to ADP as they are made, which is why the count settles a few ATP below the theoretical maximum"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is B because the classic 36-38 figure assumes clean whole-number stoichiometry, but two independent facts break that assumption. First, the actual P/O ratios are not integers: the number of protons pumped per reduced carrier and the number of protons ATP synthase must pass to make one ATP do not divide evenly, giving ~2.5 ATP per NADH and ~1.5 ATP per FADH2 rather than 3 and 2. Second, the proton-motive force is not perfectly conserved — some protons leak back across the inner membrane, and the adenine-nucleotide translocase plus the phosphate carrier spend part of the gradient importing ADP and \(\text{P}_i\) and exporting ATP. Both effects lower the realized yield to ~30-32 per glucose.

(Choice B) is correct: fractional P/O ratios (non-integer proton stoichiometry) combined with proton leak and the transport cost of moving ADP, \(\text{P}_i\), and ATP across the membrane together explain both why the number is non-integer and why it is lower than 36-38.
(Choice A) is incorrect: NADH is never oxidized directly by \(\text{O}_2\); reduced carriers deliver electrons only through the complexes of the electron-transport chain, and \(\text{O}_2\) is the terminal acceptor at Complex IV, not a direct oxidant of NADH. No carriers are simply subtracted from the total.
(Choice C) is incorrect: the tricarboxylic acid cycle releases exactly 2 CO2 per turn (4 per glucose), and CO2 release removes carbon, not electrons — the reducing equivalents that drive ATP synthesis are captured as NADH/FADH2 regardless, so this does not account for the shortfall.
(Choice D) is incorrect: although ATP synthase is reversible, under normal respiring conditions the proton-motive force drives it forward to synthesize ATP; it does not routinely hydrolyze a fixed fraction of product back to ADP, and invoking a fabricated one-in-six hydrolysis rate is not the source of the fractional yield.

This item rewards Skill 4 (Data-Based and Statistical Reasoning): the learner reasons from the measured ~30-32 value back to its mechanistic causes — non-integer stoichiometry plus gradient losses — rather than recalling a memorized ATP tally.', 'hard', '1D', 'Oxidative Phosphorylation', 'biochemistry', 4, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'NADH oxidized directly by O2, carriers subtracted' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'CO2 count blamed; confuses carbon loss with electron loss' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'synthase reversibility misapplied as routine product hydrolysis' FROM q;

-- Q95 [L3 · Oxidative Phosphorylation: ATP Yield & Bioenergetics] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Oxidative Phosphorylation: ATP Yield & Bioenergetics', 'Textbook bookkeeping predicts a theoretical maximum of ~32 ATP per glucose, yet careful measurements in intact mitochondria consistently report a somewhat lower number. Which explanation best accounts for the actual yield falling below the theoretical maximum?', '[{"label": "A", "text": "Substrate-level phosphorylation in glycolysis and the citric acid cycle is switched off whenever oxidative phosphorylation is actively running, so its usual ATP is lost"}, {"label": "B", "text": "The theoretical maximum overcounts because NADH and FADH2 actually feed their electrons into the same entry complex, so their per-carrier contributions overlap and are double-counted"}, {"label": "C", "text": "Some protons leak back across the inner membrane outside ATP synthase, and the carriers that import ADP and Pi while exporting ATP themselves consume part of the proton-motive force"}, {"label": "D", "text": "Oxygen is consumed faster than it can be delivered, so the last several NADH molecules are never oxidized at all"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Oxidative Phosphorylation.''

The answer is C because the shortfall reflects energy siphoned from the same proton gradient that drives ATP synthase. The theoretical ~2.5 and ~1.5 ATP/carrier assume every pumped proton returns through ATP synthase to make ATP. In reality, a fraction of protons leaks back across the inner membrane through non-synthase paths (dissipating the gradient as heat), and the mitochondrion must spend some of the proton-motive force to import \(\text{ADP}\) and \(\text{P}_i\) into the matrix and export \(\text{ATP}\) out via their transporters. Both drains lower the ATP actually captured, so real yields sit a bit under the maximum.

(Choice C) is correct: proton leak plus the transport cost of \(\text{ADP}\)/\(\text{P}_i\)/\(\text{ATP}\) diverts part of the gradient away from phosphorylation.
(Choice A) is incorrect: substrate-level phosphorylation is not switched off by oxidative phosphorylation; it contributes its ~4 ATP regardless, and it is not the source of the gap.
(Choice B) is incorrect: NADH and FADH2 enter the chain at different points (Complex I vs the FADH2 pathway at Complex II), pumping different numbers of protons; their contributions do not overlap or double-count.
(Choice D) is incorrect: the measured shortfall is observed under fully aerobic, oxygen-sufficient conditions; the loss is energetic (leak and transport), not an oxygen-delivery failure.

This item rewards Skill 2 (Scientific Reasoning and Problem-Solving): the reader must locate where energy is lost between the gradient and net ATP rather than recall a figure.', 'medium', '1D', 'Oxidative Phosphorylation', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'oxphos shuts off substrate-level' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'carriers double-counted' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'blames oxygen delivery' FROM q;

-- Q96 [L4 · Oxidative Phosphorylation: ATP Yield & Bioenergetics] easy skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Oxidative Phosphorylation: ATP Yield & Bioenergetics', 'In many biosynthetic pathways an unfavorable (endergonic, positive-\(\Delta G\)) reaction proceeds in the cell only when it is carried out together with the hydrolysis of ATP. Reasoning purely from energy coupling, why does linking the two reactions allow the overall process to move forward?', '[{"label": "A", "text": "ATP hydrolysis raises the temperature at the active site, so the added heat supplies the activation energy the endergonic reaction otherwise lacks"}, {"label": "B", "text": "ATP hydrolysis changes the endergonic reaction''s own \\(\\Delta G\\) to a negative value, so that reaction becomes spontaneous on its own"}, {"label": "C", "text": "ATP acts as a catalyst that lowers the activation energy, so the endergonic reaction proceeds without altering its overall \\(\\Delta G\\)"}, {"label": "D", "text": "ATP hydrolysis is strongly exergonic, so if its negative \\(\\Delta G\\) outweighs the positive \\(\\Delta G\\) of the target reaction, the summed \\(\\Delta G\\) is negative and the coupled process is favorable"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Principles of Bioenergetics.''

The answer is D because free-energy changes of coupled reactions add, so a large enough negative \(\Delta G\) can overwhelm a positive one. \(\text{ATP}\) hydrolysis releases a large amount of free energy (\(\Delta G\) is strongly negative, \(\Delta G^{\circ\prime}\approx-30.5\ \text{kJ/mol}\)). When an endergonic reaction (positive \(\Delta G\)) shares an intermediate with, or is mechanistically linked to, this hydrolysis, the two \(\Delta G\) values sum; if the release from hydrolysis is larger in magnitude than the cost of the target reaction, the overall \(\Delta G\) is negative and the combined process is spontaneous.

(Choice D) is correct: coupling makes the sum \(\Delta G_{\text{total}} = \Delta G_{\text{endergonic}} + \Delta G_{\text{hydrolysis}}\) negative when the exergonic term dominates.
(Choice A) is incorrect: spontaneity is governed by free energy, not by a local temperature bump; adding heat addresses kinetics (activation energy), not the sign of \(\Delta G\).
(Choice B) is incorrect: coupling does not change the intrinsic \(\Delta G\) of the endergonic reaction itself; that reaction remains unfavorable in isolation, and only the combined process is favorable.
(Choice C) is incorrect: lowering activation energy speeds a reaction but never changes whether it is thermodynamically favorable; a positive-\(\Delta G\) step still will not proceed net-forward on its own.

This item rewards Skill 2 (Scientific Reasoning and Problem-Solving): the reader reasons from additive free energies rather than recalling that ATP is the energy currency.', 'easy', '1D', 'Principles of Bioenergetics', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'coupling rewrites intrinsic dG' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'confuses kinetics with thermodynamics' FROM q
  UNION ALL
  SELECT id, 'A', 'misconception', 'heat supplies the energy' FROM q;

-- Q97 [L5 · Oxidative Phosphorylation: ATP Yield & Bioenergetics] hard skill4 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Oxidative Phosphorylation: ATP Yield & Bioenergetics', 'Electron transfer between two redox carriers can be treated like a tiny electrochemical cell, with the free energy released given by \(\Delta G = -nF\Delta E\) (\(F \approx 96{,}500\ \text{C/mol}\)). Consider a step in which 2 electrons pass from a donor to an acceptor whose standard reduction potential is 0.20 V higher than the donor''s, so \(\Delta E = +0.20\ \text{V}\). What is the approximate \(\Delta G\) for this transfer?', '[{"label": "A", "text": "About −39 kJ/mol (exergonic)"}, {"label": "B", "text": "About +39 kJ/mol (endergonic)"}, {"label": "C", "text": "About −19 kJ/mol (exergonic)"}, {"label": "D", "text": "About −0.39 kJ/mol (exergonic)"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Principles of Bioenergetics.''

The answer is A because plugging the values into \(\Delta G = -nF\Delta E\) with a positive \(\Delta E\) gives a negative \(\Delta G\) near −39 kJ/mol. Here \(n = 2\), \(F \approx 96{,}500\ \text{C/mol}\), and \(\Delta E = +0.20\ \text{V}\): \(\Delta G = -(2)(96{,}500)(0.20) = -38{,}600\ \text{J/mol} \approx -39\ \text{kJ/mol}\). Because electrons fall to a higher reduction potential (positive \(\Delta E\)), the transfer releases free energy and \(\Delta G\) is negative.

(Choice A) is correct: \(-(2)(96{,}500)(0.20) \approx -3.9 \times 10^{4}\ \text{J/mol} = -39\ \text{kJ/mol}\), an exergonic transfer.
(Choice B) is incorrect: it has the sign wrong; the leading negative in \(\Delta G = -nF\Delta E\) makes a positive \(\Delta E\) yield a negative \(\Delta G\), a favorable (exergonic) transfer, not endergonic.
(Choice C) is incorrect: ~−19 kJ/mol drops the factor of \(n = 2\) and uses \(n = 1\); two electrons are transferred, doubling the magnitude to ~−39 kJ/mol.
(Choice D) is incorrect: −0.39 kJ/mol is a scale/decimal error; the correct −38{,}600 J/mol converts to −38.6 kJ/mol (÷1000), not −0.39 kJ/mol, which is off by a factor of 100.

This item rewards Skill 4 (Data-Based and Statistical Reasoning): the sign and magnitude are computed from the equation and the given quantities, cross-linking to electrochemistry.', 'hard', '1D', 'Principles of Bioenergetics', 'biochemistry', 4, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'dropped leading negative sign' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'used n=1 not n=2' FROM q
  UNION ALL
  SELECT id, 'D', 'scale_unit_error', 'decimal misplacement (off by 100x)' FROM q;

-- Q98 [L6 · Oxidative Phosphorylation: ATP Yield & Bioenergetics] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Oxidative Phosphorylation: ATP Yield & Bioenergetics', 'The NADH/NAD+ couple has a standard reduction potential near −0.32 V, whereas the FADH2 associated with succinate dehydrogenase feeds electrons in at a much less negative potential (close to 0 V). Both ultimately reduce O2 (potential near +0.82 V). Reasoning strictly from energetics, why does NADH ultimately support the synthesis of more ATP than FADH2?', '[{"label": "A", "text": "NADH carries two electrons while FADH2 carries only one, so NADH inherently delivers twice the reducing power to the chain"}, {"label": "B", "text": "NADH''s electrons fall through a larger reduction-potential span to O2, so the larger \\(\\Delta E\\) releases more free energy (more negative \\(\\Delta G\\)) to pump protons"}, {"label": "C", "text": "NADH is present at much higher concentration in the matrix, so mass action drives more of its electrons through the chain per unit time"}, {"label": "D", "text": "NADH binds ATP synthase directly and donates its energy to phosphorylation, whereas FADH2 can only reduce O2"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Principles of Bioenergetics.''

The answer is B because the free energy available scales with the reduction-potential drop, and NADH starts from a more negative potential. NADH''s electrons begin near −0.32 V and fall all the way to O2 at +0.82 V, a span of about 1.14 V; FADH2''s electrons enter near 0 V and fall only ~0.8 V to O2. Since \(\Delta G = -nF\Delta E\), the larger \(\Delta E\) for NADH corresponds to a larger release of free energy, which is used to pump more protons and therefore supports more ATP.

(Choice B) is correct: a larger reduction-potential drop to O2 means a more negative \(\Delta G\) and more proton-pumping energy from NADH.
(Choice A) is incorrect: both NADH and FADH2 deliver two electrons; the difference in ATP yield is set by where they enter (the \(\Delta E\) span), not by electron count.
(Choice C) is incorrect: relative matrix concentration influences rate, not the per-electron free energy; the ATP-yield difference is thermodynamic, tied to the potential drop, not to abundance.
(Choice D) is incorrect: neither carrier docks onto ATP synthase; both deposit electrons into the electron-transport chain, and the gradient (not direct binding) links them to phosphorylation.

This item rewards Skill 2 (Scientific Reasoning and Problem-Solving): the yield difference is reasoned from \(\Delta E\) and \(\Delta G\), not recalled as an ATP count.', 'medium', '1D', 'Principles of Bioenergetics', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'electron-count difference' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'concentration/rate not energetics' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'carrier binds ATP synthase' FROM q;

-- Q99 [L7 · Oxidative Phosphorylation: ATP Yield & Bioenergetics] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Oxidative Phosphorylation: ATP Yield & Bioenergetics', 'A student tallies the direct ATP a cell makes as it fully oxidizes one glucose: 2 ATP net in glycolysis and 2 GTP in the citric acid cycle, for 4 high-energy phosphates formed by substrate-level phosphorylation. Yet the complete oxidation of glucose captures roughly 30-32 ATP overall. The student asks where the remaining energy is held between the two accounting points. Which statement best explains why the substrate-level total so badly undercounts the ATP a cell ultimately harvests from glucose?', '[{"label": "A", "text": "The substrate-level steps actually make far more than 4 ATP; the count of 4 omits additional GTP produced each time citrate is cleaved back to acetyl-CoA"}, {"label": "B", "text": "Most of the extra ATP is produced directly during the two oxidative decarboxylations that release CO2, which phosphorylate ADP at the same active sites"}, {"label": "C", "text": "Most of glucose''s captured energy is stored in the reduced carriers NADH and FADH2, which release it later at the electron transport chain to build the proton gradient that drives ATP synthase"}, {"label": "D", "text": "The reduced carriers store little energy themselves, but re-oxidizing them regenerates the NAD+ that lets glycolysis and the cycle run repeatedly and make many more substrate-level ATP"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Principles of Bioenergetics.''

The answer is C because the substrate-level steps capture only a small fraction of glucose''s free energy directly as ATP or GTP; the bulk of the energy is stored temporarily in the reduced electron carriers \(\text{NADH}\) and \(\text{FADH}_2\). Full oxidation of glucose yields ~10 \(\text{NADH}\) and ~2 \(\text{FADH}_2\) (from glycolysis, pyruvate dehydrogenase, and two turns of the citric acid cycle). These carriers hand their electrons to the electron transport chain, where the drop in reduction potential to \(\text{O}_2\) powers proton pumping across the inner membrane. The resulting proton-motive force then drives ATP synthase, so ~26-28 of the ~30-32 total \(\text{ATP}\) trace back to the reduced carriers rather than to substrate-level phosphorylation.

(Choice C) is correct: the energy missing from the substrate-level tally is held in \(\text{NADH}\) and \(\text{FADH}_2\) and is released at the electron transport chain, where it builds the gradient that oxidative phosphorylation converts into the large majority of the cell''s \(\text{ATP}\).
(Choice A) is incorrect: substrate-level phosphorylation genuinely yields only ~4 high-energy phosphates per glucose (2 \(\text{ATP}\) in glycolysis, 2 \(\text{GTP}\) in the cycle); cleaving citrate to acetyl-CoA is a cytoplasmic biosynthetic step that consumes ATP for fatty-acid synthesis, not a source of extra GTP.
(Choice B) is incorrect: the two oxidative decarboxylations (isocitrate to \(\alpha\)-ketoglutarate, and \(\alpha\)-ketoglutarate to succinyl-CoA) capture their released energy as \(\text{NADH}\), not as direct phosphorylation of \(\text{ADP}\); ATP synthase, not these active sites, makes that ATP later.
(Choice D) is incorrect: re-oxidizing the carriers does regenerate \(\text{NAD}^+\), but that recycling does not raise the substrate-level yield beyond ~4 per glucose; the extra ATP comes from oxidative phosphorylation harnessing the energy the carriers were holding, not from more substrate-level phosphorylation.

This item rewards Skill 2 (Scientific Reasoning and Problem-Solving): the reader must reason that the gap between the direct (substrate-level) tally and the total yield is bridged by energy transiently stored in the reduced carriers and released through oxidative phosphorylation.', 'medium', '1D', 'Principles of Bioenergetics', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'hidden extra substrate-level ATP' FROM q
  UNION ALL
  SELECT id, 'B', 'process_step_confusion', 'decarboxylation directly phosphorylates ADP' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'carriers only recycle NAD+, not store energy' FROM q;

-- Q100 [L8 · Oxidative Phosphorylation: ATP Yield & Bioenergetics] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Carbohydrate Metabolism II', 'Oxidative Phosphorylation: ATP Yield & Bioenergetics', 'At ATP synthase, protons stored in the intermembrane space flow back into the matrix down their electrochemical gradient, and this flow is used to build ATP from ADP and Pi. Phosphorylating ADP is itself an endergonic (positive-\(\Delta G\)) step. Reasoning about how one process pays for the other, which statement best describes the thermodynamic coupling at ATP synthase?', '[{"label": "A", "text": "Both proton flow and ADP phosphorylation are exergonic, and their released energies simply add together to make ATP"}, {"label": "B", "text": "The endergonic phosphorylation of ADP supplies the energy that pushes protons back across the membrane against their gradient"}, {"label": "C", "text": "Proton flow and ADP phosphorylation are thermodynamically independent; protons only hold ATP synthase in the correct shape while ATP forms spontaneously"}, {"label": "D", "text": "The exergonic return of protons down their gradient releases free energy that is harnessed to drive the endergonic phosphorylation of ADP, so the favorable process pays for the unfavorable one"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Principles of Bioenergetics.''

The answer is D because energy conservation requires a favorable process to pay for an unfavorable one, and here proton flow is the favorable side. Protons moving down their electrochemical gradient into the matrix is strongly exergonic (negative \(\Delta G\)). ATP synthase captures that released energy and uses it to drive the endergonic condensation of \(\text{ADP} + \text{P}_i \rightarrow \text{ATP}\). The two are mechanically linked so the negative \(\Delta G\) of proton return offsets the positive \(\Delta G\) of phosphorylation, giving a favorable coupled reaction.

(Choice D) is correct: the exergonic proton flow through \(F_0\) supplies the free energy for the endergonic ATP-forming step in \(F_1\).
(Choice A) is incorrect: phosphorylating ADP is endergonic, not exergonic, so the two energies do not simply add as two favorable terms; one must drive the other.
(Choice B) is incorrect: it reverses the direction; ADP phosphorylation is the energy-requiring step, so it cannot be the source that pumps protons uphill (that reverse mode requires ATP hydrolysis, not synthesis).
(Choice C) is incorrect: the coupling is thermodynamic, not merely structural; proton flow does not just hold a shape, it delivers the free energy that makes ATP formation favorable.

This item rewards Skill 2 (Scientific Reasoning and Problem-Solving): the reader must identify which half-reaction pays for which, applying energy conservation to coupled processes.', 'medium', '1D', 'Principles of Bioenergetics', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'phosphorylation pumps protons' FROM q
  UNION ALL
  SELECT id, 'A', 'misconception', 'both steps exergonic' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'protons only hold shape' FROM q;

COMMIT;
