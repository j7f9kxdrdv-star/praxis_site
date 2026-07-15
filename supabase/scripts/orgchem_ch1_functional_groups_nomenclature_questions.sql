-- ════════════════════════════════════════════════════════════════════
-- Organic Chemistry Ch1 — Functional Groups & Nomenclature — 24 standalone questions
-- RECOGNITION-focused: functional-group identification/classification, common names,
--  carbonyl-class structural distinctions, and carbon oxidation level.
-- Foundation 5D. content_category: Structure, function, and reactivity of biologically
--  relevant molecules. discipline=organic-chemistry. Grounded in LibreTexts OrgChem.
-- WHOLE-DOCUMENT cross-subject scope scan: the rote IUPAC naming algorithm (parent-chain
--  selection, locant numbering, substituent ordering, suffix priority), alkane/alkyne naming
--  as classes, degrees-of-unsaturation drills, and reactivity mechanisms are OFF-OUTLINE and
--  excluded; reactivity deferred to the dedicated functional-group chapters.
-- IDEMPOTENT: wipes the entire topic then re-inserts all 24.
-- ════════════════════════════════════════════════════════════════════

BEGIN;
DELETE FROM questions WHERE section = 'chem_phys' AND topic = 'Functional Groups & Nomenclature';

-- Q1 [A1 · Functional-Group Identification] easy skill1 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('chem_phys', 'Functional Groups & Nomenclature', 'Functional-Group Identification', 'In a protein, adjacent amino acids are joined by peptide bonds, the same type of linkage that gives every protein backbone its repeating amide functional group. Which of the condensed structures below contains that functional group?', '[{"label": "A", "text": "\\(\\text{CH}_3\\text{-C(=O)-NH}_2\\)"}, {"label": "B", "text": "\\(\\text{CH}_3\\text{-CH}_2\\text{-NH}_2\\)"}, {"label": "C", "text": "\\(\\text{CH}_3\\text{-C(=O)-O-CH}_3\\)"}, {"label": "D", "text": "\\(\\text{CH}_3\\text{-C(=O)-OH}\\)"}]'::jsonb, 'A', 'This is an Organic Chemistry question that falls under the content category ''Structure, function, and reactivity of biologically relevant molecules''. The answer to this question is A because an amide, the functional group of every peptide bond, has its carbonyl carbon bonded directly to nitrogen, and \(\text{CH}_3\text{-C(=O)-NH}_2\) is the only structure in which the \(\text{C=O}\) carbon is joined to an \(-\text{NH}_2\). (Choice B) In \(\text{CH}_3\text{-CH}_2\text{-NH}_2\) the nitrogen is bonded only to carbon and hydrogen and there is no carbonyl anywhere in the molecule, making it an amine, not an amide. (Choice C) In \(\text{CH}_3\text{-C(=O)-O-CH}_3\) the carbonyl carbon is bonded to an oxygen of an \(-\text{O-CH}_3\) group rather than to nitrogen, so it is an ester. (Choice D) In \(\text{CH}_3\text{-C(=O)-OH}\) the carbonyl carbon bears a hydroxyl \(-\text{OH}\), making it a carboxylic acid. Identifying the amide requires recognizing which atom is bonded to the carbonyl carbon, so this is a Knowledge of Scientific Concepts and Principles question.', 'easy', '5D', 'Structure, function, and reactivity of biologically relevant molecules', 'organic-chemistry', 1, 75)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'nitrogen present but no carbonyl' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'acyl-oxygen (ester) mistaken for acyl-nitrogen' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'acyl-hydroxyl (acid) mistaken for amide nitrogen' FROM q;

-- Q2 [A2 · Functional-Group Identification] easy skill1 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('chem_phys', 'Functional Groups & Nomenclature', 'Functional-Group Identification', 'Each structure below contains a carbonyl (\(\text{C=O}\)) group. Identify the one that is an aldehyde.', '[{"label": "A", "text": "\\(\\text{CH}_3\\text{-CO-CH}_3\\)"}, {"label": "B", "text": "\\(\\text{CH}_3\\text{-CH}_2\\text{-CHO}\\)"}, {"label": "C", "text": "\\(\\text{CH}_3\\text{-CO-CH}_2\\text{-CH}_3\\)"}, {"label": "D", "text": "\\(\\text{CH}_3\\text{-CH}_2\\text{-CO-CH}_2\\text{-CH}_3\\)"}]'::jsonb, 'B', 'This is an Organic Chemistry question that falls under the content category ''Structure, function, and reactivity of biologically relevant molecules''. The answer to this question is B because in \(\text{CH}_3\text{-CH}_2\text{-CHO}\) the carbonyl sits at the end of the chain, where its carbon still bears a hydrogen (\(\text{-CHO}\)); a terminal carbonyl carbon carrying an H is the defining feature of an aldehyde. (Choice A) In \(\text{CH}_3\text{-CO-CH}_3\) the carbonyl carbon is flanked by two carbons and carries no hydrogen, making it an internal carbonyl, i.e., a ketone. (Choice C) In \(\text{CH}_3\text{-CO-CH}_2\text{-CH}_3\) the carbonyl again lies between two carbons, so it is a ketone. (Choice D) In \(\text{CH}_3\text{-CH}_2\text{-CO-CH}_2\text{-CH}_3\) the carbonyl carbon is bonded to two carbons and no hydrogen, making it a ketone. This is a Knowledge of Scientific Concepts and Principles question because you must recognize each functional group from its condensed structure and apply the definition of an aldehyde to distinguish the terminal carbonyl from the internal carbonyls of the ketones.', 'easy', '5D', 'Structure, function, and reactivity of biologically relevant molecules', 'organic-chemistry', 1, 75)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'adjacent_fact', 'internal carbonyl (ketone), not terminal' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'internal carbonyl flanked by two carbons (ketone)' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'internal carbonyl, no H on carbonyl carbon (ketone)' FROM q;

-- Q3 [A3 · Functional-Group Identification] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('chem_phys', 'Functional Groups & Nomenclature', 'Functional-Group Identification', 'Classify the molecule \(\text{CH}_3\text{-CH}_2\text{-C(=O)-O-CH}_3\). It belongs to which functional-group class?', '[{"label": "A", "text": "Carboxylic acid"}, {"label": "B", "text": "Ketone"}, {"label": "C", "text": "Ester"}, {"label": "D", "text": "Ether"}]'::jsonb, 'C', 'This is an Organic Chemistry question that falls under the content category ''Structure, function, and reactivity of biologically relevant molecules''. The answer to this question is C because in \(\text{CH}_3\text{-CH}_2\text{-C(=O)-O-CH}_3\) the carbonyl carbon is bonded to an oxygen that in turn carries an alkyl group (\(-\text{O-CH}_3\)); an acyl group joined to an alkoxy oxygen (\(-\text{OR}\)) is an ester. (Choice A) A carboxylic acid would require that oxygen to carry a hydrogen (\(-\text{OH}\)); here it carries a \(\text{CH}_3\) group instead. (Choice B) A ketone''s carbonyl carbon is bonded to two carbons with no attached oxygen, but this carbonyl carbon is bonded to an oxygen. (Choice D) An ether is \(\text{C-O-C}\) with no carbonyl, whereas this molecule clearly contains a \(\text{C=O}\). This is a Scientific Reasoning and Problem Solving question because you must trace the atoms attached to the carbonyl carbon to assign the correct derivative class.', 'medium', '5D', 'Structure, function, and reactivity of biologically relevant molecules', 'organic-chemistry', 2, 110)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'partial_truth', 'acyl oxygen bears OR read as OH (acid vs ester)' FROM q
  UNION ALL
  SELECT id, 'B', 'adjacent_fact', 'acyl oxygen ignored, carbonyl called a ketone' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'carbonyl overlooked, C-O-C called an ether' FROM q;

-- Q4 [A4 · Functional-Group Identification] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('chem_phys', 'Functional Groups & Nomenclature', 'Functional-Group Identification', 'Each molecule below has its carbonyl carbon bonded to a heteroatom (O or N). Which one is the amide?', '[{"label": "A", "text": "\\(\\text{CH}_3\\text{-C(=O)-O-CH}_2\\text{-CH}_3\\)"}, {"label": "B", "text": "\\(\\text{CH}_3\\text{-C(=O)-O-CH}_3\\)"}, {"label": "C", "text": "\\(\\text{CH}_3\\text{-C(=O)-OH}\\)"}, {"label": "D", "text": "\\(\\text{CH}_3\\text{-C(=O)-NH-CH}_3\\)"}]'::jsonb, 'D', 'This is an Organic Chemistry question that falls under the content category ''Structure, function, and reactivity of biologically relevant molecules''. The answer to this question is D because in \(\text{CH}_3\text{-C(=O)-NH-CH}_3\) the carbonyl (acyl) carbon is bonded to nitrogen, and an acyl group joined to nitrogen (\(\text{C(=O)-N}\)) is an amide. (Choice A) In \(\text{CH}_3\text{-C(=O)-O-CH}_2\text{-CH}_3\) the carbonyl carbon is bonded to an alkoxy oxygen (\(-\text{O-CH}_2\text{CH}_3\)), making it an ester, not an amide. (Choice B) In \(\text{CH}_3\text{-C(=O)-O-CH}_3\) the carbonyl carbon is again bonded to an alkoxy oxygen (\(-\text{O-CH}_3\)), so it is also an ester. (Choice C) In \(\text{CH}_3\text{-C(=O)-OH}\) the carbonyl carbon is bonded to a hydroxyl (\(-\text{OH}\)), making it a carboxylic acid. Distinguishing the amide requires comparing the atom bonded to each acyl carbon: nitrogen marks the amide, an alkoxy oxygen marks an ester, and a hydroxyl marks a carboxylic acid. This is a Scientific Reasoning and Problem-Solving task rather than simple recall because you must apply each definition to the structures and compare them.', 'medium', '5D', 'Structure, function, and reactivity of biologically relevant molecules', 'organic-chemistry', 2, 110)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'adjacent_fact', 'acyl-oxygen (ester) mistaken for acyl-nitrogen (amide)' FROM q
  UNION ALL
  SELECT id, 'B', 'adjacent_fact', 'acyl-oxygen (ester) mistaken for amide' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'acyl-hydroxyl (carboxylic acid) mistaken for amide' FROM q;

-- Q5 [A5 · Functional-Group Identification] easy skill1 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('chem_phys', 'Functional Groups & Nomenclature', 'Functional-Group Identification', 'Which of the following condensed structures is an acid anhydride?', '[{"label": "A", "text": "\\(\\text{CH}_3\\text{-C(=O)-O-C(=O)-CH}_3\\)"}, {"label": "B", "text": "\\(\\text{CH}_3\\text{-C(=O)-O-CH}_3\\)"}, {"label": "C", "text": "\\(\\text{CH}_3\\text{-C(=O)-OH}\\)"}, {"label": "D", "text": "\\(\\text{CH}_3\\text{-CO-CH}_3\\)"}]'::jsonb, 'A', 'This is an Organic Chemistry question that falls under the content category ''Structure, function, and reactivity of biologically relevant molecules''. The answer to this question is A because \(\text{CH}_3\text{-C(=O)-O-C(=O)-CH}_3\) has two acyl (\(\text{C=O}\)) groups joined through a single bridging oxygen, which is the defining framework of an acid anhydride. (Choice B) \(\text{CH}_3\text{-C(=O)-O-CH}_3\) has only one acyl group, and its oxygen is bonded to an alkyl (methyl) carbon rather than to a second acyl group, so it is an ester. (Choice C) \(\text{CH}_3\text{-C(=O)-OH}\) has a single carbonyl carbon that also carries a hydroxyl on the same carbon, making it a carboxylic acid. (Choice D) \(\text{CH}_3\text{-CO-CH}_3\) has one carbonyl carbon flanked by two other carbons and no bridging oxygen, making it a ketone. This is a Knowledge of Scientific Concepts and Principles question because you must recognize the two-acyl, one-oxygen framework of an anhydride and distinguish it from the ester, carboxylic acid, and ketone drawn in the other choices.', 'easy', '5D', 'Structure, function, and reactivity of biologically relevant molecules', 'organic-chemistry', 1, 75)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'adjacent_fact', 'single acyl group with O bonded to alkyl carbon (ester), not two acyl groups sharing an oxygen' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'single carbonyl carbon bearing a hydroxyl (carboxylic acid)' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'lone carbonyl flanked by two carbons, no bridging oxygen (ketone)' FROM q;

-- Q6 [A6 · Functional-Group Identification] easy skill1 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('chem_phys', 'Functional Groups & Nomenclature', 'Functional-Group Identification', 'Only one of the structures below is an alcohol: a hydroxyl group (\(-\text{OH}\)) bonded to a saturated sp3 carbon. Which structure is the alcohol?', '[{"label": "A", "text": "\\(\\text{CH}_3\\text{-O-CH}_3\\)"}, {"label": "B", "text": "\\(\\text{CH}_3\\text{-CH}_2\\text{-OH}\\)"}, {"label": "C", "text": "\\(\\text{CH}_3\\text{-COOH}\\)"}, {"label": "D", "text": "\\(\\text{CH}_3\\text{-CO-CH}_3\\)"}]'::jsonb, 'B', 'This is an Organic Chemistry question that falls under the content category ''Structure, function, and reactivity of biologically relevant molecules''. The answer to this question is B because in \(\text{CH}_3\text{-CH}_2\text{-OH}\) the \(-\text{OH}\) is bonded to a saturated sp3 carbon (the \(\text{CH}_2\) carbon, which forms four single bonds), the defining hydroxyl group of an alcohol. (Choice A) In \(\text{CH}_3\text{-O-CH}_3\) the oxygen lies between two carbons (\(\text{C-O-C}\)) with no O-H bond, so it is an ether, not an alcohol. (Choice C) In \(\text{CH}_3\text{-COOH}\) an \(-\text{OH}\) is indeed present, but it is attached to a carbonyl (\(\text{C=O}\)) carbon, an sp2 carbon; that \(-\text{COOH}\) unit is a carboxyl group (a carboxylic acid), not an sp3 hydroxyl, so it is not an alcohol. (Choice D) In \(\text{CH}_3\text{-CO-CH}_3\) the oxygen is a carbonyl (\(\text{C=O}\)) flanked by two carbons with no O-H, making it a ketone. This is a Knowledge of Scientific Concepts and Principles question because you must recognize that an alcohol''s hydroxyl sits on an sp3 carbon, which distinguishes it from the carboxyl \(-\text{OH}\) on an sp2 carbon and from carbonyl and ether oxygens.', 'easy', '5D', 'Structure, function, and reactivity of biologically relevant molecules', 'organic-chemistry', 1, 75)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'C-O-C ether oxygen mistaken for an alcohol hydroxyl' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'carboxylic-acid -OH (on an sp2 carbonyl carbon) mistaken for an alcohol hydroxyl' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'internal carbonyl (ketone) oxygen mistaken for a hydroxyl' FROM q;

-- Q7 [A7 · Functional-Group Identification] easy skill1 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('chem_phys', 'Functional Groups & Nomenclature', 'Functional-Group Identification', 'Each molecule below contains at least one oxygen atom. Which one contains a carbonyl group?', '[{"label": "A", "text": "\\(\\text{CH}_3\\text{-CH}_2\\text{-OH}\\)"}, {"label": "B", "text": "\\(\\text{CH}_3\\text{-O-CH}_3\\)"}, {"label": "C", "text": "\\(\\text{CH}_3\\text{-CO-CH}_3\\)"}, {"label": "D", "text": "\\(\\text{HO-CH}_2\\text{-CH}_2\\text{-OH}\\)"}]'::jsonb, 'C', 'This is an Organic Chemistry question that falls under the content category ''Structure, function, and reactivity of biologically relevant molecules''. The answer to this question is C because in \(\text{CH}_3\text{-CO-CH}_3\) the central carbon is double-bonded to oxygen (\(\text{C=O}\)), a carbonyl group; here it is a ketone because that carbonyl carbon is flanked by two other carbons. Every option contains oxygen, so oxygen alone does not signal a carbonyl; only a carbon-oxygen DOUBLE bond does. (Choice A) In \(\text{CH}_3\text{-CH}_2\text{-OH}\) the oxygen is held by single bonds (a C-O and an O-H), making it a hydroxyl/alcohol, not a carbonyl. (Choice B) In \(\text{CH}_3\text{-O-CH}_3\) the oxygen bridges two carbons through C-O-C single bonds, an ether, so there is no C=O. (Choice D) In \(\text{HO-CH}_2\text{-CH}_2\text{-OH}\) each oxygen sits in a hydroxyl (two C-O and two O-H single bonds); having two oxygens still gives no carbon-oxygen double bond. This is a Knowledge of Scientific Concepts and Principles question because you must recognize a carbon-oxygen double bond within condensed structures rather than merely detect the presence of oxygen.', 'easy', '5D', 'Structure, function, and reactivity of biologically relevant molecules', 'organic-chemistry', 1, 75)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'hydroxyl (C-O/O-H single bonds) mistaken for a carbonyl' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'ether oxygen mistaken for a carbonyl' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'presence of oxygen (even two) mistaken for a carbonyl when both are single-bonded' FROM q;

-- Q8 [A8 · Functional-Group Identification] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('chem_phys', 'Functional Groups & Nomenclature', 'Functional-Group Identification', 'Lactic acid, \(\text{CH}_3\text{-CH(OH)-COOH}\), contains more than one oxygen-bearing group. Which functional group is the source of its most acidic proton?', '[{"label": "A", "text": "The hydroxyl (\\(-\\text{OH}\\)) of the alcohol"}, {"label": "B", "text": "The carbonyl (\\(\\text{C=O}\\)) double bond"}, {"label": "C", "text": "The methyl (\\(-\\text{CH}_3\\)) group"}, {"label": "D", "text": "The carboxyl (\\(-\\text{COOH}\\)) group"}]'::jsonb, 'D', 'This is an Organic Chemistry question that falls under the content category ''Structure, function, and reactivity of biologically relevant molecules''. The answer to this question is D because the carboxyl group (\(-\text{COOH}\)) in \(\text{CH}_3\text{-CH(OH)-COOH}\) releases its \(-\text{OH}\) proton readily, and the resulting carboxylate is resonance-stabilized, so the carboxyl is by far the most acidic site in the molecule. (Choice A) The alcohol hydroxyl on the middle carbon is only very weakly acidic (\(\text{p}K_a\) near 16), far less so than the carboxyl, so it is not the source of the readily donated proton. (Choice B) The carbonyl (\(\text{C=O}\)) double bond has no hydrogen of its own to give up; within the carboxyl group the acidic proton comes from the attached \(-\text{OH}\), not from the isolated \(\text{C=O}\). (Choice C) The methyl group is made of nonpolar \(\text{C-H}\) bonds, which are essentially non-acidic. This is a Scientific Reasoning and Problem Solving question because you must map an observed property, acidity, onto the specific functional group responsible for it.', 'medium', '5D', 'Structure, function, and reactivity of biologically relevant molecules', 'organic-chemistry', 2, 110)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'partial_truth', 'weakly acidic alcohol -OH mistaken for the acidic site' FROM q
  UNION ALL
  SELECT id, 'B', 'partial_truth', 'carbonyl C=O (bears no proton) named as the acid source' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'nonpolar alkyl C-H mistaken as acidic' FROM q;

-- Q9 [A9 · Functional-Group Identification] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('chem_phys', 'Functional Groups & Nomenclature', 'Functional-Group Identification', 'A carboxylic-acid derivative has the general form \(\text{R-C(=O)-Z}\), where the substituent \(\text{Z}\) replaces the \(-\text{OH}\) of the parent acid. Based on the group \(\text{Z}\) bonded to a carbonyl carbon in \(\text{CH}_3\text{-C(=O)-O-C(=O)-CH}_2\text{-CH}_3\), this derivative is classified as a(n):', '[{"label": "A", "text": "Anhydride"}, {"label": "B", "text": "Ester"}, {"label": "C", "text": "Amide"}, {"label": "D", "text": "Acyl halide"}]'::jsonb, 'A', 'This is an Organic Chemistry question that falls under the content category ''Structure, function, and reactivity of biologically relevant molecules''. The answer to this question is A because in \(\text{CH}_3\text{-C(=O)-O-C(=O)-CH}_2\text{-CH}_3\) the carbonyl carbon''s oxygen bridges to a second acyl group, so the substituent \(\text{Z}\) is \(-\text{O-C(=O)R}\); an acyl group joined to a second acyl group through a shared oxygen is an anhydride. (Choice B) An ester requires \(\text{Z}\) to be a simple alkoxy group (\(-\text{OR}\)) bonded to a plain alkyl carbon; here the oxygen instead leads to a second carbonyl carbon, so it is not an ester. (Choice C) An amide requires \(\text{Z}\) to be nitrogen (\(-\text{NR}_2\)), but no nitrogen is present. (Choice D) An acyl halide requires \(\text{Z}\) to be a halogen (\(-\text{X}\)), but no halogen is present. This is a Scientific Reasoning and Problem Solving question because you must read the substituent bonded to the carbonyl carbon and place the molecule among several real acid-derivative types.', 'hard', '5D', 'Structure, function, and reactivity of biologically relevant molecules', 'organic-chemistry', 2, 150)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'adjacent_fact', 'acyl-O-alkyl (ester) confused with acyl-O-acyl (anhydride)' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'amide substituent (nitrogen) absent' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'acyl-halide substituent (halogen) absent' FROM q;

-- Q10 [A10 · Functional-Group Identification] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('chem_phys', 'Functional Groups & Nomenclature', 'Functional-Group Identification', 'Hydrogen-bond donation requires a hydrogen atom covalently bonded to a strongly electronegative atom. In 2-methoxyethanol, \(\text{HO-CH}_2\text{-CH}_2\text{-O-CH}_3\), which feature can act as a hydrogen-bond donor?', '[{"label": "A", "text": "The ether oxygen (\\(\\text{C-O-C}\\))"}, {"label": "B", "text": "The hydroxyl group (\\(-\\text{OH}\\))"}, {"label": "C", "text": "The methyl group (\\(-\\text{CH}_3\\))"}, {"label": "D", "text": "The carbon-carbon single bonds (\\(\\text{C-C}\\))"}]'::jsonb, 'B', 'This is an Organic Chemistry question that falls under the content category ''Structure, function, and reactivity of biologically relevant molecules''. The answer to this question is B because the hydroxyl group (\(-\text{OH}\)) in \(\text{HO-CH}_2\text{-CH}_2\text{-O-CH}_3\) has a hydrogen covalently bonded to a highly electronegative oxygen, which is exactly what a molecule needs to donate a hydrogen bond. (Choice A) The ether oxygen (\(\text{C-O-C}\)) has no hydrogen attached to it, so it can accept a hydrogen bond but cannot donate one. (Choice C) A methyl \(\text{C-H}\) bond is too weakly polarized to act as a hydrogen-bond donor. (Choice D) \(\text{C-C}\) single bonds are nonpolar and carry no donatable hydrogen. This is a Scientific Reasoning and Problem Solving question because you must map a described behavior, hydrogen-bond donation, onto the one functional group capable of it.', 'medium', '5D', 'Structure, function, and reactivity of biologically relevant molecules', 'organic-chemistry', 2, 110)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'partial_truth', 'ether oxygen accepts but cannot donate an H-bond' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'nonpolar C-H treated as an H-bond donor' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'nonpolar C-C treated as an H-bond source' FROM q;

-- Q11 [B11 · Common Names & Carbonyl Structure] easy skill1 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('chem_phys', 'Functional Groups & Nomenclature', 'Common Names & Carbonyl Structure', 'Acetic acid is the compound that gives vinegar its characteristic sour taste. Which of the following condensed structures represents acetic acid?', '[{"label": "A", "text": "\\(\\text{HCOOH}\\)"}, {"label": "B", "text": "\\(\\text{CH}_3\\text{CH}_2\\text{COOH}\\)"}, {"label": "C", "text": "\\(\\text{CH}_3\\text{COOH}\\)"}, {"label": "D", "text": "\\(\\text{CH}_3\\text{CHO}\\)"}]'::jsonb, 'C', 'This is an Organic Chemistry question that falls under the content category ''Structure, function, and reactivity of biologically relevant molecules''. The answer to this question is C because acetic acid is ethanoic acid, whose structure carries a \(\text{-COOH}\) group (a carbonyl and a hydroxyl on the same terminal carbon) on a single \(\text{CH}_3\) carbon, giving \(\text{CH}_3\text{COOH}\); this is the two-carbon carboxylic acid found in vinegar. (Choice A) \(\text{HCOOH}\) is formic acid; its \(\text{-COOH}\) sits on a lone carbon bearing only H, so it is a one-carbon carboxylic acid rather than the two-carbon acetic acid. (Choice B) \(\text{CH}_3\text{CH}_2\text{COOH}\) is propionic acid; the extra \(\text{CH}_2\) makes it a three-carbon acid, one carbon too long. (Choice D) \(\text{CH}_3\text{CHO}\) has the right two-carbon count but ends in a \(\text{-CHO}\) aldehyde carbonyl with no hydroxyl, making it acetaldehyde rather than a carboxylic acid. This is a Knowledge of Scientific Concepts and Principles question because you must recall the structure that acetic acid maps to and recognize the \(\text{-COOH}\) carboxylic-acid group against a same-carbon-count aldehyde and against acids of differing chain length.', 'easy', '5D', 'Structure, function, and reactivity of biologically relevant molecules', 'organic-chemistry', 1, 75)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'adjacent_fact', 'formic acid, one-carbon acid' FROM q
  UNION ALL
  SELECT id, 'B', 'adjacent_fact', 'propionic acid, three-carbon acid' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'correct 2-carbon count, aldehyde not acid' FROM q;

-- Q12 [B12 · Common Names & Carbonyl Structure] easy skill1 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('chem_phys', 'Functional Groups & Nomenclature', 'Common Names & Carbonyl Structure', 'Acetone is the simplest ketone. Which of the following condensed structures is acetone?', '[{"label": "A", "text": "\\(\\text{HCHO}\\)"}, {"label": "B", "text": "\\(\\text{CH}_3\\text{CHO}\\)"}, {"label": "C", "text": "\\(\\text{CH}_3\\text{COCH}_2\\text{CH}_3\\)"}, {"label": "D", "text": "\\(\\text{CH}_3\\text{COCH}_3\\)"}]'::jsonb, 'D', 'This is an Organic Chemistry question that falls under the content category ''Structure, function, and reactivity of biologically relevant molecules''. The answer to this question is D because acetone (propanone) is \(\text{CH}_3\text{COCH}_3\): its central carbonyl carbon is flanked by two methyl groups, so the \(\text{C=O}\) sits internally between two carbons—the defining arrangement of a ketone—and with only three carbons it is the smallest structure meeting that requirement. (Choice A) \(\text{HCHO}\) (formaldehyde) has a carbonyl carbon bearing two hydrogens and no carbon neighbor, so its \(\text{C=O}\) is a terminal aldehyde, not an internal ketone carbonyl. (Choice B) \(\text{CH}_3\text{CHO}\) (acetaldehyde) carries its \(\text{C=O}\) at the chain end with one hydrogen on the carbonyl carbon, making it an aldehyde rather than a ketone. (Choice C) \(\text{CH}_3\text{COCH}_2\text{CH}_3\) (butanone) is a genuine ketone—its carbonyl carbon does bond two carbons—but its four-carbon chain makes it larger than acetone, so it is not the simplest ketone. This is a Knowledge of Scientific Concepts and Principles question because it requires connecting the common name acetone to its condensed structure and recognizing the internal-carbonyl arrangement that defines a ketone.', 'easy', '5D', 'Structure, function, and reactivity of biologically relevant molecules', 'organic-chemistry', 1, 75)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'formaldehyde is the simplest aldehyde, not ketone' FROM q
  UNION ALL
  SELECT id, 'B', 'adjacent_fact', 'acetaldehyde, a two-carbon aldehyde' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'a ketone but not the simplest (butanone)' FROM q;

-- Q13 [B13 · Common Names & Carbonyl Structure] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('chem_phys', 'Functional Groups & Nomenclature', 'Common Names & Carbonyl Structure', 'Aldehydes are the functional-group family whose carbonyl carbon lies at the end of the chain and carries at least one hydrogen. Which of the following structures would be classified in the aldehyde family?', '[{"label": "A", "text": "\\(\\text{CH}_3\\text{CH}_2\\text{CHO}\\)"}, {"label": "B", "text": "\\(\\text{CH}_3\\text{COCH}_3\\)"}, {"label": "C", "text": "\\(\\text{CH}_3\\text{CH}_2\\text{COOH}\\)"}, {"label": "D", "text": "\\(\\text{CH}_3\\text{CH}_2\\text{OH}\\)"}]'::jsonb, 'A', 'This is an Organic Chemistry question that falls under the content category ''Structure, function, and reactivity of biologically relevant molecules''. The answer to this question is A because in \(\text{CH}_3\text{CH}_2\text{CHO}\) the carbonyl carbon sits at the end of the chain and carries a hydrogen (the \(\text{-CHO}\) terminus), which is the defining structural feature that places a molecule in the aldehyde family. (Choice B) \(\text{CH}_3\text{COCH}_3\) has its \(\text{C=O}\) carbon bonded to two carbons in the middle of the chain, the internal-carbonyl pattern of a ketone. (Choice C) \(\text{CH}_3\text{CH}_2\text{COOH}\) has a terminal carbonyl, but that carbon also carries an \(\text{-OH}\), making the group \(\text{-COOH}\), a carboxylic acid rather than an aldehyde. (Choice D) \(\text{CH}_3\text{CH}_2\text{OH}\) contains only a hydroxyl on an sp3 carbon and no \(\text{C=O}\) at all, so it is an alcohol. This is a Scientific Reasoning and Problem Solving question because you must apply the terminal-carbonyl-with-hydrogen criterion to each structure and rule out the ketone, acid, and alcohol.', 'medium', '5D', 'Structure, function, and reactivity of biologically relevant molecules', 'organic-chemistry', 2, 110)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'internal carbonyl is a ketone, not terminal' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'terminal carbonyl but bears -OH, so an acid' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'alcohol has no carbonyl at all' FROM q;

-- Q14 [B14 · Common Names & Carbonyl Structure] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('chem_phys', 'Functional Groups & Nomenclature', 'Common Names & Carbonyl Structure', 'Propionic acid is a straight-chain carboxylic acid that appears in the common-name series formic, acetic, propionic, butyric. Which condensed structure corresponds to propionic acid?', '[{"label": "A", "text": "\\(\\text{CH}_3\\text{COOH}\\)"}, {"label": "B", "text": "\\(\\text{CH}_3\\text{CH}_2\\text{COOH}\\)"}, {"label": "C", "text": "\\(\\text{CH}_3\\text{CH}_2\\text{CH}_2\\text{COOH}\\)"}, {"label": "D", "text": "\\(\\text{CH}_3\\text{CH}_2\\text{CH}_2\\text{OH}\\)"}]'::jsonb, 'B', 'This is an Organic Chemistry question that falls under the content category ''Structure, function, and reactivity of biologically relevant molecules''. The answer to this question is B because propionic acid is the three-carbon member of the common-name carboxylic-acid series, and counting the carboxyl carbon it consists of the two-carbon \(\text{CH}_3\text{CH}_2\)- chain plus the \(\text{-COOH}\) carbon, giving \(\text{CH}_3\text{CH}_2\text{COOH}\). (Choice A) \(\text{CH}_3\text{COOH}\) has only two carbons and is acetic acid, one member earlier in the series. (Choice C) \(\text{CH}_3\text{CH}_2\text{CH}_2\text{COOH}\) has four carbons and is butyric acid, one member later. (Choice D) \(\text{CH}_3\text{CH}_2\text{CH}_2\text{OH}\) does contain three carbons but terminates in an \(\text{-OH}\) on an sp3 carbon rather than a \(\text{-COOH}\), making it the alcohol 1-propanol, not a carboxylic acid. This is a Scientific Reasoning and Problem Solving question because you must recall the position of propionic acid in the common-name series and confirm the terminal carboxylic-acid group to select the matching structure.', 'medium', '5D', 'Structure, function, and reactivity of biologically relevant molecules', 'organic-chemistry', 2, 110)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'adjacent_fact', 'acetic acid, one carbon too few' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'butyric acid, one carbon too many' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'correct 3-carbon count but hydroxyl, an alcohol' FROM q;

-- Q15 [C15 · Carbon Oxidation Level] hard skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('chem_phys', 'Functional Groups & Nomenclature', 'Carbon Oxidation Level', 'Three one-carbon compounds are shown: \(\text{HCHO}\) (methanal), \(\text{HCOOH}\) (methanoic acid), and \(\text{CH}_3\text{OH}\) (methanol). Considering only the single carbon in each, which ranking places these carbons from LEAST to MOST oxidized?', '[{"label": "A", "text": "\\(\\text{HCOOH} < \\text{HCHO} < \\text{CH}_3\\text{OH}\\)"}, {"label": "B", "text": "\\(\\text{HCHO} < \\text{CH}_3\\text{OH} < \\text{HCOOH}\\)"}, {"label": "C", "text": "\\(\\text{CH}_3\\text{OH} < \\text{HCHO} < \\text{HCOOH}\\)"}, {"label": "D", "text": "\\(\\text{CH}_3\\text{OH} < \\text{HCOOH} < \\text{HCHO}\\)"}]'::jsonb, 'C', 'This is an Organic Chemistry question that falls under the content category ''Structure, function, and reactivity of biologically relevant molecules''. The answer to this question is C because the single carbon becomes more oxidized as it forms more bonds to oxygen: in \(\text{CH}_3\text{OH}\) the carbon has three \(\text{C-H}\) bonds and one \(\text{C-O}\) bond (oxidation number \(-2\)), in \(\text{HCHO}\) it has two \(\text{C-H}\) bonds and a \(\text{C=O}\) that counts as two bonds to oxygen (\(0\)), and in \(\text{HCOOH}\) it has one \(\text{C-H}\) bond plus three bonds to oxygen (\(+2\)); least to most oxidized is therefore \(\text{CH}_3\text{OH} < \text{HCHO} < \text{HCOOH}\). (Choice A) This ordering places the carboxyl carbon of \(\text{HCOOH}\) (three bonds to oxygen) as least oxidized and the alcohol carbon of \(\text{CH}_3\text{OH}\) (one bond to oxygen) as most oxidized, inverting the relationship between bonds-to-oxygen and oxidation level. (Choice B) Placing \(\text{HCHO}\) below \(\text{CH}_3\text{OH}\) treats the aldehyde carbon as less oxidized than the alcohol carbon, but the \(\text{C=O}\) of \(\text{HCHO}\) supplies two bonds to oxygen versus the single \(\text{C-O}\) of \(\text{CH}_3\text{OH}\), so the aldehyde carbon is the more oxidized of the two. (Choice D) This ranks \(\text{HCOOH}\) below \(\text{HCHO}\), but the carboxyl carbon carries three bonds to oxygen while the aldehyde carbon carries only two, so \(\text{HCOOH}\) is the most oxidized member, not the middle one. This is a Scientific Reasoning and Problem Solving question because you must derive each carbon''s oxidation level from its bonds to oxygen and hydrogen and use those values to order the structures.', 'hard', '5D', 'Structure, function, and reactivity of biologically relevant molecules', 'organic-chemistry', 2, 150)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'full inversion of oxidation order' FROM q
  UNION ALL
  SELECT id, 'B', 'process_step_confusion', 'swaps alcohol and aldehyde levels' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'correct reduced end, inverts aldehyde vs acid' FROM q;

-- Q16 [C16 · Carbon Oxidation Level] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('chem_phys', 'Functional Groups & Nomenclature', 'Carbon Oxidation Level', 'Each choice describes a one-step conversion between two molecules. In which conversion is the reacting carbon OXIDIZED?', '[{"label": "A", "text": "\\(\\text{CH}_3\\text{CHO} \\rightarrow \\text{CH}_3\\text{CH}_2\\text{OH}\\)"}, {"label": "B", "text": "\\(\\text{CH}_3\\text{COOH} \\rightarrow \\text{CH}_3\\text{CHO}\\)"}, {"label": "C", "text": "\\(\\text{CH}_3\\text{COOH} \\rightarrow \\text{CH}_3\\text{CH}_2\\text{OH}\\)"}, {"label": "D", "text": "\\(\\text{CH}_3\\text{CH}_2\\text{OH} \\rightarrow \\text{CH}_3\\text{CHO}\\)"}]'::jsonb, 'D', 'This is an Organic Chemistry question that falls under the content category ''Structure, function, and reactivity of biologically relevant molecules''. The answer to this question is D because converting \(\text{CH}_3\text{CH}_2\text{OH}\) to \(\text{CH}_3\text{CHO}\) strips two hydrogens from the functional carbon and forms a \(\text{C=O}\): that carbon moves from one \(\text{C-O}\) bond and two \(\text{C-H}\) bonds (oxidation number \(-1\)) to a \(\text{C=O}\) with one \(\text{C-H}\) bond (\(+1\)). Gaining bonds to oxygen while losing bonds to hydrogen is an oxidation of carbon. (Choice A) Converting \(\text{CH}_3\text{CHO}\) to \(\text{CH}_3\text{CH}_2\text{OH}\) adds hydrogen and breaks one of the two \(\text{C-O}\) bonds of the carbonyl, lowering the carbon from \(+1\) to \(-1\); this is a reduction, not an oxidation. (Choice B) Converting \(\text{CH}_3\text{COOH}\) to \(\text{CH}_3\text{CHO}\) removes one bond to oxygen from the functional carbon (three down to two) and adds a hydrogen, dropping the oxidation number from \(+3\) to \(+1\); this is a reduction. (Choice C) Converting \(\text{CH}_3\text{COOH}\) to \(\text{CH}_3\text{CH}_2\text{OH}\) replaces bonds to oxygen with bonds to hydrogen, lowering the carbon from \(+3\) to \(-1\); this decrease in bonds-to-oxygen is a reduction. This is a Scientific Reasoning and Problem Solving question because you must determine the direction of each conversion from the change in the carbon''s bonds to hydrogen and to oxygen.', 'medium', '5D', 'Structure, function, and reactivity of biologically relevant molecules', 'organic-chemistry', 2, 110)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'aldehyde-to-alcohol read as oxidation' FROM q
  UNION ALL
  SELECT id, 'B', 'process_step_confusion', 'acid-to-aldehyde step down misread as up' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'acid-to-alcohol read as oxidation' FROM q;

-- Q17 [C17 · Carbon Oxidation Level] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('chem_phys', 'Functional Groups & Nomenclature', 'Carbon Oxidation Level', 'In acetaldehyde, \(\text{CH}_3\text{CHO}\), what is the oxidation number of the carbonyl carbon (the carbon of the \(\text{CHO}\) group)? Count each bond to oxygen as \(+1\), each bond to hydrogen as \(-1\), and each carbon-carbon bond as \(0\).', '[{"label": "A", "text": "\\(+1\\)"}, {"label": "B", "text": "\\(-1\\)"}, {"label": "C", "text": "\\(0\\)"}, {"label": "D", "text": "\\(+2\\)"}]'::jsonb, 'A', 'This is an Organic Chemistry question that falls under the content category ''Structure, function, and reactivity of biologically relevant molecules''. The answer to this question is A because the carbonyl carbon of \(\text{CH}_3\text{CHO}\) forms one bond to hydrogen (\(-1\)), one bond to the adjacent carbon (\(0\)), and a \(\text{C=O}\) double bond that counts as two bonds to oxygen (\(+2\)); summing \(-1 + 0 + 2\) gives an oxidation number of \(+1\). (Choice B) A value of \(-1\) counts the \(\text{C-H}\) bond but omits the bonds to the carbonyl oxygen entirely; the \(\text{C=O}\) contributes \(+2\) and cannot be left out. (Choice C) A value of \(0\) results from counting the \(\text{C=O}\) as a single bond to oxygen (\(+1\)) rather than a double bond; a double bond to oxygen counts as two bonds (\(+2\)), which raises the total to \(+1\). (Choice D) A value of \(+2\) counts the two bonds to oxygen but omits the \(-1\) contribution from the \(\text{C-H}\) bond on the carbonyl carbon; including it lowers the total to \(+1\). This is a Scientific Reasoning and Problem Solving question because you must apply the oxidation-number counting rules to the bonds present and compute a numerical value for the specified carbon.', 'hard', '5D', 'Structure, function, and reactivity of biologically relevant molecules', 'organic-chemistry', 2, 150)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'ignores bonds to carbonyl oxygen' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'counts C=O as one bond to oxygen' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'omits the C-H bond contribution' FROM q;

-- Q18 [C18 · Carbon Oxidation Level] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('chem_phys', 'Functional Groups & Nomenclature', 'Carbon Oxidation Level', 'Which of the following molecules contains the MOST oxidized carbon?', '[{"label": "A", "text": "\\(\\text{CH}_3\\text{OH}\\)"}, {"label": "B", "text": "\\(\\text{CO}_2\\)"}, {"label": "C", "text": "\\(\\text{HCHO}\\)"}, {"label": "D", "text": "\\(\\text{HCOOH}\\)"}]'::jsonb, 'B', 'This is an Organic Chemistry question that falls under the content category ''Structure, function, and reactivity of biologically relevant molecules''. The answer to this question is B because the carbon in \(\text{CO}_2\) forms four bonds to oxygen (two \(\text{C=O}\) double bonds), giving an oxidation number of \(+4\), the maximum a carbon can reach; no carbon still bearing hydrogen or carbon neighbors can exceed it. (Choice A) The carbon in \(\text{CH}_3\text{OH}\) has only one \(\text{C-O}\) bond and three \(\text{C-H}\) bonds (oxidation number \(-2\)); the mere presence of oxygen does not make it highly oxidized, and it is in fact the least oxidized carbon shown. (Choice C) The carbon in \(\text{HCHO}\) has a \(\text{C=O}\) worth two bonds to oxygen (oxidation number \(0\)), more oxidized than an alcohol but well below the four bonds to oxygen in \(\text{CO}_2\). (Choice D) The carbon in \(\text{HCOOH}\) has three bonds to oxygen (oxidation number \(+2\)); this is the most oxidized carbon among the organic choices but still short of the \(+4\) carbon of \(\text{CO}_2\). This is a Scientific Reasoning and Problem Solving question because you must evaluate the bonds-to-oxygen of each carbon and compare oxidation levels rather than recall a fixed list.', 'medium', '5D', 'Structure, function, and reactivity of biologically relevant molecules', 'organic-chemistry', 2, 110)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'equates any oxygen with high oxidation' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'carbonyl oxidized but only two C-O bonds' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'highest organic but below CO2' FROM q;

-- Q19 [C19 · Carbon Oxidation Level] easy skill1 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('chem_phys', 'Functional Groups & Nomenclature', 'Carbon Oxidation Level', 'In which of the following molecules is the carbon in its MOST reduced state?', '[{"label": "A", "text": "\\(\\text{CH}_3\\text{OH}\\)"}, {"label": "B", "text": "\\(\\text{HCHO}\\)"}, {"label": "C", "text": "\\(\\text{CH}_4\\)"}, {"label": "D", "text": "\\(\\text{HCOOH}\\)"}]'::jsonb, 'C', 'This is an Organic Chemistry question that falls under the content category ''Structure, function, and reactivity of biologically relevant molecules''. The answer to this question is C because the carbon in \(\text{CH}_4\) forms four bonds to hydrogen and none to any more-electronegative atom, giving an oxidation number of \(-4\), the most reduced (most hydrogen-rich) state a carbon can occupy. (Choice A) The carbon in \(\text{CH}_3\text{OH}\) has three \(\text{C-H}\) bonds but also one \(\text{C-O}\) bond (oxidation number \(-2\)); that single bond to oxygen makes it more oxidized than the all-hydrogen carbon of \(\text{CH}_4\). (Choice B) The carbon in \(\text{HCHO}\) bears a \(\text{C=O}\) (two bonds to oxygen, oxidation number \(0\)); a carbonyl carbon is partially oxidized, the opposite of most reduced. (Choice D) The carbon in \(\text{HCOOH}\) has three bonds to oxygen (oxidation number \(+2\)), making it the most oxidized carbon shown rather than the most reduced. This is a Knowledge of Scientific Concepts and Principles question because you must recognize that a carbon''s reduction level tracks the number of bonds it makes to hydrogen versus to more-electronegative atoms.', 'easy', '5D', 'Structure, function, and reactivity of biologically relevant molecules', 'organic-chemistry', 1, 75)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'adjacent_fact', 'one C-O bond raises oxidation above alkane' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'carbonyl carbon mistaken for reduced' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'most oxidized picked for most reduced' FROM q;

-- Q20 [C20 · Carbon Oxidation Level] hard skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('chem_phys', 'Functional Groups & Nomenclature', 'Carbon Oxidation Level', 'Rank the carbon in these four one-carbon species from LEAST to MOST oxidized. Which ordering is correct?', '[{"label": "A", "text": "\\(\\text{CH}_4 < \\text{HCHO} < \\text{CH}_3\\text{OH} < \\text{HCOOH}\\)"}, {"label": "B", "text": "\\(\\text{HCOOH} < \\text{HCHO} < \\text{CH}_3\\text{OH} < \\text{CH}_4\\)"}, {"label": "C", "text": "\\(\\text{CH}_3\\text{OH} < \\text{CH}_4 < \\text{HCHO} < \\text{HCOOH}\\)"}, {"label": "D", "text": "\\(\\text{CH}_4 < \\text{CH}_3\\text{OH} < \\text{HCHO} < \\text{HCOOH}\\)"}]'::jsonb, 'D', 'This is an Organic Chemistry question that falls under the content category ''Structure, function, and reactivity of biologically relevant molecules''. The answer to this question is D because the number of bonds to oxygen rises steadily across the series: \(\text{CH}_4\) has zero (oxidation number \(-4\)), \(\text{CH}_3\text{OH}\) has one (\(-2\)), \(\text{HCHO}\) has two through its \(\text{C=O}\) (\(0\)), and \(\text{HCOOH}\) has three (\(+2\)); least to most oxidized is therefore \(\text{CH}_4 < \text{CH}_3\text{OH} < \text{HCHO} < \text{HCOOH}\). (Choice A) This ordering places \(\text{HCHO}\) before \(\text{CH}_3\text{OH}\), but the aldehyde carbon has two bonds to oxygen while the alcohol carbon has only one, so \(\text{CH}_3\text{OH}\) must come first; the remainder of the sequence is correct. (Choice B) This lists the species from most to least oxidized, placing the three-oxygen-bond carbon of \(\text{HCOOH}\) first and the all-hydrogen carbon of \(\text{CH}_4\) last, the reverse of the requested least-to-most order. (Choice C) This ranks \(\text{CH}_3\text{OH}\) below \(\text{CH}_4\), but \(\text{CH}_4\) has zero bonds to oxygen (oxidation number \(-4\)) versus one for \(\text{CH}_3\text{OH}\) (\(-2\)), so the alkane is the more reduced and belongs first. This is a Scientific Reasoning and Problem Solving question because you must assign each carbon an oxidation level from its bonds to oxygen and hydrogen and then sequence the four structures.', 'hard', '5D', 'Structure, function, and reactivity of biologically relevant molecules', 'organic-chemistry', 2, 150)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'process_step_confusion', 'swaps alcohol and carbonyl positions' FROM q
  UNION ALL
  SELECT id, 'B', 'reversed_relationship', 'most-to-least instead of least-to-most' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'misranks alkane below alcohol' FROM q;

-- Q21 [D21 · Common Names & Carbonyl Structure] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('chem_phys', 'Functional Groups & Nomenclature', 'Common Names & Carbonyl Structure', 'An ester forms when a carboxylic acid and an alcohol condense with loss of water; the acyl (\(\text{C=O}\)) side of the product comes from the acid and the \(\text{-OR}\) side from the alcohol. Which acid-and-alcohol pair combined to form the ester \(\text{CH}_3\text{CH}_2\text{C(=O)OCH}_3\)?', '[{"label": "A", "text": "Propanoic acid \\(\\text{CH}_3\\text{CH}_2\\text{COOH}\\) and methanol \\(\\text{CH}_3\\text{OH}\\)"}, {"label": "B", "text": "Acetic acid \\(\\text{CH}_3\\text{COOH}\\) and ethanol \\(\\text{CH}_3\\text{CH}_2\\text{OH}\\)"}, {"label": "C", "text": "Propanoic acid \\(\\text{CH}_3\\text{CH}_2\\text{COOH}\\) and ethanol \\(\\text{CH}_3\\text{CH}_2\\text{OH}\\)"}, {"label": "D", "text": "Formic acid \\(\\text{HCOOH}\\) and 1-propanol \\(\\text{CH}_3\\text{CH}_2\\text{CH}_2\\text{OH}\\)"}]'::jsonb, 'A', 'This is an Organic Chemistry question that falls under the content category ''Structure, function, and reactivity of biologically relevant molecules''. The answer to this question is A because the ester splits at the single-bonded oxygen: the acyl side \(\text{CH}_3\text{CH}_2\text{C(=O)}-\) keeps three carbons and, on restoring the \(\text{-OH}\) it lost, regenerates propanoic acid \(\text{CH}_3\text{CH}_2\text{COOH}\), while the \(\text{-OCH}_3\) side, on restoring an H, regenerates methanol \(\text{CH}_3\text{OH}\). (Choice B) Acetic acid plus ethanol condenses to ethyl acetate, \(\text{CH}_3\text{C(=O)OCH}_2\text{CH}_3\); although it is an isomer with the same molecular formula, its acyl group has two carbons and its alkoxy group two, not the 3-plus-1 split shown. (Choice C) Propanoic acid supplies the correct three-carbon acyl group, but ethanol would furnish an \(\text{-OCH}_2\text{CH}_3\) alkoxy group, whereas the structure shows a one-carbon \(\text{-OCH}_3\), so the alcohol is wrong. (Choice D) Formic acid plus 1-propanol reverses the roles, placing the one-carbon fragment on the acyl (\(\text{C=O}\)) side and the three-carbon fragment on the alkoxy side, the opposite of the \(\text{CH}_3\text{CH}_2\text{C(=O)}-\) / \(\text{-OCH}_3\) arrangement shown. This is a Scientific Reasoning and Problem Solving question because you must disconnect the ester at the correct bond and reason backward to the parent acid and alcohol fragments.', 'hard', '5D', 'Structure, function, and reactivity of biologically relevant molecules', 'organic-chemistry', 2, 150)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'process_step_confusion', 'isomeric ester from a 2+2 carbon split (ethyl acetate)' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'correct acid, wrong alcohol (ethanol not methanol)' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'acid and alcohol fragments reversed' FROM q;

-- Q22 [D22 · Common Names & Carbonyl Structure] medium skill1 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('chem_phys', 'Functional Groups & Nomenclature', 'Common Names & Carbonyl Structure', 'Amide linkages form the peptide bonds of proteins. Which of the following condensed structures represents an N-substituted amide?', '[{"label": "A", "text": "\\(\\text{CH}_3\\text{C(=O)NH}_2\\)"}, {"label": "B", "text": "\\(\\text{CH}_3\\text{C(=O)NHCH}_3\\)"}, {"label": "C", "text": "\\(\\text{CH}_3\\text{C(=O)OCH}_3\\)"}, {"label": "D", "text": "\\(\\text{CH}_3\\text{CH}_2\\text{NHCH}_3\\)"}]'::jsonb, 'B', 'This Organic Chemistry item falls under the content category ''Structure, function, and reactivity of biologically relevant molecules''. The answer to this question is B because \(\text{CH}_3\text{C(=O)NHCH}_3\) contains the amide linkage — an acyl carbonyl carbon (\(\text{C=O}\)) bonded to nitrogen — and that nitrogen carries a methyl group in addition to one hydrogen; the alkyl group sitting directly on the amide nitrogen is what makes it N-substituted (a secondary amide). (Choice A) \(\text{CH}_3\text{C(=O)NH}_2\) is also an amide, but its nitrogen bears only hydrogens, so it is an unsubstituted (primary) amide rather than an N-substituted one. (Choice C) \(\text{CH}_3\text{C(=O)OCH}_3\) places the alkyl group on oxygen; a carbonyl bonded to \(\text{-OR}\) is an ester, which has no amide nitrogen at all. (Choice D) \(\text{CH}_3\text{CH}_2\text{NHCH}_3\) has an alkyl-bearing nitrogen but lacks an adjacent \(\text{C=O}\); without the carbonyl it is a secondary amine, not an amide. Recognizing the amide carbonyl–nitrogen linkage and locating an alkyl substituent specifically on that nitrogen makes this a Knowledge of Scientific Concepts and Principles question.', 'medium', '5D', 'Structure, function, and reactivity of biologically relevant molecules', 'organic-chemistry', 1, 110)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'partial_truth', 'amide with nitrogen bearing only H (unsubstituted)' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'ester: alkyl on oxygen, not nitrogen' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'N-alkyl present but no carbonyl, an amine' FROM q;

-- Q23 [D23 · Common Names & Carbonyl Structure] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('chem_phys', 'Functional Groups & Nomenclature', 'Common Names & Carbonyl Structure', 'A compound''s only \(\text{C=O}\) lies on the terminal (C1) carbon of its chain, and that same carbon is also bonded to an \(\text{-OH}\). Reasoning from the carbonyl''s position and its substituent, this compound is classified as which of the following?', '[{"label": "A", "text": "An aldehyde"}, {"label": "B", "text": "A ketone"}, {"label": "C", "text": "A carboxylic acid"}, {"label": "D", "text": "An ester"}]'::jsonb, 'C', 'This is an Organic Chemistry question that falls under the content category ''Structure, function, and reactivity of biologically relevant molecules''. The answer to this question is C because a terminal carbonyl carbon that also bears a hydroxyl on that same carbon constitutes the \(\text{-COOH}\) group, the defining feature of a carboxylic acid; the C1 position together with the \(\text{-OH}\) substituent forces the carboxylic-acid classification. (Choice A) An aldehyde likewise has a terminal carbonyl, but its carbonyl carbon bears a hydrogen (\(\text{R-CHO}\)) rather than a hydroxyl, and the \(\text{-OH}\) present here rules the aldehyde out. (Choice B) A ketone requires the carbonyl carbon to sit internally, bonded to two other carbons (\(\text{R-CO-R}''\)); a terminal C1 carbonyl cannot be a ketone. (Choice D) An ester carries an \(\text{-OR}\) (alkoxy) group on the carbonyl carbon, whereas the carbon described here holds an \(\text{-OH}\), making it the parent acid rather than an ester. This is a Scientific Reasoning and Problem Solving question because you must combine the carbonyl''s chain position with its attached substituent to deduce the functional-group class.', 'medium', '5D', 'Structure, function, and reactivity of biologically relevant molecules', 'organic-chemistry', 2, 110)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'partial_truth', 'terminal carbonyl but with H would be aldehyde' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'ketone needs an internal carbonyl bonded to two carbons' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'ester carries -OR, not the -OH shown' FROM q;

-- Q24 [D24 · Common Names & Carbonyl Structure] hard skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('chem_phys', 'Functional Groups & Nomenclature', 'Common Names & Carbonyl Structure', 'The target molecule ethyl acetate, \(\text{CH}_3\text{C(=O)OCH}_2\text{CH}_3\), belongs to a particular functional-group class. Which of the following molecules belongs to the same functional-group class as the target?', '[{"label": "A", "text": "\\(\\text{CH}_3\\text{CH}_2\\text{COOH}\\)"}, {"label": "B", "text": "\\(\\text{CH}_3\\text{C(=O)CH}_2\\text{CH}_3\\)"}, {"label": "C", "text": "\\(\\text{CH}_3\\text{C(=O)NHCH}_3\\)"}, {"label": "D", "text": "\\(\\text{CH}_3\\text{CH}_2\\text{C(=O)OCH}_3\\)"}]'::jsonb, 'D', 'This is an Organic Chemistry question that falls under the content category ''Structure, function, and reactivity of biologically relevant molecules''. The answer to this question is D because the target ethyl acetate is an ester, marked by a carbonyl carbon bonded through an oxygen to another carbon (\(\text{C(=O)-O-C}\)); \(\text{CH}_3\text{CH}_2\text{C(=O)OCH}_3\) contains that same acyl-oxygen-carbon linkage, so it is likewise an ester. (Choice A) \(\text{CH}_3\text{CH}_2\text{COOH}\) also has a carbonyl bonded to oxygen, but that oxygen carries an H (\(\text{-OH}\)), making it a carboxylic acid rather than an ester. (Choice B) \(\text{CH}_3\text{C(=O)CH}_2\text{CH}_3\) has its carbonyl carbon bonded to two carbons and no oxygen, the pattern of a ketone. (Choice C) \(\text{CH}_3\text{C(=O)NHCH}_3\) bonds its carbonyl carbon to nitrogen, making it an amide, not an ester. This is a Scientific Reasoning and Problem Solving question because you must first classify the target molecule and then classify each candidate to find the one that matches.', 'hard', '5D', 'Structure, function, and reactivity of biologically relevant molecules', 'organic-chemistry', 2, 150)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'partial_truth', 'carbonyl with -OH is an acid, not an ester' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'carbonyl bonded to two carbons is a ketone' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'carbonyl bonded to nitrogen is an amide' FROM q;

COMMIT;
