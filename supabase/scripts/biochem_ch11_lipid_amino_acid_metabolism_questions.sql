-- ════════════════════════════════════════════════════════════════════
-- Biochemistry Ch11 — Lipid and Amino Acid Metabolism — 85 standalone questions
-- (lipid digestion/mobilization/transport, fatty-acid structure & synthesis, fatty-acid
--  oxidation & ketone bodies, protein catabolism & the urea cycle).
-- Foundation 1D 'Metabolism of Fatty Acids and Proteins'. Grounded in LibreTexts Biochemistry.
-- WHOLE-DOCUMENT cross-subject scope map: off-outline material (lipoprotein classes, cholesterol
--  synthesis pathway, LCAT/CETP, alpha/omega-oxidation) trimmed; a few kept as Smart-Hybrid items
--  (off-outline specifics SUPPLIED in-stem, discriminator is an in-scope principle).
-- Cross-batch audit incl. Ch10-overlap + off-outline-recall lenses; 11 items remediated.
-- IDEMPOTENT: wipes the entire topic then re-inserts all 85.
-- ════════════════════════════════════════════════════════════════════

BEGIN;
DELETE FROM questions WHERE section = 'bio_biochem' AND topic = 'Lipid and Amino Acid Metabolism';

-- Q1 [A1 · Lipid Digestion & Bile] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Lipid Digestion & Bile', 'In the duodenum, a large droplet of dietary triacylglycerol is broken up by bile salts into many far smaller droplets before pancreatic lipase begins to act. A student proposes that this dispersal is what causes the fat''s ester bonds to break. Which statement best explains how the dispersal actually speeds triacylglycerol digestion?', '[{"label": "A", "text": "It multiplies the lipid–water interfacial area, so more lipase molecules can bind and act on the fat at once, even though the dispersal itself breaks no bonds."}, {"label": "B", "text": "It hydrolyzes some of the ester bonds directly, lowering the number of bonds that lipase must later cleave."}, {"label": "C", "text": "It converts the water-insoluble triacylglycerol into a water-soluble form, allowing lipase to act on fat fully dissolved in the aqueous phase."}, {"label": "D", "text": "It shifts the hydrolysis equilibrium toward products, so a greater fraction of the triacylglycerol is ultimately converted to fatty acids."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is A because pancreatic lipase is water-soluble and can only reach triacylglycerol molecules that lie at the surface of a fat droplet, where lipid meets water. Breaking one large droplet into many small ones does not change the total amount of fat, but it dramatically increases the combined surface area of that fat, exposing many more triacylglycerol molecules at the lipid–water interface simultaneously. More accessible interface means more lipase molecules can bind and catalyze at the same time, raising the overall rate of the hydrolytic step. The dispersal is purely physical: it repositions the fat, it does not cleave any bonds itself.

(Choice A) is correct: emulsification increases the interfacial surface area available to a surface-acting enzyme, so more catalysis occurs per unit time, while the bond-breaking is still done entirely by lipase.

(Choice B) is incorrect: emulsification is a physical dispersal, not a chemical reaction. Bile salts do not hydrolyze ester bonds; the stem''s premise that dispersal ''causes the ester bonds to break'' is exactly the misconception to reject, because every ester bond is cleaved by lipase, not by the act of dispersal.

(Choice C) is incorrect: emulsification does not truly dissolve triacylglycerol into the aqueous phase as individual molecules. The fat remains a separate lipid phase; it is merely subdivided into smaller droplets, so lipase still acts at an interface rather than on fully dissolved substrate.

(Choice D) is incorrect: increasing surface area speeds how fast equilibrium is approached but does not move the position of the equilibrium. Emulsification is a rate (kinetic) effect on the interfacial reaction, not a thermodynamic shift in the products-to-reactants ratio.

As a Skill 2 (reasoning about scientific concepts) item, this requires you to distinguish a physical, surface-area (kinetic) mechanism from chemical hydrolysis and from an equilibrium shift, rather than recall a definition of emulsification.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'believes emulsification itself hydrolyzes ester bonds' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'confuses interfacial dispersal with true molecular dissolution' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'treats a surface-area kinetic effect as an equilibrium shift' FROM q;

-- Q2 [A2 · Lipid Digestion & Bile] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Lipid Digestion & Bile', 'A bile salt has a rigid steroid framework: one face carries hydroxyl and ionized carboxylate groups, while the opposite face is a bare hydrocarbon surface. In the watery lumen of the small intestine, this single molecule can coat tiny fat droplets and keep them suspended rather than coalescing back into one large mass. Which feature of the molecule most directly accounts for its ability to keep fat dispersed in water?', '[{"label": "A", "text": "Its net negative charge lets the whole molecule dissolve in water, carrying the attached fat into solution with it."}, {"label": "B", "text": "Its two chemically opposite faces let it sit at the fat–water boundary, its hydrocarbon face buried in the lipid and its charged face turned toward the water."}, {"label": "C", "text": "Its rigid steroid ring system is chemically inert, so it neither reacts with nor is repelled by either the fat or the water."}, {"label": "D", "text": "Its many hydroxyl groups form hydrogen bonds that chemically link separate fat molecules together into a single stabilized cluster."}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is B because the molecule described is amphipathic: it has a polar/hydrophilic region (the hydroxyl and ionized carboxylate groups on one face) and a nonpolar/hydrophobic region (the bare hydrocarbon face). A molecule with both regions cannot be fully comfortable in either phase alone, so it orients at the lipid–water interface — the hydrophobic face turns inward toward the fat, and the polar face turns outward toward the surrounding water. By coating each small droplet with an outward-facing hydrophilic shell, it presents a water-compatible surface that keeps droplets from touching and merging, holding the fat dispersed in the aqueous lumen. This is the amphipathic solubilization principle, independent of any particular named aggregate.

(Choice B) is correct: it identifies the dual polar/nonpolar character and the interfacial orientation that lets one molecule bridge fat and water and stabilize the dispersion.

(Choice A) is incorrect: it credits the charge alone, ignoring the essential nonpolar face. A fully water-soluble molecule with no hydrophobic region would have no reason to anchor into the fat droplet, so it could not hold lipid at the interface; the fat is not dragged into true solution.

(Choice C) is incorrect: chemical inertness of the ring system is beside the point. An inert molecule that was uniformly nonpolar or uniformly polar would partition into one phase and could not sit at the boundary; it is precisely the two contrasting faces, not inertness, that make the molecule effective.

(Choice D) is incorrect: the molecule keeps fat droplets apart, not chemically bonded together. Its role is to coat and separate droplets so they stay dispersed; it does not covalently or by hydrogen bonding fuse fat molecules into one cluster.

As a Skill 2 (reasoning about scientific concepts) item, this asks you to apply the amphipathic-solubilization principle to a described molecule and predict its interfacial behavior, rather than recall the name of the aggregate it forms.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'partial_truth', 'credits only the polar/charged region and ignores the required hydrophobic face' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'attributes function to chemical inertness rather than dual polarity' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'thinks the molecule bonds fat together rather than coating and separating droplets' FROM q;

-- Q3 [A3 · Lipid Digestion & Bile] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Lipid Digestion & Bile', 'A triacylglycerol consists of a glycerol backbone esterified to three fatty acids at carbons 1, 2, and 3. Pancreatic lipase acts on the two outer (sn-1 and sn-3) ester linkages but leaves the central (sn-2) linkage intact. Adding one water molecule across each ester bond it attacks, what set of products results from complete lipase action on a single triacylglycerol molecule?', '[{"label": "A", "text": "One free glycerol plus three free fatty acids"}, {"label": "B", "text": "One 1,2-diacylglycerol plus one free fatty acid"}, {"label": "C", "text": "One 2-monoacylglycerol plus two free fatty acids"}, {"label": "D", "text": "One 2-monoacylglycerol plus two fatty-acyl-CoA molecules"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is C because each ester bond that lipase attacks is cleaved by hydrolysis: a water molecule is added across the C–O ester linkage, releasing one fatty acid as a free carboxylic acid and leaving a free hydroxyl on the glycerol carbon. The stem specifies that lipase cleaves the two outer linkages (sn-1 and sn-3) but not the central sn-2 linkage. Removing the two outer fatty acids therefore yields two free fatty acids, while the fatty acid still esterified at the middle carbon remains attached — a glycerol bearing a single acyl group at position 2, i.e., a 2-monoacylglycerol.

(Choice C) is correct: hydrolyzing exactly the two outer ester bonds liberates two free fatty acids and leaves the sn-2 ester intact, giving one 2-monoacylglycerol.

(Choice A) is incorrect: complete breakdown to free glycerol plus three fatty acids would require cleaving all three ester bonds, including the central one. The stem states the sn-2 linkage is not attacked, so one fatty acid stays esterified and the glycerol is not fully liberated.

(Choice B) is incorrect: a 1,2-diacylglycerol plus one free fatty acid represents cleavage of only one ester bond. That would be an intermediate after a single cut, not the endpoint after lipase has hydrolyzed both outer linkages.

(Choice D) is incorrect: this choice imports a later, unrelated step. Attaching coenzyme A to a fatty acid (forming fatty-acyl-CoA) is an activation reaction that occurs during intracellular fatty-acid metabolism, not part of the hydrolytic cleavage lipase performs in the gut lumen. Lipase releases free fatty acids, not acyl-CoA.

As a Skill 2 (reasoning about scientific concepts) item, this asks you to track ester hydrolysis across a specified set of bonds and deduce the products, rather than recall a named product list.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'assumes lipase cleaves all three esters including the protected sn-2 bond' FROM q
  UNION ALL
  SELECT id, 'B', 'process_step_confusion', 'stops at the single-cut intermediate instead of the two-cut endpoint' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'confuses gut hydrolysis products with intracellular acyl-CoA activation' FROM q;

-- Q4 [A4 · Lipid Digestion & Bile] easy skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Lipid Digestion & Bile', 'Bile is produced continuously by the liver, but between meals it is diverted into the gallbladder, where it is stored and concentrated until a fatty meal triggers its release into the duodenum. A patient has her gallbladder surgically removed and afterward reports discomfort and loose, greasy stools specifically after large, high-fat meals, while small low-fat meals cause no trouble. Which explanation best accounts for this pattern?', '[{"label": "A", "text": "The liver stops making bile once the gallbladder is removed, so no bile salts are available to emulsify any dietary fat."}, {"label": "B", "text": "The gallbladder is where pancreatic lipase is produced, so its removal leaves the small intestine without the enzyme needed to hydrolyze triacylglycerol."}, {"label": "C", "text": "Removing the gallbladder blocks reabsorption of dietary carbohydrates, so the greasy stools reflect unabsorbed sugars rather than unabsorbed fat."}, {"label": "D", "text": "The liver''s steady low-level bile output can no longer be stored and surged on demand, so a sudden large fat load is emulsified less effectively than a small one."}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is D because the gallbladder''s job is not to make bile but to store and concentrate the bile the liver secretes and then to release it in a coordinated surge when a fatty meal arrives. The liver still makes bile after the gallbladder is gone, but it does so at a steady trickle and can no longer deliver a concentrated bolus on demand. A small low-fat meal needs little emulsification, so the steady trickle suffices; a large high-fat meal overwhelms that limited, un-surged supply, so fat is emulsified and digested less completely and appears in the stool as fat (greasy, loose). This meal-size-dependent pattern is exactly what a storage/timing deficit predicts.

(Choice D) is correct: it correctly locates bile synthesis in the liver and the gallbladder''s role in storage/concentration/timed release, explaining why only large fat loads cause symptoms.

(Choice A) is incorrect: it wrongly claims the liver stops making bile. The liver is the site of bile production and continues to secrete it after cholecystectomy; if no bile were available at all, even small fat-containing meals would be poorly digested, which contradicts the stem.

(Choice B) is incorrect: pancreatic lipase is made by the pancreas, not the gallbladder. Removing the gallbladder does not remove the source of lipase, so this misattributes the enzyme''s origin.

(Choice C) is incorrect: greasy, fatty stools reflect unabsorbed fat, and bile has nothing to do with absorbing carbohydrates. Dietary sugars are absorbed by the intestinal epithelium independent of bile, so this choice misidentifies both the affected nutrient and bile''s function.

As a Skill 2 (reasoning about scientific concepts) item, this requires reasoning from a described clinical scenario to a consequence, using the liver-makes/gallbladder-stores logistics rather than recalling an isolated fact.', 'easy', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'thinks the gallbladder rather than the liver synthesizes bile' FROM q
  UNION ALL
  SELECT id, 'B', 'adjacent_fact', 'misattributes pancreatic lipase production to the gallbladder' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'links bile to carbohydrate absorption instead of fat' FROM q;

-- Q5 [A5 · Lipid Digestion & Bile] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Lipid Digestion & Bile', 'Bile salts are needed to emulsify fat, yet by coating the surface of an emulsified fat droplet they also physically occupy the very interface where pancreatic lipase must bind, and can push lipase off the droplet. Colipase, a small protein secreted by the pancreas, restores lipase activity by anchoring it to the droplet surface. Considering both roles of bile salts, which statement best captures why colipase is required for efficient fat digestion?', '[{"label": "A", "text": "Bile salts create the large interface lipase needs but also crowd it and displace lipase; colipase re-anchors lipase there, preserving the emulsifying benefit without the blocking."}, {"label": "B", "text": "Bile salts chemically denature lipase in the intestinal lumen and unfold it; colipase then acts as a chaperone that refolds the inactivated enzyme back to its native, active shape."}, {"label": "C", "text": "Bile salts raise the luminal pH above lipase''s optimum and inhibit it; colipase then works by chemically buffering the lumen back down to lipase''s ideal pH for catalysis."}, {"label": "D", "text": "Bile salts hydrolyze the triacylglycerol before lipase can reach it; colipase then blocks that competing bile-salt reaction so that intact substrate is left for lipase to cleave."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is A because bile salts have two opposite effects at the droplet surface. Emulsification is helpful: by dispersing fat into small droplets, bile salts create the large lipid–water interface lipase acts on. But because bile salts themselves coat that interface, they crowd it and can knock lipase off the very surface it needs to bind — a hindrance to lipase''s contact with substrate. Colipase resolves this tension: it binds both the droplet interface and lipase, tethering lipase to the fat surface despite the bile-salt coating. Thus the emulsifying benefit is preserved while the interfacial blocking is overcome. Without colipase, the same bile salts that enabled emulsification would keep lipase from binding, so their net effect at the surface would impair, not aid, lipase action.

(Choice A) is correct: it captures both faces of bile-salt action (helpful dispersal, harmful interfacial displacement) and colipase''s role as the anchor that lets lipase bind despite the bile-salt coating.

(Choice B) is incorrect: bile salts do not denature lipase, and colipase is not a refolding chaperone. Colipase acts by physically anchoring native lipase to the lipid interface, not by restoring a denatured enzyme''s fold.

(Choice C) is incorrect: colipase does not act as a pH buffer, and the problem bile salts create is spatial occupancy of the interface, not a pH shift. This choice invents a pH mechanism unrelated to the interfacial competition described.

(Choice D) is incorrect: bile salts do not hydrolyze triacylglycerol at all — their action is physical emulsification, and hydrolysis is done by lipase. There is no competing bile-salt hydrolysis for colipase to block.

As a Skill 2 (reasoning about scientific concepts) item, this asks you to reconcile the dual (helpful and hindering) roles of bile salts at an interface and infer why an anchoring cofactor is required, rather than recall colipase''s name.', 'hard', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'casts bile salts as denaturants and colipase as a refolding chaperone' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'invents a pH-buffering mechanism instead of interfacial displacement' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'wrongly attributes ester hydrolysis to bile salts competing with lipase' FROM q;

-- Q6 [A6 · Lipid Digestion & Bile] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Lipid Digestion & Bile', 'Bile salts are synthesized by the liver from cholesterol. Normally, after they emulsify fat in the small intestine, roughly 95% of them are actively reabsorbed at the terminal ileum and shuttled back to the liver to be used again, so the liver has to make very little new bile salt. A patient is given a drug (a bile-acid sequestrant resin) that binds bile salts in the gut lumen and prevents their reabsorption at the ileum, causing them to be excreted in the stool. Over time, which effect on the patient''s cholesterol is most likely, and why?', '[{"label": "A", "text": "Blood cholesterol rises, because bile salts are made from cholesterol, so trapping them in the gut prevents the cholesterol they contain from being lost."}, {"label": "B", "text": "Blood cholesterol falls, because the liver must consume more cholesterol to synthesize replacement bile salts that are no longer being recycled."}, {"label": "C", "text": "Blood cholesterol is unchanged, because bile-salt recycling and cholesterol levels are handled by independent pathways that do not affect each other."}, {"label": "D", "text": "Blood cholesterol falls, because the drug binds and removes cholesterol itself from the gut before it can be absorbed into the blood."}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is B because the recycling loop described normally lets the liver reuse bile salts many times, so it spends very little cholesterol replacing them. The drug breaks that loop: by binding bile salts and forcing their excretion, it stops them from returning to the liver. To keep enough bile salts for fat digestion, the liver must now synthesize large amounts of new bile salt, and because bile salts are made from cholesterol, this ongoing replacement draws down the body''s cholesterol. Diverting cholesterol into bile-salt synthesis (and the liver''s compensatory uptake of cholesterol from the blood to supply it) lowers blood cholesterol.

(Choice B) is correct: interrupting recycling forces continual de novo bile-salt synthesis from cholesterol, consuming cholesterol and lowering its blood level.

(Choice A) is incorrect: it reverses the direction of the effect. Although bile salts are made from cholesterol, trapping and excreting bile salts removes that cholesterol-derived material from the body rather than conserving it, so the drug lowers, not raises, cholesterol.

(Choice C) is incorrect: bile-salt turnover and cholesterol are directly linked because bile salts are synthesized from cholesterol. Forcing more bile-salt synthesis necessarily draws on cholesterol, so the pathways are not independent.

(Choice D) is incorrect: the sequestrant binds bile salts, not cholesterol molecules directly. The cholesterol-lowering effect is indirect — through increased bile-salt synthesis — not through the drug scooping up dietary cholesterol.

As a Skill 2 (reasoning about scientific concepts) item, this asks you to trace the consequence of interrupting enterohepatic recycling to its effect on cholesterol, rather than recall the drug class.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'reverses the sign of the effect, treating bile-salt trapping as cholesterol conservation' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'denies the cholesterol-to-bile-salt synthetic link' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'attributes the effect to direct cholesterol binding rather than increased bile-salt synthesis' FROM q;

-- Q7 [A7 · Lipid Digestion & Bile] hard skill4 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Lipid Digestion & Bile', 'Clinicians measure fecal fat (grams of fat lost in the stool per day) in four adults, each fed an identical, fixed daily amount of dietary fat. Pancreatic lipase output is confirmed normal in all four subjects, so any difference cannot come from a shortage of the fat-splitting enzyme. Only the delivery of bile to the small intestine differs among them, as shown.

| Subject | Bile delivery to small intestine | Fecal fat (g/day) |
|---|---|---|
| 1 | Normal | 4 |
| 2 | Partial bile-duct obstruction | 19 |
| 3 | Complete bile-duct obstruction | 33 |
| 4 | Complete obstruction, then bile salts fed by mouth | 6 |

Which conclusion is best supported by the data?', '[{"label": "A", "text": "The rising fecal fat reflects a deficiency of pancreatic lipase, since fat cannot be split into absorbable products without the fat-splitting enzyme being present."}, {"label": "B", "text": "The rising fecal fat reflects the subjects eating progressively more dietary fat, so more of it inevitably escapes absorption and appears in the stool."}, {"label": "C", "text": "Delivering bile to the gut is required for efficient fat absorption; when bile flow is blocked, unabsorbed fat is lost in the stool, and restoring bile salts corrects the loss."}, {"label": "D", "text": "Bile normally hinders fat absorption; blocking its delivery to the gut therefore allows more of the dietary fat to be taken up and less to be excreted."}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is C because fecal fat rises step-for-step as bile delivery is reduced (4 g/day with normal flow, 19 with partial obstruction, 33 with complete obstruction), even though dietary fat and pancreatic lipase are held constant across every subject. The only variable that tracks the fat loss is how much bile reaches the gut, so bile must be doing something essential for fat to be absorbed rather than excreted. Subject 4 seals the interpretation: with the duct still completely blocked but bile salts supplied by mouth, fecal fat falls back to near-normal (6 g/day). Adding bile salts back reverses the loss, which is the signature of a required factor. Physiologically, bile salts emulsify dietary fat and carry its breakdown products in mixed micelles to the intestinal surface for uptake, so losing bile causes fat malabsorption and steatorrhea.

(Choice C) is correct: it ties the fat loss to the absence of bile and correctly reads subject 4 (bile salts restored, fecal fat normalized) as proof that bile is the required factor for efficient fat absorption.

(Choice A) is incorrect: the stem states that pancreatic lipase output is confirmed normal in all four subjects, so the fat loss cannot come from a shortage of the fat-splitting enzyme. The variable that changes is bile delivery, not lipase.

(Choice B) is incorrect: every subject is fed an identical, fixed daily amount of dietary fat, so the increasing fecal fat cannot be explained by eating more. Only bile delivery differs, and it is the loss of bile, not extra intake, that leaves fat unabsorbed.

(Choice D) is incorrect: it reverses the relationship shown in the data. Blocking bile delivery raises fecal fat (more fat lost, meaning worse absorption), and restoring bile salts lowers it, so bile promotes rather than hinders fat absorption.

As a Skill 4 (data-based reasoning) item, this requires you to use the controlled comparisons in the table — dietary fat and lipase held constant while bile delivery is varied, plus the add-back control in subject 4 — to isolate bile as the factor required for fat absorption, rather than to recall a fact.', 'hard', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 4, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'blames the fat loss on lipase deficiency, ignoring the stem''s statement that lipase output is normal in all subjects' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'attributes the rising fecal fat to increased dietary intake, ignoring that fat intake is held constant' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'reverses bile''s role, claiming bile hinders absorption when the data show its loss causes fat malabsorption' FROM q;

-- Q8 [B8 · Lipid Absorption & Routing] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Lipid Absorption & Routing', 'Inside an intestinal enterocyte, the free fatty acids and 2-monoacylglycerol taken up at the brush border are enzymatically rebuilt into triacylglycerol, which is then coated with a shell of amphipathic phospholipids and apoproteins before the particle leaves the cell. If a researcher engineered an enterocyte to instead export the absorbed fatty acids as free, uncoated triacylglycerol droplets, what problem would this create for the fat once it left the cell?', '[{"label": "A", "text": "The uncoated triacylglycerol would be hydrolyzed back to fatty acids the instant it contacted extracellular water"}, {"label": "B", "text": "The uncoated triacylglycerol would be freely water-soluble and would diffuse away before reaching tissue"}, {"label": "C", "text": "The uncoated triacylglycerol would be re-absorbed into the enterocyte because it lacks an export signal"}, {"label": "D", "text": "Lacking a polar surface, the hydrophobic triacylglycerol could not stay dispersed in the aqueous blood/lymph and would aggregate instead"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is D because triacylglycerol is a nonpolar, hydrophobic molecule, and blood and lymph are aqueous. A free TAG droplet with no amphipathic shell has no polar surface to interface with water, so it cannot stay dispersed; it would coalesce into large aggregates. The enterocyte solves exactly this by wrapping the TAG core in a phospholipid-and-apoprotein shell whose outward-facing polar regions let the whole particle remain suspended in the aqueous fluid.

(Choice D) is correct: a bare hydrophobic TAG core cannot present a polar face to the surrounding water, so it aggregates rather than travels as a stable dispersed particle, which is why the cell coats it in an amphipathic shell.
(Choice A) is incorrect: nothing in the extracellular fluid spontaneously hydrolyzes TAG on contact; hydrolysis of circulating TAG requires a specific lipase (lipoprotein lipase) at the capillary wall, not mere exposure to water.
(Choice B) is incorrect: TAG is hydrophobic, not water-soluble, so it will not dissolve and diffuse away; the problem is the opposite, that it will not disperse at all.
(Choice C) is incorrect: re-absorption is not the issue, and the export block being tested is solubility in blood/lymph, not a missing intracellular trafficking signal.

As a Skill 2 (reasoning about scientific concepts) item, the student must reason from the hydrophobic nature of TAG and the aqueous nature of blood to the need for an amphipathic packaging shell, rather than recall that chylomicrons exist.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'water contact hydrolyzes ester bonds' FROM q
  UNION ALL
  SELECT id, 'B', 'reversed_relationship', 'TAG treated as water-soluble' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'invokes trafficking signal instead of solubility' FROM q;

-- Q9 [B9 · Lipid Absorption & Routing] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Lipid Absorption & Routing', 'After a fatty meal, the large lipid-rich particles assembled by enterocytes do not enter the blood capillaries that drain the intestine into the hepatic portal vein. Instead they enter lymphatic lacteals and only reach the bloodstream later, at the thoracic duct. Absorbed glucose and amino acids, by contrast, pass directly into the portal blood. What best accounts for the lipid particles taking the lymphatic detour while sugars and amino acids do not?', '[{"label": "A", "text": "The lipid particles are large, insoluble aggregates that cannot cross into blood capillaries, whereas small water-soluble sugars and amino acids pass into capillary blood easily"}, {"label": "B", "text": "The lymphatic route carries the lipid particles straight to the liver first, whereas sugars and amino acids do not need to reach the liver at all"}, {"label": "C", "text": "A lipid-specific transporter actively pumps the particles into the lacteals, whereas sugars and amino acids have no such pump and stay in the capillaries"}, {"label": "D", "text": "The sugars and amino acids are the large molecules that cannot enter blood capillaries, whereas the lipid particles are small enough to enter the portal blood"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is A because the discriminating property is particle size and solubility. The lipid particles are large and hydrophobic aggregates; blood capillary walls exclude them, but the more porous lymphatic lacteals admit them. Glucose and amino acids are small, water-soluble molecules that cross the capillary endothelium readily and so enter the portal blood directly. The route each nutrient takes follows from what can and cannot fit into a blood capillary.

(Choice A) is correct: the size/insolubility of the lipid particle keeps it out of blood capillaries and routes it through the lacteals, while small soluble sugars and amino acids enter capillary (portal) blood directly.
(Choice B) is incorrect: the lymphatic route actually bypasses the liver on first pass (it empties at the thoracic duct into the systemic venous blood), so it is the sugars and amino acids, via the portal vein, that reach the liver first.
(Choice C) is incorrect: entry into the lacteal is driven by the particle''s size and physical exclusion from blood capillaries, not by a lipid-specific active transporter.
(Choice D) is incorrect: this reverses the size relationship; sugars and amino acids are the small molecules and enter capillaries easily, whereas the lipid particles are the large ones.

As a Skill 2 (reasoning about scientific concepts) item, the student must reason from particle size and solubility to the anatomical route, not simply recall that dietary fat uses lymph.', 'hard', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'claims lymph goes to liver first' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'invents active lipid transporter into lacteal' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'swaps which nutrient is large' FROM q;

-- Q10 [B10 · Lipid Absorption & Routing] easy skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Lipid Absorption & Routing', 'Long-chain fatty acids released during fat digestion are re-esterified and packaged into large lipid particles that leave the enterocyte through the lymph. Short- and medium-chain fatty acids, however, are absorbed directly into the portal blood without being packaged this way. Which property of short- and medium-chain fatty acids best explains why they can take the direct portal-blood route?', '[{"label": "A", "text": "Their shorter chains make them more hydrophobic, so they slip through capillary membranes faster than long-chain fatty acids"}, {"label": "B", "text": "Their shorter hydrocarbon chains make them water-soluble enough to dissolve in and travel through the aqueous portal blood"}, {"label": "C", "text": "They are already esterified into triacylglycerol and so do not need repackaging"}, {"label": "D", "text": "They cannot be recognized by pancreatic lipase and so are absorbed intact"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is B because solubility scales with chain length. A shorter hydrocarbon tail means a smaller nonpolar portion relative to the polar carboxyl group, making short- and medium-chain fatty acids water-soluble enough to dissolve in the aqueous portal blood and travel without being wrapped into a large lipid particle. Long-chain fatty acids are too hydrophobic for this and must be re-esterified and packaged for the lymph route.

(Choice B) is correct: shorter chains lower hydrophobicity and raise water solubility, letting these fatty acids dissolve directly in portal blood.
(Choice A) is incorrect: shorter chains make a fatty acid less hydrophobic, not more; the reasoning is reversed, and it is water solubility (not enhanced membrane slipping) that permits the portal route.
(Choice C) is incorrect: these fatty acids are free acids released by lipase, not intact triacylglycerol; their direct absorption is explained by solubility, not by being pre-esterified.
(Choice D) is incorrect: pancreatic lipase does act on triacylglycerol regardless of chain length, and the portal route is explained by product solubility, not by escaping the enzyme.

As a Skill 2 (reasoning about scientific concepts) item, the student reasons from chain length to solubility to the absorption route rather than memorizing a fact.', 'easy', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'shorter chain called more hydrophobic' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'confuses free FA with intact TAG' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'blames escape from lipase' FROM q;

-- Q11 [B11 · Lipid Absorption & Routing] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Lipid Absorption & Routing', 'Orlistat is a weight-loss drug that inhibits pancreatic lipase, sharply reducing the amount of dietary fat that is digested and absorbed. A patient taking orlistat long-term is monitored for nutritional deficiencies. Beyond a shortfall in fat itself, which additional deficiency should the clinician most anticipate, and why?', '[{"label": "A", "text": "Vitamin C and the B vitamins, because they are absorbed alongside dietary fat"}, {"label": "B", "text": "Vitamins A, D, E, and K, because orlistat directly blocks the transporters that carry these vitamins across the intestinal wall"}, {"label": "C", "text": "Vitamins A, D, E, and K, because these vitamins are absorbed together with dietary fat and their uptake falls when fat absorption falls"}, {"label": "D", "text": "Iron and calcium, because fat is required to keep these minerals in solution in the gut"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is C because the fat-soluble vitamins A, D, E, and K dissolve in dietary fat and are taken up along with it into the enterocyte and packaged with the absorbed lipid. When orlistat blocks fat digestion and absorption, the fat these vitamins ride along with never gets absorbed, so the vitamins pass out unabsorbed too. The deficiency is a downstream consequence of impaired fat absorption, not a separate drug target.

(Choice C) is correct: A, D, E, and K travel with dietary fat, so blocking fat absorption blocks their absorption as well.
(Choice A) is incorrect: vitamin C and the B vitamins are water-soluble and are absorbed independently of dietary fat, so their status is not tied to fat absorption.
(Choice B) is incorrect: orlistat''s mechanism is inhibition of pancreatic lipase (a fat-digestion enzyme), not blockade of vitamin transporters; the vitamin loss is indirect, through the loss of the fat they dissolve in.
(Choice D) is incorrect: iron and calcium are not fat-soluble vitamins and are not dependent on dietary fat for their absorption in this way.

As a Skill 2 (reasoning about scientific concepts) item, the student links a lipase-blocking drug to fat malabsorption and then to the fate of nutrients that depend on fat for their uptake.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'water-soluble vitamins called fat-dependent' FROM q
  UNION ALL
  SELECT id, 'B', 'process_step_confusion', 'attributes loss to direct transporter block' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'swaps minerals for fat-soluble vitamins' FROM q;

-- Q12 [B12 · Lipid Absorption & Routing] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Lipid Absorption & Routing', 'A lipoprotein is a droplet of lipid cargo wrapped in an amphipathic shell studded with proteins that address it to particular tissues. Consider two such particles described only by their job: Particle 1 is assembled in the intestine and loaded with just-eaten (exogenous) fat that it delivers to peripheral tissues; Particle 2 is assembled in the liver and loaded with fat the liver itself has made (endogenous), which it exports to tissues. A meal of dietary triacylglycerol is eaten. Which particle carries that meal''s fat out of the intestine, and on what basis?', '[{"label": "A", "text": "Particle 2, because all fat destined for peripheral tissues must first be routed through the liver for packaging"}, {"label": "B", "text": "Particle 1, because the liver only handles fat during fasting and is inactive right after a meal"}, {"label": "C", "text": "Particle 2, because the liver-made particle is the only one able to reach peripheral tissues"}, {"label": "D", "text": "Particle 1, because it is the intestine-assembled particle that carries just-eaten dietary fat"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is D because the stem defines the two particles by origin and cargo: Particle 1 is made in the intestine and carries just-eaten (exogenous) fat, while Particle 2 is made in the liver and carries fat the liver synthesized (endogenous). A meal''s triacylglycerol is exogenous fat absorbed by the intestine, so by the roles given, it must leave the intestine in Particle 1. The logic follows entirely from the supplied definitions.

(Choice D) is correct: the meal''s fat is intestine-absorbed exogenous fat, matching Particle 1''s stated role of carrying just-eaten dietary fat out of the intestine.
(Choice A) is incorrect: the stem gives no such rule; Particle 1 delivers dietary fat to peripheral tissues directly, so meal fat need not be routed through the liver first.
(Choice B) is incorrect: while Particle 1 does carry the meal''s fat, the reason offered is false; the liver is not inactive after a meal, so the justification does not follow from the stem.
(Choice C) is incorrect: the stem states Particle 1 also delivers to peripheral tissues, so Particle 2 is not the only particle that can reach them.

As a Skill 2 (reasoning about scientific concepts) item, the student answers purely from the supplied particle roles and the exogenous-versus-endogenous origin of the fat, not from any memorized lipoprotein class name.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'invents mandatory liver-first routing' FROM q
  UNION ALL
  SELECT id, 'B', 'partial_truth', 'right particle, false justification' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'liver particle called sole tissue-reacher' FROM q;

-- Q13 [B13 · Lipid Absorption & Routing] hard skill4 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Lipid Absorption & Routing', 'A subject with an inherited defect eats a meal rich in long-chain triacylglycerol. On intestinal biopsy taken hours after the meal, the enterocytes are engorged with large cytoplasmic fat (triacylglycerol) droplets, yet very little triacylglycerol appears in either the intestinal lymph or the blood. Enzyme assays show that the enterocytes normally hydrolyze the meal''s fat at the brush border, take up the products, and re-esterify them into triacylglycerol inside the cell; the block lies only in loading that triacylglycerol together with apoproteins into the secreted transport particle. Which conclusion is best supported by these findings?', '[{"label": "A", "text": "Re-esterified dietary fat must be assembled into a secreted transport particle before it can leave the enterocyte"}, {"label": "B", "text": "The defect lies in brush-border hydrolysis, so the meal''s fat was never taken up by the enterocytes"}, {"label": "C", "text": "The re-esterified fat can still exit directly into portal blood once the lymphatic route is blocked"}, {"label": "D", "text": "Long-chain fat leaves the enterocyte as free fatty acids that are carried away bound to albumin"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is A because the data isolate exactly one broken step. The enterocytes still hydrolyze the meal''s fat, take up the products, and re-esterify them into triacylglycerol, so uptake works; the only block is loading that triacylglycerol with apoproteins into the secreted transport particle. The consequence is that re-esterified fat piles up as droplets inside the cell and almost none reaches the lymph or blood. If fat could leave by any route without being packaged, it would not accumulate; because it does accumulate precisely when packaging fails, assembly into a secreted transport particle is a required step for the re-esterified fat to exit the enterocyte.

(Choice A) is correct: fat is taken up and re-esterified normally but cannot leave when only the packaging/export step is blocked, so assembly into the secreted particle is what the fat needs in order to exit.
(Choice B) is incorrect: the stem states hydrolysis and uptake are normal and the droplets are re-esterified triacylglycerol, so the block is not at the brush border; the fat was clearly taken up.
(Choice C) is incorrect: the re-esterified triacylglycerol does not appear in blood either (portal or otherwise); a large re-esterified molecule does not diffuse directly into portal blood, and the accumulation shows no alternative exit opens when packaging fails.
(Choice D) is incorrect: the fat inside the cell is re-esterified triacylglycerol, not free fatty acids; albumin carries free fatty acids in blood, which is not what these engorged enterocytes contain, and no such export is occurring.

As a Skill 4 (data-based and statistical reasoning) item, the student must localize the lesion from the biopsy and enzyme data to the packaging step and infer that export of dietary fat requires assembly into a transport particle.', 'hard', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 4, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'process_step_confusion', 'misassigns the block to an earlier (uptake) step the stem says is intact' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'assumes a portal escape route opens when lymphatic export is blocked' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'imports the albumin/free-fatty-acid carrier fact into the wrong context' FROM q;

-- Q14 [C14 · Lipid Mobilization & Transport] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Lipid Mobilization & Transport', 'A subject has fasted overnight. Blood work shows that plasma insulin has fallen well below its fed-state level. Inside the subject''s adipocytes, which outcome is most consistent with this hormonal state?', '[{"label": "A", "text": "Hormone-sensitive lipase is suppressed, so stored triacylglycerol is retained and fat synthesis predominates"}, {"label": "B", "text": "Hormone-sensitive lipase is activated, hydrolyzing stored triacylglycerol to release fatty acids and glycerol into the blood"}, {"label": "C", "text": "Lipoprotein lipase on the capillary surface is activated to load fatty acids into the adipocyte for storage"}, {"label": "D", "text": "Dietary triacylglycerol is packaged into chylomicrons for export into the lymphatic lacteals"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is B because a fall in insulin is the signal of the fasting (post-absorptive) state, and low insulin relieves the suppression of hormone-sensitive lipase (HSL) inside the adipocyte. Active HSL hydrolyzes stored triacylglycerol, mobilizing fatty acids and glycerol into the blood so that other tissues can use fatty acids as fuel. The reasoning runs from the hormonal state (low insulin = fasting) to the metabolic direction (mobilization, not storage).

(Choice B) is correct: low insulin activates HSL, which hydrolyzes stored TAG and releases fatty acids plus glycerol into circulation — the defining event of fasting-state fat mobilization.
(Choice A) is incorrect: it reverses the regulation. High insulin (the fed state) suppresses HSL and favors fat storage; when insulin has fallen, HSL is active and fat is mobilized, not retained.
(Choice C) is incorrect: lipoprotein lipase loading fatty acids for storage is favored by insulin in the fed state. In fasting with low insulin, the adipocyte is releasing fat, not taking it up for storage.
(Choice D) is incorrect: chylomicron assembly is a feature of dietary fat absorption in enterocytes after a meal, not of adipocyte behavior during fasting; it does not describe the fasting hormonal response.

As a Skill 2 (reasoning about scientific concepts) item, it requires the student to connect the fed/fasting hormonal signal to the direction of adipose metabolism rather than recalling a definition.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'insulin-effect inverted' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'LPL uptake vs HSL release' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'chylomicron absorption not mobilization' FROM q;

-- Q15 [C15 · Lipid Mobilization & Transport] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Lipid Mobilization & Transport', 'During a prolonged, stressful physical exertion, a person''s plasma insulin is low while epinephrine and cortisol are elevated. How do these three signals combine to influence stored fat in adipose tissue?', '[{"label": "A", "text": "Epinephrine and cortisol inhibit hormone-sensitive lipase, opposing the low insulin so that net fat breakdown is prevented"}, {"label": "B", "text": "Only insulin controls hormone-sensitive lipase, so epinephrine and cortisol have no bearing on whether fat is mobilized"}, {"label": "C", "text": "The low insulin removes suppression of hormone-sensitive lipase while epinephrine and cortisol add stimulatory drive, so lipolysis is favored"}, {"label": "D", "text": "The elevated epinephrine and cortisol drive lipoprotein lipase to store incoming fatty acids, offsetting the low insulin"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is C because all three signals point the same direction. Low insulin removes the fed-state brake on hormone-sensitive lipase (HSL), while epinephrine and cortisol are stress/fasting hormones that add positive drive onto HSL. When a suppressor is withdrawn and two activators are added, the net effect is strong stimulation of lipolysis and release of fatty acids from stored triacylglycerol.

(Choice C) is correct: the signals converge — falling insulin disinhibits HSL and epinephrine and cortisol stimulate it, so their effects sum to favor mobilization of stored fat.
(Choice A) is incorrect: it assigns epinephrine and cortisol an inhibitory role. These are lipolytic stress hormones that activate HSL; they reinforce, not oppose, the effect of low insulin.
(Choice B) is incorrect: HSL is not controlled by insulin alone. Epinephrine and cortisol independently activate HSL, which is precisely why stress and fasting both mobilize fat.
(Choice D) is incorrect: it confuses the enzymes. Fatty-acid storage via lipoprotein lipase is favored by insulin in the fed state; low insulin plus stress hormones drives release, not storage.

As a Skill 2 (reasoning about scientific concepts) item, it asks the student to integrate several hormonal inputs onto a single regulated enzyme rather than recall one hormone in isolation.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'stress hormones miscast as inhibitory' FROM q
  UNION ALL
  SELECT id, 'B', 'partial_truth', 'insulin-only oversimplification' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'LPL storage vs HSL release' FROM q;

-- Q16 [C16 · Lipid Mobilization & Transport] hard skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Lipid Mobilization & Transport', 'During fasting, an adipocyte hydrolyzes a triacylglycerol molecule, releasing its glycerol backbone and three fatty acids into the blood. In the liver, which portion of that triacylglycerol can serve as a net source of new blood glucose?', '[{"label": "A", "text": "The three fatty acids, because their acetyl-CoA feeds gluconeogenesis, whereas glycerol is only burned for energy"}, {"label": "B", "text": "Both the glycerol and the fatty acids, since every carbon released from the triacylglycerol can be rebuilt into glucose"}, {"label": "C", "text": "Neither portion, because triacylglycerol breakdown products can only be oxidized for ATP and never contribute carbon to glucose"}, {"label": "D", "text": "The glycerol backbone, because it is phosphorylated and enters gluconeogenesis, whereas the fatty acids yield acetyl-CoA and give no net glucose"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is D because the two halves of a triacylglycerol have different metabolic fates. The glycerol backbone travels to the liver, is phosphorylated to glycerol-3-phosphate, and enters gluconeogenesis — glycerol is glucogenic. The fatty acids are broken down to acetyl-CoA, and acetyl-CoA cannot be converted to a net gain of glucose in humans. So only the glycerol portion can raise blood glucose.

(Choice D) is correct: glycerol enters gluconeogenesis and yields net glucose, while the fatty-acyl portion is converted to acetyl-CoA, which provides no net glucose.
(Choice A) is incorrect: it inverts the two fates. Fatty acids become acetyl-CoA, which is not a net glucose source; it is the glycerol, not the fatty acids, that is glucogenic.
(Choice B) is incorrect: fatty-acid-derived acetyl-CoA does not produce net glucose, so not every carbon of the triacylglycerol can be rebuilt into glucose.
(Choice C) is incorrect: it ignores glycerol''s glucogenic role. Glycerol genuinely can be converted to glucose, so the products are not limited to ATP production alone.

As a Skill 2 (reasoning about scientific concepts) item, it requires tracing each fragment of the molecule to its distinct metabolic endpoint rather than recalling a single fact about fat.', 'hard', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'glucogenic fraction swapped' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'acetyl-CoA to net glucose' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'TAG only for ATP' FROM q;

-- Q17 [C17 · Lipid Mobilization & Transport] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Lipid Mobilization & Transport', 'An investigator is studying an enzyme that hydrolyzes triacylglycerol and finds it anchored to the luminal surface of the capillary endothelium in muscle tissue, acting on triacylglycerol carried inside circulating lipid particles as they pass by. Which enzyme is being described, and what is its role?', '[{"label": "A", "text": "Lipoprotein lipase, which frees fatty acids from triacylglycerol carried within circulating particles so they can be taken up by the tissue"}, {"label": "B", "text": "Hormone-sensitive lipase, which frees fatty acids from triacylglycerol carried within circulating particles so they can be taken up by the tissue"}, {"label": "C", "text": "Hormone-sensitive lipase, which hydrolyzes triacylglycerol stored inside the muscle''s own cells for local use"}, {"label": "D", "text": "Pancreatic lipase, which hydrolyzes dietary triacylglycerol at the capillary surface before it enters the bloodstream"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is A because the described location and substrate pin down the enzyme. An enzyme sitting on the luminal surface of capillary endothelium and acting on triacylglycerol carried inside circulating particles is lipoprotein lipase (LPL). LPL frees fatty acids from the triacylglycerol inside those particles so the neighboring tissue can take them up. The key discriminator is where the enzyme acts and on which triacylglycerol pool — circulating (transported) versus stored.

(Choice A) is correct: lipoprotein lipase is positioned on the capillary endothelium and hydrolyzes TAG carried inside circulating particles, delivering fatty acids to the tissue — exactly the scenario described.
(Choice B) is incorrect: the role described (acting on circulating particles at the capillary surface) is correct, but the enzyme is misnamed. Hormone-sensitive lipase does not sit on the endothelium acting on circulating particles.
(Choice C) is incorrect: hormone-sensitive lipase does act on stored intracellular TAG, but the stem places the enzyme on the capillary surface acting on circulating particles, which is not what HSL does.
(Choice D) is incorrect: pancreatic lipase works in the intestinal lumen on dietary fat, not on the capillary endothelium acting on triacylglycerol already inside circulating particles.

As a Skill 2 (reasoning about scientific concepts) item, it requires mapping a described location and substrate pool to the correct enzyme rather than recalling enzyme names from a list.', 'hard', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'process_step_confusion', 'right role, wrong enzyme' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'HSL stored-TAG location swap' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'pancreatic lipase misplaced' FROM q;

-- Q18 [C18 · Lipid Mobilization & Transport] hard skill4 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Lipid Mobilization & Transport', 'A lipoprotein particle is a lipid core wrapped in a protein-containing shell; because protein is denser than lipid, a particle''s density rises as its protein fraction rises. Two particles are analyzed: Particle X is 22% protein and 78% lipid by mass; Particle Y is 6% protein and 94% lipid by mass. Which particle is denser, and why?', '[{"label": "A", "text": "Particle Y, because its higher lipid fraction packs more of the denser component into the particle"}, {"label": "B", "text": "Particle X, because its higher protein fraction packs more of the denser component into the particle"}, {"label": "C", "text": "Particle X, because a larger lipid fraction always makes a particle denser regardless of protein content"}, {"label": "D", "text": "Particle Y, because a lower protein fraction concentrates mass into a smaller volume and raises density"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is B because the stem supplies the governing principle: density rises with protein fraction because protein is denser than lipid. Particle X is 22% protein, while Particle Y is only 6% protein. The particle with the larger share of the denser component (protein) must be the denser particle overall, so Particle X is denser. This follows directly from the supplied composition and the density principle, with no need to recall any lipoprotein class name.

(Choice B) is correct: Particle X has the higher protein fraction (22% vs 6%), and since protein is the denser component, the higher-protein particle is denser.
(Choice A) is incorrect: it treats lipid as the denser component. The stem states protein is denser than lipid, so a higher lipid fraction lowers density rather than raising it.
(Choice C) is incorrect: it reaches the right particle for the wrong reason and also misreads the composition — Particle X has the smaller, not larger, lipid fraction, and a larger lipid fraction would lower density.
(Choice D) is incorrect: it correctly notes Particle Y''s lower protein fraction but draws the wrong conclusion; a lower protein fraction means less of the denser component, so Particle Y is the less dense particle.

As a Skill 4 (reasoning about data and research) item, it requires applying a stated density-composition relationship to the supplied percentages rather than recalling memorized particle densities.', 'hard', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 4, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'lipid miscast as denser' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'right particle wrong reasoning' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'low-protein equals denser' FROM q;

-- Q19 [C19 · Lipid Mobilization & Transport] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Lipid Mobilization & Transport', 'Consider two cholesterol-transport processes. Process 1 delivers cholesterol from the liver outward to peripheral tissues such as artery walls. Process 2 returns excess cholesterol from peripheral tissues back to the liver for disposal. Based only on the direction of cholesterol movement, which process would tend to be protective against cholesterol buildup in artery walls?', '[{"label": "A", "text": "Process 1, because delivering more cholesterol to peripheral tissues supplies them and thereby prevents buildup in artery walls"}, {"label": "B", "text": "Process 2, because returning cholesterol to the liver increases the cholesterol delivered into artery walls and clears it faster"}, {"label": "C", "text": "Process 2, because moving cholesterol out of peripheral tissues toward the liver reduces the amount left to accumulate in artery walls"}, {"label": "D", "text": "Neither, because the direction of cholesterol movement has no bearing on whether cholesterol accumulates in artery walls"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is C because the protective process must be the one that removes cholesterol from the site where it would otherwise accumulate. Process 2 carries excess cholesterol out of peripheral tissues and back to the liver, lowering the cholesterol available to deposit in artery walls. Process 1 moves cholesterol in the opposite direction — toward the periphery — which supplies the very tissues where deposits form. The reasoning is pure transport logic from the supplied directions, not recall of particle names.

(Choice C) is correct: Process 2 moves cholesterol away from peripheral tissues toward the liver, reducing what remains to accumulate in artery walls, so it is protective.
(Choice A) is incorrect: delivering more cholesterol to peripheral tissues (Process 1) increases the local supply that can deposit in artery walls; adding cholesterol to a site does not protect it from buildup.
(Choice B) is incorrect: it names the correct process but reverses its logic; returning cholesterol to the liver removes it from artery walls rather than increasing delivery into them.
(Choice D) is incorrect: direction clearly matters — moving cholesterol toward versus away from a tissue changes whether it accumulates there, which is the whole basis of the comparison.

As a Skill 2 (reasoning about scientific concepts) item, it tests transport logic — which direction of movement clears versus deposits cholesterol — rather than class-name recall.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'delivery miscast as protective' FROM q
  UNION ALL
  SELECT id, 'B', 'partial_truth', 'right process wrong logic' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'direction deemed irrelevant' FROM q;

-- Q20 [C20 · Lipid Mobilization & Transport] easy skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Lipid Mobilization & Transport', 'When adipose tissue releases free fatty acids into the blood, these molecules are largely water-insoluble yet must travel through aqueous plasma to reach other tissues. They accomplish this by binding to the plasma protein albumin. Why is such a soluble carrier necessary?', '[{"label": "A", "text": "Because free fatty acids are already highly water-soluble, albumin simply speeds up their diffusion through plasma"}, {"label": "B", "text": "Because albumin chemically converts free fatty acids into glycerol so they can dissolve in the blood"}, {"label": "C", "text": "Because free fatty acids would otherwise be filtered out by the kidney, and albumin makes them small enough to remain in circulation"}, {"label": "D", "text": "Because free fatty acids are poorly soluble in water, binding a soluble protein keeps them dispersed and transportable in aqueous plasma"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is D because the problem is a solubility mismatch. Free fatty acids are largely nonpolar and poorly soluble in water, yet plasma is aqueous. Binding to a soluble protein such as albumin lets the fatty acids be carried while shielded from the water, so they stay dispersed and transportable. The carrier solves solubility, which is exactly why a water-insoluble molecule needs a soluble escort in plasma.

(Choice D) is correct: free fatty acids are water-insoluble, so a soluble carrier (albumin) is required to keep them dispersed and moving through aqueous plasma.
(Choice A) is incorrect: it denies the premise. Free fatty acids are not highly water-soluble; if they were, no protein carrier would be needed at all.
(Choice B) is incorrect: albumin binds fatty acids noncovalently and transports them; it does not chemically convert them into glycerol, and no such conversion occurs during transport.
(Choice C) is incorrect: the reason for the carrier is insolubility in water, not evasion of kidney filtration; binding albumin actually makes the complex larger, not smaller.

As a Skill 2 (reasoning about scientific concepts) item, it asks the student to reason from a solubility property to the need for a carrier rather than recall that albumin carries fatty acids.', 'easy', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'FFAs deemed water-soluble' FROM q
  UNION ALL
  SELECT id, 'B', 'process_step_confusion', 'carrier as chemical converter' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'renal-filtration rationale' FROM q;

-- Q21 [D1 · Fatty-Acid Structure & Nomenclature] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Fatty-Acid Structure & Nomenclature', 'Two purified fatty acids, X and Y, have identical 18-carbon chains and identical carboxyl groups. Chain X has no carbon-carbon double bonds; chain Y has three cis carbon-carbon double bonds along its tail. A sample of each is warmed slowly, and their pure forms are compared side by side at room temperature. Considering how each chain''s shape lets neighboring molecules approach one another, which comparison of their physical behavior is correct?', '[{"label": "A", "text": "X melts at a higher temperature than Y and tends to be more solid, because its straight chains stack closely and pack tightly"}, {"label": "B", "text": "X melts at a lower temperature than Y and is a liquid at room temperature, because its straight chain repels neighbors"}, {"label": "C", "text": "Y melts at a higher temperature than X and is more solid, because its double bonds add rigidity that raises melting point"}, {"label": "D", "text": "X and Y melt at the same temperature, because they share the same number of carbons and the same carboxyl group"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is A because the decisive difference is chain shape, not chain length. Chain X has no double bonds, so its tail is a straight, extended zig-zag; straight chains can lie side by side and approach one another closely, maximizing the van der Waals contacts between neighbors. More contacts mean more energy is needed to pull the molecules apart, so the tightly packed solid melts at a higher temperature and tends to be solid at room temperature. Chain Y carries three cis double bonds, each of which forces a bend, or kink, into the tail; the kinked chains cannot nest against one another, so they pack loosely, make fewer contacts, and melt at a lower temperature (a liquid at room temperature). Thus the fully saturated X is the higher-melting, more solid of the pair.

(Choice A) is correct: the saturated straight chain (X) stacks closely, so its stronger cumulative packing forces raise its melting point and keep it more solid, while the kinked polyunsaturated chain (Y) packs loosely and melts lower.
(Choice B) is incorrect: it reverses the outcome and invokes a nonexistent mechanism. Straight saturated chains do not repel their neighbors; they attract them closely, which is exactly why X is higher-melting and more solid, not a lower-melting liquid.
(Choice C) is incorrect: cis double bonds do not add rigidity that packs molecules together; they introduce kinks that hold chains apart. That looser packing lowers Y''s melting point rather than raising it, so Y is the more fluid, not the more solid, of the two.
(Choice D) is incorrect: matching carbon count and carboxyl group does not make the melting points equal, because packing depends on chain shape. The presence versus absence of cis kinks changes how tightly the tails stack, and that difference dominates the melting behavior.

As a Skill 2 (reasoning about scientific concepts) item, the student must reason from a described degree of saturation and cis geometry to a predicted physical state, rather than recalling that saturated fats are solid.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'flips which chain is solid and invents chain-chain repulsion for the straight tail' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'treats cis double bonds as rigidity that tightens packing and raises melting point' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'uses equal carbon count/carboxyl to claim equal melting, ignoring chain-shape packing' FROM q;

-- Q22 [D2 · Fatty-Acid Structure & Nomenclature] easy skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Fatty-Acid Structure & Nomenclature', 'A fatty acid is drawn as a straight chain with the carboxyl group at the left end and the terminal methyl (CH3) carbon at the right end. Starting the count at that terminal methyl carbon, the very first carbon-carbon double bond encountered is the one between the third and fourth carbons from that end; a second double bond sits farther in toward the carboxyl group. Using the convention that omega numbering counts to the nearest double bond from the methyl end, how should this fatty acid be classified, and why?', '[{"label": "A", "text": "Omega-6, because the double bond closest to the methyl end is six carbons in from that end"}, {"label": "B", "text": "Omega-3, because the double bond closest to the methyl end is three carbons in from that end"}, {"label": "C", "text": "Omega-3, because there are three carbons between the two double bonds in the chain"}, {"label": "D", "text": "Omega-4, because the first double bond lies between carbons three and four counted from the methyl end"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is B because the omega classification depends only on where the double bond nearest the methyl (omega) end sits, counting from that methyl carbon. Here the counting begins at the terminal methyl carbon, and the first double bond is reached between the third and fourth carbons, meaning the nearest double bond starts at carbon 3 from the methyl end. By definition, an omega-\(n\) fatty acid has its last (methyl-proximal) double bond \(n\) carbons in from that end, so a double bond beginning at carbon 3 makes this an omega-3 fatty acid. The location of the second, more internal double bond and the total number of double bonds do not change the omega designation, which is fixed entirely by the nearest double bond to the methyl end.

(Choice B) is correct: counting from the methyl end, the nearest double bond begins at carbon 3, which is precisely the definition of an omega-3 fatty acid.
(Choice A) is incorrect: omega-6 would require the nearest double bond to begin at carbon 6 from the methyl end, but the stem places the first double bond at carbon 3, not carbon 6. This mislabels a clearly omega-3 chain as the other common polyunsaturated class.
(Choice C) is incorrect: the omega number is not the spacing between the two double bonds; it is the position of the methyl-proximal double bond measured from the methyl carbon. Using the gap between double bonds substitutes an irrelevant count for the defined one, even though it coincidentally lands on 3.
(Choice D) is incorrect: the omega number names the carbon at which the nearest double bond begins (carbon 3), not the higher-numbered carbon it ends on (carbon 4). Choosing 4 misreads the convention as counting to the far side of the double bond.

As a Skill 2 (reasoning about scientific concepts) item, the student applies the omega-counting convention to a described structure to derive the classification, rather than recalling a memorized label.', 'easy', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'adjacent_fact', 'assigns the other common class (omega-6) despite the double bond being at carbon 3' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'computes omega from spacing between the two double bonds rather than distance from the methyl end' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'counts to the far carbon (4) of the double bond instead of the near carbon (3) where it begins' FROM q;

-- Q23 [D3 · Fatty-Acid Structure & Nomenclature] hard skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Fatty-Acid Structure & Nomenclature', 'A biochemist supplies cultured human liver cells with abundant palmitate (a fully saturated 16-carbon fatty acid) plus all the cofactors needed for the cell''s own desaturase enzymes. The cells readily insert a double bond at carbon 9 and can extend and desaturate carbons on the carboxyl side of that position, but they never place a new double bond at any carbon farther from the carboxyl group than carbon 9 (that is, closer to the methyl end). Given only this limitation on where human enzymes can act, why must a polyunsaturated fatty acid whose methyl-proximal double bond lies past carbon 9 be obtained from the diet?', '[{"label": "A", "text": "Humans lack the enzymes to synthesize any fatty acid longer than 16 carbons, so all longer polyunsaturated fatty acids must come from food"}, {"label": "B", "text": "Such fatty acids can be made only in the mitochondrion, and human liver restricts fatty-acid synthesis to the cytosol, so the diet must supply them"}, {"label": "C", "text": "Human desaturases cannot place a double bond past carbon 9 toward the methyl end, so such a fatty acid cannot be made de novo and must be supplied by the diet"}, {"label": "D", "text": "The double bonds in these fatty acids are trans rather than cis, and human enzymes make only cis double bonds, so the trans versions must be eaten"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is C because the only constraint the scenario reports is positional: human desaturases can install double bonds up to carbon 9 (\(\Delta 9\)) and on the carboxyl side of that carbon, but never farther toward the methyl end. A polyunsaturated fatty acid whose methyl-proximal double bond sits beyond carbon 9, such as an omega-6 (linoleic acid) or omega-3 (alpha-linolenic acid) fatty acid, has a double bond in exactly the region human enzymes cannot reach. Because the cell cannot introduce that particular double bond itself, it cannot build the molecule de novo no matter how much precursor is available, so the intact fatty acid (or its double-bond pattern) must be obtained preformed from the diet. That is precisely what makes such a fatty acid ''essential.''

(Choice C) is correct: it ties the essentiality directly to the stated desaturation limit, the inability to place a double bond beyond carbon 9 toward the methyl end, which is the actual reason the molecule cannot be synthesized and must be eaten.
(Choice A) is incorrect: humans can elongate fatty acids past 16 carbons, so chain length is not the barrier. The stem itself notes the cells extend carbons; the limitation is on double-bond position, not on making longer chains.
(Choice B) is incorrect: fatty-acid synthesis is indeed cytosolic, but that compartmentation does not explain essentiality. The cell can make saturated and \(\Delta 9\) fatty acids in the cytosol perfectly well; what it cannot do, in any compartment, is desaturate beyond carbon 9.
(Choice D) is incorrect: essential fatty acids such as linoleic and alpha-linolenic acid are cis-polyunsaturated, not trans, and human enzymes do make cis double bonds. The barrier is the position of the double bond relative to the methyl end, not its cis/trans geometry.

As a Skill 2 (reasoning about scientific concepts) item, the student must reason from a described enzymatic limit to explain why a class of fatty acids is dietary, rather than recalling that linoleic acid is ''essential.''', 'hard', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'attributes essentiality to inability to elongate past 16 carbons rather than the desaturation limit' FROM q
  UNION ALL
  SELECT id, 'B', 'adjacent_fact', 'imports the true cytosolic-synthesis fact but wrongly makes compartmentation the cause of essentiality' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'claims essential FAs are trans and human enzymes only make cis, misassigning the barrier to geometry' FROM q;

-- Q24 [D4 · Fatty-Acid Structure & Nomenclature] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Fatty-Acid Structure & Nomenclature', 'A cell biologist engineers two otherwise identical plasma membranes. In membrane P, the phospholipid tails are fully saturated straight chains. In membrane Q, most of those saturated tails are swapped for chains bearing several cis double bonds, while everything else (head groups, cholesterol content, temperature) is held constant. When the two membranes are compared, how should membrane Q behave relative to membrane P, and why?', '[{"label": "A", "text": "Membrane Q is less fluid, because the added double bonds stiffen each tail and lock the bilayer in place"}, {"label": "B", "text": "Membrane Q is more fluid, because unsaturated tails are longer and longer tails always increase fluidity"}, {"label": "C", "text": "Membrane Q has the same fluidity as P, because fluidity is set by the phospholipid head groups, not the tails"}, {"label": "D", "text": "Membrane Q is more fluid, because the cis double bonds kink the tails and keep them from packing tightly"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is D because membrane fluidity depends on how tightly the phospholipid tails can pack. In membrane P the fully saturated straight tails lie close together, maximizing van der Waals contacts and giving a tightly packed, more ordered, less fluid bilayer. Replacing those tails with chains bearing several cis double bonds, as in membrane Q, introduces kinks that hold neighboring tails apart; the looser packing leaves more room for the chains to move, so the bilayer becomes more disordered and more fluid. Because the only variable changed is the degree of cis unsaturation of the tails, and everything else is held constant, the increased kinking is what raises Q''s fluidity relative to P.

(Choice D) is correct: cis double bonds kink the tails, loosen packing, and thereby raise membrane fluidity, which is exactly the change made in going from saturated P to polyunsaturated Q.
(Choice A) is incorrect: it reverses the effect by treating a double bond as a stiffening feature that locks the bilayer. A cis double bond does introduce a fixed bend, but that bend spreads tails apart and increases mobility rather than immobilizing the membrane, so Q is more, not less, fluid.
(Choice B) is incorrect: it reaches the right direction for the wrong reason. Fluidity here rises because of cis kinks, not because unsaturated tails are longer; in fact longer, more saturated tails pack more tightly and tend to lower fluidity, so ''longer always increases fluidity'' is false.
(Choice C) is incorrect: with head groups, cholesterol, and temperature all held constant, the only changed variable is tail saturation, so the tails, not the head groups, drive the difference. Attributing fluidity to head groups ignores the manipulation described.

As a Skill 2 (reasoning about scientific concepts) item, the student predicts the effect of a described change in tail saturation on membrane fluidity, rather than restating that unsaturated membranes are fluid.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'treats cis double bonds as stiffening the tails and lowering fluidity' FROM q
  UNION ALL
  SELECT id, 'B', 'partial_truth', 'right direction via a false rule that longer tails always raise fluidity' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'attributes fluidity to head groups and ignores the controlled tail-saturation change' FROM q;

-- Q25 [D5 · Fatty-Acid Structure & Nomenclature] easy skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Fatty-Acid Structure & Nomenclature', 'A dataset lists a fatty acid using the shorthand 18:2. A student is told only that this notation gives the number of carbons in the chain followed by the number of carbon-carbon double bonds, and that ''degree of unsaturation'' here refers to the count of carbon-carbon double bonds in the chain. Interpreting 18:2 by this convention, which description is correct?', '[{"label": "A", "text": "18 carbons and 2 carbon-carbon double bonds, giving a degree of unsaturation of 2"}, {"label": "B", "text": "2 carbons and 18 carbon-carbon double bonds, giving a degree of unsaturation of 18"}, {"label": "C", "text": "18 carbons and 2 carbon-carbon double bonds, giving a degree of unsaturation of 16 (18 minus 2)"}, {"label": "D", "text": "20 carbons total and 2 carbon-carbon double bonds, giving a degree of unsaturation of 2"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is A because the shorthand \(18:2\) lists carbons first and double bonds second: it denotes an 18-carbon chain carrying 2 carbon-carbon double bonds. Since the stem defines the degree of unsaturation as the number of carbon-carbon double bonds, that value is simply the second figure, 2. So the correct reading is 18 carbons, 2 double bonds, and a degree of unsaturation of 2, describing a diunsaturated 18-carbon fatty acid such as linoleic acid.

(Choice A) is correct: it reads the two figures in the proper order (18 carbons, then 2 double bonds) and correctly equates the degree of unsaturation with the number of double bonds.
(Choice B) is incorrect: it swaps the two numbers, treating 18 as the number of double bonds and 2 as the number of carbons. A 2-carbon fatty acid cannot hold 18 double bonds, and the notation always lists carbons before double bonds.
(Choice C) is incorrect: it reads the carbon and double-bond counts correctly but then miscomputes the degree of unsaturation by subtracting, \(18-2=16\), as though unsaturation were carbons minus double bonds. The stem defines the degree of unsaturation as the double-bond count itself, which is 2.
(Choice D) is incorrect: it inflates the carbon count to 20, misreading ''18'' as if it needed adjustment. The first figure is taken directly as the number of carbons, so the chain has 18, not 20, carbons.

As a Skill 2 (reasoning about scientific concepts) item, the student decodes a shorthand notation into carbon count, double-bond count, and degree of unsaturation, rather than recalling a specific named fatty acid.', 'easy', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'swaps the notation order, reading carbons as double bonds and vice versa' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'computes degree of unsaturation by subtracting double bonds from carbons' FROM q
  UNION ALL
  SELECT id, 'D', 'scale_unit_error', 'inflates the carbon count from 18 to 20 by misreading the first figure' FROM q;

-- Q26 [D6 · Fatty-Acid Structure & Nomenclature] hard skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Fatty-Acid Structure & Nomenclature', 'A food scientist stores three purified 18-carbon fatty acids under identical conditions (open to air, same temperature): stearic acid (fully saturated), oleic acid (one cis double bond), and linolenic acid (three cis double bonds, each pair separated by a single CH2). Over several weeks she tracks which sample turns rancid first by measuring accumulation of oxidation products. Reasoning from how the number and arrangement of the double bonds affects the reactivity of the carbon-hydrogen bonds along each chain, which fatty acid should oxidize fastest, and why?', '[{"label": "A", "text": "Stearic acid, because its chain packs tightly and the buried C-H bonds are held rigidly, making them the easiest for oxygen to abstract"}, {"label": "B", "text": "Linolenic acid, because each CH2 sitting between two double bonds bears especially weak, reactive C-H bonds, and it has the most such positions"}, {"label": "C", "text": "Oleic acid, because a single cis double bond makes the whole chain most reactive, and adding further double bonds progressively protects the chain"}, {"label": "D", "text": "All three oxidize at the same rate, because they share the same 18-carbon length and the number of double bonds does not change C-H bond reactivity"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is B because susceptibility to oxidation is set by how easily a hydrogen can be pulled off the chain, and that depends on the number and arrangement of the double bonds. A CH2 group flanked on both sides by double bonds (a bis-allylic position) holds C-H bonds that are unusually weak, because the radical left behind after a hydrogen is removed is stabilized by both adjacent double bonds. These are the sites where lipid peroxidation begins. Linolenic acid, with three double bonds arranged in the usual methylene-interrupted pattern (each pair separated by a single CH2), has two such bis-allylic CH2 groups. Oleic acid, with one double bond, has no bis-allylic position, and stearic acid, fully saturated, has none at all. More methylene-interrupted double bonds means more of these reactive positions, so the most polyunsaturated chain oxidizes fastest and turns rancid first.

(Choice B) is correct: linolenic acid has the most bis-allylic CH2 groups, whose especially weak C-H bonds make it the most readily oxidized of the three.
(Choice A) is incorrect: tight packing and saturation do not make C-H bonds easier to abstract. Stearic acid has no double bonds and therefore no allylic or bis-allylic positions, so its C-H bonds are the strongest and least reactive of the three, making it the most oxidation-resistant, not the most vulnerable.
(Choice C) is incorrect: it wrongly claims one double bond maximizes reactivity and that more double bonds protect the chain. In fact reactivity rises with the number of methylene-interrupted double bonds, because each added pair creates another weak bis-allylic C-H, so oleic acid (one double bond, no bis-allylic site) oxidizes more slowly than linolenic acid, not faster.
(Choice D) is incorrect: equal chain length does not equalize reactivity, because the number of double bonds directly controls how many weak bis-allylic C-H positions exist. Saturated, monounsaturated, and polyunsaturated 18-carbon chains differ sharply in oxidation rate for exactly this reason.

As a Skill 2 (reasoning about scientific concepts) item, the student reasons from degree of unsaturation and double-bond arrangement to the reactivity of specific C-H bonds and thus to oxidative susceptibility, rather than recalling that polyunsaturated oils go rancid.', 'hard', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'treats tight packing/saturation as increasing C-H reactivity, reversing the true resistance of saturated chains to oxidation' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'inverts the trend, claiming one double bond maximizes reactivity and further unsaturation protects the chain' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'treats equal chain length as equalizing oxidation rate, ignoring that double-bond count controls bis-allylic C-H reactivity' FROM q;

-- Q27 [E7 · Fatty-Acid Synthesis] hard skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Fatty-Acid Synthesis', 'In a well-fed hepatocyte, the acetyl-CoA needed for cytosolic fatty-acid synthesis is produced inside the mitochondrial matrix, yet the inner mitochondrial membrane has no transporter that moves acetyl-CoA itself into the cytosol. To supply cytosolic acetyl-CoA, the cell instead condenses matrix acetyl-CoA with oxaloacetate to form citrate, exports the citrate, and then cleaves it in the cytosol with ATP-citrate lyase to regenerate acetyl-CoA. What is the most direct reason the cell routes carbon through citrate rather than exporting acetyl-CoA?', '[{"label": "A", "text": "Citrate carries more chemical energy than acetyl-CoA, and that extra energy is required to drive fatty-acid synthesis in the cytosol"}, {"label": "B", "text": "Acetyl-CoA is too reactive to leave the matrix, so it must first be oxidized to citrate before it can be safely transported"}, {"label": "C", "text": "Citrate can traverse the inner membrane on a carrier, whereas acetyl-CoA cannot"}, {"label": "D", "text": "Citrate is the actual two-carbon donor that fatty-acid synthase adds to the growing chain, so it must reach the cytosol intact"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is C because the stem states the barrier explicitly: the inner membrane has no transporter for acetyl-CoA, but the cell can move the two carbons across if it first packages them into a molecule the membrane will accept. Citrate is exactly that vehicle: it crosses on a carrier, and once in the cytosol \(\text{ATP}\)-citrate lyase splits it back into acetyl-CoA and oxaloacetate. The problem to be solved is transport, so the correct reason is that citrate is membrane-permeant and acetyl-CoA is not.

(Choice C) is correct: citrate solves a transport problem — it crosses the inner membrane where acetyl-CoA cannot, delivering the two-carbon unit to the cytosol where it is released as acetyl-CoA again.

(Choice A) is incorrect: the cleavage of citrate by ATP-citrate lyase actually consumes ATP; the shuttle is not a way to import extra energy, and fatty-acid synthesis draws its reducing power from NADPH, not from citrate''s bonds.

(Choice B) is incorrect: forming citrate is a condensation, not an oxidation, and acetyl-CoA''s problem is that it lacks a transporter, not that it is dangerously reactive in the matrix.

(Choice D) is incorrect: the actual two-carbon donor to fatty-acid synthase is malonyl-CoA (made from cytosolic acetyl-CoA), not citrate; citrate is only the carrier that regenerates cytosolic acetyl-CoA before synthesis begins.

This is a Scientific Reasoning and Problem Solving question because you must reason from the stated transport barrier to why an intermediate carrier is required.', 'hard', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'citrate as energy carrier' FROM q
  UNION ALL
  SELECT id, 'B', 'process_step_confusion', 'condensation misread as oxidation' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'confusing carrier with two-carbon donor' FROM q;

-- Q28 [E8 · Fatty-Acid Synthesis] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Fatty-Acid Synthesis', 'During de novo fatty-acid synthesis, acetyl-CoA carboxylase (ACC) uses biotin and ATP to carboxylate acetyl-CoA into malonyl-CoA, and fatty-acid synthase then uses that malonyl-CoA to build the chain. Malonyl-CoA has no metabolic fate other than fatty-acid synthesis, whereas acetyl-CoA feeds many pathways. A student is asked to identify the committed, rate-limiting step of the pathway and to justify the choice. Which enzyme is the committed step, and why?', '[{"label": "A", "text": "Fatty-acid synthase, because it catalyzes the most steps in the pathway and therefore exerts the greatest control over the overall rate"}, {"label": "B", "text": "ACC, because it is the only enzyme in the pathway that requires ATP, and ATP-dependent reactions are always the committed step"}, {"label": "C", "text": "Fatty-acid synthase, because it produces palmitate, and the enzyme that makes the final product is by definition the committed step"}, {"label": "D", "text": "ACC, because once acetyl-CoA is converted to malonyl-CoA the carbon is dedicated to fatty-acid synthesis, making it the first irreversibly committed and controlled step"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is D because a committed step is the first reaction whose product is dedicated to a single pathway, and the stem tells you that malonyl-CoA has no fate other than fatty-acid synthesis while acetyl-CoA feeds many pathways. ACC produces malonyl-CoA, so ACC is the branch point at which carbon becomes irreversibly committed to making fat; that is exactly why the cell places its main regulation there and why it sets the overall rate.

(Choice D) is correct: ACC makes malonyl-CoA, a molecule dedicated solely to fatty-acid synthesis, so it is the first committed and rate-limiting step and the logical control point.

(Choice A) is incorrect: the number of steps an enzyme catalyzes does not define commitment; fatty-acid synthase acts after the pathway is already committed, so it does not gate entry into the pathway.

(Choice B) is incorrect: although ACC is indeed the ATP-requiring enzyme here, requiring ATP does not by itself make a reaction the committed step, and the reasoning (''ATP-dependent reactions are always the committed step'') is a false generalization.

(Choice C) is incorrect: making the final product is not the definition of the committed step; commitment is set at the first pathway-dedicated reaction (ACC), which occurs before the product is formed.

This is a Scientific Reasoning and Problem Solving question because you must apply the definition of a committed, rate-limiting step to the stated fates of the two intermediates.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'most steps equals most control' FROM q
  UNION ALL
  SELECT id, 'B', 'partial_truth', 'ATP use overgeneralized' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'final-product enzyme as committed step' FROM q;

-- Q29 [E9 · Fatty-Acid Synthesis] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Fatty-Acid Synthesis', 'Acetyl-CoA carboxylase (ACC) is allosterically activated by citrate and stimulated by insulin, but it is inhibited both by long-chain fatty acyl-CoA and by phosphorylation triggered by glucagon during fasting. A hepatocyte from a person who has been fasting overnight shows high glucagon, low insulin, and a rising level of long-chain fatty acyl-CoA. Based on the stated regulation of ACC, what is the state of de novo fatty-acid synthesis in this cell?', '[{"label": "A", "text": "Synthesis is largely off, because fasting phosphorylation and rising acyl-CoA both inhibit ACC while the activating signals (insulin, high citrate) are absent"}, {"label": "B", "text": "Synthesis is fully on, because low insulin removes the brake on ACC and lets the enzyme run at maximum rate"}, {"label": "C", "text": "Synthesis is fully on, because the accumulating long-chain fatty acyl-CoA is the substrate ACC needs and therefore drives the enzyme forward"}, {"label": "D", "text": "Synthesis is unaffected, because ACC responds only to citrate and the citrate level is not given, so no prediction can be made"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is A because the stem gives ACC''s regulation and the fasting cell''s signal profile: glucagon-driven phosphorylation inhibits ACC, rising long-chain fatty acyl-CoA inhibits ACC as a feedback product, and the two activators (insulin and high citrate that mark the fed state) are absent. Every relevant signal points the same way, so ACC is shut down and de novo fatty-acid synthesis is largely off — appropriate for a fasting cell that should be burning, not building, fat.

(Choice A) is correct: fasting phosphorylation plus product inhibition by acyl-CoA turn ACC off while the activating fed-state signals are missing, so synthesis is suppressed.

(Choice B) is incorrect: low insulin is a fasting signal that removes activation and permits inhibitory phosphorylation; it does not ''remove a brake'' to speed synthesis up.

(Choice C) is incorrect: long-chain fatty acyl-CoA is the pathway''s downstream product and a feedback inhibitor of ACC, not its substrate (ACC''s substrate is acetyl-CoA); its accumulation slows synthesis.

(Choice D) is incorrect: ACC integrates several inputs — insulin/glucagon phosphorylation and acyl-CoA feedback, not citrate alone — and the given fasting signals are enough to predict that synthesis is off.

This is a Scientific Reasoning and Problem Solving question because you must integrate multiple regulatory inputs to predict whether the pathway is active in a defined physiological state.', 'hard', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'low insulin misread as activating' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'product mistaken for substrate' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'only-citrate regulation claim' FROM q;

-- Q30 [E10 · Fatty-Acid Synthesis] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Fatty-Acid Synthesis', 'Fatty-acid oxidation strips electrons from a fatty acid, generating reduced carriers such as \(\text{NADH}\) and \(\text{FADH}_2\). Fatty-acid synthesis runs the opposite chemistry: each elongation cycle includes two reduction steps that build the fully reduced methylene carbons of the finished chain — first reducing an oxygenated (keto) carbon, and later reducing a carbon-carbon double bond. Given that synthesis must ADD electrons to build these reduced carbons, which cofactor does the pathway consume, and why?', '[{"label": "A", "text": "NAD+, because the reduction steps oxidize the intermediates and NAD+ collects the electrons that are removed"}, {"label": "B", "text": "NADPH, because building the reduced carbons of a fatty acid requires an electron donor, and NADPH is the cell''s reductive-biosynthesis currency"}, {"label": "C", "text": "FADH2, because the same carrier that is produced during oxidation is reused to donate electrons during synthesis"}, {"label": "D", "text": "ATP alone, because reduction steps are driven purely by phosphate-bond energy and need no separate electron donor"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is B because the stem says the pathway must ADD electrons to turn the intermediate carbons into fully reduced methylene carbons. Adding electrons is a reduction, and a reduction needs a reducing agent — an electron donor. The cell''s dedicated reducing agent for anabolism is \(\text{NADPH}\), so fatty-acid synthesis consumes \(\text{NADPH}\), in mirror-image contrast to oxidation, which produces the reduced carriers \(\text{NADH}\) and \(\text{FADH}_2\).

(Choice B) is correct: making reduced carbons requires an electron donor, and \(\text{NADPH}\) is the reductive-biosynthesis currency that supplies those electrons.

(Choice A) is incorrect: \(\text{NAD}^+\) is an electron acceptor used to oxidize substrates; it cannot donate the electrons that a reductive synthesis step needs, and using it would run the chemistry backward.

(Choice C) is incorrect: \(\text{FADH}_2\) is a product of oxidation, not the reductant of synthesis; the synthetic reductions use \(\text{NADPH}\), and the pathway does not recycle oxidation''s carriers as its electron source.

(Choice D) is incorrect: \(\text{ATP}\) contributes to committing carbon (via ACC) but cannot itself donate electrons; a reduction still requires a separate electron donor, namely \(\text{NADPH}\).

This is a Scientific Reasoning and Problem Solving question because you must reason from the redox direction of the pathway to identify the correct type of cofactor it must consume.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'oxidant supplied for a reduction' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'oxidation carrier reused in synthesis' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'ATP replaces electron donor' FROM q;

-- Q31 [E11 · Fatty-Acid Synthesis] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Fatty-Acid Synthesis', 'Fatty-acid synthase is a cytosolic multienzyme complex on which the growing chain stays tethered to an acyl carrier protein arm. The complex works in cycles: it begins from a two-carbon primer and, in each cycle, condenses on a new two-carbon unit followed by reduction, dehydration, and a second reduction, then repeats. If the finished human product is palmitate, a saturated 16-carbon fatty acid, how many condensation cycles of this type must the complex run to assemble one palmitate from the initial primer?', '[{"label": "A", "text": "8 cycles, because 8 additions of a 2-carbon unit give 16 carbons"}, {"label": "B", "text": "14 cycles, because 16 carbons are assembled one carbon at a time except for the primer"}, {"label": "C", "text": "7 cycles, because the 2-carbon primer plus seven 2-carbon additions gives 2 + 14 = 16 carbons"}, {"label": "D", "text": "16 cycles, because one cycle is required to place each carbon of the final chain"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is C because the chain starts from a 2-carbon primer and each cycle lengthens it by exactly 2 carbons. To reach 16 carbons you must add \(16 - 2 = 14\) more carbons, and \(14 \div 2 = 7\) cycles. Counting the primer''s 2 carbons plus \(7 \times 2 = 14\) added carbons gives \(2 + 14 = 16\), so 7 condensation cycles build one palmitate.

(Choice C) is correct: 7 cycles add 14 carbons to the 2-carbon primer for a 16-carbon product.

(Choice A) is incorrect: it forgets that the primer already supplies the first 2 carbons, so it counts one extra cycle; 8 cycles would give 2 + 16 = 18 carbons.

(Choice B) is incorrect: each cycle adds a 2-carbon unit, not a single carbon, so treating the build as one-carbon-at-a-time doubles the cycle count.

(Choice D) is incorrect: it assigns one cycle per carbon atom, ignoring both the 2-carbon-per-cycle addition and the 2-carbon primer.

This is a Scientific Reasoning and Problem Solving question because you must reason from the described cyclic 2-carbon addition to the number of cycles that yields the stated chain length.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'process_step_confusion', 'primer carbons double-counted' FROM q
  UNION ALL
  SELECT id, 'B', 'scale_unit_error', 'one-carbon-per-cycle assumption' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'one cycle per carbon atom' FROM q;

-- Q32 [E12 · Fatty-Acid Synthesis] hard skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Fatty-Acid Synthesis', 'Acetyl-CoA carboxylase spends ATP to attach a molecule of \(\text{CO}_2\) onto acetyl-CoA, forming the three-carbon malonyl-CoA. Fatty-acid synthase then uses malonyl-CoA — not free acetyl-CoA — as the two-carbon donor in each condensation. During that condensation, the \(\text{CO}_2\) that was just added is released again, and its departure makes the new carbon–carbon bond form readily. Only 2 of malonyl-CoA''s 3 carbons end up in the fatty acid. Which statement best explains the role of that added-then-released \(\text{CO}_2\)?', '[{"label": "A", "text": "It stays behind as the terminal carboxyl carbon of the finished chain, which is why palmitate ends in a \\(-\\text{COOH}\\) group rather than a methyl group"}, {"label": "B", "text": "It is retained in the growing chain as one of the two carbons added each cycle, so over many cycles malonyl-CoA ends up contributing all three of its carbons"}, {"label": "C", "text": "It supplies the electrons used in the reduction steps of each cycle, coupling the carboxylation event directly to the reductive part of the pathway"}, {"label": "D", "text": "It is a temporary activating handle: adding it primes the carbon, and its loss during condensation drives the C–C bond formation, so it is not incorporated"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is D because the stem describes a bookkeeping cycle: ACC spends ATP to put \(\text{CO}_2\) on acetyl-CoA (making malonyl-CoA), and that same \(\text{CO}_2\) leaves during the condensation, its departure making the new C–C bond form readily. Because the \(\text{CO}_2\) is added and then removed, only 2 of malonyl-CoA''s 3 carbons are incorporated; the \(\text{CO}_2\) acts as a temporary activating handle, not as a building block. This is exactly why malonyl-CoA, rather than acetyl-CoA itself, serves as the two-carbon donor: the added carboxyl makes the subsequent condensation thermodynamically favorable.

(Choice D) is correct: the \(\text{CO}_2\) primes the carbon and is released to drive the condensation, so it never joins the chain.

(Choice A) is incorrect: the \(\text{CO}_2\) leaves during condensation, so it cannot become a permanent carbon of palmitate; the carboxyl carbon of the finished chain comes from the primer, not from the departing \(\text{CO}_2\).

(Choice B) is incorrect: it directly contradicts the stem — only 2 of malonyl-CoA''s 3 carbons are incorporated, because the third (the added \(\text{CO}_2\)) is released each cycle.

(Choice C) is incorrect: the reduction steps draw electrons from NADPH; \(\text{CO}_2\) is not an electron donor, and its role here is activation-and-release, not supplying reducing equivalents.

This is a Scientific Reasoning and Problem Solving question because you must track the fate of the carbons and reason about why the added \(\text{CO}_2\) is not incorporated.', 'hard', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'added CO2 becomes carboxyl carbon' FROM q
  UNION ALL
  SELECT id, 'B', 'process_step_confusion', 'all three malonyl carbons kept' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'CO2 as electron source' FROM q;

-- Q33 [E13 · Fatty-Acid Synthesis] medium skill4 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Fatty-Acid Synthesis', 'The overall stoichiometry for de novo synthesis of one molecule of palmitate (16 carbons) is:

\[ 8\ \text{acetyl-CoA} + 7\ \text{ATP} + 14\ \text{NADPH} \rightarrow 1\ \text{palmitate} \]

A hepatocyte synthesizes 3 molecules of palmitate. Assuming the reaction proceeds exactly as written, how many molecules of NADPH and how many molecules of acetyl-CoA does the cell consume in total?', '[{"label": "A", "text": "42 NADPH and 24 acetyl-CoA"}, {"label": "B", "text": "14 NADPH and 8 acetyl-CoA"}, {"label": "C", "text": "42 NADPH and 21 acetyl-CoA"}, {"label": "D", "text": "24 NADPH and 42 acetyl-CoA"}]'::jsonb, 'A', 'This question falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is A because the per-palmitate stoichiometry is fixed, so you scale each reactant coefficient by 3. Each palmitate requires 14 NADPH, so \(14 \times 3 = 42\) NADPH; each palmitate requires 8 acetyl-CoA, so \(8 \times 3 = 24\) acetyl-CoA. Thus 3 palmitates consume 42 NADPH and 24 acetyl-CoA.

(Choice A) is correct: \(14 \times 3 = 42\) NADPH and \(8 \times 3 = 24\) acetyl-CoA.

(Choice B) is incorrect: 14 NADPH and 8 acetyl-CoA are the amounts for a single palmitate; this forgets to multiply by 3.

(Choice C) is incorrect: the NADPH is scaled correctly to 42, but 21 acetyl-CoA comes from \(7 \times 3\), mistakenly scaling the ATP coefficient (7) rather than the acetyl-CoA coefficient (8).

(Choice D) is incorrect: it swaps the two totals, assigning acetyl-CoA the NADPH value (42) and NADPH the acetyl-CoA value (24).

This is a Data-Based and Statistical Reasoning question because you must extract the correct coefficients from the supplied stoichiometric equation, pair each with the right reactant, and scale them to compute the required totals.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 4, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'process_step_confusion', 'forgot to scale by 3' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'scaled ATP coefficient for acetyl-CoA' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'swapped the two totals' FROM q;

-- Q34 [E14 · Fatty-Acid Synthesis] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Fatty-Acid Synthesis', 'In the cell, fatty-acid synthesis occurs in the cytosol while beta-oxidation of fatty acids occurs in the mitochondrial matrix, and the two pathways are under reciprocal regulation so that the signals turning one on tend to turn the other off. A student proposes that if both pathways ran simultaneously at full speed in the same compartment, the cell would gain a metabolic advantage. Why does keeping synthesis and oxidation in separate compartments with reciprocal control benefit the cell?', '[{"label": "A", "text": "It lets the cell run both pathways at once, doubling the rate at which fatty acids are turned over and increasing net energy yield"}, {"label": "B", "text": "It prevents a futile cycle: running both at once would build and immediately burn the same fatty acids, wasting ATP and NADPH for no net gain"}, {"label": "C", "text": "It ensures the NADH produced by synthesis is delivered directly to the oxidation machinery for immediate reuse"}, {"label": "D", "text": "It is required because the two pathways share every enzyme, so they must be physically separated to avoid competing for the same active sites"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is B because synthesis consumes \(\text{ATP}\) and \(\text{NADPH}\) to build a fatty acid, while oxidation breaks that same fatty acid back down. If both ran at once on the same molecules, the cell would spend energy building and then immediately dismantling fatty acids with no net gain — a futile cycle. Physical separation (cytosol vs. matrix) plus reciprocal regulation ensures only one direction runs at a time, so the invested \(\text{ATP}\) and \(\text{NADPH}\) are not wasted.

(Choice B) is correct: separation and reciprocal control prevent the simultaneous synthesize-and-burn futile cycle that would waste \(\text{ATP}\) and \(\text{NADPH}\).

(Choice A) is incorrect: running both at full speed does not increase energy yield; it dissipates energy, because the product of one pathway is the substrate the other destroys.

(Choice C) is incorrect: synthesis consumes \(\text{NADPH}\) and does not produce \(\text{NADH}\) to hand off; oxidation generates its own \(\text{NADH}\) and \(\text{FADH}_2\), so there is no such direct hand-off from synthesis.

(Choice D) is incorrect: the two pathways use different enzymes (e.g., cytosolic fatty-acid synthase vs. the matrix beta-oxidation enzymes), so shared active sites are not the reason for compartmentation.

This is a Scientific Reasoning and Problem Solving question because you must reason from the energy cost of each pathway to why simultaneous operation would be wasteful.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'futile cycle framed as beneficial' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'synthesis produces NADH for reuse' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'pathways share all enzymes' FROM q;

-- Q35 [E15 · Fatty-Acid Synthesis] hard skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Fatty-Acid Synthesis', 'Malonyl-CoA, the first committed intermediate of fatty-acid synthesis, also inhibits carnitine acyltransferase I (CPT-I), the enzyme that loads fatty acids onto carnitine for transport into the mitochondrial matrix, where beta-oxidation occurs. In the fed state, insulin drives ACC to make abundant malonyl-CoA. Using only this information, what is the net effect of the fed state on the two pathways, and by what logic?', '[{"label": "A", "text": "Both synthesis and oxidation are turned ON, because more malonyl-CoA feeds synthesis while the extra fatty acids it produces are simultaneously imported for oxidation"}, {"label": "B", "text": "Synthesis is turned OFF and oxidation is turned ON, because high malonyl-CoA is a fasting signal that shuts down ACC and opens CPT-I"}, {"label": "C", "text": "Synthesis is turned ON and oxidation is turned OFF, because the same rise in malonyl-CoA that supplies the synthesis machinery also blocks CPT-I, barring fatty acids from entering the mitochondria to be oxidized"}, {"label": "D", "text": "Only synthesis is affected; oxidation is unchanged, because CPT-I inhibition by malonyl-CoA blocks import but the matrix enzymes keep oxidizing fatty acids already inside"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is C because one molecule, malonyl-CoA, points both pathways in opposite directions at the same time. In the fed state insulin drives ACC to make abundant malonyl-CoA, which (1) is the committed two-carbon donor that supplies fatty-acid synthesis, turning synthesis ON, and (2) inhibits CPT-I, so fatty acids cannot be loaded onto carnitine and imported into the matrix, turning oxidation OFF. The single rise in malonyl-CoA therefore both feeds building and blocks the entry step of burning — the cell does not synthesize and oxidize fatty acids at the same time.

(Choice C) is correct: the malonyl-CoA that supplies synthesis also blocks CPT-I, so the fed state switches synthesis ON and oxidation OFF through one molecule.

(Choice A) is incorrect: it misses the inhibition half of the logic; malonyl-CoA blocks CPT-I, so oxidation is turned off, not run in parallel with synthesis.

(Choice B) is incorrect: it reverses the physiology — high malonyl-CoA is a fed-state, not fasting, signal, and it inhibits CPT-I rather than opening it.

(Choice D) is incorrect: by blocking CPT-I, malonyl-CoA cuts off the supply of new fatty acids into the matrix, so oxidation is effectively shut down at its entry step; it does not leave oxidation running on already-imported substrate as a steady state.

This is a Scientific Reasoning and Problem Solving question because you must trace one regulator''s effect in two directions to predict the coordinated state of both pathways.', 'hard', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'partial_truth', 'ignores CPT-I inhibition' FROM q
  UNION ALL
  SELECT id, 'B', 'reversed_relationship', 'fed signal read as fasting' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'entry block treated as no effect' FROM q;

-- Q36 [F16 · Cholesterol & Triacylglycerol Synthesis] easy skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Cholesterol & Triacylglycerol Synthesis', 'In addition to modulating membrane fluidity, cholesterol serves as the direct precursor from which steroid hormones, bile acids, and vitamin D are built. A researcher engineers cultured adrenal cells that can neither synthesize cholesterol de novo nor take it up from the medium. Assuming the cells remain viable long enough to be studied, which downstream product would these cells be LEAST able to generate?', '[{"label": "A", "text": "Phosphatidylcholine, a glycerophospholipid of the plasma membrane"}, {"label": "B", "text": "Glycogen, the branched storage polymer of glucose"}, {"label": "C", "text": "Palmitate, the 16-carbon product of de novo fatty-acid synthesis"}, {"label": "D", "text": "Cortisol, a steroid hormone normally secreted by the adrenal cortex"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is D because the stem states that cholesterol is the direct precursor of steroid hormones. Cortisol is a steroid hormone, so a cell with no cholesterol source has no starting material to build it; the other listed products are assembled from unrelated precursors that the cholesterol block does not touch.

(Choice D) is correct: cortisol is a steroid hormone, and the stem tells us steroid hormones are made FROM cholesterol. With neither synthesis nor uptake of cholesterol, the cell lacks the precursor and cannot make cortisol.
(Choice A) is incorrect: phosphatidylcholine is a glycerophospholipid built on a glycerol-3-phosphate backbone with fatty acyl chains and a choline head group, none of which derive from cholesterol; its production does not require a cholesterol supply.
(Choice B) is incorrect: glycogen is polymerized from glucose units and has no biosynthetic dependence on cholesterol, so a cholesterol-deprived cell can still make it.
(Choice C) is incorrect: palmitate is assembled from acetyl-CoA and malonyl-CoA by fatty-acid synthase; this pathway is independent of cholesterol, so the block does not prevent palmitate synthesis.

This question tests Skill 2 (Scientific Reasoning and Problem-Solving): the student must map a supplied biological role of cholesterol onto a specific downstream product and reason about what a precursor-deprived cell can and cannot make.', 'easy', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'adjacent_fact', 'membrane lipid confused with cholesterol-derived product' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'unrelated storage molecule assumed cholesterol-dependent' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'fatty-acid product mistaken for a cholesterol derivative' FROM q;

-- Q37 [F17 · Cholesterol & Triacylglycerol Synthesis] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Cholesterol & Triacylglycerol Synthesis', 'In the cholesterol biosynthetic pathway, the rate-limiting enzyme is normally feedback-inhibited by cholesterol, the pathway''s own end product. A new drug potently and selectively blocks this rate-limiting enzyme. A liver cell is treated with the drug while its need for cholesterol remains unchanged. Which combination of effects best predicts the cell''s response?', '[{"label": "A", "text": "De novo synthesis of cholesterol falls, and the cell compensates by upregulating uptake of cholesterol from the blood"}, {"label": "B", "text": "De novo synthesis of cholesterol falls, and uptake of cholesterol from the blood is also downregulated"}, {"label": "C", "text": "De novo synthesis of cholesterol rises because the feedback signal is removed, and uptake from the blood increases"}, {"label": "D", "text": "De novo synthesis of cholesterol is unchanged because the end product still inhibits the enzyme, while uptake increases"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is A because blocking the rate-limiting enzyme cuts flux through the pathway regardless of the feedback signal, so internal cholesterol production drops; because the cell''s cholesterol requirement is unchanged, it must make up the shortfall by pulling cholesterol in from the blood.

(Choice A) is correct: a drug that blocks the committed, rate-limiting enzyme lowers pathway flux and therefore lowers de novo cholesterol output. Since demand is unchanged, the falling internal supply drives compensatory upregulation of uptake from the circulation.
(Choice B) is incorrect: it correctly predicts that synthesis falls, but a cell whose cholesterol need is unmet would not simultaneously shut down uptake; that would worsen the deficit rather than compensate for it.
(Choice C) is incorrect: it confuses inhibiting the enzyme with removing feedback on the enzyme. Feedback inhibition acts ON this enzyme; a drug that blocks the enzyme overrides that regulation and lowers flux, so synthesis cannot rise.
(Choice D) is incorrect: the drug blocks the enzyme directly, so flux falls whether or not end-product feedback is present; the presence of feedback does not keep synthesis constant when the catalytic step itself is inhibited.

This question tests Skill 2 (Scientific Reasoning and Problem-Solving): the student must distinguish inhibiting an enzyme from relieving feedback on it and reason from reduced flux to a compensatory change in uptake.', 'hard', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'partial_truth', 'correct flux drop paired with wrong compensatory direction' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'blocking enzyme misread as relieving feedback' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'feedback presence assumed to hold flux constant despite enzyme block' FROM q;

-- Q38 [F18 · Cholesterol & Triacylglycerol Synthesis] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Cholesterol & Triacylglycerol Synthesis', 'Hepatocytes and lactating mammary cells both carry out heavy fatty-acid and cholesterol biosynthesis. Every reductive step in these anabolic pathways is powered by \(\text{NADPH}\), the hydride donor consumed as acetyl units are reduced into growing lipid chains. In a cell running this synthesis at a high rate, the \(\text{NADPH}\) delivered to the biosynthetic enzymes is drawn down and must be continuously regenerated to keep the pathway going. A student notes that the tissues most active in lipid synthesis also sustain unusually high flux through one particular glucose-catabolizing pathway. Which pathway must these tissues run at high flux to meet the demand created by their lipid synthesis?', '[{"label": "A", "text": "Glycolysis, whose payoff phase oxidizes glyceraldehyde-3-phosphate to 1,3-bisphosphoglycerate"}, {"label": "B", "text": "The pentose phosphate pathway, whose oxidative branch oxidizes glucose-6-phosphate"}, {"label": "C", "text": "The citric acid cycle, whose dehydrogenases oxidize its carbon intermediates"}, {"label": "D", "text": "Beta-oxidation of fatty acids, which oxidizes the acyl chain two carbons at a time"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is B because reductive lipid synthesis consumes \(\text{NADPH}\), and the cell must regenerate that specific cofactor at the same rate it is spent. Among the pathways offered, only the oxidative branch of the pentose phosphate pathway (PPP) reduces \(\text{NADP}^+\) to \(\text{NADPH}\): as glucose-6-phosphate is oxidized (by glucose-6-phosphate dehydrogenase and 6-phosphogluconate dehydrogenase), \(\text{NADPH}\) is generated. A tissue doing heavy fatty-acid and cholesterol synthesis therefore must run high PPP flux to keep the biosynthetic enzymes supplied with reductant. The stem tells you the cofactor that is consumed (\(\text{NADPH}\)); you must recall which glucose-catabolizing pathway regenerates that cofactor.

(Choice B) is correct: the PPP oxidative reactions produce \(\text{NADPH}\) specifically, matching the cofactor spent in anabolic reductions. This is why lipogenic tissues such as liver, adipose, and lactating mammary gland sustain high PPP flux.
(Choice A) is incorrect: the payoff phase of glycolysis oxidizes glyceraldehyde-3-phosphate and regenerates \(\text{NADH}\), not \(\text{NADPH}\). \(\text{NADH}\) is a catabolic electron carrier and cannot substitute for the \(\text{NADPH}\) that biosynthetic enzymes require, so upregulating glycolysis does not refill the reductant the lipid pathways draw on.
(Choice C) is incorrect: the citric acid cycle dehydrogenases oxidize its carbon intermediates to produce \(\text{NADH}\) and \(\text{FADH}_2\), which feed oxidative phosphorylation, not \(\text{NADPH}\); it supplies electrons for catabolic energy production rather than the reducing power consumed in synthesis.
(Choice D) is incorrect: beta-oxidation is a degradative pathway that breaks fatty acids down and yields \(\text{FADH}_2\) and \(\text{NADH}\); it is reciprocally shut off when synthesis is active, and it does not regenerate \(\text{NADPH}\).

This question tests Skill 2 (Scientific Reasoning and Problem-Solving): the student must connect the \(\text{NADPH}\)-consuming nature of reductive lipid synthesis to the pathway that regenerates that specific cofactor, and infer why high-lipogenic tissues need high pentose phosphate pathway flux.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'glycolysis wrongly recalled as the NADPH source (it regenerates NADH)' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'central oxidative pathway offered, but produces NADH/FADH2 rather than NADPH' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'opposing catabolic pathway (fatty-acid degradation) offered as the reductant source' FROM q;

-- Q39 [F19 · Cholesterol & Triacylglycerol Synthesis] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Cholesterol & Triacylglycerol Synthesis', 'In liver and adipose tissue, a triacylglycerol is assembled by esterifying a glycerol-3-phosphate backbone with three fatty acyl-CoA molecules. Compared with storing the same fatty acids as free (unesterified) fatty acids inside the cell, what advantage does packaging them as triacylglycerol provide for a cell that must stockpile large amounts of fat?', '[{"label": "A", "text": "Esterification oxidizes the fatty-acid carbons further, raising the energy released per gram when the fat is later mobilized"}, {"label": "B", "text": "Attaching the fatty acids to glycerol-3-phosphate keeps the stored molecule negatively charged, improving its solubility in the aqueous cytosol"}, {"label": "C", "text": "Esterifying the carboxyl groups removes their ionizable, amphipathic character, yielding an uncharged neutral lipid that coalesces into anhydrous droplets and does not disrupt membranes"}, {"label": "D", "text": "Forming three ester bonds introduces double bonds into the acyl chains, increasing the fluidity of the stored droplet"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is C because esterifying each fatty acid''s carboxyl group to glycerol neutralizes the charged, detergent-like free fatty acid, producing an uncharged neutral lipid. Neutral triacylglycerols aggregate into water-free droplets that pack densely and, unlike free fatty acids, do not act as detergents that would disrupt cellular membranes.

(Choice C) is correct: free fatty acids are amphipathic and their ionized carboxylates make them membrane-disrupting detergents. Esterification masks the carboxyl group, giving a neutral, anhydrous storage form that coalesces into droplets ideal for bulk storage.
(Choice A) is incorrect: forming an ester bond does not oxidize the acyl carbons; the reduced state of the chain (not any change from esterification) sets the energy yield, so this misstates the chemistry.
(Choice B) is incorrect: the point of esterification is to eliminate the charge and make the lipid insoluble and anhydrous; keeping it charged and water-soluble would defeat the purpose of compact fat storage.
(Choice D) is incorrect: ester-bond formation between glycerol and acyl-CoA does not create carbon-carbon double bonds in the chains; saturation of the stored chains is unchanged by esterification.

This question tests Skill 2 (Scientific Reasoning and Problem-Solving): the student must reason from the chemical consequence of esterifying a carboxyl group to the storage advantages of a neutral, anhydrous lipid.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'esterification wrongly equated with oxidation' FROM q
  UNION ALL
  SELECT id, 'B', 'reversed_relationship', 'storage form assumed to stay charged and soluble' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'ester bonds confused with introduction of double bonds' FROM q;

-- Q40 [F20 · Cholesterol & Triacylglycerol Synthesis] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Cholesterol & Triacylglycerol Synthesis', 'Gram for gram, triacylglycerol stores substantially more metabolic energy than glycogen. Two structural facts contribute: the carbons of fatty-acyl chains are far more reduced than those of the glucose units in glycogen, and stored triacylglycerol is essentially anhydrous, whereas cellular glycogen is bound to roughly twice its own weight in water. Which statement correctly connects these facts to the energy stored per gram of tissue?', '[{"label": "A", "text": "More-reduced carbons yield more energy when oxidized, but the bound water surrounding glycogen adds stored energy, partially offsetting fat''s advantage on a per-gram-of-tissue basis"}, {"label": "B", "text": "The bound water is the main energy reservoir, so glycogen''s hydration makes it the denser fuel per gram despite fat''s more-reduced carbons"}, {"label": "C", "text": "Because fatty-acyl carbons are more oxidized than glucose carbons, oxidizing them releases more energy, and fat''s anhydrous state further concentrates that fuel per gram"}, {"label": "D", "text": "More-reduced carbons release more energy on oxidation, and because triacylglycerol is nearly water-free, almost its entire mass is fuel; both effects raise usable energy per gram of storage tissue"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is D because the energy released on oxidation rises with how reduced the starting carbons are, and fatty-acyl carbons are more reduced than glucose carbons, so fat yields more energy per carbon. On top of that, storing fat without bound water means almost the entire stored mass is fuel, while glycogen''s heavy hydration (roughly \(2\times\) its own mass in water) means much of its stored mass is non-fuel water. Both effects push energy-per-gram of storage tissue higher for fat.

(Choice D) is correct: it correctly pairs the two given facts, more-reduced carbons giving a higher oxidation yield and the anhydrous state meaning nearly all the mass is fuel, and combines them to explain fat''s higher energy density per gram of tissue.
(Choice A) is incorrect: bound water carries no metabolic energy; the water associated with glycogen is dead weight that lowers, not adds to, glycogen''s energy per gram of tissue.
(Choice B) is incorrect: it inverts the roles by treating hydration water as an energy reservoir, when in fact that water dilutes glycogen''s fuel content per gram.
(Choice C) is incorrect: it reverses the redox direction. Fatty-acyl carbons are more reduced, not more oxidized, than glucose carbons; being more reduced is what gives them the larger oxidation yield. Its conclusion happens to be right, but the stated reason contradicts the stem.

This question tests Skill 2 (Scientific Reasoning and Problem-Solving): the student must integrate carbon reduction state and hydration to reason about energy stored per gram of tissue.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'bound water credited with storing energy' FROM q
  UNION ALL
  SELECT id, 'B', 'reversed_relationship', 'hydration made the dominant energy reservoir' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'carbon reduction state inverted to oxidized' FROM q;

-- Q41 [F21 · Cholesterol & Triacylglycerol Synthesis] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Cholesterol & Triacylglycerol Synthesis', 'Adipocytes store enormous quantities of triacylglycerol, yet they lack glycerol kinase, the enzyme that would let them phosphorylate free glycerol to glycerol-3-phosphate. Building a triacylglycerol still requires a glycerol-3-phosphate backbone. A researcher incubates adipocytes in a medium that supplies abundant free fatty acids but no glucose and no other carbon substrates. What happens to the cells'' ability to store the incoming fatty acids as triacylglycerol, and why?', '[{"label": "A", "text": "Storage is impaired, because without glucose the adipocyte cannot generate the dihydroxyacetone phosphate from glycolysis that it needs to form its glycerol-3-phosphate backbone"}, {"label": "B", "text": "Storage is unaffected, because the abundant free fatty acids can be phosphorylated directly to provide the glycerol-3-phosphate backbone"}, {"label": "C", "text": "Storage is unaffected, because the adipocyte can phosphorylate the free glycerol released from lipolysis using glycerol kinase to regenerate its backbone"}, {"label": "D", "text": "Storage is enhanced, because removing glucose forces the cell to divert all incoming fatty acids into triacylglycerol rather than oxidizing them"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is A because the adipocyte''s only route to glycerol-3-phosphate is glycolytic: glucose is broken down to dihydroxyacetone phosphate, which is reduced to glycerol-3-phosphate. Lacking glycerol kinase, the cell cannot make the backbone from free glycerol, so cutting off glucose (with no other carbon substrate provided) removes its sole source of glycerol-3-phosphate and it cannot esterify the incoming fatty acids into triacylglycerol.

(Choice A) is correct: adipose depends on glucose because glycolysis supplies dihydroxyacetone phosphate, the precursor of glycerol-3-phosphate, and the missing glycerol kinase means there is no alternative backbone source. No glucose means no backbone means no triacylglycerol assembly.
(Choice B) is incorrect: fatty acids are esterified onto the glycerol backbone as acyl-CoA; they are not phosphorylated to become glycerol-3-phosphate, so their abundance cannot substitute for the missing backbone precursor.
(Choice C) is incorrect: the stem states the adipocyte lacks glycerol kinase, so it specifically cannot phosphorylate free glycerol; this route is unavailable in adipose tissue.
(Choice D) is incorrect: without a glycerol-3-phosphate backbone the cell cannot form triacylglycerol at all, so removing glucose reduces, rather than enhances, storage; the claim reverses the actual effect.

This question tests Skill 2 (Scientific Reasoning and Problem-Solving): the student must trace the origin of the glycerol-3-phosphate backbone in a tissue lacking glycerol kinase and reason about why fat storage there depends on glucose.', 'hard', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'process_step_confusion', 'fatty acids mistaken as backbone precursor' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'glycerol kinase route assumed present in adipose' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'glucose removal wrongly predicted to boost storage' FROM q;

-- Q42 [G1 · Fatty-Acid Activation & Carnitine Entry] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Fatty-Acid Activation & Carnitine Entry', 'Before a fatty acid can be oxidized, it is activated by fatty acyl-CoA synthetase: fatty acid + CoA-SH + ATP → fatty acyl-CoA + AMP + PPi. Energy bookkeeping for β-oxidation charges this activation step as costing "two ATP equivalents" rather than one. Which feature of the reaction best justifies that accounting?', '[{"label": "A", "text": "Two separate ATP molecules are consumed in sequence, one to load CoA and one to load carnitine"}, {"label": "B", "text": "ATP is cleaved between the α and β phosphates, releasing AMP + PPi, so two phosphoanhydride bonds must be regenerated to restore ATP"}, {"label": "C", "text": "The reaction releases ADP + Pi, and a second ATP is later spent to phosphorylate the AMP back to ADP"}, {"label": "D", "text": "The FADH2 and NADH produced in the first oxidation cycle each cost the cell one ATP to replace"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is B because the synthetase cleaves ATP all the way to AMP + \(\text{PP}_i\), not to ADP + \(\text{P}_i\). Regenerating ATP from AMP requires rebuilding two phosphoanhydride bonds (AMP → ADP → ATP), so the single activation step has drawn down the cell''s high-energy phosphate pool by two ATP equivalents even though only one ATP molecule was hydrolyzed.

(Choice B) is correct: because the bond broken releases AMP + \(\text{PP}_i\), two high-energy bonds are spent, and it takes two phosphorylation steps to remake ATP — hence "2 ATP equivalents."
(Choice A) is incorrect: carnitine loading (the CPT-I step) does not consume ATP; the acyl group is simply transesterified from CoA onto carnitine, so there is no second ATP hydrolysis here.
(Choice C) is incorrect: activation does not yield ADP + \(\text{P}_i\); it yields AMP + \(\text{PP}_i\). Treating the products as ADP + \(\text{P}_i\) would wrongly imply only one high-energy bond was used.
(Choice D) is incorrect: the \(\text{FADH}_2\) and \(\text{NADH}\) generated during β-oxidation are energy-yielding products, not costs; they are not why activation is charged as two ATP.

This item rewards Skill 2 reasoning: rather than recalling a stated ATP tally, you must trace which bonds of ATP are broken and infer the true energetic cost of restoring the nucleotide pool.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'invents a second ATP at the carnitine step' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'assumes ATP→ADP+Pi cleavage instead of ATP→AMP+PPi' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'confuses energy-yielding products with an energy cost' FROM q;

-- Q43 [G2 · Fatty-Acid Activation & Carnitine Entry] hard skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Fatty-Acid Activation & Carnitine Entry', 'A researcher runs the carnitine shuttle in isolated mitochondria supplied with a single, fixed pool of free carnitine and no way to synthesize more. Long-chain acyl groups are fed in continuously, and matrix β-oxidation proceeds steadily for a long time without the carnitine pool ever running out — even though every acyl group that enters the matrix must first be loaded onto a carnitine molecule. Separately, the investigator measures no ATP consumption attributable to the transport step itself, despite the acyl group being moved off one thioester carrier and onto another. Which single feature of the CPT-II step on the matrix side best accounts for both observations at once?', '[{"label": "A", "text": "It hydrolyzes acyl-carnitine to a free fatty acid plus carnitine, so carnitine is freed but the bond energy is lost as heat"}, {"label": "B", "text": "It consumes one ATP to load the acyl group onto matrix CoA, which is what regenerates the free carnitine for reuse"}, {"label": "C", "text": "It transesterifies the acyl group from carnitine onto matrix CoA, freeing carnitine to shuttle back out and conserving the thioester bond energy"}, {"label": "D", "text": "It leaves the acyl group on carnitine in the matrix and instead activates a fresh carnitine, so the original carrier is permanently spent"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is C because both observations follow from what CPT-II does on the matrix side: it transfers the acyl group from acyl-carnitine onto a matrix CoA by transesterification. That single reaction frees the carnitine — which recycles back across the translocase — so a fixed, un-replenished carnitine pool is never depleted no matter how many acyl groups are shuttled in. Because the transfer is a transesterification (thioester of CoA \(\rightarrow\) ester of carnitine \(\rightarrow\) thioester of CoA), the acyl group''s high-energy bond is conserved throughout, so no ATP is spent on the transport step itself. One mechanism therefore explains both the non-depletion of carnitine and the absence of transport-linked ATP use.

(Choice C) is correct: CPT-II transesterifies the acyl group onto matrix CoA, regenerating free carnitine (which shuttles back out, so the pool is catalytic) and conserving the thioester bond energy (so transport costs no ATP).
(Choice A) is incorrect: CPT-II does not hydrolyze acyl-carnitine to a free fatty acid, and the bond energy is not lost as heat — it is preserved by transesterification onto CoA. Although hydrolysis would also free carnitine (matching the first observation), it would forfeit the bond energy and require re-activation at ATP cost, contradicting the measured absence of transport-linked ATP use.
(Choice B) is incorrect: no ATP is consumed at the CPT-II step; the whole point is that transesterification is energy-neutral for transport. (The 2 ATP-equivalent cost of fatty-acid oxidation is paid earlier, at cytosolic activation to acyl-CoA, not here.)
(Choice D) is incorrect: the acyl group does not stay on carnitine — if it did, carnitine could never be freed and the fixed pool would be exhausted, contradicting the observation. CPT-II moves the acyl group off carnitine and onto CoA, which is precisely what recycles the carrier.

This item rewards Skill 2 reasoning: from a described conservation of the carnitine pool and the absence of transport-linked ATP use, you must infer the one matrix-side reaction — transesterification onto CoA that regenerates free carnitine — that makes the carrier catalytic and the transport energy-neutral.', 'hard', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'process_step_confusion', 'thinks CPT-II hydrolyzes to free fatty acid and loses the bond energy as heat' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'believes ATP is spent at the matrix transfer step to reload CoA' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'thinks acyl group stays on carnitine so the carrier is consumed rather than recycled' FROM q;

-- Q44 [G3 · Fatty-Acid Activation & Carnitine Entry] hard skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Fatty-Acid Activation & Carnitine Entry', 'An infant with a CPT-I deficiency develops profound hypoglycemia during an overnight fast, yet — unlike a child with a defect in gluconeogenesis — shows strikingly LOW blood ketone levels for the degree of hypoglycemia. Which consequence of the enzyme defect best accounts for this "hypoketotic" pattern during fasting?', '[{"label": "A", "text": "The block forces the liver to oxidize its own ketone bodies for fuel, depleting them before they can be exported to the blood"}, {"label": "B", "text": "Long-chain acyl-CoA builds up inside the matrix and is diverted preferentially into cholesterol synthesis rather than into ketone bodies"}, {"label": "C", "text": "CPT-I deficiency directly inactivates HMG-CoA synthase, the committed enzyme that carries out ketone-body synthesis in the liver"}, {"label": "D", "text": "Long-chain fatty acids cannot enter the matrix, so the liver makes little acetyl-CoA for ketones and loses the fat fuel that spares glucose"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is D because CPT-I is the entry point for long-chain fatty acids into the mitochondrial matrix. When it is defective, long-chain fat cannot be oxidized, so the liver produces little acetyl-CoA from fat during fasting. Ketone bodies are made FROM that acetyl-CoA, so ketones stay low (hypoketotic). At the same time, the fat that normally spares glucose during a fast cannot be burned, so glucose is consumed and hypoglycemia results.

(Choice D) is correct: it links the single lesion — no long-chain fatty acid entry — to both findings: low acetyl-CoA (hence low ketones) and loss of fat-derived fuel (hence hypoglycemia).
(Choice A) is incorrect: the liver lacks SCOT and cannot consume ketone bodies; it is a net exporter, so it does not oxidize them before export.
(Choice B) is incorrect: with CPT-I blocked, long-chain acyl-CoA does NOT accumulate in the matrix — it never gets in. There is no matrix surplus to divert into cholesterol.
(Choice C) is incorrect: CPT-I and HMG-CoA synthase are distinct enzymes; the shuttle defect starves ketogenesis of substrate rather than inactivating the ketogenic enzyme.

This item rewards Skill 2 reasoning: you must trace a rate-limiting transport block forward to its downstream fasting consequences rather than recall a labeled syndrome.', 'hard', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'forgets liver lacks SCOT and cannot use ketones' FROM q
  UNION ALL
  SELECT id, 'B', 'process_step_confusion', 'claims matrix acyl-CoA accumulates despite entry block' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'conflates CPT-I with HMG-CoA synthase' FROM q;

-- Q45 [G4 · Fatty-Acid Activation & Carnitine Entry] easy skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Fatty-Acid Activation & Carnitine Entry', 'A patient with a complete carnitine shuttle defect is given two dietary fats: a long-chain (18-carbon) fatty acid and a medium-chain (8-carbon) fatty acid. The medium-chain fat is oxidized at a normal rate while the long-chain fat is barely oxidized. Which difference between the two fats best explains this outcome?', '[{"label": "A", "text": "Medium-chain fatty acids diffuse into the matrix without the carnitine shuttle, whereas long-chain fatty acids depend on it for entry"}, {"label": "B", "text": "Medium-chain fatty acids are oxidized in the cytosol, bypassing the mitochondrion entirely"}, {"label": "C", "text": "Medium-chain fatty acids skip the activation step and enter β-oxidation without being converted to an acyl-CoA"}, {"label": "D", "text": "Medium-chain fatty acids use a different set of β-oxidation enzymes that do not require FAD or NAD+"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is A because short- and medium-chain fatty acids (roughly under 12 carbons) cross the inner membrane freely and are activated to acyl-CoA inside the matrix, so their oxidation does not need CPT-I or carnitine. Long-chain fatty acids cannot cross on their own and depend entirely on the carnitine shuttle, so a shuttle defect selectively blocks them.

(Choice A) is correct: the medium-chain fat bypasses the carnitine shuttle by diffusing into the matrix, while the long-chain fat is stranded when the shuttle fails.
(Choice B) is incorrect: β-oxidation of medium-chain fat still occurs in the mitochondrial matrix, not the cytosol; only its entry is shuttle-independent.
(Choice C) is incorrect: medium-chain fatty acids are still activated to acyl-CoA — just inside the matrix — so they do not skip activation.
(Choice D) is incorrect: both chain lengths use the same four-step β-oxidation chemistry with \(\text{FAD}\) and \(\text{NAD}^+\); the difference is the mode of entry, not the enzyme set.

This item rewards Skill 2 reasoning: you must attribute a selective oxidation difference to the entry route rather than to an invented change in the oxidation machinery.', 'easy', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'places medium-chain oxidation in the cytosol' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'claims medium-chain fat skips activation' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'invents a separate cofactor-free enzyme set' FROM q;

-- Q46 [G5 · Fatty-Acid Activation & Carnitine Entry] hard skill4 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Fatty-Acid Activation & Carnitine Entry', 'Isolated mitochondria are given a fixed saturating supply of palmitate (C16, long-chain) or octanoate (C8, medium-chain), and the β-oxidation rate of each is measured as the carnitine concentration in the medium is raised across a wide range:

| Carnitine (µM) | Palmitate rate | Octanoate rate |
|---|---|---|
| 0 | 6 | 96 |
| 10 | 40 | 97 |
| 25 | 78 | 96 |
| 50 | 95 | 97 |
| 100 | 97 | 96 |

Based only on these data, which conclusion is best supported?', '[{"label": "A", "text": "Carnitine availability is rate-limiting for octanoate oxidation, whereas palmitate oxidation is limited by a downstream β-oxidation enzyme"}, {"label": "B", "text": "Carnitine availability is rate-limiting for palmitate oxidation until the transport step saturates, whereas octanoate oxidation is carnitine-independent"}, {"label": "C", "text": "Raising carnitine inhibits palmitate oxidation once transport is saturated, since the palmitate rate stops climbing at high carnitine"}, {"label": "D", "text": "Both fatty acids require carnitine, but palmitate simply has a higher maximal oxidation rate than octanoate"}]'::jsonb, 'B', 'This is a biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is B because the shape of each dose-response curve identifies which step controls the rate. Palmitate oxidation is nearly zero without carnitine (6), climbs steeply as carnitine is added (40, 78), and then levels off near 97 once carnitine is no longer scarce — a classic rise-then-plateau. That pattern means carnitine supply sets the palmitate rate over the rising portion (it is titratable/rate-limiting), and the plateau simply marks where the carnitine-dependent transport step has saturated and some other, carnitine-independent step now caps the flux. Octanoate, by contrast, is already at ~96 with zero carnitine and does not change as carnitine is raised, so its oxidation never depends on carnitine — consistent with a medium-chain fatty acid that enters the matrix without the shuttle.

(Choice B) is correct: the rising-then-plateauing palmitate curve shows carnitine is rate-limiting up to saturation, and the flat octanoate curve shows octanoate is carnitine-independent.
(Choice A) is incorrect: it reverses the two curves. Octanoate is the flat one (already maximal at 0 carnitine), so carnitine cannot be limiting for it; palmitate is the one whose rate tracks carnitine.
(Choice C) is incorrect: a plateau is saturation, not inhibition. The palmitate rate stays high (~97) at high carnitine rather than falling, so nothing here shows carnitine inhibits oxidation once transport is saturated.
(Choice D) is incorrect: both curves plateau at essentially the same maximal rate (~97 vs ~96), so palmitate does not have a higher maximum; and octanoate reaches its maximum at zero carnitine, which directly contradicts the claim that it requires carnitine.

This item rewards Skill 4 reasoning: you must read the shape of each dose-response curve — where it starts, where it rises, and where it plateaus — to infer that carnitine is a titratable rate-limiting factor for long-chain oxidation but irrelevant to medium-chain oxidation, rather than reading any single baseline value.', 'hard', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 4, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'swaps which curve (flat vs rising) tracks carnitine' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'misreads a saturation plateau as active inhibition' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'over-reads the shared plateau as common carnitine dependence and misattributes a higher maximal rate to palmitate' FROM q;

-- Q47 [G6 · Fatty-Acid Activation & Carnitine Entry] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Fatty-Acid Activation & Carnitine Entry', 'The activation reaction fatty acid + CoA-SH + ATP → fatty acyl-CoA + AMP + PPi is, on its own, only modestly favorable and reversible. In the cell it runs essentially to completion in the forward direction. Which factor is most responsible for making activation effectively irreversible?', '[{"label": "A", "text": "AMP is rapidly rephosphorylated to ATP, regenerating a reactant and driving the reaction backward"}, {"label": "B", "text": "The thioester bond of acyl-CoA is high-energy, so the product is thermodynamically unstable and reverts spontaneously"}, {"label": "C", "text": "Inorganic pyrophosphatase hydrolyzes the PPi product to two Pi, removing a product and pulling the equilibrium forward"}, {"label": "D", "text": "CPT-I immediately transfers the acyl group to carnitine, an exergonic step that reverses the synthetase reaction"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is C because the released \(\text{PP}_i\) is a product of the activation reaction, and a ubiquitous inorganic pyrophosphatase cleaves it into two \(\text{P}_i\). By continuously removing \(\text{PP}_i\), the cell prevents the reverse reaction and, by Le Chatelier''s principle, pulls the equilibrium toward acyl-CoA. This coupled hydrolysis is what converts a near-reversible step into an effectively irreversible one.

(Choice C) is correct: destroying the \(\text{PP}_i\) product removes it from the equilibrium, so the forward reaction is driven to completion.
(Choice A) is incorrect: rephosphorylating AMP to ATP would regenerate a reactant and, if anything, favor the reverse direction — the opposite of what makes activation irreversible.
(Choice B) is incorrect: the acyl-CoA thioester is indeed high-energy, but that reservoir of energy is what powers later steps; it does not cause the product to revert spontaneously.
(Choice D) is incorrect: the CPT-I transesterification moves the acyl group forward toward oxidation; it does not reverse the synthetase step, and it is not the driving force for irreversibility.

This item rewards Skill 2 reasoning: you must apply the principle of product removal (Le Chatelier) to explain how \(\text{PP}_i\) hydrolysis commits an otherwise reversible reaction.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'regenerating a reactant framed as driving forward' FROM q
  UNION ALL
  SELECT id, 'B', 'partial_truth', 'true thioester energy, wrong consequence' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'misassigns the carnitine step as the driving force' FROM q;

-- Q48 [H7 · Beta-Oxidation] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Beta-Oxidation', 'During one round of mitochondrial \(\beta\)-oxidation, an enzyme has just added water across the \(trans\)-\(\Delta 2\) double bond of an enoyl-CoA, producing a 3-hydroxyacyl-CoA. Which transformation occurs in the very next step of the cycle, and what cofactor change accompanies it?', '[{"label": "A", "text": "A new \\(trans\\)-\\(\\Delta 2\\) double bond is introduced, reducing \\(\\text{FAD}\\) to \\(\\text{FADH}_2\\)"}, {"label": "B", "text": "Thiolase cleaves the bond to release acetyl-CoA, reducing \\(\\text{NAD}^+\\) to \\(\\text{NADH}\\)"}, {"label": "C", "text": "The 3-hydroxyl group is oxidized to a 3-keto group, reducing \\(\\text{FAD}\\) to \\(\\text{FADH}_2\\)"}, {"label": "D", "text": "The 3-hydroxyl group is oxidized to a 3-keto group, reducing \\(\\text{NAD}^+\\) to \\(\\text{NADH}\\)"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is D because hydration is the second of the four \(\beta\)-oxidation steps, so the intermediate described is a 3-hydroxyacyl-CoA about to enter step 3: the 3-hydroxyl (an alcohol) is oxidized to a 3-keto group. Oxidizing a C–OH to a C=O is a large-enough energy drop that \(\text{NAD}^+\) serves as the acceptor, generating \(\text{NADH}\).

(Choice D) is correct: after hydration, 3-hydroxyacyl-CoA dehydrogenase oxidizes the alcohol to a ketone and passes the electrons to \(\text{NAD}^+\), yielding \(\text{NADH}\).
(Choice A) is incorrect: introducing the \(trans\)-\(\Delta 2\) double bond with \(\text{FAD}\) is step 1, which already happened before the hydration described in the stem—it is not the next step.
(Choice B) is incorrect: thiolysis is step 4 and does release acetyl-CoA, but it does not reduce a cofactor and it does not immediately follow hydration; the oxidation of the alcohol comes first.
(Choice C) is incorrect: the alcohol→ketone oxidation does happen next, but it uses \(\text{NAD}^+\), not \(\text{FAD}\); \(\text{FAD}\) is the acceptor only for the earlier C–C→C=C step.

By locating the described intermediate within the ordered sequence and predicting the next reaction and its cofactor, this item assesses Skill 2 (reasoning about scientific principles).', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'process_step_confusion', 'reports step 1 as if it were next' FROM q
  UNION ALL
  SELECT id, 'B', 'process_step_confusion', 'skips to thiolysis and attaches wrong cofactor' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'correct step, wrong carrier (FAD for alcohol oxidation)' FROM q;

-- Q49 [H8 · Beta-Oxidation] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Beta-Oxidation', 'A student compares mitochondrial \(\beta\)-oxidation with cytosolic fatty-acid synthesis and notes that the two pathways run ''backward'' relative to each other. Which single contrast between the two pathways is stated correctly?', '[{"label": "A", "text": "\\(\\beta\\)-Oxidation carries its acyl intermediates on coenzyme A, whereas synthesis carries them on acyl carrier protein (ACP)"}, {"label": "B", "text": "\\(\\beta\\)-Oxidation uses \\(\\text{NADPH}\\) as its reducing agent, whereas synthesis uses \\(\\text{NAD}^+\\) and \\(\\text{FAD}\\) as oxidants"}, {"label": "C", "text": "\\(\\beta\\)-Oxidation adds two-carbon units from malonyl-CoA, whereas synthesis removes two-carbon units as acetyl-CoA"}, {"label": "D", "text": "\\(\\beta\\)-Oxidation occurs in the cytosol, whereas synthesis occurs in the mitochondrial matrix"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is A because although the two pathways use similar-looking chemistry in reverse, they are kept separate partly by their carriers: the degradative pathway tethers acyl groups to coenzyme A, while the synthetic pathway tethers the growing chain to acyl carrier protein. Each of the other options swaps a genuine feature of one pathway onto the other.

(Choice A) is correct: \(\beta\)-oxidation intermediates are acyl-CoA species, whereas synthesis intermediates are acyl-ACP species—a real, correctly assigned distinction.
(Choice B) is incorrect: it reverses the redox roles. \(\beta\)-Oxidation is oxidative (reduces \(\text{NAD}^+\) and \(\text{FAD}\)), while synthesis is reductive (consumes \(\text{NADPH}\)).
(Choice C) is incorrect: it swaps the building blocks. Synthesis adds two-carbon units derived from malonyl-CoA; \(\beta\)-oxidation removes two-carbon units as acetyl-CoA.
(Choice D) is incorrect: it reverses the compartments. \(\beta\)-Oxidation is in the mitochondrial matrix; synthesis is cytosolic.

By testing which specific pathway feature is assigned to the correct pathway rather than merely recalling a list, this item assesses Skill 2 (reasoning about scientific principles).', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'redox roles of the two pathways swapped' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'malonyl-CoA vs acetyl-CoA building blocks swapped' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'subcellular compartments swapped' FROM q;

-- Q50 [H9 · Beta-Oxidation] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Beta-Oxidation', 'The two oxidation steps of \(\beta\)-oxidation hand their electrons to different carriers. Reasoning purely from the type of bond being made or broken, why does the first oxidation reduce \(\text{FAD}\) while the third oxidation reduces \(\text{NAD}^+\)?', '[{"label": "A", "text": "Step 1 oxidizes an alcohol to a ketone, a larger drop suited to \\(\\text{FAD}\\); step 3 converts a C–C bond into a C=C bond, a smaller drop suited to \\(\\text{NAD}^+\\)"}, {"label": "B", "text": "Step 1 converts a C–C single bond into a C=C double bond, a smaller energy drop suited to \\(\\text{FAD}\\); step 3 oxidizes an alcohol to a ketone, a larger drop suited to \\(\\text{NAD}^+\\)"}, {"label": "C", "text": "Step 1 removes water to form a double bond, so \\(\\text{FAD}\\) is required; step 3 adds water across that bond, so \\(\\text{NAD}^+\\) is required"}, {"label": "D", "text": "Step 1 uses \\(\\text{FAD}\\) because it occurs on the inner membrane, whereas step 3 uses \\(\\text{NAD}^+\\) because it occurs in the matrix"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is B because the carrier choice tracks the chemistry of each oxidation. Making a C=C double bond from adjacent C–H/C–H carbons is a comparatively modest oxidation that \(\text{FAD}\) accepts, whereas oxidizing a carbon that already bears an –OH up to a full carbonyl (C=O) is a larger oxidation that \(\text{NAD}^+\) accepts.

(Choice B) is correct: it matches the C–C→C=C dehydrogenation to \(\text{FAD}\) (step 1) and the alcohol→ketone oxidation to \(\text{NAD}^+\) (step 3), reasoning from the bond changes.
(Choice A) is incorrect: it swaps the two reactions—step 1 is the double-bond formation and step 3 is the alcohol oxidation, not the reverse.
(Choice C) is incorrect: it mislabels the chemistry entirely. Neither oxidation is a hydration/dehydration; adding water across the double bond is the separate, non-redox step 2.
(Choice D) is incorrect: cofactor choice is set by the redox chemistry, not by a supposed difference in where the two steps occur; both take place in the matrix.

By deriving each carrier from the underlying oxidation chemistry rather than recalling it, this item assesses Skill 2 (reasoning about scientific principles).', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'chemistry of steps 1 and 3 swapped' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'calls the oxidations hydration/dehydration' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'cofactor determined by location, not chemistry' FROM q;

-- Q51 [H10 · Beta-Oxidation] easy skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Beta-Oxidation', 'A myristoyl-CoA (14-carbon acyl-CoA) enters the mitochondrial matrix and completes exactly one full turn of \(\beta\)-oxidation. What does this single cycle yield?', '[{"label": "A", "text": "One acetyl-CoA, two \\(\\text{NADH}\\), and one \\(\\text{FADH}_2\\), leaving a 12-carbon acyl-CoA"}, {"label": "B", "text": "Two acetyl-CoA, one \\(\\text{NADH}\\), and one \\(\\text{FADH}_2\\), leaving a 10-carbon acyl-CoA"}, {"label": "C", "text": "One acetyl-CoA, one \\(\\text{NADH}\\), and one \\(\\text{FADH}_2\\), leaving a 12-carbon acyl-CoA"}, {"label": "D", "text": "One acetyl-CoA, one \\(\\text{NADH}\\), and one \\(\\text{FADH}_2\\), leaving a 13-carbon acyl-CoA"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is C because one turn of \(\beta\)-oxidation has exactly one \(\text{FAD}\)-linked oxidation (step 1) and one \(\text{NAD}^+\)-linked oxidation (step 3), and thiolysis (step 4) clips off a single two-carbon acetyl-CoA. Removing two carbons from the 14-carbon myristoyl-CoA leaves a 12-carbon acyl-CoA.

(Choice C) is correct: 1 acetyl-CoA + 1 \(\text{NADH}\) + 1 \(\text{FADH}_2\), and 14 − 2 = 12 carbons remain.
(Choice A) is incorrect: it double-counts \(\text{NADH}\). Only step 3, oxidation of the 3-hydroxyl to a 3-keto group, reduces \(\text{NAD}^+\), so a single cycle makes just one \(\text{NADH}\).
(Choice B) is incorrect: it removes two acetyl-CoA (four carbons) in one turn; that is the product of two cycles. A single cycle releases only one acetyl-CoA and shortens the chain by two carbons.
(Choice D) is incorrect: each cycle shortens the chain by two carbons, not one, so a 14-carbon acyl-CoA becomes 12 carbons, not 13.

By tallying the products and remaining chain length for one described cycle, this item assesses Skill 2 (reasoning about scientific principles).', 'easy', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'process_step_confusion', 'counts two NADH per cycle' FROM q
  UNION ALL
  SELECT id, 'B', 'process_step_confusion', 'releases two acetyl-CoA per single cycle' FROM q
  UNION ALL
  SELECT id, 'D', 'scale_unit_error', 'shortens chain by one carbon' FROM q;

-- Q52 [H11 · Beta-Oxidation] hard skill4 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Beta-Oxidation', 'Palmitate (16 C) is fully oxidized through 7 cycles of \(\beta\)-oxidation, giving 8 acetyl-CoA, 7 \(\text{NADH}\), and 7 \(\text{FADH}_2\). Using the yields \(\text{NADH} = 2.5\) ATP, \(\text{FADH}_2 = 1.5\) ATP, and each acetyl-CoA through the TCA cycle \(= 10\) ATP, and subtracting the ATP equivalents spent to activate the fatty acid, what is the net ATP yield?', '[{"label": "A", "text": "108 ATP"}, {"label": "B", "text": "107 ATP"}, {"label": "C", "text": "129 ATP"}, {"label": "D", "text": "106 ATP"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is D because summing the electron carriers and acetyl-CoA gives \(8 \times 10 = 80\), \(7 \times 2.5 = 17.5\), and \(7 \times 1.5 = 10.5\), for a gross of \(108\) ATP. Activating the fatty acid consumes ATP down to AMP plus \(\text{PP}_\text{i}\)—two high-energy phosphate bonds, i.e., 2 ATP equivalents—so \(108 - 2 = 106\) ATP.

(Choice D) is correct: \(80 + 17.5 + 10.5 - 2 = 106\) ATP.
(Choice A) is incorrect: 108 is the gross yield before subtracting the activation cost; the question asks for the net.
(Choice B) is incorrect: 107 results from subtracting only 1 ATP for activation, but activation cleaves ATP to AMP + \(\text{PP}_\text{i}\), costing 2 high-energy bonds.
(Choice C) is incorrect: 129 comes from using the older whole-number yields (acetyl-CoA = 12, \(\text{NADH}\) = 3, \(\text{FADH}_2\) = 2), which give \(8 \times 12 + 7 \times 3 + 7 \times 2 - 2 = 129\); the stem specifies the modern P/O yields, so the gross is 108, not 131.

By carrying out the multi-step arithmetic on the supplied stoichiometry and yields, this item assesses Skill 4 (data-based and statistical reasoning).', 'hard', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 4, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'partial_truth', 'gross yield, forgot activation cost' FROM q
  UNION ALL
  SELECT id, 'B', 'scale_unit_error', 'subtracts only 1 ATP for activation' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'uses old whole-number yields (12/3/2)' FROM q;

-- Q53 [H12 · Beta-Oxidation] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Beta-Oxidation', 'Stearoyl-CoA is the activated form of stearate, an 18-carbon saturated fatty acid. If it is oxidized completely to acetyl-CoA units, how many \(\beta\)-oxidation cycles are required and how many acetyl-CoA molecules are produced?', '[{"label": "A", "text": "8 cycles produce 9 acetyl-CoA"}, {"label": "B", "text": "9 cycles produce 9 acetyl-CoA"}, {"label": "C", "text": "9 cycles produce 18 acetyl-CoA"}, {"label": "D", "text": "8 cycles produce 8 acetyl-CoA"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is A because an 18-carbon chain is split into two-carbon acetyl-CoA units, giving \(18/2 = 9\) acetyl-CoA. Each \(\beta\)-oxidation cycle removes two carbons, but the final cycle cleaves a 4-carbon acyl-CoA (butyryl-CoA) into two acetyl-CoA at once, so the number of cuts (cycles) is one fewer than the number of pieces: \(9 - 1 = 8\) cycles.

(Choice A) is correct: for a \(2n\)-carbon chain, \(n = 9\) acetyl-CoA and \(n - 1 = 8\) cycles.
(Choice B) is incorrect: it counts one cycle per acetyl-CoA. The final cycle yields two acetyl-CoA, so cycles equal acetyl-CoA minus one.
(Choice C) is incorrect: 18 acetyl-CoA would require the chain to be split into one-carbon units; \(\beta\)-oxidation removes two carbons at a time.
(Choice D) is incorrect: 8 cycles is right, but they liberate 9 acetyl-CoA, not 8, because the last cycle produces two.

By converting a given chain length into cycle and product counts using the two-carbon rule, this item assesses Skill 2 (reasoning about scientific principles).', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'one cycle per acetyl-CoA (off-by-one)' FROM q
  UNION ALL
  SELECT id, 'C', 'scale_unit_error', 'splits into one-carbon units' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'cycles equal acetyl-CoA, undercounts final pair' FROM q;

-- Q54 [H13 · Beta-Oxidation] easy skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Beta-Oxidation', 'Margaric acid is a 17-carbon saturated fatty acid. When its activated form is taken through \(\beta\)-oxidation to completion, how does the set of end products differ from that of an even-chain fatty acid?', '[{"label": "A", "text": "Every round releases propionyl-CoA instead of acetyl-CoA"}, {"label": "B", "text": "The final round leaves a 3-carbon propionyl-CoA in addition to the acetyl-CoA units"}, {"label": "C", "text": "The final round leaves a single unpaired 1-carbon formyl-CoA plus the acetyl-CoA units"}, {"label": "D", "text": "The products are identical—only acetyl-CoA is formed, just an odd number of molecules"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is B because a 17-carbon chain cannot be divided evenly into two-carbon pieces. Successive removals of acetyl-CoA leave a final 5-carbon acyl-CoA, whose last cleavage yields one acetyl-CoA and a 3-carbon propionyl-CoA; the odd carbon shows up as this propionyl-CoA rather than as another acetyl-CoA.

(Choice B) is correct: an odd-chain fatty acid yields acetyl-CoA units plus one terminal propionyl-CoA (3 C).
(Choice A) is incorrect: only the final cleavage produces propionyl-CoA; all earlier rounds still release two-carbon acetyl-CoA.
(Choice C) is incorrect: \(\beta\)-oxidation removes two carbons per cut, so the leftover odd unit is a 3-carbon propionyl-CoA, never a 1-carbon ''formyl-CoA.''
(Choice D) is incorrect: an odd-chain fatty acid cannot give only acetyl-CoA—an odd carbon count guarantees a 3-carbon propionyl-CoA remainder.

By reasoning from chain parity to the identity of the end products, this item assesses Skill 2 (reasoning about scientific principles).', 'easy', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'process_step_confusion', 'every round makes propionyl-CoA' FROM q
  UNION ALL
  SELECT id, 'C', 'scale_unit_error', 'leftover is a 1-carbon unit' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'odd chain still gives only acetyl-CoA' FROM q;

-- Q55 [H14 · Beta-Oxidation] hard skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Beta-Oxidation', 'Oleate (an 18-carbon fatty acid with one \(cis\) double bond) is oxidized and, when the shortening chain reaches that pre-existing double bond, enoyl-CoA isomerase acts before the normal cycle can resume. Which explanation best accounts for both the need for this extra enzyme and the fact that oleate yields slightly less ATP than fully saturated stearate?', '[{"label": "A", "text": "The \\(cis\\) bond blocks thiolysis, so the isomerase cleaves it directly; the extra cleavage consumes ATP, which is why the net yield falls"}, {"label": "B", "text": "The \\(cis\\) bond must first be hydrogenated by the isomerase using \\(\\text{FADH}_2\\), and consuming that \\(\\text{FADH}_2\\) is what lowers the ATP yield"}, {"label": "C", "text": "The \\(cis\\) bond is in the wrong position and geometry for the hydratase, so the isomerase repositions it to a \\(trans\\)-\\(\\Delta 2\\) bond; because that bond already exists, the \\(\\text{FAD}\\)-linked dehydrogenation is skipped for that round, losing one \\(\\text{FADH}_2\\)"}, {"label": "D", "text": "The \\(cis\\) bond forces an extra full \\(\\beta\\)-oxidation cycle, and the additional \\(\\text{NAD}^+\\)-linked step is inefficient, so less ATP is captured"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is C because the enzymes of \(\beta\)-oxidation are built to act on a \(trans\)-\(\Delta 2\) enoyl-CoA, and a natural \(cis\) double bond sits at the wrong carbon and in the wrong geometry. Enoyl-CoA isomerase simply repositions it into the \(trans\)-\(\Delta 2\) form the hydratase needs—no new double bond is created. Because that double bond is already present, the round that would normally have made it via the \(\text{FAD}\)-linked dehydrogenase is bypassed, so one \(\text{FADH}_2\) is not produced and the ATP total is slightly lower.

(Choice C) is correct: the isomerase converts \(cis\) to \(trans\)-\(\Delta 2\), and skipping one \(\text{FADH}_2\)-producing step accounts for the reduced yield.
(Choice A) is incorrect: the isomerase does not cleave the chain—it only shifts a double bond—and the ATP shortfall comes from a skipped oxidation, not an extra ATP-consuming cut.
(Choice B) is incorrect: the isomerase performs no reduction and consumes no \(\text{FADH}_2\); it is a rearrangement. (The separate 2,4-dienoyl-CoA reductase used for polyunsaturates uses \(\text{NADPH}\), not \(\text{FADH}_2\).)
(Choice D) is incorrect: the double bond does not add a cycle; if anything it lets one round bypass a step, and the lost ATP is a missing \(\text{FADH}_2\), not an inefficient \(\text{NAD}^+\) step.

By reasoning from why the standard enzymes fail on a \(cis\) bond to the energetic consequence of skipping an oxidation, this item assesses Skill 2 (reasoning about scientific principles).', 'hard', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'process_step_confusion', 'isomerase cleaves the chain and costs ATP' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'isomerase reduces the bond using FADH2' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'cis bond adds a cycle rather than skipping a step' FROM q;

-- Q56 [I15 · Ketone Bodies] hard skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Ketone Bodies', 'A patient with severe vitamin B12 deficiency is fasting and oxidizing an odd-chain fatty acid. The final three-carbon product of beta-oxidation is carboxylated normally to methylmalonyl-CoA, but conversion of methylmalonyl-CoA to succinyl-CoA is blocked. Compared with a B12-replete person oxidizing the same fatty acid, which statement best describes the metabolic consequence?', '[{"label": "A", "text": "Acetyl-CoA can no longer be produced from the fatty acid, halting energy yield from beta-oxidation entirely."}, {"label": "B", "text": "The biotin-dependent carboxylation step is inhibited, so propionyl-CoA accumulates upstream of methylmalonyl-CoA."}, {"label": "C", "text": "Succinyl-CoA still forms but cannot enter the citric acid cycle, so no glucose can be made from any part of the molecule."}, {"label": "D", "text": "The odd-chain fatty acid''s small glucogenic contribution is lost, because the carbon that would have entered gluconeogenesis is trapped as methylmalonyl-CoA."}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is D because the only glucogenic carbon from an odd-chain fatty acid comes from its terminal three-carbon propionyl-CoA, which must travel propionyl-CoA \(\rightarrow\) methylmalonyl-CoA \(\rightarrow\) succinyl-CoA to reach the citric acid cycle and exit as malate for gluconeogenesis; blocking the \(\text{B}_{12}\)-dependent mutase strands that carbon as methylmalonyl-CoA, so the small glucose-forming contribution is lost while the rest of the chain still yields acetyl-CoA.

(Choice D) is correct: the mutase converting methylmalonyl-CoA to succinyl-CoA requires vitamin \(\text{B}_{12}\); with it blocked, the three-carbon unit never becomes the glucogenic TCA intermediate succinyl-CoA, so the odd-chain molecule''s unique glucogenic yield is eliminated.
(Choice A) is incorrect: all the two-carbon segments of the fatty acid are still released as acetyl-CoA by the normal four steps of beta-oxidation; only the final propionyl-CoA-derived carbon is affected, so energy yield from acetyl-CoA continues.
(Choice B) is incorrect: the stem specifies carboxylation to methylmalonyl-CoA proceeds normally, so the biotin-dependent propionyl-CoA carboxylase is not the blocked step; the lesion is at the downstream \(\text{B}_{12}\) mutase.
(Choice C) is incorrect: with the mutase blocked, succinyl-CoA is precisely the product that fails to form; the reasoning wrongly assumes succinyl-CoA is made but excluded from the cycle.

This item rewards Skill 2 reasoning: tracing a cofactor dependency along the propionyl-CoA pathway to predict which specific carbon source of glucose is lost.', 'hard', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'conflates loss of one 3-C fate with total pathway failure' FROM q
  UNION ALL
  SELECT id, 'B', 'process_step_confusion', 'attributes block to the wrong (biotin) step' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'treats the missing product as if it were made but excluded' FROM q;

-- Q57 [I16 · Ketone Bodies] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Ketone Bodies', 'In fasting hepatocytes, two acetyl-CoA molecules condense to acetoacetyl-CoA, HMG-CoA synthase adds a third acetyl-CoA to form HMG-CoA, and HMG-CoA lyase then cleaves HMG-CoA. If a hepatocyte''s HMG-CoA lyase is pharmacologically inhibited while beta-oxidation continues to flood the mitochondrion with acetyl-CoA, which molecule would be expected to accumulate?', '[{"label": "A", "text": "HMG-CoA, because it is the substrate immediately upstream of the inhibited lyase step"}, {"label": "B", "text": "3-Hydroxybutyrate, because the blocked lyase forces the reductive branch to dominate"}, {"label": "C", "text": "Acetone, because inhibiting the lyase increases spontaneous decarboxylation of the pathway''s products"}, {"label": "D", "text": "Free acetoacetate, because the synthase downstream continues to release it from acetoacetyl-CoA"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is A because HMG-CoA lyase is the enzyme that cleaves HMG-CoA into acetoacetate plus acetyl-CoA; if that step is blocked while upstream flux (condensation and HMG-CoA synthase) keeps running, the substrate sitting immediately before the block, HMG-CoA, is what backs up and accumulates.

(Choice A) is correct: inhibiting an enzyme causes its direct substrate to pile up; HMG-CoA is the substrate of HMG-CoA lyase, so it accumulates when the lyase is inhibited.
(Choice B) is incorrect: 3-hydroxybutyrate is made by reducing acetoacetate, but acetoacetate itself cannot form once the lyase is blocked, so the reductive product cannot rise.
(Choice C) is incorrect: acetone arises from spontaneous decarboxylation of acetoacetate; with acetoacetate no longer produced, there is no substrate for acetone formation, so it does not accumulate.
(Choice D) is incorrect: it reverses the pathway roles, treating the synthase as the enzyme that releases free acetoacetate; in fact the lyase, not the synthase, generates acetoacetate, and that step is the one inhibited.

This item rewards Skill 2 reasoning: applying the general rule that blocking an enzyme accumulates its immediate substrate, correctly placed within the ketogenesis sequence.', 'hard', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'process_step_confusion', 'expects a downstream reductive product past the block' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'invokes acetone chemistry without its precursor' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'swaps synthase and lyase roles' FROM q;

-- Q58 [I17 · Ketone Bodies] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Ketone Bodies', 'In the liver of a person who has been fasting for two days, beta-oxidation is supplying acetyl-CoA at a high rate, yet a large share of that acetyl-CoA is converted to acetoacetate and 3-hydroxybutyrate instead of being fully oxidized in the citric acid cycle. Which feature of the fasting liver''s metabolic state most directly accounts for why the citric acid cycle cannot keep pace with the incoming acetyl-CoA?', '[{"label": "A", "text": "Glucagon directly inhibits citrate synthase, blocking the condensation step and rerouting acetyl-CoA into ketone bodies."}, {"label": "B", "text": "Oxaloacetate is being consumed by gluconeogenesis, so too little remains to condense with acetyl-CoA and carry it into the cycle."}, {"label": "C", "text": "Acetyl-CoA is itself being drawn into gluconeogenesis as a carbon source, leaving only its degradation products to form ketones."}, {"label": "D", "text": "The high NADH-to-NAD+ ratio has fully arrested the cycle, so ketogenesis proceeds independently of oxaloacetate supply."}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is B because acetyl-CoA enters the citric acid cycle only by condensing with oxaloacetate to form citrate; during a fast the liver diverts oxaloacetate into gluconeogenesis, so the pool of oxaloacetate available to accept acetyl-CoA falls. With the cycle''s entry point limited by scarce oxaloacetate, the acetyl-CoA pouring out of rapid beta-oxidation exceeds what the cycle can absorb, and the surplus is condensed into HMG-CoA and cleaved to acetoacetate and 3-hydroxybutyrate.

(Choice B) is correct: the fasting liver''s gluconeogenic drain on oxaloacetate is the specific reason the cycle''s capacity to take up acetyl-CoA is limited, so the excess is shunted to ketones.
(Choice A) is incorrect: it invents direct inhibition of citrate synthase by glucagon; the actual bottleneck is loss of the oxaloacetate substrate, not hormonal inhibition of the enzyme.
(Choice C) is incorrect: acetyl-CoA is not a net carbon source for gluconeogenesis in humans (its two carbons are lost as CO2 across the cycle), so gluconeogenesis does not consume acetyl-CoA, and ketones are built from acetyl-CoA itself, not from its "degradation products."
(Choice D) is incorrect: although a high \(\text{NADH}/\text{NAD}^+\) ratio does slow the cycle, this option explicitly denies any role for oxaloacetate, whereas oxaloacetate depletion is the defining link that couples fasting gluconeogenesis to ketogenesis.

This item rewards Skill 2 reasoning: recognizing that gluconeogenesis withdraws oxaloacetate and connecting that withdrawal to the redirection of acetyl-CoA toward ketone bodies.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'invents direct hormonal enzyme inhibition instead of substrate limitation' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'believes acetyl-CoA is glucogenic / a gluconeogenic carbon source' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'true cofactor effect but explicitly omits the oxaloacetate link' FROM q;

-- Q59 [I18 · Ketone Bodies] easy skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Ketone Bodies', 'Among the three ketone bodies, acetone can be detected on the breath of a person in deep ketosis, whereas acetoacetate and 3-hydroxybutyrate are not exhaled. Which structural feature of acetoacetate best explains why acetone is the ketone body that ends up in exhaled air?', '[{"label": "A", "text": "Acetone is enzymatically produced from 3-hydroxybutyrate by a dedicated decarboxylase expressed in the lungs."}, {"label": "B", "text": "Acetone is the most oxidized ketone body, and its extra carbonyl makes it volatile enough to leave via the alveoli."}, {"label": "C", "text": "Acetoacetate is a beta-keto acid, and beta-keto acids readily lose CO2, so acetoacetate spontaneously decarboxylates to volatile acetone."}, {"label": "D", "text": "Acetoacetate carries a free carboxyl group that keeps it charged, and this charge is what allows it to diffuse into exhaled air."}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is C because acetoacetate is a beta-keto acid, a class that decarboxylates spontaneously and non-enzymatically because loss of \(\text{CO}_2\) yields a resonance-stabilized product; that reaction converts acetoacetate to acetone, a small volatile molecule that leaves the blood at the lungs and is exhaled.

(Choice C) is correct: the beta-keto arrangement (a carbonyl beta to the carboxyl) is exactly the motif that makes decarboxylation favorable, so acetone forms without an enzyme and is breathed out.
(Choice A) is incorrect: acetone formation is non-enzymatic and derives from acetoacetate, not from an enzymatic decarboxylation of 3-hydroxybutyrate in the lungs.
(Choice B) is incorrect: acetone is not ''the most oxidized'' ketone body, and volatility here comes from the decarboxylation reaction, not from an extra carbonyl making it more oxidized.
(Choice D) is incorrect: a charged carboxylate would tend to keep a molecule in aqueous solution rather than send it into exhaled air; volatility comes from losing that carboxyl as \(\text{CO}_2\) to form neutral acetone.

This item rewards Skill 2 reasoning: using beta-keto-acid chemistry to explain why one ketone body behaves differently from the other two.', 'easy', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'invents a lung decarboxylase for an enzyme-free reaction' FROM q
  UNION ALL
  SELECT id, 'B', 'adjacent_fact', 'misattributes volatility to oxidation state' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'treats charge as the cause of exhalation' FROM q;

-- Q60 [I19 · Ketone Bodies] hard skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Ketone Bodies', 'During a prolonged fast, the liver exports acetoacetate and 3-hydroxybutyrate as fuel for peripheral tissues. A physiologist compares four tissues and notes that three of them raise their oxygen consumption when perfused with ketone bodies, but one shows no change and continues to consume glucose exclusively no matter how much ketone body is supplied. Which tissue is the one that cannot oxidize ketone bodies, and what is the underlying reason?', '[{"label": "A", "text": "The renal cortex, because its high glucose reabsorption load commits it to glycolysis and leaves no capacity to oxidize ketone bodies."}, {"label": "B", "text": "Cardiac muscle, because it preferentially burns free fatty acids and therefore lacks the enzymes to convert ketone bodies to acetyl-CoA."}, {"label": "C", "text": "Skeletal muscle, because during fasting it exports its acetyl-CoA as ketone bodies rather than consuming them."}, {"label": "D", "text": "Red blood cells, because they have no mitochondria and ketone-body oxidation to acetyl-CoA feeds only the mitochondrial citric acid cycle."}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is D because converting a ketone body to usable energy is entirely a mitochondrial process: acetoacetate and 3-hydroxybutyrate must be turned into acetoacetyl-CoA and then acetyl-CoA, which can only be oxidized in the mitochondrial citric acid cycle. Mature red blood cells have no mitochondria at all, so they cannot perform this oxidation and instead rely exclusively on anaerobic glycolysis of glucose. Adding ketone bodies to red cells therefore raises neither oxygen consumption nor ATP yield, whereas heart, skeletal muscle, and renal cortex all have abundant mitochondria and readily oxidize ketones for the citric acid cycle.

(Choice D) is correct: the tissue that cannot use ketone bodies is the red blood cell, and the reason is the complete absence of mitochondria, which is where ketone-body oxidation and the citric acid cycle occur.
(Choice A) is incorrect: the renal cortex is in fact one of the tissues that actively oxidizes ketone bodies; reabsorbing glucose does not preclude ketone oxidation, and mitochondria-rich cortical cells use ketones during fasting (the more glycolytic region of the kidney is the medulla, not the cortex).
(Choice B) is incorrect: cardiac muscle is mitochondria-rich and is one of the most avid consumers of ketone bodies; although the heart also burns fatty acids, it retains the ketolytic machinery and oxidizes ketones readily, so it is not the non-user.
(Choice C) is incorrect: skeletal muscle does not make and export ketone bodies (ketogenesis is a hepatic function driven by withdrawal of oxaloacetate into gluconeogenesis); skeletal muscle consumes ketones during fasting, so it is a user, not the exception.

This item rewards Skill 2 reasoning: recognizing that ketone-body oxidation is strictly mitochondrial and applying that principle to deduce which tissue (the anucleate, amitochondrial red blood cell) is therefore forced onto glucose alone.', 'hard', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'wrongly excludes a genuine ketone-user (renal cortex) via a plausible-sounding glucose-handling rationale, exploiting cortex/medulla confusion' FROM q
  UNION ALL
  SELECT id, 'B', 'partial_truth', 'true that heart favors fatty acids, but falsely infers it lacks ketolytic enzymes' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'reverses producer/consumer roles by claiming muscle exports ketones like the liver' FROM q;

-- Q61 [I20 · Ketone Bodies] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Ketone Bodies', 'After about a week of starvation, the brain adapts to obtain up to two-thirds of its energy from ketone bodies instead of relying almost entirely on glucose. At the level of the whole organism, what is the principal survival benefit of this shift?', '[{"label": "A", "text": "The brain''s lower glucose demand reduces gluconeogenesis from amino acids, sparing body protein."}, {"label": "B", "text": "Ketone bodies can be stored in the brain in large amounts, creating an energy reserve that outlasts the body''s glycogen stores."}, {"label": "C", "text": "Using ketones lets the brain generate glucose internally, so peripheral gluconeogenesis can shut down entirely during the fast."}, {"label": "D", "text": "Ketone oxidation supplies essential fatty acids the brain needs to rebuild myelin faster during prolonged starvation."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is A because early in a fast the brain''s large glucose requirement forces the body to make glucose from amino acids released by breaking down protein; once the brain can cover most of its energy from ketone bodies, its glucose demand falls, less gluconeogenesis from amino acids is needed, and body protein (muscle) is preserved, which prolongs survival.

(Choice A) is correct: sparing glucose spares the amino-acid substrate that would otherwise be drained from protein for gluconeogenesis, so the whole-body benefit is protein conservation.
(Choice B) is incorrect: the brain does not stockpile ketone bodies as a reserve; the benefit is a change in fuel usage, not storage.
(Choice C) is incorrect: the brain cannot perform net gluconeogenesis, and some glucose production continues; ketone use reduces but does not eliminate the need for gluconeogenesis.
(Choice D) is incorrect: ketone bodies are oxidized for energy, not converted into essential fatty acids for myelin repair; this misstates their metabolic fate.

This item rewards Skill 2 reasoning: linking a shift in brain fuel to the downstream conservation of body protein.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'imagines brain ketone storage depot' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'claims brain does net gluconeogenesis' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'redirects ketone fate to myelin synthesis' FROM q;

-- Q62 [I21 · Ketone Bodies] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Ketone Bodies', 'When a peripheral cell oxidizes ketone bodies, the acetyl-CoA generated raises the cell''s acetyl-CoA level and inhibits the pyruvate dehydrogenase (PDH) complex. How does this feedback help the fasting body preserve glucose at the level of that individual cell?', '[{"label": "A", "text": "Inhibiting PDH shuts down the citric acid cycle, so glucose is spared because no fuel of any kind can be oxidized while ketones are present."}, {"label": "B", "text": "Inhibiting PDH blocks conversion of pyruvate to acetyl-CoA, so pyruvate and its glucose-derived carbons are conserved rather than irreversibly oxidized."}, {"label": "C", "text": "Inhibiting PDH forces pyruvate to be converted directly into glucose within that same cell through reactivated gluconeogenesis."}, {"label": "D", "text": "Inhibiting PDH increases glucose uptake into the cell, building an intracellular glucose reserve for later use."}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is B because PDH catalyzes the irreversible commitment of pyruvate to acetyl-CoA; when ketone-derived acetyl-CoA inhibits PDH, pyruvate is not consumed that way, so glucose-derived three-carbon units are held back from irreversible oxidation and remain available (for example, pyruvate can be exported and used by the liver for gluconeogenesis), conserving glucose.

(Choice B) is correct: sparing pyruvate from the irreversible PDH step keeps glucose carbons from being lost to oxidation, which is how ketone use conserves glucose at the cellular level.
(Choice A) is incorrect: the citric acid cycle keeps running on ketone-derived acetyl-CoA, so it is not shut down; only the pyruvate-to-acetyl-CoA step is inhibited.
(Choice C) is incorrect: most peripheral cells that oxidize ketones (such as muscle) cannot perform net gluconeogenesis, so pyruvate is not turned into glucose within that cell.
(Choice D) is incorrect: PDH inhibition does not raise glucose uptake or create an intracellular glucose store; it acts on pyruvate metabolism, not on glucose transport.

This item rewards Skill 2 reasoning: tracing how inhibiting an irreversible glucose-oxidizing step conserves glucose carbon during fasting.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'overstates PDH block as full TCA shutdown' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'gives peripheral cells net gluconeogenesis' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'confuses PDH regulation with glucose transport' FROM q;

-- Q63 [I22 · Ketone Bodies] medium skill4 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Ketone Bodies', 'The table shows fasting blood values measured in one subject on successive days without food.

| Day of fast | Blood glucose (mg/dL) | Free fatty acids (mmol/L) | Total ketone bodies (mmol/L) |
|---|---|---|---|
| 1 | 80 | 0.4 | 0.1 |
| 3 | 68 | 1.1 | 1.5 |
| 7 | 62 | 1.6 | 5.8 |

Based only on these data, which conclusion about the subject''s fuel use is best supported?', '[{"label": "A", "text": "The rising ketone concentration reflects worsening dehydration rather than a change in fuel source, since blood glucose stays nearly constant."}, {"label": "B", "text": "The fall in blood glucose shows the body is depleting fat stores first and only later mobilizing carbohydrate as ketone bodies rise."}, {"label": "C", "text": "Glucose declines only modestly while fatty acids and ketones rise sharply, indicating a fuel shift toward fat, with the brain increasingly drawing on ketone bodies."}, {"label": "D", "text": "Because free fatty acids and ketone bodies both rise, the brain must be switching to free fatty acids as its main fuel over the week."}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is C because the data show blood glucose falling only from 80 to 62 mg/dL (a modest defended decline) while free fatty acids climb from 0.4 to 1.6 mmol/L and total ketone bodies rise roughly 58-fold from 0.1 to 5.8 mmol/L; this pattern is the classic fasting transition from glucose toward fat-derived fuels, and the large late rise in ketone bodies is what allows the brain to shift substantial energy use onto ketones.

(Choice C) is correct: it reads the trends directly, a small glucose drop alongside steep rises in fatty acids and ketones, and correctly identifies the fuel shift and the brain''s growing use of ketone bodies.
(Choice A) is incorrect: nothing in the table measures hydration, and the coordinated rise in free fatty acids with ketones points to fat mobilization, not dehydration, as the source of the ketones.
(Choice B) is incorrect: it reverses the logic, since falling glucose with rising fatty acids and ketones reflects mobilization of fat as glucose is conserved, not carbohydrate being mobilized after fat.
(Choice D) is incorrect: the brain cannot use long-chain free fatty acids as fuel (they do not cross the blood-brain barrier for oxidation); the fuel the brain shifts toward is ketone bodies, which the data show rising steeply.

This item rewards Skill 4 reasoning: interpreting quantitative trends across a time course to infer the metabolic-fuel transition rather than restating a memorized fact.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 4, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'attributes ketone rise to unmeasured dehydration' FROM q
  UNION ALL
  SELECT id, 'B', 'reversed_relationship', 'inverts the order of fuel mobilization' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'claims brain burns free fatty acids' FROM q;

-- Q64 [J1 · Protein Digestion] easy skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Protein Digestion', 'A patient takes a large dose of antacid that neutralizes gastric acid, raising the pH inside the stomach from about 2 to about 6. Which effect on the very first stage of protein digestion is most likely?', '[{"label": "A", "text": "Digestion is unaffected because pancreatic trypsin secreted into the stomach takes over the initial peptide-bond cleavage"}, {"label": "B", "text": "Digestion is enhanced because pepsin is more catalytically active once the stomach reaches a neutral pH"}, {"label": "C", "text": "Digestion is unaffected because the stomach''s main role is to absorb free amino acids rather than to cleave proteins"}, {"label": "D", "text": "Digestion is impaired because pepsinogen is not converted to pepsin and proteins stay folded"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is D because the acidic stomach does two things that launch protein digestion: the low pH denatures (unfolds) dietary proteins so their bonds are exposed, and it converts pepsinogen to active pepsin (an autocatalytic conversion favored at low pH). Neutralizing the acid removes both drivers, so pepsin is not generated and proteins stay folded, stalling the first stage.

(Choice D) is correct: raising the pH prevents the acid-dependent activation of pepsinogen to pepsin and eliminates acid denaturation, so the initial cleavage of proteins into peptides cannot proceed normally.
(Choice A) is incorrect: trypsin is a pancreatic protease delivered to the small intestine, not the stomach; it does not substitute for gastric pepsin, and it would be delivered downstream regardless.
(Choice B) is incorrect: pepsin requires the acidic environment for its activity; it is not more active at neutral pH, so raising pH cannot enhance its function.
(Choice C) is incorrect: the stomach begins chemical digestion of proteins via pepsin; amino-acid absorption occurs in the small intestine, not the stomach.

This item rewards Skill 2 reasoning: you must apply the mechanism of acid-driven pepsinogen activation and protein denaturation to predict the effect of removing the acidic environment.', 'easy', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'adjacent_fact', 'trypsin substitutes in stomach' FROM q
  UNION ALL
  SELECT id, 'B', 'reversed_relationship', 'pepsin favors neutral pH' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'stomach absorbs amino acids' FROM q;

-- Q65 [J2 · Protein Digestion] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Protein Digestion', 'The pancreas synthesizes and secretes its proteolytic enzymes as inactive precursors rather than in their active form. What best explains the protective advantage of this arrangement?', '[{"label": "A", "text": "The inactive precursor cannot cleave the pancreatic cells'' own proteins, preventing the gland from digesting its own tissue before the enzyme reaches the intestine"}, {"label": "B", "text": "The inactive precursor is more thermodynamically stable and therefore resists denaturation by body heat during storage"}, {"label": "C", "text": "The inactive precursor is smaller than the active enzyme, allowing faster secretion through the pancreatic duct"}, {"label": "D", "text": "The inactive precursor allows the pancreas to absorb amino acids released from its own proteins as an energy source"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is A because a protease is, by definition, an enzyme that cleaves peptide bonds in proteins. If the pancreas produced it in active form, it would attack the cell''s own proteins at the site of synthesis. Storing and secreting it as an inactive zymogen keeps the catalytic machinery switched off until the enzyme reaches the intestinal lumen, where activation is safe, so the gland does not digest itself.

(Choice A) is correct: the zymogen form has no proteolytic activity, so it cannot degrade the pancreatic tissue that made it; activation is deferred until the enzyme is safely in the intestinal lumen.
(Choice B) is incorrect: the protective purpose is to prevent premature catalysis, not to resist thermal denaturation; stability during storage is not the reason proteases are secreted as zymogens.
(Choice C) is incorrect: activation typically involves cleaving off a fragment, so the active enzyme is if anything smaller; size and duct transit are not the rationale for the inactive form.
(Choice D) is incorrect: the point is to avoid degrading pancreatic proteins at all, not to harvest amino acids from self-digestion, which would damage the organ.

This item rewards Skill 2 reasoning: you must reason from what a protease does to why keeping it inactive inside its cell of origin is protective.', 'hard', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'adjacent_fact', 'zymogen for thermal stability' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'inactive form is smaller/faster' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'self-digestion as fuel' FROM q;

-- Q66 [J3 · Protein Digestion] hard skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Protein Digestion', 'In the small intestine, enteropeptidase (a brush-border enzyme) converts trypsinogen to trypsin; trypsin then activates chymotrypsinogen, procarboxypeptidase, and additional trypsinogen. If a person genetically lacks functional enteropeptidase, what is the most likely consequence for intestinal protein digestion?', '[{"label": "A", "text": "Only trypsinogen fails to activate, while chymotrypsinogen and procarboxypeptidase are still switched on normally by enteropeptidase"}, {"label": "B", "text": "Multiple pancreatic proteases stay inactive, because with no trypsin formed the downstream and additional zymogens never get turned on"}, {"label": "C", "text": "Protein digestion is unaffected because gastric pepsin alone fully digests dietary protein to free amino acids"}, {"label": "D", "text": "The pancreas compensates by secreting the proteases in already-active form, so no digestive defect appears"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is B because enteropeptidase is the single upstream trigger of an amplifying cascade: it makes the first trypsin, and trypsin is what activates chymotrypsinogen, procarboxypeptidase, and more trypsinogen. Remove that one trigger and no trypsin forms, so the whole downstream set of zymogens stays inactive and the amplification never starts.

(Choice B) is correct: because trypsin is the common activator of the other zymogens (and of further trypsinogen), losing the enzyme that makes the first trypsin collapses the entire activation cascade, leaving several proteases inactive.
(Choice A) is incorrect: enteropeptidase acts only on trypsinogen; chymotrypsinogen and procarboxypeptidase are activated by trypsin, so without trypsin they too remain inactive.
(Choice C) is incorrect: pepsin performs partial gastric digestion into peptides but does not complete digestion to free amino acids; the pancreatic proteases are needed downstream.
(Choice D) is incorrect: the pancreas secretes proteases as inactive zymogens precisely to avoid self-digestion; it does not switch to secreting active enzymes to compensate.

This item rewards Skill 2 reasoning: you must trace an amplifying activation cascade and predict how removing its single upstream trigger propagates to every downstream enzyme.', 'hard', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'process_step_confusion', 'enteropeptidase activates all zymogens' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'pepsin finishes digestion alone' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'pancreas secretes active backup' FROM q;

-- Q67 [J4 · Protein Digestion] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Protein Digestion', 'A researcher incubates a purified polypeptide with a single digestive enzyme and finds that cleavage occurs only at internal peptide bonds located immediately after lysine and arginine residues, leaving the chain''s two terminal residues intact. Which class and identity of enzyme is most consistent with this pattern?', '[{"label": "A", "text": "An exopeptidase such as carboxypeptidase, which removes residues one at a time from the C-terminus"}, {"label": "B", "text": "An exopeptidase such as aminopeptidase, which removes residues one at a time from the N-terminus"}, {"label": "C", "text": "An endopeptidase such as trypsin, which cuts internal bonds with specificity for basic residues"}, {"label": "D", "text": "An endopeptidase such as chymotrypsin, which cuts internal bonds after large aromatic residues"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is C because two features of the described pattern pin down the enzyme. First, cleavage at internal bonds (not at the ends) marks an endopeptidase. Second, the specific cut site immediately after lysine and arginine (basic residues) matches trypsin''s residue specificity. Together these identify trypsin.

(Choice C) is correct: internal cleavage identifies an endopeptidase, and the Lys/Arg cut site is trypsin''s signature specificity, so both the class and the identity fit.
(Choice A) is incorrect: carboxypeptidase is an exopeptidase that trims the C-terminal residue, but the data show internal cuts with the termini left intact, ruling out end-trimming.
(Choice B) is incorrect: aminopeptidase is an exopeptidase acting at the N-terminus, which again contradicts the observed internal cleavage and untouched ends.
(Choice D) is incorrect: chymotrypsin is correctly an endopeptidase, but it cuts after large aromatic residues, not after the basic residues Lys and Arg described here.

This item rewards Skill 2 reasoning: you must map an observed cleavage pattern onto the endo- versus exopeptidase distinction and then onto specific residue specificities.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'process_step_confusion', 'exopeptidase mistaken for internal cut' FROM q
  UNION ALL
  SELECT id, 'B', 'process_step_confusion', 'N-terminal trim mislabeled' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'right class wrong specificity' FROM q;

-- Q68 [J5 · Protein Digestion] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Protein Digestion', 'At the luminal (apical) membrane of an intestinal cell, amino acids are taken up together with sodium ions. If a toxin abolishes the steep sodium concentration gradient normally maintained across this membrane, what is the most likely effect on amino-acid uptake?', '[{"label": "A", "text": "Uptake is unchanged, because amino acids cross the luminal membrane by simple diffusion that does not depend on sodium"}, {"label": "B", "text": "Uptake rises, because eliminating the sodium gradient frees the transporter to move amino acids faster"}, {"label": "C", "text": "Uptake is unchanged, because the amino-acid transporter directly hydrolyzes ATP and does not use the sodium gradient"}, {"label": "D", "text": "Uptake falls, because the transporter relies on sodium flowing down its gradient to power amino-acid entry, and without that gradient the driving force is lost"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is D because luminal amino-acid uptake is secondary active transport: the co-transporter couples the energetically favorable inward flow of sodium (down its gradient) to the uphill movement of amino acids into the cell. The sodium gradient is the stored energy source. Dissipate that gradient and there is no downhill sodium flux to power the co-transport, so amino-acid uptake against its own gradient stalls.

(Choice D) is correct: the amino acid rides in on the sodium gradient, so collapsing the gradient removes the driving force and uptake drops.
(Choice A) is incorrect: luminal amino-acid entry is sodium-coupled co-transport, not simple diffusion, so it is gradient-dependent.
(Choice B) is incorrect: the gradient supplies the energy; abolishing it cannot accelerate transport, and reversing this logic misreads the mechanism.
(Choice C) is incorrect: this transporter does not directly split ATP (that would be primary active transport); it is secondary active transport that spends the sodium gradient the \(\text{Na}^+/\text{K}^+\) pump creates elsewhere.

This item rewards Skill 2 reasoning: you must apply the mechanism of sodium-coupled secondary active transport to predict the consequence of removing the ion gradient that powers it.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'amino acids diffuse freely' FROM q
  UNION ALL
  SELECT id, 'B', 'reversed_relationship', 'no gradient speeds transport' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'secondary confused with primary active' FROM q;

-- Q69 [J6 · Protein Digestion] easy skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Protein Digestion', 'Dietary protein is acted on first by endopeptidases and then by exopeptidases along the digestive tract. Considering how these two activities combine, what are the final products presented for absorption across the intestinal lining?', '[{"label": "A", "text": "Free amino acids together with short di- and tripeptides"}, {"label": "B", "text": "Only intact, full-length proteins that are absorbed and broken down inside the cell"}, {"label": "C", "text": "Only single free amino acids, with no peptides small enough to be absorbed"}, {"label": "D", "text": "Large peptide fragments of roughly a dozen residues each, absorbed without further trimming"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is A because the two enzyme classes work in complementary steps. Endopeptidases cleave internal peptide bonds, chopping proteins into many shorter peptides, and exopeptidases then trim residues off the ends of those peptides. The combined result is a mixture of free amino acids plus very short di- and tripeptides, both of which the intestine can absorb (free amino acids by Na+-linked secondary active transport, and small peptides through a dedicated peptide transporter).

(Choice A) is correct: internal cutting followed by end-trimming reduces protein all the way down to free amino acids and small di-/tripeptides, the absorbable end products.
(Choice B) is incorrect: full-length proteins are not the end product and are not absorbed intact; digestion breaks them down in the lumen and at the brush border first.
(Choice C) is incorrect: digestion does not stop at only single amino acids; short di- and tripeptides are also produced and absorbed.
(Choice D) is incorrect: exopeptidase trimming continues past large fragments, so roughly dozen-residue peptides are not the final absorbed form.

This item rewards Skill 2 reasoning: you must combine the actions of endo- and exopeptidases to reason out the size and identity of the final absorbable products.', 'easy', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'proteins absorbed intact' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'only free amino acids' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'large fragments absorbed untrimmed' FROM q;

-- Q70 [K7 · Amino-Acid Catabolism] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Amino-Acid Catabolism', 'A hepatocyte begins catabolizing the amino acid alanine. An aminotransferase acts on alanine and \(\alpha\)-ketoglutarate, using pyridoxal phosphate as a cofactor. Immediately after this single reaction, which statement best describes what has happened to alanine''s \(\alpha\)-amino nitrogen?', '[{"label": "A", "text": "It has been released from the cell as free ammonia"}, {"label": "B", "text": "It has been relocated onto \\(\\alpha\\)-ketoglutarate, forming glutamate"}, {"label": "C", "text": "It has been incorporated into urea for excretion"}, {"label": "D", "text": "It has been oxidized and lost as molecular nitrogen gas"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is B because a transamination reaction moves an \(\alpha\)-amino group from one carbon skeleton onto another without setting any nitrogen free: the aminotransferase transfers alanine''s \(\alpha\)-amino group onto the acceptor \(\alpha\)-ketoglutarate, converting it to glutamate while alanine becomes the new \(\alpha\)-keto acid pyruvate. No net nitrogen has yet been removed from the cell; the nitrogen has merely changed carriers.

(Choice A) is incorrect: transamination only shuttles the amino group between molecules; free ammonia is not liberated until a later oxidative deamination step, which this single reaction has not performed.
(Choice B) is correct: the amino group is transferred to \(\alpha\)-ketoglutarate to make glutamate plus a new \(\alpha\)-keto acid, exactly what an aminotransferase does.
(Choice C) is incorrect: incorporation into urea happens in the urea cycle, many steps downstream, and requires ammonia already freed by deamination, so it cannot be the immediate result of one transamination.
(Choice D) is incorrect: biological nitrogen catabolism does not oxidize amino nitrogen to \(\text{N}_2\) gas; the nitrogen stays bound in glutamate here and is ultimately disposed of as urea, not as elemental nitrogen.

This is a Scientific Reasoning and Problem Solving question because you must trace the fate of a specific atom through a named reaction rather than recall a definition.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'process_step_confusion', 'conflates transamination with later deamination' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'jumps ahead to urea cycle' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'believes nitrogen leaves as N2 gas' FROM q;

-- Q71 [K8 · Amino-Acid Catabolism] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Amino-Acid Catabolism', 'During amino-acid breakdown in the liver, the \(\alpha\)-amino groups of a dozen different amino acids are each transaminated onto \(\alpha\)-ketoglutarate, so their nitrogen ends up on glutamate before any is disposed of. What is the principal metabolic advantage of first funneling nitrogen from many different amino acids onto this one carrier?', '[{"label": "A", "text": "It lets each amino acid be excreted intact without further processing"}, {"label": "B", "text": "It converts every amino acid directly into glucose"}, {"label": "C", "text": "It channels diverse amino groups through a single molecule that one deamination pathway can then process"}, {"label": "D", "text": "It permanently detoxifies the nitrogen so no excretion step is needed"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is C because collecting the amino groups of many amino acids onto a single carrier, glutamate, means the cell does not need a separate nitrogen-removal pathway for each of the twenty amino acids. Once the nitrogen is consolidated on glutamate, one downstream enzyme system, glutamate dehydrogenase performing oxidative deamination, can release it as free ammonia for disposal, making the whole process economical and centralized.

(Choice A) is incorrect: transamination onto glutamate does not prepare amino acids to be excreted intact; the whole point is to collect nitrogen for a shared disposal route, and the carbon skeletons are separately used for energy.
(Choice B) is incorrect: funneling nitrogen onto glutamate concerns nitrogen handling, not carbon; not every amino acid yields glucose, and purely ketogenic ones yield none.
(Choice C) is correct: consolidating diverse amino groups on one molecule lets a single deamination step handle nitrogen from all of them, which is the efficiency being sought.
(Choice D) is incorrect: gathering nitrogen on glutamate does not detoxify it; the ammonia later freed is toxic and still must be converted to urea and excreted, so a disposal step remains essential.

This is a Scientific Reasoning and Problem Solving question because you must reason about why a convergent pathway design is efficient, not simply recall that glutamate is a hub.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'thinks amino acids excreted intact' FROM q
  UNION ALL
  SELECT id, 'B', 'adjacent_fact', 'confuses nitrogen fate with carbon-to-glucose fate' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'assumes hub step removes need to excrete' FROM q;

-- Q72 [K9 · Amino-Acid Catabolism] hard skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Amino-Acid Catabolism', 'After transamination has loaded amino-group nitrogen onto glutamate in liver mitochondria, glutamate dehydrogenase acts on that glutamate. In terms of what actually leaves the amino acid pool as disposable nitrogen, this step is distinct from transamination because it', '[{"label": "A", "text": "transfers the amino group to a second keto acid without releasing it"}, {"label": "B", "text": "attaches the amino group to aspartate to enter the urea cycle"}, {"label": "C", "text": "requires pyridoxal phosphate to shuttle the amino group between carbons"}, {"label": "D", "text": "liberates the amino group as free ammonia and regenerates \\(\\alpha\\)-ketoglutarate"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is D because glutamate dehydrogenase carries out oxidative deamination: it removes glutamate''s amino group as free ammonia \(\left(\text{NH}_4^+\right)\) and regenerates \(\alpha\)-ketoglutarate, which can accept another amino group in a new round of transamination. This is the step that finally converts bound amino nitrogen into truly free, disposable nitrogen, unlike transamination, which only relocates the group.

(Choice D) is correct: oxidative deamination releases \(\text{NH}_4^+\) and regenerates \(\alpha\)-ketoglutarate, the actual nitrogen-removal step.
(Choice A) is incorrect: transferring an amino group to another keto acid without releasing it describes transamination, which is exactly the step glutamate dehydrogenase differs from; no free nitrogen would result.
(Choice B) is incorrect: joining nitrogen to aspartate is how one urea nitrogen enters the urea cycle downstream, not what glutamate dehydrogenase does; it liberates ammonia rather than making aspartate.
(Choice C) is incorrect: pyridoxal phosphate is the transamination cofactor; glutamate dehydrogenase uses a nicotinamide cofactor \(\left(\text{NAD(P)}^+\right)\) to oxidatively deaminate, so citing PLP describes the wrong reaction.

This is a Scientific Reasoning and Problem Solving question because you must distinguish which coupled step actually removes nitrogen and reason about its products rather than recall a label.', 'hard', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'process_step_confusion', 'describes transamination instead of deamination' FROM q
  UNION ALL
  SELECT id, 'B', 'adjacent_fact', 'swaps in aspartate urea-cycle nitrogen entry' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'assigns PLP to deamination' FROM q;

-- Q73 [K10 · Amino-Acid Catabolism] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Amino-Acid Catabolism', 'A hepatocyte transaminates alanine, moving its \(\alpha\)-amino group onto \(\alpha\)-ketoglutarate and leaving the three-carbon keto acid pyruvate behind. The cell is under an acute energy demand and has ample oxaloacetate available in its mitochondria. Which fate of this leftover carbon skeleton directly captures its energy as reducing equivalents for the electron transport chain?', '[{"label": "A", "text": "It is converted to acetyl-CoA and oxidized in the TCA cycle to generate NADH and FADH2"}, {"label": "B", "text": "It is re-aminated back to alanine and held in the cell as a storage reserve"}, {"label": "C", "text": "It is converted to free ammonia that supplies a nitrogen for urea synthesis"}, {"label": "D", "text": "It is exported unchanged into the blood as a nitrogenous waste product"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is A because once the \(\alpha\)-amino group has been transaminated away, the remaining carbon skeleton is a plain \(\alpha\)-keto acid — here pyruvate — that the cell treats as fuel. Under an acute energy demand with oxaloacetate available to keep the TCA cycle turning, pyruvate is decarboxylated to acetyl-CoA, which condenses with oxaloacetate and is oxidized in the TCA cycle. That oxidation is precisely what generates the NADH and FADH2 that feed the electron transport chain, so this is the fate that directly captures the skeleton''s energy as reducing equivalents.

(Choice A) is correct: the deaminated skeleton (pyruvate) is converted to acetyl-CoA and oxidized in the TCA cycle, producing the NADH and FADH2 that drive the electron transport chain.
(Choice B) is incorrect: re-aminating the skeleton back to alanine and storing it would undo the catabolic step just performed and capture no energy; during an energy demand the cell burns the skeleton rather than rebuilding the amino acid.
(Choice C) is incorrect: it is the nitrogen that was already removed which becomes free ammonia for urea; the carbon skeleton does not turn into ammonia, so this confuses the fate of the carbons with the fate of the nitrogen.
(Choice D) is incorrect: the carbon skeleton is a useful fuel, not waste, so the cell oxidizes it rather than dumping it unchanged into the blood; the waste product actually excreted is urea, made from the removed nitrogen.

This is a Scientific Reasoning and Problem Solving question because you must reason from the stated conditions — nitrogen already removed, oxaloacetate available, energy demanded — to identify the single metabolic route that converts the carbon skeleton into reducing equivalents, rather than restate a definition.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'thinks skeleton is re-aminated and stored during energy demand' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'confuses carbon-skeleton fate with removed-nitrogen fate' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'treats useful carbon fuel as excreted waste' FROM q;

-- Q74 [K11 · Amino-Acid Catabolism] hard skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Amino-Acid Catabolism', 'A person has fasted long enough that blood glucose is maintained partly by gluconeogenesis from amino acids released by muscle. A researcher labels the carbon skeletons of alanine, aspartate, glutamate, and leucine to see which could contribute carbons to newly made glucose. Which amino acid''s carbons could NOT support blood glucose, and why?', '[{"label": "A", "text": "Aspartate, because it is deaminated to a ketone body rather than a TCA intermediate"}, {"label": "B", "text": "Leucine, because its skeleton yields acetyl-CoA/acetoacetate, which cannot form net glucose"}, {"label": "C", "text": "Alanine, because its skeleton becomes acetyl-CoA, which cannot yield net glucose"}, {"label": "D", "text": "Glutamate, because it enters the urea cycle rather than gluconeogenesis"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is B because leucine is a purely ketogenic amino acid: its carbon skeleton is broken down to acetyl-CoA and acetoacetate. Acetyl-CoA cannot be converted to net glucose in humans because the pyruvate-to-acetyl-CoA step is irreversible and the two carbons entering the TCA cycle as acetyl-CoA are lost as \(\text{CO}_2\) before oxaloacetate is regenerated. So leucine''s carbons cannot raise blood glucose. Alanine (to pyruvate), aspartate (to oxaloacetate), and glutamate (to \(\alpha\)-ketoglutarate) are all glucogenic and can feed gluconeogenesis.

(Choice A) is incorrect: aspartate is glucogenic; it is transaminated to oxaloacetate, a direct gluconeogenic precursor, not a ketone body.
(Choice C) is incorrect: alanine yields pyruvate, a classic glucogenic substrate (the glucose-alanine cycle), so its skeleton does support glucose.
(Choice B) is correct: leucine is purely ketogenic, giving acetyl-CoA/acetoacetate, which cannot generate net glucose.
(Choice D) is incorrect: glutamate''s carbons form \(\alpha\)-ketoglutarate, a glucogenic TCA intermediate; the urea cycle handles glutamate''s nitrogen, not its carbon skeleton.

This is a Scientific Reasoning and Problem Solving question because you must apply the glucogenic-versus-ketogenic distinction to specific skeletons and reason from why acetyl-CoA cannot yield net glucose.', 'hard', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'mislabels glucogenic aspartate as ketogenic' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'mislabels glucogenic alanine as ketogenic' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'confuses glutamate carbon fate with nitrogen fate' FROM q;

-- Q75 [K12 · Amino-Acid Catabolism] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Amino-Acid Catabolism', 'The liver must convert the amino nitrogen of essentially any dietary amino acid into free ammonia so it can be detoxified. It accomplishes this by coupling two reactions in sequence. Which pairing correctly describes how these two steps combine to move nitrogen from an arbitrary amino acid to free ammonia?', '[{"label": "A", "text": "Oxidative deamination frees the amino group first, then transamination places it onto glutamate for storage"}, {"label": "B", "text": "Transamination and the urea cycle act in parallel, each releasing ammonia independently"}, {"label": "C", "text": "Transamination transfers the amino group onto glutamate, then glutamate dehydrogenase deaminates glutamate to free ammonia"}, {"label": "D", "text": "Two successive transaminations relay the amino group until it is spontaneously released as ammonia"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is C because the coupled process, called transdeamination, works in a fixed order: first an aminotransferase transfers the \(\alpha\)-amino group of the amino acid onto \(\alpha\)-ketoglutarate, collecting the nitrogen on glutamate; then glutamate dehydrogenase oxidatively deaminates that glutamate, releasing the nitrogen as free ammonia and regenerating \(\alpha\)-ketoglutarate. Because the acceptor is regenerated, this two-step relay can strip nitrogen from any amino acid feeding into glutamate.

(Choice A) is incorrect: it reverses the order; nitrogen cannot be freed by deamination before transamination has placed it onto glutamate, and the sequence collects nitrogen for disposal, not storage.
(Choice C) is correct: transamination onto glutamate followed by glutamate-dehydrogenase deamination is exactly how the two steps combine to yield free ammonia.
(Choice B) is incorrect: the urea cycle consumes the ammonia that deamination produces; it does not independently release ammonia in parallel with transamination.
(Choice D) is incorrect: transamination alone never sets nitrogen free, so a chain of transaminations, no matter how long, cannot spontaneously produce ammonia; an oxidative deamination step is required.

This is a Scientific Reasoning and Problem Solving question because you must reason about how two steps must be ordered and coupled to achieve nitrogen removal, not recall a single fact.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'flips deamination and transamination order' FROM q
  UNION ALL
  SELECT id, 'B', 'adjacent_fact', 'invokes urea cycle as parallel ammonia source' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'thinks transamination alone frees ammonia' FROM q;

-- Q76 [K13 · Amino-Acid Catabolism] medium skill4 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Amino-Acid Catabolism', 'A metabolic ward measures each patient''s daily nitrogen intake (from dietary protein) and total daily nitrogen excretion (mostly urinary urea), in grams of nitrogen per day:

| Patient | N intake (g/day) | N excretion (g/day) |
|---------|------------------|---------------------|
| P | 12 | 12 |
| Q | 14 | 9 |
| R | 8 | 15 |
| S | 11 | 11 |

Based solely on these data, which patient is in a state most consistent with net breakdown of body protein (a catabolic, tissue-wasting state)?', '[{"label": "A", "text": "Patient Q, whose nitrogen intake exceeds excretion (positive balance)"}, {"label": "B", "text": "Patient P, whose intake and excretion are equal"}, {"label": "C", "text": "Patient S, whose intake and excretion are equal"}, {"label": "D", "text": "Patient R, whose nitrogen excretion exceeds intake (negative balance)"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is D because nitrogen balance compares nitrogen taken in as dietary protein against nitrogen excreted, mostly as urinary urea (balance = intake − excretion). Almost all body nitrogen is bound up in protein, so when excretion exceeds intake the body is disposing of more amino-acid nitrogen than it takes in: body protein is being broken down, its amino groups stripped by transamination and oxidative deamination to \(\text{NH}_4^+\), converted to urea in the liver, and lost in the urine. Patient R takes in only 8 g/day but excretes 15 g/day, a deficit of 7 g/day, so R alone shows negative nitrogen balance and net protein loss.

(Choice D) is correct: for Patient R, excretion (15) exceeds intake (8), a negative nitrogen balance indicating net breakdown of body protein, the catabolic, tissue-wasting state described.
(Choice A) is incorrect: Patient Q takes in more (14) than is excreted (9), a positive balance in which nitrogen is being retained to build tissue (anabolic/growth), the opposite of wasting; the large intake-excretion gap is being interpreted backward.
(Choice B) is incorrect: Patient P has intake equal to excretion (12 = 12), a neutral (zero) balance in which protein synthesis and breakdown offset, so there is no net catabolism.
(Choice C) is incorrect: Patient S likewise has intake equal to excretion (11 = 11), a neutral balance, so S is not in a wasting state either.

This is a Data-Based and Statistical Reasoning question because you must compare the intake and excretion values in the table to infer the direction of each patient''s nitrogen balance, rather than recall a definition.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 4, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'reads positive balance as wasting' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'treats neutral balance as catabolic' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'treats neutral balance as catabolic' FROM q;

-- Q77 [K14 · Amino-Acid Catabolism] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Amino-Acid Catabolism', 'A patient with a severe dietary vitamin B6 (pyridoxine) deficiency cannot make adequate pyridoxal phosphate. Considering the enzymes that depend on this cofactor, which consequence for amino-acid handling is most directly expected?', '[{"label": "A", "text": "Transamination reactions are impaired, hindering transfer of amino groups onto \\(\\alpha\\)-ketoglutarate"}, {"label": "B", "text": "Oxidative deamination by glutamate dehydrogenase is blocked, so no ammonia can ever form"}, {"label": "C", "text": "The urea cycle enzymes lose their cofactor, so urea synthesis stops entirely"}, {"label": "D", "text": "Fatty-acid \\(\\beta\\)-oxidation halts because its enzymes require the cofactor"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is A because pyridoxal phosphate (PLP), the active form of vitamin B6, is the required cofactor for aminotransferases (transaminases). Without adequate PLP, transamination is impaired, so amino groups cannot be efficiently transferred from amino acids onto \(\alpha\)-ketoglutarate to form glutamate. This bottlenecks the first step of collecting nitrogen for disposal and the catabolism of amino-acid carbon skeletons.

(Choice B) is incorrect: glutamate dehydrogenase uses a nicotinamide cofactor, not PLP, so oxidative deamination itself is not PLP-dependent; ammonia formation is reduced only indirectly because less glutamate is made upstream, not because deamination is directly blocked.
(Choice C) is incorrect: the urea cycle enzymes do not require PLP, so a B6 deficiency does not directly shut off urea synthesis.
(Choice D) is incorrect: fatty-acid \(\beta\)-oxidation does not depend on PLP, so it is not the direct casualty of a B6 deficiency.
(Choice A) is correct: transaminases are the PLP-dependent enzymes, so their reactions are the ones most directly impaired, hindering transfer of amino groups onto \(\alpha\)-ketoglutarate.

This is a Scientific Reasoning and Problem Solving question because you must reason from which enzymes depend on PLP to predict the specific step of nitrogen handling that fails.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'assigns PLP dependence to glutamate dehydrogenase' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'assumes urea cycle needs PLP' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'assumes beta-oxidation needs PLP' FROM q;

-- Q78 [L15 · Urea Cycle & Metabolic Integration] easy skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Urea Cycle & Metabolic Integration', 'When amino acids are catabolized for energy, their alpha-amino groups are funneled toward free ammonia. A physiology student proposes that the body could simply hold this nitrogen in a soluble ammonia pool between meals and release it later, avoiding the ATP cost of building a carrier molecule. Which of the following best explains why the body does NOT store nitrogen this way?', '[{"label": "A", "text": "Free ammonia diffuses too slowly across membranes to be recovered from a storage pool, so cells cannot retrieve it once it is released."}, {"label": "B", "text": "Free ammonia is toxic, especially to the central nervous system, so even modest accumulation would threaten the brain and nitrogen must be trapped in a nontoxic form."}, {"label": "C", "text": "Free ammonia is chemically inert, so storing it would waste the nitrogen because no enzyme could later reincorporate it into biomolecules."}, {"label": "D", "text": "Free ammonia is strongly acidic, so a stored pool would overwhelm the blood buffers and drop blood pH into a dangerous range."}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is B because the reason nitrogen cannot simply be pooled is a matter of toxicity, not of chemistry convenience. Free ammonia \(\text{NH}_4^+/\text{NH}_3\) is toxic to tissues and especially to the brain, where rising levels disrupt neuronal function. A soluble ammonia reservoir would expose the CNS to exactly the concentrations the body works to avoid, so nitrogen is instead captured into a nontoxic, water-soluble carrier before it can build up.

(Choice B) is correct: the hazard of a stored ammonia pool is its neurotoxicity, so the body converts nitrogen to a safe form rather than accumulating free ammonia.

(Choice A) is incorrect: the problem is not sluggish recovery of ammonia. \(\text{NH}_3\) actually crosses membranes readily; the reason it cannot be stockpiled is that any appreciable free-ammonia level is dangerous, not that it would be hard to retrieve.

(Choice C) is incorrect: ammonia is far from inert. It is a reactive nitrogen source that enzymes such as glutamate dehydrogenase and glutamine synthetase readily handle. Storage is avoided because ammonia is toxic, not because the nitrogen would be chemically stranded.

(Choice D) is incorrect: this invokes a pH catastrophe as the danger. Ammonia is in fact a weak base, not a strong acid, and while it participates in acid-base handling, the core reason a stored pool is unacceptable is direct neurotoxicity at low concentrations, not a wholesale collapse of blood buffering.

This is a Skill 2 (Reasoning About Scientific Principles) item because it asks you to reason from the toxic property of free ammonia to the physiological design choice of trapping nitrogen rather than storing it.', 'easy', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'Invents a kinetic/retrieval barrier as the reason nitrogen is not pooled, ignoring that ammonia crosses membranes easily and the real issue is toxicity' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'Frames ammonia as inert and the nitrogen as unrecoverable, contradicting its known reactivity and enzymatic reincorporation' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'Overstates a real acid-base link into a pH-collapse mechanism, substituting a buffering catastrophe for the actual direct neurotoxicity' FROM q;

-- Q79 [L16 · Urea Cycle & Metabolic Integration] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Urea Cycle & Metabolic Integration', 'Nitrogen from amino-acid breakdown throughout the body is ultimately excreted as urea in the urine. Considering both where toxic ammonia is safely neutralized and where the finished waste molecule leaves the body, which of the following best describes the division of labor between the liver and the kidney in this disposal pathway?', '[{"label": "A", "text": "The kidney converts ammonia to urea and the liver filters urea from the blood for storage in bile."}, {"label": "B", "text": "The liver and kidney each independently synthesize urea, and both organs excrete it directly across their epithelia."}, {"label": "C", "text": "The liver detoxifies ammonia by building it into urea, and the kidney clears that urea from blood into urine for excretion."}, {"label": "D", "text": "The kidney detoxifies ammonia into urea while the liver reabsorbs urea so its nitrogen can be reused for protein synthesis."}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is C because the two organs play distinct, sequential roles. The liver is the site of the urea cycle: it takes toxic \(\text{NH}_4^+\) and locks its nitrogen into urea, a nontoxic, water-soluble molecule. That urea then travels in the blood to the kidney, whose job is filtration and excretion, and it is cleared into the urine. The detoxification chemistry happens in the liver; the disposal happens at the kidney.

(Choice C) is correct: the liver performs the detoxifying synthesis of urea, and the kidney excretes the urea it receives from the blood.

(Choice A) is incorrect: it reverses the roles, placing urea synthesis in the kidney and casting the liver as a filter. The liver does not filter urea out for storage in bile; it is the organ that makes urea, and the kidney excretes it.

(Choice B) is incorrect: it makes both organs redundant urea factories. Urea synthesis is concentrated in the liver via the urea cycle, not carried out equivalently in both organs, and the kidney''s role is excretion, not synthesis.

(Choice D) is incorrect: it both reverses the synthesis site and misstates the fate of urea. Urea is a terminal waste product destined for excretion, not a nitrogen store the liver reclaims for protein synthesis; reusable nitrogen is handled upstream (e.g., via glutamate), not by recovering excreted urea.

This is a Skill 2 (Reasoning About Scientific Principles) item because it asks you to reason about the logic of a disposal pathway and assign each step to the correct organ, rather than recall an isolated fact.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'Swaps the organ roles, giving the kidney the synthesis step and the liver a filtering/storage role that belongs to neither' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'Treats both organs as interchangeable urea synthesizers/excretors, erasing the liver-synthesis vs kidney-excretion division' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'Reverses the synthesis site and adds a false urea-nitrogen recycling step, ignoring that urea is a terminal waste product' FROM q;

-- Q80 [L17 · Urea Cycle & Metabolic Integration] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Urea Cycle & Metabolic Integration', 'A researcher feeds a subject amino acids in which the alpha-amino nitrogen is isotopically labeled and separately labels the alpha-amino nitrogen of the aspartate pool, then collects excreted urea, H2N–CO–NH2. Tracing the two nitrogen atoms and the single carbon atom of each urea molecule back to their immediate sources, which of the following correctly assigns their origins?', '[{"label": "A", "text": "Both nitrogens come from aspartate, and the carbon comes from free ammonia."}, {"label": "B", "text": "Both nitrogens come from free ammonia, and the carbon comes from aspartate."}, {"label": "C", "text": "One nitrogen comes from free ammonia and the other from aspartate, while the carbon comes from a second molecule of free ammonia."}, {"label": "D", "text": "One nitrogen comes from free ammonia and the other from aspartate, while the carbon comes from CO2 (bicarbonate)."}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is D because urea, \(\text{H}_2\text{N–CO–NH}_2\), assembles its atoms from three distinct sources. One nitrogen enters as free ammonia \(\text{NH}_4^+\) generated by oxidative deamination, and the second nitrogen is donated by aspartate. The lone carbon of the carbonyl comes from \(\text{CO}_2\)/bicarbonate, which is fixed at the start of the cycle. Tracing each atom therefore gives two nitrogens from two different donors and a carbon from \(\text{CO}_2\).

(Choice D) is correct: the two nitrogens trace to free ammonia and to aspartate respectively, and the carbon traces to \(\text{CO}_2\)/bicarbonate.

(Choice A) is incorrect: it assigns both nitrogens to aspartate and, implausibly, the carbon to ammonia. Only one nitrogen is aspartate-derived, and ammonia supplies nitrogen, not the carbonyl carbon.

(Choice B) is incorrect: it credits both nitrogens to free ammonia and the carbon to aspartate. Aspartate contributes one nitrogen, not the carbon skeleton of the carbonyl, and only one nitrogen is ammonia-derived.

(Choice C) is incorrect: it gets the two nitrogen sources right but assigns the carbon to a second ammonia molecule. The carbonyl carbon is supplied by \(\text{CO}_2\)/bicarbonate, not by ammonia.

This is a Skill 2 (Reasoning About Scientific Principles) item because it asks you to reason atom-by-atom about where each part of an excreted molecule originates, rather than recall the fact as a slogan.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'Assigns both nitrogens to aspartate and the carbon to ammonia, scrambling which donor supplies nitrogen versus carbon' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'Credits both nitrogens to free ammonia and treats aspartate as the carbon source, missing aspartate''s role as a second nitrogen donor' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'Gets both nitrogen sources correct but wrongly sources the carbonyl carbon from ammonia instead of CO2/bicarbonate' FROM q;

-- Q81 [L18 · Urea Cycle & Metabolic Integration] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Urea Cycle & Metabolic Integration', 'The urea cycle and the citric acid (TCA) cycle are sometimes called the ''Krebs bicycle'' because a shared intermediate couples them. Suppose an inhibitor blocks the mitochondrial conversion of oxaloacetate to aspartate. Assuming no compensatory pathways, which coupled effect on the two cycles is most directly expected?', '[{"label": "A", "text": "Urea synthesis falls because its aspartate-derived nitrogen donor is depleted, and the fumarate the urea cycle normally feeds back to the TCA cycle also declines."}, {"label": "B", "text": "Urea synthesis rises because oxaloacetate is diverted directly into the urea cycle as a nitrogen carrier."}, {"label": "C", "text": "TCA flux rises because oxaloacetate accumulates and drives citrate synthesis, with no effect on the urea cycle."}, {"label": "D", "text": "Urea synthesis is unaffected because both urea nitrogens come from free ammonia, so aspartate supply is irrelevant."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is A because the two cycles are linked through aspartate and fumarate. Aspartate, made from TCA-derived oxaloacetate by transamination, carries the second nitrogen into the urea cycle; the urea cycle in turn releases fumarate, which re-enters the TCA cycle. Blocking oxaloacetate-to-aspartate conversion starves the urea cycle of its aspartate-derived nitrogen, so urea output drops. Because the exported fumarate is generated from that same aspartate (aspartate enters, then argininosuccinate is cleaved to release fumarate), the fumarate the urea cycle feeds back to the TCA cycle also declines, so the block propagates across both halves of the bicycle.

(Choice A) is correct: losing aspartate cuts the second nitrogen donor (lowering urea synthesis) and simultaneously reduces the fumarate the urea cycle feeds back to the TCA cycle.

(Choice B) is incorrect: it imagines oxaloacetate entering the urea cycle directly as a nitrogen carrier. Oxaloacetate carries no nitrogen and must first be transaminated to aspartate to donate one; blocking that step lowers, not raises, urea synthesis.

(Choice C) is incorrect: it treats the urea cycle as decoupled. Because aspartate and fumarate link the cycles, a block at the aspartate step does affect the urea cycle rather than leaving it untouched.

(Choice D) is incorrect: it claims both urea nitrogens come from ammonia, making aspartate dispensable. Only one nitrogen is ammonia-derived; the other is supplied by aspartate, so its loss impairs urea synthesis.

This is a Skill 2 (Reasoning About Scientific Principles) item because it asks you to reason about how a perturbation propagates through two integrated cycles via their shared intermediates, not to recall a named fact.', 'hard', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'process_step_confusion', 'Skips the transamination step and has oxaloacetate itself enter the urea cycle, predicting a rise instead of a fall in urea synthesis' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'Treats the two cycles as decoupled, denying the aspartate/fumarate linkage that transmits the perturbation' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'Claims both urea nitrogens are ammonia-derived, erasing aspartate''s role and wrongly predicting no effect' FROM q;

-- Q82 [L19 · Urea Cycle & Metabolic Integration] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Urea Cycle & Metabolic Integration', 'An infant with an inherited deficiency in a urea-cycle enzyme presents with lethargy, seizures, and coma that worsen after a high-protein meal. Reasoning from the blocked step to the clinical picture, which chain of events best accounts for the neurological symptoms?', '[{"label": "A", "text": "The block prevents urea from being broken back down into ammonia, so a shortage of ammonia in neurons impairs neurotransmission."}, {"label": "B", "text": "The block keeps ammonia from being built into urea, so ammonia builds up in the blood and reaches the brain, where it is neurotoxic and a protein load makes it worse."}, {"label": "C", "text": "The block causes urea to accumulate to toxic levels in the blood, and it is the excess urea that directly poisons neurons."}, {"label": "D", "text": "The block halts glucose production from amino acids, so the brain is starved of fuel and a protein meal cannot relieve the deficit."}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is B because a defective urea-cycle enzyme interrupts the pathway that converts ammonia into urea. With that disposal route blocked, free ammonia \(\text{NH}_4^+\) builds up in the blood (hyperammonemia) and crosses into the brain, where it is neurotoxic and produces lethargy, seizures, and coma. A high-protein meal delivers more amino acids to deaminate, generating still more ammonia the blocked cycle cannot clear, so symptoms worsen. The toxic species is the substrate that piles up behind the block, ammonia, not the product that fails to form.

(Choice B) is correct: the enzyme defect traps nitrogen as ammonia, which accumulates and injures the brain, and a protein load intensifies the ammonia burden.

(Choice A) is incorrect: it reverses the pathway''s direction, treating the cycle as one that liberates ammonia from urea and casting an ammonia shortage as the problem. The cycle consumes ammonia; a block causes ammonia excess, not deficiency.

(Choice C) is incorrect: it blames the product, urea. A block upstream reduces urea formation and causes the toxic substrate ammonia to accumulate instead; urea itself is the nontoxic molecule the pathway is trying to make.

(Choice D) is incorrect: it substitutes a fuel-shortage story for a toxicity story. The urea cycle disposes of nitrogen; its failure causes ammonia buildup, and the worsening after protein reflects more ammonia, not a gluconeogenic fuel crisis.

This is a Skill 2 (Reasoning About Scientific Principles) item because it asks you to reason from a blocked disposal step through substrate accumulation to a clinical consequence.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'Runs the cycle backward, casting it as ammonia-releasing and blaming an ammonia shortage rather than the accumulation caused by the block' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'Blames the downstream product urea instead of the upstream substrate ammonia that accumulates behind the block' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'Swaps the nitrogen-disposal role for a gluconeogenic fuel role, attributing the symptoms to brain fuel starvation' FROM q;

-- Q83 [L20 · Urea Cycle & Metabolic Integration] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Urea Cycle & Metabolic Integration', 'Different animals excrete surplus nitrogen as ammonia, urea, or uric acid. Ammonia is cheap to make but highly toxic and requires large volumes of water for dilution; uric acid is nearly nontoxic and needs little water but is metabolically expensive to synthesize. Given that terrestrial mammals such as humans are ureotelic, which reasoning best explains why urea is the excreted form chosen over the two alternatives?', '[{"label": "A", "text": "Urea is the most toxic of the three, but mammals tolerate it because their kidneys excrete it faster than ammonia or uric acid."}, {"label": "B", "text": "Urea is chosen because it is the cheapest of the three to synthesize, requiring less ATP than making ammonia."}, {"label": "C", "text": "Urea strikes a balance: far less toxic than ammonia so it can be transported and concentrated safely, yet cheaper to synthesize than uric acid, suiting an animal with adequate but not unlimited water."}, {"label": "D", "text": "Urea is chosen because it requires essentially no water for excretion, allowing mammals to conserve water as strictly as uric-acid excreters do."}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is C because ureotelism is a compromise across two competing costs. Ammonia is the least expensive to produce but is so toxic that it demands large volumes of water for safe dilution, which suits aquatic animals. Uric acid is nearly nontoxic and water-sparing but is metabolically expensive to build, favoring animals under severe water constraint (like birds and reptiles). Urea sits between: its low toxicity lets a mammal transport and concentrate nitrogen safely, while its synthesis is cheaper than uric acid, an appropriate trade-off for a land animal with adequate but finite water.

(Choice C) is correct: urea balances moderate synthetic cost against low toxicity, matching the water availability of terrestrial mammals.

(Choice A) is incorrect: it inverts the toxicity ranking, calling urea the most toxic. Urea is far less toxic than ammonia; that low toxicity is precisely why it can be safely carried and concentrated.

(Choice B) is incorrect: it claims urea is the cheapest to synthesize, cheaper even than ammonia. Making urea costs ATP that simply excreting ammonia does not; urea is chosen for its safety-versus-cost balance, not for being the cheapest.

(Choice D) is incorrect: it overstates urea''s water economy, equating it with uric acid. Urea is excreted dissolved in urine and does require water; it is only more water-efficient than dilute ammonia excretion, not as water-sparing as uric acid.

This is a Skill 2 (Reasoning About Scientific Principles) item because it asks you to reason about a cost-benefit trade-off among excretion strategies rather than recall a single labeled fact.', 'medium', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'Inverts the toxicity ranking, labeling urea the most toxic and inventing a rapid-clearance rationale' FROM q
  UNION ALL
  SELECT id, 'B', 'partial_truth', 'Fixates on the cost axis alone and wrongly rates urea cheaper than ammonia, ignoring the ATP cost of urea synthesis' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'Overstates urea''s water economy to uric-acid levels, ignoring that urea is excreted dissolved in urine' FROM q;

-- Q84 [L21 · Urea Cycle & Metabolic Integration] hard skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Urea Cycle & Metabolic Integration', 'Two blood samples are drawn from a healthy subject: one shortly after a carbohydrate-rich meal and one after an overnight fast. In the fasted sample the insulin-to-glucagon ratio is far lower than in the fed sample, because insulin has fallen and glucagon has risen. Reasoning from this shift in the hormonal ratio, which statement best describes the dominant direction of hepatic and whole-body metabolism in the fasted state?', '[{"label": "A", "text": "The low ratio marks fuel abundance, so anabolic storage dominates: the liver takes up glucose to build glycogen and synthesize fatty acids, and adipose tissue lays down triacylglycerol for later use."}, {"label": "B", "text": "Because insulin still sets the hepatic tone, the liver keeps synthesizing glycogen yet simultaneously exports that same glucose through gluconeogenesis to feed the peripheral tissues."}, {"label": "C", "text": "The fall in the ratio drives the liver to take up circulating amino acids for a burst of net protein synthesis, which becomes the body''s main route for storing the fast''s surplus fuel."}, {"label": "D", "text": "The low ratio marks fuel scarcity, so catabolic mobilization dominates: the liver runs glycogenolysis then gluconeogenesis to release glucose, and adipose lipolysis supplies fatty acids for oxidation."}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is D because whole-body fuel metabolism is set by the insulin-to-glucagon ratio, \( \text{insulin}{:}\text{glucagon} \). A high ratio (the fed sample) is an anabolic signal: liver and muscle take up glucose to build glycogen and fat and to synthesize protein. A low ratio means glucagon (with epinephrine) dominates relative to insulin — an unambiguous catabolic signal. The liver responds by mobilizing fuel: glycogenolysis first, then gluconeogenesis from glycerol, lactate, and glucogenic amino acids, while adipose lipolysis releases fatty acids for oxidation. So the sharp fall in the ratio points whole-body metabolism toward mobilization and glucose export, exactly as option A describes.

(Choice D) is correct: a low \( \text{insulin}{:}\text{glucagon} \) ratio is a catabolic signal, so the liver runs glycogenolysis and gluconeogenesis while adipose tissue undergoes lipolysis — net fuel mobilization.

(Choice A) is incorrect: it reads the low ratio as a signal of abundance and predicts anabolic storage (glycogen and fat synthesis). That is the response to a HIGH ratio in the fed state; a low ratio drives the opposite direction.

(Choice B) is incorrect: it has the liver building glycogen and running gluconeogenesis at the same time. These opposing programs are reciprocally controlled by the ratio — at a low ratio glycogen synthesis is switched off while glycogenolysis and gluconeogenesis are switched on.

(Choice C) is incorrect: a low ratio does not drive net protein synthesis or fuel storage. Fasting is catabolic — amino acids are released and used as gluconeogenic substrate, not consumed to store surplus fuel.

This is a Skill 2 (Reasoning About Scientific Principles) item because it asks you to reason from a described hormonal ratio to the dominant direction of whole-body metabolism.', 'hard', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'Reads a low insulin:glucagon ratio as an anabolic/abundance signal, inverting the fasting catabolic direction into glycogen and fat synthesis' FROM q
  UNION ALL
  SELECT id, 'B', 'process_step_confusion', 'Runs glycogen synthesis and gluconeogenesis simultaneously, ignoring the reciprocal on/off control the hormonal ratio imposes on opposing hepatic pathways' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'Believes fasting drives net hepatic protein synthesis to store surplus fuel, missing that a low ratio is catabolic and amino acids serve as gluconeogenic substrate' FROM q;

-- Q85 [L22 · Urea Cycle & Metabolic Integration] hard skill4 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Lipid and Amino Acid Metabolism', 'Urea Cycle & Metabolic Integration', 'A physiologist samples liver tissue and blood from one subject at a single time point and records four measurements, each flagged relative to an overnight-fasted baseline:

| Measurement | Result vs. baseline |
| --- | --- |
| Blood insulin | High |
| Blood glucagon | Low |
| Hepatic malonyl-CoA | High |
| Blood free fatty acids (albumin-bound) | Low |

Malonyl-CoA is the committed intermediate of cytosolic fatty-acid synthesis and is also an allosteric inhibitor of carnitine palmitoyltransferase I (CPT-I). Based only on these data, which interpretation of the subject''s hormonal state and dominant hepatic fuel-handling pathway is best supported?', '[{"label": "A", "text": "A fed state in which the liver favors fatty-acid synthesis, and mitochondrial fatty-acid oxidation is concurrently suppressed."}, {"label": "B", "text": "A fasting state in which the liver is exporting glucose by gluconeogenesis while oxidizing incoming fatty acids."}, {"label": "C", "text": "A fasting state in which the liver is oxidizing fatty acids and shunting the resulting acetyl-CoA into ketone bodies."}, {"label": "D", "text": "A fed state in which the liver favors fatty-acid synthesis while simultaneously exporting those fatty acids for peripheral oxidation."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Metabolism of Fatty Acids and Proteins.''

The answer is A because the four values must be read together, not one at a time. A high insulin with low glucagon gives a high insulin:glucagon ratio, which is the anabolic, fed hormonal signal that drives storage pathways. High hepatic malonyl-CoA confirms this at the substrate level: malonyl-CoA is the committed intermediate of fatty-acid synthesis, so its accumulation means lipogenesis is running. The stem also tells you malonyl-CoA inhibits CPT-I, the rate-limiting step of the carnitine shuttle; with CPT-I blocked, long-chain fatty acids cannot enter the mitochondrion, so beta-oxidation is shut off at the same time synthesis is on. The low circulating free fatty acids fit the fed state as well, because high insulin suppresses adipose hormone-sensitive lipase, so little fat is being mobilized. Integrating hormone ratio plus substrate signals gives a fed subject whose liver favors fatty-acid synthesis with oxidation reciprocally suppressed.

(Choice A) is correct: high insulin:glucagon plus high malonyl-CoA plus low free fatty acids together indicate a fed, anabolic state in which lipogenesis dominates and malonyl-CoA-mediated CPT-I inhibition blocks concurrent fatty-acid oxidation.

(Choice B) is incorrect: it reverses the hormonal reading. A high insulin:glucagon ratio and high malonyl-CoA are fed-state signals, whereas gluconeogenesis and hepatic fatty-acid oxidation are fasting processes that require a low insulin:glucagon ratio and low malonyl-CoA to relieve CPT-I inhibition. The data show the opposite hormonal pattern.

(Choice C) is incorrect: ketogenesis from fatty-acid oxidation is a fasting outcome that depends on a low insulin:glucagon ratio and low malonyl-CoA so that CPT-I is active. Here malonyl-CoA is high and CPT-I is therefore inhibited, so fatty acids cannot be oxidized and ketones cannot be made.

(Choice D) is incorrect: it correctly reads the fed, lipogenic hormonal state but pairs it with the liver exporting fatty acids for peripheral oxidation. Simultaneous net synthesis and net export for oxidation is not what these values support, and the low blood free fatty acids argue against active fat release; the fed liver is making and storing fat, not shipping it out to be burned.

This is a Skill 4 (Data-Based and Statistical Reasoning) item because it requires you to integrate several data points — a hormone ratio plus two substrate levels and a stated regulatory relationship — to infer both the hormonal state and the dominant pathway, rather than recall a single state''s definition or read a single flagged analyte.', 'hard', '1D', 'Metabolism of Fatty Acids and Proteins', 'biochemistry', 4, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'Reads high insulin:glucagon and high malonyl-CoA as a fasting profile, inverting the fed-state hormonal signal and assigning gluconeogenesis plus fat oxidation' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'Assumes fatty-acid oxidation and ketogenesis can run despite high malonyl-CoA, ignoring that malonyl-CoA-mediated CPT-I inhibition blocks the carnitine shuttle' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'Correctly identifies the fed lipogenic state but wrongly couples it with simultaneous fatty-acid export for peripheral oxidation, contradicting the low blood free fatty acids' FROM q;

COMMIT;
