-- Biology Chapter 8: The Immune System, standalone questions
-- BATCH 4 of 4, FINAL (22 questions): lymphoid tissue, tolerance and failure modes.
--   Units: bone marrow, thymus, lymph nodes and spleen (12) . self versus nonself, host-damaging
--          responses and deficiency as a probe of normal function (10)
--
-- This file completes the chapter at 90 questions.
--
-- SCOPE CONVENTION (carried through all four batches): entities the AAMC outline does not name are
-- described functionally and never required as recalled vocabulary. Verified clean across all 90.
--
-- !! RUN AFTER BATCHES 1, 2 AND 3 !!
-- No DELETE here: batch 1 owns the chapter-scoped DELETE. Re-running this file alone would
-- duplicate its 22 questions.

BEGIN;

-- B4 Q1 . Two Site Design of Lymphocyte Production . medium . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Two Site Design of Lymphocyte Production$q$,
    $q$Every blood cell lineage in an adult arises from stem cells housed in the same set of marrow cavities, yet one lymphocyte lineage exits while still incompetent and completes its final steps inside a small structure lying behind the sternum. Both locations count as primary lymphoid sites. What does splitting the sequence across two locations achieve that carrying it out in one place could not?$q$,
    $q$[{"label":"A","text":"The marrow lacks the surface display molecules that a lymphocyte under test must engage, so no screening step can be carried out there."},{"label":"B","text":"The second site receives lymph draining from the body surface, giving the cells under test a broader sample of antigens than the first site can offer."},{"label":"C","text":"Immature cells are held in a compartment shielded from the debris of active infection and from the tissues they will eventually patrol, so any that react against the host's own peptides are deleted before they can reach a target."},{"label":"D","text":"Separation lets the cells under test meet an assortment of nonself antigens before export, so only those that already recognise a pathogen are released."}]$q$::jsonb,
    'C',
    $q$This item falls under Organ Systems and tests the division of labour between the site where lymphocytes are generated and the separate site where one lineage is vetted. The answer is C because the value of a second, separate location is that it is sequestered: a cell that would attack the host can be destroyed there while it is nowhere near the tissues it might damage and nowhere near invading material that would corrupt the test it is being put through. All blood lineages, including both lymphocyte lineages, begin from stem cells in red marrow. One of those lineages departs before it is functional and finishes behind the sternum, where it is confronted with the body's own peptides carried in by resident presenting cells; the great majority of arrivals fail and die, and only about two percent are ever exported. That arithmetic only makes sense if the deleting step happens somewhere the cell can do no harm while it is still dangerous, and somewhere the reference material is essentially all self. Vetting conducted in the middle of an infected tissue would both expose untested cells to targets and blur the very distinction the test is meant to draw.

(Choice A) Nucleated cells throughout the body, marrow included, carry the display molecules of the major histocompatibility complex, and the other lymphocyte lineage is in fact screened against the host's own material inside the marrow. The marrow is not disqualified on that ground.

(Choice B) Collecting lymph from a drainage field describes a secondary lymphoid organ such as a lymph node, which is where already mature cells meet antigen. It is an accurate description of a different structure and says nothing about why development is split in two.

(Choice D) This inverts the logic of the vetting step. Cells are tested against the body's own material, not against pathogens, and the pathogens they will eventually recognise are absent during development. Exporting only cells that had already met a pathogen would leave the host defenceless against everything it had not yet encountered.

This is a Knowledge of Scientific Concepts and Principles question because it asks the student to state why the site where a lymphocyte lineage is vetted must be anatomically separate from both its birthplace and the tissues it will later police.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    1,
    85
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', NULL FROM q;

-- B4 Q2 . Nonself Present During the Screening Window . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Nonself Present During the Screening Window$q$,
    $q$Newborn mice are inoculated with a virus that establishes a persistent, high-level infection of the organ in which one lymphocyte lineage is tested before release, while replicating only weakly elsewhere. The mice grow up well and show no sign of attacking their own organs. As adults they mount no cell-mediated response at all to this virus, although their responses to unrelated viruses are ordinary. Which account fits the pattern?$q$,
    $q$[{"label":"A","text":"Fragments of the agent were on show throughout the checking window and were read as the host's own material, so any clone able to bind them was culled."},{"label":"B","text":"The infection wiped out the developing population wholesale, leaving too few cells of that lineage to mount any specific response."},{"label":"C","text":"Removal of cells directed at the host's own proteins takes place only after the cells reach the circulation, so the site of infection is irrelevant and the defect arose at the activation stage instead."},{"label":"D","text":"Cells of this lineage survive only if they engage the display molecules carried by the resident cells of the organ, and those that fail to engage them die, which limits the repertoire."}]$q$::jsonb,
    'A',
    $q$This item falls under Organ Systems and tests what the composition of the environment inside a screening organ does to the repertoire that leaves it. The answer is A because a maturing cell treats whatever is on display in that organ as the standard of self, so an agent abundantly present there during development is written into that standard and the clones capable of recognising it are removed alongside the genuinely self-directed ones. The deleting step is deliberately blind: it asks only whether a cell binds what is displayed locally, not whether the displayed thing originated in the host, and cells that bind are killed by programmed death before export. Because the host's own peptides are richly represented at that site while pathogens normally are not, the step ordinarily removes only dangerous cells. Persistent occupancy of the organ by a virus breaks that assumption, and the price is a permanent gap in the repertoire specific to that one agent. That is precisely the observed pattern: nothing against this virus, ordinary responses to others, and no self-directed disease, since the screen against the host itself worked exactly as designed.

(Choice B) Wholesale loss of the population would cripple responses to every agent and would show up as a general failure to thrive. The preserved responses to unrelated viruses rule this out, and it leaves the specificity of the deficit unexplained.

(Choice C) Removal of cells that react against the host is a central step carried out inside the organ and completed before export, which is why such cells are largely kept out of the circulation in the first place. Relocating that whole process to after export moves a real step to the wrong stage and could not generate a defect confined to a single specificity.

(Choice D) The requirement to engage the display molecules of the resident cells is a genuine feature of this lineage's development and does constrain what it can later see. It is true but not selective: the same requirement applies to the unrelated viruses these mice handle normally, so it cannot account for a gap limited to one agent.

This is a Scientific Reasoning and Problem Solving question because it asks the student to work backwards from a response failure limited to a single agent to the condition inside the screening organ that must have produced it.$q$,
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
  SELECT q.id, 'B', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', NULL FROM q;

-- B4 Q3 . Neonatal Versus Adult Loss of Screening Organ . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Neonatal Versus Adult Loss of Screening Organ$q$,
    $q$Two groups of mice have the organ that screens one lymphocyte lineage taken out surgically: group 1 on the day of birth, group 2 at nine months of age. Group 1 wastes away with runaway infections and fails to reject skin grafts. Group 2 stays healthy for the rest of its life, showing only a slow narrowing of the range of responses it can raise. What accounts for the gap between the two outcomes?$q$,
    $q$[{"label":"A","text":"The structure shrinks steadily after puberty, so by nine months it had already ceased to contribute and its loss could change nothing."},{"label":"B","text":"Loss of the structure halts new output equally in both groups; group 1 suffers because its marrow cannot yet generate the precursors that would seed it."},{"label":"C","text":"The surgery in group 1 also compromises the marrow, so the failure there is a general shortage of all blood cells rather than of one lineage."},{"label":"D","text":"By the later age a large, long-lived pool of already vetted cells has built up outside the site and is kept going by division, whereas a day-old mouse has not yet assembled such a pool."}]$q$::jsonb,
    'D',
    $q$This item falls under Organ Systems and tests why the timing of losing a primary lymphoid organ changes the outcome so sharply. The answer is D because the organ is a factory for one lineage rather than the place that lineage lives and works: cells that pass its screen leave and take up residence in secondary lymphoid tissue, where they persist for years and can expand by division. An animal that reaches nine months has therefore already stocked its periphery with a broad, self-tolerant repertoire, and removing the factory only stops further stocking; the standing stock decays slowly, which is why the sole deficit seen is a gradual narrowing of the range of responses. A newborn has no such stock, so removing the factory removes the entire supply. The result is the classic picture in group 1: overwhelming infection and failure to reject foreign tissue, both of which need the lineage that is vetted at that site.

(Choice A) The organ genuinely does involute, losing tissue steadily from puberty onward at roughly three percent per year, so this choice starts from a real observation. It goes too far, however: involution reduces output rather than abolishing it, and the reason group 2 is protected is the reservoir it built earlier, not the absence of any function at the time of surgery.

(Choice B) The marrow has taken over most blood cell production well before birth and is generating lymphoid precursors at the time of the neonatal surgery, so a failure of precursor supply is not what distinguishes the newborn. This choice misassigns the deficit to the earliest step of the pathway rather than to the missing downstream reservoir.

(Choice C) The organ removed sits behind the sternum, and the marrow is a separate primary site left intact by that operation, so oxygen carriage and phagocyte production are unaffected. The failure in group 1 is confined to the lineage that depends on the removed site, not spread across all blood cells.

This is a Scientific Reasoning and Problem Solving question because it asks the student to explain two opposite surgical outcomes by reasoning about what has and has not accumulated in the periphery at each age.$q$,
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
  SELECT q.id, 'A', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', NULL FROM q;

-- B4 Q4 . Lineage That Never Leaves Its Birthplace . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Lineage That Never Leaves Its Birthplace$q$,
    $q$An infant is born without the small organ that lies behind the sternum, while the marrow is normal on biopsy. Blood analysis shows one of the two adaptive cell populations at a near-normal count and the other almost absent. Which one is at a near-normal count, and on what grounds?$q$,
    $q$[{"label":"A","text":"B lymphocytes, because they are produced at one site and then pass through the missing organ for a check that is not essential."},{"label":"B","text":"B lymphocytes, because this lineage both arises and is screened inside the very cavities where all blood cells begin, so the absent structure never contributes to its supply."},{"label":"C","text":"T lymphocytes, because it is the other lineage whose final steps depend on the structure behind the sternum."},{"label":"D","text":"T lymphocytes, because the spleen and lymph nodes are where cells of every lineage meet displayed antigen."}]$q$::jsonb,
    'B',
    $q$This item falls under Organ Systems and tests which of the two adaptive lineages completes its development without ever entering the organ behind the sternum. The answer is B because the B lineage never migrates to that organ at all: it arises from marrow stem cells and undergoes nearly all of its development in the marrow, including the step that removes members binding the host's own material. Nothing in that programme requires the missing structure, and the last polishing stages take place in the spleen rather than behind the sternum, so the supply of these cells is untouched. The T lineage is the exception among blood cells in that it departs while still immature and must complete its testing behind the sternum, which is why its count collapses when that destination does not form. The practical prediction follows directly: defences that rest on cells finished in the marrow persist, while everything that depends on the lineage vetted behind the sternum, including rejection of foreign tissue, is lost.

(Choice A) This names the right lineage on the wrong anatomy. Cells of the B lineage do not travel to the organ behind the sternum for any step; treating that organ as an optional waypoint for them misstates where their screening happens.

(Choice C) This reverses which lineage depends on which site. It is the T lineage, not the B lineage, whose final steps occur behind the sternum, so the T count is the one that falls when that organ is missing.

(Choice D) The spleen and lymph nodes are indeed places where mature cells encounter displayed antigen, and this statement is accurate as far as it goes. Those are secondary sites, however, and they neither generate nor perform the developmental screening of the lineage in question, so they cannot preserve a lineage whose primary site is absent.

This is a Knowledge of Scientific Concepts and Principles question because it asks the student to recall which adaptive lineage completes its development without entering the organ behind the sternum and to apply that fact to an infant born without that organ.$q$,
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
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', NULL FROM q;

-- B4 Q5 . Why Rare Clones Must Be Concentrated . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Why Rare Clones Must Be Concentrated$q$,
    $q$The body carries on the order of a trillion lymphocytes, but only a minute fraction of them bear a receptor shaped to bind any one particular antigen. A bacterium introduced by a thorn prick is at first confined to a few cubic millimetres of skin. Which feature of the response makes it likely that a matching cell will meet that bacterium's antigens within days rather than never?$q$,
    $q$[{"label":"A","text":"Each lymphocyte carries receptors of many different binding shapes, so nearly any cell in the pool can respond to whatever arrives."},{"label":"B","text":"Phagocytes already living in the skin ingest and destroy the bacterium, which is what clears most punctured-skin infections."},{"label":"C","text":"Both the invader's molecular fragments and a dense standing pool of the cells that could recognise them are funnelled into the same small filtering organ."},{"label":"D","text":"The bacterium multiplies until its antigens are abundant enough throughout the whole body for chance contact to be certain."}]$q$::jsonb,
    'C',
    $q$This Organ Systems question tests how the architecture of a secondary lymphoid organ solves an encounter problem that dispersed defence cannot solve. The answer is C because a cell present at vanishingly low frequency can find its target on a useful timescale only if the target and a concentrated pool of candidate cells are delivered into the same small space. Work through what the stem implies numerically: if only one cell in many tens of thousands carries a fitting receptor, a random search of every tissue compartment in the body would take far longer than an unchecked infection takes to become dangerous. Lymphatic drainage is therefore not merely a return route for tissue fluid; it carries a sample of whatever is in that tissue into a bean-sized organ that already holds lymphocytes packed at very high density. Because a representative sample of the invader and a large slice of the available repertoire now occupy a volume of only a few cubic centimetres, the improbable pairing becomes probable, and the one cell that fits can then be enlarged into a clone big enough to matter. Clonal selection has a physical prerequisite: the selecting agent and the population being selected from must be in contact, and the filtering organ is what guarantees that contact. (Choice A) This inverts the defining property of the adaptive system. Each lymphocyte commits to a single binding shape, which is exactly why any one specificity is rare and why the meeting problem exists at all; a cell able to bind anything would also fail to discriminate self from nonself. (Choice B) This is a true statement about innate defence and it does clear many minor wounds, but it is an answer to a different question. It describes destruction without specific recognition, and so says nothing about how a matching lymphocyte finds its antigen; it also fails whenever the organism resists ingestion. (Choice D) This puts the events in the wrong order. Waiting for body-wide dissemination would mean the specific response begins only after the infection has become systemic, which is the outcome the architecture exists to prevent, and spreading the same material through the whole body lowers rather than raises the concentration any one cell would sample. This is a Scientific Reasoning and Problem Solving question because it asks the student to turn a statement about how rare a matching cell is into a conclusion about where recognition must physically be made to happen.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$one cell, many specificities$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', $q$innate answer to an adaptive question$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$wait for dissemination$q$ FROM q;

-- B4 Q6 . Purpose of the Obligate Drainage Detour . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Purpose of the Obligate Drainage Detour$q$,
    $q$After removal of a breast tumour, the whole group of small bean-shaped filtering organs in one armpit is excised, and the drainage vessels of that arm are left to return tissue fluid to the circulation without passing through any such organ. The patient later sustains an identical superficial cut on each forearm, one on the operated side and one on the intact side. Which of the following would be expected on the operated side?

I. A response specific to the organisms in that cut begins later than the matching response on the intact side.
II. Material carried away from that cut enters the general circulation without first being gathered at a screening point.
III. Bacteria in the cut itself escape ingestion by cells already resident in that skin.$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"I and II only"},{"label":"C","text":"II and III only"},{"label":"D","text":"I, II and III"}]$q$::jsonb,
    'B',
    $q$This Organ Systems question tests what is actually accomplished during the detour that tissue fluid makes before rejoining the circulation. The answer is B because abolishing the detour removes the step that gathers drained material for inspection, which delays the specific arm of defence, while leaving defences that operate in the tissue itself untouched. Statement I follows from the point that recognition by a rare specific cell is a numbers game: with no waystation in that path, whatever leaves the cut is carried straight into the general circulation instead of being deposited among densely packed lymphocytes, so the specific response starts later than on the intact side. Statement II is the same physical fact seen from the other side; the detour exists so that drained material is collected at a chokepoint and inspected before it goes anywhere else, and with the chokepoint gone that collection step simply does not happen. Statement III fails because defence in the skin does not depend on any distant organ: cells resident in the tissue engulf bacteria on contact, using recognition of general foreign features rather than a specific match, and they are still present after the operation. The discriminating principle is innate versus adaptive: only the adaptive arm requires the anatomical convergence that has been removed. (Choice A) This captures the delay to the specific response but stops short. It leaves out the routing change itself, which is the direct physical consequence of losing the chokepoint and the reason the delay occurs. (Choice C) This keeps the routing point but adds a false claim and drops the true one. Discarding statement I removes the whole immunological cost of the operation, and accepting statement III asserts that tissue phagocytes are somehow disabled by the loss of a structure downstream of them. (Choice D) This applies the right reasoning at the wrong level of organisation. Losing the organ impairs the response that must be assembled in a filtering organ, not the ingestion of bacteria by cells sitting in the wound, which happens locally and needs no such organ. This is a Scientific Reasoning and Problem Solving question because it asks the student to predict, from the removal of one anatomical step, which arms of defence fail and which are untouched.$q$,
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
  SELECT q.id, 'A', 'partial_truth', $q$true but incomplete set$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$innate defence depends on nodes$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$over-inclusive all-of-the-above$q$ FROM q;

-- B4 Q7 . What Node Enlargement Actually Consists Of . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$What Node Enlargement Actually Consists Of$q$,
    $q$A splinter wound on a child's forearm becomes infected. Over three days the bean-shaped organ in the armpit on that side becomes tender and grows to several times its usual bulk, while the matching organ in the opposite armpit stays as it was. The change in bulk is mainly accounted for by which of the following?$q$,
    $q$[{"label":"A","text":"Swelling of the individual cells already sitting there, with their count unaltered."},{"label":"B","text":"Multiplication of the wound organisms themselves inside the organ until it is packed with them."},{"label":"C","text":"An equal proportional expansion of every cell type the organ contains."},{"label":"D","text":"A large gain in cell numbers, driven by rapid division of the few resident cells whose receptors fit what came from the wound."}]$q$::jsonb,
    'D',
    $q$This Organ Systems question tests what the familiar swelling beside an infection physically consists of. The answer is D because the organ enlarges by making cells, and specifically by the explosive division of the small subset whose receptors happened to fit the material delivered from the infected site. What arrives from the wound is a sample of the invader and its molecules, and that sample is far too small to add any bulk of its own; what adds bulk is what the arriving sample sets off. The event is selection rather than general stimulation, because only cells with a fitting receptor are triggered to divide, and from a starting frequency of perhaps one in tens of thousands those cells generate a clone large enough to be a substantial fraction of the organ within days. Regions of rapid division become visible inside the organ as it works, and further cells are drawn in from the blood, which adds to the bulk. The one-sidedness in the stem is the giveaway that this is a selective, drainage-linked event rather than anything systemic: only the organ receiving fluid from that limb receives the trigger. (Choice A) This confuses a change in cell size with a change in cell number, the wrong level of organisation for the effect described. Individual cells cannot swell by enough to multiply the volume of a whole organ several times over, and a response that added no cells would leave the body no better equipped to clear the infection. (Choice B) This mistakes the organ for a culture vessel. Material arriving from the wound is inspected and largely destroyed there by cells that ingest foreign matter, so the organism load inside is small; an organ genuinely filling with multiplying bacteria describes a failure of the filter, not the ordinary swelling that accompanies a healing wound. (Choice C) This gets the mechanism right but the selectivity wrong, and the difference matters. Uniform expansion of every resident cell type would produce a bigger organ with the same proportions and no improvement in the response to this particular organism, whereas the useful outcome is the disproportionate amplification of one narrow population. This is a Knowledge of Scientific Concepts and Principles question because it asks the student to identify the cellular event that clonal expansion inside a filtering organ actually amounts to.$q$,
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
  SELECT q.id, 'A', 'scale_unit_error', $q$cell size versus cell number$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$node as culture vessel$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$non-selective proliferation$q$ FROM q;

-- B4 Q8 . Draining Versus Remote Node Time Course . medium . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Draining Versus Remote Node Time Course$q$,
    $q$A traceable foreign protein is injected into the footpad of a mouse. At set intervals the small filtering organ receiving drainage from that foot and an unrelated one in the neck are removed, and two quantities are measured: how much of the protein is present, in arbitrary units, and how many cells per million bind it.

| Hours after injection | Protein, foot organ | Binding cells per million, foot organ | Protein, neck organ | Binding cells per million, neck organ |
| --- | --- | --- | --- | --- |
| 0 | 0 | 30 | 0 | 30 |
| 6 | 85 | 33 | 0 | 30 |
| 24 | 140 | 210 | 2 | 31 |
| 72 | 60 | 4100 | 4 | 46 |
| 120 | 10 | 2600 | 3 | 380 |

Which conclusion about the neck organ is best supported?$q$,
    $q$[{"label":"A","text":"Its late rise reflects cells that multiplied at the site of delivery and then travelled there, rather than fresh local triggering."},{"label":"B","text":"The amount accumulating in it by 120 hours is enough to account for the count measured there."},{"label":"C","text":"The two organs differ only in when the foreign substance reaches them; the eventual size of the responding population is comparable."},{"label":"D","text":"Its responding cells were already climbing before anything could have left the foot, so the growth came first."}]$q$::jsonb,
    'A',
    $q$This Organ Systems question tests reading a two-site time course to decide whether a rise in responding cells was generated locally or imported. The answer is A because the neck organ shows a large rise in binding cells at a point when the amount of foreign protein it holds is trivial and already falling, so the cells cannot have been produced by stimulation there. Compare the two columns for the foot-draining organ: protein appears by 6 hours, peaks at 140 units by 24 hours, and is then cleared, while binding cells climb from 30 to 4100 per million by 72 hours, a rise of more than a hundredfold that is locked to the arrival of the protein. The neck organ never sees more than 4 units, roughly three per cent of the peak elsewhere, and its cell count is still essentially at baseline at 72 hours when the foot organ has already finished expanding. Only at 120 hours, after the expansion at the drainage site has run, does the neck count rise to 380. The order of events, large expansion at the delivery site first and a modest rise elsewhere afterwards, with no matching antigen signal at the second site, points to redistribution of already amplified cells through the circulation rather than a second, independent triggering event. (Choice B) This misjudges magnitude. Three units at 120 hours is a fraction of what accompanied a hundredfold expansion at the other site, and the amount there is falling while the count rises, so the two cannot stand in a driving relationship. (Choice C) This is right that arrival timing differs but wrong that the outcomes match. The eventual counts are 2600 and 380 per million, a sevenfold gap, so the second site never mounts a comparable population of its own. (Choice D) This reverses the sequence in the table. The neck counts are 30, 30 and 31 at 0, 6 and 24 hours, entirely flat while the foot organ is already expanding, so nothing rose there before material had left the foot. This is a Data-based and Statistical Reasoning question because it asks the student to compare the timing and magnitude of two paired columns and infer where a population of cells was actually produced.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    4,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'misconception', $q$trivial signal read as sufficient$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$delay only, same magnitude$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$sequence of events reversed$q$ FROM q;

-- B4 Q9 . Screening Antigen That Never Leaves Vessels . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Screening Antigen That Never Leaves Vessels$q$,
    $q$An intravenous line becomes contaminated and delivers bacteria straight into a vein. The organisms multiply in the bloodstream and never establish a focus in any tissue space, so no draining lymph node ever receives them. Which structure allows an adaptive response to be raised against them anyway?$q$,
    $q$[{"label":"A","text":"The thymus, where developing lymphocytes that react against the body's own molecules are eliminated before they are released into service."},{"label":"B","text":"The red bone marrow, which raises its output of new lymphocytes until enough of them happen to carry a useful receptor."},{"label":"C","text":"The spleen, whose lymphocyte-rich sleeves wrap the small arteries within it, so vessel-borne material is screened as it flows past."},{"label":"D","text":"The unencapsulated lymphocyte clusters beneath the linings of the throat and gut, which sample material crossing those surfaces from outside."}]$q$::jsonb,
    'C',
    $q$This item belongs to Organ Systems and tests how the secondary lymphoid organs divide the sampling of the body between them. The answer is C because the spleen is the only one of these organs built onto the arterial circuit: the artery supplying it splits into small vessels that are sleeved by lymphocyte-rich tissue, so anything travelling in the circulation is delivered directly into a mass of naive cells and can be picked up by the cells that ingest foreign matter and display fragments of it.

A lymph node is plumbed the opposite way. It is fed by incoming lymphatic channels carrying fluid that has already drained out of interstitial spaces, so a node can only sample antigen that first entered a tissue. An agent seeded straight into a vein and confined to the circulation never travels that route. Because the spleen sits on the circulatory path, clonal selection can proceed there: the rare naive lymphocyte whose receptor fits the invader is exposed to it, is triggered, and expands. That is precisely why the body needs a station screening the circulating compartment in addition to the network screening tissue drainage.

(Choice A) The thymus screens developing lymphocytes for reactivity against the body's own molecules, which is a maturation function carried out before cells are released. It receives no meaningful stream of circulating foreign material to sample, so it cannot be where a response to an invader is initiated.

(Choice B) Raising the output of new lymphocytes does not help, because each cell's binding specificity is fixed before it ever meets an antigen. Producing more cells at random does not bring a fitting one into contact with the invader; the invader has to be brought to a place where lymphocytes are already concentrated.

(Choice D) The unencapsulated clusters under the lining of the throat and gut sample material crossing those surfaces from the outside world. They are positioned for antigen arriving across an epithelium, not for antigen already inside vessels and never entering an interstitial space.

This is a Knowledge of Scientific Concepts and Principles question because it asks the student to recall which lymphoid organ is positioned on the circulatory path and is therefore able to initiate a response to material that never enters a tissue space.$q$,
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
  SELECT q.id, 'A', 'adjacent_fact', $q$true-but-about-a-different-organ$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$more-output-solves-a-targeting-problem$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$right-category-of-tissue-wrong-position$q$ FROM q;

-- B4 Q10 . Why A Coated Organism Is The One That Overwhelms . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Why A Coated Organism Is The One That Overwhelms$q$,
    $q$Two years after his spleen was removed following a car crash, a man still clears boils, dental abscesses and infected cuts without unusual trouble. He then becomes critically ill within hours of acquiring a bacterium whose thick slippery outer layer makes it very hard for any cell to grip and swallow. What accounts for this selective pattern of vulnerability?$q$,
    $q$[{"label":"A","text":"Ordinary organisms are taken up on the spot, but this one is not until antibody has been raised against its covering, and the site that raises such a response to a blood-borne invader is gone."},{"label":"B","text":"The covering hides the organism from lymphocytes altogether, so no antibody against it can be raised in anyone, whether or not that organ is still present."},{"label":"C","text":"The removed organ was where developing lymphocytes acquire the ability to tell the body's own molecules from foreign ones, so his tolerance has been disturbed."},{"label":"D","text":"The removed organ was the only site at which a rare lymphocyte can meet its fitting antigen, so every adaptive response he now mounts is delayed."}]$q$::jsonb,
    'A',
    $q$This question sits in Organ Systems and asks what a later pattern of infections reveals about which requirement can no longer be met. The answer is A because an organism whose surface layer resists being gripped is not handled by ingestion alone: antibody has to be raised against that surface layer before a phagocyte can hold on to the organism at all, and for an invader multiplying in the bloodstream the place where that response is normally raised is the organ he no longer has. The failure is therefore confined to organisms that carry such a layer and arrive by that route.

Boils, dental abscesses and infected cuts differ on both counts. Those organisms can be gripped and ingested at the site without any antibody being raised first, and antigen leaving the focus is taken up by lymphatic capillaries and carried to a regional node, a pathway the surgery never touched. So the split described in the case is exactly what the loss predicts: unchanged handling of ordinary local infections, catastrophic failure against a coated organism seeded into the blood.

(Choice B) A thick surface layer resists being gripped, but it does not hide the organism from lymphocytes. That layer is itself a foreign structure, and antibody is raised against it, which is why the man's problem is where such a response can be mounted rather than whether it is possible at all.

(Choice C) Screening developing lymphocytes for reactivity against the body's own molecules happens during maturation in a different organ, before those cells enter service. Disturbed tolerance would show up as damage to the patient's own tissues, not as selective susceptibility to one class of organism.

(Choice D) A rare lymphocyte can encounter its target in any of several secondary sites, which is exactly why responses to skin and gum infections survive the loss. Claiming a single meeting place predicts a general slowing of every adaptive response, which contradicts the preserved handling of boils and abscesses.

This is a Scientific Reasoning and Problem Solving question because it asks the student to read a split between preserved and failed defences and infer which specific requirement of the failed case has no substitute in this patient.$q$,
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
  SELECT q.id, 'B', 'misconception', $q$physical-resistance-mistaken-for-invisibility$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$maturation-screen-attributed-to-the-wrong-organ$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$one-of-several-sites-treated-as-the-sole-site$q$ FROM q;

-- B4 Q11 . Why Rare Clones Must Keep Moving . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Why Rare Clones Must Keep Moving$q$,
    $q$In an adult, roughly one lymphocyte in every 100,000 carries a receptor able to bind any given foreign structure, and a pathogen that breaches the skin of the foot is held almost entirely within the single lymphoid organ draining that region rather than spreading to the others. A cell bearing a suitable receptor is nonetheless engaged within a few days. What does the continuous traffic of lymphocytes between the circulation and lymphoid tissue accomplish here?$q$,
    $q$[{"label":"A","text":"It increases the number of copies of each specificity present in the body, raising the chance that one is on hand at any given site."},{"label":"B","text":"It carries the foreign structure outward from the point of entry to every site, so each lymphocyte can stay in the organ where it already resides."},{"label":"C","text":"It returns cells that have already been triggered to the region that needs them, which is what removes the delay before the response begins."},{"label":"D","text":"Each cell passes from one screening station to the next, so any clone eventually meets material held in all of them without having to live where the intruder arrived."}]$q$::jsonb,
    'D',
    $q$This question belongs to Organ Systems and tests why a defence built on rare, pre committed clones can still find a fit quickly. The answer is D because a lymphocyte is not assigned to one site for life: it crosses out of the circulation into a lymphoid organ, spends some hours there, leaves and enters another. Over a day or two a single cell therefore visits many such stations in turn.

That behaviour turns a hopeless problem into a manageable one. Clonal selection fixes each cell's binding specificity before it ever meets a target, so the body cannot manufacture a fitting receptor on demand; it can only bring the fitting cell and the target into the same place. If cells were stationary, success would require the one clone in 100,000 to happen to reside in the particular organ that captured the invader, and most encounters would fail outright. Because the whole population moves, every clone is repeatedly presented to every deposit of captured material, so the probability that the correct clone eventually arrives approaches certainty over a few days.

(Choice A) Movement between compartments redistributes cells; it does not create them. The size of any clone rises only after its target has triggered it, which is a consequence of the meeting rather than a way of arranging one.

(Choice B) This reverses the direction of the traffic that matters. The stem specifies that the invader stays where it was deposited and does not spread, so the mobile element must be the cells; a stationary population would still fail even if some material did leak away.

(Choice C) Delivering already triggered cells to the affected region is the output stage of the response and occurs only after a fit has been made. It cannot explain how the fit was made, which is what the days before the response are spent on.

This is a Scientific Reasoning and Problem Solving question because it asks the student to combine the rarity of any one specificity with the confinement of the invader and infer what continuous cell traffic buys the system.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$traffic-mistaken-for-proliferation$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', $q$antigen-moves-instead-of-cells$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$effector-delivery-substituted-for-search$q$ FROM q;

-- B4 Q12 . Reading a Labelled Lymphocyte Distribution Time Course . medium . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Reading a Labelled Lymphocyte Distribution Time Course$q$,
    $q$Lymphocytes from a donor animal were tagged and injected into the bloodstream of a genetically identical recipient. The table gives the percentage of the injected tag recovered at each site afterwards, and the four columns sum to 100 at every time point. Blood in this animal makes a complete circuit of the body in well under a minute.

| Time after injection | Blood | Spleen | Lymph nodes | Other tissues |
| --- | --- | --- | --- | --- |
| 5 min | 78 | 11 | 3 | 8 |
| 1 h | 26 | 44 | 16 | 14 |
| 6 h | 14 | 31 | 41 | 14 |
| 24 h | 13 | 29 | 44 | 14 |
| 48 h | 13 | 29 | 44 | 14 |

Which conclusion is supported by these results?$q$,
    $q$[{"label":"A","text":"Most tagged cells are permanently captured by the first site they reach, since the value in the first column falls by roughly two thirds within the first hour."},{"label":"B","text":"Cells must be leaving the sampled sites and re-entering the vascular space at the rate at which they arrive, since the shares settle after a few hours and then stop changing."},{"label":"C","text":"The rise in the lymph node column between one and six hours shows that the tagged cells divide faster there than they do elsewhere."},{"label":"D","text":"The nodes must be entered from the circulation more rapidly than the spleen is, because their share is the largest one at 48 hours."}]$q$::jsonb,
    'B',
    $q$This question falls under Organ Systems and asks for an inference about lymphocyte traffic drawn from a distribution measured over time. The answer is B because the values at 24 and 48 hours are identical and the six hour values are already close to them, yet 13 per cent of the tag is still in the first column, and the whole circulating volume passes through these organs many times an hour. A share that large and that stable cannot be residual material still in transit, because at that circuit rate any cells not returning to the vessels would have been cleared from the first column long before 48 hours.

A value that is constant is therefore evidence of exchange, not of stillness. Cells must be departing the tissues and re-entering the vessels at the same rate as others are leaving the vessels for the tissues, which is the definition of a steady state. The early points make the ordering plain as well: the splenic share is already 44 at one hour while the nodal share is only 16, and only later does the nodal share become the largest.

(Choice A) The fall from 78 to 26 in the first hour is read correctly, but the conclusion does not follow. Permanent capture predicts that the first column would keep falling toward zero as the population makes circuit after circuit; instead it settles at 13 per cent and is still 13 per cent at 48 hours.

(Choice C) A rise in one column matched by falls in the others over the same interval is movement between compartments, not multiplication. The table reports how a fixed quantity of tag is shared out and is constrained to sum to 100, so it cannot demonstrate that any population has grown in number.

(Choice D) Being largest at the end says nothing about the speed of entry. At one hour the splenic share is 44 per cent against 16 per cent for the nodes, so the site that filled faster is the one with the smaller final share, and a standing share reflects how long cells stay as well as how fast they arrive.

This is a Data-based and Statistical Reasoning question because it asks the student to distinguish a static distribution from a steady state by comparing how the values behave across successive time points.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    4,
    95
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$correct-trend-wrong-endpoint$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$redistribution-read-as-proliferation$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$final-magnitude-mistaken-for-rate$q$ FROM q;

-- B4 Q13 . Random Repertoire and the Need for Tolerance . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Random Repertoire and the Need for Tolerance$q$,
    $q$Each developing lymphocyte builds its recognition site by joining gene segments in a combination drawn at random, fixed before the cell has ever met anything foreign, and across all such cells a person carries trillions of distinct sites. Why must the body impose a dedicated check on newly made cells rather than trusting this collection as it stands?$q$,
    $q$[{"label":"A","text":"A site that fits the body's own constituents cannot arise this way, because the gene segments available for joining exclude host-fitting shapes."},{"label":"B","text":"Shapes produced blindly will inevitably include some complementary to the body's own material, so those cells must be eliminated once they exist."},{"label":"C","text":"Far more sites appear than any one person will ever use, so the surplus has to be trimmed to conserve resources."},{"label":"D","text":"Most sites made this way fit nothing at all, and the check exists mainly to discard those unusable cells."}]$q$::jsonb,
    'B',
    $q$This Organ Systems item tests self versus nonself recognition, specifically why unresponsiveness toward the host has to be manufactured rather than inherited. The answer is B because shapes produced blindly will inevitably include some complementary to the body's own material, so those cells must be eliminated once they exist. The joining of gene segments proceeds with no information about what the cell will one day encounter, and that is precisely what lets the adaptive system cover targets no ancestor ever saw. The same indifference cuts both ways: a process that samples the space of possible binding surfaces without regard to origin cannot skip the region of that space already occupied by the host's own molecules. At a repertoire size in the trillions, a self-fitting fraction is not a rare accident but a statistical certainty, so a screening stage that tests immature cells against host constituents and then kills, edits, or silences the responders is a structural requirement of the design rather than an optional refinement. (Choice A) The starting segments cannot be curated to yield only foreign-fitting shapes, because whether something counts as foreign is defined relative to the individual carrying it, while essentially the same inherited segment pool is shuffled in everyone regardless of what that individual's own proteins look like. (Choice C) It is true that one person meets only a sliver of the binding surfaces their marrow generates, but economy is not the pressure that produced a self-directed screen. An unused cell costs almost nothing, whereas a single cell that attacks a working organ can cost the organ, so the screen is aimed at danger rather than at waste. (Choice D) Cells whose receptors turn out to be non-functional are indeed removed, but that outcome decides whether a cell can participate in a response at all, which is a separate question from whether it endangers the host, and it therefore does not explain why the check specifically probes reactivity toward the body itself. This is a Knowledge of Scientific Concepts and Principles question because it asks the student to apply the principle that recognition sites are assembled without reference to any target and to identify the consequence that sparing the host must be imposed as a separate, active step.$q$,
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
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', NULL FROM q;

-- B4 Q14 . Autoimmunity as Correct Machinery Wrong Target . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Autoimmunity as Correct Machinery Wrong Target$q$,
    $q$A patient develops progressive destruction of the cartilage in several joints. Investigators recover from the inflamed tissue both lymphocytes and soluble products that lock onto a molecule normally present in that cartilage, and the patient clears ordinary infections no less well than healthy controls. Which observations would be expected if this disorder reflects intact recognition machinery aimed at the wrong target rather than a fault in the machinery itself?

I. The offending population arose by expansion of a few precursor cells that already carried the matching site before any damage appeared, as happens after a vaccine.
II. The attachment measured is as strong and as narrowly restricted as attachment seen in a successful response to a bacterium.
III. The host molecule had to be chemically altered into a foreign-like form first, because unaltered host structures cannot be attached at all.$q$,
    $q$[{"label":"A","text":"III only"},{"label":"B","text":"II only"},{"label":"C","text":"I and II only"},{"label":"D","text":"I, II, and III"}]$q$::jsonb,
    'C',
    $q$This Organ Systems item tests self versus nonself recognition by asking what an autoimmune disorder looks like at the level of the recognition event itself. The answer is C because statements I and II each describe the ordinary adaptive sequence running at full quality, with the only abnormality being the identity of what is bound. Clonal selection means any response starts from rare pre-existing cells whose sites already fit the target and finishes with a large descendant population, and that history is identical whether the fitted target sits on a bacterium or on a joint constituent, which makes statement I expected. Statement II follows from the same reasoning: the damage here is confined to tissues carrying one particular structure, and such confinement is only possible if attachment is tight and discriminating, so loose or promiscuous binding is the opposite of what the clinical picture implies. The normal handling of infections stated in the stem reinforces the interpretation, since a genuine defect in expansion, attachment, or killing would blunt protective responses as well. What has gone wrong is the earlier step that should have deleted or silenced cells bearing host-fitting sites, leaving an otherwise normal effector program pointed at the wrong address. (Choice A) Statement III fails on its own terms, because host structures are perfectly bindable; the chemical shapes displayed by the body's own molecules are no different in kind from those on a microbe, and it is only prior removal of the matching cells that ordinarily spares them. Choosing III alone also discards two observations that fit the premise. (Choice B) Statement II is correct, but stopping there omits the feature that most directly shows the response was assembled in the usual way. Without statement I, nothing in the answer establishes that a small pre-existing population was selected and expanded, which is the signature of an intact adaptive program rather than a random inflammatory accident. (Choice D) Adding statement III inserts a modification step that the normal pathway does not require and that the findings do not support, since the products recovered attach to the molecule as the cartilage actually presents it. This is a Scientific Reasoning and Problem Solving question because it asks the student to decide which experimental observations distinguish a correctly functioning recognition system misdirected at a host structure from a system whose components are themselves defective.$q$,
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
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', NULL FROM q;

-- B4 Q15 . Injury Exposing a Sequestered Body Constituent . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Injury Exposing a Sequestered Body Constituent$q$,
    $q$A man sustains a crushing blow to one testis. Eight months later his blood contains lymphocytes and soluble products that lock onto components carried on the surface of his own sperm, and the untouched testis on the opposite side has become inflamed. Tight junctions between the supporting cells of the seminiferous tubules normally seal those components away from the circulation, and have done so since the organ was built. What does this sequence reveal about how the body comes to leave its own constituents alone?$q$,
    $q$[{"label":"A","text":"The blow destroyed the step that removes host-reactive cells, so reactions against many unrelated tissues should now follow."},{"label":"B","text":"Microbes carried in by the wound are displayed alongside host fragments, and the reaction is aimed at the microbial portion while the tissue injury is incidental."},{"label":"C","text":"The barrier normally holds the local number of responsive cells below the count needed for any reaction, and the injury pushed that number above threshold."},{"label":"D","text":"Sparing of the body's own molecules is learned by exposing immature adaptive cells to whatever is accessible during a defined developmental window, so anything walled off then was never included and stays a legitimate target."}]$q$::jsonb,
    'D',
    $q$This Organ Systems item tests self versus nonself recognition by working backwards from an autoimmune outcome to what it reveals about how sparing of the host is acquired. The answer is D because sparing of the body's own molecules is learned by exposing immature adaptive cells to whatever is accessible during a defined developmental window, so anything walled off then was never included and stays a legitimate target. If nonreactivity were an intrinsic property of anything the genome encodes, no host structure could ever be attacked no matter how it was revealed. The findings say the opposite: a structure that was physically fenced off while the screening cells were maturing behaves exactly like foreign material the first time it reaches the circulation. Two details make this reading specific rather than merely plausible. The reaction follows a single mechanical breach with no further trauma, so it is the escape of previously enclosed material, and not ongoing injury, that set the response going. The reaction then damages the organ on the uninjured side, which shows the products are directed at the structure itself and travel to wherever that structure is found. (Choice A) A destroyed screening apparatus would leave newly made host-reactive cells surviving against constituents throughout the body, predicting scattered damage rather than a reaction confined to one class of cell surface, and a local mechanical injury has no route to alter the bone marrow and thymus, where new cells are made and tested. (Choice B) Material introduced through a wound could in principle be displayed, but the recovered products lock onto the man's own sperm surface, so the target is a host structure by direct measurement; treating the tissue damage as incidental cannot explain why an organ far from the wound became inflamed. (Choice C) This reduces a question about which targets are treated as acceptable to a question about how many cells are locally present. Numbers govern how vigorous a response is, not whether a structure counts as belonging to the body, and a purely local threshold cannot explain circulating products that seek out the organ on the side that was never struck. This is a Scientific Reasoning and Problem Solving question because it asks the student to infer, from an autoimmune response triggered by injury to an anatomically enclosed tissue, that unresponsiveness toward the host depends on exposure during development rather than on any built-in property of host molecules.$q$,
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
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'scale_unit_error', NULL FROM q;

-- B4 Q16 . Locating the Source of Tissue Damage . easy . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Locating the Source of Tissue Damage$q$,
    $q$A person develops severe swelling and tissue damage within minutes of eating a purified plant protein and requires emergency treatment. The same protein at the same dose produces no measurable change in people who eat it routinely.

What accounts for the harm suffered by the affected person?$q$,
    $q$[{"label":"A","text":"The protein first tears open the tissue it contacts, and the swelling is the repair sequence arriving afterwards."},{"label":"B","text":"The protein is toxic in itself, and the unaffected eaters simply take it up from the gut more slowly."},{"label":"C","text":"The harm is inflicted by the host's own defensive machinery acting on the plant material, so its extent tracks the vigour of that individual's committed reaction rather than any destructive property of the food."},{"label":"D","text":"Damage scales with the mass of protein swallowed, so a trace quantity could not produce injury on this scale."}]$q$::jsonb,
    'C',
    $q$Organ Systems, immune function: this item tests where the tissue damage in a reaction against a harmless environmental molecule actually originates. The answer is C because the identical molecule at the identical dose is harmless in most people, so the variable that decides whether injury occurs sits in the responder and not in the molecule. Adaptive defence works by recognising a shape and then committing effector machinery to whatever carries that shape. Nothing in that machinery evaluates whether the shape belongs to something dangerous; the specificity is for structure, not for threat. Once a lymphocyte population has been selected on an innocuous plant shape, meeting that shape again releases the same vessel-dilating, fluid-leaking, tissue-degrading effectors that would otherwise be aimed at a parasite. Severity therefore scales with how large and how easily triggered that person's committed population is, which is why one eater can be endangered by a quantity another eater never notices.

(Choice A) reverses cause and effect. The swelling is not repair arriving after mechanical injury; it precedes the damage and produces it, and it appears within minutes, far too fast for a wound-healing sequence to have begun.

(Choice B) keeps the cause inside the molecule. If the protein were intrinsically poisonous, a slower rate of uptake would shift the timing of harm but would not abolish it, so routine eaters should show graded damage. They show none at all.

(Choice D) applies a sound idea at the wrong scale. Dose response holds for chemical toxicity, but a host-generated injury is amplified far beyond the trigger that starts it, so trace amounts can produce reactions wildly out of proportion to the mass encountered.

This is a Scientific Reasoning and Problem Solving question because it asks you to locate the source of tissue damage by comparing two sets of people given the identical material and inferring that the causal variable lies in the responder rather than in the substance.$q$,
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
  SELECT q.id, 'A', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'scale_unit_error', NULL FROM q;

-- B4 Q17 . Reading a Prior Contact Patch Panel . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Reading a Prior Contact Patch Panel$q$,
    $q$Substance X and unrelated substance Z are innocuous plant extracts. Four matched groups of volunteers each received one skin patch, and the width of the raised skin area was recorded over four days. Group 4 received a dilute acid instead of a plant extract, as a positive comparison. Widths are in millimetres.

| Group | Skin exposure 3 weeks before | Patch now | 4 h | 24 h | 48 h | 96 h |
|---|---|---|---|---|---|---|
| 1 | none | X | 0 | 0 | 0 | 0 |
| 2 | X | X | 0 | 6 | 14 | 5 |
| 3 | X | Z | 0 | 0 | 0 | 0 |
| 4 | none | dilute acid | 13 | 9 | 3 | 0 |

Which conclusion do these results support?$q$,
    $q$[{"label":"A","text":"The group 2 injury is generated after the patch by a mobilised host population whose reactivity is confined to the material that individual met previously, whereas the group 4 injury is done by the acid itself."},{"label":"B","text":"Volunteers in group 2 are generally more fragile to chemical injury of the skin than volunteers in group 1."},{"label":"C","text":"The delay in group 2 shows that X must build up locally over roughly a day before it reaches a damaging level."},{"label":"D","text":"Group 4 confirms that a patch can injure skin with no prior exposure, so prior exposure is not required for skin injury."}]$q$::jsonb,
    'A',
    $q$Organ Systems, immune function: this item tests reading a four-arm patch panel to decide whether an injury was inflicted by the applied agent or manufactured by the host. The answer is A because the shapes of the two time courses and the two negative arms point the same way. Group 4 shows what direct chemical injury looks like: maximal at four hours and shrinking from then on, because the harm is done at the moment of contact and the body then repairs it. Group 2 shows the opposite profile, nothing at four hours, climbing to a peak at 48 hours and only then receding, which is the signature of an injury that has to be built after the fact by cells that must be summoned and must arrive. Group 1 shows that X is harmless to skin meeting it for the first time, so nothing about the material is intrinsically damaging. Group 3 is the decisive arm: the same primed volunteers are untouched by an unrelated extract, so what they gained from the earlier exposure is not a general vulnerability but a commitment to one structure, which is the defining behaviour of a clonally selected population.

(Choice B) is refuted by group 3. If those volunteers had simply become more fragile, an unrelated patch would mark them too, and Z produced nothing at any time point.

(Choice C) borrows a real pharmacological idea and applies it where the data exclude it. Local accumulation to a toxic level would also occur in group 1, which received the same patch of X for the same period and never marked at all, and accumulation of X would not spare group 3 either.

(Choice D) states something true that does not bear on the question. Nobody disputes that a caustic agent injures naive skin; the acid arm is there to supply a contrasting time course, and it cannot explain why group 2 marked while group 1 did not.

This is a Data-based and Statistical Reasoning question because it asks you to compare the shapes of two time courses and use the two null arms to decide which of the recorded injuries was manufactured by the host rather than by the applied agent.$q$,
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
  SELECT q.id, 'B', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', NULL FROM q;

-- B4 Q18 . Separating Irritant Injury from Host Response . medium . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Separating Irritant Injury from Host Response$q$,
    $q$A worker on a production line forms a red, hardened plaque on the wrist about two days after each shift in which a new solvent touches the skin. Two accounts are on the table: the solvent injures skin directly at the strength used on the line, or the worker's own defence has been mobilised against it. Investigators may run one further test.

Which test would separate the two accounts?$q$,
    $q$[{"label":"A","text":"Apply a tenfold stronger solution to the worker's other wrist and confirm that the plaque is bigger."},{"label":"B","text":"Record whether washing the wrist within one minute of contact shortens how long the plaque lasts."},{"label":"C","text":"Apply the solvent to the worker's back and confirm that a plaque forms there as well."},{"label":"D","text":"Patch a panel of people who have never met it, at the dose used on the line, and count how many of them form a comparable skin lesion."}]$q$::jsonb,
    'D',
    $q$Organ Systems, immune function: this item tests the design of a comparison that separates a host-generated skin reaction from direct chemical injury. The answer is D because the two accounts make sharply different predictions about people meeting the material for the very first time. A caustic agent damages whatever it touches, so if the strength used on the line is enough to burn this worker's skin, it will burn most first-time skin too, and the rate in a fresh panel will be high. A host-generated reaction requires that a responding population already be present and enlarged, and that only follows an earlier meeting, so the rate in a fresh panel will be close to zero. The rate among first-time subjects is therefore the one variable whose expected value differs between the hypotheses, which is exactly what a discriminating test needs. Everything else about the two accounts, the look of the mark, its size and where it sits, is predicted equally well by both, which is why the remaining options cannot decide anything.

(Choice A) A bigger dose gives a bigger mark under either account. Chemical burns are dose dependent, and host-generated reactions are dose dependent as well, so a stronger solution confirms only that more material does more, not what turned the material into an injury.

(Choice B) Cutting the contact time reduces the amount that gets into the skin, and that shrinks a burn and a host reaction alike. This measures exposure, not mechanism.

(Choice C) Testing a second body site establishes only that the responsiveness is not peculiar to the wrist. Both accounts predict a mark wherever an adequate dose is applied, so the outcome is uninformative either way.

This is a Reasoning about the Design and Execution of Research question because it asks you to choose the single comparison group whose expected result differs between a direct-injury explanation and a host-response explanation of the same skin finding.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    3,
    90
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', NULL FROM q;

-- B4 Q19 . Localising Transferable Reactivity to a Blood Fraction . hard . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Localising Transferable Reactivity to a Blood Fraction$q$,
    $q$An office worker forms a firm red patch on the waist two days after each day spent wearing a nickel-plated belt buckle, while a person who has never worn one shows nothing after the same contact. Investigators suspect the capacity to react is carried by something in the circulation and could be handed on to another individual. They may draw and separate a sample of that circulating material from the affected worker, and may apply nickel to the skin of consenting first-time subjects.

Which design would establish which part of the separated sample carries the capacity to react?$q$,
    $q$[{"label":"A","text":"Give one matched first-time host the unseparated material and apply nickel; a reaction proves that the capacity travels."},{"label":"B","text":"Divide the blood into a washed white cell fraction and a cell free plasma fraction, deliver each fraction to its own matched naive volunteer, and then patch both volunteers."},{"label":"C","text":"Return the separated plasma to the affected worker herself and re-apply nickel to her skin."},{"label":"D","text":"Measure how much nickel is present in the plasma of the affected worker at the time the patch appears."}]$q$::jsonb,
    'B',
    $q$Organ Systems, immune function: this item tests the design of a transfer experiment that assigns an acquired reactivity to one component of the circulation. The answer is B because pinning reactivity on a particular carrier requires that the candidate carriers be delivered separately, into separate untreated hosts, and read out the same way. Splitting into a washed cell portion and a fluid portion creates two arms differing in exactly one thing, which portion the host received, so a mark in one arm and not the other assigns the capacity to that portion. Washing the cells matters because it strips carryover fluid, so a positive cell arm cannot be dismissed as fluid contamination riding along. First-time hosts matter because a host that already reacts cannot demonstrate that anything was conferred on it. Delayed skin reactions of this kind in fact travel with lymphocytes rather than with the fluid phase, which is why the two arms behave differently, but the design is selectable without knowing that result in advance.

(Choice A) Unseparated material does establish that the capacity is transferable at all, which is a real and useful result, but it delivers both candidate carriers at once and therefore cannot say which of them is responsible. It answers the earlier question rather than this one.

(Choice C) Returning fluid to the person it came from swaps the stages of the experiment. That person already reacts, so a mark there shows nothing was conferred, and the comparison contains no untreated host at all.

(Choice D) Measuring how much trigger is circulating describes the distribution of the metal, not the location of the capacity to react. A transfer claim needs a host that acquires the capacity, and this measurement never produces one.

This is a Reasoning about the Design and Execution of Research question because it asks you to construct a fractionation and transfer scheme in which the arms differ by exactly one candidate carrier and every readout host begins without the reactivity under test.$q$,
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
  SELECT q.id, 'A', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', NULL FROM q;

-- B4 Q20 . Infection Pattern Pointing to One Arm . easy . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Infection Pattern Pointing to One Arm$q$,
    $q$A three year old has had eight episodes of pus forming bacterial disease of the middle ear and soft tissue, all caused by organisms that grow outside host cells, yet cleared chickenpox, measles and two further viral illnesses on an ordinary schedule. Engulfing white cell counts and overall marrow output are within reference limits. Which missing element best accounts for this history?$q$,
    $q$[{"label":"A","text":"The thymus schooled lineage that inspects fragments shown on the surfaces of other cells and destroys those carrying foreign ones"},{"label":"B","text":"The lineage whose members, once chosen by a matching encounter, export copies of their own recognition molecule into the blood"},{"label":"C","text":"The cells that engulf foreign material and hold pieces of it out on their surfaces for both adaptive lineages to inspect"},{"label":"D","text":"The maturation screens that discard lymphocytes reacting strongly against the body's own molecules"}]$q$::jsonb,
    'B',
    $q$Organ Systems: this item asks you to reason from a pattern of infections back to the adaptive element that is absent. The answer is B because organisms replicating in the fluid outside host cells are reached by exported recognition molecules, and only the lineage that secretes copies of its own surface receptor can supply them. Adaptive defence runs as two parallel outputs from a shared beginning. One output is a soluble molecule released into plasma and interstitial fluid, where it can reach anything sitting outside a cell; the other acts only on cells that exhibit fragments on their surface, which is exactly what an infected cell does. A child who repeatedly loses ground to pus forming organisms living outside cells, yet clears chickenpox and measles on time, has an intact contact dependent output and a missing soluble one. The history is informative precisely because the two outputs reach different physical compartments.

(Choice A) The lineage that examines the surfaces of other cells and kills those exhibiting foreign fragments is the one that clears viral disease. Had it failed, the history would run the other way: trouble with the viral illnesses and comparative competence against organisms in tissue fluid.

(Choice C) A failure of the cells that take up foreign material and hold pieces of it out would indeed compromise defence against bacteria, but it would compromise the antiviral response as well, since both outputs are launched from that upstream display step. Recovery from four viral illnesses on schedule rules it out, and the normal engulfing cell count offers it no support either.

(Choice D) Losing the screens that remove strongly self reactive cells produces attack on the body's own tissues, not an infectious history. That failure changes what the repertoire is aimed at, not whether the repertoire can be deployed against foreign organisms.

This is a Scientific Reasoning and Problem Solving question because it supplies an outcome, a selective vulnerability to organisms in one physical compartment, and asks you to work backwards to the single element whose absence produces exactly that selectivity and no more.$q$,
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
  SELECT q.id, 'A', 'reversed_relationship', $q$mirror-image deficiency$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$upstream shared step offered for a one-sided deficit$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$tolerance mechanism imported into an infection question$q$ FROM q;

-- B4 Q21 . Localising a Block Upstream of Lymphocytes . hard . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Localising a Block Upstream of Lymphocytes$q$,
    $q$Laboratory testing on a young child shows that neither virus infected targets are killed nor the soluble molecules that neutralise bacteria growing in tissue fluid are released. Cells of both adaptive lineages circulate in normal numbers and carry structurally diverse surface receptors, and marrow output is unremarkable. An investigator suspects the block lies upstream of those lineages rather than within them. Which experiment would best localise the failure?$q$,
    $q$[{"label":"A","text":"Sample blood for neutralising molecules before and two weeks after deliberate exposure to a harmless marker substance, testing a healthy donor the same way for comparison"},{"label":"B","text":"Incubate the child's lymphocytes with a purified marker substance and no other cell type, then measure the expansion of each lineage against a healthy donor's lymphocytes treated identically"},{"label":"C","text":"Culture the child's lymphocytes with a healthy donor's ingesting and displaying cells, and separately culture healthy donor lymphocytes with the child's ingesting and displaying cells, giving both the same marker substance"},{"label":"D","text":"Feed labelled bacteria to the child's ingesting cells and to a healthy donor's cells, then count the particles taken up by each population and compare the totals"}]$q$::jsonb,
    'C',
    $q$Organ Systems: this item tests reasoning about how to assign an adaptive failure to the presenting step rather than to the responding cells. The answer is C because only a reciprocal pairing, in which each partner is tested once against a known good counterpart, can reveal which of two interacting populations carries the fault. When both adaptive outputs are absent while the responding cells are present in normal numbers with a diverse receptor set, the economical explanation is that a step both outputs share has been lost. That shared step is the handing over of fragments by cells that take up foreign matter, since the contact dependent output cannot begin without a fragment held out on a surface and the soluble output against protein targets is licensed through that same display. A single culture cannot separate a broken presenter from a broken responder, because a null result is compatible with either. Swapping one partner at a time converts that null result into an assignment, since the response returns in whichever pairing replaces the faulty population.

(Choice A) Sampling the blood before and after exposure documents that one output is missing, which the history already established. Adding a healthy comparison subject calibrates the size of the failure but still measures only the endpoint of the pathway, so it says nothing about which cell within the pathway is at fault.

(Choice B) Offering purified material to the responding cells alone removes the very interaction under investigation. Nothing is learned about the presenter when the presenter has been left out of the vessel, and the lineage that acts on displayed fragments cannot respond to free material in any case.

(Choice D) Counting particles taken up probes uptake, an earlier and separable stage. A cell can ingest normally and still fail at the later job of loading fragments and exhibiting them on its surface, so a normal uptake count would leave the hypothesis untouched.

This is a Reasoning about the Design and Execution of Research question because it asks you to choose the arrangement of experimental arms that assigns a defect to one of two interacting cell populations rather than merely confirming that the defect exists.$q$,
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
  SELECT q.id, 'A', 'adjacent_fact', $q$endpoint assay offered as a localisation experiment$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$free antigen suffices$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$earlier step substituted for the step in question$q$ FROM q;

-- B4 Q22 . Assigning Deficiency Patterns to Immune Arms . medium . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Immune System',
    $q$Assigning Deficiency Patterns to Immune Arms$q$,
    $q$The table gives the mean number of infections per year in four unrelated people, grouped by the class of organism recovered. Person Z has no known immune defect and is included for comparison.

| Person | Pus forming bacteria multiplying in tissue fluid | Prolonged or recurrent viral illness | Deep fungal and yeast disease |
| --- | --- | --- | --- |
| W | 9.0 | 0.4 | 0.0 |
| X | 1.1 | 7.0 | 5.2 |
| Y | 10.2 | 8.1 | 6.0 |
| Z | 1.0 | 0.5 | 0.0 |

Which of the following readings of W, X and Y are supported?

I. W's ordinary rate in the second and third columns argues against loss of a step that both arms depend on.
II. In X, the arm that acts on cells exhibiting fragments of proteins made inside them is the one that has failed.
III. Y's row can be produced by loss of a single element that both arms require, without invoking two separate lineage failures.$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"II only"},{"label":"C","text":"I and II only"},{"label":"D","text":"I, II, and III"}]$q$::jsonb,
    'D',
    $q$Organ Systems: this item tests whether a table of infection frequencies can be read as evidence about which arm of adaptive defence is missing. The answer is D because all three readings survive comparison with the unaffected row. W matches the unaffected person in the viral and fungal columns, and a lost step feeding both arms would have raised those columns too, so reading I holds. X shows a bacterial rate matching the unaffected person alongside prolonged viral episodes and deep fungal disease, which implicates the output that acts on cells holding out fragments of what they are making internally, so reading II holds. Y is raised in every column, and because both outputs are launched from the same upstream handover of fragments, one lost step accounts for the whole row without postulating two rare failures at once, so reading III holds. The unaffected person matters throughout: without that row, a rate of 1.1 bacterial episodes per year in X might be misread as mild susceptibility rather than as ordinary.

(Choice A) Stopping at reading I treats only W's row as interpretable. X departs from the unaffected person in two columns, one by more than tenfold and one in which the unaffected person records no episodes at all, which is at least as much signal as W supplies.

(Choice B) Taking reading II alone implies that W's normal viral and fungal rates carry no information. They carry a great deal, because they exclude the very shared step whose loss would have raised every column, which is what reading I asserts.

(Choice C) Accepting I and II while rejecting III places Y's trouble at two separate late steps. The architecture makes that unnecessary, because a single earlier step feeds both outputs, and the simpler account is preferred when the data do not distinguish them.

This is a Data-based and Statistical Reasoning question because it requires comparing each affected row against an unaffected reference across three organism classes and converting the resulting pattern of differences into an assignment of the missing element.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    4,
    95
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$interprets only the cleanest row$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$treats normal values as carrying no evidence$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$places a shared failure at the wrong stage of the pathway$q$ FROM q;

COMMIT;

-- Verification: the chapter is now COMPLETE. Expect 90 questions and 270 distractor rows.
SELECT
  (SELECT COUNT(*) FROM public.questions WHERE topic = 'The Immune System') AS questions,
  (SELECT COUNT(*) FROM public.question_distractor_metadata m
     JOIN public.questions x ON x.id = m.question_id
   WHERE x.topic = 'The Immune System') AS distractor_rows;

-- Distribution check across the finished chapter.
SELECT difficulty, COUNT(*) FROM public.questions
 WHERE topic = 'The Immune System' GROUP BY difficulty ORDER BY difficulty;
SELECT correct_answer, COUNT(*) FROM public.questions
 WHERE topic = 'The Immune System' GROUP BY correct_answer ORDER BY correct_answer;
