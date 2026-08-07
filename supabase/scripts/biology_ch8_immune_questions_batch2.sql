-- Biology Chapter 8: The Immune System, standalone questions
-- BATCH 2 of 4 (24 questions): the major histocompatibility complex and T lymphocytes.
--   Units: MHC and antigen presentation (12) . T lymphocytes and cell-mediated immunity (12)
--
-- The bank had ZERO questions touching the major histocompatibility complex before this batch,
-- despite MHC being explicitly named in the AAMC content outline.
--
-- SCOPE CONVENTION (carried from batch 1): entities the outline does not name are described
-- functionally and never required as recalled vocabulary. Verified clean of: CD4, CD8, helper T,
-- cytotoxic T, regulatory T, dendritic, natural killer, class I, class II, T-cell receptor,
-- positive/negative selection, cytokine, interleukin, costimulation, perforin, granzyme.
-- "Major histocompatibility complex" and "MHC" ARE outline-named and are used freely.
--
-- !! RUN AFTER BATCH 1 !!
-- No DELETE here: batch 1 owns the chapter-scoped DELETE. Run
-- biology_ch8_immune_questions.sql first, then this file. Re-running this file alone would
-- duplicate its 24 questions.

BEGIN;

-- B2 Q1 . Detecting an Entirely Intracellular Infection . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Detecting an Entirely Intracellular Infection$q$,
    $q$A virus completes its entire replication cycle within a liver cell. Nothing recognisable from the invader is ever exposed on the outer face of that cell's membrane, and circulating antibody cannot cross that membrane to reach what lies inside. Nevertheless a patrolling lymphocyte of the lineage that kills its target directly singles this cell out for destruction.

What property of the liver cell makes this identification possible?$q$,
    $q$[{"label":"A","text":"The virus inserts whole copies of its own coat proteins into the outer membrane, where they project outward as intact foreign structures rather than as processed pieces."},{"label":"B","text":"The patrolling cell mounts samples of its own interior in its major histocompatibility complex grooves and the liver cell inspects them, so the inspection runs from the immune cell toward the target."},{"label":"C","text":"The liver cell routinely digests a sample of the proteins built in its own interior and mounts the resulting short pieces in a groove on its major histocompatibility complex molecules."},{"label":"D","text":"The infected cell secretes a diffusible signal that slows viral replication in neighbouring cells, and the patrolling cell homes to the source of that signal."}]$q$::jsonb,
    'C',
    $q$This question belongs to the Organ Systems content category and tests antigen presentation, specifically how an infection sealed inside a cell is made legible to a patrolling killer lymphocyte. The answer is C because a nucleated cell constantly samples the proteins it builds in its own interior, cuts them into short pieces, and seats those pieces in a groove on its major histocompatibility complex molecules, so an event confined to the cytosol acquires an outward readout. Antibody is a soluble blood protein and cannot cross an intact membrane, which means surveillance by dissolved proteins stops at the outer leaflet and can say nothing about what a living cell contains. The solution the body uses is to make each cell report on itself: whatever the cell is synthesising, including anything a virus compels it to synthesise, enters the sampling stream automatically. The patrolling cell therefore never sees the virus at all. What it sees is a short sequence that does not belong to the catalogue of the body's own products, held in the display groove, and recognition is of that combined unit rather than of the pathogen itself. (Choice A) Some enveloped viruses do insert glycoproteins into the host membrane, but the stem specifies that nothing recognisable from the invader is exposed there, and a surveillance system that required intact foreign structures on the outside would miss every pathogen that keeps its products internal. (Choice B) This inverts the direction of inspection. The cell under suspicion is the one that must exhibit samples of its contents, and the patrolling cell is the reader of that exhibit. A lymphocyte showing its own pieces would report on the lymphocyte and would say nothing about the liver cell it is inspecting. (Choice D) Infected cells do release soluble signals that slow viral replication in the surrounding tissue, and that is a genuine antiviral defence, but a diffusible signal spreads across a field of cells and cannot mark out which individual cell is harbouring the invader. It also acts on the cells that receive it rather than condemning the cell that sent it. This is a Scientific Reasoning and Problem Solving question because the student must reason from the physical inaccessibility of a cell's interior to the only surveillance strategy that could possibly work, instead of recalling a labelled pathway.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$whole antigen on the surface$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', $q$inverted display and inspection roles$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$diffusible antiviral signal as a locator$q$ FROM q;

-- B2 Q2 . Universal Distribution of the Display Molecule . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Universal Distribution of the Display Molecule$q$,
    $q$The major histocompatibility complex molecules that report on a cell's internal contents are made by essentially every nucleated cell of the body, while a second reporting device is restricted to the few cell types that ingest foreign material. Mature red blood cells carry neither. What accounts for the near universal distribution of the first device?$q$,
    $q$[{"label":"A","text":"Intracellular parasites can take up residence in almost any tissue, so a cell type that could not advertise what it harbours would become a hiding place no killing lymphocyte could see."},{"label":"B","text":"Every nucleated cell must be able to engulf material from outside itself, and reporting on that engulfed material is an obligatory downstream step of the uptake."},{"label":"C","text":"Mature red blood cells extrude their nucleus during development and can therefore no longer transcribe the genes that encode these molecules."},{"label":"D","text":"A cell installs these molecules only after a patrolling lymphocyte has already flagged it as abnormal, so the display follows the inspection."}]$q$::jsonb,
    'A',
    $q$This question belongs to the Organ Systems content category and tests antigen presentation, in particular why one reporting system is spread across almost the whole body while a second is confined to a handful of cell types. The answer is A because the intracellular pathogens this system exists to expose are not restricted to any one tissue, so any cell type that could not advertise what it harbours would be a place where such a pathogen could multiply unseen. Viruses and other obligate intracellular organisms take up residence in nerve, muscle, liver, gut and skin alike. The lymphocyte lineage that kills targets directly can act only where an advertisement is available, so the coverage of the system has to match the reach of the threat; a gap in coverage would be a gap in defence rather than a saving. The second device has a different job. It hands out material the cell has taken in from outside, so only cells that professionally ingest such material need it, and its distribution is correspondingly narrow. Mature red blood cells are the exception that confirms the logic, since without a nucleus they lack both the genes and the ordinary protein synthesis machinery needed to build a display molecule at all. (Choice B) Engulfing material from outside is the specialty of a small set of phagocytic cells, and it is precisely those cells that carry the second device. Advertising internally made products requires no ingestion step whatever, so engulfment cannot be the reason the first device is everywhere. (Choice C) It is true that a maturing red blood cell extrudes its nucleus and loses the ability to transcribe these genes, and that correctly explains why red cells are bare. It is a statement about the one exception and says nothing about why every cell that does retain a nucleus carries the device. (Choice D) The device is present continuously rather than installed on demand. If it appeared only after a cell had already been flagged as abnormal, there would be no information available for the flagging step itself, which makes the proposal circular. This is a Knowledge of Scientific Concepts and Principles question because the student must connect the known tissue range of intracellular pathogens to the distribution a surveillance molecule needs in order to expose them.$q$,
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
  SELECT q.id, 'B', 'misconception', $q$conflating the two reporting systems$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$true fact about the exception$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$display induced by recognition$q$ FROM q;

-- B2 Q3 . Baseline Self Fragment Display in Healthy Cells . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Baseline Self Fragment Display in Healthy Cells$q$,
    $q$A tissue sample is taken from a person with no infection anywhere in the body. Every nucleated cell in the sample displays its usual surface density of major histocompatibility complex molecules, and essentially all of their binding grooves are occupied rather than empty. Which of the following can be concluded about this occupancy?

I. The pieces filling the grooves are products of the cell's ordinary internal protein turnover.
II. Maintaining occupancy in the absence of any pathogen is superfluous, since there is nothing foreign to report.
III. The steady baseline this occupancy creates is what allows an unfamiliar fragment appearing later to be judged as nonself.$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"III only"},{"label":"C","text":"I, II, and III"},{"label":"D","text":"I and III only"}]$q$::jsonb,
    'D',
    $q$This question belongs to the Organ Systems content category and tests self versus nonself recognition as it operates in the resting, uninfected state. The answer is D because statements I and III are both supported while statement II rests on a false premise about what the resting display is for. In a healthy cell, enzyme complexes in the cytoplasm continually chew up ordinary cellular proteins, and the short pieces produced by that routine turnover are the material that fills the binding grooves, so in a person with no infection the occupants must be of the body's own making, which is what statement I asserts. That continuous traffic is not idle machinery waiting for an emergency. It is the reference standard, because a surveying cell can call a fragment foreign only by contrast with the ordinary pattern it has learned, and that is what statement III asserts. Statement II therefore fails on its own logic: an unfamiliar fragment would carry no meaning at all if there were no familiar output to compare it against, so display in the absence of infection is the very thing that makes later detection possible. (Choice A) Statement I is correct, but stopping there treats the baseline as an incidental by-product of protein turnover with no function. The reason the body pays the continuous metabolic cost of display is the one given in statement III, so omitting it misses the point of the observation. (Choice B) Statement III is correct, but rejecting statement I leaves the grooves filled by nothing in particular. In a person with no infection there is no foreign source available, so the occupants have to come from the cell's own protein economy. (Choice C) This adds statement II, the intuitive but mistaken idea that a defence with nothing to report is wasted effort. Without a familiar baseline there would be no standard against which an unfamiliar fragment could ever be judged, so the resting output is doing work at all times. This is a Scientific Reasoning and Problem Solving question because the student must evaluate three claims about a baseline observation and decide which of them the uninfected condition actually licenses.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    90
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$true but incomplete set$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$true but incomplete set$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$resting defence as wasted effort$q$ FROM q;

-- B2 Q4 . Consequences of Suppressed Surface Display . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Consequences of Suppressed Surface Display$q$,
    $q$A certain virus encodes a protein that lowers the number of reporting molecules a host cell places on its surface. Three cultures of identical nucleated cells were prepared: uninfected, infected with a mutant virus that lacks that protein, and infected with the wild type. Each culture was then exposed separately to two lymphocyte preparations. Set 1 came from an animal previously exposed to this virus and was expanded from a single responding clone; set 2 came from an animal never exposed to any virus. Cell numbers were equal in every well.

| Culture | Reporting molecules per cell (thousands) | Killed by set 1 (%) | Killed by set 2 (%) |
| --- | --- | --- | --- |
| Uninfected | 60 | 2 | 3 |
| Mutant virus | 55 | 68 | 6 |
| Wild-type virus | 5 | 5 | 61 |

The results most strongly support which account of what each set demands of a cell before killing it?$q$,
    $q$[{"label":"A","text":"Set 2 recognises the same viral fragment as set 1 but with slower kinetics, which is why it prevails only in the wild-type culture."},{"label":"B","text":"Set 1 acts only on a target that is exhibiting a foreign piece on its outer face, whereas set 2 acts on a target whose outward exhibit has dwindled, so the wild type simply exchanges one attacker for another."},{"label":"C","text":"Set 1 is switched on by the disappearance of the reporting molecules and set 2 by their abundance."},{"label":"D","text":"The wild-type protein blocks the breakdown of viral products in the cytosol, so the reporting molecules stay at their usual density but carry only ordinary self pieces."}]$q$::jsonb,
    'B',
    $q$This question belongs to the Organ Systems content category and tests antigen presentation together with the consequence of losing it. The answer is B because the two infected cultures carry the same viral antigens and differ only in one viral protein, so the collapse of set 1 killing from 68 percent to 5 percent cannot be a difference in binding specificity and must track the fall in reporting molecules from 55 thousand to 5 thousand per cell. Set 1 was expanded from a single responding clone in an animal that had met this virus, which is the signature of a population selected for one binding partner, and its output falls to background precisely where the surface report vanishes. Set 2 came from an animal that had never met any virus, so no clone in it could have been selected against this pathogen, yet it kills the low display culture at 61 percent while leaving both high display cultures near the 2 to 6 percent background. The trigger for set 2 is therefore the shortfall itself rather than any particular fragment. The virus does gain something by suppressing the display, since it blinds the selected killer, but it pays for that gain by revealing the cell to a population that reads absence. (Choice A) If set 2 read the same fragment as set 1, it would have to kill the mutant culture as well, merely later; instead it stays at 6 percent there, and an animal never exposed to the virus has no expanded clone for it. (Choice C) This reverses both assignments. Set 1 is the population that fails when the report disappears, and set 2 is the one that fails when the report is abundant, which is the opposite of what the choice states. (Choice D) This proposes an interference at the degradation step rather than at the display step, and it predicts that the reporting molecule count would remain near the uninfected value. The measured 5 thousand per cell in the wild-type culture rules it out directly. This is a Data-based and Statistical Reasoning question because the student must compare killing percentages across matched cultures and attribute the difference to the one measured variable that changes between them.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$nonspecific killer treated as specific$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', $q$inverted activation signals$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$wrong step of the presentation pathway$q$ FROM q;

-- B2 Q5 . Two Fragment Sources, Two Carriers . easy . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Two Fragment Sources, Two Carriers$q$,
    $q$A scavenging cell engulfs a bacterium and breaks it apart, while a nearby skin cell is invaded by a virus that is now copying itself in the cytosol. Both cells end up carrying short peptides on their outer face, yet the immune system must treat the two cells very differently. Why must peptides of these two origins be held by different surface carriers?$q$,
    $q$[{"label":"A","text":"Fragments of the cell's own normal proteins are never put on view, so a second carrier is needed for the self peptides that escape breakdown."},{"label":"B","text":"The cell that took in foreign matter is the more dangerous of the two, so the split allows that cell rather than the invaded one to be eliminated."},{"label":"C","text":"A cell reporting on debris it had taken up would look identical to one whose own synthetic machinery had been subverted, and would be killed alongside it."},{"label":"D","text":"Two carriers can hold a wider assortment of peptide shapes than one, so the split mainly widens the range of pathogens that can be detected."}]$q$::jsonb,
    'C',
    $q$This Organ Systems item tests antigen presentation, specifically why the source of a displayed peptide has to be encoded in the carrier that holds it. The answer is C because a single carrier would erase the one piece of information a responding lymphocyte needs before it acts: whether the cell putting the peptide on view is itself compromised or is only acting as a messenger. Every cell with a nucleus continuously samples the proteins it is making, chops a fraction of them up, and places the pieces on its outer face, so a viral peptide appearing there is direct evidence that virus is being assembled in that very cell, and the correct outcome is elimination of the cell. The scavenging cell in this stem is perfectly healthy. What it shows is evidence about its surroundings, not about itself, and the correct outcome is a call for reinforcement rather than its own death. Since the two situations demand opposite fates for the cell doing the showing, the carrier has to differ so that the lymphocyte arriving at the surface knows which fate applies before it commits.

(Choice A) Normal cells do put fragments of their own ordinary proteins on view, and they do so constantly. That steady display of self is exactly what marks a cell as unaltered, so the premise of this choice is false.

(Choice B) This reverses the danger. A cell that has swallowed and destroyed a microbe has done its job, whereas a cell that is manufacturing viral protein is the one that must be removed. Eliminating the scavenging cell would destroy the very cells that organise the response.

(Choice D) Broadening the range of shapes that can be held is a genuine benefit of having more than one carrier, but it does not explain why the two carriers are loaded from different internal compartments or why they engage different lymphocyte populations. A system built only for breadth could have used two carriers of the same kind, loaded from the same source.

This is a Scientific Reasoning and Problem Solving question because it asks the student to reason from the opposite outcomes the two cells require back to the structural feature that keeps those outcomes distinguishable.$q$,
    'easy',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    75
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$self peptides are never displayed$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', $q$wrong cell targeted for destruction$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$repertoire breadth substituted for compartment segregation$q$ FROM q;

-- B2 Q6 . Restricting the Ingested-Material Display . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Restricting the Ingested-Material Display$q$,
    $q$In a laboratory strain of mouse, a mutation puts the second display molecule, the one normally restricted to a small set of cells that take in and break down foreign material, onto every nucleated cell in the body. Each cell can now load that molecule with peptides drawn from the fluid around it. Which consequence would this change be expected to produce?$q$,
    $q$[{"label":"A","text":"Cells harbouring a virus in their cytosol would stop being recognised, because the newly added molecule would crowd out the display that all nucleated cells already carry."},{"label":"B","text":"Ordinary self proteins, harmlessly sampled, would be presented to the lymphocyte population that grants other cells permission to act, so attacks would be mounted on healthy structures."},{"label":"C","text":"The rate at which bacteria are engulfed and destroyed would rise across the body, since far more cells could now take up and break down microbes."},{"label":"D","text":"Peptides drawn from the surrounding fluid would be routed to the lymphocyte population that kills on contact, so cells everywhere would be lost to immediate direct attack."}]$q$::jsonb,
    'B',
    $q$This Organ Systems item tests antigen presentation together with self versus nonself recognition, using a thought experiment that removes the normal limit on which cells may show ingested matter. The answer is B because putting that molecule on every cell would turn the whole body into a source of requests for help, including the vast majority of cells that never encounter anything dangerous. The lymphocyte population engaged by that particular display does not kill its target; it grants other cells permission to proceed, which is precisely why the display is confined to a small set of cells that load it only after taking in and dismantling something. Cells bathed in extracellular fluid would take up serum proteins, shed membrane, and the remains of neighbours that died of ordinary wear, and every one of those peptides would then be offered as though it were evidence of an intruder. The mechanisms that remove self reactive lymphocytes as they mature are not completely effective, so some lymphocytes able to bind self peptides always persist. Offering self material in this permissive setting invites exactly the mistaken activation that the restriction exists to prevent, which is the pattern underlying autoimmune disease.

(Choice A) Surface real estate is not limiting in this way, and the display carried by all nucleated cells is loaded from a separate internal supply of chopped up cytosolic protein. Recognition of cells harbouring an intracellular parasite would continue unchanged.

(Choice C) Carrying a display molecule does not confer the ability to engulf anything. Ingestion depends on the cytoskeletal machinery and surface receptors of a phagocyte, none of which this mutation supplies, so engulfment rates across the body would not change.

(Choice D) This assigns the wrong lymphocyte population to the display in question. The lymphocytes that kill on contact inspect the display loaded from proteins made inside the cell; the molecule described in the stem engages the lymphocytes that issue permission signals, so the harm would arrive by way of misdirected licensing rather than by immediate contact killing.

This is a Scientific Reasoning and Problem Solving question because it asks the student to predict the systemic consequence of lifting a restriction on which cells are permitted to carry out one step of antigen presentation.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$surface competition between the two displays$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$phagocytosis capacity conflated with display capacity$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$lymphocyte populations swapped between the two displays$q$ FROM q;

-- B2 Q7 . Reading Fragment Origin from an Assay . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Reading Fragment Origin from an Assay$q$,
    $q$Four cultured preparations were matched for the total amount of one bacterial antigen present, then mixed with lymphocytes from a donor previously exposed to that bacterium. Preparations 1 and 3 used a skin cell line; preparations 2 and 4 used macrophages. In 1 and 2 the antigen was built inside the cell from an engineered gene; in 3 and 4 the whole antigen was placed in the culture and had to be brought in.

| Preparation | Cell type | How the antigen arose | Direct lysis of matched targets (% of maximum) | Soluble permission signal (units) |
|---|---|---|---|---|
| 1 | skin cell line | built inside | 84 | 3 |
| 2 | macrophage | built inside | 79 | 5 |
| 3 | skin cell line | placed in culture | 6 | 4 |
| 4 | macrophage | placed in culture | 5 | 72 |

Which conclusion do the four sets of readings together support?$q$,
    $q$[{"label":"A","text":"Only one of the two cell types can put externally acquired fragments on view, so the response to swallowed matter depends on which cell handled it rather than on how much was supplied."},{"label":"B","text":"Preparation 3 received too little antigen to fill enough binding sites, so the gap between 3 and 4 reflects quantity rather than cell type."},{"label":"C","text":"The skin cell line cannot degrade protein that it has taken in, so nothing at all reaches its outer face."},{"label":"D","text":"Antigen built inside a cell drives the soluble permission signal, whereas antigen brought in from outside drives direct lysis."}]$q$::jsonb,
    'A',
    $q$This Organ Systems item tests antigen presentation as read from experimental data, specifically what decides whether material taken in from outside can be shown at all. The answer is A because the two preparations that received the whole antigen in the culture differ only in the cell used, and only the macrophage produced a permission signal above background. The three other preparations sit at 3, 4 and 5 units, so 72 units in preparation 4 is the single readout that rises at all, and the only variable that changed between the third and fourth rows is cell type. The first two rows then rule out the idea that the skin line is simply inert, because when the same antigen was built inside it the lysis readout reached 84 percent of maximum. Taken together, the readings say that material generated within any nucleated cell can be shown by that cell, whereas material brought in from the surroundings can be shown only by the restricted set of cells, and it is that restriction, not the antigen and not the amount, that settles which lymphocyte population is engaged.

(Choice B) The stem states that the total amount of antigen was matched across preparations, so a shortfall cannot be the explanation. Preparations 3 and 4 also received their antigen by the same route and in the same amount, yet only one of them gave any signal, so the difference tracks the cell used rather than the quantity supplied.

(Choice C) The skin line plainly does break protein down and display the products, since preparation 1 produced a strong lysis readout. What it lacks is the route that carries externally derived pieces to the surface, not the ability to degrade protein at all, so the claim overreaches.

(Choice D) This states the relationship backwards. Antigen built inside the cell was followed by high lysis in preparations 1 and 2 with no permission signal above background, while antigen taken in by macrophages produced 72 units of permission signal with lysis no higher than background.

This is a Data-based and Statistical Reasoning question because it asks the student to hold the supplied amount constant across four readings, isolate the one variable that changed between the informative rows, and state what the resulting pattern can and cannot support.$q$,
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
  SELECT q.id, 'B', 'scale_unit_error', $q$amount limitation invoked against a controlled amount$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$one blocked route generalised to all display$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$origin and readout swapped$q$ FROM q;

-- B2 Q8 . Control Arm for a Display-Blocking Reagent . hard . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Control Arm for a Display-Blocking Reagent$q$,
    $q$Macrophages are cultured with intact antigen X, then mixed with lymphocytes from a donor previously exposed to that antigen, and the soluble permission signal is measured. In one arm, a reagent that sits tightly over the surface structure these cells carry in addition to the one present on every nucleated cell is added first; the reagent does not reduce viability. Signal in that arm falls to background, while direct killing of separately infected targets by the same lymphocyte population is unaffected. The investigator concludes that the covered structure is the one that puts swallowed material on view. Which further arm would most strengthen that conclusion?$q$,
    $q$[{"label":"A","text":"Showing that the reagent also stops the cells from taking antigen X in, since a structure that displays swallowed material must be the same one that carries it inward."},{"label":"B","text":"Repeating the arm with cells whose internal digestive compartments have been prevented from fusing, to confirm that degradation precedes display."},{"label":"C","text":"Repeating the untreated arm with lymphocytes from a donor never exposed to that antigen, to show that the signal requires prior encounter."},{"label":"D","text":"Repeating the treated arm with short peptides already cut from X, which bypass uptake and processing and should still give nothing if the binding groove itself has been masked."}]$q$::jsonb,
    'D',
    $q$This Organ Systems item tests the design of an antigen presentation experiment, specifically the control needed before one can say what a blocking reagent actually interfered with. The answer is D because the observed loss of signal has two live explanations and this arm separates them. The reagent may be lying across the cleft where ingested pieces are held, which is what the investigator claims, or it may simply be preventing the cells from taking antigen X in or from moving it through the internal compartments where it is cut up. Short peptides that have already been cut need neither of those steps, since they can settle directly into an exposed cleft on the outer face. If the arm given pre-cut peptides still yields background, the ingestion route cannot be the explanation and the cleft itself must be covered. If instead the pre-cut peptides restore the signal, the reagent was acting upstream and the original conclusion fails, which is exactly what makes this a discriminating arm rather than a confirming one.

(Choice A) This would weaken rather than strengthen the conclusion, and it rests on a false premise: the structure that holds a fragment on the surface is not the receptor that draws material into the cell. Demonstrating that ingestion had also stopped would leave the investigator unable to say which step the reagent affected.

(Choice B) Preventing internal digestive compartments from fusing tests whether degradation must precede display, a point already accepted and not in dispute here. That arm would fail for reasons wholly unrelated to the reagent, so it says nothing about where the reagent acts.

(Choice C) Lymphocytes from a donor with no prior exposure address the specificity of the responding population, which is a legitimate control for a different claim. Specificity was never in doubt in this experiment, and the arm cannot distinguish a covered cleft from interrupted ingestion.

This is a Reasoning about the Design and Execution of Research question because it asks the student to select the arm that separates two competing explanations for the same loss of measured output.$q$,
    'hard',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    3,
    105
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$display molecule conflated with uptake receptor$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', $q$degradation step tested instead of the display step$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$specificity control offered for a localisation claim$q$ FROM q;

-- B2 Q9 . Population Value of MHC Allele Diversity . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Population Value of MHC Allele Diversity$q$,
    $q$Human MHC loci carry hundreds of alleles each, and the protein made from one allele binds a set of short peptides that the protein made from another allele cannot hold. Two unrelated people therefore almost never carry matching sets, which is why organ donation is so often blocked. What advantage does this arrangement give the human population, despite the cost to transplant surgery?$q$,
    $q$[{"label":"A","text":"A person carrying two unlike alleles at one locus makes a single combined protein that holds peptides neither version could hold alone."},{"label":"B","text":"The variety lets a person switch on previously silent alleles as unfamiliar infections appear during the course of life."},{"label":"C","text":"Lymphocyte binding sites are generated in enormous variety before any antigen is met, so some cell can bind almost any invader."},{"label":"D","text":"A microbe that slips past surveillance in one individual is still caught in many others, so no single pathogen can defeat the whole species."}]$q$::jsonb,
    'D',
    $q$This Organ Systems item examines the major histocompatibility complex and the reason its extreme allelic diversity is maintained. The answer is D because a wide spread of alleles guarantees that whatever short peptides a novel microbe generates, some members of the species will own a molecule capable of gripping those peptides and showing them to lymphocytes. Presentation is a matching problem: each MHC protein carries a binding pocket with its own chemical preferences, so a given peptide is held well by some versions and poorly by others. If everyone carried an identical version, a microbe whose peptides happened to fit that version badly would go undisplayed in every host, and the adaptive response, which cannot begin until a fragment is shown to a lymphocyte, would fail across the board. Diversity spreads that risk across many hosts, so selection preserves the pool even when particular hosts die. The cost falls on transplant medicine, where the same variability makes it improbable that any two unrelated people carry the same set.

(Choice A) Alleles at a given locus are expressed codominantly, so a heterozygote makes two separate proteins, one specified by each allele. The chains do not fuse into a novel hybrid pocket with a new specificity; the benefit of heterozygosity is simply owning two pockets rather than one, which is a different claim from the one made here.

(Choice B) Which alleles a person carries is fixed at fertilization, and those alleles are expressed constitutively rather than held in reserve and switched on to suit the infection of the moment. The benefit under discussion accrues across many hosts over evolutionary time, not within a single lifetime.

(Choice C) Lymphocyte binding sites are indeed generated in enormous variety before any antigen is encountered, and that diversity is what makes clonal selection workable. It is a true statement about a separate source of variation, produced independently of which MHC alleles a person inherited, so it does not explain why the MHC loci themselves are so variable between people.

This is a Knowledge of Scientific Concepts and Principles question because it asks the student to recall that an adaptive response cannot begin until a peptide is held and displayed, and then apply that requirement to a whole population rather than to one host.$q$,
    'easy',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    1,
    70
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$hybrid-molecule fallacy$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$inducible alleles within a lifetime$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$correct fact, wrong source of diversity$q$ FROM q;

-- B2 Q10 . Nonself Recognition of Grafted Tissue . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Nonself Recognition of Grafted Tissue$q$,
    $q$A man receives a kidney from an unrelated donor. Nothing can be cultured from the organ or from his blood, yet two weeks later a biopsy shows it crowded with his own lymphocytes and the tissue is failing. Which feature of the transplanted cells accounts for the attack?$q$,
    $q$[{"label":"A","text":"The graft cells have lost the surface markers that healthy cells normally show, so they read as damaged."},{"label":"B","text":"Their peptide-holding surface proteins are encoded by alleles that his own genome lacks, so the proteins are themselves read as nonself."},{"label":"C","text":"The graft carries proteins he has never met before, and any unfamiliar protein provokes an attack no matter how it is encountered."},{"label":"D","text":"The surgery itself injures the graft, and the debris released recruits the fast, nonspecific arm of defence."}]$q$::jsonb,
    'B',
    $q$This Organ Systems item examines self versus nonself discrimination as it applies to grafted tissue. The answer is B because the peptide-holding surface proteins of the graft are themselves products of alleles absent from the recipient, so the display apparatus, not merely the fragment it carries, is what reads as nonself. Students often assume an immune attack requires an invader, but the adaptive system does not test for pathogenicity; it tests for combined shapes that the maturing lymphocyte pool was never taught to ignore. A lymphocyte scans the composite formed by a display protein together with whatever fragment sits in its cleft, so a donor whose display proteins differ in the residues lining that cleft presents an enormous number of unfamiliar composites at once. This is true even though every fragment on show comes from an entirely ordinary housekeeping protein of the graft. The result is a fast, specific, and clinically useless adaptive response, and because these display molecules are the principal cause of graft rejection, they are named for tissue compatibility in the first place.

(Choice A) This inverts the trigger. Rejection follows the presence of unfamiliar display molecules, not their absence. Loss of surface display is a real signal that marks a cell as abnormal in other settings, but graft cells display abundantly; that display is simply the wrong version for this recipient.

(Choice C) This is correct as far as it goes and then fails on a decisive point. Unfamiliar donor proteins do exist, but a lymphocyte of this lineage cannot see an intact protein floating free; it responds only to a processed fragment held in a display molecule on a cell surface. Dropping that requirement removes the very step that makes mismatched display molecules the dominant target.

(Choice D) Surgical injury genuinely does recruit the rapid, nonspecific arm of defence, and some inflammation follows any operation. That mechanism is not tailored to a particular donor, however, and it would not produce a graft packed with lymphocytes that progressively destroy the tissue over weeks, so it is a true statement about a different process.

This is a Scientific Reasoning and Problem Solving question because it asks the student to explain a specific adaptive response in a sterile patient by identifying what, in the absence of any pathogen, the responding cells could have recognized as nonself.$q$,
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
  SELECT q.id, 'A', 'reversed_relationship', $q$absence rather than mismatch$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$free protein seen directly$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$innate injury response substituted for adaptive rejection$q$ FROM q;

-- B2 Q11 . Designing a Donor Compatibility Culture . hard . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Designing a Donor Compatibility Culture$q$,
    $q$A transplant laboratory screens candidate donors for a patient who needs a kidney. For each candidate, white cells drawn from the patient are cultured together with white cells drawn from that candidate for five days, and the total amount of newly made DNA in the well is measured at the end. Vigorous new DNA synthesis is scored as a strong reaction against the candidate, and candidates yielding the least synthesis are ranked as most suitable. Which of the following must the protocol include for that ranking to be valid?

I. A step that stops the candidate's cells from dividing, so that the DNA measured can be assigned to one side of the mixture.
II. A well holding the patient's cells with no second party added, to establish how much division occurs anyway.
III. A well holding cells from one of the patient's siblings in every run, so that candidates can be scored against a known match.$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"II only"},{"label":"C","text":"I, II, and III"},{"label":"D","text":"I and II only"}]$q$::jsonb,
    'D',
    $q$This Organ Systems item examines the design of an assay that reads compatibility from the proliferation of lymphocytes placed together. The answer is D because the readout is only interpretable if the dividing cells can be attributed to one party and if the division seen without any second party is known. Item I is required: if both populations remain able to divide, each side responds to the other and the pooled DNA signal cannot be assigned to the patient's response, which is the quantity that predicts what will happen to a graft in that patient. Item II is required because lymphocytes in culture divide to some degree regardless of stimulus, and without that floor there is no way to say that a low reading reflects compatibility rather than a poorly performing culture. Item III fails on a specific genetic point: a sibling is not a known match. Each person inherits one set of these linked loci from each parent, so two siblings have roughly a one in four chance of receiving the same pair, which is far better than the odds for an unrelated donor but nowhere near certainty, and a sibling therefore cannot serve as a fixed reference point.

(Choice A) Correct as far as it goes. Blocking division on one side does make the signal attributable, but with no unstimulated well the laboratory has no baseline, so it cannot tell a genuinely low response from a culture in which little was going to happen in any case.

(Choice B) Also incomplete, and in the more damaging direction. A baseline well without the essential blocking step leaves every experimental value derived from a two-way exchange, so a large reading might reflect the candidate reacting to the patient rather than the reverse.

(Choice C) This adds a requirement that is not one. Including a sibling would be informative only if siblings matched reliably, which they do not, so building the ranking on that comparator would introduce error rather than control it.

This is a Reasoning about the Design and Execution of Research question because it asks the student to decide which manipulation and which control a mixed culture must contain before its output can be read as a measure of donor mismatch.$q$,
    'hard',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    3,
    105
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$one necessary element recognized, one dropped$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$control kept, manipulation dropped$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$true tendency treated as a fixed standard$q$ FROM q;

-- B2 Q12 . Tolerance to Self Peptides in MHC . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Tolerance to Self Peptides in MHC$q$,
    $q$At any moment most of the peptides sitting in a cell's MHC molecules are pieces of that cell's own everyday proteins, and healthy tissue is left alone. In one woman, the lining of several joints is being steadily destroyed by lymphocytes that bind a normal, unmodified joint protein held in MHC on the cells there. Which requirement of the healthy system has broken down in her?$q$,
    $q$[{"label":"A","text":"MHC molecules on her joint cells should hold only material brought in from outside those cells, and hers are holding pieces made within them."},{"label":"B","text":"Healthy cells normally keep their own peptides out of MHC entirely, and hers have begun loading them."},{"label":"C","text":"During maturation, any clone able to lock onto an unaltered body component is culled, and one such clone escaped."},{"label":"D","text":"Her lymphocytes are being activated at the site of injury rather than first encountering the antigen in a lymphoid organ, so a stage has been skipped."}]$q$::jsonb,
    'C',
    $q$This Organ Systems item examines self versus nonself recognition and the origin of autoimmune disease. The answer is C because tolerance is not achieved by hiding the body's own fragments from display but by editing the responding population so that no surviving clone binds strongly to a fragment of the body itself. Display is indiscriminate: a cell chops up whatever proteins it contains and shows the pieces, so in an uninfected person almost everything on show is self. Safety therefore has to be built into the other half of the interaction. As lymphocytes of this lineage mature, those whose binding sites engage a body-derived fragment held in the body's own display molecule are removed by programmed cell death, leaving a repertoire that reacts only when something unfamiliar occupies the cleft. When a clone with self-directed specificity survives that editing and later meets its target, the machinery works exactly as designed and destroys healthy tissue, which is what autoimmune disease is. Working backwards from the outcome described, the display side is functioning normally and the failure must lie in the editing of the repertoire.

(Choice A) This reverses the sampling rule. The display found on essentially every nucleated cell exists precisely to show fragments of proteins made inside that cell, which is how an infected cell advertises what it is manufacturing. Showing internally made pieces is normal function, not pathology.

(Choice B) This states the common but incorrect belief that self peptides are excluded from display. In an uninfected person the great majority of occupied clefts hold self material, and this is exactly why tolerance has to be enforced on the responding cells instead.

(Choice D) This names the wrong stage of the response. Encounter with antigen in a lymphoid organ and subsequent action in the tissue are ordinary sequential steps of a normal adaptive response, and an unusual order of events would not by itself create specificity for a body constituent. The defect here concerns which clones exist at all, not where they were switched on.

This is a Scientific Reasoning and Problem Solving question because it asks the student to start from a destructive clinical outcome and infer which of two separable safeguards, indiscriminate display or edited repertoire, must have failed.$q$,
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
  SELECT q.id, 'A', 'reversed_relationship', $q$inside versus outside sampling reversed$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$self peptides never presented$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$activation site substituted for repertoire editing$q$ FROM q;

-- B2 Q13 . Display Requirement for T Lymphocyte Recognition . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Display Requirement for T Lymphocyte Recognition$q$,
    $q$A soluble binding protein in blood grips an intact bacterial toxin as it drifts through the interstitium and blocks it there. A T lymphocyte with the same binding specificity ignores that free toxin completely, and engages only after a body cell has chopped the toxin up and set the pieces in its own surface display. What does this stricter rule buy the body?$q$,
    $q$[{"label":"A","text":"The binding site can then grip a far broader chemical range than a soluble binder ever could, including whole folded shapes."},{"label":"B","text":"It ensures the toxin is neutralised before it reaches the tissue it would injure."},{"label":"C","text":"It assigns the lymphocyte to threats that are still outside cells and leaves the soluble binder to handle threats already sitting inside them."},{"label":"D","text":"Reactivity becomes conditional on a cell having taken up or manufactured the offending material, so the ensuing action is aimed at one identified cell rather than at the fluid around it."}]$q$::jsonb,
    'D',
    $q$This Organ Systems item tests antigen presentation as the precondition for adaptive cellular recognition. The answer is D because making the trigger a processed fragment held in a cell's own display converts recognition into a statement about one particular cell rather than about the extracellular pool, so whatever the lymphocyte does next lands on that cell. A free binder and a T lymphocyte are built for different jobs. The free binder must find its quarry anywhere in solution, so it grips whole native shapes wherever they happen to drift, and its useful output is simply to coat or block. The lymphocyte's output is always directed at a cell: either it destroys one that is building something foreign, or it authorises one that has swallowed something foreign to escalate. A trigger that fires only once a cell has processed and posted material therefore functions as an address, naming which cell needs the attention. There is a second payoff: the fragments on show are drawn from the inside of that cell, the one compartment a free binder can never sample, so an organism that hides indoors is still reported to the outside world.

(Choice A) The rule narrows the chemical range rather than widening it. Only short processed pieces fit the groove of the presenting protein, whereas a binder working in solution can engage intact envelopes, sugars and folded conformations that would not survive processing at all.

(Choice B) Stopping the toxin before it reaches its tissue is the contribution of the free binder described in the stem, not the payoff of the cell bound rule. It answers a different question, and it does not explain why a lymphocyte should refuse a molecule it is perfectly capable of gripping.

(Choice C) This reverses the division of labour. The cell bound rule is precisely what points the lymphocyte at material a cell has already internalised or synthesised, while binders circulating in body fluids are the arm that works on what is still loose outside cells.

This is a Knowledge of Scientific Concepts and Principles question because it asks the student to state what the presentation requirement accomplishes for an effector whose output must be delivered to a single cell.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$presentation broadens rather than narrows the recognisable chemistry$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', $q$true of the soluble binder, irrelevant to the lymphocyte rule$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', $q$inside and outside assignments swapped$q$ FROM q;

-- B2 Q14 . Loss of the Signal Releasing T Lymphocyte Population . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Loss of the Signal Releasing T Lymphocyte Population$q$,
    $q$A child inherits a defect that leaves the T lymphocyte population which releases soluble licensing signals absent from blood and lymph nodes. The population that destroys a displaying target by direct contact is present at normal frequency, and macrophages, other phagocytes and B lymphocytes are all normal in number. Which of the following would be expected to fall below normal in this child?

I. Antibody output against a protein antigen met for the first time
II. Accumulation of phagocytes at a splinter wound over the first few hours
III. Destruction of bacteria that macrophages have already engulfed$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"I and II only"},{"label":"C","text":"I and III only"},{"label":"D","text":"I, II and III"}]$q$::jsonb,
    'C',
    $q$This Organ Systems item tests the division of labour between the two T lymphocyte populations and the boundary between innate and adaptive control. The answer is C because the absent population is the source of the soluble permissions that a B lymphocyte needs before it will produce antibody against a protein antigen and that a macrophage needs before it raises its internal killing power, while the gathering of phagocytes at fresh damage is driven by innate mediators released at the injury itself. Item I is therefore reduced: an antibody response to a protein antigen is a two cell event, in which the B lymphocyte binds antigen, ingests it, displays fragments in the second kind of display molecule, and only then receives the soluble go ahead. With that go ahead missing, the B lymphocyte stalls even though it is present and specific. Item III is also reduced, because a macrophage that has engulfed a resistant organism frequently cannot finish it off unaided; the soluble signal is what upgrades its internal machinery. Item II is intact, since recruitment within hours of a splinter is set in motion by mediators from damaged tissue and resident phagocytes, none of which depend on adaptive licensing.

(Choice A) This captures the antibody defect but stops short. It treats the missing population as an assistant to B lymphocytes only, when its other documented client is the macrophage, whose killing of already engulfed organisms is raised by the same soluble output.

(Choice B) This swaps the affected macrophage function for an innate one. Arrival of phagocytes at a fresh wound within hours precedes any adaptive involvement and proceeds in people who lack adaptive lymphocytes entirely.

(Choice D) This extends adaptive dependence to an event that is under local innate control. Early recruitment is triggered at the injury itself, so it does not belong in the list with the two adaptive dependent items.

This is a Scientific Reasoning and Problem Solving question because it asks the student to take a single missing cell population and sort three downstream events by whether each one requires adaptive licensing.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    95
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$correct on antibody help, blind to macrophage upgrading$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', $q$an early innate step credited to a later adaptive stage$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$every inflammatory event treated as adaptively licensed$q$ FROM q;

-- B2 Q15 . Pairing Display Type to Effector Function . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Pairing Display Type to Effector Function$q$,
    $q$Airway lining cells can support the growth of a virus but never engulf outside debris; they carry only the display found on every nucleated cell. In an engineered mouse, that display is deleted from the airway lining alone. Macrophages keep both of their displays and still deliver fragments of the virus to the draining lymph node. Over the following week the mouse builds both T lymphocyte populations at the usual frequency and with the correct specificity. What follows in the infected airway?$q$,
    $q$[{"label":"A","text":"Contact killing fails at the site of copying, because the effector has no readable account of what is being built inside those cells, even though priming in the node succeeded."},{"label":"B","text":"The lining cells are destroyed anyway, since a body cell that has lost that display is itself read as abnormal and struck down by the same contact dependent lymphocyte."},{"label":"C","text":"Antibody output against the virus collapses, because the soluble authorisations that drive it are released only once the universal display has been engaged."},{"label":"D","text":"Killing proceeds on schedule, because the lymphocyte reads whole viral proteins sitting in the plasma membrane of the affected cell and does not need any display."}]$q$::jsonb,
    'A',
    $q$This Organ Systems item tests why each T lymphocyte population is paired with a different display molecule, and what that pairing accomplishes. The answer is A because the two displays serve two separate stages: the one restricted to ingesting cells starts the response in lymphoid tissue, while the one carried by every nucleated cell is how an ordinary body cell reports its internal contents to the population that kills by touch. Deleting the second display from the airway removes the report without touching the start. Macrophages still ferry antigen to the node, so both populations are raised on schedule, exactly as the stem states. But when the trained contact killer reaches the airway it finds cells that present nothing at all, and since its whole engagement rule is to bind a fragment seated in that display, it cannot tell an infected lining cell from a healthy one. The virus therefore continues to be made in a compartment that has gone dark to this effector. This is the reason the pairing exists: every nucleated cell must be readable, or an intracellular resident could simply pick a tissue that does not ingest anything and never be reported. Some viruses exploit precisely this by lowering that display on the cells they occupy.

(Choice B) Being struck down for having lost the display is a real defence, but it belongs to a different sentinel lineage that treats absence of the display as the alarm. The contact dependent T lymphocyte works the opposite way: it must physically engage a fragment held in a display, so a bare cell is invisible to it.

(Choice C) The direction is inverted. Soluble authorisations come from the population that reads the display restricted to ingesting cells, and macrophages retain both displays in this animal, so antibody responses have the input they need.

(Choice D) A lymphocyte that read intact viral proteins in the membrane would need no presentation at all, which is the recognition style of a soluble binder rather than of a T lymphocyte. Presentation of a processed fragment is the only way this effector engages a target.

This is a Scientific Reasoning and Problem Solving question because it asks the student to take an engineered deletion and infer which stage of the response, initiation or execution, is the one that fails.$q$,
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
  SELECT q.id, 'B', 'adjacent_fact', $q$missing display alarm attributed to the wrong lineage$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', $q$the two displays swapped between the two populations$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$T lymphocyte pictured recognising native surface protein$q$ FROM q;

-- B2 Q16 . Interpreting a Matched Display Killing Assay . medium . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Interpreting a Matched Display Killing Assay$q$,
    $q$Lymphocytes that kill by touching their quarry were taken from a mouse of display variant m that had recovered from virus P. Portions of the same preparation were mixed with four sets of cells, and the percentage of each set destroyed was recorded over six hours. All sets were plated at equal density.

| Cell set | Display variant | Carrying | 2 h | 4 h | 6 h |
| --- | --- | --- | --- | --- | --- |
| W | m | virus P | 12 | 41 | 68 |
| X | n | virus P | 2 | 3 | 4 |
| Y | m | none | 1 | 3 | 3 |
| Z | m | virus Q | 2 | 4 | 5 |

What do the four time courses together establish?$q$,
    $q$[{"label":"A","text":"The killers act on the virus itself, and set X escaped because it was carrying fewer viral particles than set W."},{"label":"B","text":"Attack requires both a piece of the infecting agent and a matched version of the presenting molecule; either one on its own leaves the cell intact."},{"label":"C","text":"Sharing the display variant is what licenses attack, since the one set that resisted throughout was the set carrying the other variant."},{"label":"D","text":"The variant difference only slows the process, so set X would reach set W's level if the six hours were extended."}]$q$::jsonb,
    'B',
    $q$This Organ Systems item tests antigen presentation and binding specificity through a killing time course. The answer is B because the four sets form a two by two design, and only the set that shares both features with the source animal is destroyed. Set W shares the variant and carries the agent the source animal had met, and it climbs from 12 to 68 percent. Set X carries the same agent but the other variant, and stays at background. Set Y shares the variant but carries nothing, and stays at background. Set Z shares the variant and carries a different agent, and stays at background. Comparing W with X isolates the variant while holding the agent constant; comparing W with Y and Z isolates the agent while holding the variant constant. Each comparison collapses the response, so neither feature is sufficient by itself and both are necessary together. That is the signature of an effector that binds a processed fragment seated in a particular presenting protein, so the fragment alone and the protein alone are both invisible to it.

(Choice A) Nothing in the design allows a claim about how much agent each set carries; sets W and X were prepared with the same agent, and the only stated difference between them is the variant. Invoking an unmeasured difference in load also fails to explain why sets Y and Z, which share the variant, were spared.

(Choice C) The variant clearly matters, but the claim that it is sufficient is refuted within the same table. Sets Y and Z carry the identical variant to set W and remain at three and five percent, so variant sharing without the right fragment produces nothing.

(Choice D) The trend argues against a slower version of the same process. Set W is already at 41 percent by four hours and accelerating, while set X moves from 2 to 4 percent across the whole run, a flat background drift rather than a delayed rise.

This is a Data-based and Statistical Reasoning question because it asks the student to compare four matched time courses and decide which combination of variables is necessary for the outcome.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$killer pictured as binding free virus, plus invented load difference$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$variant treated as sufficient rather than necessary$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'scale_unit_error', $q$a categorical block reinterpreted as a slower rate on a longer timescale$q$ FROM q;

-- B2 Q17 . Two Screens During Lymphocyte Maturation . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Two Screens During Lymphocyte Maturation$q$,
    $q$In one mouse strain, developing lymphocytes inside the site where they are screened meet the animal's own display molecules normally, but peptide fragments belonging to distant tissues are never carried into that site. Cells finish screening and leave for the bloodstream in normal or slightly greater numbers than usual. What outcome is most probable in these animals?$q$,
    $q$[{"label":"A","text":"Cells exiting the site cannot engage the display molecule on any body cell, so this arm of defence never operates."},{"label":"B","text":"A first meeting with a pathogen proceeds normally, but no accelerated reaction follows a repeat meeting."},{"label":"C","text":"Cells entering circulation are prone to causing autoimmune destruction of otherwise unharmed body structures."},{"label":"D","text":"Every self-reactive cell that reaches the blood is destroyed on its first contact with a body cell, so tissue damage cannot occur."}]$q$::jsonb,
    'C',
    $q$This item falls under Organ Systems and tests self versus nonself recognition, specifically what a developing lymphocyte must prove during maturation before it is licensed to circulate. The answer is C because a cell whose binding site happens to fit a tissue that was never sampled at the screening site was never given an opportunity to fail the tolerance test against that tissue, so it survives and leaves armed against the animal itself. Maturation poses two logically separate questions. The first asks whether the young cell can engage the organism's own display molecules at all; since every antigen this lineage will ever see must be handed to it on such a display, a cell that cannot dock there is useless and is eliminated. The second asks whether the cell reacts strongly to fragments of the organism's own proteins; a cell that does react is dangerous and is likewise eliminated. In the strain described, the first question is still posed and answered, because the display molecules are present and cells graduate in at least their usual numbers. The second question, however, is posed only about the proteins that happen to be available at that location. Specificities directed at tissues whose peptides never arrive are never challenged, so they slip through a screen that only appears to have run, and the modest excess of graduates is itself the signature of deletions that failed to happen. The predicted result is not global immune failure but a targeted attack on the very tissues that went unrepresented. (Choice A) Inability to dock onto the display molecule is the failure mode of the screen that is still intact here, and that failure would sharply reduce the number of graduating cells rather than leave it normal or slightly raised, which the stem rules out. (Choice B) A weakened reaction on second exposure concerns whether a long-lived responder population is laid down after a first encounter, a separate matter that this manipulation does not touch. (Choice D) A backup does exist once cells reach the periphery, but it is neither absolute nor automatic: it depends on a self-reactive cell meeting its target under conditions that withhold the extra licensing input, and plenty of self-reactive cells escape it. The stated certainty that damage cannot occur is what makes this choice fail. This is a Scientific Reasoning and Problem Solving question because it asks the student to disable one of two developmental screens and predict the specific, tissue-restricted failure of self versus nonself recognition that follows.$q$,
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
  SELECT q.id, 'A', 'process_step_confusion', $q$wrong stage of a two-stage process$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', $q$true statement about a different immune property$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$real safeguard stated as an absolute$q$ FROM q;

-- B2 Q18 . Prebuilt Repertoire and First Response Lag . easy . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Prebuilt Repertoire and First Response Lag$q$,
    $q$A person encounters a bacterial protein for the first time. Defence aimed precisely at that protein becomes measurable only after several days, even though cells able to bind the protein were already stocked in the body at the moment of exposure. What accounts for the lag?$q$,
    $q$[{"label":"A","text":"Any one binding shape is carried by only a handful of cells, and many rounds of division are needed until that clone is numerous enough to act."},{"label":"B","text":"The fit to that protein is manufactured only after the protein arrives, and shaping a new receptor takes days."},{"label":"C","text":"The protein must first be ferried to a filtering lymphoid organ, and that journey occupies most of the interval."},{"label":"D","text":"The interval corresponds to the time a single responding cell needs to complete one round of copying itself."}]$q$::jsonb,
    'A',
    $q$This item falls under Organ Systems and tests clonal selection, in particular what a repertoire assembled in advance predicts about the timing of a first response. The answer is A because the only way to hold enough distinct receptor shapes to cover an unpredictable world is to keep each individual shape at extremely low abundance, and that low starting abundance is precisely what forces a delay while the matching cells multiply. The body cannot know in advance which shapes it will need, so it generates an enormous library of them ahead of any encounter, on the order of a hundred billion different specificities. That library must fit inside a finite pool of circulating cells, so arithmetic alone dictates that each single specificity is represented by only a tiny fraction of the pool. When an antigen finally appears it does not instruct a cell to construct a fit; it simply picks out the rare cells that already fit and drives them to proliferate. Repeated doublings over several days are required before that rare founding population becomes large enough to produce a measurable effect. The same logic explains why a later encounter with the identical antigen is fast: the matching population has already been expanded and no longer starts from scarcity. (Choice B) This is the custom-built-on-demand model that clonal selection replaced. The stem states that cells able to bind were already stocked, so no construction step remains to be carried out. (Choice C) Delivery of antigen to a filtering lymphoid organ is real and does consume time, but that transit is measured in hours rather than days, and it cannot explain why the delay largely disappears on re-exposure to the same antigen. (Choice D) This identifies expansion as the cause but places it at the wrong magnitude of time. A responding lymphocyte completes a cycle in hours, not days, which is why the delay reflects many successive cycles rather than one. This is a Scientific Reasoning and Problem Solving question because it asks the student to reason from the size of a pre-existing repertoire to the scarcity of any one specificity and then to the timing of a first response.$q$,
    'easy',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    65
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'misconception', $q$instructional rather than selective model$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$real step that is too small to explain the effect$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'scale_unit_error', $q$right mechanism, wrong timescale$q$ FROM q;

-- B2 Q19 . Testing Necessity of a Licensing Contact . medium . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Testing Necessity of a Licensing Contact$q$,
    $q$A researcher asks whether engagement of a displayed fragment is on its own enough to drive a resting lymphocyte into division. Lymphocytes cultured with cell line P, which carries the fragment and a full set of surface proteins, divide vigorously. The same lymphocytes cultured with line Q, identical to P except that it lacks one surface protein, do not divide at all. A colleague objects that line Q may simply be placing fewer fragments on its outer face. Which further condition would settle the objection?$q$,
    $q$[{"label":"A","text":"Repeat the run with line P across a series of fragment densities to show that division tracks how much is on offer."},{"label":"B","text":"Repeat the pairing with line Q while supplying a soluble molecule that stands in for the absent membrane component."},{"label":"C","text":"Add a well containing only the resting cells, with neither line present."},{"label":"D","text":"Draw the resting cells from an animal that has never met the fragment previously."}]$q$::jsonb,
    'B',
    $q$This item falls under Organ Systems and tests reasoning about experimental design, applied to the claim that antigen recognition alone is insufficient to activate a lymphocyte. The answer is B because a rescue condition is the only listed manipulation that separates the two competing explanations for line Q's failure. The colleague's objection is a confound: line Q differs from line P in the intended way, but it might also differ in an unintended way, namely how densely it decorates its outer face with fragment. If the loss of division were caused by too little fragment, then restoring the missing surface component in trans, without touching fragment density, would leave the cultures still quiescent. If instead the loss were caused by absence of a second, licensing engagement, then restoring that engagement while fragment density remains exactly as it was should bring division back. A single result therefore discriminates between the hypotheses, which is what a control must do. Note also that the rescue reagent is deliberately chosen so that it cannot itself alter presentation, keeping the comparison to one variable. (Choice A) A dose series on line P establishes that the response is graded with the amount presented, which is useful background but says nothing about line Q, and it therefore leaves the confound exactly where it was. (Choice C) A cells-only well is a necessary baseline for defining spontaneous division, and its absence would weaken the study, but it cannot distinguish sparse fragment on line Q from a missing licensing contact, since both hypotheses predict the same near-zero baseline. (Choice D) Prior exposure is irrelevant, because a lymphocyte's binding specificity is fixed before it ever meets its antigen; naive cells are in fact the standard starting material for such an assay, so this changes nothing about the confound. This is a Reasoning about the Design and Execution of Research question because it asks the student to identify the rescue condition that distinguishes a deliberate manipulation from an unintended difference between two cell lines.$q$,
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
  SELECT q.id, 'A', 'adjacent_fact', $q$informative experiment that misses the confound$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$necessary control that is not the discriminating one$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$exposure creates specificity$q$ FROM q;

-- B2 Q20 . Dose Response With Licensing Withheld . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Dose Response With Licensing Withheld$q$,
    $q$Resting lymphocytes were cultured with partner cells carrying a fragment on their outer face. In one set the partner cells also made a second engagement with the lymphocyte; in the other set that second engagement was interrupted by a reagent shown not to interfere with fragment binding. The table gives the percentage of lymphocytes entering division after three days.

| Fragment dose (arb. units) | Second engagement intact (%) | Second engagement interrupted (%) |
| --- | --- | --- |
| 0 | 1 | 1 |
| 1 | 12 | 1 |
| 10 | 38 | 2 |
| 100 | 61 | 2 |
| 1000 | 62 | 2 |

What do these results establish about the second engagement?$q$,
    $q$[{"label":"A","text":"The fragment supplies the permissive input and the second engagement supplies the specificity, since specificity disappears once that engagement is interrupted."},{"label":"B","text":"The second engagement lifts the ceiling of the response but leaves the dose needed for a half maximal response unchanged."},{"label":"C","text":"The second engagement is sufficient by itself, since cells enter division when it is present even with no fragment added."},{"label":"D","text":"The confirming input operates as an all or none permission step, because raising the amount on offer cannot compensate for its loss."}]$q$::jsonb,
    'D',
    $q$This item falls under Organ Systems and tests data-based reasoning about the requirement for a second, licensing input beyond antigen recognition alone. The answer is D because the interrupted column stays flat at background across a thousandfold range of fragment, which is the signature of a gate rather than of an amplifier. Compare the two columns as functions of dose. With the second engagement intact, the response is clearly graded: it climbs from 1 to 12 to 38 to 61 percent and then plateaus, exactly what a saturating recognition process looks like. With that engagement interrupted, the response never leaves background no matter how much fragment is offered, so the two conditions are not two points on one curve. If the second engagement merely added to or multiplied the recognition signal, enough fragment should eventually substitute for it, and the interrupted curve would simply be shifted or scaled. It is not. The functional reading is that recognition without confirmation yields inaction by design, which is precisely the safeguard the body needs: a lymphocyte that meets its target in the absence of corroborating evidence of danger must do nothing, or every encounter with a self fragment would become an attack. (Choice A) This reverses the roles of the two inputs. The dose response in the intact column is driven by fragment, showing that the fragment carries the specific information; the second engagement is uniform across doses and therefore cannot be what confers specificity. (Choice B) A pure ceiling effect would still permit a graded rise in the interrupted column at some dose, and it presumes a half maximal value that cannot be defined for a flat line at background. (Choice C) The zero-dose row settles this directly: with the second engagement intact but no fragment present, division sits at 1 percent, identical to background, so the engagement alone drives nothing. This is a Data-based and Statistical Reasoning question because it asks the student to compare the shapes of two dose response columns across a thousandfold range and infer that one input gates the other rather than adding to it.$q$,
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
  SELECT q.id, 'A', 'reversed_relationship', $q$roles of two signals exchanged$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$efficacy shift applied to a null curve$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$licensing signal treated as self-sufficient$q$ FROM q;

-- B2 Q21 . Collapse of Both Adaptive Arms Together . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Collapse of Both Adaptive Arms Together$q$,
    $q$A virus slowly destroys the lymphocyte subset that neither kills target cells on contact nor secretes soluble binding proteins, and whose only output is the signal that permits other cells to act. After several years almost none of that subset remains in an infected patient. Consider three defensive activities:

I. Destruction of the patient's own virus-infected cells by the lymphocyte lineage that kills on contact
II. Generation of antigen-specific soluble binding proteins against a newly encountered protein
III. Engulfment and digestion of bacteria by phagocytes arriving at a fresh wound

Which activities are expected to be substantially impaired?$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"II only"},{"label":"C","text":"I and II only"},{"label":"D","text":"I, II, and III"}]$q$::jsonb,
    'C',
    $q$Organ Systems: this item probes the boundary between innate defences and the two adaptive arms, and the dependence of both adaptive arms on a single lymphocyte population. The answer is C because the destroyed subset licenses both the contact-killing lineage and the lineage that secretes antigen-specific soluble binding proteins, whereas engulfment at a fresh wound is an innate function that no lymphocyte controls.

The subset described does no effector work of its own. Its product is permission: it inspects fragments displayed by cells that have taken up foreign material, and when the fit is right it releases signals allowing a second cell to divide and mature. Item I therefore fails, because the contact-killing lineage expands to useful numbers only after receiving that permission, so cells harbouring virus accumulate. Item II fails for the same structural reason: the cell that secretes soluble binding proteins against a protein must first display fragments of that protein and be inspected before it will proliferate. Item III does not fail, because a phagocyte arriving at a wound recognises broad molecular patterns shared by many groups of microbes, has no clonal specificity, and needs no lymphocyte permission to ingest and digest what it finds.

(Choice A) I only captures the cellular arm but stops there. It reflects a reading in which the lost subset supports only killing, whereas the reaction to a protein antigen depends on the very same permission step and fails alongside it.

(Choice B) II only captures the humoral arm alone, a common assumption because the licensing cell is usually introduced in the setting of antibody production. Direct killing of infected cells is licensed by that same subset and is lost as well.

(Choice D) I, II, and III treats the loss as total. Innate clearance is constitutive: phagocytes are produced in bone marrow, circulate continuously, and carry receptors for conserved microbial surface structures, so they act without any adaptive instruction. That is why a patient stripped of this subset still walls off ordinary wound bacteria while succumbing to organisms whose control requires adaptive specificity.

This is a Scientific Reasoning and Problem Solving question because it asks the student to sort three defensive activities by whether each one depends on adaptive licensing or runs on innate machinery that operates independently of any lymphocyte.$q$,
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
  SELECT q.id, 'A', 'partial_truth', $q$one-arm-only$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$one-arm-only$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$total-collapse$q$ FROM q;

-- B2 Q22 . Protein Versus Polysaccharide Antigen Dependence . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Protein Versus Polysaccharide Antigen Dependence$q$,
    $q$A child lacks the lymphocyte subset that neither kills on contact nor secretes soluble binding proteins, and whose only output is the permission signal other cells require. After immunisation she generates a normal quantity of specific soluble binding protein against a bacterial capsular polysaccharide, but almost none against a purified protein toxin. Which feature of the two immunogens accounts for the difference?$q$,
    $q$[{"label":"A","text":"Both immunogens require the same inspection step, but the toxin was given at a dose too low to trigger it."},{"label":"B","text":"Only one of the two must first be broken into fragments and displayed for inspection by the missing cells before the responding cell is allowed to proliferate."},{"label":"C","text":"The missing cells are themselves the source of circulating binding proteins, so any reaction that depends on them collapses."},{"label":"D","text":"The repeating, evenly spaced units of the polysaccharide keep its receptors from clustering, so no activating signal is delivered."}]$q$::jsonb,
    'B',
    $q$Organ Systems: this item tests why the molecular class of an antigen determines whether the humoral reaction needs a second lymphocyte to authorise it. The answer is B because a protein immunogen must be internalised, degraded, and returned to the surface of the responding cell for inspection, while a polysaccharide bypasses that requirement entirely.

The cell that secretes soluble binding proteins carries surface receptors of a single specificity, the outcome of clonal selection. A capsular polysaccharide is built from many identical units at regular spacing, so one molecule engages many receptors at once and delivers a strong direct signal; no third party is needed. A protein antigen presents each of its determinants only once or twice, so receptor engagement alone is too weak to commit the cell. The responding cell therefore swallows the protein, degrades it, and returns fragments to its own surface on a display molecule encoded in the major histocompatibility complex. The inspecting subset reads that display, confirms the fragment is nonself, and only then issues the signals that permit division and maturation. Remove the inspecting subset and the polysaccharide route is untouched while the protein route stops, which is exactly the pattern seen in this child.

(Choice A) Dose is not the variable at issue, and the first clause is false: the two immunogens do not share a common requirement. No quantity of extra toxin restores the reaction in someone lacking the inspecting cells, because what is missing is an authorising signal rather than an amount of antigen.

(Choice C) If the missing cells manufactured the circulating binding proteins themselves, no humoral reaction of any kind would survive their loss. The child mounts a full reaction to the polysaccharide, which rules this out and places the deficit in authorisation rather than in production; the secreted proteins come from the mature descendants of the responding lymphocyte itself.

(Choice D) The repeating architecture of a polysaccharide promotes receptor clustering rather than preventing it, and that clustering is precisely why the polysaccharide reaction survives. This choice states the correct relationship in the wrong direction.

This is a Knowledge of Scientific Concepts and Principles question because it asks the student to recall which structural class of antigen requires inspection before the responding cell may proliferate and to apply that rule to a stated cellular deficiency.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$dose-explains-it$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$wrong-producer$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$inverted-effect$q$ FROM q;

-- B2 Q23 . Adoptive Transfer and Causal Necessity . hard . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Adoptive Transfer and Causal Necessity$q$,
    $q$Mice bred without any lymphocytes make no soluble binding proteins against an injected protein and cannot clear a virus from their own tissues. Investigators put purified cells into each of three groups before immunisation: group 1 gets only the lineage that manufactures soluble binding proteins, group 2 gets only the subset that issues permission signals, and group 3 gets both. Groups 1 and 2 yield nothing detectable, while group 3 yields a full amount. Before this experiment, the only evidence linking the permission-issuing subset to the outcome was that its abundance in intact mice tracked the amount of soluble binding protein in serum. What does the group 3 result establish that the earlier evidence could not?$q$,
    $q$[{"label":"A","text":"That the transferred permission-issuing cells are the direct source of the secreted binding proteins, since output appears only when they are present."},{"label":"B","text":"That both cell types read the same determinant on the immunogen, since neither works by itself."},{"label":"C","text":"That nothing beyond the two transferred cell types is needed, since putting them back restored the full reaction."},{"label":"D","text":"That this cell type is genuinely necessary, because its addition is the only difference between the group that failed and the group that succeeded."}]$q$::jsonb,
    'D',
    $q$Organ Systems and the logic of experimental design: this item asks what an add-back transfer establishes that an observational correlation cannot. The answer is D because transfer converts the presence of a cell type into a variable the investigator sets, so recovery of function when that cell type is added back identifies it as necessary rather than merely co-varying with function.

The earlier evidence was observational. In intact mice, the abundance of the permission-issuing subset and the amount of circulating binding protein rise and fall with the same underlying stimuli, so the two can track each other without either causing the other. The transfer design removes that ambiguity. Recipients begin with no lymphocytes at all, which sets a common baseline; the investigators then change exactly one thing between group 1 and group 3, namely whether the permission-issuing cells are put back. Group 1 stays silent and group 3 responds. Because nothing else differs between those two groups, the difference in result must be attributed to what was added, and the silence of group 1 shows that the secreting lineage cannot supply for itself whatever the second cell type provides.

(Choice A) Necessity is not the same as authorship. Group 1 already contains the lineage that actually secretes the binding proteins and still yields nothing, which shows only that this lineage needs a partner. The design says nothing about which cell releases the secreted product.

(Choice B) Whether the two cell types read the same determinant is a separate question that would require immunogens carrying two distinguishable parts, tested in combination. This experiment varied only presence and absence of cells with one immunogen, so specificity matching was never probed.

(Choice C) Reconstitution occurred in an animal that still possesses all of its non-lymphocyte cells, including the phagocytic cells that first capture foreign material and display it. The result therefore shows the two transferred cell types are required, not that they are sufficient on their own.

This is a Reasoning about the Design and Execution of Research question because it asks the student to state which inference an add-back manipulation supports that an observed correlation in intact animals does not.$q$,
    'hard',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    3,
    105
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$necessity-as-authorship$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', $q$untested-true-claim$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$necessity-as-sufficiency$q$ FROM q;

-- B2 Q24 . Subset Depletion and Arm Specific Readout . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Subset Depletion and Arm Specific Readout$q$,
    $q$Mice receive a purified binding reagent aimed at a surface marker unique to the lymphocyte lineage that destroys its targets by direct contact, and that lineage is cleared from the body. These mice then handle an injected bacterial toxin as well as sham-treated littermates do, generating a normal quantity of specific soluble binding protein against it. The same mice cannot eliminate cells of their own tissues that a virus has entered. The split in outcomes is explained by which property of the removed lineage?$q$,
    $q$[{"label":"A","text":"It engages a cell only when that cell displays, on its own membrane, pieces of material assembled inside it."},{"label":"B","text":"It can engage only material that stays dissolved in body fluids, so anything sheltered within a cell escapes it."},{"label":"C","text":"It is the source of the specific soluble binding proteins, so its removal should have blunted the reaction to the injected toxin as well."},{"label":"D","text":"It comes into play only after the fast, broadly acting defences have failed, and the toxin had already been handled before that stage."}]$q$::jsonb,
    'A',
    $q$Organ Systems: this item uses a targeted depletion to isolate which arm of defence one lymphocyte lineage actually carries. The answer is A because the removed lineage acts on cells that show fragments of proteins built within themselves, a display carried by every nucleated cell, and a toxin circulating in body fluids is not such a cell.

A reagent that binds a marker unique to one cell type and clears it from the animal is a subtraction experiment: whatever collapses afterwards is work the subtracted cells were doing. Here the humoral arm is intact, so the removed lineage is neither the maker of the secreted binding proteins nor required by the cell that makes them. What collapses is clearance of the animal's own cells that a virus has entered. Those cells are identifiable only because every nucleated cell continuously samples the proteins it is synthesising and places fragments of them on a surface molecule encoded in the major histocompatibility complex. A cell building viral proteins therefore advertises its state, and the depleted lineage is the one that reads that advertisement and destroys the cell. The injected toxin is dealt with by secreted binding proteins acting on material outside cells, a route that never involves the depleted lineage, so that outcome is untouched.

(Choice B) This inverts the relationship. Material dissolved in body fluids is precisely what the secreted binding proteins deal with, and that arm was preserved. The depleted lineage is the one restricted to targets it can touch and inspect at close range.

(Choice C) If this lineage produced the specific soluble binding proteins, its removal would have flattened the reaction to the injected toxin. That reaction was normal, which excludes this explanation and cleanly separates the two adaptive arms; the secreted proteins come from the mature descendants of a different lymphocyte lineage.

(Choice D) The removed lineage is not a late fallback triggered by failure of the fast, broadly acting defences. It is deployed against cells carrying an infection inside them as part of the adaptive phase regardless of how the early response fared, and the depletion result speaks to what it recognises rather than to when it acts.

This is a Scientific Reasoning and Problem Solving question because it asks the student to infer, from which defence survived a targeted depletion and which did not, what kind of target the removed cells must be able to recognise.$q$,
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
  SELECT q.id, 'B', 'reversed_relationship', $q$swapped-arms$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$wrong-producer$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$wrong-stage$q$ FROM q;

COMMIT;

-- Verification: after batches 1 and 2, expect 46 questions and 138 distractor rows.
SELECT
  (SELECT COUNT(*) FROM public.questions WHERE topic = 'The Immune System') AS questions,
  (SELECT COUNT(*) FROM public.question_distractor_metadata m
     JOIN public.questions x ON x.id = m.question_id
   WHERE x.topic = 'The Immune System') AS distractor_rows;
