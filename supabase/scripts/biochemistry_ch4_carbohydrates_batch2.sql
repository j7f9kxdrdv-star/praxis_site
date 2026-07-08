-- Carbohydrate Structure and Function — Batch 2 — monosaccharide reactions
-- Original Praxist Prep questions, grounded in LibreTexts Biochemistry; scope verified vs AAMC 2026 outline.
-- Idempotent: deletes only this batch's subtopics, then re-inserts. question_attempts / distractor_metadata cascade.

-- Figure support (idempotent; adds the columns if the live DB lacks them).
ALTER TABLE questions ADD COLUMN IF NOT EXISTS figure_svg TEXT;
ALTER TABLE questions ADD COLUMN IF NOT EXISTS figure_url TEXT;

DELETE FROM questions WHERE topic = 'Carbohydrate Structure and Function' AND subtopic IN ('Esterification', 'Glycoside Formation & Hydrolysis', 'Keto-Enol Tautomerism', 'Oxidation & Reducing Sugars', 'Reducing & Non-Reducing Sugars', 'Reduction & Deoxy Sugars');

-- Q1 [Oxidation & Reducing Sugars] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Oxidation & Reducing Sugars', 'A researcher treats a solution of an aldohexose with a mild oxidizing agent chosen specifically because it reacts with aldehyde groups but leaves secondary and primary alcohols untouched. After the reaction goes to completion, the sugar''s carbon skeleton and all of its hydroxyl groups remain intact. Which change to the monosaccharide''s functional groups best accounts for the product formed?', '[{"label": "A", "text": "The aldehyde at the C1 carbon is converted into a carboxylic acid."}, {"label": "B", "text": "The aldehyde at the C1 carbon is converted into a primary alcohol."}, {"label": "C", "text": "The primary alcohol at the terminal (C6) carbon is converted into a carboxylic acid."}, {"label": "D", "text": "Both the C1 aldehyde and the C6 primary alcohol are converted into carboxylic acids."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is A because a mild oxidizing agent that acts selectively on aldehydes will target only the C1 aldehyde of an aldose, converting that \(\text{-CHO}\) group into a carboxylic acid \(\text{-COOH}\) while leaving the carbon skeleton and the alcohol groups untouched. This single-carbon oxidation is exactly what produces an aldonic acid (for example, D-glucose is oxidized to D-gluconic acid), the outcome you should predict whenever an aldose is mildly oxidized at C1.

(Choice C) is incorrect: Oxidizing the primary alcohol at C6 to a carboxylic acid does yield a carboxylic acid, but it describes formation of a uronic acid (e.g., glucuronic acid). A primary alcohol is not an aldehyde, so a mild, aldehyde-selective oxidant does not act there; this misassigns the reactive group to the wrong end of the chain.

(Choice B) is incorrect: Converting the C1 aldehyde into a primary alcohol is a reduction, not an oxidation, and would give a sugar alcohol (alditol, e.g., sorbitol). This reverses the direction of electron flow demanded by an oxidizing agent.

(Choice A) is correct: the reactive C1 aldehyde is the only group a mild oxidant attacks, so it becomes a carboxylic acid, giving an aldonic acid.

(Choice D) is incorrect: Oxidizing both the C1 aldehyde and the C6 alcohol to carboxylic acids describes an aldaric acid (e.g., glucaric acid), which requires a stronger, less selective oxidant. The prompt specifies a mild reagent that spares alcohols, so the C6 position cannot be oxidized here.

At the Skill 2 level, you must apply the rule that mild oxidants convert aldehydes—but not alcohols or ketones—to carboxylic acids, and then map that rule onto the specific C1 position of an aldose to predict the aldonic-acid product rather than simply recalling a definition.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 2, 75, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'C', 'process_step_confusion', 'oxidizes the wrong carbon (C6 primary alcohol → uronic acid instead of C1 → aldonic acid)' FROM q
  UNION ALL
  SELECT id, 'B', 'reversed_relationship', 'confuses oxidation with reduction (aldehyde → primary alcohol yields a sugar alcohol)' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'over-oxidizes both ends (aldaric acid), ignoring that a mild reagent spares alcohols' FROM q;

-- Q2 [Oxidation & Reducing Sugars] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Oxidation & Reducing Sugars', 'A researcher synthesizes two disaccharides from the same pair of hexose monomers. In Disaccharide I, the two rings are joined by an oxygen bridge that connects the anomeric carbon of one ring to the C4 hydroxyl of the other ring. In Disaccharide II, the two rings are joined by an oxygen bridge that directly connects the anomeric carbon of one ring to the anomeric carbon of the other ring. When each is warmed with an alkaline cupric-ion solution, only one of them causes the blue solution to form a brick-red precipitate. Which statement best explains why the two disaccharides behave differently?', '[{"label": "A", "text": "Disaccharide II reacts because joining two anomeric carbons creates a strained bridge that is easily hydrolyzed to release two aldehydes, whereas the C4 linkage in Disaccharide I is stable and cannot be cleaved."}, {"label": "B", "text": "Disaccharide I reacts because one ring retains an anomeric carbon that is still a hemiacetal, allowing that ring to open to an aldehyde; in Disaccharide II both anomeric carbons are tied up as a full acetal, so neither ring can open."}, {"label": "C", "text": "Disaccharide I reacts because a C1-to-C4 oxygen bridge is a hemiacetal linkage, whereas the C1-to-C1 bridge in Disaccharide II is a full acetal linkage that is itself oxidized by the cupric ion."}, {"label": "D", "text": "Disaccharide II reacts because a bond between two anomeric carbons leaves both rings free to undergo keto-enol tautomerization, while the anomeric-to-C4 bond in Disaccharide I locks both rings in the cyclic form."}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is B because a sugar acts as a reducing agent only when at least one anomeric carbon remains a free hemiacetal, which lets that ring open reversibly to the open-chain aldehyde form that the cupric reagent oxidizes. In Disaccharide I the bridge runs from one ring''s anomeric carbon to the other ring''s C4 hydroxyl; the second ring''s anomeric carbon is untouched and stays a hemiacetal, so that ring can still open to an aldehyde and reduce \(\text{Cu}^{2+}\) to the brick-red \(\text{Cu}_2\text{O}\). In Disaccharide II the bridge joins the two anomeric carbons directly, converting both into a single full acetal; with no free hemiacetal, neither ring can open, so it is non-reducing (the sucrose situation).

(Choice B) is correct: it correctly ties the reducing behavior to a surviving free-hemiacetal anomeric carbon in I and the loss of both anomeric hemiacetals to a full acetal in II.

(Choice A) is incorrect: reducing activity comes from ring-opening of a free hemiacetal, not from hydrolyzing the glycosidic bond. Warming with the mild cupric reagent does not cleave the linkage, and the C1-to-C1 acetal is if anything the linkage that cannot open, so this reverses the actual outcome.

(Choice C) is incorrect: it mislabels the linkages. A bond from an anomeric carbon to a C4 hydroxyl is a full acetal at that carbon, not a hemiacetal, and the cupric ion does not oxidize the glycosidic bond itself; it oxidizes the aldehyde exposed when a free hemiacetal ring opens.

(Choice D) is incorrect: keto-enol tautomerization matters for a free anomeric center (e.g., a ketose isomerizing to an aldose), but a carbon locked in an acetal cannot open or tautomerize. Joining the two anomeric carbons removes the only centers that could open, so II is the non-reducing sugar, not the reactive one.

This question targets Skill 2 (Scientific Reasoning and Problem-Solving): rather than recalling a definition, you must map each described linkage onto the state of its anomeric carbon (free hemiacetal versus full acetal) and reason forward to predict which sugar can open to an aldehyde and reduce the metal ion.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 2, 90, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'attributes reducing activity to hydrolysis/cleavage of the glycosidic bond rather than reversible ring-opening of a free hemiacetal' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'confuses hemiacetal vs. acetal designation of the anomeric carbon and imagines the glycosidic bond itself being oxidized' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'correctly invokes tautomerization but assigns reducing behavior to the fully-acetal-locked disaccharide, reversing which sugar can open' FROM q;

-- Q3 [Oxidation & Reducing Sugars] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Oxidation & Reducing Sugars', 'A chemist warms a solution of D-glucose with a basic reagent containing Cu(II) ions. After several minutes the mixture develops a brick-red solid. Which statement correctly describes the electron transfer that produced this result?', '[{"label": "A", "text": "The glucose aldehyde group loses electrons and becomes a primary alcohol, while Cu(II) gains electrons to form elemental Cu(0)."}, {"label": "B", "text": "The glucose aldehyde group gains electrons and becomes a primary alcohol, while Cu(II) loses electrons to form Cu(III)."}, {"label": "C", "text": "The glucose aldehyde group loses electrons and becomes a carboxylate, while Cu(II) gains electrons to form Cu(I)."}, {"label": "D", "text": "The glucose aldehyde group gains electrons and becomes a carboxylate, while Cu(II) loses electrons to form Cu(I)."}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is C because a reducing sugar acts as the reducing agent: its free aldehyde (from the open-chain form of glucose at C1) is the species that gets oxidized, meaning it loses electrons and is converted to a carboxylate (gluconate). Because the sugar donates those electrons, the Cu(II) ion is the oxidizing agent and is reduced — it gains electrons and drops from Cu(II) to Cu(I), which precipitates as brick-red \(\text{Cu}_2\text{O}\). Oxidation of an aldehyde to a carboxylic acid and reduction of \(\text{Cu}^{2+}\) to \(\text{Cu}^{+}\) are complementary halves of the same electron transfer.

(Choice C) is correct: the aldehyde is oxidized (loses electrons → carboxylate) and Cu(II) is reduced by exactly one electron to Cu(I), the oxidation state in \(\text{Cu}_2\text{O}\).

(Choice B) is incorrect: Wrong on both counts and reverses every role: the aldehyde does not gain electrons (that would be reduction to an alcohol, not what a reducing sugar does), and Cu(II) does not get oxidized to Cu(III) — a reducing sugar cannot oxidize the metal.

(Choice A) is incorrect: that the sugar loses electrons, but the products are wrong: losing electrons at the aldehyde carbon gives a carboxylate, not a primary alcohol (alcohol would require gaining electrons), and Cu(II) is reduced only to Cu(I) in \(\text{Cu}_2\text{O}\), not all the way to elemental Cu(0).

(Choice D) is incorrect: Reverses both partners: it says the sugar gains electrons (reduction) and the metal loses electrons (oxidation), which is backwards — the sugar is the reducing agent and therefore is the one oxidized, and Cu(II) is the one reduced.

At the Skill 2 level, you must map the observed brick-red solid onto the underlying redox roles rather than recall a reagent name: identify which partner is the reducing agent (the sugar, oxidized) and which is the oxidizing agent (Cu(II), reduced), then read off the correct products and oxidation-state change (\(\text{Cu}^{2+}\rightarrow\text{Cu}^{+}\)) from those roles.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 2, 80, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'swaps both redox roles and assigns an impossible Cu(III) product' FROM q
  UNION ALL
  SELECT id, 'A', 'partial_truth', 'correct oxidation direction for the sugar but wrong organic product and over-reduces the metal to Cu(0)' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'correct final products but reversed electron-transfer direction for both partners' FROM q;

-- Q4 [Oxidation & Reducing Sugars] hard skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Oxidation & Reducing Sugars', 'A researcher treats β-D-glucopyranose with a mild oxidizing agent that acts specifically on the ring position derived from the free aldehyde. Because the sugar was oxidized in its cyclic form, the initially generated carboxyl group remains held near the ring oxygen''s parent hydroxyl, and an intramolecular reaction traps the product before it can equilibrate with the open-chain species. Which description best characterizes the isolated product?

(Recall that in β-D-glucopyranose the six-membered ring is closed by the hydroxyl on C5, and C6 remains a terminal –CH₂OH.)', '[{"label": "A", "text": "An open-chain polyol in which the C1 carbon has been reduced to a primary alcohol"}, {"label": "B", "text": "An open-chain dicarboxylic acid bearing carboxyl groups at both C1 and C6 termini"}, {"label": "C", "text": "A six-membered cyclic hemiacetal unchanged except for a new carboxyl group at C6"}, {"label": "D", "text": "A six-membered cyclic ester linking the C5 oxygen to the oxidized C1 carbon"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is D because oxidation targets the anomeric carbon (C1), the ring position derived from the open-chain aldehyde. In the open-chain form this would simply give the aldonic acid (D-gluconic acid), with C1 becoming a carboxyl \(\text{(–COOH)}\). But the sugar was oxidized while cyclic, so the newly formed carboxyl at C1 sits adjacent to the C5 hydroxyl — the same –OH that closes the pyranose ring. That C5 oxygen attacks the C1 carboxyl carbon intramolecularly, forming a cyclic ester (a lactone). Because C5 and C1 are separated so as to close a six-membered ring, the product is a δ-lactone (glucono-δ-lactone): a six-membered cyclic ester linking the C5 oxygen to the C1 carbonyl carbon.

(Choice D) is correct: a lactone is an intramolecular ester, and here the C5 –OH esterifies to the oxidized C1 carboxyl, giving the six-membered cyclic ester.

(Choice B) is incorrect: a C1-and-C6 dicarboxylic acid (glucaric/saccharic acid) requires oxidizing BOTH the anomeric carbon and the terminal \(\text{–CH}_2\text{OH}\) at C6. The mild reagent acts only at the aldehyde-derived C1, so C6 stays as an alcohol.

(Choice C) is incorrect: this describes oxidizing C6 to a carboxyl (glucuronic acid) while leaving the C1 hemiacetal intact — the reverse of what the reagent does. The reagent oxidizes C1, and C1 cannot remain a hemiacetal once it is oxidized.

(Choice A) is incorrect: converting C1 to a primary alcohol is a reduction (yielding the alditol glucitol/sorbitol), not an oxidation, and it produces an open-chain polyol with no ester or carboxyl group at all.

Under Skill 2, you must apply the mechanism of anomeric-carbon oxidation to a described cyclic substrate and predict that the geometrically proximal C5 hydroxyl closes onto the new carboxyl to yield a lactone, rather than defaulting to the familiar open-chain aldonic-acid answer.', 'hard', '1D', 'Carbohydrates', 'biochemistry', 2, 100, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'process_step_confusion', 'over-oxidation to the diacid (glucaric acid) by wrongly assuming both terminal carbons react' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'oxidizes the wrong terminus (C6 -> glucuronic acid) and keeps the C1 hemiacetal' FROM q
  UNION ALL
  SELECT id, 'A', 'misconception', 'confuses oxidation with reduction of the anomeric carbon (alditol formation)' FROM q;

-- Q5 [Oxidation & Reducing Sugars] medium skill2 ans=B [FIG]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Oxidation & Reducing Sugars', 'A researcher isolates the monosaccharide whose structure is shown and adds it to a warmed alkaline copper(II) solution to test for redox activity. Based on the structure shown, what should the researcher observe, and why?', '[{"label": "A", "text": "No color change occurs, because the anomeric carbon is locked in an acetal linkage that cannot open to an aldehyde."}, {"label": "B", "text": "A brick-red precipitate forms, because the ring can open at the anomeric carbon to expose an aldehyde that is oxidized."}, {"label": "C", "text": "No color change occurs, because a six-membered pyranose ring is too stable to open under the mild conditions used."}, {"label": "D", "text": "A brick-red precipitate forms, because every hydroxyl group on the ring is oxidized to a carboxylic acid by the copper reagent."}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is B because the structure shown is D-glucopyranose in which the anomeric carbon (C1) carries a hydroxyl group rather than a bond to a second sugar or alcohol. A carbon bearing both a ring oxygen and a hydroxyl is a hemiacetal, and a cyclic hemiacetal exists in equilibrium with its open-chain form. Opening the ring at C1 regenerates a free aldehyde, which a mild oxidant such as alkaline \(\text{Cu}^{2+}\) can oxidize; the copper is simultaneously reduced from \(\text{Cu}^{2+}\) (blue) to \(\text{Cu}_2\text{O}\) (a brick-red \(\text{Cu}^{1+}\) precipitate). A sugar with at least one free hemiacetal is therefore a reducing sugar.

(Choice B) is correct: the free hemiacetal at C1 lets the ring reopen to an oxidizable aldehyde, so the reducing sugar produces the brick-red \(\text{Cu}_2\text{O}\) precipitate.

(Choice A) is incorrect: an acetal would require the anomeric carbon to be bonded to a second oxygen from another sugar or alcohol (a glycosidic linkage), as in sucrose. The anomeric carbon in the structure shown is not engaged in such a linkage, so it is a hemiacetal, not an acetal, and it can open.

(Choice C) is incorrect: ring size does not prevent reopening. The cyclic hemiacetal is genuinely in equilibrium with the open-chain aldehyde under aqueous, especially basic, conditions regardless of whether the ring is a pyranose; the deciding factor is whether the anomeric carbon is a hemiacetal or a locked acetal.

(Choice D) is incorrect: the reaction reaches the right outcome (a precipitate forms) but by a wrong mechanism. The mild oxidant selectively targets the aldehyde generated at the anomeric carbon; it does not oxidize the ordinary ring hydroxyls to carboxylic acids.

This is a Skill 2 item because the student cannot answer from a memorized definition; they must inspect the drawn anomeric carbon, recognize it as a free hemiacetal rather than a glycosidic acetal, and reason forward to the ring-opening equilibrium and resulting redox outcome.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 2, 90, '<svg style="max-width:380px;margin-inline:auto" viewBox="0 0 360 218" xmlns="http://www.w3.org/2000/svg" fill="none" stroke="#1a1a1a" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round" font-family="''Helvetica Neue'',Arial,sans-serif"><line x1="86" y1="96" x2="172" y2="74"/><line x1="172" y1="74" x2="258" y2="96"/><line x1="258" y1="96" x2="258" y2="150"/><line x1="86" y1="96" x2="86" y2="150"/><path d="M258,150 L172,172 L86,150" stroke-width="3.6"/><text x="172" y="68" text-anchor="middle" font-size="15.5" fill="#1a1a1a" stroke="none">O</text><line x1="86" y1="96" x2="86" y2="68"/><text x="86" y="60" text-anchor="middle" font-size="15" fill="#1a1a1a" stroke="none">CH<tspan dy="4" font-size="11">2</tspan><tspan dy="-4">OH</tspan></text><line x1="86" y1="150" x2="86" y2="178"/><text x="86" y="192" text-anchor="middle" font-size="15" fill="#1a1a1a" stroke="none">OH</text><line x1="172" y1="172" x2="172" y2="146"/><text x="172" y="139" text-anchor="middle" font-size="15" fill="#1a1a1a" stroke="none">OH</text><line x1="258" y1="150" x2="258" y2="178"/><text x="258" y="192" text-anchor="middle" font-size="15" fill="#1a1a1a" stroke="none">OH</text><line x1="258" y1="96" x2="258" y2="68"/><text x="258" y="60" text-anchor="middle" font-size="15" fill="#14524A" stroke="none" font-weight="700">OH</text><line x1="258" y1="96" x2="284" y2="110"/><text x="293" y="114" text-anchor="middle" font-size="15" fill="#1a1a1a" stroke="none">H</text></svg>')
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'confuses hemiacetal with acetal / assumes anomeric carbon is locked in a glycosidic linkage' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'believes the pyranose ring is too stable to open, ignoring the hemiacetal equilibrium' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'correct observation via wrong mechanism — thinks the copper reagent oxidizes all ring hydroxyls rather than the single anomeric-derived aldehyde' FROM q;

-- Q6 [Reduction & Deoxy Sugars] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Reduction & Deoxy Sugars', 'A chemist treats a solution of D-glucose (an aldohexose) with a reagent that donates hydride specifically to carbonyl carbons, and the reaction proceeds to completion. Which statement best describes the resulting product?', '[{"label": "A", "text": "Carbon 1 is converted to a carboxylic acid, giving a compound with one acidic end and one alcohol end."}, {"label": "B", "text": "The product is a new reducing sugar that can still reduce Cu2+ to Cu2O in Benedict''s test."}, {"label": "C", "text": "Both terminal carbons now bear a hydroxymethyl group, so the molecule has an alcohol at each end and no carbonyl."}, {"label": "D", "text": "Carbon 1 becomes a phosphoester, blocking the ring-opening equilibrium of the sugar."}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is C because adding hydride to a carbonyl carbon is a reduction, and reducing the C1 aldehyde of an aldohexose converts that carbon from \(\text{-CHO}\) to \(\text{-CH}_2\text{OH}\). Because C6 of the sugar was already a \(\text{-CH}_2\text{OH}\), the product (a sugar alcohol, or alditol, such as D-glucitol/sorbitol) carries a hydroxymethyl group at both ends and contains no remaining carbonyl group. The molecule is now terminated by an alcohol on each end.

(Choice A) is incorrect: wrong because converting C1 to a carboxylic acid is an oxidation (yielding gluconic acid), the opposite of what a hydride donor does; a reducing reagent removes the carbonyl rather than raising it to a carboxyl.

(Choice B) is incorrect: wrong because reducing-sugar behavior depends on a carbonyl (or a hemiacetal that can open to one) being available to be oxidized; once the aldehyde is permanently reduced to an alcohol, the alditol has no carbonyl to donate electrons and no longer reduces \(\text{Cu}^{2+}\).

(Choice C) is correct: reduction of the carbonyl yields \(\text{-CH}_2\text{OH}\), matching the pre-existing \(\text{-CH}_2\text{OH}\) at the other terminus, so the alditol has an alcohol at each end and no carbonyl.

(Choice D) is incorrect: wrong because forming a phosphoester requires transfer of a phosphate group (e.g., from ATP), an entirely different modification; a hydride-donating reagent adds \(\text{H}^-\) to a carbonyl and cannot install a phosphate.

As a Skill 2 item, this requires applying the definition of carbonyl reduction to predict a specific structural outcome for a named sugar, rather than recalling a stated fact, and distinguishing reduction from the oxidation and substitution pathways that alter the same carbons.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 2, 90, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'confuses reduction with oxidation of the carbonyl' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'believes the reduced product retains reducing-sugar activity' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'substitutes a different monosaccharide modification (phosphorylation) for reduction' FROM q;

-- Q7 [Reduction & Deoxy Sugars] easy skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Reduction & Deoxy Sugars', 'Two five-carbon sugars found in nucleic-acid backbones are identical except at C-2: one carries a hydroxyl group at that position, and the other carries only a hydrogen. When each is incorporated into a polynucleotide chain, which consequence follows directly from the presence of the C-2 hydroxyl group (compared with a hydrogen at the same position)?', '[{"label": "A", "text": "The sugar becomes a reducing sugar, whereas the hydrogen-bearing sugar cannot reduce Benedict''s reagent"}, {"label": "B", "text": "The phosphodiester backbone becomes more resistant to nucleophilic attack, because the extra hydroxyl sterically shields the neighboring phosphate"}, {"label": "C", "text": "The sugar can no longer close into a ring and is locked in its open-chain aldehyde form"}, {"label": "D", "text": "The phosphodiester backbone becomes more prone to self-cleavage, because the C-2 hydroxyl can act as an intramolecular nucleophile toward the adjacent phosphate"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is D because the only structural difference described is the group at C-2: a hydroxyl (\(-\text{OH}\)) versus a hydrogen (\(-\text{H}\)). In a polynucleotide, that C-2 hydroxyl sits adjacent to the phosphodiester bond of the backbone and can act as an intramolecular nucleophile: under basic conditions it attacks the neighboring phosphorus, cleaving the chain. This is precisely why ribose-containing polymers (RNA) are chemically labile and self-cleave, whereas replacing the C-2 \(-\text{OH}\) with \(-\text{H}\) (the deoxy modification) removes that nucleophile and yields a far more stable backbone (DNA). The consequence is read directly from the single structural change, not from the name of the sugar.

(Choice D) is correct: The reactive C-2 hydroxyl provides an intramolecular nucleophile positioned to attack the backbone phosphate, so its presence increases susceptibility to base-catalyzed self-cleavage — the correct consequence.

(Choice B) is incorrect: This reverses the actual relationship: the C-2 hydroxyl does not shield the phosphate; it makes the backbone more, not less, vulnerable to nucleophilic (self-)cleavage. The sugar lacking that hydroxyl is the more stable one.

(Choice C) is incorrect: Ring closure (hemiacetal formation) depends on the anomeric carbon (C-1) reacting with a distal ring-oxygen donor, not on the C-2 substituent; both the hydroxyl- and hydrogen-bearing sugars cyclize normally, so the C-2 group does not prevent ring formation.

(Choice A) is incorrect: ''Reducing sugar'' status depends on a free anomeric carbon (the aldehyde/hemiacetal at C-1), which both sugars possess; a substituent at C-2 does not determine whether the sugar reduces Benedict''s reagent, so this consequence does not follow from the C-2 hydroxyl.

As a Skill 2 (reasoning about scientific concepts) item, this question asks you to reason from a single defined structural feature — a hydroxyl versus a hydrogen at C-2 — to its chemical consequence for backbone reactivity, rather than to recall a definition.', 'easy', '1D', 'Carbohydrates', 'biochemistry', 2, 60, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'reverses the effect of the 2''-OH, treating it as protective/stabilizing rather than as the reactive nucleophile that destabilizes the backbone' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'attributes ring closure to the C-2 substituent instead of the anomeric carbon (C-1)' FROM q
  UNION ALL
  SELECT id, 'A', 'adjacent_fact', 'conflates the C-2 substituent with reducing-sugar status, which depends on the free anomeric carbon at C-1' FROM q;

-- Q8 [Reduction & Deoxy Sugars] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Reduction & Deoxy Sugars', 'A researcher treats a solution of D-glucose with a mild reducing agent that converts the molecule''s single carbonyl carbon into a hydroxyl-bearing carbon, yielding an acyclic hexahydroxy product. When this product is dissolved in fresh water and its behavior is compared with that of ordinary D-glucose, which property that glucose displays is NOT observed for the product?

A. It hydrogen-bonds extensively with water and remains highly soluble.
B. It rotates the plane of plane-polarized light passing through its solution.
C. Its freshly prepared solution shows a gradual change in optical rotation until a fixed value is reached.
D. It can react with a carboxylic acid to form a hydrolyzable ester linkage at one of its hydroxyl groups.', '[{"label": "A", "text": "Its freshly prepared solution shows a gradual change in optical rotation until a fixed value is reached."}, {"label": "B", "text": "It rotates the plane of plane-polarized light passing through its solution."}, {"label": "C", "text": "It hydrogen-bonds extensively with water and remains highly soluble."}, {"label": "D", "text": "It can react with a carboxylic acid to form a hydrolyzable ester linkage at one of its hydroxyl groups."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is A because the gradual change in optical rotation of a freshly dissolved sugar until it reaches an equilibrium value is mutarotation, and mutarotation requires the cyclic form to reopen to the acyclic carbonyl form and reclose, interconverting the \(\alpha\) and \(\beta\) anomers. That reversible ring opening depends on the anomeric carbon being a hemiacetal (a carbon bearing both an \(-OH\) and a ring \(-O-\)). Converting glucose''s C1 carbonyl into an ordinary \(-CH_2OH\)/\(-CHOH-\) alcohol removes the carbon that could cyclize into a hemiacetal, so the product exists only as the open-chain polyol (an alditol). With no hemiacetal to open and reclose, no anomers can form or interconvert, and mutarotation is abolished. Thus C names the property glucose shows that the reduced product does not.

(Choice C) is incorrect: The reduced product is a polyhydroxy compound with even more free \(-OH\) groups available than the parent aldose, so it hydrogen-bonds with water and stays highly water-soluble; this property is retained, not lost.

(Choice B) is incorrect: Reduction of C1 does not erase the molecule''s remaining stereocenters (C2–C5 are still chiral centers), so the product is still an optically active chiral molecule that rotates plane-polarized light. A single steady rotation is observed; what is lost is the time-dependent drift, not optical activity itself, so this property is retained.

(Choice A) is correct: Mutarotation — the drift of optical rotation to an equilibrium value — is exactly the property that requires reopening the hemiacetal to the carbonyl form and reforming the ring as a mix of anomers; destroying the carbonyl by reduction eliminates the hemiacetal and therefore this behavior.

(Choice D) is incorrect: Ester formation is a reaction of a hydroxyl group with a carboxylic acid, and it does not require the anomeric carbon at all. The reduced product is a polyol that still carries many \(-OH\) groups (in fact one more than the parent, since C1 is now \(-CH_2OH\)), so it readily esterifies to give an ester linkage that is cleavable by hydrolysis; this capability is retained, not lost.

At the Skill 2 level, you cannot recall a memorized fact here; you must map the described chemical change (carbonyl → alcohol, giving an acyclic polyol) onto the structural requirement for each listed property, recognize that only the hemiacetal-dependent behavior (ring opening/closing that produces anomers) is destroyed, and reject the distractors that depend on unrelated structural features (remaining stereocenters, hydroxyl groups, and general water solubility).', 'hard', '1D', 'Carbohydrates', 'biochemistry', 2, 100, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'C', 'misconception', 'assumes a chemical modification changes an unrelated bulk property (solubility)' FROM q
  UNION ALL
  SELECT id, 'B', 'partial_truth', 'conflates loss of mutarotation with loss of all optical activity/chirality' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'believes reducing the carbonyl removes hydroxyl-based reactivity such as esterification' FROM q;

-- Q9 [Keto-Enol Tautomerism] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Keto-Enol Tautomerism', 'A researcher dissolves a sample of pure D-glucose in a dilute sodium hydroxide solution and lets it stand at room temperature. After several hours, chromatographic analysis of the solution reveals that the original sugar is now accompanied by two additional monosaccharides, all present at equilibrium. Assuming no bonds other than those at C1 and C2 are disturbed during the process, which set of monosaccharides would the chromatogram most likely show?', '[{"label": "A", "text": "D-glucose, D-fructose, and D-galactose"}, {"label": "B", "text": "D-glucose, D-mannose, and D-galactose"}, {"label": "C", "text": "D-glucose, D-fructose, and D-mannose"}, {"label": "D", "text": "D-glucose and D-fructose only"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is C because under basic conditions the carbonyl of an aldose is deprotonated at the adjacent carbon to form a common \(C1\text{–}C2\) enediol intermediate. Because both C1 and C2 lose their fixed geometry in this planar enediol, re-protonation can occur in three ways: back to the original aldose, at C1 to give the corresponding 2-ketose, or at C2 from the opposite face to give the C2 epimer of the starting aldose. For D-glucose, the 2-ketose reached through this shared enediol is D-fructose, and the C2 epimer is D-mannose. All three therefore equilibrate through the same intermediate, so the chromatogram shows D-glucose, D-fructose, and D-mannose.

(Choice A) is incorrect: D-fructose is correctly included as the 2-ketose, but D-galactose differs from glucose at C4, not C2. The \(C1\text{–}C2\) enediol only scrambles the configuration at C2, so a C4 epimer cannot be produced by this pathway.

(Choice B) is incorrect: This set contains no ketose, yet the enediol mechanism necessarily passes through the 2-ketose (fructose) form; it also lists D-galactose, a C4 epimer that the C1–C2 enediol cannot generate. Epimerization here does not occur by a direct one-step swap of an aldose for another aldose.

(Choice D) is incorrect: D-fructose is a valid product, but stopping here ignores that the same enediol also allows re-protonation at C2 from the opposite face, generating the C2 epimer D-mannose. The interconversion is not limited to the aldose and its ketose.

(Choice C) is correct: This set correctly pairs the starting aldose with its 2-ketose (D-fructose) and its C2 epimer (D-mannose), the two products reachable through the shared C1–C2 enediol.

At the Skill 2 level, you are not recalling a named list of interconverting sugars; you must apply the enediol mechanism to a specific starting aldose, recognize that only the C1 and C2 positions can be altered, and deduce which particular ketose and epimer result.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 2, 90, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'any-epimer-interconverts' FROM q
  UNION ALL
  SELECT id, 'B', 'process_step_confusion', 'skips-ketose-intermediate' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'aldose-ketose-only' FROM q;

-- Q10 [Keto-Enol Tautomerism] medium skill1 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Keto-Enol Tautomerism', 'During the alkaline processing of a glucose solution, the open-chain sugar transiently interconverts between a form in which C-2 carries a carbonyl group and a form in which the C-1–C-2 bond is a carbon–carbon double bond bearing a hydroxyl substituent (an "-ene-diol" arrangement). At equilibrium, which form of this two-carbon fragment predominates, and for what reason?

I. The form with the C=C bearing the hydroxyl group predominates
II. The form with the C-2 carbonyl predominates
III. The two forms are present in essentially equal amounts
IV. The favored form is the one lower in free energy', '[{"label": "A", "text": "I, because a carbon–carbon double bond delocalizes electron density more effectively than a carbon–oxygen double bond"}, {"label": "B", "text": "III, because the two forms are related by simply shifting a proton and a double bond, so they are equal in energy"}, {"label": "C", "text": "I and IV, because the double-bond-plus-hydroxyl form lies lower in free energy than the carbonyl-containing form"}, {"label": "D", "text": "II and IV, because the carbonyl-containing form lies lower in free energy than the double-bond-plus-hydroxyl form"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is D because the two interconverting forms described are the keto and enol tautomers of the sugar fragment. The C-2 carbonyl form is the keto tautomer, and the form with a C-1–C-2 double bond bearing a hydroxyl group is the enol tautomer. A carbon–oxygen double bond (the carbonyl) is stronger and more stable than the combination of a carbon–carbon double bond plus an O–H bond found in the enol, so the keto tautomer sits lower in free energy. At equilibrium the lower-energy species predominates, so both statement II (the carbonyl form predominates) and statement IV (the favored form is the one lower in free energy) are correct, and together they identify the keto form as favored.

(Choice A) is incorrect: This selects the enol form (I) and offers a spurious reason: a carbon–carbon \(\pi\) bond does not stabilize an isolated system better than a carbon–oxygen \(\pi\) bond. The stronger, more polarized C=O of the carbonyl makes the keto tautomer the more stable one, so the enol does not predominate.

(Choice B) is incorrect: This reflects the misconception that because tautomers differ "only" by the position of a proton and a double bond, they must be isoenergetic. Tautomers are distinct constitutional isomers with different bonding, and the keto and enol forms differ substantially in free energy; they are not present in equal amounts.

(Choice D) is correct: Statement II correctly names the carbonyl (keto) form as predominant, and statement IV correctly states that the thermodynamically favored tautomer is the one of lower free energy; the keto form satisfies both.

(Choice C) is incorrect: This pairs the correct thermodynamic principle (IV, that the lower-energy form is favored) with the wrong identification of that form. It labels the enol (double bond plus hydroxyl) as lower in energy, but the carbonyl form is actually lower in free energy, so I is incorrect here.

This is a Skill 1 (Knowledge of Scientific Concepts) question because it requires recalling the relative stability of keto versus enol tautomers and applying the definition that the tautomer favored at equilibrium is the one lower in free energy.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 1, 75, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'believes the C=C/enol form is more stable than the carbonyl/keto form' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'treats tautomers as isoenergetic because they differ only by a proton and double-bond shift' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'applies the correct low-energy-favored rule but reverses which tautomer is lower in energy' FROM q;

-- Q11 [Keto-Enol Tautomerism] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Keto-Enol Tautomerism', 'Free D-fructose gives a positive result with a mild copper(II) reagent that oxidizes aldehydes to carboxylates but leaves ketones untouched. Curiously, the fructose unit inside sucrose gives no reaction with the same reagent, even though the two molecules contain the identical fructose framework. Which explanation best reconciles these two observations?', '[{"label": "A", "text": "Under base the open-chain form of free fructose rearranges into an aldehyde-bearing species that the reagent oxidizes; in sucrose the fructose anomeric carbon is locked in the glycosidic bond, so its ring cannot open."}, {"label": "B", "text": "The reagent oxidizes fructose''s C-2 ketone carbonyl directly to a carboxylic acid; in sucrose that same carbonyl is sterically shielded by the bulky glucose unit, so the oxidation cannot take place."}, {"label": "C", "text": "Free fructose reacts simply because it has no glycosidic bond, so any monosaccharide with a free ketone is oxidized by this reagent whether or not it rearranges; sucrose blocks the reaction only by tying up that ketone."}, {"label": "D", "text": "Under the basic conditions the fructose ketone is first reduced to a secondary alcohol, and it is this newly formed hydroxyl group that the reagent then reacts with; in sucrose the linkage prevents that reduction."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is A because the mild copper(II) reagent oxidizes aldehydes but not ketones, so a ketose like fructose cannot be oxidized as-is. Under basic conditions the open-chain form of fructose undergoes keto–enol tautomerism: the C-2 carbonyl and the C-1 hydroxyl equilibrate through a common enediol intermediate, which can collapse toward C-1 to place the carbonyl there, converting the ketose into an aldose (glucose/mannose). That newly exposed aldehyde is what the reagent oxidizes. This rearrangement requires the sugar to be able to open its ring to the free carbonyl form. In sucrose, fructose is joined to glucose through its anomeric (C-2) carbon, so that carbon is locked as a full acetal; the fructose ring cannot open to a free carbonyl and therefore cannot tautomerize, which is exactly why sucrose is a nonreducing sugar. The contrast between free and sucrose-bound fructose thus pinpoints ring-opening plus tautomerization as the required step.

(Choice B) is incorrect: wrong because it violates the stated selectivity of the reagent, which does not touch ketones; a direct oxidation of the C-2 ketone to a carboxylic acid cannot occur, so "steric shielding" is not what silences the sucrose case.

(Choice A) is correct: it correctly routes the chemistry through base-catalyzed tautomerization of the open chain to an aldose, and it correctly explains the sucrose result by the anomeric carbon being tied up in the glycosidic bond so the ring cannot open.

(Choice C) is incorrect: wrong because it denies that any rearrangement is needed. If a free ketone were sufficient, the aldehyde-selective reagent would have no way to act on it; the reactivity depends on generating an aldehyde by tautomerization, not merely on the absence of a glycosidic bond.

(Choice D) is incorrect: wrong because it inverts the redox direction. The sugar is oxidized (it reduces Cu²⁺ to Cu⁺), and no reduction of the ketone to an alcohol occurs; a secondary alcohol is not the group that the reagent oxidizes here.

At the Skill 2 level, you cannot succeed by recalling that "fructose is a reducing sugar." You must reason from two constraints at once—an oxidant that spares ketones, and a fructose unit that reacts only when free—to infer that the reactive species is an aldehyde generated by base-catalyzed enediol tautomerism, a transformation that is impossible once the anomeric carbon is locked in an acetal.', 'hard', '1D', 'Carbohydrates', 'biochemistry', 2, 105, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'believes the mild oxidant attacks the ketone carbonyl directly rather than requiring conversion to an aldehyde' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'correctly notes the glycosidic bond matters but omits the required tautomerization to an aldehyde' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'reverses the redox direction, treating the sugar as being reduced rather than oxidized' FROM q;

-- Q12 [Keto-Enol Tautomerism] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Keto-Enol Tautomerism', 'A three-carbon sugar in solution slowly interconverts between a form bearing a carbonyl at C2 and a transient intermediate in which C2 and C3 are joined by a double bond. A student tracking this interconversion labels the carbonyl oxygen and the two hydrogens on C3 with distinguishable isotopes. When the carbonyl form is converted into the double-bonded intermediate, which set of changes at the C2–C3 region is observed?

I. One hydrogen originally on C3 is no longer bonded to C3.
II. The oxygen at C2 gains a bond to hydrogen.
III. Both original C3 hydrogens remain bonded to C3, and a hydrogen is instead removed from C2.', '[{"label": "A", "text": "II only, because the oxygen at C2 is protonated to give C2–OH while the carbon skeleton and every C–H bond in the region stay completely intact."}, {"label": "B", "text": "I and II only, because a hydrogen leaves C3 while the oxygen at C2 gains one as the C=C forms."}, {"label": "C", "text": "III only, because the carbon that carried the carbonyl must itself lose a hydrogen in order for the new C2=C3 double bond to form."}, {"label": "D", "text": "I and III only, because a hydrogen is stripped from both C2 and C3 at once to make room for the new double bond."}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is B because the interconversion described is keto–enol tautomerization, the process that lets an open-chain sugar shift its carbonyl into a neighboring C=C double bond. Starting from the carbonyl form \(\text{C2}=\text{O}\) with a hydrogen-bearing C3 adjacent to it, forming the C2=C3 double bond requires two coordinated changes: a hydrogen must leave the carbon next to the carbonyl (here C3, the \(\alpha\)-carbon) so that carbon can donate electrons into the new \(\pi\) bond, and the carbonyl oxygen must gain a hydrogen so that \(\text{C2}=\text{O}\) becomes \(\text{C2}\text{–OH}\) (the enol/enediol hydroxyl). Both statement I (a C3 hydrogen is lost) and statement II (the oxygen gains a hydrogen) capture exactly these paired changes, so I and II together are correct.

(Choice A) is incorrect: II only is wrong because protonating the oxygen alone cannot create a carbon–carbon double bond; a hydrogen must also be removed from the adjacent carbon (statement I) to free up the electrons that form the C=C.

(Choice C) is incorrect: III only is wrong because it removes the hydrogen from the carbonyl carbon (C2) itself. C2 has no hydrogen to lose in a ketone, and even in an aldehyde the carbonyl carbon''s electrons are already committed to oxygen; the hydrogen that leaves comes from the neighboring \(\alpha\)-carbon, not from the carbonyl carbon.

(Choice B) is correct: I and II only is correct: the \(\alpha\)-carbon (C3) loses a hydrogen and the carbonyl oxygen gains one, converting \(\text{C}=\text{O} + \text{C}\text{–H}\) into \(\text{C}\text{–OH} + \text{C}=\text{C}\).

(Choice D) is incorrect: I and III only is wrong because it double-counts hydrogen loss, stripping a hydrogen from both carbons. Only one hydrogen total is relocated to oxygen; if hydrogens were pulled from both carbons the atom count would not balance and no O–H would form.

Skill 2 is assessed here because you are given a described chemical transformation and must reason from the mechanism of tautomerization—tracking which specific bonds break and form—rather than recalling a memorized fact, applying the C=O + C–H ⇌ C–OH + C=C relationship to predict the labeled-atom outcome.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 2, 90, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'partial_truth', 'captures only the oxygen-protonation half of the change and ignores that a C–H bond must break to make the C=C' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'removes the hydrogen from the carbonyl carbon instead of the adjacent alpha-carbon' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'believes forming a C=C requires removing a hydrogen from each of the two bonded carbons, violating atom balance' FROM q;

-- Q13 [Esterification] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Esterification', 'A cell converts a free monosaccharide into a metabolic intermediate by joining one of the sugar''s hydroxyl groups to phosphoric acid, a reaction analogous to how a carboxylic acid and an alcohol combine. Which statement best describes the bond that forms and the small molecule released?', '[{"label": "A", "text": "The carbon bearing the reacting hydroxyl is oxidized to a carboxyl group while the phosphate is released as inorganic phosphate."}, {"label": "B", "text": "A glycosidic acetal bond forms at the anomeric carbon, joining the sugar to the phosphate through a direct carbon–carbon linkage."}, {"label": "C", "text": "Water adds across a ring bond to open the sugar into its chain form, leaving the phosphate group chemically unchanged."}, {"label": "D", "text": "A phosphate ester bond forms between the hydroxyl oxygen and phosphorus, and one molecule of water is released."}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is D because esterification of a sugar is a condensation reaction: the oxygen of the sugar''s hydroxyl group attacks the electrophilic phosphorus of phosphoric acid, forming a new \(\text{C–O–P}\) linkage (a phosphate monoester) while one molecule of water is eliminated. The hydroxyl oxygen is retained in the ester linkage, and the acid contributes the \(\text{–OH}\) that leaves as part of water. This is the same alcohol-plus-acid logic that yields carboxylic esters, and it is exactly how sugars such as glucose become glucose-6-phosphate.

(Choice A) is incorrect: Oxidation to a carboxylic acid is a genuine reaction of monosaccharide hydroxyl and aldehyde groups (yielding derivatives such as gluconic or glucuronic acid), but oxidation is a redox change of the sugar carbon, not the acid–alcohol condensation described here; no phosphate ester would result, and phosphate would not simply be expelled.

(Choice B) is incorrect: A glycosidic acetal bond does form by condensation, but it is created when the anomeric hydroxyl reacts with another hydroxyl to give a \(\text{C–O–C}\) acetal linkage—not a carbon–carbon bond, and not with phosphoric acid. Esterification with an acid gives an ester (\(\text{C–O–P}\)), not a glycoside.

(Choice D) is correct: the hydroxyl oxygen bonds to phosphorus to form a phosphate ester, releasing water—the defining outcome of esterifying a sugar \(\text{–OH}\) with phosphate.

(Choice C) is incorrect: This describes hydrolysis/ring-opening, the reverse of a condensation. Esterification consumes a hydroxyl and releases water rather than adding water, and the phosphate becomes covalently bonded to the sugar rather than remaining unchanged.

Answering requires applying the general acid-plus-alcohol esterification pattern to a sugar hydroxyl and predicting both the new bond and the byproduct, which is Skill 2 (reasoning about scientific principles rather than recalling a fact).', 'medium', '1D', 'Carbohydrates', 'biochemistry', 2, 75, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'conflating sugar hydroxyl esterification with oxidation of the sugar to a carboxylic acid' FROM q
  UNION ALL
  SELECT id, 'B', 'process_step_confusion', 'confusing ester (acid + alcohol) formation with glycoside/acetal (alcohol + alcohol) condensation and mislabeling the linkage atoms' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'treating the condensation as hydrolysis—adding water and ring-opening instead of releasing water and forming a bond' FROM q;

-- Q14 [Esterification] medium skill1 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Esterification', 'A glucose transporter in the plasma membrane moves neutral glucose down its concentration gradient in either direction. Once inside a liver cell, glucose is converted to glucose-6-phosphate by transfer of a phosphoryl group from ATP onto the hydroxyl at carbon 6, forming a phosphate ester. Cells that carry out this conversion accumulate a much higher total intracellular glucose-derived pool than cells that do not, because the product does not leave through the same transporter. Which feature of the phosphate ester product best explains why it fails to exit the cell through this transporter?', '[{"label": "A", "text": "The phosphate group carries a net negative charge, and the transporter cannot move a molecule that is no longer neutral"}, {"label": "B", "text": "Esterifying the C6 hydroxyl removes the ring oxygen the transporter must recognize, so binding to the transporter no longer occurs"}, {"label": "C", "text": "Ester formation converts the six-membered ring to an open-chain aldehyde that is too flexible to enter the transporter"}, {"label": "D", "text": "The added phosphate increases the molecule''s mass beyond the size limit that the transporter''s binding pocket can accommodate"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is A because forming a phosphate ester at carbon 6 attaches an ionized phosphate group, which carries a net negative charge at physiological pH. The transporter described moves the *neutral* sugar down its gradient; a charged phosphorylated sugar is a chemically different species that the transporter does not carry. Because the ester-linked phosphate makes glucose-6-phosphate anionic, it can neither be exported by the neutral-glucose carrier nor slip through the nonpolar interior of the bilayer on its own. The consequence is that phosphorylation "traps" the sugar inside the cell, which is why cells performing this step accumulate a larger intracellular pool.

(Choice B) is incorrect: The C6 hydroxyl and the ring oxygen are different atoms; esterifying the primary (C6) hydroxyl does not remove the ring oxygen, and the pyranose ring stays intact. Loss of transporter recognition is a real outcome, but attributing it to destroying the ring oxygen is chemically incorrect.

(Choice A) is correct: the phosphate ester introduces a charge, and a charged solute cannot be moved by a transporter built for the neutral sugar (nor diffuse through the hydrophobic membrane core).

(Choice C) is incorrect: Phosphorylation at C6 does not force the ring open. Ring opening to the open-chain aldehyde is a separate equilibrium (mutarotation) that occurs at the anomeric carbon, C1, and is unrelated to esterifying C6; the phosphorylated sugar remains predominantly cyclic.

(Choice D) is incorrect: A single phosphate adds only about 80 daltons, a small change relative to glucose (~180 daltons); transporters discriminate substrates by chemical fit and charge, not by a strict mass cutoff that this addition would exceed. The decisive change is the new charge, not bulk.

Skill 1: This question asks you to recall the foundational consequence that forming a charged sugar phosphate ester prevents the molecule from crossing the membrane, then identify which chemical property of the product is responsible.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 1, 80, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'confuses C6 hydroxyl with the ring oxygen' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'attributes ring-opening (mutarotation at C1) to C6 esterification' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'believes size/mass, not charge, blocks transport' FROM q;

-- Q15 [Glycoside Formation & Hydrolysis] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Glycoside Formation & Hydrolysis', 'A chemist dissolves D-glucose in excess anhydrous methanol and adds a trace of dry HCl. Under these conditions, methanol reacts selectively at the anomeric carbon of the glucopyranose ring, and the product is isolated after the reaction reaches completion. Which description correctly characterizes the functional-group change at the anomeric carbon and the small molecule, if any, that is released?

A. The anomeric carbon remains a hemiacetal, its linkage to methanol stays a hemiacetal, and one molecule of water is released.
B. The anomeric carbon is converted to an acetal, a glycosidic bond forms to the methanol oxygen, and one molecule of water is released.
C. The anomeric carbon is converted to an ester, an ester bond forms to the methanol oxygen, and one molecule of water is released.
D. The anomeric carbon is converted to an ether by directly joining the two existing hydroxyl oxygens, and no small molecule is released in the process.', '[{"label": "A", "text": "The anomeric carbon remains a hemiacetal, its linkage to methanol stays a hemiacetal, and one molecule of water is released."}, {"label": "B", "text": "The anomeric carbon is converted to an acetal, a glycosidic bond forms to the methanol oxygen, and one molecule of water is released."}, {"label": "C", "text": "The anomeric carbon is converted to an ester, an ester bond forms to the methanol oxygen, and one molecule of water is released."}, {"label": "D", "text": "The anomeric carbon is converted to an ether by directly joining the two existing hydroxyl oxygens, and no small molecule is released in the process."}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is B because the anomeric carbon of cyclic D-glucose bears a hemiacetal, a carbon holding both an \(-OR\) (the ring oxygen) and an \(-OH\) group. When acid protonates the anomeric hydroxyl, that \(-OH\) leaves as water, generating a resonance-stabilized oxocarbenium ion; the incoming methanol oxygen then adds to the anomeric carbon. The carbon now carries two \(-OR\) groups (the ring oxygen and the new \(-OCH_3\)), which is by definition an acetal. This carbon–\(O\)–methanol acetal linkage is a glycosidic bond, and the sugar–\(OCH_3\) product is a glycoside (methyl glucoside). Because the anomeric \(-OH\) departs as \(H_2O\) while methanol supplies the new \(-OR\), exactly one molecule of water is released, making this a condensation.

(Choice A) is incorrect: A hemiacetal has one \(-OR\) and one \(-OH\) on the same carbon; once the second alcohol adds and water leaves, the carbon has two \(-OR\) groups and is no longer a hemiacetal but a full acetal, so the linkage cannot remain a hemiacetal.

(Choice B) is correct: adding a second alcohol to the anomeric hemiacetal, with loss of water, produces an acetal joined by a glycosidic bond.

(Choice C) is incorrect: An ester forms between a carboxylic acid (or acyl group) and an alcohol; glucose has no carboxyl group at its anomeric carbon, so reaction with an alcohol at that carbon yields an acetal, not an ester, even though both reactions release water.

(Choice D) is incorrect: Simply fusing two intact hydroxyl oxygens into an ether would conserve all atoms and release nothing, but that misreads the mechanism: the anomeric hydroxyl is expelled as water, and the product carbon bears two \(-OR\) groups (an acetal), not a single \(-O-\) ether bridge.

This question requires a Skill 2 process: applying the general hemiacetal-plus-alcohol-to-acetal transformation to the specific case of a monosaccharide''s anomeric carbon and predicting both the product''s bond type and the released byproduct.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 2, 90, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'process_step_confusion', 'Fails to advance the reaction: assumes adding an alcohol leaves the anomeric center a hemiacetal rather than converting it to a full acetal.' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'Confuses acetal formation with esterification because both condensations release water, ignoring that no carboxyl group is present.' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'Treats the coupling as a direct ether condensation with no atom loss, missing that the anomeric hydroxyl leaves as water and the product carbon becomes an acetal.' FROM q;

-- Q16 [Glycoside Formation & Hydrolysis] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Glycoside Formation & Hydrolysis', 'A cell assembles a long amylose chain by sequentially joining free glucose units end to end, each new glucose attaching to the growing polymer at its anomeric carbon. For every single glucose unit incorporated into the chain, one additional small molecule is generated and released into the surrounding cytosol. Which molecule accumulates as a byproduct of extending the chain by one glucose?', '[{"label": "A", "text": "Carbon dioxide"}, {"label": "B", "text": "Molecular hydrogen"}, {"label": "C", "text": "Water"}, {"label": "D", "text": "Ammonia"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is C because linking a glucose unit to a growing polysaccharide creates a glycosidic bond, which is an acetal linkage formed by a condensation (dehydration synthesis) reaction. The anomeric hydroxyl of one sugar and a hydroxyl of the next combine, and the atoms of one \(\text{H}_2\text{O}\) molecule are expelled for each bond made. Because one glycosidic bond forms per glucose added, exactly one molecule of water is released per unit incorporated. The reverse process, hydrolysis, consumes a water molecule to break the same linkage, which confirms that bond formation must release it.

(Choice A) is incorrect: Carbon dioxide is lost during decarboxylation reactions of central metabolism (for example, in the citric acid cycle), not when two hydroxyl-bearing carbons are joined by an acetal linkage; no carbon skeleton is cleaved when a glycosidic bond forms.

(Choice B) is incorrect: Molecular hydrogen (\(\text{H}_2\)) would be released only if the reaction were an oxidation that stripped a pair of hydrogen atoms; glycosidic bond formation is a condensation, not a redox event, and the carbon oxidation states of the sugars are unchanged.

(Choice C) is correct: Water is correct: joining the two hydroxyl groups eliminates the elements of one water molecule (an -OH from one sugar and an -H from the other), the defining feature of a dehydration synthesis.

(Choice D) is incorrect: Ammonia is expelled during reactions that break carbon-nitrogen bonds, such as the deamination of amino acids; glucose contains no nitrogen, so no ammonia can be produced when glucose units are joined.

At the Skill 2 level, this question requires recognizing the reaction class from the described bond-forming scenario and then predicting the stoichiometric byproduct, rather than recalling a stated definition.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 2, 75, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'confuses condensation with decarboxylation, expecting CO2 loss as in metabolic pathways' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'mistakes the dehydration synthesis for an oxidation that would release H2' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'imports the nitrogen-loss (deamination) byproduct from amino acid chemistry into a sugar reaction' FROM q;

-- Q17 [Glycoside Formation & Hydrolysis] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Glycoside Formation & Hydrolysis', 'A researcher isolates a pure sample of maltose, a disaccharide in which two glucose units are joined through the anomeric carbon of one ring. She wants to convert the sample entirely back into its individual six-carbon sugars in a test tube. Which pairing of an added reagent with the products she should recover is correct?', '[{"label": "A", "text": "Adding a molecule of water, recovering two molecules of glucose"}, {"label": "B", "text": "Removing a molecule of water, recovering a single larger linked-sugar product"}, {"label": "C", "text": "Adding inorganic phosphate, recovering one molecule of free glucose and one molecule of glucose-1-phosphate"}, {"label": "D", "text": "Adding a mild oxidizing agent, recovering two glucose molecules each bearing an oxidized anomeric carbon"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is A because the glycosidic bond linking the two glucose units of maltose is an acetal, and cleaving an acetal back to its component pieces is a hydrolysis reaction — water is consumed as the nucleophile that breaks the linkage. Adding one molecule of water across the \(\text{Glc}(\alpha 1{\rightarrow}4)\text{Glc}\) linkage splits the disaccharide into its two constituent monosaccharides, yielding two molecules of free glucose. Because the linkage is between two identical hexoses, the only sugar product is glucose.

(Choice C) is incorrect: Cleavage by inorganic phosphate is phosphorolysis, not hydrolysis, and it produces a phosphorylated sugar (e.g., glucose-1-phosphate) rather than a second free sugar; this is how glycogen phosphorylase mobilizes glycogen in cells, but it is a distinct reaction that does not use water and is not the general route for breaking a glycosidic bond.

(Choice B) is incorrect: Removing water (a condensation/dehydration) is the direction that forms a glycosidic bond, not the direction that cleaves one — running it would build a larger linked product instead of liberating the monomers, so this reverses the required chemistry.

(Choice A) is correct: adding water (hydrolysis) cleaves the acetal linkage and regenerates the two free glucose monosaccharides.

(Choice D) is incorrect: A mild oxidizing agent acts on the exposed anomeric carbon (aldehyde) of a reducing sugar, converting it to a carboxylic acid; this redox chemistry modifies a monosaccharide but does nothing to sever the glycosidic bond holding the two units together, so no separation into free sugars occurs.

Skill 2 is assessed here because the stem never states what breaks a glycosidic bond; the test-taker must recognize the linkage as an acetal, recall that acetal cleavage requires the addition of water, and then predict both the reagent and the specific monosaccharide products for this particular disaccharide.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 2, 75, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'C', 'adjacent_fact', 'confusing phosphorolysis with hydrolysis' FROM q
  UNION ALL
  SELECT id, 'B', 'reversed_relationship', 'applying bond-forming (condensation) chemistry to bond cleavage' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'conflating monosaccharide redox chemistry with glycosidic-bond cleavage' FROM q;

-- Q18 [Glycoside Formation & Hydrolysis] hard skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Glycoside Formation & Hydrolysis', 'A chemist synthesizes methyl α-D-glucopyranoside by reacting D-glucose with methanol under acidic conditions. In the product, the ring carbon that was the anomeric center in free glucose now bears the ring oxygen and a newly attached methoxy (–OCH₃) group, with no hydroxyl group remaining on that carbon. A sample of this product is added to hot Benedict''s reagent (a mild Cu²⁺ oxidizing solution). What is the most likely outcome, and why?

A. A brick-red precipitate forms, because the methoxy group makes the anomeric carbon more electrophilic and directly reactive toward the Cu²⁺ oxidant.
B. A brick-red precipitate forms, because under basic conditions the compound tautomerizes to an enediol that exposes an oxidizable carbonyl.
C. No brick-red precipitate forms, because the ring cannot open at the anomeric carbon to regenerate the aldehyde required for oxidation.
D. No brick-red precipitate forms, because acidic synthesis conditions permanently oxidize the anomeric carbon to a carboxylic acid.', '[{"label": "A", "text": "A brick-red precipitate forms, because the methoxy group makes the anomeric carbon more electrophilic and directly reactive toward the Cu²⁺ oxidant."}, {"label": "B", "text": "No brick-red precipitate forms, because the ring cannot open at the anomeric carbon to regenerate the aldehyde required for oxidation."}, {"label": "C", "text": "A brick-red precipitate forms, because under basic conditions the compound tautomerizes to an enediol that exposes an oxidizable carbonyl."}, {"label": "D", "text": "No brick-red precipitate forms, because acidic synthesis conditions permanently oxidize the anomeric carbon to a carboxylic acid."}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is B because a sugar acts as a reducing sugar only when its anomeric carbon can revert from the cyclic form to the open-chain aldehyde, which is the group that reduces \(Cu^{2+}\) to the brick-red \(Cu_2O\) precipitate. In free glucose the anomeric carbon is a hemiacetal (bonded to one ring \(-OR\) and one free \(-OH\)), so it is in equilibrium with the open-chain aldehyde. Once methanol is added under acid to give methyl α-D-glucopyranoside, that carbon becomes a full acetal (bonded to two \(-OR\) groups: the ring oxygen and the new \(-OCH_3\), with no free \(-OH\)). An acetal has no free hydroxyl at the anomeric carbon to allow ring-opening, so it cannot regenerate the aldehyde and cannot reduce Benedict''s reagent. This is exactly why glycosides such as this one — and the glycosidic (acetal) linkage in sucrose — are nonreducing.

(Choice A) is incorrect: wrong because Benedict''s reagent oxidizes an exposed aldehyde carbon, not an electrophilic acetal carbon; making the anomeric carbon "more electrophilic" does not create the free aldehyde that the mild \(Cu^{2+}\) reagent requires, and acetals are in fact unreactive toward it.

(Choice C) is incorrect: a real trap drawn from fructose chemistry: a free ketose can tautomerize through an enediol under basic conditions to expose an oxidizable aldehyde, which is why free fructose is a reducing sugar. But that pathway still requires a free anomeric \(-OH\) (a hemiacetal/hemiketal) to open the ring first. The locked acetal here cannot open, so no enediol and no carbonyl can form.

(Choice B) is correct: with both anomeric bonds occupied by \(-OR\) groups, the ring is locked shut, no aldehyde is ever exposed, and the mild oxidant leaves the sugar untouched — no precipitate.

(Choice D) is incorrect: wrong because the acidic methanol conditions form a glycoside (an acetal), a substitution at the anomeric carbon; they do not oxidize that carbon to a carboxylic acid. Oxidation to an aldonic/uronic acid would require an oxidizing agent, not acid-catalyzed glycoside synthesis.

This is a Skill 2 (reasoning) question: rather than recalling a definition, you must trace the functional-group change (hemiacetal → acetal) caused by the reaction, recognize that ring-opening to the aldehyde is the mechanistic requirement for a positive test, and infer that a locked anomeric carbon eliminates that pathway.', 'hard', '1D', 'Carbohydrates', 'biochemistry', 2, 90, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'confuses electrophilicity of the acetal carbon with reactivity toward a mild aldehyde-selective oxidant' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'correctly recalls fructose enediol tautomerization but misapplies it to a locked acetal that cannot open' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'confuses acid-catalyzed glycoside (acetal) formation with oxidation of the anomeric carbon' FROM q;

-- Q19 [Glycoside Formation & Hydrolysis] easy skill1 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Glycoside Formation & Hydrolysis', 'A chemist reacts D-ribose with methanol under acidic conditions. During the reaction, the ribose first closes into a cyclic form whose ring is built from four carbon atoms and one oxygen atom, and methanol then adds across the anomeric carbon to lock the sugar in that cyclic form. Based on the size of the ring in the product, this methyl glycoside is best classified as which of the following?', '[{"label": "A", "text": "A methyl pyranoside"}, {"label": "B", "text": "A methyl septanoside"}, {"label": "C", "text": "A methyl furanoside"}, {"label": "D", "text": "A methyl trioside"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is C because a glycoside is classified by the size of the cyclic ring in the sugar from which it is derived. A ring built from four carbon atoms plus one oxygen atom is a five-membered ring, which is named a furanose (after the parent compound furan). A glycoside derived from a furanose ring is therefore a furanoside, so the methyl glycoside of a five-membered ribose ring is a methyl furanoside. Ribose in fact predominantly adopts this five-membered (furanose) form, consistent with the ring described.

(Choice A) is incorrect: A pyranoside is derived from a pyranose, the six-membered ring (five carbons and one oxygen, named after pyran). The ring described here has only four carbons and one oxygen, giving five atoms total, not six, so "pyranoside" applies to the wrong ring size. This choice reflects the common assumption that all sugar glycosides default to the six-membered form seen in glucose.

(Choice C) is correct: A five-membered ring (four carbons plus one oxygen) is a furanose, and its glycoside is a furanoside; this matches the ring described, so it is correct.

(Choice B) is incorrect: "Septanoside" would imply a seven-membered ring. Sugar rings that form by intramolecular attack of a hydroxyl on the carbonyl carbon are essentially always five- or six-membered because those sizes are the most stable, and the ring described contains only five atoms, so this is both structurally implausible and the wrong count.

(Choice D) is incorrect: "Trioside" suggests a three-membered ring (or conflates ring size with the "triose" three-carbon designation). The described ring contains five atoms, not three, and monosaccharides do not cyclize into strained three-membered rings, so this choice confuses the total ring size with an unrelated carbon-count naming.

Skill 1: This question requires recognizing and recalling the defined relationship between ring size and glycoside nomenclature (five-membered furanose to furanoside), applying a scientific term to a described structure.', 'easy', '1D', 'Carbohydrates', 'biochemistry', 1, 60, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'assumes all sugar glycosides adopt the six-membered pyranose form like glucose' FROM q
  UNION ALL
  SELECT id, 'B', 'scale_unit_error', 'invents a larger ring-size name for a ring that is actually five-membered' FROM q
  UNION ALL
  SELECT id, 'D', 'scale_unit_error', 'conflates ring-atom count with an unrelated carbon-count (triose) naming, implying a three-membered ring' FROM q;

-- Q20 [Glycoside Formation & Hydrolysis] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Glycoside Formation & Hydrolysis', 'A chemist examines the anomeric carbon of a sugar residue and finds that it is bonded to two oxygen atoms, each of which is part of a separate carbon–oxygen–carbon bridge; the carbon carries no directly attached hydroxyl group. When this residue is warmed with a mild cupric oxidizing solution that reacts only with free aldehydes, no brick-red precipitate forms. Which conclusion about the anomeric carbon best accounts for both the bonding described and the negative test result?', '[{"label": "A", "text": "Its two –OR linkages leave one free –OH, which is oxidized directly without any ring opening."}, {"label": "B", "text": "Its single free –OH allows it to open reversibly to an aldehyde, but the aldehyde is too hindered to be oxidized."}, {"label": "C", "text": "It is a hemiacetal, so the negative result must come from the ketone form resisting the mild oxidant."}, {"label": "D", "text": "Its two –OR linkages lock the ring closed, so it cannot revert to an open-chain aldehyde and act as a reducing group."}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is D because the described anomeric carbon has two separate C–O–C bridges (two \(-\text{OR}\) groups) and no free \(-\text{OH}\), which is the defining bonding pattern of an acetal, i.e., a glycoside. In the cyclic form of a monosaccharide, the anomeric carbon must retain one free \(-\text{OH}\) (a hemiacetal) to reversibly ring-open into the reactive open-chain aldehyde. Replacing that free \(-\text{OH}\) with a second \(-\text{OR}\) converts the hemiacetal into a full acetal, which cannot ring-open to an aldehyde. With no free aldehyde available, the mild cupric reagent has nothing to oxidize, so no \(\text{Cu}_2\text{O}\) precipitate forms — the residue is non-reducing at that carbon. The bonding (two \(-\text{OR}\), no \(-\text{OH}\)) and the negative test are therefore two consequences of the same fact.

(Choice D) is correct: two \(-\text{OR}\) groups and no free \(-\text{OH}\) define an acetal/glycoside, which is locked closed and cannot open to an oxidizable aldehyde, explaining the negative result.

(Choice B) is incorrect: it misreads the bonding — the stem specifies no free \(-\text{OH}\) at the anomeric carbon, so this "single free –OH" premise contradicts the described acetal. A hemiacetal that could open would in fact give a positive test, not a negative one.

(Choice C) is incorrect: a hemiacetal has one \(-\text{OR}\) and one free \(-\text{OH}\), not the two \(-\text{OR}\) groups described, so the residue is not a hemiacetal; invoking a "ketone form" also does not follow from the bonding given.

(Choice A) is incorrect: it self-contradicts by claiming two \(-\text{OR}\) groups yet still a free \(-\text{OH}\); an acetal carbon has no free \(-\text{OH}\), and reducing behavior requires ring-opening to an aldehyde, not direct oxidation of a hydroxyl at the anomeric carbon.

This is a Skill 2 item because it asks you to apply the hemiacetal-versus-acetal bonding rule to a described anomeric carbon and predict its chemical behavior, rather than to recall a stated definition.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 2, 90, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'confuses_hemiacetal_and_acetal_bonding' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'mislabels_acetal_as_hemiacetal' FROM q
  UNION ALL
  SELECT id, 'A', 'partial_truth', 'retains_free_OH_with_two_OR' FROM q;

-- Q21 [Reducing & Non-Reducing Sugars] hard skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Reducing & Non-Reducing Sugars', 'A chemist synthesizes four disaccharides, each built from two glucose units joined by a single glycosidic bond, and then tests each one with a mild oxidizing reagent that reacts with an open-chain aldehyde. The four linkages are:

I. The anomeric carbon (C1) of one glucose bonded to the C1 anomeric carbon of the other.
II. The anomeric carbon (C1) of one glucose bonded to the C4 hydroxyl of the other.
III. The anomeric carbon (C1) of one glucose bonded to the C6 hydroxyl of the other.
IV. The anomeric carbon (C1) of one glucose bonded to the C2 hydroxyl of the other.

Which disaccharide will fail to give a positive result with the reagent?', '[{"label": "A", "text": "Disaccharide II"}, {"label": "B", "text": "Disaccharide I"}, {"label": "C", "text": "Disaccharide III"}, {"label": "D", "text": "Disaccharide IV"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is B because a disaccharide gives a positive test only if at least one monosaccharide retains a free hemiacetal—an anomeric carbon still bearing an \(-OH\) that can reversibly open to the acyclic aldehyde and be oxidized. In linkage I, the glycosidic bond joins the anomeric C1 of one glucose to the anomeric C1 of the other, so BOTH anomeric carbons are locked into a full acetal. Neither ring can open to expose an aldehyde, and the disaccharide is non-reducing—it fails the test.

(Choice B) is correct: With both anomeric carbons committed to the bond, there is no free hemiacetal and no acyclic aldehyde can form; this is the same situation that makes sucrose (an anomeric-to-anomeric linkage) non-reducing.

(Choice A) is incorrect: A C1-to-C4 linkage (as in maltose or lactose) consumes only one anomeric carbon; the second glucose keeps its C1 as a free hemiacetal that can open to an aldehyde, so this disaccharide is reducing and tests positive.

(Choice C) is incorrect: A C1-to-C6 linkage (as in isomaltose) uses only the anomeric carbon of the first glucose; the C6 hydroxyl is a non-anomeric primary alcohol, so the second glucose retains a free anomeric hemiacetal and the sugar is reducing.

(Choice D) is incorrect: Here the anomeric C1 of one glucose bonds to the C2 hydroxyl of the other. Because C2 of glucose is a non-anomeric hydroxyl, the second glucose still has a free anomeric carbon at its own C1, leaving one open-able hemiacetal—so this disaccharide is reducing. (This is distinct from sucrose, where the 1,2 bond joins the anomeric C1 of glucose to the anomeric C2 of a ketose fructose, consuming both anomeric carbons.)

This is a Skill 2 item: rather than recalling that "sucrose is non-reducing," you must apply the rule that a free hemiacetal (an anomeric carbon still capable of ring-opening) is required for reduction, and evaluate each described linkage to determine whether both anomeric carbons have been consumed.', 'hard', '1D', 'Carbohydrates', 'biochemistry', 2, 90, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'believes any glycosidic bond eliminates the reducing end' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'mistakes a non-anomeric primary (C6) hydroxyl for a consumed anomeric carbon' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'overgeneralizes sucrose''s 1,2 linkage as always anomeric-to-anomeric' FROM q;

-- Q22 [Reducing & Non-Reducing Sugars] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Reducing & Non-Reducing Sugars', 'D-glucose is treated with methanol and a trace of acid, converting it to methyl α-D-glucopyranoside, in which the C1 oxygen bridges to a methyl group. Compared with the D-glucose it was made from, how does this product behave toward (i) mutarotation of its optical rotation in aqueous solution and (ii) reduction of Cu²⁺ in Benedict''s reagent?

(i) mutarotation, (ii) Cu²⁺ reduction', '[{"label": "A", "text": "Shows mutarotation; does not reduce Cu²⁺"}, {"label": "B", "text": "Does not show mutarotation; reduces Cu²⁺"}, {"label": "C", "text": "Does not show mutarotation; does not reduce Cu²⁺"}, {"label": "D", "text": "Shows mutarotation; reduces Cu²⁺"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is C because both mutarotation and the ability to reduce \(\text{Cu}^{2+}\) depend on the same structural feature: an anomeric carbon that can reopen to the open-chain aldehyde. In free D-glucose, C1 is a cyclic hemiacetal that reversibly opens to an aldehyde; the aldehyde re-closes to either the α or β ring (producing mutarotation) and is also oxidizable (reducing \(\text{Cu}^{2+}\) to brick-red \(\text{Cu}_2\text{O}\)). Forming methyl α-D-glucopyranoside converts that hemiacetal into a full acetal (a glycoside): the C1 oxygen is now committed to the methyl bridge, the ring can no longer open, and no aldehyde is ever exposed. With the anomeric carbon locked, the α form cannot equilibrate with β and no open aldehyde exists to be oxidized, so the glycoside neither mutarotates nor reduces Benedict''s reagent.

(Choice A) is incorrect: wrong because it grants mutarotation while denying reduction; both properties share the identical requirement of a re-openable anomeric center, so they cannot be separated this way—a locked acetal loses both, not just one.

(Choice B) is incorrect: wrong for the mirror-image reason: it denies mutarotation but claims reduction. Reduction of \(\text{Cu}^{2+}\) requires the same free aldehyde that mutarotation needs, so a glycoside that cannot mutarotate also cannot reduce the reagent.

(Choice D) is incorrect: treats the product as if its anomeric carbon were still a free hemiacetal, which describes the starting glucose, not the glycoside; the acetal linkage removes the open-chain aldehyde entirely, so both properties are absent.

(Choice C) is correct: because trapping C1 in a glycosidic (acetal) bond eliminates ring-opening, removing the open-chain aldehyde responsible for both mutarotation and \(\text{Cu}^{2+}\) reduction.

Skill 2: rather than recalling a labeled definition, you must connect the reaction described (hemiacetal → acetal) to its structural consequence (no ring-opening) and then deduce that a single change withdraws two seemingly separate properties at once.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 2, 80, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'partial_truth', 'decouples two properties that share one cause; keeps mutarotation, drops reduction' FROM q
  UNION ALL
  SELECT id, 'B', 'partial_truth', 'decouples two properties that share one cause; drops mutarotation, keeps reduction' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'treats the glycoside as if its anomeric carbon were still a free hemiacetal (attributes starting-material behavior to the product)' FROM q;

-- Q23 [Reducing & Non-Reducing Sugars] medium skill1 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Reducing & Non-Reducing Sugars', 'Amylose is an unbranched storage polymer built from many D-glucose residues joined exclusively by α-1,4 glycosidic linkages. A researcher treats a purified sample of a single, intact amylose chain (containing hundreds of glucose residues) with warm Benedict''s reagent under conditions that do not hydrolyze any of the glycosidic bonds. Considering how each glucose residue is connected to its neighbors along the chain, how many glucose residues in one intact amylose molecule are capable of opening to the free open-chain aldehyde form?', '[{"label": "A", "text": "None, because every glucose residue in the chain is joined to a neighbor through its C1"}, {"label": "B", "text": "Two, because both terminal residues sit at the ends of the chain"}, {"label": "C", "text": "All of them, because each glucose retains its ring-opening ability regardless of linkage"}, {"label": "D", "text": "Exactly one, the terminal residue whose C1 is not committed to a glycosidic bond"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is D because ring opening to the free aldehyde requires a hemiacetal, and a glucose residue only retains a hemiacetal at its anomeric carbon (\(C1\)) if that carbon is NOT tied up in a glycosidic linkage. In an α-1,4 chain, each internal residue donates its \(C1\) into the acetal bond that connects it to the next residue, converting that anomeric carbon into a full acetal that cannot revert to the open-chain aldehyde. Following the chain, every residue uses its \(C1\) for a linkage except the single residue at one terminus, whose \(C1\) remains a free hemiacetal. That lone residue is the reducing end, and it is the only one that can open to an aldehyde and reduce Benedict''s reagent.

(Choice A) is incorrect: wrong because not every residue is joined through its \(C1\). The residue at the reducing terminus keeps its \(C1\) free as a hemiacetal—it connects to the chain through its \(C4\) hydroxyl rather than through \(C1\)—so at least that one residue is not linked through its anomeric carbon and can still open to the aldehyde.

(Choice B) is incorrect: wrong because the two ends of the chain are not chemically equivalent. Only the reducing terminus has a free anomeric carbon. At the non-reducing terminus the residue''s own \(C1\) is committed to the acetal glycosidic bond with its neighbor (only its \(C4\) hydroxyl is left free), so that residue cannot open to an aldehyde. This leaves a single reducing end per chain, not two.

(Choice D) is correct: because exactly one terminal residue keeps an uncommitted anomeric carbon, giving a single reducing end per unbranched chain.

(Choice C) is incorrect: wrong because a glucose whose \(C1\) is locked in an acetal glycosidic bond has lost its hemiacetal and can no longer open to the aldehyde; ring-opening ability is not preserved once the anomeric carbon is used in a linkage.

This is a Skill 1 (Knowledge of Scientific Concepts) question: it asks you to recall that a hemiacetal (free anomeric carbon) is required for ring opening and to apply that fact to trace which residues in a defined linear polysaccharide retain one.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 1, 75, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'overgeneralizes that every residue''s anomeric carbon is consumed in a linkage' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'treats both chain termini as equivalent, conflating reducing and non-reducing ends' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'believes ring-opening ability is intrinsic to glucose and unaffected by acetal linkage' FROM q;

-- Q24 [Reducing & Non-Reducing Sugars] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Reducing & Non-Reducing Sugars', 'A chemist dissolves freshly prepared methyl α-D-glucopyranoside — glucose whose anomeric hydroxyl has been converted to a methyl glycoside — in water. Over several hours she monitors the solution''s optical rotation and finds that it does not drift toward a stable intermediate value, remaining fixed at the rotation of the α form. She then heats an aliquot with a mild cupric ion test reagent and observes no brick-red precipitate. Which single feature of this molecule accounts for BOTH the constant optical rotation and the failure of the copper test?

A. The methyl group''s electron donation stabilizes the ring oxygen, freezing the anomeric configuration and shielding C1 from oxidation
B. Its anomeric carbon is locked as a full acetal, so the ring cannot reopen to the free-aldehyde form that either process would require
C. Glycoside formation converts the C1 aldehyde into a carboxylic acid, which is neither oxidizable nor capable of interconverting between anomers
D. As a monosaccharide derivative it lacks the second sugar unit whose free anomeric center is needed to both mutarotate and reduce copper', '[{"label": "A", "text": "Its anomeric carbon is locked as a full acetal, so the ring cannot reopen to the free-aldehyde form that either process would require"}, {"label": "B", "text": "The methyl group''s electron donation stabilizes the ring oxygen, freezing the anomeric configuration and shielding C1 from oxidation"}, {"label": "C", "text": "Glycoside formation converts the C1 aldehyde into a carboxylic acid, which is neither oxidizable nor capable of interconverting between anomers"}, {"label": "D", "text": "As a monosaccharide derivative it lacks the second sugar unit whose free anomeric center is needed to both mutarotate and reduce copper"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is A because both observations trace back to a single structural fact: the anomeric carbon (C1) of the glycoside is a full acetal, not a hemiacetal. In free glucose, C1 is a cyclic hemiacetal that can reversibly open to expose the straight-chain aldehyde. That open-chain intermediate is what allows α and β cyclic forms to interconvert (mutarotation, seen as optical rotation drifting to an equilibrium value) and what presents an oxidizable aldehyde to a mild cupric reagent (the positive reducing-sugar test that gives brick-red \(\text{Cu}_2\text{O}\)). Once the anomeric \(-\text{OH}\) is replaced by \(-\text{OCH}_3\) to give a full acetal, there is no anomeric proton to lose and no leaving group for ring-opening under these conditions, so the ring stays closed. With no accessible free aldehyde, the α configuration is fixed (rotation stays constant) and there is nothing for the copper to oxidize (no precipitate). One cause, two consequences.

(Choice B) is incorrect: wrong because it invents an electronic "shielding/freezing" effect. The methyl group does not merely stabilize a configuration or block oxidation electronically; it eliminates the ring-opening pathway entirely by making C1 a full acetal. Inductive electron donation is not what abolishes mutarotation or the copper reaction.

(Choice A) is correct: a full acetal at the anomeric carbon cannot revert to the open aldehyde, and that single fact suppresses both mutarotation and the reducing-sugar reaction.

(Choice C) is incorrect: wrong because glycoside formation does not oxidize C1 to a carboxylic acid — it forms an acetal by adding an alkoxy group. The carbon stays at the acetal (aldehyde) oxidation level; it is simply no longer free to open. Converting to a carboxylic acid would be an oxidation (as in aldonic acids), a different reaction that is not what happened here.

(Choice D) is incorrect: wrong because reducing behavior and mutarotation do not require a second sugar unit at all. Free monosaccharides like glucose mutarotate and give a positive copper test on their own; the deciding factor is whether the anomeric carbon is a hemiacetal (open-able) or a locked acetal, not how many sugar residues are present.

This is a Skill 2 (Reasoning) item: the stem reports two separate laboratory behaviors and asks you to trace both to one underlying structural cause, requiring you to connect anomeric-carbon availability to ring-opening and then to each observation, rather than to recall a definition.', 'hard', '1D', 'Carbohydrates', 'biochemistry', 2, 100, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'invents_an_electronic_effect_instead_of_the_structural_ring-opening_cause' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'confuses_acetal_formation_with_oxidation_to_a_carboxylic_acid' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'wrongly_requires_a_second_sugar_unit_for_mutarotation_and_reduction' FROM q;

