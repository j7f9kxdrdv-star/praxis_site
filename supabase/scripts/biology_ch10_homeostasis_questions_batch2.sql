-- Biology Chapter 10: Homeostasis, standalone questions
-- BATCH 2 of 3 (20 questions): the rest of the proximal tubule, the loop of Henle and the
--   concentrating mechanism, and the first items of the distal nephron.
--
-- !! RUN AFTER BATCH 1 !!
-- No DELETE here: batch 1 owns the chapter-scoped DELETE. Re-running this file alone would
-- duplicate its 20 questions.

BEGIN;

-- Q1 . Saturable carrier ceiling and solute spillover . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Saturable carrier ceiling and solute spillover$q$,
    $q$A solute crosses the glomerular filter without restriction and is pulled back out of the lumen by a carrier protein that becomes fully occupied once enough of the solute arrives. An investigator raises the solute's plasma level in steps from zero upward and, at each step, measures how much of the solute leaves the body in urine each minute. Which pattern does that measured output follow as plasma level is raised?$q$,
    $q$[{"label":"A","text":"Output climbs in direct proportion to plasma level across the entire range, beginning at the very lowest values tested."},{"label":"B","text":"Output climbs with plasma level at first and then levels off at a fixed ceiling once the carrier is fully occupied."},{"label":"C","text":"Output stays near zero up to a critical plasma level, then rises along a line whose slope eventually matches the rise in the quantity presented to the nephron."},{"label":"D","text":"Output stays near zero up to a critical plasma level and then holds steady at a fixed rate however high plasma climbs."}]$q$::jsonb,
    'C',
    $q$This Organ Systems item tests the ceiling that a saturable reclamation carrier places on tubular recovery and the threshold pattern that ceiling produces. The answer is C because a carrier with a finite number of binding sites removes essentially all of the solute offered to it until those sites are fully engaged, after which every additional molecule that arrives must continue down the tubule and leave the body. Below the critical plasma level, recovery keeps pace with arrival, so output sits at essentially zero and the plot hugs the horizontal axis. Once every site is engaged, recovery is locked at its maximum, a fixed number of molecules per minute that cannot grow no matter how much more arrives. Everything beyond that fixed amount escapes, so what is voided equals what arrives minus a constant, and the voided line therefore climbs with a slope that converges on the slope of the arrival line itself. The finished plot is a flat stretch, a bend at the threshold, and then a rising line running parallel to the amount presented.

(Choice A) A straight proportional rise starting at the very lowest plasma levels describes a solute that crosses the filter and is then ignored by the tubule, the behavior of a marker used to gauge filtration rate. It leaves the reclamation step out of the picture altogether.

(Choice B) A curve that rises and then flattens at a fixed ceiling is a genuine curve, but it belongs to the quantity recovered, not the quantity voided. Recovery is the process with an upper bound; what escapes has none.

(Choice D) This choice correctly places the bend at a critical plasma level but then freezes output there. Nothing clears the surplus once the sites are all engaged, so output cannot remain constant while more and more solute keeps arriving.

This is a Scientific Reasoning and Problem Solving question because it asks the student to convert a statement about finite carrier capacity into the shape of an excretion curve across a whole range of plasma values.$q$,
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
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', NULL FROM q;

-- Q2 . Basolateral pump failure in proximal reabsorption . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Basolateral pump failure in proximal reabsorption$q$,
    $q$A toxin is infused into the vessels wrapping the first tubular segment of the nephron, where it shuts down the ATP driven ion pump sitting on the cell membrane that faces the interstitium. Glomerular filtration and every downstream segment are unaffected. What change in the fluid leaving that segment, and in the urine that is eventually voided, follows most directly?$q$,
    $q$[{"label":"A","text":"Glucose and amino acids escape reclamation there and appear in the voided urine."},{"label":"B","text":"Water recovery proceeds as before, so the volume of fluid handed onward is unchanged."},{"label":"C","text":"Organic solutes are still recovered, but wastes such as drug metabolites can no longer be added to the lumen and build up in blood."},{"label":"D","text":"Sodium is driven into the lumen as the pump runs backwards, so the fluid handed onward becomes hypertonic."}]$q$::jsonb,
    'A',
    $q$This Organ Systems item tests how the energy supply on the blood facing surface of a tubule cell sets what that segment can reclaim. The answer is A because the pump on that surface is what holds sodium inside the cell at a low level, and that low internal sodium is what makes sodium flow inward from the lumen and drag glucose and amino acids in with it. Shut the pump down and cell sodium rises within minutes, the inward gradient collapses, and the coupled uptake of organic solutes at the lumen facing surface stalls. Those solutes stay in the fluid, and because no later stretch of the nephron carries machinery to recover them, they travel the whole length of the tubule and leave the body. The recognizable picture is sugar and amino acids in a urine sample that normally contains neither, with the plasma levels of both entirely ordinary.

(Choice B) Water follows solute osmotically in this segment rather than being moved on its own. When solute recovery falls, the osmotic pull weakens and more water stays in the lumen, so the volume handed onward rises rather than staying fixed.

(Choice C) This inverts which job survives. Adding wastes to the lumen and recovering organic solutes both lean on the same sodium gradient, so neither is spared, and the choice describes only the process the question did not ask about.

(Choice D) The pump does not reverse and pour sodium into the lumen. It simply stops, and the fluid handed onward is left richer in the solutes that were never withdrawn rather than turning hypertonic through added sodium.

This is a Scientific Reasoning and Problem Solving question because it asks the student to trace a single energetic failure at one membrane surface through to the specific substances that show up in a urine sample.$q$,
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
  SELECT q.id, 'B', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', NULL FROM q;

-- Q3 . Composition of fluid leaving the proximal tubule . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Composition of fluid leaving the proximal tubule$q$,
    $q$A physiologist samples tubular fluid at the very end of the first tubular segment of the nephron in a healthy person and compares that sample with the filtrate that entered the segment.

I. The volume passing the sampling point each minute is markedly smaller than the volume that entered
II. The osmolarity of the sample is close to that of the plasma from which the filtrate was formed
III. The sodium concentration of the sample is markedly lower than that of the entering filtrate

Which of the above will be observed?$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"II and III only"},{"label":"C","text":"I and III only"},{"label":"D","text":"I and II only"}]$q$::jsonb,
    'D',
    $q$This Organ Systems item tests what the first stretch of tubule does to the volume, the tonicity and the sodium content of the fluid it passes onward. The answer is D because items I and II both describe that fluid correctly while item III does not. Roughly two thirds of the filtered water and of the filtered sodium are reclaimed before the fluid reaches the loop, so the volume arriving at the sampling point each minute is far smaller than the volume that entered, which makes item I correct. This segment is also freely permeable to water, so water follows the reclaimed solute out almost as fast as the solute leaves and the fluid never gets a chance to become dilute or concentrated. Its osmolarity therefore stays close to that of the plasma it came from, which makes item II correct. Item III fails for the same reason: sodium and water leave in nearly the same proportion, so what remains carries close to the sodium concentration it started with even though far less of it is left.

(Choice A) This accepts the fall in volume but rejects the matching osmolarity, implying the segment strips solute while leaving water behind. That would hand on a dilute fluid, which is not what a freely water permeable epithelium produces.

(Choice B) This drops the volume statement, yet a segment that reclaims most of the filtered water must pass on a much smaller volume each minute than it received.

(Choice C) This accepts item III, treating sodium as though it were withdrawn ahead of water. Here the two leave together, so the sodium concentration barely moves.

This is a Knowledge of Scientific Concepts and Principles question because it asks the student to state the volume, the osmolarity and the sodium concentration of fluid leaving the proximal tubule from recall of what that segment reclaims.$q$,
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
  SELECT q.id, 'A', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', NULL FROM q;

-- Q4 . Distinguishing tubular secretion from tubular reabsorption for a test solute . medium . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Distinguishing tubular secretion from tubular reabsorption for a test solute$q$,
    $q$A laboratory has made a new compound and needs to know whether the nephron adds it to the tubular fluid, removes it from the tubular fluid, or leaves it alone. The compound is small, uncharged, does not bind plasma proteins, and crosses the glomerular filter without restriction. The laboratory also holds a second substance that crosses the filter just as freely and is known to be neither added nor removed at any point along the nephron. Both can be infused to steady plasma levels and measured in plasma and in urine. Which comparison would settle the question most directly?$q$,
    $q$[{"label":"A","text":"The compound's concentration in urine against its concentration in plasma, treating a higher urinary value as evidence that the tubule added it."},{"label":"B","text":"The volume of plasma freed of the compound each minute against the volume freed of the second substance each minute, treating a larger value as addition and a smaller value as removal."},{"label":"C","text":"The compound's urinary output each minute before and after its plasma level is raised, treating a rise in output as evidence that the tubule added it."},{"label":"D","text":"The mass of the compound appearing in urine over an hour against the mass of the second substance appearing over the same hour, treating the larger mass as evidence that the tubule added the compound."}]$q$::jsonb,
    'B',
    $q$This Organ Systems item tests the design logic that separates what the tubule does to a substance from what filtration alone would already do to it. The answer is B because the volume of plasma freed of a substance each minute is the one measure that can be set directly against a reference substance the tubule never touches. That reference is removed from exactly the volume of plasma that gets filtered, so it supplies the yardstick the comparison needs. If the new compound is freed from a larger volume of plasma each minute than the reference, the nephron must be putting extra molecules into the lumen; if from a smaller volume, molecules must be coming back out of the lumen; and if the two match, the tubule is leaving the compound alone. Because both substances cross the filter equally freely, every difference between them belongs to what happens after filtration, which is precisely what was asked. The comparison also survives changes in urine flow and in the doses infused, since those influences act on both substances alike and cancel when the two are measured side by side in the same subject.

(Choice A) Urine is a concentrated fluid because most of the filtered water is reclaimed on the way through. Even the untouched reference substance ends up many times more concentrated in urine than in plasma, so a high urinary concentration on its own says nothing about whether the tubule added anything.

(Choice C) Raising the plasma level raises the amount delivered to the filter, and urinary output rises with it whatever the tubule is doing. The observation is real but it cannot separate addition from removal from indifference, because no reference is involved.

(Choice D) The two substances are infused independently, so the masses recovered in urine reflect the doses chosen rather than the tubule's handling. Absolute amounts have to be scaled to how much of each was filtered before they can be set against one another at all.

This is a Reasoning about the Design and Execution of Research question because it asks the student to choose, among four measurable comparisons, the one whose built in reference substance isolates what the tubule does from what the filter does.$q$,
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
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'scale_unit_error', NULL FROM q;

-- Q5 . Why regulated water exit comes last . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Why regulated water exit comes last$q$,
    $q$In a hypothetical kidney, the tubule region whose water permeability can be turned on or off is repositioned so that fluid passes through it first, and the fluid then flows through a region that is always freely water permeable and that runs deep through the medulla before draining to the bladder. The medullary osmotic gradient and every transport protein are unchanged. What is the consequence for this kidney?$q$,
    $q$[{"label":"A","text":"Output would become permanently watery, since water could no longer be recovered anywhere past the loop."},{"label":"B","text":"Regulation would be preserved, since the total water recovered along the whole tubule is unchanged."},{"label":"C","text":"Urine osmolarity would be locked near that of the deep interstitium, leaving output volume essentially fixed."},{"label":"D","text":"The medullary gradient would dissipate, since the hairpin geometry of the loop has been reversed."}]$q$::jsonb,
    'C',
    $q$This Organ Systems item tests how fixed and adjustable water exit are arranged in series along the tubule, and what that arrangement buys the kidney. The answer is C because the last stretch of tubule the fluid passes through sets the final concentration, and a stretch that always lets water follow the surrounding gradient will pull its contents toward equilibrium with the deep interstitium every single time. Once that equilibration happens, whatever concentration the fluid carried when it arrived is erased, so turning the earlier region on or off changes nothing about what reaches the bladder. Output volume then becomes little more than the daily solute load divided by one fixed concentration. The real tubule is arranged the other way round: the stretch that is always open to water sits early, and the stretch whose permeability can be switched sits at the very end, so it has the last word on how much water leaves. That ordering is what lets one animal void a large volume of watery urine in the morning and a small volume of highly concentrated urine that evening using the identical set of transporters. The redesigned tubule keeps every transport protein and the medullary gradient intact and still loses all flexibility of output, which shows that the flexibility lives in the sequence rather than in the parts.

(Choice A) This runs water the wrong way. The terminal stretch in the redesigned tubule passes through hyperosmotic medulla, so water leaves the fluid there instead of being trapped inside it, and the product would be concentrated rather than watery.

(Choice B) Total water recovered is not the quantity that matters here. Even if the same volume were reclaimed overall, the animal would have lost the ability to change that volume from hour to hour, and adjustability, not total recovery, is what the arrangement exists to provide.

(Choice D) Nothing in the redesign alters the hairpin geometry or the transport that builds the medullary gradient, and the stem states that the gradient is intact. Naming a collapsed gradient identifies the wrong failure: the machinery still works, but its product can no longer be tuned.

This is a Scientific Reasoning and Problem Solving question because it asks the student to predict the functional consequence of reordering two tubule regions rather than to recall their normal sequence.$q$,
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
  SELECT q.id, 'A', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', NULL FROM q;

-- Q6 . Nitrogen waste toxicity versus water cost . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Nitrogen waste toxicity versus water cost$q$,
    $q$A freshwater fish and a desert rodent catabolize dietary protein at similar rates. The fish releases its waste nitrogen in the cheapest chemical form directly across its gills, while the rodent expends ATP converting the same waste into a chemically different form before excreting it. The rodent's conversion is favored in its habitat mainly because:$q$,
    $q$[{"label":"A","text":"its product is tolerated at far higher concentrations, so the same load leaves in much less water."},{"label":"B","text":"the conversion also recovers usable energy from the carbon skeleton of the amino acids."},{"label":"C","text":"its product crosses cell membranes more freely, which speeds its removal from blood."},{"label":"D","text":"its product is nearly insoluble and is voided as a paste with almost no water."}]$q$::jsonb,
    'A',
    $q$This Organ Systems item tests the trade off that governs how animals package waste for disposal. The answer is A because the detoxified product can accumulate in body fluid to concentrations that would be lethal if the cheap form reached them, and that tolerance is what allows a fixed daily load to be voided in a small volume of urine rather than a flood. The cheap form is a base that raises the pH of body fluid and disturbs cells at very low concentrations, so an animal that keeps it must continuously flush it away with large quantities of fluid. A fish sitting in fresh water has an unlimited flushing medium on the other side of its gills and pays nothing for it. A desert mammal does not, so it spends ATP up front to make something it can carry safely at high concentration, and it recovers that cost many times over in fluid it does not have to drink and then void. Toxicity and water cost are two sides of one problem: the more damaging a waste is at a given concentration, the more solvent must be dedicated to keeping it dilute, and solvent is the resource a land animal cannot spare.

(Choice B) The conversion consumes ATP rather than yielding it. Usable energy is harvested earlier, from the carbon skeleton left after the amino group is stripped off, and that step is entirely separate from the detoxification being described.

(Choice C) This reverses the permeability relationship. The cheap form is a small uncharged molecule that slips across membranes into cells, which is a large part of why it is damaging, and in any case faster clearance from blood would do nothing about the volume of fluid needed to carry a day's nitrogen out of the body.

(Choice D) A nearly insoluble waste voided as a paste describes the strategy of birds, reptiles and many terrestrial invertebrates, which conserves even more fluid but costs still more energy. Mammals do not use it, and the stem describes an animal that excretes its waste dissolved in urine.

This is a Knowledge of Scientific Concepts and Principles question because it asks the student to state why detoxifying waste before excretion is worth its energetic cost in a habitat where water is scarce.$q$,
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
  SELECT q.id, 'B', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', NULL FROM q;

-- Q7 . Descending limb volume loss at constant solute . easy . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Descending limb volume loss at constant solute$q$,
    $q$Tubular fluid is drawn from the start of the loop of Henle and from its deepest point in the medulla of a rat deprived of drinking water overnight. Osmolarity at the deep site is about four times that at the start. Compared with the first sample, the deep sample most likely contains:$q$,
    $q$[{"label":"A","text":"roughly the same volume of fluid carrying about four times as much sodium."},{"label":"B","text":"a smaller volume of fluid carrying proportionally less sodium."},{"label":"C","text":"a smaller volume of fluid concentrated by sodium pumped in from the surrounding tissue."},{"label":"D","text":"a smaller volume of fluid carrying nearly the same quantity of sodium."}]$q$::jsonb,
    'D',
    $q$This Organ Systems item tests what follows from a tubule wall that is open to water but closed to salt. The answer is D because the dominant event in this stretch is departure of water, so the solute already present stays behind and simply ends up dissolved in less fluid. Concentration is amount divided by volume. If the amount of sodium is held roughly constant and the concentration climbs about fourfold, the volume must have fallen to roughly a quarter of what entered. A fourfold rise between the top and the bottom of the loop is therefore a statement about water leaving rather than about salt arriving. The same reasoning explains why fluid at the bend of the loop is as concentrated as fluid anywhere in the tubule even though the rise owes almost nothing to new solute being added. Bulk removal of salt does not begin until the fluid rounds the bend and enters the ascending stretch, where the wall is closed to water instead.

(Choice A) This attributes the rise to solute being added rather than water being removed. Salt is not driven from the interstitium into this part of the tubule against its own gradient, and if the volume were unchanged, the tubule would have had to gain roughly three extra ions for every one it started with.

(Choice B) If salt left in proportion to the water, the fluid would stay isosmotic and the measured concentration would not climb at all. This describes what happens in the proximal tubule, where solute and water are recovered together, not what happens deep in the medulla.

(Choice C) Active uptake of sodium from the surrounding tissue into the lumen belongs to no part of the loop. It confuses both the direction and the location of the pumping step, which sits in the ascending stretch and moves sodium out of the tubule rather than into it.

This is a Scientific Reasoning and Problem Solving question because it asks the student to convert a measured concentration change into a paired statement about volume and solute quantity.$q$,
    'easy',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', NULL FROM q;

-- Q8 . Ascending limb dilution sets urine floor . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Ascending limb dilution sets urine floor$q$,
    $q$An investigator blocks the salt carrier of the thick ascending limb in a rat while every other transport protein keeps working. After a large drink, the rat cannot produce urine more dilute than its blood. This failure follows most directly from which change?$q$,
    $q$[{"label":"A","text":"The medullary gradient has collapsed, so the collecting duct can no longer concentrate the filtrate."},{"label":"B","text":"Solute is no longer stripped from a stretch whose wall is closed to water, so the fluid stays isosmotic with plasma."},{"label":"C","text":"Proximal reabsorption has risen to compensate for the salt left behind downstream."},{"label":"D","text":"Sodium can no longer be reclaimed at any point along the tubule."}]$q$::jsonb,
    'B',
    $q$This Organ Systems item tests why one stretch of the tubule is the only place the kidney manufactures fluid thinner than blood. The answer is B because that stretch has a wall through which water cannot follow while salt is pulled out of the lumen, and removing solute from a compartment water cannot leave is the single event in the whole tubule that drives the fluid below the concentration of plasma. Block the carrier and the fluid arriving at the far end of the loop is still isosmotic with blood. Everything past that point can only take water away or leave it alone, and taking water away raises concentration rather than lowering it, so the thinnest product the kidney could then deliver is one that matches blood, and the surplus intake stays in the body. Getting rid of extra fluid is therefore not simply a matter of switching off recovery at the end of the tubule; it depends on thin fluid having been manufactured earlier. That stretch sets the floor of the kidney's range while the medullary gradient sets its ceiling, and the two failures sit at opposite ends of the same range.

(Choice A) A weakened medullary gradient is a genuine consequence of blocking this carrier, but it explains the opposite failure. Losing the gradient means the animal cannot make urine saltier than blood, whereas the rat here is failing at the watery end of its range.

(Choice C) Proximal recovery is isosmotic and is not driven up by events further along. Even if more fluid were taken up early, that would reduce the volume delivered downstream without ever making the remaining fluid thinner than blood.

(Choice D) Sodium uptake elsewhere is untouched: the stem restricts the block to one carrier in one stretch, and the proximal tubule, the distal tubule and the collecting duct all keep reclaiming sodium by their own routes. This spreads a lesion in a single stretch across the entire organ.

This is a Scientific Reasoning and Problem Solving question because it asks the student to trace a single blocked transporter to a specific limitation on the range of urine the kidney can produce.$q$,
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
  UNION ALL SELECT q.id, 'C', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', NULL FROM q;

-- Q9 . Ascending limb transport block and urine volume . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Ascending limb transport block and urine volume$q$,
    $q$A hospitalized patient is started on a drug that binds and disables the apical carrier that moves sodium, potassium and chloride together out of the fluid in the thick ascending limb. Over the next day the patient's urine output rises to several liters and the urine stays near the tonicity of plasma no matter how little the patient drinks. Which chain of events accounts for the rise in output?$q$,
    $q$[{"label":"A","text":"Salt retained in the filtrate drives glomerular filtration upward, so more fluid is delivered than later segments can reclaim."},{"label":"B","text":"The salt held back in the tubule retains water osmotically within the loop itself, and that retained water is the whole of the extra volume."},{"label":"C","text":"The tissue deep in the medulla no longer reaches a high solute concentration, so water lacks the gradient it needs to leave the collecting duct."},{"label":"D","text":"Because the disabled carrier sits in the descending portion, water can no longer be drawn out of the tubule as fluid travels toward the bend."}]$q$::jsonb,
    'C',
    $q$This item falls under Organ Systems and tests how blocking salt movement in one tubular segment propagates into a change in the volume of urine produced. The answer is C because the salt pumped out of that segment is what loads the deep tissue with solute, and once that tissue is no longer concentrated, water sitting in the collecting duct has nothing to move toward. The segment returning toward the cortex moves salt out of the tubule while holding water back, so it is the engine that builds the concentrated environment surrounding the deepest structures. Fluid running down the collecting duct passes through that environment, and water crosses out of the duct only because the fluid outside is more concentrated than the fluid inside. Disable the carrier and the surrounding tissue drifts back toward plasma values, so most of what arrives at the duct is carried onward to the bladder rather than being reclaimed. The ability to concentrate and the ability to dilute are lost together here, which is why the urine sits near plasma tonicity instead of becoming maximally dilute. (Choice A) What happens to salt already inside the tubule cannot push more fluid across the filter upstream, so unreabsorbed salt does not drive filtration upward, and no plausible change in filtration could account for several extra liters a day. (Choice B) Salt left in the tubule does hold some water with it, and this contributes, but the bulk of the effect lies downstream: about a fifth of the filtered water is still present when fluid reaches the collecting duct, and whether that water is reclaimed depends entirely on the environment the duct passes through. Naming only the loop stops the reasoning one segment too early. (Choice D) The two limbs do opposite jobs. The limb heading toward the bend is freely permeable to water and carries no salt pump to block, while the limb heading back toward the cortex moves salt and is sealed against water. Placing the carrier in the wrong limb reverses which step the drug interrupts. This is a Scientific Reasoning and Problem Solving question because it requires tracing a blocked membrane carrier through the loss of a tissue gradient to a specific change in the volume of urine produced.$q$,
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
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', NULL FROM q;

-- Q10 . Loop length multiplies a single level difference . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Loop length multiplies a single level difference$q$,
    $q$The carriers of the thick ascending limb can hold the fluid inside the tubule roughly 200 mOsm/L below the fluid immediately outside it at any single horizontal level, and cannot exceed that difference. Compare two nephrons with identical carrier density: one whose bend sits just beneath the cortex, and one whose bend reaches the tip of a renal pyramid. Which of the following are correct?

I. Fluid at the bend of the deeper nephron can sit far more than 200 mOsm/L above plasma, because the difference established at each level adds to the difference already present above it.
II. The two nephrons must arrive at the same value at their bends, since their carriers are equally abundant and equally active.
III. Extending a nephron's bend further toward the tip would raise the value it can attain there.$q$,
    $q$[{"label":"A","text":"I and III only"},{"label":"B","text":"I only"},{"label":"C","text":"III only"},{"label":"D","text":"I, II and III"}]$q$::jsonb,
    'A',
    $q$This item falls under Organ Systems and tests what the multiplier in the loop actually multiplies, and why the axial extent of the anatomy, not the strength of any one pump, sets the ceiling. The answer is A because statement I correctly describes small per level differences stacking along the axis, statement III correctly follows from that stacking, and statement II denies the role of axial extent altogether. A single pass of transport is weak: it can separate the two sides of the tubule wall by only about a fifth of plasma tonicity. What makes the arrangement powerful is that fluid arriving at any level has already been worked on by every level above it, so each new increment is added on top of an already elevated starting value rather than starting fresh. Stack enough increments and fluid at the deepest bend approaches roughly four times plasma, even though no single pump ever produced more than a fraction of that. Statement II fails on exactly this point: equal carrier density guarantees equal work per level, not equal totals, and the shallow nephron simply has fewer levels over which to accumulate. Two conveyor belts of identical strength deliver very different totals if one runs three times as long. This is also why nephrons whose bends barely leave the cortex contribute little to the deep environment, while the animals that make the most concentrated urine are the ones whose loops run furthest toward the tip. (Choice B) Selecting I alone accepts the stacking idea but stops short of its structural consequence: if the total is built level by level, then adding levels must raise the total, which is exactly what III asserts. (Choice C) Selecting III alone accepts that depth matters but leaves the mechanism unstated; without the stacking described in I there is no reason depth should matter at all, since the per level limit is fixed. (Choice D) Including II contradicts the very reasoning that supports III, since II asserts that anatomy is irrelevant while III asserts that it is decisive. This is a Scientific Reasoning and Problem Solving question because it requires converting a fixed per level transport limit into a prediction about the total difference two nephrons of different lengths can achieve.$q$,
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
  SELECT q.id, 'B', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', NULL FROM q;

-- Q11 . Medullary blood flow rate and gradient washout . medium . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Medullary blood flow rate and gradient washout$q$,
    $q$In an isolated perfused kidney, an investigator raises the flow through the straight vessels running beside the deepest loops tenfold, and the most concentrated urine the preparation can make falls by half. She considers two accounts: the fast blood removes accumulated solute from the depths faster than the tubules can restore it, or the fast flow has damaged the tubular pumps themselves. Which measurement best separates the two accounts?$q$,
    $q$[{"label":"A","text":"Repeat the whole protocol in a second preparation and confirm the concentrating defect appears again at high flow."},{"label":"B","text":"Compare the net rate at which salt and urea are carried away in the blood leaving the region, sampled shortly after each change in flow."},{"label":"C","text":"Record how much urine the preparation makes per minute at each flow rate."},{"label":"D","text":"Sample fluid at the bend of the deepest loops and compare its concentration at each flow rate."}]$q$::jsonb,
    'B',
    $q$This item falls under Organ Systems and tests how to design a comparison that discriminates between removal of solute by blood and failure of the transport that deposits it. The answer is B because the two accounts predict opposite things about how much material the blood carries off in the period right after the flow is raised: if fast blood is stripping solute out of the depths, the amount leaving per minute surges above its former value, whereas if the pumps have failed, less solute is being handed to the blood in the first place and the amount leaving falls. That opposition in direction is what makes the measurement discriminating; a good design does not merely confirm the phenomenon, it picks a variable on which the rival explanations disagree. Timing matters here, because once a new steady state settles the amount carried off must again match the amount deposited, so the informative comparison is made while the depths are still being emptied. The result also explains why these vessels normally run slowly. Their hairpin path lets solute enter on the way down and leave again on the way back up, so at low velocity the blood takes away only the water and salt that were reclaimed, leaving the accumulated environment intact. Speed removes that near cancellation, because blood spends too little time alongside the tubules for the returning limb to give back what the descending limb picked up. (Choice A) Reproducing the result in a second preparation is sound practice and strengthens the claim that the effect is real, but both accounts predict the same reproducible defect, so a repeat run says nothing about which mechanism produced it. (Choice C) Urine output per minute is essentially the observation already reported. Both accounts predict a preparation that concentrates poorly and therefore passes more fluid, so repeating the outcome variable adds nothing that separates them. (Choice D) The concentration of fluid at the bend falls under both accounts as well, since the fluid there equilibrates with whatever surrounds it, and what surrounds it is depleted whether the depletion came from washing or from failed deposition. It documents the effect without identifying its source. This is a Reasoning about the Design and Execution of Research question because it requires choosing the measured variable on which two competing explanations of the same result make predictions in opposite directions.$q$,
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
  SELECT q.id, 'A', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', NULL FROM q;

-- Q12 . Loop depth versus maximal urine concentration . easy . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Loop depth versus maximal urine concentration$q$,
    $q$A comparative study recorded, for five mammals, an index of how far the longest loops descend toward the tip of the pyramid and the highest urine osmolarity each animal reached after two days without water.

| Species | Loop depth index | Highest urine osmolarity (mOsm/L) |
| --- | --- | --- |
| Beaver | 1.3 | 520 |
| Human | 3.0 | 1,400 |
| Dog | 4.3 | 2,400 |
| Cat | 4.8 | 3,100 |
| Kangaroo rat | 8.5 | 5,500 |

A sixth mammal, a desert gerbil, has a loop depth index of 6.5. What is the best estimate of the highest urine osmolarity it can reach?$q$,
    $q$[{"label":"A","text":"About 620 mOsm/L"},{"label":"B","text":"About 1,300 mOsm/L"},{"label":"C","text":"About 2,500 mOsm/L"},{"label":"D","text":"About 4,200 mOsm/L"}]$q$::jsonb,
    'D',
    $q$This item falls under Organ Systems and tests reading a structural measurement against a functional ceiling and estimating a value that does not appear in the table. The answer is D because a depth index of 6.5 lies between the cat at 4.8 and the kangaroo rat at 8.5, so the estimate must fall between their osmolarities of 3,100 and 5,500. Across the whole table, greater depth accompanies greater attainable concentration without exception, and over that last interval the rise is close to steady: about 2,400 mOsm/L is gained across 3.7 index units, which is roughly 650 mOsm/L per unit. The gerbil sits 1.7 units above the cat, so it gains about 1,100 on the cat's value, giving an estimate near 4,200. (Choice A) This value sits beside the beaver, the shallowest animal in the table, and would require the gerbil to concentrate less well than a human despite loops more than twice as deep, reversing the direction every row supports. (Choice B) This treats the human value as a standard that other mammals approach, but three of the five tabulated species already exceed it and the gerbil's index is more than double the human's. (Choice C) This is close to the dog's value and would be defensible only for an index near 4.3; stopping partway up the table ignores the two rows that actually bracket 6.5. This is a Data-based and Statistical Reasoning question because it requires extracting the rate at which the tabulated quantity changes and using it to estimate a value for an index absent from the table.$q$,
    'easy',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    4,
    65
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', NULL FROM q;

-- Q13 . Reading an osmolarity profile along the nephron . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Reading an osmolarity profile along the nephron$q$,
    $q$Micropuncture samples of tubular fluid were collected at four successive sites along a single nephron in an animal that had been deprived of water for 18 hours. Site 1 is the earliest point sampled and site 4 the latest. The fluid immediately outside the tubule at site 2 measured about 1200 mOsm/L, and nowhere in this kidney does the fluid outside the tubule fall below about 300 mOsm/L.

| Sampling site | Fluid osmolarity (mOsm/L) |
|---|---|
| 1 | 300 |
| 2 | 1150 |
| 3 | 120 |
| 4 | 1000 |

Which segment does the tubule pass through between sites 2 and 3?$q$,
    $q$[{"label":"A","text":"The proximal convoluted tubule"},{"label":"B","text":"The descending limb of the loop of Henle"},{"label":"C","text":"The ascending limb of the loop of Henle"},{"label":"D","text":"The medullary collecting duct"}]$q$::jsonb,
    'C',
    $q$This item falls under Organ Systems and tests how the osmolarity profile of tubular fluid identifies where along the nephron a sample was taken. The answer is C because only a stretch that pulls salt out of the lumen while refusing to let water follow can drive the fluid far below the 300 mOsm/L at which it was filtered, and that is exactly what the drop from site 2 to site 3 shows. Filtrate begins as plasma stripped of protein, so the 300 at site 1 marks the start of the tubule. The climb to 1150 at site 2 requires water to have left the lumen into much saltier surroundings. Now consider what water movement alone could do between sites 2 and 3: water crossing the wall can only pull the fluid toward the value outside the tubule, and the stem states that this outside value never drops below about 300, so no amount of water entering the lumen could bring the sample to 120. The reading is therefore consistent only with sodium chloride being carried out across a wall that water cannot cross. The rise back to 1000 at site 4 then reflects water leaving the last stretch of tubule down the very gradient that the preceding salt transport helped to build.

(Choice A) The first convoluted segment removes salt and water in roughly equal proportion, so fluid leaving it is still close to 300 mOsm/L. It can produce neither the peak at site 2 nor the trough at site 3.

(Choice B) In the limb that dives toward the papilla, water leaves and osmolarity climbs. That accounts for the change from site 1 to site 2, not for the fall that follows it, so this choice has the direction of the change backwards.

(Choice D) The final duct is where fluid is concentrated again during water deprivation, which fits the change from site 3 to site 4. Placing it between sites 2 and 3 puts the dilution step at the wrong stage of the pathway.

This is a Data-based and Statistical Reasoning question because it asks the student to identify an unlabelled segment by reasoning from the shape of a measured osmolarity profile together with the osmolarity of the fluid surrounding the tubule.$q$,
    'hard',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    4,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', NULL FROM q;

-- Q14 . Ceiling on maximal urine concentration . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Ceiling on maximal urine concentration$q$,
    $q$A patient who has had no access to drinking water for a prolonged period is being studied. In this state, the chemical signal that inserts water pores into the wall of the medullary collecting duct is present at saturating levels, so the duct wall is as permeable to water as it can possibly be, and flow through the duct is slow enough that the fluid inside reaches osmotic equilibrium with the surrounding tissue at every position it passes. Probe readings of the surrounding tissue give 1,200 mOsm/L at the innermost point the duct reaches, 300 mOsm/L where the duct begins, and 750 mOsm/L midway between those two. Fluid enters the duct at 100 mOsm/L. What is the highest osmolarity the fluid leaving this duct can attain?$q$,
    $q$[{"label":"A","text":"About 1,200 mOsm/L"},{"label":"B","text":"About 2,400 mOsm/L"},{"label":"C","text":"About 750 mOsm/L"},{"label":"D","text":"About 50 mOsm/L"}]$q$::jsonb,
    'A',
    $q$This Organ Systems item tests what sets the upper limit on how concentrated urine can become. The answer is A because water leaves the duct only while the fluid inside is less concentrated than the fluid outside, so once the two match the driving force is gone, and the highest surrounding value the duct is ever exposed to, 1,200 mOsm/L, is the most the fluid inside can reach. Concentrating urine is a passive process: the permeable wall supplies only a path, while the driving force is the osmotic difference across that wall. Equilibration can carry the inside fluid up to the outside value, but nothing about equilibration can carry it past that value. That is why saturating the permeability signal, slowing transit further, or worsening the dehydration cannot push the number higher; each of those factors changes how completely equilibrium is reached, not where equilibrium sits. The deepest surrounding reading is therefore a hard ceiling that the fluid can approach but never exceed.

(Choice B) 2,400 mOsm/L doubles the deepest surrounding reading, treating maximal wall permeability plus unlimited time as though continued exposure keeps adding concentration. Osmotic water movement is self-limiting: it halts at equality, so no amount of extra permeability or extra time produces a value above the surrounding fluid.

(Choice C) 750 mOsm/L correctly recognizes that the surrounding fluid imposes the limit but reads that limit at the wrong position. The fluid does not stop midway; it continues into progressively saltier surroundings and re-equilibrates at each successive position, so the last position it passes, not an intermediate one, fixes the final value.

(Choice D) 50 mOsm/L reverses the direction of water movement, treating the concentrated surroundings as drawing water into the duct and diluting its contents below the entering value. Water moves toward the more concentrated compartment, which here lies outside the duct, so the fluid loses water and rises above its entering value rather than falling below it.

This is a Scientific Reasoning and Problem Solving question because it asks the student to apply the limits of a passive equilibrium process to predict the maximum value an outcome can reach when every factor promoting that process has already been maximized.$q$,
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
  SELECT q.id, 'B', 'misconception', $q$maximal driver assumed to overshoot equilibrium$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$right principle applied at the wrong position$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$water flow direction inverted$q$ FROM q;

-- Q15 . Urea contribution to the medullary gradient . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Urea contribution to the medullary gradient$q$,
    $q$After several weeks on a very low protein diet, a subject is deprived of fluid for 14 hours. Vasopressin is measured and is appropriately high, yet urine osmolarity plateaus near 600 mOsm/L, compared with about 1150 mOsm/L when the same subject ate an ordinary diet. Which change best accounts for the lower ceiling?$q$,
    $q$[{"label":"A","text":"More osmotically active particles remain in the tubular fluid, and they hold water inside the duct"},{"label":"B","text":"The tubule responds poorly to the water-conserving hormone because its receptors cannot be built without dietary protein"},{"label":"C","text":"Protein restriction increases muscle breakdown, and the extra creatinine excreted obligates additional loss of fluid"},{"label":"D","text":"Less urea reaches the deep interstitium, so fewer osmoles are available there to draw water out of the collecting duct"}]$q$::jsonb,
    'D',
    $q$This item falls under Organ Systems and tests the contribution of the body's main nitrogen waste to the osmotic gradient deep in the kidney. The answer is D because the concentrating step is passive: water leaves the last stretch of tubule only if the fluid around it is more crowded with particles than the fluid inside, and a large share of those surrounding particles is the nitrogen waste itself rather than sodium chloride. The supply of that waste tracks how much amino acid the body is breaking down, so weeks of very low intake shrink the pool available for the kidney to deposit around the deepest tubules. With the deep gradient blunted, even a maximal hormonal signal that opens the water pathway can only pull the tubular fluid up to whatever the surrounding fluid measures, and 600 mOsm/L is the ceiling that this weaker surrounding fluid sets. The failure therefore lies in the osmotic environment the hormone acts against, not in the hormone itself.

(Choice A) This has the direction backwards. Taking in less nitrogen means fewer, not more, particles pass along the tubule, and in any case particles retained inside the lumen would drive a large dilute urine rather than a ceiling on concentration.

(Choice B) The stem already reports that the signal is appropriately high, and the defect described here sits outside the tubule rather than in its response machinery. Receptors that cannot be synthesised are a commonly imagined but incorrect consequence of moderate dietary restriction.

(Choice C) Extra breakdown products would, if anything, add to the particle load the kidney handles. This statement concerns waste generation elsewhere in the body and does not address why the maximum achievable concentration falls.

This is a Knowledge of Scientific Concepts and Principles question because it asks the student to attribute a measured drop in maximal urine concentration to the loss of a specific contributor to the osmotic gradient deep in the kidney.$q$,
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
  SELECT q.id, 'A', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', NULL FROM q;

-- Q16 . Obligatory urine volume from solute load . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Obligatory urine volume from solute load$q$,
    $q$An adult generates a fixed load of 900 mOsm of solute that must leave the body in the urine each day. Even under maximal water conservation, this person's kidneys cannot push urine osmolarity past 1200 mOsm/L, and the daily load does not change with dehydration. What is the smallest daily urine volume compatible with clearing the whole load?$q$,
    $q$[{"label":"A","text":"0.075 L per day"},{"label":"B","text":"0.75 L per day"},{"label":"C","text":"1.3 L per day"},{"label":"D","text":"3.0 L per day"}]$q$::jsonb,
    'B',
    $q$This item falls under Organ Systems and tests the arithmetic that sets a floor under daily urine output. The answer is B because volume is the load divided by the highest concentration attainable: 900 mOsm divided by 1200 mOsm per litre gives 0.75 L per day. The meaning matters more than the number. Concentration is a ratio, so once the numerator is fixed by metabolism and diet and the denominator has a hard upper bound set by how steep the kidney's deepest osmotic gradient can be, the volume of fluid carrying that load cannot fall below the quotient. No amount of thirst, water restriction or hormonal signalling can push output lower without leaving part of the load inside the body. This is why urine output can never fall to zero, and why a person with a blunted deep gradient, who tops out at a lower concentration, is forced to give up even more water each day for the same load.

(Choice A) This is the correct quotient shifted by a factor of ten, a magnitude slip rather than a reasoning error. A daily output of 75 mL would be a small fraction of what any functioning kidney produces.

(Choice C) Dividing 1200 by 900 inverts the relationship and yields a number with the wrong units. Litres come from milliosmoles divided by milliosmoles per litre, not the reverse, and inverting the ratio would perversely predict a larger volume for a kidney that concentrates better.

(Choice D) This uses the method correctly but substitutes the osmolarity of plasma, near 300 mOsm/L, for the maximum the kidney can reach. It gives the output of someone excreting the load without concentrating at all, which is an upper reference point rather than the floor requested.

This is a Data-based and Statistical Reasoning question because it asks the student to combine a fixed solute load with a ceiling concentration to compute a minimum volume and to interpret what that quotient represents physiologically.$q$,
    'hard',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    4,
    85
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'scale_unit_error', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', NULL FROM q;

-- Q17 . Distal sodium delivery and potassium secretion . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Distal sodium delivery and potassium secretion$q$,
    $q$Principal cells of the late distal nephron take up sodium from the tubular fluid and release potassium into it, and the rate of potassium release tracks the rate of sodium uptake by those same cells. Consider three interventions in an otherwise healthy adult.

I. A drug that blocks the sodium potassium two chloride symporter of the thick ascending limb
II. Intravenous infusion of a sodium salt whose anion the proximal tubule cannot reclaim
III. A drug that blocks the luminal sodium channel of principal cells

Which interventions would be expected to raise urinary potassium loss?$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"I and III only"},{"label":"C","text":"I and II only"},{"label":"D","text":"I, II, and III"}]$q$::jsonb,
    'C',
    $q$This question sits in the Organ Systems content category and tests how the quantity of salt reaching the last segments of the nephron governs the loss of potassium in urine. The answer is C because interventions I and II both push extra sodium past the earlier segments and into the final tubule, whereas intervention III removes the very sodium entry step that drives potassium out of the cell. Sodium crosses the apical membrane of these cells down a steep electrochemical gradient that basolateral pumping maintains, and every ion of sodium withdrawn from the fluid leaves the lumen slightly more electrically negative. That growing negativity, together with the raised pump turnover it reflects, favors the exit of potassium from cell to lumen, so any manipulation that offers more sodium to these cells raises the potassium that ends up in urine. Blocking salt uptake in the thick ascending limb leaves in the fluid a large load that would otherwise have been reclaimed upstream, and it arrives downstream intact. An anion the early tubule cannot recover holds its sodium partner in the lumen for a different reason, charge balance, but the downstream consequence is identical. Both routes therefore converge on the same variable, and both raise potassium loss.

(Choice A) Intervention I is correctly identified, but the reasoning stops one step short. An anion that cannot be reclaimed upstream is a second and entirely independent route to the same increase in downstream sodium delivery, so a set containing only I is incomplete.

(Choice B) Intervention III inhibits sodium entry across the apical membrane of principal cells. With less sodium crossing, the electrical driving force and the pump turnover that favor potassium exit both fall, so urinary potassium declines rather than rises. This choice has the direction of the effect inverted.

(Choice D) Treating every agent that increases urine flow as a potassium waster ignores the mechanism entirely. Drugs acting at the final segment itself spare potassium precisely because they cut the sodium uptake on which potassium release depends, so the effect of III opposes the effects of I and II.

This is a Scientific Reasoning and Problem Solving question because the student must trace three unrelated pharmacological manipulations forward to a single shared downstream variable, the sodium load presented to the final tubule, and then predict the direction of potassium loss for each one.$q$,
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
  SELECT q.id, 'A', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', NULL FROM q;

-- Q18 . Two requirements for concentrating urine . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Two requirements for concentrating urine$q$,
    $q$Four groups of rats are prepared. In each group the water permeability of the final duct is clamped pharmacologically at a high or a low value, and the osmolality of the deep medullary interstitium is set independently by controlling salt transport in the ascending limb. Plasma osmolality is 300 mOsm/kg in every animal.

| Group | Water permeability of final duct | Papillary interstitial osmolality (mOsm/kg) |
|---|---|---|
| 1 | High | 1200 |
| 2 | High | 300 |
| 3 | Low | 1200 |
| 4 | Low | 300 |

In how many of the four groups will the fluid leaving the duct be hyperosmotic to plasma?$q$,
    $q$[{"label":"A","text":"One"},{"label":"B","text":"Two"},{"label":"C","text":"Three"},{"label":"D","text":"Four"}]$q$::jsonb,
    'A',
    $q$This question falls in the Organ Systems content category and tests the recognition that a concentrated final product requires two separate conditions to hold at once. The answer is A because water can only leave the duct if a path exists and a driving force exists, and only group 1 supplies both. Water crosses the epithelium by osmosis, so an open path is useless when the fluid outside sits at the same osmolality as the fluid inside, and a steep surrounding gradient is equally useless when the epithelium will not let water through. Group 2 has an open path but faces an interstitium no saltier than plasma, so the fluid can at best equilibrate toward 300 mOsm/kg and never exceeds it. Group 3 faces a steep gradient it cannot exploit, so the dilute fluid handed to it by a fully active ascending limb passes straight through and emerges well below plasma osmolality. Group 4 fails both tests at once, with neither a path for water to cross nor a difference in osmolality to drive it, so whatever osmolality the fluid carries into the duct it carries out again and it never rises above that of plasma. Only group 1 lets water move down a large osmotic difference into the surrounding tissue, leaving behind a small volume of solute rich fluid.

(Choice B) A count of two follows from treating an open water path as sufficient by itself, which credits groups 1 and 2, or from treating a steep gradient as sufficient by itself, which credits groups 1 and 3. Either version drops the requirement that both must be present, and each version is contradicted by the group it wrongly includes.

(Choice C) A count of three follows from treating the two conditions as alternatives, so that any group possessing at least one of them concentrates its fluid. The reasoning is half right, since both variables genuinely matter, but they combine as a joint requirement rather than as substitutes, so groups 2 and 3 fail alongside group 4.

(Choice D) A count of four assumes the final duct always delivers a product saltier than plasma. Urine at or below plasma osmolality is a normal and frequent output, and concentration is something the duct must actively achieve rather than a default state, so three of these four preparations lack one or both of the requirements for achieving it.

This is a Scientific Reasoning and Problem Solving question because the student must apply a two condition rule independently to each of four experimentally defined combinations and then aggregate the four verdicts into a single count.$q$,
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
  UNION ALL SELECT q.id, 'C', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', NULL FROM q;

-- Q19 . Designing a test for a local tubular sensor . easy . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Designing a test for a local tubular sensor$q$,
    $q$Fluid leaving the thick ascending limb passes a patch of specialized tubular cells pressed against the arterioles that supply the glomerulus of that same nephron. One proposal holds that these cells read the salt content of the fluid beside them and adjust filtration in their own nephron on the spot. A competing proposal holds that any such adjustment is carried out by a substance travelling in the blood, which would reach every nephron in the kidney alike. Which experiment best distinguishes the two proposals?$q$,
    $q$[{"label":"A","text":"Infuse a salt load into a vein and record the filtration rate of the whole kidney, which pools all of its nephrons, before and after"},{"label":"B","text":"Compare average single nephron filtration rates in animals fed a high salt diet for two weeks with those fed a low salt diet"},{"label":"C","text":"Remove one kidney and record whether filtration per nephron rises in the kidney that remains"},{"label":"D","text":"Perfuse the tubule of one nephron with a salty fluid and compare filtration in that same nephron with filtration in its untouched neighbors"}]$q$::jsonb,
    'D',
    $q$This question falls in the Organ Systems content category and tests how an experiment must be built to separate a signal that acts where it is generated from one that travels in the blood to every target at once. The answer is D because only this design changes the input to a single sensor while leaving every other nephron in the same kidney untouched as a built in control. If the adjustment is local, filtration falls in the perfused nephron alone and its neighbors are unaffected, because the neighbors never saw the salty fluid. If instead the adjustment depends on something released into the blood, the perfused nephron and its neighbors share the same circulation and would have to move together. The two proposals therefore predict visibly different patterns, and one measurement settles the matter. Every other option changes salt at many sensors simultaneously or pools the readout across nephrons, and under those conditions the local and bloodborne accounts predict the very same result, which is why they cannot discriminate.

(Choice A) Salt delivered into a vein reaches every nephron in the kidney, and a whole kidney measurement sums their responses. A change in that number is consistent with both proposals, so the experiment produces a real effect that carries no information about where the signal acts.

(Choice B) Two weeks of altered diet is a systemic and slow manipulation, and averaging filtration across nephrons hides exactly the nephron to nephron difference that would identify a local signal. It is a legitimate experiment about the response to dietary salt, but it answers a different question than the one posed.

(Choice C) Removing one kidney tests how the remaining organ compensates for lost tissue, which is a separate phenomenon driven by whole body demands. The manipulation never varies the salt content of the fluid arriving at the sensor, so neither proposal is put at risk by the result.

This is a Reasoning about the Design and Execution of Research question because the student must choose the one manipulation that varies the input to a single sensor while leaving matched neighboring units untouched, which is the only arrangement in which the two competing accounts predict different outcomes.$q$,
    'easy',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    3,
    70
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', NULL FROM q;

-- Q20 . Water deprivation then exogenous hormone challenge . medium . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Water deprivation then exogenous hormone challenge$q$,
    $q$Two adults with lifelong polyuria and a healthy control were deprived of water for eight hours, after which urine osmolality was measured. Each then received an injection of a synthetic analogue of the kidney's water conserving hormone, and urine osmolality was measured again one hour later.

| Subject | After deprivation (mOsm/kg) | After injection (mOsm/kg) |
|---|---|---|
| Control | 950 | 1005 |
| Patient J | 135 | 715 |
| Patient K | 140 | 155 |

Which conclusion is best supported by these results?$q$,
    $q$[{"label":"A","text":"Patient J's shortfall is in the tubular reaction, and patient K's is in supply of the molecule"},{"label":"B","text":"Patient J's shortfall is in supply of the molecule, and patient K's is in the tubular reaction"},{"label":"C","text":"Both patients fall short in supply of the molecule, and the dose reaching patient K was too small"},{"label":"D","text":"Both patients handle the molecule normally, and the low starting values reflect incomplete deprivation"}]$q$::jsonb,
    'B',
    $q$This question sits in the Organ Systems content category and tests the interpretation of a challenge test that separates a missing chemical message from a target that cannot act on one. The answer is B because patient J concentrated the urine sharply once the substance was supplied from outside, which shows the kidney machinery was ready and only the substance was missing, while patient K barely moved despite receiving the same supply. Eight hours without water is a powerful natural stimulus, and the control shows what an intact system does with it, reaching a high value before the injection and gaining almost nothing afterwards because it was already near its ceiling. Both patients failed that natural stimulus, so the test cannot separate them until the substance is supplied artificially. Once it is, the two end points diverge by more than fourfold, and the divergence localizes each defect: a kidney that responds to an outside dose was never the problem, and a kidney that ignores an outside dose is the problem.

(Choice A) This assigns each defect to the wrong patient. Patient J rose from 135 to 715 within an hour of the injection, which is only possible if the final duct can raise its water permeability and the surrounding tissue can pull water out, so the reaction apparatus is intact in J and impaired in K.

(Choice C) Attributing patient K's flat result to an inadequate dose ignores the design of the test. Both patients received the same analogue on the same schedule, and patient J's large rise establishes that the dose was ample to drive a substantial response, so an unresponsive kidney rather than an underdose explains K's result.

(Choice D) The control subject argues directly against this. Deprivation alone raised the control to 950 mOsm/kg, so eight hours is long enough to reveal a normal concentrating response, and both patients sat near 140 mOsm/kg under that same stimulus, which is a failure rather than an artifact of a short deprivation.

This is a Data-based and Statistical Reasoning question because the student must compare two measurements taken before and after a defined intervention, use the control values to establish what an intact response looks like, and assign the two patients to different lesions on the basis of the size of the change rather than the raw values.$q$,
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
  SELECT q.id, 'A', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', NULL FROM q;

COMMIT;

-- Verification: after batches 1 and 2, expect 40 questions and 120 distractor rows.
SELECT
  (SELECT COUNT(*) FROM public.questions WHERE topic = 'Homeostasis') AS questions,
  (SELECT COUNT(*) FROM public.question_distractor_metadata m
     JOIN public.questions x ON x.id = m.question_id
   WHERE x.topic = 'Homeostasis') AS distractor_rows;
