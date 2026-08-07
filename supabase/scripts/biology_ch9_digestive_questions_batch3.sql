-- Biology Chapter 9: The Digestive System, standalone questions
-- BATCH 3 of 3, FINAL (25 questions): absorption, liver and bile, colon and vitamins.
--   Units: peptide uptake and a missing brush-border enzyme . the diffusion barrier and carrier
--          limits . the biliary tree as a plumbing system . bilirubin from liver to stool .
--          the water budget and why it fails . gut bacteria as a metabolic organ .
--          the vitamin machinery and which lesions break which vitamins
--
-- This file completes the chapter at 75 questions.
--
-- !! RUN AFTER BATCHES 1 AND 2 !!
-- No DELETE here: batch 1 owns the chapter-scoped DELETE. Re-running this file alone would
-- duplicate its 25 questions.

BEGIN;

-- B2 Q1 . Peptide uptake outpacing free amino acids . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Peptide uptake outpacing free amino acids$q$,
    $q$An investigator perfuses an isolated loop of jejunum with three solutions in turn, each supplying an identical load of glycine presented in a different form. Venous drainage from the loop is collected for 30 minutes after each perfusion, and its total glycine content, free plus peptide bound, is measured. Flow rate and perfusate volume are the same in all three runs.

| Solute perfused | Glycine units supplied (mmol) | Glycine units in drainage over 30 min (mmol) |
| --- | --- | --- |
| Free glycine | 30 | 12 |
| Glycylglycine | 30 | 21 |
| Glycylglycylglycine | 30 | 25 |

What accounts for the ordering of the three drainage values?$q$,
    $q$[{"label":"A","text":"Every bond in the chained forms is broken at the brush border before anything crosses into the cell, so all three solutions are ultimately handled by the same free amino acid carriers."},{"label":"B","text":"The chained forms enter the cell intact on a carrier separate from the free amino acid carriers, energised by an inward hydrogen ion gradient, and are split into single units only after entry."},{"label":"C","text":"The chained forms enter the cell intact and pass unchanged into the blood, where circulating enzymes release the individual units."},{"label":"D","text":"The difference reflects the greater molecular mass of the chained forms rather than any difference in how many units were taken up."}]$q$::jsonb,
    'B',
    $q$This item sits in Organ Systems and tests the absorptive step that follows protein digestion in the small intestine. The answer is B because the two unit and three unit chains cross the apical membrane intact on a carrier of their own, driven by an inward hydrogen ion gradient rather than by the sodium gradient that serves free amino acids, and they are cleaved to single units only once inside the cell, so a single carrier cycle moves two or three units inward instead of one. Compare the third column against an identical supplied load: 12, then 21, then 25 units out of 30. If every bond had to be broken at the surface before anything crossed, the three solutions would be indistinguishable by the moment transport began, and the three values would converge on one number. They do not converge, and recovery climbs with chain length, which points to a parallel route with its own capacity that competes neither for binding sites nor for the sodium gradient used by the free amino acid carriers. The hydrolysis step has not been skipped; it has been relocated to the cytosol.

(Choice A) If surface hydrolysis preceded all uptake, the three solutions would present the same species to the same carriers, and the three collected values would be equal. A clear rank order appears instead, so this cannot be the explanation.

(Choice C) The cleavage step is real but is placed one compartment too far downstream. Peptidases inside the absorptive cell split the chains before they leave it, so what reaches the blood is already free amino acid. Note that the assay counts glycine whether free or peptide bound, so the measurement itself cannot rescue this choice; it fails on where the cleavage happens.

(Choice D) Mass was not the quantity measured. Both the supplied load and the collected load are reported in the same units of substance, so a heavier molecule cannot by itself inflate the third column.

This is a Data-based and Statistical Reasoning question because it asks the student to compare three collection values measured against one identical supplied load and to infer from their rank order which absorptive route the chained forms must be using.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$everything-is-broken-down-first$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$right-process-wrong-compartment$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'scale_unit_error', $q$mass-versus-moles$q$ FROM q;

-- B2 Q2 . Two lumen consequences of disaccharidase loss . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Two lumen consequences of disaccharidase loss$q$,
    $q$An adult reports bloating and loose stools within two hours of drinking milk. Testing shows that her intestinal brush border no longer produces the enzyme that acts on the sugar in milk, while her pancreatic secretions and bile output are normal. What accounts for her symptoms?$q$,
    $q$[{"label":"A","text":"The undigested disaccharide remains in the lumen, retains fluid there osmotically, and reaches colonic bacteria that ferment it into gas and small organic acids."},{"label":"B","text":"The disaccharide is taken up intact by the epithelium and cannot be metabolised, so it builds up inside the absorptive cells and injures them."},{"label":"C","text":"The disaccharide is split normally in the lumen, but the freed single sugars cannot be picked up by their carriers and build up instead."},{"label":"D","text":"The defect shortens the microvilli and lowers total absorptive surface, so every class of nutrient is absorbed poorly."}]$q$::jsonb,
    'A',
    $q$This item sits in Organ Systems and tests the consequence of losing a membrane anchored step of carbohydrate handling. The answer is A because a sugar that is never cleaved cannot be picked up by any single sugar carrier, so it stays behind as an osmotically active particle and is delivered onward to the microbial population of the large bowel. Two consequences follow from that one failure. Solute retained in the lumen raises the osmolarity of the intestinal contents, so water moves down its own gradient into the lumen rather than out of it, and the volume arriving downstream exceeds what can be reclaimed there. The intact sugar is also a ready substrate for resident microbes, and their fermentation of it yields gas plus small organic acids, so the bowel distends and further osmotically active particles are added to the load. Because the pancreatic and biliary contributions are stated to be intact, fat and protein handling are untouched, which is why the picture is confined to what follows a milk load.

(Choice B) Nothing is taken up intact here. Two sugar units joined together are not substrates for the single sugar carriers of the absorptive membrane, so the sugar never reaches the interior of the cell and no intracellular accumulation occurs.

(Choice C) This puts the failure one step too late. The cleavage itself is what has been lost, so there are no freed single sugars waiting for a carrier; the carriers themselves are working normally.

(Choice D) Losing one membrane enzyme does not remodel the absorptive surface. Surface area is unchanged, and uptake of amino acids, other sugars and fat breakdown products proceeds normally, which is why the trouble is specific to this one dietary sugar.

This is a Knowledge of Scientific Concepts and Principles question because it asks the student to apply the concepts of osmotic solute retention and microbial fermentation to predict what an unabsorbed luminal sugar will do.$q$,
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
  SELECT q.id, 'B', 'misconception', $q$disaccharide-crosses-membrane$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$transport-blamed-for-hydrolysis-loss$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$surface-loss-substituted-for-enzyme-loss$q$ FROM q;

-- B2 Q3 . Redundant bulk uptake versus unique distal recovery . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Redundant bulk uptake versus unique distal recovery$q$,
    $q$A surgeon removes 50 cm of small intestine from the jejunum of one patient and 50 cm from the far end of the ileum of another. Both patients go on to absorb the bulk of a mixed meal normally, but only the second develops specific nutrient deficiencies over the following months. Which difference between the two regions explains this outcome?$q$,
    $q$[{"label":"A","text":"The far end holds most of the intestine's absorptive area, so taking it costs more capacity than taking an equal length from further up."},{"label":"B","text":"Contact between contents and epithelium lasts longest in the final segment, so losing it shortens exposure equally for every nutrient."},{"label":"C","text":"Capacity for bulk uptake is duplicated along a long proximal stretch, whereas a few dedicated recovery mechanisms sit only in a short terminal zone and exist nowhere else."},{"label":"D","text":"Chemical breakdown of food is completed in the final segment, so losing it leaves nutrients incompletely broken down when they arrive in the large bowel."}]$q$::jsonb,
    'C',
    $q$This item sits in Organ Systems and tests how absorptive work is distributed along the length of the small intestine. The answer is C because the machinery for taking up sugars, amino acids and fat breakdown products is spread redundantly over metres of upper intestine, so losing a short piece of it costs almost nothing, whereas a small number of specialised uptake mechanisms are confined to the last stretch and have no backup upstream. The pattern in the two patients is exactly what redundancy predicts: remove one copy of a widely duplicated function and the remaining copies take up the work, but remove the only copy of a unique function and that function is simply gone. Vitamin B12 is the clearest instance. It is too large to cross by simple diffusion, so it is carried by a binding partner made further up the tract and is taken into the epithelium by receptors that occur only in the terminal segment. Capacity for that route is set by the number of those receptors, not by sheer surface area, so nothing is gained by spreading it out, and no amount of remaining proximal intestine can substitute once the receptor bearing segment is gone.

(Choice A) This reverses the actual distribution. Absorptive area is greatest in the upper intestine, where the mucosal folds are present and the villi are tallest and most crowded, and it declines toward the end, so the region whose removal caused deficiencies is not the region carrying the most surface.

(Choice B) Even if residence time were longer in the last segment, a uniform loss of exposure would blunt uptake of everything a little rather than knock out a short list of substances while leaving the bulk of the meal absorbed normally. The observed selectivity rules out a uniform effect.

(Choice D) This misplaces a stage. Cleavage of the meal is essentially finished well before the end of the small intestine, and the material entering the large bowel is already residue, so the deficiencies cannot come from unfinished breakdown.

This is a Scientific Reasoning and Problem Solving question because it asks the student to work backwards from two contrasting surgical outcomes to the underlying difference in how absorptive functions are distributed along the organ.$q$,
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
  SELECT q.id, 'A', 'reversed_relationship', $q$surface-gradient-flipped$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', $q$transit-time-substituted-for-specificity$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$digestion-finished-at-the-end$q$ FROM q;

-- B2 Q4 . Aqueous diffusion barrier at the absorptive surface . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Aqueous diffusion barrier at the absorptive surface$q$,
    $q$A poorly mixed sheet of fluid sits against the intestinal lining and turns over only slowly, so any solute must cross it by random thermal motion before it can touch the membrane. A hydrophobic drug given as free molecules arrives at the brush border far more slowly than its very high measured permeability through artificial lipid bilayers would predict. Which of the following would increase the rate at which drug molecules reach the brush border?

I. Delivering the drug in a preparation that keeps a much higher amount of it dissolved close to the epithelium
II. Modifying the drug so that its partition coefficient into membrane lipid doubles
III. Increasing local agitation right at the mucosal face so the stagnant zone becomes thinner$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"I and III only"},{"label":"C","text":"II and III only"},{"label":"D","text":"I, II, and III"}]$q$::jsonb,
    'B',
    $q$This Organ Systems item tests the poorly mixed film of fluid that stands between the gut contents and the absorptive cell, and how to work out which step in a two stage journey sets the overall rate. The answer is B because only items I and III act on the step that is actually limiting, which is passage through water rather than passage through lipid. Movement across a stagnant film is diffusive, so the number of molecules delivered per second rises with the concentration difference that drives the diffusion and falls as the film gets deeper. A greasy compound holds only a very small amount in true aqueous solution, so the concentration term is minute no matter how eagerly the compound partitions into lipid once it arrives. That is precisely why such a compound is given in a vehicle that keeps it dissolved: the vehicle does not push it through the membrane, it simply keeps far more of it available in the watery gap immediately outside. Item I raises the driving concentration, item III shortens the path, and both therefore raise delivery. Item II speeds a step that was never the bottleneck, and speeding a step that is not rate limiting leaves the overall rate essentially where it was.
(Choice A) Item I does belong in the answer, but this choice stops halfway. Delivery across a diffusive gap depends on two terms, the driving concentration and the thickness of the gap, and item III manipulates the second of them. Naming only one of two valid interventions is correct as far as it goes but incomplete.
(Choice C) Item III belongs, yet pairing it with item II reflects the common assumption that the lipid bilayer must be the obstacle for a fat loving molecule. The stem already reports that the compound crosses artificial bilayers readily, so the membrane step is fast, and making a fast step faster changes little. This choice also discards the solubility intervention that matters most.
(Choice D) This choice adds item II to the two correct interventions. It treats every plausible sounding change as helpful rather than asking which single step governs the rate, and it therefore fails the discrimination the question is built around.
This is a Scientific Reasoning and Problem Solving question because it asks the student to identify which of two sequential steps limits delivery and then predict which manipulations act on that step rather than on the step that is already fast.$q$,
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
  SELECT q.id, 'A', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', NULL FROM q;

-- B2 Q5 . Designing a test for carrier mediated uptake . hard . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Designing a test for carrier mediated uptake$q$,
    $q$Investigators perfuse matched loops of rat jejunum with a water soluble vitamin at graded luminal doses and record how much reaches the venous effluent each minute. The rate climbs steeply over the low range, then flattens so completely that raising the dose further adds nothing. A reviewer counters that the flat portion may only mean the strongest solutions injured the loops. Which single follow up experiment would answer the reviewer and at the same time support a protein assisted route?$q$,
    $q$[{"label":"A","text":"Warm the perfusate by ten degrees and show that transfer of the test solute rises at every dose in the series, including the doses on the flat portion"},{"label":"B","text":"At the top dose, show that an inert passively absorbed tracer still crosses the loops at exactly the rate it shows at the lowest dose"},{"label":"C","text":"Repeat the entire dose series in a second species and confirm that transfer flattens at the same point on the curve in both preparations"},{"label":"D","text":"At the top dose, strip sodium from the perfusate and show that transfer of the test solute collapses while an inert passively absorbed tracer crosses at its usual rate"}]$q$::jsonb,
    'D',
    $q$This Organ Systems item tests the difference between a route that depends on a protein and on a supplied energy source and unassisted movement through lipid, and how to build a follow up study that separates a real mechanism from an artifact. The answer is D because it collects two readings from the same loops at the same top dose: a viability reading that stays normal if the tissue is healthy, and an energy source reading that only a protein coupled route can fail. Many nutrients cross the apical surface bound to a protein that simultaneously carries sodium down its steep inward electrochemical gradient, so the sodium gradient, not the nutrient gradient, supplies the work. Take the sodium out of the lumen and that gradient disappears, and transfer disappears with it. Unassisted passage through the lipid of the membrane has no such dependence, so it would continue regardless of which ion sits in the lumen. Injured tissue would also stop taking up a solute, which is exactly why the flat portion on its own is ambiguous. The inert tracer crossing at its usual rate in the very same loops shows the epithelium is intact, so the collapse cannot be blamed on damage. One experiment therefore settles both the objection and the mechanism.
(Choice A) Raising the temperature accelerates almost everything that depends on molecular motion, unassisted diffusion through lipid included. A higher rate at every dose is therefore compatible with either mechanism, and this design also says nothing about whether the strongest solutions damaged the tissue.
(Choice B) This is a sound viability control and it does dispose of the reviewer's objection, so it is attractive. It stops short, though, because a flat response in a demonstrably intact loop still leaves the cause open. Ruling out injury is necessary but not sufficient, and nothing here shows that the route depends on a protein or on an energy supply.
(Choice C) Reproducing the flattening in another species speaks to reliability rather than to cause. A reproducible artifact is still an artifact, so this design neither excludes tissue damage nor provides evidence about mechanism, and reproducibility alone cannot arbitrate between the two competing explanations.
This is a Reasoning about the Design and Execution of Research question because it asks the student to select the follow up whose internal control eliminates an alternative explanation while the same manipulation independently tests the proposed transport mechanism.$q$,
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
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', NULL FROM q;

-- B2 Q6 . Shared carrier competition between similar nutrients . easy . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Shared carrier competition between similar nutrients$q$,
    $q$In an isolated brush border preparation, leucine uptake falls by half when isoleucine is added at high concentration, but is unaffected when equal concentrations of lysine or glucose are added. A student swallows a purified leucine capsule with water alone on one day, and in the middle of a large steak dinner on another day. Compared with the water only day, leucine appearing in the bloodstream over the next hour on the steak day will most likely be:$q$,
    $q$[{"label":"A","text":"reduced, because the meal releases chemically similar molecules that vie for a limited number of binding sites"},{"label":"B","text":"unchanged, because a protein assisted route always operates at its maximum rate whenever its substrate is present"},{"label":"C","text":"raised, because the extra amino acids liberated by the meal drive the transport step to run faster"},{"label":"D","text":"reduced, but only after the amino acids liberated by the meal have been cleared from the lumen"}]$q$::jsonb,
    'A',
    $q$This Organ Systems item tests what it means for two nutrients to share one uptake route and how that plays out when a supplement meets a full meal. The answer is A because the preparation data show a shape selective interaction: one branched neutral amino acid interferes with another, while a charged amino acid and a sugar do not. That pattern points to a finite set of sites that recognize a particular shape rather than to a general slowdown, since a general slowdown would have been produced by lysine and glucose too. Digesting a steak floods the lumen with the very class of molecules that interfered in the dish, so the supplement now has to share those sites and a smaller fraction of the dose is picked up in any given interval. Notice that the student is never told which molecules a steak yields, so the inference runs from the selectivity pattern to the composition of the meal to the predicted outcome.
(Choice B) This assumes that an assisted route runs flat out whenever anything it recognizes is nearby. Occupancy is what sets the rate, and occupancy is shared, so when several recognized molecules are present at once each one gets a smaller share of the available sites. The data in the stem already contradict this, since leucine uptake was measurably depressed.
(Choice C) This has the right variables pointing the wrong way. Extra molecules that fit the same site do not recruit the site to work harder, they occupy it. A route of this kind has no mechanism for being urged along by a rival substrate, and the isolated preparation showed suppression rather than stimulation.
(Choice D) This turns a simultaneous contest into an orderly queue. Molecules do not wait their turn in the lumen, they arrive at the sites at rates set by their relative amounts and by how tightly each is bound, so the interference is happening during the meal rather than afterward. The direction is right but the timing and the mechanism are misplaced.
This is a Scientific Reasoning and Problem Solving question because it asks the student to read a selectivity pattern from a laboratory preparation and use it to predict how a real meal will change the uptake of a supplement taken with it.$q$,
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
  SELECT q.id, 'B', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', NULL FROM q;

-- B2 Q7 . Storage capacity from bile concentration . medium . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Storage capacity from bile concentration$q$,
    $q$A fasting volunteer's bile is sampled from the tube leaving the liver and from inside the gallbladder during the same procedure, and the liver's output rate and the gallbladder's holding volume are recorded.

| Measurement | Value |
| --- | --- |
| Bile salt concentration, bile leaving the liver | 30 mmol/L |
| Bile salt concentration, gallbladder bile | 300 mmol/L |
| Rate of bile formation by the liver | 600 mL per day |
| Volume the gallbladder holds when full | 50 mL |

When completely full, the gallbladder contains approximately what share of the bile salt the liver puts out in one day?$q$,
    $q$[{"label":"A","text":"About 8 percent"},{"label":"B","text":"About 17 percent"},{"label":"C","text":"About 83 percent"},{"label":"D","text":"About 0.8 percent"}]$q$::jsonb,
    'C',
    $q$This question sits in the Organ Systems category and tests how a small storage organ accommodates the continuous output of a much larger secretory one. The answer is C because a full gallbladder holds 50 mL at 300 mmol/L, which is 15 mmol of bile salt, while the liver delivers 600 mL at 30 mmol/L, or 18 mmol, across a day, and 15 out of 18 is five sixths, or about 83 percent. The two concentration figures differ by a factor of ten, and that factor carries the whole argument: the lining of the storage organ pulls water and small ions out of the fluid it receives, so the volume collapses while the solutes left behind rise in proportion. Storage capacity therefore has to be judged in amount of solute, not in millilitres. Judging by volume alone would suggest the organ could bank only a sliver of a day's production, whereas stripping out roughly nine tenths of the water lets it bank most of it. The same reasoning predicts that stored fluid is not simply fresh fluid in a smaller container: compared with fresh fluid it is far richer in whatever the lining cannot reabsorb and correspondingly poorer in water and in the ions that leave with it.

(Choice A) About 8 percent is the ratio of the two volumes, 50 mL against 600 mL. It treats millilitres as though they measured amount of bile salt and discards the tenfold concentration difference the table supplies.

(Choice B) About 17 percent is the leftover share, the portion of a day's output that one filling could not accommodate. It is the complement of the quantity asked for rather than the quantity itself.

(Choice D) About 0.8 percent comes from attaching the higher concentration to the fluid leaving the liver and the lower one to the stored fluid. That reversal contradicts the measurements, since the water absorbing lining sits downstream of the liver and acts on fluid that has already left it.

This is a Data-based and Statistical Reasoning question because it requires converting two concentrations and two volumes into amounts of solute and then forming a ratio, rather than reading any single value off the table.$q$,
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
  SELECT q.id, 'A', 'scale_unit_error', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', NULL FROM q;

-- B2 Q8 . Pump failure versus open outlet in bile delivery . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Pump failure versus open outlet in bile delivery$q$,
    $q$In an anaesthetised animal, a drug is infused that abolishes contraction of the gallbladder wall while leaving the smooth muscle ring at the shared outlet into the duodenum free to relax normally. The liver goes on forming bile at its usual rate. A fatty meal stimulus is then delivered into the duodenum. What is the most likely result?$q$,
    $q$[{"label":"A","text":"Delivery into the gut is unchanged, because relaxation of the outlet ring by itself paces the arrival of bile"},{"label":"B","text":"Bile still trickles into the gut at the rate the liver forms it, but no concentrated surge arrives and duct pressure stays low"},{"label":"C","text":"Pressure climbs steeply inside the bile ducts and bile backs up toward the liver"},{"label":"D","text":"No bile whatever reaches the gut, because every drop of delivery depends on the squeezing wall"}]$q$::jsonb,
    'B',
    $q$This Organ Systems item tests how a reservoir and a gated outlet divide the work of delivering bile. The answer is B because moving fluid along a tube needs two separate things, a driving force and an open path, and this preparation has removed only the first of the two big contributions to the driving force while leaving the path wide open. The liver secretes bile continuously and its own secretion pressure still pushes that fluid forward, so a slow trickle keeps arriving in the gut. What is lost is the stored volume, which normally leaves as a concentrated surge when the wall squeezes, so the meal is not met by any surge at all. Because the exit is open, nothing dams up behind it and the pressure inside the ducts stays at its low resting value. The mirror image lesion, a wall that squeezes normally against an outlet held shut, also fails to deliver the stored volume, but there the effort is converted into pressure instead of flow and the ducts distend. That pressure difference is the practical way to tell a pump problem from an outlet problem.

(Choice A) This treats the outlet ring as the sole determinant of delivery. Relaxing the ring supplies a path but supplies no force to move the stored volume through it, so the meal receives only the liver's ongoing trickle rather than the usual surge, and delivery is therefore not unchanged.

(Choice C) This is the picture produced by the opposite lesion, an outlet that will not open. Pressure can only build when the fluid has nowhere to go, and here the exit relaxes normally, so there is no obstruction for the liver's output to back up against.

(Choice D) This overstates the role of the reservoir. The wall is needed to expel stored bile, but it is not the only source of forward pressure, since bile leaving the liver can still travel through an open outlet on its own.

This is a Knowledge of Scientific Concepts and Principles question because it asks the student to apply the principle that flow requires both a driving force and an open exit to a specific pairing of a muscular reservoir with a gated outlet in the biliary system.$q$,
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
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', NULL FROM q;

-- B2 Q9 . One duct lesion, two downstream consequences . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$One duct lesion, two downstream consequences$q$,
    $q$A patient develops a stone firmly lodged in the single duct that carries bile from the liver and gallbladder into the small intestine, so that nothing passes it. The liver cells, the gut lining and the lifespan of the patient's red blood cells are all normal. Over the next several days, blood work and the appearance of the patient's bowel movements are recorded. Which pair of findings is expected, and why?$q$,
    $q$[{"label":"A","text":"Blood pigment rises, and the stools darken beyond their usual colour, because the trapped pigment is redirected into the gut"},{"label":"B","text":"Blood pigment stays normal, and the stools turn pale, because the liver has stopped making the pigment"},{"label":"C","text":"Blood pigment rises, and the stools keep their usual colour, because gut bacteria manufacture the brown colouring themselves"},{"label":"D","text":"Blood pigment rises, and the stools turn pale, because the block traps the pigment upstream and starves the gut of it"}]$q$::jsonb,
    'D',
    $q$This Organ Systems question tests the reasoning that a single interruption in a one way excretory route produces paired consequences, one upstream of the block and one downstream of it. The answer is D because that duct is the only route by which this pigment reaches the gut, so plugging it both traps the pigment behind the plug, where it spills into the circulation, and prevents it from reaching the bacteria that convert it into the brown compound responsible for normal stool colour. The upstream half follows from the fact that liver cells go on processing and exporting the pigment whether or not the exit is open, so with nowhere to go it accumulates and enters the blood, which is what yellows the skin and the whites of the eyes. The downstream half follows from the fact that the intestinal bacteria are converters rather than producers: they act on pigment that arrives from above, so if nothing arrives, nothing is made and the stools lose their colour. Because the stem rules out any change in red cell turnover and any failure of the liver cells themselves, both findings must be traced to the mechanical block rather than to overproduction or to failed synthesis. Once the liver has processed it the pigment is water soluble, so some of the retained material leaves in the urine and darkens it, but that is a leak around the edges and not an alternative route into the gut. Recognising that one lesion explains two seemingly unrelated observations is the point of the item.

(Choice A) The upstream half is right and the downstream half is inverted. Stool colour depends on how much pigment arrives in the gut, not on how much is held back, and a duct that admits nothing cannot redirect anything into the intestine.

(Choice B) This keeps the pale stools but attributes them to a halt in production. The stem specifies normal liver cells and a normal red cell lifespan, so production continues and the retained material has to appear somewhere, which is why blood levels do not stay normal.

(Choice C) This treats the gut bacteria as the source of the pigment rather than as the step that modifies it. They work on material delivered from above, so blocking delivery removes their substrate and the stools cannot keep their normal colour.

This is a Scientific Reasoning and Problem Solving question because it asks the student to derive two consequences running in opposite directions, retention behind the block and deprivation beyond it, from one anatomical lesion while excluding the alternative causes that the stem rules out.$q$,
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
  SELECT q.id, 'A', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', NULL FROM q;

-- B2 Q10 . Consequence of being the first processing stop . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Consequence of being the first processing stop$q$,
    $q$A drug taken by mouth crosses the intestinal lining without being altered, and every molecule absorbed must pass through the liver before it can reach any other tissue. The identical dose given directly into a vein produces a peak level in the general circulation several times higher than the swallowed dose does, and far more of the unaltered drug is later recovered in the urine after the injected dose than after the swallowed one. Which property of the liver do these observations demonstrate?$q$,
    $q$[{"label":"A","text":"It can chemically modify a large share of an ingested substance before the rest of the body is exposed to it"},{"label":"B","text":"It slows the rate at which molecules cross the gut lining into the blood"},{"label":"C","text":"It holds the drug temporarily and later releases it unchanged, so total exposure is the same by either route"},{"label":"D","text":"It passes onward more of the unchanged drug than it receives"}]$q$::jsonb,
    'A',
    $q$This Organ Systems question tests the functional payoff of the liver occupying the first processing position for material taken up from the gut. The answer is A because the two routes differ in exactly one respect, whether the dose passes the liver before entering the general circulation, and the route that does pass it yields both a lower peak and less unaltered drug recovered afterwards, which is the signature of chemical conversion rather than of delay or of storage. Loss of material, not merely rearrangement of its timing, is what the recovery figure reports, and only a step that changes the molecule can destroy the original form. A substantial fraction is therefore converted on the way through, so the rest of the body sees a smaller and chemically different load than the gut delivered. That positional advantage is what allows the liver to intercept ingested toxins before they are distributed, and it is also why the effective swallowed dose of many compounds must exceed the injected dose.

(Choice B) This locates the limitation at the wrong step. Slowing absorption would flatten and delay the rise in blood level without destroying any drug, so the amount of unaltered drug eventually recovered would still match the injected dose, and the stem separately states that the lining passes the molecule unchanged.

(Choice C) Temporary holding is a real capability of the organ, but it cannot account for the data. Storage followed by release shifts when the drug appears without removing any of it, so total recovery of the unaltered form would be preserved, which contradicts the urine finding.

(Choice D) This states the relationship backwards. Blood leaving after the first pass carries less unaltered drug than it brought in, which is precisely why the swallowed route produces the lower peak at an equal dose.

This is a Scientific Reasoning and Problem Solving question because it asks the student to compare two routes of administration that differ in a single respect and to infer, from a lower peak combined with reduced recovery of the unaltered molecule, that conversion rather than delay explains the difference.$q$,
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
  SELECT q.id, 'B', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', NULL FROM q;

-- B2 Q11 . Hepatic modification enabling pigment excretion . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Hepatic modification enabling pigment excretion$q$,
    $q$Hepatocytes attach two sugar-acid groups to bilirubin before pumping it into the bile canaliculus. In a newborn whose enzyme for this step is still immature, the pigment builds up in blood bound to albumin and very little of it reaches bile. Which property of the pigment does this hepatic step alter so that the molecule can leave the body in a watery secretion?$q$,
    $q$[{"label":"A","text":"It lowers the pigment's toxicity so that cells lining the gut are not injured on contact."},{"label":"B","text":"It splits the pigment's four-ring backbone into fragments small enough to cross the membrane."},{"label":"C","text":"It makes the pigment hydrophilic enough to stay dissolved in bile without a carrier protein."},{"label":"D","text":"It strengthens the pigment's binding to albumin so that more can be delivered per unit of blood."}]$q$::jsonb,
    'C',
    $q$This Organ Systems item tests what the liver does chemically to bile pigment and why the unaltered form cannot appear in a watery secretion at all. The answer is C because the sugar-acid groups added inside the hepatocyte make the pigment hydrophilic, so it stays dissolved in bile on its own rather than depending on a protein to hold it in solution. Bilirubin as it arrives at the liver is a flat, largely nonpolar molecule that is essentially insoluble in body water, which is exactly why it must travel bound to albumin and why the free level in blood stays vanishingly low. Attaching two glucuronic acid units hangs charged, hydroxyl-rich sugars onto the molecule and converts it into a species that dissolves readily in an aqueous fluid. Only after that change can the hepatocyte pump it into the bile canaliculus and have it remain in solution all the way to the duodenum. When the conjugating enzyme is immature, the unaltered form accumulates on albumin instead, and albumin-bound material is not pumped into bile, so essentially none of it appears downstream, which is the picture described. (Choice A) Handling the pigment does reduce its ability to enter cells and do harm, and the unaltered form is genuinely neurotoxic in a newborn, but toxicity is not the property that permits secretion. A harmless molecule that is still insoluble could not be carried away in a watery fluid, so this choice names a real benefit that does not answer what was asked. (Choice B) The four-ring backbone is not cleaved in the liver. Ring opening happens earlier, when heme is degraded, and further breakdown happens later, once bacteria in the colon attack what has been excreted, so this choice moves a real event to the wrong stage. (Choice D) The relationship runs the opposite way. The modified pigment binds albumin far more weakly, precisely because a water soluble product no longer needs a carrier, and it is the unmodified form that is tightly held by albumin. This is a Knowledge of Scientific Concepts and Principles question because it asks the student to name the chemical property a hepatic modification changes and to state why that change is the prerequisite for putting the pigment into an aqueous secretion.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$detoxification-instead-of-solubility$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', $q$right-process-wrong-stage$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$binding-direction-inverted$q$ FROM q;

-- B2 Q12 . Pattern separating obstruction from red cell loss . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Pattern separating obstruction from red cell loss$q$,
    $q$Three adults were evaluated for yellow sclerae and the panel below was obtained. Laboratory reference limits are a water-soluble fraction below 0.3 mg/dL and an albumin-bound fraction below 0.8 mg/dL.

| Adult | Water-soluble fraction (mg/dL) | Albumin-bound fraction (mg/dL) | Urine urobilinogen | Stool colour |
|---|---|---|---|---|
| J | 0.2 | 4.8 | raised | dark brown |
| K | 5.4 | 0.5 | absent | pale grey |
| L | 0.2 | 0.6 | normal | brown |

Adults J and K both have a raised total. Which reasoning correctly identifies the one whose duct is blocked?$q$,
    $q$[{"label":"A","text":"J, because a high albumin-bound fraction shows that export out of the liver cell has failed."},{"label":"B","text":"K, because material that the liver has processed is backing up while none of it reaches colonic bacteria."},{"label":"C","text":"K, because the sum of the two fractions is larger than the sum in the other adult's row."},{"label":"D","text":"J, because dark stool shows that the pigment is being concentrated upstream of a narrowing."}]$q$::jsonb,
    'B',
    $q$This Organ Systems item tests the pattern of findings that separates a closed outflow route from a heavy load arriving at a working liver. The answer is B because adult K's row shows the form that the liver has finished handling piling up in blood at the same time that the gut receives none of it, a combination that is only possible if the route from liver to intestine is shut. Once the hepatocyte adds sugar-acid groups it pumps the water soluble product into bile. If the duct is obstructed that product cannot leave, so it refluxes into blood and the water-soluble fraction climbs while the albumin-bound fraction stays within its reference limit, exactly as in row K. Because nothing arrives in the colon, resident bacteria make no urobilinogen and no stercobilin, so the faeces lose their brown pigment and turn pale, and the urine loses the urobilinogen that is normally reabsorbed from the colon and cleared by the kidney. Adult J shows the mirror image: the albumin-bound fraction is high, yet the liver is plainly still delivering pigment downstream, since urobilinogen is raised and the stool is dark. The magnitude of the total is therefore useless for localising the lesion; only the split between the two fractions read together with the evidence of intestinal delivery does the job. (Choice A) This inverts the direction of the reasoning. A failure to export from the hepatocyte would raise the water-soluble fraction, because the sugar-acid groups have already been added by that point, so a high albumin-bound fraction points to a step earlier than the modification, not to the duct. (Choice C) This reaches the right adult by the wrong route. The sums are 5.9 for K and 5.0 for J, so the statement is numerically true, but a total concentration is only a magnitude, and magnitude alone cannot tell you where along the path the pigment is stuck. (Choice D) Dark stool is positive evidence that pigment is reaching the colon and being converted there by bacteria. A blocked duct produces the opposite finding, the pale grey stool seen in row K, so this choice reads the colour backwards. This is a Data-based and Statistical Reasoning question because it asks the student to compare rows of a laboratory panel and decide which combination of fraction split and downstream colour, rather than which single largest number, localises the lesion.$q$,
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
  SELECT q.id, 'A', 'reversed_relationship', $q$fraction-assigned-to-wrong-side-of-the-liver$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$magnitude-substituted-for-pattern$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$stool-colour-inverted$q$ FROM q;

-- B2 Q13 . Germ-free gut and pigment colour loss . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Germ-free gut and pigment colour loss$q$,
    $q$A colony of laboratory mice is reared so that no microbes ever settle in the large intestine. Bile flow, liver function and diet are all normal, and the animals are otherwise well. Which of the following would be expected in these mice?

I. Faeces that are yellow-green rather than brown
II. A fall in the quantity of pigment excreted by the kidneys
III. Retention of pigment in the blood with yellowing of the tissues$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"III only"},{"label":"C","text":"I and III only"},{"label":"D","text":"I and II only"}]$q$::jsonb,
    'D',
    $q$This Organ Systems item tests what colonic bacteria do to the excreted bile pigment and which of the body's visible colours depend on that conversion. The answer is D because items I and II both follow from removing the bacterial step, whereas item III would require a defect in a pathway that these animals still have fully intact. The brown of normal faeces is not the colour of the pigment the liver excretes; it is the colour of stercobilin, the end product of bacterial attack on that pigment in the colon. Strip the colon of microbes and the pigment leaves in the stool close to the state in which it arrived, so the faeces take on the yellow-green shade of the unconverted material, which makes item I correct. Item II is correct for a less obvious reason: bacteria first convert the pigment to urobilinogen, a portion of which is taken back up from the colon, returns in the blood, and is cleared by the kidneys, where it is oxidised to urobilin, one of the pigments that contributes to the colour of urine. With no bacteria there is no urobilinogen, so the amount of this pigment leaving in the urine falls. Item III fails because nothing in this animal blocks the liver: uptake, the addition of sugar-acid groups, and pumping into bile all proceed normally, so pigment is cleared from blood at the usual rate and no yellowing occurs. (Choice A) This stops at the stool and misses the renal consequence. It treats the bacterial product as if it were confined to the gut lumen, ignoring the portion that is reabsorbed and later excreted in urine. (Choice B) This assumes that bacteria are needed for the body to clear the pigment at all. Clearance is a hepatic job that is finished once the pigment has been pumped into bile, and the bacterial step comes only after that, so removing it cannot cause the pigment to back up into blood. (Choice C) This pairs a correct prediction about stool with the same false claim about yellowing. It is the most tempting wrong choice, because a student who sees a colour change may assume any colour change implies the pigment is accumulating somewhere. This is a Scientific Reasoning and Problem Solving question because it asks the student to remove one step from a multi-organ pathway and predict which two downstream observations change while a third does not.$q$,
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
  SELECT q.id, 'A', 'partial_truth', $q$gut-only-endpoint$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', $q$bacterial-step-moved-upstream-of-clearance$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$lumen-effect-generalised-to-plasma$q$ FROM q;

-- B2 Q14 . Uptake failure behind a bleeding tendency . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Uptake failure behind a bleeding tendency$q$,
    $q$An adult has had a stone lodged in the common bile duct for eight weeks and now bruises easily and clots slowly. A large oral dose of the fat-soluble vitamin that several clotting factors require changes nothing, but the same substance given by injection restores normal clotting within a day. The person has taken no antibiotic and the resident microbes of the large bowel have not been disturbed. What does the contrast between the two routes of delivery establish?$q$,
    $q$[{"label":"A","text":"Uptake across the intestinal wall has failed, while the liver's ability to use the nutrient is intact."},{"label":"B","text":"Microbes in the large bowel are the body's only meaningful source and they have stopped producing it."},{"label":"C","text":"The liver's synthetic machinery has been destroyed, so factors cannot be assembled at all."},{"label":"D","text":"Stomach acid destroyed the swallowed dose before it could reach the absorptive surface."}]$q$::jsonb,
    'A',
    $q$This Organ Systems item tests how a difference between two routes of delivery localises a defect along a nutrient's path from lumen to plasma. The answer is A because the same substance works when it bypasses the gut and fails when it must cross the gut, which places the failure at the step of moving it from the lumen into the body rather than at any step after that. The stem supplies everything needed to run the argument: the substance is fat soluble, several clotting factors depend on it, and the injection corrects the problem quickly. A stone sitting in the common duct for weeks keeps bile out of the intestinal lumen, and a fat soluble substance is poorly taken up when bile is absent, so a swallowed dose travels along the tract and leaves again largely untaken however large it is. Delivered by injection the substance reaches hepatocytes directly, the clotting factors can be finished, functional factors appear in plasma, and the clotting time normalises within a day. That correction is the discriminating observation, because a defect anywhere downstream of absorption would not be repaired simply by changing how the substance is delivered. The stem also closes off the competing explanation on purpose, since the bowel microbes are undisturbed and so a shortfall of what they make cannot be the cause. (Choice B) This is a true statement about a different situation. Bowel bacteria do contribute some of this vitamin, but it is also obtained from the diet, the stem explicitly leaves the microbes undisturbed, and a bacterial shortfall would have responded to a swallowed dose, which is precisely what did not happen here. (Choice C) The injection result refutes this directly. If the liver could no longer assemble the factors, no route of delivery would help, so the prompt correction after injection is evidence that the hepatic machinery is intact. (Choice D) This relocates the failure to the wrong stage. The vitamin survives the stomach perfectly well, and if acid were the problem then a very large swallowed dose would have overwhelmed such a loss, whereas the dose given here achieved nothing at all. This is a Scientific Reasoning and Problem Solving question because it asks the student to treat the difference between an oral and an injected dose as a natural experiment and infer which single step in the pathway has been lost.$q$,
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
  SELECT q.id, 'B', 'adjacent_fact', $q$synthesis-route-substituted-for-absorption-route$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$hepatic-synthetic-failure$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$failure-relocated-upstream$q$ FROM q;

-- B2 Q15 . Daily fluid load and colonic reserve . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Daily fluid load and colonic reserve$q$,
    $q$The table lists one day of water handling in a healthy adult, along with the greatest amount the colon can take up in 24 hours.

| Item | Litres per day |
| --- | --- |
| Swallowed in food and drink | 2.0 |
| Added as digestive juices | 7.0 |
| Delivered to the colon | 1.5 |
| Leaving in stool | 0.15 |
| Ceiling on colonic uptake | 4.5 |

Uptake by the small intestine now begins to fail, with nothing else altered. At what point does stool turn liquid?$q$,
    $q$[{"label":"A","text":"As soon as the small intestine leaves behind more than about 0.15 L per day, because that is the entire margin available."},{"label":"B","text":"Straight away and in proportion to the failure, because the colon takes up a set percentage of what it is given rather than a set amount."},{"label":"C","text":"Once roughly 3 L per day more than usual arrives at the colon, since that is where its reserve runs out."},{"label":"D","text":"Not at all from a small intestinal fault alone, because colonic reserve is greater than the whole amount handled each day."}]$q$::jsonb,
    'C',
    $q$This Organ Systems item tests the size of the daily fluid load moving through the gut and how large a failure upstream can be tolerated before stool changes. The answer is C because the colon is given 1.5 L a day but can handle up to 4.5 L, so it holds about 3 L of unused capacity, and only a shortfall bigger than that reaches the stool. Start with the input side: 2.0 L arrives by mouth and 7.0 L is added by the gut itself, so 9.0 L is presented to the small intestine, and most of that is the body's own secretion rather than anything drunk. Because 1.5 L passes on, the small intestine has already recovered 7.5 L, close to 83 percent of the load. The colon then keeps 1.35 L of the 1.5 L it receives, and the 0.15 L that escapes is under 2 percent of the original 9.0 L. The ceiling supplied is an absolute daily amount, not a proportion, so the correct comparison is 4.5 L minus 1.5 L, a spare 3.0 L, which is about a third of the whole 9.0 L load.

(Choice A) The 0.15 L figure is a genuine value in the table, but it is what the system lets go under ordinary conditions, not the margin it holds in hand. Reading an output as a tolerance understates the true buffer by roughly twentyfold.

(Choice B) This treats colonic uptake as a fixed percentage of whatever arrives, which would mean every extra litre delivered produced extra stool at once. The number supplied is a maximum daily amount instead, and a system with headroom soaks up shortfalls silently until that headroom is used up.

(Choice D) The reserve is real but limited. Even the full ceiling of 4.5 L is only half of the 9.0 L handled each day, so a severe small intestinal fault can certainly exceed it and produce liquid stool.

This is a Data-based and Statistical Reasoning question because it asks the student to convert several tabulated daily amounts into a spare capacity and then judge that capacity as a fraction of the total load.$q$,
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
  UNION ALL SELECT q.id, 'D', 'partial_truth', NULL FROM q;

-- B2 Q16 . Driving force versus route for colonic water . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Driving force versus route for colonic water$q$,
    $q$An isolated loop of colon is kept alive in a bath, and its lumen is filled with a salt solution at the same total particle concentration as the bath. A toxin applied to the inner surface blocks sodium entry into the lining cells without killing them and without changing how easily water can cross them. Compared with an untreated loop, what happens to the volume of liquid left in the lumen over the next two hours?$q$,
    $q$[{"label":"A","text":"Almost nothing is taken up, because the route for fluid stays open but the gradient that would drive fluid through it is never built."},{"label":"B","text":"Almost nothing is taken up, because a poisoned carrier also shuts the pores that let fluid cross."},{"label":"C","text":"Uptake carries on near its usual rate, since fluid crosses the wall down its own concentration difference regardless of ion handling."},{"label":"D","text":"Fluid is driven into the lumen instead, since a blocked carrier runs in reverse and expels salt outward."}]$q$::jsonb,
    'A',
    $q$This Organ Systems item tests how the large intestine recovers fluid and which part of that machinery the experiment has actually removed. The answer is A because no epithelium in the gut handles water as cargo: it moves ions out of the lumen, and the volume shift is a passive consequence of the concentration difference that ion movement creates. Sodium is brought from the lumen into the cell and then driven onward into the space behind the epithelium at the expense of ATP, which raises particle concentration on that side and lowers it in the lumen. Because the loop was filled at the same total particle concentration as the bath, there is no head start: every bit of the driving force has to be manufactured by transport itself. Block the entry step and that difference is never manufactured, so even a completely open and fully permeable route carries no net movement and the loop finishes with close to the volume it started with. The discrimination that matters here is between a shut route and an absent driving force, two failures that look identical from the outside and can be told apart only by what the setup rules out.

(Choice B) This reaches the right outcome by a mechanism the setup forbids. The toxin is stated not to change how easily water can cross the cells, so the pores are intact, and the failure has to be traced to the missing driving force rather than to a closed route.

(Choice C) Water does move down its own concentration difference, but that difference does not exist on its own. The two compartments start out matched, so with ion movement blocked neither side becomes more concentrated than the other and no net volume shift follows.

(Choice D) Blocking an entry pathway simply stops entry. Carriers do not run backwards and expel their cargo when inhibited, and net movement into the lumen would require a separate outward route being switched on, which nothing in this experiment has done.

This is a Scientific Reasoning and Problem Solving question because it asks the student to predict the result of removing one transport step and then to decide which of two outwardly identical failure modes the stated controls have eliminated.$q$,
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
  SELECT q.id, 'B', 'process_step_confusion', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', NULL FROM q;

-- B2 Q17 . Fasting test separating two fluid losses . medium . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Fasting test separating two fluid losses$q$,
    $q$A patient has had several litres of liquid stool a day for a week. Two mechanisms are under consideration: material left in the lumen that cannot be taken up and holds fluid there, and lining cells actively driving fluid outward into the lumen. Stool output can be measured accurately on the ward. Which plan best tells the two apart?$q$,
    $q$[{"label":"A","text":"Give a known oral dose of a poorly taken up sugar and confirm that output climbs."},{"label":"B","text":"Draw blood before and after a day of losses and compare the electrolyte readings."},{"label":"C","text":"Give a drug that slows transit through the gut and see whether output falls."},{"label":"D","text":"Stop all food and drink for 48 hours, give fluid by vein, and keep weighing what is put out."}]$q$::jsonb,
    'D',
    $q$This Organ Systems item tests experimental discrimination between two routes to fluid loss from the gut. The answer is D because withholding intake removes the only thing that can hold fluid in the lumen osmotically, so a loss that persists must be generated by the epithelium itself. If unabsorbed material is responsible, the load disappears once nothing is eaten and output falls sharply within a day or so. If instead the cells are pushing ions and fluid outward, that process is driven from the blood side and continues whether or not the patient eats, so output stays high. Replacing losses through a vein is not decorative: it keeps the patient safe over 48 hours and, crucially, avoids reintroducing the very oral load the test is trying to withdraw. Weighing every stool converts a subjective impression into the quantitative endpoint that lets the two predictions be separated, since the whole design rests on the two hypotheses predicting different numbers at the end of the fast.

(Choice A) An osmotically active load raises output under either mechanism, since anyone given enough poorly absorbed material passes more fluid. A manoeuvre whose predicted result is the same on both hypotheses carries no discriminating information.

(Choice B) Blood chemistry documents the consequences of losing fluid and electrolytes, but the two mechanisms produce overlapping derangements. This measures how sick the patient is, not where the fluid in the lumen came from.

(Choice C) Slowing transit lengthens the time contents spend against the wall and lowers output whichever mechanism is at work, so a fall says nothing about origin. It also treats the symptom rather than probing the cause, which is what a discriminating test has to do.

This is a Reasoning about the Design and Execution of Research question because it asks the student to choose the manipulation whose outcome differs between two competing mechanisms and to see why each alternative predicts the same result under both.$q$,
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
  SELECT q.id, 'A', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', NULL FROM q;

-- B2 Q18 . Sugar salt coupling in rehydration fluid . easy . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Sugar salt coupling in rehydration fluid$q$,
    $q$In an outbreak of profuse liquid stool, a drink containing only salts gives little benefit, whereas the same drink with a small amount of glucose added sharply cuts net losses. In this illness the epithelium pours chloride and fluid into the lumen but is otherwise undamaged. What best accounts for the effect of the added glucose?$q$,
    $q$[{"label":"A","text":"It is burned by the intestinal cells to supply energy that the ion pump otherwise lacks."},{"label":"B","text":"It is carried in only alongside sodium, and the extra solute taken up draws fluid after it."},{"label":"C","text":"It pulls fluid across by osmosis on its own, so the salts in the drink play no part."},{"label":"D","text":"It shuts the outward anion route, stopping the secretion at its source."}]$q$::jsonb,
    'B',
    $q$This Organ Systems item tests why an effective rehydration fluid must supply a sugar as well as a salt. The answer is B because the small intestine takes up certain sugars on a carrier that will not work unless it binds sodium at the same time, so offering the sugar forces sodium uptake alongside it. That absorbed sodium raises the particle concentration on the blood side of the epithelium and lowers it in the lumen, and fluid then follows passively. The important insight is that absorption and secretion are separate machineries running in parallel: the illness has switched on outward movement, but the coupled uptake pathway remains fully intact and can be recruited simply by supplying its partner molecule. A salt only drink offers sodium with nothing to drag it in efficiently, so recovery stays modest, while net balance turns favourable once the absorptive route is driven hard enough to exceed the ongoing loss.

(Choice A) The energy for this uptake step comes from the sodium gradient maintained by the ATP driven pump on the far side of the cell, not from oxidising the newly arrived sugar. Cells with an active secretory process running are not energy starved in the first place.

(Choice C) Sugar alone in the lumen would simply add particles there and, if anything, hold fluid back. Its benefit depends entirely on being taken up together with sodium, so the salts are indispensable rather than incidental.

(Choice D) This describes plugging the leak rather than opening the drain. Nothing about the sugar interferes with the outward pathway; the loss continues unchanged and is simply outweighed by an absorptive route that has been driven harder.

This is a Scientific Reasoning and Problem Solving question because it asks the student to explain a clinical observation by inferring which transport process the illness has left untouched and how supplying one substrate recruits it.$q$,
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
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', NULL FROM q;

-- B2 Q19 . Colonic mucosa fuelled by luminal fermentation . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Colonic mucosa fuelled by luminal fermentation$q$,
    $q$During abdominal surgery a loop of colon is left in place with its arterial circulation intact but is excluded from the stream of contents leaving the small intestine. Over the following weeks the mucosa of that isolated loop becomes thin and inflamed, even though the patient eats well and perfusion of the loop is unimpaired. What accounts for the deterioration?$q$,
    $q$[{"label":"A","text":"Its absorptive cells are incapable of taking up glucose from capillary blood, so they must always be given nutrients on the cavity side."},{"label":"B","text":"Amino acids taken up further upstream are normally passed forward along the cavity to nourish this segment, and exclusion cuts off that delivery."},{"label":"C","text":"Renewal of the epithelium is driven mainly by mechanical stimulation from bulk passing over it, and exclusion removes that stimulus entirely."},{"label":"D","text":"It draws most of its fuel from small acids that gut microbes make out of carbohydrate the host cannot cleave, and that feedstock no longer arrives."}]$q$::jsonb,
    'D',
    $q$This item falls under Organ Systems and tests where the lining of the large bowel gets its energy. The answer is D because the cells of that lining take most of their ATP from short chain acids produced by microbial fermentation on the cavity side, and excluding the loop removes the fermentable starting material. Dietary fibre is a carbohydrate that no human enzyme can cleave, so it arrives in the large bowel essentially untouched. Organisms living there ferment it into small acids such as butyrate, acetate and propionate, and the absorptive cells sitting immediately above them oxidise those acids in preference to anything arriving by blood. That is a striking arrangement: a tissue nourished mainly from the cavity it faces rather than from the capillaries behind it, which is exactly why a loop with a perfect blood supply and a well fed patient still wastes away once the flow of unabsorbed carbohydrate stops. Instilling the missing acids into such a loop reverses the change, which pins the cause on fuel rather than on bulk or stimulation.

(Choice A) These cells can certainly import glucose from capillary blood, and they do so; the point is that this supply does not cover their demand once their preferred fuel disappears. Stating an absolute inability overshoots the physiology and would predict rapid death of the tissue rather than slow thinning.

(Choice B) Amino acids taken up upstream enter the blood draining the gut and travel to the liver. Nothing routes them forward through the gut cavity to feed downstream segments, so exclusion interrupts no such delivery, and this choice describes a pathway that does not exist.

(Choice C) Turnover of this epithelium is rapid and continuous, but the limiting input in an excluded loop is chemical, not mechanical. Restoring fermentation products alone repairs the tissue without restoring any bulk moving through it, which separates the two explanations cleanly.

This is a Scientific Reasoning and Problem Solving question because it asks the student to infer, from an experimental exclusion and the tissue damage that follows, which side of an epithelium supplies its energy.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$absolute-inability overstatement$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', $q$true statement about the wrong route$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$mechanical rather than metabolic cause$q$ FROM q;

-- B2 Q20 . Antibiotic loss of bacterial vitamin production . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Antibiotic loss of bacterial vitamin production$q$,
    $q$A man completes six weeks of broad spectrum antibiotics for a bone infection, eating an unrestricted diet throughout. In the final week he bruises easily and his clotting time is prolonged, and both resolve once vitamin K is given. One physician proposes that killing the organisms of the large bowel removed a source of the vitamin. A colleague counters that the antibiotic molecule itself interfered with the liver step that uses the vitamin to finish clotting proteins. Which findings would favour the first explanation over the second?

I. The concentration of vitamin K measured in his plasma was low while he was bleeding.
II. Clotting time returned to normal about two weeks after the last dose, tracking the recovery of bacterial counts in stool rather than the clearance of the drug from blood within two days.
III. A sample drawn before the antibiotic course began showed a normal clotting time.$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"I and II only"},{"label":"C","text":"II and III only"},{"label":"D","text":"I, II and III"}]$q$::jsonb,
    'B',
    $q$This item falls under Organ Systems and tests the microbial contribution to the host's vitamin supply. The answer is B because items I and II each point at loss of supply rather than at a blocked liver step, while item III is expected under both explanations and therefore separates nothing. Organisms in the large bowel manufacture several vitamins the host makes in insufficient amount, chiefly vitamin K and biotin, and the absorptive cells of that lining take them up. Vitamin K is what the liver requires to finish several clotting proteins, so wiping out the producing population with weeks of broad spectrum treatment can leave a person bruising and bleeding on a normal diet. Now compare the two proposals. If the drug had blocked the liver step, the vitamin itself would still have been made and absorbed, so its plasma concentration would be normal or even raised; a low plasma level, item I, therefore fits removal of the source and not a blockade downstream of it. Item II adds an independent timing argument: recovery that waits two weeks for the bacterial population to return, long after the drug has left the blood, matches regrowth of a producer and does not match relief of a direct chemical blockade.

(Choice A) Item I alone genuinely favours loss of supply, so this choice is defensible until the timing evidence is weighed. It stops short, because a single plasma measurement is a snapshot that could be pushed around by intake or by laboratory variation, and item II supplies the independent line of evidence that makes the conclusion secure.

(Choice C) This choice keeps a genuinely discriminating item and pairs it with one that is not, and it discards item I. A normal clotting time before treatment shows only that something about the antibiotic course caused the problem, which is common ground between the two proposals rather than a reason to prefer either.

(Choice D) Item III looks persuasive because a clean baseline feels like strong evidence. It is strong evidence for a different claim, that the course was responsible at all, and adding a finding that both explanations predict equally dilutes rather than strengthens the case for one of them.

This is a Scientific Reasoning and Problem Solving question because it asks the student to sort candidate observations by whether each one actually separates two competing causes of the same clinical outcome.$q$,
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
  SELECT q.id, 'A', 'partial_truth', $q$one valid item, stops short$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$true finding that answers a different question$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$more evidence is always better$q$ FROM q;

-- B2 Q21 . Colonic transport machinery versus nutrient uptake . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Colonic transport machinery versus nutrient uptake$q$,
    $q$In a research setting the same solution of glucose, amino acids and sodium chloride is infused through a fine tube directly into the large bowel of one volunteer and into the jejunum of another. Both regions are equally well perfused. In the jejunal subject the glucose and the amino acids appear in the blood within minutes, while in the colonic subject almost none of either appears. Which property of the colonic lining accounts for the difference?$q$,
    $q$[{"label":"A","text":"It is well supplied with transport proteins for ions but has neither the amplified surface nor the specific carriers that upstream segments use to take up dissolved nutrients."},{"label":"B","text":"The mucus released there forms a layer that dissolved molecules are unable to cross."},{"label":"C","text":"Contents move through that region far too quickly for any uptake to take place."},{"label":"D","text":"The infused molecules must first be cleaved by pancreatic enzymes, and none of those enzymes are still active that far along."}]$q$::jsonb,
    'A',
    $q$This item falls under Organ Systems and tests what the lining of the large bowel is and is not equipped to move. The answer is A because that epithelium is built for salt and water recovery and carries almost none of the specialised uptake apparatus that handles sugars and the products of protein breakdown. Two features go together. First, the surface itself is flat: there are no circular folds and no villi, so the area available is a small fraction of what the jejunum offers. Second, the cells there are dominated by pumps and channels that move sodium and let water follow osmotically, together with mucus secreting cells. That combination describes a tissue able to reclaim a litre or more of fluid a day while returning almost no nutrient value to the body, and it predicts exactly the result described, a nutrient load delivered to the wrong place and never seen in blood.

(Choice B) Mucus does coat this surface and does protect it, but it is a lubricating and shielding layer, not a seal. Water and sodium cross it continuously in large quantities, so a barrier argument would have to block those too, and it plainly does not.

(Choice C) This inverts the actual timing. Material dwells in the large bowel typically for twelve to twenty four hours, far longer than anywhere else in the tract, so contact time is generous rather than limiting and cannot be the reason uptake fails.

(Choice D) Pancreatic enzymes act on food polymers, and glucose and free amino acids are already the finished products of digestion that need no further cleaving, as their rapid uptake from the jejunum shows. The choice imports a true fact about digestion into a setting where it does not apply.

This is a Knowledge of Scientific Concepts and Principles question because it asks the student to apply what the lining of the large bowel is structurally equipped to move to a case where two delivery sites give opposite results.$q$,
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
  SELECT q.id, 'B', 'misconception', $q$mucus as an impermeable seal$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', $q$transit time in the wrong direction$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$true digestion fact, wrong target$q$ FROM q;

-- B2 Q22 . Colonic residence time and stool consistency . medium . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Colonic residence time and stool consistency$q$,
    $q$Three adults were studied on a metabolic ward. The table gives, for each one, the volume of fluid passing from the small bowel into the colon each day, the volume of fluid still present in the stool passed each day, and the time contents dwell in the colon before being expelled.

| Subject | Fluid entering colon (mL/day) | Fluid in stool (mL/day) | Dwell time in colon (h) |
| --- | --- | --- | --- |
| P | 1,200 | 96 | 14 |
| Q | 900 | 90 | 10 |
| R | 2,000 | 100 | 30 |

Whose colon recovers the greatest share of the fluid presented to it, and what consistency follows for that person's stool?$q$,
    $q$[{"label":"A","text":"Q, since Q's stool holds the least fluid of the three, and that stool will therefore be firm."},{"label":"B","text":"P, whose stool will be firm, because a dwell time in the middle of the range gives the best recovery."},{"label":"C","text":"R, whose stool will be firm and hard to pass."},{"label":"D","text":"R, whose stool will be loose, because fluid seeps back over so long a dwell."}]$q$::jsonb,
    'C',
    $q$This item falls under Organ Systems and tests how long the colon holds material and what that holding time does to the product. The answer is C because R reclaims 1,900 of the 2,000 mL delivered, about 95 percent, against 1,104 of 1,200 mL for P, about 92 percent, and 810 of 900 mL for Q, about 90 percent, and the longest contact naturally yields the driest and hardest product. The three loads differ, so the comparison has to be made as a share of what each colon received and cannot be read off the stool column alone. Doing it that way reverses the impression that column gives: Q passes the smallest absolute volume of fluid, 90 mL, yet recovers the smallest share of what it was handed. The underlying relationship is monotonic, since sodium is pumped out of the cavity and water follows osmotically, so the more hours the residue spends against that lining, the more fluid is reclaimed. This is why the large bowel, which typically holds material for twelve to twenty four hours compared with a few hours in the small bowel, is where liquid residue is converted into a semisolid mass, and why an unusually long dwell such as R's produces the driest stool of the three.

(Choice A) This choice reads the raw stool column instead of a proportion. Q's 90 mL is indeed the smallest volume of fluid passed, but it came from the smallest delivered load, so Q's share recovered is the lowest of the three rather than the highest, and a 10 hour dwell is the shortest contact in the table.

(Choice B) P is a plausible looking middle case, and 92 percent recovery is respectable. But there is no optimum in the middle of the range; recovery keeps climbing with contact time, so P is beaten by R on the very measure the question asks about.

(Choice D) This gets the subject right and the direction wrong. Prolonged contact continues to remove fluid rather than returning it, so an unusually long dwell hardens the residue and makes it difficult to expel, which is precisely the situation produced when defecation is repeatedly postponed.

This is a Data-based and Statistical Reasoning question because it asks the student to convert three stool volumes into fractions of three different delivered loads, notice that the ranking by share disagrees with the ranking by raw volume, and then translate the winning share into a physical property of the product.$q$,
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
  SELECT q.id, 'A', 'scale_unit_error', $q$absolute volume read as a share$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$imagined optimum in the middle$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$long contact framed as fluid return$q$ FROM q;

-- B2 Q23 . Pancreatic step in the B12 relay . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Pancreatic step in the B12 relay$q$,
    $q$Swallowed vitamin B12 is bound in the mouth by a salivary glycoprotein that survives gastric acid. That salivary glycoprotein must then be stripped off by proteases in the lumen of the duodenum before intrinsic factor can attach, and only B12 carried by intrinsic factor is absorbed by endocytosis in the terminal ileum. A patient with end stage chronic pancreatitis has normal gastric acid output, normal intrinsic factor concentration in gastric juice, and a structurally normal ileum on biopsy, yet serum B12 has fallen steadily over two years. What best accounts for the fall in serum B12?$q$,
    $q$[{"label":"A","text":"Intrinsic factor is broken down in the stomach before it can meet B12."},{"label":"B","text":"B12 enters the mucosal cell normally but is not passed onward into the blood."},{"label":"C","text":"B12 must be held in solution by bile, and bile delivery is impaired as well."},{"label":"D","text":"B12 is still occupied by the binder it picked up in the mouth."}]$q$::jsonb,
    'D',
    $q$This Organ Systems item tests the relay of binding proteins that escorts B12 along the gut and what happens when one link in that relay fails. The answer is D because the exocrine pancreas is the source of the luminal proteases that act in the duodenum, so in end stage pancreatic disease the salivary binder is never removed and B12 arrives at the far small intestine still occupied, unable to pair with intrinsic factor and therefore unable to dock at the mucosal receptor. Uptake of this molecule is unusual in requiring three organs in series: the salivary glands supply a protein that shields it from acid, the exocrine pancreas supplies the proteases that liberate it in the duodenum, and the stomach supplies the factor that ileal receptors actually recognise. Failure of any one of the three is sufficient to produce deficiency, which is why a healthy stomach and a healthy ileum together do not guarantee normal uptake. Every test of stomach and ileum offered here is normal, so the broken link must lie in the step that sits between them, and the stem does not name which organ supplies that step. Deficiency arising by this route is corrected by supplying the missing digestive enzymes with meals rather than by treating the stomach or the ileum.

(Choice A) The gastric factor named in the stem is measured at normal concentration in gastric juice, and it is comparatively resistant to acid; acid destruction of that factor is therefore neither supported by the data nor an event that pancreatic disease would cause.

(Choice B) A blocked exit from the mucosal cell into the blood would be a defect of the epithelium itself, and nothing in pancreatic disease acts on the epithelium. The step that pancreatic secretion controls happens in the lumen, before any cell is entered.

(Choice C) This nutrient is water soluble and is carried in the aqueous phase of the lumen, so it does not need bile for solubilisation the way vitamins A, D, E and K do. Reduced delivery of bile would not by itself account for the deficiency described.

This is a Scientific Reasoning and Problem Solving question because it supplies an outcome plus three normal findings and asks the student to identify which organ in a three step relay must be the failing one.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$blames the wrong protein in the chain$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', $q$right process, wrong stage$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$imports the fat absorption story into a water soluble nutrient$q$ FROM q;

-- B2 Q24 . Which fat soluble vitamin fails first . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Which fat soluble vitamin fails first$q$,
    $q$Bile flow into the intestine stops completely in an adult whose liver synthetic capacity, kidney function and diet all remain normal. Uptake of dietary lipid and of the fat soluble vitamins falls to nearly zero from the day the blockage begins. Three weeks later the patient is reassessed. Which abnormality is most likely to have appeared first?$q$,
    $q$[{"label":"A","text":"Impaired dark adaptation"},{"label":"B","text":"Prolonged clotting times"},{"label":"C","text":"A fall in serum calcium with bone pain"},{"label":"D","text":"Anaemia from oxidative injury to red cell membranes"}]$q$::jsonb,
    'B',
    $q$This Organ Systems item tests why the four fat soluble vitamins do not run short at the same rate once their absorption stops. The answer is B because vitamin K, which the liver needs in order to finish several coagulation factors, is held in the smallest body reserve of the four and turns over within days to a couple of weeks, so a bleeding tendency is the first measurable failure. Reserve size divided by daily consumption, not the severity of the absorption block, sets the order in which these deficiencies surface. The liver holds enough vitamin A to cover many months of zero intake, vitamin D and its metabolites sit in liver and adipose stores that also last months and are further buffered by synthesis in sunlit skin, and vitamin E in body fat is measured in years. Three weeks of complete failure to absorb therefore reads out only on the fastest turning pool. The stem also closes off the obvious confounder by stating that liver synthetic capacity is normal, so a prolonged clotting time here reflects the missing vitamin rather than failure of the organ that assembles the factors.

(Choice A) Impaired dark adaptation does follow depletion of vitamin A, which supplies the retinal that visual pigment needs, but hepatic stores of that vitamin cover many months of zero intake. This is the right consequence on far too short a timescale.

(Choice C) A fall in serum calcium is a late change. Vitamin D stores last months, synthesis in sunlit skin continues, and parathyroid hormone defends the circulating calcium concentration by drawing on bone long after intestinal calcium uptake begins to slip, so serum calcium is commonly still normal at three weeks. Bone pain is later still.

(Choice D) Red cell membranes are protected from oxidation by vitamin E, whose adipose reserve is the largest of the four, so oxidative destruction of red cells after only three weeks of malabsorption would be extraordinary. In adults this deficiency takes years to become apparent.

This is a Scientific Reasoning and Problem Solving question because it asks the student to rank four deficiencies by latency, weighing each vitamin's stored quantity against its daily rate of use, rather than to recall that all four share one absorption route.$q$,
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
  SELECT q.id, 'A', 'scale_unit_error', $q$right deficiency, wrong latency$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$true endpoint that hormonal buffering delays$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'scale_unit_error', $q$real deficiency syndrome with the longest lag$q$ FROM q;

-- B2 Q25 . Positive control in a bile diversion study . medium . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Positive control in a bile diversion study$q$,
    $q$Investigators divert bile away from the small intestine in rats and then measure intestinal uptake of a radiolabelled B vitamin, expecting uptake to be unchanged because this vitamin is taken up straight from the watery contents of the lumen. Uptake in the operated rats matches uptake in unoperated rats. A reviewer objects that this result on its own does not support the conclusion. Which additional measurement would best answer the objection?$q$,
    $q$[{"label":"A","text":"Uptake of the labelled B vitamin at twice the administered dose"},{"label":"B","text":"Uptake of the labelled B vitamin in unoperated rats fed a fat free diet"},{"label":"C","text":"Uptake in the same operated rats of a second labelled vitamin that needs the fat phase"},{"label":"D","text":"Uptake of the labelled B vitamin in a sham operated group"}]$q$::jsonb,
    'C',
    $q$This Organ Systems item tests what an unchanged measurement can and cannot establish, and why the water soluble vitamins survive a lesion that ruins fat uptake. The answer is C because an unchanged result is uninterpretable until the experiment shows that the surgery actually removed something that some absorptive route depended on, and a nutrient that must travel in the fat phase provides exactly that internal positive control. If uptake of that comparison nutrient collapses in the same operated rats while uptake of the B vitamin holds steady, the diversion is proven effective and the contrast between the two routes is established in one preparation. Without it, an equally good reading of the data is that the operation failed, that bile was still reaching the lumen, and that nothing was ever tested. The underlying physiology is that most water soluble vitamins cross the epithelium directly from the aqueous contents of the lumen, by simple diffusion or by membrane carriers, so they never enter the fat phase and are indifferent to whether bile arrives. The one water soluble vitamin handled differently, B12, needs a protein escort rather than a fat phase, so it too would be spared by this lesion.

(Choice A) Doubling the dose probes the capacity of the uptake route rather than whether the surgical manipulation worked, and a transport step that is already unimpaired will simply carry more. The objection concerns the validity of the manipulation, not saturation.

(Choice B) Rats that never had surgery cannot show that the surgery did anything, and taking fat out of the diet changes a second variable at the same time. This addresses a question the reviewer did not ask.

(Choice D) A sham operated group is a sensible control for the trauma of surgery, and it strengthens the study, but it still cannot demonstrate that diverting bile abolished absorption by the fat dependent route. It leaves the reviewer's objection standing.

This is a Reasoning about the Design and Execution of Research question because it asks the student to choose the positive control that makes an unchanged experimental measurement interpretable.$q$,
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
  SELECT q.id, 'A', 'scale_unit_error', $q$dose response substituted for a validity control$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', $q$a control for the wrong comparison$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$a legitimate control that answers a different threat$q$ FROM q;

COMMIT;

-- Verification: the chapter is now COMPLETE. Expect 75 questions and 225 distractor rows.
SELECT
  (SELECT COUNT(*) FROM public.questions WHERE topic = 'The Digestive System') AS questions,
  (SELECT COUNT(*) FROM public.question_distractor_metadata m
     JOIN public.questions x ON x.id = m.question_id
   WHERE x.topic = 'The Digestive System') AS distractor_rows;

-- Distribution check across the finished chapter.
SELECT difficulty, COUNT(*) FROM public.questions
 WHERE topic = 'The Digestive System' GROUP BY difficulty ORDER BY difficulty;
SELECT correct_answer, COUNT(*) FROM public.questions
 WHERE topic = 'The Digestive System' GROUP BY correct_answer ORDER BY correct_answer;
