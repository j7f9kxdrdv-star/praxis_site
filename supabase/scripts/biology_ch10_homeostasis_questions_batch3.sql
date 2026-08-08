-- Biology Chapter 10: Homeostasis, standalone questions
-- BATCH 3 of 3, FINAL (20 questions): integrated volume and osmolarity control, the skin as a
--   water and heat organ, thermoregulation as a control loop, and the named cutaneous receptors.
--
-- This file completes the chapter at 60 questions, and with it BIOLOGY IS COMPLETE:
-- all 12 chapters carry standalone question banks.
--
-- !! RUN AFTER BATCHES 1 AND 2 !!
-- No DELETE here: batch 1 owns the chapter-scoped DELETE. Re-running this file alone would
-- duplicate its 20 questions.

BEGIN;

-- Q1 . Volume defence overriding osmolarity defence . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Volume defence overriding osmolarity defence$q$,
    $q$A trauma patient loses 1.4 L of whole blood over twenty minutes and receives no fluid replacement. Plasma osmolarity measured immediately afterwards is unchanged from her baseline of 289 mOsm/L, while cardiac filling is clearly reduced. Over the next several hours, as she drinks freely, what happens to urine volume and to plasma concentration?$q$,
    $q$[{"label":"A","text":"Urine volume falls, and plasma concentration drifts below its set point."},{"label":"B","text":"Urine volume falls, and plasma concentration drifts above its set point."},{"label":"C","text":"Urine volume rises, and plasma concentration is held at its set point."},{"label":"D","text":"Urine volume and plasma concentration both stay at baseline."}]$q$::jsonb,
    'A',
    $q$This item belongs to Organ Systems and tests how the kidney arbitrates when the signal reporting how much fluid there is and the signal reporting how concentrated that fluid is point in different directions. The answer is A because the body treats filling of the vascular compartment as the more urgent variable, so it conserves water even though concentration needs no correction, and the conserved water dilutes what remains. Whole blood carries cells, protein and dissolved particles away in the same proportions they occupy in the circulation, so removing it lowers the amount of fluid without changing the number of particles per litre of what is left behind. Sensors reporting concentration therefore register nothing unusual, while sensors reporting vascular filling are strongly engaged. The response driven by the filling signal is avid salt and water retention in the distal nephron and collecting duct, which cuts urine output sharply and keeps ingested water inside the body. Because that water is held back with no concentration deficit to correct, it is pure surplus as far as the concentration variable is concerned, and plasma concentration slides slightly under its normal set point. This is the physiological reason a patient who has bled heavily and then drinks freely commonly shows a low serum sodium: the body accepted a concentration error in order to protect perfusion. (Choice B) This gets the renal volume response right but reverses the concentration consequence. Holding on to water without holding on to a matching load of particles must lower, not raise, the concentration of the fluid that water joins. (Choice C) This assumes the concentration set point outranks filling. If that were true, a bleeding patient would pour out fluid to defend a number that is already correct, deepening the very deficit that threatens tissue perfusion, which is why the hierarchy runs the other way. (Choice D) It is true that no osmotic correction is called for, but that is only half of the input the kidney receives. Filling is monitored independently, and a large fall in it drives a renal response on its own even when concentration is untouched. This is a Scientific Reasoning and Problem Solving question because it asks the student to predict the direction of two coupled variables in the one situation where their two control signals disagree.$q$,
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
  SELECT q.id, 'B', 'reversed_relationship', $q$right volume response, inverted concentration consequence$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$concentration control outranks volume control$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$no osmotic error, therefore no response$q$ FROM q;

-- Q2 . Tonicity of fluid lost predicts urine . medium . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Tonicity of fluid lost predicts urine$q$,
    $q$Three subjects each lose 2.0 L of fluid over one hour and drink nothing afterwards. All three began with a plasma osmolarity of 290 mOsm/L and have normal kidneys. The table gives the osmolarity of the fluid each subject lost.

| Subject | Source of loss | Osmolarity of fluid lost (mOsm/L) |
| --- | --- | --- |
| 1 | isotonic fluid drained from the peritoneal cavity | 290 |
| 2 | eccrine sweat during exercise in heat | 95 |
| 3 | urine passed during an osmotic diuresis | 600 |

Which subject is predicted to pass the smallest volume of the most concentrated urine in the hours that follow?$q$,
    $q$[{"label":"A","text":"Subject 1"},{"label":"B","text":"Subject 2"},{"label":"C","text":"Subject 3"},{"label":"D","text":"All three alike, since each lost the same 2.0 L"}]$q$::jsonb,
    'B',
    $q$This item belongs to Organ Systems and tests how the particle content of a lost fluid, and not merely its volume, shapes the urine the kidney then produces. The answer is B because sweat carries away far more water than particles, so the fluid left behind is concentrated up, and that concentration signal reinforces the volume signal instead of fighting it. Every one of the three has lost the same 2.0 L, so all three share a reduced circulating volume and all three will hold back salt and water to some degree. What separates them is what the loss did to the fluid that stayed. Subject 1 lost fluid at the same 290 mOsm/L as the starting value, so the particles per litre of what remains are unchanged and only the volume input is driving conservation. Subject 3 lost fluid at 600 mOsm/L, richer in particles than the body fluid it came from, which leaves the remainder thinner than normal; the concentration input therefore pushes toward getting rid of water and partly cancels the volume input. Subject 2 lost fluid at 95 mOsm/L, so almost all of what left was water; the remaining fluid is concentrated, and both inputs now demand maximum water recovery in the collecting duct. Aligned signals give the smallest, most concentrated urine. (Choice A) An isotonic loss engages only one of the two inputs. Conservation certainly occurs, but without a concentration deficit to add to it the urine will not be driven as far toward its concentrated extreme as in the sweating subject. (Choice C) This inverts the effect of losing a fluid richer in particles than the body fluid it came from. That loss dilutes the remainder, and a dilute remainder argues for excreting water, which works against maximal concentration. (Choice D) This treats volume as the only thing that matters. Equal volumes lost do not mean equal composition lost, and the composition determines whether the second input adds to the first or subtracts from it. This is a Data-based and Statistical Reasoning question because it requires comparing three measured osmolarity values against a common baseline to rank the urine profiles those losses produce.$q$,
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
  SELECT q.id, 'A', 'partial_truth', $q$volume signal alone, no reinforcing osmotic signal$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', $q$concentrated loss assumed to concentrate the remainder$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$equal volume lost implies equal renal response$q$ FROM q;

-- Q3 . Water load and collecting duct permeability . easy . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Water load and collecting duct permeability$q$,
    $q$A healthy adult drinks 1.5 L of plain water within fifteen minutes. Forty minutes later her plasma osmolarity has fallen to 279 mOsm/L, and the medullary interstitium is as salty as it was before the drink. What becomes of the surplus water?$q$,
    $q$[{"label":"A","text":"It is drawn back into the circulation from the final tubule segment, and urine output falls."},{"label":"B","text":"It leaves in urine that stays close to plasma in concentration, because the medullary gradient still pulls water out."},{"label":"C","text":"It is cleared mainly by a rise in filtration at the glomerulus, with tubular handling unchanged."},{"label":"D","text":"It runs through the final tubule segment without being reclaimed and leaves as a large volume of urine well below plasma in concentration."}]$q$::jsonb,
    'D',
    $q$This item belongs to Organ Systems and tests what the last segment of the nephron does when the body is carrying more water than it needs. The answer is D because the final water recovery step is the only one that can be switched on and off from minute to minute, and closing it leaves the water already inside the tubule with nowhere to go except out. About two thirds of filtered water is reclaimed early in the tubule regardless of what the body needs, and that fraction does not swing when someone drinks. What does change is the water permeability of the last stretch of tubule, the stretch that runs back down through the salty medulla. When that stretch is permeable, the concentrated surroundings pull water out of it and the urine ends up small in volume and concentrated. When permeability is withdrawn, the same fluid slides past the identical gradient sealed off from it, so the dilute fluid delivered onward from the ascending limb stays dilute and is voided in bulk. The gradient in this scenario is intact; what changed is access to it. (Choice A) This runs the control loop backwards. Reclaiming water from an adult who has just drunk a litre and a half would worsen the dilution already measured rather than correct it. (Choice B) The gradient is indeed still present, but a gradient can only move water across a membrane the water can cross. With the water route closed, an osmotic difference on the far side of an impermeable wall does nothing, so the urine is not held near plasma concentration. (Choice C) Filtration is deliberately stabilised against ordinary swings so that the tubule sees a steady load, and a drink of water does not push it upward. Excess water is disposed of by changing what the tubule gives back, not by changing what the glomerulus hands it. This is a Scientific Reasoning and Problem Solving question because it asks the student to trace a measured fall in plasma concentration through to the specific tubular step that is altered and the urine that results.$q$,
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
  SELECT q.id, 'A', 'reversed_relationship', $q$water recovery increased in a water-loaded subject$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$gradient present, permeability ignored$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$filtration rate as the disposal lever$q$ FROM q;

-- Q4 . Obligatory urine volume caps water conservation . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Obligatory urine volume caps water conservation$q$,
    $q$A castaway on a raft has no drinking water. Her tissues generate about 600 mOsm of waste solute each day, all of which must leave the body in urine, and her kidneys can concentrate urine to a maximum of 1200 mOsm/L. Water leaves through skin and breath at about 0.9 L per day and carries essentially no solute with it, while metabolism returns only about 0.25 L of water per day. Over the next two days, what happens to her urine volume and her plasma osmolarity?$q$,
    $q$[{"label":"A","text":"Urine output stops altogether, because water conservation at its ceiling closes the final tubule to all fluid loss."},{"label":"B","text":"Urine volume settles near 0.5 L each day, and plasma osmolarity holds at baseline, because concentrating the urine matches every route of water loss."},{"label":"C","text":"Urine volume settles near 0.5 L each day, but plasma osmolarity still climbs, because excreting the daily solute load obliges a water loss that conservation cannot abolish."},{"label":"D","text":"Urine volume settles near 0.5 L each day, and plasma osmolarity falls, because the water she holds back is not matched by any solute she holds back."}]$q$::jsonb,
    'C',
    $q$This item belongs to Organ Systems and tests the ceiling on what water conservation can achieve while the body still has waste to dispose of. The answer is C because the daily solute load can only leave dissolved in water, so dividing that load by the highest concentration the kidney can reach fixes a floor under urine volume that no amount of conservation can drop below. Take the floor first: 600 mOsm of solute divided by a maximum of 1200 mOsm per litre gives 0.5 L of urine per day, and that half litre must be passed even though the body can spare no water at all. Now total the books. Water out is the 0.5 L of obligatory urine plus 0.9 L through skin and breath, or 1.4 L, while water in is only the 0.25 L returned by metabolism, leaving a net shortfall of roughly 1.15 L each day. Total body solute, by contrast, does not change, because the 600 mOsm excreted is exactly what her tissues generated. A body losing water while holding its particle count steady must become more concentrated, so plasma osmolarity climbs day by day and the deficit compounds across the two days. (Choice A) Maximal conservation makes urine small and concentrated, not absent. Flow cannot stop, because the waste solute has no other exit and can travel only dissolved in water. (Choice B) This gets the obligatory volume right but stops one step short. Conservation slows the loss, it does not balance the books: 1.4 L leaving against 0.25 L returning is still a net water loss, and losing water alone raises concentration rather than holding it steady. (Choice D) This borrows reasoning that applies only when water is available to retain. Holding water back does dilute the body fluids when there is a supply to hold on to, but with no intake the conserved fraction is merely water that left more slowly, not water that was added. This is a Scientific Reasoning and Problem Solving question because it asks the student to convert a daily solute load and a maximum urine concentration into a floor on urine volume, then use that floor to decide which way plasma concentration must move.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    110
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$maximal conservation read as no urine at all$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$obligatory volume right, water balance ignored$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$conservation assumed to dilute when there is no water intake$q$ FROM q;

-- Q5 . Avascular epidermis fed by diffusion . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Avascular epidermis fed by diffusion$q$,
    $q$A scrape that removes only the outermost 0.1 mm of forearm skin weeps clear fluid but never bleeds, and cells recovered from the outer surface of the removed material contain no nuclei. A cut 1 mm deep at the same site bleeds at once. Which account best explains both the absence of bleeding and the state of those surface cells?$q$,
    $q$[{"label":"A","text":"The surface layer of the skin holds no vessels of its own; its cells depend on nutrients diffusing upward from the tissue below, so cells far from that boundary cannot stay alive, and blood escapes only when an injury crosses into the tissue that carries the supply."},{"label":"B","text":"Capillary loops run all the way to the skin surface but are too narrow for blood to escape from an injury that shallow."},{"label":"C","text":"Cells lying deepest die first because they are farthest from atmospheric oxygen, while surface cells stay alive by taking oxygen directly from the air."},{"label":"D","text":"Surface cells are dead because friction wears them down, and the scrape does not bleed because too little tissue was taken to open anything."}]$q$::jsonb,
    'A',
    $q$This item sits in Organ Systems and tests how the outermost skin layer is supplied and what that predicts about the depth of an injury. The answer is A because that layer holds no vessels at all, so its cells live on nutrients and oxygen that diffuse upward from the vascularised tissue beneath, and blood can only escape once a wound crosses into that tissue. Distance from the supply therefore sets viability: cells sitting closest to the boundary occupy the steepest part of the gradient and remain metabolically active, while cells displaced far outward are progressively cut off from oxygen and nutrients and die, which is exactly why the most superficial cells of the scraped material contain no nuclei. The clear weeping is interstitial fluid seeping up through the boundary rather than blood, and weeping without bleeding is the signature of an injury that stopped short of the supplying tissue. A cut deep enough to reach that tissue opens vessels immediately, so depth rather than area decides whether a skin injury bleeds.

(Choice B) No capillary loops enter the outermost layer. If vessels did reach the surface, the most superficial cells would be the best supplied rather than the least, and even the shallowest abrasion would bleed.

(Choice C) This inverts the direction of the gradient. Oxygen for these cells arrives from below in tissue fluid, not from the atmosphere, so the cells nearest the deeper tissue are the living ones and the outwardly displaced cells are the ones that die.

(Choice D) Mechanical wear does strip surface cells away, but it fails to explain why those cells are already dead before they are shed, and the amount of tissue removed is irrelevant to bleeding: a pinprick removes almost nothing yet bleeds freely because it crosses the boundary.

This is a Scientific Reasoning and Problem Solving question because it asks the student to infer a supply route and a viability gradient from two clinical observations about how deep an injury must go before blood appears.$q$,
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
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', NULL FROM q;

-- Q6 . Cornification as intracellular chemical transformation . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Cornification as intracellular chemical transformation$q$,
    $q$A dye that binds DNA is applied to one living cell deep in the skin's outer layer, and that same cell is followed for four weeks as it is displaced toward the surface. Over that time the label disappears and the cell becomes flatter, drier and mechanically tougher, yet it is never swapped for a different cell. What has happened inside this one cell?$q$,
    $q$[{"label":"A","text":"It divided repeatedly on its way outward, so the label was diluted among its descendants and the toughening reflects how tightly those descendants are packed."},{"label":"B","text":"It suffocated once it neared the surface, and the toughening is passive drying of a cytoplasm that is otherwise chemically unchanged."},{"label":"C","text":"It secreted its contents outward and was left as an empty shell, with the toughness supplied by the thickened plasma membrane alone."},{"label":"D","text":"Its nucleus and organelles were dismantled in place while cross linked fibrous protein and lipid granules accumulated, converting the interior into a tough, water resistant mass."}]$q$::jsonb,
    'D',
    $q$This item belongs to Organ Systems and tests cornification as a chemical and structural conversion occurring inside a single cell. The answer is D because the changes described happen within one tracked cell rather than by exchange of one cell for another: the nucleus and the rest of the organelles are actively degraded, while fibrous protein is synthesised, cross linked into bundles, and packed into the cytoplasm alongside lipid rich granules that are discharged between neighbouring cells. Loss of the DNA label is the direct readout of nuclear breakdown, and it is decisive here because the cell was never exchanged for another one. The mechanical toughening and the dryness come from that accumulated protein scaffold, and the lipid discharged around the cells supplies the sealant that resists water movement. The cell therefore ends its life as a flattened, protein filled, anucleate unit that is still doing useful mechanical and sealing work, which is why this end state is best treated as a programmed conversion rather than as simple death.

(Choice A) Division would not remove a nuclear label from a lineage, since each descendant would inherit both DNA and dye, and the stem explicitly follows one cell rather than a lineage.

(Choice B) Suffocation with passive drying would leave organelles recognisable and would not account for the large gain in structural protein, which requires synthesis while the cell is still alive.

(Choice C) The plasma membrane does thicken and lipid is released, but the interior is not emptied; it is filled with protein, and an empty shell would collapse rather than resist abrasion.

This is a Knowledge of Scientific Concepts and Principles question because it asks the student to name the internal chemical and structural changes that convert a living cell of the outer skin into a tough surface unit.$q$,
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
  SELECT q.id, 'A', 'process_step_confusion', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', NULL FROM q;

-- Q7 . Stratum corneum as the water barrier . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Stratum corneum as the water barrier$q$,
    $q$Adhesive tape is pressed onto a patch of forearm skin and pulled off repeatedly, lifting away successive sheets of the outermost cells. Water crossing the patch is then measured at roughly ten times the rate measured before the procedure, the patch does not bleed, and the cell layers beneath appear structurally normal under the microscope.

Which of the following are supported by these observations?

I. Most of the water that normally crosses intact skin passes through the material the tape lifted away.
II. The layers left behind, by themselves, restrain water movement poorly.
III. The rise in water crossing the patch is caused by injury to the vessels supplying it.$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"I and II only"},{"label":"C","text":"II and III only"},{"label":"D","text":"I, II and III"}]$q$::jsonb,
    'B',
    $q$This item falls under Organ Systems and tests which part of the skin actually limits water loss. The answer is B because a tenfold rise in water crossing the patch after only the most superficial cells are removed places the resistance in the removed material, and the fact that intact deeper layers cannot hold that water back shows those layers contribute little resistance on their own. Statement I follows from the size of the change relative to how little tissue was taken: if the deeper layers carried most of the resistance, stripping a thin superficial sheet could only produce a small increase. Statement II is the same measurement read from the other side, since the remaining layers are structurally normal yet now leak water at ten times the previous rate. Statement III fails on the observation that the patch does not bleed, which places the injury above the vascular tissue entirely; the escaping water is moving outward from tissue fluid across a surface that has lost its seal, not spilling from opened vessels. The practical consequence is that a person whose superficial layer is damaged loses water far faster than expected even though nothing deeper is wrong.

(Choice A) This stops short. Accepting statement I while rejecting statement II ignores that the same measurement is direct evidence about how weakly the remaining layers resist water, since those layers are intact and still leaking.

(Choice C) Including statement III contradicts the absence of bleeding, and dropping statement I leaves the tenfold rise without a source; taken together this choice misattributes a surface sealing failure to a vascular one.

(Choice D) Statements I and II are sound, but statement III cannot be rescued: a stripping injury that never reaches vascular tissue cannot damage vessels, and vessel damage would produce bleeding rather than a quiet rise in water crossing the surface.

This is a Scientific Reasoning and Problem Solving question because it asks the student to localise the skin's water barrier by weighing the size of a measured change against how little tissue was removed and against the absence of bleeding.$q$,
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
  SELECT q.id, 'A', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', NULL FROM q;

-- Q8 . Burn area scaling of fluid loss . medium . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Burn area scaling of fluid loss$q$,
    $q$Fluid lost through burned skin is collected from four patients whose burns have destroyed the surface seal over different fractions of the body surface, with no replacement given for the first several hours. Blood sodium in all four is 140 mmol/L at the time of collection.

| Fraction of body surface burned | Fluid lost through skin (mL/h) | Sodium in that fluid (mmol/L) |
|---|---|---|
| none | 25 | 15 |
| 10 percent | 130 | 15 |
| 25 percent | 300 | 15 |
| 40 percent | 470 | 15 |

What urine should the 40 percent patient produce after several unreplaced hours, and why?$q$,
    $q$[{"label":"A","text":"A large volume of dilute urine, because sodium leaving through the wound lowers the solute content of the blood."},{"label":"B","text":"A reduced volume of urine whose solute content matches the blood closely, because water and sodium leave the wound in the same ratio in which the blood holds them."},{"label":"C","text":"A small volume of urine considerably more concentrated than the blood it was filtered from, because the fluid leaving through the wound removes proportionally more water than salt."},{"label":"D","text":"Urine settling at about 15 mmol/L of sodium, because urine ends up matching the fluid that is being lost."}]$q$::jsonb,
    'C',
    $q$This item sits in Organ Systems and tests reading a scaling relationship out of a table and predicting the renal response to it. The answer is C because the table shows two things at once: the hourly loss climbs roughly in step with the burned fraction, reaching about nineteen times the intact rate at 40 percent, and every sample carries only 15 mmol/L of sodium against 140 mmol/L in the blood. Fluid that dilute is close to free water, so at 470 mL/h the patient sheds roughly 470 mL of water but only about 7 mmol of sodium each hour. Blood volume therefore falls while the sodium left behind is packed into a shrinking volume, and both changes push the tubule the same way: reclaim water while still excreting the day's obligatory solute load. The only way to clear that solute in very little water is to raise urine concentration well above that of blood, so the predicted output is scanty and strongly concentrated. Note that the ceiling on concentrating power sets a floor on urine volume, so output falls sharply but never to zero.

(Choice A) This runs the direction backwards. The fluid escaping is far more dilute than blood, so the loss raises rather than lowers the solute concentration of what remains, and a dilute diuresis would deepen the deficit.

(Choice B) Volume does fall, but the premise is wrong: 15 mmol/L against 140 mmol/L is not the ratio the blood holds, so the loss is disproportionately water and the urine must end up more concentrated than blood, not equal to it.

(Choice D) This reads a number straight off the table and applies it to the wrong compartment. Urine concentration is set by what the tubule reabsorbs and secretes, not by the composition of fluid escaping elsewhere, and 15 mmol/L would represent near maximal dilution when the situation demands the opposite.

This is a Data-based and Statistical Reasoning question because it asks the student to compare loss rates across burned fractions and to weigh the sodium content of the lost fluid against the blood value before predicting the direction of the renal response.$q$,
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
  SELECT q.id, 'A', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', NULL FROM q;

-- Q9 . Sweat tonicity and rehydration osmolarity swing . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Sweat tonicity and rehydration osmolarity swing$q$,
    $q$A runner completes a 3 hour race in warm conditions, loses 3.0 L of sweat, and afterwards drinks 3.0 L of pure water. Values measured on this runner before the race are shown.

| Fluid | Sodium (mmol/L) | Osmolarity (mOsm/L) |
| --- | --- | --- |
| Plasma | 140 | 290 |
| Sweat | 45 | 105 |

How does plasma osmolarity compare with its pre-race value at the end of the race, and again once the water has been taken in?$q$,
    $q$[{"label":"A","text":"Higher than 290 mOsm/L at the end of the race, then back to 290 mOsm/L"},{"label":"B","text":"Lower than 290 mOsm/L at the end of the race, then higher than 290 mOsm/L"},{"label":"C","text":"Higher than 290 mOsm/L at the end of the race, then lower than 290 mOsm/L"},{"label":"D","text":"Still 290 mOsm/L at the end of the race, then lower than 290 mOsm/L"}]$q$::jsonb,
    'C',
    $q$This item sits in Organ Systems and tests how the tonicity of sweat sets the direction of the plasma osmolarity change at two different stages of a race. The answer is C because sweat carries proportionally more water than solute out of the body, so the fluid left behind becomes concentrated, and refilling that volume with solute free water afterwards dilutes it below where it started. Compare the two rows: every liter of plasma holds 290 mOsm of solute, while every liter of sweat carries only about 105 mOsm. Losing 3.0 L of sweat therefore removes 3.0 L of water but only about 315 mOsm of solute, far less than the roughly 870 mOsm that 3.0 L of plasma would have contained. The solute remaining in the body is now dissolved in a smaller total volume, so at the end of the race plasma osmolarity sits above 290 mOsm/L. Drinking 3.0 L of pure water then returns total body water to its starting point while returning none of the missing 315 mOsm, so the same body water now holds less solute than it did before the race and osmolarity settles below 290 mOsm/L. This two stage swing is the physiology behind the dilutional fall in plasma sodium seen in endurance athletes who cover large sweat losses with plain water.

(Choice A) reads the first stage correctly but assumes that restoring volume also restores solute. Plain water supplies no sodium and no other osmotically active particles, so the endpoint cannot be the original value.

(Choice B) reverses both stages. It would require sweat to be more concentrated than plasma, which the table contradicts, and it would require pure water to raise osmolarity rather than lower it.

(Choice D) reflects the common assumption that sweat is essentially plasma leaving the body. If that were so, osmolarity would indeed hold steady while sweating, but at 105 mOsm/L the sweat is roughly a third as concentrated as the plasma it derives from, so the loss cannot be neutral.

This is a Data-based and Statistical Reasoning question because it asks the student to compare the tabulated solute concentrations of sweat and plasma and use that comparison to predict the direction of the osmolarity change at two successive points in the scenario.$q$,
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
  SELECT q.id, 'A', 'partial_truth', $q$right first stage, wrong endpoint$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', $q$both directions inverted$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$sweat treated as an isotonic plasma filtrate$q$ FROM q;

-- Q10 . Cumulative sweat sodium loss and the limits of tubular conservation . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Cumulative sweat sodium loss and the limits of tubular conservation$q$,
    $q$Over an eight hour shift in a foundry a worker loses about 8 L of sweat containing 50 mmol/L of sodium. He replaces the volume exactly, drinking 8 L of a commercial drink containing 20 mmol/L of sodium. Blood drawn at the end of the shift shows a high circulating aldosterone level acting on the collecting duct, and glomerular filtration rate is unchanged from baseline. What is the state of this worker's total body sodium and plasma sodium concentration, and what can the tubule do about it?$q$,
    $q$[{"label":"A","text":"Total body sodium has fallen by roughly 240 mmol and plasma sodium concentration is below normal; the tubule can strip the urine of sodium almost completely, but that only halts further loss"},{"label":"B","text":"Total body sodium has fallen by roughly 240 mmol but plasma sodium concentration is above normal, because each liter of sweat removes proportionally more salt than it removes water"},{"label":"C","text":"Plasma sodium concentration is below normal, but raising tubular reabsorption on its own will return it to normal, because the sodium filtered each day far exceeds the amount lost in sweat"},{"label":"D","text":"Total body sodium is essentially unchanged, because a secretion of only 50 mmol/L is far too dilute to represent a meaningful salt loss across a single shift"}]$q$::jsonb,
    'A',
    $q$This item sits in Organ Systems and tests why a dilute secretion can still create a substantial salt deficit, and what tubular handling of that salt can and cannot correct. The answer is A because 8 L at 50 mmol/L carries away about 400 mmol of sodium while the replacement drink returns only 8 L at 20 mmol/L, or about 160 mmol, leaving a net deficit near 240 mmol with total body water back at its starting point. Concentration and amount are separate quantities: a fluid far more dilute than plasma can still, secreted for hours on end, remove a large absolute quantity. With sodium reduced and water restored, plasma sodium concentration must sit below its normal value. The high aldosterone level reaching the collecting duct raises sodium movement out of the tubular fluid, and the urine can be stripped of sodium almost completely, which is the appropriate renal response. That response only halts further loss, however, because the tubule reclaims sodium that has already been filtered from the blood and can do nothing about sodium carried off through the skin. Normal concentration returns when sodium is taken in, or when the surplus water is passed in urine.

(Choice B) has the direction of the concentration change backwards. Sweat is hypotonic to plasma, so per liter it removes proportionally more water than salt, and the fall in concentration here comes from replacing that volume with a fluid poorer in sodium than what was lost.

(Choice C) is right about the direction of the change but wrong about the remedy. The filtered load each day is indeed enormous, yet reabsorption only returns sodium that was already inside the body; no degree of reabsorption can add back sodium that has left through the skin.

(Choice D) mistakes a modest concentration for a modest quantity. Fifty millimoles per liter is low next to plasma, but multiplied across eight liters it becomes a loss of several hundred millimoles, more than enough to call up maximal renal conservation.

This is a Scientific Reasoning and Problem Solving question because it asks the student to convert two per liter sodium concentrations into a net cumulative deficit and then decide which part of that deficit tubular reabsorption is actually able to reverse.$q$,
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
  SELECT q.id, 'B', 'reversed_relationship', $q$tonicity of sweat inverted$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$reabsorption mistaken for net acquisition$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'scale_unit_error', $q$per liter concentration judged as total quantity$q$ FROM q;

-- Q11 . Distinguishing the two sweat gland populations by their deficits . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Distinguishing the two sweat gland populations by their deficits$q$,
    $q$Two people attend a dermatology clinic. Patient 1 was born without functional sweat glands over the general body surface. Patient 2 has a separate population of glands that has stopped working; those glands are confined to the axillae and groin, became active only at puberty, and empty into hair follicles. What consequences are expected for each?$q$,
    $q$[{"label":"A","text":"Both overheat readily in warm weather, because each gland population contributes to thermoregulatory secretion"},{"label":"B","text":"Patient 1 produces little body odor but tolerates heat normally, while Patient 2 overheats readily in warm weather"},{"label":"C","text":"Patient 1 overheats readily in warm weather and also produces little body odor, while Patient 2 is essentially unaffected"},{"label":"D","text":"Patient 1 overheats readily in warm weather, while Patient 2 produces little body odor but tolerates heat normally"}]$q$::jsonb,
    'D',
    $q$This item sits in Organ Systems and tests the division of labor between the two populations of sweat glands and what each one's absence would cost. The answer is D because the glands spread across the whole body surface produce the thin, watery secretion whose vaporization cools the skin, while the glands restricted to the axillae and groin release a thicker, organic rich fluid into hair follicles, where resident skin bacteria break it down and generate odor. Removing the first population takes away the principal route for shedding heat in warm conditions, so Patient 1 overheats. Removing the second takes away the material the bacteria act on, so Patient 2 loses body odor; because those glands occupy only small regions of the body and secrete a fluid poorly suited to vaporizing, their loss costs nothing in heat tolerance. The pubertal timing given in the stem fits the same split, since the follicle associated glands stay quiet through childhood while the body wide glands work from infancy onward.

(Choice A) assumes both populations contribute to cooling. The follicle associated glands cover a small fraction of the total surface and secrete a viscous fluid, so their contribution to heat loss is negligible even when they are working normally.

(Choice B) swaps the two consequences, assigning the odor defect to the person lacking the body wide glands and the heat intolerance to the person whose regional glands have failed.

(Choice C) predicts overheating in Patient 1 correctly but wrongly attaches the loss of odor to the same person. The secretion of the body wide glands is largely water with a little salt and is not the substrate bacteria convert into odor.

This is a Knowledge of Scientific Concepts and Principles question because it asks the student to hold the defining properties of each sweat gland population in mind and match each population to the specific deficit its absence would produce.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$both gland types treated as cooling glands$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', $q$consequences assigned to the wrong patient$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$correct heat prediction, wrong odor source$q$ FROM q;

-- Q12 . Direction of heat exchange when the surroundings are hotter than the skin . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Direction of heat exchange when the surroundings are hotter than the skin$q$,
    $q$A foundry worker stands in a room where the air and every nearby surface sit at 45 degrees C, while his skin is at 35 degrees C. He is sweating heavily, and sweat is visibly running off his forearms and dripping to the floor. How does body heat change along each of the available routes of exchange?$q$,
    $q$[{"label":"A","text":"Sweat that runs off the skin removes heat just as well as sweat that leaves as vapor, so the rate of sweat production alone sets how much cooling he gets"},{"label":"B","text":"Every route that depends on a difference in warmth now delivers heat into the body, so the only net loss is the energy taken up when water changes to vapor at the skin"},{"label":"C","text":"Net heat loss continues along the difference in warmth, though more slowly than usual, so the change of water to vapor merely supplements it"},{"label":"D","text":"The energy removed as water changes to vapor is too small to matter in air this hot, so core temperature must climb whatever the sweating rate"}]$q$::jsonb,
    'B',
    $q$This item sits in Organ Systems and tests the direction of heat flow along each exchange route once the surroundings are hotter than the body surface. The answer is B because every route other than vaporization moves heat down a gradient in warmth, and here that gradient runs the wrong way: air and surfaces at 45 degrees C are hotter than skin at 35 degrees C, so direct contact, air movement over the skin and infrared exchange all deposit heat into the body instead of drawing it out. Vaporization is the exception because it does not require the environment to be cooler at all. It consumes a large quantity of energy from the skin simply to lift water molecules out of the liquid state, and that energy leaves with the vapor regardless of how hot the surrounding air happens to be. This is why heavy sweating still works in a hot room, and why the thing that defeats it is high humidity, which stops water leaving the surface, rather than heat by itself.

(Choice A) treats sweat production as if it were the same thing as sweat evaporation. The large energy cost is paid only at the moment molecules leave the liquid state, so sweat that beads up and falls to the floor carries away only the small amount of heat stored in the warm liquid itself and is essentially wasted.

(Choice C) keeps the usual direction and merely slows it. The gradient has not simply shrunk, it has changed sign, so these routes represent a heat gain rather than a reduced heat loss, and vaporization is not a supplement but the whole of the net loss.

(Choice D) underestimates the energy involved in the change of state. Converting water to vapor absorbs a large quantity of heat per gram, which is why a heavily sweating adult can shed heat at several times the resting rate as long as the vapor can escape.

This is a Scientific Reasoning and Problem Solving question because it asks the student to assign a sign to the heat flow along each route using the two temperatures given and then identify the single route whose direction does not depend on that comparison.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$sweat produced equated with sweat evaporated$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$gradient shrunk rather than reversed$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'scale_unit_error', $q$energy of the change of state underestimated$q$ FROM q;

-- Q13 . Hypodermal fat depth and heat loss rate . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Hypodermal fat depth and heat loss rate$q$,
    $q$Two adults with the same core temperature and the same cutaneous blood flow sit quietly in a 10 degree C room wearing identical clothing. One of them has a hypodermal fat layer of roughly twice the thickness of the other's. After twenty minutes the leaner adult's core reading has fallen further. Which of the following best explains the difference?$q$,
    $q$[{"label":"A","text":"Stored fat generates warmth on its own, so the adult carrying more of it adds heat internally at a higher rate."},{"label":"B","text":"Heat travelling outward from the interior must cross the fatty layer, which conducts poorly, so a deeper layer slows escape at the same driving gradient."},{"label":"C","text":"The heavier adult clamps down harder on the vessels of the skin, so less warmth is delivered to the outside of the body."},{"label":"D","text":"Fat beneath the skin raises the ratio of surface to volume, so the heavier adult exchanges heat with the room more readily."}]$q$::jsonb,
    'B',
    $q$This item sits in Organ Systems and tests the hypodermis as a physical barrier standing between the warm interior of the body and the environment. The answer is B because heat produced deep in the body can only leave through the shell that surrounds it, and adipose tissue passes heat poorly, so a deeper shell lowers the rate of escape even when everything driving that escape is identical. The scenario deliberately matches the two adults on the variables that set how much warmth arrives at the outside of the body: identical starting core readings, identical blood flow to the skin, identical clothing and identical room. What differs is only the depth of the fatty shell that heat must traverse on its way out. Body composition therefore acts as a variable in its own right, independent of how hard the circulatory or sweating effectors are working, and two people who look thermally identical on paper can drift apart in core reading at very different rates. (Choice A) White adipose tissue in the hypodermis is a storage depot and a cushion, not a furnace running at a higher rate than other tissue, so attributing the difference to extra warmth production inverts what the depot actually does. (Choice C) Differential constriction of skin vessels would indeed change how much heat reaches the outside, but the scenario holds cutaneous blood flow equal in the two adults, so this proposes a mechanism that has been experimentally excluded here. (Choice D) A larger, fatter body has a smaller, not a larger, ratio of surface to volume, and in any case a higher ratio would speed exchange in the person who is actually cooling more slowly, which reverses the observed direction. This is a Scientific Reasoning and Problem Solving question because the student must hold every driver of heat escape constant and reason that the remaining difference, the depth of the fatty shell, is what sets the rate at which the interior cools.$q$,
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
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', NULL FROM q;

-- Q14 . Piloerection and trapped still air . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Piloerection and trapped still air$q$,
    $q$In a cold room the small muscles anchored to each hair follicle contract, and the visible result in a person is goose bumps. The identical reflex in a heavily coated mammal slows its loss of body warmth appreciably, whereas in the person the effect on warmth retention is close to nil. Which of the following best explains this difference?$q$,
    $q$[{"label":"A","text":"Standing the hairs upright holds a motionless pocket of air against the skin, and the depth of that pocket depends on how long and how dense the coat is."},{"label":"B","text":"The contracting follicle muscles release warmth directly, and a coated animal has far more of these muscles per unit of body surface."},{"label":"C","text":"Erect hairs enlarge the area available for exchange with the surroundings, which matters more in an animal covered in fur."},{"label":"D","text":"The reflex exists to make a threatened animal appear larger, so any effect on warmth retention is incidental in both species."}]$q$::jsonb,
    'A',
    $q$This item sits in Organ Systems and tests what the arrector pili reflex actually accomplishes physically, and why the same reflex pays off in one species and not another. The answer is A because raising the hairs does not itself add warmth: it creates a still layer of air next to the skin, and air that is not moving is a poor carrier of warmth away from the body. The size of that motionless pocket scales with the length and density of the hair coat, which is why a dog or a cat gains real protection while a person, whose coat is sparse, gains almost none. The reflex in humans is a retained response whose insulating payoff has largely been lost, which is exactly why goose bumps are visible and useless at the same time. Nothing about the muscular contraction itself is different between the two species; only the structure it moves has changed. (Choice B) The tiny follicle muscles are far too small a mass for their contraction to be a meaningful source of warmth, and the difference between species lies in the hair coat rather than in muscle number. (Choice C) Raising the hairs does slightly change the outline of the surface, but the functional consequence is to hold air still rather than to enlarge exchange, and enlarging exchange would speed loss of warmth rather than slow it. (Choice D) Making the animal look bigger is a genuine consequence in a frightened cat, yet it is a separate use of the same reflex and cannot explain why the coated animal actually retains warmth better in the cold. This is a Knowledge of Scientific Concepts and Principles question because the student must recall what elevating the hair shafts does to the layer of air at the skin and apply that to a species whose coat can no longer hold such a layer.$q$,
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

-- Q15 . Fever as an elevated set point . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Fever as an elevated set point$q$,
    $q$Over one hour after the onset of an infection, a patient's core reading climbs from 37.0 to 38.6 degrees C. Throughout that climb the skin is pale and cool to the touch, the patient piles on blankets, and the large muscles contract in rapid bursts. Which of the following best explains this presentation?$q$,
    $q$[{"label":"A","text":"Control of body warmth has broken down, and the responses seen during the climb are uncoordinated output from a damaged regulator."},{"label":"B","text":"Cutaneous sensors are reporting the surrounding air rather than the interior, so the effectors are following the skin reading and ignoring the deep reading."},{"label":"C","text":"The regulator's target value has been driven upward, so 38.6 still counts as too low and warmth conserving effectors run until the new target is met."},{"label":"D","text":"Avenues of heat disposal are already open to their maximum, and the muscular bursts are an incidental by-product of the extra load being handled."}]$q$::jsonb,
    'C',
    $q$This item sits in Organ Systems and tests the logic of a regulated variable when the regulator's target itself is moved. The answer is C because a negative feedback loop compares the measured value with a target and drives its effectors in whichever direction closes the gap, so once the target is pushed above the current reading, the loop treats a perfectly warm body as too cool and recruits every warmth conserving response it has. That is precisely what the scenario shows: pale cool skin means the surface vessels are shut down so that warmth is held in, blanket seeking is the behavioural arm of the same drive, and rhythmic contraction of large muscles is the effector that raises internal warmth production. All three effectors point the same way, upward, which is the signature of an intact loop chasing a raised target rather than a broken one. This also explains the familiar sequence in which a person feels coldest while the reading is rising fastest, stops feeling cold once the reading reaches the new target, and finally feels hot and sweats when the target returns to normal and the same loop reverses to shed the surplus. (Choice A) Uncoordinated output from a damaged regulator would show effectors working against each other, whereas here the vascular, behavioural and muscular responses are aligned in a single direction, which is what an intact loop looks like. (Choice B) Sensors in the skin do contribute to the overall signal, but they cannot override a deep reading that is already well above the usual value for an entire hour, and this choice leaves unexplained why the target itself would have moved. (Choice D) The scenario states that the skin is pale and cool, which means the surface route for disposal is closed rather than wide open, so the premise of this choice contradicts the observation. This is a Scientific Reasoning and Problem Solving question because the student must read the direction in which several effectors are being driven and infer from that direction what has happened to the regulator's target.$q$,
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
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', NULL FROM q;

-- Q16 . Separating set point shift from heat overload . medium . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Separating set point shift from heat overload$q$,
    $q$Two people arrive at a clinic, each with a core reading of 39.2 degrees C. One became unwell with a bacterial illness; the other collapsed after several hours of hard labour in a hot, poorly ventilated shed. An investigator wants to establish, for each person separately, whether the regulator's target has been pushed upward or whether the target is unchanged and warmth acquisition has simply outrun removal. Which of the following should the investigator do?$q$,
    $q$[{"label":"A","text":"Follow how high the core reading rises in each person over the next six hours."},{"label":"B","text":"Count the circulating white cells in a blood sample from each person."},{"label":"C","text":"Cool both people externally with ice packs and compare how quickly each core reading comes down."},{"label":"D","text":"Record, before any treatment is given, whether each person's skin vessels and sweat glands are being driven toward retaining heat or toward unloading it."}]$q$::jsonb,
    'D',
    $q$This item sits in Organ Systems and tests how to design an observation that reveals the state of a controller rather than the value of the variable it controls. The answer is D because the core reading alone is identical in the two people and therefore carries no information about the target; what distinguishes them is the direction in which the loop is currently driving its output. If the target has been pushed upward, the loop reads 39.2 as still short of where it wants to be and keeps the surface vessels narrowed and sweating suppressed. If the target is unchanged and warmth has simply accumulated faster than it could be shed, the loop reads 39.2 as far too high and has the surface vessels open and the sweat glands running flat out. Reading the effectors at a fixed value of the controlled variable, before anything has been done to either person, is the manoeuvre that separates a moved target from a defeated one, because it removes the reading itself as a confounding difference between the two people. (Choice A) How far the reading eventually climbs is a matter of severity rather than of mechanism, and both a raised target and unchecked accumulation can reach similar peaks, so this observation does not discriminate. (Choice B) A white cell count can indicate that an infection is present, but infection and overwhelming heat exposure can coexist in the same person, and the count says nothing about where the regulator's target currently sits. (Choice C) External cooling removes warmth from both people by the same physical route, so the rate of decline mostly reports body size, surface contact and circulation rather than the position of the target, and applying an intervention also destroys the resting state the investigator needs to observe. This is a Reasoning about the Design and Execution of Research question because the student must choose the observation that isolates the controller's behaviour while holding the controlled variable itself constant across the two people.$q$,
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
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', NULL FROM q;

-- Q17 . Receptor depth and spatial resolution . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Receptor depth and spatial resolution$q$,
    $q$Two closely spaced points pressed against a fingertip can be felt as separate only if each indentation deforms a different sensory ending. Mechanical deformation that must travel far through tissue spreads sideways as it descends, so at depth two small indentations merge into a single broad distortion. Which of the following cutaneous receptors are positioned so that two nearby indentations still reach them as distinct events?

I. Merkel discs
II. Meissner corpuscles
III. Pacinian corpuscles$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"III only"},{"label":"C","text":"I and II only"},{"label":"D","text":"II and III only"}]$q$::jsonb,
    'C',
    $q$This Organ Systems question tests how the depth at which each named cutaneous receptor sits determines the spatial detail it can report. The answer is C because Merkel discs and Meissner corpuscles both lie at the very top of the skin: Merkel discs sit among the deepest epidermal cells, and Meissner corpuscles occupy the dermal projections immediately beneath the epidermis. A small contact at the surface reaches these endings after traveling almost no distance, so the mechanical distortion it produces is still narrow and local when it arrives. Two nearby contacts therefore deform two different shallow endings, which is the physical requirement the stem describes. Pacinian corpuscles, by contrast, lie in the deep dermis and the tissue beneath it. Deformation arriving from the surface spreads as it descends, so at that depth two contacts have already merged into one broad distortion, and no receptor there can tell them apart. That deep location instead suits the Pacinian corpuscle to stimuli that penetrate the whole tissue block, such as firm pressure and vibration. (Choice A) is incomplete. Merkel discs are indeed shallow, but Meissner corpuscles sit essentially at the same level, just under the epidermal border, and receive equally distinct deformation, so excluding them is unjustified. (Choice B) inverts the depth logic entirely: the Pacinian corpuscle is the deepest of the named receptors, so it is the one for which nearby contacts are least separable. (Choice D) pairs a correct choice with a wrong one. The Pacinian corpuscle's extreme sensitivity to tiny rapid displacements tempts students to credit it with spatial precision, but sensitivity and spatial resolution are independent properties, and depth abolishes the second no matter how great the first. This is a Knowledge of Scientific Concepts and Principles question because it asks the student to recall the depth at which each named skin receptor sits and to match that position against the physical requirement given in the stem.$q$,
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
  SELECT q.id, 'A', 'partial_truth', $q$half the shallow pair$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', $q$deepest receptor chosen for finest detail$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$sensitivity mistaken for resolution$q$ FROM q;

-- Q18 . Lamellar capsule as temporal filter . medium . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Lamellar capsule as temporal filter$q$,
    $q$A mechanoreceptor located deep in the dermis is wrapped in dozens of concentric connective tissue layers separated by fluid. When a probe presses steadily into the overlying skin, the receptor's afferent fiber discharges briefly as the probe arrives, falls silent while the press is held, and discharges again when the probe lifts. Investigators propose that the wrapping is responsible: slow, held deformation is redistributed around the ending through the fluid layers and never reaches the axon terminal, while abrupt changes are transmitted through before redistribution can occur. To test this, they dissect the layers away and record from the bare ending. Which observation would support their proposal?$q$,
    $q$[{"label":"A","text":"During a held press, the bare ending generates a response that continues for as long as the press is maintained, unlike the intact receptor."},{"label":"B","text":"The bare ending gives no response to any mechanical stimulus, whether held or abrupt."},{"label":"C","text":"The bare ending responds only when the probe arrives and lifts, exactly as the intact receptor did."},{"label":"D","text":"The bare ending responds during a held press only when the probe is driven several times deeper than before."}]$q$::jsonb,
    'A',
    $q$This Organ Systems question tests whether the student can identify the experimental result that would implicate the layered capsule of the deep dermal vibration receptor, the Pacinian corpuscle, as a mechanical filter. The answer is A because the proposal makes a specific prediction: the silence during a held press is imposed by the wrapping, not by the nerve ending itself. If that is true, then stripping the wrapping away should unmask an ending that signals steadily whenever it is deformed, while only the intact preparation confines its activity to the moments of change. Observing a continuous response from the bare ending during a held press, alongside onset and offset responses from the intact corpuscle, is exactly the dissociation the proposal predicts. The fluid filled layers absorb and redistribute slow deformation so that only rapid change gets through to the terminal, and this construction is why the intact receptor answers vibration while ignoring a steady load. (Choice B) reflects the misconception that the capsule itself performs the sensory transduction. The terminal of the afferent fiber is the transducing element; the layers merely govern which deformations reach it, so their removal should not abolish responsiveness altogether. (Choice C) is the result predicted by the rival account, in which the decline during a held stimulus is intrinsic to the ending itself. If the bare ending behaved identically to the intact receptor, the wrapping would be contributing nothing temporal, and the proposal would be undermined rather than supported. (Choice D) recasts the wrapping as a device that sets how large a stimulus must be rather than how fast it must change. A deeper press differs in magnitude, not in time course, so this observation would speak to stimulus strength, which is not the property the proposal claims the layers control. This is a Reasoning about the Design and Execution of Research question because it asks the student to determine which recorded outcome of a dissection experiment would support one proposed mechanism over its alternative.$q$,
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
  SELECT q.id, 'B', 'misconception', $q$capsule as the transducer$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$rival hypothesis outcome$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'scale_unit_error', $q$magnitude for timescale$q$ FROM q;

-- Q19 . Deficit pattern localizing receptor loss . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Deficit pattern localizing receptor loss$q$,
    $q$A patient with a selective fingertip neuropathy undergoes quantitative sensory testing, with results shown below.

| Test | Affected hand | Unaffected hand |
| --- | --- | --- |
| Two-point threshold, sustained caliper | 14 mm | 3 mm |
| Detection of gentle 30 Hz flutter | Normal | Normal |
| Detection of 250 Hz vibration | Normal | Normal |
| Detection of skin stretch across the digit | Normal | Normal |

Loss of which receptor population best accounts for this pattern?$q$,
    $q$[{"label":"A","text":"Free nerve endings"},{"label":"B","text":"Meissner corpuscles"},{"label":"C","text":"Pacinian corpuscles"},{"label":"D","text":"Merkel discs"}]$q$::jsonb,
    'D',
    $q$This Organ Systems question tests whether a pattern of preserved and lost sensory capacities can be traced back to the one receptor class whose position and construction fit the missing function. The answer is D because the only failed test is fine spatial discrimination under a steadily applied stimulus, and that job belongs to Merkel discs. They sit at the base of the epidermis, shallow enough that the deformation from each caliper tip is still narrow when it arrives, and each ending reports from a small, sharply bounded patch of skin, so two tips a few millimetres apart normally engage separate endings. They are also slowly adapting, continuing to signal for as long as a stimulus is held, which is exactly what a sustained caliper demands. With Merkel discs gone, the held tips cannot be resolved until they are far apart, while every other tested capacity persists because its receptor class remains intact. (Choice A) Free nerve endings mediate pain and temperature; their loss would blunt pinprick and thermal sensation, neither of which was tested here, and they contribute nothing to separating two blunt points. (Choice B) Meissner corpuscles are also shallow and serve fine touch, so they are tempting, but the normal detection of gentle low frequency flutter shows they are functioning, and they adapt rapidly, falling silent while a stimulus is held, so a sustained caliper press must be reported by slowly adapting endings rather than by them. (Choice C) Pacinian corpuscles are excluded twice over: normal detection of 250 Hz vibration shows they work, and their position deep in the dermis means the deformation reaching them from two nearby tips has already merged, so they could not support two-point separation even when healthy. This is a Data-based and Statistical Reasoning question because it requires reading a table of spared and impaired sensory results and inferring which single receptor loss is consistent with every row at once.$q$,
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
  SELECT q.id, 'A', 'adjacent_fact', $q$wrong modality receptor$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$the other shallow receptor$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$vibration receptor misapplied$q$ FROM q;

-- Q20 . Supranuclear pigment cap geometry . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Homeostasis',
    $q$Supranuclear pigment cap geometry$q$,
    $q$In the deepest layer of the epidermis, the only epidermal cells that still divide accumulate pigment clustered in a cap on the side of the nucleus facing the skin surface. Compared with the same quantity of pigment spread evenly through all layers of the epidermis, what advantage does this placement provide?$q$,
    $q$[{"label":"A","text":"It positions the pigment to catch rays that have already passed the nuclei, shielding the underlying dermis from injury."},{"label":"B","text":"It interposes an absorbing shield between arriving rays and the genomes of the cells whose uncorrected damage would be inherited by every cell they subsequently produce."},{"label":"C","text":"It keeps the pigment out of superficial cells, which are continuously shed, so the investment in pigment lasts longer before being lost."},{"label":"D","text":"It brings the pigment close enough to the genetic material of dividing cells to speed the enzymatic correction of any injury that occurs."}]$q$::jsonb,
    'B',
    $q$This Organ Systems question tests why melanin accumulates as a cap above the nucleus inside the dividing basal cells of the epidermis rather than being distributed indiscriminately. The answer is B because the threat the pigment counters, ultraviolet light, arrives from outside the body, and the cells that most need defending are the ones that go on dividing. A basal cell that acquires an unrepaired change to its genetic sequence copies that change into both daughters, and their descendants replace the entire overlying epidermis, so a single injured basal cell can seed a permanent and expanding population of altered cells, including the ones from which skin cancers arise. Cells above the basal layer face the opposite fate: they have left the cycle, are moving outward, and will be shed within weeks, so injury to them departs with them. An absorbing cap parked between the incoming light and the basal nucleus therefore concentrates protection exactly where injury would be perpetuated, a far better use of a fixed amount of pigment than diluting it through layers whose cells are disposable. (Choice A) reverses the geometry: a shield is useful only when it sits between the source and the target, and rays that have already passed a basal nucleus have already done whatever harm they will do to it. The dermis is also the wrong target, since its injuries are not multiplied by epidermal division. (Choice C) starts from a true observation, that superficial cells are shed, but draws the wrong conclusion from it: shedding is precisely why superficial cells need little protection, and the point of the deep placement is to guard the cells that persist, not to economize on pigment turnover. (Choice D) assigns the pigment a repair function it does not have. It absorbs and dissipates incoming energy before injury occurs, while correction of injury that does occur is carried out by enzymes unrelated to pigment. This is a Scientific Reasoning and Problem Solving question because it requires connecting the geometry of an absorbing structure to the renewal biology of the epidermis to explain why one arrangement protects better than another.$q$,
    'hard',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    90
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'reversed_relationship', $q$shield behind the target$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$true premise, wrong conclusion$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$pigment as repair enzyme$q$ FROM q;

COMMIT;

-- Verification: the chapter is COMPLETE. Expect 60 questions and 180 distractor rows.
SELECT
  (SELECT COUNT(*) FROM public.questions WHERE topic = 'Homeostasis') AS questions,
  (SELECT COUNT(*) FROM public.question_distractor_metadata m
     JOIN public.questions x ON x.id = m.question_id
   WHERE x.topic = 'Homeostasis') AS distractor_rows;

-- Distribution check across the finished chapter.
SELECT difficulty, COUNT(*) FROM public.questions
 WHERE topic = 'Homeostasis' GROUP BY difficulty ORDER BY difficulty;
SELECT correct_answer, COUNT(*) FROM public.questions
 WHERE topic = 'Homeostasis' GROUP BY correct_answer ORDER BY correct_answer;
