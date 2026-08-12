-- Biochemistry Chapter 9: Carbohydrate Metabolism I, standalone questions
-- BATCH 1 of 2 (21 questions): the hexokinase/glucokinase lane . the PFK-1/PFK-2 control node .
--   the payoff phase and energy accounting (incl. the Rapoport-Luebering bookkeeping item) .
--   pyruvate fates with the carved GAPDH-stall key . the fructose and galactose feeder arms
--   (GLUT5, fructokinase, aldolase B, the below-PFK-1 regulatory jewel, galactokinase, GALT,
--   the UDP-glucose catalytic cycle).
--
-- CHAPTER SIZE: 45 questions in two batches (21 + 24), per the Step 1 pre-flight — the FINAL
-- biochemistry chapter. The recorded Ch4 grant delivers the unclaimed pathway interior; the live
-- Ch10/11/12 arc (~270 questions) forecloses PDH entirely (zero Ch9 keys), the Cori cycle, bare
-- lactate-regenerates-NAD+ purpose keys, hormonal state logic (the thumb-litmus line), GLUT1/2/4
-- keys (GLUT5 is the one open transporter), and ATP totals beyond net-2. See
-- biochemistry_ch9_carbmet1_questions.plan.md for the audit trail and the drafter contract.
--
-- !! BATCH 1 OWNS THE CHAPTER DELETE !! Batch 2 is pure INSERTs and runs after this file.

BEGIN;

DELETE FROM public.questions WHERE topic = 'Carbohydrate Metabolism I';

-- Q1 . Hexokinase glucokinase saturation profiles . hard . skill 4 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$Hexokinase glucokinase saturation profiles$q$,
    $q$A biochemist measures glucose phosphorylation by two human enzymes across a range of glucose concentrations. Enzyme 1 has a Km of 0.05 mM for glucose and operates above 95 percent of its maximal rate at 4 mM glucose, with essentially no further increase when glucose is raised to 10 mM. Enzyme 2 has a Km of 8 mM for glucose, runs at about one third of its maximal rate at 4 mM glucose, and rises to more than half of its maximal rate as glucose is raised from 4 mM to 10 mM. Fasting blood glucose is about 4 to 5 mM, and blood glucose can approach 10 mM after a carbohydrate-rich meal. Which assignment of physiological roles is best supported by these data?$q$,
    $q$[{"label":"A","text":"Enzyme 2 is suited to tissues such as the brain that require a constant rate of glucose phosphorylation, because its rate does not change between the fasting and fed states."},{"label":"B","text":"Enzyme 1 is better suited to disposing of a postprandial glucose load, because its lower Km allows it to bind glucose more effectively when glucose is abundant."},{"label":"C","text":"Enzyme 2 contributes negligibly to glucose phosphorylation during fasting, because its Km is above fasting glucose concentrations."},{"label":"D","text":"Enzyme 1 suits tissues that must phosphorylate glucose steadily at any physiological glucose level, while Enzyme 2 suits a hepatic role in which phosphorylation rises with blood glucose after a meal."}]$q$::jsonb,
    'D',
    $q$This Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway question tests the ability to match the kinetic profiles of the two glucose-phosphorylating enzymes to their physiological roles. The answer is D because the data show that Enzyme 1 is already saturated at fasting glucose while Enzyme 2 responds across the physiological range. An enzyme with a Km of 0.05 mM faces a fasting glucose concentration roughly eighty times its Km, so it runs at its ceiling at all times; raising glucose to 10 mM cannot increase its rate, which is exactly what the data show. This is the profile of hexokinase, the isoform found in tissues such as brain and muscle that need a steady, guaranteed supply of phosphorylated glucose regardless of the fed or fasted state. Enzyme 2, with a Km of 8 mM, sits on the steep part of its curve between 4 and 10 mM, so its rate climbs from about one third to more than half of maximal across the fasting to postprandial transition. That is the profile of glucokinase, which lets the liver increase glucose phosphorylation precisely when glucose is abundant and throttle it back when glucose falls. (Choice A) reverses the assignment: Enzyme 2 is the responsive enzyme, its rate climbing from about one third to more than half of maximal across the fed transition, so it cannot supply the constant rate that tissues like the brain require. (Choice B) misreads affinity as capacity. Enzyme 1's low Km means it is already near its maximal rate at fasting glucose, so it has no headroom to increase phosphorylation during a postprandial rise; tight binding at low concentrations does not translate into responsiveness at high concentrations. (Choice C) overstates the data: at 4 mM glucose Enzyme 2 still runs at about one third of its maximal rate, a substantial rather than negligible contribution, and role assignment rests on responsiveness across the physiological range, not on whether glucose exceeds Km. This is a Data-based and Statistical Reasoning question because it requires converting rate versus glucose concentration data for two enzymes into a supported conclusion about which tissue role each saturation profile can serve.$q$,
    'hard',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    4,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$affinity equals throughput$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', NULL FROM q;

-- Q2 . Glucokinase tissue restriction consequences . medium . skill 2 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$Glucokinase tissue restriction consequences$q$,
    $q$Glucokinase is expressed only in hepatocytes and pancreatic beta cells, and insulin acts on hepatocytes to increase synthesis of glucokinase protein. An investigational drug selectively and completely inactivates glucokinase without affecting any other kinase. Which outcome is most likely in the tissues of a treated patient?$q$,
    $q$[{"label":"A","text":"Skeletal muscle and brain continue phosphorylating glucose at near-normal rates, because those tissues depend on hexokinase rather than glucokinase."},{"label":"B","text":"Skeletal muscle stops phosphorylating glucose, because insulin can no longer induce glucokinase in muscle fibers."},{"label":"C","text":"Hepatocytes fully preserve their capacity to phosphorylate a large postprandial glucose load, because their basal hexokinase activity substitutes for glucokinase."},{"label":"D","text":"Pancreatic beta cells restore their glucose phosphorylation by increasing glucokinase synthesis in response to insulin."}]$q$::jsonb,
    'A',
    $q$This Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway question tests the consequences of glucokinase's restricted tissue distribution. The answer is A because glucokinase's absence from tissues outside the liver and pancreatic beta cells means that a glucokinase-specific drug leaves most of the body's glucose phosphorylation untouched. Skeletal muscle, brain, and nearly all other tissues phosphorylate glucose with hexokinase, a distinct isoform the drug does not affect, so their glycolytic entry step proceeds at near-normal rates. The brain in particular depends on continuous glucose phosphorylation, and its hexokinase, saturated even at fasting glucose concentrations, maintains that supply without interruption. The insulin effect described in the stem is an induction of enzyme synthesis, a change in the amount of glucokinase protein rather than a covalent or allosteric modification, and it occurs in the liver. The burden of losing glucokinase therefore falls selectively on the two cell types that express it: hepatocytes lose their ability to ramp up glucose phosphorylation when glucose is plentiful, and beta cells lose part of the machinery that ties their metabolism to glucose availability. (Choice B) fails on the stem's own premise: skeletal muscle never expresses glucokinase, so there is no muscle glucokinase for insulin to induce and no dependence to lose; muscle phosphorylation runs on hexokinase. (Choice C) is a partial truth. Hepatocytes do contain some hexokinase, but it is a low-capacity enzyme that is already saturated at fasting glucose, so it cannot expand its rate to absorb a large postprandial glucose load the way glucokinase can. (Choice D) misplaces the induction step: insulin increases glucokinase synthesis in hepatocytes, not in beta cells, and even where induction occurs, synthesizing more protein cannot restore flux when the drug completely inactivates every glucokinase molecule produced. This is a Scientific Reasoning and Problem Solving question because it asks the examinee to predict which tissues are spared or harmed by a targeted enzyme loss using the isoform distribution of glucose phosphorylation.$q$,
    'medium',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    2,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', NULL FROM q;

-- Q3 . Glucose 6-phosphate product inhibition contrast . medium . skill 2 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$Glucose 6-phosphate product inhibition contrast$q$,
    $q$In a cell culture experiment, an inhibitor of phosphoglucose isomerase causes glucose 6-phosphate to accumulate in both skeletal muscle myotubes and hepatocytes. Both cell types are then supplied with abundant extracellular glucose, and the rate at which each phosphorylates newly imported glucose is measured. Which result is expected?$q$,
    $q$[{"label":"A","text":"Phosphorylation slows sharply in both cell types, because accumulated glucose 6-phosphate inhibits every glucose-phosphorylating enzyme."},{"label":"B","text":"Phosphorylation persists in the myotubes but slows sharply in the hepatocytes, because glucokinase is the isoform subject to feedback by its product."},{"label":"C","text":"Phosphorylation slows sharply in the myotubes but persists in the hepatocytes, because hexokinase is inhibited by glucose 6-phosphate while glucokinase is not."},{"label":"D","text":"Phosphorylation continues unchanged in both cell types, because glucose 6-phosphate is diverted into glycogen synthesis and the pentose phosphate pathway before it can accumulate."}]$q$::jsonb,
    'C',
    $q$This Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway question tests the product-inhibition contrast between hexokinase and glucokinase. The answer is C because the two isoforms respond oppositely to accumulated glucose 6-phosphate. Hexokinase, the isoform in skeletal muscle, is inhibited by its own product, so when the isomerase block backs up glucose 6-phosphate the myotubes' entry step shuts down and newly imported glucose is no longer phosphorylated at an appreciable rate. Glucokinase escapes this feedback, so hepatocytes keep phosphorylating incoming glucose even while glucose 6-phosphate is plentiful. This regulatory freedom is an intrinsic property of the glucokinase protein itself, not a consequence of the hepatocyte environment, so it persists in cultured cells. The contrast fits each tissue's job: muscle phosphorylates glucose only as fast as its own downstream demand consumes the product, whereas the liver must keep pulling in and phosphorylating glucose when the sugar is abundant so the product can be routed toward storage and other pathways. (Choice A) overgeneralizes the feedback: inhibition by glucose 6-phosphate is a property of hexokinase, not of every glucose-phosphorylating enzyme, and glucokinase's escape from that feedback is precisely what distinguishes the liver. (Choice B) inverts the isoforms; it is hexokinase, not glucokinase, that is subject to product feedback, so the persistence belongs to the hepatocytes rather than the myotubes. (Choice D) contradicts the premise while containing a true fragment: glycogen synthesis and the pentose phosphate pathway do consume glucose 6-phosphate, but the stem states that the metabolite has already accumulated in both cell types, so diversion has failed and the feedback difference between the isoforms determines the outcome. This is a Scientific Reasoning and Problem Solving question because it requires predicting how the same metabolite buildup produces divergent outcomes in two tissues from the regulatory difference between the two phosphorylating isoforms.$q$,
    'medium',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    2,
    85
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', NULL FROM q;

-- Q4 . Irreversible glycolytic steps requiring bypass . easy . skill 1 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$Irreversible glycolytic steps requiring bypass$q$,
    $q$Under cellular conditions, most glycolytic reactions operate close to equilibrium and can be reversed directly during gluconeogenesis, but a few are so exergonic that the liver must route around them using separate bypass reactions. Which of the following glycolytic enzymes catalyze steps that gluconeogenesis must bypass rather than simply reverse?

I. Hexokinase
II. Phosphofructokinase-1
III. Phosphoglycerate kinase$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"I and II only"},{"label":"C","text":"II and III only"},{"label":"D","text":"I, II, and III"}]$q$::jsonb,
    'B',
    $q$This Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway question tests recognition of the irreversible steps of glycolysis that gluconeogenesis must bypass. The answer is B because hexokinase (item I) and phosphofructokinase-1 (item II) catalyze two of glycolysis's three physiologically irreversible reactions, while phosphoglycerate kinase (item III) catalyzes a reversible step. The three reactions with large negative free energy changes in the cell are those of hexokinase (glucokinase in liver), phosphofructokinase-1, and pyruvate kinase; these define exactly where glucose synthesis cannot simply run glycolysis backward and must instead use separate bypass reactions. Because these steps release so much free energy in the forward direction, their reverse reactions are inaccessible under cellular conditions, which is why gluconeogenesis is not merely glycolysis run in reverse. Phosphoglycerate kinase, despite its kinase name, operates near equilibrium, and during gluconeogenesis it runs in the reverse direction as part of the shared central stretch of the pathway, illustrating that near-equilibrium steps are common to both pathways. (Choice A) is incomplete: hexokinase is indeed bypassed, but phosphofructokinase-1 also catalyzes an irreversible committed step, so item I alone understates the set. (Choice C) swaps a reversible kinase for an irreversible one: phosphoglycerate kinase's ATP-producing reaction is freely reversible and needs no bypass, so including item III in place of the true third member, pyruvate kinase, confuses two similarly named steps. (Choice D) assumes that every kinase-catalyzed step is irreversible; ATP involvement does not by itself make a reaction irreversible, and phosphoglycerate kinase is the standard counterexample. This is a Knowledge of Scientific Concepts and Principles question because it asks the examinee to recall which specific glycolytic reactions are irreversible and therefore require dedicated bypasses in gluconeogenesis.$q$,
    'easy',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    1,
    65
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', NULL FROM q;

-- Q5 . Citrate feedback inhibition of PFK-1 . medium . skill 2 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$Citrate feedback inhibition of PFK-1$q$,
    $q$Hepatocytes are treated with an inhibitor of the citric acid cycle enzyme aconitase, and cytosolic citrate rises several-fold while ATP concentration remains essentially unchanged. Over the next hour, glycolytic flux in these cells falls sharply. Which event most directly links the mitochondrial blockade to the reduced flux?$q$,
    $q$[{"label":"A","text":"Competitive displacement of fructose 6-phosphate from the phosphofructokinase-1 catalytic site"},{"label":"B","text":"Depletion of the cytosolic ADP pool that serves as the phosphate acceptor in the pyruvate kinase reaction"},{"label":"C","text":"Allosteric inhibition of phosphofructokinase-1 by the accumulating intermediate, signaling that downstream oxidative capacity is already fully supplied"},{"label":"D","text":"Feedback inhibition of hexokinase by a rising glucose 6-phosphate concentration"}]$q$::jsonb,
    'C',
    $q$This question falls under Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway and tests feedback inhibition of phosphofructokinase-1 by citrate. The answer is C because citrate is an allosteric inhibitor of phosphofructokinase-1, the rate-limiting enzyme that catalyzes the committed step of glycolysis. When aconitase is blocked, citrate cannot proceed through the citric acid cycle, so it accumulates in the mitochondrion and is exported to the cytosol. A rising cytosolic citrate concentration reports that the oxidative machinery downstream of glycolysis is already fully supplied with carbon, so committing additional glucose into the pathway would accomplish nothing useful. Citrate therefore binds an allosteric site on phosphofructokinase-1 and slows flux at the pathway's control point even though ATP, the other major inhibitory signal, has not changed. This design lets one enzyme integrate information about downstream capacity in addition to the cell's immediate energy state. (Choice A) Citrate does not compete with fructose 6-phosphate for the catalytic site. It acts at a spatially separate allosteric site, so its inhibition cannot be relieved simply by raising substrate concentration the way competitive inhibition would be. (Choice B) In the pyruvate kinase reaction, ADP accepts a phosphate from phosphoenolpyruvate, but a citric acid cycle blockade with unchanged ATP provides no mechanism for depleting cytosolic ADP, and ADP scarcity is not what shuts down flux here. (Choice D) Hexokinase inhibition by glucose 6-phosphate does occur, but it is a downstream consequence rather than the direct link: only after phosphofructokinase-1 slows do fructose 6-phosphate and then glucose 6-phosphate back up and restrain hexokinase. The event that most directly connects the mitochondrial blockade to reduced flux is citrate acting on phosphofructokinase-1. This is a Scientific Reasoning and Problem Solving question because it requires tracing how a citric acid cycle blockade propagates backward through an exported metabolite signal to the allosteric control point of glycolysis.$q$,
    'medium',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    2,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', NULL FROM q;

-- Q6 . AMP as amplified low energy signal . hard . skill 2 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$AMP as amplified low energy signal$q$,
    $q$During sustained muscle activity, total ATP concentration falls by only about ten percent, yet flux through phosphofructokinase-1 rises many-fold. ATP is maintained at millimolar levels, whereas resting AMP is orders of magnitude lower. Which property of the adenine nucleotide system explains why AMP, rather than the modest decline in ATP itself, functions as the sensitive activating signal for this enzyme?$q$,
    $q$[{"label":"A","text":"Near-equilibrium adenylate kinase activity converts small fractional losses of ATP into proportionally much larger fractional increases in AMP, amplifying the signal read by the allosteric activating site"},{"label":"B","text":"AMP competes directly with ATP for the catalytic site, so any AMP present blocks the inhibitory nucleotide from binding"},{"label":"C","text":"Deamination of AMP to IMP prolongs the activating signal after energy demand has ended"},{"label":"D","text":"ATP binds its regulatory site so weakly that a ten percent fall in total ATP empties the site and fully relieves inhibition"}]$q$::jsonb,
    'A',
    $q$This question falls under Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway and tests why AMP serves as the sensitive low-energy activator of phosphofructokinase-1. The answer is A because the adenylate kinase reaction, which interconverts two ADP molecules with one ATP and one AMP, runs near equilibrium in most cells. Because ATP is held at millimolar levels while resting AMP is far scarcer, the equilibrium expression forces the AMP concentration to track roughly with the square of the ADP concentration divided by the ATP concentration. When energy consumption nudges ATP down and ADP up by modest amounts, this relationship multiplies those small fractional changes into a very large fractional rise in AMP. The allosteric activating site on phosphofructokinase-1 therefore reads AMP as an amplified, high-gain gauge of energy charge, allowing glycolytic flux to respond dramatically long before the ATP pool itself has fallen enough to register at any binding site. A signal built on the scarce nucleotide is simply more sensitive than one built on the abundant, buffered nucleotide. (Choice B) AMP does not act by competing at the catalytic site. It binds a distinct allosteric activating site, and the inhibitory action of ATP likewise occurs at its own regulatory site rather than through a contest that AMP could win by direct competition. (Choice C) Deamination of AMP to IMP removes AMP from the pool and therefore terminates, rather than prolongs, the activating signal; this reaction runs the signal in the opposite direction from what the choice claims. (Choice D) ATP does bind a low-affinity regulatory site, but the concentration remains millimolar after a ten percent fall, so occupancy of both the catalytic site and the regulatory site changes very little; the decline in ATP itself is therefore an insensitive signal, not one that empties the site. This is a Scientific Reasoning and Problem Solving question because it requires reasoning quantitatively from a near-equilibrium reaction and relative nucleotide pool sizes to explain why one nucleotide's concentration change is amplified into the dominant regulatory signal.$q$,
    'hard',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    2,
    95
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', NULL FROM q;

-- Q7 . Potent allosteric override of ATP inhibition . hard . skill 2 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$Potent allosteric override of ATP inhibition$q$,
    $q$Purified liver phosphofructokinase-1 assayed at a high, inhibitory ATP concentration shows low activity. Adding a micromolar quantity of a phosphorylated fructose metabolite, produced in the intact hepatocyte by a separate regulatory enzyme, restores near-maximal activity even though the ATP concentration is unchanged. Which molecule produces this rescue, and by what mechanism?$q$,
    $q$[{"label":"A","text":"Fructose 1,6-bisphosphate, which feeds forward to stimulate the enzyme that produced it"},{"label":"B","text":"Fructose 6-phosphate, which raises the reaction velocity by mass action at the catalytic site"},{"label":"C","text":"Fructose 2,6-bisphosphate, which displaces ATP from the catalytic site so that substrate can bind"},{"label":"D","text":"Fructose 2,6-bisphosphate, which binds an allosteric site and increases the enzyme's affinity for fructose 6-phosphate, functionally overriding the inhibition set by abundant ATP"}]$q$::jsonb,
    'D',
    $q$This question falls under Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway and tests fructose 2,6-bisphosphate as the most potent activator of phosphofructokinase-1. The answer is D because fructose 2,6-bisphosphate, generated in hepatocytes by the kinase activity of PFK-2, binds an allosteric site on phosphofructokinase-1 and sharply increases the enzyme's affinity for its substrate fructose 6-phosphate. This activation is powerful enough at micromolar concentrations to overcome the inhibited conformational state imposed by abundant ATP, which is why activity returns even though the inhibitory nucleotide concentration never changes. Functionally, this lets a signal of plentiful fuel override the energy brake: a liver cell with high ATP can still push glucose through glycolysis whenever this regulator is elevated. Its potency at trace concentrations, together with the persistence of ATP inhibition in its absence, marks it as the dominant input at this control point. (Choice A) Fructose 1,6-bisphosphate is the product of the phosphofructokinase-1 reaction, and its feed-forward stimulation acts on pyruvate kinase later in the pathway, not back on the enzyme that produced it. (Choice B) Fructose 6-phosphate is the substrate itself; raising its concentration increases velocity only within the limits set by the inhibited enzyme and would require far more than micromolar amounts, so mass action at the catalytic site cannot explain near-maximal rescue at a fixed inhibitory ATP concentration. (Choice C) This choice names the correct metabolite but the wrong mechanism. Fructose 2,6-bisphosphate does not evict ATP from the catalytic site; ATP continues to bind there and serve as the phosphate donor for the reaction. The activator instead works through a separate allosteric site that shifts the enzyme toward its high-affinity state. This is a Scientific Reasoning and Problem Solving question because it requires inferring both the identity of an unnamed regulator and its site of action from the behavior of an inhibited enzyme in a reconstituted assay.$q$,
    'hard',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    2,
    90
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'process_step_confusion', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', NULL FROM q;

-- Q8 . Bifunctional PFK-2 kinase phosphatase domains . easy . skill 1 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$Bifunctional PFK-2 kinase phosphatase domains$q$,
    $q$In liver cells, fructose 2,6-bisphosphate is both synthesized and degraded by PFK-2, and the two activities reside on the same polypeptide chain. How does this single protein catalyze the two opposing reactions?$q$,
    $q$[{"label":"A","text":"It catalyzes one reversible reaction whose direction is set entirely by the mass action of substrate and product"},{"label":"B","text":"It contains two distinct catalytic domains, a kinase that phosphorylates carbon 2 of fructose 6-phosphate and a phosphatase that hydrolyzes that same phosphate"},{"label":"C","text":"Its kinase activity phosphorylates carbon 1 of fructose 6-phosphate, and the same active site later removes that group"},{"label":"D","text":"A covalent modification interconverts a single active site between a phosphorylating mode and a hydrolyzing mode"}]$q$::jsonb,
    'B',
    $q$This question falls under Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway and tests the bifunctional architecture of PFK-2. The answer is B because the PFK-2 polypeptide carries two separate catalytic domains that perform two different chemistries. One domain is a kinase that transfers a phosphate from ATP to carbon 2 of fructose 6-phosphate, creating fructose 2,6-bisphosphate; the other domain is a phosphatase that hydrolyzes that carbon 2 phosphate, regenerating fructose 6-phosphate. Because synthesis and degradation are handled by physically distinct active sites on one protein, the cell can tune the concentration of this powerful glycolytic regulator in either direction using a single gene product, and whichever domain is more active at a given moment sets the net level of the regulator. This arrangement places both the on switch and the off switch for a key PFK-1 activator inside one enzyme. (Choice A) The two activities are not one reversible reaction pushed back and forth by mass action. The kinase reaction consumes ATP, while the phosphatase reaction is a hydrolysis that releases inorganic phosphate; running the kinase backward would require regenerating ATP, which the phosphatase reaction does not do. (Choice C) Phosphorylation of carbon 1 of fructose 6-phosphate is the reaction of phosphofructokinase-1, which produces the glycolytic intermediate fructose 1,6-bisphosphate. PFK-2 acts at carbon 2, and its product is a purely regulatory molecule rather than a pathway intermediate. (Choice D) Covalent modification of PFK-2 does shift the balance between its two activities, but it does so by favoring one domain over the other, not by converting a single active site between a phosphorylating mode and a hydrolyzing mode; both catalytic sites exist on the protein at all times. This is a Knowledge of Scientific Concepts and Principles question because it asks for the recalled structural fact that PFK-2 carries distinct kinase and phosphatase domains on one polypeptide chain.$q$,
    'easy',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    1,
    60
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', NULL FROM q;

-- Q9 . Site of NAD+ reduction in glycolysis . easy . skill 1 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$Site of NAD+ reduction in glycolysis$q$,
    $q$A membrane-permeable NAD+ analog fluoresces only after it accepts electrons and is converted to its reduced form. A researcher adds the analog to hepatocytes that are actively converting glucose to pyruvate and monitors the cells for fluorescence. Conversion of which substrate to which product generates the fluorescent signal?$q$,
    $q$[{"label":"A","text":"Fructose 1,6-bisphosphate to dihydroxyacetone phosphate and glyceraldehyde 3-phosphate"},{"label":"B","text":"Glyceraldehyde 3-phosphate to 1,3-bisphosphoglycerate"},{"label":"C","text":"Phosphoenolpyruvate to pyruvate"},{"label":"D","text":"Pyruvate to lactate"}]$q$::jsonb,
    'B',
    $q$This question falls under Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway and tests recognition of the single reaction in glycolysis where redox chemistry occurs, the step that reduces NAD+ to NADH. The answer is B because glyceraldehyde 3-phosphate dehydrogenase catalyzes the only glycolytic reaction that changes the oxidation state of a carbon skeleton. The aldehyde carbon of glyceraldehyde 3-phosphate is oxidized while inorganic phosphate is incorporated into the product, yielding the acyl phosphate 1,3-bisphosphoglycerate, and the electrons stripped from the sugar are captured by NAD+ to form NADH. An analog of NAD+ that fluoresces only in its reduced form will therefore light up at this conversion and at no other point in the pathway, because every other glycolytic step isomerizes, cleaves, dehydrates, phosphorylates, or dephosphorylates an intermediate without moving electrons onto a cofactor. Since the six carbon stage of the pathway is split into two triose phosphates upstream of this reaction, the oxidation occurs twice per glucose, which is why glycolysis yields exactly two NADH per glucose. (Choice A) The cleavage of fructose 1,6-bisphosphate into dihydroxyacetone phosphate and glyceraldehyde 3-phosphate is a carbon carbon bond scission catalyzed by aldolase. No electrons are transferred and no cofactor participates, so this step cannot generate the reduced, fluorescent form of the analog. (Choice C) Conversion of phosphoenolpyruvate to pyruvate transfers a phosphoryl group to ADP and produces ATP. It is an energy harvesting step, but its currency is phosphoryl transfer, not electron transfer, so it leaves the analog oxidized and dark. (Choice D) Reduction of pyruvate to lactate runs redox chemistry in the opposite direction from the credited step: it consumes NADH and regenerates NAD+. This reaction would extinguish an existing fluorescent signal by reoxidizing the analog rather than create one. This is a Knowledge of Scientific Concepts and Principles question because it asks you to identify the one glycolytic reaction that carries the pathway's oxidation chemistry and reduces NAD+ to NADH.$q$,
    'easy',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    1,
    70
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'process_step_confusion', $q$wrong pathway step, no redox$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$true energy step, wrong currency$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$redox direction inverted$q$ FROM q;

-- Q10 . Phosphoglycerate kinase ATP synthesis mechanism . easy . skill 2 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$Phosphoglycerate kinase ATP synthesis mechanism$q$,
    $q$A biochemist combines purified phosphoglycerate kinase with 1,3-bisphosphoglycerate, ADP, and magnesium in a simple buffered solution containing no membranes, no vesicles, and no dissolved oxygen. ATP accumulates rapidly in the mixture. Which mechanism accounts for this ATP synthesis?$q$,
    $q$[{"label":"A","text":"A proton gradient formed across a lipid bilayer drives condensation of ADP with inorganic phosphate"},{"label":"B","text":"The enzyme first produces GTP, which nucleoside diphosphate kinase then converts to ATP"},{"label":"C","text":"A phosphoryl group is transferred directly from a high-energy donor molecule to ADP"},{"label":"D","text":"Oxidation of an aldehyde group coupled to NAD+ reduction supplies the energy for phosphorylation"}]$q$::jsonb,
    'C',
    $q$This question falls under Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway and tests the mechanism class by which phosphoglycerate kinase makes ATP, namely substrate level phosphorylation. The answer is C because 1,3-bisphosphoglycerate carries an acyl phosphate whose transfer potential exceeds that of ATP, and phosphoglycerate kinase simply hands that phosphoryl group directly to ADP, producing ATP and 3-phosphoglycerate. Because the energy resides in the substrate itself, the reaction needs only the enzyme, the donor, ADP, and magnesium; no membrane, proton gradient, electron carrier, or oxygen is required, which is exactly why the reconstituted system in the stem produces ATP in a plain buffer. This mechanism, substrate level phosphorylation, is one of two such steps in glycolysis and is the reason the pathway can supply ATP under fully anaerobic conditions. The identical mechanism operates again at the pyruvate kinase step, where phosphoenolpyruvate serves as the high energy donor, which is why glycolysis makes all of its ATP without any membrane bound machinery. (Choice A) Chemiosmotic ATP synthesis requires an intact membrane across which a proton gradient can be maintained and an ATP synthase to dissipate it. The stem specifies that no membranes or vesicles are present, so no gradient can exist in this system. (Choice B) Formation of GTP followed by conversion to ATP through nucleoside diphosphate kinase describes the substrate level phosphorylation carried out by succinyl CoA synthetase in the citric acid cycle, not the reaction catalyzed by phosphoglycerate kinase, which phosphorylates ADP directly. (Choice D) Oxidation of an aldehyde coupled to reduction of NAD+ describes the immediately preceding glycolytic step, the one that creates 1,3-bisphosphoglycerate in the first place. That chemistry cannot be operating here because the mixture contains no NAD+ and the high energy donor was supplied preformed. This is a Scientific Reasoning and Problem Solving question because it requires using the stated absence of membranes and oxygen to deduce which ATP forming mechanism remains possible in the reconstituted system.$q$,
    'easy',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    2,
    70
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$oxidative phosphorylation reflex$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', $q$borrowed from TCA cycle$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$neighboring step's chemistry$q$ FROM q;

-- Q11 . Feed-forward activation of pyruvate kinase . medium . skill 2 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$Feed-forward activation of pyruvate kinase$q$,
    $q$Pyruvate kinase activity is assayed in vitro at a fixed, subsaturating concentration of phosphoenolpyruvate. Adding fructose 1,6-bisphosphate to the assay increases the reaction rate severalfold, even though no additional substrate forms under these conditions. In an intact cell, what advantage does this regulatory behavior provide?$q$,
    $q$[{"label":"A","text":"An intermediate made by an early committed step signals the final enzyme to speed up, so material entering the pathway is carried through to completion"},{"label":"B","text":"Fructose 1,6-bisphosphate is converted through later steps into extra phosphoenolpyruvate, raising the rate by increasing substrate supply"},{"label":"C","text":"Fructose 1,6-bisphosphate covalently attaches a phosphate to pyruvate kinase, locking the enzyme in its active conformation"},{"label":"D","text":"It allows the end product of the pathway to suppress the enzymes that begin it, preventing wasteful entry of glucose"}]$q$::jsonb,
    'A',
    $q$This question falls under Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway and tests the logic of feed forward activation of pyruvate kinase by fructose 1,6-bisphosphate. The answer is A because fructose 1,6-bisphosphate is generated by phosphofructokinase 1, the step that commits glucose to completing glycolysis. When flux through that committed step rises, fructose 1,6-bisphosphate accumulates and binds pyruvate kinase allosterically, shifting the enzyme toward its active conformation and increasing its rate at an unchanged phosphoenolpyruvate concentration, exactly as the assay shows. The advantage is coordination in the forward direction: a signal from early in the pathway tells the terminal enzyme that material is on its way, so downstream capacity expands to match upstream commitment and intermediates do not pile up between the two ends of the pathway. Without this signal, a surge of glucose committed by the early steps could outpace the terminal reaction and leave phosphorylated intermediates stranded in the middle of the pathway. (Choice B) In a cell, fructose 1,6-bisphosphate is indeed converted through later steps into phosphoenolpyruvate, but the assay held substrate fixed and stated that no additional substrate forms, so the observed rate increase must come from allosteric activation rather than from increased substrate supply. (Choice C) Covalent attachment of phosphate to pyruvate kinase is a real regulatory mechanism, but it is performed by a protein kinase using ATP, not by fructose 1,6-bisphosphate, and phosphorylation of pyruvate kinase lowers rather than raises its activity. Fructose 1,6-bisphosphate binds reversibly at an allosteric site. (Choice D) An end product suppressing the enzymes that begin a pathway describes feedback inhibition, which runs in the opposite direction from the mechanism observed here: the activating signal originates upstream and acts downstream, not the reverse. This is a Scientific Reasoning and Problem Solving question because it requires interpreting an allosteric assay result and reasoning out why an upstream intermediate activating the final enzyme benefits pathway coordination.$q$,
    'medium',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    2,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'partial_truth', $q$true fact, wrong mechanism for this observation$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$covalent vs allosteric swap$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$feedback for feed-forward$q$ FROM q;

-- Q12 . Net glycolytic ATP and NADH yield . medium . skill 4 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$Net glycolytic ATP and NADH yield$q$,
    $q$A mitochondria-free cytosolic extract is supplied with glucose, ADP, inorganic phosphate, and NAD+ in the absence of oxygen. Product levels are measured after the extract converts each glucose molecule to two molecules of pyruvate. Which of the statements below are supported by the pathway's stoichiometry?

I. Two ATP are consumed before the six-carbon skeleton is cleaved
II. Four ATP are produced by direct phosphoryl transfer to ADP
III. The extract gains a net two ATP and two NADH per glucose consumed$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"I and II only"},{"label":"C","text":"II and III only"},{"label":"D","text":"I, II, and III"}]$q$::jsonb,
    'D',
    $q$This question falls under Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway and tests the energy accounting of glycolysis from glucose to pyruvate. The answer is D because all three statements follow from the pathway's stoichiometry. Statement I is supported: hexokinase and phosphofructokinase 1 each consume one ATP during the investment phase, and both phosphorylations occur before aldolase cleaves the six carbon skeleton into two triose phosphates. Statement II is supported: each of the two triose phosphates passes through two phosphoryl transfer steps, one catalyzed by phosphoglycerate kinase and one by pyruvate kinase, so four ATP are formed per glucose by direct transfer of phosphoryl groups to ADP. Statement III is the arithmetic consequence of I and II combined with the oxidation step: four ATP made minus two invested leaves a net gain of two ATP, and the single oxidation reaction, running once per triose phosphate, reduces two NAD+ to two NADH per glucose. None of this chemistry requires oxygen or mitochondria, so the anaerobic, cytosolic extract completes the full accounting, and the net figure of two ATP and two NADH represents the complete yield of the pathway itself through pyruvate. (Choice A) Accepting only statement I ignores the payoff phase entirely; the two phosphoryl transfer steps demonstrably generate four ATP per glucose in this system. (Choice B) Rejecting statement III usually reflects the belief that NADH can only form when oxygen is available to accept its electrons; in fact NAD+ reduction happens within glycolysis itself, and the net figures of two ATP and two NADH follow directly from the gross figures in statements I and II. (Choice C) Rejecting statement I denies the investment phase; the pathway cannot cleave fructose 1,6-bisphosphate without first spending two ATP to build it, so the priming cost is real and must be counted. This is a Data-based and Statistical Reasoning question because it requires reconciling gross and net product figures from the measured stoichiometry of a reconstituted pathway.$q$,
    'medium',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    4,
    90
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$stops at the investment phase$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$NADH-needs-oxygen belief$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$forgets the investment phase$q$ FROM q;

-- Q13 . ATP cost of the bisphosphoglycerate detour . hard . skill 4 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$ATP cost of the bisphosphoglycerate detour$q$,
    $q$In red blood cells, a mutase converts part of the 1,3-bisphosphoglycerate formed during glycolysis to 2,3-bisphosphoglycerate, which is subsequently hydrolyzed to 3-phosphoglycerate and reenters the pathway. Suppose 100 glucose molecules complete glycolysis in such a cell, and 20 percent of all 1,3-bisphosphoglycerate molecules formed are routed through this detour. What is the net ATP yield from these 100 glucose molecules?$q$,
    $q$[{"label":"A","text":"120 ATP"},{"label":"B","text":"200 ATP"},{"label":"C","text":"160 ATP"},{"label":"D","text":"180 ATP"}]$q$::jsonb,
    'C',
    $q$This question falls under Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway and tests the ATP bookkeeping of the 2,3-bisphosphoglycerate detour in red blood cells. The answer is C because the detour bypasses exactly one ATP producing step per molecule diverted, so the problem reduces to counting the skipped phosphoglycerate kinase payments and subtracting them from the undisturbed net. Work through the accounting: 100 glucose molecules are each split into two triose phosphates, generating 200 molecules of 1,3-bisphosphoglycerate. With no detour, each of the 200 would earn one ATP at the phosphoglycerate kinase step and one ATP at the pyruvate kinase step, for 400 gross ATP; subtracting the 200 ATP invested in priming the 100 glucose molecules leaves a normal net of 200 ATP. Here 20 percent of the 1,3-bisphosphoglycerate, 40 molecules, is converted to 2,3-bisphosphoglycerate and then hydrolyzed to 3-phosphoglycerate, rejoining the pathway below phosphoglycerate kinase. Each diverted molecule therefore skips that ATP payment but still earns the pyruvate kinase ATP downstream, so the loss is 40 ATP and the net yield is 200 minus 40, or 160 ATP. (Choice A) A yield of 120 assumes each diverted molecule forfeits both of the pathway's phosphoryl transfer payments. The detour reenters the pathway at 3-phosphoglycerate, upstream of pyruvate kinase, so the second ATP is still collected. (Choice B) A yield of 200 assumes that because the detour rejoins glycolysis, nothing is lost. Carbon is conserved, but the phosphate that phosphoglycerate kinase would have transferred to ADP is instead released as inorganic phosphate during hydrolysis, so one ATP per diverted molecule is genuinely forgone. (Choice D) A yield of 180 subtracts only 20 ATP, which comes from applying the 20 percent to the 100 glucose molecules instead of to the 200 triose phosphate molecules that actually flow past the branch point. This is a Data-based and Statistical Reasoning question because it requires computing a net ATP total from per triose stoichiometry and a stated diversion percentage.$q$,
    'hard',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    4,
    110
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'process_step_confusion', $q$bypasses both SLP steps$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$detour is free$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'scale_unit_error', $q$per-glucose vs per-triose slip$q$ FROM q;

-- Q14 . Glycolytic stall without NAD regeneration . hard . skill 4 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$Glycolytic stall without NAD regeneration$q$,
    $q$Cultured myocytes are made severely hypoxic while lactate dehydrogenase is pharmacologically inhibited, leaving the cells no route to reoxidize cytosolic NADH. Within minutes, glycolytic ATP production collapses. Metabolite profiling shows that fructose 1,6-bisphosphate and dihydroxyacetone phosphate each rise more than fivefold, while 3-phosphoglycerate, phosphoenolpyruvate, and pyruvate all fall sharply. At which reaction has glycolytic flux most likely stopped?$q$,
    $q$[{"label":"A","text":"The phosphofructokinase-1 reaction"},{"label":"B","text":"The phosphoglycerate kinase reaction"},{"label":"C","text":"The pyruvate kinase reaction"},{"label":"D","text":"The glyceraldehyde 3-phosphate dehydrogenase reaction"}]$q$::jsonb,
    'D',
    $q$This question tests Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway, specifically identifying the glycolytic reaction that stoichiometrically consumes NAD+ and therefore stalls when the cell has no way to reoxidize NADH. The answer is D because glyceraldehyde 3-phosphate dehydrogenase is the one glycolytic enzyme that uses NAD+ as a substrate, oxidizing its triose phosphate substrate while reducing NAD+ to NADH; when hypoxia shuts down mitochondrial reoxidation and the lactate dehydrogenase inhibitor blocks the cytosolic backup route, the NAD+ pool is rapidly converted to NADH and this dehydrogenase can no longer turn over. The metabolite pattern confirms the location. Intermediates upstream of a block accumulate while intermediates downstream are drained, and here fructose 1,6-bisphosphate and dihydroxyacetone phosphate rise while 3-phosphoglycerate, phosphoenolpyruvate, and pyruvate fall, bracketing the arrest between the triose phosphates and 3-phosphoglycerate. Dihydroxyacetone phosphate piles up because triose phosphate isomerase holds it in equilibrium with the trapped aldehyde substrate of the dehydrogenase. Two reactions sit inside that bracket, but only one of them requires NAD+, and the perturbation in this experiment is purely a loss of NAD+ regeneration. (Choice A) Phosphofructokinase-1 is the pathway's main regulatory valve, but a block at that step would cause its product, fructose 1,6-bisphosphate, to fall rather than rise more than fivefold; the data place the arrest downstream of this reaction. (Choice B) Phosphoglycerate kinase also lies between the accumulating and the depleted metabolites, so the crossover pattern alone cannot exclude it; however, this kinase uses ADP, which becomes plentiful as ATP production collapses, and it has no NAD+ requirement. It idles only because the upstream dehydrogenase stops supplying 1,3-bisphosphoglycerate. (Choice C) A pyruvate kinase block would dam up phosphoenolpyruvate, yet phosphoenolpyruvate falls sharply, placing this reaction downstream of the true arrest point. This is a Data-based and Statistical Reasoning question because it requires locating a pathway block from the measured pattern of accumulating and depleted intermediates and reconciling that location with the cofactor each candidate reaction consumes.$q$,
    'hard',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    4,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', NULL FROM q;

-- Q15 . Pyruvate fate enzyme and compartment map . medium . skill 2 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$Pyruvate fate enzyme and compartment map$q$,
    $q$In a hepatocyte, pyruvate generated by glycolysis in the cytosol faces several possible fates, including transport into the mitochondrion for oxidation. Which of the following correctly pairs a pyruvate fate with its enzyme and cellular compartment?

I. Reduction to lactate by lactate dehydrogenase in the cytosol
II. Carboxylation to oxaloacetate by pyruvate carboxylase in the mitochondrial matrix
III. Reduction to lactate by lactate dehydrogenase inside the mitochondrial matrix$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"I and II only"},{"label":"C","text":"II and III only"},{"label":"D","text":"I, II, and III"}]$q$::jsonb,
    'B',
    $q$This question tests Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway, specifically the map of pyruvate's metabolic fates and the enzyme and compartment responsible for each. The answer is B because statements I and II each pair a genuine pyruvate fate with the correct enzyme in the correct compartment, while statement III assigns lactate formation to the wrong compartment. Glycolysis runs in the cytosol, so pyruvate is produced there, and the branch point that follows is defined as much by location as by enzyme. When the cell must dispose of pyruvate without sending it into the mitochondrion, cytosolic lactate dehydrogenase reduces it to lactate, so statement I is correct. Pyruvate that does cross into the mitochondrion can be oxidized, or it can be carboxylated to oxaloacetate by pyruvate carboxylase, an enzyme that resides in the mitochondrial matrix, so statement II is also correct. Statement III fails on geography: lactate dehydrogenase and the rest of the fermentation machinery operate in the cytosol, which is precisely what lets a cell keep making lactate when mitochondrial activity is limited, so no matrix-localized lactate step exists. (Choice A) This option credits the cytosolic lactate pairing but wrongly rejects statement II; the carboxylation of pyruvate to oxaloacetate genuinely takes place inside the mitochondrial matrix, so accepting statement I alone is incomplete. (Choice C) This option swaps the geography of the two fates, accepting lactate formation inside the matrix while rejecting the true cytosolic pairing in statement I; it reflects confusion about which pyruvate fate belongs to which compartment. (Choice D) Accepting all three statements requires believing that lactate dehydrogenase functions inside the mitochondrial matrix in addition to the cytosol; the reduction of pyruvate to lactate is a cytosolic event, so statement III cannot stand and this option overreaches. This is a Scientific Reasoning and Problem Solving question because it asks you to evaluate each proposed pyruvate fate by matching the chemical conversion to both its enzyme and its cellular compartment rather than recalling one isolated fact.$q$,
    'medium',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    2,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', NULL FROM q;

-- Q16 . GLUT5 mediated fructose uptake . easy . skill 2 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$GLUT5 mediated fructose uptake$q$,
    $q$A cultured hepatocyte line loses the ability to take up fructose from the medium, while its glucose uptake and its cytosolic fructokinase activity remain normal. Genetic analysis traces the defect to a loss-of-function mutation in a single facilitated-diffusion transporter. Which transporter is most likely mutated?$q$,
    $q$[{"label":"A","text":"GLUT1"},{"label":"B","text":"GLUT2"},{"label":"C","text":"GLUT5"},{"label":"D","text":"GLUT4"}]$q$::jsonb,
    'C',
    $q$This question tests Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway, specifically the transporter that brings fructose into cells at the start of the fructose 1-phosphate pathway. The answer is C because GLUT5 is the facilitated-diffusion carrier specific for fructose, so a loss-of-function mutation in GLUT5 abolishes fructose uptake while leaving glucose uptake untouched. The experimental pattern isolates the membrane step. Fructokinase, the cytosolic enzyme that phosphorylates incoming fructose to fructose 1-phosphate, is intact, so the sugar fails to reach its trapping enzyme only because it can no longer cross the plasma membrane. Normally that rapid phosphorylation keeps free intracellular fructose very low, preserving the steep inward concentration gradient that drives continued facilitated diffusion through GLUT5, so transporter and kinase work as a functional pair. Because glucose transport is completely normal, the mutated carrier must be one whose loss selectively affects fructose and nothing else. (Choice A) GLUT1 is expressed on many cell types and carries glucose; its broad distribution tempts the assumption that it moves every hexose, but it is not the fructose carrier, and its loss would compromise the basal glucose uptake that the stem says is normal. (Choice B) GLUT2 is a hepatocyte glucose transporter that can also move fructose in some tissues, so this choice is partially defensible; however, GLUT2 is not fructose specific, and a defect in it would disturb glucose handling as well, contradicting the observation that glucose uptake is unaffected. (Choice D) GLUT4 is the well-known transporter of muscle and adipose tissue that is recruited to the cell surface after feeding; it is a glucose carrier in those tissues and is not the route by which fructose enters cells. This is a Scientific Reasoning and Problem Solving question because it asks you to combine the selective loss of one sugar's uptake with intact downstream phosphorylation to deduce which membrane transporter must be responsible.$q$,
    'easy',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    2,
    60
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', NULL FROM q;

-- Q17 . Aldolase B cleavage of fructose 1-phosphate . medium . skill 3 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$Aldolase B cleavage of fructose 1-phosphate$q$,
    $q$Hepatocytes from a child with an inherited disorder of fructose metabolism and from a healthy donor are incubated with radiolabeled fructose. In both cell types the label quickly appears in fructose 1-phosphate, but only in the healthy cells does it move on into the triose phosphates of glycolysis; the patient cells instead accumulate fructose 1-phosphate and show depletion of free phosphate and ATP. Which enzyme is most likely deficient in the patient cells?$q$,
    $q$[{"label":"A","text":"Aldolase B"},{"label":"B","text":"Fructokinase"},{"label":"C","text":"Phosphofructokinase-1"},{"label":"D","text":"Triose phosphate isomerase"}]$q$::jsonb,
    'A',
    $q$This question tests Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway, specifically the cleavage step of the hepatic fructose 1-phosphate pathway. The answer is A because aldolase B cleaves fructose 1-phosphate into glyceraldehyde and dihydroxyacetone phosphate, and the patient cells trap label in fructose 1-phosphate without passing any of it to the triose phosphate level, exactly the pattern expected when this cleavage is missing. In the normal route, fructokinase spends ATP to phosphorylate fructose to fructose 1-phosphate, aldolase B splits that product, the glyceraldehyde half is phosphorylated to glyceraldehyde 3-phosphate, and the dihydroxyacetone phosphate half is isomerized, so both halves join glycolysis as trioses. When aldolase B is deficient, fructokinase keeps working, so each fructose molecule still consumes ATP and locks a phosphate group inside fructose 1-phosphate, a product that cannot release it; that sequestration explains the depletion of free phosphate and ATP measured in the patient cells. The comparison with the healthy control therefore localizes the block precisely to the cleavage of fructose 1-phosphate. (Choice B) A fructokinase deficiency would prevent fructose 1-phosphate from ever forming, yet label appeared rapidly in fructose 1-phosphate in both cell types, proving the kinase is active; this choice puts the block one step too early in the pathway. (Choice C) Phosphofructokinase-1 acts on fructose 6-phosphate in the glucose limb of glycolysis; the fructose 1-phosphate route does not pass through that reaction, so a defect there could not stop label from reaching the triose phosphates by way of aldolase B. (Choice D) Triose phosphate isomerase interconverts dihydroxyacetone phosphate and glyceraldehyde 3-phosphate; if it were deficient, label would still appear in dihydroxyacetone phosphate, which is itself a triose phosphate, contradicting the observation that no label reached that level. This is a Reasoning about the Design and Execution of Research question because it asks you to interpret a radiolabel tracing experiment with a matched healthy control and localize the enzymatic step whose loss explains the patient cells' metabolite pattern.$q$,
    'medium',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    3,
    85
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'process_step_confusion', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', NULL FROM q;

-- Q18 . Fructose bypass of the PFK-1 checkpoint . hard . skill 2 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$Fructose bypass of the PFK-1 checkpoint$q$,
    $q$In hepatocytes, an experimentally induced rise in ATP and citrate strongly inhibits phosphofructokinase-1, and glycolytic flux from added glucose slows accordingly. The same cells are then given an equal amount of fructose, which the liver channels through fructokinase and aldolase B. Compared with the glucose flux, how will the flow of fructose carbons to pyruvate respond to the PFK-1 inhibition?$q$,
    $q$[{"label":"A","text":"It will slow in parallel, because all dietary hexose carbons must pass through the PFK-1 reaction"},{"label":"B","text":"It will remain high, because the citrate that inhibits PFK-1 simultaneously activates fructokinase"},{"label":"C","text":"It will remain high, because fructose 1-phosphate is converted to fructose 2,6-bisphosphate, which overrides the inhibition of PFK-1"},{"label":"D","text":"It will remain high, because fructose carbons enter glycolysis at the triose phosphate level, downstream of the step PFK-1 catalyzes"}]$q$::jsonb,
    'D',
    $q$This question tests Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway, specifically the regulatory consequence of where fructose carbons join glycolysis. The answer is D because the hepatic fructose 1-phosphate pathway converts fructose to fructose 1-phosphate and then cleaves it into trioses that enter glycolysis at the triose phosphate level, downstream of the fructose 6-phosphate to fructose 1,6-bisphosphate reaction that PFK-1 catalyzes, and carbons that enter a pathway below a checkpoint cannot be throttled by that checkpoint. Glucose carbons must pass through PFK-1, the pathway's principal control valve, so when ATP and citrate accumulate and inhibit the enzyme, glucose flux slows as the stem describes. Fructose carbons never present themselves to the inhibited enzyme, so their flow to pyruvate continues at a high rate, largely indifferent to the cell's energy status. This bypass of the main checkpoint is the reason hepatic fructose metabolism is described as escaping the pathway's principal regulation. (Choice A) This is the assumption that every dietary hexose funnels through the same committed step; in the liver, fructose is handled by fructokinase and aldolase B and its carbons skip the PFK-1 reaction entirely, so fructose flux does not fall in parallel with glucose flux. (Choice B) This reverses citrate's role; citrate is an inhibitory signal of energy abundance acting at PFK-1, and it is not an activator of fructokinase. Fructose flux persists because of where its carbons enter, not because any effector stimulates the fructose pathway. (Choice C) This confuses fructose 1-phosphate with fructose 2,6-bisphosphate. Fructose 2,6-bisphosphate is a genuine activator of PFK-1, but it is synthesized from fructose 6-phosphate by a separate bifunctional enzyme, not from fructose 1-phosphate, and the observed fructose flux does not travel through PFK-1 at all, so no override is needed or possible. This is a Scientific Reasoning and Problem Solving question because it asks you to predict pathway flux by combining the site of allosteric inhibition with the point at which fructose carbons enter glycolysis.$q$,
    'hard',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    2,
    90
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', NULL FROM q;

-- Q19 . First enzymatic step of galactose catabolism . easy . skill 1 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$First enzymatic step of galactose catabolism$q$,
    $q$A hepatocyte converts cytosolic galactose into an intermediate that can enter glycolysis. Which reaction must occur first in this pathway?$q$,
    $q$[{"label":"A","text":"Phosphorylation of galactose on carbon 1 by galactokinase, at the cost of one ATP"},{"label":"B","text":"Exchange of the free sugar with the glucose unit of UDP-glucose to form UDP-galactose"},{"label":"C","text":"Epimerization of free galactose to free glucose"},{"label":"D","text":"Phosphorylation of galactose on carbon 6 by hexokinase"}]$q$::jsonb,
    'A',
    $q$This question tests Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway, specifically the order of reactions that carries galactose carbons into glycolysis. The answer is A because galactokinase catalyzes the first reaction of the pathway, spending one ATP to phosphorylate galactose on carbon 1 and yielding galactose 1-phosphate. Every later step depends on this product: the uridyltransferase accepts galactose 1-phosphate and exchanges it with the glucose unit of UDP-glucose, releasing glucose 1-phosphate, and the epimerase then converts the resulting UDP-galactose back to UDP-glucose. The glucose 1-phosphate released by the exchange is converted to glucose 6-phosphate, which enters glycolysis directly. Because the only enzyme in the pathway that acts on free galactose is galactokinase, the kinase reaction must come first. (Choice B) The uridyltransferase cannot use free galactose; its substrate is galactose 1-phosphate, so the exchange with UDP-glucose can occur only after the kinase step. No enzyme in the pathway attaches an unphosphorylated sugar to a nucleotide. (Choice C) The epimerase interconverts UDP-galactose and UDP-glucose, two sugars that are already nucleotide linked, and it has no activity on a free monosaccharide, so free galactose is never simply epimerized to free glucose. (Choice D) Hexokinase phosphorylates glucose and several other hexoses on carbon 6, but galactose is not a substrate its active site accepts; the dedicated galactokinase handles galactose and places the phosphate on carbon 1. This choice names the wrong enzyme and the wrong position. This is a Knowledge of Scientific Concepts and Principles question because it asks you to recall which enzyme initiates galactose catabolism and where in the reaction sequence it acts.$q$,
    'easy',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    1,
    50
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'process_step_confusion', $q$skips the obligatory kinase step$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$free-sugar epimerization myth$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$true fact about the wrong enzyme$q$ FROM q;

-- Q20 . Tracer localization of classic galactosemia . hard . skill 3 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$Tracer localization of classic galactosemia$q$,
    $q$Fibroblasts cultured from an infant with vomiting and failure to thrive were incubated with galactose radiolabeled in every carbon. After one hour, the label was recovered almost entirely as intracellular galactose 1-phosphate, which had accumulated to many times its normal concentration. No label appeared in UDP-galactose, in glucose 1-phosphate, or in any glycolytic intermediate, although the cells maintained a normal-sized UDP-glucose pool. Which conversion is blocked in these cells?$q$,
    $q$[{"label":"A","text":"Phosphorylation of free galactose to galactose 1-phosphate"},{"label":"B","text":"Epimerization of UDP-galactose to UDP-glucose"},{"label":"C","text":"Exchange of galactose 1-phosphate with the glucose unit of UDP-glucose to yield glucose 1-phosphate and UDP-galactose"},{"label":"D","text":"Conversion of glucose 1-phosphate to glucose 6-phosphate"}]$q$::jsonb,
    'C',
    $q$This question tests Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway, specifically using tracer data to localize the enzymatic lesion of classic galactosemia. The answer is C because the labeling pattern brackets the block at the uridyltransferase exchange, the reaction in which galactose 1-phosphate and UDP-glucose swap sugar groups to give glucose 1-phosphate and UDP-galactose. Labeled galactose 1-phosphate accumulated massively, so the upstream kinase is intact and delivered substrate to the transferase. Yet the label never moved on: a single working exchange would have placed labeled carbons into UDP-galactose, and continued cycling through the epimerase and later exchanges would eventually have delivered label to glucose 1-phosphate and into glycolysis. None of that occurred. Because the UDP-glucose co-substrate pool was normal in size, the failure cannot be blamed on a missing partner; the exchange enzyme itself is not functioning. This substrate-behind, products-absent pattern is the signature of the transferase deficiency responsible for classic galactosemia. (Choice A) A galactokinase block would leave the label stranded as free galactose, because the cell could not make galactose 1-phosphate at all; the massive accumulation of labeled galactose 1-phosphate proves this step is functional. (Choice B) An epimerase deficiency is a genuine, generally milder cause of galactosemia and would also eventually back up galactose 1-phosphate, which makes it tempting. However, with the transferase still active, each exchange would deposit label in UDP-galactose while draining a UDP-glucose pool that could not be regenerated; instead, UDP-galactose never became labeled and the UDP-glucose pool stayed normal. (Choice D) The conversion of glucose 1-phosphate to glucose 6-phosphate is a real step on the route into glycolysis, but the label never arrived at glucose 1-phosphate in the first place; a block at this later step would show labeled glucose 1-phosphate piling up while glycolytic intermediates stayed unlabeled. This is a Reasoning about the Design and Execution of Research question because it asks you to use where a radiolabel did and did not appear in a tracer experiment to localize the blocked metabolic step.$q$,
    'hard',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    3,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'process_step_confusion', $q$wrong step in the sequence$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$defensible until the discriminating tracer facts apply$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$real step downstream of the actual block$q$ FROM q;

-- Q21 . Catalytic recycling of UDP-glucose . medium . skill 2 . 1D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Carbohydrate Metabolism I',
    $q$Catalytic recycling of UDP-glucose$q$,
    $q$A hepatocyte metabolizes a steady stream of dietary galactose to pyruvate, with the galactose carbons entering glycolysis as glucose 6-phosphate after first appearing as glucose 1-phosphate. During this steady state, the cell's small UDP-glucose pool stays essentially constant and no net consumption of UTP is measured, even though the uridyltransferase uses one UDP-glucose in every catalytic cycle. Which feature of the pathway explains these observations?$q$,
    $q$[{"label":"A","text":"New UDP-glucose is continuously synthesized from glucose 1-phosphate and UTP to replace each molecule the transferase consumes"},{"label":"B","text":"The epimerase regenerates UDP-glucose from the UDP-galactose produced in each exchange, so the nucleotide sugar cycles instead of being consumed"},{"label":"C","text":"Galactose 1-phosphate is isomerized directly to glucose 1-phosphate, so UDP-glucose is not actually required for carbon flow"},{"label":"D","text":"Net flux through the epimerase runs from UDP-glucose to UDP-galactose, continuously replenishing the transferase's nucleotide substrate"}]$q$::jsonb,
    'B',
    $q$This question tests Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway, specifically why the galactose pathway needs only a catalytic amount of UDP-glucose to deliver galactose carbons into glycolysis. The answer is B because the epimerase converts the UDP-galactose released by each transferase exchange back into UDP-glucose, closing a loop in which the nucleotide sugar is regenerated as fast as it is used. Each transferase turnover consumes one UDP-glucose but simultaneously produces one UDP-galactose, so the epimerase can restore the consumed carrier one for one. Summing the kinase, transferase, and epimerase reactions, the net conversion is galactose plus ATP to glucose 1-phosphate plus ADP: the UDP sugars cancel out of the overall equation. That matches the observations exactly, a constant UDP-glucose pool and no net UTP consumption, while the carbons stream through glucose 1-phosphate and glucose 6-phosphate into glycolysis. (Choice A) A cell can indeed synthesize UDP-glucose from glucose 1-phosphate and UTP, and that reaction establishes the pool in the first place. But if steady flux depended on continuous resynthesis, one UTP would be consumed for every galactose processed, contradicting the finding that UTP is not depleted. (Choice C) There is no direct isomerization of galactose 1-phosphate to glucose 1-phosphate; the carbons must pass through the nucleotide-linked exchange, which is precisely why loss of the transferase produces severe disease rather than a harmless detour around it. (Choice D) This choice reverses the epimerase's working direction. During net galactose catabolism the epimerase must run from UDP-galactose toward UDP-glucose; net flux in the opposite direction would drain UDP-glucose and starve the transferase of its co-substrate, stalling the pathway. This is a Scientific Reasoning and Problem Solving question because it asks you to reason from the stoichiometry of three coupled reactions to explain why the nucleotide sugar behaves as a recycled catalyst rather than a consumed reactant.$q$,
    'medium',
    '1D',
    $q$Glycolysis, Gluconeogenesis, and the Pentose Phosphate Pathway$q$,
    'biochemistry',
    2,
    85
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'adjacent_fact', $q$real reaction, wrong explanation for the data$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$invents a bypass the pathway lacks$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$correct enzyme, inverted direction$q$ FROM q;

COMMIT;

-- Verification: expect 21 questions and 63 distractor rows.
SELECT
  (SELECT COUNT(*) FROM public.questions WHERE topic = 'Carbohydrate Metabolism I') AS questions,
  (SELECT COUNT(*) FROM public.question_distractor_metadata m
     JOIN public.questions x ON x.id = m.question_id
   WHERE x.topic = 'Carbohydrate Metabolism I') AS distractor_rows;
