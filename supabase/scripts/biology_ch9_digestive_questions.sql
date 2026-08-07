-- Biology Chapter 9: The Digestive System, standalone questions
-- BATCH 1 of 3 (25 questions): mouth to stomach.
--   Units: what digestion is and where each nutrient class is first attacked . propulsion, mixing
--          and the gut wall . sphincters and one-way flow . the acid-producing machinery .
--          the other gastric cell types and the mucosal barrier . intrinsic factor .
--          the control signals belonging to the stomach
--
-- CHAPTER SIZE: 75 questions, not 100. A Step 1 boundary audit found that most of the CHEMISTRY of
-- digestion is already owned by other chapters (Biochem Ch11 owns fat digestion, bile, micelles,
-- lipase and chylomicrons; Biochem Ch2 owns the enzyme-versus-pH relationship; Biochem Ch4 owns
-- glycosidic hydrolysis; Bio Ch4 owns autonomic control; Bio Ch5 owns insulin, glucagon, ADH and
-- aldosterone; Bio Ch7 owns portal anatomy and lacteal routing; GenChem Ch10 owns acid-base
-- computation). Written naively this is a 110-concept chapter; after the audit it is 75.
-- Precedent: Bio Ch6 Respiratory was forced to 100 against a real density of 85 to 90 and came back
-- about 30 percent redundant. Bio Ch8 Immune was sized honestly at 90 and landed clean.
-- See biology_ch9_digestive_questions.plan.md for the full scope verdict and the 25 boundary rules.
--
-- OFF-OUTLINE CONTENT: the founder explicitly approved naming gastrin, secretin, cholecystokinin,
-- intrinsic factor, vitamin B12, chief and parietal cells, bilirubin and the named sphincters,
-- despite the AAMC outline not listing them, on the same grounds he kept lung volumes in the
-- respiratory chapter: they are standard, heavily tested MCAT content.
--
-- !! BATCH 1 OWNS THE CHAPTER DELETE !! Batches 2 and 3 are pure INSERTs and run after this file.

BEGIN;

DELETE FROM public.questions WHERE topic = 'The Digestive System';

-- Q1 . Intracellular versus luminal digestion . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Intracellular versus luminal digestion$q$,
    $q$A small freshwater invertebrate finishes digesting its meal only after individual cells have engulfed food fragments. A physiologist argues that no animal the size of a human could be fed by this arrangement. Which feature of the human alimentary canal removes that limitation?$q$,
    $q$[{"label":"A","text":"Chemical processing is carried to completion in a lumen open to the outside, so the epithelium needs only to take up single small molecules rather than particles of food."},{"label":"B","text":"Each absorptive cell of the human tract carries far more lysosomes, letting one cell degrade a proportionally larger share of a meal once it has been taken in."},{"label":"C","text":"The human tract is open at both ends rather than at one, so incoming material and waste residue never have to travel in the same direction."},{"label":"D","text":"The absorptive cells of the human tract are replaced every few days, so they can internalize material far faster than the invertebrate cells manage."}]$q$::jsonb,
    'A',
    $q$This item falls under Organ Systems and tests the contrast between finishing a meal inside a cell and finishing it in a space that is continuous with the environment. The answer is A because a human carries chemical breakdown all the way to absorbable units inside a channel whose contents remain topologically outside the body, so the lining is never asked to swallow a piece of food. In the invertebrate arrangement, whatever the secreted enzymes fail to finish must still be brought bodily into a single cell, which caps the size of the largest fragment the animal can use and ties total throughput to the number of cells doing that swallowing. A human instead releases a small volume of concentrated catalyst from a few accessory organs into a long channel, where it acts on the whole meal at once, and the epithelium then moves only single small molecules across itself. That is precisely what makes bulk feeding on large items workable for a large animal. (Choice B) Lysosome number is not the bottleneck. A cell packed with them still has to get the food across its own membrane first, and that is the step that fails for a mouthful of steak, so multiplying the internal degrading machinery does not rescue the strategy. (Choice C) A tract open at both ends is genuinely a human feature and it does permit one way flow and regional specialization, but an animal could have two openings and still leave the final breakdown to its lining cells, so this does not address the size limitation being asked about. (Choice D) Rapid turnover of the lining is true of the human gut, yet a faster replacement schedule does not change how large a piece of food a cell can bring in, and turnover exists to repair wear rather than to feed the animal. This is a Knowledge of Scientific Concepts and Principles question because it asks the student to recall the defining difference between the two digestive strategies and apply it to why body size forces a large animal into one of them.$q$,
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
  SELECT q.id, 'B', 'process_step_confusion', $q$more of the same organelle solves a size problem$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$true anatomical fact offered as a causal explanation$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$fast turnover equals fast uptake$q$ FROM q;

-- Q2 . Physical breakup versus bond cleavage . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Physical breakup versus bond cleavage$q$,
    $q$A person's stomach generates only weak churning waves, so a protein rich meal is pushed onward as intact lumps rather than as a fine suspension. Secretion volumes and enzyme concentrations along the whole tract are normal, and transit time is unchanged. What is the most likely consequence for this meal?$q$,
    $q$[{"label":"A","text":"No change occurs, because the identity of the final products is fixed by which enzymes are present rather than by how the food is handled physically."},{"label":"B","text":"The meal is left essentially untouched, since it is the pounding of the food that severs the links joining one amino acid to the next."},{"label":"C","text":"Only a trivial fraction of the meal is processed, because a lump shields its own interior for the whole of its passage down the tract."},{"label":"D","text":"A larger share of the meal is still unhydrolyzed when it reaches the colon, because catalysts can act only at the exposed boundary of each lump within the time available."}]$q$::jsonb,
    'D',
    $q$This item falls under Organ Systems and tests why physical breakup of food, which creates no new products of its own, still determines how much chemical breakdown gets finished. The answer is D because catalysts reach only the outer boundary of a solid mass, and the gut allows a fixed window of time before material is passed onward. Grinding and churning cut nothing chemically, so on their own they yield nothing absorbable and the meal would leave the body much as it entered. What they do accomplish is to convert one large mass into many small ones, multiplying the amount of food that lies at a boundary a catalyst can reach at any instant. Because residence time downstream is set by motility and not by how coarse the meal is, a fixed clock is running: whatever is not reached before the window closes moves on unhydrolyzed. Weak churning therefore does not change what the products would be, it changes how much of the meal ever becomes product. (Choice A) This is right about product identity, since no physical step alters which bonds an enzyme cleaves, but it wrongly treats the extent of reaction within a limited time as if it were guaranteed. Rate matters here precisely because transit time is stated to be fixed. (Choice B) This reverses the roles of the two kinds of processing. Physical handling changes size and position only, while the covalent links joining amino acids are broken by catalysts, so a meal delivered in lumps is still worked on, just less completely. (Choice C) The right mechanism is taken to the wrong magnitude. A lump does not shield its interior for the whole passage: its outer layer is steadily stripped away, fluid soaks in, and the mass shrinks as it travels, so a substantial fraction is still handled and the deficit is partial rather than near total. This is a Scientific Reasoning and Problem Solving question because it asks the student to hold enzyme supply and transit time constant and predict how a change in particle size alone shifts the completeness of digestion.$q$,
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
  SELECT q.id, 'A', 'partial_truth', $q$final products identical therefore outcome identical$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$chewing breaks chemical bonds$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'scale_unit_error', $q$treating a food mass as impenetrable$q$ FROM q;

-- Q3 . Consequence of staggered first attack . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Consequence of staggered first attack$q$,
    $q$A child produces thick secretions that plug the duct delivering pancreatic juice into the small intestine, while salivary and gastric secretions are normal in volume and composition. Stool testing shows a large unabsorbed residue. Which dietary class contributes most of that residue, and for what reason?$q$,
    $q$[{"label":"A","text":"Carbohydrate, because the mouth supplies only a token amount of amylase and every later step depends entirely on the plugged duct."},{"label":"B","text":"Protein, because the stomach contributes only mixing and acidification, leaving all chain shortening to the secretion that is now blocked."},{"label":"C","text":"Fat, because essentially no cleaving of it had begun anywhere upstream, whereas the other two classes were each already worked on earlier along the route."},{"label":"D","text":"Carbohydrate and protein together, because fat is already dealt with by enzymes that are released before the meal ever reaches the stomach."}]$q$::jsonb,
    'C',
    $q$This item falls under Organ Systems and tests the consequence of the fact that the three dietary classes are first attacked at different points along the tract. The answer is C because triglycerides are the one class with no meaningful head start, so losing the pancreatic contribution leaves them with almost nothing else. Starch meets amylase in the mouth and keeps being worked on in the upper stomach until acid mixes through, and the brush border of the intestinal lining finishes disaccharides on its own. Polypeptides meet acid and pepsin in the stomach, so a good deal of chain shortening has already happened before the duct is reached, and brush border peptidases contribute as well. Triglycerides have neither advantage: the lipases available before the duodenum are quantitatively trivial, and the pancreas is effectively the only source that matters. When a single supply line carries the sole significant catalyst for one class and merely the largest share for the other two, that one class is the one that ends up in the stool. (Choice A) This is genuinely partly right, since pancreatic amylase does most of the starch work, but it overlooks that starch has two other routes, an early one in the mouth and a final one at the lining itself, so it is not the class left most stranded. (Choice B) This ignores what the stomach actually does. Acid and pepsin begin shortening polypeptide chains well before the blocked duct is reached, and the stem explicitly preserves gastric secretion, so protein is not the class without upstream processing. (Choice D) This reverses the actual sequence. Nothing of consequence acts on fat before the stomach, while carbohydrate is the class that does receive attention in the mouth, so the choice swaps which class enjoys the early head start. This is a Scientific Reasoning and Problem Solving question because it asks the student to combine where each class is first attacked with the loss of one secretion and infer which class suffers the largest deficit.$q$,
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
  SELECT q.id, 'A', 'partial_truth', $q$largest contributor mistaken for only contributor$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$all protein digestion happens in the small intestine$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$early and late nutrient classes exchanged$q$ FROM q;

-- Q4 . Quantitative distribution of digestive work . medium . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Quantitative distribution of digestive work$q$,
    $q$The table gives the percentage of each ingested foodstuff that has been reduced to absorbable units at three points along the gut of a healthy volunteer. Of the three, only starch meets a catalyst before the meal is swallowed.

| Sampling point | Starch | Protein | Triglyceride |
| --- | --- | --- | --- |
| Leaving the stomach | 30 | 15 | 8 |
| Mid small intestine | 92 | 84 | 90 |
| Entering the large intestine | 99 | 96 | 98 |

Which conclusion do these data support?$q$,
    $q$[{"label":"A","text":"Protein handling is essentially finished before the material enters the small intestine."},{"label":"B","text":"Where a class is first attacked is a poor guide to where most of its breakdown actually gets done."},{"label":"C","text":"Fat relies on the stomach more heavily than the other two classes do, since its value there is the lowest of the three."},{"label":"D","text":"Starch is handled about twice as fast as protein everywhere in the tract, matching the ratio of the two at the first sampling point."}]$q$::jsonb,
    'B',
    $q$This item falls under Organ Systems and tests whether a student can separate the sequence in which foodstuffs are first attacked from the quantitative distribution of digestive work. The answer is B because starch, the only one of the three with a head start, still gains sixty nine of its ninety nine percentage points after the material has left the stomach. Reading down each column shows the same pattern for all three: single digit to low double digit values at the first sampling point, then values in the eighties and nineties one step later. The entire gain between the first and second rows belongs to the segment beyond the stomach, which means the great majority of the work happens in one place regardless of where a given foodstuff was first touched. Starch is the informative case, since the intuition that an early start implies most of the job is done early is exactly what its numbers contradict. The third row adds only a few more points for each, so even the later gut contributes little by comparison. (Choice A) Fifteen percent is not a finished job. This choice reads the first row as if it were an endpoint and ignores that protein climbs another sixty nine points in the very next segment, so it misjudges the magnitude of what the stomach accomplished. (Choice C) This inverts the relationship the numbers show. The lowest value at the stomach means fat gained the least there and therefore depends on the stomach least, not most, so the choice reads a small contribution as evidence of a large dependence. (Choice D) A two to one ratio at a single sampling point says nothing about relative rates elsewhere, and the two columns close from eight points apart at the middle sample to three points apart at the last, so a fixed speed ratio across the whole tract is not supported. This is a Data-based and Statistical Reasoning question because it asks the student to compare gains between successive rows rather than read single values, and to test a stated expectation about starch's head start against what the columns actually show.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$stomach does the protein job$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', $q$low value misread as high reliance$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'scale_unit_error', $q$single ratio generalized into a constant rate$q$ FROM q;

-- Q5 . Segmentation versus propulsive intestinal motility . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Segmentation versus propulsive intestinal motility$q$,
    $q$A drug given to an anaesthetised animal abolishes the localised ring contractions that repeatedly divide and recombine the contents of the small intestine, while the slowly propagating waves that sweep along the same segment continue unchanged. Food residue reaches the large bowel considerably sooner than in untreated animals. Which further consequence is most likely?$q$,
    $q$[{"label":"A","text":"Enzymes released into the lumen lose their activity, because their release depends on those ring contractions."},{"label":"B","text":"Less carbohydrate and protein crosses the lining, because chyme meets the secretions and the exchange surface less thoroughly and for less time."},{"label":"C","text":"The stomach empties more slowly, because a receiving segment that cannot stir its load cannot accept a new one."},{"label":"D","text":"Uptake of sugars and amino acids rises, because the contents now pass a greater length of wall each minute."}]$q$::jsonb,
    'B',
    $q$This item falls under Organ Systems and tests how two different contraction patterns of the small intestine contribute separately to nutrient uptake and to transit. The answer is B because a wall that can still propagate waves but can no longer shuttle its load back and forth delivers residue onward faster and stirs it far less, and both changes cut the amount of nutrient that gets across the lining. Uptake depends on two things the drug has removed: repeated mechanical contact between the load and the surface that takes up the products of digestion, and thorough dispersal of that load through the fluid released into the lumen. Localised ring contractions do not work by pushing material along; they isolate short pockets, squeeze them, then let them merge again, which is why a marker in that part of the tract barely advances even while contractions are vigorous. Propagating waves do the opposite, displacing the load but presenting each portion to a given stretch of wall only briefly. Deleting the first pattern while keeping the second converts a slow, well stirred exchange surface into a fast, poorly stirred conduit.

(Choice A) Activity of the secreted enzymes does not depend on wall movement. They are released and act on whatever they encounter whether or not the load is being agitated, so nothing here inactivates them.

(Choice C) The rate at which the stomach delivers its load onward is set by feedback from material that has already reached the receiving segment, chiefly how much is sitting there and what it contains. That feedback slows delivery when the segment is full, and this drug empties the segment faster, so if anything the brake is applied less rather than more.

(Choice D) This has the relationship backwards. Passing more wall per minute means less time in contact with any of it, and shorter contact lowers rather than raises the fraction taken up.

This is a Scientific Reasoning and Problem Solving question because it asks the student to predict the absorptive cost of selectively deleting one of two motility patterns while the other is left intact.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$enzyme function wrongly made dependent on motility$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$regulation assigned to the wrong step$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$transit speed inverted against uptake$q$ FROM q;

-- Q6 . Oesophageal transport independent of gravity . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Oesophageal transport independent of gravity$q$,
    $q$A volunteer hangs head down on an inversion table and swallows a barium bolus. Fluoroscopy shows the barium arriving in the stomach about eight seconds later, essentially the same interval recorded in that volunteer sitting upright. Which feature of the oesophageal wall accounts for this result?$q$,
    $q$[{"label":"A","text":"Reduced pressure inside the chest during the swallow draws the swallowed material along."},{"label":"B","text":"Mucus lubrication lets the swallowed material slide along the wall against very little resistance."},{"label":"C","text":"The whole length of the muscular wall shortens at the same moment, squeezing the swallowed material toward the far end."},{"label":"D","text":"A ring of constriction forms behind the swallowed material and travels along at a set rate, mechanically displacing whatever lies ahead of it."}]$q$::jsonb,
    'D',
    $q$This item falls under Organ Systems and tests the mechanism by which the oesophagus moves a swallowed load. The answer is D because an unchanged transit interval in an inverted subject can only hold if the force doing the work is generated by the wall and aimed along the tube, rather than supplied by weight. As the swallow starts, circular muscle just behind the load shortens and pinches the lumen shut, while the wall immediately ahead relaxes and widens to receive it. That closed ring then advances at its own pace, and since the lumen behind it is sealed, the load has nowhere to go but forward. Direction is therefore set by the order in which successive parts of the wall shorten, not by which way is down, so a subject who is inverted, flat or weightless moves the load at close to the same speed. The eight second figure is a property of the travelling ring, not of falling.

(Choice A) Pressure inside the chest does fall during inspiration, but a swallow does not create a suction column that drags a load the whole length of the tube, and any such column would still depend on how the body is oriented.

(Choice B) Lubrication is real and it does lower friction, but lowering resistance is not the same as supplying directed force. A slippery tube with no travelling ring would let an inverted load sit still or drift the wrong way.

(Choice C) A squeeze applied everywhere at once raises pressure equally at both ends of the load and so pushes it in no particular direction. Direction comes from the constriction arising behind the load and then moving, which is exactly the feature this choice deletes by collapsing the sequence into a single simultaneous event.

This is a Knowledge of Scientific Concepts and Principles question because it asks the student to identify the wall mechanism that makes transport through the oesophagus independent of body orientation.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$passive pressure gradient substituted for active propulsion$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$true accessory feature offered as the driving cause$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$correct machinery, sequence collapsed into simultaneity$q$ FROM q;

-- Q7 . Wall layer depth and lost function . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Wall layer depth and lost function$q$,
    $q$An ischaemic injury destroys a complete ring of the jejunal wall and replaces it with inert fibrous tissue. The damage runs from the lumen outward and stops exactly at the outer border of the submucosa, leaving every layer external to that border structurally normal. Which of the following would be lost at that ring?
I. Release of mucus onto the surface facing the lumen
II. Uptake of sugars and amino acids out of the lumen
III. Circumferential narrowing that drives contents toward the colon$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"III only"},{"label":"C","text":"I and II only"},{"label":"D","text":"I, II and III"}]$q$::jsonb,
    'C',
    $q$This item falls under Organ Systems and tests how deep a lesion must reach before propulsion itself fails. The answer is C because the destroyed zone takes in the innermost lining and the connective tissue plate beneath it but stops short of the muscle coats, so the secretory and absorptive work of that ring is gone while its ability to squeeze survives. The tube is built as concentric sleeves. The innermost sleeve carries the epithelium facing the lumen, which both releases mucus and provides the surface across which digested products enter. Immediately outside it lies a dense connective tissue plate carrying vessels and nerves. Outside that sit the muscle coats, whose circumferential shortening narrows the bore and drives the load onward. Converting the two inner sleeves to scar therefore silences items I and II. Item III would fail only if the injury reached the muscle coats, and the stem fixes the outer edge of the damage short of them, so the scarred ring is still squeezed on schedule and the segment stays passable even though nothing crosses it.

(Choice A) Naming only the loss of mucus release is right as far as it goes and then stops halfway. The very sleeve that releases mucus also carries the surface through which sugars and amino acids enter, so the two functions are destroyed together and cannot be separated by this lesion.

(Choice B) This swaps the jobs of the sleeves. It credits the destroyed inner layers with generating the squeeze, when the circumferential narrowing that moves the load is produced further out in the wall, in the part the described injury spares, and it leaves secretion and uptake to coats that do neither.

(Choice D) This treats damage confined to one depth as if it compromised the entire thickness. The stem pins the outer edge of the injury, and functions belonging to layers beyond that edge continue, so scaling the loss up to the whole wall overshoots the level of organisation actually affected.

This is a Scientific Reasoning and Problem Solving question because it asks the student to map a stated lesion depth onto the specific functions that do and do not survive it.$q$,
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
  SELECT q.id, 'A', 'partial_truth', $q$half the correct set selected$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', $q$layer functions swapped inside out$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'scale_unit_error', $q$partial thickness injury generalised to transmural$q$ FROM q;

-- Q8 . Testing intramural signalling in isolated gut . medium . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Testing intramural signalling in isolated gut$q$,
    $q$A 10 cm length of small intestine is excised, flushed clean and suspended in a warmed, oxygenated bath with no remaining attachment to any other tissue. A balloon in the middle of the segment is inflated to a fixed volume. Transducers 3 cm oral and 3 cm aboral to the balloon record a contraction on the oral side and a relaxation on the aboral side, both beginning within a second of inflation. The investigator concludes that the signal coordinating this response is carried within the wall of the segment itself. Which manipulation would test that conclusion most directly?$q$,
    $q$[{"label":"A","text":"Cut the wall through its full thickness between the balloon and one transducer, repeat the inflation, and compare that side's response with the response on the uncut side."},{"label":"B","text":"Move the balloon to the oral end of the segment and record from the aboral transducer alone, then compare with the original recording."},{"label":"C","text":"Replace the bath fluid with a solution of identical osmolarity but no glucose, then repeat the inflation."},{"label":"D","text":"Inflate the balloon to a series of progressively larger volumes and show that both responses grow as volume grows."}]$q$::jsonb,
    'A',
    $q$This item falls under Organ Systems and tests how to isolate the route by which a coordinating signal travels in an isolated length of gut. The answer is A because the claim on trial is a claim about a route, and a route is tested by interrupting it at a defined point and asking whether the response beyond the interruption disappears while the response on the other side survives. Since nothing is attached to the specimen, any contribution from outside it is already excluded, so two accounts remain: something spreads through the wall from the stimulated point to sites on either side, or each recording site is activated on its own without anything passing between them. A cut through the full thickness of the wall between balloon and transducer severs every route running within the wall across that line, while leaving living, contractile tissue on both sides of the cut. If the response beyond the cut disappears while the response on the intact side is unchanged at the same inflation volume, then continuity of the wall between stimulus and recording site is necessary for the response, which is exactly what the conclusion asserts. The uncut side, tested in the same bath at the same moment, is a control built into the preparation, so a lost response cannot be dismissed as the specimen simply dying during the experiment.

(Choice B) Relocating the stimulus and dropping one recording site changes where the stimulus is applied rather than what lies between stimulus and response, and it throws away the two sided comparison that gives the design its discriminating power.

(Choice C) Removing a metabolic substrate probes whether the tissue remains viable. Viability matters, but a response that fails under those conditions would say nothing about which route the signal took to reach either transducer.

(Choice D) Showing that larger inflations produce larger responses characterises how the stimulus is graded. Grading of that kind is equally expected whether something spreads through the wall or each site is activated independently, so the result cannot discriminate between the two accounts.

This is a Reasoning about the Design and Execution of Research question because it asks the student to select the interruption and the internal control that together distinguish a signal conducted through the wall from independent local responses.$q$,
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
  SELECT q.id, 'B', 'process_step_confusion', $q$wrong variable manipulated in an otherwise sensible design$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$viability control offered as a mechanism test$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$dose response mistaken for evidence of a pathway$q$ FROM q;

-- Q9 . Reflux at the oesophagogastric junction . easy . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Reflux at the oesophagogastric junction$q$,
    $q$A patient reports burning chest discomfort that appears only while lying flat after a large meal and fades within a minute or two of sitting upright. Endoscopy shows a slack muscular ring at the junction, an eroded lining just above it, and a completely healthy lining below it. What accounts for the injury falling where it does?$q$,
    $q$[{"label":"A","text":"Lying down removes the downward pull of gravity, so swallowed food itself abrades the upper tube."},{"label":"B","text":"Pressure inside the chest exceeds that in the belly when a person lies flat, so the gradient across the ring points downward and drags at the tube above it."},{"label":"C","text":"A full abdomen sits at higher pressure than the chest, so contents travel backward through the lax ring into a tube that is not adapted to hold them."},{"label":"D","text":"Enzymes made by the pancreas reach the upper tube and dissolve its surface."}]$q$::jsonb,
    'C',
    $q$Organ Systems, and specifically the ring that guards the top of the stomach and the direction in which material crosses it. The answer is C because a filled belly sits at a higher pressure than the chest cavity, and once the ring stops sealing, that difference drives gastric contents upward into a stretch of tube that is not built to hold them. Posture is the clue. Standing puts the chest above the belly and adds gravity to the forces keeping material down, so symptoms ease within a minute or two of sitting up. Lying flat removes that help, and a large meal raises the load in the abdomen further, so the moment the ring goes slack the gradient runs the wrong way and material crosses it. The damage sits on one side of the ring for the same reason: acid stays where it was made unless something pushes it, and only the tissue on the receiving end of that push meets something it never normally encounters. Nothing about the gastric lining itself has changed in this patient, which is why the picture below the ring is unremarkable.

(Choice A) Removing the pull of gravity does not turn food into an abrasive. Solid material moves down the tube in seconds under the muscular wave, whether the person is upright or flat, and mechanical scraping would not produce a burning symptom that tracks meal size and posture so closely.

(Choice B) This reverses the gradient. The chest cavity sits at a lower pressure than the abdomen through most of the breathing cycle, which is exactly why a competent ring is needed at all, and a downward gradient would move material away from the inflamed area rather than onto it.

(Choice D) Pancreatic secretions are delivered into the segment just beyond the stomach, several stages away from the inflamed area, and they would have to cross two separate one way gates to arrive here. Their presence explains neither the posture dependence nor the sharp boundary between damaged and undamaged lining.

This is a Scientific Reasoning and Problem Solving question because it asks the student to take a postural pattern and a sharply bounded area of damage and work backward to the direction in which material must have been moving.$q$,
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
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', NULL FROM q;

-- Q10 . One way flow into the large intestine . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$One way flow into the large intestine$q$,
    $q$An operation for a growth in the wall of the large intestine left the ring guarding its junction with the small intestine permanently open, although no length of small intestine was taken out and biopsy of the remaining bowel is normal. Over the following months the patient loses weight steadily and passes frequent watery stools. Output of digestive enzymes and of bile is measured as normal, and recovery of bile salts and of vitamin B12 at the far end of the small intestine is also normal. Which consequence of the open junction best explains these findings?$q$,
    $q$[{"label":"A","text":"Flow becomes two way, so residue moves on before the surface above has finished taking up nutrients, and colonic contents can wash back into a segment built for uptake."},{"label":"B","text":"The large intestine can no longer reclaim water once the ring is held open, so fluid loss by itself accounts for both problems."},{"label":"C","text":"Residue simply moves onward faster, and the only result is a larger fluid load arriving downstream."},{"label":"D","text":"Returning contents reach the first stretch of small intestine, so it is the very beginning of that organ that is flooded and put out of action."}]$q$::jsonb,
    'A',
    $q$Organ Systems, tested here through the one way gate that separates the last stretch of small intestine from the large intestine. The answer is A because that gate does two jobs at once, holding residue back until the length above has finished taking up what it can, and preventing already processed material from returning into a region whose business is uptake rather than storage. Hold it permanently open and both jobs fail together. Material now crosses whenever a wave arrives, so contact time between residue and the absorptive surface falls, which is enough on its own to explain steady weight loss in a person whose enzyme and bile output is normal. At the same time nothing resists movement in the opposite direction, so watery material from downstream washes back into a region not built to hold it, adding to the fluid that eventually leaves the body. The stem deliberately closes off the competing explanations: chemical digestion is intact, no absorptive length was sacrificed, the lining itself is normal, and the specialised uptake that happens at the far end of the small intestine still works. What has been lost is control over timing and direction.

(Choice B) The large intestine keeps its capacity to reclaim water after this operation. What changes is how fast material arrives and how much of it there is, so the load can exceed what the tissue can handle even though the tissue works normally. This choice also leaves the weight loss entirely unexplained.

(Choice C) Faster onward movement is genuinely part of the story, but stopping there misses the consequence that matters most for body weight. A shorter dwell time above the junction means nutrients that would have been taken up are carried away instead, and the choice also ignores the loss of one way flow in the other direction.

(Choice D) Backflow through an open junction reaches the last stretch of small intestine, not the first, because the junction sits at the far end of that organ. Naming the wrong end also gives the wrong prediction, since a region several metres upstream is untouched by anything crossing that gate.

This is a Scientific Reasoning and Problem Solving question because it asks the student to predict, from the loss of a single gate, two separate physiological consequences and then match them against a described clinical picture.$q$,
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
  SELECT q.id, 'B', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', NULL FROM q;

-- Q11 . Voluntary and reflex control of evacuation . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Voluntary and reflex control of evacuation$q$,
    $q$A spinal injury spares the sensory pathways and the local reflex circuits of the lower cord but abolishes every descending command to the striated muscle of the pelvic floor. The patient still feels the rectum filling. What follows when a mass movement delivers material into the rectum?$q$,
    $q$[{"label":"A","text":"Nothing is released, because both rings open only on a command from the brain."},{"label":"B","text":"Wall stretch alone relaxes the inner ring, and the outer ring cannot be kept shut by choice, so contents pass involuntarily."},{"label":"C","text":"The inner ring tightens as the wall distends, so material is retained until a deliberate effort opens the outer ring."},{"label":"D","text":"The outer ring relaxes first and the inner one then closes, pushing material back up into the colon."}]$q$::jsonb,
    'B',
    $q$Organ Systems, and the unusual case of a gate built from two rings under two different kinds of control. The answer is B because the inner ring answers only to the state of the wall around it and yields once the chamber fills, while the outer ring is the part a person consciously keeps closed, and that is precisely what this patient has lost. The normal sequence runs like this. Filling distends the wall, a circuit in the cord relaxes the inner ring and at the same moment briefly tightens the outer one, and the person then feels the urge and decides. Holding on beyond those first few seconds is an active choice made moment by moment with striated muscle. If the moment is inconvenient the walls relax to accommodate more, the urge fades, and the next mass movement raises the question again. Strip out the descending pathway and only the automatic half of the system survives. The brief guarding contraction still occurs, because the circuit that produces it lies below the injury, but nothing can sustain it once it fades, and the inner ring has already opened. Sensation is intact, so the patient knows what is happening, but knowing is not the same as being able to act on it.

(Choice A) If a conscious command were required to open either ring, an intact person would never be caught out by an urgent one, and infants, who have no such control at all, could not empty. The inner ring is the involuntary half of the pair and needs no instruction from above.

(Choice C) This inverts the response to filling. Distension relaxes the inner ring rather than tightening it, which is why an urge appears at all, and the outer ring is the structure a person opens deliberately rather than the one that yields last.

(Choice D) The two steps are the wrong way round. The automatic response opens the inner ring while briefly tightening the outer one, which is what buys time for a decision, and it does not drive material backward against the wave that delivered it.

This is a Scientific Reasoning and Problem Solving question because it asks the student to separate the automatic and the deliberate halves of one control system and predict what survives when only the deliberate half is removed.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', NULL FROM q;

-- Q12 . Meal composition and emptying rate . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Meal composition and emptying rate$q$,
    $q$Four 500 mL test meals were given to healthy volunteers on separate days, and the time for half the meal to leave the stomach was recorded. Meals 2, 3 and 4 were matched at 250 kcal.

| Test meal | Composition | Half emptying time (min) |
| --- | --- | --- |
| 1 | water only | 12 |
| 2 | carbohydrate | 46 |
| 3 | protein | 58 |
| 4 | fat | 104 |

A second group of volunteers had earlier undergone surgery that left the stomach outlet permanently wide open, and each meal was repeated in that group. In the second group, for which meal would the rate at which contents reach the duodenum be expected to rise the most?$q$,
    $q$[{"label":"A","text":"Meal 1"},{"label":"B","text":"Meal 2"},{"label":"C","text":"Meal 3"},{"label":"D","text":"Meal 4"}]$q$::jsonb,
    'D',
    $q$Organ Systems, examined through measurements of how quickly the stomach hands material on. The answer is D because the table shows that the brake on emptying is set by what is being delivered rather than by how much: all four meals were the same 500 mL, meals 2, 3 and 4 carried the same 250 kcal, and yet the fat meal was held back more than eight times longer than plain water and nearly twice as long as the protein meal matched to it for both volume and energy. An outlet held permanently open cannot apply a brake, so the meal whose delivery rate rises most is the one that was normally restrained most. Since rate of delivery runs inversely to half emptying time, the size of the gain for each meal is roughly its half time divided by the twelve minutes water takes. Water is already close to the fastest anything can leave, so opening the outlet buys almost nothing there. Carbohydrate at 46 minutes and protein at 58 minutes sit in the middle, gaining roughly fourfold and fivefold. Fat at 104 minutes owes almost all of its transit time to restraint, so its delivery rate rises by close to ninefold, the widest margin in the set, and it is also the meal most likely to arrive downstream faster than the next segment can handle it.

(Choice A) Reading the table as a ranking of speed and assuming the quickest meal is the most affected gets the logic backwards. A meal that already leaves in twelve minutes has almost no held back fraction left to release, so the surgical change has its smallest effect here.

(Choice B) The carbohydrate meal is genuinely restrained and its delivery would accelerate, but it is not the extreme case. Choosing it means noticing that meals carrying nutrients are slowed without going on to ask which class of nutrient slows them most.

(Choice C) The protein meal is the closest competitor and stays defensible until the numbers are compared directly. At 58 minutes it is held back rather more than carbohydrate but only about half as long as the 104 minute fat meal, so the largest change does not appear here.

This is a Data-based and Statistical Reasoning question because it asks the student to convert four half emptying times into relative rates of delivery and infer which meal gains most once the step that restrains delivery is removed.$q$,
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
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', NULL FROM q;

-- Q13 . Gastric proton pump energetics and blockade . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Gastric proton pump energetics and blockade$q$,
    $q$An experimental compound concentrates inside the acidic secretory canaliculi of gastric gland cells, where it covalently locks the transporter that exchanges luminal potassium for cytoplasmic hydrogen ions. Twelve hours after a single dose, the fluid in the gastric lumen sits near pH 6 instead of its usual value below 2. Which of the following would be expected in this person?

I. The rate at which the affected cells hydrolyse ATP falls.
II. The bicarbonate output of the exocrine pancreas after the next meal falls.
III. Uptake of vitamin B12 at the terminal ileum stops within the same twelve hours.$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"II only"},{"label":"C","text":"I and II only"},{"label":"D","text":"I, II, and III"}]$q$::jsonb,
    'C',
    $q$Organ Systems, tested here through the energy cost of gastric acid secretion and the events downstream of it. The answer is C because items I and II both follow from silencing an ATP consuming transporter whose product doubles as a signal to the small intestine, while item III does not follow. The cytoplasm of the secreting cell sits close to neutrality, whereas the fluid it delivers into the lumen is normally more than a hundred thousand fold richer in hydrogen ions, and no gradient already present in that cell is steep enough to pay for a climb of that size, so the transporter must couple ion movement directly to ATP hydrolysis rather than ride on an existing sodium or potassium gradient. Locking the transporter shut therefore retires a large and continuous ATP demand, and the rate at which those cells consume ATP falls, which is item I. Item II runs through a separate chain: the arrival of strongly acidic chyme in the first segment of the small intestine is the stimulus that releases secretin, and secretin is what instructs the pancreatic duct cells to deliver bicarbonate rich juice. With luminal contents sitting near pH 6, that stimulus is weak, so the pancreatic bicarbonate response to the next meal is blunted. Item III fails because the glycoprotein escort that vitamin B12 needs in order to be taken up at the terminal ileum is a separate secretory product of the same cells, released by exocytosis rather than by the blocked exchanger, so B12 handling does not halt within hours.
(Choice A) Item I alone is correct but incomplete. Stopping there treats luminal acid as a purely local digestive agent and misses that the same acid is the trigger for the pancreatic bicarbonate response.
(Choice B) Item II alone is likewise correct but incomplete, and it ignores the metabolic consequence of removing the dominant ATP sink from a highly specialised secretory cell.
(Choice D) Adding item III reflects the common belief that any agent shutting off acid abolishes B12 uptake at once. Deficiency can develop slowly for other reasons over long periods, but an acute block of the exchanger does not stop the glycoprotein from being secreted, so uptake does not stop in twelve hours.
This is a Scientific Reasoning and Problem Solving question because it asks the student to trace one molecular blockade outward into a metabolic consequence, a hormonal consequence, and a consequence that does not occur.$q$,
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
  SELECT q.id, 'A', 'partial_truth', $q$correct-but-incomplete Roman numeral set$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$correct-but-incomplete Roman numeral set$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$acid blockade equated with loss of all parietal cell output$q$ FROM q;

-- Q14 . Alkaline tide and secretory stoichiometry . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Alkaline tide and secretory stoichiometry$q$,
    $q$During a meal, blood leaving the stomach is transiently less acidic than the blood arriving in it, and the effect peaks while gastric acid output is maximal. Giving an inhibitor of the enzyme that hydrates carbon dioxide abolishes both the shift in the draining blood and most of the acid output. What do these paired observations indicate about how the secreting cells operate?$q$,
    $q$[{"label":"A","text":"Each hydrogen ion sent into the lumen is generated inside the cell together with one base equivalent, which is then handed to the bloodstream."},{"label":"B","text":"The cells strip acid out of arriving blood and concentrate it in the lumen, leaving the departing blood depleted of it."},{"label":"C","text":"Base released by the exocrine pancreas enters the bloodstream and lowers the acidity of blood draining neighbouring organs."},{"label":"D","text":"Perfusion slows during secretion, so carbon dioxide builds up in the wall and its accumulation raises the pH of the departing blood."}]$q$::jsonb,
    'A',
    $q$Organ Systems, examined through the transport stoichiometry that makes blood leaving an actively secreting stomach transiently alkaline. The answer is A because acid and base are manufactured together in one intracellular reaction, so every unit of acid exported to the lumen obliges the cell to unload a matching unit of base on its other face. Carbonic anhydrase inside the secreting cell joins water to carbon dioxide, and the product immediately yields a hydrogen ion and a bicarbonate ion. The hydrogen ion is the species driven into the lumen, while the bicarbonate has nowhere to go except across the opposite face of the cell into the interstitium and then the vein, typically traded there for a chloride ion that follows the hydrogen ion into the lumen as the counterion of the secreted acid. Because both ions arise from a single reaction, their quantities are matched one for one, which is exactly why the alkalinity of the draining blood tracks the rate of secretion in real time and vanishes when the enzyme is blocked. The pairing of the two observations also settles the mechanistic question: the acid is built on site inside the cell, not harvested from the blood supply.
(Choice B) This is the intuitive picture, that a secreting organ pulls its product out of the circulation, but the second observation contradicts it. If acid were simply being extracted from plasma, blocking an intracellular synthetic enzyme would not abolish secretion, and the departing blood would be expected to lose acid without gaining any base.
(Choice C) The exocrine pancreas does release bicarbonate, but into its duct and therefore into the intestinal lumen, and its own venous blood is left more acidic rather than less. It is a true statement about a different organ that cannot explain a change measured in blood leaving the stomach while the stomach is secreting.
(Choice D) This reverses the direction of the relationship. Carbon dioxide accumulating in a tissue would make the blood draining it more acidic, not less, and perfusion of the gastric wall rises rather than falls when secretion is active.
This is a Scientific Reasoning and Problem Solving question because it asks the student to combine the timing of the venous change with the consequence of removing one enzyme and infer the fixed one to one coupling that must link acid export to base release.$q$,
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
  SELECT q.id, 'B', 'misconception', $q$secretion as extraction from plasma$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$correct physiology of the wrong organ$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$carbon dioxide accumulation given the wrong pH sign$q$ FROM q;

-- Q15 . Limits of gastric absorption . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Limits of gastric absorption$q$,
    $q$A fasted volunteer swallows a modest dose of ethanol along with a starch meal. Ethanol is detectable in the blood within minutes, long before the pyloric sphincter has released any of the meal onward. Which feature of ethanol accounts for its arrival that early?$q$,
    $q$[{"label":"A","text":"It is cleaved by acid into fragments that carrier proteins in the lining recognise and import."},{"label":"B","text":"It is small and uncharged, so it slips across the epithelium by simple diffusion without needing a carrier."},{"label":"C","text":"It is reclaimed alongside water by the same route that recovers fluid from residue later in the tract."},{"label":"D","text":"It dissolves into the mucous coat and departs in the lymphatic vessels of the wall."}]$q$::jsonb,
    'B',
    $q$Organ Systems, tested through the limits of what the stomach can and cannot take up. The answer is B because a small, electrically neutral, lipid soluble molecule dissolves straight through membranes on its own, and passage of that kind needs none of the protein machinery this part of the tract lacks. A sac that holds a meal for hours is built to contain a harsh fluid rather than to harvest from it. Its surface is coated in thick mucus, it is folded into ridges rather than fringed with the fine projections that multiply surface area further along, and it carries very few of the sugar, amino acid and short peptide carriers that make the next segment genuinely absorptive. Nutrients also arrive as polymers and are only partly broken down at this stage, so there would be little for a carrier to move even if one were present. Ethanol bypasses all of that because it partitions readily into membrane lipid and crosses passively down its own gradient, which is why a drink taken on an empty stomach registers so quickly, and why aspirin swallowed by mouth also begins to reach the blood before the stomach has emptied.
(Choice A) Ethanol is not a substrate for digestion. There are no bonds in it for acid or an enzyme to break, and manufacturing fragments for a carrier would be a slower route than the direct one rather than a faster one, so this transplants the macronutrient sequence onto a small solvent molecule.
(Choice C) Bulk recovery of water from residue is a real process, but it happens far downstream and over many hours, once most of the fluid load has already been taken up, so it cannot explain an appearance in blood within minutes of swallowing.
(Choice D) Lymphatic routing is reserved for the large lipid particles assembled inside intestinal cells, which are too bulky to enter blood capillaries. A small water miscible molecule has no need of that pathway and enters the capillary blood of the stomach wall directly.
This is a Knowledge of Scientific Concepts and Principles question because it asks the student to apply the general requirements for crossing an epithelium to one specific molecule at one specific site and to recognise why that site is otherwise a poor absorber.$q$,
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
  SELECT q.id, 'A', 'process_step_confusion', $q$digestion step inserted before a passive uptake$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$true mechanism from the wrong segment$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$lymph routing overgeneralised to any absorbed substance$q$ FROM q;

-- Q16 . Gastric mucosal barrier: acid load versus mucosal defense . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Gastric mucosal barrier: acid load versus mucosal defense$q$,
    $q$A woman with arthritis takes a daily tablet that blocks synthesis of a local lipid messenger, one that normally drives the stomach lining to release alkali and a thick glycoprotein gel. After eight weeks she has shallow gastric erosions, yet her acid output after a test meal is identical to her pre-treatment value, and the erosions heal when a drug that shuts down the parietal cell proton pump is added while she keeps taking the tablet. What do these findings indicate about the origin of the erosions?$q$,
    $q$[{"label":"A","text":"Ordinary quantities of acid became injurious once the covering that keeps the cell surface near neutral pH stopped being renewed."},{"label":"B","text":"The tablet must be pushing acid secretion above its usual level, since blocking that secretion allowed healing."},{"label":"C","text":"The tablet injures the wall directly as each dose dissolves against it, independently of what the cavity contains."},{"label":"D","text":"Release of the alkali and the gel is itself driven by acid arriving at the wall, so with acid output unchanged that layer cannot have been what changed."}]$q$::jsonb,
    'A',
    $q$This Organ Systems item examines the gastric mucosal barrier and how erosions appear when that barrier is undermined. The answer is A because damage developed while the amount of acid delivered to the cavity was unchanged, so the injury must reflect a defense that stopped being replenished rather than an oversupply of hydrogen ions. The wall is shielded by a viscous cover that holds base released by the epithelium against the cell surface, and that trapped base keeps the pH immediately at the cells far higher than the pH a fraction of a millimeter away. The tablet removes the signal that drives production of both the cover and the base held inside it, so the standing pH difference across it collapses and hydrogen ions that used to be neutralized in transit now arrive at living cells intact. The test meal figure fixes the direction of the reasoning: secretion never rose, so the variable that moved was on the protective side of the balance. Healing on a pump blocker fits the same picture, because dropping delivery below the usual amount compensates for a defense that can no longer handle even a usual amount.

(Choice B) Blocking secretion relieves the lesion, but relief on treatment does not establish that secretion had been abnormal to begin with, and the test meal result rules that possibility out directly.

(Choice C) Local contact injury from a dissolving dose is real for some agents, yet contact alone would not be undone by lowering the hydrogen ion load in the cavity, and it cannot explain a lesion that heals while the same dose continues.

(Choice D) This reverses the control described in the stem: the tablet acts on the signal that drives release of the alkali and the gel, so that layer fails whether or not acid output moves, and an unchanged acid figure therefore says nothing about whether the layer was maintained.

This is a Scientific Reasoning and Problem Solving question because it asks the student to work backwards from a lesion that appeared with no change in secretory output and identify failure of mucosal protection, rather than excess secretion, as its origin.$q$,
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
  SELECT q.id, 'B', 'misconception', $q$treatment response mistaken for cause$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$true accessory mechanism promoted to sole cause$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$direction of control between defense and acid inverted$q$ FROM q;

-- Q17 . Epithelial renewal as a component of gastric protection . easy . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Epithelial renewal as a component of gastric protection$q$,
    $q$A patient receives an intravenous agent that prevents cells from completing mitosis. Within a week the stomach lining shows scattered shallow erosions where the layer of cells facing the cavity is missing. Measurements made across that week show that acid output and the volume and alkali content of the secreted gel are unchanged from the values recorded before treatment, and the agent itself is not detectable in the stomach cavity. Which explanation best accounts for the erosions?$q$,
    $q$[{"label":"A","text":"Output of the alkaline gel fell first, so hydrogen ions reached living cells before any cells were lost."},{"label":"B","text":"Cells that divide in the gastric glands are the source of the inactive form of the stomach's protein cutting enzyme, so losing them left the meal undigested and abrasive against the wall."},{"label":"C","text":"The agent is corrosive on contact with the lining, which is why the loss is confined to the innermost cells."},{"label":"D","text":"The surface population is worn away and replaced every few days from a dividing layer deeper in the gland, and that replacement has now stopped."}]$q$::jsonb,
    'D',
    $q$This Organ Systems item examines the part of gastric protection that depends on continuous replacement of the lining rather than on anything secreted. The answer is D because the stem removes one process only, the ability of cells to divide, and shows by direct measurement that the secretory arm of protection is untouched, which leaves loss of replacement as the only available route to a bare surface. The cells facing the cavity are constantly worn away and are normally restocked from a dividing layer deeper in the gland, so the whole surface is turned over in a matter of days. Stop the restocking and the loss continues at its usual rate with nothing arriving to fill the gaps, so within days there are patches where nothing living stands between ordinary gastric contents and the tissue beneath. Acid still does the eroding, but the reason it can is that the covering of living cells is no longer being rebuilt. The timing fits as well: this population turns over faster than almost any other in the body, so a block on cell division shows itself here within a week rather than over months.

(Choice A) The stem states that the volume and alkali content of the gel were unchanged, so the secreted layer is not the arm of protection that failed here.

(Choice B) The inactive form of the stomach's protein cutting enzyme comes from a distinct secretory population deeper in the gland, not from the cells that renew the surface, and undigested food is not what produces these lesions.

(Choice C) The agent was given into a vein and is not detectable in the cavity, so a direct chemical attack on the lining from the cavity side is excluded by the stem.

This is a Scientific Reasoning and Problem Solving question because it asks the student to eliminate the secretory arm of gastric protection using the measurements supplied and attribute the lesions to a halt in epithelial replacement.$q$,
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
  SELECT q.id, 'A', 'process_step_confusion', $q$barrier failure assigned to the wrong protective arm$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', $q$real cell population given the wrong secretory product$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$systemic drug effect attributed to local contact$q$ FROM q;

-- Q18 . A second parietal cell product and the site of B12 uptake . medium . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$A second parietal cell product and the site of B12 uptake$q$,
    $q$Vitamin B12 uptake was measured in four adults. Each swallowed a fixed dose of the pure vitamin dissolved in water, and the percentage taken up into blood was determined. The measurement was then repeated with the same dose swallowed together with an extract of healthy human gastric juice from which the acid had been removed. Peak acid output was measured separately.

| Subject | Peak acid output (mmol/h) | B12 taken up, dose alone (%) | B12 taken up, dose plus extract (%) |
|---|---|---|---|
| Healthy control | 23 | 62 | 63 |
| Six months on a proton pump blocker | 2 | 55 | 57 |
| Selective destruction of the acid secreting cells | 1 | 6 | 58 |
| Final 60 cm of small intestine surgically removed | 22 | 4 | 5 |

What do the data indicate about why uptake fails in the third subject?$q$,
    $q$[{"label":"A","text":"The collapse in hydrogen ion output is itself what stops the vitamin from being taken up."},{"label":"B","text":"The absorbing lining of the last stretch of small intestine has been destroyed in that subject as well."},{"label":"C","text":"The lost cell population also supplies a carrier that B12 must travel with, and the absorbing surface itself is still functional."},{"label":"D","text":"The carrier comes from the absorbing lining and the stomach is where B12 crosses into blood, so the third and fourth subjects have the same defect at different sites."}]$q$::jsonb,
    'C',
    $q$This Organ Systems item uses paired uptake measurements to separate the acid producing job of a gastric cell population from a second product of those same cells. The answer is C because the subject whose acid secreting cells were destroyed takes up almost nothing from a dose given alone, 6 percent against 62 percent in the control, yet reaches 58 percent when the same dose is swallowed with an extract of normal gastric juice that has had its acid removed. Something in that extract, and not the acid, is what was missing. The row for the drug settles the alternative: acid output there is 2 against 23 in the control, a near total loss, and uptake is still 55 percent, so removing acid by itself does not block uptake. The final row shows the opposite pattern, acid output normal at 22 but uptake stuck at 4 percent alone and 5 percent with the extract, which is the signature of a lost absorbing surface that no added material can rescue. Reading the three rows against the control, the destroyed population must release something besides acid that B12 has to be bound to, and in the third subject the downstream surface that does the absorbing is intact and simply has nothing arriving in usable form.

(Choice A) The drug row rules this out: hydrogen ion output there is essentially gone, 2 against 23, yet 55 percent of the dose is still taken up, so a collapse in acid output is not on its own enough to stop uptake.

(Choice B) Destruction of the absorbing lining is what the fourth subject shows, where the extract changes nothing; for the third subject it is refuted by the rescue to 58 percent, because a missing absorptive surface cannot be restored by adding material to a swallowed dose.

(Choice D) This swaps the two roles. If the carrier came from the downstream lining, adding an extract of gastric juice could not have rescued the third subject, and the fourth subject would have been the one rescued by it.

This is a Data-based and Statistical Reasoning question because it requires comparing three affected rows against a control across two uptake columns to decide, for each one, whether the deficit lies in a missing secreted component or in the absorbing surface itself.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$acid assumed to be the only relevant gastric product$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', $q$finding true of one row transplanted onto another$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$source of carrier and site of uptake interchanged$q$ FROM q;

-- Q19 . Gastric reservoir capacity and meal size . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Gastric reservoir capacity and meal size$q$,
    $q$In one operation for gastric cancer the stomach is removed and a narrow loop of jejunum is sewn in to join the esophagus straight to the duodenum. The absorptive lining downstream is left untouched and pancreatic output is unchanged. After recovery the patient can no longer finish a meal of ordinary size and instead eats six small meals a day. Which property lost with the removed organ best accounts for the new eating pattern?$q$,
    $q$[{"label":"A","text":"The surface across which most of a meal's nutrients enter the blood"},{"label":"B","text":"A chamber that accepts a large load at low internal pressure and releases it forward gradually"},{"label":"C","text":"The fine projections that multiply contact area for nutrient uptake"},{"label":"D","text":"The enzyme that starts the breakdown of protein"}]$q$::jsonb,
    'B',
    $q$This Organ Systems item tests the stomach as a holding chamber and contrasts that role with the arrangement that serves uptake further along the canal. The answer is B because only the missing organ could take in a whole meal at one sitting and hand it on in measured portions, and a slim loop of bowel sewn into its place can do neither. An empty stomach is about the size of a fist, yet its wall can take in several liters, because the ridges of the lining smooth out and the wall lengthens instead of being put under tension. Volume therefore climbs steeply while the pressure inside barely moves, which is why a healthy person can swallow a large plate of food in minutes without discomfort. Emptying is then metered forward over roughly two to four hours, so the next segment receives a trickle rather than a flood. A conduit of fixed width has neither behavior: it fills at once, tension in its wall rises immediately, and the person stops eating long before a normal portion is gone.

(Choice A) Very little of a meal actually crosses the gastric lining. Water, alcohol and a few small drugs enter there, but essentially all carbohydrate, protein and fat uptake happens beyond it, and the stem states that this downstream lining was spared. Losing a surface that was never doing the absorbing cannot explain the change.

(Choice C) The fine projections that multiply contact area sit in the segment that was deliberately preserved, so they were never lost. Their job is also the wrong one: they raise the area available for uptake per unit length, which is a very different thing from raising how much the canal can hold at one moment.

(Choice D) Losing the protein splitting enzyme of the stomach is real, but proteases delivered into the duodenum complete protein breakdown perfectly well, and the stem tells you that pancreatic output is unchanged. A digestive shortfall of this kind would show up as poor nutrition over months, not as an immediate ceiling on how much food fits in one sitting.

This is a Knowledge of Scientific Concepts and Principles question because it asks the student to apply the concept of a low pressure holding chamber to a case in which that chamber has been replaced by a tube of fixed width.$q$,
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
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', NULL FROM q;

-- Q20 . Two lesion routes to one deficiency . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Two lesion routes to one deficiency$q$,
    $q$A patient develops anemia with abnormally large red cells together with numbness in the feet, traced to lack of one water soluble vitamin. The same picture appears after the entire stomach has been taken out, and it also appears after the last stretch of small bowel has been resected. In both cases injected replacement corrects the problem while swallowed doses of ordinary strength do not. Why do lesions at opposite ends of the canal converge on the identical deficiency?$q$,
    $q$[{"label":"A","text":"The nutrient is taken up along the whole length of the canal, so losing any long section drops total uptake below need"},{"label":"B","text":"Both operations speed the passage of material so that it sweeps past the absorbing surface too quickly"},{"label":"C","text":"Both operations remove tissue in which the nutrient is held in store between meals"},{"label":"D","text":"Uptake needs a carrier protein released at one site and a receptor present only at the other, so failure of either step closes the single route available"}]$q$::jsonb,
    'D',
    $q$This Organ Systems item tests the two station relay that moves vitamin B12 out of the gut, and it asks the student to reason backwards from a deficiency to either of two very different lesions. The answer is D because absorption of this vitamin depends on a glycoprotein made in the upper organ binding it and on a docking site restricted to the far end of the small bowel taking the pair up, so knocking out either station shuts the same and only pathway. Intrinsic factor is the one gastric product that nothing else in the body can supply, which is why total gastrectomy is survivable in every other digestive respect yet still ends in this deficiency. The complex it forms is then endocytosed at receptors confined to the terminal ileum, a site restriction that has no backup elsewhere in the canal. Because the vitamin is banked in the liver in quantities that cover ordinary needs for years, the deficiency surfaces long after the operation, which is exactly why the same late picture can follow two operations performed at opposite ends of the tube. Injection works in both patients because it bypasses the entire relay.

(Choice A) If uptake were spread along the whole canal, then removing a short terminal length would matter little and removing a large midsection would matter most. The observed pattern is the reverse: a short terminal resection is devastating while much longer resections elsewhere are not, which shows the route is site restricted rather than distributed.

(Choice B) Faster transit does shorten contact time and can reduce uptake of several nutrients, but it would blunt absorption broadly rather than singling out one vitamin, and it would not explain why an oral dose fails while an injected dose succeeds.

(Choice C) The gut wall is not the storage depot for this vitamin. Reserves are held in the liver, which is untouched by either operation, and a lost store would be exhausted within days rather than producing the years long lag actually observed.

This is a Scientific Reasoning and Problem Solving question because it hands the student an outcome shared by two anatomically opposite lesions and requires working backwards to the one serial pathway that both of them interrupt.$q$,
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
  UNION ALL SELECT q.id, 'C', 'misconception', NULL FROM q;

-- Q21 . Localising a vitamin absorption defect . medium . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Localising a vitamin absorption defect$q$,
    $q$A patient absorbs almost none of a swallowed dose of one nutrient, and the fault could sit either in the stomach or in the far end of the small bowel. Investigators give a radiolabeled dose by mouth, follow it with an injected unlabeled dose large enough to saturate the body's binding sites so that whatever is taken up spills into the urine, and record the fraction of label excreted over 24 hours. Several days later they repeat the whole procedure with purified intrinsic factor swallowed alongside the same dose. Which pattern of results would point to the stomach rather than the bowel as the site of the fault?$q$,
    $q$[{"label":"A","text":"Little label in the first run and just as little in the second"},{"label":"B","text":"Ample label in the first run and little in the second"},{"label":"C","text":"Little label in the first run and an amount inside the normal range in the second"},{"label":"D","text":"Little label in the first run and even less in the second"}]$q$::jsonb,
    'C',
    $q$This Organ Systems item tests the logic of a two condition test built to separate a secretory fault from an uptake fault, using urinary appearance of a label as the readout. The answer is C because the second run supplies from outside the body exactly the one thing a diseased stomach fails to make, so if the label now appears normally the missing piece must have been that secreted product and the downstream wall must be healthy. The design changes one variable only between runs, which is what makes the comparison interpretable: the dose, the route, the saturating injection and the collection window are all held constant while the added glycoprotein is switched on. A wall that lacks working docking sites cannot use supplied carrier either, so in that patient the supplement changes nothing. Each patient therefore serves as their own control, removing between person differences in body reserves that would otherwise blur the readout. Note that the urinary measure is only a proxy for absorption, so it assumes stable kidney function across the two runs, an assumption worth checking before either result is trusted.

(Choice A) This is precisely the result expected from the alternative lesion. Supplying carrier to a wall that cannot bind and internalise the complex leaves the block untouched, so an unchanged result points away from the organ named in the question rather than towards it.

(Choice B) Ample label on the first run contradicts the premise that almost nothing is absorbed, and a fall after adding carrier reverses the direction the manipulation should push. The order of events is scrambled: the supplement is meant to rescue a failed run, not spoil a successful one.

(Choice D) A further drop would mean the added carrier actively worsened uptake, which the mechanism gives no reason to expect. Supplying a limiting component can restore or fail to restore a process, but it should not push it below the level seen without it.

This is a Reasoning about the Design and Execution of Research question because it asks the student to interpret a within patient two condition comparison in which a single supplied component is the only manipulated variable and to map each possible outcome onto a candidate lesion.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    3,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', NULL FROM q;

-- Q22 . Feed forward gastrin release by peptides . easy . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Feed forward gastrin release by peptides$q$,
    $q$Three test loads plus a saline control, all of equal volume and all buffered to the same starting pH, were placed directly into the stomachs of fasted volunteers through a tube that bypassed the mouth. Plasma concentration of the antral hormone and acid output were then measured over the following hour.

| Instilled load | Plasma hormone (pg/mL) | Acid output (mmol/h) |
| --- | --- | --- |
| Saline only | 25 | 2 |
| Peptone, a partly broken down egg albumin | 95 | 22 |
| Glucose | 28 | 3 |
| Long chain lipid emulsion | 27 | 3 |

What does this pattern indicate about how the stomach sets its acid output?$q$,
    $q$[{"label":"A","text":"Acid delivery is scaled to the class of food that acid is required to break down, so the arriving meal commissions its own digestive capacity."},{"label":"B","text":"Acid delivery tracks the total energy content of the instilled load, independent of what that load is made of."},{"label":"C","text":"Acid delivery is driven by mechanical stretch of the gastric wall rather than by the chemical composition of what arrives."},{"label":"D","text":"The hormone rises because acid already formed in the lumen feeds back to increase further release of that hormone."}]$q$::jsonb,
    'A',
    $q$This item sits in Organ Systems and tests feed forward control of gastric acid secretion by the hormone released from antral endocrine cells. The answer is A because only the load that acid is needed to process raised both the hormone value and the acid measurement, while equally large volumes of the other two loads left both essentially at control level. Every instillation was matched for volume and for starting pH, and every one bypassed the mouth, so wall stretch, lumen acidity and anticipation were all held constant across the four conditions. The one variable left free is the chemical class of the load, and only the partly broken down egg albumin, which supplies short peptides and free amino acids, moved either number. Those peptides act on antral endocrine cells to release gastrin, which drives the proton pump of parietal cells to secrete hydrochloric acid. Note the direction of the arrangement: the products of protein breakdown announce that protein has arrived and call up the acid that will finish the job, so the stomach builds capacity for work still to come rather than correcting a shortfall after the fact. A purely corrective loop would have to wait for evidence that digestion was already falling behind.

(Choice B) Energy content cannot be the variable. Glucose and the lipid emulsion both carry calories, yet neither moved the hormone value more than 3 pg/mL above the saline control, so caloric load and the response come apart cleanly in this data set.

(Choice C) Stretch is a genuine stimulus in an intact stomach, but the design deliberately matched the instilled volumes, so distension was identical in all four conditions and cannot explain an elevenfold difference in the acid measurement.

(Choice D) This runs the loop backwards. Accumulating acid does not amplify release of this hormone; falling luminal pH is the signal that shuts release down, which is why acid secretion in a healthy stomach is self limiting rather than runaway.

This is a Data-based and Statistical Reasoning question because the student must read four measured conditions against one another, notice which variables the protocol already held constant, and isolate the single remaining variable that accounts for the pattern.$q$,
    'easy',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    4,
    85
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'misconception', $q$calories drive everything$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$true stimulus, held constant by design$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$loop run backwards$q$ FROM q;

-- Q23 . Acid negative feedback on gastrin release . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Acid negative feedback on gastrin release$q$,
    $q$Luminal pH was clamped at each of three values by controlled infusion while blood was sampled for the antral hormone. One patient with recurrent duodenal ulceration was studied alongside healthy volunteers; imaging and biopsy showed a normal parietal cell mass in both groups.

| Clamped luminal pH | Hormone, healthy (pg/mL) | Hormone, patient (pg/mL) |
| --- | --- | --- |
| 5.5 | 90 | 420 |
| 3.0 | 45 | 430 |
| 1.5 | 15 | 425 |

Which additional finding should be expected in this patient?$q$,
    $q$[{"label":"A","text":"Acid formation will be low despite the raised hormone value, because the target cells have become unresponsive to that hormone."},{"label":"B","text":"Acid formation continues near its maximum for hours after a meal has left, because nothing switches the drive off."},{"label":"C","text":"The raised hormone value will settle into the healthy range after a day of fasting."},{"label":"D","text":"Acid formation will peak after eating and then fall back on the usual timetable, with only the resting value altered."}]$q$::jsonb,
    'B',
    $q$This item sits in Organ Systems and tests the negative feedback limb that terminates release of the antral hormone once gastric contents become sufficiently acidic. The answer is B because the patient's value is flat across a ten thousand fold change in hydrogen ion concentration, which means the acidity signal never reaches the cells that release the hormone, so nothing in the system ever calls a halt. In the healthy volunteers the value falls from 90 to 15 pg/mL as pH is driven from 5.5 down to 1.5, the signature of a closed loop in which the product of a response cancels the stimulus for that response. Losing that limb does not weaken the drive. It deletes the only thing that ever stopped it. With a normal parietal cell mass being pushed continuously by an unopposed signal, acid formation persists close to its ceiling long after the meal that started it has gone, and the duodenum receives an acid load it was never built to buffer, which is why recurrent ulceration is the presenting complaint. The general lesson is worth holding: an open loop of this kind does not run low or oscillate, it runs flat out.

(Choice A) This inverts cause and effect. Unresponsive target cells would give a high hormone value with a low acid measurement, but the study explicitly reports a normal parietal cell mass, and a stomach making little acid would not ulcerate the intestine downstream of it.

(Choice C) Fasting removes the meal related stimulus, not the defect. The patient already sits at 425 pg/mL at pH 1.5, conditions under which a healthy volunteer has switched release almost entirely off, so an empty stomach cannot normalise the value either.

(Choice D) A normal timetable requires an intact off switch, and the data show precisely that switch missing. The rise after eating can still occur, but the fall depends on the limb that is absent, so recovery cannot follow the usual schedule.

This is a Data-based and Statistical Reasoning question because the student must compare two response curves across a clamped independent variable, recognise a flat curve as a missing feedback limb rather than as a raised set point, and project that reading forward to a consequence not shown in the table.$q$,
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
  SELECT q.id, 'A', 'reversed_relationship', $q$target resistance instead of missing brake$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$assumes the drive is meal dependent$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$correct rise, wrong fall$q$ FROM q;

-- Q24 . Gut somatostatin as secretory brake . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Gut somatostatin as secretory brake$q$,
    $q$Endocrine cells scattered through the mucosa of the stomach and duodenum release gut somatostatin, which diffuses a short distance to neighbouring cells and restrains them. A compound is developed that abolishes release of gut somatostatin throughout the gut while leaving every stimulatory pathway intact. A healthy volunteer takes the compound and then eats a standard meal.

Which of the following would be expected?

I. The stomach would deliver chyme into the duodenum faster than in the untreated state.
II. Pancreatic enzyme delivery to the duodenum for the same meal would be greater than in the untreated state.
III. The stomach would fail to increase its secretion when the meal arrived.$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"II only"},{"label":"C","text":"I and II only"},{"label":"D","text":"I, II and III"}]$q$::jsonb,
    'C',
    $q$This item sits in Organ Systems and tests what a single inhibitory signal contributes when it restrains more than one organ at once. The answer is C because the brake released by these mucosal cells holds back both the emptying of the stomach and the exocrine output of the pancreas, so subtracting it releases both, yet it cannot abolish a response driven by pathways the compound never touched. Statement I holds because the cells releasing the brake sit in the wall of the stomach and duodenum, exactly where the rate of handover between them is set, and with the restraint gone the stomach pushes its contents onward faster than the intestine would normally allow. Statement II holds because the same signal, released from the duodenal mucosa, damps the exocrine pancreas, so removing it leaves a larger enzyme delivery for an identical meal. Statement III fails on the stated terms of the experiment, since every stimulatory pathway is untouched and a meal will still recruit secretion, in fact more of it than usual. The general point is that losing a brake is not the same as losing a response: a disinhibited system is more responsive, not less, and one paracrine restraint distributed along the mucosa lets several organs be pulled back together rather than one at a time.

(Choice A) Statement I alone is incomplete. It captures the faster handover to the intestine but stops at the stomach, ignoring that the same signal is released from duodenal mucosa and restrains the exocrine pancreas as well.

(Choice B) Statement II alone is incomplete in the mirror image way. It captures the larger enzyme delivery but ignores that the brake also holds back gastric emptying, which is the step immediately upstream of it.

(Choice D) Including statement III contradicts the premise of the experiment. The compound was specified to leave stimulatory pathways intact, so responsiveness to a meal is preserved and, if anything, exaggerated rather than lost.

This is a Scientific Reasoning and Problem Solving question because the student must take a stated lesion in one arm of a control system and predict the direction of the change at two separate effector organs, while rejecting the claim that removing an inhibitor removes the response itself.$q$,
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
  SELECT q.id, 'A', 'partial_truth', $q$one target organ only, stomach$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$one target organ only, pancreas$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$any inhibitor loss abolishes regulation$q$ FROM q;

-- Q25 . Cephalic phase anticipatory gastric secretion . medium . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Cephalic phase anticipatory gastric secretion$q$,
    $q$An investigator asks whether the gastric mucosa can be switched on by something other than the meal itself. Fasted dogs are fitted with a cannula that drains gastric juice, and the rate of drainage is recorded each minute. Four protocols are proposed. Which one can settle the question?$q$,
    $q$[{"label":"A","text":"Deliver the meal through the cannula while the dog neither sees nor tastes it, and compare drainage with a resting baseline."},{"label":"B","text":"Compare drainage during an inert saline load with drainage during an equal load of real food, both delivered through the cannula."},{"label":"C","text":"Let the dog eat normally and record whether drainage rises within the first minute after the first bite."},{"label":"D","text":"Let the dog see, smell and chew a favoured meal while a diversion keeps every mouthful out of the stomach, then compare drainage with a resting baseline."}]$q$::jsonb,
    'D',
    $q$This item sits in Organ Systems and tests the design logic required to show that gastric juice production begins before the meal reaches the organ that produces it. The answer is D because it is the only protocol in which nothing whatever reaches the target organ, so any rise in drainage must have been generated by seeing, smelling and chewing the food rather than by its arrival. That is the substance of the cephalic phase: secretion is commissioned on a prediction that food is coming, not as a response to food that has come, and the only way to demonstrate anticipation is to make arrival impossible while leaving the anticipatory cues fully in place. Comparing against the same fasted dog at rest supplies the baseline drainage against which the rise is judged. The causal chain is cut at a known point, so arrival is excluded by construction and anticipation is the only explanation left standing.

(Choice A) Delivering the meal while the dog neither sees nor tastes it isolates the opposite half of the system. It is a clean test of the response to arrival, and it deliberately strips out the very cues whose contribution the investigator set out to measure.

(Choice B) Comparing an inert load with a real one asks whether the response depends on what arrived rather than on how much arrived. That is a useful control for a different question, and in both conditions material reaches the target organ, so neither arm can speak to anticipation.

(Choice C) Timing the rise after the first bite is suggestive but not decisive. Some of the food has already been swallowed by then, so an early rise cannot be assigned to anticipation rather than to the first material to arrive, and the two candidate causes remain confounded.

This is a Reasoning about the Design and Execution of Research question because the student must select, from four protocols, the one whose control structure eliminates the rival explanation and leaves anticipation as the only surviving cause of the measured rise.$q$,
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
  SELECT q.id, 'A', 'process_step_confusion', $q$isolates the later stage instead$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', $q$valid control for a different question$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$early timing without a clean cut$q$ FROM q;

COMMIT;

-- Verification: expect 25 questions and 75 distractor rows.
SELECT
  (SELECT COUNT(*) FROM public.questions WHERE topic = 'The Digestive System') AS questions,
  (SELECT COUNT(*) FROM public.question_distractor_metadata m
     JOIN public.questions x ON x.id = m.question_id
   WHERE x.topic = 'The Digestive System') AS distractor_rows;
