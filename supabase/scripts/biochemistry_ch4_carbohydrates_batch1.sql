-- Carbohydrate Structure and Function — Batch 1 — classification, stereochemistry & cyclic sugars (with figures)
-- Original Praxist Prep questions, grounded in LibreTexts Biochemistry; scope verified vs AAMC 2026 outline.
-- Idempotent: deletes only this batch's subtopics, then re-inserts. question_attempts / distractor_metadata cascade.

-- Figure support (idempotent; adds the columns if the live DB lacks them).
ALTER TABLE questions ADD COLUMN IF NOT EXISTS figure_svg TEXT;
ALTER TABLE questions ADD COLUMN IF NOT EXISTS figure_url TEXT;

DELETE FROM questions WHERE topic = 'Carbohydrate Structure and Function' AND subtopic IN ('Absolute Configuration (D/L)', 'Chair Conformation & Mutarotation', 'Cyclic Sugars & Anomers', 'Monosaccharide Classification', 'Stereochemistry & Isomerism');

-- Q1 [Monosaccharide Classification] medium skill2 ans=A [FIG]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Monosaccharide Classification', 'A monosaccharide is drawn as the Fischer projection shown above. Based on the carbonyl group and the number of carbon atoms in the structure shown, this sugar is best classified as which of the following?', '[{"label": "A", "text": "Ketohexose"}, {"label": "B", "text": "Aldohexose"}, {"label": "C", "text": "Ketopentose"}, {"label": "D", "text": "Aldopentose"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is A because a monosaccharide is named by combining a prefix for its carbonyl group (aldo- for an aldehyde, keto- for a ketone) with a root for its carbon count (pentose for five carbons, hexose for six). Reading the Fischer projection shown from top to bottom, the backbone contains six carbons, and the carbonyl is located on an interior carbon that bears a \(\text{CH}_2\text{OH}\) group above it rather than a terminal \(\text{H}\). An interior \(\text{C}=\text{O}\) flanked by carbon on both sides is a ketone, so this sugar is a keto sugar with six carbons: a ketohexose. This matches the classification of D-fructose.

(Choice A) is correct: the structure shown has six backbone carbons and an interior ketone carbonyl, which together define a ketohexose.

(Choice B) is incorrect: aldohexose keeps the correct six-carbon count but assigns the wrong carbonyl type. It would require the \(\text{C}=\text{O}\) to sit at a terminal carbon bonded to \(\text{H}\) (an aldehyde, as in glucose). The carbonyl in the structure shown is not terminal, so it is a ketone, not an aldehyde.

(Choice C) is incorrect: ketopentose identifies the carbonyl correctly but miscounts the backbone. A pentose has five carbons; counting every carbon in the projection shown gives six, so the root must be -hexose, not -pentose.

(Choice D) is incorrect: aldopentose assigns the wrong carbonyl type and the wrong carbon count. It would describe a five-carbon sugar with a terminal aldehyde (as in ribose), matching neither the carbonyl nor the length of the structure shown.

This is a Skill 2 question because it asks you to apply the aldose/ketose and carbon-count naming rules to a specific structure you must interpret, rather than recall a definition.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 2, 75, '<svg style="max-width:190px;margin-inline:auto" viewBox="0 0 180 300" xmlns="http://www.w3.org/2000/svg" fill="none" stroke="#1a1a1a" stroke-width="1.6" stroke-linecap="round" font-family="''Helvetica Neue'',Arial,sans-serif"><line x1="90" y1="50" x2="90" y2="250"/><text x="90" y="42" text-anchor="middle" font-size="15.5" fill="#1a1a1a" stroke="none">CH<tspan dy="4" font-size="11">2</tspan><tspan dy="-4">OH</tspan></text><line x1="90" y1="84" x2="115" y2="84"/><line x1="90" y1="88" x2="115" y2="88"/><text x="123" y="86" text-anchor="start" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">O</text><line x1="54" y1="126" x2="126" y2="126"/><text x="46" y="126" text-anchor="end" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">HO</text><text x="134" y="126" text-anchor="start" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">H</text><line x1="54" y1="166" x2="126" y2="166"/><text x="46" y="166" text-anchor="end" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">H</text><text x="134" y="166" text-anchor="start" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">OH</text><line x1="54" y1="206" x2="126" y2="206"/><text x="46" y="206" text-anchor="end" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">H</text><text x="134" y="206" text-anchor="start" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">OH</text><text x="90" y="270" text-anchor="middle" font-size="15.5" fill="#1a1a1a" stroke="none">CH<tspan dy="4" font-size="11">2</tspan><tspan dy="-4">OH</tspan></text></svg>')
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'Misreads an interior ketone carbonyl as a terminal aldehyde, defaulting to the more familiar aldose (glucose-like) pattern while keeping the correct carbon count' FROM q
  UNION ALL
  SELECT id, 'C', 'scale_unit_error', 'Correctly identifies the ketone but miscounts the backbone carbons, undercounting a hexose as a pentose' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'Errs on both axes at once — treats the carbonyl as an aldehyde and the chain as five carbons, yielding the ribose-like classification' FROM q;

-- Q2 [Monosaccharide Classification] easy skill1 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Monosaccharide Classification', 'D-ribose, the sugar found in the backbone of RNA nucleotides, is best classified by its carbon count and the type of its carbonyl group as which of the following?', '[{"label": "A", "text": "An aldohexose"}, {"label": "B", "text": "An aldopentose"}, {"label": "C", "text": "A ketopentose"}, {"label": "D", "text": "An aldotetrose"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is B because monosaccharides are named by combining the type of carbonyl group with the number of carbons in the chain. D-ribose has a five-carbon backbone, and its carbonyl is a terminal \(\text{–CHO}\) group (a carbon double-bonded to oxygen and bonded to one hydrogen), which is an aldehyde. A five-carbon sugar bearing an aldehyde is therefore an aldopentose, the class to which D-ribose belongs.

(Choice B) is correct: ribose has five carbons (the "pent-" root) and a terminal aldehyde carbonyl (the "aldo-" prefix), making it an aldopentose.

(Choice A) is incorrect: "hex-" designates a six-carbon backbone, as in glucose (an aldohexose). Ribose has one fewer carbon than that, so calling it an aldohexose overcounts the skeleton by one carbon.

(Choice C) is incorrect: the "keto-" prefix requires a ketone carbonyl, in which the carbonyl carbon is bonded to two other carbons (as in fructose). Ribose''s carbonyl carbon instead carries a hydrogen, marking it an aldehyde, so a ketopentose classification misreads the carbonyl even though the "pent-" count is right.

(Choice D) is incorrect: "tetr-" designates a four-carbon backbone. Ribose''s chain is longer than that, so aldotetrose undercounts the skeleton, even though it correctly recognizes the carbonyl as an aldehyde.

This is a Skill 1 (Knowledge of Scientific Concepts) item: it asks you to apply the standard carbohydrate naming convention by recalling the carbon count and carbonyl type of a common monosaccharide.', 'easy', '1D', 'Carbohydrates', 'biochemistry', 1, 45, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'scale_unit_error', 'miscounts carbon chain length (off by one, defaults to the most familiar hexose glucose)' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'confuses an aldehyde carbonyl with a ketone carbonyl while counting carbons correctly' FROM q
  UNION ALL
  SELECT id, 'D', 'scale_unit_error', 'undercounts carbon chain length (off by one toward tetrose)' FROM q;

-- Q3 [Stereochemistry & Isomerism] medium skill2 ans=C [FIG]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Stereochemistry & Isomerism', 'A monosaccharide is drawn as the Fischer projection shown above, with its carbonyl carbon at the top and a –CH₂OH group at the bottom. Assuming free rotation is not possible about the interior carbon–carbon bonds, what is the maximum number of stereoisomers that share the same constitution (connectivity) as the molecule depicted?', '[{"label": "A", "text": "32 stereoisomers"}, {"label": "B", "text": "8 stereoisomers"}, {"label": "C", "text": "16 stereoisomers"}, {"label": "D", "text": "6 stereoisomers"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is C because the maximum number of stereoisomers a molecule can have is \(2^n\), where \(n\) is the number of stereocenters (chiral carbons). To solve, you must first inspect the Fischer projection and count the carbons that bear four different groups. In the structure shown, the carbonyl carbon at the top and the –CH₂OH carbon at the bottom are not stereocenters, but each of the four interior carbons in between carries an –H on one side and an –OH on the other while being flanked by different chains, making all four asymmetric. With \(n = 4\), the maximum number of stereoisomers is \(2^4 = 16\).

(Choice C) is correct: counting the four asymmetric interior carbons gives \(n = 4\), so \(2^4 = 16\).

(Choice B) is incorrect: \(8 = 2^3\) results from undercounting by one stereocenter — a common error is treating the carbon adjacent to the carbonyl (or the one nearest the –CH₂OH terminus) as non-chiral, leaving only three.

(Choice A) is incorrect: \(32 = 2^5\) results from overcounting by one — mistakenly including a terminal carbon (the carbonyl carbon or the –CH₂OH carbon) as a fifth stereocenter, even though neither bears four different substituents.

(Choice D) is incorrect: 6 corresponds to the total number of carbons in the backbone, not \(2^n\). This choice confuses the length of the carbon chain with the count used in the stereoisomer formula.

As a Skill 2 problem, this requires extracting a structural feature from the figure — identifying which carbons in the projection are true stereocenters — and then applying the \(2^n\) relationship, rather than recalling a memorized number.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 2, 75, '<svg style="max-width:190px;margin-inline:auto" viewBox="0 0 180 300" xmlns="http://www.w3.org/2000/svg" fill="none" stroke="#1a1a1a" stroke-width="1.6" stroke-linecap="round" font-family="''Helvetica Neue'',Arial,sans-serif"><line x1="90" y1="50" x2="90" y2="250"/><text x="90" y="42" text-anchor="middle" font-size="15.5" fill="#1a1a1a" stroke="none">CHO</text><line x1="54" y1="86" x2="126" y2="86"/><text x="46" y="86" text-anchor="end" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">H</text><text x="134" y="86" text-anchor="start" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">OH</text><line x1="54" y1="126" x2="126" y2="126"/><text x="46" y="126" text-anchor="end" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">HO</text><text x="134" y="126" text-anchor="start" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">H</text><line x1="54" y1="166" x2="126" y2="166"/><text x="46" y="166" text-anchor="end" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">H</text><text x="134" y="166" text-anchor="start" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">OH</text><line x1="54" y1="206" x2="126" y2="206"/><text x="46" y="206" text-anchor="end" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">H</text><text x="134" y="206" text-anchor="start" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">OH</text><text x="90" y="270" text-anchor="middle" font-size="15.5" fill="#1a1a1a" stroke="none">CH<tspan dy="4" font-size="11">2</tspan><tspan dy="-4">OH</tspan></text></svg>')
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'process_step_confusion', 'undercount_stereocenters_off_by_one' FROM q
  UNION ALL
  SELECT id, 'A', 'process_step_confusion', 'overcount_stereocenters_include_terminal' FROM q
  UNION ALL
  SELECT id, 'D', 'scale_unit_error', 'confuse_chain_length_with_stereocenter_count' FROM q;

-- Q4 [Monosaccharide Classification] easy skill1 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Monosaccharide Classification', 'Ribulose, a five-carbon monosaccharide that functions as an intermediate in the pentose phosphate pathway, carries a ketone group rather than an aldehyde. If the carbon skeleton of ribulose is numbered according to standard carbohydrate nomenclature, which carbon bears the carbonyl group?', '[{"label": "A", "text": "C1"}, {"label": "B", "text": "C5"}, {"label": "C", "text": "C3"}, {"label": "D", "text": "C2"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is D because carbohydrate numbering assigns the lowest possible locant to the most oxidized carbon, which is the carbonyl carbon. In a ketose such as ribulose, the carbonyl cannot sit at a terminal position (a terminal carbon bonded to only one other carbon would be an aldehyde, i.e., an aldose). The carbonyl is therefore placed as close to the end of the chain as its ketone identity allows, giving it the second carbon, \(C2\). The terminal carbon nearest the carbonyl, \(C1\), is a \(-CH_2OH\) group.

(Choice A) is incorrect: \(C1\) would be the carbonyl carbon only for an aldose, where the carbonyl is a terminal aldehyde (\(-CHO\)). The stem specifies a ketone, so \(C1\) is instead a hydroxymethyl (\(-CH_2OH\)) group, and the carbonyl must lie internally.

(Choice D) is correct: a ketose''s carbonyl receives the lowest locant compatible with being a ketone, and the smallest possible number for an internal carbonyl carbon is \(C2\).

(Choice C) is incorrect: placing the carbonyl at \(C3\) treats it as merely "somewhere in the middle" rather than at the lowest permissible locant. Numbering always favors the lower number, so as long as \(C2\) can host the carbonyl, \(C3\) is not chosen.

(Choice B) is incorrect: \(C5\) is the opposite terminal carbon from \(C1\). Assigning the carbonyl the highest locant reverses the rule that the most oxidized carbon takes the lowest number; \(C5\) is a terminal \(-CH_2OH\), not the carbonyl.

This question asks you to recall and apply the basic carbohydrate numbering convention (Skill 1): the carbonyl carbon is the most oxidized carbon and is given the lowest possible locant, so an aldose''s carbonyl is \(C1\) and a ketose''s is \(C2\).', 'easy', '1D', 'Carbohydrates', 'biochemistry', 1, 60, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'Treats every sugar''s carbonyl as a terminal aldehyde (C1), ignoring that a ketone must be internal' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'Believes a ketone''s carbonyl sits in the geometric middle of the chain rather than at the lowest permissible locant' FROM q
  UNION ALL
  SELECT id, 'B', 'reversed_relationship', 'Reverses the locant rule, assigning the carbonyl the highest number instead of the lowest' FROM q;

-- Q5 [Absolute Configuration (D/L)] medium skill2 ans=B [FIG]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Absolute Configuration (D/L)', 'The Fischer projection shown depicts an aldohexose drawn in its open-chain form, with the aldehyde carbon (C1) at the top and the terminal CH2OH at the bottom. A student is asked to assign the absolute (D or L) configuration of this sugar and to justify the assignment. Which of the following correctly states both the configuration and the structural basis for that assignment?', '[{"label": "A", "text": "It is an L sugar, because the hydroxyl group on its highest-numbered chiral carbon is oriented on the right side of the Fischer projection."}, {"label": "B", "text": "It is a D sugar, because the hydroxyl group on its highest-numbered chiral carbon is oriented on the right side of the Fischer projection."}, {"label": "C", "text": "It is a D sugar, because the hydroxyl group on the carbon adjacent to the carbonyl is oriented on the right side of the Fischer projection."}, {"label": "D", "text": "It is a D sugar, because the hydroxyl group on the anomeric carbon that forms the ring is oriented on the right side of the Fischer projection."}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is B because the D/L configuration of a sugar is defined by the orientation of the hydroxyl group on the chiral center most remote from the carbonyl carbon, which in an aldohexose is C5 — the highest-numbered stereocenter (the terminal CH2OH carbon, C6, is not a stereocenter). Reading the Fischer projection shown, the OH on that carbon extends to the right of the vertical backbone. By convention every sugar is referenced to glyceraldehyde: when the OH on the last (highest-numbered) chiral carbon points right, as in D-glyceraldehyde, the sugar is assigned the D configuration. Extracting that single orientation from the figure and mapping it to the reference rule yields D.

(Choice B) is correct: it identifies the correct reference carbon (the highest-numbered chiral center) and applies the correct rule (OH on the right of the Fischer projection at that carbon defines D).

(Choice A) is incorrect: it inspects the correct carbon but reverses the rule. An OH pointing to the right at the highest-numbered chiral center defines D, not L; L is assigned only when that OH points to the left (\(L =\) Last carbon, Left OH). This is the reversed-relationship trap.

(Choice C) is incorrect: it lands on the D configuration but justifies it using the wrong stereocenter — the carbon adjacent to the carbonyl (C2), which is the chiral center nearest the aldehyde. D/L is set by the most remote chiral center, not the nearest one; using C2 would misassign many sugars (for example, sugars that are epimeric at an internal carbon), so the reasoning is invalid even though the label happens to match.

(Choice D) is incorrect: it invokes the anomeric carbon, which does not exist in the open-chain Fischer form shown and, when the ring does close, governs the \(\alpha/\beta\) designation — not the D/L designation. Anomers differ only at the hemiacetal/acetal carbon; that distinction is unrelated to absolute D/L configuration.

Skill 2: this item requires applying the D/L assignment convention to a specific structure — you must locate the correct diagnostic carbon in the figure, read the orientation of its OH, and connect that observation to the glyceraldehyde reference rule rather than recalling a memorized fact.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 2, 75, '<svg style="max-width:190px;margin-inline:auto" viewBox="0 0 180 300" xmlns="http://www.w3.org/2000/svg" fill="none" stroke="#1a1a1a" stroke-width="1.6" stroke-linecap="round" font-family="''Helvetica Neue'',Arial,sans-serif"><line x1="90" y1="50" x2="90" y2="250"/><text x="90" y="42" text-anchor="middle" font-size="15.5" fill="#1a1a1a" stroke="none">CHO</text><line x1="54" y1="86" x2="126" y2="86"/><text x="46" y="86" text-anchor="end" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">H</text><text x="134" y="86" text-anchor="start" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">OH</text><line x1="54" y1="126" x2="126" y2="126"/><text x="46" y="126" text-anchor="end" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">HO</text><text x="134" y="126" text-anchor="start" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">H</text><line x1="54" y1="166" x2="126" y2="166"/><text x="46" y="166" text-anchor="end" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">H</text><text x="134" y="166" text-anchor="start" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">OH</text><line x1="54" y1="206" x2="126" y2="206"/><text x="46" y="206" text-anchor="end" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">H</text><text x="134" y="206" text-anchor="start" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">OH</text><text x="90" y="270" text-anchor="middle" font-size="15.5" fill="#1a1a1a" stroke="none">CH<tspan dy="4" font-size="11">2</tspan><tspan dy="-4">OH</tspan></text></svg>')
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'Applies the D/L rule with the sides flipped (right OH read as L instead of D)' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'Uses the chiral center nearest the carbonyl (C2) instead of the most remote one to assign D/L' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'Confuses the anomeric (alpha/beta) assignment with the absolute D/L assignment' FROM q;

-- Q6 [Absolute Configuration (D/L)] easy skill1 ans=C [FIG]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Absolute Configuration (D/L)', 'The Fischer projection shown above depicts one enantiomer of glyceraldehyde, the simplest aldotriose. Based on the position of the hydroxyl group at the molecule''s single chiral center, which absolute configuration should be assigned to the structure shown?', '[{"label": "A", "text": "l (levorotatory)"}, {"label": "B", "text": "D"}, {"label": "C", "text": "L"}, {"label": "D", "text": "R"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is C because absolute configuration for a sugar is assigned by inspecting the hydroxyl group on the highest-numbered (last) chiral carbon in the Fischer projection. In the structure shown, that hydroxyl is drawn on the left-hand side. By convention, a sugar whose last chiral center has its OH pointing to the left is designated L (a useful memory aid: the OH on the Last chiral carbon points to the Left). The structure shown is therefore L-glyceraldehyde.

(Choice C) is correct: With the reference OH on the left of the Fischer projection, the molecule matches the definition of an L sugar, related to L-glyceraldehyde.

(Choice B) is incorrect: D is assigned when the OH on the last chiral carbon points to the right in the Fischer projection. Reading the projection shown reveals the OH on the opposite side, so D is the enantiomer of the structure depicted, not the structure itself.

(Choice A) is incorrect: The lowercase \(l\) (levorotatory) label describes the direction a compound rotates plane-polarized light and must be measured experimentally; it does not denote absolute configuration and cannot be read off a Fischer projection. Uppercase D/L and lowercase d/l are independent designations, so this choice confuses optical rotation with structural assignment.

(Choice D) is incorrect: R is a Cahn–Ingold–Prelog (CIP) descriptor based on ranking substituent priorities, not the D/L system biochemists use for sugars. The question asks for the D/L assignment, so an R/S label is the wrong nomenclature category even though it also describes a chiral center.

This is a Skill 1 (Knowledge of Scientific Concepts) question because it requires recognizing the definition of the D/L convention and applying the last-chiral-carbon rule directly to the hydroxyl position shown in the figure.', 'easy', '1D', 'Carbohydrates', 'biochemistry', 1, 50, '<svg style="max-width:190px;margin-inline:auto" viewBox="0 0 180 180" xmlns="http://www.w3.org/2000/svg" fill="none" stroke="#1a1a1a" stroke-width="1.6" stroke-linecap="round" font-family="''Helvetica Neue'',Arial,sans-serif"><line x1="90" y1="50" x2="90" y2="130"/><text x="90" y="42" text-anchor="middle" font-size="15.5" fill="#1a1a1a" stroke="none">CHO</text><line x1="54" y1="86" x2="126" y2="86"/><text x="46" y="86" text-anchor="end" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">HO</text><text x="134" y="86" text-anchor="start" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">H</text><text x="90" y="150" text-anchor="middle" font-size="15.5" fill="#1a1a1a" stroke="none">CH<tspan dy="4" font-size="11">2</tspan><tspan dy="-4">OH</tspan></text></svg>')
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'swaps the D/L convention (OH left = L) for its mirror-image rule (OH right = D)' FROM q
  UNION ALL
  SELECT id, 'A', 'misconception', 'conflates optical rotation (lowercase l, levorotatory) with absolute configuration' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'applies CIP R/S nomenclature instead of the sugar D/L convention' FROM q;

-- Q7 [Absolute Configuration (D/L)] hard skill2 ans=D [FIG]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Absolute Configuration (D/L)', 'The Fischer projection shown depicts the open-chain form of a common aldohexose, drawn with the aldehyde carbon at the top and the terminal CH2OH at the bottom. A chiral molecule and its enantiomer are non-superimposable mirror images of one another. If the sugar in the structure shown were replaced by its enantiomer and that enantiomer were drawn as a Fischer projection in the same top-to-bottom orientation, which set of hydroxyl (–OH) positions — listed for the four stereocenters in order from the top stereocenter down to the bottom stereocenter — would correctly represent it?', '[{"label": "A", "text": "left, left, right, right"}, {"label": "B", "text": "right, left, right, left"}, {"label": "C", "text": "right, left, right, right"}, {"label": "D", "text": "left, right, left, left"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is D because the enantiomer of a sugar is its non-superimposable mirror image, and generating that mirror image in a Fischer projection requires reflecting the horizontal bonds at every stereocenter — so each –OH that points one way in the original must point the opposite way in the enantiomer. Reading the four stereocenters of the structure shown from top to bottom gives the sequence right, left, right, right; reflecting all four yields left, right, left, left, which is the enantiomer (the L form).

(Choice D) is correct: every one of the four stereocenters is inverted relative to the structure shown. Because all chiral centers are simultaneously flipped, the result is the true mirror image (enantiomer), consistent with the fact that the mirror image of D-glucose is L-glucose.

(Choice B) is incorrect: this set inverts only the bottom (penultimate) stereocenter and leaves the other three unchanged. Inverting the single carbon most remote from the carbonyl swaps the D/L designation, but because the other three centers are untouched the molecule is not the mirror image — it is a diastereomer that differs at just one center (an epimer), not the enantiomer.

(Choice C) is incorrect: this set reproduces the structure shown exactly, with no stereocenter inverted. A molecule is superimposable on itself, so this is simply the original sugar again, not its mirror image.

(Choice A) is incorrect: this set inverts only the top stereocenter and leaves the lower three unchanged. Flipping a single center produces a diastereomer that differs at one position, not the fully reflected mirror image required for an enantiomer.

This question requires Skill 2 reasoning because the diagnostic stereochemical pattern must be extracted from the figure and then transformed by applying the definition of an enantiomer, distinguishing a full four-center reflection from partial inversions that yield diastereomers.', 'hard', '1D', 'Carbohydrates', 'biochemistry', 2, 90, '<svg style="max-width:190px;margin-inline:auto" viewBox="0 0 180 300" xmlns="http://www.w3.org/2000/svg" fill="none" stroke="#1a1a1a" stroke-width="1.6" stroke-linecap="round" font-family="''Helvetica Neue'',Arial,sans-serif"><line x1="90" y1="50" x2="90" y2="250"/><text x="90" y="42" text-anchor="middle" font-size="15.5" fill="#1a1a1a" stroke="none">CHO</text><line x1="54" y1="86" x2="126" y2="86"/><text x="46" y="86" text-anchor="end" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">H</text><text x="134" y="86" text-anchor="start" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">OH</text><line x1="54" y1="126" x2="126" y2="126"/><text x="46" y="126" text-anchor="end" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">HO</text><text x="134" y="126" text-anchor="start" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">H</text><line x1="54" y1="166" x2="126" y2="166"/><text x="46" y="166" text-anchor="end" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">H</text><text x="134" y="166" text-anchor="start" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">OH</text><line x1="54" y1="206" x2="126" y2="206"/><text x="46" y="206" text-anchor="end" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">H</text><text x="134" y="206" text-anchor="start" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">OH</text><text x="90" y="270" text-anchor="middle" font-size="15.5" fill="#1a1a1a" stroke="none">CH<tspan dy="4" font-size="11">2</tspan><tspan dy="-4">OH</tspan></text></svg>')
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'Confusing the D/L-defining (penultimate) carbon inversion with generating the full enantiomer' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'Treating the molecule as its own mirror image (no inversion)' FROM q
  UNION ALL
  SELECT id, 'A', 'partial_truth', 'Inverting a single stereocenter and mistaking the resulting epimer/diastereomer for the enantiomer' FROM q;

-- Q8 [Absolute Configuration (D/L)] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Absolute Configuration (D/L)', 'A purified sample of a naturally occurring aldohexose is placed in a polarimeter, and the plane of polarized light is observed to rotate counterclockwise (to the left). Independent structural analysis confirms the molecule is a D-sugar. A student concludes that the polarimeter must be malfunctioning, reasoning that a D-sugar should have rotated the light in the opposite direction. Which statement best evaluates the student''s reasoning?', '[{"label": "A", "text": "The student is wrong; the D prefix is assigned from the configuration at the chiral center farthest from the carbonyl and carries no information about the direction a sample rotates polarized light."}, {"label": "B", "text": "The student is correct; because the molecule is assigned D, its solution must rotate polarized light clockwise, so a leftward rotation signals an error in the measurement."}, {"label": "C", "text": "The student is wrong; the D prefix is assigned from the configuration at the carbon bearing the carbonyl group, so the measured rotation and the prefix describe unrelated centers."}, {"label": "D", "text": "The student is wrong; the observed leftward rotation shows the sample is actually the L enantiomer, since only L-sugars rotate polarized light counterclockwise."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is A because the D/L designation is an absolute-configuration label, not a measurement of optical behavior. For a sugar, the D or L prefix is fixed by the configuration at the highest-numbered (most carbonyl-remote) chiral carbon, compared to D- or L-glyceraldehyde: if that reference center matches D-glyceraldehyde, the sugar is D. The direction a solution rotates plane-polarized light — clockwise (dextrorotatory, +) or counterclockwise (levorotatory, −) — is an independent, experimentally measured property that depends on the whole molecule and cannot be predicted from the D/L prefix. A D-sugar can therefore be levorotatory (D-fructose is a classic example), so a leftward rotation from a confirmed D-sugar is entirely expected, not a malfunction.

(Choice A) is correct: it correctly separates the two ideas — D is set by the far chiral center''s configuration and says nothing about rotation direction — which is exactly why no contradiction exists.

(Choice B) is incorrect: it repeats the core misconception that "D" implies dextrorotatory. The prefix reflects spatial configuration relative to glyceraldehyde, not sign of rotation, so a D-sugar is free to be levorotatory and the measurement need not be in error.

(Choice C) is incorrect: it reaches the right verdict (student is wrong) for the wrong structural reason. The D/L reference center is the chiral carbon farthest from the carbonyl, not the carbonyl carbon itself (the carbonyl carbon of an aldose is not even a chiral center), so the stated basis is false.

(Choice D) is incorrect: it assumes rotation direction reveals D versus L. Because sign of rotation is not tied to the D/L configuration, a counterclockwise reading does not force the molecule to be the L enantiomer; the structural analysis identifying it as D stands.

This question requires Skill 2 reasoning: rather than restating a definition, you must apply the distinction between absolute configuration and optical rotation to a described measurement, predict what the D prefix does and does not tell you, and reject a plausible but false inference.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 2, 90, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'D means dextrorotatory' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'wrong reference chiral center' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'rotation direction determines D/L' FROM q;

-- Q9 [Stereochemistry & Isomerism] medium skill1 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Stereochemistry & Isomerism', 'A laboratory prepares two pure samples of glucose: one containing only D-glucose and the other containing only L-glucose, which are enantiomers of each other. A technician measures the melting point, aqueous solubility, and optical rotation of each pure sample under identical conditions. Which set of results is consistent with the relationship between these two compounds?', '[{"label": "A", "text": "Different melting points and solubilities, and optical rotations equal in magnitude and opposite in sign"}, {"label": "B", "text": "Identical melting points and solubilities, and optical rotations equal in both magnitude and sign"}, {"label": "C", "text": "Identical melting points and solubilities, but optical rotations equal in magnitude and opposite in sign"}, {"label": "D", "text": "Identical melting points and solubilities, but optical rotations opposite in sign and unequal in magnitude"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is C because enantiomers are nonsuperimposable mirror images that possess nearly identical physical properties in an achiral environment—melting point, boiling point, density, and solubility are the same for both. The one property that distinguishes them is their interaction with plane-polarized light: because the two molecules are exact mirror images, they rotate the plane of polarized light by the same magnitude but in opposite directions (one dextrorotatory, one levorotatory). D-glucose and L-glucose are the textbook example of this enantiomeric pair.

(Choice C) is correct: matching melting points and solubilities plus optical rotations that are equal in magnitude and opposite in sign is exactly what defines a pair of enantiomers.

(Choice B) is incorrect: if the two samples rotated light in the same direction (same sign), they would not be behaving as mirror images at all; identical rotation would imply the same compound, not a distinct enantiomer.

(Choice A) is incorrect: differing melting points and solubilities would describe diastereomers (e.g., epimers), not enantiomers. Enantiomers have identical scalar physical properties in an achiral setting, so this violates the defining relationship even though the optical-rotation part is stated correctly.

(Choice D) is incorrect: the mirror-image symmetry forces the magnitude of rotation to be identical for both members; only the sign flips. Opposite sign is right, but unequal magnitude is inconsistent with true enantiomers.

This is a Skill 1 (Knowledge of Scientific Concepts) question because it asks you to recall the defining physical relationship between enantiomers and recognize it in the specific case of D- versus L-glucose.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 1, 75, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'believes mirror images rotate polarized light in the same direction' FROM q
  UNION ALL
  SELECT id, 'A', 'misconception', 'confuses enantiomers with diastereomers/epimers (thinks enantiomers have different mp and solubility)' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'knows rotation sign is opposite but thinks the magnitudes differ' FROM q;

-- Q10 [Stereochemistry & Isomerism] medium skill2 ans=D [FIG]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Stereochemistry & Isomerism', 'The figure above shows Fischer projections for two six-carbon sugars, labeled A and B. Examine the position of each hydroxyl group in structure A and compare it with the corresponding position in structure B. Which term best describes the relationship between the two molecules?', '[{"label": "A", "text": "Identical compounds"}, {"label": "B", "text": "Enantiomers"}, {"label": "C", "text": "Constitutional isomers"}, {"label": "D", "text": "Epimers"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is D because a careful comparison of structures A and B in the figure shows that the two sugars have the same molecular formula and the same connectivity, and their hydroxyl groups are oriented identically at every chiral center except one. Two sugars whose configurations match at all stereocenters but one are diastereomers that differ at a single stereocenter — the definition of epimers. Because the mismatch occurs at a carbon other than the carbonyl-derived (anomeric) position, and only one center is inverted, the relationship is specifically epimeric.

(Choice D) is correct: When you extract the orientation of each \(\text{OH}\) from the Fischer projections, A and B agree at every stereocenter but a single one, so they are diastereomers differing at exactly one chiral center — epimers.

(Choice B) is incorrect: Enantiomers are non-superimposable mirror images, which requires the configuration at every stereocenter to be inverted. Reading the figure shows most centers are unchanged, so A and B are not mirror images of each other.

(Choice C) is incorrect: Constitutional (structural) isomers share a molecular formula but differ in how their atoms are connected. A and B have identical connectivity — both are unbranched aldohexose chains with the same functional groups in the same sequence — so they differ only in spatial arrangement, not connectivity.

(Choice A) is incorrect: Identical compounds would show the same \(\text{OH}\) orientation at every chiral center. The figure reveals a difference at one center, so the two structures are not the same molecule.

This is a Skill 2 item because it requires applying the definitions of stereoisomer categories to information you must extract directly from the Fischer projections, rather than recalling a stated fact.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 2, 75, '<svg viewBox="0 0 416 336" xmlns="http://www.w3.org/2000/svg" font-family="''Helvetica Neue'',Arial,sans-serif"><svg x="0" y="0" width="180" height="300" style="width:180px;height:300px" viewBox="0 0 180 300" xmlns="http://www.w3.org/2000/svg" fill="none" stroke="#1a1a1a" stroke-width="1.6" stroke-linecap="round" font-family="''Helvetica Neue'',Arial,sans-serif"><line x1="90" y1="50" x2="90" y2="250"/><text x="90" y="42" text-anchor="middle" font-size="15.5" fill="#1a1a1a" stroke="none">CHO</text><line x1="54" y1="86" x2="126" y2="86"/><text x="46" y="86" text-anchor="end" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">H</text><text x="134" y="86" text-anchor="start" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">OH</text><line x1="54" y1="126" x2="126" y2="126"/><text x="46" y="126" text-anchor="end" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">HO</text><text x="134" y="126" text-anchor="start" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">H</text><line x1="54" y1="166" x2="126" y2="166"/><text x="46" y="166" text-anchor="end" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">H</text><text x="134" y="166" text-anchor="start" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">OH</text><line x1="54" y1="206" x2="126" y2="206"/><text x="46" y="206" text-anchor="end" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">H</text><text x="134" y="206" text-anchor="start" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">OH</text><text x="90" y="270" text-anchor="middle" font-size="15.5" fill="#1a1a1a" stroke="none">CH<tspan dy="4" font-size="11">2</tspan><tspan dy="-4">OH</tspan></text></svg><svg x="236" y="0" width="180" height="300" style="width:180px;height:300px" viewBox="0 0 180 300" xmlns="http://www.w3.org/2000/svg" fill="none" stroke="#1a1a1a" stroke-width="1.6" stroke-linecap="round" font-family="''Helvetica Neue'',Arial,sans-serif"><line x1="90" y1="50" x2="90" y2="250"/><text x="90" y="42" text-anchor="middle" font-size="15.5" fill="#1a1a1a" stroke="none">CHO</text><line x1="54" y1="86" x2="126" y2="86"/><text x="46" y="86" text-anchor="end" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">H</text><text x="134" y="86" text-anchor="start" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">OH</text><line x1="54" y1="126" x2="126" y2="126"/><text x="46" y="126" text-anchor="end" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">HO</text><text x="134" y="126" text-anchor="start" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">H</text><line x1="54" y1="166" x2="126" y2="166"/><text x="46" y="166" text-anchor="end" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">HO</text><text x="134" y="166" text-anchor="start" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">H</text><line x1="54" y1="206" x2="126" y2="206"/><text x="46" y="206" text-anchor="end" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">H</text><text x="134" y="206" text-anchor="start" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">OH</text><text x="90" y="270" text-anchor="middle" font-size="15.5" fill="#1a1a1a" stroke="none">CH<tspan dy="4" font-size="11">2</tspan><tspan dy="-4">OH</tspan></text></svg><text x="90" y="324" text-anchor="middle" font-size="16" font-weight="700" fill="#1a1a1a" font-family="''Helvetica Neue'',Arial,sans-serif">A</text><text x="326" y="324" text-anchor="middle" font-size="16" font-weight="700" fill="#1a1a1a" font-family="''Helvetica Neue'',Arial,sans-serif">B</text></svg>')
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'confuses single-center inversion with full mirror-image inversion' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'conflates stereoisomerism with connectivity/constitutional isomerism' FROM q
  UNION ALL
  SELECT id, 'A', 'misconception', 'overlooks the single differing stereocenter and reads the sugars as the same molecule' FROM q;

-- Q11 [Stereochemistry & Isomerism] medium skill2 ans=A [FIG]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Stereochemistry & Isomerism', 'The Fischer projections shown display two aldohexoses, labeled A and B, each drawn with its aldehyde carbon (C1) at the top and its –CH2OH carbon (C6) at the bottom. Working down each chain from C1 to C6, compare the two structures. Which term correctly describes the stereochemical relationship between A and B, and at which numbered carbon does that relationship arise?

[FIGURE: Two aldohexose Fischer projections side by side, labeled A and B. Both have CHO at the top (C1) and CH2OH at the bottom (C6). Structure A, reading top to bottom, has –OH on the RIGHT at C2, on the LEFT at C3, on the RIGHT at C4, and on the RIGHT at C5. Structure B has –OH on the LEFT at C2, on the LEFT at C3, on the RIGHT at C4, and on the RIGHT at C5. The remaining position on each carbon is occupied by –H.]', '[{"label": "A", "text": "They are epimers, differing in configuration only at C2."}, {"label": "B", "text": "They are epimers, differing in configuration only at C4."}, {"label": "C", "text": "They are enantiomers, with opposite configuration at every stereocenter."}, {"label": "D", "text": "They are diastereomers that differ in configuration at two stereocenters."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is A because tracing the two Fischer projections from C1 down to C6 shows that A and B place –OH on the same side at C3 (left, left), C4 (right, right), and C5 (right, right), and differ at only one stereocenter: at C2, structure A has –OH on the right while structure B has –OH on the left. Two sugars whose configurations match at every stereocenter but one are epimers, named for the carbon at which they differ; because the single transposition is at C2, A and B are C2 epimers. (Tracing the substituents shows A is D-glucose and B is D-mannose, the classic C2-epimer pair.)

(Choice A) is correct: Comparing the structures carbon by carbon, C3, C4, and C5 are identical and only the C2 substituents are swapped. A difference at exactly one stereocenter defines an epimeric relationship, and locating that center at C2 completes the answer.

(Choice B) is incorrect: C4 is where the D-glucose/D-galactose epimeric pair differs, and this is a common trap because galactose is the textbook ''other'' glucose epimer. In the projections shown, however, C4 carries –OH on the right in both structures; the transposed –H and –OH sit at C2, not C4.

(Choice C) is incorrect: Enantiomers are nonsuperimposable mirror images, which requires opposite configuration at every stereocenter (as in D-glucose versus L-glucose). Here the two structures match at C3, C4, and C5, so they cannot be mirror images.

(Choice D) is incorrect: Although epimers are a subset of diastereomers, this option specifies a difference at two stereocenters. Tracing the projections reveals a swap at only one carbon (C2), so calling the relationship a two-center difference misreads the structures.

At the Skill 2 level, you cannot answer by recalling a memorized fact; you must extract the configuration at each stereocenter from the Fischer projections, compare the two structures carbon by carbon, and map the observed single-center difference onto the correct isomer term and carbon number.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 2, 90, '<svg viewBox="0 0 416 336" xmlns="http://www.w3.org/2000/svg" font-family="''Helvetica Neue'',Arial,sans-serif"><svg x="0" y="0" width="180" height="300" style="width:180px;height:300px" viewBox="0 0 180 300" xmlns="http://www.w3.org/2000/svg" fill="none" stroke="#1a1a1a" stroke-width="1.6" stroke-linecap="round" font-family="''Helvetica Neue'',Arial,sans-serif"><line x1="90" y1="50" x2="90" y2="250"/><text x="90" y="42" text-anchor="middle" font-size="15.5" fill="#1a1a1a" stroke="none">CHO</text><line x1="54" y1="86" x2="126" y2="86"/><text x="46" y="86" text-anchor="end" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">H</text><text x="134" y="86" text-anchor="start" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">OH</text><line x1="54" y1="126" x2="126" y2="126"/><text x="46" y="126" text-anchor="end" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">HO</text><text x="134" y="126" text-anchor="start" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">H</text><line x1="54" y1="166" x2="126" y2="166"/><text x="46" y="166" text-anchor="end" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">H</text><text x="134" y="166" text-anchor="start" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">OH</text><line x1="54" y1="206" x2="126" y2="206"/><text x="46" y="206" text-anchor="end" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">H</text><text x="134" y="206" text-anchor="start" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">OH</text><text x="90" y="270" text-anchor="middle" font-size="15.5" fill="#1a1a1a" stroke="none">CH<tspan dy="4" font-size="11">2</tspan><tspan dy="-4">OH</tspan></text></svg><svg x="236" y="0" width="180" height="300" style="width:180px;height:300px" viewBox="0 0 180 300" xmlns="http://www.w3.org/2000/svg" fill="none" stroke="#1a1a1a" stroke-width="1.6" stroke-linecap="round" font-family="''Helvetica Neue'',Arial,sans-serif"><line x1="90" y1="50" x2="90" y2="250"/><text x="90" y="42" text-anchor="middle" font-size="15.5" fill="#1a1a1a" stroke="none">CHO</text><line x1="54" y1="86" x2="126" y2="86"/><text x="46" y="86" text-anchor="end" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">HO</text><text x="134" y="86" text-anchor="start" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">H</text><line x1="54" y1="126" x2="126" y2="126"/><text x="46" y="126" text-anchor="end" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">HO</text><text x="134" y="126" text-anchor="start" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">H</text><line x1="54" y1="166" x2="126" y2="166"/><text x="46" y="166" text-anchor="end" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">H</text><text x="134" y="166" text-anchor="start" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">OH</text><line x1="54" y1="206" x2="126" y2="206"/><text x="46" y="206" text-anchor="end" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">H</text><text x="134" y="206" text-anchor="start" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">OH</text><text x="90" y="270" text-anchor="middle" font-size="15.5" fill="#1a1a1a" stroke="none">CH<tspan dy="4" font-size="11">2</tspan><tspan dy="-4">OH</tspan></text></svg><text x="90" y="324" text-anchor="middle" font-size="16" font-weight="700" fill="#1a1a1a" font-family="''Helvetica Neue'',Arial,sans-serif">A</text><text x="326" y="324" text-anchor="middle" font-size="16" font-weight="700" fill="#1a1a1a" font-family="''Helvetica Neue'',Arial,sans-serif">B</text></svg>')
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'adjacent_fact', 'correct-relationship-wrong-locus' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'conflates-epimer-with-enantiomer' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'overcounts-differing-centers' FROM q;

-- Q12 [Stereochemistry & Isomerism] easy skill1 ans=B [FIG]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Stereochemistry & Isomerism', 'Fischer projections of two three-carbon monosaccharides are shown above, labeled structure A and structure B. Each has a single stereocenter. Based on the spatial arrangement of substituents depicted in the two projections, which term best describes the stereochemical relationship between structure A and structure B?', '[{"label": "A", "text": "Epimers"}, {"label": "B", "text": "Enantiomers"}, {"label": "C", "text": "Identical molecules"}, {"label": "D", "text": "Diastereomers"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is B because comparing the two Fischer projections shows that structure B is the non-superimposable mirror image of structure A: the single stereocenter has the opposite configuration in each, and reflecting one projection reproduces the other exactly. Stereoisomers that are non-superimposable mirror images of each other are, by definition, enantiomers. Because glyceraldehyde has only one chiral carbon, inverting that one center produces the mirror-image partner (D- and L-glyceraldehyde), which are enantiomers.

(Choice B) is correct: The two structures are non-superimposable mirror images, which is the definition of enantiomers.

(Choice A) is incorrect: Epimers are diastereomers that differ in configuration at exactly one of several stereocenters while remaining identical at the others. A molecule with only one stereocenter cannot have "other" centers that stay the same, so two single-stereocenter mirror images cannot be epimers.

(Choice C) is incorrect: Identical molecules are superimposable. The two projections cannot be overlaid without reflection, so they are not the same molecule; they have opposite configurations at the stereocenter.

(Choice D) is incorrect: Diastereomers are stereoisomers that are NOT mirror images of each other. The pair shown is a mirror-image pair, so it fails the diastereomer definition; a single-stereocenter molecule has no way to form a diastereomer at all.

This is a Skill 1 (Knowledge of Scientific Concepts) task: you recall the definitions of enantiomers, epimers, and diastereomers and apply the correct label to the mirror-image relationship extracted directly from the two Fischer projections.', 'easy', '1D', 'Carbohydrates', 'biochemistry', 1, 60, '<svg viewBox="0 0 416 216" xmlns="http://www.w3.org/2000/svg" font-family="''Helvetica Neue'',Arial,sans-serif"><svg x="0" y="0" width="180" height="180" style="width:180px;height:180px" viewBox="0 0 180 180" xmlns="http://www.w3.org/2000/svg" fill="none" stroke="#1a1a1a" stroke-width="1.6" stroke-linecap="round" font-family="''Helvetica Neue'',Arial,sans-serif"><line x1="90" y1="50" x2="90" y2="130"/><text x="90" y="42" text-anchor="middle" font-size="15.5" fill="#1a1a1a" stroke="none">CHO</text><line x1="54" y1="86" x2="126" y2="86"/><text x="46" y="86" text-anchor="end" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">H</text><text x="134" y="86" text-anchor="start" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">OH</text><text x="90" y="150" text-anchor="middle" font-size="15.5" fill="#1a1a1a" stroke="none">CH<tspan dy="4" font-size="11">2</tspan><tspan dy="-4">OH</tspan></text></svg><svg x="236" y="0" width="180" height="180" style="width:180px;height:180px" viewBox="0 0 180 180" xmlns="http://www.w3.org/2000/svg" fill="none" stroke="#1a1a1a" stroke-width="1.6" stroke-linecap="round" font-family="''Helvetica Neue'',Arial,sans-serif"><line x1="90" y1="50" x2="90" y2="130"/><text x="90" y="42" text-anchor="middle" font-size="15.5" fill="#1a1a1a" stroke="none">CHO</text><line x1="54" y1="86" x2="126" y2="86"/><text x="46" y="86" text-anchor="end" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">HO</text><text x="134" y="86" text-anchor="start" dominant-baseline="middle" font-size="15.5" fill="#1a1a1a" stroke="none">H</text><text x="90" y="150" text-anchor="middle" font-size="15.5" fill="#1a1a1a" stroke="none">CH<tspan dy="4" font-size="11">2</tspan><tspan dy="-4">OH</tspan></text></svg><text x="90" y="204" text-anchor="middle" font-size="16" font-weight="700" fill="#1a1a1a" font-family="''Helvetica Neue'',Arial,sans-serif">A</text><text x="326" y="204" text-anchor="middle" font-size="16" font-weight="700" fill="#1a1a1a" font-family="''Helvetica Neue'',Arial,sans-serif">B</text></svg>')
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'Confuses epimer with any single-center configurational difference, ignoring that epimers require multiple stereocenters' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'Thinks mirror-image Fischer projections represent the same molecule (fails to test superimposability)' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'Confuses the two mutually exclusive categories of stereoisomers, labeling a mirror-image pair as non-mirror-image diastereomers' FROM q;

-- Q13 [Stereochemistry & Isomerism] hard skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Stereochemistry & Isomerism', 'Two open-chain aldohexoses, Sugar P and Sugar Q, are compared. Each has four chiral centers (C2, C3, C4, and C5). When their Fischer projections are aligned, the configurations at C3 and C5 are found to differ between the two sugars, while the configurations at C2 and C4 are identical in both. Which term most precisely describes the relationship between Sugar P and Sugar Q?', '[{"label": "A", "text": "Anomers"}, {"label": "B", "text": "Enantiomers"}, {"label": "C", "text": "Epimers"}, {"label": "D", "text": "Diastereomers"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is D because two stereoisomers that differ at some—but not all—of their chiral centers are non-superimposable and are not mirror images of one another; by definition, stereoisomers that are not mirror images are diastereomers. Here Sugar P and Sugar Q share four chiral centers, differ at two of them (C3 and C5), and match at the other two (C2 and C4). Because only some centers are inverted, the molecules cannot be mirror images, yet they are distinct stereoisomers—precisely the definition of diastereomers.

(Choice D) is correct: Diastereomers are stereoisomers that are not mirror images of each other. Differing at exactly two of four centers guarantees the sugars are non-superimposable but not mirror images, so "diastereomers" is the most precise classification.

(Choice B) is incorrect: Enantiomers are stereoisomers that ARE non-superimposable mirror images. A mirror-image relationship requires the configuration at EVERY chiral center to be inverted—all four here. Because C2 and C4 are unchanged, the two sugars cannot be mirror images and therefore cannot be enantiomers.

(Choice C) is incorrect: Epimers are the special subset of diastereomers that differ at exactly ONE chiral center (e.g., glucose and galactose at C4). Sugar P and Sugar Q differ at two centers, so the more restrictive term "epimers" does not apply even though they are diastereomers.

(Choice A) is incorrect: Anomers are diastereomers of CYCLIC sugars that differ only at the new hemiacetal/acetal (anomeric) carbon generated upon ring closure. These sugars are described in the open-chain form and differ at C3 and C5—not at an anomeric carbon—so "anomers" is inapplicable.

Skill 2: Rather than recalling a definition, you had to translate the described pattern (differs at two of four centers, matches at two) into structural consequences—non-superimposable but not a mirror image—and then select the classification whose defining criterion that pattern uniquely satisfies while ruling out the more restrictive terms (enantiomer, epimer, anomer).', 'hard', '1D', 'Carbohydrates', 'biochemistry', 2, 90, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'Treats any pair of stereoisomers, or any inversion of configuration, as producing a mirror-image (enantiomeric) relationship, ignoring that enantiomers require inversion at every chiral center.' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'Applies the correct family (diastereomer subset) but confuses the epimer criterion of ''differs at exactly one center'' with ''differs at more than one center.''' FROM q
  UNION ALL
  SELECT id, 'A', 'process_step_confusion', 'Recognizes anomers as a diastereomer subtype but forgets they are defined by the cyclic anomeric carbon, misapplying the term to open-chain internal chiral centers.' FROM q;

-- Q14 [Stereochemistry & Isomerism] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Stereochemistry & Isomerism', 'D-glucose and D-mannose are two aldohexoses that can be interconverted in the laboratory by inverting the configuration at a single carbon while leaving every other carbon untouched. A student examining this transformation wants to classify the relationship between the two sugars. Which set of stereochemical labels correctly describes the D-glucose/D-mannose pair?

A. Epimers and diastereomers, but not enantiomers
B. Epimers and enantiomers, but not diastereomers
C. Diastereomers, but neither epimers nor enantiomers
D. Epimers, but neither diastereomers nor enantiomers', '[{"label": "A", "text": "Epimers and diastereomers, but not enantiomers"}, {"label": "B", "text": "Epimers and enantiomers, but not diastereomers"}, {"label": "C", "text": "Diastereomers, but neither epimers nor enantiomers"}, {"label": "D", "text": "Epimers, but neither diastereomers nor enantiomers"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is A because two stereoisomers that differ in configuration at exactly one chiral carbon are, by definition, epimers. Epimers are a specific subset of diastereomers: because the two molecules share identical configuration at all other stereocenters, they cannot be nonsuperimposable mirror images of one another, so they are not enantiomers, yet they are still stereoisomers that are not mirror images, which is precisely the definition of diastereomers. Therefore the D-glucose/D-mannose pair is correctly labeled as both epimers and diastereomers, but not enantiomers.

(Choice A) is correct: Differing at a single stereocenter makes the pair epimers, and every epimeric pair is automatically a (non-mirror-image) diastereomeric pair, while the shared configuration at the remaining carbons rules out an enantiomeric (mirror-image) relationship.

(Choice B) is incorrect: Enantiomers must be nonsuperimposable mirror images, which requires the configuration at every chiral center to be inverted. A pair that differs at only one carbon cannot be mirror images, so "enantiomers" cannot apply, and the pair is in fact a type of diastereomer rather than the opposite of one.

(Choice C) is incorrect: This choice recognizes that the pair is diastereomeric but wrongly denies the epimer label. Because the two sugars differ at exactly one chiral center, they meet the narrower definition of epimers; epimers are a subset of diastereomers, so both labels apply simultaneously.

(Choice D) is incorrect: This reflects the misconception that epimers are a category separate from diastereomers. All epimers are diastereomers (though not all diastereomers are epimers), so a pair cannot be epimers while failing to be diastereomers.

To reason to the key, a student must apply the hierarchical relationships among stereoisomer classes—recognizing that a one-center difference places the pair inside the epimer subset while still satisfying the broader diastereomer definition and excluding the mirror-image requirement of enantiomers—rather than recalling any single definition stated in the stem.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 2, 75, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'conflating epimers with enantiomers (treating a single-center inversion as producing mirror images)' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'correctly identifying diastereomer status but failing to recognize the pair also qualifies for the narrower epimer subset' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'treating epimers and diastereomers as mutually exclusive categories rather than subset/superset' FROM q;

-- Q15 [Cyclic Sugars & Anomers] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Cyclic Sugars & Anomers', 'D-Fructose in aqueous solution exists predominantly as a cyclic ring rather than as its open-chain form. The ring forms when one of the sugar''s own hydroxyl oxygens reaches back and adds across the C2 carbonyl carbon in an intramolecular addition reaction, and no other molecule participates in the closure. Which functional group is generated at the ring carbon that was formerly the carbonyl carbon?', '[{"label": "A", "text": "A hemiacetal, because the intramolecular addition occurs at an aldehyde carbonyl"}, {"label": "B", "text": "A hemiketal, because the intramolecular addition occurs at a ketone carbonyl"}, {"label": "C", "text": "An acetal, because two hydroxyl oxygens have added to the former carbonyl carbon"}, {"label": "D", "text": "A ketal, because both oxygens on the former carbonyl carbon are now bonded to carbon"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is B because ring closure adds a single hydroxyl oxygen across a carbonyl, and the product''s identity is dictated by which kind of carbonyl was attacked. D-Fructose is a ketose: its C2 carbonyl is a ketone, flanked on both sides by carbon. When an intramolecular hydroxyl oxygen adds across a ketone carbonyl, the former carbonyl carbon ends up bearing one \(\text{OR}\) group (from the attacking hydroxyl, now a ring oxygen) and one \(\text{OH}\) group (the new anomeric hydroxyl, from the former carbonyl \(\text{O}\)). A carbon carrying one \(\text{OR}\) and one \(\text{OH}\) derived from a ketone is a hemiketal.

(Choice B) is correct: the C2 carbonyl of fructose is a ketone, and intramolecular addition of a single hydroxyl oxygen to a ketone yields a hemiketal (\(\text{OR}\) + \(\text{OH}\) on the former carbonyl carbon).

(Choice A) is incorrect: a hemiacetal forms when a hydroxyl adds to an aldehyde carbonyl, which is what happens for aldoses such as glucose. Fructose''s reactive carbonyl is a ketone, not an aldehyde, so the product is a hemiketal rather than a hemiacetal. (Note that some modern texts use "hemiacetal" loosely for both; here the choices force the precise ketone-derived term.)

(Choice C) is incorrect: an acetal requires two \(\text{OR}\) groups on the former carbonyl carbon, which demands a second alcohol and loss of water in a separate downstream step. The scenario states no other molecule participates and only one hydroxyl adds, so only one \(\text{OR}\) group is present and the carbon retains a free \(\text{OH}\).

(Choice D) is incorrect: a ketal, like an acetal, requires both oxygens to be \(\text{OR}\) groups (both bonded to carbon) with no free \(\text{OH}\) remaining; this too needs a second alcohol. A single intramolecular addition leaves one \(\text{OH}\), so the carbon is only at the "hemi" stage, not a full ketal.

To answer, you had to apply the rule that carbonyl type plus number of added alcohols determines the product: classify fructose''s C2 as a ketone and recognize that one intramolecular hydroxyl addition stops at the hemiketal, rather than restating a memorized definition.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 2, 85, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'Assumes all cyclized monosaccharides form hemiacetals, overlooking that fructose''s carbonyl is a ketone rather than an aldehyde' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'Confuses the single-alcohol addition product (hemi) with the two-alcohol downstream glycoside product (acetal)' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'Correctly identifies the ketone origin (''ket-'') but overshoots to the full ketal, which requires a second OR group and loss of the free OH' FROM q;

-- Q16 [Cyclic Sugars & Anomers] medium skill2 ans=C [FIG]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Cyclic Sugars & Anomers', 'A Haworth projection of a cyclic D-glucopyranose ring is shown in the figure above. Based only on the spatial relationship between the hydroxyl group on the anomeric carbon and the reference carbon that bears the CH2OH group in the structure shown, which anomeric designation best describes this monosaccharide?', '[{"label": "A", "text": "It is an epimer, not an anomer, of D-glucose."}, {"label": "B", "text": "It is the α anomer."}, {"label": "C", "text": "It is the β anomer."}, {"label": "D", "text": "It is the L-enantiomer of the sugar."}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is C because in a Haworth projection the anomeric configuration is assigned by comparing the orientation of the hydroxyl on the anomeric carbon (C1) to the reference carbon that carries the CH2OH group (C5). In the structure shown, the C1 hydroxyl and the C5 CH2OH lie on the same face of the ring, which is the defining relationship for the β configuration. Extracting this cis relationship from the figure is the only way to arrive at the correct designation.

(Choice C) is correct: reading the figure, the anomeric hydroxyl sits on the same side of the ring as the CH2OH-bearing carbon; a substituent that shares that face gives the β anomer of D-glucopyranose.

(Choice B) is incorrect: the α anomer requires the anomeric hydroxyl to lie on the opposite face from the CH2OH-bearing carbon, i.e., trans to it. The structure shown does not display that opposing arrangement, so it is not the α form.

(Choice A) is incorrect: epimers differ in configuration at a single non-anomeric stereocenter (for example, glucose versus galactose at C4). The question concerns the configuration at the anomeric carbon itself, so the α/β anomer distinction—not epimerism—applies here.

(Choice D) is incorrect: the D/L designation is set by the highest-numbered stereocenter (C5) and describes the absolute configuration of the parent sugar, not the arrangement at the anomeric carbon. It is a separate axis of classification and does not name the anomeric form.

This question requires Skill 2 reasoning: rather than recalling a memorized rule, you must interpret the spatial arrangement in the Haworth projection, relate the anomeric hydroxyl to the C5 substituent, and apply the definition of the β configuration to the specific structure shown.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 2, 75, '<svg style="max-width:380px;margin-inline:auto" viewBox="0 0 360 218" xmlns="http://www.w3.org/2000/svg" fill="none" stroke="#1a1a1a" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round" font-family="''Helvetica Neue'',Arial,sans-serif"><line x1="86" y1="96" x2="172" y2="74"/><line x1="172" y1="74" x2="258" y2="96"/><line x1="258" y1="96" x2="258" y2="150"/><line x1="86" y1="96" x2="86" y2="150"/><path d="M258,150 L172,172 L86,150" stroke-width="3.6"/><text x="172" y="68" text-anchor="middle" font-size="15.5" fill="#1a1a1a" stroke="none">O</text><line x1="86" y1="96" x2="86" y2="68"/><text x="86" y="60" text-anchor="middle" font-size="15" fill="#1a1a1a" stroke="none">CH<tspan dy="4" font-size="11">2</tspan><tspan dy="-4">OH</tspan></text><line x1="86" y1="150" x2="86" y2="178"/><text x="86" y="192" text-anchor="middle" font-size="15" fill="#1a1a1a" stroke="none">OH</text><line x1="172" y1="172" x2="172" y2="146"/><text x="172" y="139" text-anchor="middle" font-size="15" fill="#1a1a1a" stroke="none">OH</text><line x1="258" y1="150" x2="258" y2="178"/><text x="258" y="192" text-anchor="middle" font-size="15" fill="#1a1a1a" stroke="none">OH</text><line x1="258" y1="96" x2="258" y2="68"/><text x="258" y="60" text-anchor="middle" font-size="15" fill="#14524A" stroke="none" font-weight="700">OH</text><line x1="258" y1="96" x2="284" y2="110"/><text x="293" y="114" text-anchor="middle" font-size="15" fill="#1a1a1a" stroke="none">H</text></svg>')
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'Confuses the cis (same-face) relationship with the trans arrangement and assigns the opposite anomer' FROM q
  UNION ALL
  SELECT id, 'A', 'misconception', 'Conflates anomers (differ at the anomeric carbon) with epimers (differ at a non-anomeric stereocenter)' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'Applies the D/L absolute-configuration axis instead of the anomeric α/β axis' FROM q;

-- Q17 [Cyclic Sugars & Anomers] medium skill2 ans=A [FIG]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Cyclic Sugars & Anomers', 'The Haworth projection shown above depicts a cyclic form of D-glucopyranose. Based on the orientation of the hydroxyl group at the anomeric carbon (C1) relative to the ring, which designation correctly describes the structure shown?', '[{"label": "A", "text": "It is the α anomer."}, {"label": "B", "text": "It is the β anomer."}, {"label": "C", "text": "It is the L enantiomer of the sugar."}, {"label": "D", "text": "It is the C4 epimer of the sugar."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is A because the anomeric designation of a cyclic sugar is fixed by where the hydroxyl group on the anomeric carbon (C1) sits relative to the reference \(\text{CH}_2\text{OH}\) group of the ring. In a Haworth projection of a D-pyranose, when the anomeric OH lies on the opposite side of the ring from the \(\text{CH}_2\text{OH}\), the sugar is the \(\alpha\) anomer. Reading the structure shown, the C1 OH is oriented on the face of the ring opposite the \(\text{CH}_2\text{OH}\), which is the arrangement that defines \(\alpha\)-D-glucopyranose.

(Choice A) is correct: the C1 OH orientation extracted from the figure — trans to the ring''s \(\text{CH}_2\text{OH}\) — matches the defining arrangement of the \(\alpha\) anomer, so \(\alpha\) is the correct designation.

(Choice B) is incorrect: the \(\beta\) anomer has its anomeric OH on the same side of the ring as the reference \(\text{CH}_2\text{OH}\), which is the opposite of what the figure shows; choosing \(\beta\) inverts the anomeric relationship depicted.

(Choice C) is incorrect: the D/L label is set by the configuration at the highest-numbered chiral center (C5), not by C1. Calling the structure the L enantiomer would require the whole molecule to be the mirror image with every stereocenter inverted, which the single anomeric feature shown does not indicate.

(Choice D) is incorrect: an epimer differs in configuration at exactly one non-anomeric stereocenter (e.g., C4 distinguishes glucose from galactose). The figure asks about C1, the anomeric carbon, so an epimeric relationship at C4 is the wrong category of isomer for the feature being read.

As a Skill 2 task, this requires extracting one specific structural feature from the Haworth projection — the side of the ring the anomeric OH occupies relative to the \(\text{CH}_2\text{OH}\) — and mapping that spatial observation onto the correct \(\alpha\)/\(\beta\) nomenclature rule rather than recalling a definition.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 2, 75, '<svg style="max-width:380px;margin-inline:auto" viewBox="0 0 360 218" xmlns="http://www.w3.org/2000/svg" fill="none" stroke="#1a1a1a" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round" font-family="''Helvetica Neue'',Arial,sans-serif"><line x1="86" y1="96" x2="172" y2="74"/><line x1="172" y1="74" x2="258" y2="96"/><line x1="258" y1="96" x2="258" y2="150"/><line x1="86" y1="96" x2="86" y2="150"/><path d="M258,150 L172,172 L86,150" stroke-width="3.6"/><text x="172" y="68" text-anchor="middle" font-size="15.5" fill="#1a1a1a" stroke="none">O</text><line x1="86" y1="96" x2="86" y2="68"/><text x="86" y="60" text-anchor="middle" font-size="15" fill="#1a1a1a" stroke="none">CH<tspan dy="4" font-size="11">2</tspan><tspan dy="-4">OH</tspan></text><line x1="86" y1="150" x2="86" y2="178"/><text x="86" y="192" text-anchor="middle" font-size="15" fill="#1a1a1a" stroke="none">OH</text><line x1="172" y1="172" x2="172" y2="146"/><text x="172" y="139" text-anchor="middle" font-size="15" fill="#1a1a1a" stroke="none">OH</text><line x1="258" y1="150" x2="258" y2="178"/><text x="258" y="192" text-anchor="middle" font-size="15" fill="#1a1a1a" stroke="none">OH</text><line x1="258" y1="96" x2="284" y2="110"/><text x="296" y="114" text-anchor="middle" font-size="15" fill="#14524A" stroke="none" font-weight="700">OH</text><line x1="258" y1="96" x2="258" y2="68"/><text x="258" y="60" text-anchor="middle" font-size="15" fill="#1a1a1a" stroke="none">H</text></svg>')
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'Swaps the α/β rule so the anomeric OH orientation is read as the opposite anomer' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'Confuses the anomeric center with the D/L-determining center (C5), treating an anomeric change as an enantiomeric change' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'Applies the epimer concept (differs at one non-anomeric stereocenter) to the anomeric carbon' FROM q;

-- Q18 [Cyclic Sugars & Anomers] medium skill1 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Cyclic Sugars & Anomers', 'D-Glucose exists predominantly as a six-membered ring (glucopyranose) rather than as an open chain in aqueous solution. A student dissolves pure β-D-glucopyranose in water and, over time, detects a small equilibrium amount of the open-chain form bearing a reactive aldehyde group that reduces Benedict''s reagent. In the cyclic form, which numbered carbon corresponds to the carbon that carries this aldehyde group when the ring opens?', '[{"label": "A", "text": "C2"}, {"label": "B", "text": "C1"}, {"label": "C", "text": "C4"}, {"label": "D", "text": "C6"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is B because ring closure in an aldohexose occurs when a hydroxyl oxygen makes an intramolecular nucleophilic attack on the carbonyl carbon, converting the open-chain aldehyde into a cyclic hemiacetal. In glucose the aldehyde sits at C1, so C1 is the carbon that becomes bonded to two oxygens in the ring (the ring oxygen and a hydroxyl), and it is the only carbon that can revert to a free aldehyde when the ring reopens. That reactive, potentially open aldehyde at C1 is exactly what reduces Benedict''s reagent.

(Choice B) is correct: C1 is the former carbonyl carbon of the aldose. Reopening the hemiacetal regenerates the \(\text{-CHO}\) at this position, which is oxidized by Benedict''s reagent.

(Choice A) is incorrect: C2 in glucose bears a single \(\text{-OH}\) and is a chiral center where epimers such as mannose differ; it is never the carbonyl carbon in an aldose and cannot open to an aldehyde.

(Choice C) is incorrect: C4 is the carbon at which glucose and galactose differ (they are C4 epimers), a common point of confusion, but it carries an ordinary hydroxyl and is not the site of ring closure or the aldehyde.

(Choice D) is incorrect: C6 is the terminal \(\text{-CH}_2\text{OH}\) of the hexose. Its oxygen is a single primary hydroxyl (or, in a 6-membered ring, is not part of the ring at all), so it does not become an aldehyde on ring opening.

This is a Skill 1 (knowledge of scientific concepts) item: it asks you to recall that the ring-forming carbon of an aldohexose is the former carbonyl carbon at C1 and to distinguish it from carbons involved in epimerization or the terminal hydroxymethyl group.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 1, 75, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'adjacent_fact', 'confuses the anomeric carbon with an adjacent chiral center (C2) that distinguishes epimers like mannose' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'recalls C4 as the glucose/galactose epimeric position and wrongly ties that distinguishing carbon to ring opening' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'assumes the terminal CH2OH (C6) is the reactive/oxidizable carbon because it is an exposed end of the chain' FROM q;

-- Q19 [Cyclic Sugars & Anomers] easy skill1 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Cyclic Sugars & Anomers', 'A biochemistry student is modeling how a linear aldohexose could close into a ring by having one of its hydroxyl groups attack the aldehyde carbon. Depending on which hydroxyl acts as the nucleophile, rings enclosing different numbers of atoms are geometrically conceivable. Of the four ring closures the student sketches, which one yields a product that actually persists in solution rather than reverting because of destabilizing ring strain?', '[{"label": "A", "text": "A closure enclosing three ring atoms"}, {"label": "B", "text": "A closure enclosing four ring atoms"}, {"label": "C", "text": "A closure enclosing six ring atoms"}, {"label": "D", "text": "A closure enclosing seven ring atoms"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is C because a monosaccharide cyclizes only when a hydroxyl group can reach the carbonyl carbon to form a ring that is essentially free of strain, and this is achieved only by 5-membered (furanose) or 6-membered (pyranose) rings. A six-atom ring places its atoms at bond angles very close to the ideal tetrahedral geometry, so it forms and persists in solution. For an aldohexose such as glucose, this six-membered pyranose is in fact the dominant species at equilibrium.

(Choice A) is incorrect: a three-membered ring is extraordinarily strained. Its internal bond angles are forced to roughly \(60^\circ\), far from the tetrahedral ideal, so such a closure is prohibitively unstable and does not form as a sugar ring.

(Choice B) is incorrect: a four-membered ring is likewise highly strained, with angles compressed toward \(90^\circ\). This strain makes the closure energetically unfavorable, so a four-membered ring is not among the sizes sugars stably adopt.

(Choice C) is correct: a six-membered ring corresponds to the pyranose form. Its geometry accommodates near-ideal bond angles, so it forms stably; along with the 5-membered furanose, it is one of the only two ring sizes sugars reliably adopt.

(Choice D) is incorrect: although a seven-membered ring reintroduces some angle relief compared with very small rings, rings larger than six atoms are disfavored for sugars because of transannular crowding and the unfavorable entropy of closing a longer chain; sugars do not stably form seven-membered rings.

This is a Skill 1 (Knowledge of Scientific Concepts) question because it requires you to recall the basic fact that only furanose (5-membered) and pyranose (6-membered) rings form stably for sugars, then apply that recalled rule to identify the viable ring size.', 'easy', '1D', 'Carbohydrates', 'biochemistry', 1, 60, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'assumes any geometrically drawable ring closure is chemically viable, ignoring that small rings carry prohibitive angle strain' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'believes a four-membered ring is stable enough to form, not recognizing the severe angle strain that rules it out' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'over-generalizes ''bigger rings relieve strain'' and picks a seven-membered ring, unaware sugars stop at six' FROM q;

-- Q20 [Cyclic Sugars & Anomers] medium skill2 ans=D [FIG]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Cyclic Sugars & Anomers', 'The figure above shows two cyclic representations of D-glucose, labeled structure A and structure B. A student compares the two Haworth projections carbon by carbon and finds that they are identical at every ring position except one. Based on the location of the single point of difference between structures A and B, how are the two structures best classified?

A. Anomers
B. Enantiomers
C. Epimers
D. Ring-size (furanose/pyranose) isomers', '[{"label": "A", "text": "Ring-size (furanose/pyranose) isomers"}, {"label": "B", "text": "Enantiomers"}, {"label": "C", "text": "Epimers"}, {"label": "D", "text": "Anomers"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is D because the student must locate the single ring position at which structures A and B differ. Reading the two Haworth projections, every carbon is identical except the acetal/hemiacetal carbon (the ring carbon bonded to both the ring oxygen and the exocyclic hydroxyl). Two cyclic sugars that are otherwise identical and differ only in configuration at that carbon are, by definition, anomers, the specific α/β pair generated when the linear aldose cyclizes.

(Choice D) is correct: The reference defines anomers as "diastereomers that differ only at the hemiacetal or acetal C." Because the only mismatch between A and B is at that carbon, the relationship is specifically anomeric \(\left(\alpha\text{ vs. }\beta\right)\).

(Choice B) is incorrect: Enantiomers are "stereoisomers that are mirror images of each other," which requires the configuration to be inverted at every stereocenter (e.g., D-glucose vs. L-glucose). A and B match at all positions but one, so they are not mirror images.

(Choice C) is incorrect: Epimers are diastereomers that differ at exactly one stereocenter other than the acetal/hemiacetal carbon (e.g., glucose vs. galactose at C4). The single difference here is located at the acetal carbon itself, which excludes the epimer classification and defines the more specific anomer case.

(Choice A) is incorrect: A ring-size relationship (furanose, a 5-membered ring, vs. pyranose, a 6-membered ring) would change the number of atoms in the ring. Both A and B contain the same ring skeleton, so they cannot differ in ring size.

This is a Skill 2 item: the stem provides no verbal label for the differing position, so the student cannot word-match. They must extract from the figure that the lone difference sits at the acetal carbon and then map that observation onto the correct isomer definition.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 2, 75, '<svg viewBox="0 0 776 254" xmlns="http://www.w3.org/2000/svg" font-family="''Helvetica Neue'',Arial,sans-serif"><svg x="0" y="0" width="360" height="218" style="width:360px;height:218px" viewBox="0 0 360 218" xmlns="http://www.w3.org/2000/svg" fill="none" stroke="#1a1a1a" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round" font-family="''Helvetica Neue'',Arial,sans-serif"><line x1="86" y1="96" x2="172" y2="74"/><line x1="172" y1="74" x2="258" y2="96"/><line x1="258" y1="96" x2="258" y2="150"/><line x1="86" y1="96" x2="86" y2="150"/><path d="M258,150 L172,172 L86,150" stroke-width="3.6"/><text x="172" y="68" text-anchor="middle" font-size="15.5" fill="#1a1a1a" stroke="none">O</text><line x1="86" y1="96" x2="86" y2="68"/><text x="86" y="60" text-anchor="middle" font-size="15" fill="#1a1a1a" stroke="none">CH<tspan dy="4" font-size="11">2</tspan><tspan dy="-4">OH</tspan></text><line x1="86" y1="150" x2="86" y2="178"/><text x="86" y="192" text-anchor="middle" font-size="15" fill="#1a1a1a" stroke="none">OH</text><line x1="172" y1="172" x2="172" y2="146"/><text x="172" y="139" text-anchor="middle" font-size="15" fill="#1a1a1a" stroke="none">OH</text><line x1="258" y1="150" x2="258" y2="178"/><text x="258" y="192" text-anchor="middle" font-size="15" fill="#1a1a1a" stroke="none">OH</text><line x1="258" y1="96" x2="284" y2="110"/><text x="296" y="114" text-anchor="middle" font-size="15" fill="#14524A" stroke="none" font-weight="700">OH</text><line x1="258" y1="96" x2="258" y2="68"/><text x="258" y="60" text-anchor="middle" font-size="15" fill="#1a1a1a" stroke="none">H</text></svg><svg x="416" y="0" width="360" height="218" style="width:360px;height:218px" viewBox="0 0 360 218" xmlns="http://www.w3.org/2000/svg" fill="none" stroke="#1a1a1a" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round" font-family="''Helvetica Neue'',Arial,sans-serif"><line x1="86" y1="96" x2="172" y2="74"/><line x1="172" y1="74" x2="258" y2="96"/><line x1="258" y1="96" x2="258" y2="150"/><line x1="86" y1="96" x2="86" y2="150"/><path d="M258,150 L172,172 L86,150" stroke-width="3.6"/><text x="172" y="68" text-anchor="middle" font-size="15.5" fill="#1a1a1a" stroke="none">O</text><line x1="86" y1="96" x2="86" y2="68"/><text x="86" y="60" text-anchor="middle" font-size="15" fill="#1a1a1a" stroke="none">CH<tspan dy="4" font-size="11">2</tspan><tspan dy="-4">OH</tspan></text><line x1="86" y1="150" x2="86" y2="178"/><text x="86" y="192" text-anchor="middle" font-size="15" fill="#1a1a1a" stroke="none">OH</text><line x1="172" y1="172" x2="172" y2="146"/><text x="172" y="139" text-anchor="middle" font-size="15" fill="#1a1a1a" stroke="none">OH</text><line x1="258" y1="150" x2="258" y2="178"/><text x="258" y="192" text-anchor="middle" font-size="15" fill="#1a1a1a" stroke="none">OH</text><line x1="258" y1="96" x2="258" y2="68"/><text x="258" y="60" text-anchor="middle" font-size="15" fill="#14524A" stroke="none" font-weight="700">OH</text><line x1="258" y1="96" x2="284" y2="110"/><text x="293" y="114" text-anchor="middle" font-size="15" fill="#1a1a1a" stroke="none">H</text></svg><text x="180" y="242" text-anchor="middle" font-size="16" font-weight="700" fill="#1a1a1a" font-family="''Helvetica Neue'',Arial,sans-serif">A</text><text x="596" y="242" text-anchor="middle" font-size="16" font-weight="700" fill="#1a1a1a" font-family="''Helvetica Neue'',Arial,sans-serif">B</text></svg>')
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'confuses mirror-image (all-stereocenter inversion) with a single-position difference' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'correctly sees one differing stereocenter but ignores that it is the acetal carbon, defaulting to the broader epimer label' FROM q
  UNION ALL
  SELECT id, 'A', 'adjacent_fact', 'imports the furanose/pyranose ring-size distinction from the same chapter as a plausible structural difference' FROM q;

-- Q21 [Chair Conformation & Mutarotation] hard skill2 ans=B [FIG]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Chair Conformation & Mutarotation', 'Among all the aldohexoses, β-D-glucose is by far the most abundant in nature, and its six-membered ring is unusually resistant to distortion into higher-energy ring shapes. The structure shown is the favored chair conformation of β-D-glucopyranose. Reasoning from the positions the ring substituents occupy in the structure shown, which feature best explains why this particular sugar is thermodynamically favored over other aldohexoses?

[FIGURE: The 4C1 chair conformation of β-D-glucopyranose, drawn in the standard zig-zag chair form with the ring oxygen at the upper right and the six ring carbons alternating between "up" and "down" vertices. At every ring carbon, two bonds leave the ring atom in addition to its two ring bonds: one bond is drawn pointing nearly straight up or straight down, parallel to the vertical axis running through the middle of the ring, and the other is drawn splaying out sideways away from the ring. In this drawing, each near-vertical bond carries a hydrogen atom, while the four ring –OH groups (on C1, C2, C3, C4) together with the C5 –CH2OH are each drawn on the sideways-splayed bond at their carbon.]', '[{"label": "A", "text": "In the shown chair, every bulky ring substituent sits on a bond running parallel to the ring axis, which spaces the large groups far from the ring hydrogens and thereby lowers the ring''s overall energy."}, {"label": "B", "text": "In the shown chair, every bulky ring substituent sits on a bond that splays outward from the ring rather than one running parallel to the ring axis, so same-face crowding between substituents is minimized."}, {"label": "C", "text": "The shown anomeric hydroxyl is oriented so that its lone pairs align with the ring-oxygen bond, and this stabilizing orbital overlap is what makes the whole sugar the lowest-energy aldohexose."}, {"label": "D", "text": "Glucose has one fewer chiral center than the other common aldohexoses, so fewer high-energy diastereomeric arrangements are available to it and it settles into the single most stable form."}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is B because the stability of a pyranose ring is governed by how its substituents are distributed between the two kinds of positions on a chair: those on bonds that splay outward from the ring (equatorial) and those on bonds that run parallel to the vertical ring axis (axial). A substituent forced onto an axial bond on one face is crowded against the two other axial groups on that same face two carbons away, producing destabilizing 1,3-diaxial strain. Reading the structure shown, each near-vertical (axial) bond carries only a small hydrogen, while every one of the four ring –OH groups and the –CH2OH sits on an outward-splaying bond — that is, they all occupy equatorial positions. With no bulky group forced axial, there is no 1,3-diaxial crowding, so this conformation sits at an energy minimum. β-D-glucose is the only aldohexose whose favored chair can place all of its bulky substituents equatorial, which is precisely why it is the most stable and most abundant aldohexose in nature.

(Choice B) is correct: it reads the drawing correctly — the bulky groups are on the outward-splaying (equatorial) bonds — and ties that placement to relief of same-face 1,3-diaxial crowding.

(Choice A) is incorrect: it reverses the geometry. The figure shows the bulky groups on the outward-splaying bonds, not on the near-vertical bonds that run parallel to the ring axis. Groups on those axial bonds would be forced together as 1,3-diaxial neighbors, which maximizes strain rather than lowering the energy.

(Choice C) is incorrect: this describes an anomeric-type orbital interaction, which would if anything favor the α-anomer (axial anomeric OH), not β-D-glucose, and it addresses only one carbon. It cannot explain the overall stability advantage, which comes from the arrangement of all five bulky substituents seen in the figure, not from the anomeric position alone.

(Choice D) is incorrect: it is factually wrong. All D-aldohexoses (glucose, mannose, galactose) have the same number of chiral centers — four — so glucose does not have ''one fewer.'' Its stability advantage comes from where its substituents sit in the chair, not from having fewer stereocenters.

At the Skill 2 level, the task is not to recall a memorized fact but to interpret the given conformation: you must read that the bulky substituents lie on the outward-splaying bonds while only hydrogens occupy the axial bonds, recognize that as the all-equatorial arrangement, and connect it to minimized 1,3-diaxial strain — the reasoning chain that explains β-D-glucose''s exceptional prevalence.', 'hard', '1D', 'Carbohydrates', 'biochemistry', 2, 100, '<svg style="max-width:360px;margin-inline:auto" viewBox="0 0 300 214" xmlns="http://www.w3.org/2000/svg" fill="none" stroke="#1a1a1a" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round" font-family="''Helvetica Neue'',Arial,sans-serif"><line x1="250" y1="96" x2="210" y2="132"/><line x1="210" y1="132" x2="140" y2="156"/><line x1="140" y1="156" x2="70" y2="132"/><line x1="70" y1="132" x2="110" y2="96"/><line x1="110" y1="96" x2="180" y2="72"/><line x1="180" y1="72" x2="250" y2="96"/><line x1="210" y1="132" x2="242" y2="146"/><text x="253" y="150" text-anchor="start" dominant-baseline="middle" font-size="14.5" fill="#14524A" stroke="none" font-weight="700">OH</text><line x1="140" y1="156" x2="134" y2="186"/><text x="132" y="198" text-anchor="middle" font-size="14.5" fill="#1a1a1a" stroke="none">OH</text><line x1="70" y1="132" x2="40" y2="146"/><text x="29" y="150" text-anchor="end" dominant-baseline="middle" font-size="14.5" fill="#1a1a1a" stroke="none">HO</text><line x1="110" y1="96" x2="82" y2="78"/><text x="71" y="74" text-anchor="end" dominant-baseline="middle" font-size="14.5" fill="#1a1a1a" stroke="none">HO</text><line x1="180" y1="72" x2="206" y2="52"/><text x="214" y="46" text-anchor="start" font-size="14.5" fill="#1a1a1a" stroke="none">CH<tspan dy="4" font-size="10.5">2</tspan><tspan dy="-4">OH</tspan></text><circle cx="250" cy="96" r="9" fill="#FFFFFF" stroke="none"/><text x="250" y="96" text-anchor="middle" dominant-baseline="middle" font-size="15" fill="#1a1a1a" stroke="none">O</text></svg>')
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'axial/equatorial reversal — reads the chair wrong and claims axial placement is stabilizing' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'anomeric-effect overreach — attributes whole-molecule stability to a single-carbon orbital interaction that actually favors the α-anomer' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'stereocenter-count confusion — false claim that glucose has fewer chiral centers than other aldohexoses' FROM q;

-- Q22 [Chair Conformation & Mutarotation] medium skill2 ans=C [FIG]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Chair Conformation & Mutarotation', 'The structure shown is one chair conformation of β-D-glucopyranose. A pre-med student is asked why this particular conformation, rather than its ring-flipped counterpart, is the one that predominates in solution. Based on the spatial arrangement of the ring substituents in the structure shown, which statement best explains why this conformation is energetically favored?

[FIGURE: A chair conformation of β-D-glucopyranose. At each ring carbon that carries a bulky group (the -OH groups and the -CH2OH group), that group is angled outward from the ring; the smaller hydrogen atoms are the ones pointing straight up or straight down from the ring carbons.]', '[{"label": "A", "text": "The ring oxygen holds the bulky substituents in fixed positions, preventing the molecule from interconverting to any other conformation."}, {"label": "B", "text": "The bulky substituents occupy axial positions, where overlap of their electron clouds provides a stabilizing interaction that lowers the ring''s energy."}, {"label": "C", "text": "The bulky substituents occupy equatorial positions, where they sit farther from the other ring atoms and so experience less steric strain than they would axially."}, {"label": "D", "text": "The bulky substituents lie in the plane of a flat, planar six-membered ring, which spreads them as far apart as the ring geometry allows."}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is C because the six-membered pyranose ring adopts a chair rather than a flat ring, and each ring carbon bears one substituent that points roughly outward from the ring (equatorial) and one that points straight up or down (axial). In the structure shown, the bulky groups (the \(-\text{OH}\) groups and the \(-\text{CH}_2\text{OH}\) group) are the ones angled outward, so they occupy equatorial positions, while the small hydrogens take the axial up/down positions. An equatorial substituent points away from the other ring atoms, so it experiences far less steric strain (1,3-diaxial crowding) than it would in an axial position, where it would be forced close to the axial substituents two carbons away. β-D-glucopyranose is the only common aldohexose that can place all of its bulky substituents equatorial in a single chair, which is exactly why the conformation shown is the favored one; ring-flipping to the alternate chair would force every one of those groups axial and is strongly disfavored.

(Choice C) is correct: the outward-angled bulky groups occupy equatorial positions, and equatorial placement of bulky groups minimizes steric strain, which is what stabilizes the conformation shown.

(Choice B) is incorrect: it reverses the geometry. The bulky groups in the favored chair are equatorial, not axial, and axial bulky groups actually suffer 1,3-diaxial steric clashes. There is no stabilizing "electron-cloud overlap" between them — that description fits the disfavored, all-axial ring-flipped chair, not the one shown.

(Choice A) is incorrect: the ring oxygen does not lock the substituents in place. Cyclic sugars freely interconvert between chair (and boat) conformations without breaking any covalent bonds; the shown chair predominates because it is lower in energy, not because interconversion is forbidden.

(Choice D) is incorrect: the favored form is a puckered chair, not a flat planar ring. A planar six-membered ring is a high-energy arrangement with eclipsing and angle strain; the whole point of the chair is to pucker out of the plane so substituents can adopt distinct axial and equatorial positions.

At the Skill 2 level, you cannot answer by recalling a definition — you must read the figure, recognize that the outward-angled groups are the equatorial ones, and then apply the principle that equatorial placement of bulky substituents reduces steric strain to explain why the shown conformation is preferred.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 2, 75, '<svg style="max-width:360px;margin-inline:auto" viewBox="0 0 300 214" xmlns="http://www.w3.org/2000/svg" fill="none" stroke="#1a1a1a" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round" font-family="''Helvetica Neue'',Arial,sans-serif"><line x1="250" y1="96" x2="210" y2="132"/><line x1="210" y1="132" x2="140" y2="156"/><line x1="140" y1="156" x2="70" y2="132"/><line x1="70" y1="132" x2="110" y2="96"/><line x1="110" y1="96" x2="180" y2="72"/><line x1="180" y1="72" x2="250" y2="96"/><line x1="210" y1="132" x2="242" y2="146"/><text x="253" y="150" text-anchor="start" dominant-baseline="middle" font-size="14.5" fill="#14524A" stroke="none" font-weight="700">OH</text><line x1="140" y1="156" x2="134" y2="186"/><text x="132" y="198" text-anchor="middle" font-size="14.5" fill="#1a1a1a" stroke="none">OH</text><line x1="70" y1="132" x2="40" y2="146"/><text x="29" y="150" text-anchor="end" dominant-baseline="middle" font-size="14.5" fill="#1a1a1a" stroke="none">HO</text><line x1="110" y1="96" x2="82" y2="78"/><text x="71" y="74" text-anchor="end" dominant-baseline="middle" font-size="14.5" fill="#1a1a1a" stroke="none">HO</text><line x1="180" y1="72" x2="206" y2="52"/><text x="214" y="46" text-anchor="start" font-size="14.5" fill="#1a1a1a" stroke="none">CH<tspan dy="4" font-size="10.5">2</tspan><tspan dy="-4">OH</tspan></text><circle cx="250" cy="96" r="9" fill="#FFFFFF" stroke="none"/><text x="250" y="96" text-anchor="middle" dominant-baseline="middle" font-size="15" fill="#1a1a1a" stroke="none">O</text></svg>')
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'swaps axial for equatorial and invents a stabilizing interaction where the real driver is strain minimization' FROM q
  UNION ALL
  SELECT id, 'A', 'misconception', 'believes cyclic sugars are conformationally locked rather than freely interconverting chair forms' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'conflates the flat Haworth depiction with the actual 3D geometry, thinking the favored ring is planar' FROM q;

-- Q23 [Chair Conformation & Mutarotation] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Chair Conformation & Mutarotation', 'A researcher dissolves crystalline pure α-D-glucopyranose in water at neutral pH and immediately begins recording the solution''s optical rotation, which reflects the identities of the sugar species present. No enzymes, acids, or other reagents are added, and the aldehyde carbon is not tied up in a glycosidic bond. Over the next several hours, the researcher periodically re-measures the solution. Assuming the sample is otherwise chemically stable, which outcome best describes the population of glucose species in the solution once the reading stops changing?', '[{"label": "A", "text": "Both α-D-glucopyranose and α-D-galactopyranose are present, in roughly equal amounts"}, {"label": "B", "text": "Only α-D-glucopyranose is present, unchanged from the moment of dissolution"}, {"label": "C", "text": "Only β-D-glucopyranose is present, the α form having been fully consumed"}, {"label": "D", "text": "Both α-D-glucopyranose and β-D-glucopyranose are present, in a fixed ratio favoring one over the other"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is D because a pyranose ring is a cyclic hemiacetal that can reversibly open to the open-chain aldehyde form. When pure α-D-glucopyranose dissolves, its anomeric hemiacetal transiently opens to the achiral-at-C1 straight-chain aldehyde; re-closure can generate either the α or the β anomer. Given enough time, the solution reaches an equilibrium mixture that contains both anomers in a fixed, thermodynamically determined ratio (one anomer is somewhat favored, but neither is eliminated). The changing optical rotation that settles to a constant value is the signature of this interconversion.

(Choice D) is correct: it captures both features of the equilibrium — both anomers coexist, and their ratio is fixed and unequal because the two anomers differ slightly in stability.

(Choice B) is incorrect: it assumes the anomeric center is locked. It is a hemiacetal, not a full acetal, so no enzyme or added reagent is needed for the ring to open and re-close; the optical rotation would not drift and then stabilize if nothing were interconverting.

(Choice C) is incorrect: it confuses "one anomer is favored at equilibrium" with "the reaction goes to completion." Equilibrium between two species of comparable free energy leaves a measurable amount of both; the α form is not fully consumed.

(Choice A) is incorrect: it confuses anomerization with epimerization at a different carbon. Ring opening and re-closure only changes the configuration at the anomeric carbon (C1), producing the other anomer of the same sugar — it does not invert C4 to convert glucose into galactose.

At the Skill 2 level, answering requires reasoning from the hemiacetal ring-opening mechanism to predict the equilibrium state, rather than recalling a stated definition: you must recognize that reversible opening scrambles only C1, so a single pure anomer must relax to a two-anomer mixture of the same sugar.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 2, 90, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'believes the anomeric center is fixed without an enzyme/catalyst' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'treats a favored equilibrium as a reaction that goes to completion' FROM q
  UNION ALL
  SELECT id, 'A', 'process_step_confusion', 'conflates anomerization at C1 with epimerization at another carbon' FROM q;

-- Q24 [Chair Conformation & Mutarotation] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Chair Conformation & Mutarotation', 'A chemist dissolves crystals of pure α-D-glucopyranose in water and immediately begins tracking the solution''s observed optical rotation with a polarimeter. Over the next hour the reading drifts steadily and then holds constant at a value between those of the two pure anomers. In a second trial, the chemist first converts the same glucose to methyl α-D-glucopyranoside (the anomeric hydroxyl replaced by a methoxy group), dissolves it, and again monitors the rotation. Which outcome should the chemist predict for the second trial, and why?

A. The rotation holds constant from the start, because sealing the anomeric carbon prevents the ring from reopening to the intermediate that would let the two anomers interconvert.
B. The rotation holds constant from the start, because the methoxy substituent is bulkier than a hydroxyl and locks the pyranose ring into a single chair conformation.
C. The rotation drifts as before, because in water the glycosidic methoxy group is rapidly hydrolyzed back to a hydroxyl, restoring the original interconversion.
D. The rotation drifts as before, because dissolving any glucose derivative immediately produces equal amounts of α and β forms that then equilibrate.', '[{"label": "A", "text": "The rotation holds constant from the start, because sealing the anomeric carbon prevents the ring from reopening to the intermediate that would let the two anomers interconvert."}, {"label": "B", "text": "The rotation holds constant from the start, because the methoxy substituent is bulkier than a hydroxyl and locks the pyranose ring into a single chair conformation."}, {"label": "C", "text": "The rotation drifts as before, because in water the glycosidic methoxy group is rapidly hydrolyzed back to a hydroxyl, restoring the original interconversion."}, {"label": "D", "text": "The rotation drifts as before, because dissolving any glucose derivative immediately produces equal amounts of α and β forms that then equilibrate."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is A because the drifting rotation in the first trial (mutarotation) requires that the two anomers be able to interconvert in solution. That interconversion is possible only because the cyclic anomeric carbon of glucose is a hemiacetal: it can reversibly open to the open-chain aldehyde form and then reclose, and each reclosure can generate either the α or β anomer. Starting from one pure anomer, this open-and-reclose cycle gradually populates the other anomer until an equilibrium mixture is reached, and because the two anomers have different specific rotations the observed rotation drifts to the equilibrium value. Converting the anomeric \(\text{OH}\) to a methoxy group makes the anomeric carbon a full acetal (a glycoside), not a hemiacetal. An acetal cannot spontaneously ring-open to the aldehyde, so the pathway that allows anomers to interconvert is blocked. With no interconversion, the freshly dissolved single anomer keeps its composition and its rotation stays constant.

(Choice A) is correct: it correctly identifies that mutarotation depends on the anomeric carbon being able to reopen, and that capping it as an acetal removes that intermediate, so no rotation change occurs.

(Choice B) is incorrect: it invents a conformational-locking effect. Even if the methoxy group did favor one chair, a change in preferred chair conformation would not create or prevent the anomer interconversion that mutarotation reports; the deciding factor is whether the anomeric center can open to the open-chain form, not which chair the ring adopts.

(Choice C) is incorrect: glycosides are acetals and are kinetically stable to hydrolysis in neutral water at room temperature (enzymes or strong acid are needed to cleave them on any relevant timescale). The methoxy group is not spontaneously stripped back to a hydroxyl during the measurement, so interconversion is not restored.

(Choice D) is incorrect: dissolving a pure anomer does not instantly yield equal amounts of both forms; interconversion is a gradual approach to equilibrium, and the equilibrium is not 50:50 (β-D-glucopyranose predominates). This choice also ignores that the acetal cannot interconvert at all.

Answering requires reasoning from the mutarotation mechanism to a novel manipulation—recognizing that capping the anomeric carbon eliminates the ring-opening intermediate—rather than recalling a stated definition.', 'hard', '1D', 'Carbohydrates', 'biochemistry', 2, 105, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'conflates conformation with configuration' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'believes glycosides hydrolyze spontaneously in neutral water' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'assumes instantaneous/equal anomer distribution' FROM q;

