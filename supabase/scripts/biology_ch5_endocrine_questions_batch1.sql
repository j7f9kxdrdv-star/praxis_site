-- The Endocrine System — Batch 1 — Mechanisms of Hormone Action
-- Original Praxist Prep questions, grounded in the subject reference textbook; scope verified vs AAMC 2026 outline.
-- Idempotent: deletes only this batch's subtopics, then re-inserts. question_attempts / distractor_metadata cascade.

DELETE FROM questions WHERE topic = 'The Endocrine System' AND subtopic IN ('Hormone Classes & Chemistry', 'Receptors & Signal Transduction', 'Second Messengers & Amplification');

-- Q1 [Hormone Classes & Chemistry] easy skill1 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'The Endocrine System', 'Hormone Classes & Chemistry', 'A researcher studies a hormone whose biosynthesis begins with cholesterol as its structural precursor. Which hormone fits this description?', '[{"label": "A", "text": "Cortisol"}, {"label": "B", "text": "Epinephrine"}, {"label": "C", "text": "Insulin"}, {"label": "D", "text": "Thyroxine"}]'::jsonb, 'A', 'This is a Biology question that falls under the content category ''Endocrine System: Mechanisms of Hormone Action.''

The answer is A because cortisol is a steroid hormone, and steroid hormones are the class derived from the lipid cholesterol. Cortisol is produced by the adrenal cortex and, like all steroids, is built by chemically modifying the cholesterol backbone. A hormone whose synthesis begins with cholesterol as its precursor is therefore a steroid.

(Choice A) is correct: Cortisol is a steroid hormone derived from cholesterol, matching the described precursor.

(Choice B) is incorrect: Epinephrine is an amine hormone synthesized from the amino acid tyrosine, not from cholesterol; it is secreted by the adrenal medulla, so associating any adrenal hormone with cholesterol is the error.

(Choice C) is incorrect: Insulin is a peptide/protein hormone assembled from a chain of amino acids via transcription and translation, not from a lipid precursor.

(Choice D) is incorrect: Thyroxine is an amine hormone derived from tyrosine; although it is lipid-soluble like steroids, its precursor is an amino acid rather than cholesterol.

As a Skill 1 item, this question asks the student to recall the defining chemical precursor of each hormone class and identify the hormone that belongs to the steroid class.', 'easy', '3A', 'Endocrine System: Mechanisms of Hormone Action', 'biology', 1, 45, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'adrenal-gland-implies-steroid' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'default-to-familiar-hormone' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'lipid-soluble-implies-cholesterol-derived' FROM q;

-- Q2 [Hormone Classes & Chemistry] easy skill1 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'The Endocrine System', 'Hormone Classes & Chemistry', 'A researcher is grouping hormones by their chemical class based on how they are synthesized. Which of the following is a peptide/protein hormone rather than a steroid or amine hormone?', '[{"label": "A", "text": "Aldosterone"}, {"label": "B", "text": "Insulin"}, {"label": "C", "text": "Epinephrine"}, {"label": "D", "text": "Melatonin"}]'::jsonb, 'B', 'This is a Biology question that falls under the content category ''Endocrine System: Mechanisms of Hormone Action.'' The answer is B because insulin is a peptide/protein hormone: peptide and protein hormones consist of multiple amino acids linked into a chain (protein hormones being longer polypeptides), and OpenStax classifies pancreatic insulin as a protein hormone that reduces blood glucose. (Choice B) is correct: insulin is built as a chain of amino acids, synthesized like other body proteins (DNA to mRNA to polypeptide), which places it in the peptide/protein class. (Choice A) is incorrect: aldosterone is a steroid hormone produced by the adrenal cortex and, like all steroids, is derived from the lipid cholesterol, not from amino acid chains. (Choice C) is incorrect: epinephrine is an amine hormone, a tyrosine-derived catecholamine secreted by the adrenal medulla, so it is made by modifying a single amino acid rather than linking many. (Choice D) is incorrect: melatonin is an amine hormone derived from the amino acid tryptophan and secreted by the pineal gland, making it an amine rather than a peptide/protein. As a Skill 1 item, this question asks you to recall the chemical class of each named hormone and identify the one that belongs to the peptide/protein category.', 'easy', '3A', 'Endocrine System: Mechanisms of Hormone Action', 'biology', 1, 45, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'confuses a steroid hormone for a peptide hormone' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'confuses a tyrosine-derived amine (catecholamine) for a peptide hormone' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'confuses a tryptophan-derived amine for a peptide hormone' FROM q;

-- Q3 [Hormone Classes & Chemistry] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'The Endocrine System', 'Hormone Classes & Chemistry', 'A mutation eliminates the protease that matures a cell''s peptide-hormone precursor inside its secretory vesicles. Transcription, translation, vesicle packaging, and the exocytosis triggered by the normal stimulus all still occur. What is the most likely fate and effect of the molecule the cell releases?', '[{"label": "A", "text": "It gains the ability to cross target-cell membranes directly"}, {"label": "B", "text": "Its secretion is blocked because exocytosis requires the cleavage step"}, {"label": "C", "text": "It is still secreted but cannot activate its target receptors"}, {"label": "D", "text": "It is redirected to lysosomes and degraded before release"}]'::jsonb, 'C', 'This is a Biology question that falls under the content category ''Endocrine System: Mechanisms of Hormone Action.''

The answer is C because peptide hormones are synthesized as larger inactive precursors (prohormones) that must be proteolytically cleaved to yield the mature, functional hormone, yet this activating cleavage is a separate event from the vesicle packaging and exocytosis that release the molecule. In OpenStax A&P 2e, the pro-opiomelanocortin (POMC) precursor produces active molecules such as ACTH and MSH only ''when cleaved.'' The stem specifies that packaging and stimulus-triggered exocytosis proceed normally, so a molecule is still secreted; because the maturation step never happens, that molecule is the uncleaved precursor, which lacks the mature hormone''s activity and therefore cannot activate its target receptors.

(Choice C) is correct: exocytosis is triggered by the stimulus and does not depend on the intravesicular cleavage, so the precursor is still released; lacking the mature active form, it cannot productively engage its receptors.

(Choice B) is incorrect: vesicle packaging and stimulus-triggered exocytosis are upstream of, and independent of, the intravesicular maturation step. OpenStax Biology 2e notes that secreted peptides such as insulin are stored in vesicles and released in response to a stimulus; losing the activating protease does not block that release, and the stem states packaging and exocytosis occur normally.

(Choice A) is incorrect: peptide hormones are water-soluble and cannot diffuse across the lipid plasma membrane, which is why they act through cell-surface receptors; removing a maturation protease does not confer lipid solubility on the uncleaved precursor.

(Choice D) is incorrect: the molecule has already entered the regulated secretory pathway (packaged into secretory vesicles per the stem), and loss of the activating protease provides no signal to reroute the vesicle contents to lysosomes for degradation; it is exocytosed, not degraded before release.

At the Skill 2 level, this item requires reasoning from a described processing pathway to predict a downstream consequence, distinguishing the effect of blocking one specific step (activating cleavage) from the packaging and exocytosis steps that proceed normally, rather than recalling a definition.', 'medium', '3A', 'Endocrine System: Mechanisms of Hormone Action', 'biology', 2, 75, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'process_step_confusion', 'Assuming exocytosis depends on the intravesicular activating cleavage, so blocking cleavage blocks secretion' FROM q
  UNION ALL
  SELECT id, 'A', 'misconception', 'Believing a water-soluble peptide can diffuse across the lipid membrane like a steroid' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'Mis-sorting the regulated-secretory-pathway cargo to the lysosomal degradation pathway' FROM q;

-- Q4 [Hormone Classes & Chemistry] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'The Endocrine System', 'Hormone Classes & Chemistry', 'A newly characterized adrenal hormone partitions readily into cell membranes yet is nearly insoluble in plasma on its own. Based on this chemistry, how does the hormone most likely travel through the blood to its target tissues?', '[{"label": "A", "text": "Escorted by a membrane channel protein"}, {"label": "B", "text": "Dissolved freely in the aqueous plasma"}, {"label": "C", "text": "Packaged inside secretory vesicles in blood"}, {"label": "D", "text": "Carried bound to a plasma transport protein"}]'::jsonb, 'D', 'This is a Biology question that falls under the content category ''Endocrine System: Mechanisms of Hormone Action.''

The answer is D because a hormone that partitions into membranes and is nearly insoluble in plasma is lipophilic (hydrophobic). Since blood is a water-based fluid, such lipid-derived hormones cannot dissolve in it and must travel bound to a transport (carrier) protein that keeps them soluble in the bloodstream. This is the same solubility logic that governs steroid and thyroid hormones.

(Choice D) is correct: The described hormone is hydrophobic, so like the adrenal steroids cortisol and aldosterone, it must be carried bound to a plasma transport protein to remain soluble as it moves through the water-based blood to its targets.

(Choice B) is incorrect: Dissolving freely in aqueous plasma is how hydrophilic peptide and amine hormones travel; a hormone insoluble in plasma cannot use this route, so applying the water-soluble rule here reverses the correct relationship.

(Choice C) is incorrect: Secretory vesicles do store and release many hormones from the secreting cell, but this is an intracellular pre-release step; hormones do not remain packaged in vesicles while circulating in the blood.

(Choice A) is incorrect: Membrane channel proteins move solutes across a single plasma membrane; they are not free-floating blood carriers and do not shuttle hormones through the circulation between distant tissues.

This item requires Skill 2 reasoning: the student must infer the transport requirement from the hormone''s stated solubility rather than recall a labeled hormone class.', 'medium', '3A', 'Endocrine System: Mechanisms of Hormone Action', 'biology', 2, 75, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'Applies the water-soluble (peptide/amine) free-dissolution rule to a lipophilic hormone, reversing the solubility-to-transport relationship' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'Confuses intracellular secretory-vesicle storage/release with the mode of transport through circulating blood' FROM q
  UNION ALL
  SELECT id, 'A', 'misconception', 'Conflates a transmembrane channel/carrier that moves solutes across one membrane with a plasma blood-transport carrier protein' FROM q;

-- Q5 [Hormone Classes & Chemistry] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'The Endocrine System', 'Hormone Classes & Chemistry', 'A researcher isolates a hormone that the adrenal medulla synthesizes by modifying a single tyrosine molecule into a catecholamine, then releases into the bloodstream during acute stress. Which hormone did the researcher most likely isolate?', '[{"label": "A", "text": "Thyroxine"}, {"label": "B", "text": "Epinephrine"}, {"label": "C", "text": "Melatonin"}, {"label": "D", "text": "Cortisol"}]'::jsonb, 'B', 'This is a Biology question that falls under the content category ''Endocrine System: Mechanisms of Hormone Action.''

The answer is B because epinephrine is the catecholamine synthesized in the adrenal medulla from a single molecule of the amino acid tyrosine and released systemically during acute stress. The described features—an adrenal medulla origin, a single-tyrosine precursor, catecholamine chemistry, and stress-triggered systemic release—together identify a catecholamine, and epinephrine is the medulla''s dominant catecholamine hormone.

(Choice B) is correct: epinephrine is a tyrosine-derived catecholamine produced by chromaffin cells of the adrenal medulla and secreted into the circulation in response to danger or stress, matching every element of the scenario.

(Choice A) is incorrect: thyroxine is also derived from tyrosine, but it is synthesized in the thyroid gland (from iodinated tyrosine residues), not the adrenal medulla, and it is a thyroid hormone rather than a catecholamine.

(Choice C) is incorrect: melatonin is an amine hormone, but it is derived from tryptophan and secreted by the pineal gland to regulate circadian rhythm, so its precursor, gland, and chemical class all fail to match.

(Choice D) is incorrect: cortisol is produced by the adrenal cortex and is a steroid hormone derived from cholesterol, not an amino acid, so it is neither a catecholamine nor tyrosine-derived despite its adrenal association.

This item requires Skill 2 reasoning: the student must integrate the described precursor, source gland, and chemical class to identify the hormone rather than recalling a single stated fact.', 'medium', '3A', 'Endocrine System: Mechanisms of Hormone Action', 'biology', 2, 75, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'partial_truth', 'Correct precursor (tyrosine) but wrong source gland and hormone class' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'Also an amine hormone but derived from tryptophan in the pineal gland' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'Adrenal-associated hormone assumed to share catecholamine chemistry, but it is a cholesterol-derived steroid from the cortex' FROM q;

-- Q6 [Hormone Classes & Chemistry] hard skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'The Endocrine System', 'Hormone Classes & Chemistry', 'An unknown hormone is water-soluble, produces its full effect within seconds, and is completely blocked by an antagonist that cannot cross the plasma membrane; chemically, it is built by modifying a single amino acid. To which class does it most likely belong?', '[{"label": "A", "text": "Thyroid hormone"}, {"label": "B", "text": "Peptide or protein hormone"}, {"label": "C", "text": "Amine hormone"}, {"label": "D", "text": "Steroid hormone"}]'::jsonb, 'C', 'This is a Biology question that falls under the content category ''Endocrine System: Mechanisms of Hormone Action.''

The answer is C because only an amine hormone satisfies every clue simultaneously. Water solubility and a membrane-impermeant blocker that fully abolishes the effect together require a receptor exposed on the cell surface, since a blocker unable to enter the cell can only work if the target receptor is extracellular; this rules out any hormone that acts through an intracellular receptor. Action within seconds is incompatible with the gene-transcription-and-translation pathway used by intracellular receptors, which takes far longer. Finally, being built by modifying a single amino acid distinguishes amine hormones (derived from tyrosine or tryptophan) from hormones made of amino acid chains. Catecholamines such as epinephrine fit all four properties: they are hydrophilic, act via surface receptors and second messengers, work rapidly (epinephrine''s half-life is about one minute), and are single-amino-acid derivatives.

(Choice C) is correct: amine hormones like the catecholamines are water-soluble single-amino-acid derivatives that bind surface receptors and trigger rapid second-messenger responses, matching all four measured properties.

(Choice B) is incorrect: peptide and protein hormones are indeed water-soluble, surface-receptor-binding, and fast-acting, so they match three clues, but they are chains of multiple amino acids rather than a single modified amino acid, which the stem explicitly excludes.

(Choice A) is incorrect: thyroid hormone is a single-amino-acid (tyrosine) derivative, matching that one clue, but it is lipid-soluble and acts through intracellular receptors that drive gene transcription, so it would neither be blocked by a membrane-impermeant antagonist nor act within seconds.

(Choice D) is incorrect: steroid hormones do require a receptor, which may tempt a student who forgets that steroid receptors are intracellular, but steroids are lipid-soluble, derived from cholesterol rather than an amino acid, and act slowly through gene transcription, contradicting the solubility, speed, and surface-receptor clues.

As a Skill 2 item, this question requires combining several measured properties and eliminating classes that satisfy only some of them, rather than recalling a single stated fact.', 'hard', '3A', 'Endocrine System: Mechanisms of Hormone Action', 'biology', 2, 100, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'partial_truth', 'matches-solubility-speed-and-surface-receptor-but-fails-single-amino-acid-origin' FROM q
  UNION ALL
  SELECT id, 'A', 'partial_truth', 'matches-single-amino-acid-origin-but-lipid-soluble-and-intracellular-slow' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'believes-all-hormone-receptors-are-on-the-cell-surface' FROM q;

-- Q7 [Hormone Classes & Chemistry] easy skill1 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'The Endocrine System', 'Hormone Classes & Chemistry', 'Four hormones are compared, and for each only its site and mode of synthesis is given. A researcher wants to identify the single hormone that, once secreted, cannot dissolve freely in the aqueous plasma and must instead travel through the bloodstream bound to a transport protein. Which hormone fits this description?', '[{"label": "A", "text": "Oxytocin, synthesized as a short peptide in the hypothalamus"}, {"label": "B", "text": "Glucagon, synthesized as a polypeptide in the pancreatic alpha cells"}, {"label": "C", "text": "Insulin, synthesized as a polypeptide in the pancreatic beta cells"}, {"label": "D", "text": "Aldosterone, synthesized from cholesterol in the adrenal cortex"}]'::jsonb, 'D', 'This is a Biology question that falls under the content category ''Endocrine System: Mechanisms of Hormone Action.''

The correct answer is D. A hormone that cannot dissolve freely in the water-based plasma and must be carried bound to a transport protein is one that is hydrophobic (lipid-soluble). Hormones synthesized from cholesterol are steroids, and like cholesterol they are not soluble in water. Because blood is water-based, such lipid-derived hormones cannot circulate dissolved in plasma and must travel bound to a carrier (transport) protein. Aldosterone is synthesized from cholesterol in the adrenal cortex, so it is a steroid and is the hormone that requires a carrier protein in circulation. The other three options are hormones built from amino acids (polypeptides or short peptides), which are water-soluble and therefore dissolve freely in plasma without a carrier.

(Choice D) is correct: aldosterone is synthesized from cholesterol, making it a hydrophobic steroid hormone. Steroid hormones are not soluble in water, so in the aqueous plasma they must be transported bound to a carrier protein, exactly matching the described behavior.

(Choice B) is incorrect: glucagon is synthesized as a polypeptide (a chain of amino acids) in the pancreatic alpha cells. Amino-acid-based hormones are water-soluble, so glucagon dissolves freely in plasma and does not require a carrier protein.

(Choice C) is incorrect: insulin is synthesized as a polypeptide in the pancreatic beta cells. As a water-soluble peptide hormone, insulin circulates dissolved directly in the plasma rather than bound to a transport protein.

(Choice A) is incorrect: oxytocin is synthesized as a short peptide in the hypothalamus. Being a small water-soluble peptide, it dissolves freely in the bloodstream and does not need a carrier protein for transport.

This item assesses Skill 1 (Knowledge of Scientific Concepts and Principles): it requires recognizing that cholesterol-derived (steroid) hormones are hydrophobic and therefore carrier-dependent in circulation, whereas amino-acid-based peptide hormones are water-soluble and travel dissolved in plasma.', 'easy', '3A', 'Endocrine System: Mechanisms of Hormone Action', 'biology', 1, 60, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'Treats a water-soluble polypeptide hormone as if it were carrier-dependent, ignoring that amino-acid-based hormones dissolve freely in plasma' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'Assumes a well-known peptide hormone (insulin) must be transported bound to a carrier protein, overlooking its hydrophilic nature' FROM q
  UNION ALL
  SELECT id, 'A', 'adjacent_fact', 'Selects a small peptide hormone, confusing peptide size or hypothalamic origin with lipid-solubility and carrier dependence' FROM q;

-- Q8 [Hormone Classes & Chemistry] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'The Endocrine System', 'Hormone Classes & Chemistry', 'A researcher applies a drug that irreversibly disables intracellular (cytoplasmic and nuclear) hormone receptors while leaving cell-surface receptors intact. Signaling by which of the following hormones is most likely to be lost?', '[{"label": "A", "text": "Thyroxine, an iodinated tyrosine derivative"}, {"label": "B", "text": "Epinephrine, a catecholamine from the adrenal medulla"}, {"label": "C", "text": "Melatonin, a tryptophan derivative from the pineal gland"}, {"label": "D", "text": "Antidiuretic hormone, a peptide from the pituitary"}]'::jsonb, 'A', 'This is a Biology question that falls under the content category ''Endocrine System: Mechanisms of Hormone Action.''

The answer is A because a hormone''s signaling is abolished by disabling intracellular receptors only if that hormone normally acts through an intracellular receptor. Thyroxine (T4) is an amino acid derivative built from tyrosine, yet it is lipid-soluble; like steroid hormones, it diffuses (via a carrier-mediated step) across the plasma membrane and binds receptors inside the cell that regulate gene transcription. Because thyroid hormone is the one amine that relies on intracellular receptors, disabling those receptors selectively silences its action while sparing the other listed hormones, which all act at the cell surface.

(Choice B) is incorrect: Epinephrine is a water-soluble catecholamine that cannot cross the membrane; it binds cell-surface receptors coupled to G proteins and second messengers, so intracellular receptors are irrelevant to its signaling.

(Choice A) is correct: Thyroxine is amino acid-derived but lipid-soluble, so it acts through intracellular receptors bound to DNA; disabling those receptors abolishes its transcriptional effect.

(Choice C) is incorrect: Melatonin is a water-soluble amine derived from tryptophan; like other amines except thyroid hormone, it signals through membrane surface receptors and is unaffected by loss of intracellular receptors.

(Choice D) is incorrect: Antidiuretic hormone is a hydrophilic peptide that cannot diffuse through the membrane and therefore binds a surface receptor, leaving its pathway intact when intracellular receptors are disabled.

Skill 2: rather than recalling a definition, the student must map each hormone''s chemistry to its receptor location and recognize that thyroxine is the amine exception that behaves like a steroid, using the experimental manipulation to isolate the one intracellular-receptor pathway.', 'hard', '3A', 'Endocrine System: Mechanisms of Hormone Action', 'biology', 2, 90, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'All amine hormones use surface receptors (treats the amine class as uniform, ignoring the thyroid exception)' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'Amine derived from an aromatic amino acid must signal like thyroxine (over-generalizes lipid-solubility to all amines)' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'Peptide hormone mistaken as membrane-permeant intracellular-receptor agonist' FROM q;

-- Q9 [Receptors & Signal Transduction] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'The Endocrine System', 'Receptors & Signal Transduction', 'A hormone that a cell synthesizes from cholesterol reaches a target tissue and, over several hours, changes the amounts of specific proteins the cells produce. The effect is abolished if the cells are pretreated with a drug that blocks RNA polymerase, but is unaffected by drugs that block adenylyl cyclase or protein kinase A. Which mechanism best accounts for how this hormone acts on its target cells?', '[{"label": "A", "text": "It opens a ligand-gated ion channel, and the resulting ion influx changes membrane potential"}, {"label": "B", "text": "It binds a G protein-coupled receptor that raises cyclic AMP to activate protein kinase A"}, {"label": "C", "text": "It diffuses across the plasma membrane and binds a receptor that acts as a transcription factor"}, {"label": "D", "text": "It binds a surface receptor tyrosine kinase that phosphorylates cytoplasmic proteins"}]'::jsonb, 'C', 'This is a Biology question that falls under the content category ''Endocrine System: Mechanisms of Hormone Action.''

The answer is C because two independent clues converge on an intracellular, transcription-based mechanism. First, the hormone is made from cholesterol, so it is lipid-soluble and can diffuse directly through the plasma membrane rather than needing a surface receptor. Second, the response is slow (hours) and is eliminated specifically by a drug that blocks RNA polymerase, showing that the effect depends on new gene transcription. A cholesterol-derived (steroid) hormone crosses the membrane, binds a receptor in the cytosol or nucleus, and the hormone-receptor complex binds DNA and acts as a transcription factor to change which target genes are transcribed. The insensitivity to adenylyl cyclase and protein kinase A inhibitors further rules out a cyclic-AMP surface pathway.

(Choice C) is correct: a lipid-soluble, cholesterol-derived hormone diffuses through the bilayer and binds an intracellular receptor whose hormone-receptor complex regulates gene transcription, which explains both the requirement for RNA polymerase and the independence from the cAMP cascade.

(Choice B) is incorrect: a G protein-coupled receptor raising cyclic AMP to activate protein kinase A is the pathway of water-soluble hormones; it would be disrupted by the adenylyl cyclase and protein kinase A inhibitors, which the data show have no effect, and it phosphorylates existing proteins rather than requiring RNA polymerase.

(Choice A) is incorrect: a ligand-gated ion channel is a surface receptor that admits ions and changes membrane potential on a timescale of milliseconds; it does not require new transcription and cannot explain a slow, RNA-polymerase-dependent change in protein levels, nor would a lipid-soluble hormone need it.

(Choice D) is incorrect: a receptor tyrosine kinase sits on the cell surface and signals by phosphorylating cytoplasmic proteins; a cholesterol-derived hormone need not use a surface receptor, and phosphorylation of existing proteins would not be abolished by blocking RNA polymerase.

This item requires Skill 2 reasoning: the student must combine the hormone''s cholesterol origin with the pharmacological result (blocked by an RNA-polymerase inhibitor, unaffected by cAMP-pathway inhibitors) to infer an intracellular transcription-factor mechanism, rather than recall a definition.', 'medium', '3A', 'Endocrine System: Mechanisms of Hormone Action', 'biology', 2, 80, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'assumes a cholesterol-derived hormone signals through a surface cAMP second-messenger cascade' FROM q
  UNION ALL
  SELECT id, 'A', 'adjacent_fact', 'confuses a real fast ionotropic surface receptor with a slow transcriptional mechanism' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'conflates surface receptor phosphorylation of existing proteins with new gene transcription' FROM q;

-- Q10 [Receptors & Signal Transduction] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'The Endocrine System', 'Receptors & Signal Transduction', 'A researcher engineers an intracellular steroid receptor so that its hormone can still bind the receptor normally, but the resulting hormone-receptor complex can no longer attach to chromatin. Which molecular event is directly lost in target cells?', '[{"label": "A", "text": "The receptor can no longer bind its steroid hormone"}, {"label": "B", "text": "Second messengers such as cAMP are no longer generated"}, {"label": "C", "text": "The hormone can no longer diffuse across the plasma membrane"}, {"label": "D", "text": "Transcription of specific target genes is no longer altered"}]'::jsonb, 'D', 'This is a Biology question that falls under the content category ''Endocrine System: Mechanisms of Hormone Action.''

The answer is D because a steroid hormone-receptor complex functions as a transcription factor: after the hormone binds its intracellular receptor, the complex translocates to the nucleus and binds a specific DNA segment to increase or decrease transcription of target genes. If the complex can no longer attach to chromatin, the one molecular consequence that is directly abolished is the complex''s regulation of target-gene transcription, so the amount of the corresponding mRNA (and downstream protein) can no longer be changed.

(Choice D) is correct: DNA binding by the hormone-receptor complex is precisely the step that triggers increased or decreased transcription of specific genes; blocking chromatin attachment removes that transcriptional regulation.

(Choice B) is incorrect: cAMP and other second messengers belong to the cell-membrane receptor pathway used by water-soluble (peptide/amine) hormones, not to the intracellular steroid receptor, which acts directly on DNA; steroid signaling does not require cAMP, so losing DNA binding does not eliminate a cAMP step that was never part of this pathway.

(Choice C) is incorrect: diffusion of the lipid-soluble steroid across the plasma membrane is an upstream event that depends on the hormone''s hydrophobic character, not on the receptor''s chromatin-binding domain; the hormone would still cross the membrane and bind the receptor normally.

(Choice A) is incorrect: hormone binding and DNA binding are distinct receptor functions, and the scenario specifies that hormone binding is preserved; the engineered defect lies in chromatin attachment, so the receptor still recognizes and binds its steroid.

As a Skill 2 item, this question asks the student to apply the mechanism of intracellular steroid receptors to a novel loss-of-function scenario, predicting the specific molecular consequence rather than recalling a definition.', 'medium', '3A', 'Endocrine System: Mechanisms of Hormone Action', 'biology', 2, 80, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'Applying the water-soluble hormone second-messenger (cAMP) cascade to a steroid hormone, which instead acts directly through an intracellular receptor' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'Confusing an upstream step (membrane diffusion of the lipid-soluble hormone) with the receptor''s downstream DNA-binding function' FROM q
  UNION ALL
  SELECT id, 'A', 'reversed_relationship', 'Conflating the receptor''s separate hormone-binding and DNA-binding domains, ignoring that the scenario preserves hormone binding' FROM q;

-- Q11 [Receptors & Signal Transduction] easy skill1 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'The Endocrine System', 'Receptors & Signal Transduction', 'A physiologist compares how two hormones act on a hepatocyte: glucagon (secreted by pancreatic alpha cells) and cortisol (secreted by the adrenal cortex). Only one of these hormones initiates its cellular response by binding a receptor at the cell surface. Which statement correctly describes glucagon''s mechanism of action in the hepatocyte?', '[{"label": "A", "text": "It binds a plasma membrane receptor and triggers a cAMP second-messenger cascade"}, {"label": "B", "text": "It enters the cell and binds a cytosolic receptor that then moves to the DNA"}, {"label": "C", "text": "It binds a receptor already bound to DNA in the nucleus"}, {"label": "D", "text": "It directly activates adenylyl cyclase without first binding a receptor"}]'::jsonb, 'A', 'This is a Biology question that falls under the content category ''Endocrine System: Mechanisms of Hormone Action.''

The answer is A because glucagon is a peptide (amino acid-derived) hormone. Such hormones are water-soluble and cannot diffuse through the lipid bilayer, so they act as an extracellular first messenger that binds a receptor on the cell surface. For glucagon, this receptor is coupled through a G protein to adenylyl cyclase, generating the second messenger cyclic AMP (cAMP), which activates protein kinases inside the cell. Cortisol, a steroid, is the hormone in the pair that instead diffuses through the membrane, so glucagon is the surface-acting hormone.

(Choice A) is correct: as a water-soluble peptide hormone, glucagon binds a cell membrane receptor and initiates the cAMP second-messenger system (OpenStax lists glucagon among hormones that use cAMP).

(Choice B) is incorrect: entering the cell to bind a cytosolic receptor that then moves to the DNA describes the STEROID pathway (e.g., cortisol), not a peptide hormone. Glucagon cannot cross the membrane to reach a cytosolic receptor.

(Choice C) is incorrect: binding a receptor already bound to DNA in the nucleus describes THYROID hormone action, a lipid-soluble pathway. Glucagon is a peptide and never enters the nucleus.

(Choice D) is incorrect: glucagon does not act on adenylyl cyclase directly; it binds the membrane receptor, and only then does the associated G protein activate adenylyl cyclase. The hormone is a first messenger that binds the receptor, not the downstream enzyme.

Skill 1 is assessed here because the question requires recalling and applying the relationship between a peptide hormone''s water solubility and its surface receptor plus cAMP second-messenger mechanism.', 'easy', '3A', 'Endocrine System: Mechanisms of Hormone Action', 'biology', 1, 50, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'applying the steroid (lipid-soluble) cytosolic-receptor/DNA pathway to a water-soluble peptide hormone' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'applying the thyroid-hormone DNA-bound-receptor pathway to a peptide hormone' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'mistaking a downstream enzyme (adenylyl cyclase) in glucagon''s own cascade for the hormone''s direct binding target' FROM q;

-- Q12 [Receptors & Signal Transduction] hard skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'The Endocrine System', 'Receptors & Signal Transduction', 'In an isolated tissue, a hormone triggers a rapid contraction that decays within seconds, and this response is fully blocked by a receptor antagonist engineered so that it cannot cross the plasma membrane. Which classification of the hormone is most consistent with these observations?', '[{"label": "A", "text": "Steroid hormone acting on an intracellular receptor"}, {"label": "B", "text": "Peptide hormone acting on a cell-surface receptor"}, {"label": "C", "text": "Steroid hormone acting on a cell-surface receptor"}, {"label": "D", "text": "Thyroid hormone acting on an intracellular receptor"}]'::jsonb, 'B', 'This is a Biology question that falls under the content category ''Endocrine System: Mechanisms of Hormone Action.''

The answer is B because an antagonist that cannot cross the plasma membrane can only occupy a receptor whose binding site faces the extracellular space. Because the antagonist fully abolishes the effect, the functional receptor must sit on the cell surface, and only water-soluble hormones (peptide and other amino acid–derived hormones) use surface receptors. This matches the kinetics as well: surface receptors act through second-messenger cascades such as cAMP, which is rapidly degraded by phosphodiesterase, producing a fast onset and short duration rather than the slow, sustained gene-transcription response of intracellular receptors.

(Choice B) is correct: peptide hormones are hydrophilic, cannot diffuse through the lipid bilayer, and therefore signal through cell-surface receptors accessible to a membrane-impermeant blocker; their second-messenger action explains the rapid, short-lived contraction.

(Choice A) is incorrect: a steroid diffuses through the membrane to an intracellular receptor, which a membrane-impermeant antagonist could never reach, so the block would fail; steroid action via gene transcription is also slow, contradicting the seconds-long response.

(Choice C) is incorrect: this pairs the correct surface location with the wrong hormone class. Steroids are lipid-soluble and act on intracellular receptors, not on cell-surface receptors, so this classification is internally inconsistent even though a surface receptor is what the blocker requires.

(Choice D) is incorrect: thyroid hormones are lipid-soluble and, like steroids, bind intracellular receptors bound to DNA to drive transcription; an impermeant antagonist could not reach that receptor, and the transcriptional mechanism cannot produce a response that decays within seconds.

At the Skill 2 level, the reasoning moves from an experimental constraint—an impermeant blocker can only act on a receptor whose binding site is extracellular—together with the fast, transient kinetics, to deduce both the receptor location and the hormone class, rather than recalling a definition.', 'hard', '3A', 'Endocrine System: Mechanisms of Hormone Action', 'biology', 2, 95, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'partial_truth', 'correctly identifies an intracellular-receptor hormone class but ignores that a membrane-impermeant blocker cannot reach an intracellular receptor and that steroid action is slow' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'pairs the correct surface-receptor location with the wrong hormone class, contradicting steroid lipid-solubility' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'treats thyroid hormone as a surface-acting hormone, forgetting it is lipid-soluble and uses an intracellular DNA-bound receptor' FROM q;

-- Q13 [Receptors & Signal Transduction] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'The Endocrine System', 'Receptors & Signal Transduction', 'A hormone''s effect on a target cell first appears about two hours after exposure, persists for many hours afterward, and is completely prevented when a transcription inhibitor is applied beforehand. Which hormone class and mechanism best accounts for this time course?', '[{"label": "A", "text": "A peptide hormone acting through an IP3 second messenger"}, {"label": "B", "text": "A peptide hormone acting through a cAMP cascade"}, {"label": "C", "text": "A catecholamine acting through a surface G-protein receptor"}, {"label": "D", "text": "A steroid hormone acting through an intracellular receptor"}]'::jsonb, 'D', 'This is a Biology question that falls under the content category ''Endocrine System: Mechanisms of Hormone Action.''

The answer is D because the observed kinetics are the signature of a lipid-soluble steroid hormone. A steroid diffuses across the plasma membrane, binds an intracellular receptor, and the resulting hormone-receptor complex enters the nucleus and triggers transcription of a target gene into mRNA, which is then translated into protein. This transcription-and-translation route imposes a delay of roughly hours before an effect appears (slow onset), and because a new pool of protein is synthesized, the effect persists long after (long duration). Decisively, blocking transcription abolishes the effect, which is only possible if the mechanism depends on new gene expression.

(Choice D) is correct: a steroid hormone alters gene transcription through an intracellular receptor, producing a delayed, sustained, transcription-dependent response that matches all three observations.

(Choice B) is incorrect: a peptide hormone acting through a cAMP second-messenger cascade activates pre-existing protein kinases within seconds to minutes, and the signal ceases quickly once phosphodiesterase degrades cAMP; such a response is rapid and brief, and it does not require new transcription, so a transcription inhibitor would not abolish it.

(Choice C) is incorrect: a catecholamine such as epinephrine binds a surface G-protein-coupled receptor and acts extremely rapidly and transiently (epinephrine''s half-life is about one minute); this cannot explain a two-hour delay, a multi-hour duration, or dependence on transcription.

(Choice A) is incorrect: a peptide hormone using the IP3/calcium second-messenger system still acts through a fast, transient surface-receptor cascade that mobilizes existing calcium stores; like the cAMP pathway it is rapid, short-lived, and independent of new gene transcription.

As a Skill 2 item, this requires reasoning from the reported time course and the transcription-inhibitor result to infer the underlying hormone class and signaling mechanism, rather than recalling a definition.', 'medium', '3A', 'Endocrine System: Mechanisms of Hormone Action', 'biology', 2, 90, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'Attributes slow/durable transcription-dependent kinetics to a rapid, transient second-messenger (cAMP) pathway' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'Confuses the fastest-acting, shortest-lived hormone class (catecholamine, ~1 min half-life) with a slow, sustained response' FROM q
  UNION ALL
  SELECT id, 'A', 'adjacent_fact', 'Recognizes IP3/Ca2+ as a real second messenger but wrongly treats a surface-cascade pathway as slow and transcription-dependent' FROM q;

-- Q14 [Receptors & Signal Transduction] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'The Endocrine System', 'Receptors & Signal Transduction', 'A researcher injects a water-soluble peptide hormone into a subject and confirms that it circulates at equal concentration through the vessels of both the liver and the biceps. Only the liver alters its metabolic activity. What best accounts for this difference?', '[{"label": "A", "text": "Only hepatocytes express the membrane receptor that binds this hormone"}, {"label": "B", "text": "The biceps downregulated its receptors for this hormone"}, {"label": "C", "text": "Only hepatocytes possess the cAMP second-messenger machinery needed to relay a peptide signal"}, {"label": "D", "text": "The hormone diffuses into hepatocytes to reach an intracellular receptor but cannot cross the muscle-cell membrane"}]'::jsonb, 'A', 'This is a Biology question that falls under the content category ''Endocrine System: Mechanisms of Hormone Action.''

The answer is A because a hormone travels throughout the body in the bloodstream but affects only its target cells, meaning cells that possess receptors specific to that hormone. The stem holds delivery constant by stating the hormone reaches the liver and biceps at equal concentration, so differences in transport, distance, or blood supply cannot explain the split response. The only remaining variable that determines which tissue responds is receptor expression: hepatocytes carry the matching cell-surface receptor and can therefore bind the hormone and launch the intracellular signaling cascade, whereas the muscle fibers lack that receptor and remain unaffected even while bathed in the hormone.

(Choice A) is correct: target-tissue specificity is set by which cells express the receptor for a given hormone. A cell without the specific receptor cannot bind the hormone or transduce its signal, so it does not respond even at equal hormone concentration.

(Choice B) is incorrect: downregulation is a real process in which chronically high hormone levels cause a target cell to reduce its receptor number and become less reactive. Crucially, it presupposes that the tissue already possesses receptors and has merely lowered their count, so it can only blunt a response, not abolish it in a tissue that fundamentally has no matching receptor. Nothing in the stem indicates prior chronic exposure, and a downregulated muscle would still show some altered activity.

(Choice C) is incorrect: the cAMP second-messenger relay (G protein, adenylyl cyclase, cAMP, protein kinases) is not tissue-exclusive. This machinery is broadly shared across cell types, and skeletal muscle uses cAMP signaling for peptide hormones such as epinephrine and glucagon. Because the downstream cascade is common to both tissues, it is not the discriminating variable; specificity is determined upstream by whether the cell displays the receptor that binds this particular hormone.

(Choice D) is incorrect: a water-soluble peptide hormone cannot diffuse through the lipid bilayer of any cell, so it does not act on an intracellular receptor in hepatocytes or anywhere else — it binds a receptor on the cell surface. Intracellular receptors are used by lipid-soluble steroid and thyroid hormones, not peptides, and a muscle-cell membrane is not selectively less permeable to a peptide than a liver-cell membrane. Membrane entry is therefore not the variable that explains the difference.

This item requires Skill 2 reasoning: the student must use the scenario data to hold hormone delivery constant, then distinguish receptor expression (the true determinant of target specificity) from downstream signaling machinery and mechanism-of-action features that are shared by both tissues, rather than restating a memorized definition.', 'medium', '3A', 'Endocrine System: Mechanisms of Hormone Action', 'biology', 2, 75, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'Confusing reduced receptor number (downregulation) with the absence of receptors that defines a non-target tissue' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'Believing the shared cAMP/G-protein second-messenger cascade is tissue-specific, when receptor expression (not the downstream relay) sets target specificity' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'Applying the lipid-hormone intracellular-receptor / membrane-diffusion mechanism to a water-soluble peptide that must bind a surface receptor' FROM q;

-- Q15 [Receptors & Signal Transduction] hard skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'The Endocrine System', 'Receptors & Signal Transduction', 'A point mutation in a nuclear cortisol receptor abolishes the receptor''s DNA-binding domain while leaving its hormone-binding domain fully functional. In a cell expressing only this mutant receptor, cortisol binds the receptor normally. What is the most likely fate of the resulting hormone-receptor complex?', '[{"label": "A", "text": "It docks at the hormone response element and drives target-gene transcription as usual"}, {"label": "B", "text": "It cannot engage a hormone response element, so target-gene transcription is not initiated"}, {"label": "C", "text": "It activates adenylyl cyclase at the plasma membrane, raising cytosolic cAMP"}, {"label": "D", "text": "It binds DNA normally, but the resulting mRNA cannot be exported for translation"}]'::jsonb, 'B', 'This is a Biology question that falls under the content category ''Endocrine System: Mechanisms of Hormone Action.''

The answer is B because cortisol is a steroid hormone whose signaling proceeds in an ordered sequence: the lipid-soluble hormone diffuses across the plasma membrane, binds an intracellular receptor to form a hormone-receptor complex, and that complex then binds a specific segment of DNA (a hormone response element, HRE), which triggers transcription of a target gene to mRNA and subsequent protein synthesis. The stem specifies that the mutation leaves the hormone-binding domain intact but abolishes the DNA-binding domain. Cortisol therefore still binds normally, but the DNA-binding domain is precisely the part of the receptor that recognizes and docks at the HRE. With that domain gone, the complex cannot engage the HRE, so transcription is never initiated and the pathway fails at the gene-transcription step even though the upstream hormone-binding event succeeds.

(Choice B) is correct: the DNA-binding lesion prevents the complex from engaging the hormone response element, so transcription of the target gene is not initiated and no new mRNA or protein is produced.

(Choice A) is incorrect: engaging the HRE and driving transcription requires an intact DNA-binding domain, which is exactly what the mutation destroys; hormone binding alone is not sufficient to dock the complex on DNA, so transcription cannot proceed normally.

(Choice C) is incorrect: the cAMP/adenylyl cyclase cascade is used by water-soluble hormones acting through plasma-membrane receptors and G proteins, not by steroid hormones acting through intracellular receptors; a mutant nuclear receptor cannot switch the cell to a membrane-delimited second-messenger pathway.

(Choice D) is incorrect: this mislocates the lesion downstream to mRNA export/translation and falsely asserts DNA binding still occurs, whereas the mutation eliminates DNA binding itself, so the failure is at transcription initiation, before any target-gene mRNA is ever made.

As a Skill 2 item, this requires interpreting the described mutation to locate where in the ordered steroid-signaling pathway the defect falls, distinguishing an intact upstream hormone-binding event from a blocked downstream DNA-engagement step, rather than recalling a single fact.', 'hard', '3A', 'Endocrine System: Mechanisms of Hormone Action', 'biology', 2, 90, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'Assumes hormone binding alone drives transcription, ignoring that the DNA-binding domain is required to dock at the hormone response element' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'Confuses the steroid intracellular-receptor pathway with the water-soluble hormone adenylyl-cyclase/cAMP second-messenger cascade' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'Mislocates the lesion downstream to mRNA export/translation while wrongly preserving DNA binding, rather than blocking transcription initiation at the DNA-binding step' FROM q;

-- Q16 [Receptors & Signal Transduction] easy skill1 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'The Endocrine System', 'Receptors & Signal Transduction', 'Cortisol is a steroid hormone released by the adrenal cortex. Based on cortisol''s chemical class, where in a target cell is its receptor located?', '[{"label": "A", "text": "Spanning the plasma membrane, coupled to a G protein"}, {"label": "B", "text": "On the extracellular surface of the plasma membrane"}, {"label": "C", "text": "In the cytoplasm or nucleus, inside the cell"}, {"label": "D", "text": "Anchored to the outer membrane of the nuclear envelope, facing the cytoplasm"}]'::jsonb, 'C', 'This is a Biology question that falls under the content category ''Endocrine System: Mechanisms of Hormone Action.''

The answer is C because cortisol is a steroid hormone, and steroid hormones are lipid-soluble. OpenStax classifies cortisol as a steroid and notes that steroid hormones are insoluble in water; being derived from cholesterol, they readily diffuse through the lipid bilayer of the plasma membrane. Their receptors are therefore intracellular: OpenStax states that intracellular hormone receptors are located inside the cell and that a steroid hormone may bind to its receptor within the cytosol or within the nucleus, after which the hormone-receptor complex acts on DNA to regulate transcription. Recognizing that cortisol is a steroid tells you its receptor must be intracellular.

(Choice C) is correct: intracellular receptors residing in the cytoplasm or nucleus are the receptor type used by lipid-soluble steroid hormones such as cortisol, which diffuse through the plasma membrane to reach them.

(Choice B) is incorrect: cell-membrane receptors on the extracellular surface serve water-soluble (hydrophilic) hormones, which cannot diffuse through the lipid bilayer and must pass their message to a surface receptor; as a lipid-soluble steroid, cortisol enters the cell and does not use a surface receptor.

(Choice A) is incorrect: membrane-spanning receptors coupled to G proteins mediate signaling for water-soluble hormones through second-messenger cascades such as cAMP, not for lipid-soluble steroids like cortisol that enter the cell directly.

(Choice D) is incorrect: steroid receptors are not membrane-anchored proteins on the nuclear envelope; OpenStax places steroid-type intracellular receptors free within the cytosol or within the nucleus, where the hormone-receptor complex binds DNA to influence transcription.

As a Skill 1 item, this question requires identifying the foundational relationship between a hormone''s chemical class (lipid-soluble steroid) and the intracellular location of its receptor as established in the source material.', 'easy', '3A', 'Endocrine System: Mechanisms of Hormone Action', 'biology', 1, 50, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'Assigns the water-soluble hormone''s surface receptor location to a lipid-soluble steroid hormone, reversing the solubility-to-location rule' FROM q
  UNION ALL
  SELECT id, 'A', 'process_step_confusion', 'Confuses the membrane-bound G-protein/second-messenger pathway (used by hydrophilic hormones) with lipophilic steroid signaling' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'Treats the intracellular receptor as a membrane-anchored protein on the nuclear envelope, mistaking ''inside the cell'' for ''attached to an internal membrane'' rather than free in cytosol/nucleus' FROM q;

-- Q17 [Receptors & Signal Transduction] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'The Endocrine System', 'Receptors & Signal Transduction', 'A single cell carries receptors for both a steroid hormone and the peptide hormone glucagon. When the cell is exposed to each hormone separately, glucagon''s effect appears within seconds and vanishes within a minute after the hormone is washed away, whereas the steroid''s effect takes about an hour to appear and then persists for many hours after washout. Which feature of the steroid''s mechanism best accounts for both its slow onset and its lasting effect?', '[{"label": "A", "text": "It works by turning on transcription of new genes into protein"}, {"label": "B", "text": "It amplifies its signal through a cytoplasmic second messenger such as cAMP"}, {"label": "C", "text": "Its surface receptor triggers the response by activating an associated G protein"}, {"label": "D", "text": "It directly opens membrane ion channels to alter the cell''s membrane potential"}]'::jsonb, 'A', 'This is a Biology question that falls under the content category ''Endocrine System: Mechanisms of Hormone Action.''

The answer is A. A steroid hormone is lipid-soluble, so it diffuses through the plasma membrane and binds an intracellular receptor; the hormone-receptor complex then enters the nucleus and acts as a transcription factor, turning on target genes whose mRNA is translated into new protein. Building that new protein takes time, which is why the steroid''s effect appears only after a lag of roughly an hour, and the effect persists because the newly made proteins linger long after the hormone itself is gone. Glucagon, a water-soluble peptide, cannot enter the cell; it binds a surface receptor and works through a rapidly made, rapidly degraded second messenger, so its effect turns on within seconds and shuts off within a minute once the hormone is removed. Only a gene-transcription mechanism explains BOTH the slow onset and the long persistence, so the student must map that behavioral signature to the intracellular-receptor pathway.

(Choice A) is correct: the steroid''s slow, durable action is the hallmark of intracellular-receptor signaling, in which the hormone-receptor complex drives transcription of new mRNA that is translated into protein; the transcription-and-translation delay produces the lag, and the lifetime of the new proteins produces the persistence.

(Choice B) is incorrect: a cytoplasmic second messenger such as cAMP is the mechanism of water-soluble hormones like glucagon, and it produces a fast, brief response (cAMP is quickly destroyed by phosphodiesterase), which is the opposite of the slow, lasting signature described for the steroid.

(Choice C) is incorrect: activation of a G protein by a surface receptor belongs to the peptide (glucagon) membrane pathway; steroids act on intracellular receptors, not membrane G-protein-coupled receptors, and this pathway again gives rapid, transient effects, not the slow, durable one observed.

(Choice D) is incorrect: directly gating membrane ion channels is the fastest class of receptor response and is not how steroids act; steroids exert their effect through gene transcription inside the nucleus, so this mechanism explains neither the hour-long onset nor the many-hour persistence.

Skill 2: the item requires reasoning from the experimental signature (slow onset plus long persistence for one hormone, fast and transient for the other) back to the underlying mechanism, rather than recalling a stated fact that steroids act slowly.', 'medium', '3A', 'Endocrine System: Mechanisms of Hormone Action', 'biology', 2, 80, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'process_step_confusion', 'assigning the cAMP second-messenger cascade of the peptide pathway to the steroid mechanism' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'attributing the surface-receptor G-protein activation step to the steroid pathway' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'believing steroids act by directly opening membrane ion channels rather than by altering gene transcription' FROM q;

-- Q18 [Second Messengers & Amplification] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'The Endocrine System', 'Second Messengers & Amplification', 'A hormone binds a G-protein-coupled receptor on a target cell, activating a G protein that stimulates phospholipase C. A drug then completely and selectively inhibits phospholipase C in this cell. After the drug takes effect, which second messenger still accumulates normally in response to the hormone?', '[{"label": "A", "text": "Inositol triphosphate (IP3)"}, {"label": "B", "text": "Cyclic AMP (cAMP)"}, {"label": "C", "text": "Intracellular calcium ions (Ca2+)"}, {"label": "D", "text": "Diacylglycerol (DAG)"}]'::jsonb, 'B', 'This is a Biology question that falls under the content category ''Endocrine System: Mechanisms of Hormone Action.''

The answer is B because cyclic AMP (cAMP) is produced by adenylate cyclase acting on ATP, an entirely separate effector pathway from phospholipase C (PLC). Inhibiting PLC removes only the messengers that depend on PLC cleaving the membrane phospholipid PIP2; it does not touch adenylate cyclase, so cAMP can still accumulate normally when a G protein stimulates that enzyme. To answer, the student must recognize that of the four listed messengers, cAMP is the only one that does not originate from the PLC branch, so it is the only one whose production survives PLC inhibition.

(Choice A) is incorrect: IP3 is one of the two direct products of phospholipase C cleaving PIP2, so inhibiting PLC prevents IP3 from forming.

(Choice D) is incorrect: DAG is the other direct product of phospholipase C cleaving PIP2, so blocking PLC also stops DAG production.

(Choice C) is incorrect: intracellular Ca2+ rises as a second messenger only because IP3 triggers its release from stores such as the smooth endoplasmic reticulum; with PLC blocked, no IP3 forms, so the Ca2+ signal downstream of it does not occur.

(Choice B) is correct: cAMP is made by adenylate cyclase, a different effector enzyme in a parallel pathway, so PLC inhibition leaves cAMP accumulation intact.

At the Skill 2 level, the item requires tracing which messengers depend on the specific enzyme that was inhibited versus a parallel effector pathway, rather than recalling a definition, because the student must separate the entire PLC branch (IP3, DAG, and the Ca2+ release it drives) from the independent adenylate cyclase branch that produces cAMP.', 'medium', '3A', 'Endocrine System: Mechanisms of Hormone Action', 'biology', 2, 75, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'process_step_confusion', 'direct product of the inhibited enzyme mistaken for the surviving messenger' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'direct product of the inhibited enzyme mistaken for the surviving messenger' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'downstream messenger of the inhibited pathway mistaken for one from a parallel pathway' FROM q;

-- Q19 [Second Messengers & Amplification] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'The Endocrine System', 'Second Messengers & Amplification', 'A liver cell binds glucagon, and its cytosolic cAMP concentration rises sharply. Which event occurs next in the pathway that produces the hormone''s metabolic effect?', '[{"label": "A", "text": "The stimulatory G protein binds GTP and switches on membrane adenylyl cyclase"}, {"label": "B", "text": "Adenylyl cyclase keeps converting additional ATP molecules into more cAMP"}, {"label": "C", "text": "cAMP activates protein kinase A, which adds phosphates to target proteins"}, {"label": "D", "text": "Cytosolic phosphodiesterase hydrolyzes the accumulated cAMP back into AMP"}]'::jsonb, 'C', 'This is a Biology question that falls under the content category ''Endocrine System: Mechanisms of Hormone Action.''

The answer is C because, once the second messenger cAMP has accumulated in the cytosol, the next forward step is that cAMP activates a protein kinase (protein kinase A). Activated PKA then phosphorylates target proteins, adding phosphate groups that switch those proteins on or off to carry out the changes the hormone specifies. Predicting this step requires knowing where cAMP sits in the cascade and what it acts on, not merely restating a definition.

(Choice C) is correct: OpenStax states that "as the second messenger, cAMP activates a type of enzyme called a protein kinase," and that these activated kinases "phosphorylate numerous and various cellular proteins," which produces the hormonal response. This is the immediate downstream event after cAMP rises.

(Choice B) is incorrect: Adenylyl cyclase converting ATP into cAMP is the step that generates cAMP in the first place. It occurs before cAMP accumulates, not after; treating it as the next step reverses the temporal order of the cascade.

(Choice A) is incorrect: The stimulatory G protein binding GTP and activating adenylyl cyclase is an upstream membrane event that precedes cAMP synthesis entirely. By the time cytosolic cAMP has already risen, this activation step has already happened.

(Choice D) is incorrect: Phosphodiesterase hydrolyzing cAMP back into AMP is a real, cytosolic termination step, but it deactivates the signal to end the response. It does not produce the hormone''s effect and is not the next forward step once cAMP rises.

At the Skill 2 level, the student must apply an ordered model of the cAMP cascade to a specific cell, distinguishing the forward signal-producing step from upstream synthesis steps and the downstream shut-off step rather than recognizing a memorized phrase.', 'medium', '3A', 'Endocrine System: Mechanisms of Hormone Action', 'biology', 2, 75, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'process_step_confusion', 'upstream synthesis step mistaken for downstream step' FROM q
  UNION ALL
  SELECT id, 'A', 'process_step_confusion', 'membrane-level upstream event placed after cAMP rise' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'signal-termination step mistaken for effect-producing step' FROM q;

-- Q20 [Second Messengers & Amplification] hard skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'The Endocrine System', 'Second Messengers & Amplification', 'A steroid hormone activates one intracellular receptor per hormone molecule, whereas an equal number of epinephrine molecules binding surface receptors each drive a G-protein/adenylyl-cyclase/protein-kinase pathway, yielding roughly a million-fold more phosphorylated product. Which feature of the surface pathway best accounts for this disparity?', '[{"label": "A", "text": "Phosphodiesterase prolongs cyclic AMP to sustain output"}, {"label": "B", "text": "Each hormone molecule occupies its own membrane receptor"}, {"label": "C", "text": "Cyclic AMP diffuses freely, reaching targets more quickly"}, {"label": "D", "text": "Several sequential catalytic steps each multiply the signal"}]'::jsonb, 'D', 'This is a Biology question that falls under the content category ''Endocrine System: Mechanisms of Hormone Action.''

The answer is D because surface-receptor signaling amplifies through a series of catalytic, one-to-many steps that multiply at each stage. A single hormone-bound receptor activates many G proteins; each activated adenylyl cyclase converts many ATP molecules into cAMP; and each cAMP-activated protein kinase then catalyzes many phosphorylation reactions. Because these one-to-many steps occur in sequence, their multipliers compound (for example, hundreds times hundreds times hundreds), so a few hormone molecules generate an enormous quantity of product. The steroid pathway, by contrast, is essentially one-to-one, so output scales linearly with hormone number and no large gain appears.

(Choice D) is correct: the multiplicative product of several sequential catalytic steps (many G proteins per receptor, many cAMP per cyclase, many substrates per kinase) is precisely what produces the roughly million-fold gain over a one-to-one model.

(Choice B) is incorrect: one hormone occupying one receptor describes the non-amplifying, one-to-one arrangement itself and matches the steroid comparison. If output depended only on how many hormone molecules bound receptors, both pathways would scale identically with hormone number, and the observed disparity for equal hormone amounts would not occur.

(Choice C) is incorrect: cAMP is indeed a small, freely diffusing second messenger, but rapid diffusion affects the speed and reach of the response, not the total quantity of product made. Diffusion moves existing molecules; it does not create the large number of new phosphorylated products that defines amplification.

(Choice A) is incorrect: phosphodiesterase (PDE) hydrolyzes and thereby deactivates cAMP, terminating rather than sustaining the signal. PDE limits the response duration; it neither prolongs cAMP nor contributes to the enlarged output, so it cannot explain the greater product yield.

Skill 2: this item requires reasoning quantitatively from the described per-step catalytic multipliers to infer that compounding one-to-many stages, not any single feature, produces the large amplification, and applying that principle to distinguish the surface cascade from a one-to-one intracellular model.', 'hard', '3A', 'Endocrine System: Mechanisms of Hormone Action', 'biology', 2, 100, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'Conflates amplification with hormone/receptor quantity (the one-to-one model)' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'cAMP does diffuse freely, but diffusion governs speed/reach, not amount of product' FROM q
  UNION ALL
  SELECT id, 'A', 'misconception', 'Believes phosphodiesterase sustains/prolongs cAMP rather than terminating it' FROM q;

-- Q21 [Second Messengers & Amplification] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'The Endocrine System', 'Second Messengers & Amplification', 'A hormone binds a G-protein-coupled receptor that activates phospholipase C, and shortly afterward Ca2+ floods out of the smooth endoplasmic reticulum into the cytosol. Which molecule generated by this receptor''s pathway directly triggered that Ca2+ release?', '[{"label": "A", "text": "Cyclic AMP (cAMP)"}, {"label": "B", "text": "Inositol trisphosphate (IP3)"}, {"label": "C", "text": "Diacylglycerol (DAG)"}, {"label": "D", "text": "Phosphatidylinositol bisphosphate (PIP2)"}]'::jsonb, 'B', 'This is a Biology question that falls under the content category ''Endocrine System: Mechanisms of Hormone Action.'' The answer is IP3 because when the G protein activates phospholipase C (PLC), PLC cleaves the membrane phospholipid PIP2 into two products, DAG and IP3; the IP3 then diffuses into the cytosol and causes calcium ions to be released from storage sites such as the smooth endoplasmic reticulum, making it the specific messenger that triggered the observed Ca2+ release. (Choice B) is correct: IP3 is the water-soluble PLC product that binds ligand-gated Ca2+ channels on the ER and directly liberates the stored Ca2+. (Choice A) is incorrect: cAMP is the second messenger of the separate adenylate (adenylyl) cyclase pathway, in which the G protein activates adenylate cyclase to convert ATP to cAMP; that pathway does not involve PLC and did not release the ER Ca2+ here. (Choice C) is incorrect: DAG is the other PLC cleavage product, but it stays in the membrane and activates protein kinase C rather than releasing Ca2+ from the ER, so it is not the trigger. (Choice D) is incorrect: PIP2 is the membrane substrate that PLC cleaves, not a downstream second messenger, so it is consumed by the pathway rather than generated to release Ca2+. As a Skill 2 item, this requires reasoning about the causal sequence of the PLC pathway to distinguish the messenger that releases Ca2+ from the substrate, the co-product, and the messenger of the unrelated cyclase pathway.', 'medium', '3A', 'Endocrine System: Mechanisms of Hormone Action', 'biology', 2, 75, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'adjacent_fact', 'wrong-pathway messenger (adenylate cyclase product substituted for PLC product)' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'co-product of same enzyme mistaken for the Ca2+-releasing messenger' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'substrate of the reaction mistaken for its product' FROM q;

-- Q22 [Second Messengers & Amplification] hard skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'The Endocrine System', 'Second Messengers & Amplification', 'A liver cell responds to glucagon by breaking down glycogen into glucose. In an experiment, a cell is treated with a drug that selectively inhibits adenylyl cyclase, then exposed to glucagon. Glucagon binding and G-protein activation both proceed normally. Compared with an untreated cell, what is the most likely result, and why?', '[{"label": "A", "text": "Glycogen breakdown increases, because cAMP is no longer degraded to AMP"}, {"label": "B", "text": "Glycogen breakdown proceeds normally, because IP3 releases stored Ca2+ instead"}, {"label": "C", "text": "Glycogen breakdown fails, because protein kinase A is not activated"}, {"label": "D", "text": "Glycogen breakdown continues at a reduced rate, because ATP still activates protein kinase A directly"}]'::jsonb, 'C', 'This is a Biology question that falls under the content category ''Endocrine System: Mechanisms of Hormone Action.''

Glucagon is a peptide hormone that signals through the cAMP second-messenger system. In this pathway the activated G protein stimulates adenylyl cyclase, adenylyl cyclase converts ATP to cAMP, cAMP activates protein kinase A (PKA), and PKA drives the phosphorylation cascade that activates glycogen phosphorylase and breaks glycogen down into glucose. A drug that inhibits adenylyl cyclase removes the step that generates cAMP. Glucagon still binds and the G protein still activates, but with adenylyl cyclase disabled no cAMP is made, PKA is never activated, and glycogen breakdown fails. The student must trace the specific cascade (G protein to adenylyl cyclase to cAMP to PKA to glycogen phosphorylase) to see that the block falls upstream of PKA and therefore prevents the response.

(Choice C) is correct: with adenylyl cyclase inhibited, cAMP is not produced, PKA is not activated, and the glycogen-breakdown response cannot occur.

(Choice B) is incorrect: the IP3/Ca2+ pathway is a genuinely separate second-messenger system in which the G protein activates phospholipase C, which cleaves a membrane phospholipid into DAG and IP3, and IP3 releases stored Ca2+. It does not depend on adenylyl cyclase. But glucagon in the liver signals through cAMP, not IP3/Ca2+, so this parallel pathway is not the one glucagon uses and cannot substitute for it—being a peptide hormone does not make a cell switch to IP3.

(Choice A) is incorrect: cAMP degradation to AMP is carried out by phosphodiesterase (PDE), a different enzyme. Increased cAMP and amplified signaling would result from inhibiting PDE, not adenylyl cyclase. Inhibiting adenylyl cyclase lowers cAMP because synthesis stops, so the response cannot increase.

(Choice D) is incorrect: ATP does not activate PKA. PKA is activated by cAMP, which adenylyl cyclase must first synthesize from ATP; ATP is the raw material, not the activator. With adenylyl cyclase blocked, ATP simply is not converted to cAMP, so there is no low-level direct activation and no reduced-rate response—the pathway is halted, not merely slowed.

Answering requires reasoning through the sequential logic of the cascade (G protein to adenylyl cyclase to cAMP to PKA to glycogen phosphorylase), identifying that adenylyl cyclase sits upstream of PKA, and predicting that its loss propagates forward to abolish the response, rather than recalling a single definition.', 'hard', '3A', 'Endocrine System: Mechanisms of Hormone Action', 'biology', 2, 105, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'partial_truth', 'correct description of an unaffected parallel pathway (IP3/Ca2+) misapplied as a rescue for a hormone that actually signals through cAMP' FROM q
  UNION ALL
  SELECT id, 'A', 'reversed_relationship', 'confuses inhibiting cAMP synthesis (adenylyl cyclase) with inhibiting cAMP degradation (phosphodiesterase), predicting cAMP accumulation and increased response instead of loss' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'mistakes ATP (the substrate consumed to make cAMP) for the direct activator of PKA, predicting residual low-level signaling when none exists' FROM q;

-- Q23 [Second Messengers & Amplification] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'The Endocrine System', 'Second Messengers & Amplification', 'A researcher applies a peptide hormone to cultured cells and then adds a drug that blocks phosphodiesterase. Compared with untreated cells, how does the drug most likely alter the duration of the hormone''s intracellular effect?', '[{"label": "A", "text": "Shortened, because G proteins can no longer be activated"}, {"label": "B", "text": "Shortened, because adenylyl cyclase can no longer act"}, {"label": "C", "text": "Unchanged, because the hormone''s blood half-life is fixed"}, {"label": "D", "text": "Prolonged, because cAMP is no longer degraded"}]'::jsonb, 'D', 'This is a Biology question that falls under the content category ''Endocrine System: Mechanisms of Hormone Action.''

The answer is D because peptide-hormone effects are normally short-lived precisely because the second messenger cAMP is rapidly deactivated. Phosphodiesterase (PDE) is the cytosolic enzyme that degrades cAMP, ensuring the target cell''s response ceases quickly unless new hormone arrives. Blocking PDE prevents cAMP breakdown, so the second messenger persists and the intracellular cascade—and therefore the hormone''s effect—lasts longer than normal.

(Choice D) is correct: With PDE inhibited, cAMP accumulates rather than being converted to AMP, so the phosphorylation cascade is not terminated on schedule and the cellular response is prolonged.

(Choice B) is incorrect: Adenylyl cyclase is the enzyme that synthesizes cAMP from ATP; PDE inhibition does not disable it. If anything, cAMP synthesis continues while degradation stops, which lengthens rather than shortens the response.

(Choice C) is incorrect: A hormone''s blood half-life governs how long the first messenger circulates, not how long the intracellular cascade lasts. PDE acts inside the cell on cAMP, so blocking it changes the effect''s duration regardless of the hormone''s plasma half-life.

(Choice A) is incorrect: G proteins act upstream of cAMP to activate adenylyl cyclase and are not the target of PDE. Their activation is unaffected, and blocking cAMP degradation extends the signal rather than cutting it off.

Skill 2: This item requires interpreting an experimental manipulation—inhibiting the degrading enzyme—and reasoning from the transience of the second-messenger cascade to predict its consequence for the duration of peptide-hormone action.', 'medium', '3A', 'Endocrine System: Mechanisms of Hormone Action', 'biology', 2, 80, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'process_step_confusion', 'Confuses the cAMP-synthesizing enzyme (adenylyl cyclase) with the cAMP-degrading enzyme (PDE)' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'Applies the hormone''s plasma half-life (a real property of the circulating first messenger) to the intracellular cascade duration' FROM q
  UNION ALL
  SELECT id, 'A', 'process_step_confusion', 'Assigns the effect of PDE inhibition to an upstream activation step (G-protein signaling) unaffected by PDE' FROM q;

-- Q24 [Second Messengers & Amplification] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'The Endocrine System', 'Second Messengers & Amplification', 'Hormone X binds a cell-surface receptor and triggers a G-protein/cAMP phosphorylation cascade in a target cell, while hormone Y diffuses in, binds an intracellular receptor, and drives transcription of a target gene in the same cell. Which prediction about the two responses, with its reason, is correct?', '[{"label": "A", "text": "X acts faster; Y sustains its effect longer"}, {"label": "B", "text": "Y acts faster; X sustains its effect longer"}, {"label": "C", "text": "X acts faster and sustains its effect longer"}, {"label": "D", "text": "Y acts faster and sustains its effect longer"}]'::jsonb, 'A', 'This is a Biology question that falls under the content category ''Endocrine System: Mechanisms of Hormone Action.''

The answer is A because hormone X''s surface receptor immediately activates a preexisting G-protein/adenylyl-cyclase/cAMP cascade that phosphorylates enzymes already present in the cytosol, producing a rapid onset; however, cAMP is quickly destroyed by phosphodiesterase, so the response ceases quickly. Hormone Y must instead complete gene transcription and translation before any new protein appears, which delays onset, but the newly synthesized proteins and the long half-life of a lipid-soluble hormone make its effect more sustained.

(Choice A) is correct: the membrane cascade acts on existing proteins for speed, whereas the transcription pathway builds new protein for a longer-lasting effect, correctly pairing faster onset with X and greater duration with Y.

(Choice B) is incorrect: it reverses both predictions. A pathway requiring transcription and translation cannot outpace a cascade acting on preexisting enzymes, and the cAMP signal is short-lived because phosphodiesterase rapidly deactivates it, so X is not the more sustained response.

(Choice C) is incorrect: it correctly identifies X as faster but wrongly extends the amplifying cascade to durability. Amplification governs signal strength, not persistence; phosphodiesterase degradation ends the cAMP signal quickly, so X is not the more sustained response.

(Choice D) is incorrect: it assumes that skipping the membrane cascade and entering the nucleus produces a faster response, but transcription and translation take longer to yield an effect than a cascade acting on enzymes already in the cytosol, so Y is slower in onset.

Skill 2: the item requires reasoning from the described mechanisms—linking receptor location and the transcription-versus-cascade step to onset speed and to signal duration—rather than recalling a single stated fact.', 'hard', '3A', 'Endocrine System: Mechanisms of Hormone Action', 'biology', 2, 100, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'Swaps which pathway is faster and which is more sustained' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'Correctly names X as faster but over-extends amplification into signal duration' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'Assumes nuclear/intracellular action is faster because it bypasses the surface cascade' FROM q;

-- Q25 [Second Messengers & Amplification] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds, figure_svg)
  VALUES ('bio_biochem', 'The Endocrine System', 'Second Messengers & Amplification', 'In a fasting-state liver cell, a peptide hormone binds a membrane receptor, activating a G protein that stimulates adenylyl cyclase; the resulting cAMP activates protein kinase A, which phosphorylates the cell''s metabolic enzymes. What functional change does this cascade most directly produce in the cell?', '[{"label": "A", "text": "Adenylyl cyclase activity is suppressed"}, {"label": "B", "text": "Glucose is stored by building glycogen"}, {"label": "C", "text": "Glycogen is broken down, releasing glucose"}, {"label": "D", "text": "Calcium is released from the smooth ER"}]'::jsonb, 'C', 'This is a Biology question that falls under the content category ''Endocrine System: Mechanisms of Hormone Action.''

The answer is C because the endpoint of the cAMP second-messenger cascade is the phosphorylation of target enzymes by activated protein kinase A (PKA), and that phosphorylation carries out the change specified by the hormone. In a fasting liver cell, the peptide hormone acting through this Gs–adenylyl cyclase–cAMP–PKA pathway is glucagon, whose PKA-driven phosphorylation of metabolic enzymes stimulates the breakdown of glycogen stores, releasing glucose and raising blood glucose. The scenario supplies only the cascade mechanics, so the student must trace the phosphorylation step to its metabolic consequence rather than restate a definition.

(Choice C) is correct: PKA phosphorylation of the liver cell''s enzymes activates glycogen breakdown (glycogenolysis), releasing glucose — the functional endpoint the glucagon-driven cAMP cascade produces.

(Choice B) is incorrect: building glycogen to store glucose is the antagonistic action of insulin, which lowers blood glucose; it is the opposite of what a cAMP–PKA phosphorylation cascade in a fasting liver cell produces.

(Choice A) is incorrect: suppression of adenylyl cyclase and falling cAMP describe an inhibitory Gi pathway (for example, somatostatin/GHIH), not the stimulatory Gs cascade that has already activated PKA in this scenario.

(Choice D) is incorrect: calcium release from the smooth endoplasmic reticulum is triggered by IP3 in the phospholipase C pathway, a separate second-messenger system, not the cAMP–PKA phosphorylation cascade described here.

At the Skill 2 level, the student cannot readback an answer; they must map the general cascade endpoint — phosphorylation of enzymes by an activated kinase — onto the specific metabolic outcome in the cell described.', 'medium', '3A', 'Endocrine System: Mechanisms of Hormone Action', 'biology', 2, 80, NULL)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'antagonistic hormone''s opposite effect (insulin glycogen synthesis)' FROM q
  UNION ALL
  SELECT id, 'A', 'misconception', 'confuses stimulatory Gs cascade with inhibitory Gi pathway that lowers cAMP' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'attributes IP3/Ca2+ (PLC pathway) event to the cAMP-PKA pathway' FROM q;

