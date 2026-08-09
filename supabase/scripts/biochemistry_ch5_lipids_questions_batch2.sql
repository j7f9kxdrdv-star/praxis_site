-- Biochemistry Chapter 5: Lipid Structure and Function, standalone questions
-- BATCH 2 of 2, FINAL (22 questions): phospholipid architecture . membrane-lipid physical
--   behaviour . the sphingolipid family . fat-soluble vitamins as molecules . prostaglandins.
--
-- This file completes the chapter at 45 questions.
--
-- !! RUN AFTER BATCH 1 !!
-- No DELETE here: batch 1 owns the chapter-scoped DELETE. Re-running this file alone would
-- duplicate its 22 questions.

BEGIN;

-- Q1 . Head versus tail solubility contributions . easy . skill 2 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Head versus tail solubility contributions$q$,
    $q$A chemist splits phosphatidylcholine into two pieces. Piece 1 keeps the glycerol, the phosphate, and the choline but lacks both hydrocarbon chains; piece 2 keeps the glycerol and both chains but lacks the phosphate and choline. When each piece is stirred into water, what behavior is expected?$q$,
    $q$[{"label":"A","text":"Piece 1 clumps away from the water, while piece 2 dissolves readily."},{"label":"B","text":"Both pieces dissolve readily, because each retains part of an amphipathic molecule."},{"label":"C","text":"Piece 1 dissolves readily, while piece 2 clumps away from the water."},{"label":"D","text":"Neither piece dissolves, because a lipid stays insoluble no matter which portion is removed."}]$q$::jsonb,
    'C',
    $q$This Lipids question examines the division of labor within phospholipid architecture, in which the polar phosphate-bearing head supplies the molecule's affinity for water and the two hydrocarbon tails supply its tendency to hide from water. The answer is C because each region carries its characteristic property with it when the molecule is cut apart. Piece 1, containing glycerol, the phosphate, and the choline, is a small, highly polar and charged species with essentially no nonpolar surface, so water solvates it well and it dissolves freely. Piece 2 is a diacylglycerol whose structure is dominated by two long nonpolar chains; water cannot interact favorably with those chains, so the hydrophobic effect drives such molecules to aggregate away from the aqueous phase. The intact parent lipid is amphipathic precisely because it stitches these two opposite tendencies into one covalent structure, and separating the regions separates the behaviors. (Choice A) This reverses the assignment of properties: it treats the charged phosphocholine unit as the water-avoiding region and the acyl chains as the water-loving region, exactly backwards from the roles each region plays in the intact lipid. (Choice B) Amphipathicity is a property of the whole molecule, not of its halves; once the pieces are separated, neither one contains both a polar region and a nonpolar region, so only the polar piece dissolves while the tail-bearing piece self-associates. (Choice D) Bulk water insolubility is not an indelible label attached to anything derived from a lipid; nearly all of phosphatidylcholine's insoluble character resides in its tails, and removing them leaves a small polar fragment that dissolves as easily as other water-soluble metabolites. This is a Scientific Reasoning and Problem Solving question because it asks the student to predict the aqueous behavior of two novel fragments by reasoning about which region of the parent phospholipid contributes polarity and which contributes hydrophobic character.$q$,
    'easy',
    '5D',
    $q$Lipids$q$,
    'biochemistry',
    2,
    70
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'reversed_relationship', $q$role reversal of head and tail$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$property of whole misapplied to parts$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$lipid always insoluble$q$ FROM q;

-- Q2 . Phosphodiester linkage to head group . easy . skill 1 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Phosphodiester linkage to head group$q$,
    $q$An enzyme acting on phosphatidylethanolamine releases free ethanolamine, leaving a lipid in which two fatty acyl chains and one phosphate group remain bonded to glycerol. Which type of linkage did the enzyme hydrolyze?$q$,
    $q$[{"label":"A","text":"A glycosidic linkage"},{"label":"B","text":"A phosphodiester linkage"},{"label":"C","text":"A carboxylic acid ester linkage"},{"label":"D","text":"An amide linkage"}]$q$::jsonb,
    'B',
    $q$This Lipids question tests recognition of the phosphodiester linkage, the bond system that attaches a head group alcohol to the glycerophospholipid backbone. The answer is B because in phosphatidylethanolamine the central phosphate is esterified twice, once to the oxygen on carbon 3 of glycerol and once to the hydroxyl oxygen of ethanolamine, and two ester bonds on a single phosphorus define a phosphodiester. Cleaving the outer of these two phosphoester bonds detaches the ethanolamine head group while leaving the phosphate still attached to glycerol; the remaining lipid, glycerol bearing two fatty acyl chains and a phosphate, is phosphatidic acid. The observed products, a free amino alcohol plus a lipid that keeps its phosphate, therefore point directly at the phosphorus-centered linkage rather than at any bond involving the fatty acyl chains. (Choice A) A glycosidic linkage joins a sugar through its anomeric carbon to another group; carbohydrates do serve as head groups in glycolipids, but no sugar is present in phosphatidylethanolamine, and glycosidic cleavage could not release an amino alcohol from a phosphate. (Choice C) Carboxylic acid ester bonds are genuinely present in this lipid, but they connect the two fatty acyl chains to carbons 1 and 2 of glycerol; hydrolyzing them would release free fatty acids and leave the head group attached, the opposite of the observed result. (Choice D) An amide linkage joins a fatty acid to the backbone nitrogen in sphingolipids, a different lipid family; glycerophospholipids contain no amide bond, and ethanolamine in this lipid is bound through its oxygen, not its nitrogen. This is a Knowledge of Scientific Concepts and Principles question because it asks the student to identify the specific covalent linkage joining a head group to a glycerophospholipid backbone from the products its hydrolysis generates.$q$,
    'easy',
    '5D',
    $q$Lipids$q$,
    'biochemistry',
    1,
    60
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$wrong-family linkage$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$right bond, wrong location$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$sphingolipid linkage transplanted$q$ FROM q;

-- Q3 . Head group charge and electrophoretic migration . hard . skill 4 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Head group charge and electrophoretic migration$q$,
    $q$Three synthetic glycerophospholipids carry identical fatty acyl chains on a diacylglycerol phosphate core and differ only in the group joined through the second bond on the core's phosphorus. In lipid 1 that group is choline, whose quaternary nitrogen holds a permanent positive charge. In lipid 2 it is serine, which at pH 7.4 presents one protonated amino group and one deprotonated carboxylate. Lipid 3 has no added group, leaving the core's ionized phosphate fully exposed. The three lipids are spotted on a strip and an electric field is imposed at pH 7.4; a species travels toward the anode, the positively charged pole, only if it bears net negative charge. Which result is predicted?$q$,
    $q$[{"label":"A","text":"All three lipids migrate toward the anode."},{"label":"B","text":"Only lipid 3 migrates toward the anode; lipids 1 and 2 remain stationary."},{"label":"C","text":"Lipid 1 migrates toward the cathode, while lipids 2 and 3 migrate toward the anode."},{"label":"D","text":"Lipids 2 and 3 migrate toward the anode, while lipid 1 remains stationary."}]$q$::jsonb,
    'D',
    $q$This Lipids question requires data-based reasoning about how head group identity sets a glycerophospholipid's net charge and therefore its movement in an electric field. The answer is D because summing every ionized group in each lipid at pH 7.4 gives a net charge of zero for lipid 1 and a net negative charge for lipids 2 and 3. In all three lipids the bridging phosphate contributes one negative charge. Lipid 1 adds choline's permanently positive nitrogen, so plus one and minus one cancel; the molecule is a net neutral zwitterion and does not travel in the field. Lipid 2 adds serine, whose protonated amine and deprotonated carboxylate cancel each other, leaving the phosphate's negative charge unopposed; the lipid carries net minus one and moves toward the anode. Lipid 3 is phosphatidic acid, whose bare phosphate has no attached group to offset it and is ionized at pH 7.4, so it likewise moves toward the anode. (Choice A) Every lipid does contain an ionized phosphate, but migration follows net charge rather than the presence of any single group; in lipid 1 the choline cation exactly offsets the phosphate anion, so lipid 1 does not travel. (Choice B) This choice cancels serine's zwitterionic pair against the phosphate; in fact the amine and carboxylate cancel one another, the phosphate's charge survives the sum, and lipid 2 travels toward the anode. (Choice C) Choline's positive charge is real, but counting it while omitting the phosphate's negative charge wrongly assigns lipid 1 a net positive charge; the correct total is zero, so lipid 1 stays in place rather than moving toward the cathode. This is a Data-based and Statistical Reasoning question because it requires combining the described ionization state of each head group into a per-molecule charge total and translating each total into a predicted direction of movement in the applied field.$q$,
    'hard',
    '5D',
    $q$Lipids$q$,
    'biochemistry',
    4,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$single group substituted for net charge$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', $q$wrong pairing in charge summation$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$incomplete charge inventory$q$ FROM q;

-- Q4 . Sphingomyelin as a glycerol-free phospholipid . medium . skill 2 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Sphingomyelin as a glycerol-free phospholipid$q$,
    $q$A lipid purified from neural tissue contains a long-chain amino alcohol serving as its structural core, a single fatty acid joined to that core's nitrogen through an amide bond, and a phosphate bridging the core's terminal hydroxyl group to choline. The molecule contains no glycerol. How should this lipid be classified?$q$,
    $q$[{"label":"A","text":"As a phospholipid, because the class is defined by the phosphate-containing head group, and here sphingosine substitutes for glycerol as the scaffold."},{"label":"B","text":"As a glycolipid, because its head group is attached through the terminal hydroxyl group of the structural core."},{"label":"C","text":"As a wax, because it combines a long-chain alcohol with a fatty acid."},{"label":"D","text":"As a sphingolipid only, because a lipid that lacks glycerol cannot belong to the phospholipid class."}]$q$::jsonb,
    'A',
    $q$This Lipids question examines what defines membership in the phospholipid class when the scaffold is not glycerol. The answer is A because the described molecule is sphingomyelin: its long-chain amino alcohol is sphingosine, which offers a nitrogen for amide attachment of one fatty acid and a terminal hydroxyl for attachment of the phosphocholine head group. Membership in the phospholipid class follows from possessing a phosphate-containing head group, not from the identity of the scaffold beneath it, so a sphingosine-based lipid bearing phosphocholine is simultaneously a sphingolipid, by its scaffold, and a phospholipid, by its head group. Glycerophospholipids and sphingomyelin therefore share one class despite being built on different cores, and both present the same overall plan of two hydrophobic chains beneath a polar phosphate-bearing head. (Choice B) A glycolipid is defined by a carbohydrate head group; attachment through a terminal hydroxyl does not create one, and this molecule carries phosphocholine rather than any sugar. (Choice C) Waxes are esters formed between a long-chain alcohol and a fatty acid; here the fatty acid is joined through an amide bond to nitrogen, and the polar phosphocholine unit has no counterpart in any wax. (Choice D) The sphingolipid assignment is correct as far as it goes, but the two categories are not exclusive; because the classification rests on the phosphate head group rather than on glycerol, sphingomyelin belongs to both families at once. This is a Scientific Reasoning and Problem Solving question because it asks the student to assign a described glycerol-free structure to the correct lipid class by applying the defining criterion for a phospholipid rather than matching a memorized glycerol template.$q$,
    'medium',
    '5D',
    $q$Lipids$q$,
    'biochemistry',
    2,
    75
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'partial_truth', $q$attachment site mistaken for class criterion$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$wax definition transplanted$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$glycerol required for phospholipid$q$ FROM q;

-- Q5 . Tail number dictating micelle versus bilayer . easy . skill 2 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Tail number dictating micelle versus bilayer$q$,
    $q$A lab synthesizes two amphiphiles that share an identical charged head group. Amphiphile 1 carries a single 16-carbon tail, while amphiphile 2 carries two such tails. When amphiphile 2 is dispersed in water at high concentration, which aggregate should predominate?$q$,
    $q$[{"label":"A","text":"A spherical micelle, because the second tail sharpens the wedge shape that lets the assembly curve tightly around its core"},{"label":"B","text":"Free monomers in solution, because the second tail doubles the hydrophobic area and blocks any stable self-assembly"},{"label":"C","text":"A double-layered sheet, because head groups of adjacent amphiphiles fuse into a continuous covalent lattice"},{"label":"D","text":"A double-layered sheet, because the paired tails give the molecule a roughly cylindrical outline that packs side by side without needing a curved surface"}]$q$::jsonb,
    'D',
    $q$This Lipids question tests how the molecular geometry of an amphiphile determines which aggregate it assembles into when dispersed in water. The answer is D because adding a second hydrocarbon tail changes the molecule's overall shape from a cone into an approximate cylinder, and cylinders pack side by side into flat, double-layered sheets rather than curling into spheres. A single-tailed amphiphile is wide at its charged head and narrow at its lone tail, giving it a tapered, cone-like profile. Cones fit together the way orange slices do, curving around a central point, so single-tailed amphiphiles bury their tails in the core of a small sphere, the micelle. Once a second tail of similar length is attached, the hydrophobic end becomes roughly as wide as the head, the taper disappears, and the molecule approximates a cylinder. Cylinders cannot wrap into a tightly curved sphere; the geometry that hides their hydrophobic surface most completely is two flat layers laid tail to tail, with head groups facing water on both faces. The same logic explains why two-tailed phospholipids build the bilayers of cell membranes while single-tailed soaps and detergents form micelles. (Choice A) reverses the geometric inference: a second tail widens the hydrophobic end and blunts the taper, whereas a sharpened wedge is the shape of a single-tailed amphiphile and is precisely what favors the tightly curved micelle. (Choice B) misstates the driving force. Enlarging the hydrophobic surface strengthens the tendency to aggregate, because clustering releases ordered water molecules and is entropically favorable; it does not keep monomers dispersed. (Choice C) names the right aggregate for the wrong reason. Self-assembly is entirely noncovalent; the sheet is held together by the hydrophobic effect acting on the buried tails, and no covalent bonds ever form between neighboring head groups. This is a Scientific Reasoning and Problem Solving question because it requires predicting the assembly behavior of an unfamiliar synthetic amphiphile from its molecular shape rather than recalling a memorized pairing of molecule and structure.$q$,
    'easy',
    '2A',
    $q$Lipids$q$,
    'biochemistry',
    2,
    65
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'reversed_relationship', $q$shape logic inverted$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$hydrophobicity blocks assembly$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$right structure wrong force$q$ FROM q;

-- Q6 . Trans double bond chain packing . medium . skill 2 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Trans double bond chain packing$q$,
    $q$Industrial partial hydrogenation of a vegetable oil converts many of its cis double bonds to the trans configuration. A cis double bond forces a rigid bend of about 30 degrees into an acyl tail. Which structural change explains why the processed fat is solid at room temperature while the starting oil is liquid?$q$,
    $q$[{"label":"A","text":"Hydrogenation eliminates every double bond, leaving the product with only fully saturated tails"},{"label":"B","text":"The trans arrangement bends each tail more sharply than cis does, and the interlocking bends bind neighboring tails together"},{"label":"C","text":"The trans geometry keeps each tail fully extended, so neighboring tails can stack as closely as saturated tails do"},{"label":"D","text":"The trans arrangement adds mass to each tail, and heavier tails require more thermal energy to melt"}]$q$::jsonb,
    'C',
    $q$This Lipids question tests how the geometry of a carbon-carbon double bond controls how tightly acyl tails pack against their neighbors. The answer is C because a trans double bond places the two flanking segments of the tail on opposite sides of the rigid bond, so the tail continues along an essentially straight zigzag path, just as a fully saturated tail does. Straight tails can lie flush against adjacent tails along their entire length, maximizing intermolecular contact, so the processed fat packs densely, melts at a higher temperature, and behaves as a solid under room conditions. In the starting oil, every cis double bond bends its tail; bent tails cannot nest against one another, packing stays loose, and the material remains liquid. Partial hydrogenation therefore solidifies an oil in two complementary ways: it saturates a fraction of the double bonds outright, and it isomerizes many of the survivors from cis to trans; those trans tails pack nearly as well as saturated ones. Because tight packing is what raises melting temperature, the bulk consequence follows directly from the shape of the tails. (Choice A) confuses partial with complete hydrogenation. The industrial process deliberately stops short of full saturation, so many double bonds remain in the product; the solidification depends in large part on the ones that have flipped to trans. (Choice B) inverts the geometry. The trans arrangement removes the bend rather than deepening it; it is the cis arrangement that kinks the tail, and no interlocking of bends holds tails together in either configuration. (Choice D) attributes melting behavior to mass. Flipping a double bond from cis to trans rearranges the same atoms in space without changing molecular weight, and the melting differences among these fats track packing efficiency, not size. This is a Scientific Reasoning and Problem Solving question because it requires connecting the three-dimensional geometry of one double bond to the packing behavior of whole molecules and from there to a bulk physical property of the fat.$q$,
    'medium',
    '5D',
    $q$Lipids$q$,
    'biochemistry',
    2,
    75
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'process_step_confusion', $q$partial mistaken for complete$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', $q$cis and trans swapped$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$melting tracks mass$q$ FROM q;

-- Q7 . Cholesterol bidirectional fluidity buffering . hard . skill 2 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Cholesterol bidirectional fluidity buffering$q$,
    $q$Cholesterol inserts between membrane phospholipids with its lone hydroxyl group oriented toward the aqueous surface. Compared with an otherwise identical bilayer lacking it, a cholesterol-rich bilayer is expected to display which of the following?

I. Greater acyl-tail motion when both bilayers are held below the phospholipid transition temperature
II. Restricted acyl-tail motion when both bilayers are held above the phospholipid transition temperature
III. A transition temperature shifted far below that of the cholesterol-free bilayer$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"I and II only"},{"label":"C","text":"II and III only"},{"label":"D","text":"I, II, and III"}]$q$::jsonb,
    'B',
    $q$This Lipids question tests cholesterol's two-way modulation of membrane physical behavior on either side of the phospholipid transition temperature. The answer is B because statements I and II are both correct while statement III is not. Below the transition temperature, phospholipid tails settle into a tightly ordered, gel-like arrangement. Cholesterol's bulky fused-ring system wedges between the tails and physically prevents that orderly packing, so the tails retain more freedom of motion than they would in a pure bilayer; statement I is true. Above the transition temperature, the tails are already highly mobile, and the same rigid rings now act as a brace that restricts their rotation and reduces disorder; statement II is true. Acting in opposite directions on either side of the transition, cholesterol holds membrane behavior within a middle range across a broad span of temperatures. Statement III is false because cholesterol does not simply slide the transition downward and abolish the gel state that way; instead it blunts and broadens the cooperative transition itself, so the membrane changes character gradually rather than melting sharply. A substantially lowered transition temperature is the signature of introducing bent unsaturated tails, not of adding a sterol. (Choice A) captures only the fluidizing action in the cold, ordered state and misses the restraining action in the warm, disordered state, so it tells half the story. (Choice C) treats cholesterol as a pure stiffening agent plus a transition shift, denying its well-documented ability to disrupt gel-state packing from within. (Choice D) accepts statement III along with the two correct statements, wrongly assigning to cholesterol the melting-point depression that belongs to unsaturated acyl tails. This is a Scientific Reasoning and Problem Solving question because it requires applying one molecule's packing behavior across two different temperature regimes and predicting effects that run in opposite directions.$q$,
    'hard',
    '2A',
    $q$Lipids$q$,
    'biochemistry',
    2,
    95
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$half of a two-way effect$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$cholesterol as pure stiffener$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$neighboring mechanism misassigned$q$ FROM q;

-- Q8 . Cholesterol orientation in the bilayer . medium . skill 3 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Cholesterol orientation in the bilayer$q$,
    $q$Cholesterol consists of a rigid, fused four-ring frame attached to a single polar group. A researcher preparing synthetic phospholipid bilayers wants to determine how inserted cholesterol is oriented: does its polar group face the surrounding water, or is it buried among the hydrophobic tails? Which of the following observations would best establish that the polar group faces the water?$q$,
    $q$[{"label":"A","text":"A membrane-impermeant reagent that reacts only with accessible hydroxyls covalently labels the sterol when added to intact, sealed liposomes"},{"label":"B","text":"Cholesterol dissolves uniformly into the hydrophobic core, with no portion of the molecule detectable at either aqueous surface of the bilayer"},{"label":"C","text":"Labeling experiments place the fused rings among the polar head groups at the surface, with the hydroxyl directed toward the bilayer center"},{"label":"D","text":"Inside cells, cholesterol can be stored after esterification of its hydroxyl to a fatty acid, forming cholesteryl esters found in lipid droplets"}]$q$::jsonb,
    'A',
    $q$Lipids: cholesterol's orientation in a bilayer follows from its weakly amphipathic structure, and the right experiment can localize its one polar group. The answer is A because a reagent that cannot cross the membrane can only reach groups exposed on the outer, water-facing surface of a sealed liposome; if that reagent covalently modifies the sterol at its hydroxyl, the hydroxyl must sit at the aqueous interface among the phospholipid head groups rather than deep in the hydrocarbon core. Cholesterol is built almost entirely from a rigid, planar set of fused hydrocarbon rings plus a short branched tail, with a single hydroxyl as its only polar feature. That architecture makes it weakly amphipathic: the ring system slips in among the fatty acyl chains of one leaflet, while the hydroxyl points outward to hydrogen bond with water and the head group region. The impermeant-reagent design turns this structural claim into a testable prediction, since the vesicles stay sealed and a positive labeling result can only mean the target group is accessible from the aqueous phase. (Choice B) reflects the misconception that cholesterol behaves as a wholly hydrophobic molecule, like a triacylglycerol dissolved in the middle of an oil droplet. Its rings are indeed buried, but its hydroxyl is not, and an observation of complete burial would contradict rather than establish the orientation being tested. (Choice C) describes the reverse arrangement. Packing the bulky nonpolar rings among the charged, hydrated head groups while pointing the lone polar group into the anhydrous core is energetically backwards, and such a finding would argue against the proposed orientation instead of supporting it. (Choice D) is a true statement about cholesterol handling in cells: esterifying the hydroxyl to a fatty acid yields cholesteryl esters, the neutral storage form packed inside lipid droplets and lipoprotein cores. Because esterification describes what can happen to the hydroxyl chemically, not where the free molecule sits in a membrane, it provides no evidence about orientation. This is a Reasoning about the Design and Execution of Research question because it asks which observation would justify a specific structural conclusion, which requires linking the logic of an impermeant labeling strategy, where only surface-exposed groups can react, to the position of a molecule within the bilayer.$q$,
    'medium',
    '5D',
    $q$Lipids$q$,
    'biochemistry',
    3,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'misconception', $q$fully buried hydrophobe$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', $q$inverted orientation$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$true but irrelevant ester fact$q$ FROM q;

-- Q9 . Phosphatidic acid as parent structure in glycerophospholipid naming . medium . skill 2 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Phosphatidic acid as parent structure in glycerophospholipid naming$q$,
    $q$During membrane lipid synthesis, a cell produces phosphatidylserine by joining the hydroxyl group of serine to the single open position on a simpler parent lipid. Which of the following identifies that parent?$q$,
    $q$[{"label":"A","text":"A phosphorylated intermediate that does not itself qualify as a glycerophospholipid until an alcohol head group is attached to its phosphate"},{"label":"B","text":"Diacylglycerol, a glycerol backbone carrying two fatty acyl chains with its third hydroxyl left free"},{"label":"C","text":"Phosphatidic acid, a glycerol backbone carrying two fatty acyl chains and a phosphate at the third carbon"},{"label":"D","text":"Serine itself, acting as the central scaffold and receiving a diacylglycerol phosphate unit as its polar head group"}]$q$::jsonb,
    'C',
    $q$Lipids: glycerophospholipids follow a parent-plus-head-group construction pattern, and their names encode which alcohol has been added to the parent. The answer is C because glycerol esterified to two fatty acyl chains, with a phosphate on its third carbon, is phosphatidic acid, the simplest glycerophospholipid and the parent structure of the entire family. Esterifying the hydroxyl of a small alcohol onto that phosphate generates the named membrane lipids as a phosphatidyl-X series: serine gives phosphatidylserine, ethanolamine gives phosphatidylethanolamine, and choline gives phosphatidylcholine. The name itself records this logic: the phosphatidyl portion denotes the diacylglycerol phosphate core contributed by the parent, and the suffix names the alcohol esterified onto it. Because serine is attached through its hydroxyl at the one open position on the phosphate, conceptually removing serine returns the intact parent, phosphatidic acid, with two acyl tails and a bare phosphate remaining.

(Choice A) This choice treats the bare phosphate as a mere attachment point rather than a true head group, implying the parent only becomes a glycerophospholipid once an alcohol caps it. In fact phosphatidic acid already possesses every defining feature of the class: a glycerol backbone, two fatty acyl chains, and a phosphate at carbon 3. Its ionized phosphate itself serves as the polar head, which is why phosphatidic acid functions as a genuine, negatively charged membrane lipid in its own right.

(Choice B) Diacylglycerol correctly captures the two acyl chains on the glycerol backbone but omits the phosphate from the core. Without a phosphate at the third carbon there is nothing for serine's hydroxyl to attach to, and the molecule would be a neutral glycerolipid rather than a phospholipid.

(Choice D) This choice reverses the construction pattern. Serine is the small alcohol added last onto the phosphate, not the scaffold; the glycerol phosphate framework carries the fatty acyl chains and receives serine, not the other way around.

This is a Scientific Reasoning and Problem Solving question because it requires applying the general assembly and naming pattern of glycerophospholipids to deconstruct a specific membrane lipid and reason out which structural parent remains when its head-group alcohol is removed.$q$,
    'medium',
    '5D',
    $q$Lipids$q$,
    'biochemistry',
    2,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$phosphate-not-a-head-group$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$core-minus-phosphate$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$alcohol-as-scaffold$q$ FROM q;

-- Q10 . Sphingomyelin structure in myelin insulation . easy . skill 1 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Sphingomyelin structure in myelin insulation$q$,
    $q$The myelin wrap that electrically insulates a vertebrate axon is exceptionally rich in one phospholipid that contains no glycerol. This lipid is built from:$q$,
    $q$[{"label":"A","text":"sphingosine carrying one amide-linked fatty acid, with a single galactose as its head group"},{"label":"B","text":"sphingosine carrying one amide-linked fatty acid, with a phosphocholine head group on its terminal hydroxyl"},{"label":"C","text":"sphingosine carrying one ester-linked fatty acid, with a phosphocholine head group on its terminal hydroxyl"},{"label":"D","text":"sphingosine carrying two amide-linked fatty acids, with a phosphocholine head group on its terminal hydroxyl"}]$q$::jsonb,
    'B',
    $q$This Lipids question asks for the structure of the glycerol-free phospholipid concentrated in the myelin sheath. The answer is B because the lipid described is sphingomyelin, the one major phospholipid of human membranes that is not built on glycerol. Its backbone is sphingosine, a long-chain amino alcohol that contributes its own hydrocarbon tail to the molecule. The backbone amine holds a single fatty acid through an amide bond, and the terminal hydroxyl carries a phosphocholine head group through a phosphodiester bond. Because sphingosine supplies one tail and the amide-linked fatty acid supplies the other, the molecule presents two hydrophobic chains to the membrane interior while containing only one true fatty acid, and the phosphocholine head makes it a full member of the phospholipid class. The insulating membranes of the sheath are exceptionally enriched in sphingolipids of this kind. (Choice A) A single galactose attached to the backbone describes a cerebroside, another lipid genuinely abundant in myelin membranes. However, a sugar head attached with no phosphate anywhere in the molecule disqualifies it from the phospholipid class specified in the stem, so it cannot be the lipid in question. (Choice C) An ester linkage is the attachment chemistry of glycerolipids, in which fatty acids join the hydroxyls of glycerol. Sphingosine instead offers an amine at the acylation position, so its fatty acid is joined through an amide bond, not an ester. (Choice D) Only one fatty acid is amide-linked in sphingomyelin, because the backbone possesses a single amine to hold it. The second hydrophobic tail is sphingosine's own built-in hydrocarbon chain, so a molecule bearing two amide-linked fatty acids does not correspond to any major membrane sphingolipid. This is a Knowledge of Scientific Concepts and Principles question because it requires recalling the structural composition of sphingomyelin, the sphingosine-based phospholipid enriched in the insulating membranes of myelin.$q$,
    'easy',
    '5D',
    $q$Lipids$q$,
    'biochemistry',
    1,
    60
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'adjacent_fact', $q$real myelin lipid, wrong class$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$glycerolipid linkage transplanted$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$two tails misread as two fatty acids$q$ FROM q;

-- Q11 . Phosphate-free glycosidic heads of glycosphingolipids . medium . skill 2 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Phosphate-free glycosidic heads of glycosphingolipids$q$,
    $q$Starting from the same ceramide, a neuron can produce either sphingomyelin or a single-sugar glycolipid of the cerebroside type. Which of the features listed distinguish the finished glycolipid from the finished sphingomyelin?

I. Its head group is attached through a glycosidic bond rather than through a phosphodiester bond
II. The completed molecule contains no phosphorus
III. Its sugar occupies the nitrogen position that holds the fatty acid in sphingomyelin$q$,
    $q$[{"label":"A","text":"I and II only"},{"label":"B","text":"I and III only"},{"label":"C","text":"II and III only"},{"label":"D","text":"I, II, and III"}]$q$::jsonb,
    'A',
    $q$This Lipids question probes what separates a glycosphingolipid from sphingomyelin when both arise from the same ceramide. The answer is A because statements I and II are true and statement III is false. Both products keep the entire ceramide core: a sphingosine backbone whose amine already holds one fatty acid in amide linkage. The two classes then diverge only at the terminal hydroxyl. Sphingomyelin caps that hydroxyl with phosphocholine through a phosphodiester bond, while a cerebroside-type glycolipid attaches a single sugar directly through a glycosidic bond with no phosphate intervening. Statement I is therefore correct, since the linkage chemistries of the two head groups differ in exactly this way. Statement II is also correct: because the sugar bonds directly to the hydroxyl, the finished glycolipid contains no phosphorus anywhere, which is the defining division between the glycosphingolipids and the phosphosphingolipids. Statement III fails because the nitrogen position is already occupied by the amide-linked fatty acid in both molecules; the sugar takes the same hydroxyl position that phosphocholine occupies in sphingomyelin, so the two products differ at the head position, not at the nitrogen. (Choice B) This combination keeps the correct linkage statement but discards the phosphorus-free point, the single most definitional difference between the classes, while accepting the false claim that glycosylation displaces the fatty acid from the amine. (Choice C) This combination correctly retains the phosphorus distinction but rejects the true statement about glycosidic versus phosphodiester linkage while accepting the false attachment-site claim. (Choice D) Accepting all three statements treats every position on the backbone as a point of difference, but the amide-linked fatty acid is shared by both products rather than distinguishing them, so statement III cannot be included. This is a Scientific Reasoning and Problem Solving question because it requires mapping two biosynthetic products onto a shared ceramide scaffold and reasoning out which structural positions differ and which are conserved.$q$,
    'medium',
    '5D',
    $q$Lipids$q$,
    'biochemistry',
    2,
    90
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'process_step_confusion', $q$attachment site confused$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$right on phosphorus, wrong on linkage$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$every position assumed to differ$q$ FROM q;

-- Q12 . Two-attribute sphingolipid classification from data . hard . skill 4 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Two-attribute sphingolipid classification from data$q$,
    $q$A membrane lipid fraction from nervous tissue yields three purified components, X, Y, and Z, whose structural features are summarized below.

| Component | Backbone | Fatty acid attachment | Phosphorus | Head group |
|---|---|---|---|---|
| X | sphingosine | one, amide-linked | present | choline joined through a phosphodiester bond |
| Y | sphingosine | one, amide-linked | absent | a single galactose unit |
| Z | sphingosine | one, amide-linked | absent | a branched oligosaccharide bearing sialic acid |

Which assignment correctly matches each component to its lipid class?$q$,
    $q$[{"label":"A","text":"X: cerebroside; Y: sphingomyelin; Z: ganglioside"},{"label":"B","text":"X: sphingomyelin; Y: ganglioside; Z: cerebroside"},{"label":"C","text":"X: ganglioside; Y: cerebroside; Z: sphingomyelin"},{"label":"D","text":"X: sphingomyelin; Y: cerebroside; Z: ganglioside"}]$q$::jsonb,
    'D',
    $q$This Lipids question requires classifying three sphingolipids from tabulated structural attributes. The answer is D because two criteria applied in sequence sort the components uniquely. Note first that all three components share the same ceramide core, a sphingosine backbone with one amide-linked fatty acid, so the backbone and linkage columns cannot discriminate among them; classification rests entirely on the head. The first criterion is phosphorus: component X is the only one with a phosphodiester-linked head, and among sphingosine-based lipids that head chemistry defines sphingomyelin, here with choline as the attached alcohol. The second criterion applies to the phosphate-free, sugar-headed components: Y carries one galactose unit, the single-sugar pattern of a cerebroside, while Z carries a branched oligosaccharide containing sialic acid, and the presence of sialic acid residues is the recognition mark of a ganglioside. Applying both attributes together yields X as sphingomyelin, Y as cerebroside-type, and Z as ganglioside-type. (Choice A) Assigning the phosphate-containing component to the cerebroside class and the galactose-headed component to sphingomyelin reverses the head chemistry of the two classes; a cerebroside never contains phosphorus, and sphingomyelin always does. (Choice B) This assignment passes the phosphorus test and places X correctly, but then swaps the two glycolipids: a single galactose cannot constitute the sialylated oligosaccharide of a ganglioside, and an oligosaccharide bearing sialic acid is far too elaborate to be a cerebroside head. (Choice C) Treating the sialic-acid-bearing component as sphingomyelin confuses an acidic sugar with a phosphate group; sialic acid carries a carboxylate rather than a phosphodiester, and the table lists Z as phosphorus-free, which excludes it from the phospholipid class outright. This is a Data-based and Statistical Reasoning question because it requires applying two structural criteria simultaneously to tabulated molecular attributes in order to sort each component into its correct sphingolipid class.$q$,
    'hard',
    '5D',
    $q$Lipids$q$,
    'biochemistry',
    4,
    105
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'reversed_relationship', $q$phosphate criterion inverted$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$passes phosphate test, fails sugar test$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$acidic sugar mistaken for phosphate$q$ FROM q;

-- Q13 . Retinal aldehyde as visual chromophore . easy . skill 1 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Retinal aldehyde as visual chromophore$q$,
    $q$Dietary vitamin A reaches the retina, where one of its derivatives binds the protein opsin to form a pigment that changes shape upon absorbing a photon, initiating vision. At its terminal carbon, this photon-absorbing derivative carries which functional group?$q$,
    $q$[{"label":"A","text":"A carboxylic acid"},{"label":"B","text":"An aldehyde"},{"label":"C","text":"A primary alcohol"},{"label":"D","text":"A fatty acid ester"}]$q$::jsonb,
    'B',
    $q$This Lipids question tests the vitamin A family of fat-soluble isoprenoid derivatives and asks which oxidation state of the molecule's terminal carbon marks the light-absorbing component of the visual pigment. The answer is B because the derivative that binds opsin is retinal, in which the terminal carbon of the vitamin's long polyene chain has been oxidized from an alcohol to an aldehyde. Retinal's extended chain of alternating single and double bonds is the part of the molecule that actually captures the photon, and absorption flips the geometry of one of those double bonds; the resulting change in shape is passed to the surrounding opsin protein and launches the signal the brain interprets as light. The common vitamin A forms differ only in the oxidation state of that single terminal carbon: alcohol in retinol, aldehyde in retinal, and carboxylic acid in retinoic acid. All of them share the same hydrophobic isoprenoid skeleton, which is why the family travels and is stored with lipids, so matching each physiological role to its terminal group is the entire discriminating task. (Choice A) A carboxylic acid is the terminal group of retinoic acid, formed by one additional oxidation beyond the aldehyde; that derivative acts on developing tissues rather than participating in photoreception. (Choice C) A primary alcohol is the terminal group of retinol, the parent and transport form of the vitamin; it must be oxidized once before it can join opsin as the pigment's light-absorbing unit. (Choice D) A fatty acid ester forms when an alcohol oxygen condenses with a fatty acid, the same linkage that joins fatty acids to glycerol in dietary fats; an esterified terminus stays at the alcohol oxidation level and is not the group presented by the opsin-bound derivative. This is a Knowledge of Scientific Concepts and Principles question because it asks the student to recall which oxidation state of vitamin A's terminal carbon corresponds to the derivative serving as the photon-absorbing component of the visual pigment.$q$,
    'easy',
    '5D',
    $q$Lipids$q$,
    'biochemistry',
    1,
    60
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'process_step_confusion', $q$one oxidation step too far$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$parent form mistaken for active form$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$neighboring lipid linkage mistaken for the active group$q$ FROM q;

-- Q14 . Retinoic acid supports epithelial development . medium . skill 2 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Retinoic acid supports epithelial development$q$,
    $q$The terminal carbon of vitamin A can be oxidized in two sequential steps, first from an alcohol to an aldehyde and then from the aldehyde to a carboxylic acid. In an experimental animal, the enzyme catalyzing only the second step is inactivated, while all other vitamin A handling remains normal. Which function is most directly lost?$q$,
    $q$[{"label":"A","text":"Transport of the vitamin's alcohol form through the blood on its plasma binding protein"},{"label":"B","text":"Photon capture by the pigment of rod photoreceptor cells"},{"label":"C","text":"Regeneration of the alcohol form from the aldehyde form"},{"label":"D","text":"Support of the growth and specialization of epithelial tissues such as the skin"}]$q$::jsonb,
    'D',
    $q$This Lipids question tests the division of labor among the vitamin A derivatives: the aldehyde-level molecule works in vision while the carboxylic acid-level molecule serves developing tissues. The answer is D because inactivating only the second oxidation removes a single product, retinoic acid, the carboxylic acid derivative. Retinoic acid is the family member that acts on developing tissues, supporting the proper formation and renewal of epithelial layers such as the skin; this is why vitamin A deficiency presents clinically with skin disorders in addition to night blindness. Because the first oxidation still runs, the aldehyde derivative is made normally, and every role served by the alcohol or the aldehyde is untouched. Each oxidation raises the terminal carbon one level, and only the final, acid-level product carries the developmental role, so the question is solved by tracing which end product disappears when the second step alone fails. A useful check is that any answer naming a role of the alcohol or the aldehyde must survive the block, leaving only the acid-dependent role as a casualty. (Choice A) Transport through the blood carries the alcohol form of the vitamin on its plasma binding protein; this lies upstream of both oxidations, so a block at the second step leaves it untouched. (Choice B) Photon capture in rod photoreceptors is performed by the aldehyde derivative, the product of the first oxidation; that molecule is still synthesized in normal amounts when only the second step fails. (Choice C) Returning the aldehyde to the alcohol is a reduction, the reverse of the first oxidation, and does not involve the inactivated enzyme at any point. This is a Scientific Reasoning and Problem Solving question because it requires the student to map a specific enzymatic block onto the branched metabolism of vitamin A and deduce which downstream physiological function is lost.$q$,
    'medium',
    '5D',
    $q$Lipids$q$,
    'biochemistry',
    2,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'adjacent_fact', $q$upstream process presented as the casualty$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', $q$wrong branch of the metabolic fork$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', $q$direction of the reaction flipped$q$ FROM q;

-- Q15 . Conjugation length sets carotene color . hard . skill 4 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Conjugation length sets carotene color$q$,
    $q$Beta-carotene, a 40-carbon plant hydrocarbon containing 11 conjugated double bonds, absorbs maximally near 450 nm and gives carrots their orange color. A single enzymatic cut at its central bond yields two identical 20-carbon molecules, each ending in an aldehyde; this molecule, retinal, has 6 conjugated double bonds and absorbs maximally near 380 nm, just outside the visible range. A fully saturated hydrocarbon of either length absorbs only below 200 nm. These data best support which conclusion?$q$,
    $q$[{"label":"A","text":"The wavelength a polyene captures grows with the extent of its unbroken pi framework, so halving the framework shifts the peak below the band the eye detects"},{"label":"B","text":"The wavelength a polyene captures shrinks as its unbroken pi framework extends, which is why the parent molecule needs higher-energy light than its fragments"},{"label":"C","text":"The aldehyde created by the cut, not the pi framework, is the group that captures light in the visible band"},{"label":"D","text":"Because each fragment keeps the parent's ratio of double bonds to carbons, its peak stays at the parent's wavelength"}]$q$::jsonb,
    'A',
    $q$This Lipids question tests the link between beta-carotene's structure and its behavior as a pigment, and what happens to light absorption when the molecule is split into its two vitamin A halves. The answer is A because the data tie peak absorption to the length of the continuous run of alternating double bonds: eleven in sequence absorb at 450 nm, six absorb at 380 nm, and a chain with none at all absorbs only below 200 nm. Longer conjugation lets the pi electrons spread over a larger framework, which narrows the energy gap between their occupied and excited states, so more extended conjugated systems capture lower-energy, longer-wavelength photons. Reading the trend forward, cutting the eleven-bond run roughly in half drops the peak from the blue region into the near ultraviolet, and the fragments no longer remove any visible wavelength from reflected light. This is exactly why the central cleavage of one orange carotene molecule yields two retinal units whose peak absorption no longer falls in the visible band; each is nonetheless the aldehyde-bearing vitamin A derivative that can go on to serve as the light-sensing unit of the visual pigment. (Choice B) The data run opposite to this claim: the molecule with the most extended alternating framework absorbs at the longest wavelength and therefore the lowest photon energy, not the highest. (Choice C) The aldehyde cannot be the visible-light absorber, because the fragment carrying the aldehyde absorbs at 380 nm, outside the visible band, while the parent species with no aldehyde at all is the orange one. (Choice D) The fragments do retain a double-bond density close to the parent's, but absorption tracks the absolute extent of the unbroken conjugated run rather than its per-carbon density, and the measured peak in fact moves from 450 nm to 380 nm. This is a Data-based and Statistical Reasoning question because it requires the student to extract the relationship between conjugation length and absorption wavelength from comparative spectral data and extrapolate it to the products of carotene cleavage.$q$,
    'hard',
    '5D',
    $q$Lipids$q$,
    'biochemistry',
    4,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'reversed_relationship', $q$direction of the structure-property trend flipped$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$salient functional group credited for a pi-system property$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'scale_unit_error', $q$ratio mistaken for the operative absolute quantity$q$ FROM q;

-- Q16 . Vitamin D3 as a ring-opened steroid derivative . medium . skill 2 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Vitamin D3 as a ring-opened steroid derivative$q$,
    $q$In the skin, ultraviolet light converts a derivative of cholesterol into vitamin D3. A student receives an unlabeled lipid sample known to be either pure cholesterol or pure vitamin D3. Analysis shows a single hydroxyl group, a branched hydrocarbon tail, and exactly three closed carbon rings, with the carbons that would close a fourth ring instead lying in an open chain. Which conclusion does the analysis best support?$q$,
    $q$[{"label":"A","text":"The sample is cholesterol, because the nucleus of cholesterol consists of three fused rings"},{"label":"B","text":"The sample is cholesterol, because only the intact parent compound possesses a branched hydrocarbon tail"},{"label":"C","text":"The sample is vitamin D3, because one ring of the fused steroid nucleus was broken during its synthesis while the rest of the skeleton remained intact"},{"label":"D","text":"The sample is vitamin D3, because the light-driven conversion removes the branched tail while leaving all four rings of the precursor closed"}]$q$::jsonb,
    'C',
    $q$This Lipids question tests the structural relationship between vitamin D3 and the steroid nucleus of its precursor. The answer is C because every steroid, cholesterol included, is built on a nucleus of four fused rings, so a compound presenting only three closed rings cannot be intact cholesterol. Vitamin D3 arises when ultraviolet light breaks open one ring of a cholesterol-derived precursor in the skin; the product keeps the other three rings, the single hydroxyl group, and the branched hydrocarbon tail of the steroid framework, while the atoms of the opened ring persist as an open stretch of chain. The sample's inventory matches that ring-opened pattern exactly: three closed rings plus the leftover chain that once completed a fourth. Solving the problem therefore takes two steps, first recalling the four-ring definition of the steroid nucleus to rule out cholesterol, then recognizing the three-ring remainder with its residual open segment as the signature of the light-opened vitamin. (Choice A) This choice rests on a miscount of the steroid nucleus; steroids are defined by four fused rings, not three, so a three-ring compound argues against cholesterol rather than for it. (Choice B) Cholesterol does possess a short branched tail, but the tail survives the ring-opening conversion and is present in both molecules, so its presence cannot distinguish the sample; the ring count is the discriminating observation. (Choice D) The light-driven conversion opens a ring and leaves the tail in place, and the analysis itself reports a branched tail with only three closed rings, the opposite of what this choice predicts. This is a Scientific Reasoning and Problem Solving question because it requires the student to combine the four-ring definition of the steroid nucleus with the reported ring count to deduce which of the two candidate molecules the sample must be.$q$,
    'medium',
    '5D',
    $q$Lipids$q$,
    'biochemistry',
    2,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$miscounted defining feature of the steroid nucleus$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$shared feature treated as a discriminator$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$wrong bond change assigned to the photochemical step$q$ FROM q;

-- Q17 . Tocopherol chain-breaking site in membranes . hard . skill 3 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Tocopherol chain-breaking site in membranes$q$,
    $q$A research team prepares liposomes from phospholipids with polyunsaturated tails, adds a lipid-soluble radical initiator, and tracks the accumulation of lipid peroxidation products over time. When a small amount of alpha-tocopherol is incorporated into the bilayer, almost no product forms until the tocopherol is used up, after which products accumulate rapidly. The team wishes to conclude that tocopherol halts the propagation of radicals by donating a hydrogen atom within the bilayer itself, rather than by reacting in the surrounding solution. Which additional condition would most directly support the proposed site of action?$q$,
    $q$[{"label":"A","text":"Repeating the experiment with liposomes built from fully saturated phospholipid tails"},{"label":"B","text":"Repeating the experiment with the radical initiator omitted to confirm that no products form spontaneously"},{"label":"C","text":"Running a parallel trial in which an equally potent water-soluble reducing agent is confined to the aqueous phase outside the vesicles"},{"label":"D","text":"Doubling the incorporated tocopherol and confirming that the delay before products appear lengthens proportionally"}]$q$::jsonb,
    'C',
    $q$This Lipids question examines vitamin E's role as the chain-breaking antioxidant of membranes and asks how an experiment can localize that activity to the bilayer interior. The answer is C because the team's conclusion contains two separable claims: that tocopherol interrupts radical propagation, and that it does so from within the membrane rather than from the surrounding solution. The observed delay already establishes interruption, since products appear only after the tocopherol supply is exhausted, but the delay alone cannot distinguish where the interruption happens. Supplying an equally potent reducing agent that dissolves only in water, and showing that it fails to reproduce the protective delay, demonstrates that reducing power in the aqueous compartment is not sufficient; protection requires an antioxidant that resides among the hydrocarbon tails, where the propagating radicals are generated. That localization reflects tocopherol's design: its ring donates a hydrogen atom to a lipid radical, yielding a stabilized species too sluggish to continue the chain, while its long hydrophobic tail anchors it in the bilayer beside the polyunsaturated chains it protects, exactly where a water-soluble reducer cannot reach. (Choice A) Liposomes built from fully saturated tails would test whether polyunsaturated chains are the necessary substrate for peroxidation; that is a legitimate but different question, and its outcome would reveal nothing about the compartment in which tocopherol acts. (Choice B) Omitting the initiator is a baseline control for the initiation step, confirming that the measured products are radical-derived; it does not probe the inhibitor at all, let alone its location. (Choice D) A proportional lengthening of the protective delay supports stoichiometric consumption of the antioxidant by radicals, which strengthens the chain-breaking mechanism but remains silent on whether that chemistry occurs inside the bilayer or in solution. This is a Reasoning about the Design and Execution of Research question because it asks the student to select the control condition that isolates the membrane compartment as an antioxidant's site of action.$q$,
    'hard',
    '5D',
    $q$Lipids$q$,
    'biochemistry',
    3,
    105
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'adjacent_fact', $q$control that probes the substrate instead of the inhibitor$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', $q$control aimed at the wrong step of the process$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$evidence for the mechanism but not the location$q$ FROM q;

-- Q18 . Vitamin K glutamate carboxylation chemistry . medium . skill 2 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Vitamin K glutamate carboxylation chemistry$q$,
    $q$Hepatocytes secrete an inactive clotting-factor precursor whose amino-terminal region must be enzymatically altered before the protein can participate in coagulation. The responsible enzyme requires vitamin K, and mass spectrometry of the mature protein shows that several residues in this region have each gained 44 Da. Which change to the precursor accounts for these findings?$q$,
    $q$[{"label":"A","text":"Attachment of a phosphate group to the gamma carbon of selected glutamate side chains"},{"label":"B","text":"Attachment of a second carboxyl group to the gamma carbon of selected glutamate side chains"},{"label":"C","text":"Removal of the original carboxyl group from selected glutamate side chains"},{"label":"D","text":"Attachment of a second carboxyl group to the side chains of selected aspartate residues"}]$q$::jsonb,
    'B',
    $q$This Lipids question tests the chemistry of the post-translational modification performed by the vitamin K-dependent carboxylase. The answer is B because a mass gain of 44 Da corresponds to the incorporation of one molecule of carbon dioxide, and that is exactly what the vitamin K-dependent enzyme installs: a new carboxyl group attached to the gamma carbon of particular glutamate side chains after the polypeptide has already been synthesized. Each modified residue, known as gamma-carboxyglutamate, therefore bears two carboxylate groups where the original glutamate bore one. These modified residues cluster in the amino-terminal region of several clotting-factor precursors, including the precursor of thrombin, and the modification is what renders those proteins competent for coagulation; when the vitamin K cofactor is missing, the carboxylation step fails and the precursors remain inactive. The point under test is the chemistry itself: a carboxylation of an amino acid side chain within a finished protein, which is why it qualifies as a post-translational modification rather than an event of translation. (Choice A) A phosphate transfer would add roughly 80 Da per site, not 44 Da, so the measured mass increase rules out phosphorylation even though it is otherwise the most familiar post-translational modification. (Choice C) Removing the original carboxyl group runs in the wrong direction; a decarboxylation would decrease the residue mass rather than increase it, and it would dismantle, rather than construct, the doubled negative charge these proteins require. (Choice D) The vitamin K-dependent carboxylase acts on glutamate, not aspartate; although adding a carboxyl group to aspartate would also produce a 44 Da gain, the enzyme's residue specificity places the new group on glutamate's gamma carbon. This is a Scientific Reasoning and Problem Solving question because it asks the student to match a measured mass change and a cofactor requirement to the specific covalent chemistry of a side-chain carboxylation.$q$,
    'medium',
    '5D',
    $q$Lipids$q$,
    'biochemistry',
    2,
    85
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'scale_unit_error', $q$wrong functional group betrayed by the mass scale$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', $q$direction of the modification reversed$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$right chemistry transplanted onto the wrong residue$q$ FROM q;

-- Q19 . Doubled carboxylate calcium chelation logic . easy . skill 4 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Doubled carboxylate calcium chelation logic$q$,
    $q$A synthetic peptide containing four glutamate residues binds calcium ions weakly, with a dissociation constant near 5 mM. After enzymatic modification, each of those side chains carries a pair of carboxylate groups on adjacent carbons, and the dissociation constant for calcium falls to 0.05 mM while sodium binding is essentially unchanged. Which property of the modified side chains best explains these measurements?$q$,
    $q$[{"label":"A","text":"Each of the two acid groups captures its own separate calcium ion, doubling the number of ions the peptide holds"},{"label":"B","text":"The second acid group makes the side chain more hydrophobic, favoring close approach to the ion"},{"label":"C","text":"The two acid groups, in their protonated neutral forms, hydrogen bond to the calcium ion"},{"label":"D","text":"Two closely spaced negative charges on a single side chain attract a doubly charged cation from both sides at once"}]$q$::jsonb,
    'D',
    $q$This Lipids question tests the electrostatic logic by which the doubled carboxylate of gamma-carboxyglutamate binds calcium. The answer is D because at physiological pH both acid groups on the modified side chain are ionized, so the residue presents two negative charges held close together on adjacent carbons. A calcium ion carries two positive charges and can sit between the paired anions, attracted by both simultaneously; the side chain closes around the ion like a claw, an arrangement commonly described as chelation of a divalent cation. The measurements match this geometry in two ways. Affinity improves one hundredfold, far more than the modest statistical gain expected if the modification had merely added a second independent binding site, which signals that the two charges cooperate on a single ion. And the improvement is selective for the doubly charged ion: a sodium ion, with only one positive charge, cannot take full advantage of the second contact, so its binding barely changes. This is the same chemistry that lets modified clotting proteins hold calcium ions along their amino-terminal regions. (Choice A) If each acid group captured its own separate ion, the peptide would hold more calcium overall, but the tightness of any individual site would be nearly unchanged; the large fall in the dissociation constant shows a change in grip on each ion, not merely a change in capacity. (Choice B) An added ionizable acid group makes the side chain more polar and more negatively charged, not more hydrophobic, and a hydrophobic surface offers no attraction for a cation dissolved in water. (Choice C) The attraction depends on the deprotonated, anionic form of the acids; in their protonated neutral form the charges vanish and the electrostatic pull is lost, so protonation would weaken binding rather than create it. This is a Data-based and Statistical Reasoning question because it asks the student to use the size of the affinity change and the unchanged sodium binding to infer that paired negative charges coordinate a single divalent cation.$q$,
    'easy',
    '5D',
    $q$Lipids$q$,
    'biochemistry',
    4,
    70
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$additive-sites reading that ignores cooperativity in the data$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$polarity of the modification inverted$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', $q$charge state of the working form reversed$q$ FROM q;

-- Q20 . Prostaglandin autocrine paracrine locality . medium . skill 2 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Prostaglandin autocrine paracrine locality$q$,
    $q$A researcher isolates two signaling molecules. Molecule 1 is a twenty-carbon carboxylic acid with a five-membered ring, produced in nearly every organ from a fatty acid freed from membrane phospholipid. Molecule 2 is a peptide exported by one discrete gland into the bloodstream, which carries it to distant organs. Which of the following accurately characterizes molecule 1?

I. It acts on the cell that released it or on that cell's immediate neighbors

II. It must ride the general circulation before reaching any responsive cell

III. It can stimulate a given process in one location yet inhibit the same process elsewhere$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"II only"},{"label":"C","text":"I and III only"},{"label":"D","text":"II and III only"}]$q$::jsonb,
    'C',
    $q$This Lipids question tests the signaling range of prostaglandins, the family of twenty-carbon eicosanoid mediators, and the way their local action separates them from classical endocrine hormones. The answer is C because statements I and III are accurate while statement II is false. Molecule 1 matches the prostaglandin blueprint: twenty carbons including a five-membered ring, produced in nearly every organ from arachidonic acid liberated from membrane phospholipid. Prostaglandins operate as autocrine and paracrine factors, meaning their target cells are the secreting cell itself or cells lying immediately nearby, which makes statement I correct. Because the response depends on which receptor type a given target expresses, one and the same prostaglandin can stimulate a process in one location and inhibit that identical process somewhere else, which makes statement III correct as well. Statement II instead describes molecule 2 and the classical hormone strategy: release from a single dedicated gland followed by bulk transport in blood to remote organs. Prostaglandins are short-lived and act before any such journey could occur, so obligatory passage through the circulation is exactly the property they lack. (Choice A) is a partial truth: it accepts the local-action statement but wrongly rejects statement III, even though receptor-dependent variation in response is a hallmark of this lipid family and follows directly from its local mode of delivery. (Choice B) reverses the two signaling strategies, assigning the endocrine requirement for blood-borne delivery to the locally acting lipid while discarding both of its genuine properties. (Choice D) couples the true receptor-dependence statement to the false circulation requirement, reflecting the misconception that a molecule with hormone-like potency must also use hormone-like long-distance delivery. This is a Scientific Reasoning and Problem Solving question because it requires identifying an unnamed twenty-carbon lipid as a prostaglandin from structural clues and then applying the autocrine and paracrine signaling model to judge each claim about how far the signal travels before acting.$q$,
    'medium',
    '5D',
    $q$Lipids$q$,
    'biochemistry',
    2,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', NULL FROM q;

-- Q21 . Enzyme blockade reveals mediator function . hard . skill 3 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Enzyme blockade reveals mediator function$q$,
    $q$In a placebo-controlled trial, volunteers with acute joint sprains take a drug that irreversibly inactivates the enzyme converting arachidonic acid, a twenty-carbon fatty acid cut loose from membrane phospholipid, into prostaglandins. Compared with placebo, treated volunteers report milder pain, show less swelling at the sprain, and register lower fevers. Chemical assays confirm the drug binds only that enzyme and no receptor. These observations most strongly support which conclusion?$q$,
    $q$[{"label":"A","text":"The drug produced relief by directly numbing sensory neurons, independent of any change in lipid synthesis."},{"label":"B","text":"The blocked products normally restrain inflammation, and their loss let alternative mediators resolve the injury sooner."},{"label":"C","text":"Relief occurred because the unreacted fatty acid substrate, rather than any downstream product, is the true mediator of pain and fever."},{"label":"D","text":"The lipid products of the targeted reaction normally act as causal promoters of inflammation, nociception, and an elevated thermal set point."}]$q$::jsonb,
    'D',
    $q$This Lipids question examines how an enzyme-inhibition experiment reveals the physiological role of prostaglandins, the twenty-carbon lipid mediators built from arachidonic acid. The answer is D because removing a product and watching a response fade is the classic loss-of-function argument: if inactivating the synthetic enzyme relieves pain, swelling, and fever, the products that enzyme normally makes must have been actively driving those responses. The trial isolates the variable cleanly, since the assays show the drug touches only the biosynthetic enzyme and binds no receptor, so any clinical change must trace back to the missing lipid output rather than to some direct drug effect on the responding cells. Because all three findings moved downward together once synthesis stopped, the simplest supported conclusion is that prostaglandins generated at the injury and in thermoregulatory centers act as positive mediators of inflammation, nociceptive signaling, and the raised thermal set point. Note that this inference concerns what the products were doing, not how target cells transduce them; the experiment identifies the mediators, and working out any downstream mechanism would require separate studies. (Choice A) proposes direct action on sensory neurons, a misconception the design already excludes: the binding assays show the drug interacts with the enzyme alone, so a neuronal mechanism cannot account for the result. (Choice B) reverses the direction of prostaglandin action; if these lipids normally restrained inflammation, cutting off their supply should have worsened the swelling and fever rather than relieving them, the opposite of what was measured. (Choice C) confuses adjacent steps of the pathway: blocking the enzyme makes the fatty acid substrate accumulate, so if the substrate itself caused pain and fever, treated volunteers should have felt worse as it built up, again contradicting the data. This is a Reasoning about the Design and Execution of Research question because it asks the student to interpret a controlled loss-of-function intervention and decide what the disappearance of a response implies about the normal role of the molecules that were eliminated.$q$,
    'hard',
    '5D',
    $q$Lipids$q$,
    'biochemistry',
    3,
    90
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', NULL FROM q;

-- Q22 . Fat solubility drives tissue accumulation . hard . skill 4 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Fat solubility drives tissue accumulation$q$,
    $q$Two adults each ingest ten times the recommended daily amount of a different micronutrient for eight weeks. Compound X is water soluble; compound Y is lipid soluble. Week 8 data: the X user shows near-baseline plasma X with a fortyfold rise in urinary X, while the Y user shows mildly raised plasma Y, an eightfold rise in liver and adipose Y, and urinary Y below the assay's detection limit. Which conclusion do these data best support?$q$,
    $q$[{"label":"A","text":"Y dissolves preferentially into hydrophobic depots and evades renal removal, so sustained overconsumption will drive progressive buildup toward toxicity."},{"label":"B","text":"The undetectable urinary signal indicates Y is completely degraded to inactive end products, leaving no reservoir that could ever reach harmful levels."},{"label":"C","text":"The tissue enrichment of Y is transient because lipid-soluble compounds equilibrate with body water and wash out within days of stopping the doses."},{"label":"D","text":"The fortyfold figure shows X deposits in fatty stores five times faster than Y accumulates, since forty divided by eight is five."}]$q$::jsonb,
    'A',
    $q$This Lipids question tests the partitioning consequence of fat solubility: lipid-soluble micronutrients distribute into hydrophobic tissue compartments rather than leaving the body in urine, so chronic excess builds up. The answer is A because the two disposal patterns in the data track solubility exactly as partitioning predicts. The water-soluble compound X stays near baseline in plasma while its urinary level climbs fortyfold, meaning the kidneys clear the surplus about as fast as it arrives; an overdose of X is simply flushed out in the aqueous waste stream. The lipid-soluble compound Y shows the mirror image: essentially nothing appears in urine, and the surplus instead piles up eightfold in liver and adipose tissue, the body's hydrophobic storage sites. Renal filtration hands water-soluble solutes to an aqueous exit route that is effectively closed to a molecule that partitions into lipid phases, so Y has no efficient way out, and every additional week of overdosing enlarges a growing reservoir. This is precisely why chronic excess of fat-soluble vitamins produces hypervitaminosis while comparable excess of water-soluble vitamins rarely does. (Choice B) claims complete degradation with no reservoir, a misconception directly contradicted by the measured eightfold rise in liver and adipose stores; absence from urine reflects failure to excrete, not successful destruction. (Choice C) reverses the partitioning logic: a molecule that favors lipid phases does not equilibrate freely with body water, so the depot drains slowly over weeks to months after dosing stops, not within days. (Choice D) commits a scale and unit error by dividing a urinary excretion ratio for one compound by a tissue storage ratio for a different compound; the two numbers describe different processes measured in different people and cannot be combined into any deposition rate, and the data show X does not deposit in fat at all. This is a Data-based and Statistical Reasoning question because it requires comparing paired plasma, tissue, and urinary measurements across two compounds and inferring from those numbers which disposal route each solubility class follows and what continued excess intake will therefore produce.$q$,
    'hard',
    '5D',
    $q$Lipids$q$,
    'biochemistry',
    4,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'scale_unit_error', NULL FROM q;

COMMIT;

-- Verification: the chapter is COMPLETE. Expect 45 questions and 135 distractor rows.
SELECT
  (SELECT COUNT(*) FROM public.questions WHERE topic = 'Lipid Structure and Function') AS questions,
  (SELECT COUNT(*) FROM public.question_distractor_metadata m
     JOIN public.questions x ON x.id = m.question_id
   WHERE x.topic = 'Lipid Structure and Function') AS distractor_rows;

-- Distribution check across the finished chapter.
SELECT difficulty, COUNT(*) FROM public.questions
 WHERE topic = 'Lipid Structure and Function' GROUP BY difficulty ORDER BY difficulty;
SELECT correct_answer, COUNT(*) FROM public.questions
 WHERE topic = 'Lipid Structure and Function' GROUP BY correct_answer ORDER BY correct_answer;
