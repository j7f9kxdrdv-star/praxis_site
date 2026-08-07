-- Biology Chapter 7: The Cardiovascular System, standalone questions
-- BATCH 3 of 4 (25 questions): capillary exchange and blood.
--   Units: Starling forces and capillary fluid flux . lymphatic return and heat exchange
--          . blood composition and plasma . erythrocyte production and destruction
--
-- Verified against OpenStax Anatomy and Physiology 2e with line-level citations; see
-- biology_ch7_cardiovascular_questions.verification.md for the per-question audit trail.
--
-- !! RUN AFTER BATCHES 1 AND 2 !!
-- This file contains NO delete: batch 1 owns the chapter-scoped DELETE. Run
-- batches 1 and 2 first, then this file.
-- Re-running this file alone would duplicate its 25 questions, so if you need a clean slate,
-- re-run batch 1 (which clears the chapter) and then every later batch in order.

BEGIN;

-- B3 Q1 . Net Filtration Pressure at the Venular End . easy . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Net Filtration Pressure at the Venular End$q$,
    $q$Blood enters a systemic capillary at a hydrostatic pressure of \(35\ \text{mm Hg}\) and leaves it at \(18\ \text{mm Hg}\), while the plasma colloid osmotic pressure holds near \(25\ \text{mm Hg}\) along the whole vessel. Interstitial hydrostatic and colloid osmotic pressures are negligible. At the venular end of this capillary, fluid most likely$q$,
    $q$[{"label":"A","text":"moves into the capillary under a net pressure of \\(7\\ \\text{mm Hg}\\)."},{"label":"B","text":"moves into the capillary under a net pressure of \\(10\\ \\text{mm Hg}\\)."},{"label":"C","text":"moves out of the capillary under a net pressure of \\(7\\ \\text{mm Hg}\\)."},{"label":"D","text":"moves out of the capillary under a net pressure of \\(10\\ \\text{mm Hg}\\)."}]$q$::jsonb,
    'A',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because at the venular end the inward colloid osmotic pressure of \(25\ \text{mm Hg}\) exceeds the outward hydrostatic pressure of \(18\ \text{mm Hg}\), leaving a net inward pressure of \(7\ \text{mm Hg}\). Net filtration pressure is capillary hydrostatic pressure minus blood colloid osmotic pressure, so \(18 - 25 = -7\ \text{mm Hg}\), and a negative value signifies reabsorption rather than filtration. Hydrostatic pressure falls along the capillary as fluid is lost from it, whereas the plasma proteins cannot cross the wall and therefore hold the colloid osmotic pressure nearly constant from one end to the other. The two opposing pressures are equal near the midpoint, so the upstream stretch of the vessel loses fluid and the downstream stretch regains it.

(Choice A) At the venular end the values are \(18\ \text{mm Hg}\) pushing out and \(25\ \text{mm Hg}\) pulling in, so the net pressure of \(7\ \text{mm Hg}\) is directed inward and water is reabsorbed. This is the standard result for the downstream portion of a systemic capillary.

(Choice B) The inward direction is right, but \(10\ \text{mm Hg}\) is the magnitude that belongs to the arteriolar end, where \(35\ \text{mm Hg}\) opposes \(25\ \text{mm Hg}\). The magnitude at any point depends on the local hydrostatic pressure, which here is \(18\ \text{mm Hg}\). Pairing the correct direction with a value carried over from the other end still gives the wrong net pressure.

(Choice C) The magnitude of \(7\ \text{mm Hg}\) is arithmetically correct, but the direction assigned to it is inverted. Because the colloid osmotic pressure is the larger of the two values at this location, the resultant force points into the lumen. Outward movement here would require the local hydrostatic pressure to exceed \(25\ \text{mm Hg}\).

(Choice D) Both the magnitude and the direction belong to the arteriolar end, where a hydrostatic pressure of \(35\ \text{mm Hg}\) against a colloid osmotic pressure of \(25\ \text{mm Hg}\) drives fluid outward at \(10\ \text{mm Hg}\). Applying those values downstream ignores the fall in hydrostatic pressure along the vessel. The question specifies the venular end.

This is a Scientific Reasoning and Problem Solving question because you must combine two opposing pressure values into a signed net pressure and interpret its direction.$q$,
    'easy',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    55
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'partial_truth', $q$right_direction_wrong_magnitude$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', $q$sign_flip$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$wrong_location_value$q$ FROM q;

-- B3 Q2 . Colloid Versus Crystalloid Osmotic Effects . easy . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Colloid Versus Crystalloid Osmotic Effects$q$,
    $q$An investigator perfuses an isolated capillary bed with a protein-free salt solution whose total solute osmolarity and inflow pressure match those of plasma. Compared with perfusion using whole plasma, the surrounding tissue most likely$q$,
    $q$[{"label":"A","text":"gains less fluid, because the perfusate exerts a stronger inward osmotic pull."},{"label":"B","text":"gains no extra fluid, because the total osmolarity of the perfusate is matched."},{"label":"C","text":"gains more fluid, because the perfusate exerts almost no inward osmotic pull."},{"label":"D","text":"loses fluid to the capillary, because small solutes now drive reabsorption."}]$q$::jsonb,
    'C',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because the inward pull across a capillary wall is generated by suspended plasma proteins, so a protein-free perfusate leaves hydrostatic pressure essentially unopposed and fluid accumulates in the tissue. Small ions and glucose move across the capillary wall down their gradients, so their concentrations end up similar on both sides and they contribute little to net water movement. Plasma proteins, in contrast, are too large to cross the wall and remain suspended in the lumen as a colloid, which is why they alone set up an effective osmotic gradient. With the inward pull near zero, the net pressure stays outward along the entire length of the vessel instead of reversing near the midpoint, and interstitial volume rises continuously.

(Choice A) A protein-free solution has less osmotic holding power across the capillary wall, not more, because the particles it does contain equilibrate across that wall. Matching total osmolarity with small solutes does not create a sustained gradient. The predicted direction of change in tissue fluid is therefore backwards.

(Choice B) Total osmolarity is the wrong quantity to match, because the capillary wall is freely permeable to the small solutes that supply most of it. An osmotic gradient holds water in place only when the barrier restricts the solute in question. Equal osmolarity therefore does not predict equal fluid balance here.

(Choice C) Removing the plasma proteins removes essentially all of the effective inward pull, so hydrostatic pressure filters fluid outward along the whole capillary and the tissue swells. Isolated organs perfused with protein-free solutions become waterlogged for exactly this reason.

(Choice D) Small solutes cross the capillary wall down their concentration gradients and reach similar concentrations on both sides, so they cannot sustain reabsorption. Net movement of fluid from tissue back into the lumen requires an inward pull that outlasts equilibration. Without proteins, no such pull exists.

This is a Scientific Reasoning and Problem Solving question because you must predict how removing one class of solute from the perfusate alters net capillary fluid movement.$q$,
    'easy',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    55
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'reversed_relationship', $q$inverted_effect$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$wrong_governing_variable$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$crystalloid_as_oncotic$q$ FROM q;

-- B3 Q3 . Comparing Starling Forces Across Capillary Beds . medium . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Comparing Starling Forces Across Capillary Beds$q$,
    $q$The table lists capillary hydrostatic pressure (CHP), interstitial fluid hydrostatic pressure (IFHP), and blood colloid osmotic pressure (BCOP) measured in four capillary segments sampled from different tissues. Interstitial colloid osmotic pressure is negligible in all four segments. In which segment does fluid most likely move on balance from the interstitial space into the capillary lumen?

| Segment | CHP (mm Hg) | IFHP (mm Hg) | BCOP (mm Hg) |
|---|---|---|---|
| W | 32 | 2 | 25 |
| X | 24 | 6 | 26 |
| Y | 30 | 4 | 24 |
| Z | 21 | 1 | 19 |$q$,
    $q$[{"label":"A","text":"Segment W"},{"label":"B","text":"Segment X"},{"label":"C","text":"Segment Y"},{"label":"D","text":"Segment Z"}]$q$::jsonb,
    'B',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because segment X is the only one whose outward pressures fail to overcome the inward pull, giving a net pressure of \(-8\ \text{mm Hg}\) and therefore reabsorption. The net pressure equals the outward push, which is capillary hydrostatic pressure minus interstitial fluid hydrostatic pressure, minus the inward pull, which is blood colloid osmotic pressure once the negligible interstitial colloid osmotic pressure is dropped. Working through the table gives \(32 - 2 - 25 = +5\) for W, \(24 - 6 - 26 = -8\) for X, \(30 - 4 - 24 = +2\) for Y, and \(21 - 1 - 19 = +1\) for Z. Only a negative net pressure corresponds to movement from the interstitium into the lumen, so X is the single reabsorbing segment.

(Choice A) Segment W has the highest capillary hydrostatic pressure in the table at \(32\ \text{mm Hg}\) and only \(2\ \text{mm Hg}\) of opposing interstitial hydrostatic pressure. Its net pressure of \(+5\ \text{mm Hg}\) is the strongest outward value shown. Fluid therefore leaves this segment for the tissue.

(Choice B) Segment X combines the highest colloid osmotic pressure at \(26\ \text{mm Hg}\) with a modest hydrostatic pressure of \(24\ \text{mm Hg}\) and the highest interstitial hydrostatic pressure at \(6\ \text{mm Hg}\). The result, \(-8\ \text{mm Hg}\), is the only inward net pressure in the table.

(Choice C) Segment Y yields \(+2\ \text{mm Hg}\), a small but genuinely outward net pressure. Its raised interstitial hydrostatic pressure of \(4\ \text{mm Hg}\) reduces filtration without reversing it. Movement remains from lumen to interstitium.

(Choice D) Segment Z has the lowest capillary hydrostatic pressure in the table at \(21\ \text{mm Hg}\), which makes it superficially attractive. Its colloid osmotic pressure is also unusually low at \(19\ \text{mm Hg}\), however, so the balance still favors filtration at \(+1\ \text{mm Hg}\). A low hydrostatic value alone does not establish reabsorption.

This is a Data-based and Statistical Reasoning question because you must extract three values per row from a table and combine them into a signed net pressure for each segment before comparing them.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    4,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'adjacent_fact', $q$largest_magnitude_wrong_sign$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$reduced_but_not_reversed$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$single_column_heuristic$q$ FROM q;

-- B3 Q4 . Manipulating the Filtration Balance Experimentally . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Manipulating the Filtration Balance Experimentally$q$,
    $q$In an isolated perfused limb, the rate at which lymph drains from the tissue tracks the net rate of capillary filtration. Each of the following changes is imposed separately, with all other conditions held constant. Which of the changes are expected to increase the rate of lymph drainage?

I. Raising the pressure in the venule that drains the limb
II. Perfusing with a solution containing half the normal albumin concentration
III. Constricting the arteriole that supplies the limb$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"I and II only"},{"label":"C","text":"I and III only"},{"label":"D","text":"II and III only"}]$q$::jsonb,
    'B',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because raising downstream venous pressure and diluting the perfusate albumin both increase net filtration, whereas constricting the supply arteriole lowers the pressure delivered to the capillary and reduces filtration. Lymph forms from the fraction of filtered fluid that is not reabsorbed, so anything that widens the gap between filtration and reabsorption raises lymph flow. Item I acts by raising the outward push, since pressure in a congested venule is reflected backwards into the capillary. Item II acts on the opposing side of the balance, lowering the inward pull that albumin supplies. Item III acts in the opposite direction, because arterioles are the resistance vessels of the circuit and tightening one drops the pressure reaching the capillary beyond it.

(Choice A) Item I alone is incomplete because item II also raises net filtration. Halving the albumin concentration reduces the only force that pulls water back into the lumen, so filtration exceeds reabsorption by a wider margin and lymph flow rises. Selecting item I alone credits only the hydrostatic side of the balance.

(Choice B) Item I raises capillary hydrostatic pressure by back transmission from the congested venule, and item II lowers blood colloid osmotic pressure by removing half the albumin. Both widen the filtration surplus that the lymphatics must carry away, so both increase lymph drainage.

(Choice C) Item III is the one manipulation that lowers filtration. Arterioles are the site of greatest resistance, so constricting the supply arteriole produces a larger pressure drop before the blood reaches the capillary and leaves less hydrostatic pressure to drive fluid outward. Lymph drainage would fall rather than rise.

(Choice D) This pairing keeps the correct item II but again treats arteriolar constriction as though it raised capillary pressure. Constriction upstream of an exchange vessel shields that vessel from arterial pressure instead of exposing it. It also omits item I, which does raise filtration.

This is a Scientific Reasoning and Problem Solving question because you must predict the direction in which each separate manipulation shifts the balance of capillary pressures.$q$,
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
  SELECT q.id, 'A', 'partial_truth', $q$one_force_only$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', $q$upstream_downstream_inversion$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$wrong_pair$q$ FROM q;

-- B3 Q5 . Two Mechanisms of Interstitial Fluid Accumulation . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Two Mechanisms of Interstitial Fluid Accumulation$q$,
    $q$Two individuals have swollen ankles. In the first, incompetent valves in the leg veins allow blood to pool in the lower limb; in the second, dietary protein intake has been severely inadequate for many months. The pressure changes that most likely drive the swelling in these two individuals are$q$,
    $q$[{"label":"A","text":"lowered plasma colloid osmotic pressure in the first, and lowered plasma colloid osmotic pressure in the second."},{"label":"B","text":"lowered plasma colloid osmotic pressure in the first, and raised capillary hydrostatic pressure in the second."},{"label":"C","text":"raised capillary hydrostatic pressure in the first, and lowered plasma colloid osmotic pressure in the second."},{"label":"D","text":"raised capillary hydrostatic pressure in the first, and raised capillary hydrostatic pressure in the second."}]$q$::jsonb,
    'C',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because venous pooling raises the outward pressure inside the capillary, while chronic protein deprivation lowers the inward pull that plasma proteins supply. Blood trapped behind incompetent valves distends the vein and raises the pressure within it, and that pressure is reflected backwards through the venules into the capillary, so capillary hydrostatic pressure rises and filtration exceeds reabsorption. Inadequate dietary protein limits the raw material for hepatic albumin synthesis, and albumin is the dominant contributor to blood colloid osmotic pressure, so the inward pull that normally returns water at the venular end weakens. Both routes end in accumulated interstitial fluid, but they act on opposite sides of the pressure balance, which is why identifying the underlying cause matters clinically.

(Choice A) A fall in colloid osmotic pressure does explain the second individual, but it cannot explain the first. Plasma protein concentration is unaffected by where blood pools within a limb. Attributing both cases to protein loss ignores the hydrostatic route entirely.

(Choice B) This assigns each mechanism to the wrong individual. Pooling of blood behind failed valves does nothing to plasma protein concentration, and inadequate dietary protein does not raise the pressure inside capillaries. The two derangements are correctly named but swapped.

(Choice C) Venous pooling raises pressure that is reflected back into the capillary, increasing filtration in the first individual, while chronic protein deprivation reduces circulating albumin and therefore the colloid osmotic pressure in the second. The two individuals swell for opposite reasons within the same pressure balance.

(Choice D) Raised capillary hydrostatic pressure is correct for the first individual only. Severe protein deficiency does not raise arterial or venous pressure, and because albumin helps maintain blood volume and blood pressure, losing it tends to lower them. This option collapses two distinct mechanisms into one.

This is a Scientific Reasoning and Problem Solving question because you must trace two different clinical situations to the specific pressure term each one alters.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    75
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$one_mechanism_generalized$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', $q$swapped_assignment$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$one_mechanism_generalized$q$ FROM q;

-- B3 Q6 . Protein Content of Accumulated Interstitial Fluid . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Protein Content of Accumulated Interstitial Fluid$q$,
    $q$Fluid is aspirated from a swollen limb in each of two individuals whose blood albumin levels are normal. In the first, the lymphatic vessels serving the limb were removed during surgery; in the second, an obstructed vein has raised venous pressure in the limb. Compared with the second sample, the first most likely contains$q$,
    $q$[{"label":"A","text":"a higher protein concentration, because escaped plasma protein is not carried away."},{"label":"B","text":"a lower protein concentration, because added protein-poor filtrate dilutes it."},{"label":"C","text":"a higher protein concentration, because the capillary wall has become leakier to protein."},{"label":"D","text":"a lower protein concentration, because capillary hydrostatic pressure there is normal."}]$q$::jsonb,
    'A',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because the lymphatic vessels are the route that returns escaped protein from the tissue spaces to the blood, so removing them lets that protein build up in the interstitium. Interstitial fluid normally contains few proteins precisely because lymph continuously carries away the small amount that leaves the capillary, and destroying the lymphatic drainage of a region leaves protein-rich fluid accumulating in the tissue. In the second limb that route is intact and the derangement is a raised outward push acting across a wall that still holds back plasma proteins, so the extra fluid delivered to the tissue is a protein-poor filtrate that dilutes the interstitial protein already present. The two limbs therefore differ measurably in the protein content of their fluid even though both look similar from the outside.

(Choice A) With the lymphatic vessels gone, protein that has left the capillary has no exit and accumulates alongside the retained water, so the aspirate is comparatively protein-rich. This is the characteristic finding when lymphatic drainage is destroyed.

(Choice B) Dilution by protein-poor filtrate is genuinely correct physiology, but it describes the second limb rather than the first. Raised capillary hydrostatic pressure pushes fluid across a wall that still retains plasma proteins, so the added fluid is low in protein and lowers the interstitial concentration. Applying that reasoning to the limb without lymphatics reverses the comparison.

(Choice C) Increased permeability of the capillary wall would indeed raise interstitial protein, and damage to blood vessels is a recognized cause of tissue swelling. Nothing in this situation damages the capillary wall itself, however, since only the lymphatic vessels were taken out. The right outcome is reached by the wrong route.

(Choice D) Capillary hydrostatic pressure is in fact normal in the first limb, so this premise is accurate. A normal outward push, however, means less protein-poor filtrate is added, which raises rather than lowers the relative protein concentration. The prediction contradicts its own starting point.

This is a Scientific Reasoning and Problem Solving question because you must reason from two different derangements to a single measurable property of the accumulated fluid.$q$,
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
  SELECT q.id, 'B', 'partial_truth', $q$right_mechanism_wrong_case$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$correct_outcome_wrong_cause$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$true_premise_inverted_conclusion$q$ FROM q;

-- B3 Q7 . Position of the Filtration Reabsorption Crossover . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Position of the Filtration Reabsorption Crossover$q$,
    $q$Along one systemic capillary, hydrostatic pressure falls steadily from \(35\ \text{mm Hg}\) at the arteriolar end to \(18\ \text{mm Hg}\) at the venular end. In an individual with liver failure the plasma colloid osmotic pressure is \(20\ \text{mm Hg}\) rather than the usual \(25\ \text{mm Hg}\), and interstitial pressures remain negligible. Compared with normal, the point along this capillary at which net fluid movement equals zero most likely$q$,
    $q$[{"label":"A","text":"moves toward the arteriolar end, so a larger fraction of the capillary reabsorbs."},{"label":"B","text":"moves toward the arteriolar end, so a larger fraction of the capillary filters."},{"label":"C","text":"moves toward the venular end, so a larger fraction of the capillary reabsorbs."},{"label":"D","text":"moves toward the venular end, so a larger fraction of the capillary filters."}]$q$::jsonb,
    'D',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because a lower colloid osmotic pressure is matched by the falling hydrostatic pressure only further downstream, pushing the crossover toward the venule and leaving more of the vessel in net filtration. Net movement is zero where hydrostatic pressure equals colloid osmotic pressure. Normally that occurs where hydrostatic pressure has fallen to \(25\ \text{mm Hg}\), which on a linear profile is \((35 - 25)/(35 - 18)\), or roughly \(59\%\) of the way along. With liver failure it occurs where hydrostatic pressure reaches \(20\ \text{mm Hg}\), which is \((35 - 20)/(35 - 18)\), or roughly \(88\%\) of the way along. Everything upstream of the crossover filters and everything downstream reabsorbs, so the filtering stretch grows from about three fifths to about seven eighths of the capillary and the surplus fluid burdening the tissue increases.

(Choice A) Moving the crossover toward the arteriolar end would require hydrostatic pressure to fall below the colloid osmotic pressure sooner, which happens when colloid osmotic pressure rises rather than falls. The stated change is a fall from \(25\ \text{mm Hg}\) to \(20\ \text{mm Hg}\). Both the direction of the shift and the consequence are inverted here.

(Choice B) The consequence is right but the direction of the shift is backwards. A larger filtering fraction can only arise if the crossover retreats toward the venular end, since filtration is the upstream behavior of the vessel. Shifting the crossover toward the arteriole would shrink the filtering stretch instead.

(Choice C) The direction of the shift is right but the consequence is backwards. Filtration occupies the segment upstream of the crossover, where hydrostatic pressure still exceeds the colloid osmotic pull, and reabsorption occupies the segment downstream of it. Pushing the crossover toward the venule shortens the reabsorbing stretch rather than lengthening it.

(Choice D) The crossover sits where hydrostatic pressure has decayed to the colloid osmotic value, so lowering that value from \(25\ \text{mm Hg}\) to \(20\ \text{mm Hg}\) delays the crossing until about \(88\%\) of the way to the venule. The stretch upstream of the crossover, which is the filtering stretch, therefore lengthens.

This is a Scientific Reasoning and Problem Solving question because you must locate a crossover point on a stated pressure profile and translate its displacement into a change in capillary behavior.$q$,
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
  SELECT q.id, 'A', 'reversed_relationship', $q$double_inversion$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', $q$correct_outcome_wrong_shift$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$correct_shift_wrong_side$q$ FROM q;

-- B3 Q8 . Daily Lymph Return Volume . easy . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Daily Lymph Return Volume$q$,
    $q$Across all systemic capillary beds of a healthy adult, roughly \(24\ \text{L}\) of fluid is filtered into the interstitium each day while roughly \(20.4\ \text{L}\) is reabsorbed. If interstitial fluid volume stays constant across that day, what volume of fluid must the lymphatic vessels deliver to the subclavian veins?$q$,
    $q$[{"label":"A","text":"\\(3.6\\ \\text{L}\\)"},{"label":"B","text":"\\(4.4\\ \\text{L}\\)"},{"label":"C","text":"\\(20.4\\ \\text{L}\\)"},{"label":"D","text":"\\(44.4\\ \\text{L}\\)"}]$q$::jsonb,
    'A',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because the lymphatic vessels must carry away exactly the fluid that is filtered but not reabsorbed, which is \(24\ \text{L}\) minus \(20.4\ \text{L}\), or \(3.6\ \text{L}\) per day. Taken over the capillary bed as a whole, capillary hydrostatic pressure is higher than blood colloid osmotic pressure, so more fluid leaves by filtration at the arterial end than returns by reabsorption at the venous end. For interstitial volume to hold steady, that daily surplus must leave the tissue by some other route, and the only such route is the lymphatic system, whose vessels drain into the subclavian veins in the neck. Fluid balance in a tissue is therefore a three way accounting: filtered out, reabsorbed back, and the remainder returned as lymph.

(Choice A) This is the correct answer. The residual \(3.6\ \text{L}\) per day is precisely the load the lymphatic vessels return to the venous circulation, which is why lymph is often described as recycled plasma.

(Choice B) A value of \(4.4\ \text{L}\) comes from mishandling the decimal places when \(20.4\ \text{L}\) is subtracted from \(24\ \text{L}\). A lymphatic load that large would remove more fluid than the tissue receives each day, so interstitial volume would fall rather than stay constant.

(Choice C) A value of \(20.4\ \text{L}\) is the volume taken directly back into the blood capillaries at their venous ends, not the volume left over. That fluid never enters a lymphatic vessel at all, so counting it as lymph double counts the reabsorbed portion.

(Choice D) A value of \(44.4\ \text{L}\) is the sum of the filtered and reabsorbed volumes rather than their difference. Adding the two counts the same fluid twice and would imply a lymphatic load larger than the total volume that ever leaves the capillaries.

This is a Scientific Reasoning and Problem Solving question because you must apply conservation of fluid volume to the filtration and reabsorption rates supplied.$q$,
    'easy',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    60
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'scale_unit_error', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', NULL FROM q;

-- B3 Q9 . Lacteal Routing Of Absorbed Lipid . easy . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Lacteal Routing Of Absorbed Lipid$q$,
    $q$A rat whose intestinal lymphatic vessels have been ligated is fed a meal containing radiolabeled glucose and radiolabeled long chain triglyceride. Blood drawn from a systemic vein over the next several hours most likely shows which pattern of label appearance?$q$,
    $q$[{"label":"A","text":"Both the glucose label and the triglyceride label appear at close to normal levels."},{"label":"B","text":"The triglyceride label appears at close to normal levels, while the glucose label is greatly reduced."},{"label":"C","text":"The glucose label appears at close to normal levels, while the triglyceride label is greatly reduced."},{"label":"D","text":"Both the glucose label and the triglyceride label are greatly reduced."}]$q$::jsonb,
    'C',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because sugars enter the villus blood capillaries directly, whereas absorbed long chain lipid is repackaged into chylomicrons that can leave the villus only through its lacteal. Each villus contains a capillary bed of one arteriole and one venule plus a single lymphatic capillary, the lacteal. Fatty acids and monoacylglycerides taken up by the absorptive epithelial cell are reincorporated into triglycerides and surrounded with a protein coat to form chylomicrons, which are too big to pass the basement membranes of blood capillaries and instead enter the large pores of the lacteals. From there the lipid travels in lymph and empties through the thoracic duct into the subclavian vein, so ligating the intestinal lymphatics removes the only export route available to dietary triglyceride while leaving the monosaccharide route intact.

(Choice A) This outcome would require chylomicrons to enter the villus blood capillaries directly. Their size prevents that, so blocking the lacteal route must depress the appearance of the lipid label even though the sugar label is unaffected.

(Choice B) This reverses the two absorption routes. Monosaccharides do not depend on lymphatic drainage and lipid does, so the label depressed by lymphatic ligation is the triglyceride label rather than the glucose label.

(Choice C) This is the correct answer. Glucose reaches the systemic blood by way of the villus venule regardless of lymphatic patency, while triglyceride carried in chylomicrons is stranded when lacteal drainage is interrupted.

(Choice D) This treats the lymphatic route as the common pathway for all absorbed nutrients. The breakdown products of carbohydrate and protein enter the bloodstream directly from the villus capillaries, so the glucose label is not expected to fall.

This is a Scientific Reasoning and Problem Solving question because you must predict the outcome of an anatomical interruption from the absorption route each nutrient class uses.$q$,
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
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', NULL FROM q;

-- B3 Q10 . Starling Forces And Lymph Formation Rate . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Starling Forces And Lymph Formation Rate$q$,
    $q$A cannula in the lymphatic vessel draining a resting skeletal muscle allows the rate of lymph formation in that muscle to be measured directly. Consider the following interventions:

I. Partial obstruction of the venous outflow from the muscle
II. Rapid infusion of a large volume of protein free isotonic saline into the systemic circulation
III. Intravenous infusion of a small volume of concentrated albumin that raises plasma protein concentration

Which of the interventions would most likely increase the measured rate?$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"II only"},{"label":"C","text":"I and II only"},{"label":"D","text":"I and III only"}]$q$::jsonb,
    'C',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because both venous obstruction and plasma dilution widen the gap between filtration and reabsorption, whereas raising plasma protein concentration narrows it. Lymph is simply the filtered fluid that the blood capillaries fail to take back, so anything that increases net filtration increases lymph formation. Obstructing venous outflow raises pressure in the venules and reflects that pressure back into the capillaries, driving more fluid into the interstitial fluid. Diluting the plasma with protein free saline lowers blood colloid osmotic pressure, the force responsible for reabsorption, so less of the filtered fluid returns to the capillary. Concentrated albumin does the opposite by strengthening that reabsorptive force.

(Choice A) Item I is correctly credited, since raised capillary pressure promotes the flow of fluid out of the capillaries and into the interstitial fluid. This choice overlooks item II, however, because reabsorption depends on plasma protein concentration, which a large protein free infusion dilutes.

(Choice B) Item II is correctly credited, but this choice rejects item I. Obstructing venous outflow does not reduce filtration; blood accumulating upstream of the obstruction raises pressure in the venules and eventually the capillaries, which pushes additional fluid into the tissue.

(Choice C) This is the correct answer. Items I and II raise net filtration through opposite arms of the same balance, one by raising the outward hydrostatic force and one by weakening the inward osmotic force, and both surpluses must leave the tissue as lymph.

(Choice D) Item III raises blood colloid osmotic pressure, which is the force that draws fluid from the tissue back into the capillary. Strengthening it increases reabsorption and reduces the residual that the lymphatics must carry, so this intervention lowers rather than raises lymph formation.

This is a Scientific Reasoning and Problem Solving question because you must apply the balance of hydrostatic and colloid osmotic forces to predict the direction of change under three separate perturbations.$q$,
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
  UNION ALL SELECT q.id, 'B', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', NULL FROM q;

-- B3 Q11 . Cannulated Lymph Sampling As A Permeability Assay . medium . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Cannulated Lymph Sampling As A Permeability Assay$q$,
    $q$Investigators cannulate the lymphatic vessel draining a dog hindlimb and find that lymph flow triples within minutes of infusing a test compound into the femoral artery. They cannot yet tell whether the compound raised capillary hydrostatic pressure or increased the permeability of the capillary wall. Which additional measurement would best distinguish these two possibilities?$q$,
    $q$[{"label":"A","text":"The rate of lymph flow from the opposite, uninfused hindlimb"},{"label":"B","text":"The protein concentration of the collected lymph relative to plasma"},{"label":"C","text":"Mean arterial pressure in the femoral artery during the infusion"},{"label":"D","text":"The increase in weight of the infused limb during the infusion"}]$q$::jsonb,
    'B',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because the two candidate mechanisms move lymph flow in the same direction but move the composition of that lymph in opposite directions. Plasma proteins normally cannot cross the capillary wall, so the fluid filtered into the tissue, and therefore the lymph formed from it, is protein poor compared with plasma. If the compound acted purely by raising capillary hydrostatic pressure, it would force out more of that same protein poor filtrate, so lymph flow would rise while the lymph to plasma protein ratio fell. If instead the wall became more permeable, colloid would escape alongside the water and the lymph to plasma protein ratio would climb toward one. Flow alone cannot separate the two, but the ratio can.

(Choice A) Sampling the untreated limb is a reasonable control for systemic drift such as a change in blood pressure or temperature. Lymph flow there would be unchanged under either mechanism, however, so the comparison confirms that the effect is local without revealing how it was produced.

(Choice B) This is the correct answer. A lymph to plasma protein ratio that rises toward unity indicates escape of colloid across a leakier wall, whereas a falling ratio indicates dilution by additional protein poor filtrate driven out by pressure.

(Choice C) Capillary hydrostatic pressure is not fixed by arterial pressure. The arterioles are the site of the most precipitous pressure drop in the circulation, so dilating them delivers a larger share of arterial pressure to the capillary bed even when mean arterial pressure holds steady. An unchanged arterial reading would therefore rule out neither mechanism.

(Choice D) Weight gain in the limb tracks the accumulation of fluid in the tissue, which increases whenever net filtration exceeds the capacity of reabsorption and lymphatic drainage. Both proposed mechanisms raise net filtration, so this measurement reports the size of the effect rather than its cause.

This is a Reasoning about the Design and Execution of Research question because you must select the measurement that discriminates between two hypotheses that predict identical results for the variable already recorded.$q$,
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
  SELECT q.id, 'A', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', NULL FROM q;

-- B3 Q12 . Countercurrent Vascular Heat Exchange In A Limb . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Countercurrent Vascular Heat Exchange In A Limb$q$,
    $q$In a whale swimming in near freezing water, each artery running out to the flipper is surrounded by a bundle of veins carrying blood back from the flipper tip. Compared with an arrangement in which those same veins run just beneath the skin of the flipper, this arrangement most likely does which of the following?$q$,
    $q$[{"label":"A","text":"Delivers warmer blood to the flipper tip, so more heat is lost to the water."},{"label":"B","text":"Returns cooler blood to the core, so core temperature drops during a long dive."},{"label":"C","text":"Raises the resistance to flow through the flipper, so flipper perfusion falls."},{"label":"D","text":"Returns warmer blood to the core, so less heat is lost to the water."}]$q$::jsonb,
    'D',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because placing outgoing and returning vessels in direct contact lets heat pass from the arterial blood into the venous blood before that heat can reach the surface and be lost. This countercurrent arrangement transfers heat from arteries to veins, warming the blood returning to the heart and preventing cold venous blood from cooling the core organs. The consequence at the far end of the limb is that arterial blood arrives already cooled, so the temperature difference between the flipper tip and the surrounding water is small and surface heat loss is modest. Routing the return through superficial veins instead would carry warm blood along the skin, where that heat is given up to the water rather than recaptured. The same anatomy can be shut down when an animal needs to dump heat, which is why structures such as flukes and ears can serve as radiators.

(Choice A) This reverses the direction of heat flow within the vessel bundle. Heat moves down its gradient from the warmer arterial blood into the cooler returning venous blood, so the tip receives blood that is cooler, not warmer, than blood leaving the core.

(Choice B) Returning blood is warmed rather than cooled as it passes alongside the artery, which is precisely how the arrangement protects the heart and internal organs. An arrangement that delivered chilled blood to the core would defeat the purpose of the adaptation.

(Choice C) Wrapping veins around an artery does not appreciably change the radius of the artery, and resistance in a vessel is governed chiefly by radius. Reduced flipper perfusion in the cold is produced by vasoconstriction of the peripheral vessels, which is a separate mechanism from the anatomical pairing described.

(Choice D) This is the correct answer. Heat carried outward in arterial blood is handed off to the adjacent venous blood and returned to the core, so the limb functions as a heat conserving exchanger rather than a radiator.

This is a Scientific Reasoning and Problem Solving question because you must predict the thermal consequence of a described vascular geometry.$q$,
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
  SELECT q.id, 'A', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', NULL FROM q;

-- B3 Q13 . Interstitial Protein Retention After Lymphatic Loss . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Interstitial Protein Retention After Lymphatic Loss$q$,
    $q$Several weeks after the lymphatic vessels draining one arm are removed during surgery, that arm remains swollen, and fluid sampled from its tissue spaces contains far more albumin than fluid sampled from the opposite arm. Which consequence of the retained albumin best explains why fluid keeps accumulating in the arm?$q$,
    $q$[{"label":"A","text":"Blood colloid osmotic pressure falls as albumin leaves the plasma, so reabsorption drops in every capillary bed."},{"label":"B","text":"Interstitial colloid osmotic pressure rises, so less of the filtered fluid is drawn back at the venous end."},{"label":"C","text":"Interstitial fluid hydrostatic pressure rises as fluid collects, and that pressure opposes further filtration from the capillary."},{"label":"D","text":"The retained albumin draws water out of the cells of the arm, so the swelling reflects lost cell volume."}]$q$::jsonb,
    'B',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because reabsorption at the venous end depends on the colloid osmotic pressure of plasma exceeding that of the fluid outside the capillary, and trapped albumin erodes that difference. Normally the fluid in the tissue spaces contains few proteins, so its colloid osmotic pressure is very low and water is drawn from the tissue back into the capillary. A small quantity of albumin always escapes the capillaries, and the lymphatic capillaries, which are permeable to large molecules, normally clear it along with the surplus filtrate. Once those vessels are gone the escaped protein has no exit and its concentration in the tissue climbs, so the osmotic gradient that used to recover fluid shrinks. Net filtration then exceeds recovery by an ever larger margin, which is why protein rich fluid keeps building up rather than settling at a new steady volume.

(Choice A) A generalized fall in plasma protein concentration is a genuine cause of swelling, as seen when the liver cannot manufacture plasma proteins. It cannot explain this case, because the plasma albumin pool is large and continually replenished, and a systemic fall in colloid osmotic pressure would produce widespread swelling rather than swelling confined to one arm.

(Choice B) This is the correct answer. Rising colloid osmotic pressure outside the capillary narrows the gradient responsible for reabsorption, so a progressively larger share of the filtered fluid stays in the tissue.

(Choice C) This statement is accurate on its own terms, because hydrostatic pressure in the tissue does rise as fluid collects and does oppose further filtration. That force acts as a brake on swelling rather than a cause of it, so it predicts that the limb would settle at a new stable volume. It is also a consequence of the accumulated fluid rather than of the retained albumin the question asks about.

(Choice D) Albumin outside the capillary does not draw appreciable water out of cells, since cell volume is governed by small permeant solutes rather than by colloid. The accumulated fluid arrives from the capillaries by filtration, so the swollen limb reflects added extracellular volume rather than shrunken cells.

This is a Scientific Reasoning and Problem Solving question because you must trace how a change in the protein concentration outside the capillary alters the balance of forces governing reabsorption.$q$,
    'hard',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    125
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', NULL FROM q;

-- B3 Q14 . Plasma Fraction and Plasma Protein Content . easy . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Plasma Fraction and Plasma Protein Content$q$,
    $q$Whole blood from a healthy adult is centrifuged. The packed erythrocyte column occupies \(45\%\) of the tube, and protein accounts for about \(7\%\) of the volume of the clear layer above it. Which value is closest to the percentage of whole blood volume made up by the protein in that clear layer?$q$,
    $q$[{"label":"A","text":"About \\(0.4\\%\\)"},{"label":"B","text":"About \\(4\\%\\)"},{"label":"C","text":"About \\(7\\%\\)"},{"label":"D","text":"About \\(13\\%\\)"}]$q$::jsonb,
    'B',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because the \(7\%\) figure applies only to the liquid layer, which is a little more than half of whole blood, so the whole blood figure must be a little more than half of \(7\%\). The clear layer above the packed cells is plasma, and with an erythrocyte column of \(45\%\) the plasma fraction is \(100\% - 45\% = 55\%\). Protein occupies about \(7\%\) of plasma volume, so protein occupies \(0.55 \times 0.07 = 0.0385\), or roughly \(3.9\%\) of whole blood, which rounds to \(4\%\). Plasma is otherwise about \(92\%\) water, and all of its nonprotein solutes together contribute only about \(1\%\) of plasma volume. (Choice A) A value near \(0.4\%\) is roughly an order of magnitude too small and is closer to the whole blood share of plasma's nonprotein solutes than to its protein. Scaling \(7\%\) by \(0.55\) shifts the value only modestly, never by a factor of ten. (Choice B) Plasma makes up \(55\%\) of this sample, and \(7\%\) of that \(55\%\) is about \(3.9\%\). The answer must lie between half of \(7\%\) and \(7\%\) itself, and only this choice falls in that interval. (Choice C) A value of \(7\%\) applies the per plasma measurement directly to whole blood and ignores the \(45\%\) of the tube that erythrocytes occupy. Because that packed column holds no plasma protein, the whole blood figure must be smaller than the plasma figure. (Choice D) A value near \(13\%\) comes from dividing by \(0.55\) instead of multiplying by it. Dividing implies that whole blood is richer in plasma protein than plasma itself, which cannot hold when nearly half of whole blood volume is cells. This is a Scientific Reasoning and Problem Solving question because you must rescale a concentration expressed per unit of plasma into one expressed per unit of whole blood.$q$,
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
  SELECT q.id, 'A', 'scale_unit_error', $q$order of magnitude slip$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$skipped rescaling step$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$divided instead of multiplied$q$ FROM q;

-- B3 Q15 . Erythrocyte ATP Production . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Erythrocyte ATP Production$q$,
    $q$Washed human erythrocytes are suspended in a buffer containing \(5\ \text{mM}\) glucose. A dose of cyanide that abolishes ATP production in cultured hepatocytes leaves erythrocyte ATP unchanged, whereas an inhibitor of the glycolytic enzyme glyceraldehyde-3-phosphate dehydrogenase drives erythrocyte ATP nearly to zero within minutes. Which feature of mature erythrocytes best explains these results?$q$,
    $q$[{"label":"A","text":"An electron transport chain that cyanide cannot inhibit"},{"label":"B","text":"An absence of mitochondria and therefore of respiration"},{"label":"C","text":"An ATP reserve large enough to mask a loss of respiration"},{"label":"D","text":"A switch to glycolysis that occurs only when oxygen is scarce"}]$q$::jsonb,
    'B',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because a cell whose ATP is untouched by a respiratory poison but collapses when one cytoplasmic enzyme is blocked has no respiratory machinery to poison. Cyanide acts on the terminal oxidase of the electron transport chain, so a cell that ignores it is generating no ATP by oxidative phosphorylation. As an erythrocyte matures in red bone marrow it extrudes its nucleus and most of its other organelles, and because the mature cell contains no mitochondria, glycolysis is its only route to ATP. That single pathway explains why blocking one glycolytic enzyme empties the ATP pool within minutes, and it also means these cells consume none of the oxygen they carry. (Choice A) Human cells possess no cyanide insensitive terminal oxidase, so this choice invokes machinery these cells do not have. If any alternative respiratory chain were present, blocking a single glycolytic enzyme could not have driven ATP nearly to zero. (Choice B) Mature erythrocytes discard their organelles during maturation, leaving no mitochondria and therefore no oxidative phosphorylation for cyanide to act on. Every ATP molecule is made in the cytoplasm, so an inhibitor placed at glyceraldehyde-3-phosphate dehydrogenase halts the cell's entire supply. (Choice C) A stored pool of ATP could delay a decline but could not hold concentrations unchanged under continued exposure to cyanide. The collapse seen within minutes under the glycolytic inhibitor shows that ATP turns over far too fast for a reserve to hide a shutdown of respiration. (Choice D) This choice treats reliance on glycolysis as a conditional response to low oxygen, but a cell with no mitochondria has nothing to switch away from. Oxygen was not limiting in this buffer, yet the glycolytic inhibitor still removed the entire ATP supply. This is a Scientific Reasoning and Problem Solving question because you must infer the absence of an organelle from a cell's pattern of response to two different inhibitors.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$invents machinery the cell does not have$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$buffering pool that cannot last$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$conditional anaerobiosis$q$ FROM q;

-- B3 Q16 . Plasma Proteins and Capillary Fluid Balance . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Plasma Proteins and Capillary Fluid Balance$q$,
    $q$A patient with advanced liver disease has normal capillary hydrostatic pressures of \(35\ \text{mm Hg}\) at the arterial end and \(18\ \text{mm Hg}\) at the venous end. The patient's blood colloid osmotic pressure, however, measures \(14\ \text{mm Hg}\) rather than the usual \(25\ \text{mm Hg}\). Which outcome is most likely in this patient's systemic capillary beds?$q$,
    $q$[{"label":"A","text":"Filtration continues along the entire length of each capillary."},{"label":"B","text":"Reabsorption at the venous end proceeds more slowly than normal."},{"label":"C","text":"Reabsorption at the venous end proceeds more rapidly than normal."},{"label":"D","text":"Net fluid movement ceases because the two pressures now balance."}]$q$::jsonb,
    'A',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because with the opposing colloid pressure reduced to \(14\ \text{mm Hg}\), hydrostatic pressure exceeds it at every point along the vessel, so fluid never turns around. Net filtration pressure is capillary hydrostatic pressure minus blood colloid osmotic pressure, the interstitial pressures being small enough to neglect. Normally that yields \(35 - 25 = +10\ \text{mm Hg}\) at the arterial end, zero near the midpoint, and \(18 - 25 = -7\ \text{mm Hg}\) at the venous end, so fluid leaves early and is drawn back late. Here the venous end calculation becomes \(18 - 14 = +4\ \text{mm Hg}\), still positive, so fluid leaves over the whole length and accumulates in the interstitium as edema. Albumin, manufactured by the liver, is the single largest contributor to that colloid pressure, which is why a failing liver lowers it. (Choice A) Because the colloid pressure has fallen below even the venous end hydrostatic pressure, the difference stays positive from one end of the vessel to the other. Fluid therefore exits continuously with no reabsorption phase, and the lymphatic vessels cannot return all of it. (Choice B) This choice preserves the normal pattern and merely slows it, which requires the net pressure at the venous end to remain negative. With \(18\ \text{mm Hg}\) opposing only \(14\ \text{mm Hg}\), the sign of that difference has reversed, so no reabsorption occurs at all. (Choice C) More rapid reabsorption would require a larger colloid pressure pulling water inward, not a smaller one. This choice inverts the relationship between plasma protein concentration and the inward force. (Choice D) A standstill requires the two pressures to be equal, which normally occurs near the midpoint of a capillary where both are about \(25\ \text{mm Hg}\). In this patient a difference of \(4\ \text{mm Hg}\) remains even at the venous end, so exchange does not stop. This is a Scientific Reasoning and Problem Solving question because you must combine two opposing pressures at two locations and determine the sign of the result.$q$,
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
  SELECT q.id, 'B', 'partial_truth', $q$right pattern, wrong sign$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', $q$inverted protein effect$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$false equilibrium$q$ FROM q;

-- B3 Q17 . Platelet Origin From Megakaryocytes . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Platelet Origin From Megakaryocytes$q$,
    $q$A drug destroys every megakaryocyte in a man's bone marrow while sparing all other marrow precursors and every formed element already in his blood. Which change is most likely over the following \(2\) weeks?$q$,
    $q$[{"label":"A","text":"His platelet count falls, because circulating platelets cannot replace themselves."},{"label":"B","text":"His platelet count holds steady, because circulating platelets divide as they are lost."},{"label":"C","text":"His platelet count holds steady, because the spleen regenerates its stored platelets."},{"label":"D","text":"His platelet count falls, but only after several months of gradual decline."}]$q$::jsonb,
    'A',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because platelets are cytoplasmic fragments that cannot divide, so removing the cells that shed them cuts off the only source of new ones. A platelet is not a cell but a fragment of megakaryocyte cytoplasm surrounded by a bit of plasma membrane, released when megakaryocyte extensions reach through the walls of marrow capillaries. A single megakaryocyte sheds \(2{,}000\) to \(3{,}000\) such fragments over its lifespan, and the nucleus stays behind in the megakaryocyte remnant. Circulating platelets survive only about \(10\) days before macrophages remove them, so \(2\) weeks without megakaryocytes leaves the count clearly depressed. (Choice A) With no megakaryocytes left, no new fragments enter the blood, and the platelets already circulating carry no nucleus and so no chromosomes to replicate or partition. Clearance by macrophages continues at its normal rate, so the count falls steadily. (Choice B) Division of circulating platelets would require genetic material, which anucleate fragments do not carry. No formed element sustains its own numbers in the bloodstream this way; replacement always comes from marrow precursors. (Choice C) About one third of platelets are held in the spleen for later release, so the organ genuinely stores them, but storage is not production. Once megakaryocyte output stops, the splenic pool is drawn down along with the circulating pool. (Choice D) A delay of months would require a platelet lifespan of months, whereas platelets persist only about \(10\) days. A fall is therefore evident well inside the \(2\) week window described. This is a Knowledge of Scientific Concepts and Principles question because you must recall that platelets are anucleate megakaryocyte fragments with a lifespan of roughly \(10\) days.$q$,
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
  SELECT q.id, 'B', 'misconception', $q$fragment treated as a cell$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$real splenic role, wrong process$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'scale_unit_error', $q$lifespan off by an order of magnitude$q$ FROM q;

-- B3 Q18 . Erythrocyte Deformability and Capillary Transit . easy . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Erythrocyte Deformability and Capillary Transit$q$,
    $q$A woman inherits a defect in the erythrocyte membrane skeleton, so her circulating erythrocytes are rigid and cannot bend, although their diameter is unchanged at \(7\ \mu\text{m}\). Her aorta and large arteries remain unobstructed. Where in the circulation would these cells most likely first lodge?$q$,
    $q$[{"label":"A","text":"In capillaries, where the velocity of blood flow is lowest"},{"label":"B","text":"In arterioles, where resistance to blood flow is greatest"},{"label":"C","text":"In large veins, which hold most of the blood volume"},{"label":"D","text":"In the pulmonary trunk, where blood pressure is relatively low"}]$q$::jsonb,
    'A',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because capillaries are the only vessels whose lumen can be narrower than an erythrocyte, so passage there depends on the cell bending rather than on the vessel widening. A capillary lumen measures roughly \(5\) to \(10\ \mu\text{m}\) across, and the narrowest are just barely wide enough for an erythrocyte to squeeze through. A normal erythrocyte solves this by folding over itself and springing back on reaching a wider vessel, a maneuver permitted by flexible structural proteins such as spectrin. A cell locked into a rigid shape keeps its full \(7\ \mu\text{m}\) width and therefore wedges at the first point where the lumen falls below that value. (Choice A) Flow velocity is indeed lowest here, but the reason a rigid cell stops is dimensional: this is the only vessel class whose internal diameter approaches that of a single erythrocyte. The unobstructed aorta and large arteries have lumens hundreds of times wider. (Choice B) Arterioles do produce the most precipitous pressure drop and the greatest resistance in the systemic circuit, so the claim attached to this choice is accurate. Their lumens average about \(30\ \mu\text{m}\), however, roughly four times an erythrocyte's width, so a rigid cell passes through them. (Choice C) Systemic veins do hold about \(64\%\) of the blood volume, because their large lumens and thin walls make them highly distensible. Large lumens and distensibility work against obstruction rather than for it. (Choice D) The pulmonary trunk does carry blood at a lower pressure than the aorta, since the right ventricle faces less resistance. Pressure does not decide whether a cell of fixed width fits, and this is a conducting vessel far wider than any single cell. This is a Scientific Reasoning and Problem Solving question because you must match a change in cell mechanics to the one vessel dimension it constrains.$q$,
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
  SELECT q.id, 'B', 'adjacent_fact', $q$correct vessel fact, wrong question$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$large reservoir mistaken for a bottleneck$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$true pressure claim, irrelevant to fit$q$ FROM q;

-- B3 Q19 . Plasma Versus Serum . medium . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Plasma Versus Serum$q$,
    $q$Two tubes of blood are drawn from the same donor in the same minute. Tube 1 contains an anticoagulant and is centrifuged at once, while tube 2 has no additive and is left standing for \(30\) minutes before centrifugation. Which measurement made on the clear fluid above the cells in tube 2 would be markedly lower than the same measurement on tube 1?$q$,
    $q$[{"label":"A","text":"Sodium ion concentration"},{"label":"B","text":"Albumin concentration"},{"label":"C","text":"Fibrinogen concentration"},{"label":"D","text":"Glucose concentration"}]$q$::jsonb,
    'C',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because the untreated tube is allowed to coagulate, and the protein that is polymerized and trapped in the resulting mesh is removed from the fluid that is later assayed. Blood collected without an anticoagulant runs the coagulation cascade, which converts a soluble plasma protein into insoluble fibrin strands that become part of the packed mass at the bottom of the tube. The supernatant recovered from such a tube is serum, which is plasma from which the clotting factors have been removed. Fibrinogen normally accounts for about \(7\%\) of total plasma protein at \(0.2\) to \(0.45\ \text{g/dL}\), and essentially all of it is consumed during clot formation. (Choice A) Sodium is a small electrolyte that is neither a substrate nor a product of coagulation, so it stays dissolved in the fluid phase. Its concentration in the fluid from tube 2 matches that in tube 1. (Choice B) Albumin is the most abundant plasma protein at roughly \(54\%\) of total protein and \(3.5\) to \(5.0\ \text{g/dL}\), which makes it tempting whenever a protein is expected to change. It is not built into fibrin, however, so its concentration is essentially the same in both tubes. (Choice C) Coagulation in the additive free tube converts fibrinogen into fibrin, which is retained in the clot rather than in the supernatant. The assayed fluid is therefore serum, and its fibrinogen concentration is near zero against the anticoagulated sample from tube 1. (Choice D) Glucose is a nonprotein solute that is not removed by clot formation. Cells in an unseparated tube consume glucose slowly, but over \(30\) minutes that loss is a few percent at most and would not produce a marked difference. This is a Reasoning about the Design and Execution of Research question because you must predict how a specimen handling choice alters the analyte a measurement actually captures.$q$,
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
  SELECT q.id, 'A', 'adjacent_fact', $q$real plasma solute, unaffected$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$abundant protein assumed to be lost$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$slow preanalytic drift mistaken for removal$q$ FROM q;

-- B3 Q20 . Interpreting an Elevated Hematocrit . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Interpreting an Elevated Hematocrit$q$,
    $q$Two patients each have a hematocrit of \(54\%\). Patient A has been vomiting for \(3\) days and has lost \(4\ \text{kg}\) of body weight, while patient B has a stable weight and a marrow disorder that overproduces erythrocytes. Which of the following findings would be expected in patient A but NOT in patient B?

I. A total circulating erythrocyte volume that lies within the reference range
II. A plasma total protein concentration above the reference range
III. An immediate fall in hematocrit after infusion of \(2\ \text{L}\) of isotonic saline$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"I and II only"},{"label":"C","text":"II and III only"},{"label":"D","text":"I, II, and III"}]$q$::jsonb,
    'B',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because the two patients reach the same ratio by opposite routes, and only the findings that track a shrunken liquid compartment separate them. Hematocrit is packed erythrocyte volume divided by whole blood volume, so it rises either when the numerator grows or when the denominator shrinks. Patient A has lost fluid, so erythrocyte mass is unchanged while the plasma compartment has contracted, which also concentrates everything dissolved in that plasma. Patient B has generated extra erythrocytes with a normal plasma compartment, so erythrocyte mass is high while dissolved protein is normal. Statement III fails as a discriminator because expanding the plasma compartment dilutes erythrocytes in anyone, whatever raised the ratio in the first place. (Choice A) Statement I does discriminate, since only patient B carries an expanded erythrocyte mass. Stopping there overlooks statement II, which follows directly from the loss of plasma water and is equally specific to patient A. (Choice B) Statement I holds only for patient A, whose erythrocyte number never changed, whereas patient B has a genuinely enlarged erythrocyte mass. Statement II also holds only for patient A, because removing water from plasma concentrates the proteins dissolved in it, while patient B's plasma and its proteins are normal. Statement III is true of both patients, so it is excluded. (Choice C) Statement II is correctly recognized, but statement III describes a response shared by both patients, since adding isotonic fluid to the circulation dilutes erythrocytes whatever the cause of the high ratio. This option also discards statement I, one of the two genuine discriminators. (Choice D) This option treats the response to volume expansion as diagnostic, but a saline load lowers the erythrocyte fraction in patient B as well by enlarging the denominator of the ratio. A finding shared by both patients cannot distinguish between them. This is a Scientific Reasoning and Problem Solving question because you must decide which of several true findings actually discriminate between two mechanisms that produce an identical measured value.$q$,
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
  SELECT q.id, 'A', 'partial_truth', $q$incomplete correct set$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$shared response mistaken for a discriminator$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$all statements true of one patient assumed exclusive$q$ FROM q;

-- B3 Q21 . Anucleate Erythrocyte Lifespan . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Anucleate Erythrocyte Lifespan$q$,
    $q$Spectrin, a cytoskeletal protein that lets an erythrocyte fold as it squeezes through a capillary, becomes progressively oxidized as the cell ages. Over its remaining weeks in the bloodstream, this mature erythrocyte most likely:$q$,
    $q$[{"label":"A","text":"replaces the protein by translating it on ribosomes retained from the reticulocyte stage."},{"label":"B","text":"carries the altered protein until splenic macrophages engulf the whole cell."},{"label":"C","text":"refolds the protein using chaperones driven by ATP from its own mitochondria."},{"label":"D","text":"ruptures within a vessel so that the kidneys clear its freed globin chains."}]$q$::jsonb,
    'B',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because a mature erythrocyte has no ribosomes, no endoplasmic reticulum, and no nucleus, so a damaged structural protein cannot be replaced and the worn cell is eventually phagocytized whole. As an erythrocyte matures in the red bone marrow it extrudes its nucleus and most of its other organelles, and the ribosomal remnants that mark a reticulocyte are quickly shed during the first day or two in the circulation. From that point the cell cannot transcribe or translate anything, so oxidative damage to spectrin simply accumulates and the cell grows stiffer and less deformable. Erythrocytes live up to \(120\) days in the circulation, after which macrophages located primarily within the bone marrow, liver, and spleen remove the worn cell in its entirety and recycle its components.

(Choice A) Reticulocytes do retain networks of ribosomes, the feature that gives them their name, but only during roughly the first day or two after release. Those remnants are shed long before the cell is weeks old. A cell partway through its lifespan therefore has no translational machinery at all.

(Choice B) With no way to make a replacement, the cell carries the oxidized spectrin for the rest of its time in the vasculature, and the accumulating damage is what eventually marks it as worn out. Macrophages of the spleen, along with those of the liver and bone marrow, then engulf the whole cell. Its globin, iron, and the non-iron portion of heme are recycled or excreted rather than repaired in place.

(Choice C) Mature erythrocytes lack mitochondria and rely on anaerobic respiration, which is useful because it keeps them from consuming the oxygen they are transporting. No oxidative phosphorylation occurs in these cells. Chaperone-driven refolding would in any case not reverse a covalent oxidative modification.

(Choice D) Hemoglobin that escapes phagocytosis is broken down in the circulation, and the released alpha and beta chains are cleared by the kidneys, so this route is real. It is not the usual fate of an aged erythrocyte, which is removed intact by macrophages of the bone marrow, liver, and spleen. Intravascular rupture is the minor pathway rather than the expected one.

This is a Knowledge of Scientific Concepts and Principles question because you must recall which organelles a mature erythrocyte lacks and how worn cells are normally cleared.$q$,
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
  SELECT q.id, 'A', 'adjacent_fact', $q$true-of-an-earlier-stage$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$assumes-standard-cell-metabolism$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$minor-route-as-main-route$q$ FROM q;

-- B3 Q22 . Reticulocyte Count And Marrow Response . medium . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Reticulocyte Count And Marrow Response$q$,
    $q$Two adults each have a hematocrit of \(28\%\) against a reference value near \(45\%\), but reticulocytes make up \(0.2\%\) of circulating erythrocytes in patient 1 and \(8\%\) in patient 2. Which conclusion do these values best support?$q$,
    $q$[{"label":"A","text":"Patient 1's marrow is responding vigorously, so patient 1's deficit arises after cells enter the blood."},{"label":"B","text":"Patient 2's marrow is responding vigorously, so patient 2's deficit arises after cells enter the blood."},{"label":"C","text":"Patient 2's marrow is responding vigorously, so patient 2's deficit arises within the marrow itself."},{"label":"D","text":"Neither marrow is responding, so both deficits arise within the marrow itself."}]$q$::jsonb,
    'B',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because a reticulocyte fraction several times the normal \(1\%\) to \(2\%\) shows that patient 2's marrow is already delivering replacements at an accelerated rate, which places the cause of the low hematocrit downstream of the marrow. A reticulocyte is a newly released erythrocyte that still carries ribosomal remnants during its first day or two in the blood, so the proportion of circulating cells at that stage gives a rough estimate of the rate of erythrocyte production. Patient 1 has a large deficit with a fraction only a fifth of the lower end of the reference range, the pattern expected when production itself has failed. Patient 2 has the same deficit with output several times normal, so replacement is not the limiting step, and cells must be lost or destroyed once they are already in the circulation, as in hemorrhage or accelerated clearance by macrophages.

(Choice A) This assigns the elevated output to the wrong patient. A value of \(0.2\%\) sits well below the reference fraction, so patient 1's marrow has not raised production at all despite a severe deficit. Patient 1's problem therefore lies in production rather than downstream of it.

(Choice B) A fraction of \(8\%\) is several times the reference value, so patient 2's marrow is compensating rather than failing. The deficit must then arise after the cells are released, from bleeding or from accelerated destruction. Anemias are conventionally sorted into exactly these categories of blood loss, decreased production, and excessive destruction.

(Choice C) The first clause reads patient 2's value correctly, but the conclusion contradicts it. A marrow that has raised its output several fold is by definition not the site of the failure. A marrow lesion predicts a low reticulocyte fraction, which is what patient 1 shows instead.

(Choice D) This holds for patient 1 alone. Treating \(8\%\) as unremarkable ignores the reference fraction of \(1\%\) to \(2\%\), which is the only way to see that patient 2's marrow is hyperactive. The two patients arrive at the same hematocrit for opposite reasons.

This is a Data-based and Statistical Reasoning question because you must compare two laboratory values against reference ranges and infer where in the erythrocyte lifecycle each patient's defect lies.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    4,
    85
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'reversed_relationship', $q$patient-swap$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$right-premise-wrong-conclusion$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$reference-range-blindness$q$ FROM q;

-- B3 Q23 . Iron Recycling And Heme Breakdown . medium . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Iron Recycling And Heme Breakdown$q$,
    $q$In a patient with a chronic hemolytic disorder, splenic and hepatic macrophages phagocytize erythrocytes at roughly three times the usual rate. Dietary iron intake is unchanged, the hematocrit stays near normal, and liver and kidney function are normal. Which of the following are expected consequences?

I. Plasma bilirubin bound to albumin rises.
II. Whole-body iron stores fall as heme iron is excreted in the bile.
III. Transferrin delivers a larger quantity of iron to the red bone marrow.$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"I and III only"},{"label":"C","text":"II and III only"},{"label":"D","text":"I, II, and III"}]$q$::jsonb,
    'B',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because accelerated phagocytosis raises both the pigment waste stream and the recycled iron stream, while the iron itself is conserved rather than excreted. When a macrophage degrades an engulfed erythrocyte, hemoglobin is dismantled along three routes: globin is broken down into amino acids that can be sent back to the marrow, the iron of the heme portion is stored as ferritin or hemosiderin in the liver or spleen or carried on transferrin to the red bone marrow, and the non-iron portion of heme becomes biliverdin and then bilirubin. Bilirubin binds albumin and travels in the blood to the liver, and because hepatic uptake scales with the plasma concentration, tripling the rate of delivery raises the steady state plasma level, so item I holds. A hematocrit held near normal against tripled destruction means the marrow is producing at roughly triple the usual rate, so salvaged iron is being drawn toward erythrocyte precursors and item III holds as well. Item II fails because it is the pigment, not the metal, that leaves the body in the bile.

(Choice A) This accepts the bilirubin consequence but omits the iron traffic. Iron released by macrophage digestion does not sit still; it is either stored as ferritin and hemosiderin or mobilized on transferrin to the red bone marrow. With production tripled to hold the hematocrit steady, more of that iron moves toward the marrow, so item III is also expected.

(Choice B) Item I follows because the non-iron portion of heme becomes biliverdin and then bilirubin, which binds albumin in the plasma at a level set by the rate of delivery. Item III follows from the recycling route, in which transferrin carries salvaged iron to the red bone marrow for building new erythrocytes. Item II is the only false statement, so items I and III alone are expected.

(Choice C) This accepts the claim that heme iron is excreted in the bile. Bile carries bilirubin, the pigment derived from the non-iron portion of heme, while the iron re-enters the body pool in the liver, spleen, and bone marrow. Item I is also expected and should not have been dropped.

(Choice D) Items I and III are correct, but item II treats the metal and the pigment as sharing one excretory path. Only the non-iron remnant of heme becomes bilirubin and enters the bile. The iron is retained and recycled, so whole body stores are not drained by macrophage clearance.

This is a Knowledge of Scientific Concepts and Principles question because you must recall the separate fates of globin, heme iron, and the non-iron portion of heme after macrophages clear aged erythrocytes.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    1,
    95
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$incomplete-set$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$metal-and-pigment-conflation$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$accept-all$q$ FROM q;

-- B3 Q24 . Extramedullary Hemopoiesis . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Extramedullary Hemopoiesis$q$,
    $q$An adult with advanced marrow fibrosis has nearly all of the marrow space in the vertebrae, sternum, and pelvis replaced by scar tissue. Over the following months the liver and spleen enlarge substantially. Which explanation for that enlargement is best supported?$q$,
    $q$[{"label":"A","text":"Splenic and hepatic macrophages have increased their clearance of aged erythrocytes."},{"label":"B","text":"Iron freed from degraded heme is accumulating as ferritin in both organs."},{"label":"C","text":"Mature erythrocytes are being retained in both organs instead of circulating."},{"label":"D","text":"Both organs have resumed producing erythrocytes and other formed elements."}]$q$::jsonb,
    'D',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because the liver and spleen retain throughout adulthood the ability to generate the formed elements, and they take that role back up when the marrow can no longer fill it. Before birth, blood cell formation begins in the yolk sac and continues in the fetal liver, spleen, and lymphatic tissue before shifting to the red bone marrow, and after birth the process is largely restricted to the cranial and pelvic bones, the vertebrae, the sternum, and the proximal epiphyses of the femur and humerus. Because the liver and spleen never lose the capacity, destruction of the marrow, whether by a disease such as bone cancer or by the fibrosis described here, can initiate blood cell formation outside the medullary cavity. The expanding population of precursor cells within those organs is what accounts for their progressive enlargement over months.

(Choice A) Macrophages of the spleen and liver do clear worn erythrocytes, and states of accelerated clearance can enlarge the spleen. Nothing described here shortens erythrocyte survival, however. The lesion is a failure of production rather than a rise in destruction.

(Choice B) Both organs do store iron as ferritin and hemosiderin, so the premise is real. That store is filled by erythrocyte turnover, which marrow scarring does not increase, and a static iron pool would not drive months of progressive growth. Nothing in the scenario gives iron deposition a reason to expand.

(Choice C) Erythrocytes remain within the vascular network, and no reserve of mature erythrocytes is held back from the circulation in the way described. It is platelets, roughly one third of which migrate to the spleen for storage and later release. A withheld reserve would also be finite and would not explain growth continuing for months.

(Choice D) The liver and spleen carried out blood cell formation during fetal life and keep that ability throughout adulthood. Loss of the marrow removes the normal site of production, and formation restarts outside the medullary cavity. Growth of that reactivated blood-forming tissue enlarges both organs.

This is a Scientific Reasoning and Problem Solving question because you must connect the developmental history of blood cell formation sites to an organ finding in an adult whose marrow has failed.$q$,
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
  SELECT q.id, 'A', 'process_step_confusion', $q$destruction-for-production$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', $q$true-fact-wrong-driver$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$wrong-formed-element$q$ FROM q;

-- B3 Q25 . Erythrocyte Turnover And Survival Time . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Erythrocyte Turnover And Survival Time$q$,
    $q$In a healthy adult, circulating erythrocytes survive about \(120\) days, and each newly released cell is counted as a reticulocyte for roughly its first day in the blood, giving a reticulocyte fraction near \(1\%\). A patient's erythrocyte survival is shortened to \(40\) days, yet the total circulating erythrocyte count remains normal and steady. The reticulocyte fraction in this patient is most likely closest to:$q$,
    $q$[{"label":"A","text":"\\(0.3\\%\\)"},{"label":"B","text":"\\(1\\%\\)"},{"label":"C","text":"\\(3\\%\\)"},{"label":"D","text":"\\(5\\%\\)"}]$q$::jsonb,
    'C',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because a steady pool size forces daily production to equal daily destruction, so a survival time cut to one third must be matched by roughly three times the daily output. If the pool holds \(N\) cells and each survives \(L\) days, then at steady state the marrow must release \(N/L\) cells per day. Because a cell is counted as a reticulocyte for its first day only, the reticulocyte fraction equals \((N/L \times 1\ \text{day})/N = 1/L\), which reproduces the normal value of \(1/120\), or about \(0.8\%\), rounded to \(1\%\) in the stem. Substituting \(L = 40\ \text{days}\) gives \(1/40 = 2.5\%\), and among the choices \(3\%\) is nearest. The elevated fraction is the visible sign that marrow output has risen to defend a normal erythrocyte count against faster removal.

(Choice A) This is the normal value divided by three, which follows from treating shortened survival as evidence of reduced output. Steady state requires the opposite relationship, since a stable count with faster loss can only be maintained by faster replacement. A falling output would be accompanied by a falling erythrocyte count, which the stem excludes.

(Choice B) This assumes the reticulocyte fraction is a fixed property of blood rather than a ratio that tracks turnover. The fraction is daily output divided by pool size, so it must change whenever survival time changes. Holding it at the reference value ignores the stated three-fold shortening.

(Choice C) With the pool stable, daily replacement equals \(1/40\) of the pool, or \(2.5\%\) per day. Each of those cells spends its first day at the reticulocyte stage, so about \(2.5\%\) of circulating erythrocytes are reticulocytes at any moment. Of the values offered, \(3\%\) is the closest.

(Choice D) This value follows from allowing a two-day reticulocyte stage, giving \(2/40\). Reticulocytes can indeed carry organelle remnants for the first day or two in the circulation, but the stem stipulates a one-day interval. Doubling the transit time doubles the computed fraction without justification.

This is a Scientific Reasoning and Problem Solving question because you must build a steady-state turnover relationship from the given survival and transit times and apply it to a shortened lifespan.$q$,
    'hard',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    115
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'reversed_relationship', $q$inverted-proportionality$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$reference-range-anchor$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'scale_unit_error', $q$wrong-transit-time$q$ FROM q;

COMMIT;

-- Verification: after batches 1 to 3, expect 75 questions and 225 distractor rows.
SELECT
  (SELECT COUNT(*) FROM public.questions WHERE topic = 'The Cardiovascular System') AS questions,
  (SELECT COUNT(*) FROM public.question_distractor_metadata m
     JOIN public.questions x ON x.id = m.question_id
   WHERE x.topic = 'The Cardiovascular System') AS distractor_rows;
