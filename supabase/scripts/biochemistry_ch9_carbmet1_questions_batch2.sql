-- Biochemistry Chapter 9: Carbohydrate Metabolism I, standalone questions
-- BATCH 2 of 2 (24 questions), CHAPTER COMPLETE at 45 — AND WITH IT THE ENTIRE BIOCHEMISTRY
-- QUESTION BANK (12 of 12 chapters live): glycogen enzymology (UDP-glucose activation, synthase
--   primer dependence, glycogenin, branching mechanics, the limit-dextrin stall, the debranching
--   free-glucose arithmetic, phosphoglucomutase, allosteric muscle phosphorylase, the Von Gierke
--   convergence vignette) . the four gluconeogenesis bypass enzymes (biotin/PC, the acetyl-CoA
--   fate switch, PEPCK/malate exit, FBPase-1 reciprocal control, the G6Pase ER compartment) .
--   the pentose phosphate pathway (oxidative-branch control and carbon bookkeeping, the red-cell
--   vignettes, non-oxidative reverse flux, the product ledger).
--
-- PURE INSERTs: run AFTER biochemistry_ch9_carbmet1_questions.sql (batch 1 owns the DELETE).
-- Arc contract honoured: zero PDH keys; the thumb litmus held on every regulation key; Ch4's
-- structure facts, Ch12's state logic, and the burned NADPH-lipogenesis and Cori lanes untouched.
-- Q17 was replaced pre-ship: the drafted item duplicated the non-oxidative reverse-flux key; the
-- replacement keys the oxidative branch's C1-lost-as-CO2 carbon arithmetic instead.

BEGIN;

-- B2 Q1 . pyrophosphate hydrolysis driving force . medium . skill 2 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$pyrophosphate hydrolysis driving force$q$,
    $q$The formation of UDP-glucose from glucose 1-phosphate and UTP has a standard free energy change close to zero, yet in intact hepatocytes this reaction proceeds nearly to completion. A biochemist reconstitutes the reaction in vitro using only purified UDP-glucose pyrophosphorylase, glucose 1-phosphate, and UTP. Which outcome should the biochemist expect in this reconstituted system?$q$,
    $q$[{"label":"A","text":"The reaction proceeds to completion because cleavage of UTP to UDP releases enough free energy to drive glucosyl transfer"},{"label":"B","text":"A significant fraction of the glucose 1-phosphate remains unreacted because the exergonic hydrolysis of released pyrophosphate cannot occur"},{"label":"C","text":"No UDP-glucose forms at all because pyrophosphate must first bind the enzyme as an activator of glucosyl transfer"},{"label":"D","text":"The reaction proceeds to completion because glucose 1-phosphate is a high energy compound whose consumption is inherently irreversible"}]$q$::jsonb,
    'B',
    $q$This question tests the Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway content category, specifically how the cell drives formation of the activated glucosyl donor UDP-glucose. The answer is B because the reaction catalyzed by UDP-glucose pyrophosphorylase is freely reversible on its own, and the forward pull in cells comes from a second enzyme, inorganic pyrophosphatase, which was not included in the reconstituted system. In the intact hepatocyte, glucose 1-phosphate attacks UTP, displacing pyrophosphate and forming UDP-glucose with a standard free energy change near zero. Inorganic pyrophosphatase then hydrolyzes the released pyrophosphate into two orthophosphates, a strongly exergonic cleavage that continuously removes a product of the first reaction. Coupling the two steps makes the overall process highly favorable and effectively irreversible, which is why the cellular reaction runs nearly to completion. With only the pyrophosphorylase present, pyrophosphate accumulates, the system settles at its intrinsic near-unity equilibrium, and substantial glucose 1-phosphate remains. (Choice A) UTP is not cleaved to UDP in this reaction; the UMP portion of UTP is incorporated into UDP-glucose while the two terminal phosphates leave together as pyrophosphate, so no separate UTP hydrolysis is available to drive the transfer. (Choice C) Pyrophosphate is a product of the reaction, not a required activator; supplying or retaining it would push the equilibrium backward toward glucose 1-phosphate and UTP rather than enabling catalysis. (Choice D) Glucose 1-phosphate does carry a phosphoryl group on its anomeric carbon, but the stem states that the overall transfer has a standard free energy change near zero, so consumption of glucose 1-phosphate is not inherently irreversible and cannot by itself carry the reaction to completion. This is a Scientific Reasoning and Problem Solving question because it requires predicting the outcome of a reconstituted reaction by recognizing which coupled step normally supplies the thermodynamic pull and reasoning about what happens when that step is removed.$q$,
    'medium',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    2,
    85
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$wrong energy source$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', $q$product recast as required activator$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$true property, wrong conclusion$q$ FROM q;

-- B2 Q2 . glycogen synthase primer dependence . hard . skill 2 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$glycogen synthase primer dependence$q$,
    $q$Two cell-free reaction mixtures each contain purified, fully active glycogen synthase and saturating UDP-glucose. A trace amount of purified glycogen is added to the second mixture only. After incubation, incorporation of glucose into alpha-1,4 linked polymer is detected in the second mixture but not the first. Which property of glycogen synthase best accounts for this result?$q$,
    $q$[{"label":"A","text":"Glycogen functions as an allosteric activator that converts the enzyme into its active conformation"},{"label":"B","text":"The enzyme requires preformed alpha-1,6 branch points as the acceptor sites for incoming glucosyl units"},{"label":"C","text":"The added glycogen supplies the uridine nucleotide that must be regenerated for each glucosyl transfer"},{"label":"D","text":"The enzyme can transfer glucosyl units only onto the nonreducing end of an existing chain and cannot link two free precursors together"}]$q$::jsonb,
    'D',
    $q$This question tests the Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway content category, specifically the elongation mechanism of glycogen synthase and its dependence on a preexisting chain. The answer is D because glycogen synthase is strictly an elongating enzyme. It transfers a glucosyl unit from UDP-glucose onto the free 4-hydroxyl at the nonreducing end of a chain that already exists, forming a new alpha-1,4 bond, and it has no activity that can join two free precursors into a first glucose-glucose linkage. A mixture containing only the enzyme and its activated donor therefore produces no polymer no matter how long it incubates. Adding trace glycogen supplies abundant nonreducing ends that serve as acceptor substrates, and incorporation begins immediately. In cells, this same limitation is the reason a dedicated initiator protein must construct a short seed chain before synthase can contribute anything to a brand new granule. (Choice A) The requirement demonstrated here is for glycogen as an acceptor substrate, not as an allosteric signal; the classic allosteric activator of glycogen synthase is glucose 6-phosphate, and no conformational switch triggered by glycogen itself is needed for catalysis. (Choice B) Glycogen synthase adds residues through alpha-1,4 linkages at nonreducing ends; alpha-1,6 branch points are created by a separate transferase and are not the acceptor sites for elongation, so a completely unbranched chain would still support incorporation. (Choice C) The uridine nucleotide is already supplied in activated form as saturating UDP-glucose, and regeneration of UTP from released UDP is handled by nucleotide kinases, not by glycogen, so the donor was never the limiting component in the first mixture. This is a Scientific Reasoning and Problem Solving question because it requires working backward from a differential experimental result to the mechanistic property responsible, distinguishing an acceptor substrate requirement from superficially similar activation explanations.$q$,
    'hard',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    2,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$substrate requirement mistaken for allosteric activation$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', $q$real glycogen feature, wrong acceptor site$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$confuses donor activation step with elongation step$q$ FROM q;

-- B2 Q3 . glycogenin tyrosine autoglucosylation . easy . skill 1 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$glycogenin tyrosine autoglucosylation$q$,
    $q$A cell line is engineered so that every glycogen granule is completely degraded, leaving no residual oligosaccharide chains. Despite normal glycogen synthase activity, normal branching enzyme activity, and abundant UDP-glucose, the cells cannot deposit new glycogen until one additional protein acts. Which activity of that protein allows granule formation to begin?$q$,
    $q$[{"label":"A","text":"It attaches glucose residues from UDP-glucose to one of its own tyrosine side chains, generating a short chain that glycogen synthase then elongates"},{"label":"B","text":"It transfers a multi-residue block of glucose from a donor chain onto an interior position of an acceptor chain"},{"label":"C","text":"It couples glucose 1-phosphate to UTP, generating the activated glucosyl donor used for chain elongation"},{"label":"D","text":"It binds glycogen synthase and anchors the growing granule while contributing no catalytic sugar additions of its own"}]$q$::jsonb,
    'A',
    $q$This question tests the Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway content category, specifically how a brand new glycogen granule is initiated when no preexisting chain remains. The answer is A because the initiating protein is glycogenin, a glucosyltransferase that primes granule formation by glucosylating itself. Using UDP-glucose as the donor, glycogenin attaches the first glucose to the hydroxyl group of one of its own tyrosine residues and then adds several more residues stepwise, building a short alpha-1,4 chain that remains covalently anchored to the protein. Glycogen synthase cannot create this first chain because it only elongates chains that already exist, but once the short protein-bound primer is present, synthase extends it efficiently and branching enzyme remodels the growing polymer. The mature granule therefore retains glycogenin at its core. This division of labor explains why the engineered cells stall specifically at initiation even though the elongation and branching machinery is fully functional. (Choice B) Transfer of a multi-residue block onto an interior position describes the branching step, which remodels chains that already exist; it cannot generate the first chain of a new granule, and the stem states branching activity is already normal. (Choice C) Coupling glucose 1-phosphate to UTP describes formation of the activated donor, and the stem specifies that UDP-glucose is already abundant, so donor supply is not the blocked step. (Choice D) Glycogenin does remain at the center of the mature granule and associates with glycogen synthase, but it is not a passive scaffold; its essential contribution is catalytic, attaching the seed glucose residues to itself before any other enzyme can act. This is a Knowledge of Scientific Concepts and Principles question because it asks the examinee to recall the specific self-glucosylating priming function that must act before a new glycogen granule can form.$q$,
    'easy',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    1,
    60
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'process_step_confusion', $q$later pathway step substituted for initiation$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$upstream activation step$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$true localization, denies the catalysis$q$ FROM q;

-- B2 Q4 . branching enzyme block transfer . medium . skill 2 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$branching enzyme block transfer$q$,
    $q$During granule growth, glycogen synthase elongates a chain until it extends roughly eleven residues beyond the nearest branch point, and branching enzyme then acts on that chain. A researcher radiolabels the seven glucose residues closest to the nonreducing end of such a chain before allowing branching enzyme to act. Where and in what form should the label appear afterward?$q$,
    $q$[{"label":"A","text":"As single labeled residues transferred one at a time to interior positions, each forming its own alpha-1,6 linkage"},{"label":"B","text":"As an intact block reattached to an interior position of a chain through an alpha-1,4 linkage"},{"label":"C","text":"As an intact block of about seven residues relocated to an interior glucose and attached through a newly formed alpha-1,6 linkage"},{"label":"D","text":"As an intact block moved onto the nonreducing end of a neighboring chain after hydrolysis of an existing alpha-1,6 bond"}]$q$::jsonb,
    'C',
    $q$This question tests the Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway content category, specifically the catalytic mechanism of glycogen branching enzyme. The answer is C because branching enzyme operates on blocks of residues, not on single sugars. Once glycogen synthase has extended a chain roughly eleven residues past the nearest branch, branching enzyme cleaves an internal alpha-1,4 bond near the nonreducing end and excises a segment of about seven residues as one intact unit. It then reattaches that entire segment to the 6-hydroxyl of a glucose at an interior position, creating a brand new alpha-1,6 linkage where none existed before. Because the seven labeled terminal residues correspond to the transferred segment, the label should travel as a contiguous block and end up on a short chain now joined to the rest of the molecule through an alpha-1,6 bond. (Choice A) Residue-by-residue transfer misstates the scale of the reaction; the enzyme excises and relocates a multi-residue segment in a single catalytic event rather than shuttling monomers individually, so the label would never appear as scattered single residues. (Choice B) This choice gets the block transfer right but the chemistry wrong; reattachment occurs at an interior 6-hydroxyl to form an alpha-1,6 linkage, not an alpha-1,4 linkage, which is the bond type the segment was cleaved from. (Choice D) Hydrolyzing an existing alpha-1,6 bond and delivering material to a nonreducing end reverses the direction of the process; that combination describes the chain-transfer and debranching activities used during glycogen breakdown, not the construction of a new branch. This is a Scientific Reasoning and Problem Solving question because it requires applying the block transfer mechanism to predict where a specific set of labeled residues ends up and which linkage type holds them in place.$q$,
    'medium',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    2,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'scale_unit_error', $q$monomer scale substituted for block scale$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$right transfer, wrong bond$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$degradative direction substituted for synthetic$q$ FROM q;

-- B2 Q5 . phosphorylase stall producing limit dextrin . medium . skill 4 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$phosphorylase stall producing limit dextrin$q$,
    $q$Researchers incubate purified glycogen granules with glycogen phosphorylase and excess inorganic phosphate, with no other enzymes present. Glucose 1-phosphate is released rapidly at first, but release stops while roughly forty percent of the original glucose residues remain in a soluble polysaccharide. Structural analysis of this residual polysaccharide shows that every outer chain has been shortened to a stub of about four alpha-1,4-linked residues extending from an alpha-1,6 branch point. Which property of glycogen phosphorylase best explains why glucose 1-phosphate release halted?$q$,
    $q$[{"label":"A","text":"Accumulating glucose 1-phosphate allosterically inhibited the enzyme before the granule could be fully degraded."},{"label":"B","text":"During purification, glycogen phosphorylase lost the transferase and alpha-1,6 glucosidase activities it normally uses to pass through branch points."},{"label":"C","text":"The enzyme cleaves only alpha-1,4 linkages at nonreducing ends and cannot act on residues lying close to an alpha-1,6 branch point."},{"label":"D","text":"The residues remaining in the polysaccharide are joined exclusively by alpha-1,6 linkages, which the enzyme cannot cleave."}]$q$::jsonb,
    'C',
    $q$This Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway question tests the mechanism of glycogen phosphorylase and the reason its attack on a glycogen granule stalls before the granule is consumed. The answer is C because glycogen phosphorylase carries out phosphorolysis only at alpha-1,4 glycosidic linkages, working inward one residue at a time from nonreducing chain ends, and the geometry of its active site prevents productive binding once a chain end comes within about four residues of an alpha-1,6 branch point. The experimental pattern is the fingerprint of exactly this limitation: release of glucose 1-phosphate was fast while long outer chains were available, then stopped abruptly, and every remaining chain was trimmed to a short stub of uniform length anchored at a branch. The residual polysaccharide is a limit dextrin, and its existence reflects a built-in boundary of the enzyme rather than any loss of enzyme or substrate. In the cell, further mobilization requires the debranching enzyme, which relocates the stub and removes the branch residue so that phosphorylase can resume. (Choice A) Inhibition by accumulating glucose 1-phosphate would slow release progressively across all chains and leave stubs of variable length; it cannot produce the uniform four-residue stubs positioned precisely at branch points, and the excess inorganic phosphate supplied here keeps the reaction pulled toward phosphorolysis. (Choice B) Transferase and alpha-1,6 glucosidase activities belong to the separate bifunctional debranching enzyme, not to phosphorylase, so no such activities could have been lost from the purified phosphorylase preparation; they were never part of it. (Choice D) A limit dextrin keeps its alpha-1,4 backbone; alpha-1,6 linkages occur only at the branch points themselves, so the remaining forty percent of residues are not joined exclusively by alpha-1,6 bonds. This is a Data-based and Statistical Reasoning question because it asks you to read the uniform stub length and abrupt halt in a partial digestion experiment and infer from that pattern the linkage specificity and steric limit of the enzyme that generated it.$q$,
    'medium',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    4,
    85
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'adjacent_fact', $q$real phenomenon, wrong signature$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', $q$assigns debranching activities to phosphorylase$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$misreads limit dextrin structure$q$ FROM q;

-- B2 Q6 . debranching dual activity product count . hard . skill 4 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$debranching dual activity product count$q$,
    $q$An isolated glycogen fragment contains 120 glucose residues arranged in alpha-1,4-linked chains with 8 alpha-1,6 branch points. The fragment is degraded to completion by the combined action of glycogen phosphorylase and the bifunctional debranching enzyme, and all monomeric products are collected. How many molecules of free glucose and of glucose 1-phosphate are recovered?$q$,
    $q$[{"label":"A","text":"0 free glucose and 120 glucose 1-phosphate"},{"label":"B","text":"112 free glucose and 8 glucose 1-phosphate"},{"label":"C","text":"32 free glucose and 88 glucose 1-phosphate"},{"label":"D","text":"8 free glucose and 112 glucose 1-phosphate"}]$q$::jsonb,
    'D',
    $q$This Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway question tests the dual catalytic activities of the glycogen debranching enzyme and the product accounting of complete glycogenolysis. The answer is D because only the residue that sits in an alpha-1,6 linkage at each branch point is released as free glucose, while every other residue leaves as glucose 1-phosphate. Glycogen phosphorylase phosphorolyzes alpha-1,4 linkages from nonreducing ends until it stalls about four residues from each branch. The transferase activity of the debranching enzyme then moves a block of three residues from the stub onto the end of a neighboring chain, where those residues become ordinary alpha-1,4 substrate for phosphorylase and are released as glucose 1-phosphate. The single branch point residue left behind is hydrolyzed, not phosphorolyzed, by the alpha-1,6 glucosidase activity, so it emerges as free glucose. With 8 branch points, exactly 8 residues are freed as glucose, and the remaining 112 of the 120 residues are recovered as glucose 1-phosphate. The arithmetic generalizes: for any granule fragment degraded to completion by this enzyme pair, the number of free glucose molecules equals the number of alpha-1,6 branch points, and every remaining residue is recovered in the phosphorylated pool. (Choice A) This assumes every linkage is cleaved phosphorolytically; the glucosidase step uses water rather than inorganic phosphate, so each branch residue is released without a phosphate group, and 8 of the 120 residues therefore appear as free glucose. (Choice B) This inverts the two product pools; free glucose is the minor product, limited to one residue per branch, while glucose 1-phosphate is the bulk product of chain phosphorolysis. (Choice C) This counts the entire four-residue stub at each branch as free glucose, but the transferase relocates three of those residues intact onto the main chain for later phosphorolysis; only the one alpha-1,6-linked residue per branch is hydrolyzed free. This is a Data-based and Statistical Reasoning question because it requires converting a stated branch count into an exact quantitative split between the hydrolytic and phosphorolytic products of glycogen degradation.$q$,
    'hard',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    4,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$ignores hydrolytic branch step$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', $q$inverted product pools$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$whole-stub-released error$q$ FROM q;

-- B2 Q7 . phosphoglucomutase glycogen glycolysis junction . medium . skill 2 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$phosphoglucomutase glycogen glycolysis junction$q$,
    $q$A cultured myoblast line carries an inducible loss-of-function mutation in phosphoglucomutase. The cells are first allowed to accumulate normal glycogen stores, and the mutation is then induced; afterward, glycogen phosphorylase, the debranching enzyme, hexokinase, and all glycolytic enzymes assay at normal activity, while phosphoglucomutase activity is undetectable. When these cells face an acute increase in ATP demand, which direct metabolic consequence is expected?$q$,
    $q$[{"label":"A","text":"Glucose 1-phosphate produced by glycogenolysis accumulates because it cannot be converted into an intermediate that enters glycolysis."},{"label":"B","text":"Free glucose released at former branch points cannot be phosphorylated and is trapped as unusable fuel."},{"label":"C","text":"Glucose taken up from the culture medium can no longer be phosphorylated, blocking glycolytic entry of extracellular fuel."},{"label":"D","text":"Glycolysis stops at the step converting glucose 6-phosphate to fructose 6-phosphate."}]$q$::jsonb,
    'A',
    $q$This Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway question tests the role of phosphoglucomutase as the junction connecting glycogen stores to glycolysis. The answer is A because phosphorolysis of glycogen yields glucose 1-phosphate, a metabolite that no glycolytic enzyme accepts; phosphoglucomutase must first interconvert glucose 1-phosphate and glucose 6-phosphate before glycogen-derived carbon can enter the glycolytic sequence. When this mutase is absent, phosphorylase still cleaves glycogen normally, but its product piles up at a dead end, cut off from the pathway that would burn it. The same enzyme works in the opposite direction when glucose is being stored, carrying glucose 6-phosphate toward glucose 1-phosphate for activation, which is why phosphoglucomutase sits at the crossroads between glycogen metabolism and the glycolytic and gluconeogenic mainline, and why the glycogen in these cells had to be laid down before the mutation was switched on. Importantly, glucose entering the cell from outside bypasses this junction entirely, because hexokinase phosphorylates it directly at carbon 6. The result is a cell starving beside a full pantry: glycogen reserves are intact and fully mobilizable, yet the released carbon cannot cross the single enzymatic bridge into the energy-producing pathway. (Choice B) The small amount of free glucose released at former branch points is a hexokinase substrate; its phosphorylation does not involve phosphoglucomutase and proceeds normally in these cells. (Choice C) Extracellular glucose is phosphorylated by hexokinase directly to glucose 6-phosphate, which enters glycolysis without ever passing through glucose 1-phosphate, so fuel from the medium is unaffected. (Choice D) The conversion of glucose 6-phosphate to fructose 6-phosphate is catalyzed by phosphoglucose isomerase, a distinct and fully active enzyme here; the trap is confusing the mutase, which moves a phosphate between carbons of glucose, with the isomerase, which converts an aldose to a ketose. This is a Scientific Reasoning and Problem Solving question because it requires predicting which metabolic connection is severed when the enzyme linking glycogenolysis to glycolysis is removed while all neighboring enzymes remain functional.$q$,
    'medium',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    2,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'process_step_confusion', $q$wrong enzyme assigned to branch glucose$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$misplaces the junction on the uptake route$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$real step, wrong enzyme attribution$q$ FROM q;

-- B2 Q8 . AMP calcium muscle phosphorylase activation . easy . skill 2 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$AMP calcium muscle phosphorylase activation$q$,
    $q$During high-intensity exercise, intracellular conditions in a contracting skeletal muscle fiber change within seconds. Which of the following changes increases glycogen phosphorylase activity in the fiber, promoting glycogen mobilization without requiring any circulating hormonal signal?

I. A rise in cytosolic AMP concentration
II. Release of calcium from the sarcoplasmic reticulum
III. A rise in cytosolic ATP concentration$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"I and II only"},{"label":"C","text":"II and III only"},{"label":"D","text":"I, II, and III"}]$q$::jsonb,
    'B',
    $q$This Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway question tests hormone-independent control of glycogen phosphorylase in contracting skeletal muscle. The answer is B because both a rise in AMP and calcium release couple glycogen mobilization directly to the fiber's internal state, while a rise in ATP signals energy sufficiency and works in the opposite direction. AMP binds the nucleotide site of muscle glycogen phosphorylase and shifts the enzyme toward its active R state, so the very molecule that accumulates as ATP is consumed switches on the fuel supply. Calcium released from the sarcoplasmic reticulum during excitation-contraction coupling binds the calmodulin subunit of phosphorylase kinase, activating it and thereby increasing phosphorylase activity, which synchronizes glycogen breakdown with contraction itself. The AMP signal is also amplified, because even small fractional drops in ATP produce proportionally large rises in AMP through the adenylate kinase equilibrium, letting a maximally contracting fiber ramp up glucose 1-phosphate output within moments of stimulation. Neither signal requires any circulating hormone; the fiber senses its own energy state and contractile activity from the inside. (Choice A) This captures the AMP effect but omits calcium, which links every contraction cycle to glycogen mobilization and raises phosphorylase activity just as surely during intense exercise. (Choice C) This reverses the nucleotide logic; ATP competes with AMP and stabilizes the less active conformation, since an energy-replete fiber has no need to draw down its glycogen, and this choice also discards the genuine AMP signal. (Choice D) Including item III treats any adenine nucleotide as an activator, but AMP and ATP report opposite energy states, and only the low-energy signal AMP promotes phosphorylase activity. This is a Scientific Reasoning and Problem Solving question because it requires sorting intracellular signals by whether each one activates or opposes glycogen mobilization according to the energy and contractile logic of the muscle fiber.$q$,
    'easy',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    2,
    65
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$incomplete signal set$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', $q$inverted nucleotide logic$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$nucleotides-equivalent error$q$ FROM q;

-- B2 Q9 . convergent final glucose release step . hard . skill 3 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$convergent final glucose release step$q$,
    $q$A research team evaluates a child with severe fasting hypoglycemia whose liver biopsy shows abundant glycogen of normal structure. In a controlled protocol, an infusion of alanine, a substrate the liver can carry toward glucose, fails to raise blood glucose, and a separate maneuver that triggers hepatic glycogen breakdown also fails. In both challenges, intrahepatic glucose 6-phosphate rises well above baseline. Assuming a single enzyme deficiency, which conclusion do the paired challenge results best support?$q$,
    $q$[{"label":"A","text":"Glycogen phosphorylase is deficient, which explains the failure of the glycogen breakdown challenge."},{"label":"B","text":"A gluconeogenic enzyme acting upstream of glucose 6-phosphate is deficient, which explains the failure of the alanine challenge."},{"label":"C","text":"Two separate deficiencies, one in each pathway, must be present to account for both failed challenges."},{"label":"D","text":"Glycogenolysis and gluconeogenesis converge on one shared terminal step, so deficiency of the enzyme that releases free glucose from glucose 6-phosphate accounts for both failures."}]$q$::jsonb,
    'D',
    $q$This Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway question tests the convergence of glycogenolysis and gluconeogenesis on a single terminal enzymatic step. The answer is D because the two challenge tests probe different pathways yet fail in the same way, with glucose 6-phosphate accumulating in both, and a single deficiency can explain that pattern only if it lies at a step the two pathways share. Carbon mobilized from hepatic glycogen and carbon built up from alanine both arrive at glucose 6-phosphate, and free glucose can leave the liver for the blood only after glucose-6-phosphatase removes the phosphate. A block at this final step therefore strands the products of both pathways, which is exactly what the rising intrahepatic glucose 6-phosphate in both tests demonstrates: each pathway ran, delivered carbon to the common intermediate, and then stopped at the same locked gate. That convergence is the architectural point: two pathways with different starting materials and different enzymology nonetheless depend on one shared exit step to deliver free glucose to the blood. The abundant, structurally normal glycogen further confirms that the storage machinery upstream is intact. (Choice A) A phosphorylase deficiency would prevent glycogen from being degraded at all, so the glycogen breakdown challenge would not have raised glucose 6-phosphate, and this lesion would leave the failed alanine challenge entirely unexplained. (Choice B) A gluconeogenic deficiency upstream of glucose 6-phosphate would produce a failed alanine test without any rise in glucose 6-phosphate from that arm, and in a single-deficiency model it could not account for the failed glycogen challenge. (Choice C) Invoking two independent deficiencies contradicts the stated single-enzyme assumption and is unnecessary, since one shared distal lesion is the more parsimonious account and the data fully support it. This is a Reasoning about the Design and Execution of Research question because it asks you to interpret a paired-challenge experimental design and use the metabolite accumulation shared across both tests to localize the lesion to the step where the two pathways converge.$q$,
    'hard',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    3,
    105
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'process_step_confusion', $q$explains one arm, contradicted by metabolite data$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$one-arm explanation$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$parsimony failure$q$ FROM q;

-- B2 Q10 . pyruvate carboxylase reaction package . easy . skill 1 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$pyruvate carboxylase reaction package$q$,
    $q$During gluconeogenesis, the pyruvate kinase step of glycolysis cannot simply run in reverse, so hepatocytes first convert pyruvate into a four carbon intermediate. Which combination of required cofactor, subcellular compartment, and product characterizes this initial bypass reaction?$q$,
    $q$[{"label":"A","text":"Thiamine pyrophosphate cofactor, mitochondrial matrix, oxaloacetate product"},{"label":"B","text":"Biotin cofactor, cytosol, oxaloacetate product"},{"label":"C","text":"Biotin cofactor, mitochondrial matrix, phosphoenolpyruvate product"},{"label":"D","text":"Biotin cofactor, mitochondrial matrix, oxaloacetate product"}]$q$::jsonb,
    'D',
    $q$This question falls under Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway and tests the cofactor, compartment, and product package of pyruvate carboxylase, the enzyme that begins the bypass of pyruvate kinase. The answer is D because pyruvate carboxylase is a biotin dependent enzyme of the mitochondrial matrix that uses ATP and bicarbonate to carboxylate three carbon pyruvate into four carbon oxaloacetate. Biotin is covalently tethered to the enzyme and acts as a swinging carrier that first accepts an activated carboxyl group and then delivers it to pyruvate. The pyruvate kinase step of glycolysis releases far too much free energy to run backward, so gluconeogenesis must climb around it in two stages, and this carboxylation is the first stage. The mitochondrial location fits the logic of the pathway: pyruvate is delivered into the matrix, is carboxylated there, and the resulting oxaloacetate must subsequently be moved toward the cytosol for the later reactions of glucose synthesis. The ATP spent here is part of the extra energetic price that makes the bypass thermodynamically favorable in the synthetic direction, and because biotin is a B vitamin obtained from the diet, its deficiency impairs this and other carboxylation reactions. (Choice A) Thiamine pyrophosphate is the cofactor of enzymes that decarboxylate alpha keto acids; it helps remove carbon dioxide rather than add it, so it cannot support a carboxylation reaction. (Choice B) The cytosol is where the second bypass enzyme, phosphoenolpyruvate carboxykinase, completes the detour; assigning the carboxylation itself to the cytosol swaps the compartments of the two halves of the bypass. (Choice C) Phosphoenolpyruvate is formed one reaction later, when oxaloacetate is simultaneously decarboxylated and phosphorylated; pyruvate carboxylase stops at oxaloacetate and never generates a phosphorylated product. This is a Knowledge of Scientific Concepts and Principles question because it asks for direct recall of the cofactor requirement, subcellular location, and product that define the pyruvate carboxylase reaction.$q$,
    'easy',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    1,
    60
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'adjacent_fact', $q$wrong cofactor from a neighboring pyruvate enzyme$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', $q$compartment swapped with the second bypass enzyme$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$correct cofactor and compartment, product from the next step$q$ FROM q;

-- B2 Q11 . bypass enzyme to step mapping . medium . skill 2 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$bypass enzyme to step mapping$q$,
    $q$Gluconeogenesis retraces most of glycolysis but must detour around each irreversible glycolytic reaction using dedicated enzymes. Which of the following pairings correctly matches an irreversible glycolytic enzyme with the gluconeogenic machinery that bypasses it?

I. Pyruvate kinase, bypassed by the sequential actions of pyruvate carboxylase and phosphoenolpyruvate carboxykinase
II. Phosphofructokinase-1, bypassed by fructose-1,6-bisphosphatase
III. Glucokinase, bypassed by fructose-1,6-bisphosphatase$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"I and II only"},{"label":"C","text":"II and III only"},{"label":"D","text":"I, II, and III"}]$q$::jsonb,
    'B',
    $q$This question falls under Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway and tests the map between the three irreversible glycolytic reactions and the four gluconeogenic enzymes that bypass them. The answer is B because pairings I and II are correct while pairing III attaches an enzyme to the wrong checkpoint. Most of the reactions of glycolysis are freely reversible and are shared by both pathways, but the steps catalyzed by glucokinase or hexokinase, phosphofructokinase-1, and pyruvate kinase release too much free energy to run backward, so gluconeogenesis replaces each with dedicated machinery. Pairing I is correct: the pyruvate kinase step is bypassed in two stages, with pyruvate carboxylase converting pyruvate to oxaloacetate and phosphoenolpyruvate carboxykinase converting oxaloacetate to phosphoenolpyruvate, which is why one glycolytic enzyme requires two gluconeogenic enzymes and the full bypass map contains four enzymes for three steps. Pairing II is correct: fructose-1,6-bisphosphatase hydrolyzes the phosphate that phosphofructokinase-1 installed, regenerating fructose 6-phosphate. Pairing III is wrong on the enzyme side: the glucokinase step is undone by glucose-6-phosphatase, which releases free glucose, whereas fructose-1,6-bisphosphatase acts one checkpoint earlier and cannot act on glucose 6-phosphate. (Choice A) Selecting I only wrongly rejects the fructose-1,6-bisphosphatase pairing, which is a genuine and central piece of the bypass map. (Choice C) This combination accepts the mismatched glucokinase pairing while rejecting the two enzyme sequence of pairing I, inverting the actual map at both ends of the pathway. (Choice D) Accepting all three pairings treats fructose-1,6-bisphosphatase as if any phosphatase could reverse any kinase step, but each bypass enzyme is specific for a single substrate at a single checkpoint. This is a Scientific Reasoning and Problem Solving question because it requires matching each irreversible glycolytic reaction to the specific gluconeogenic enzyme or enzyme pair that detours around it and rejecting a deliberately swapped pairing.$q$,
    'medium',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    2,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$accepts one true pairing, rejects another$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$swaps checkpoints at both ends of the map$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$any phosphatase reverses any kinase$q$ FROM q;

-- B2 Q12 . acetyl CoA activation of pyruvate carboxylase . hard . skill 2 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$acetyl CoA activation of pyruvate carboxylase$q$,
    $q$In isolated liver mitochondria supplied with a constant amount of pyruvate, an investigator raises the matrix concentration of acetyl CoA without changing any other condition. The rate at which pyruvate is converted to a four carbon product increases sharply. Which mechanism accounts for this observation?$q$,
    $q$[{"label":"A","text":"Acetyl CoA binds a regulatory site on pyruvate carboxylase distinct from the active site and increases the enzyme's activity"},{"label":"B","text":"Acetyl CoA is consumed as a second substrate of pyruvate carboxylase, so raising its concentration drives the reaction by mass action"},{"label":"C","text":"Acetyl CoA stimulates phosphoenolpyruvate carboxykinase, which pulls the four carbon product forward and accelerates the carboxylation upstream"},{"label":"D","text":"Acetyl CoA inhibits pyruvate kinase, preventing phosphoenolpyruvate from being reconverted to pyruvate and raising net carboxylation"}]$q$::jsonb,
    'A',
    $q$This question falls under Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway and tests the allosteric activation of pyruvate carboxylase by acetyl CoA. The answer is A because acetyl CoA is a positive allosteric effector of pyruvate carboxylase: it binds at a regulatory site distinct from the active site and increases the enzyme's catalytic activity, so raising its matrix concentration increases the rate of pyruvate carboxylation even though the pyruvate supply is unchanged. The logic of this experiment operates entirely at the level of the enzyme and its effector: when acetyl CoA binds the regulatory site, the enzyme shifts toward a more active state, so the same delivery of pyruvate supports a faster carboxylation rate. Because the observation was produced by changing a single molecule's concentration in an isolated system, the only mechanism that can link that molecule directly to increased carboxylase flux is effector binding to the carboxylase itself. (Choice B) Acetyl CoA is not a substrate of pyruvate carboxylase; the carbon added to pyruvate comes from bicarbonate activated at the expense of ATP, so a mass action argument based on consuming acetyl CoA fails at the level of the reaction's stoichiometry. (Choice C) Phosphoenolpyruvate carboxykinase is a cytosolic enzyme without significant allosteric regulation, and a downstream pull on the product could not produce the sharp rate increase measured at the carboxylation step inside isolated mitochondria. (Choice D) Acetyl CoA does inhibit pyruvate kinase, but pyruvate kinase is a cytosolic glycolytic enzyme; in isolated mitochondria supplied with a fixed amount of pyruvate there is no phosphoenolpyruvate recycling to suppress, so this true regulatory fact cannot explain the measured change. This is a Scientific Reasoning and Problem Solving question because it requires inferring which regulatory mechanism can causally connect a controlled rise in a single effector to an increased flux through a specific enzyme.$q$,
    'hard',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    2,
    95
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'misconception', $q$effector mistaken for substrate$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$regulation displaced onto the downstream bypass enzyme$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$true fact that cannot explain this system$q$ FROM q;

-- B2 Q13 . oxaloacetate malate exit route . hard . skill 2 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$oxaloacetate malate exit route$q$,
    $q$In hepatocytes, the second bypass enzyme of gluconeogenesis resides in the cytosol, yet its four carbon substrate is produced inside the mitochondrial matrix, and the inner membrane lacks an effective carrier for that substrate. A tracer study follows the labeled carbons of the matrix intermediate until they appear in phosphoenolpyruvate. Which sequence of transport and reaction steps do the labeled carbons follow?$q$,
    $q$[{"label":"A","text":"The intermediate is exported as citrate, cleaved in the cytosol to regenerate the four carbon compound, which is then decarboxylated and phosphorylated using GTP"},{"label":"B","text":"The intermediate is reduced to malate, which exits to the cytosol and is reoxidized; the four carbon compound is then further carboxylated and phosphorylated using GTP"},{"label":"C","text":"The intermediate is reduced to malate, which exits to the cytosol and is reoxidized; the four carbon compound is then decarboxylated and phosphorylated using GTP"},{"label":"D","text":"The intermediate is reduced to malate, which exits to the cytosol and is reoxidized; the four carbon compound is then decarboxylated and phosphorylated using ATP"}]$q$::jsonb,
    'C',
    $q$This question falls under Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway and tests the phosphoenolpyruvate carboxykinase package: how oxaloacetate reaches the cytosolic enzyme and what chemistry the enzyme performs. The answer is C because the inner mitochondrial membrane has no effective oxaloacetate carrier, so matrix oxaloacetate is first reduced to malate, malate crosses the inner membrane on its own transporter, and cytosolic malate dehydrogenase reoxidizes it to oxaloacetate; phosphoenolpyruvate carboxykinase then removes the carboxyl group that pyruvate carboxylase had added and transfers a phosphoryl group from GTP, yielding phosphoenolpyruvate. The decarboxylation is not wasted effort, because losing carbon dioxide helps drive formation of the high energy enol phosphate, and GTP rather than ATP is the required phosphoryl donor. Tracing the label therefore requires two changes of chemical identity around the membrane crossing, oxaloacetate to malate in the matrix and malate back to oxaloacetate in the cytosol, before the final decarboxylating phosphorylation. (Choice A) Citrate export with cytosolic cleavage back to a four carbon compound is a real mitochondrial exit strategy, but it belongs to a different biosynthetic context and requires ATP citrate lyase; it is not the route that feeds phosphoenolpyruvate carboxykinase in gluconeogenesis. (Choice B) This option reverses the chemistry of the final step: phosphoenolpyruvate carboxykinase removes a carboxyl group from the four carbon substrate to give a three carbon product, and adding another carboxyl group would move the pathway away from phosphoenolpyruvate entirely. (Choice D) The malate route and the decarboxylation are correct here, but phosphoenolpyruvate carboxykinase is specific for GTP as its phosphoryl donor, a nucleotide detail that distinguishes it from most of the kinases encountered in glycolysis. This is a Scientific Reasoning and Problem Solving question because it requires combining a membrane transport constraint with the reaction chemistry of the second bypass enzyme to trace carbon from the matrix to phosphoenolpyruvate.$q$,
    'hard',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    2,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'process_step_confusion', $q$borrowed exit route from another pathway$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', $q$reaction direction inverted at the final step$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$wrong but analogous nucleotide$q$ FROM q;

-- B2 Q14 . reciprocal effector control at FBPase-1 . hard . skill 2 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$reciprocal effector control at FBPase-1$q$,
    $q$A hepatocyte lysate held at fixed substrate concentrations is split into two aliquots. AMP is added to the first aliquot and fructose 2,6-bisphosphate to the second. In both aliquots, the rate of conversion of fructose 1,6-bisphosphate to fructose 6-phosphate falls sharply. What should happen to flux through phosphofructokinase-1 in these same aliquots, and why?$q$,
    $q$[{"label":"A","text":"Flux falls, because an effector that inhibits the bisphosphatase inhibits phosphofructokinase-1 as well."},{"label":"B","text":"Flux rises, because both added molecules activate phosphofructokinase-1 even as they inhibit the bisphosphatase."},{"label":"C","text":"Flux is unchanged, because phosphofructokinase-1 is controlled by ATP and citrate rather than by these two molecules."},{"label":"D","text":"Flux rises, because slowing the bisphosphatase leaves more fructose 6-phosphate for the kinase, with no direct effect on the kinase itself."}]$q$::jsonb,
    'B',
    $q$This item falls under Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway and tests how one pair of allosteric effectors sets opposite directions at fructose-1,6-bisphosphatase and at phosphofructokinase-1. The answer is B because AMP and fructose 2,6-bisphosphate each bind fructose-1,6-bisphosphatase and inhibit it while binding phosphofructokinase-1 and activating it, so the very additions that slowed the hydrolysis step must accelerate the kinase step. Fructose-1,6-bisphosphatase hydrolyzes fructose 1,6-bisphosphate to fructose 6-phosphate plus inorganic phosphate and is the rate-limiting reaction of glucose synthesis, which is the activity the lysate data report. Phosphofructokinase-1 catalyzes the opposing kinase reaction and carries the principal control point of glycolysis. Because the two enzymes read the same two small molecules with opposite signs, a single effector concentration is enough to specify which way the fructose 6-phosphate and fructose 1,6-bisphosphate interconversion actually runs. Answering therefore means reading an observed inhibition backward through the shared effector rather than through substrate bookkeeping.

(Choice A) A fall in kinase flux would require both molecules to act with the same sign at the two enzymes. AMP and fructose 2,6-bisphosphate are inhibitors at the bisphosphatase and activators at the kinase, so their effects on the two enzymes must diverge, not match.

(Choice C) ATP and citrate are indeed negative effectors of phosphofructokinase-1, which makes this choice tempting, but naming them does not exclude AMP and fructose 2,6-bisphosphate, both of which are potent positive effectors of that same enzyme. Neither ATP nor citrate was manipulated here, so predicting no response ignores the additions that were actually made.

(Choice D) The predicted direction is right, but the mechanism is not. Inhibiting the bisphosphatase leaves less fructose 6-phosphate rather than more, since that hydrolysis is precisely what generates fructose 6-phosphate at this step, and the kinase is switched on by direct binding of the added effectors rather than by any change in how much substrate reaches it. This is a Scientific Reasoning and Problem Solving question because it asks the test taker to convert an observed inhibition at fructose-1,6-bisphosphatase into a predicted flux change at phosphofructokinase-1 using the shared effector pair.$q$,
    'hard',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    2,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'reversed_relationship', $q$same-sign-at-both-enzymes$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$true-fact-wrong-exclusivity$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$substrate-supply-instead-of-allostery$q$ FROM q;

-- B2 Q15 . glucose-6-phosphatase endoplasmic reticulum compartment . medium . skill 2 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$glucose-6-phosphatase endoplasmic reticulum compartment$q$,
    $q$Sealed vesicles derived from hepatocyte endoplasmic reticulum are incubated with a saturating concentration of glucose 6-phosphate, and the release of free phosphate is measured. The sealed preparation releases phosphate slowly. When the same preparation is treated with a mild detergent that breaks the vesicles open, the measured rate increases roughly sixfold. Which explanation best accounts for the difference?$q$,
    $q$[{"label":"A","text":"The detergent releases glucose that had accumulated inside the vesicles, relieving product inhibition of a cytosol-facing active site."},{"label":"B","text":"The enzyme requires ATP to drive the reaction, and ATP cannot cross an intact vesicle membrane."},{"label":"C","text":"The active site faces the cytosol, so glucose 6-phosphate must first be carried out of the lumen before it can be hydrolyzed."},{"label":"D","text":"The active site faces the lumen, so hydrolysis in sealed vesicles is limited by transport of glucose 6-phosphate across the membrane."}]$q$::jsonb,
    'D',
    $q$This item falls under Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway and tests the compartmentalization of glucose-6-phosphatase, the enzyme that releases free glucose at the end of hepatic glucose output. The answer is D because the catalytic site of glucose-6-phosphatase is oriented toward the lumen of the endoplasmic reticulum, so in a sealed vesicle the rate is capped by how fast a membrane transporter delivers glucose 6-phosphate inward, and opening the membrane removes that cap. Saturating substrate in the surrounding buffer is not the same as saturating substrate at the active site when a membrane stands between them, which is why the sealed and broken preparations differ so much. The same topology sets a requirement in the intact cell: glucose 6-phosphate is carried into the lumen, hydrolyzed there, and the free glucose and phosphate are then carried back out to the cytosol before glucose can leave the cell. Recognizing that a membrane barrier, not the chemistry of the reaction, is what changed is the inferential step here.

(Choice A) Product accumulation cannot explain the result, because the assay was run with saturating substrate and measures phosphate release rather than a reversible approach to equilibrium. It also places the active site on the cytosolic face, which would predict that sealed and opened vesicles behave alike.

(Choice B) Glucose-6-phosphatase is a hydrolase; it cleaves the phosphate ester using water and consumes no ATP, so ATP access across the membrane is irrelevant to the rate in either condition.

(Choice C) This choice inverts the geometry. If the active site faced the cytosol, substrate added outside would reach it immediately and breaking the vesicles would change little, and the choice further requires glucose 6-phosphate to exit a lumen it was never described as entering. This is a Scientific Reasoning and Problem Solving question because it asks the test taker to infer enzyme topology from the difference in rate between sealed and permeabilized vesicles.$q$,
    'medium',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    2,
    90
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'process_step_confusion', $q$product-inhibition-substitution$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$phantom-ATP-requirement$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', $q$inverted-membrane-topology$q$ FROM q;

-- B2 Q16 . gluconeogenesis compartment span and organs . easy . skill 1 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$gluconeogenesis compartment span and organs$q$,
    $q$An isolated perfused liver is supplied with carbon-13 labeled pyruvate, and labeled glucose subsequently appears in the perfusate. When a single reaction confined to the mitochondrial matrix is selectively blocked, labeled glucose no longer forms, even though every other enzyme of the pathway remains fully active and supplied with substrate. Which characterization of gluconeogenesis is most consistent with this result and with where the pathway normally operates?$q$,
    $q$[{"label":"A","text":"It runs partly in the mitochondrial matrix and partly in the cytosol, and it is carried mainly by the liver with a smaller contribution from the kidney."},{"label":"B","text":"Every step runs in the cytosol, and mitochondria contribute only the ATP and GTP that the pathway consumes."},{"label":"C","text":"Every step runs in the mitochondrial matrix, and the finished glucose is exported from the matrix for release."},{"label":"D","text":"It runs partly in the mitochondrial matrix and partly in the cytosol, but only hepatocytes perform it, since kidney cells cannot synthesize glucose."}]$q$::jsonb,
    'A',
    $q$This item falls under Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway and tests where the reactions of gluconeogenesis are located, both within the cell and among organs. The answer is A because the pathway is split across two compartments, beginning with a matrix reaction that commits pyruvate carbon toward glucose and finishing with cytosolic reactions, and because the liver performs most of this synthesis while the kidney performs the rest. The tracer result shows that the rest of the pathway, though fully active, cannot make glucose on its own, which places an indispensable step inside the matrix; knowing that the remaining reactions run in the cytosol, and knowing the organ distribution, are separate facts the test taker must bring to the question. Glycolysis, by contrast, is entirely cytosolic, so the compartment split is a feature that distinguishes glucose synthesis from glucose breakdown rather than a mirror image of it.

(Choice B) A purely cytosolic pathway would keep making labeled glucose when a matrix reaction is blocked, provided ATP and GTP were still available, which is exactly what the experiment rules out.

(Choice C) The cytosolic enzymes of the pathway are real participants, and the final steps of glucose formation occur outside the matrix, so a wholly mitochondrial scheme with glucose leaving the matrix does not describe this pathway.

(Choice D) The compartment statement here is correct, but the organ statement is not. The kidney also synthesizes glucose from noncarbohydrate precursors, contributing a real if smaller share of the body's output alongside the liver. This is a Knowledge of Scientific Concepts and Principles question because it asks the test taker to recall the two-compartment organization of gluconeogenesis and the organs that carry it out.$q$,
    'easy',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    1,
    70
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'misconception', $q$mirror-of-glycolysis$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$all-steps-in-one-organelle$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$liver-only-restriction$q$ FROM q;

-- B2 Q17 . Oxidative phase carbon accounting . hard . skill 4 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$Oxidative phase carbon accounting$q$,
    $q$A liver cytosol preparation carries out only the oxidative phase of the pentose phosphate pathway and is supplied with excess NADP+. Three measurements are made. For every 1.0 mol of glucose 6-phosphate consumed, 1.0 mol of CO2 is released. When the substrate is glucose 6-phosphate radiolabeled with 14C at carbon 1, more than 95% of the radioactivity is recovered in the released CO2. When the substrate is instead radiolabeled at carbon 6, more than 95% of the radioactivity is recovered in the phosphorylated sugar product. Which conclusion do these data best support?$q$,
    $q$[{"label":"A","text":"Carbon 6 of glucose 6-phosphate is released as CO2, so the sugar product is built from carbons 1 through 5 of the substrate."},{"label":"B","text":"CO2 is released at the glucose 6-phosphate dehydrogenase step, so decarboxylation occurs before 6-phosphogluconate is formed."},{"label":"C","text":"Carbon 1 leaves as CO2 at the 6-phosphogluconate dehydrogenase step, leaving a five-carbon sugar phosphate composed of carbons 2 through 6."},{"label":"D","text":"Each oxidation step of the phase releases one CO2, so two carbons are lost per substrate and the sugar product is a four-carbon phosphate."}]$q$::jsonb,
    'C',
    $q$This Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway question tests the carbon bookkeeping of the oxidative phase of the pentose phosphate pathway. The answer is C because the three observations together identify both how many carbons leave and which carbon it is. The stoichiometric result, 1.0 mol of CO2 per 1.0 mol of glucose 6-phosphate consumed, means exactly one carbon is removed from each six-carbon substrate, so the phosphorylated sugar product must contain five carbons. The paired labeling experiments then assign the lost carbon: a label placed on carbon 1 is recovered in the released CO2, while a label placed on carbon 6 stays in the sugar product, so the carbon that departs is C1 and the product retains carbons 2 through 6. Within the oxidative phase, the only CO2-releasing step is the oxidative decarboxylation catalyzed by 6-phosphogluconate dehydrogenase. Glucose 6-phosphate dehydrogenase oxidizes C1 to a lactone carbonyl without releasing any carbon, lactonase hydrolysis opens the ring to give 6-phosphogluconate with C1 as a carboxylate, and oxidation at C3 converts C1 into a beta-keto acid carboxylate that is lost as CO2, yielding the five-carbon product ribulose 5-phosphate. (Choice A) reverses the labeling result. The data show the carbon 6 label remaining in the sugar product and the carbon 1 label appearing in CO2, so carbon 6 cannot be the carbon released; a product built from carbons 1 through 5 would have carried the carbon 1 label, which is not observed. (Choice B) assigns the decarboxylation to the wrong step. Glucose 6-phosphate dehydrogenase performs a dehydrogenation that forms 6-phosphogluconolactone; no carbon leaves until after the lactone is hydrolyzed and the resulting acid is oxidized, so CO2 release follows, rather than precedes, the formation of 6-phosphogluconate. (Choice D) miscounts the departing carbons. Although the phase contains two oxidation steps, only one of them is a decarboxylation, and the measured yield of 1.0 mol CO2 per mole of substrate directly rules out the loss of two carbons; a four-carbon product would also require a CO2 yield of 2.0 mol per mole of substrate. This is a Data-based and Statistical Reasoning question because it requires integrating a measured CO2 stoichiometry with the recovery patterns of two positional radiolabels to deduce which specific carbon is excised and the carbon count of the resulting sugar, none of which is stated in the stem.$q$,
    'hard',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    4,
    95
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'reversed_relationship', $q$terminal-carbon swap$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', $q$wrong enzyme assigned to the decarboxylation$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'scale_unit_error', $q$double-counted decarboxylation$q$ FROM q;

-- B2 Q18 . NADP ratio control of committed step . hard . skill 4 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$NADP ratio control of committed step$q$,
    $q$Hepatocytes maintained with insulin contain about three times more glucose 6-phosphate dehydrogenase protein than untreated cells, because the hormone induces transcription of the gene. In one experiment, the cytosolic NADP+ to NADPH ratio in these cells measures 0.02 at baseline; after addition of a compound that rapidly consumes NADPH, the ratio rises to 5 within minutes. Based on these measurements, what happens to flux through the first committed reaction of the pentose phosphate pathway during those minutes?$q$,
    $q$[{"label":"A","text":"Flux rises sharply, because the increase in available NADP+ supplies the electron acceptor the dehydrogenase requires while the fall in NADPH relieves inhibition of the enzyme."},{"label":"B","text":"Flux falls, because NADP+ is the principal inhibitor of the dehydrogenase and its accumulation shuts down the oxidative branch."},{"label":"C","text":"Flux is unchanged, because a committed, irreversible reaction proceeds at a fixed rate that cofactor concentrations cannot influence."},{"label":"D","text":"Flux rises only after several hours, because the response requires the compound to induce transcription of additional dehydrogenase, as insulin did."}]$q$::jsonb,
    'A',
    $q$This question falls under Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway and tests regulation of glucose 6-phosphate dehydrogenase, the committed and rate limiting step of the pentose phosphate pathway, by the NADP+ to NADPH ratio. The answer is A because the dehydrogenase responds directly and immediately to the balance of its cofactor couple. NADP+ is the electron acceptor the reaction consumes, and NADPH inhibits the enzyme, so at the baseline ratio of 0.02 the pool is almost entirely NADPH: the enzyme is starved of acceptor and strongly inhibited, and flux is held low. When the added compound consumes NADPH and the ratio climbs to 5, NADP+ becomes abundant at the same moment the inhibitor disappears, so both constraints lift together and flux through the committed step rises sharply within minutes. This effector level control is the pathway's central logic: NADPH production automatically tracks NADPH consumption, with no change in enzyme amount required. The insulin induction in the stem sets how much enzyme is present, but the minute to minute flux decision belongs to the cofactor ratio acting on that existing enzyme. (Choice B) reverses the roles of the redox couple; NADP+ is the required acceptor whose availability drives flux forward, not an inhibitor, so its accumulation opens rather than closes the branch. (Choice C) confuses thermodynamic irreversibility with insensitivity to regulation; committed, irreversible steps are exactly where pathways concentrate control, and this enzyme's rate varies steeply with the cofactor ratio. (Choice D) confuses two timescales of control; transcriptional induction of the kind insulin produces raises enzyme quantity over hours, whereas the flux response to a shifted cofactor ratio works through enzyme molecules already present and is complete within minutes, as the measurement window indicates. This is a Data-based and Statistical Reasoning question because it asks for a directional prediction of pathway flux inferred from quantitative NADP+ to NADPH ratios measured before and after a perturbation.$q$,
    'hard',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    4,
    95
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'reversed_relationship', $q$activator and inhibitor exchanged$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$irreversible means unregulated$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$wrong regulatory timescale$q$ FROM q;

-- B2 Q19 . NADPH glutathione peroxide defense chain . easy . skill 2 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$NADPH glutathione peroxide defense chain$q$,
    $q$A mature erythrocyte depends on the oxidative branch of the pentose phosphate pathway to regenerate its cytosolic NADPH. If this NADPH supply dwindles, why does the cell become vulnerable to damage from hydrogen peroxide?$q$,
    $q$[{"label":"A","text":"NADPH normally binds hydrogen peroxide directly and converts it to water without any intermediary."},{"label":"B","text":"NADH from glycolysis takes over glutathione reduction but works too slowly to keep pace with peroxide formation."},{"label":"C","text":"Oxidized glutathione is the species that neutralizes peroxides, and without NADPH the cell cannot convert its glutathione to the oxidized form."},{"label":"D","text":"Glutathione can no longer be returned to its reduced state, so the reactions that eliminate peroxides stall for lack of their reducing partner."}]$q$::jsonb,
    'D',
    $q$This question falls under Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway and tests the defensive role of NADPH, which protects cells against peroxides by way of the glutathione system. The answer is D because NADPH does not act on peroxides itself; its job is to keep the cell's pool of glutathione in the reduced state. Reduced glutathione is the working reducing partner for the enzymatic reactions that destroy hydrogen peroxide, and each round of peroxide destruction leaves glutathione in its spent, oxidized form. NADPH supplies the electrons that return glutathione to the reduced, active form, so when NADPH regeneration slows, spent glutathione accumulates, the peroxide destroying reactions stall, and hydrogen peroxide is left free to attack membrane lipids and proteins. The chain therefore runs in one direction: the oxidative branch regenerates NADPH, NADPH regenerates reduced glutathione, and reduced glutathione supports peroxide elimination. In a mature erythrocyte, which has no alternative NADPH source of comparable capacity, the oxidative branch is the upstream guardian of the entire chain, which is why its failure surfaces first as oxidant vulnerability. (Choice A) skips the intermediary; NADPH does not bind or reduce hydrogen peroxide directly, and its protective effect is exerted entirely through maintaining the glutathione pool. (Choice B) treats the two nicotinamide carriers as interchangeable; NADH serves catabolic energy transfer, is not the cofactor used to regenerate glutathione, and cannot substitute in this defense chain at any speed. (Choice C) inverts the redox logic; it is the reduced form of glutathione that supports peroxide destruction, and NADPH's role is to regenerate that reduced form, not to produce the oxidized one. This is a Scientific Reasoning and Problem Solving question because it requires tracing a cause and effect chain from a failing cofactor supply through an intermediate carrier to the collapse of the cell's peroxide defense.$q$,
    'easy',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    2,
    60
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'process_step_confusion', $q$skipped intermediate in a chain$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$carrier interchangeability$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', $q$active form inverted$q$ FROM q;

-- B2 Q20 . oxidant stress hemolysis enzyme lesion . medium . skill 3 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$oxidant stress hemolysis enzyme lesion$q$,
    $q$A patient develops sudden destruction of his red blood cells days after starting an oxidant antimalarial drug, and investigators study his washed erythrocytes to locate the defect. When the cells are incubated with an oxidant challenge, NADPH regeneration fails almost completely, while ATP production from glycolysis remains normal. A deficiency of which enzyme best explains both laboratory findings?$q$,
    $q$[{"label":"A","text":"Glutathione peroxidase"},{"label":"B","text":"Glucose 6-phosphate dehydrogenase"},{"label":"C","text":"Hexokinase"},{"label":"D","text":"Transketolase"}]$q$::jsonb,
    'B',
    $q$This question falls under Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway and tests localization of an enzymatic lesion in the oxidative branch using a pair of discriminating functional assays run on a patient's red cells. The answer is B because glucose 6-phosphate dehydrogenase catalyzes the first, committed reaction of the oxidative branch and is the erythrocyte's essential source of NADPH. A cell deficient in this enzyme cannot regenerate NADPH when an oxidant drug raises demand, which matches the first finding, yet glucose 6-phosphate remains free to flow through glycolysis unimpeded, which matches the preserved ATP production. Without NADPH the erythrocyte cannot maintain its downstream reducing systems, so the drug's oxidant load damages membranes and hemoglobin and the cells are destroyed, producing the clinical episode. The assay pair was chosen to separate the two fates of glucose 6-phosphate at the branch point, so only a lesion in the step committing that metabolite to the oxidative pathway can produce a failed NADPH assay alongside intact glycolysis. (Choice A) names a genuine downstream defense enzyme, but a glutathione peroxidase deficiency would leave NADPH regeneration fully intact when the cells are challenged, contradicting the central laboratory finding; the lesion it produces sits below the cofactor supply being measured. (Choice C) would indeed deprive the oxidative branch of its substrate, but hexokinase also feeds glycolysis, so its loss would depress ATP production as well, and that assay was normal; the intact glycolytic result eliminates any lesion upstream of the branch point. (Choice D) places the defect in the non-oxidative phase; transketolase shuffles carbon skeletons among sugar phosphates and generates no NADPH, so its loss cannot explain a failed NADPH regeneration assay. This is a Reasoning about the Design and Execution of Research question because it asks which candidate lesion is uniquely consistent with both of the discriminating measurements the investigators designed the assay pair to separate.$q$,
    'medium',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    3,
    85
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'adjacent_fact', $q$right chain, wrong link$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$explains one finding, contradicts the other$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$wrong pathway phase$q$ FROM q;

-- B2 Q21 . second oxidative NADPH step probed by substrate entry . medium . skill 3 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$second oxidative NADPH step probed by substrate entry$q$,
    $q$Researchers study fibroblasts in which the gene for the first enzyme of the oxidative pentose phosphate branch has been deleted. In assays of permeabilized cells supplied with excess NADP+, adding glucose 6-phosphate yields no NADPH, but adding 6-phosphogluconate yields NADPH and CO2 at the same rates measured in control cells. Which conclusion do these results best support?$q$,
    $q$[{"label":"A","text":"The deleted enzyme is dispensable for NADPH production, because the modified cells still generated NADPH under one of the assay conditions."},{"label":"B","text":"The deletion inactivated the entire oxidative branch, so any NADPH detected must have originated outside the pathway."},{"label":"C","text":"The oxidative branch contains an additional NADPH-generating oxidation downstream of the deleted step, and it remains functional when an intermediate enters below the block."},{"label":"D","text":"The CO2 release indicates that 6-phosphogluconate was diverted into the citric acid cycle, which supplied the NADPH observed."}]$q$::jsonb,
    'C',
    $q$This question falls under Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway and tests the architecture of the oxidative branch, which generates NADPH at more than one oxidative step. The answer is C because the assay design uses the point of substrate entry as a probe of reaction order. Glucose 6-phosphate must pass through the deleted first enzyme before anything downstream can act, so its failure to yield NADPH confirms that the block is real and that the first oxidation is required for flux beginning at the top of the branch. 6-phosphogluconate enters below the deleted step, and the modified cells convert it to NADPH and CO2 at control rates, which means an intact enzyme downstream of the block carries out its own NADP+ linked oxidation. That downstream reaction is the oxidative decarboxylation of 6-phosphogluconate, which reduces a second NADP+ and releases carbon as CO2 on the way to the pentose product. Read together, the paired results support one specific structural conclusion: the branch produces NADPH at two separate oxidations, and the deletion removed only the first. (Choice A) overreads a single permissive result; the glucose 6-phosphate assay shows that when substrate must traverse the deleted step, no NADPH appears at all, so the first enzyme is required for any flux that begins at glucose 6-phosphate and is in no sense dispensable. (Choice B) is contradicted by the second assay; NADPH and CO2 production from 6-phosphogluconate at control rates demonstrates that the downstream oxidative machinery survived the deletion and that the NADPH arose within the pathway itself rather than outside it. (Choice D) misplaces both compartment and cofactor; the citric acid cycle operates in mitochondria and reduces NAD+ rather than NADP+, whereas this assay measures a cytosolic NADP+ linked activity, and the CO2 comes from the pathway's own decarboxylation of 6-phosphogluconate. This is a Reasoning about the Design and Execution of Research question because it requires using the choice of substrate entry points as experimental probes to determine which reactions of the pathway survived a targeted deletion.$q$,
    'medium',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    3,
    90
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$single permissive result overgeneralized$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$one deletion kills whole pathway$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$wrong pathway and compartment credited$q$ FROM q;

-- B2 Q22 . non-oxidative branch reverse flux . medium . skill 2 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$non-oxidative branch reverse flux$q$,
    $q$A cultured cell entering a phase of rapid nucleotide synthesis requires a large supply of ribose 5-phosphate. Its NADPH pool is already fully reduced, and measurements confirm that flux through glucose 6-phosphate dehydrogenase stays at baseline throughout this period. Which enzymatic route can meet the cell's ribose 5-phosphate demand under these conditions?$q$,
    $q$[{"label":"A","text":"Oxidation of glucose 6-phosphate through the oxidative branch of the pentose phosphate pathway, followed by isomerization of ribulose 5-phosphate"},{"label":"B","text":"Transketolase and transaldolase acting on fructose 6-phosphate and glyceraldehyde 3-phosphate, with net flux proceeding toward pentose formation"},{"label":"C","text":"Reversal of the glucose 6-phosphate dehydrogenase and lactonase steps, driven by accumulation of ribulose 5-phosphate"},{"label":"D","text":"Transketolase and transaldolase converting existing ribose 5-phosphate into fructose 6-phosphate and glyceraldehyde 3-phosphate"}]$q$::jsonb,
    'B',
    $q$This question falls under Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway and tests how the non-oxidative branch of the pentose phosphate pathway can carry flux in either direction to match cellular demand. The answer is B because transketolase and transaldolase catalyze freely reversible carbon rearrangements among sugar phosphates, so glycolytic intermediates can be reshuffled into ribose 5-phosphate with no flux through the oxidative branch. The pathway has two functionally distinct segments. The oxidative branch, which begins with glucose 6-phosphate dehydrogenase, is physiologically irreversible and obligatorily reduces NADP+ each time it generates a pentose skeleton, so it cannot supply ribose when the stem holds that enzyme's flux at baseline. The non-oxidative branch instead operates near equilibrium, so its net direction is set by the relative concentrations of its sugar phosphates. A cell that needs pentoses but already has ample reducing power therefore pulls fructose 6-phosphate and glyceraldehyde 3-phosphate out of glycolysis and lets these reversible reactions run toward ribose 5-phosphate. (Choice A) The oxidative branch followed by isomerization does yield ribose 5-phosphate under other conditions, but this route is excluded here because the stem states that glucose 6-phosphate dehydrogenase flux never rises, and the oxidative reactions cannot generate pentoses without running. (Choice C) The oxidative steps are physiologically irreversible; a buildup of ribulose 5-phosphate cannot push glucose 6-phosphate dehydrogenase or the lactonase backward, so no reverse oxidative route exists. (Choice D) This names the correct enzymes but the wrong direction: converting ribose 5-phosphate into fructose 6-phosphate and glyceraldehyde 3-phosphate consumes pentoses to feed glycolysis, the mode used when reducing power is needed but nucleotide precursors are not, which is the opposite of this cell's situation. This is a Scientific Reasoning and Problem Solving question because it requires applying the reversibility of the non-oxidative branch to identify which route satisfies the stated combination of a high pentose demand and an unchanged oxidative flux.$q$,
    'medium',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    2,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$true pathway excluded by a stated constraint$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$irreversible step treated as reversible$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$flux direction inverted$q$ FROM q;

-- B2 Q23 . transketolase and transaldolase carbon transfers . medium . skill 4 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$transketolase and transaldolase carbon transfers$q$,
    $q$An investigator purifies two enzymes of the pentose phosphate pathway and studies them in sequence, measuring the chain length of every sugar phosphate present. In the first incubation, enzyme 1 is supplied with equal amounts of a five-carbon ketose phosphate and a five-carbon aldose phosphate; as these are consumed, sugar phosphates containing three and seven carbons appear in a 1:1 ratio. Those two products are then moved to a second incubation with enzyme 2, where they are replaced by sugar phosphates containing four and six carbons, again in a 1:1 ratio. No carbon dioxide is detected in either incubation. Which description of the two reactions is most consistent with these measurements?$q$,
    $q$[{"label":"A","text":"Enzyme 1 transfers a three-carbon unit between the two pentoses, and enzyme 2 transfers a two-carbon unit between the products of the first reaction"},{"label":"B","text":"Each enzyme removes one carbon as carbon dioxide and adds the remaining fragment to the second substrate"},{"label":"C","text":"Enzyme 1 transfers a two-carbon unit from the ketose to the aldose, and enzyme 2 transfers a three-carbon unit between the products of the first reaction"},{"label":"D","text":"Both enzymes transfer a two-carbon unit, and the different product sizes reflect only the different lengths of the starting sugars"}]$q$::jsonb,
    'C',
    $q$This question falls under Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway and tests carbon bookkeeping across the two group transfer enzymes of the non-oxidative branch. The answer is C because the measured chain lengths fix the size of the fragment each enzyme moves. In the first incubation, ten substrate carbons, five plus five, reappear as a three-carbon and a seven-carbon product, so one substrate lost two carbons while the other gained two. That is the transketolase reaction, which moves a two-carbon unit from a ketose donor to an aldose acceptor, converting xylulose 5-phosphate and ribose 5-phosphate into glyceraldehyde 3-phosphate and sedoheptulose 7-phosphate. In the second incubation, seven-carbon and three-carbon substrates become four-carbon and six-carbon products, so three carbons moved from the longer sugar to the shorter one. That is the transaldolase reaction, which yields erythrose 4-phosphate and fructose 6-phosphate. Total carbon is conserved at ten in both steps, consistent with the absence of carbon dioxide, because the non-oxidative branch neither oxidizes nor decarboxylates its substrates; it only rearranges carbon skeletons. (Choice A) This inverts the two fragment sizes. A three-carbon transfer between two pentoses would give two-carbon and eight-carbon products rather than three and seven, and a two-carbon transfer in the second incubation could not produce the observed four-carbon and six-carbon pair. (Choice B) Losing one carbon as carbon dioxide in each step would drop the total from ten carbons to nine, and no carbon dioxide was detected; decarboxylation occurs in the oxidative branch, not in these group transfer reactions. (Choice D) A two-carbon transfer describes the first incubation correctly but not the second, where it would convert the seven-carbon and three-carbon pair into two five-carbon sugars or into nine-carbon and one-carbon products, neither of which was observed. This is a Data-based and Statistical Reasoning question because it requires using the measured carbon chain lengths and the absence of carbon dioxide to deduce the size of the fragment transferred in each reaction.$q$,
    'medium',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    4,
    105
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'reversed_relationship', $q$transfer sizes assigned to the wrong steps$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$decarboxylation assumed in a group transfer step$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$one step generalized to both$q$ FROM q;

-- B2 Q24 . pentose phosphate pathway product ledger . easy . skill 4 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$pentose phosphate pathway product ledger$q$,
    $q$A cell-free extract that contains the pentose phosphate pathway enzymes and their cofactors, but no glycolytic or gluconeogenic enzymes, is incubated with glucose 6-phosphate, NADP+, and an excess of ADP and inorganic phosphate. Over 15 minutes the NADP+ concentration falls by 1.6 mM and 0.8 mM carbon dioxide is released. Net accumulation over this interval is expected for which of the following?

I. NADPH
II. Ribose 5-phosphate
III. ATP$q$,
    $q$[{"label":"A","text":"I and II only"},{"label":"B","text":"I only"},{"label":"C","text":"I and III only"},{"label":"D","text":"I, II, and III"}]$q$::jsonb,
    'A',
    $q$This question falls under Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway and tests the net input and output ledger of the pentose phosphate pathway. The answer is A because the pathway generates NADPH and ribose 5-phosphate but neither makes nor consumes ATP. The 1.6 mM fall in NADP+ against 0.8 mM carbon dioxide is a 2:1 ratio, exactly what the oxidative branch predicts: glucose 6-phosphate dehydrogenase and 6-phosphogluconate dehydrogenase each reduce one NADP+, while only the second of those steps releases carbon dioxide, so item I accumulates. That decarboxylation leaves a five-carbon skeleton, ribulose 5-phosphate, which an isomerase converts to ribose 5-phosphate; since the extract contains no glycolytic enzymes to draw pentose carbon onward, item II builds up as well. Item III does not. The pathway's reactions are oxidations, a hydrolysis, a decarboxylation, isomerizations, and carbon skeleton transfers, and none of them is a kinase or synthetase step, so the ADP and inorganic phosphate supplied are never converted to ATP. This absence of energy currency turnover is a defining contrast with glycolysis, which both spends and generates ATP. (Choice B) NADPH does accumulate, but stopping at item I ignores the released carbon dioxide, which marks pentose formation and makes ribose 5-phosphate an equally real net product. (Choice C) Including ATP grafts substrate-level phosphorylation onto this pathway; the ATP-forming kinase steps belong to glycolysis, and this extract was prepared without glycolytic enzymes. (Choice D) This assumes that any pathway oxidizing a sugar must capture part of the energy as ATP, but here the electrons are deposited on NADP+ and no phosphoryl group is transferred to ADP. This is a Data-based and Statistical Reasoning question because it requires reading the measured cofactor and carbon dioxide changes and combining them with the pathway's reaction inventory to decide which species show net accumulation.$q$,
    'easy',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    4,
    75
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'partial_truth', $q$incomplete product list$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$neighboring pathway step grafted on$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$energy always captured as ATP$q$ FROM q;

COMMIT;

-- Verification: expect 45 questions, 135 distractor rows, and letters 11/11/12/11.
SELECT
  (SELECT COUNT(*) FROM public.questions WHERE topic = 'Carbohydrate Metabolism I') AS questions,
  (SELECT COUNT(*) FROM public.question_distractor_metadata m
     JOIN public.questions x ON x.id = m.question_id
   WHERE x.topic = 'Carbohydrate Metabolism I') AS distractor_rows;

SELECT correct_answer, COUNT(*) FROM public.questions
WHERE topic = 'Carbohydrate Metabolism I' GROUP BY correct_answer ORDER BY correct_answer;
