-- Carbohydrate Structure and Function — Batch 3 — complex carbohydrates + metabolism-lite
-- Original Praxist Prep questions, grounded in LibreTexts Biochemistry; scope verified vs AAMC 2026 outline.
-- Idempotent: deletes only this batch's subtopics, then re-inserts. question_attempts / distractor_metadata cascade.

-- Figure support (idempotent; adds the columns if the live DB lacks them).
ALTER TABLE questions ADD COLUMN IF NOT EXISTS figure_svg TEXT;
ALTER TABLE questions ADD COLUMN IF NOT EXISTS figure_url TEXT;

DELETE FROM questions WHERE topic = 'Carbohydrate Structure and Function' AND subtopic IN ('Carbohydrate Metabolism', 'Cellulose', 'Disaccharides', 'Glycogen', 'Polysaccharides', 'Starch');

-- Q1 [Disaccharides] easy skill1 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Disaccharides', 'A plant loads a sweet-tasting disaccharide into its phloem to transport fixed carbon from its leaves to its roots. When a hydrolase in the root cells cleaves the glycosidic bond of this transport sugar, the reaction releases two chemically distinct monosaccharides: an aldohexose that the cell can phosphorylate directly, and a ketohexose. This transport sugar is the same disaccharide humans consume as ordinary table sugar. Which pair of monosaccharides is released when this disaccharide is hydrolyzed?', '[{"label": "A", "text": "Glucose and fructose"}, {"label": "B", "text": "Glucose and glucose"}, {"label": "C", "text": "Glucose and galactose"}, {"label": "D", "text": "Galactose and fructose"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is A because table sugar is sucrose, a disaccharide built from one glucose unit joined to one fructose unit through an \(\alpha,\beta\)-1,2 glycosidic bond. Hydrolysis of that bond therefore releases exactly one glucose and one fructose. This also matches the scenario''s chemical clues: glucose is an aldohexose (an aldose the cell can phosphorylate directly), and fructose is a ketohexose (a ketose), so the two products are indeed chemically distinct.

(Choice C) is incorrect: glucose plus galactose is the monomer pair of lactose (milk sugar), not sucrose. Galactose is an aldohexose like glucose, so this pair would not include the required ketohexose, and it does not describe table sugar.

(Choice B) is incorrect: glucose plus glucose is the composition of maltose, a hydrolysis product of starch and glycogen. Both monomers would be identical aldohexoses, contradicting the scenario''s requirement that the two products be chemically distinct with one being a ketohexose.

(Choice A) is correct: sucrose hydrolyzes into glucose (an aldohexose) and fructose (a ketohexose), the exact two monosaccharides described.

(Choice D) is incorrect: this pair keeps the correct fructose but replaces glucose with galactose. No common dietary disaccharide is made of galactose and fructose, and table sugar specifically contains glucose, not galactose.

As a Skill 1 item, this question asks you to recall the defining monomer composition of a named biomolecule (sucrose = glucose + fructose) and connect it to the basic aldose/ketose identities of those two sugars.', 'easy', '1D', 'Carbohydrates', 'biochemistry', 1, 50, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'C', 'adjacent_fact', 'confuses sucrose with lactose (glucose + galactose)' FROM q
  UNION ALL
  SELECT id, 'B', 'adjacent_fact', 'confuses sucrose with maltose (glucose + glucose)' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'keeps fructose but substitutes galactose for glucose, inventing a non-existent pairing' FROM q;

-- Q2 [Disaccharides] easy skill1 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Disaccharides', 'A newborn is diagnosed with a deficiency of the intestinal enzyme that hydrolyzes the principal disaccharide in breast milk. As a result, this sugar passes into the large intestine undigested rather than being broken down into its two component monosaccharides for absorption. Which pair of monosaccharides would normally have been released by complete hydrolysis of this disaccharide?', '[{"label": "A", "text": "Glucose and fructose"}, {"label": "B", "text": "Galactose and glucose"}, {"label": "C", "text": "Glucose and glucose"}, {"label": "D", "text": "Galactose and fructose"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is B because the principal disaccharide in milk is lactose, and complete hydrolysis of lactose yields galactose and glucose joined by a \(\beta(1\rightarrow4)\) glycosidic bond, written Gal(\(\beta1,4\))Glc. The intestinal enzyme lactase cleaves this bond and liberates one molecule of galactose and one of glucose for absorption.

(Choice A) is incorrect: glucose and fructose are the monomers of sucrose (table sugar), Glc(\(\alpha1,2\))Fru, not the sugar in milk. Fructose is not a component of the milk disaccharide.

(Choice B) is correct: the milk disaccharide lactose is composed of galactose linked to glucose, so hydrolysis releases exactly these two monosaccharides.

(Choice C) is incorrect: two glucose units joined by an \(\alpha(1\rightarrow4)\) bond form maltose, a starch/glycogen hydrolysis product, not the milk sugar; milk''s disaccharide contains galactose, not a second glucose.

(Choice D) is incorrect: this pairing swaps in fructose for glucose. Galactose is one correct monomer, but the second monomer of the milk disaccharide is glucose, not fructose, so this pair is wrong.

As a Skill 1 (Knowledge of Scientific Concepts) item, this question asks you to recall the identity of the monosaccharide building blocks of a common disaccharide — a foundational fact about carbohydrate structure.', 'easy', '1D', 'Carbohydrates', 'biochemistry', 1, 45, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'confuses milk sugar (lactose) with table sugar (sucrose)' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'recalls a different common disaccharide (maltose, Glc+Glc) instead of lactose' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'gets galactose right but substitutes fructose for the second monomer glucose' FROM q;

-- Q3 [Disaccharides] easy skill1 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Disaccharides', 'During digestion, salivary and pancreatic amylases progressively cleave dietary starch, and the predominant disaccharide released as an intermediate product is subsequently split by a brush-border enzyme before absorption. Which monosaccharide units make up this disaccharide intermediate?', '[{"label": "A", "text": "One galactose unit and one glucose unit"}, {"label": "B", "text": "One glucose unit and one fructose unit"}, {"label": "C", "text": "Two glucose units"}, {"label": "D", "text": "Two fructose units"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is C because starch is a polymer of glucose, so its breakdown by amylase yields maltose, a disaccharide composed of two glucose units joined by an \(\alpha\)-1,4 glycosidic bond. The intestinal brush-border enzyme maltase then hydrolyzes maltose into two free glucose molecules for absorption.

(Choice C) is correct: Maltose is the disaccharide intermediate of starch digestion, and because starch contains only glucose residues, both monosaccharides released are glucose.

(Choice B) is incorrect: One glucose plus one fructose describes sucrose, \(\text{Glc}(\alpha 1,2)\text{Fru}\), which is table sugar derived from plants — not the intermediate produced when amylase digests starch.

(Choice A) is incorrect: One galactose plus one glucose describes lactose, \(\text{Gal}(\beta 1,4)\text{Glc}\), the disaccharide found in milk; galactose is not a component of starch, so it cannot arise from starch breakdown.

(Choice D) is incorrect: Two fructose units would require a fructose-based polymer; starch is built entirely from glucose, so no fructose is released during its digestion.

This question requires Skill 1 (Knowledge of Scientific Concepts) because it tests recall of the composition and dietary origin of maltose as the disaccharide product of starch hydrolysis.', 'easy', '1D', 'Carbohydrates', 'biochemistry', 1, 60, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'adjacent_fact', 'confuses maltose with sucrose (glucose+fructose)' FROM q
  UNION ALL
  SELECT id, 'A', 'adjacent_fact', 'confuses maltose with lactose (galactose+glucose)' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'assumes an incorrect monosaccharide (fructose) is the starch monomer' FROM q;

-- Q4 [Disaccharides] hard skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Disaccharides', 'A student mixes three separate disaccharide solutions with Benedict''s reagent and heats each tube. She has been told only how each disaccharide is assembled: in the first, the C1 of one glucose is bonded to the C4 of a second glucose; in the second, the C1 of galactose is bonded to the C4 of glucose; and in the third, the C1 of glucose is bonded to the C2 of fructose. One tube fails to produce the brick-red precipitate that signals a positive result. Which disaccharide gives the negative result, and what accounts for it?

A. The first disaccharide, because a bond originating from a glucose C1 locks that ring shut and prevents any chain opening.
B. The second disaccharide, because the galactose ring cannot isomerize to an open-chain aldehyde the way a glucose ring can.
C. The third disaccharide, because its linkage ties up the reactive carbon of both monosaccharides, so neither ring can open.
D. The third disaccharide, because fructose is a ketose, and Benedict''s reagent reacts only with sugars built entirely from aldoses.', '[{"label": "A", "text": "The first disaccharide, because a bond originating from a glucose C1 locks that ring shut and prevents any chain opening."}, {"label": "B", "text": "The second disaccharide, because the galactose ring cannot isomerize to an open-chain aldehyde the way a glucose ring can."}, {"label": "C", "text": "The third disaccharide, because fructose is a ketose, and Benedict''s reagent reacts only with sugars built entirely from aldoses."}, {"label": "D", "text": "The third disaccharide, because its linkage ties up the reactive carbon of both monosaccharides, so neither ring can open."}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

(Choice D) is correct: a positive Benedict''s result requires a free anomeric carbon whose cyclic hemiacetal (or, for a ketose, an isomerizable \(\alpha\)-hydroxymethyl ketone) can reversibly open to expose a carbonyl that reduces \(\text{Cu}^{2+}\) to brick-red \(\text{Cu}_2\text{O}\). In the third disaccharide the linkage joins the anomeric carbon of glucose (C1) to the anomeric carbon of fructose (C2). Because both anomeric carbons are committed to the glycosidic bond, each ring is locked as a full acetal and neither can open to a free carbonyl, so the sugar is non-reducing and the tube stays negative.

(Choice A) is incorrect: the first disaccharide links glucose C1 to glucose C4, so only one anomeric carbon (the first glucose''s C1) is tied up. The second glucose retains a free anomeric carbon at C1 that can open to an aldehyde, making this sugar reducing and the tube positive.

(Choice B) is incorrect: a galactose ring, like glucose, retains a free hemiacetal that opens to an aldehyde whenever its anomeric carbon is not in the glycosidic bond. Here the linkage uses galactose C1 but leaves the glucose anomeric carbon free, so this disaccharide is reducing; the claim that galactose cannot form an aldehyde is false.

(Choice C) is incorrect: it identifies the right tube but for the wrong reason. Benedict''s reagent does react with ketoses such as free fructose, which isomerizes to an aldose under basic conditions; the negative result is not because fructose is a ketose but because the C1–C2 linkage occupies both anomeric carbons.

At the Skill 2 level, you must map each described linkage onto whether an anomeric carbon remains free, then reason that only the disaccharide committing both anomeric carbons to the bond can neither open a ring nor reduce \(\text{Cu}^{2+}\).', 'hard', '1D', 'Carbohydrates', 'biochemistry', 2, 100, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'believes any glycosidic bond from an anomeric carbon abolishes reducing behavior for the whole disaccharide' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'wrongly thinks galactose cannot open to an aldehyde, confusing epimer identity with ring-opening ability' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'picks the correct tube but attributes it to fructose being a ketose rather than to both anomeric carbons being bonded' FROM q;

-- Q5 [Disaccharides] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Disaccharides', 'A lab is characterizing maltose, a disaccharide in which two D-glucose units are joined by an α-1,4 glycosidic bond. A researcher notes that when freshly dissolved crystalline maltose is placed in water, the solution''s optical rotation gradually shifts before settling at a stable value, and that maltose gives a positive result with Benedict''s reagent (Cu²⁺ → brick-red Cu₂O). A colleague argues that both observations should instead resemble those of sucrose, which shows a fixed optical rotation and a negative Benedict''s result. Which statement best accounts for maltose''s observed behavior?', '[{"label": "A", "text": "Both anomeric carbons are consumed by the α-1,4 bond, so an open-chain aldehyde forms only under the strongly basic conditions of Benedict''s reagent."}, {"label": "B", "text": "One glucose retains a free anomeric carbon that can open to an aldehyde, permitting both interconversion of anomers and oxidation by Cu²⁺."}, {"label": "C", "text": "The α configuration of the glycosidic bond leaves the ring permanently locked, so the shifting rotation reflects slow hydrolysis rather than ring opening."}, {"label": "D", "text": "The 1,4 linkage places both rings in equilibrium with open-chain forms, so each glucose contributes an aldehyde available for oxidation and anomer interconversion."}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is B because in maltose the α-1,4 bond ties up the anomeric carbon (C1) of only the first glucose; the second glucose keeps its C1 as a free hemiacetal. A hemiacetal reversibly opens to the open-chain aldehyde, and that single equilibrium accounts for both observations at once. The transient open-chain form lets the ring re-close as either the α- or β-anomer, so a freshly dissolved single anomer relaxes toward the equilibrium anomer mixture and the optical rotation drifts to a stable value (mutarotation). The same aldehyde is oxidized by Cu²⁺, reducing it to brick-red Cu₂O, which is the positive Benedict''s result. Sucrose lacks any free anomeric carbon (its Glc(α1,2β)Fru bond joins both anomeric carbons), so it cannot open, cannot mutarotate, and is non-reducing.

(Choice B) is correct: a single free hemiacetal (one free anomeric carbon) is exactly what is needed to open to an aldehyde, and that one feature explains both mutarotation and the positive Benedict''s test.

(Choice A) is incorrect: it wrongly claims both anomeric carbons are used by the α-1,4 bond. A 1,4 linkage only consumes one anomeric carbon (C1 of the first residue) plus the C4-OH of the second; the second residue''s anomeric carbon stays free, so no special basic conditions are required to expose the aldehyde. This choice essentially describes sucrose, not maltose.

(Choice C) is incorrect: the α versus β designation refers to which face the glycosidic oxygen points on the first residue and does not "lock" the second residue''s ring. The shifting rotation comes from ring opening and re-closing at the free anomeric carbon (mutarotation), not from hydrolysis of the disaccharide; hydrolysis is far slower and is not what produces mutarotation.

(Choice D) is incorrect: only the residue whose anomeric carbon is not engaged in the glycosidic bond can open to an aldehyde. The first glucose''s C1 is locked as a full acetal by the α-1,4 bond, so it cannot open; maltose therefore has exactly one reducing end, not two.

Skill 2 is exercised here by requiring you to reason from a described linkage (α-1,4, one anomeric carbon free) to the predicted chemical behavior — mutarotation and reducing activity — and to reject the parallel but incorrect claims that either both or neither anomeric carbon is available.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 2, 90, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'believes a 1,4 glycosidic bond consumes both anomeric carbons (confusing maltose with sucrose''s anomeric-to-anomeric linkage)' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'attributes mutarotation to slow glycosidic hydrolysis rather than to ring opening/closing at the free anomeric carbon, and thinks α-config locks the ring' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'correctly links open-chain aldehyde to reducing/mutarotation behavior but wrongly counts two reducing ends, ignoring that the first residue''s anomeric carbon is a locked acetal' FROM q;

-- Q6 [Disaccharides] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Disaccharides', 'A chemist synthesizes a disaccharide by condensing two D-glucose units: the anomeric carbon (C1) of the first glucose is joined through an oxygen to the C6 hydroxyl of the second glucose. No other glucose hydroxyls participate in the linkage. When this purified disaccharide is added to warm Benedict''s reagent, what is the most likely result, and why?', '[{"label": "A", "text": "No color change occurs, because forming any glycosidic bond consumes the reactive carbon of both sugars."}, {"label": "B", "text": "No color change occurs, because a bond made through an anomeric carbon always locks the molecule into a non-reducing form."}, {"label": "C", "text": "A brick-red precipitate forms, because the second glucose retains a free anomeric carbon that can open to an aldehyde."}, {"label": "D", "text": "A brick-red precipitate forms, because both glucose units contribute an aldehyde group once the rings form."}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is C because a disaccharide is a reducing sugar whenever at least one of its monosaccharides keeps a free anomeric carbon that can revert to the open-chain aldehyde and reduce Cu\(^{2+}\) to a brick-red Cu\(_2\)O precipitate. In the described molecule the glycosidic bond uses the C1 (anomeric) carbon of the first glucose but attaches to the C6 hydroxyl of the second glucose. Because C6 is not an anomeric carbon, the second glucose''s own anomeric C1 is still a hemiacetal, so it can open to an aldehyde and act as a reducing agent, producing the brick-red precipitate.

(Choice A) is incorrect: forming a glycosidic bond ties up only the specific carbon(s) that supply the linking oxygens. Here only one anomeric carbon (the first glucose''s C1) is committed; the second glucose is linked through its non-anomeric C6, so its anomeric carbon is untouched and the sugar remains reducing.

(Choice B) is incorrect: whether an anomeric-carbon linkage abolishes reducing character depends on whether the partner carbon is also anomeric. A sugar becomes non-reducing only when the bond joins two anomeric carbons (as in sucrose, Glc(α1,2β)Fru), locking both into full acetals. A C1-to-C6 linkage leaves one anomeric carbon free.

(Choice C) is correct: only one anomeric carbon (the first glucose''s C1) is engaged in the acetal linkage; the second glucose is joined through C6, so its C1 remains a hemiacetal that can open to a free aldehyde and reduce Cu\(^{2+}\), giving the brick-red Cu\(_2\)O.

(Choice D) is incorrect: a brick-red precipitate does form, but not for this reason. Benedict''s reagent oxidizes a single free anomeric (potential aldehyde) carbon; the first glucose''s C1 is locked in an acetal and cannot open, so only one sugar, not both, supplies the reactive aldehyde.

This item is Skill 2 (Reasoning) because you cannot read the answer off a memorized name; you must apply the rule that reducing character requires at least one free anomeric carbon to a described, unnamed linkage and infer the Benedict''s outcome from which carbons the bond ties up.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 2, 75, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'believes any glycosidic bond consumes both anomeric carbons' FROM q
  UNION ALL
  SELECT id, 'B', 'partial_truth', 'overgeneralizes that an anomeric-carbon linkage is always non-reducing, ignoring the partner carbon' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'assumes both ring carbons yield aldehydes, missing that the linked anomeric carbon is locked as an acetal' FROM q;

-- Q7 [Polysaccharides] medium skill2 ans=D [FIG]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Polysaccharides', 'The schematic shown depicts the topology of an animal glucose-storage polysaccharide, with each hexagon representing a glucose residue. When this molecule is mobilized, a phosphorylase enzyme releases glucose residues only from the outermost termini of each chain, working inward one residue at a time. Based on the arrangement of chains in the schematic, which structural feature best explains why this polymer can supply glucose to the cell more rapidly than a single long, unbranched chain of the same total mass?', '[{"label": "A", "text": "The extra glycosidic linkages between residues store additional chemical energy that is released faster during cleavage."}, {"label": "B", "text": "The compact shape packs the residues so tightly that the enzyme diffuses through the interior more quickly."}, {"label": "C", "text": "The interior junction residues are directly exposed to the enzyme, letting cleavage begin from the center of the molecule outward."}, {"label": "D", "text": "The topology creates numerous simultaneously accessible chain termini, so many phosphorylase molecules can release glucose in parallel."}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is D because the schematic shows a polymer whose chains split repeatedly, producing many separate outer chain endings rather than the two endings of a single linear chain. Because phosphorylase acts only at these outer termini, a molecule with this topology offers many attack points at once. Many enzyme molecules can therefore work in parallel, and glucose is liberated from all of those endings simultaneously, giving rapid mobilization. This matches the reasoning that the storage polymer is cleaved one residue at a time from all the branches (at the nonreducing ends), producing a large amount of free glucose quickly.

(Choice A) is incorrect: the number of glycosidic bonds tracks with total mass, not with topology, and a bond of a given type carries the same modest linkage energy regardless of how the chain is arranged; branching does not add stored chemical energy, and cleavage rate is set by the number of available termini, not by "extra" energy in the bonds.

(Choice B) is incorrect: phosphorylase does not diffuse through the packed interior to act; it works from the outer termini of the chains. Compactness contributes to keeping the polymer as one osmotically inexpensive molecule, but it is not the reason glucose is released quickly, and tighter packing would if anything hinder, not speed, interior access.

(Choice D) is correct: the repeatedly splitting chains generate a large number of outer chain endings, and since the enzyme releases residues only from those endings, many can be processed at the same time, producing free glucose rapidly.

(Choice C) is incorrect: the junction residues where chains split are internal and are not the sites of terminal cleavage; phosphorylase removes residues from the outer endings inward, not from the interior junctions outward, so cleavage cannot begin at the center.

Skill 2 note: rather than recalling a fact, you had to read the branching pattern from the schematic and connect that topology to the enzyme''s mode of action (terminal-only cleavage) to deduce the functional consequence — more simultaneous release sites means faster glucose supply.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 2, 90, '<svg style="max-width:380px;margin-inline:auto" viewBox="0 0 360 210" xmlns="http://www.w3.org/2000/svg" fill="none" stroke="#1a1a1a" stroke-width="1.6" stroke-linecap="round" font-family="''Helvetica Neue'',Arial,sans-serif"><line x1="60" y1="125" x2="102" y2="125"/><line x1="102" y1="125" x2="144" y2="125"/><line x1="144" y1="125" x2="186" y2="125"/><line x1="186" y1="125" x2="228" y2="125"/><line x1="228" y1="125" x2="270" y2="125"/><line x1="106" y1="92" x2="120" y2="62"/><line x1="190" y1="92" x2="204" y2="62"/><line x1="204" y1="62" x2="226" y2="40"/><line x1="148" y1="158" x2="162" y2="186"/><line x1="232" y1="92" x2="248" y2="66"/><line x1="102" y1="125" x2="106" y2="92"/><line x1="186" y1="125" x2="190" y2="92"/><line x1="144" y1="125" x2="148" y2="158"/><line x1="228" y1="125" x2="232" y2="92"/><line x1="204" y1="62" x2="226" y2="40"/><polygon points="71.0,125.0 65.5,134.5 54.5,134.5 49.0,125.0 54.5,115.5 65.5,115.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="113.0,125.0 107.5,134.5 96.5,134.5 91.0,125.0 96.5,115.5 107.5,115.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="155.0,125.0 149.5,134.5 138.5,134.5 133.0,125.0 138.5,115.5 149.5,115.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="197.0,125.0 191.5,134.5 180.5,134.5 175.0,125.0 180.5,115.5 191.5,115.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="239.0,125.0 233.5,134.5 222.5,134.5 217.0,125.0 222.5,115.5 233.5,115.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="281.0,125.0 275.5,134.5 264.5,134.5 259.0,125.0 264.5,115.5 275.5,115.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="117.0,92.0 111.5,101.5 100.5,101.5 95.0,92.0 100.5,82.5 111.5,82.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="131.0,62.0 125.5,71.5 114.5,71.5 109.0,62.0 114.5,52.5 125.5,52.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="201.0,92.0 195.5,101.5 184.5,101.5 179.0,92.0 184.5,82.5 195.5,82.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="215.0,62.0 209.5,71.5 198.5,71.5 193.0,62.0 198.5,52.5 209.5,52.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="237.0,40.0 231.5,49.5 220.5,49.5 215.0,40.0 220.5,30.5 231.5,30.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="159.0,158.0 153.5,167.5 142.5,167.5 137.0,158.0 142.5,148.5 153.5,148.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="173.0,186.0 167.5,195.5 156.5,195.5 151.0,186.0 156.5,176.5 167.5,176.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="243.0,92.0 237.5,101.5 226.5,101.5 221.0,92.0 226.5,82.5 237.5,82.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="259.0,66.0 253.5,75.5 242.5,75.5 237.0,66.0 242.5,56.5 253.5,56.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/></svg>')
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'conflating bond count/branching with stored energy' FROM q
  UNION ALL
  SELECT id, 'B', 'partial_truth', 'compactness is real but wrong mechanism for speed' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'cleavage direction reversed (interior-out vs terminal-in)' FROM q;

-- Q8 [Polysaccharides] hard skill2 ans=A [FIG]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Polysaccharides', 'The schematic shown above depicts two glucose polymers, structures A and B, in which each hexagon bead represents a glucose residue joined into a main chain with branches. A cell mobilizes stored glucose using an exo-acting enzyme that removes one residue at a time only from a chain terminus that lies away from the polymer''s single anchored end, and multiple copies of this enzyme can work on one molecule at the same time. Based on the branching topology in the schematic, which structure offers more terminal sites for simultaneous enzymatic attack, and what functional consequence does this have?', '[{"label": "A", "text": "Structure B, because its architecture provides a greater number of these accessible chain termini, allowing glucose to be released more rapidly."}, {"label": "B", "text": "Structure B, because its architecture provides a greater number of the polymer''s anchored reducing ends, allowing glucose to be released more rapidly."}, {"label": "C", "text": "Structure A, because its architecture provides a greater number of these accessible chain termini, allowing glucose to be released more rapidly."}, {"label": "D", "text": "Structure B, because its architecture provides a greater number of these accessible chain termini, but this instead slows the overall rate at which glucose is released."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is A because a glucose polymer has exactly one reducing end (the single anchored terminus) but one non-reducing end for every chain tip, so each additional branch point creates one additional non-reducing end. The exo-acting enzyme described removes residues one at a time only from these non-reducing termini, and because several copies act on one molecule simultaneously, the rate of glucose release scales with the number of non-reducing ends. In the schematic, structure B carries more branch points than structure A, so B presents more non-reducing ends for simultaneous attack and therefore releases glucose faster. This mirrors the textbook point that a densely branched storage polymer is "cleaved one residue at a time from all the branches (at the nonreducing ends)... producing a large amount of free glucose quickly."

(Choice C) is incorrect: it reverses the topology read from the figure. Structure A is the less-branched of the two, so it has fewer chain termini, not more; the functional claim is right but it is attached to the wrong structure.

(Choice B) is incorrect: it identifies structure B correctly but mislabels the extra termini as reducing ends. Branching multiplies non-reducing ends only; any glucose polymer, no matter how branched, still has just one reducing end (the anchored end), so extra branches cannot add reducing ends. The stem also specifies that the enzyme acts away from the anchored end, so "anchored reducing ends" is the wrong site entirely.

(Choice A) is correct: structure B is the more densely branched polymer in the schematic, so it presents the greater number of non-reducing chain termini, and because copies of the exo-acting enzyme work on those termini at the same time, glucose is liberated more rapidly.

(Choice D) is incorrect: it correctly picks structure B and correctly notes more termini, but it inverts the functional consequence. More simultaneous attack sites speed release rather than slow it; this is precisely why animals store glucose as a highly branched polymer for rapid mobilization.

At the Skill 2 level, the task is not to recall a definition but to read branching density directly from the figure, translate branch points into a count of non-reducing termini, and connect that count to the rate of an exo-acting degradative enzyme—applying the structure–function relationship rather than restating it.', 'hard', '1D', 'Carbohydrates', 'biochemistry', 2, 95, '<svg viewBox="0 0 776 246" xmlns="http://www.w3.org/2000/svg" font-family="''Helvetica Neue'',Arial,sans-serif"><svg x="0" y="30" width="360" height="150" style="width:360px;height:150px" viewBox="0 0 360 150" xmlns="http://www.w3.org/2000/svg" fill="none" stroke="#1a1a1a" stroke-width="1.6" stroke-linecap="round" font-family="''Helvetica Neue'',Arial,sans-serif"><line x1="40" y1="118" x2="80" y2="118"/><line x1="80" y1="118" x2="120" y2="118"/><line x1="120" y1="118" x2="160" y2="118"/><line x1="160" y1="118" x2="200" y2="118"/><line x1="200" y1="118" x2="240" y2="118"/><line x1="240" y1="118" x2="280" y2="118"/><line x1="280" y1="118" x2="320" y2="118"/><line x1="126" y1="84" x2="144" y2="54"/><line x1="246" y1="84" x2="264" y2="54"/><line x1="120" y1="118" x2="126" y2="84"/><line x1="240" y1="118" x2="246" y2="84"/><polygon points="51.0,118.0 45.5,127.5 34.5,127.5 29.0,118.0 34.5,108.5 45.5,108.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="91.0,118.0 85.5,127.5 74.5,127.5 69.0,118.0 74.5,108.5 85.5,108.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="131.0,118.0 125.5,127.5 114.5,127.5 109.0,118.0 114.5,108.5 125.5,108.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="171.0,118.0 165.5,127.5 154.5,127.5 149.0,118.0 154.5,108.5 165.5,108.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="211.0,118.0 205.5,127.5 194.5,127.5 189.0,118.0 194.5,108.5 205.5,108.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="251.0,118.0 245.5,127.5 234.5,127.5 229.0,118.0 234.5,108.5 245.5,108.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="291.0,118.0 285.5,127.5 274.5,127.5 269.0,118.0 274.5,108.5 285.5,108.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="331.0,118.0 325.5,127.5 314.5,127.5 309.0,118.0 314.5,108.5 325.5,108.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="137.0,84.0 131.5,93.5 120.5,93.5 115.0,84.0 120.5,74.5 131.5,74.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="155.0,54.0 149.5,63.5 138.5,63.5 133.0,54.0 138.5,44.5 149.5,44.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="257.0,84.0 251.5,93.5 240.5,93.5 235.0,84.0 240.5,74.5 251.5,74.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="275.0,54.0 269.5,63.5 258.5,63.5 253.0,54.0 258.5,44.5 269.5,44.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/></svg><svg x="416" y="0" width="360" height="210" style="width:360px;height:210px" viewBox="0 0 360 210" xmlns="http://www.w3.org/2000/svg" fill="none" stroke="#1a1a1a" stroke-width="1.6" stroke-linecap="round" font-family="''Helvetica Neue'',Arial,sans-serif"><line x1="60" y1="125" x2="102" y2="125"/><line x1="102" y1="125" x2="144" y2="125"/><line x1="144" y1="125" x2="186" y2="125"/><line x1="186" y1="125" x2="228" y2="125"/><line x1="228" y1="125" x2="270" y2="125"/><line x1="106" y1="92" x2="120" y2="62"/><line x1="190" y1="92" x2="204" y2="62"/><line x1="204" y1="62" x2="226" y2="40"/><line x1="148" y1="158" x2="162" y2="186"/><line x1="232" y1="92" x2="248" y2="66"/><line x1="102" y1="125" x2="106" y2="92"/><line x1="186" y1="125" x2="190" y2="92"/><line x1="144" y1="125" x2="148" y2="158"/><line x1="228" y1="125" x2="232" y2="92"/><line x1="204" y1="62" x2="226" y2="40"/><polygon points="71.0,125.0 65.5,134.5 54.5,134.5 49.0,125.0 54.5,115.5 65.5,115.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="113.0,125.0 107.5,134.5 96.5,134.5 91.0,125.0 96.5,115.5 107.5,115.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="155.0,125.0 149.5,134.5 138.5,134.5 133.0,125.0 138.5,115.5 149.5,115.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="197.0,125.0 191.5,134.5 180.5,134.5 175.0,125.0 180.5,115.5 191.5,115.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="239.0,125.0 233.5,134.5 222.5,134.5 217.0,125.0 222.5,115.5 233.5,115.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="281.0,125.0 275.5,134.5 264.5,134.5 259.0,125.0 264.5,115.5 275.5,115.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="117.0,92.0 111.5,101.5 100.5,101.5 95.0,92.0 100.5,82.5 111.5,82.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="131.0,62.0 125.5,71.5 114.5,71.5 109.0,62.0 114.5,52.5 125.5,52.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="201.0,92.0 195.5,101.5 184.5,101.5 179.0,92.0 184.5,82.5 195.5,82.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="215.0,62.0 209.5,71.5 198.5,71.5 193.0,62.0 198.5,52.5 209.5,52.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="237.0,40.0 231.5,49.5 220.5,49.5 215.0,40.0 220.5,30.5 231.5,30.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="159.0,158.0 153.5,167.5 142.5,167.5 137.0,158.0 142.5,148.5 153.5,148.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="173.0,186.0 167.5,195.5 156.5,195.5 151.0,186.0 156.5,176.5 167.5,176.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="243.0,92.0 237.5,101.5 226.5,101.5 221.0,92.0 226.5,82.5 237.5,82.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="259.0,66.0 253.5,75.5 242.5,75.5 237.0,66.0 242.5,56.5 253.5,56.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/></svg><text x="180" y="234" text-anchor="middle" font-size="16" font-weight="700" fill="#1a1a1a" font-family="''Helvetica Neue'',Arial,sans-serif">A</text><text x="596" y="234" text-anchor="middle" font-size="16" font-weight="700" fill="#1a1a1a" font-family="''Helvetica Neue'',Arial,sans-serif">B</text></svg>')
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'C', 'reversed_relationship', 'misreads the figure by assigning the correct functional advantage to the less-branched structure' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'confuses added branch termini with reducing ends, ignoring that a polymer has only one reducing end' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'identifies the correct structure and termini but inverts the rate consequence of more simultaneous attack sites' FROM q;

-- Q9 [Polysaccharides] medium skill2 ans=C [FIG]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Polysaccharides', 'A cell biologist isolates the glucose polymer whose backbone topology is depicted in the schematic shown, where each hexagon bead represents one glucose residue. This polymer is then exposed to an exoglycosidase that mobilizes glucose by removing one residue at a time from a chain terminus that bears a free anomeric-carbon-adjacent hydroxyl available for attack (a "non-reducing end"). Based on the topology in the schematic, how many such termini does the enzyme have available, and how would this polymer''s rate of glucose mobilization compare with that of a glycogen fragment containing the same total number of glucose residues?', '[{"label": "A", "text": "Many non-reducing ends; glucose is mobilized faster than from the glycogen fragment"}, {"label": "B", "text": "1 non-reducing end; glucose is mobilized faster than from the glycogen fragment"}, {"label": "C", "text": "1 non-reducing end; glucose is mobilized more slowly than from the glycogen fragment"}, {"label": "D", "text": "Many non-reducing ends; glucose is mobilized more slowly than from the glycogen fragment"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is C because the schematic depicts a single continuous chain of glucose beads with no points where a second chain emerges from a residue. A glucose polymer has exactly one reducing end (the terminus whose anomeric carbon is free) and one non-reducing end for each chain terminus that is not the reducing end. A chain with no branch points therefore terminates in only two ends total—one reducing, one non-reducing—so it presents a single non-reducing end to the exoglycosidase. Because degradative enzymes such as glycogen phosphorylase liberate glucose one residue at a time, working inward from each non-reducing end, the number of non-reducing ends sets how many places the enzyme can act simultaneously. A glycogen fragment of the same size carries many branch points, and each branch adds another non-reducing terminus; with many ends available at once, glucose is released rapidly. The polymer in the schematic, with only one such terminus, is degraded from one point only and mobilizes glucose more slowly.

(Choice A) is incorrect: it inverts the topology read from the schematic. "Many non-reducing ends" describes a branched molecule like glycogen, but the schematic shows no branch points, so this end count does not match the structure, and the faster rate that would follow from it does not apply.

(Choice B) is incorrect: it correctly counts one non-reducing end but pairs it with the wrong rate. A single point of enzyme attack cannot release glucose faster than a molecule offering many simultaneous points; one end predicts slower, not faster, mobilization.

(Choice C) is correct: the schematic shows one continuous unbranched chain, which has a single non-reducing end, and a single point of exoglycosidic attack means glucose is freed more slowly than from an equally sized glycogen fragment whose many branches expose many non-reducing ends at once.

(Choice D) is incorrect: it lands on the correct slower rate but by faulty reasoning, assigning "many non-reducing ends" to a structure the schematic shows to be unbranched. Many ends would predict faster, not slower, release, so the end count and the rate are internally inconsistent.

At the Skill 2 level, answering requires reading the branching topology directly from the schematic—counting chain termini rather than recalling a definition—and then reasoning from that structural feature to a functional consequence: fewer non-reducing ends means fewer simultaneous sites of enzymatic glucose release, hence a slower mobilization rate.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 2, 90, '<svg style="max-width:380px;margin-inline:auto" viewBox="0 0 320 120" xmlns="http://www.w3.org/2000/svg" fill="none" stroke="#1a1a1a" stroke-width="1.6" stroke-linecap="round" font-family="''Helvetica Neue'',Arial,sans-serif"><line x1="42" y1="60" x2="80" y2="60"/><line x1="80" y1="60" x2="118" y2="60"/><line x1="118" y1="60" x2="156" y2="60"/><line x1="156" y1="60" x2="194" y2="60"/><line x1="194" y1="60" x2="232" y2="60"/><line x1="232" y1="60" x2="270" y2="60"/><polygon points="53.0,60.0 47.5,69.5 36.5,69.5 31.0,60.0 36.5,50.5 47.5,50.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="91.0,60.0 85.5,69.5 74.5,69.5 69.0,60.0 74.5,50.5 85.5,50.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="129.0,60.0 123.5,69.5 112.5,69.5 107.0,60.0 112.5,50.5 123.5,50.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="167.0,60.0 161.5,69.5 150.5,69.5 145.0,60.0 150.5,50.5 161.5,50.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="205.0,60.0 199.5,69.5 188.5,69.5 183.0,60.0 188.5,50.5 199.5,50.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="243.0,60.0 237.5,69.5 226.5,69.5 221.0,60.0 226.5,50.5 237.5,50.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="281.0,60.0 275.5,69.5 264.5,69.5 259.0,60.0 264.5,50.5 275.5,50.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/></svg>')
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'misreads the figure as branched and infers the branched-polymer consequence' FROM q
  UNION ALL
  SELECT id, 'B', 'partial_truth', 'correct end count paired with the wrong rate direction' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'right rate reached through an end count that contradicts the figure' FROM q;

-- Q10 [Polysaccharides] easy skill1 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Polysaccharides', 'Glycogen is the branched polymer that mammals use to store fuel in liver and muscle; complete acid hydrolysis of a purified glycogen sample yields glucose as the only monosaccharide detected. Based on this composition, glycogen is best classified as which type of carbohydrate?', '[{"label": "A", "text": "A heteropolysaccharide"}, {"label": "B", "text": "A glycosaminoglycan"}, {"label": "C", "text": "An oligosaccharide"}, {"label": "D", "text": "A homopolysaccharide"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is D because polysaccharides are grouped by how many kinds of monosaccharide they contain, not by whether they are branched. Since complete hydrolysis of glycogen releases glucose as the only monosaccharide, glycogen is assembled from a single type of monomer and is therefore a homopolysaccharide (like starch, cellulose, and chitin).

(Choice A) is incorrect: a heteropolysaccharide is built from more than one kind of monomer (e.g., the repeating GlcNAc–uronic-acid disaccharides of glycosaminoglycans). Glycogen''s branching makes it structurally elaborate, but branching does not add a second monomer type—every residue is still glucose, so it is not a heteropolysaccharide.

(Choice B) is incorrect: glycosaminoglycans (e.g., hyaluronate, chondroitin sulfate) are heteropolysaccharides with a repeating disaccharide that includes an amino sugar, and they are structural/extracellular molecules rather than fuel stores. Glycogen contains only glucose and is not a GAG.

(Choice D) is correct: a polymer made from a single kind of monosaccharide is a homopolysaccharide, and glycogen releasing only glucose fits that definition exactly.

(Choice C) is incorrect: "oligosaccharide" describes chain length (a short chain of only a few sugars, as in \(N\)-linked glycans), not monomer diversity. Glycogen is a very large, many-thousand-residue polysaccharide, so this length-based category does not apply.

This is a Skill 1 (Knowledge of Scientific Concepts) item: it asks you to apply the definition of a homopolysaccharide to a polymer described by its monomer composition.', 'easy', '1D', 'Carbohydrates', 'biochemistry', 1, 60, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'confuses structural complexity (branching) with monomer diversity, choosing the opposite classification' FROM q
  UNION ALL
  SELECT id, 'B', 'adjacent_fact', 'names a real polysaccharide class but one that is actually a heteropolysaccharide, not glycogen''s category' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'conflates the chain-length category (oligosaccharide) with the monomer-diversity classification being asked' FROM q;

-- Q11 [Polysaccharides] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Polysaccharides', 'A biochemist compares two synthetic glucose polymers of identical total molecular mass. Polymer X is a long, largely unbranched chain (like amylose), whereas Polymer Y contains frequent α-1,6-linked branch points along its backbone (like glycogen). When each polymer is incubated with a phosphorylase that sequentially removes glucose units from chain termini, Polymer Y releases free glucose far more rapidly than Polymer X. Which structural consequence of the added branch points best accounts for this faster mobilization?', '[{"label": "A", "text": "The branch points multiply the number of exposed non-reducing termini, giving the enzyme many more sites to act on simultaneously"}, {"label": "B", "text": "The branch points convert the α-1,4 backbone links into α-1,6 links, which are hydrolyzed more readily by the phosphorylase"}, {"label": "C", "text": "The branch points shorten each individual chain segment, lowering the activation energy the phosphorylase must overcome per cleavage"}, {"label": "D", "text": "The branch points increase the polymer''s average molecular mass, storing more glucose per molecule for the enzyme to release"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is A because a phosphorylase (like glycogen phosphorylase) works inward from a chain''s non-reducing end, so the rate at which glucose can be released depends on how many such ends are available at once. Every α-1,6 branch point creates an additional chain that terminates in its own non-reducing end. A highly branched polymer therefore presents many termini that the enzyme can attack in parallel, whereas a long unbranched chain offers essentially one productive terminus. Branching also keeps the molecule more soluble and hydrated, but the dominant reason mobilization speeds up is the multiplication of simultaneous cleavage sites. (Choice A) is correct: it identifies the greater number of accessible non-reducing termini as the structural feature that lets many cleavage reactions proceed at the same time.

(Choice C) is incorrect: activation energy for the glycosidic-cleavage step is a property of the transition state at the acetal linkage and is set by the enzyme''s catalytic chemistry, not by how long the surrounding chain happens to be; shortening a segment does not change the per-bond energy barrier.

(Choice B) is incorrect: added branch points do not convert backbone α-1,4 linkages into α-1,6 linkages. The α-1,6 bonds appear only at the branch junctions, and a phosphorylase that clips the α-1,4-linked residues actually stalls near an α-1,6 branch (a separate debranching activity is needed there), so this reverses the real relationship.

(Choice D) is incorrect: the two polymers are stipulated to have identical total mass, so branching does not add stored glucose. Even setting that aside, greater mass per molecule would not by itself accelerate the release rate; total substrate amount and rate of release are distinct quantities.

Answering requires reasoning from the described scenario to the mechanistic consequence of structure: recognizing that terminal-acting degradation makes the count of accessible non-reducing ends—not bond energetics or total mass—the rate-limiting variable when branching increases.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 2, 90, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'C', 'misconception', 'conflates chain geometry with enzymatic activation energy' FROM q
  UNION ALL
  SELECT id, 'B', 'reversed_relationship', 'assumes branch linkages are cleaved faster when they actually stall phosphorylase' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'confuses total stored substrate with rate of release' FROM q;

-- Q12 [Cellulose] easy skill1 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Cellulose', 'Cellulose is the most abundant structural polysaccharide in the plant kingdom, forming the tough fibrous scaffold that reinforces plant cell walls. A student is asked to specify the repeating monomer and the exact glycosidic linkage that connect the sugar units along a single cellulose chain. Which description correctly characterizes the backbone of cellulose?', '[{"label": "A", "text": "Glucose units connected by α-1,4 glycosidic bonds"}, {"label": "B", "text": "Glucose units connected by β-1,4 glycosidic bonds"}, {"label": "C", "text": "Glucose units connected by α-1,6 glycosidic bonds"}, {"label": "D", "text": "N-acetylglucosamine units connected by β-1,4 glycosidic bonds"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is B because cellulose is a homopolysaccharide in which \(D\)-glucose residues are joined by \(\beta\text{-1,4}\) glycosidic bonds. The \(\beta\) configuration at the anomeric carbon flips every other glucose unit \(180^\circ\), producing long, straight, unbranched chains that pack side by side through extensive hydrogen bonding into rigid microfibrils — the structural basis of the plant cell wall.

(Choice A) is incorrect: \(\alpha\text{-1,4}\) linkages between glucose units are the hallmark of the storage polysaccharides starch (amylose) and glycogen, not cellulose. The \(\alpha\) linkage curls the chain into a helix suited for energy storage rather than the extended fibers cellulose forms.

(Choice C) is incorrect: \(\alpha\text{-1,6}\) linkages are the branch points found in glycogen and amylopectin, where a side chain attaches to a main \(\alpha\text{-1,4}\) chain; they do not form the linear backbone of any glucose homopolymer, and cellulose is unbranched.

(Choice B) is correct: \(\beta\text{-1,4}\)-linked glucose gives the straight, hydrogen-bonded fibers that make cellulose the main structural component of plant cell walls.

(Choice D) is incorrect: a \(\beta\text{-1,4}\)-linked polymer describes chitin, whose repeating unit is \(N\)-acetylglucosamine rather than glucose; chitin is the structural material of arthropod exoskeletons and fungal walls, not cellulose.

This question asks you to recall a single defined fact — the monomer and glycosidic linkage of cellulose — placing it at the knowledge-retrieval (Skill 1) level.', 'easy', '1D', 'Carbohydrates', 'biochemistry', 1, 45, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'confuses cellulose with starch/glycogen storage linkage' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'mistakes branch-point linkage for backbone linkage' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'swaps cellulose monomer for chitin''s while keeping the shared β-1,4 linkage' FROM q;

-- Q13 [Cellulose] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Cellulose', 'A nutrition researcher notes that starch and cellulose are both glucose homopolymers, yet a person who eats an equal mass of each absorbs a large amount of glucose from the starch while the cellulose is excreted in the feces essentially intact. The glucose monomers released from either polymer would be handled identically by the intestinal cells. Which explanation best accounts for why the cellulose yields no absorbable glucose?', '[{"label": "A", "text": "Cellulose chains pack into hydrogen-bonded fibers that make the polymer physically too large for any intestinal transporter to take up."}, {"label": "B", "text": "The glucose units in cellulose are a different stereoisomer of glucose than those in starch, so human cells cannot metabolize them."}, {"label": "C", "text": "Cellulose lacks a free anomeric carbon at its ends, so digestive enzymes have no reducing terminus to begin hydrolysis."}, {"label": "D", "text": "Human digestive enzymes hydrolyze the α glycosidic bonds of starch but cannot cleave the β 1,4 bonds joining glucose units in cellulose."}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

(Choice D) is correct: starch and cellulose are both polymers of the same glucose monomer, differing in the configuration of the glycosidic bond that joins the residues along the backbone: starch uses \(\alpha\)-1,4 linkages, whereas cellulose uses \(\beta\)-1,4 linkages. Glycosidic hydrolases are stereospecific for the bond they cleave. Human \(\alpha\)-amylase and the brush-border \(\alpha\)-glucosidases recognize and hydrolyze \(\alpha\) linkages, releasing glucose that is absorbed; humans produce no enzyme (cellulase) that can hydrolyze the \(\beta\)-1,4 bond, so cellulose passes through the gut intact as fiber. Because the stem tells you the freed monomers would be handled identically, the difference must lie in the bond that must be broken to free them, not in the sugar itself.

(Choice A) is incorrect: although cellulose does form extensively hydrogen-bonded fibers, size is not why no glucose is absorbed. Starch is likewise a large polymer that cannot be transported whole; both must first be hydrolyzed to monosaccharides. The barrier is the failure to cleave the polymer, not the transport of an intact chain.

(Choice B) is incorrect: the residues in cellulose and starch are the same enantiomer, D-glucose. The \(\alpha\)/\(\beta\) designation refers to the anomeric configuration at the glycosidic bond, not to a different stereoisomer of glucose; once liberated, cellulose-derived glucose is ordinary D-glucose that human cells readily metabolize, which is exactly why ruminant symbionts extract usable energy from it.

(Choice C) is incorrect: cellulose does possess a free reducing (anomeric) end, and in any case glycoside hydrolases cleave internal glycosidic bonds along the chain rather than requiring a reducing terminus to initiate; a missing reducing end is not what blocks digestion.

Skill 2 is exercised here by requiring you to reason from the shared monomer and identical downstream handling to isolate the glycosidic-bond configuration as the single variable that determines whether human enzymes can digest the polymer.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 2, 90, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'size/physical-barrier confusion — attributes indigestibility to the polymer being too large to absorb rather than to the uncleavable bond' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'anomeric-vs-enantiomer confusion — mistakes the α/β glycosidic configuration for a different stereoisomer of the glucose monomer' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'reducing-end/mechanism confusion — invents a missing anomeric terminus as the block, misrepresenting how glycoside hydrolases act' FROM q;

-- Q14 [Cellulose] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Cellulose', 'A biochemist synthesizes two unbranched glucose homopolymers that differ in only one respect: in Polymer I every glucose is joined to the next by a β-1,4 glycosidic bond, while in Polymer II every glucose is joined by an α-1,4 glycosidic bond. In water, Polymer I aggregates into rigid, water-insoluble bundles, whereas Polymer II disperses readily and is cleaved by salivary amylase. Which single molecular consequence of the anomeric configuration at the glycosidic bond best accounts for Polymer I forming rigid fibers rather than dispersing like Polymer II?', '[{"label": "A", "text": "In Polymer I each successive residue is inverted ~180° relative to its neighbor, producing an extended, straight chain whose hydroxyls hydrogen-bond to adjacent parallel chains."}, {"label": "B", "text": "The β configuration makes each glycosidic oxygen more electronegative, so Polymer I acquires a net negative charge that cross-links neighboring chains through ionic electrostatic bridges."}, {"label": "C", "text": "The β-1,4 bond forces Polymer I into a tightly coiled helix whose interior excludes water, and stacking of these helices produces the insoluble fiber."}, {"label": "D", "text": "Only the β linkage permits α-1,6 branch points, and the resulting dense branching sterically prevents Polymer I from dissolving."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is A because the anomeric configuration dictates the geometry that successive glucose units must adopt. With a β-1,4 linkage, the glycosidic oxygen points "up" (equatorial), and to satisfy the bond geometry each glucose ring must be flipped roughly 180° relative to its neighbor. This alternating inversion produces the most extended, ribbon-straight conformation a glucose polymer can adopt. Straight, unbent chains can lie side by side so that their hydroxyl groups form an extensive network of inter-chain (and intra-chain) hydrogen bonds, packing many parallel chains into rigid, water-insoluble microfibrils—the structural basis of cellulose. An α-1,4 linkage (glycosidic O pointing "down," axial) leaves successive residues in the same orientation, forcing the chain to curve and coil into a helix that cannot pack into fibers and instead disperses and is accessible to \(\alpha\)-amylase, as in starch.

(Choice A) is correct: the ~180° flip of alternating residues is exactly what the β geometry imposes, and the resulting extended chain enables the inter-chain hydrogen bonding that builds insoluble fibers.

(Choice B) is incorrect: neither the α nor the β glycosidic oxygen bears a charge; both linkages are neutral acetals. Cellulose fibers are held together by hydrogen bonds and hydrophobic contacts between neutral chains, not by electrostatic bridges, and the β configuration does not confer a net negative charge.

(Choice C) is incorrect: it inverts the actual geometry. The coiled/helical conformation belongs to the α-1,4 polymer (starch/amylose); the β-1,4 polymer is the extended, straight one. A helix is precisely the shape that prevents tight fiber packing, so attributing rigid insoluble fibers to a helix is backward.

(Choice D) is incorrect: branching is a separate structural feature and is not required for insolubility. Cellulose is unbranched, and α-1,6 branch points are found in the α-linked polymers (glycogen and amylopectin), not in the β-linked polymer. Branching actually increases solubility and enzyme accessibility rather than causing the observed insolubility.

At the Skill 2 level, the item requires reasoning from the anomeric configuration to its geometric consequence (extended vs. coiled chain) and then to the emergent bulk property (rigid insoluble fiber vs. dispersible digestible polymer), rather than recalling a stated definition of cellulose.', 'hard', '1D', 'Carbohydrates', 'biochemistry', 2, 105, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'attributes insolubility to charge/electrostatics rather than hydrogen bonding between neutral chains' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'swaps the conformations, assigning the helical coil to the β-linked polymer instead of the α-linked one' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'imports α-1,6 branching (a real feature of glycogen/amylopectin) and misapplies it as the cause of cellulose insolubility' FROM q;

-- Q15 [Starch] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Starch', 'A researcher incubates purified amylose and purified amylopectin in separate tubes, each with an enzyme that hydrolyzes only α-1,6 glycosidic bonds and has no activity toward α-1,4 bonds. After incubation, the number of reducing ends is measured in each tube. Which outcome is expected, and why?', '[{"label": "A", "text": "New reducing ends appear only in the amylose tube, because a single unbranched chain presents the enzyme with more accessible bonds to cleave."}, {"label": "B", "text": "New reducing ends appear only in the amylopectin tube, because that polymer contains the linkage the enzyme cleaves while amylose does not."}, {"label": "C", "text": "New reducing ends appear in both tubes, because α-1,6 bonds join the glucose units along the main chain of each polymer."}, {"label": "D", "text": "New reducing ends appear in neither tube, because both polymers are built entirely from α-1,4 bonds that this enzyme cannot hydrolyze."}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is B because the two components of starch differ specifically in their glycosidic linkages: amylose is a linear polymer joined exclusively by \(\alpha\text{-}1,4\) bonds, whereas amylopectin has an \(\alpha\text{-}1,4\) backbone punctuated by \(\alpha\text{-}1,6\) branch points. An enzyme that hydrolyzes only \(\alpha\text{-}1,6\) bonds therefore has a substrate to cleave in amylopectin (each branch point), and cleaving a branch point liberates a new chain terminus, generating additional reducing ends. Amylose contains no \(\alpha\text{-}1,6\) bonds, so the enzyme leaves it intact and no new reducing ends form there.

(Choice B) is correct: only amylopectin carries \(\alpha\text{-}1,6\) branch points, so it is the only substrate for an \(\alpha\text{-}1,6\)-specific enzyme, and hydrolyzing those branches creates new reducing ends.

(Choice A) is incorrect: it reverses the relationship. Amylose is the unbranched chain and contains no \(\alpha\text{-}1,6\) bonds at all, so an \(\alpha\text{-}1,6\)-specific enzyme has nothing to cleave in it regardless of how accessible its \(\alpha\text{-}1,4\) bonds are.

(Choice C) is incorrect: it misplaces the \(\alpha\text{-}1,6\) linkage. In both polymers the main-chain glucose units are joined by \(\alpha\text{-}1,4\) bonds; the \(\alpha\text{-}1,6\) linkage occurs only at amylopectin''s branch points, not along either backbone, so amylose would not be cleaved.

(Choice D) is incorrect: while amylose is indeed all \(\alpha\text{-}1,4\), amylopectin is not built entirely from \(\alpha\text{-}1,4\) bonds. Its \(\alpha\text{-}1,6\) branch points are exactly the bonds this enzyme can hydrolyze, so at least one tube does show new reducing ends.

To reach the answer you had to apply the structural distinction between the two starch components to a described enzymatic scenario, predicting which polymer serves as a substrate rather than recalling a stated definition.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 2, 75, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'swaps which starch component is branched' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'believes α-1,6 forms the main chain rather than the branch point' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'correct that amylose is all α-1,4 but overgeneralizes it to amylopectin' FROM q;

-- Q16 [Starch] medium skill2 ans=C [FIG]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Starch', 'A biochemistry student is studying the polysaccharides that a germinating seed mobilizes for energy. The schematic shown depicts one of the glucose polymers found in the storage granules of a potato tuber, with each hexagonal bead representing a glucose residue and the connecting lines representing the polymer''s chain topology. Based on the arrangement of glucose residues in the schematic and the biological source described, which polysaccharide is most consistent with this structure?', '[{"label": "A", "text": "Amylose, one of the two glucose polymers packaged in plant starch granules"}, {"label": "B", "text": "Glycogen, the glucose polymer stored in animal muscle and liver tissue"}, {"label": "C", "text": "Amylopectin, one of the two glucose polymers packaged in plant starch granules"}, {"label": "D", "text": "Cellulose, the glucose polymer that reinforces plant cell walls"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is C because the schematic depicts a main chain of glucose residues carrying a modest number of side chains, and this moderate degree of branching in a plant-starch (potato tuber) context matches amylopectin. Plant starch is a mixture of two glucose polymers, and amylopectin is the branched fraction (roughly 80% of the granule), built from an \(\alpha\text{-1,4}\)-linked backbone with periodic \(\alpha\text{-1,6}\) branch points. The reader must combine the topology drawn in the figure with the stated plant source to select it.

(Choice A) is incorrect: amylose is the other polymer packaged in plant starch granules, but it is the linear fraction — an \(\alpha\text{-1,4}\)-linked chain with no branch points — so a schematic showing side chains does not depict amylose.

(Choice C) is correct: amylopectin is the branched plant-starch polymer, and the main chain with a few side chains drawn in a potato-tuber (plant storage) context is consistent with its \(\alpha\text{-1,4}\) backbone plus scattered \(\alpha\text{-1,6}\) branches.

(Choice B) is incorrect: glycogen is the glucose storage polymer of animal muscle and liver, not plant tubers; it also carries far more frequent branch points than the polymer drawn, which shows only a few side chains.

(Choice D) is incorrect: cellulose is a structural polymer of the plant cell wall, not an energy-storage polymer of the granule; it is an unbranched \(\beta\text{-1,4}\)-linked chain forming extended linear fibers, inconsistent with the branched schematic.

As a Skill 2 item, this requires interpreting the branching topology in the figure and integrating it with the biological source to distinguish among four glucose polymers, rather than recalling a single definition.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 2, 75, '<svg style="max-width:380px;margin-inline:auto" viewBox="0 0 360 150" xmlns="http://www.w3.org/2000/svg" fill="none" stroke="#1a1a1a" stroke-width="1.6" stroke-linecap="round" font-family="''Helvetica Neue'',Arial,sans-serif"><line x1="40" y1="118" x2="80" y2="118"/><line x1="80" y1="118" x2="120" y2="118"/><line x1="120" y1="118" x2="160" y2="118"/><line x1="160" y1="118" x2="200" y2="118"/><line x1="200" y1="118" x2="240" y2="118"/><line x1="240" y1="118" x2="280" y2="118"/><line x1="280" y1="118" x2="320" y2="118"/><line x1="126" y1="84" x2="144" y2="54"/><line x1="246" y1="84" x2="264" y2="54"/><line x1="120" y1="118" x2="126" y2="84"/><line x1="240" y1="118" x2="246" y2="84"/><polygon points="51.0,118.0 45.5,127.5 34.5,127.5 29.0,118.0 34.5,108.5 45.5,108.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="91.0,118.0 85.5,127.5 74.5,127.5 69.0,118.0 74.5,108.5 85.5,108.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="131.0,118.0 125.5,127.5 114.5,127.5 109.0,118.0 114.5,108.5 125.5,108.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="171.0,118.0 165.5,127.5 154.5,127.5 149.0,118.0 154.5,108.5 165.5,108.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="211.0,118.0 205.5,127.5 194.5,127.5 189.0,118.0 194.5,108.5 205.5,108.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="251.0,118.0 245.5,127.5 234.5,127.5 229.0,118.0 234.5,108.5 245.5,108.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="291.0,118.0 285.5,127.5 274.5,127.5 269.0,118.0 274.5,108.5 285.5,108.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="331.0,118.0 325.5,127.5 314.5,127.5 309.0,118.0 314.5,108.5 325.5,108.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="137.0,84.0 131.5,93.5 120.5,93.5 115.0,84.0 120.5,74.5 131.5,74.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="155.0,54.0 149.5,63.5 138.5,63.5 133.0,54.0 138.5,44.5 149.5,44.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="257.0,84.0 251.5,93.5 240.5,93.5 235.0,84.0 240.5,74.5 251.5,74.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/><polygon points="275.0,54.0 269.5,63.5 258.5,63.5 253.0,54.0 258.5,44.5 269.5,44.5" fill="#EEF1F0" stroke="#1a1a1a" stroke-width="1.3"/></svg>')
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'adjacent_fact', 'confusing the two starch fractions (linear amylose vs branched amylopectin)' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'conflating the branched plant-starch polymer with the more heavily branched animal polymer glycogen' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'confusing an energy-storage plant glucose polymer with the structural plant glucose polymer cellulose' FROM q;

-- Q17 [Starch] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Starch', 'A nutrition researcher feeds two isolated glucose polymers to human volunteers. Polymer P is a linear chain of glucose in which each glucose is joined to the next through a bond that projects downward from the anomeric carbon, while Polymer Q is a linear chain of the identical glucose monomers joined through a bond that projects upward from the anomeric carbon. After a meal, blood glucose rises when volunteers consume Polymer P but remains flat when they consume Polymer Q, which is recovered largely intact in the stool. Which factor best accounts for why only Polymer P serves as a usable energy source in humans?', '[{"label": "A", "text": "Human amylase recognizes the linkage geometry in Polymer P but not the inverted linkage in Polymer Q, so only P yields absorbable glucose."}, {"label": "B", "text": "Polymer Q packs into tight hydrogen-bonded fibers, and this physical inaccessibility, rather than the linkage type itself, is what keeps every human enzyme from reaching it."}, {"label": "C", "text": "Polymer Q is built from a monosaccharide that human tissues cannot phosphorylate or feed into glycolysis, so its glucose can never be oxidized for energy at all."}, {"label": "D", "text": "The glycosidic bond in Polymer Q is intrinsically far stronger than the bond in Polymer P, so it requires more energy to break than digestion can supply."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is A because a glycosidic bond that projects downward from the anomeric carbon is an \(\alpha\) linkage (as in starch and glycogen), whereas one that projects upward is a \(\beta\) linkage (as in cellulose). Human \(\alpha\)-amylase is stereospecific: it hydrolyzes the \(\alpha\)-1,4 bonds of Polymer P, releasing maltose and glucose that the small intestine can absorb, but it does not fit or cleave the \(\beta\)-1,4 bond of Polymer Q. Because no human enzyme liberates glucose from Polymer Q, that glucose is never absorbed and cannot be used as fuel, so Polymer Q passes through and is recovered intact.

(Choice C) is incorrect: both polymers are made of the same monomer, D-glucose, which human cells readily phosphorylate (via hexokinase) and oxidize. The problem is not that the freed glucose is unusable; it is that Polymer Q''s glucose is never freed in the first place.

(Choice B) is incorrect: while cellulose does form tight hydrogen-bonded fibrils, the fundamental reason humans cannot use it is the \(\beta\) linkage, which human amylase cannot hydrolyze. Even fully dispersed \(\beta\)-1,4-linked chains resist human digestion, and organisms that harbor cellulase enzymes can digest cellulose despite the same fiber packing.

(Choice A) is correct: enzyme specificity for the \(\alpha\) versus \(\beta\) glycosidic geometry, not the monomer, the fiber, or the bond energy, is what determines digestibility.

(Choice D) is incorrect: \(\alpha\) and \(\beta\) glycosidic bonds are the same type of acetal linkage with essentially the same bond energy; they differ only in the spatial orientation at the anomeric carbon. Digestion works by enzyme-catalyzed hydrolysis, not by brute-force energy input, so a hypothetical energy difference is not the operative factor.

This item requires reasoning from a described scenario: recognizing that "downward" versus "upward" projection from the anomeric carbon encodes the \(\alpha\)/\(\beta\) distinction, and then inferring that an enzyme''s stereospecificity for the \(\alpha\) linkage is the single variable that makes starch, but not cellulose, a usable energy source.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 2, 90, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'C', 'misconception', 'attributes indigestibility to the monomer identity rather than the linkage, when both polymers share the same glucose monomer' FROM q
  UNION ALL
  SELECT id, 'B', 'partial_truth', 'cites the real fiber-packing property of cellulose but wrongly makes physical inaccessibility, not the beta linkage, the decisive cause' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'treats alpha vs beta as a bond-strength/energy difference rather than a stereochemical orientation difference' FROM q;

-- Q18 [Starch] hard skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Starch', 'Two identical aliquots of a purified, unbranched amylose solution are incubated separately: aliquot 1 with α-amylase and aliquot 2 with β-amylase. Both enzymes act only on α-1,4 glycosidic bonds. After a brief incubation that hydrolyzes the same small fraction of the total α-1,4 bonds in each aliquot, an investigator measures the average chain length of the polysaccharide molecules remaining in solution and the concentration of free maltose. Which pattern of results is expected for aliquot 1 relative to aliquot 2 at this early time point?', '[{"label": "A", "text": "Aliquot 1 shows far more accumulated maltose but almost no change in average chain length compared with aliquot 2"}, {"label": "B", "text": "Aliquot 1 shows a much larger drop in average chain length but far less accumulated maltose than aliquot 2"}, {"label": "C", "text": "Aliquot 1 and aliquot 2 show nearly identical drops in chain length and identical maltose concentrations"}, {"label": "D", "text": "Aliquot 1 retains its original chain length while releasing free glucose, whereas aliquot 2 loses chain length without releasing any sugar"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is B because the two enzymes attack the same amylose chain in fundamentally different geometric patterns. α-amylase is an endo-acting enzyme: it hydrolyzes α-1,4 bonds at random internal positions along the chain. β-amylase is an exo-acting enzyme: it removes one maltose unit at a time only from the non-reducing end. When each enzyme has cleaved the same small number of α-1,4 bonds, the location of those cuts is what matters. Each internal cut by α-amylase splits a long polymer into two shorter pieces, so a few random internal cuts sharply lowers the average chain length while liberating very little free maltose (most fragments are still oligomers longer than a disaccharide). In contrast, each β-amylase cut merely shaves a maltose off the end, so the same number of cuts produces a stoichiometric amount of free maltose while the bulk polymer barely shrinks. Comparing aliquot 1 (α-amylase) to aliquot 2 (β-amylase): aliquot 1 has the larger chain-length drop and the smaller maltose pool.

(Choice B) is correct: random internal (endo) cleavage collapses average chain length quickly with little disaccharide release, whereas end-wise (exo) removal of maltose does the opposite, so aliquot 1 loses more chain length and accumulates less maltose than aliquot 2.

(Choice A) is incorrect: it reverses the two enzymes. Rapid maltose accumulation with little change in chain length is the signature of the exo-acting β-amylase (aliquot 2), not the endo-acting α-amylase (aliquot 1).

(Choice C) is incorrect: it assumes cleaving the same number of bonds produces the same physical outcome regardless of where the bonds are. Endo versus exo positioning is precisely what makes the outcomes differ, so identical results cannot be expected.

(Choice D) is incorrect: it misassigns products and mechanism. β-amylase must release sugar (maltose) with each cut, so an enzyme that loses chain length "without releasing any sugar" is impossible; and α-amylase, cutting internally, does not preserve the original chain length.

At the Skill 2 level, this requires predicting how enzyme geometry (endo random-internal versus exo end-wise) maps onto two measurable consequences—average chain length and disaccharide yield—rather than recalling a stated definition, and then correctly assigning each predicted pattern to the right enzyme.', 'hard', '1D', 'Carbohydrates', 'biochemistry', 2, 100, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'endo/exo enzyme roles swapped' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'same number of bonds cleaved implies same physical outcome regardless of position' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'exo cleavage without product release / endo cleavage preserving chain length' FROM q;

-- Q19 [Glycogen] medium skill1 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Glycogen', 'A physiologist studying energy reserves isolates the principal glucose-storage polysaccharide from a mammal''s tissues and compares it to the analogous storage polymer purified from potato tubers. Both polymers are built from glucose and yield glucose upon complete hydrolysis. Which statement correctly identifies the mammalian polymer and a way its structure differs from the plant polymer?', '[{"label": "A", "text": "It is cellulose, and it is concentrated in adipose tissue, where its β-1,4 linkages resist rapid mobilization"}, {"label": "B", "text": "It is amylose, and it is stored chiefly in the small intestine as long unbranched α-1,4 chains"}, {"label": "C", "text": "It is glycogen, and it is stored mainly in liver and muscle with more frequent α-1,6 branches than the plant polymer"}, {"label": "D", "text": "It is dextran, and it is stored throughout the bloodstream as a polymer with an α-1,6 main-chain backbone"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is C because the main glucose-storage polysaccharide in animals is glycogen, which is deposited mainly in the liver and skeletal muscle. Like the plant storage form amylopectin, glycogen has an \(\alpha\text{-}1,4\)-linked glucose backbone with \(\alpha\text{-}1,6\) branch points, but it carries many more \(\alpha\text{-}1,6\) branches than amylopectin does. The more frequent branching creates many nonreducing ends, allowing glucose to be released rapidly from many branches at once when the animal needs fuel.

(Choice A) is incorrect: cellulose is a structural polysaccharide built from \(\beta\text{-}1,4\)-linked glucose, not an energy-storage molecule, and it is not stored in adipose tissue (fat, not glucose polymer, is stored there); its \(\beta\) linkages are not even digestible by mammals.

(Choice B) is incorrect: amylose is a plant polymer (the unbranched fraction of starch), not the animal storage form, and animals do not store a glucose polysaccharide in the small intestine; the intestine is where dietary starch is digested, not where a storage polymer is deposited.

(Choice C) is correct: glycogen is the animal glucose-storage polysaccharide, held mainly in liver and muscle, and it is more highly branched (more frequent \(\alpha\text{-}1,6\) branches) than the plant polymer amylopectin.

(Choice D) is incorrect: dextran is a bacterial/yeast glucose polymer with an \(\alpha\text{-}1,6\) main chain, used in lab chromatography resins; it is not the storage polysaccharide of mammals and is not circulated in the bloodstream as an energy reserve.

As a Skill 1 (knowledge recall) item, this question asks you to identify glycogen as the animal storage polysaccharide, recall its principal storage sites (liver and skeletal muscle), and recall that it is more highly branched than the plant polymer amylopectin.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 1, 75, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'confusing a structural polysaccharide with a storage polysaccharide' FROM q
  UNION ALL
  SELECT id, 'B', 'adjacent_fact', 'substituting the plant storage polymer (amylose/starch) for the animal one' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'naming a different α-glucan (dextran) that is not the mammalian storage form' FROM q;

-- Q20 [Glycogen] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Glycogen', 'Two glucose homopolymers are compared: glycogen, the animal storage polysaccharide, and amylose, an unbranched plant storage polymer. Both are built from glucose and are degraded by exoglycosidases that remove one glucose unit at a time from a chain terminus that bears a free C4 hydroxyl. A muscle cell must liberate a large burst of free glucose within seconds of an epinephrine signal. Which structural feature of glycogen most directly accounts for its superior ability to meet this demand compared with an equal mass of amylose?', '[{"label": "A", "text": "Its branch points shorten the overall molecule, reducing the distance enzymes must travel along each chain"}, {"label": "B", "text": "Its α-1,4 glycosidic bonds are intrinsically weaker and hydrolyze faster than the bonds in amylose"}, {"label": "C", "text": "Its greater number of reducing ends gives enzymes more sites from which to begin removing glucose"}, {"label": "D", "text": "Its extensive branching creates many chain termini at which degradative enzymes can act simultaneously"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is D because degradation proceeds from chain termini one residue at a time, so the rate of glucose release scales with the number of termini that enzymes can attack at once. Glycogen''s frequent α-1,6 branch points generate a highly branched, tree-like architecture in which every branch ends in its own terminus. An equal mass of unbranched amylose is essentially a single long chain with only one such terminus per molecule, so many enzyme molecules can chew glycogen from many ends in parallel, producing a large amount of free glucose almost simultaneously.

(Choice D) is correct: extensive branching multiplies the number of accessible chain ends, and because each end is an independent site of exolytic cleavage, more ends means proportionally faster overall glucose output — exactly what a rapid, on-demand energy source requires.

(Choice B) is incorrect: both glycogen and amylose are joined by the same α-1,4 glycosidic linkage along their main chains, so the intrinsic bond chemistry is identical. The difference in mobilization rate arises from architecture (number of ends), not from any difference in bond strength.

(Choice C) is incorrect: it correctly senses that "more ends = faster release" but names the wrong end. Each linear glucose chain has exactly one reducing end (the terminus with a free anomeric carbon); branching adds non-reducing ends, and it is the non-reducing termini — those bearing a free C4 hydroxyl — from which glucose is removed. Branching does not multiply reducing ends.

(Choice A) is incorrect: branch points do make the molecule more compact, but exolytic enzymes act only at termini and do not "travel" processively down a chain to reach an interior target, so compactness per se does not speed release. The benefit of branching is the added termini, not a shorter path along any single chain.

Answering this requires reasoning from the described degradation mechanism — one residue removed at a time from free-C4-hydroxyl termini — to conclude that a structure maximizing the count of such termini best serves rapid, simultaneous glucose mobilization.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 2, 90, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'attributes-rate-difference-to-bond-strength-rather-than-architecture' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'confuses-non-reducing-ends-with-reducing-ends' FROM q
  UNION ALL
  SELECT id, 'A', 'partial_truth', 'correct-that-branching-adds-compactness-but-wrong-causal-mechanism-for-speed' FROM q;

-- Q21 [Glycogen] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Glycogen', 'A muscle cell mobilizes its glycogen stores to fuel contraction. The enzyme that shortens the glycogen chains uses inorganic phosphate (Pi), rather than water, to break the bond attaching each terminal residue to the polymer. Because of this, the cell later saves one ATP that would otherwise be spent trapping the released sugar inside the cell. Which molecule is the direct product released as each residue is removed from the chain?', '[{"label": "A", "text": "Free glucose"}, {"label": "B", "text": "Glucose-1-phosphate"}, {"label": "C", "text": "Maltose"}, {"label": "D", "text": "Glucose-6-phosphate"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is B because glycogen phosphorylase carries out phosphorolysis, not hydrolysis: it uses inorganic phosphate \(\left(P_i\right)\) instead of water to cleave the \(\alpha\text{-}1{,}4\) glycosidic bond at a terminal residue. The phosphate is added directly onto the anomeric carbon (C1) of the departing sugar, so the residue leaves already carrying a phosphate group at C1 — that is, as glucose-1-phosphate. This also explains the ATP the cell saves: the product exits already phosphorylated, so hexokinase does not need to spend an ATP to trap it in the cell.

(Choice A) is incorrect: free glucose would be the product if the enzyme were hydrolytic (using water), as with the amylases of digestion. Phosphorylase uses \(P_i\), so the leaving sugar retains a phosphate and is not free glucose.

(Choice C) is incorrect: maltose is a disaccharide \(\left(\text{Glc-}\alpha\text{-}1{,}4\text{-Glc}\right)\) produced when amylase hydrolyzes starch or glycogen into two-residue fragments. Phosphorylase removes single residues, not disaccharide units, so no maltose is generated.

(Choice B) is correct: attaching \(P_i\) to C1 of the cleaved terminal residue yields glucose-1-phosphate, the immediate product of phosphorolysis.

(Choice D) is incorrect: glucose-6-phosphate does appear during glycogen catabolism, but only after phosphoglucomutase later shifts the phosphate from C1 to C6. It is a downstream product, not the molecule released at the moment of cleavage.

Reaching the answer requires applying the definition of phosphorolysis to a described scenario: identifying \(P_i\) (not water) as the attacking group tells you the leaving sugar must carry a phosphate at the point of cleavage, which distinguishes the immediate product from both the hydrolytic products and the later isomerized product.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 2, 75, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'assumes the degradative enzyme is hydrolytic (uses water) like amylase and therefore releases free glucose' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'confuses glycogen phosphorylase with amylase, which hydrolyzes chains into maltose disaccharide units' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'names the downstream phosphoglucomutase product (phosphate shifted C1 to C6) instead of the immediate cleavage product' FROM q;

-- Q22 [Glycogen] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Glycogen', 'Two purified glucose-storage polymers, X and Y, contain the same total number of glucose residues and identical α-1,4 and α-1,6 linkage chemistry, but polymer X carries roughly three times as many α-1,6 branch points as polymer Y. Both are exposed to an excess of the same phosphorylase, an enzyme that liberates glucose residues one at a time starting from a chain terminus that lacks a free anomeric carbon. Assuming enzyme is not limiting, why does polymer X release free glucose at a faster initial rate than polymer Y?', '[{"label": "A", "text": "X exposes more reducing ends, giving the phosphorylase additional starting points for residue removal."}, {"label": "B", "text": "X has more α-1,6 linkages, which the phosphorylase hydrolyzes faster than the α-1,4 linkages that predominate in Y."}, {"label": "C", "text": "X presents a greater number of non-reducing chain ends, so more enzyme molecules can act on it simultaneously."}, {"label": "D", "text": "X is a smaller, more compact molecule, so its glycosidic bonds are more accessible to the enzyme than those in Y."}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is C because the phosphorylase described removes glucose one residue at a time from a terminus lacking a free anomeric carbon—that is, from a non-reducing end. Each linear chain segment in a branched polymer terminates in one such end, so the number of non-reducing ends scales with the number of branches. Because X has about three times as many branch points as Y for the same total number of residues, X presents many more non-reducing ends. With enzyme in excess, many phosphorylase molecules can dock on these many ends and release glucose in parallel, giving X a faster initial mobilization rate.

(Choice C) is correct: more branch points mean more non-reducing chain ends available at once, and since the enzyme acts only at those ends, more enzyme copies can work simultaneously, speeding release.

(Choice B) is incorrect: this phosphorylase acts on the α-1,4-linked residues of the linear segments, not on the α-1,6 branch linkages themselves (a separate debranching activity handles those), so having more α-1,6 bonds does not directly accelerate glucose release; the linkage type is also not the variable that sets the rate here.

(Choice A) is incorrect: a polysaccharide has only a single reducing end regardless of how many branches it has, and the enzyme described starts at ends without a free anomeric carbon (non-reducing ends), so branching does not multiply reducing ends or provide extra starting points of that kind.

(Choice D) is incorrect: the two polymers contain the same number of residues, so X is not smaller than Y; furthermore, generalized bond "accessibility" is not what limits this reaction—the number of valid terminal starting sites is.

Skill 2 note: answering requires reasoning from the enzyme''s terminus specificity to the structural consequence of branching—recognizing that each added branch creates one more non-reducing end and that parallel action at many ends, not any change in bond chemistry, produces faster mobilization.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 2, 90, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'conflates enzyme target linkage with rate-determining variable' FROM q
  UNION ALL
  SELECT id, 'A', 'reversed_relationship', 'confuses reducing end with non-reducing end' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'attributes rate to compactness/accessibility rather than end count' FROM q;

-- Q23 [Carbohydrate Metabolism] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Carbohydrate Metabolism', 'A researcher feeds a volunteer a meal consisting only of purified amylopectin (a plant starch) and then samples the hepatic portal vein, which carries newly absorbed nutrients away from the small intestine. Amylases secreted into the mouth and small intestine act on the meal, and brush-border enzymes finish the job before absorption. Assuming digestion goes to completion, which monosaccharide should dominate the portal blood, and why?', '[{"label": "A", "text": "Fructose, because a hexose sugar is released each time a glycosidic bond within the polymer is cleaved"}, {"label": "B", "text": "Galactose, because the enzymes convert absorbed sugars into the storage form used by the liver"}, {"label": "C", "text": "A roughly equal mix of glucose and cellobiose left behind at the branch points"}, {"label": "D", "text": "Glucose, because the polymer is built entirely from glucose units joined by bonds the amylases can hydrolyze"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is D because amylopectin, like all starch, is a homopolymer of glucose: the residues are joined by \(\alpha\)-1,4 glycosidic bonds along the chains with \(\alpha\)-1,6 bonds at the branch points. Amylases hydrolyze the \(\alpha\)-1,4 linkages, producing maltose (Glc(\(\alpha\)1,4)Glc) and smaller fragments; brush-border enzymes (maltase, plus a debranching activity that clears the \(\alpha\)-1,6 branches) then finish the hydrolysis down to free glucose. Because the entire polymer is made of glucose, complete digestion can yield only glucose monomers for absorption, so glucose should dominate the portal blood.

(Choice A) is incorrect: while each hydrolysis event does release a hexose, that hexose is glucose, not fructose. Fructose reaches the blood from dietary sucrose (Glc(\(\alpha\)1,2)Fru), not from starch — starch contains no fructose to release.

(Choice B) is incorrect: galactose comes from dietary lactose (Gal(\(\beta\)1,4)Glc), not from starch, and digestive enzymes hydrolyze bonds rather than convert one monosaccharide into another. The liver does store glucose as glycogen, but that is an intracellular event, not the monosaccharide crossing the gut wall.

(Choice D) is correct: starch is a pure glucose polymer, and the \(\alpha\)-1,4 (and \(\alpha\)-1,6 at branches) linkages are exactly the bonds the human gut enzymes can cleave, so complete digestion delivers glucose.

(Choice C) is incorrect: cellobiose is Glc(\(\beta\)1,4)Glc, the repeating disaccharide of cellulose, whose \(\beta\)-1,4 bonds amylases cannot hydrolyze. Starch has no \(\beta\)-1,4 bonds, so no cellobiose is generated; the \(\alpha\)-1,6 branch points are cleared by a debranching enzyme, not left as a disaccharide.

Answering this required reasoning from the enzyme''s bond specificity and the polymer''s composition to predict the product, rather than recalling a stated fact — the stem never names the product, so you had to deduce that a glucose-only polymer hydrolyzed by glucose-releasing enzymes must yield glucose.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 2, 90, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'confusing starch products with dietary sucrose/fructose' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'confusing starch digestion product with lactose-derived galactose or with liver glycogen storage' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'confusing amylase-cleavable alpha-1,4 starch bonds with beta-1,4 cellulose/cellobiose' FROM q;

-- Q24 [Carbohydrate Metabolism] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'Carbohydrate Structure and Function', 'Carbohydrate Metabolism', 'During fasting, a muscle cell mobilizes its glycogen stores. Glycogen phosphorylase releases glucose residues as glucose-1-phosphate, which the cell then isomerizes to glucose-6-phosphate for use in glycolysis. Unlike glucose freed by intestinal digestion of dietary starch, the sugar liberated from intramuscular glycogen is never dephosphorylated and exported to the blood. Which feature of the phosphorylated product best accounts for why the muscle cell retains it rather than releasing it into circulation?', '[{"label": "A", "text": "The phosphate group adds a negative charge, so the sugar no longer crosses the membrane by passive diffusion and is not recognized by the transporters that carry free glucose"}, {"label": "B", "text": "Phosphorylation converts the sugar into a nonreducing form that the cell can no longer oxidize, so it must be held in storage instead of being sent into circulation"}, {"label": "C", "text": "The phosphate ester locks the anomeric carbon so the pyranose ring can no longer open, and this rigid closed form is what prevents the sugar from crossing the membrane"}, {"label": "D", "text": "Phosphorylation raises the sugar''s lipid solubility, letting it embed in the hydrophobic bilayer rather than diffuse out of the cell into the surrounding blood"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Carbohydrates.''

The answer is A because the plasma membrane''s nonpolar interior already makes an uncharged polar molecule like glucose dependent on specific transport proteins to cross it. Attaching a phosphate group adds negative charge, making the molecule even less able to slip through the bilayer by passive diffusion, and the facilitative glucose transporters that move free glucose in and out of cells do not recognize the phosphorylated form. Because glycogen phosphorylase releases the residue already phosphorylated (as glucose-1-phosphate), the cell can commit that carbon to glycolysis via glucose-6-phosphate without ever letting it escape — phosphorylation both traps the fuel intracellularly and readies it for the pathway.

(Choice A) is correct: the negative charge on the phosphate blocks passive diffusion across the nonpolar membrane interior, and the phosphorylated sugar is not a transporter substrate, so it stays inside the cell.

(Choice B) is incorrect: glucose-6-phosphate remains a reducing sugar (its C-1 anomeric OH is free), and reducing character governs redox chemistry at the anomeric carbon, not whether a molecule can cross a membrane or be oxidized in glycolysis. Retention is a transport/charge issue, not an oxidation issue.

(Choice C) is incorrect: in glucose-6-phosphate the phosphate sits on C-6, not the anomeric carbon, so it does not ''lock'' ring opening, and ring dynamics do not govern permeability in the first place. This choice invents a mechanism that does not determine membrane crossing.

(Choice D) is incorrect: adding a charged phosphate group makes the molecule more hydrophilic, not more lipid-soluble, so it becomes less — not more — able to interact with the nonpolar bilayer. This reverses the actual effect of phosphorylation on membrane behavior.

This question requires reasoning about why an experimentally observed outcome (retention of the sugar) follows from the chemical property introduced by phosphorylation, rather than recalling a stated definition.', 'medium', '1D', 'Carbohydrates', 'biochemistry', 2, 90, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'adjacent_fact', 'invokes a real carbohydrate concept (reducing vs. nonreducing sugars) that is irrelevant to membrane retention' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'plausible-sounding structural mechanism (anomeric-carbon locking) that does not actually govern permeability' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'reverses the true polarity effect — claims phosphorylation increases lipid solubility when it increases hydrophilicity' FROM q;

