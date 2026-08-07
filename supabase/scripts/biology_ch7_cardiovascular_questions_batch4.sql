-- Biology Chapter 7: The Cardiovascular System, standalone questions
-- BATCH 4 of 4 (25 questions): coagulation, oxygen delivery, transfusion, baroreflex.
--   Units: coagulation and hemostasis . oxygen content, delivery and extraction . blood groups
--          and transfusion . neural control of the circulation . leukocytes as formed elements
--
-- Verified against OpenStax Anatomy and Physiology 2e with line-level citations; see
-- biology_ch7_cardiovascular_questions.verification.md for the per-question audit trail.
--
-- !! RUN AFTER BATCHES 1, 2 AND 3 !!
-- This file contains NO delete: batch 1 owns the chapter-scoped DELETE. Run
-- batches 1, 2 and 3 first, then this file. This completes the chapter at 100 questions.
-- Re-running this file alone would duplicate its 25 questions, so if you need a clean slate,
-- re-run batch 1 (which clears the chapter) and then every later batch in order.

BEGIN;

-- B4 Q1 . Immediate Vessel Narrowing After Injury . easy . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Immediate Vessel Narrowing After Injury$q$,
    $q$A researcher punctures a small arteriole in an anesthetized rat and records that visible blood loss slows sharply within \(15\) seconds, whereas a firm gelatinous mass is not present at the wound until roughly \(5\) minutes later. Which event most likely accounts for the reduction in blood loss observed at \(15\) seconds?$q$,
    $q$[{"label":"A","text":"Cross-linking of insoluble protein strands across the opening in the wall"},{"label":"B","text":"Conversion of a circulating precursor into an active clotting enzyme at the site"},{"label":"C","text":"Contraction of platelet proteins that draw the edges of the opening together"},{"label":"D","text":"Contraction of the smooth muscle in the wall around the opening"}]$q$::jsonb,
    'D',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because contraction of the smooth muscle in the wall physically narrows the injured segment within seconds, long before any protein mesh exists. Hemostasis proceeds in three ordered steps: vascular spasm, formation of a platelet plug, and coagulation. The spasm is a dramatic contraction of the vessel's own smooth muscle, believed to be triggered by chemicals released from vessel-lining cells and from pain receptors, and it typically lasts up to \(30\) minutes. That timing makes it the only listed process able to reduce flow at \(15\) seconds. The firm gelatinous mass appearing at \(5\) minutes is the product of the coagulation step, so any process that depends on that mesh cannot explain the much earlier drop in blood loss. (Choice A) Cross-linking of insoluble strands is the terminal stabilizing event of coagulation and requires a mesh that the observation places at roughly \(5\) minutes. At \(15\) seconds essentially no strands are present to be linked together. This choice places the final step of the sequence at its beginning. (Choice B) Precursor activation does begin rapidly after tissue damage, so this option is partly reasonable on timing. However, generating an active enzyme does not by itself reduce the caliber of the opening or slow flow through it; it only initiates the chemistry that later yields strands. A measurable drop in blood loss at \(15\) seconds requires a mechanical change in the wall. (Choice C) Contraction of platelet proteins does pull the edges of a clot together, but this retraction acts on a clot that has already been stabilized. It therefore necessarily follows mesh formation rather than preceding it. Assigning it to the \(15\) second mark reverses the order of the sequence. (Choice D) When a vessel is severed or punctured, the smooth muscle in its wall contracts dramatically, constricting flow immediately and persisting for up to \(30\) minutes. This is the first of the three hemostatic steps and the only one available on a \(15\) second timescale. It therefore accounts for the sharp early reduction in blood loss. This is a Scientific Reasoning and Problem Solving question because you must match the timing of two hemostatic events and pick the one fast enough to slow bleeding within seconds of injury.$q$,
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
  SELECT q.id, 'A', 'process_step_confusion', $q$terminal step placed first$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$true early event with no mechanical consequence$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$clot retraction mistimed$q$ FROM q;

-- B4 Q2 . Enzymatic Clot Dissolution . easy . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Enzymatic Clot Dissolution$q$,
    $q$Two weeks after a deep bruise, a small clot inside a superficial vein has gradually disappeared and blood flow through that segment is normal. Imaging shows no new obstruction anywhere downstream. Which process most directly accounts for the clot's removal?$q$,
    $q$[{"label":"A","text":"Contractile proteins within platelets tightened the mesh and squeezed fluid out of it"},{"label":"B","text":"A circulating inactive protein was converted to an enzyme that digested the mesh"},{"label":"C","text":"Heparin on the vessel lining prevented further strands from being added to the mesh"},{"label":"D","text":"Liver-derived clotting factors were exhausted, so the mesh could not be maintained"}]$q$::jsonb,
    'B',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because an inactive plasma protein is converted into an active protein-degrading enzyme that gradually breaks down the strands making up the clot. Once a vessel has healed, normal flow can only be restored if the existing mesh is physically destroyed rather than merely prevented from growing. Fibrinolysis accomplishes this by activating a circulating precursor into an enzyme that catabolizes the strands over days. The absence of any downstream obstruction rules out the alternative fate in which a fragment detaches and lodges elsewhere, leaving local dissolution as the explanation. Processes that only compact the clot or block its further enlargement leave the original mass in place. (Choice A) Contraction of platelet proteins does shrink a clot and wring fluid out of it, and this genuinely reduces clot volume. However, retraction concentrates rather than eliminates the strands, and it acts on the clot shortly after that clot is stabilized rather than over two weeks. A retracted clot still occupies the lumen and would not restore normal flow. (Choice B) Fibrinolysis converts an inactive circulating protein into an active enzyme that gradually breaks down the strands of the clot. This is the mechanism by which normal blood flow is restored as the vessel heals. The slow, progressive disappearance described fits this enzymatic degradation. (Choice C) Anticoagulants found on the surfaces of the cells lining vessels do limit the extension of clotting beyond the region of injury. Preventing new strands from being added, though, does nothing to the strands already deposited. The existing clot would persist and continue to obstruct the segment. (Choice D) Clotting factors are indeed secreted primarily by the liver and can be consumed during extensive clotting. Depleting the supply of precursors halts further clot growth but leaves the assembled mesh intact, because the mesh is not maintained by ongoing factor consumption. This would not restore flow through the segment. This is a Scientific Reasoning and Problem Solving question because you must use the absence of any downstream obstruction to eliminate mechanical dislodgement and infer how the mesh was broken down where it sat.$q$,
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
  SELECT q.id, 'A', 'process_step_confusion', $q$retraction mistaken for removal$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$anticoagulation confused with lysis$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$precursor depletion without degradation$q$ FROM q;

-- B4 Q3 . Platelet Granule Release and Plug Growth . medium . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Platelet Granule Release and Plug Growth$q$,
    $q$In a flow chamber, whole blood is perfused over a collagen-coated surface in the presence of a compound that blocks the emptying of platelet secretory granules. Compared with untreated blood, what is the most likely effect on the platelet aggregate that forms on the surface?$q$,
    $q$[{"label":"A","text":"Platelets attach normally, but few extra platelets are recruited and the aggregate stays thin"},{"label":"B","text":"Platelets fail to attach to the collagen at all, so no aggregate begins to form"},{"label":"C","text":"Platelets attach and recruit further platelets normally, but no reinforcing protein mesh forms"},{"label":"D","text":"Platelets build a larger aggregate than controls because inhibitory signals are retained inside them"}]$q$::jsonb,
    'A',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because initial attachment depends on direct binding to exposed collagen, whereas enlargement of the aggregate depends on chemicals that platelets release once bound. Platelets that meet exposed collagenous fibers clump, become spiked and sticky, and bind directly to that surface, a step that requires no secretion. Once bound, they release granule contents including adenosine diphosphate, which helps additional platelets adhere at the injury site and thereby reinforces and expands the plug. Blocking secretion therefore separates these two functions: the first layer still forms, but the positive feedback that amplifies it is lost. The predicted result is a thin aggregate rather than a growing plug. (Choice A) Direct binding to collagenous fibers is a contact-dependent event and is unaffected by an inhibitor of secretion. Recruitment of further platelets, however, is driven by released granule contents, so it collapses when secretion is blocked. The aggregate consequently starts but fails to enlarge. (Choice B) Complete failure of attachment would occur if the collagen-binding step itself were disabled, which is not what this compound does. Platelets bind exposed collagen directly rather than through material they secrete. Attachment should therefore remain intact in the treated sample. (Choice C) This option preserves the very step the manipulation removes, because recruitment of additional platelets is driven by chemicals released from the granules. Granule contents also include phospholipids that help activate further clotting chemicals, so the reinforcing mesh would if anything be impaired as well rather than being the sole casualty. The option therefore misassigns which function survives the treatment. (Choice D) Granule contents released by platelets act to recruit and activate further platelets rather than to suppress them. Trapping those contents inside the cell would therefore reduce, not increase, aggregate size. This option inverts the direction of the signal. This is a Reasoning about the Design and Execution of Research question because you must predict how selectively blocking one secretory step in a flow chamber separates initial surface attachment from the amplification that normally follows it.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    3,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'misconception', $q$secretion required for adhesion$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$preserves the step the manipulation removes$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$recruitment signal treated as inhibitory$q$ FROM q;

-- B4 Q4 . Clot Retraction by Platelet Contraction . medium . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Clot Retraction by Platelet Contraction$q$,
    $q$Whole blood from a healthy donor forms a solid clot in \(6\) minutes, and over the next hour the clot shrinks to about \(45\%\) of its original volume while clear fluid is expressed around it. Blood from a patient also forms a solid clot in \(6\) minutes, but the clot volume is unchanged after one hour, and the patient's platelet count and plasma coagulation protein concentrations are normal. Which platelet function is most likely impaired in the patient?$q$,
    $q$[{"label":"A","text":"Adhering to collagen exposed at a site of injury"},{"label":"B","text":"Releasing granule contents that recruit additional platelets"},{"label":"C","text":"Providing membrane surfaces on which activation reactions are accelerated"},{"label":"D","text":"Generating contractile force against the strands of the clot mesh"}]$q$::jsonb,
    'D',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because the shrinkage of a formed clot and the expression of fluid from it are produced by contractile proteins inside platelets pulling on the strands of the mesh. The patient forms a clot on schedule and has a normal platelet count and normal plasma proteins, so every step up to and including mesh formation is functioning. The single abnormality is that the formed clot never decreases in volume, isolating a defect that acts after the mesh is stabilized. Contractile proteins within platelets normally pull on the strands, drawing the edges of the clot together and wringing out a small volume of fluid. A failure of that contractile machinery reproduces exactly the pattern described. (Choice A) A defect in binding to exposed collagen would delay or prevent the initial plug and would show up as impaired clot formation. The patient's clot appears at \(6\) minutes, matching the control exactly. The data therefore exclude a problem with the adhesive step. (Choice B) Failure to release granule contents would blunt recruitment of further platelets and slow the appearance of a plug. Because clotting time is identical to control, recruitment cannot be the limiting defect here. This option addresses plug growth rather than the post-formation change in volume. (Choice C) Platelet membranes do serve as surfaces on which activation reactions are accelerated, so losing that function is physiologically meaningful. However, such a defect would prolong the time required to form the clot, which is normal in this patient. The observation of unchanged volume after an intact \(6\) minute clotting time points elsewhere. (Choice D) Contractile proteins within platelets act on the stabilized clot, pulling the strands so that the edges are drawn tightly together and fluid is expressed. Loss of this force leaves a clot that forms normally but never decreases in volume. This matches the patient's isolated abnormality. This is a Reasoning about the Design and Execution of Research question because you must use a comparison in which clotting time is held identical to isolate the step that fails only after the mesh has already formed.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    3,
    85
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'adjacent_fact', $q$real platelet function excluded by data$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', $q$recruitment defect excluded by normal clotting time$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$true platelet role, wrong stage$q$ FROM q;

-- B4 Q5 . Cascade Amplification by Feedback Activation . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Cascade Amplification by Feedback Activation$q$,
    $q$An investigator adds the same trace dose of an active clotting enzyme to two tubes, one containing plasma and one containing purified fibrinogen at the same concentration in identical buffer. In the purified tube, fibrin accumulates at a steadily declining rate from the start, whereas in the plasma tube the rate of accumulation rises for the first \(60\) seconds before substrate becomes limiting. Which feature of plasma best accounts for the rising phase?$q$,
    $q$[{"label":"A","text":"Plasma contains a protein that cross-links the strands once they have formed"},{"label":"B","text":"Plasma proteins shield the added enzyme from degradation, prolonging its active lifetime"},{"label":"C","text":"Plasma supplies cofactors that the purified system lacks, speeding each catalytic cycle"},{"label":"D","text":"Plasma contains precursors that the added enzyme converts into more of itself"}]$q$::jsonb,
    'D',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because a reaction rate that increases over time indicates that the amount of active enzyme is itself growing, which happens when the enzyme activates precursors that generate more of it. In the purified system the enzyme concentration is fixed, so the rate can only fall as substrate is consumed, and this is exactly what is observed. In plasma the rate climbs instead, which cannot be explained by any effect that merely preserves, accelerates or repositions a fixed quantity of enzyme. Coagulation is organized as a cascade in which the final enzyme also activates clotting factor molecules earlier in the sequence, producing still more of that enzyme. This positive feedback loop amplifies the cascade and is the only listed feature capable of increasing the amount of active enzyme during the reaction. (Choice A) A plasma protein that cross-links strands once they have formed is a genuine component of clot stabilization and makes the finished mesh more durable. Stabilizing a product, however, acts downstream of the reaction being timed and does not change how fast new strands appear. It cannot generate an accelerating rate. (Choice B) Protecting the enzyme from degradation would keep the rate from falling as quickly, which is a plausible-sounding effect. Even a perfectly protected enzyme, though, is present at a fixed amount and would at best sustain a constant rate against declining substrate. Sustaining a rate is not the same as increasing it. (Choice C) Plasma genuinely supplies cofactors that a purified preparation lacks, and calcium in particular is required throughout the clotting process. A cofactor present at a fixed concentration from the first instant would raise the rate uniformly rather than cause it to climb while substrate falls. The shape of the time course, not its magnitude, is what must be explained. (Choice D) The cascade is built so that the enzyme converting the soluble precursor into insoluble strands also activates factors earlier in the sequence. Each round therefore produces more of that same enzyme, so its concentration and the reaction rate both rise with time. This autocatalytic amplification is absent from the purified system, matching the divergence between the tubes. This is a Data-based and Statistical Reasoning question because you must compare the shapes of two fibrin accumulation curves and infer what the plasma tube supplies that a purified system cannot.$q$,
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
  SELECT q.id, 'A', 'adjacent_fact', $q$true downstream stabilization offered as a rate cause$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$enzyme preservation confused with enzyme generation$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$real cofactor, wrong kinetic signature$q$ FROM q;

-- B4 Q6 . Confinement of Clotting to the Injury Site . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Confinement of Clotting to the Injury Site$q$,
    $q$Clot formation at a small wound normally stays within the damaged segment rather than propagating along the vessel into healthy tissue. An investigator proposes three mechanisms that could contribute to this confinement.

I. Anticoagulants carried in the plasma inactivate activated clotting enzymes that are swept downstream from the wound
II. The undamaged lining bordering the wound keeps the collagenous fibers beneath it covered
III. Clotting factors are consumed at the wound faster than the liver can replace them, leaving none available downstream

Which of the proposed mechanisms would contribute to confinement?$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"I and III only"},{"label":"C","text":"II and III only"},{"label":"D","text":"I and II only"}]$q$::jsonb,
    'D',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because plasma anticoagulants quench activated enzymes that leave the wound and an intact lining withholds the collagen that would otherwise activate platelets, whereas confinement does not depend on exhausting the supply of clotting factors. Several circulating plasma anticoagulants act specifically to limit the coagulation process to the region of injury and to restore a clot-free condition in the rest of the blood. Damage to the endothelial lining with exposure of the collagenous fibers beneath it is one of the primary causes of clot formation, so a border whose lining is intact simply presents no trigger. Item III fails on both scale and consequence: the circulating pool of liver-derived factors greatly exceeds what a small wound consumes, and a state in which those factors truly are depleted produces bleeding at distant sites rather than orderly localization. (Choice A) This selection accepts the plasma brake but discards the contribution of the intact lining. Because exposure of the underlying collagenous fibers is a primary trigger for clot formation, a border that keeps those fibers covered is itself a confinement mechanism. Omitting item II understates how localization is achieved. (Choice B) This selection pairs a correct mechanism with the claim that the factor supply runs out. Localization is attributed to inhibitors that inactivate enzymes leaving the injury, not to depletion of precursors, and depletion severe enough to halt clotting presents as bleeding elsewhere rather than as tidy confinement. Item III therefore cannot be part of the answer. (Choice C) This selection recognizes the structural barrier but rejects the plasma inhibitors while accepting factor depletion. Activated enzymes generated at the wound do enter flowing blood, and circulating anticoagulants are described as limiting coagulation to the region of injury. Dropping item I while keeping item III inverts which of the two is genuine. (Choice D) Items I and II operate at different levels and together explain localization: inhibitors in the plasma inactivate activated enzymes carried away from the wound, and the undamaged lining offers no exposed collagen to activate platelets. Item III is excluded because the supply of liver-derived factors is not the limiting quantity at a small wound. This pairing captures both the chemical and the structural basis of confinement. This is a Data-based and Statistical Reasoning question because you must weigh each proposed mechanism against the observation that clotting stops at the damaged segment and keep only those consistent with that limit.$q$,
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
  SELECT q.id, 'A', 'partial_truth', $q$chemical brake accepted, structural barrier ignored$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$confinement attributed to precursor depletion$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$genuine inhibitor discarded, pathological consumption retained$q$ FROM q;

-- B4 Q7 . Platelet Plug Versus Fibrin Reinforcement . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Platelet Plug Versus Fibrin Reinforcement$q$,
    $q$A standardized skin puncture in a patient stops bleeding at \(5\) minutes, within the \(2\) to \(9\) minute reference range, but the wound re-bleeds \(45\) minutes later. The patient's platelet count and collagen-induced platelet aggregation are both normal, whereas a plasma sample from the patient takes more than four times as long as control plasma to form a gel. Which defect best explains the combined findings?$q$,
    $q$[{"label":"A","text":"Failure of platelets to adhere to collagen exposed at the wound"},{"label":"B","text":"Failure of the injured arteriole to constrict after the puncture"},{"label":"C","text":"Failure to convert a soluble precursor protein into insoluble strands"},{"label":"D","text":"Failure to restrain the enzyme that dissolves an established clot"}]$q$::jsonb,
    'C',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because the patient can build a platelet plug on time but cannot generate the insoluble strands that convert that temporary seal into a durable clot. A platelet plug can temporarily seal a small opening, buying time while more durable repairs are made, which explains why bleeding stops within the reference range. The normal platelet count and normal collagen-induced aggregation confirm that this first phase is intact. The markedly prolonged time for plasma to gel localizes the defect to the step in which a soluble protein is converted into insoluble strands. Without that mesh the unreinforced plug cannot withstand pressure, and bleeding resumes after roughly \(45\) minutes. (Choice A) A failure of platelets to bind exposed collagen would delay or abolish the initial seal, producing a bleeding time outside the reference range. The measured value of \(5\) minutes and the normal collagen-induced aggregation both argue against this. The adhesive step is functioning in this patient. (Choice B) Loss of the constrictive response would also impair the earliest reduction in blood loss and would not selectively affect a plasma test performed outside the body. The gel time abnormality involves plasma alone, which contains no vessel wall. Vascular narrowing cannot account for the laboratory finding. (Choice C) The prolonged plasma gel time identifies impaired conversion of a soluble protein into insoluble strands, and it is that mesh which traps platelets and blood cells to make the clot robust. Bleeding stops on schedule because the temporary plug forms normally, then resumes when the plug is not reinforced. Both halves of the clinical picture follow from this single defect. (Choice D) Unrestrained activity of the clot-dissolving enzyme is a real cause of delayed re-bleeding after an initially normal seal, which makes this option genuinely tempting. Its action, however, is exerted on a clot after that clot has formed, so it does not account for the patient's plasma requiring more than four times the control time to gel at all. The prolonged gel time points to failed strand production rather than accelerated strand removal. This is a Data-based and Statistical Reasoning question because you must read a normal bleeding time and normal platelet studies against a delayed re-bleed and localize the defect to the later stabilizing step.$q$,
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
  SELECT q.id, 'A', 'adjacent_fact', $q$adhesion defect excluded by the data$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', $q$vessel wall defect invoked for a plasma finding$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$hyperlysis explains re-bleed but not the assay$q$ FROM q;

-- B4 Q8 . Vasomotor Changes Across the Clot Lifecycle . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Vasomotor Changes Across the Clot Lifecycle$q$,
    $q$After a small arteriole is punctured, its diameter falls to about \(60\%\) of baseline within one minute and is still reduced when measured at \(30\) minutes. Serial imaging shows the diameter returning to baseline only as the clot occupying the site is subsequently removed. Which mechanism best accounts for both the persistence of the narrowing and the timing of its reversal?$q$,
    $q$[{"label":"A","text":"Mechanical compression of the vessel wall by the enlarging clot, relieved when the clot is digested"},{"label":"B","text":"Chemicals released by adhering platelets, later opposed by a vasodilator appearing during clot removal"},{"label":"C","text":"Sustained stretch of the vessel wall by rising upstream pressure, relieved when flow resumes"},{"label":"D","text":"Contraction of wall smooth muscle driven by plasma calcium, ending when the clot consumes it"}]$q$::jsonb,
    'B',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because chemicals released by platelets at the wound maintain the vasoconstriction, and the later degradation of the clot liberates a vasodilator that reverses exactly those chemicals. The narrowing begins as a contraction of wall smooth muscle triggered by endothelins from vessel-lining cells and by pain receptors. Among the substances subsequently released from platelet granules are serotonin, which maintains vasoconstriction, and prostaglandins and phospholipids, which also maintain vasoconstriction. During degradation of the clot, bradykinin, a vasodilator, is released, reversing the effects of the serotonin and prostaglandins from the platelets and allowing the smooth muscle in the vessel wall to relax and the circulation to be restored. A single chemical scheme therefore explains both the maintained narrowing and the coupling of its reversal to clot removal. (Choice A) Compression by a growing clot is intuitively appealing because the clot and the narrowing appear together and resolve together. However, a clot forms inside the lumen and would narrow the channel rather than squeeze the muscular wall from outside, so it cannot produce a reduction in the diameter of the vessel itself. The observed narrowing reflects contraction of the wall. (Choice B) Substances released by platelets at the wound, including serotonin and prostaglandins, maintain vasoconstriction and so sustain the narrowing beyond its initial trigger. As the clot is later broken down, a vasodilator is released that specifically reverses the effects of those platelet products, letting the wall smooth muscle relax and the circulation be restored. This links both phases of the diameter record to one sequence of released chemicals. (Choice C) Wall stretch is a real determinant of vessel caliber, and pressure does rise proximal to an obstruction. Compliance, however, allows a vessel to expand when the pressure inside it rises, so stretch produces distension rather than the sustained \(40\%\) reduction in diameter recorded here. This option also leaves the timing of the reversal unexplained. (Choice D) Calcium is genuinely required throughout the clotting process and participates in smooth muscle contraction, which makes this option superficially plausible. The quantity of calcium incorporated into a small clot is negligible against a tightly regulated plasma concentration, so it could not fall far enough to release the vessel. The reversal is instead tied to the appearance of a vasodilator during clot degradation. This is a Data-based and Statistical Reasoning question because you must align a vessel diameter time course with the lifespan of the clot and infer which signals sustain the narrowing and which later reverse it.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$intraluminal clot as external compressor$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', $q$stretch offered as a cause of narrowing$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'scale_unit_error', $q$clotting calcium requirement scaled to plasma depletion$q$ FROM q;

-- B4 Q9 . Oxygen Content Versus Percent Saturation . easy . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Oxygen Content Versus Percent Saturation$q$,
    $q$A woman with long-standing iron deficiency has a blood hemoglobin concentration of \(6\) g/dL, compared with about \(14\) g/dL in healthy adults. Her lungs are normal, her arterial \(P_{\text{O}_2}\) is \(98\) mm Hg, and pulse oximetry reads \(99\%\). Her exercise intolerance is most directly attributable to which feature of her arterial blood?$q$,
    $q$[{"label":"A","text":"A smaller fraction of its hemoglobin binding sites is occupied by oxygen."},{"label":"B","text":"A smaller quantity of oxygen is dissolved in its plasma."},{"label":"C","text":"A smaller total quantity of oxygen is carried in each unit volume."},{"label":"D","text":"A smaller partial pressure of oxygen drives diffusion into her tissues."}]$q$::jsonb,
    'C',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because nearly all blood oxygen travels bound to hemoglobin, so a carrier concentration of \(6\) g/dL rather than \(14\) g/dL leaves each unit volume holding far less oxygen even when partial pressure and percent saturation are normal. Percent saturation reports the fraction of available heme sites that happen to be occupied, not how many sites exist. A pulse oximeter therefore reads normally in anemia, because the few hemoglobin molecules present are almost fully loaded. Arterial \(P_{\text{O}_2}\) reports only the oxygen physically dissolved in plasma, which is a trivial share of the total. Oxygen content, the amount each unit volume can surrender to working muscle, scales with hemoglobin concentration, and it is the only one of the three measurements that is abnormal in this woman. (Choice A) Percent saturation is the proportion of heme units bound to oxygen at a given moment, and the reading of \(99\%\) sits at the top of the normal range of \(95\%\) to \(99\%\). Iron deficiency reduces the number of binding sites available, not the fraction of them that is filled. Her hemoglobin is well loaded; there is simply too little of it. (Choice B) Dissolved oxygen tracks arterial \(P_{\text{O}_2}\), which is normal at \(98\) mm Hg, so the dissolved quantity is also normal. Even a large change in this compartment would matter little, because only about \(1.5\%\) of blood oxygen travels dissolved. Iron deficiency does not alter the solubility of oxygen in plasma. (Choice C) Content is set by hemoglobin concentration multiplied by the fraction of its sites occupied, plus a negligible dissolved term. With saturation preserved but carrier concentration at roughly \(43\%\) of normal, each unit volume of her arterial blood hands off correspondingly less oxygen to exercising tissue. This is the deficit that limits her exertion. (Choice D) Her arterial partial pressure of \(98\) mm Hg is normal, so the gradient available at the arterial end of a systemic capillary is intact. What is missing is the reservoir of bound oxygen that normally sustains that gradient as blood traverses the capillary. Partial pressure and content describe different properties of the same sample, and only content is abnormal here. This is a Scientific Reasoning and Problem Solving question because you must separate the fraction of binding sites occupied from the absolute amount of gas the blood can carry when the carrier protein is scarce.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$saturation mistaken for capacity$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', $q$dissolved compartment overweighted$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$pressure substituted for content$q$ FROM q;

-- B4 Q10 . Dissolved Oxygen As A Fraction Of Content . medium . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Dissolved Oxygen As A Fraction Of Content$q$,
    $q$An investigator has a healthy volunteer breathe an enriched gas mixture that raises arterial \(P_{\text{O}_2}\) from \(100\) mm Hg to \(300\) mm Hg while hemoglobin saturation holds steady at \(99\%\). Plasma dissolves \(0.003\) mL of oxygen per \(100\) mL of blood for each mm Hg of \(P_{\text{O}_2}\), and the volunteer's arterial oxygen content was \(20\) mL per \(100\) mL beforehand. By approximately what percentage does arterial oxygen content rise?$q$,
    $q$[{"label":"A","text":"\\(3\\%\\)"},{"label":"B","text":"\\(4.5\\%\\)"},{"label":"C","text":"\\(30\\%\\)"},{"label":"D","text":"\\(200\\%\\)"}]$q$::jsonb,
    'A',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because tripling the partial pressure adds only \(0.6\) mL of dissolved oxygen per \(100\) mL to a starting content of \(20\) mL per \(100\) mL. Dissolved oxygen equals the solubility coefficient multiplied by partial pressure. At \(100\) mm Hg the plasma holds \(0.003 \times 100 = 0.3\) mL per \(100\) mL, and at \(300\) mm Hg it holds \(0.003 \times 300 = 0.9\) mL per \(100\) mL, an increment of \(0.6\) mL per \(100\) mL. Because hemoglobin was already almost fully loaded, the bound compartment contributes essentially nothing further. The fractional gain is therefore \(0.6/20 = 0.03\), about \(3\%\), which is why supplemental oxygen adds little content once saturation is already high. (Choice A) The calculation uses the increment in the dissolved compartment, \(0.9 - 0.3 = 0.6\) mL per \(100\) mL, divided by the original content of \(20\) mL per \(100\) mL. This yields roughly \(3\%\). It illustrates that the dissolved fraction is a small share of total blood oxygen even at supranormal partial pressures. (Choice B) This value results from dividing the total dissolved quantity after the change, \(0.9\) mL per \(100\) mL, by \(20\) mL per \(100\) mL. That treats oxygen already dissolved at baseline as newly added. The \(0.3\) mL per \(100\) mL present at \(100\) mm Hg was part of the original \(20\) mL per \(100\) mL and cannot be counted twice. (Choice C) A tenfold error in the solubility coefficient, using \(0.03\) rather than \(0.003\) mL per \(100\) mL per mm Hg, produces an increment of \(6\) mL per \(100\) mL and an apparent \(30\%\) rise. The stated coefficient is small precisely because oxygen is poorly soluble in aqueous plasma. Carrying the decimal correctly keeps the dissolved contribution in the range of tenths of a milliliter. (Choice D) This assumes content rises in proportion to partial pressure, so that tripling \(P_{\text{O}_2}\) triples content. Content is dominated by the hemoglobin bound pool, which is already near its ceiling at \(99\%\) saturation and cannot triple. Partial pressure governs only the small dissolved term. This is a Data-based and Statistical Reasoning question because you must combine a solubility coefficient with the hemoglobin bound quantity and express the dissolved portion as a percentage of the total.$q$,
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
  SELECT q.id, 'B', 'process_step_confusion', $q$total instead of increment$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'scale_unit_error', $q$decimal slip in the solubility coefficient$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$content proportional to partial pressure$q$ FROM q;

-- B4 Q11 . Circulatory Hypoxia With Normal Arterial Content . medium . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Circulatory Hypoxia With Normal Arterial Content$q$,
    $q$Three days after a large myocardial infarction, a patient has an arterial \(P_{\text{O}_2}\) of \(95\) mm Hg, a hemoglobin saturation of \(98\%\), and a hemoglobin concentration of \(15\) g/dL, yet his hands are cool and his blood lactate is climbing. How would the oxygen content of blood sampled from his pulmonary artery most likely compare with normal?$q$,
    $q$[{"label":"A","text":"Higher than normal, because arterial content is preserved while fewer tissues are perfused."},{"label":"B","text":"Higher than normal, because sluggish flow shortens the time available for oxygen to diffuse."},{"label":"C","text":"Unchanged, because arterial saturation and hemoglobin concentration are both normal."},{"label":"D","text":"Lower than normal, because blood lingers in tissues while oxygen demand persists."}]$q$::jsonb,
    'D',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because a failing pump moves less blood per minute, so each unit volume must surrender a larger share of its oxygen to cover an unchanged tissue requirement. Blood in the pulmonary artery is the pooled venous return from the whole body, so its oxygen content reflects what the tissues left behind. Arterial content here is normal, since saturation and hemoglobin concentration are both normal, which means the problem is the rate at which that content is delivered rather than the content itself. When flow falls, capillary transit time lengthens and tissues keep drawing on the oxygen that venous blood normally carries in reserve, widening the difference between arterial and venous content. The cool skin and rising lactate mark a circulatory rather than a respiratory cause of tissue hypoxia. (Choice A) Preserved arterial content sets the starting point for each pass, not the endpoint. Redistribution of flow away from skin and toward vital organs does not reduce whole-body oxygen use, so the pooled venous sample is more depleted, not less. Venous content rises only when tissues extract less than usual. (Choice B) Reduced flow lengthens rather than shortens the time a red cell spends in a capillary. More time in contact with an oxygen consuming tissue permits more unloading, not less. The direction of this reasoning is inverted. (Choice C) Normal saturation and hemoglobin concentration fix the arterial content but say nothing about how much of that content is removed on each circuit. Venous content is arterial content minus extraction, and extraction is exactly what changes when the pump fails. A normal arterial blood gas is therefore compatible with a markedly abnormal venous sample. (Choice D) With cardiac output depressed, the same whole-body oxygen requirement is met from fewer liters of blood per minute, so each liter gives up more oxygen. Venous blood normally retains a reserve of bound oxygen, and that reserve is drawn down under these conditions. The pooled sample from the pulmonary artery is correspondingly oxygen poor. This is a Reasoning about the Design and Execution of Research question because you must decide what sampling blood downstream of the tissues adds when every arterial measurement is already normal, and predict which way that value shifts.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    3,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$correct arterial premise, wrong venous conclusion$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', $q$transit time inverted$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$arterial values assumed to fix venous values$q$ FROM q;

-- B4 Q12 . Oxygen Delivery As Flow Times Content . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Oxygen Delivery As Flow Times Content$q$,
    $q$A woman with chronic anemia has an arterial oxygen content of \(10\) mL per \(100\) mL of blood and a resting cardiac output of \(9.0\) L/min. After transfusion her arterial oxygen content is \(18\) mL per \(100\) mL and her resting cardiac output settles at \(5.5\) L/min. How does her whole-body oxygen delivery after transfusion compare with the value before transfusion?$q$,
    $q$[{"label":"A","text":"It is about \\(40\\%\\) lower."},{"label":"B","text":"It is about \\(10\\%\\) lower."},{"label":"C","text":"It is about \\(80\\%\\) higher."},{"label":"D","text":"It is about \\(10\\%\\) higher."}]$q$::jsonb,
    'D',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because delivery is the product of flow and content, and the near doubling of content is largely offset by the fall in cardiac output from \(9.0\) to \(5.5\) L/min. Oxygen delivery equals cardiac output multiplied by arterial oxygen content, so both terms must be carried through the calculation. Before transfusion, \(9.0\) L/min equals \(90\) dL/min, and \(90 \times 10 = 900\) mL of oxygen per minute. After transfusion, \(5.5\) L/min equals \(55\) dL/min, and \(55 \times 18 = 990\) mL of oxygen per minute. The ratio \(990/900 = 1.10\) corresponds to a gain of roughly \(10\%\), which explains why a high resting cardiac output in chronic anemia is a compensation that is withdrawn once carrying capacity is restored. (Choice A) This tracks the fall in flow alone, since \(5.5/9.0\) is about \(0.61\). It ignores the fact that each unit volume now carries \(18\) rather than \(10\) mL of oxygen per \(100\) mL. Flow is only one of the two factors in the delivery product. (Choice B) The magnitude is right but the direction is inverted, as \(900/990\) is about \(0.91\). This arises from dividing the pre transfusion delivery by the post transfusion value rather than the reverse. Delivery rose from \(900\) to \(990\) mL/min, so the comparison must be expressed as an increase. (Choice C) This tracks content alone, since \(18/10 = 1.8\). Holding cardiac output constant would indeed raise delivery by \(80\%\), but the stem states that output fell substantially once the anemia was corrected. Both factors change here, and their product changes far less than either factor alone. (Choice D) Multiplying flow by content at each time point gives \(900\) mL/min before and \(990\) mL/min after, an increase of about one tenth. The transfusion nearly doubled the oxygen carried per unit volume, but the elevated output that had been sustaining delivery was no longer required. The net effect on delivery is therefore modest. This is a Data-based and Statistical Reasoning question because you must multiply flow by content at two separate time points and express the difference as a percentage rather than judging either factor on its own.$q$,
    'hard',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    4,
    115
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$one factor of the product only$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', $q$transposed ratio$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$content change only$q$ FROM q;

-- B4 Q13 . Regional Extraction Reserve . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Regional Extraction Reserve$q$,
    $q$During a catheterization study, systemic arterial blood contains \(20\) mL of oxygen per \(100\) mL, blood leaving the myocardium through the coronary sinus contains \(5\) mL per \(100\) mL, and blood from a resting forearm vein contains \(15\) mL per \(100\) mL. If blood flow to each tissue were held exactly constant, the largest possible percentage increase in oxygen uptake would be closest to which pair of values?$q$,
    $q$[{"label":"A","text":"\\(300\\%\\) for the myocardium and \\(33\\%\\) for the forearm"},{"label":"B","text":"\\(75\\%\\) for the myocardium and \\(25\\%\\) for the forearm"},{"label":"C","text":"\\(25\\%\\) for the myocardium and \\(75\\%\\) for the forearm"},{"label":"D","text":"\\(33\\%\\) for the myocardium and \\(300\\%\\) for the forearm"}]$q$::jsonb,
    'D',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because at fixed flow the ceiling on uptake is set by how much unextracted oxygen still remains in the venous effluent, and the coronary sinus sample has very little left. Uptake at constant flow is proportional to the difference between arterial and venous content, and the absolute maximum that difference could reach is the full arterial content of \(20\) mL per \(100\) mL. The myocardium already removes \(20 - 5 = 15\) mL per \(100\) mL, so its uptake could rise at most by a factor of \(20/15\), about \(1.33\), a gain near \(33\%\). The resting forearm removes only \(20 - 15 = 5\) mL per \(100\) mL, so its ceiling is \(20/5 = 4\), a gain of \(300\%\). A tissue that already extracts heavily at rest has almost no extraction reserve and must instead be supplied by raising its perfusion. (Choice A) The two figures are individually correct but assigned to the wrong tissues. The coronary sinus value of \(5\) mL per \(100\) mL signals near maximal extraction, which leaves the myocardium with the smaller reserve, while the forearm venous value of \(15\) mL per \(100\) mL signals a large untapped reserve. Matching each number to the correct sample reverses this pairing. (Choice B) These are the resting extraction ratios, \(15/20 = 75\%\) for the myocardium and \(5/20 = 25\%\) for the forearm. Both are computed correctly from the data, but an extraction ratio describes what a tissue is already doing, not how much further it could go. The remaining reserve is the complement of that ratio expressed relative to current uptake. (Choice C) This inverts the resting extraction ratios, assigning the low value to the myocardium and the high value to the forearm. The coronary sinus sample is the more oxygen depleted of the two, so the myocardium is the heavier extractor. The direction of the comparison is reversed. (Choice D) Working from the ceiling of complete extraction, the myocardium can raise uptake from a difference of \(15\) to at most \(20\) mL per \(100\) mL, roughly \(33\%\), whereas the forearm can go from \(5\) to \(20\) mL per \(100\) mL, a fourfold rise. These ceilings are theoretical, since hemoglobin rarely if ever surrenders all of its bound oxygen. The practical consequence is that increased myocardial work must be met chiefly by increased coronary flow. This is a Data-based and Statistical Reasoning question because you must convert two arteriovenous differences into extraction fractions and then into the proportional reserve each bed still has available.$q$,
    'hard',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    4,
    125
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'reversed_relationship', $q$correct values, transposed tissues$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$extraction ratio answering the wrong question$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', $q$inverted extraction ratios$q$ FROM q;

-- B4 Q14 . Widening Extraction At Peak Exercise . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Widening Extraction At Peak Exercise$q$,
    $q$At peak exercise a physically fit young man has a cardiac output of \(20\) L/min and a whole-body oxygen consumption of \(3200\) mL/min, compared with \(5\) L/min and \(250\) mL/min at rest. Arterial blood carries \(20\) mL of oxygen per \(100\) mL in both states. The oxygen content of the mixed venous blood in his pulmonary artery at peak exercise is closest to which value?$q$,
    $q$[{"label":"A","text":"\\(0\\) mL per \\(100\\) mL"},{"label":"B","text":"\\(4\\) mL per \\(100\\) mL"},{"label":"C","text":"\\(10\\) mL per \\(100\\) mL"},{"label":"D","text":"\\(15\\) mL per \\(100\\) mL"}]$q$::jsonb,
    'B',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because consumption equals flow multiplied by the arteriovenous content difference, and at \(200\) dL/min a consumption of \(3200\) mL/min requires a difference of \(16\) mL per \(100\) mL. Rearranging, the arteriovenous difference equals consumption divided by cardiac output expressed in the same volume units. At rest, \(250\) mL/min divided by \(50\) dL/min gives \(5\) mL per \(100\) mL, so mixed venous content is \(20 - 5 = 15\) mL per \(100\) mL. At peak effort, \(3200\) mL/min divided by \(200\) dL/min gives \(16\) mL per \(100\) mL, so mixed venous content falls to \(20 - 16 = 4\) mL per \(100\) mL. Cardiac output rose only fourfold while consumption rose roughly thirteenfold, and the shortfall is covered by drawing down the oxygen that venous blood normally carries in reserve. (Choice A) Complete extraction would require consumption to equal delivery, which at peak is \(20\) mL per \(100\) mL multiplied by \(200\) dL/min, or \(4000\) mL/min. The stated consumption of \(3200\) mL/min is below that, so oxygen still returns to the right heart. Hemoglobin rarely if ever surrenders all of its bound oxygen. (Choice B) Dividing \(3200\) mL/min by \(200\) dL/min yields an arteriovenous difference of \(16\) mL per \(100\) mL, leaving \(4\) mL per \(100\) mL in the venous return. Compared with the resting difference of \(5\) mL per \(100\) mL, extraction has more than tripled. This widening is what allows consumption to outpace the rise in flow. (Choice C) This corresponds to extracting exactly half the arterial content, a common default assumption. That difference of \(10\) mL per \(100\) mL across \(200\) dL/min would support a consumption of only \(2000\) mL/min, well short of the \(3200\) mL/min stated. The extraction fraction is not fixed and rises steeply with exercise intensity. (Choice D) This is the resting mixed venous content, correctly derived from the resting flow and consumption. Holding it constant would mean extraction per unit volume never changes, so a fourfold rise in output could support only a fourfold rise in consumption, to about \(1000\) mL/min. The stem states a much larger rise in consumption, which forces venous content down. This is a Data-based and Statistical Reasoning question because you must rearrange the relationship among consumption, flow, and content to solve for the oxygen still present in blood returning from the tissues.$q$,
    'hard',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    4,
    120
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$consumption equated with delivery$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$fixed one half extraction assumption$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$resting value carried into exercise$q$ FROM q;

-- B4 Q15 . Screening Donor Units Against A Recipient Antibody Profile . easy . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Screening Donor Units Against A Recipient Antibody Profile$q$,
    $q$A trauma patient needs erythrocytes urgently, and a rapid screen shows that the patient's plasma agglutinates reagent cells displaying A alone and reagent cells displaying D alone, but not reagent cells displaying B alone. The antigens present on the cells in the four available units are listed.

| Unit | A antigen | B antigen | D antigen |
| --- | --- | --- | --- |
| W | present | absent | present |
| X | absent | present | present |
| Y | absent | absent | present |
| Z | absent | present | absent |

Which unit is least likely to have its cells agglutinated in this patient?$q$,
    $q$[{"label":"A","text":"Unit W"},{"label":"B","text":"Unit X"},{"label":"C","text":"Unit Y"},{"label":"D","text":"Unit Z"}]$q$::jsonb,
    'D',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because the cells in unit Z display neither of the two antigens this patient's plasma reacts against, so the circulating antibodies have nothing on them to bind. Agglutination follows when antibody in the recipient plasma attaches to an antigen on a donated erythrocyte and ties neighboring cells into clumps, so a unit is acceptable only when it lacks every antigen the recipient holds antibody against. The screen identifies two such antibodies, one directed at A and one directed at D, while the absence of a reaction against B cells shows that no anti-B is circulating. A unit may therefore carry B without consequence, whereas any unit carrying A or D will be attacked. Screening the four rows against those two criteria leaves exactly one acceptable unit. (Choice A) The cells in unit W carry both of the antigens the screen flagged. A positive screening reaction marks an antigen as a hazard rather than as a match, so these cells present the largest number of targets on the shelf, not the fewest. Anti-A and anti-D in the patient's plasma would both find a target here. (Choice B) The cells in unit X lack A, which removes the antigen responsible for the strongest preformed reaction, and the B antigen they carry is harmless because the screen against B cells was negative. They also carry D, however, and this patient's plasma reacted against D. Avoiding one of the two flagged antigens is not sufficient. (Choice C) Cells lacking both A and B are widely assumed to be acceptable for any recipient, and as far as the ABO antigens go these are. They carry D, and the screen shows this patient holds antibody against D, so these cells would be agglutinated. Rh status has to be screened alongside the ABO antigens rather than after them. (Choice D) The cells in unit Z lack A and lack D, the two antigens against which this patient holds antibody, and the B antigen they do carry meets no antibody because the screen against B cells was negative. Nothing in the patient's plasma can attach to these cells, so no clumping is expected. This is the one unit on the shelf that satisfies both criteria. This is a Scientific Reasoning and Problem Solving question because you must translate a pattern of agglutination reactions into the set of antigens the patient cannot safely receive and screen each donor profile against it.$q$,
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
  SELECT q.id, 'A', 'reversed_relationship', $q$a positive screening reaction read as evidence of compatibility$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$one flagged antigen avoided read as compatibility achieved$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$cells lacking A and B assumed acceptable for every recipient$q$ FROM q;

-- B4 Q16 . Sensitization Timing After Rh Exposure . medium . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Sensitization Timing After Rh Exposure$q$,
    $q$An Rh-negative man who has never been transfused receives one unit of Rh-positive packed red cells in week \(0\), and those cells survive with a normal lifespan. His plasma is then tested at intervals against reagent Rh-positive erythrocytes, with the results shown.

| Week | Agglutination of reagent Rh-positive cells |
| --- | --- |
| \(0\), before transfusion | none |
| \(1\) | none |
| \(6\) | strong |
| \(20\) | strong |

Which outcome is most likely if he receives a second unit of Rh-positive cells in week \(24\)?$q$,
    $q$[{"label":"A","text":"The transfused cells survive with a normal lifespan, as the first unit did"},{"label":"B","text":"His own erythrocytes are agglutinated while the transfused cells survive"},{"label":"C","text":"Destruction of the transfused cells begins several weeks after the infusion"},{"label":"D","text":"Destruction of the transfused cells begins immediately after the infusion"}]$q$::jsonb,
    'D',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because his plasma already holds anti-D by week \(20\), so a second unit of Rh-positive cells meets circulating antibody the moment it enters his vessels. Antibody against the D antigen behaves differently from anti-A and anti-B, which are present without any transfusion history; anti-D appears only after an Rh-negative person is exposed to Rh-positive cells. The table records exactly that sequence, with no reactivity before the first unit or one week after it, then strong reactivity by week \(6\) that persists at week \(20\). The first unit survived because the antibody had not yet been made, and the interval between week \(1\) and week \(6\) is the time that production took. A repeat exposure at week \(24\) is therefore a different situation, because the antibody no longer has to be generated before it can act. (Choice A) This restates what happened after the first unit, when no anti-D was present. The week \(6\) and week \(20\) results show that his plasma has changed since then, so the earlier outcome is not expected to repeat. Survival of Rh-positive cells depends on the absence of anti-D, and that condition no longer holds. (Choice B) Anti-D attaches only to cells that display the D antigen, and his own erythrocytes lack it. His antibody therefore has no target on his own cells however high its concentration climbs. The infused cells, not his own, are the ones carrying the antigen in question. (Choice C) A delay of several weeks is the interval needed to generate antibody after a first exposure, which is what the gap between week \(1\) and week \(6\) records. Antibody that is already circulating binds its antigen without any such waiting period. The delay belongs to antibody production, not to antibody action. (Choice D) Strong reactivity at weeks \(6\) and \(20\) shows that anti-D is in his plasma before the second unit is given. The antibody attaches to D on the newly infused cells as they enter the circulation, links them into clumps, and leads to their breakdown. No interval is needed for antibody to appear, so destruction starts at once. This is a Reasoning about the Design and Execution of Research question because you must judge which claim a serial antibody time course cannot support given that the first exposure produced no early cell destruction.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$first exposure outcome assumed to repeat$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', $q$antibody turned against the host's own cells$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$production lag mistaken for action lag$q$ FROM q;

-- B4 Q17 . Vessel Obstruction During A Mismatched Transfusion . medium . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Vessel Obstruction During A Mismatched Transfusion$q$,
    $q$Thirty minutes into a transfusion, a patient's plasma free hemoglobin has risen from \(3\ \text{mg/dL}\) to \(190\ \text{mg/dL}\), and the hematocrit is \(28\%\) against the \(29\%\) recorded before the \(300\ \text{mL}\) unit was started. Oxygen delivery measured in several organs is now well below its pre-transfusion value. Which consequence of the incompatibility most directly accounts for this decline?$q$,
    $q$[{"label":"A","text":"Free hemoglobin released from destroyed erythrocytes exceeds the rate at which the kidneys clear it"},{"label":"B","text":"Expansion of blood volume by the infused fluid dilutes the recipient's own erythrocytes"},{"label":"C","text":"Clumped erythrocytes lodge in and obstruct the small vessels supplying the tissues"},{"label":"D","text":"Destruction of the transfused erythrocytes leaves oxygen-carrying capacity at its pre-transfusion value"}]$q$::jsonb,
    'C',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because antibody links erythrocytes into aggregates that physically plug small vessels and cut perfusion to the tissue beyond them. Each antibody molecule has more than one binding site, so it can attach to antigens on separate cells and tie them together. The resulting clumps are far larger than a single deformable red cell and become stuck where vessel diameter is smallest, so the patient's own oxygenated erythrocytes can no longer reach tissue downstream. That mechanical blockage is what drives delivery below the starting point, since destruction of the donated cells alone could at worst leave delivery where it began. The failure of the hematocrit to rise after \(300\ \text{mL}\) of erythrocytes, together with the sharp rise in free hemoglobin, indicates that the donated cells were broken down rather than retained. (Choice A) A free hemoglobin load that outstrips renal clearance is a genuine consequence of this reaction and is the route to kidney injury. Hemoglobin arriving at the kidney does not, however, interfere with perfusion of other organs. This choice names a real downstream problem that cannot account for a systemic drop in delivery. (Choice B) Volume expansion does lower the concentration of circulating erythrocytes when it occurs. The hematocrit has moved by a single point, from \(29\%\) to \(28\%\), a change far too small to drive delivery well below baseline in several organs. Dilution is measurable here and is not remotely large enough to be the operating mechanism. (Choice C) Aggregates of linked erythrocytes obstruct small vessels throughout the body and deprive the tissues past them of oxygen and nutrients. Because those plugs stop the patient's own circulating erythrocytes as well as the donated ones, delivery falls below the pre-transfusion level rather than merely failing to rise. This is the only listed mechanism that produces a net loss relative to baseline. (Choice D) The infused cells were indeed broken down, which is why the hematocrit did not rise despite \(300\ \text{mL}\) of red cells. That accounts for the absence of any improvement in oxygen-carrying capacity, but staying at the starting value is not the same as dropping below it. This choice explains the flat hematocrit and stops short of explaining the observed deficit. This is a Reasoning about the Design and Execution of Research question because you must identify which measurement in the panel points to a second consequence that the rise in free hemoglobin alone cannot account for.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    3,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'adjacent_fact', $q$real downstream complication offered as the cause$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'scale_unit_error', $q$a real mechanism invoked at the wrong order of magnitude$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$explains the flat hematocrit but not the deficit$q$ FROM q;

-- B4 Q18 . Donor Plasma Antibody Load In Whole Blood . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Donor Plasma Antibody Load In Whole Blood$q$,
    $q$A recipient whose erythrocytes carry both the A and the B antigen, and whose plasma volume is \(3.0\ \text{L}\), receives one unit of whole blood from a donor whose erythrocytes carry neither antigen. The unit delivers \(250\ \text{mL}\) of donor plasma along with the donor erythrocytes. Which outcome is most likely in the hours after the infusion?$q$,
    $q$[{"label":"A","text":"Rapid agglutination and breakdown of the transfused erythrocytes"},{"label":"B","text":"Extensive breakdown of the recipient's own erythrocytes"},{"label":"C","text":"No agglutination of erythrocytes of either origin"},{"label":"D","text":"Limited breakdown of the recipient's own erythrocytes"}]$q$::jsonb,
    'D',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because the donor plasma carries anti-A and anti-B, which do find targets on the recipient's cells, but \(250\ \text{mL}\) of that plasma is diluted about \(13\)-fold on entering \(3.0\ \text{L}\) of recipient plasma. Compatibility has to be assessed in both directions whenever a unit carries plasma as well as cells. The donated erythrocytes display neither A nor B, and a person whose own cells display both antigens forms antibody against neither, so the donated cells themselves are not attacked. The plasma runs the other way: a donor whose cells lack both antigens carries both anti-A and anti-B, and the recipient's cells present both of those targets. Adding \(250\ \text{mL}\) to \(3.0\ \text{L}\) gives \(3250\ \text{mL}\) in total, leaving the infused antibody at roughly \(7.7\%\) of its donor concentration, and that fixed quantity is consumed as it binds rather than being replenished. (Choice A) The donated erythrocytes display neither A nor B, and the recipient forms antibody against neither antigen because both appear on their own cells. Nothing in the recipient plasma can attach to the donated cells, so they are not the population at risk. This choice assigns the reaction to the wrong side of the pairing. (Choice B) Antibody in the donor plasma does act on the recipient's own erythrocytes, so the target population is correctly identified here. The quantity is not: the infused antibody sits at roughly one thirteenth of its donor concentration and is not replenished, so it is consumed well before most of the recipient's cells have been bound. A reaction limited by antibody supply cannot clear an entire erythrocyte population. (Choice C) This would be the outcome if the donor plasma were removed and the cells resuspended before transfusion. Whole blood carries that plasma with it, and the anti-A and anti-B it contains do find targets on the recipient's cells. Some breakdown of the recipient's own erythrocytes therefore does occur. (Choice D) Anti-A and anti-B in the donor plasma bind the recipient's erythrocytes, which display both antigens, while the small infused volume caps how much binding can occur. Diluting \(250\ \text{mL}\) into \(3250\ \text{mL}\) leaves that antibody at about \(7.7\%\) of its starting concentration. The resulting breakdown is real but modest, which is why plasma-containing units of this kind are usually tolerated. This is a Data-based and Statistical Reasoning question because you must check compatibility in both directions and then use the infused donor plasma volume against the recipient plasma volume to gauge how large the reaction can be.$q$,
    'hard',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    4,
    115
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'reversed_relationship', $q$attack aimed at the donated cells instead of the host cells$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$right target cells, wrong magnitude$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$cells lacking A and B assumed to make the whole unit inert$q$ FROM q;

-- B4 Q19 . Carotid Sinus Compression . easy . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Carotid Sinus Compression$q$,
    $q$A clinician presses firmly on the neck of a supine volunteer directly over one carotid sinus, deforming and stretching the sinus wall. Mean arterial pressure drops from \(94\) to \(79\) mm Hg within \(10\) seconds. Which combination of changes most likely produced the measured decrease?$q$,
    $q$[{"label":"A","text":"Cardiac output rises and total peripheral resistance rises"},{"label":"B","text":"Cardiac output falls and total peripheral resistance falls"},{"label":"C","text":"Cardiac output rises and total peripheral resistance falls"},{"label":"D","text":"Cardiac output falls and total peripheral resistance rises"}]$q$::jsonb,
    'B',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because stretching the sinus wall makes the medullary centers behave as though arterial pressure were too high, and their corrective output lowers both the volume the heart delivers per minute and the tone of the resistance vessels. Arterial pressure is set jointly by how much blood the heart ejects per minute and how strongly the arterioles oppose its exit, so a controller that pushed those two terms in opposite directions would be working against itself. Stretch receptors in the sinus wall report wall deformation rather than luminal pressure as such, which is why external compression fools them into firing faster. The cardiovascular centers answer that faster afferent traffic by slowing the heart and weakening its contraction while at the same time releasing arteriolar tone. The recorded decrease of \(15\) mm Hg therefore represents a smaller minute output arriving in a wider, less resistant vascular bed. (Choice A) This pairing is the response appropriate to a sensed pressure that is too low, not too high. Raising both minute output and vessel tone would drive arterial pressure upward, whereas the volunteer's pressure was measured to decrease. It reverses the direction of the entire loop. (Choice B) Both effector limbs move in the same direction here, which is exactly how the loop corrects an apparently elevated pressure. Reduced output arriving in a dilated bed lowers pressure faster than either change alone. This matches the measured decrease. (Choice C) The vascular half of this pairing is correct, since releasing arteriolar tone does lower resistance and pressure. The cardiac half is not, because a rise in output would partly offset the vasodilation rather than reinforce it. A controller that drove its two effectors in opposing directions would blunt its own correction. (Choice D) The cardiac half of this pairing is correct, since the heart does slow and eject less. The vascular half describes constriction, which would raise resistance and oppose the observed pressure decrease. This reflects the common assumption that vessels always tighten to defend perfusion, when in fact the reflex releases arteriolar tone whenever sensed pressure is excessive. This is a Scientific Reasoning and Problem Solving question because you must trace an artificially applied stretch signal through the reflex arc to its simultaneous effects on both the heart and the vessels.$q$,
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
  SELECT q.id, 'A', 'reversed_relationship', $q$Loop run backwards$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$One effector limb correct$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$Vessels always constrict to defend perfusion$q$ FROM q;

-- B4 Q20 . Bidirectional Reflex Gain . medium . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Bidirectional Reflex Gain$q$,
    $q$In a resting volunteer (heart rate \(68\) beats per minute, mean arterial pressure \(93\) mm Hg), an infusion that raises mean arterial pressure by \(10\) mm Hg slows the heart by \(8\) beats per minute. The volunteer then stands, and mean arterial pressure transiently falls to \(78\) mm Hg, with reflex sensitivity unchanged across this range. Which heart rate is most likely recorded at that moment?$q$,
    $q$[{"label":"A","text":"\\(56\\) beats per minute"},{"label":"B","text":"\\(68\\) beats per minute"},{"label":"C","text":"\\(80\\) beats per minute"},{"label":"D","text":"\\(84\\) beats per minute"}]$q$::jsonb,
    'C',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because the loop operates in both directions, so a \(15\) mm Hg fall speeds the heart by \(1.5 \times 8 = 12\) beats per minute above the resting value of \(68\). The infusion establishes the sensitivity of the loop: \(8\) beats per minute of heart rate change for every \(10\) mm Hg of pressure change. Standing moves pressure the other way, from \(93\) to \(78\) mm Hg, a fall of \(15\) mm Hg, which is \(1.5\) of those \(10\) mm Hg units. Because the receptors are stretched less at the lower pressure, they fire less, and the correction runs opposite to the correction seen during the infusion. The predicted rate is therefore \(68 + 12 = 80\) beats per minute. (Choice A) This value applies the measured slope in the same direction as the infusion, subtracting \(12\) beats per minute from \(68\). Slowing the heart when pressure has already fallen would drive pressure lower still, which is the opposite of a corrective response. The sign of the correction must flip when the sensed pressure moves the other way. (Choice B) Leaving heart rate untouched assumes that a falling pressure is corrected by vessel tone alone. In fact the cardiovascular centers adjust the heart and the resistance vessels together, and the heart rate limb is the faster of the two. An unchanged rate is also inconsistent with the sensitivity the infusion just demonstrated. (Choice C) A \(15\) mm Hg fall is \(1.5\) units of \(10\) mm Hg, so the heart speeds by \(1.5 \times 8 = 12\) beats per minute. Added to the resting \(68\), this predicts \(80\) beats per minute. This is the value consistent with a symmetric, linear loop. (Choice D) This value rounds the \(15\) mm Hg fall up to two complete \(10\) mm Hg steps and adds \(16\) beats per minute. The stem specifies that sensitivity is unchanged across the range, so the response scales continuously rather than in whole steps. Fractional pressure changes produce fractional rate changes. This is a Reasoning about the Design and Execution of Research question because you must extract a reflex gain from a controlled pressure challenge and apply that same gain when pressure moves the opposite way.$q$,
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
  SELECT q.id, 'A', 'reversed_relationship', $q$Sign of the correction not flipped$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$Pressure defended by vessels only$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'scale_unit_error', $q$Quantized rather than proportional scaling$q$ FROM q;

-- B4 Q21 . Head-Up Tilt And Resistance Adjustment . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Head-Up Tilt And Resistance Adjustment$q$,
    $q$Over the first minute of \(70^\circ\) head-up tilt, a volunteer's stroke volume falls from \(75\) to \(50\) mL, heart rate rises from \(64\) to \(80\) beats per minute, and mean arterial pressure holds steady at \(92\) mm Hg. Mean arterial pressure equals the product of cardiac output and total peripheral resistance. How must total peripheral resistance have changed over that minute?$q$,
    $q$[{"label":"A","text":"It falls by about \\(17\\%\\)"},{"label":"B","text":"It is essentially unchanged"},{"label":"C","text":"It rises by about \\(17\\%\\)"},{"label":"D","text":"It rises by about \\(20\\%\\)"}]$q$::jsonb,
    'D',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because cardiac output fell from \(4.80\) to \(4.00\) L/min, and holding pressure constant requires resistance to rise by the reciprocal of that ratio, \(4.80 / 4.00 = 1.20\). Supine output is \(75 \text{ mL} \times 64 \text{ min}^{-1} = 4800\) mL/min, and upright output is \(50 \text{ mL} \times 80 \text{ min}^{-1} = 4000\) mL/min, so the faster heart recovers only part of the stroke volume lost to venous pooling in the legs. Since pressure is the product of output and resistance, and pressure did not move, the resistance term must have grown by exactly the factor by which output shrank. That factor is \(4800 / 4000 = 1.20\), a rise of \(20\%\). This is why the reflex constricts arterioles as well as speeding the heart: the cardiac limb alone leaves a deficit that only the vascular limb can close. (Choice A) A falling resistance would compound the falling output, and pressure would drop rather than hold at \(92\) mm Hg. This treats resistance as following cardiac output rather than opposing its decline. The direction of the vascular limb is inverted. (Choice B) An unchanged resistance would leave pressure proportional to output, and pressure would have fallen by roughly one sixth. The numbers show output did fall, so the faster heart rate by itself cannot account for the stable pressure. Some vascular adjustment is mathematically required. (Choice C) This value is the fractional fall in cardiac output, \(800 / 4800 = 16.7\%\), applied directly as the fractional rise needed in resistance. Restoring a product requires multiplying by the reciprocal, not by one plus the same fraction. Raising resistance by \(17\%\) would leave pressure about \(3\%\) below its supine value. (Choice D) The output ratio is \(4800 / 4000 = 1.20\), so resistance must rise by \(20\%\) for the product to be preserved. This is larger than the fractional fall in output because the two quantities are reciprocals, not complements. It is the only value consistent with an unchanged pressure of \(92\) mm Hg. This is a Data-based and Statistical Reasoning question because you must combine the measured changes in stroke volume and heart rate into a new flow and solve for the resistance change that holds pressure constant.$q$,
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
  SELECT q.id, 'A', 'reversed_relationship', $q$Resistance tracks output instead of opposing it$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$Heart rate alone defends pressure$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'scale_unit_error', $q$Complement used where the reciprocal is required$q$ FROM q;

-- B4 Q22 . Cutting The Afferent Limb . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Cutting The Afferent Limb$q$,
    $q$In an anesthetized animal, only the sensory nerves leaving the carotid and aortic sinuses are cut. The animal is then monitored alongside an unoperated control for several hours. Which of the following outcomes are most likely in the operated animal?

I. Systemic arterioles lose vasomotor tone and dilate maximally
II. Beat-to-beat variability in arterial pressure increases sharply
III. A moderate hemorrhage lowers arterial pressure more than it does in the control$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"II only"},{"label":"C","text":"II and III only"},{"label":"D","text":"I and III only"}]$q$::jsonb,
    'C',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is C because removing the sensor removes the correction, not the standing outflow that sets vessel tone, so pressure becomes unstable and poorly defended against a volume challenge while arterioles retain their tone. The medullary centers discharge tonically at rest, and arterioles are held partly constricted by that background outflow together with local mechanisms in the vessel wall; cutting the incoming sensory nerves leaves every one of those outflow pathways physically intact. What is lost is the moment-to-moment error signal, so ordinary perturbations such as posture change, respiration and movement are no longer buffered and pressure swings widely, which is item II. It is also the loss of that error signal that disables the compensatory response to bleeding, since the fall in sensed pressure is normally what recruits a faster, harder-working heart and constricted vessels, which is item III. Item I confuses the loss of a corrective input with the loss of the effector pathway itself. (Choice A) Selecting item I alone treats the sensory input as the origin of all arteriolar tone and predicts a low but stable pressure. Arterioles are partly constricted at rest by ongoing outflow and by local wall mechanisms that the operation never touched. This choice also denies the reflex its two demonstrable roles, buffering ordinary pressure disturbances and mounting the compensatory response to blood loss. (Choice B) Item II is correctly accepted, since the absence of an error signal leaves ordinary perturbations uncorrected and pressure swings widely. Item III is wrongly rejected: the response to bleeding is normally recruited by a fall in sensed pressure, and an animal that cannot register that fall tolerates the same volume loss poorly. Recognizing the buffering deficit without recognizing the compensatory deficit captures only half of what the afferent cut removes. (Choice C) Items II and III both follow from the loss of the error signal while the effector limbs remain functional. Pressure becomes labile because nothing corrects ordinary disturbances, and a hemorrhage is poorly tolerated because nothing recruits the compensatory response. Item I is excluded because tonic outflow and local wall mechanisms preserve arteriolar tone. (Choice D) Item III is correctly accepted, since the compensatory response to bleeding depends on a pressure signal this animal can no longer register. Item I is not, because only the incoming sensory nerves were cut and the outflow that holds arterioles partly constricted is untouched. The appeal of this pairing lies in assuming that an animal which cannot defend its pressure must therefore have lost vessel tone entirely, when an inability to correct pressure is not the same as an inability to maintain resting tone. This is a Data-based and Statistical Reasoning question because you must evaluate several proposed outcomes of removing the sensory limb and keep only those consistent with losing moment to moment pressure buffering.$q$,
    'hard',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    4,
    115
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$Sensor treated as the source of vessel tone$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$Buffering deficit recognized, compensatory deficit missed$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$Correct hemorrhage prediction over-extended to total loss of tone$q$ FROM q;

-- B4 Q23 . Locating The Break In The Loop . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Locating The Break In The Loop$q$,
    $q$A patient becomes lightheaded \(15\) seconds after standing, and mean arterial pressure falls from \(94\) to \(62\) mm Hg. The fall could arise either from a depleted circulating volume acting on an intact reflex or from a reflex whose output no longer reaches its effectors. Which additional bedside measurement best separates these two possibilities?$q$,
    $q$[{"label":"A","text":"The change in heart rate between supine and standing"},{"label":"B","text":"The change in pulse pressure between supine and standing"},{"label":"C","text":"The mean arterial pressure fall recorded on a repeat standing trial"},{"label":"D","text":"The mean arterial pressure reached after \\(5\\) minutes of continued standing"}]$q$::jsonb,
    'A',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is A because an intact loop working on an underfilled circulation drives a large rise in rate, whereas a loop whose output cannot reach the effectors leaves rate nearly flat despite the same pressure signal. A useful discriminating test must produce different readings under the two candidate mechanisms, and pressure itself cannot do that job because both candidates were defined by producing the same pressure fall. The rate response is the fastest and most visible output of the loop, so its presence or absence localizes the break: a marked tachycardia proves that the sensor, the integrator and the pathway to the heart are all working and that the problem lies upstream in the volume being circulated. A rate that barely moves while pressure drops by \(32\) mm Hg indicates that the signal is being generated but not delivered. This is why clinicians read the rate change and the pressure change together rather than the pressure alone. (Choice A) Rate is the quickest output of the loop, so its behaviour reports directly on whether the loop reaches its effectors. A steep rise localizes the fault to circulating volume, while a nearly unchanged rate localizes it to the delivery of the reflex output. Only this measurement is predicted to differ between the two candidates. (Choice B) Pulse pressure does narrow when stroke volume falls, so this measurement is genuinely abnormal here. It fails as a discriminator because stroke volume falls in both candidates, from a small filling volume in the first and from unopposed venous pooling in the second. A finding shared by both possibilities cannot separate them, however real it is. (Choice C) Repeating the provocation tests whether the finding is reproducible, and it will be, because both candidates produce a pressure fall on every attempt. Confirming that an abnormality is genuine is a different task from locating where the loop is broken. The second trial returns the same shared finding as the first. (Choice D) Prolonged standing does not distinguish them, because pressure remains low in both cases: neither an underfilled circulation nor an undelivered reflex output resolves with time. Waiting merely confirms that the pressure fall is sustained. It adds duration rather than discrimination. This is a Data-based and Statistical Reasoning question because you must determine which single bedside measurement separates two candidate explanations that produce the identical fall in pressure.$q$,
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
  SELECT q.id, 'B', 'partial_truth', $q$Correct inference with no discriminating power$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$Confirmation mistaken for discrimination$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$Duration mistaken for discrimination$q$ FROM q;

-- B4 Q24 . Leukocyte Exit From The Microcirculation . medium . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Leukocyte Exit From The Microcirculation$q$,
    $q$An investigator perfuses an isolated venule with a fixed, recirculating volume of blood and then applies an agent that irreversibly cross-links the junctional proteins binding adjacent endothelial cells to one another, leaving the endothelial cells themselves structurally intact. In untreated control vessels, roughly \(200\) leukocytes per microscopic field accumulate in the surrounding tissue over \(60\) minutes. Relative to the controls, the treated preparation most likely shows:$q$,
    $q$[{"label":"A","text":"an increase in tissue leukocytes and a decrease in leukocytes within the lumen"},{"label":"B","text":"a decrease in tissue leukocytes and an increase in leukocytes within the lumen"},{"label":"C","text":"a decrease in tissue leukocytes and no change in leukocytes within the lumen"},{"label":"D","text":"no change in tissue leukocytes and no change in leukocytes within the lumen"}]$q$::jsonb,
    'B',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is B because leukocytes leave a vessel by squeezing between neighboring endothelial cells, so locking those cells to one another closes the exit route and strands the leukocytes inside a closed perfusion loop. Venules and capillaries are the principal sites at which circulating leukocytes adhere to the endothelial lining and then push between adjacent cells to reach the tissue fluid. The agent leaves the endothelial cells themselves intact and does not alter perfusion, so the only variable changed is the passability of the space between neighboring cells. With that space sealed, the roughly \(200\) cells per field that would otherwise have crossed each hour never leave the vessel. Because the perfusate is a fixed volume that recirculates rather than being continuously replenished, cells that are no longer withdrawn into the tissue remain in that volume, so the luminal count climbs above the control value. (Choice A) Binding adjacent endothelial cells more tightly to one another narrows rather than widens the space between them, so tissue accumulation should fall rather than rise. A rise in tissue counts paired with a fall in luminal counts is the pattern expected from an agent that loosened those attachments. This choice therefore predicts the result of the opposite manipulation. (Choice B) is correct. Sealing the space between adjacent endothelial cells removes the route leukocytes use to reach the tissue, so tissue accumulation drops well below the control value of about \(200\) cells per field. Those cells stay in the fixed recirculating volume instead of being withdrawn from it, so the luminal leukocyte count rises above that of the controls. (Choice C) The tissue half of this prediction is sound, since sealing the space between neighboring endothelial cells does reduce the number of leukocytes reaching the surrounding tissue. The luminal half is not, because the preparation is perfused with a fixed volume that recirculates. Leukocytes that are no longer lost to the tissue stay in that volume, so their concentration rises rather than holding steady. (Choice D) This outcome would require leukocytes to cross the wall by some route other than the space between neighboring endothelial cells, such as passage through the endothelial cell bodies themselves. The route described for venules and capillaries is adhesion to the endothelial lining followed by passage between adjacent cells, and the treatment targets that passage while sparing the cells. Sealing it therefore alters both compartments rather than leaving them unchanged. This is a Reasoning about the Design and Execution of Research question because you must predict how blocking one step in a closed recirculating preparation redistributes cells between the two compartments being counted.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    3,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'reversed_relationship', $q$direction flip on an experimental manipulation$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$half right two compartment prediction that ignores mass balance$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$wrong anatomical route for crossing the vessel wall$q$ FROM q;

-- B4 Q25 . Granulocyte Fraction Of A Differential Count . medium . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Cardiovascular System',
    $q$Granulocyte Fraction Of A Differential Count$q$,
    $q$A hematology analyzer reports a total leukocyte concentration of \(8{,}000\) cells per \(\mu L\), with a differential of \(62.5\%\) neutrophils, \(28\%\) lymphocytes, \(6\%\) monocytes, \(3\%\) eosinophils, and \(0.5\%\) basophils. A reviewing hematologist records the absolute concentration of the leukocytes whose cytoplasm contains abundant, highly visible granules. That recorded value is closest to:$q$,
    $q$[{"label":"A","text":"\\(280\\) cells per \\(\\mu L\\)"},{"label":"B","text":"\\(2{,}720\\) cells per \\(\\mu L\\)"},{"label":"C","text":"\\(5{,}000\\) cells per \\(\\mu L\\)"},{"label":"D","text":"\\(5{,}280\\) cells per \\(\\mu L\\)"}]$q$::jsonb,
    'D',
    $q$This is a Biology question that falls under the content category 'Organ Systems.' The answer is D because neutrophils, eosinophils, and basophils together make up \(66\%\) of this differential, and \(0.66 \times 8{,}000 = 5{,}280\) cells per \(\mu L\). Stained blood smears divide leukocytes into two morphological classes according to whether the cytoplasm holds abundant, highly visible granules. The granular class comprises neutrophils, eosinophils, and basophils, while the agranular class comprises lymphocytes and monocytes. Summing the granular lineages here gives \(62.5\% + 3\% + 0.5\% = 66\%\), and applying that fraction to the reported total yields \(5{,}280\) cells per \(\mu L\). The reported total also falls within the usual range of \(5{,}000\) to \(10{,}000\) leukocytes per \(\mu L\), so no correction to the total is warranted. (Choice A) This value is \(3.5\%\) of the total, the combined eosinophil and basophil share, and so counts only the two least numerous granular lineages. It excludes neutrophils, whose granules are numerous but fine and are best revealed by chemically neutral stains rather than acidic or basic ones. Faint staining does not make those granules absent, so neutrophils belong in the sum. (Choice B) This value is \(34\%\) of the total, which is the combined lymphocyte and monocyte share. Those two cell types constitute the class with smaller, less visible granules and nuclei that lack distinct lobes. Reporting them answers the opposite half of the morphological division. (Choice C) This value is \(62.5\%\) of the total, the neutrophil share alone, and it reflects the common shorthand of treating the granular class as though neutrophils were its only member. Neutrophils are indeed the most abundant granular type in a normal differential, but eosinophils and basophils carry conspicuous granules as well. Omitting their combined \(3.5\%\) understates the requested concentration by \(280\) cells per \(\mu L\). (Choice D) is correct. Adding the three granular lineages gives \(62.5\% + 3\% + 0.5\% = 66\%\) of the reported leukocytes. Multiplying \(8{,}000\) cells per \(\mu L\) by \(0.66\) yields \(5{,}280\) cells per \(\mu L\). The remaining \(34\%\), or \(2{,}720\) cells per \(\mu L\), belongs to the agranular class. This is a Reasoning about the Design and Execution of Research question because you must decide which of the reported cell categories belong in the requested group before converting percentages into an absolute concentration.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    3,
    85
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$stain name misread as absence of the feature$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', $q$complement of the requested class$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$most abundant member substituted for the whole class$q$ FROM q;

COMMIT;

-- Verification: after all four batches, expect 100 questions and 300 distractor rows.
SELECT
  (SELECT COUNT(*) FROM public.questions WHERE topic = 'The Cardiovascular System') AS questions,
  (SELECT COUNT(*) FROM public.question_distractor_metadata m
     JOIN public.questions x ON x.id = m.question_id
   WHERE x.topic = 'The Cardiovascular System') AS distractor_rows;
