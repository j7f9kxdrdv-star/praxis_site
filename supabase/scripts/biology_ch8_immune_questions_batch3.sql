-- Biology Chapter 8: The Immune System, standalone questions
-- BATCH 3 of 4 (22 questions): B lymphocytes, antibody recognition and immunological memory.
--   Units: B lymphocytes and antigen-antibody recognition (13) . immunological memory (9)
--
-- SCOPE CONVENTION (carried from batches 1 and 2): entities the outline does not name are described
-- functionally. Antibody DOMAIN ARCHITECTURE (Fab, Fc, hypervariable and constant domains) belongs to
-- Biochem Ch3 and is deliberately absent here: this batch tests antigen-antibody RECOGNITION and what
-- it accomplishes, which is what the AAMC outline names under Biology.
--
-- !! RUN AFTER BATCHES 1 AND 2 !!
-- No DELETE here: batch 1 owns the chapter-scoped DELETE. Re-running this file alone would
-- duplicate its 22 questions.

BEGIN;

-- B2 Q1 . Defence Against an Extracellular Bacterial Product . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Defence Against an Extracellular Bacterial Product$q$,
    $q$A vaccine is being developed against a bacterial product that is released by the organism, causes its damage entirely in the fluid between cells, and never enters the cells it injures. Protection against this product depends most directly on which property of the adaptive response?$q$,
    $q$[{"label":"A","text":"Cutting the material into pieces small enough to sit in a surface carrier on a host cell"},{"label":"B","text":"Killing host cells that harbour the material inside them"},{"label":"C","text":"Producing a soluble binder that grips the molecule in its native folded shape and blocks its contact with target cells"},{"label":"D","text":"Raising the number of cells that display pieces of the material on their outer surface"}]$q$::jsonb,
    'C',
    $q$This item falls under Organ Systems and tests antigen-antibody recognition applied to a target that acts only outside cells. The answer is C because the adaptive lineage that reads a structure in the folded conformation it already carries can later release large amounts of a soluble version of that same gripping surface into the very compartment where the product does its damage, and a product that has been coated cannot dock onto the cell it was built to attack. Blocking the docking step is sufficient on its own, since a bacterial product that never contacts its target cell causes no injury even though it remains chemically intact. This is precisely why immunisation against secreted bacterial products works: the protective element ends up as a soluble binder circulating in the same fluid as its target, rather than a cell that must hunt something down. Recognition of the free, folded species is therefore the property on which protection rests.

(Choice A) Fragmenting material into pieces small enough to occupy a surface carrier is a genuine recognition route, but it is the route used by the other adaptive lineage, and it yields cells that inspect surfaces rather than a soluble molecule able to meet a free product dissolved in the fluid. It therefore cannot be what protection against this target depends on.

(Choice B) Killing host cells is a defence against material sequestered inside cells. The stem specifies that this product never enters the cells it injures, so destroying host tissue would add damage without removing the harmful species from the fluid around those cells.

(Choice D) Increasing how many cells put pieces of the material on show does occur during a real response and does recruit more lymphocytes, but display by itself intercepts nothing in the fluid. The harmful species reaches its target cell just as quickly whether or not fragments of it are on view elsewhere.

This is a Knowledge of Scientific Concepts and Principles question because it asks the student to recall which arm of the adaptive response acts on material in its native, free state and to apply that fact to a purely extracellular target.$q$,
    'easy',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    1,
    65
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'process_step_confusion', $q$recognition route of the other adaptive lineage offered as the protective mechanism$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$treating cell killing as a defence against free molecules$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$true event during a response, irrelevant to interception$q$ FROM q;

-- B2 Q2 . Targets a Naive B Receptor Can Reach . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Targets a Naive B Receptor Can Reach$q$,
    $q$Resting B lymphocytes from a donor who has met none of these organisms are distributed into wells. Each well receives one item from the list below, and no cell of any other type is added to any well. Engagement of the surface binding units on the B lymphocytes is then measured.

I. A folded toxin dissolved in the medium
II. The sugar coat on the outside of a whole, undamaged bacterium
III. Cells infected with a virus whose protein is never exposed on the cell surface and never leaves the cell

Engagement is expected with which item or items?$q$,
    $q$[{"label":"A","text":"I and II only"},{"label":"B","text":"I only"},{"label":"C","text":"II only"},{"label":"D","text":"I, II, and III"}]$q$::jsonb,
    'A',
    $q$This item sits in Organ Systems and tests antigen-antibody recognition, specifically the range of targets a resting B lymphocyte can engage on its own. The answer is A because items I and II both leave their binding surface facing the medium, while item III keeps its binding surface locked inside a cell where no surface unit on a lymphocyte can reach it. A dissolved toxin is already in the conformation it will hold when it meets its target, so the shape a B lymphocyte must read is present the moment the toxin is added to the well. The sugar coat of an undamaged bacterium is likewise on the outside and bathed by the medium, and this lineage reads a coat built of sugars as readily as it reads a protein surface, because the fit of the binding site to a three dimensional shape, not the chemical class of the material, is what governs engagement. Item III fails for a structural reason rather than a chemical one: a protein that never appears on the outside of the infected cell and never leaves it presents no exposed surface for a binding unit to contact, and the only route by which such a protein reaches a lymphocyte at all is as short pieces held out on a carrier, which serves the other adaptive lineage rather than the units being measured here.

(Choice B) Restricting engagement to I treats dissolved material as the only accessible form and assumes that a structure attached to a living organism must first be stripped off and handled. Nothing about being anchored to a bacterium hides an outward facing coat from the medium around it.

(Choice C) Restricting engagement to II makes the opposite assumption, that the binding unit needs a particle or cell surface to press against. A free molecule of the right shape engages perfectly well, which is exactly why a soluble product of this response can later act on free targets in the blood.

(Choice D) Including III ignores where the viral protein actually sits. It is never on the outside of the infected cell and never enters the medium, so nothing about it is available for a surface binding unit to contact.

This is a Scientific Reasoning and Problem Solving question because it asks the student to take one recognition rule and apply it across three physically different presentations of a target to decide which are reachable.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    85
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'partial_truth', $q$correct on the dissolved case, wrongly excludes the intact surface$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$belief that a particle or cell surface is required$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$internal protein treated as if it were surface accessible$q$ FROM q;

-- B2 Q3 . Why Surface and Output Specificity Must Match . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Why Surface and Output Specificity Must Match$q$,
    $q$An engineered mouse line carries a defect in which the gene segments that build a lymphocyte's gripping site are shuffled a second time after that cell has been picked out by a bacterium and has begun to divide. Each descendant therefore puts out soluble units whose gripping surface is set at random. The number of soluble units made per descendant, and the number of descendants produced, are both normal. Compared with a wild type mouse, what happens to the response against that bacterium?$q$,
    $q$[{"label":"A","text":"Binding of the bacterium is unaffected, because the cell was already picked out correctly before it began to divide"},{"label":"B","text":"Binding of the bacterium improves, because the descendants now cover a wider range of shapes between them"},{"label":"C","text":"The first exposure proceeds normally and the loss shows up only on a later exposure to the same bacterium"},{"label":"D","text":"The share of released units able to grip the invader falls to roughly the chance frequency of any single binding shape"}]$q$::jsonb,
    'D',
    $q$This question belongs to Organ Systems and tests clonal selection together with the specificity of what a selected lymphocyte's offspring release. The answer is D because selection acts on the surface gripping unit of the parent cell, and the benefit of that selection survives only if the offspring carry the same gripping surface forward when they switch to pouring material into the fluid. The described defect leaves every quantitative feature of the response intact: the correct parent is chosen, it divides the usual number of times, and each offspring releases the usual quantity of soluble material. What is destroyed is the link between the choice and the product. Shuffling the gripping surface again after the parent has been chosen means the soluble output samples the entire repertoire once more, so the proportion of it that fits the organism falls back to the frequency of any one shape among all possible shapes, which is vanishingly small. The broader lesson is that matching between the surface unit and the released unit is not a redundancy but the mechanism that converts one correct recognition event into a large quantity of useful product.

(Choice A) This treats correct selection of the parent as sufficient on its own. Selection identifies which cell to amplify; it does not stamp the chosen shape onto anything the offspring later manufacture, and the stamping step is exactly what this mouse line has lost.

(Choice B) Wider shape coverage sounds like a gain but is a loss in this setting. Spreading a fixed total output across millions of different shapes lowers the quantity aimed at the one shape that matters, so broadening the range moves the useful concentration in the wrong direction.

(Choice C) Placing the deficit on a later exposure misassigns the stage at which the defect operates. The reshuffling occurs as soon as the chosen cell divides, so the very first wave of released material is already off target, and a repeat encounter would fail in the same way for the same reason.

This is a Scientific Reasoning and Problem Solving question because it asks the student to predict, from a described genetic lesion, how the quality of a response changes while every quantitative feature of it stays fixed.$q$,
    'hard',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    105
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$selection alone treated as sufficient$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', $q$diversity read as gain rather than dilution$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$defect assigned to the wrong encounter$q$ FROM q;

-- B2 Q4 . Reading a Native Versus Fragment Binding Table . medium . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Reading a Native Versus Fragment Binding Table$q$,
    $q$Surface binding units were purified from two lymphocyte lineages, P and Q, taken from a donor immune to one bacterium. Each preparation below was offered to both, and binding was recorded in arbitrary units, with values under 15 counted as background.

| Material offered | Lineage P (AU) | Lineage Q (AU) |
| --- | --- | --- |
| Whole folded toxin, free in the fluid | 480 | 4 |
| Short cut pieces of that toxin, free in the fluid | 12 | 6 |
| Short cut pieces held out by a carrier on a cell surface | 9 | 455 |
| Sugar coat of the whole bacterium | 390 | 3 |

The bacterium is then altered by genetic engineering so that it makes no sugar coat. The altered organism, together with the toxin it still produces, is placed in a fluid containing the purified binding units from both lineages and no host cells of any kind. Which outcome does the table support?$q$,
    $q$[{"label":"A","text":"Neither set of units engages anything in the fluid, because the only structure available in its natural state has been removed"},{"label":"B","text":"The lineage P units engage the toxin, since they grip a molecule in its native three dimensional state with no third cell needed"},{"label":"C","text":"The lineage Q units engage the toxin, because their score against loose cut pieces of it shows a real, if weak, interaction"},{"label":"D","text":"The lineage P units engage the toxin only once its cut pieces are held out on a carrier"}]$q$::jsonb,
    'B',
    $q$This item falls under Organ Systems and tests antigen-antibody recognition read from measured binding data. The answer is B because the lineage P units score far above background against material offered in its whole, natural conformation, 480 for the dissolved toxin and 390 for the coat sugar, and they need no accessory cell present to do so. The lineage Q units show the mirror image profile: 4 and 3 against whole structures, 6 against loose cut pieces, and 455 only when those pieces are held out by a carrier on a cell. That pattern identifies the presence of a carrier bearing cell, rather than the chemical nature of the material, as the requirement for lineage Q. In the described fluid there is no cell at all to hold pieces out, so lineage Q has no condition it can score above background on. Removing the sugar coat costs lineage P one of its two targets but leaves the other intact, because the toxin is still manufactured and is still whole and free in the fluid.

(Choice A) This assumes the coat was the only structure available in natural conformation. The first row of the table shows a second such structure, the whole toxin, and the altered organism still releases it into the fluid, where it scores 480.

(Choice C) This reads 6 arbitrary units as genuine binding. The threshold given is 15, so the value for lineage Q against loose cut pieces reports no interaction at all, and treating it as a real signal is an error of magnitude rather than of mechanism.

(Choice D) This inserts a fragmentation and display step that lineage P does not use. The value of 9 recorded for lineage P against carrier held pieces sits below background, showing that route contributes nothing for this lineage, while the value of 480 shows the direct route already works.

This is a Data-based and Statistical Reasoning question because it asks the student to compare four measured conditions against a stated background threshold and extend the resulting pattern to a new experimental condition not shown in the table.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    4,
    110
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$assumes only one accessible native structure existed$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'scale_unit_error', $q$background level read as a real signal$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$fragmentation and display step inserted into the wrong lineage$q$ FROM q;

-- B2 Q5 . Origin of B Lineage Binding Diversity . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Origin of B Lineage Binding Diversity$q$,
    $q$A volunteer receives an injection of a laboratory compound that has never existed in nature and that no organism has ever synthesised. Two weeks later the volunteer's serum holds an antibody that recognises that compound and nothing else. Which feature of B lymphocytes makes this result possible?$q$,
    $q$[{"label":"A","text":"Each cell finishes maturation carrying a single randomly assembled binding specificity, so the collection of such cells spans millions of distinct shapes before any encounter."},{"label":"B","text":"A single B cell displays roughly one hundred thousand surface receptors, and those receptors differ from one another in shape."},{"label":"C","text":"Phagocytes ingest unfamiliar material and display fragments of it on their surface for inspection."},{"label":"D","text":"New receptor specificities are generated in bone marrow only once an unfamiliar target has been detected."}]$q$::jsonb,
    'A',
    $q$This item sits in Organ Systems and tests clonal selection at its starting point: where the library of binding specificities in the B lymphocyte lineage comes from. The answer is A because every B cell completes its development in bone marrow with one randomly assembled recognition site, and the sum of all such cells therefore covers an enormous range of shapes before the immune system has met anything at all. The gene segments coding for the variable part of the receptor exist in many alternative versions, and each developing cell joins one combination of them at random. Because the joining is random rather than directed, the resulting library is not built to match any particular target: it simply covers a vast sample of possible shapes. A molecule that has never existed can still find a partner in that library, precisely because the library was never tailored to the natural world in the first place. Each individual specificity is consequently rare, which is why a first response needs time for the matching cells to be found and multiplied.

(Choice B) A single B cell does display on the order of a hundred thousand surface receptors, but every one of them carries the same specificity. Diversity in this system lives across the whole set of cells, not within one cell, so this choice places the variation at the wrong level of organisation.

(Choice C) Ingestion of foreign material and display of its fragments is a real and important step, but it explains how a target is shown to lymphocytes, not why a lymphocyte with a fitting site exists in the first place.

(Choice D) This reverses the order of events. The set of specificities is generated in advance of any contact, which is exactly what allows a response to a compound no organism has ever produced. Marrow does not custom order specificities on demand, and a system that waited for a target before building a binder would have no way to build the right one.

This is a Knowledge of Scientific Concepts and Principles question because it asks the student to identify the defining property of the B lymphocyte repertoire, a randomly generated set of specificities fixed during development, that makes a response to a never before existing target possible.$q$,
    'easy',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    1,
    65
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'scale_unit_error', $q$variation placed inside one cell instead of across the cell population$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$true statement about a neighbouring process that does not answer the question asked$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$repertoire built on demand rather than in advance$q$ FROM q;

-- B2 Q6 . Selection Versus Instruction by Antigen . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Selection Versus Instruction by Antigen$q$,
    $q$A volunteer is given an unfamiliar compound for the first time. Blood drawn one week beforehand already contained about three thousand cells per litre whose membrane protein grips that compound. The antibody recovered from serum two weeks afterwards has the same amino acid sequence as that membrane protein, and the count of gripping cells has risen roughly two hundred fold. What does this pattern indicate about the role of the compound?$q$,
    $q$[{"label":"A","text":"It is broken into fragments inside a cell first, and those fragments are then built into the recognition site of that same cell."},{"label":"B","text":"It acts as a filter rather than a mould: it selects the few cells carrying a matching site fixed at maturation and drives them to divide."},{"label":"C","text":"It serves as a template around which a flexible binding region folds, which is why the recovered protein fits it so exactly."},{"label":"D","text":"Cells with the matching site are generated in response to its arrival, and their surface protein is later copied into a soluble form."}]$q$::jsonb,
    'B',
    $q$This item sits in Organ Systems and tests the distinction between selection and instruction, which is the conceptual core of clonal selection in the B lineage. The answer is B because the fitting cells were countable in blood a week before anything was given, and the secreted binder turned out to carry the same sequence as the surface protein those cells were already displaying, so the arriving material sorted and amplified a set that was fixed in advance instead of shaping a binder to order. Two observations must be combined to reach this. First, the specificity existed beforehand, so it cannot have been created by the meeting. Second, the secreted product reproduces, residue for residue, the site those cells were displaying at the outset, so the meeting did not even modify the site: it left the site exactly as it was and caused the cells bearing it to proliferate, which is what the two hundred fold rise in their number records. The reasoning runs backwards from an outcome, and only a filtering mechanism fits that outcome. Because each specificity begins rare, the size of the eventual response depends largely on how far the chosen minority can expand.

(Choice A) Uptake and breakdown of foreign material genuinely happens and matters for how lymphocytes are engaged, but the resulting fragments are displayed on the cell surface, not stitched into the recognition site. This choice keeps a real process and swaps two of its stages, and it also cannot produce a binder whose sequence was already fixed before the compound arrived.

(Choice C) This is the template idea that students most commonly hold, and it is the exact hypothesis these observations exclude. A binding region moulded around the compound would have a shape settled only after exposure, yet the recovered protein matches, residue for residue, one that cells were already carrying a week earlier. Until that identity of sequence is applied, this choice looks as defensible as the key.

(Choice D) The second half is right, since the soluble product does reproduce the surface specificity. The first half runs the causal arrow the wrong way: the fitting cells were present a week early, so they were found rather than made.

This is a Scientific Reasoning and Problem Solving question because it asks the student to reason from an observed outcome, sequence identity between a pre-existing surface protein and a later secreted antibody, back to the only mechanism of antigen action consistent with it.$q$,
    'hard',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'process_step_confusion', $q$real pathway with processing and display stages interchanged$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$antigen as instructive mould for the binding site$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$matching cells created by the antigen rather than found by it$q$ FROM q;

-- B2 Q7 . Reading Expansion of a Rare Clone . medium . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Reading Expansion of a Rare Clone$q$,
    $q$A rabbit is injected once with target P and never with target Q. On three days, blood is stained with labelled P and labelled Q so that cells whose surface protein grips each one can be counted, and the total lymphocyte concentration is recorded at the same time. The animal goes on to make a strong antibody response to P and none to Q.

| Day | Total lymphocytes (per microlitre) | Cells gripping P (per microlitre) | Cells gripping Q (per microlitre) |
| --- | --- | --- | --- |
| 0 | 2000 | 16 | 12 |
| 4 | 2139 | 155 | 12 |
| 8 | 2409 | 425 | 12 |

Which conclusion do these counts support?$q$,
    $q$[{"label":"A","text":"Cells that grip P proliferated, and part of the increase came from cells that formerly gripped nothing being switched over."},{"label":"B","text":"Exposure to P taught cells that formerly gripped nothing to build a P-shaped site, which is why their number climbed."},{"label":"C","text":"Cells reactive to P were present at low frequency from the outset and then multiplied, since cells reactive to neither one remained at a constant number."},{"label":"D","text":"Each cell that grips P raised the quantity of P-gripping proteins on its own membrane, which is what the rising values register."}]$q$::jsonb,
    'C',
    $q$This item sits in Organ Systems and tests clonal selection as it appears in cell counts: expansion of a rare pre-existing specificity rather than conversion of cells that had a different one. The answer is C because the quantity of lymphocytes gripping neither label works out to 1972 per microlitre on all three days, so nothing was drawn out of that pool, while the P column climbs from 16 to 425 and the total climbs by the identical amount. Subtracting the two stained columns from the total gives 2000 minus 28, 2139 minus 167, and 2409 minus 437, each of which equals 1972. That constant remainder is the decisive figure. Had unlabelled cells been retooled into P recognisers, the remainder would have fallen by the amount the P column rose. Instead the P column gains 409 and the total gains 409, which is what division of an already existing group looks like: new cells are added to the pool rather than moved within it. The Q column, flat at 12, confirms that the change is confined to one specificity and is not a general lymphocyte increase.

(Choice A) The first clause is right, since cells gripping P clearly divided. The second clause fails the arithmetic, because any switching over of unlabelled cells would have drawn cells out of the remainder, and the remainder holds at 1972 on every sampling day.

(Choice B) This treats the injected material as an instructor rather than as a filter. It also fails numerically for the same reason as choice A: a cell taught to grip P is a cell subtracted from the unlabelled pool, yet that pool is unchanged across all three days.

(Choice D) The assay counts cells, not signal intensity per cell, and the total lymphocyte concentration rises in step with the P column. More proteins on the same cells would leave both the cell counts and the total untouched, so this explanation is pitched at the wrong level of organisation.

This is a Data-based and Statistical Reasoning question because it requires the student to derive a quantity not printed in the table, the number of cells gripping neither label, and to use its constancy across all three days to choose between expansion of a rare group and conversion of other cells.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    4,
    105
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$right mechanism plus an extra mechanism the data rule out$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$antigen teaches cells a new specificity$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'scale_unit_error', $q$per-cell receptor number substituted for cell count$q$ FROM q;

-- B2 Q8 . Epitope Size and Response Diversity . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Epitope Size and Response Diversity$q$,
    $q$The binding pocket of an antibody accommodates roughly six amino acid residues at a time. A pathogenic bacterium secretes a toxin that folds into a compact globule of 480 residues. What follows for the set of antibodies a patient raises against this toxin?$q$,
    $q$[{"label":"A","text":"Several distinct specificities arise, each attaching to a different exposed patch of the same molecule."},{"label":"B","text":"A single specificity arises, because the folded toxin behaves as one indivisible target."},{"label":"C","text":"The toxin must be trimmed into six residue pieces before any antibody can attach to it."},{"label":"D","text":"The toxin falls below the size threshold for recognition and must be coupled to a carrier first."}]$q$::jsonb,
    'A',
    $q$This Organ Systems item tests antigen-antibody recognition, specifically why the unit an antibody actually engages is far smaller than the antigen that carries it. The answer is A because a folded 480 residue toxin exposes many separate six residue areas on its surface, and each of those areas can select a different B lineage clone, so the response is a mixture of specificities rather than one. An antibody combining site is a shallow pocket, and only a handful of amino acids from the target can occupy it at once. The consequence is close to arithmetic: a large protein presents many separate areas that are chemically unlike one another, and clonal selection operates on each of them independently, since a clone is chosen by whether its receptor fits that one area. Antibodies of several specificities therefore attach to different parts of the same toxin at the same time, which is why serum raised against a single protein is a mixture and not a pure reagent. The same relationship explains why large antigens are generally stronger stimulants than small ones: a bigger structure supplies more independent handles for selection to act on.

(Choice B) treats the folded protein as one recognition unit. Folding does not merge the surface into a single target, because the pocket still samples only a few amino acids at a time, so many independent clones are engaged by one protein.

(Choice C) borrows a step from the pathway that cuts proteins into short pieces and loads them onto the surface display molecules read by T lymphocytes. Antibodies engage intact native surfaces directly, and no cutting is required before attachment occurs.

(Choice D) describes a molecule too small to stimulate a response on its own, which must be joined to a larger carrier before it is seen. A 480 residue toxin sits far above that threshold and requires no carrier.

This is a Knowledge of Scientific Concepts and Principles question because it asks the student to apply the fixed size of an antibody combining site to a large target and state what that implies about how many separate specificities one protein can raise.$q$,
    'easy',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    1,
    60
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'misconception', $q$one antigen equals one antibody$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$processing step imported into antibody binding$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$small molecule carrier rule misapplied$q$ FROM q;

-- B2 Q9 . Shared Surface Patches and Test Specificity . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Shared Surface Patches and Test Specificity$q$,
    $q$A clinical assay scores a sample as reactive when a purified antibody raised against organism P attaches to material in the patient's serum. Organism Q, which is not related to P and is common in the same area, carries a surface patch whose shape and charge closely resemble one patch on P. What limitation does this place on the interpretation of a reactive sample?$q$,
    $q$[{"label":"A","text":"Attachment cannot occur unless the two organisms share a recent common ancestor."},{"label":"B","text":"The assay reports the presence of a complementary patch rather than the species that supplied it."},{"label":"C","text":"Reactive samples are trustworthy here, while non-reactive samples are the ones prone to error."},{"label":"D","text":"The assay stays valid so long as the antibody was raised against P rather than against Q."}]$q$::jsonb,
    'B',
    $q$This Organ Systems item tests the limits of binding specificity in antigen-antibody recognition and what those limits do to a test built on attachment alone. The answer is B because attachment is decided by the fit between a small pocket and a small surface area, so any molecule carrying a sufficiently close copy of that area will be captured, no matter which organism supplied it. The pocket contacts only a few residues and reads their geometry and charge, not their ancestry. Two lineages with no recent shared history can arrive at a surface area that satisfies the same pocket, and the assay cannot separate the two events, since in both cases the antibody is held and the readout rises. A rise therefore supports only the conclusion that a complementary surface area was present in the material tested. This is precisely why assays of this design are used as screens rather than as confirmations, and why a reactive sample is followed by a second test that keys on some independent property of the suspected agent, such as its nucleic acid.

(Choice A) assumes that a shared surface shape must reflect shared descent. Unrelated lineages can converge on a similar arrangement of charge and geometry, and the antibody pocket has no access to ancestry, only to fit.

(Choice C) runs the reliability argument backwards for the situation described. The look-alike patch on the second organism is a source of falsely reactive readings, so it is the reactive result that is made ambiguous here, while failure to attach argues against the presence of a matching surface area.

(Choice D) is correct that the antibody was raised against P, which is why it binds P well, but the origin of a reagent does not restrict what can capture it. The reagent's history and its behaviour toward similar surfaces are separate facts.

This is a Scientific Reasoning and Problem Solving question because it asks the student to carry a property of molecular recognition forward into the interpretation of a clinical assay and to state exactly what a reactive reading can and cannot establish.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    85
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$binding implies phylogenetic kinship$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', $q$positive and negative predictive value inverted$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$reagent provenance mistaken for reagent selectivity$q$ FROM q;

-- B2 Q10 . Binding Strength Versus Discrimination . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Binding Strength Versus Discrimination$q$,
    $q$Two purified antibodies, R1 and R2, were each raised against target molecule X. Molecule Y comes from an unrelated organism and is chemically similar to X. The table gives the concentration of each antibody at which half of its sites are filled by the molecule listed.

| Antibody | Half occupancy with X | Half occupancy with Y |
| --- | --- | --- |
| R1 | 1 nM | 500 nM |
| R2 | 60 nM | 60 nM |

I. R1 separates X from Y more sharply than R2 does.
II. R2 holds X more tightly than R1 does.
III. R2 would give the same reading for a preparation of X as for an equal amount of Y.

Which of the statements are supported by the data?$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"II only"},{"label":"C","text":"I and III only"},{"label":"D","text":"I, II, and III"}]$q$::jsonb,
    'C',
    $q$This Organ Systems item pulls apart two properties of antigen-antibody recognition that students routinely merge: how tightly an antibody holds a target, and how well it tells two targets apart. The answer is C because statements I and III both follow from the four tabulated values, while statement II runs the half occupancy scale backwards. A lower concentration at half occupancy means the sites fill when less material is present, so a smaller number signals a stronger hold. R1 needs 1 nM for X but 500 nM for Y, a five hundred fold gap, so across a wide range of concentrations R1 is largely loaded on X while its loading on Y stays low, which is what discrimination looks like in practice. R2 needs 60 nM for either molecule, so no concentration exists at which it is loaded on one and not on the other, and its output cannot indicate which molecule was in the tube. Note that R2 is not weak in absolute terms, since 60 nM is a respectable hold; it is simply indiscriminate, and discrimination rather than raw strength is the property an assay depends on. Statement II asserts the reverse of what the table shows, because 60 nM is more material than 1 nM and therefore the looser grip.

(Choice A) accepts statement I and stops there. Statement III is an equally direct consequence of the two identical values in the R2 row, since equal half occupancy for both molecules means equal fractional loading, and so equal signal, at equal amounts.

(Choice B) reads the larger number as the firmer grip. Half occupancy is a concentration that must be supplied, so a larger value means a weaker interaction, which makes statement II false and statement I true.

(Choice D) folds statement II in with the two supported claims, which amounts to treating strength of binding and power to distinguish as one property. The R2 row shows they are independent, because a moderately firm hold can still fail entirely to separate two molecules.

This is a Scientific Reasoning and Problem Solving question because it asks the student to convert four half occupancy values into separate claims about binding strength and about discrimination and to reject the claim that runs the concentration scale backwards.$q$,
    'hard',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    105
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$stops at the first supported statement$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', $q$concentration scale read in the wrong direction$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$strong binding assumed to mean selective binding$q$ FROM q;

-- B2 Q11 . Commitment of a Selected B Lymphocyte to Export . easy . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Commitment of a Selected B Lymphocyte to Export$q$,
    $q$A single lymphocyte in a lymph node binds one antigen and divides repeatedly. Several days later some daughters have lost the antigen-binding receptor from their outer membrane, their cytoplasm is packed with ribosome-studded internal membrane, and serum levels of a soluble antigen-binding protein rise steeply. What is the most likely relationship between that soluble protein and the receptor those daughters lost?$q$,
    $q$[{"label":"A","text":"It carries a freshly generated combining site, since the switch to export requires the cell to run a new round of gene rearrangement."},{"label":"B","text":"It is assembled outside the cell from subunits shed by the daughters, so its combining site takes shape only after release into the fluid."},{"label":"C","text":"It carries a combining site identical to the one the cells used before commitment, since both arise from the same rearranged genes in one expanded clone."},{"label":"D","text":"It carries combining sites drawn from the whole repertoire of the node, since many different clones begin exporting at once."}]$q$::jsonb,
    'C',
    $q$This Organ Systems item tests clonal selection and what changes when a chosen B lymphocyte commits to full time export of its binding protein. The answer is C because the exported protein and the outer-membrane receptor of the parent cell are two finished forms of a single gene product, so their combining sites are the same. Each maturing B lymphocyte rearranges its binding genes once, and every descendant of that cell inherits that one rearranged version. Antigen picks out the rare cell whose site already fits, and the descendants whose cytoplasm fills with ribosome-studded internal membrane have not altered the site at all: they have changed only how the product is finished, releasing it into fluid rather than fixing it in the membrane. That is why serum activity against the triggering antigen climbs at the same moment the surface form disappears from those daughters, and why the exported material remains as narrowly targeted as the receptor that started the response. The expanded internal membrane is the machinery for high rate export, not a device for making anything new.

(Choice A) The rearrangement that builds the binding site occurs during maturation, before the cell ever meets antigen, and the shift to export does not run it again. If a new site were generated at this stage, the cell selected by the antigen would stop matching the antigen that selected it, which would defeat the entire logic of picking one cell out of the starting population.

(Choice B) The binding site is folded inside the cell as the protein is built and is complete before the protein leaves; nothing is stitched together in the surrounding fluid from cast off pieces. This choice puts a step that occurs during synthesis after the step of release.

(Choice D) One triggered cell yields one specificity, not a sample of the node's whole collection. Many other cells in the same node carry other sites, but they were not selected by this antigen, so pooling them describes the tissue rather than the lineage the question follows.

This is a Scientific Reasoning and Problem Solving question because it asks the student to connect an observed change in one cell's surface and interior to a prediction about the targeting of the protein that appears in serum.$q$,
    'easy',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    70
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$specificity is remade at activation$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', $q$synthesis and secretion steps swapped$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$population repertoire substituted for one clone$q$ FROM q;

-- B2 Q12 . Adding a Protein Partner to a Capsule Sugar . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Adding a Protein Partner to a Capsule Sugar$q$,
    $q$A bacterial capsule sugar is given to two matched groups of children under two years of age. Group 1 receives the purified sugar alone; group 2 receives the same quantity of that sugar joined covalently to a foreign protein. Serum antibody able to attach to the sugar is assayed 14 days after a first injection and 14 days after an identical second injection given six months later.

| Group | After first injection (units/mL) | After second injection (units/mL) |
| --- | --- | --- |
| 1: sugar alone | 12 | 11 |
| 2: sugar joined to a protein | 15 | 138 |

Which property of the group 2 material accounts for the pattern across its row?$q$,
    $q$[{"label":"A","text":"Its sugar chain carries more repeating units, so a larger number of matching receptors on one cell are bridged together at the moment of first contact."},{"label":"B","text":"Much of what is counted in its second column is antibody aimed at the attached partner rather than at the sugar itself."},{"label":"C","text":"Its sugar cannot engage any matching receptor until the attached partner has been broken down first, so the plain preparation triggers nothing at all."},{"label":"D","text":"Its attached partner yields peptide fragments the sugar-binding cell can display, recruiting the licensing lymphocyte subset and setting up a much larger reaction on re-exposure."}]$q$::jsonb,
    'D',
    $q$This Organ Systems item tests antigen presentation as the gate on help from the licensing lymphocyte subset, read out of a two dose vaccine data set. The answer is D because the lymphocyte subset that supplies licensing signals can only act on a target that is showing it a fragment held in a display molecule, and a sugar yields no such fragment. Both preparations gave a modest first result, so the sugar by itself clearly reaches and triggers cells whose receptors fit it; the informative comparison is not the first column but the change from the first column to the second. Group 1 gained nothing on the repeat dose, the signature of a reaction that runs on receptor engagement alone. In group 2 the cell that grabs the sugar also internalises the protein tied to it, breaks that protein up and shows pieces of it on its own display molecule, which recruits licensing cells matched to those pieces. That extra input is what converts a short lived reaction into one that returns far stronger months later, and it is why a designer of such a preparation attaches a protein rather than simply purifying more sugar.

(Choice A) Repetition on a sugar is exactly what lets it engage many receptors on one cell at once, and that engagement is already occurring in group 1, whose first column value is comparable. Cross-bridging alone produces the flat pattern seen in row 1, so it cannot be the source of the difference in row 2.

(Choice B) Antibody against the attached protein is indeed produced, but the assay described counts only antibody that attaches to the sugar, so the second column value is not inflated by that population. The choice is true about the response and irrelevant to the number reported.

(Choice C) Group 1 produced 12 units without any partner present, which directly contradicts the claim that nothing is triggered by the plain sugar. This reverses the order of events as well, since the sugar is bound by its matching receptor first and any protein tied to it is processed afterwards.

This is a Data-based and Statistical Reasoning question because it asks the student to compare change across two columns rather than absolute values and to infer from that comparison which feature of one preparation supplied the missing requirement.$q$,
    'hard',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    4,
    110
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$cross-linking alone builds a stronger repeat response$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$true side product mistaken for the measured quantity$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$processing step placed ahead of receptor binding$q$ FROM q;

-- B2 Q13 . Culture Arm Testing Matched Versus Generic Help . medium . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Culture Arm Testing Matched Versus Generic Help$q$,
    $q$A researcher cultures purified B lymphocytes with a foreign protein for seven days and finds no antibody in the medium. In a parallel well, adding cells of the non-killing lymphocyte population, which releases soluble permitting signals, restores antibody output. A colleague argues that the added cells may simply be supplying a general growth factor that any dividing cell would require. Which additional culture arm best addresses that objection?$q$,
    $q$[{"label":"A","text":"Omit the protein from the well that contains both cell types, then assay the medium."},{"label":"B","text":"Add partner cells in the same number, but ones able to react only to an unrelated target, holding all else constant."},{"label":"C","text":"Culture the added cells by themselves with the protein and assay the medium for antibody."},{"label":"D","text":"Raise the number of B lymphocytes tenfold in the well that lacks the added cells."}]$q$::jsonb,
    'B',
    $q$This Organ Systems item tests experimental design around antigen presentation, specifically how to show that help delivered to a B lymphocyte is matched to the antigen rather than generic. The answer is B because a growth factor would work on any dividing cell regardless of what that cell is displaying, whereas matched help requires the helping cell to read a fragment of the very protein the B lymphocyte took up. Swapping in partner cells that can respond only to some unrelated target holds cell number, culture conditions and the protein constant and varies one thing: whether the partner cells can recognise what the B lymphocyte is showing them. If antibody still fails to appear, the restoring effect cannot be a nonspecific factor, since a nonspecific factor would be delivered by these cells as readily as by the original ones. If antibody does appear, the colleague is right and the effect is generic. The arm therefore produces opposite outcomes under the two competing explanations, which is what any discriminating control must do.

(Choice A) Removing the protein gives no antibody under either explanation, because a B lymphocyte still needs its receptor engaged before it can respond at all. The arm confirms that the trigger is required but leaves the two competing accounts of the added cells untouched.

(Choice C) Culturing the added cells alone checks whether they are themselves the source of the antibody being measured. That is a reasonable housekeeping control for the assay, but it says nothing about whether their contribution to the mixed well is targeted or generic.

(Choice D) Adding more responders does not create the missing signal, and the outcome would look the same whichever explanation is true. This assumes a shortfall of quantity where the stem describes a shortfall of a required input.

This is a Reasoning about the Design and Execution of Research question because it asks the student to select the culture arm whose two possible outcomes separate a targeted requirement from a nonspecific one while changing a single variable.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    3,
    95
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$legitimate baseline that lacks discriminating power$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$valid control aimed at a different question$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$scaling responders substitutes for a missing signal$q$ FROM q;

-- B2 Q14 . Why Re-encounter Shortens the Delay . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Why Re-encounter Shortens the Delay$q$,
    $q$A volunteer is injected with a harmless bacterial protein. Blood sampling finds no circulating protein able to bind it until about day ten, after which the level rises modestly and then falls back to undetectable over the following weeks. The same material is injected again six months later, and bindable protein is measurable within two days at a level far above the earlier peak. What accounts for the much shorter wait on the repeat injection?$q$,
    $q$[{"label":"A","text":"Descendants of the cells that answered the first time bind a wider range of shapes, so more of them can take part."},{"label":"B","text":"Fragment display by other cells is no longer needed once a foreign shape has been met, so one stage is skipped."},{"label":"C","text":"A trickle of the bindable protein persisted from the first response and simply continued at the same rate."},{"label":"D","text":"Cells committed to that one specificity had become far more numerous and long lasting, so fewer cycles of proliferation stood ahead of secretion."}]$q$::jsonb,
    'D',
    $q$This question belongs to the Organ Systems category and tests how a repeat meeting with the same antigen differs from the first meeting. The answer is D because the first exposure leaves behind a much larger and much longer lasting set of lymphocytes carrying receptors for that one antigen, so far fewer cycles of proliferation separate the moment of binding from the appearance of secreted antibody in the blood. Before any exposure, the lymphocytes able to bind a given antigen are present in very low numbers within the whole repertoire, and most of the first response is spent selecting those rare cells and expanding them into a working population whose descendants can secrete. Once that expansion has occurred, the surviving descendants persist for years, so the same antigen now meets a population far larger than before and already well advanced toward secretion. Speed on the second occasion therefore comes from starting the same process much further along, not from any change in how secretion itself works. (Choice A) Receptor binding shapes are fixed before the antigen is ever encountered, and only the cells whose receptors already bound this antigen were expanded, so the population left behind is focused on that same antigen rather than spread across a wider range of shapes; greater breadth would in any case not explain an earlier start. (Choice B) Surface display of fragments and the cell to cell contacts it supports are required on a repeat meeting exactly as on a first one, and nothing about a second dose removes a stage from the pathway. (Choice C) The stem states that the level fell back to undetectable well before the second dose, so continued low grade output cannot explain a rise that begins within forty eight hours and greatly exceeds the first peak. This is a Knowledge of Scientific Concepts and Principles question because it asks the student to supply the reason a repeat exposure shortens the interval before antibody appears, drawing on how clonal selection changes the size and readiness of the responding lymphocyte population.$q$,
    'easy',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    1,
    75
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$repeat responses are broader rather than more focused$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', $q$a stage of the pathway is dropped on repeat exposure$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$residual output explains the second rise$q$ FROM q;

-- B2 Q15 . Separate Causes for Speed and Size . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Separate Causes for Speed and Size$q$,
    $q$On meeting an antigen it has encountered once before, an animal makes circulating antibody both sooner and in far greater quantity than it did the first time. An investigator claims that the earlier onset and the larger quantity are two outcomes of two distinct causes, not one cause showing itself in two ways. Three possible findings are listed below. Which findings, if obtained, would support that claim?

I. In animals whose lymphocytes able to bind the antigen are reduced back to the number present before any exposure, but which are otherwise unaltered, a repeat dose still yields antibody within two days, although the peak is no higher than in a first response.

II. In animals that have never met the antigen, artificially raising the number of lymphocytes able to bind it lifts the peak reached but leaves the onset as late as usual.

III. A drug that blocks lymphocyte division, given at the moment of the repeat dose, abolishes both the early onset and the raised peak.$q$,
    $q$[{"label":"A","text":"I and II only"},{"label":"B","text":"I and III only"},{"label":"C","text":"II and III only"},{"label":"D","text":"I, II, and III"}]$q$::jsonb,
    'A',
    $q$This question belongs to the Organ Systems category and tests whether the two features of a repeat response, its earlier onset and its greater size, follow from one cause or from two. The answer is A because findings I and II each break the link between the two features, in opposite directions, whereas finding III is equally expected on either account. After a first exposure the population able to bind that antigen differs from the population in a naive animal in two respects at once: there are far more such cells, and those cells are already advanced along the road to secretion. Finding I strips away the numerical advantage while leaving the advanced state, and the speed survives while the size does not. Finding II grants the numerical advantage to an animal that has no advanced state, and the size improves while the speed does not. Two dissociations pointing in opposite directions show that each feature tracks a different property of the population, which is exactly the investigator's claim, and a student who explains only the speed or only the size has accounted for half of what changed. (Choice B) Finding I is genuinely informative, but finding III reports only that proliferation is needed downstream of both features, which is a true statement about the response that a single cause account predicts just as readily. (Choice C) This selection treats a shared downstream requirement as though it discriminated between the two accounts, and it discards finding I, the one result that separates onset from magnitude. (Choice D) Findings I and II are the two useful dissociations, but adding III does not strengthen the case, because a manipulation that removes both features together is neutral between one cause and two. This is a Scientific Reasoning and Problem Solving question because it asks the student to judge which experimental outcomes could dissociate two co-occurring features of a repeat response and which merely confirm a requirement common to both.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'adjacent_fact', $q$true observation that does not bear on the claim$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$a common requirement counts as evidence of separate causes$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$correct pair plus one neutral finding$q$ FROM q;

-- B2 Q16 . Specificity Control in a Two Exposure Time Course . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Specificity Control in a Two Exposure Time Course$q$,
    $q$Antigen X is injected into a rabbit at the start of the study. Six weeks later the same rabbit receives a further dose of antigen X together with an unrelated antigen Y that it has never met. The table gives the concentration of circulating protein able to bind each antigen, in arbitrary units, on the days following whichever dose began that time course.

| Days after dose | X, first dose | X, second dose | Y, first dose |
|---|---|---|---|
| 2 | <1 | 12 | <1 |
| 4 | <1 | 140 | <1 |
| 7 | 3 | 620 | <1 |
| 10 | 18 | 900 | 2 |
| 14 | 30 | 950 | 15 |
| 21 | 24 | 780 | 26 |

What does including antigen Y allow the investigator to establish that the two antigen X columns on their own could not?$q$,
    $q$[{"label":"A","text":"The repeat dose of X reaches a far higher peak than the first dose of X did."},{"label":"B","text":"Only the substance met earlier shows the swift, large accumulation, which rules out a body-wide lift in reactivity."},{"label":"C","text":"The reply to Y was held back by the simultaneous huge reply to X, so both draw on one shared pool of cells."},{"label":"D","text":"Having met X already quickens the animal's first reply to unfamiliar material, since binding protein for Y arises sooner than it did for X."}]$q$::jsonb,
    'B',
    $q$This question belongs to the Organ Systems category and tests what a simultaneous unrelated antigen adds to a comparison of first and repeat time courses. The answer is B because Y is given to the same animal at the same moment as the second dose of X, so its slow low course confines the acceleration and amplification to the one antigen the rabbit had met before, excluding any whole animal change in responsiveness acquired over the six weeks. Taken alone, the two X columns are compatible with two very different accounts: either the lymphocytes able to bind X changed, or the rabbit as a whole became a faster and stronger responder to anything. The Y column decides between them. Binding protein for Y stays below 1 unit until day 10 and reaches only 26 units by day 21, essentially the same sluggish, low course that X produced on first meeting, while X in the same animal at the same time is already at 140 units by day 4 and peaks near 950. Confinement of the effect to a single binding shape is what clonal selection predicts, because only lymphocytes whose receptors bound X were selected, expanded and retained, and a first meeting with a different antigen still shows the usual delay and low level. (Choice A) This is a fair reading of the two X columns, but it is exactly the conclusion those two columns already permit, so it names nothing that antigen Y contributes to the design. (Choice C) The data show no suppression of Y: its course matches what a first meeting normally looks like, and a large simultaneous reply to X neither delayed it nor lowered it, so no competition for a shared pool is demonstrated. (Choice D) The numbers run the other way. Binding protein for Y was still below 1 unit at day 7, when X on first meeting had already reached 3 units, so prior contact with X did not hasten the reply to an unfamiliar antigen. This is a Data-based and Statistical Reasoning question because it requires comparing three time courses measured in one animal and deciding which conclusion the added column licenses, rather than reading any single concentration off the table.$q$,
    'hard',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    4,
    105
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$true conclusion that the control does not add$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$competing responses drain a shared pool$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$acceleration generalised to an unmet antigen$q$ FROM q;

-- B2 Q17 . Enlarged Responsive Population After Clearance . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Enlarged Responsive Population After Clearance$q$,
    $q$A person meets a particular antigen for the first time; the infection resolves and antibody against that antigen later falls below detection. Thirty years on, the same antigen is met again and is dealt with in two days rather than the two weeks the first episode took. Ignoring for the moment any change in how readily one cell is switched on, the shortened delay follows chiefly from which property of what the first episode left behind?$q$,
    $q$[{"label":"A","text":"Far more cells bearing receptors matched to it persist than were there at the start, so fewer rounds of proliferation stand between contact and a useful output."},{"label":"B","text":"The surviving cells now carry receptors that fit a wider range of foreign material, so more of them can take part."},{"label":"C","text":"The surviving cells live far longer than ordinary lymphocytes do, which is why they are still present decades later."},{"label":"D","text":"The bone marrow releases new lymphocytes of that specificity at a permanently higher rate afterwards."}]$q$::jsonb,
    'A',
    $q$This question belongs to Organ Systems and tests what an adaptive response leaves behind once it has finished, and why that residue by itself shortens the next encounter. The answer is A because the enlarged pool that survives the first episode is made up of descendants of the very few cells originally picked out by that substance, so a later exposure begins from a much larger base and needs far fewer divisions to reach a protective level of output. In a first exposure the body must find, among an enormous pre-built variety of lymphocytes, the rare ones whose surface binding sites happen to fit. Those few then divide again and again, and the days consumed by that build-up account for most of the lag before antibody can be measured. Most of the progeny become short lived secreting cells and die once the threat is gone, but a substantial fraction stays behind, permanently outnumbering the original handful by orders of magnitude. Present the same substance again and the arithmetic of clonal expansion starts from a far higher point, which on its own removes most of the wait, with no change in what any single cell can recognise. (Choice B) Binding specificity is fixed when a lymphocyte matures and does not broaden with experience. If it did, the accelerated handling would not be restricted to the one substance that produced it, and restriction to that one substance is exactly what is observed. (Choice C) Long survival is real, and it explains why the pool is still present decades later, but persistence answers whether the cells are there, not why what they mount is quicker. Speed comes from how many of them are waiting when the substance returns. (Choice D) The marrow keeps generating fresh lymphocytes across the whole pre-built range of specificities and has no way of knowing which one proved useful. The surplus is generated in the periphery by division of the cells that bound the substance, not upstream at the site where new lymphocytes are made. This is a Knowledge of Scientific Concepts and Principles question because it asks the student to recall what clonal selection and clonal expansion leave in place after a response resolves and to attach that stored population directly to the shortened lag of a later exposure.$q$,
    'easy',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    1,
    65
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'misconception', $q$specificity broadens with experience$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$true persistence, wrong explanatory role$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$expansion relocated to the generative site$q$ FROM q;

-- B2 Q18 . Lowered Triggering Requirement of Surviving Lymphocytes . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Lowered Triggering Requirement of Surviving Lymphocytes$q$,
    $q$A protein is given at a dose too small to elicit any antibody in a mouse meeting it for the first time. When the number of lymphocytes able to bind that protein is first raised in such a mouse to match the number carried by a mouse that met the protein a year earlier, the low dose still elicits nothing, whereas the previously exposed mouse makes antibody at that dose. In a separate comparison, the soluble signal normally supplied by the lymphocyte subset that licenses others rather than killing them is held at a level that silences the first-time mouse completely, and the previously exposed mouse still makes antibody. Taken together, what do these two findings establish about the origin of the improved second response?$q$,
    $q$[{"label":"A","text":"The improvement is fully explained by there being more cells able to bind that protein, since more binding events occur at any dose."},{"label":"B","text":"The always ready, nonspecific defences were upgraded by the first exposure and now handle the protein themselves."},{"label":"C","text":"Pool size cannot account for it, because adding cells does not lower the input each one must gather before it commits."},{"label":"D","text":"Each surviving cell secretes far more antibody than a newly made one does, so even minimal triggering yields a detectable level."}]$q$::jsonb,
    'C',
    $q$This question belongs to Organ Systems and tests whether the improvement in a repeat adaptive response can be credited entirely to the size of the pool left behind by the first exposure. The answer is C because the amount of stimulus a cell must collect before it is switched on is a property of that cell, and multiplying how many such cells are present does not reduce that requirement; if anything, dividing a fixed dose among more cells gives each one less. In the first finding the low dose yields nothing in the unexposed animal even after its population able to bind the protein has been brought up to match the exposed animal, so the two groups are equated on abundance and still differ in outcome. In the second finding the accessory input that a fresh cell must receive is cut to a level that abolishes the response in the unexposed animal, yet the exposed animal still responds, and a required input cannot be substituted for by extra cells either. The two findings therefore isolate a change in the cells themselves: the survivors are intrinsically easier to switch on, needing less of the material they recognise and less licensing than a cell that has never been used. Faster protection on re-exposure is thus the sum of two contributions, a bigger starting pool and a lower bar for setting each member of it in motion. (Choice A) Greater numbers are genuinely part of the story and account for much of the shortened lag under ordinary conditions, but the first finding deliberately matches the two animals on how many cells can bind the protein and the advantage survives that match, so abundance cannot be the whole account. (Choice B) The defences that act the same way on every foreign surface do not acquire target specific improvement; had they been upgraded, the advantage would extend to unrelated organisms, and specificity to the substance previously met is the defining feature of the improvement being examined. (Choice D) Product per cell concerns how much appears after a cell has committed rather than whether commitment happens, and the cells left behind by an earlier response are distinguished by how readily they start and by how long their secreting progeny persist, not by a higher output rate per cell. It also leaves the second finding unexplained, since there the licensing input rather than the recognised protein was withheld. This is a Scientific Reasoning and Problem Solving question because it asks the student to reason backwards from two outcomes, one of which equates the animals on cell number, and decide which of two candidate causes can and cannot produce them.$q$,
    'hard',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    110
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$correct contributor, over-extended to sufficiency$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$nonspecific arm acquires specific improvement$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$output magnitude substituted for the commitment step$q$ FROM q;

-- B2 Q19 . Cell-Free Control in a Protection Transfer . medium . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Cell-Free Control in a Protection Transfer$q$,
    $q$A mouse that cleared a bacterial infection two months earlier serves as the donor, and cells taken from its spleen are moved into mice of the same inbred line that have never met that bacterium. Those mice then survive a bacterial dose that kills untreated mice of the line. A parallel group receiving spleen cells from a donor with no history of that infection dies at the untreated rate. The investigators conclude that protection travels with the moved cells. Which further group does the design need before that conclusion is safe?$q$,
    $q$[{"label":"A","text":"Mice given the same donor cells and then challenged with an unrelated bacterium."},{"label":"B","text":"Mice given the donor cells one week after the challenge instead of before it."},{"label":"C","text":"Mice given twice as many donor cells, to show a graded relation between number and survival."},{"label":"D","text":"Mice given the cell-free liquid left when the same donor material is passed through a filter."}]$q$::jsonb,
    'D',
    $q$This question belongs to Organ Systems and tests the logic of crediting transferred protection to the cells in a preparation rather than to something else carried along with them. The answer is D because a suspension drawn from an animal that has already responded contains soluble products of that response, above all antibody whose binding sites fit the organism, and antibody transferred on its own is sufficient to protect a recipient that has never met the organism. Only an arm receiving the identical preparation with every cell taken out can separate the two possibilities. Should the filtered fluid protect as well as the intact suspension, survival is attributable to what was dissolved in it; should it fail, survival must be credited to the living population that was removed. Note what the existing arms already accomplish: the group receiving cells from a donor with no prior contact excludes any nonspecific benefit of receiving lymphocytes as such, and using one inbred line excludes rejection of the graft and a reaction to nonself tissue. What is still uncontrolled is the carry-over of dissolved products, and closing that gap is what the stated conclusion requires. (Choice A) Challenging with a different organism tests whether the protection is confined to what the donor previously met. That is a worthwhile question, but it is a different question, and a dissolved product would be equally confined, so this arm cannot tell a cellular cause from a soluble one. (Choice B) Giving the preparation after the challenge asks about treatment timing rather than about where the protection resides, and a suspension delivered later still carries the same dissolved products with it. (Choice C) A graded relation between how much was given and how many survived looks persuasive, but the volume of accompanying fluid rises in step with the number of cells, so both candidate agents increase together and the ambiguity is untouched. This is a Reasoning about the Design and Execution of Research question because it asks the student to name the specific control arm that separates a cellular cause from a soluble one before a transfer experiment can support a causal claim.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    3,
    95
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'adjacent_fact', $q$valid control for a different claim$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', $q$timing arm substituted for a source arm$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$dose relation that scales the confound too$q$ FROM q;

-- B2 Q20 . Accessible Targets in a Prior Exposure . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Accessible Targets in a Prior Exposure$q$,
    $q$Two harmless test materials are made from one bacterium: one is the protein of its outer wall layer, the other an abundant enzyme the organism keeps inside itself and never puts on its outer face. Animals given either material generate antibody in equal amount and with equal tightness of fit for its own target, yet only the animals given the wall protein material survive a later challenge with the whole bacterium. Which requirement for protection does this result reveal?$q$,
    $q$[{"label":"A","text":"Protection is strongest when the response is aimed at a molecule buried deep in the organism, where it disables essential machinery."},{"label":"B","text":"The internal enzyme reached the circulation without being taken up and shown to lymphocytes, so no lasting clone was established for it."},{"label":"C","text":"Only one of the two responses yields molecules able to grip a feature displayed on the intact cell."},{"label":"D","text":"Both responses install lasting clones, but only the one aimed at the wall layer is renewed often enough to still be present at challenge."}]$q$::jsonb,
    'C',
    $q$Organ Systems, antigen and antibody recognition: this item asks what a deliberate harmless prior exposure must supply if the protection it installs is to work when the real organism arrives. The answer is C because protection depends on the expanded clones producing molecules that can physically reach and grip a structure carried on the outside of the intact pathogen, and only the wall protein material offers such a structure. Clonal selection expands whatever lymphocytes happen to fit the material supplied, so both animals expand a well fitted population and both accumulate abundant product of equal fit; the two responses are equivalent in every respect the assay measured. What differs is the address of the target. The enzyme sits behind the wall of the intact organism during a real challenge, so the fitted molecules circulate with nothing to hold, and the infection proceeds as though the animal had never been treated at all. The wall protein, by contrast, is on the exposed face of every cell in the challenge dose, so the same recognition event now lands on the pathogen and the organism is blocked and marked for destruction. This is exactly why a controlled prior exposure has to carry the same reachable features the pathogen itself will present, rather than merely any part of it.

(Choice A) reverses the relationship between target location and protective value. A molecule sequestered inside the organism is harder, not easier, for a circulating recognition molecule to reach, and burial confers no advantage; the useful target is the one on the outside.

(Choice B) misplaces the failure at the uptake and display step. Both animals plainly took up, processed, and displayed their material, because a large, tightly fitting product cannot be generated without that step, so the two responses diverge later, at the challenge itself.

(Choice D) is correct that both animals hold lasting clones, but persistence is not what separates the groups. Both received a single treatment and were challenged at the same later time, so no difference in durability is available to explain the outcome.

This is a Scientific Reasoning and Problem Solving question because the student must recognise that equal amounts of equally tight product do not by themselves confer protection and must infer that reachability of the target on the intact organism is the limiting requirement.$q$,
    'hard',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    95
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', NULL FROM q;

-- B2 Q21 . Control Arms for a Specificity Claim . medium . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Control Arms for a Specificity Claim$q$,
    $q$A team gives mice a harmless material made from bacterium P, waits four weeks, then challenges them with the unrelated bacterium Q and finds that the mice become infected. They wish to conclude that the protection this material installs does not extend to Q. Which of the following groups must the study include for that conclusion to hold?

I. Mice given no material and then challenged with Q
II. Mice given the material from P and then challenged with P
III. Mice given a material made from Q and then challenged with Q$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"I and II only"},{"label":"C","text":"I, II, and III"},{"label":"D","text":"II only"}]$q$::jsonb,
    'B',
    $q$Organ Systems, the specificity of adaptive protection: this item asks which comparison arms are logically necessary before a failure to protect can be read as evidence that protection is antigen specific. The answer is B because the intended conclusion rests on two separate claims, that the mice met Q at its ordinary infection rate and that the material was capable of protecting at all, and those two claims are supplied by group I and group II respectively. Without group I there is no figure to compare the observed infection rate against, so the outcome after the P material carries no information; Q might infect nearly every animal it meets, treated or not, or hardly any. Without group II an equally simple explanation survives, that this batch of material was inert, degraded, or given below an effective dose, in which case the failure says nothing about the reach of protection and everything about the preparation itself. With both arms present the result is pinned down: the material demonstrably installed protection, and that protection demonstrably did not carry over to an organism sharing none of the same recognised features. Group III addresses a different question, whether Q can be protected against by some material of its own, and the answer to that has no bearing on whether protection raised against P transfers.

(Choice A) supplies the baseline and nothing else. It rules out the possibility that Q fails to infect untreated mice, but it leaves an inert or mishandled preparation standing as a complete alternative explanation for the lack of protection.

(Choice C) treats an informative arm as a required one. A study can establish that protection raised against P does not extend to Q without ever showing that any material protects against Q, so this group strengthens the report but is not needed for the stated conclusion.

(Choice D) confirms that the material was potent but leaves the challenge outcome uninterpretable, because the infection rate observed after the P material has no untreated value to be measured against.

This is a Reasoning about the Design and Execution of Research question because the student must decide which control arms are logically required to support a negative result and must separate a necessary comparison from one that is merely informative.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    3,
    75
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', NULL FROM q;

-- B2 Q22 . Graded Protection Against a Mutated Coat . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Graded Protection Against a Mutated Coat$q$,
    $q$Rabbits received one of three prior treatments and were later challenged with one of three organisms. Variant A2 arose from strain A by mutation of its outer coat, while species Z is unrelated to A. The table gives the percentage of rabbits still uninfected fourteen days after challenge. Which conclusion about the material made from strain A does this pattern support?

| Prior treatment | Challenge organism | Percent uninfected |
| --- | --- | --- |
| Material from A | Strain A | 94 |
| Material from A | Variant A2 | 38 |
| Material from A | Species Z | 8 |
| Material from Z | Strain A | 9 |
| None | Strain A | 7 |
| None | Variant A2 | 6 |
| None | Species Z | 10 |$q$,
    $q$[{"label":"A","text":"Variant A2 is intrinsically less able to establish an infection than strain A is."},{"label":"B","text":"Any prior treatment raises a general resistance that partly blunts whatever organism follows it."},{"label":"C","text":"Full protection requires a second dose of the material, which the rabbits meeting A2 had not received."},{"label":"D","text":"It installed binders that engage part of what A2 now presents and none of what Z presents."}]$q$::jsonb,
    'D',
    $q$Organ Systems, the specificity of protection installed by a controlled prior exposure: this item asks what a graded set of challenge outcomes reveals about which features the installed response recognises. The answer is D because the value against A2, 38 percent, sits far above its own untreated rate of 6 percent yet far below the 94 percent recorded against strain A, which is the signature of a partial match, while both pairings involving Z sit level with their matched untreated rates, which is the signature of no match at all. The untreated arms give 7 percent for A and 6 percent for A2, so the two challenges are equally severe in a naive animal and the intermediate 38 percent cannot be blamed on a feeble variant. Mutation of an outer coat alters some of the features an existing response grips and leaves others unchanged, so the portion of the response that still finds a hold sets the portion of animals that stay clear, which is why the figure lands between the two extremes rather than at either one. The two unrelated pairings, 8 percent for the A material against Z where untreated rabbits reached 10 percent, and 9 percent for the Z material against A where untreated rabbits reached 7 percent, differ from their own baselines by no more than two points in either direction, which is precisely what antigen specific protection predicts.

(Choice A) is excluded by the untreated arms. Rabbits given nothing resist A2 no better than they resist A, 6 percent against 7 percent, so the variant is not the weaker organism and its intrinsic capacity cannot explain the intermediate value.

(Choice B) is excluded by the two unrelated pairings, which land within two points of their own untreated rates. A general heightened state installed by any treatment would have lifted those groups above their baselines, and it did not.

(Choice C) misplaces the requirement at the dosing stage. Every treated group received one identical dose, and the group challenged with strain A reached 94 percent on that single dose, so the number of doses cannot account for the shortfall against A2.

This is a Data-based and Statistical Reasoning question because the student must compare each treated value against its own matched untreated value and infer from the size of each gap how much of the recognised structure the mutated variant still retains.$q$,
    'hard',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    4,
    105
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', NULL FROM q;

COMMIT;

-- Verification: after batches 1, 2 and 3, expect 68 questions and 204 distractor rows.
SELECT
  (SELECT COUNT(*) FROM public.questions WHERE topic = 'The Immune System') AS questions,
  (SELECT COUNT(*) FROM public.question_distractor_metadata m
     JOIN public.questions x ON x.id = m.question_id
   WHERE x.topic = 'The Immune System') AS distractor_rows;
