-- Biology Chapter 10: Homeostasis (the excretory system and the skin), standalone questions
-- BATCH 1 of 3 (20 questions): renal architecture, glomerular filtration, the proximal tubule.
--
-- CHAPTER SIZE: 60 questions. A Step 1 boundary audit found 37 concepts already owned by SIX other
-- chapters, more blocking than any chapter in the bank.
--
--   THE HORMONE AXIS IS GONE. Bio Ch5 Endocrine (100 questions) owns aldosterone as an answer (five
--   separate keys), the renin-angiotensin cascade, antidiuretic hormone and its source, atrial
--   natriuretic peptide, erythropoietin, and steroid-versus-peptide mechanism. NO QUESTION IN THIS
--   CHAPTER HAS A HORMONE NAME AS ITS ANSWER. Where a hormone is needed it is handed to the student
--   in the stem and the question asks what the TUBULE does.
--
--   THE PRESSURE BALANCE IS GONE. Bio Ch7 owns Starling forces, net filtration pressure arithmetic,
--   the hydrostatic-versus-oncotic contrast, portal systems and two capillary beds in series,
--   efferent arteriolar resistance and filtration fraction. This chapter gets ONE numeric filtration
--   item, and its answer turns on Bowman's capsule hydrostatic pressure, a term Ch7 never uses.
--
--   Also blocked: skin as a pathogen barrier and antigen presentation (Bio Ch8); skin
--   thermoregulation framed as which-system-dumps-heat and renal bicarbonate handling (Bio Ch6); the
--   bicarbonate buffer, blood pH AND renal acid-base compensation (GenChem Ch10, which carries the
--   classic "the kidney regulates pH" item under a biology tag); the internal-versus-external
--   sphincter pair with voluntary override (Bio Ch9, whose defecation item is the same question with
--   the organ swapped); smooth-versus-skeletal muscle, where Bio Ch11 already uses the filling
--   bladder as its scenario.
--
-- WHAT THIS CHAPTER OWNS INSTEAD: the tubule rather than the hormone, the filtration barrier's
-- selectivity rather than the pressure balance, and the skin's water and heat physics rather than
-- its defence. Charge selectivity, autoregulation, the countercurrent multiplier, transport maximum
-- and osmoreceptors are all untouched elsewhere in the bank.
--
-- See biology_ch10_homeostasis_questions.plan.md for the full scope verdict and boundary rules.
--
-- !! BATCH 1 OWNS THE CHAPTER DELETE !! Batches 2 and 3 are pure INSERTs and run after this file.

BEGIN;

DELETE FROM public.questions WHERE topic = 'Homeostasis';

-- Q1 . Why the medullary gradient is regional . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Why the medullary gradient is regional$q$,
    $q$The interstitial fluid of a kidney sits near 300 mOsm/kg just beneath the outer capsule but reaches roughly 1200 mOsm/kg at the deepest points of the organ. Which arrangement of structures accounts for this difference?$q$,
    $q$[{"label":"A","text":"Sodium is moved out of the nephron by pumps only at depth; nearer the capsule solute leaves the nephron by diffusion alone."},{"label":"B","text":"Blood moves through the deep vessels much faster than through the shallow ones, and that speed drives solute inward and packs it at the tip."},{"label":"C","text":"Long hairpin tubule limbs lying beside equally long hairpin vessels are found only at depth; nearer the surface there are only coiled segments and a freely intermixing capillary bed."},{"label":"D","text":"Only the deep zone contains collecting ducts, and urea leaking from their walls supplies the entire gradient on its own."}]$q$::jsonb,
    'C',
    $q$This question falls under Organ Systems and tests the structural precondition for a standing osmotic gradient inside the kidney. The answer is C because a gradient can be built and held only where long hairpin tubule limbs lie alongside equally long hairpin blood vessels, and that geometry exists only at depth. Every renal corpuscle and both convoluted portions of every nephron sit in the cortex, which is served by a peritubular network in which blood mixes freely and moves on quickly. Salt deposited into cortical interstitium is carried away about as fast as it arrives, so that tissue stays close to plasma osmolarity no matter how hard the proximal tubule is working. Deeper in the organ the arrangement changes: the long loops of juxtamedullary nephrons deposit salt at increasing depths, and the vasa recta that accompany them descend and ascend side by side, taking up solute on the way in and handing it back on the way out. Because those vessels flow slowly and in opposite directions, they trade solute with each other instead of flushing it into the general circulation, and the deposited salt accumulates to roughly four times plasma osmolarity at the deepest point. Geometry, not transport strength, is the limiting condition.

(Choice A) Active sodium transport is not confined to the deep zone. The proximal convoluted tubule, which lies entirely in the outer tissue, performs the single largest block of active reabsorption in the whole nephron, and yet no standing gradient exists there. That is exactly the point: pumping alone is not sufficient.

(Choice B) Flow through the deep vessels is unusually slow, not fast. Rapid flow is what destroys a deep gradient, because it would carry sodium and urea away faster than the loops could deposit them, leaving the interstitium near plasma osmolarity.

(Choice D) Collecting ducts do release urea into the deep interstitium, and urea recycling genuinely deepens the gradient, but ducts begin in the outer tissue and simply pass through it, and no amount of urea can accumulate where the vasculature washes solute away. Paired hairpin geometry is the necessary condition; urea is an amplifier on top of it.

This is a Knowledge of Scientific Concepts and Principles question because it asks the student to match a known anatomical layout to the physical condition that any standing concentration gradient requires.$q$,
    'easy',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    1,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', NULL FROM q;

-- Q2 . Consequence of nephron segment order . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Consequence of nephron segment order$q$,
    $q$Consider a nephron built with two of its segments in the wrong order: fluid reaches the water permeable terminal duct first and only afterward enters the salt pumping limb that discharges fluid at about 100 mOsm/kg. The deep interstitial gradient is normal and every transporter works normally. Which capacity is lost?$q$,
    $q$[{"label":"A","text":"Making urine more concentrated than plasma when water must be conserved."},{"label":"B","text":"Reclaiming glucose completely at ordinary blood glucose levels."},{"label":"C","text":"Making urine more dilute than blood when water intake is high."},{"label":"D","text":"Forming filtrate at a normal rate across the barrier at the capsule."}]$q$::jsonb,
    'A',
    $q$This question falls under Organ Systems and tests why the order in which fluid meets nephron segments determines what the kidney can do. The answer is A because the salt pumping limb leaves the fluid it discharges at roughly 100 mOsm/kg, so whatever segment sits downstream of it is the only structure that can ever raise that value again. In the real itinerary the diluting limb acts early and hands a hypotonic fluid to the terminal duct, which then sits inside an interstitium running up to about 1200 mOsm/kg. If that duct is water permeable, water leaves down the gradient and the fluid finishes hyperosmotic; if the duct is closed to water, the hypotonic fluid passes through unchanged. Both outcomes are available only because the diluting step comes first and the tunable step comes last. Swap them and the final thing that happens to the fluid is obligatory dilution, so the animal excretes a large watery volume whether or not it has water to spare. The gradient is still there, but nothing downstream can use it.

(Choice B) Glucose is reclaimed in the proximal convoluted tubule, which lies upstream of both swapped segments and is untouched by the rearrangement. Its transport maximum is unchanged, so glucose handling is unaffected.

(Choice C) The rearranged nephron keeps the ability to make watery urine; in fact it can do nothing else, since the last segment always discharges fluid well below plasma osmolarity. This choice states the surviving ability rather than the lost one.

(Choice D) Filtration occurs at the corpuscle, before the fluid reaches either of the two segments in question. Rearranging plumbing downstream of the barrier does not change the rate at which fluid crosses it, so this names the wrong stage of the process.

This is a Scientific Reasoning and Problem Solving question because it asks the student to predict which physiological capability disappears when two steps of an established sequence are exchanged.$q$,
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
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', NULL FROM q;

-- Q3 . Renal oxygen supply versus transport work . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Renal oxygen supply versus transport work$q$,
    $q$A surgical patient is hypotensive for 40 minutes. A biopsy taken afterward shows dead tubular cells packed into one narrow band at a fixed depth inside the kidney, while tubules nearer the outer aspect look intact. Which pairing of features accounts for the location of the damage?$q$,
    $q$[{"label":"A","text":"Those cells sit in the most richly perfused region of the kidney, so the fall in pressure withdrew a larger absolute quantity of supply from them than from any other tubule."},{"label":"B","text":"Those cells are the first to meet the filtrate, so they faced the largest solute load before any reabsorption had occurred."},{"label":"C","text":"Those cells do very little transport work and hold few mitochondria, so even a brief interruption of supply kills them."},{"label":"D","text":"Those cells carry the heaviest active pumping load while sitting where oxygen delivery is lowest."}]$q$::jsonb,
    'D',
    $q$This question falls under Organ Systems and tests the mismatch between where the kidney does its hardest transport work and where its blood supply is thinnest. The answer is D because the thick ascending limb runs its sodium potassium ATPase at a very high rate, and that limb lies in the medulla, the least well supplied tissue in the organ. Deep renal tissue receives only a small fraction of total renal flow, and the vessels serving it are arranged as hairpins in which the descending and ascending arms lie against one another. Oxygen diffuses straight across from the incoming arm into the outgoing arm and is carried back out before it ever reaches the bottom of the loop, so oxygen tension at depth is low even in a healthy person. The cells there therefore work with almost no reserve. A drop in perfusion that a cortical tubule shrugs off pushes this segment below what its pumps require, and it dies first. That is why the injury appears as a band at one depth rather than as damage spread evenly through the organ, and why the kidney tolerates a fall in perfusion so poorly.

(Choice A) The relationship runs the other way. The outer tissue, not the deep band, receives the great majority of renal blood flow, so the region that lost the largest absolute quantity of supply is precisely the region the biopsy found intact. Perfusion by itself cannot single out the cells that died; only the ratio of supply to demand can.

(Choice B) The cells that meet filtrate first are proximal convoluted tubule cells, and those sit in the outer tissue, which the biopsy describes as intact. Naming that stage of the itinerary contradicts the location the question asks about.

(Choice C) These cells are densely packed with mitochondria precisely because their pumping load is so large. A low workload would predict tolerance of a supply interruption, not vulnerability to one, so the reasoning points the wrong way.

This is a Scientific Reasoning and Problem Solving question because it asks the student to work backward from an observed pattern of injury to the combination of metabolic demand and regional supply that produced it.$q$,
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
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', NULL FROM q;

-- Q4 . Bladder compliance and upstream drainage . easy . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Bladder compliance and upstream drainage$q$,
    $q$A urinary bladder taking in urine from 50 mL to 400 mL shows almost no rise in the pressure inside it. Suppose instead its wall were stiff, so that the pressure climbed in proportion to the volume held. What would follow upstream?$q$,
    $q$[{"label":"A","text":"Filtration at the capsule would increase, because a larger force downstream draws more fluid across the barrier."},{"label":"B","text":"Ureteral drainage would be opposed during much of the storage interval, damming fluid back toward the kidneys."},{"label":"C","text":"The lining cells would stay tall and columnar instead of flattening as the wall is stretched."},{"label":"D","text":"Urine formation would halt until the next void, because the kidneys cannot work against a downstream force."}]$q$::jsonb,
    'B',
    $q$This question falls under Organ Systems and tests compliance, the ability of a hollow store to accept volume without a matching rise in pressure, and what that property protects. The answer is B because the whole drainage path above the store operates on a very small pressure difference, and a stiff wall would cancel that difference long before the store was full. Urine is made continuously, so it has to keep moving away from the kidney at all times and not only at the moment of voiding. The ureters move it along with modest peristaltic waves that work against whatever pressure waits at the far end, and they do so without help from gravity. A highly compliant store takes on several hundred milliliters while the pressure inside it rises by only a few centimeters of water, so the far end stays near zero throughout the interval between voids and flow stays one way. Make the wall stiff and pressure climbs with every milliliter added, the ureters progressively lose the head they need, and fluid backs up into the collecting system of the kidney itself. That rising back pressure is what ultimately threatens the nephrons, which is why compliance is best understood as a protective property for the organs above the store rather than a convenience for the store itself.

(Choice A) The relationship is inverted. Raising the pressure downstream of a filter opposes filtration rather than promoting it, since fluid must be driven into a space that is already pressurized.

(Choice C) The lining epithelium does flatten as the wall is stretched, and that is a genuine feature of this organ, but it is a fact about the wall itself and says nothing about what happens upstream, which is what the question asked.

(Choice D) The kidney does not switch itself off when downstream pressure rises. Filtration carries on and fluid accumulates in the tract above the obstruction, which is precisely the outcome that a compliant wall exists to prevent.

This is a Scientific Reasoning and Problem Solving question because it asks the student to remove one mechanical property from a downstream reservoir and infer the consequence for the organs that drain into it.$q$,
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
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', NULL FROM q;

-- Q5 . Capsular pressure in glomerular filtration . easy . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Capsular pressure in glomerular filtration$q$,
    $q$A physiologist advances micropipettes into a single rat nephron and records 55 mm Hg of blood hydrostatic pressure inside the glomerulus, 15 mm Hg of fluid pressure inside Bowman's space, and 30 mm Hg of colloid osmotic pressure in the glomerular blood. Protein is essentially absent from Bowman's space. What is the net pressure driving fluid across the wall, and which way does it act?$q$,
    $q$[{"label":"A","text":"40 mm Hg, directed out of the vessel"},{"label":"B","text":"25 mm Hg, directed out of the vessel"},{"label":"C","text":"10 mm Hg, directed out of the vessel"},{"label":"D","text":"10 mm Hg, directed into the vessel"}]$q$::jsonb,
    'C',
    $q$This question sits in the Organ Systems category and tests the three way pressure balance that sets the rate of filtration in the renal corpuscle. The answer is C because the 55 mm Hg pushing outward is opposed both by the 15 mm Hg of fluid already sitting in the capsular space and by the 30 mm Hg of colloid osmotic pull from retained plasma proteins, so 55 minus 45 leaves 10 mm Hg acting outward. The two opposing terms are summed first and then subtracted as a single quantity, because both act inward on the same barrier. The capsular term matters here in a way it does not in most vascular beds: fluid that crosses the wall enters an enclosed chamber with one narrow exit, so it builds a back pressure of its own that the blood must overcome. The osmotic term is large precisely because almost no protein crosses; with the far side effectively protein free, the fluid there exerts virtually no osmotic pull of its own and contributes nothing to the outward side of the ledger. The surviving margin is only about 10 mm Hg, which is why a shift of a few mm Hg in any single term produces a large proportional change in the volume filtered each minute.

(Choice A) 40 mm Hg results from subtracting only the fluid pressure in the capsular chamber and forgetting that retained plasma proteins also hold fluid back. This overstates the true driving force fourfold.

(Choice B) 25 mm Hg comes from subtracting only the colloid osmotic term. That is the balance one would write for a bed draining into open interstitial space, but it ignores the enclosed chamber on the far side of this particular barrier, which pushes back with a substantial 15 mm Hg.

(Choice D) A 10 mm Hg force acting inward has the right magnitude but the wrong sign. A corpuscle operating that way would reclaim fluid from the tubule rather than produce the roughly 180 liters of filtrate formed each day, and the arithmetic gives a positive outward remainder because 55 exceeds the sum of 15 and 30.

This is a Data-based and Statistical Reasoning question because it asks the student to combine three separately measured pressures with the correct signs and report both the size and the direction of the result.$q$,
    'easy',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    4,
    75
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$omitted opposing term$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$ignored capsular back pressure$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$sign inversion$q$ FROM q;

-- Q6 . Downstream obstruction and filtration rate . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Downstream obstruction and filtration rate$q$,
    $q$A stone lodges in one ureter and completely blocks outflow from that kidney, while the opposite kidney is untouched. One hour later the mean arterial pressure, the plasma protein concentration, and the blood flow through the blocked kidney are all unchanged, yet the volume of fluid entering the tubules on that side has dropped to about a fifth of its former value. Which of the following occur in a nephron of the blocked kidney?

I. Fluid pressure inside the capsular space has risen.
II. The net pressure driving fluid out of the glomerular capillary has fallen.
III. Blood hydrostatic pressure inside the glomerular capillary has fallen below the blood colloid osmotic pressure.$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"I and II only"},{"label":"C","text":"II and III only"},{"label":"D","text":"I, II, and III"}]$q$::jsonb,
    'B',
    $q$This question sits in the Organ Systems category and tests how a mechanical block far downstream of the nephron feeds back on the balance of forces at the filtering surface. The answer is B because fluid that keeps crossing the barrier now has nowhere to drain, so it accumulates upstream of the stone and raises the pressure inside the capsular chamber, and that rising back pressure subtracts directly from the outward drive. Statement I is therefore the cause and statement II is its consequence. The instructive feature of this scenario is that nothing on the blood side has moved: arterial pressure, plasma protein concentration and renal blood flow are all held constant, so neither the outward hydrostatic term nor the inward colloid osmotic term has changed. Filtration nevertheless collapses, and the only remaining term that can account for it lies on the far side of the barrier. This is why an obstructed ureter can silence a kidney within hours in a patient whose blood pressure is entirely normal, and why relieving the obstruction restores function if it is done soon enough.

(Choice A) Statement I is true but stops short of the outcome described. A rise in capsular pressure matters here only because it enters the balance as an opposing term, and naming the rise without carrying it through to the net outward drive leaves the fall in filtered volume unexplained.

(Choice C) Pairing II with III places the pressure change on the wrong side of the barrier. A downstream blockage raises the pressure of fluid that has already crossed, not the pressure of the blood upstream of the filtering surface, which is set by an arterial supply whose mean pressure and flow the stem holds steady.

(Choice D) This keeps the two correct statements but adds the same error as choice C. Statement III also contradicts the conditions given, since a fall in glomerular blood pressure large enough to abolish filtration could not occur while both the mean arterial pressure and the blood flow through that kidney remain at their former values.

This is a Scientific Reasoning and Problem Solving question because it asks the student to start from an observed collapse in filtered volume and work backwards to identify which single term in the pressure balance must have moved.$q$,
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
  SELECT q.id, 'A', 'partial_truth', $q$cause without consequence$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$wrong side of the barrier$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$only blood side can change$q$ FROM q;

-- Q7 . Barrier conductance as a determinant of filtration rate . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Barrier conductance as a determinant of filtration rate$q$,
    $q$In a rat model of glomerular injury, micropuncture of an affected nephron shows the blood hydrostatic pressure inside the glomerulus, the fluid pressure in Bowman's space, and the colloid osmotic pressure of the glomerular blood all at their usual values. Blood flow to that nephron is normal as well, yet the fluid it forms each minute is half of the control value. Which explanation is best supported?$q$,
    $q$[{"label":"A","text":"The fluid pressure in Bowman's space must in fact be raised, since filtration cannot fall while every measured pressure is normal."},{"label":"B","text":"The colloid osmotic pressure of the blood must be higher than the sampled figure, since taking water out concentrates the proteins left behind."},{"label":"C","text":"Fluid leaving the blood early in the bed is drawn back into it later in the bed, so the net amount collected is halved."},{"label":"D","text":"The push across the wall is only one term; how much wall remains open and how readily it lets water pass also set the rate, and both have been reduced."}]$q$::jsonb,
    'D',
    $q$This question sits in the Organ Systems category and tests what sets the volume of filtrate a single corpuscle produces once the pressure balance has been accounted for. The answer is D because the rate at which fluid crosses the wall is the product of two independent things: the net pressure pushing it, and the ease with which the wall itself lets water by, which reflects both how much filtering surface is open and how leaky that surface is per unit of area. Every pressure term in this nephron is at its usual figure, so the net push is unchanged and cannot account for the loss, and the blood supply is normal as well. The remaining factor is the wall itself. Injury that scars part of the tuft, or that makes the supporting cells wrapped around the loops contract and take loops out of service, removes filtering surface without moving any pressure, and injury to the covering cells that form the slits lowers how easily water moves per unit of the surface that remains. Either change halves output while leaving every micropipette reading normal, which is why a corpuscle can fail quietly in a patient whose blood pressure is entirely ordinary.

(Choice A) This insists that a pressure must have moved because nothing else could have, which is exactly the assumption the scenario is built to break. The value in the capsular space was measured directly and came back normal, so discarding the measurement in order to protect the assumption is the weaker inference.

(Choice B) Removing water does concentrate the proteins left in the blood, so the colloid osmotic term genuinely climbs from one end of the bed to the other. That happens in a healthy corpuscle too, so it cannot explain why this one yields half as much fluid as a control in which the same concentrating effect occurs.

(Choice C) Nothing in the corpuscle pulls fluid back out of the capsular space. The fluid there carries essentially no protein and so exerts no osmotic pull of its own, and its hydrostatic pressure stays well below the pressure in the glomerular blood along the whole length of the bed, so the movement never turns around.

This is a Scientific Reasoning and Problem Solving question because it asks the student to rule out every term in the pressure balance using the values supplied and then identify the property of the barrier that must have changed instead.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$pressure is the whole story$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$true but non discriminating$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$behavior borrowed from another bed$q$ FROM q;

-- Q8 . Protein binding and filtrate solute composition . medium . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Protein binding and filtrate solute composition$q$,
    $q$A fine glass pipette is placed in Bowman's space of a single nephron in an anaesthetised rat, and fluid is collected at the instant it forms, on the far side of the corpuscular wall and before it has reached any tubular segment. Blood taken from the renal artery at the same moment is spun down and its cell free liquid is assayed.

| Substance | Blood, cell free liquid | Bowman's space fluid |
| --- | --- | --- |
| Sodium | 142 mmol/L | 142 mmol/L |
| Potassium | 4.3 mmol/L | 4.3 mmol/L |
| Glucose | 5.1 mmol/L | 5.1 mmol/L |
| Urea | 5.4 mmol/L | 5.4 mmol/L |
| Creatinine | 0.09 mmol/L | 0.09 mmol/L |
| Total calcium | 2.4 mmol/L | 1.3 mmol/L |
| Albumin | 42 g/L | 0.02 g/L |

Albumin is a 66 kDa protein; every other entry in the table is a small solute less than 1 nm wide. Which conclusion about the calcium rows is best supported by these readings?$q$,
    $q$[{"label":"A","text":"Roughly half of this ion travels docked to a macromolecule that the wall holds back, so its unattached form sits at the same level on either side."},{"label":"B","text":"The corpuscular wall pumps this ion back into the blood as fluid crosses, keeping its level in Bowman's space below its level in blood."},{"label":"C","text":"Part of this ion had already been taken back into the blood by the tubule before the sample was drawn, which is why less of it remains."},{"label":"D","text":"The share of this ion that is bound to plasma protein is the share that crosses the wall, and the free share is the one held back."}]$q$::jsonb,
    'A',
    $q$This Organ Systems item tests what the composition of newly formed glomerular fluid reveals about which physical form of a solute is able to pass the corpuscular wall. The answer is A because a solute that circulates partly bound to a plasma protein presents only its free portion to the sieve, so its total concentration falls on the far side while its free concentration does not. Sodium, potassium, glucose, urea and creatinine read identically in both columns, the signature of water sweeping small solutes bodily through open pores rather than any selective handling. Albumin, at 42 g/L in blood and essentially nil in the sampled fluid, shows that the wall retains the large plasma protein, so what forms is otherwise a copy of the liquid phase of blood. Calcium is the lone outlier, 2.4 mmol/L against 1.3 mmol/L, and the one property that separates calcium from the other small solutes is that about half of it circulates attached to albumin. The attached portion leaves with the albumin, the free portion passes without hindrance, and the free calcium concentration is therefore the same in both compartments even though the totals are not.

(Choice B) The renal corpuscle is a sieve, not a transporting epithelium: it presents fenestrated endothelium, a basement membrane and podocyte filtration slits, and no pump that drives a solute back across the wall. Had such a pump been at work, sodium, potassium and glucose, all of which are handled by carriers elsewhere in the nephron, would show gaps here as well, and they do not.

(Choice C) The fluid was collected in Bowman's space before it reached any tubular segment, so reabsorption has had no opportunity to act on it. Calcium reabsorption in the proximal tubule and the loop is real, but it operates on fluid that has already left the sampling point and cannot produce a difference present at the moment of formation.

(Choice D) This inverts which pool moves. Attachment to a large plasma protein is precisely what prevents a solute from crossing, so the attached pool stays behind and the free pool passes. If the attached pool crossed instead, albumin itself would have to appear in Bowman's space in quantity, yet it reads 0.02 g/L, a trace.

This is a Data-based and Statistical Reasoning question because it asks the student to compare two columns of a table, locate the single row that breaks an otherwise perfect match, and infer the physical reason for that one departure rather than read any listed value off the table.$q$,
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
  SELECT q.id, 'B', 'misconception', $q$Treats the renal corpuscle as a selectively transporting epithelium rather than a passive sieve$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$Attributes a filtration stage observation to the later tubular reabsorption stage$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$Swaps which pool, bound or free, is the filterable one$q$ FROM q;

-- Q9 . Size limit of the filtration barrier and routes into tubular fluid . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Size limit of the filtration barrier and routes into tubular fluid$q$,
    $q$Testing of a patient's urine reveals globulin molecules of roughly 150 kDa present at about one third of their concentration in plasma. No segment of the nephron possesses a carrier able to move intact molecules of that mass into the lumen. Which of the following accounts for this finding?$q$,
    $q$[{"label":"A","text":"Size selectivity at the renal corpuscle has been lost, admitting particles normally held inside the capillary."},{"label":"B","text":"The transport maximum for glucose in the proximal convoluted tubule has been exceeded by the filtered load."},{"label":"C","text":"Removal of water in the collecting duct has concentrated an amount of that protein that is ordinarily present."},{"label":"D","text":"Secretion of creatinine into the distal portion of the nephron has risen sharply above its usual rate."}]$q$::jsonb,
    'A',
    $q$This item sits in the Organ Systems category and tests the size limit of the sieve that produces the initial filtrate. The answer is A because a globulin of roughly 150 kDa cannot cross that sieve in a healthy kidney, and the stem has closed off every other route by which such a molecule could reach the tubular fluid. The fluid captured at the head of the nephron differs from blood chiefly in that it contains no cells and no medium to large proteins, both of which stay behind in the capillary. Anything found downstream must therefore have arrived either at that entry point or by being handed into the lumen from the surrounding blood. The stem rules out the second route explicitly for a molecule of this mass, since no carrier moves an intact protein of that size across the tubular epithelium. Only entry at the front of the nephron remains, which means the sieve there is admitting particles it ordinarily rejects outright. (Choice B) The transport maximum for glucose governs a sugar of under 200 daltons that is ordinarily recovered in full early in the tubule. Saturating that system spills sugar into the urine and says nothing whatever about the handling of a molecule nearly a thousand times heavier. (Choice C) Removing water downstream does raise the concentration of everything already in the tubular fluid, but healthy filtrate carries only a trace of large protein, a tiny fraction of one percent of the plasma level. No degree of water removal the kidney can achieve would lift that trace to one third of the plasma value, so concentration alone cannot produce this result. (Choice D) Creatinine is genuinely added to the lumen from the peritubular blood, but that pathway serves small organic solutes and organic acids and bases. It has neither the capacity nor the mechanism to move an intact 150 kDa protein, and creatinine itself would not register as a globulin on testing. This is a Knowledge of Scientific Concepts and Principles question because it asks the student to apply the known size limit of the barrier at the head of the nephron in order to interpret an abnormal protein finding in urine.$q$,
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
  SELECT q.id, 'B', 'adjacent_fact', $q$true statement about a different solute$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$correct mechanism, insufficient magnitude$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$real secretory pathway, wrong molecular class$q$ FROM q;

-- Q10 . Fixed anionic charge and charge selectivity . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Fixed anionic charge and charge selectivity$q$,
    $q$Rats are treated with an enzyme that strips the fixed negative charges lining the glomerular capillary wall, the basement membrane and the podocyte slits. Electron micrographs confirm that slit width and endothelial pore diameter are unchanged. The animals then receive two inert dextran tracers of identical 3.6 nm effective radius, small enough that neither is excluded on size alone: X carries a net negative charge and Y is electrically neutral. Compared with untreated animals, how should the two tracers appear in fluid collected from Bowman's capsule?$q$,
    $q$[{"label":"A","text":"X and Y both rise by the same proportion."},{"label":"B","text":"Y rises steeply in the filtrate while X shifts hardly at all."},{"label":"C","text":"X rises steeply in the filtrate while Y shifts hardly at all."},{"label":"D","text":"X and Y both rise, with Y showing the larger increase."}]$q$::jsonb,
    'C',
    $q$This question belongs to the Organ Systems category and tests the separation of two independent selection mechanisms operating at the same barrier. The answer is C because the enzyme abolishes an obstacle that acted on one tracer only, and the tracer it never acted on has nothing to gain. The barrier can be treated as two filters applied to the same stream: a geometric one set by the dimensions of the endothelial windows and the gaps between neighboring foot processes, and an electrostatic one set by the fixed anionic groups lining those pathways. The stem states that both tracers sit below the geometric limit, so on dimensions alone both are admitted. In the untreated animal the anionic species is repelled by the like charges fixed along the wall of the pathway and therefore appears in far smaller amounts than the neutral species of identical size. Once the fixed charge is stripped, and with the micrographs certifying that no opening has widened, the repelled species loses the only thing that was holding it back and its passage climbs toward that of the neutral species. The neutral tracer was already crossing at close to the rate its size permits, so it has almost no headroom to increase. (Choice A) An equal proportional rise treats the barrier as if charge acted on both species alike. If the wall were a pure size sieve the enzyme would change nothing at all, and if charge matters then only the charged species can be released by removing it, so this option is internally inconsistent. (Choice B) This has the direction of the electrostatic effect backwards. The neutral tracer is by definition immune to a fixed charge, so it cannot be the species freed by removing that charge, whereas the negatively charged species is the one being repelled. (Choice D) This gets the direction of change right but assigns the larger response to the wrong species. Both could rise slightly if any nonspecific damage occurred, yet the tracer that stood to gain most is unambiguously the one whose exclusion depended on the charge that was just removed. This is a Scientific Reasoning and Problem Solving question because it asks the student to hold pore geometry constant, isolate charge as the single altered variable, and predict the differential response of two otherwise identical tracers.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$barrier is size only$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', $q$charge effect applied to the wrong tracer$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$right direction, wrong species dominates$q$ FROM q;

-- Q11 . Layer specific failure of the serial barrier . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Layer specific failure of the serial barrier$q$,
    $q$A mutation abolishes the protein that bridges the gap between adjacent podocyte foot processes. Electron microscopy and biochemical assay show the endothelial pores and the basement membrane to be entirely normal. Which of the following would be expected in the fluid entering the proximal convoluted tubule?

I. Plasma proteins present in appreciable amounts
II. Intact erythrocytes present
III. Glucose present at its plasma concentration$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"II only"},{"label":"C","text":"I and II only"},{"label":"D","text":"I and III only"}]$q$::jsonb,
    'D',
    $q$This question belongs to the Organ Systems category and tests which of the structures standing in series at the renal corpuscle holds back which class of particle. The answer is D because the mutation widens the narrowest restriction in the series while leaving intact the far coarser one that arrests cells, and small solutes were never restricted by any layer to begin with. Fluid crossing into the capsule passes three structures one after another, and each has a different effective limit, so a defect in one predicts a specific set of consequences rather than a general opening. The innermost layer is perforated by windows measured in tens of nanometers, which is ample to arrest a cell roughly a hundred times that size but far too coarse to detain a dissolved protein. The gaps between adjacent foot processes form the narrowest passage in the series and are among the structures that keep albumin sized proteins on the blood side, so abolishing the bridge that spans them lets appreciable protein through and statement I holds. An erythrocyte is stopped much earlier, at a layer the stem certifies as normal, so statement II fails. Glucose is a few hundred daltons and crosses every layer freely in health, entering the tubule at the same concentration it has in plasma, so statement III describes an ordinary event that the defect does not disturb. (Choice A) This correctly anticipates the protein leak but drops statement III, treating the ordinary free passage of a small sugar as though it should be disturbed by a defect in a protein sized restriction. Glucose entry is unchanged and is therefore expected. (Choice B) This assigns cell retention to the damaged element. Cells never reach the foot processes because they are held at the perforated inner layer, which the stem reports as structurally normal, so intact red cells should not appear. (Choice C) This pairs the correct protein prediction with the wrong layer for cells, treating the barrier as though a single failure opened it to everything at once rather than as a graded sequence in which the coarse restriction survives. This is a Scientific Reasoning and Problem Solving question because it asks the student to trace a defect localized to one element of a serial barrier forward to the precise set of particles that will and will not cross.$q$,
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
  SELECT q.id, 'A', 'partial_truth', $q$correct leak, forgets the unchanged normal finding$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$cells held by the wrong layer$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$serial barrier collapsed into a single filter$q$ FROM q;

-- Q12 . Clearance as a filtration rate marker . medium . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Clearance as a filtration rate marker$q$,
    $q$Substance Q is an inert polysaccharide that is freely filtered at the renal corpuscle and is neither reabsorbed nor secreted at any point in the nephron. Q is infused to a steady plasma level in a patient, and the clearances of Q and of three endogenous solutes are measured over the same collection period.

| Substance | Clearance (mL/min) |
|---|---|
| Q | 118 |
| R | 0 |
| S | 62 |
| T | 174 |

Which conclusion do these values support?$q$,
    $q$[{"label":"A","text":"R is added to the tubular fluid from the surrounding blood after it has been filtered."},{"label":"B","text":"T is passed into the tubular fluid from the surrounding blood, beyond what arrives initially."},{"label":"C","text":"S is held back entirely at the barrier and never enters the tubular fluid in the first place."},{"label":"D","text":"S and T both have part of their load returned to the blood, S to a greater extent than T."}]$q$::jsonb,
    'B',
    $q$This question belongs to the Organ Systems category and tests the use of a purely filtered marker as a yardstick against which other solutes are judged. The answer is B because Q fixes the yardstick at 118 mL/min, and only a solute that is put into the lumen by a second route can produce a value above that ceiling. Clearance expresses the volume of plasma stripped completely free of a solute each minute, so for a substance that enters the lumen only by filtration and is then left alone, clearance equals the volume of plasma filtered each minute. That makes Q's value the reference figure for this patient. A solute whose value falls below the reference must have had part of its filtered load returned to the blood, and a solute whose value is zero must have had all of it returned. A value above the reference cannot be explained by filtration at all, because filtration cannot deliver more than the reference volume; the excess must be transferred into the lumen from the peritubular blood, which is exactly what T's 174 mL/min shows. (Choice A) A value of zero is the signature of complete recovery, not of addition. Adding a solute to the lumen can only push the value upward, so R at zero indicates that everything filtered was taken back, as happens with glucose below its transport ceiling. (Choice C) A solute barred from the initial filtrate and not otherwise added would leave the plasma untouched and register a value of zero. S sits at roughly half the reference figure, which instead means it is filtered normally and then about half of the filtered load is retrieved. (Choice D) The first half of this is right, since S at 62 is below the reference and so is partly retrieved, but T at 174 exceeds the reference. A solute that is only filtered and then partly retrieved can never exceed the reference, so T cannot be undergoing net recovery at all. This is a Data-based and Statistical Reasoning question because it asks the student to establish a reference value from one row of a table and then classify the remaining measurements as above, below or at that reference in order to infer the direction of net transport.$q$,
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
  SELECT q.id, 'A', 'reversed_relationship', $q$secretion and reabsorption inverted$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$low clearance read as failure to filter$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$one solute classified correctly, the other impossible$q$ FROM q;

-- Q13 . Renal autoregulation across a pressure range . hard . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Renal autoregulation across a pressure range$q$,
    $q$An anaesthetised animal has an adjustable clamp on the renal artery, and filtration rate for that kidney is recorded at a series of fixed arterial pressures. At 60 mmHg the filtration rate is 45 percent of its peak, but at every pressure from 80 to 180 mmHg it stays between 98 and 102 percent of peak. The investigator wants to know whether this flat stretch is produced by an active change in the calibre of the vessels feeding the glomeruli, or whether those vessels stay passive and the constancy is imposed somewhere past the filtration barrier. Which additional recording at each pressure would best separate the two possibilities?$q$,
    $q$[{"label":"A","text":"The protein content of fluid drawn from Bowman's capsule."},{"label":"B","text":"The volume of blood leaving the organ's vein each minute."},{"label":"C","text":"Urine output per unit time."},{"label":"D","text":"A repeat series in which the clamp is opened to 180 mmHg in one abrupt jump."}]$q$::jsonb,
    'B',
    $q$This item falls under Organ Systems and tests renal autoregulation, specifically what evidence separates an active adjustment of vessel calibre from a passive consequence of the plumbing. The answer is B because the volume of blood the organ receives each minute is the one quantity that reveals whether resistance upstream of the glomeruli is being raised in step with the driving pressure. A flat filtration curve on its own is silent about mechanism, since it is equally compatible with supply vessels that narrow progressively as pressure climbs and with supply vessels that stay wide while the constancy is imposed somewhere past the filtration barrier. Flow settles the matter. If flow through the organ is also flat while pressure more than doubles, then resistance in the supply vessels must have risen almost in proportion to pressure, which no passive tube can do, so the regulation lives in the vessel wall. If instead flow climbs roughly in a straight line with pressure while filtration stays flat, the supply vessels are plainly not adjusting, and the constancy has to be generated downstream of them. Notice that the two candidate explanations predict identical values for the variable already in hand, which is exactly why a second variable is needed. (Choice A) Protein in capsular fluid reports on the selectivity of the barrier, a separate property that neither candidate mechanism predicts would change, so it cannot discriminate between them. (Choice C) Urine output lies far downstream of filtration and is shaped by reabsorption and secretion along the whole tubule, so any pattern of urine output is consistent with either explanation and isolates nothing. (Choice D) An abrupt single jump alters only how fast the stimulus is applied, not which variable is recorded, and it discards the graded series that made the flat stretch visible in the first place, so it adds no discriminating information. This is a Reasoning about the Design and Execution of Research question because it asks the student to select the one additional recording that pulls apart two mechanisms that make identical predictions for the measurement already collected.$q$,
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
  SELECT q.id, 'A', 'adjacent_fact', $q$true statement about a different renal property$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$downstream proxy mistaken for the target variable$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$manipulating stimulus timing instead of adding a measurement$q$ FROM q;

-- Q14 . Macula densa position and luminal salt sensing . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Macula densa position and luminal salt sensing$q$,
    $q$In a micropuncture experiment, the fluid running through the loop of a single nephron is switched to a solution in which dissolved salt is raised well above normal, delivered at exactly the previous rate. Within seconds the vessel supplying that same glomerulus narrows and that nephron's filtration rate falls, while every neighbouring nephron is unchanged. Where does the structure responsible for this response sit, and what does it register?$q$,
    $q$[{"label":"A","text":"In the wall of the distal convoluted tubule where it presses against the afferent arteriole, registering the sodium chloride concentration of the fluid in the tubule lumen."},{"label":"B","text":"In the wall of the afferent arteriole itself, registering the sodium chloride concentration of the blood arriving at the glomerulus."},{"label":"C","text":"In the layer of cells lining Bowman's capsule, registering the rate at which filtrate enters the nephron."},{"label":"D","text":"In the wall of the distal convoluted tubule where it presses against the afferent arteriole, registering the wall tension of that vessel."}]$q$::jsonb,
    'A',
    $q$This item falls under Organ Systems and tests the position of the tubular salt sensor and the compartment it actually samples. The answer is A because the manipulation was confined to the fluid running through one nephron, so whatever triggered the vascular response must sit where it can sample that fluid at a point past the perfused segment, and the only place the tubule presses against its own supply vessel is where the early distal convoluted tubule contacts the afferent arteriole. The cells there read the salt concentration of the fluid sliding past their apical surface and release local paracrine signals that make the upstream vessel constrict, which lowers filtration in that one nephron. Two features of the result pin the answer down. First, the rate of delivery was deliberately held constant, so a sensor of flow rate had nothing new to detect and the change in salt concentration is the only candidate stimulus. Second, neighbouring nephrons were untouched: a sensor that read the blood, or any signal carried through the circulation, would have acted across the whole organ, whereas a sensor that reads one tubule's own fluid can only act on that tubule's own vessel. This one to one coupling between a single tubule and a single arteriole is the structural signature of the sensor's location. (Choice B) A sensor bathed by blood in the arteriole wall would be sampling a compartment that was never altered, and it could not explain why the effect was restricted to the perfused nephron rather than spread across the kidney. (Choice C) The capsular lining surrounds the filtration barrier and sits upstream of the perfused segment, so it cannot register a change generated further along the tubule, and the entry rate of filtrate was not what the investigator manipulated. (Choice D) The location here is right but the stimulus is wrong: wall tension is the adequate stimulus for the vessel's own stretch sensitive smooth muscle, a separate mechanism, and nothing in this experiment altered the pressure inside the arteriole, since the trigger originated inside the tubule. This is a Scientific Reasoning and Problem Solving question because it asks the student to work backwards from a deliberately localised experimental result to the anatomical position and the adequate stimulus of the sensor that must have produced it.$q$,
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
  SELECT q.id, 'B', 'misconception', $q$sensor reads plasma rather than tubular fluid$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$a real structure at the wrong point in the flow path$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$correct site paired with the stimulus belonging to the other mechanism$q$ FROM q;

-- Q15 . Isolating the arteriolar myogenic stretch response . hard . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Isolating the arteriolar myogenic stretch response$q$,
    $q$A kidney is perfused in place with its nerve supply intact. A pipette allows the fluid inside the tubular segment that lies against one afferent arteriole to be perfused independently, while the pressure inside that arteriole is stepped upward. An investigator wants to show that the smooth muscle of the arteriole shortens as a direct response to being stretched, with no contribution from the salt sensor in the tubule wall and none from any signal originating outside the kidney. Which of the following steps are required?

I. Perfuse that tubular segment throughout at a fixed rate with a solution of unchanging salt content.
II. Cut the nerves running to the kidney and perfuse it with a fluid free of circulating messengers.
III. Interrupt delivery to that tubular segment entirely, so that nothing passes the sensor during each pressure step.$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"II only"},{"label":"C","text":"I and II only"},{"label":"D","text":"I, II, and III"}]$q$::jsonb,
    'C',
    $q$This item falls under Organ Systems and tests how to isolate the vessel wall's own stretch response from the other influences that converge on the same arteriole. The answer is C because a clean demonstration requires silencing every alternative source of constriction while leaving stretch as the only thing that varies, and steps I and II do exactly that while step III reintroduces the very influence the design is meant to remove. Statement I is required because the tubular sensor responds to the salt concentration and the flow rate of the fluid passing it, so holding both fixed guarantees that any narrowing seen after a pressure step cannot have come from that route. Statement II is required because the preparation still carries its nerves and is still perfused, so a constriction could otherwise be attributed to a command arriving from outside the organ rather than to the wall itself. Statement III is not required and is actively harmful: when almost no salt reaches that sensor it releases less of its constricting paracrine signal and the same arteriole dilates, so cutting delivery to zero does not silence the tubular route but drives it hard in one direction, and it destroys the very constancy that statement I was included to create. With I and II in place, the pressure step becomes the only manipulated variable and the wall's shortening can be attributed to stretch alone. (Choice A) Step I alone controls the tubular route but leaves nerves and circulating signals free to act on the same vessel, so a constriction could still have an origin outside the kidney. (Choice B) Step II alone excludes outside signals but leaves the tubular sensor free to respond to whatever the pressure step does to delivery along the nephron, which is a serious confound in this preparation. (Choice D) Adding step III swings the tubular sensor to one extreme instead of holding it still, so including it weakens rather than strengthens the design. This is a Reasoning about the Design and Execution of Research question because it asks the student to decide which controls are necessary to attribute an observed constriction to stretch of the vessel wall rather than to a competing sensor or to a signal arriving from outside the organ.$q$,
    'hard',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    3,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$a necessary control mistaken for a sufficient one$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$the external control alone$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$belief that more manipulation always means better control$q$ FROM q;

-- Q16 . Dialysate composition and gradient design . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Dialysate composition and gradient design$q$,
    $q$A haemodialysis circuit runs a patient's blood along one face of a membrane that passes small solutes but holds back proteins and cells, with a prepared bath flowing along the other face. The bath is matched to plasma for sodium, bicarbonate and calcium, and holds no urea, but because of an error during preparation it also holds no glucose. What is the most likely result over a four hour run?$q$,
    $q$[{"label":"A","text":"Waste clearance speeds up, because the lighter solute load in the bath steepens every outward gradient."},{"label":"B","text":"Nothing measurable happens, because a membrane sized to pass small wastes will not admit a particle of that size."},{"label":"C","text":"The patient's circulating fluid falls sharply as water is dragged into the bath behind the absent solute."},{"label":"D","text":"Blood sugar drops, since nothing on the far side opposes its outward diffusion."}]$q$::jsonb,
    'D',
    $q$This item falls under Organ Systems and tests the logic behind the composition of the fluid on the far side of an artificial filtering membrane. The answer is D because a bath sets an independent gradient for every solute small enough to cross, and a solute held at zero on one side will move down its gradient until the two sides converge. The design principle is therefore symmetric in two directions. Substances the treatment is meant to remove, such as urea, are left out of the bath so that their gradient points steadily outward across the whole run. Substances the patient must keep, such as sodium, bicarbonate and calcium, are supplied at plasma levels so that their gradient is flat and no net movement occurs. Sugar belongs firmly in the second group, since it is small enough to cross freely, so omitting it turns a solute meant to be preserved into one that is removed exactly as if it were a waste product. Over hours of continuous exposure to a large volume of bath, that loss can become clinically serious rather than trivial. (Choice A) A bath carrying fewer solutes does not steepen the gradient for urea, because urea was already absent from the bath and its gradient was already maximal, so leaving out an unrelated substance cannot improve waste removal. (Choice B) The membrane is described as passing small solutes, and sugar is in that size class, so appealing to exclusion by size contradicts the stated property of the barrier. (Choice C) The osmotic pull created by one missing small solute is a tiny fraction of total plasma osmolarity, so the reasoning about direction is right but the predicted magnitude is far too large to describe the dominant outcome. This is a Scientific Reasoning and Problem Solving question because it asks the student to reason from the composition of a bath to the direction of net movement for each solute and then predict the consequence of a single omission.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$belief that total solute load rather than per solute gradient drives clearance$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$size exclusion invoked against the stated membrane property$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'scale_unit_error', $q$correct osmotic direction at a wildly inflated magnitude$q$ FROM q;

-- Q17 . Isosmotic bulk reabsorption in proximal tubule . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Isosmotic bulk reabsorption in proximal tubule$q$,
    $q$In an isolated perfused kidney, the water channels lining the proximal convoluted tubule are blocked while sodium reabsorption there proceeds at its usual rate. Fluid is sampled at the point where that segment ends. How does that sample compare with fluid sampled at the same point in an untreated kidney?$q$,
    $q$[{"label":"A","text":"Iso-osmotic with blood, with flow above baseline"},{"label":"B","text":"Hypo-osmotic to blood, with flow above baseline"},{"label":"C","text":"Hyper-osmotic to blood, with flow above baseline"},{"label":"D","text":"Hypo-osmotic to blood, with flow at baseline"}]$q$::jsonb,
    'B',
    $q$This Organ Systems item tests how the first stretch of the nephron reclaims a large share of what is filtered while handing on fluid whose particle concentration is unchanged, and what breaks when solute movement and water movement are uncoupled. The answer is B because sodium and the solutes carried alongside it keep leaving the lumen while water is prevented from following, so the fluid passed downstream is both dilute and larger in amount than usual. In an intact kidney this segment is unusually leaky to water, so each particle pumped into the surrounding interstitium is followed almost immediately by enough water to keep the two compartments matched. That tight coupling is why roughly two thirds of the filtered fluid can be recovered here without the remaining stream becoming any more or any less concentrated than blood. Once the water route is shut, the coupling fails: pumping continues, particles leave, but the water they would have dragged with them stays behind. The residual stream therefore holds fewer particles dispersed through nearly the original quantity of water, which is a dilute fluid arriving downstream at an elevated rate.

(Choice A) This correctly anticipates the extra volume but keeps the concentration matched to blood. Matched concentration is not a fixed property of the segment; it is a consequence of the high water permeability that the experiment abolishes, so once water cannot follow the departing solute the remaining fluid must fall below blood in concentration.

(Choice C) This reverses the direction of the change. Concentration would rise only if water left faster than particles did, which is what happens in a water-permeable stretch sitting in a salty interstitium, not in a segment whose water route has been closed while pumping continues.

(Choice D) The dilution is right, but the flow is not. Every unit of water that fails to be recovered here stays in the lumen, so the quantity moving on must rise; a normal flow would imply water was still leaving despite the block.

This is a Scientific Reasoning and Problem Solving question because the student must predict two linked downstream measurements, concentration and flow, from a single experimental lesion rather than recall what the segment normally does.$q$,
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
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', NULL FROM q;

-- Q18 . Filtered load sets urinary appearance . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Filtered load sets urinary appearance$q$,
    $q$Substance Z is freely filtered at the glomerulus and is reclaimed by proximal carriers that together can move no more than 300 mg per minute. In subject J the blood level of Z is 250 mg/dL and the filtration rate is 90 mL/min, while in subject K, who is hyperfiltering, the blood level is 175 mg/dL and the filtration rate is 180 mL/min. In which subject or subjects does Z appear in the urine?$q$,
    $q$[{"label":"A","text":"J only"},{"label":"B","text":"Both J and K"},{"label":"C","text":"Neither J nor K"},{"label":"D","text":"K only"}]$q$::jsonb,
    'D',
    $q$This Organ Systems item tests the quantity that actually reaches the carriers each minute, which is the product of the filtration rate and the blood level, and why that product rather than the blood level alone decides what ends up in urine. The answer is D because K delivers 315 mg of Z to the tubule every minute against a reclaiming ceiling of 300 mg per minute, while J delivers only 225 mg per minute and so loses none. Converting units first, 250 mg/dL is 2.5 mg/mL, and 2.5 multiplied by 90 gives 225 mg per minute for J. For K, 175 mg/dL is 1.75 mg/mL, and 1.75 multiplied by 180 gives 315 mg per minute. Everything up to the ceiling is pulled back, so J's entire delivery is recovered and K's excess of 15 mg per minute has nowhere to go but the urine. The instructive point is that the subject with the higher blood level spills nothing: doubling the rate at which plasma is strained more than compensates for a lower concentration, so the delivered quantity, not the concentration, is what the carriers actually face.

(Choice A) This picks the subject with the higher blood level and stops there. Concentration alone says nothing about how many milligrams arrive per minute, and J's low filtration rate keeps the delivery comfortably under the ceiling.

(Choice B) This follows from multiplying the given numbers without converting deciliters to milliliters, which inflates both deliveries by a factor of one hundred and puts each of them far above the ceiling. Checking that the answer has a plausible magnitude catches the slip.

(Choice C) This is right that a ceiling exists and right that a raised blood level does not by itself force spillage, but it misses that the filtration rate is the other multiplier. A high enough filtration rate can push a modest concentration past the ceiling, which is exactly K's situation.

This is a Scientific Reasoning and Problem Solving question because the student must convert units, compute two delivery rates, compare each against a fixed ceiling, and resist the intuition that the higher blood level identifies the spiller.$q$,
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
  UNION ALL SELECT q.id, 'B', 'scale_unit_error', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', NULL FROM q;

-- Q19 . Proximal secretion adds to what is filtered . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Proximal secretion adds to what is filtered$q$,
    $q$A small drug that does not bind plasma proteins passes freely into the filtrate at the glomerulus. In a steady state, the amount of drug leaving in the urine each minute is measured and found to be well above the amount entering the nephron in the filtrate each minute. Which handling step accounts for that difference?$q$,
    $q$[{"label":"A","text":"Cells of the proximal tubule move the drug out of the surrounding interstitial fluid and into the lumen"},{"label":"B","text":"The drug travels the whole length of the tubule untouched, so everything strained out simply continues onward"},{"label":"C","text":"Carriers pull the drug back out of the lumen, but they work at a fixed ceiling that the drug exceeds"},{"label":"D","text":"Water recovery downstream concentrates the drug in the urine, which raises the amount leaving each minute"}]$q$::jsonb,
    'A',
    $q$This Organ Systems item tests the three-way bookkeeping of the nephron, in which what leaves in the urine equals what is strained out, plus whatever the tubule adds to the lumen, minus whatever the tubule pulls back. The answer is A because the only step that can raise the urinary amount above the amount strained out is transport in the opposite direction, from the blood and interstitial fluid beside the tubule into the lumen, and the proximal tubule carries the carrier systems that do this for foreign compounds such as drugs. Straining at the glomerulus sets an upper limit on how much can reach the lumen that way, so no amount of straining alone explains the excess. Pulling material back out of the lumen can only lower the urinary amount, never raise it. That leaves addition to the lumen as the only possibility, and the excess measured is exactly the amount added.

(Choice B) A substance that is strained out and then ignored by the tubule leaves in the urine at the same rate at which it enters the filtrate, not at a higher rate. This describes the ideal marker used to gauge the straining rate itself, which is precisely why it cannot account for a surplus.

(Choice C) This runs the transport in the wrong direction. Carriers that recover material from the lumen subtract from the urinary amount, so even carriers working flat out at their ceiling can at best let the strained amount through untouched and can never push the urinary amount above it.

(Choice D) This confuses how concentrated the urine is with how much drug leaves per minute. Recovering water downstream packs the same quantity of drug into a smaller volume, raising its concentration while leaving the milligrams per minute unchanged, so it cannot create the surplus.

This is a Knowledge of Scientific Concepts and Principles question because the student must apply the standing relationship among straining, addition to the lumen and recovery from the lumen to decide which of the three steps can make urinary output exceed what was strained out.$q$,
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
  SELECT q.id, 'B', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'scale_unit_error', NULL FROM q;

-- Q20 . Osmotic diuresis from unreabsorbed solute . hard . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Osmotic diuresis from unreabsorbed solute$q$,
    $q$A sugar that the tubule cannot pull back out of the forming urine is infused into a vein in anesthetized rats over thirty minutes, and urine flow climbs to roughly three times its starting value. The investigators conclude that the sugar stays in the fluid running down the nephron and holds water there, forcing more urine out. A reviewer replies that the infusion itself delivered fluid to the animals and may also have shifted their circulating water-conserving signals, either of which could explain the rise. Which added group would best isolate the mechanism the investigators propose?$q$,
    $q$[{"label":"A","text":"A group given an equal volume of solute-free water intravenously over the same thirty minutes"},{"label":"B","text":"A group given the same sugar at three rising doses, with urine flow plotted against dose"},{"label":"C","text":"A group given an equal volume of an equally concentrated sugar that the proximal segment recovers completely"},{"label":"D","text":"A group deprived of drinking water beforehand, so that water-conserving signals are already maximal when the sugar is given"}]$q$::jsonb,
    'C',
    $q$This Organ Systems item tests control design for an experiment on the diuresis caused by a solute that stays in the tubular fluid. The answer is C because it holds the delivered fluid quantity and the particle concentration constant while changing only whether the solute can be taken back out of the lumen, which is the single variable the investigators' explanation rests on. If the sugar is fully recovered in the early tubule, the water it would have held is recovered with it, so urine flow should stay near its starting value despite an identical fluid load. Any rise seen in the treated group but absent in this control cannot be blamed on the delivered fluid, since both groups received the same amount, nor on a general osmotic shift in the circulation, since both loads carried the same particle concentration. What remains as the difference is exactly the claim under test, namely that a solute left behind in the tubular fluid drags water past the recovering segments and out into the urine. A control that changes two things at once cannot do this work, which is what disqualifies the alternatives.

(Choice A) This addresses the delivered fluid but nothing else. Solute-free water lowers the particle concentration of the circulation, which is itself a powerful stimulus for water loss, so this group changes two variables and cannot separate them.

(Choice B) A dose-response relationship strengthens the case that the sugar is responsible, but every dose is still delivered as a fluid load, so the reviewer's objection about delivered fluid and circulating signals applies with equal force at each dose. Showing that more of a confounded treatment produces more of an effect does not remove the confound.

(Choice D) Prior water deprivation loads a second large perturbation onto the design, altering the starting urine flow, the particle concentration of the circulation and the state of the tubule before the sugar even arrives. It also makes the baselines of the two groups incomparable, which is the opposite of what a control is for.

This is a Reasoning about the Design and Execution of Research question because the student must identify which additional group varies only whether the infused solute can be recovered while matching the volume and the particle load that the reviewer flagged as confounds.$q$,
    'hard',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    3,
    95
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', NULL FROM q;

COMMIT;

-- Verification: expect 20 questions and 60 distractor rows.
SELECT
  (SELECT COUNT(*) FROM public.questions WHERE topic = 'Homeostasis') AS questions,
  (SELECT COUNT(*) FROM public.question_distractor_metadata m
     JOIN public.questions x ON x.id = m.question_id
   WHERE x.topic = 'Homeostasis') AS distractor_rows;
