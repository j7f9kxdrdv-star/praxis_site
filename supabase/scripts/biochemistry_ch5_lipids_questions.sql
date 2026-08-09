-- Biochemistry Chapter 5: Lipid Structure and Function, standalone questions
-- BATCH 1 of 2 (23 questions): lipid fundamentals and class discrimination . triacylglycerols,
--   saponification, soaps and micelles . steroid structure . waxes and terpenes.
--
-- CHAPTER SIZE: 45 questions, well below the 72 of Biochem Ch3/Ch4, because a Step 1 boundary audit
-- found this chapter's traditional material heavily claimed before it was built: Biochem Ch11 owns
-- fatty-acid nomenclature, all lipid energetics, digestion/bile/micelle-ferrying, lipoproteins and
-- cholesterol synthesis; Bio Ch5 Endocrine owns steroid-hormone mechanism (the single most saturated
-- concept in the bank); Bio Ch9 closed all three vitamin-K vignette routes the week before.
-- What survives is the CHEMISTRY: saponification and soap micelles (zero prior coverage bank-wide),
-- steroid and terpene structure, and in batch 2 the membrane lipids and vitamin chemistry.
-- FORWARD RESERVATION: batch 2 claims cholesterol-as-fluidity-buffer and bilayer-versus-micelle
-- geometry; the future Biochem Ch8 Membranes bank must treat those as TESTED_ELSEWHERE. Ch8 keeps
-- bilayer dynamics, the fluid mosaic model, rafts, asymmetry, membrane proteins and transport.
-- This chapter ships FIGURE-FREE: structures are described in words.
-- See biochemistry_ch5_lipids_questions.plan.md for the full audit trail.
--
-- !! BATCH 1 OWNS THE CHAPTER DELETE !! Batch 2 is pure INSERTs and runs after this file.

BEGIN;

DELETE FROM public.questions WHERE topic = 'Lipid Structure and Function';

-- Q1 . Solubility as the lipid class criterion . easy . skill 1 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Solubility as the lipid class criterion$q$,
    $q$Triacylglycerols contain ester groups, steroids consist of fused hydrocarbon rings often bearing a hydroxyl group, and many terpenes are pure hydrocarbons. Despite sharing no common functional group, all three are classified as lipids. Membership in the lipid class is assigned on the basis of which criterion?$q$,
    $q$[{"label":"A","text":"Presence of at least one ester linkage to a fatty acid"},{"label":"B","text":"Preferential dissolution in nonpolar solvents rather than in water"},{"label":"C","text":"Ability to form micelles when dispersed in aqueous solution"},{"label":"D","text":"Preferential dissolution in water rather than in nonpolar solvents"}]$q$::jsonb,
    'B',
    $q$Lipids questions like this one test the criterion that defines the lipid class, which is solubility behavior rather than shared covalent architecture. The answer is B because a molecule earns membership in the lipid class by partitioning preferentially into nonpolar solvents such as chloroform or hexane while dissolving poorly in water. Because the defining test is a physical property and not a functional group, the class sweeps in molecules with very different skeletons: ester-linked acylglycerols, fused-ring steroids, and hydrocarbon terpenes all pass the same partitioning test. This is why lipids are chemically heterogeneous in a way that carbohydrates and proteins are not; those classes are defined structurally, as polyhydroxy carbonyl compounds and amide-linked amino acid polymers respectively, so their members resemble one another. Any structural criterion chosen for lipids would either exclude true lipids or admit non-lipids, which is why the physical definition is the one that survives. (Choice A) An ester linkage to a fatty acid is present in triacylglycerols, waxes, and glycerophospholipids, but steroids and many terpenes contain no fatty acid ester at all, so this criterion would expel molecules that are unambiguously lipids from the class. (Choice C) Micelle formation requires an amphipathic structure with a polar head group. Purely hydrophobic lipids such as triacylglycerols and terpene hydrocarbons cannot form micelles, yet they remain lipids, so this behavior identifies only a subset of the class rather than the class itself. (Choice D) This reverses the actual partitioning behavior. A molecule that preferred water to nonpolar solvents would be hydrophilic, and hydrophilicity is precisely what excludes a molecule from the lipid class. This is a Knowledge of Scientific Concepts and Principles question because it asks the student to recall that lipid classification rests on a shared solubility property rather than a shared functional group and to recognize that structural diversity follows directly from that physical definition.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$lipids equal fats equal fatty acid esters$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$subset behavior mistaken for class definition$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$direction of partitioning inverted$q$ FROM q;

-- Q2 . Water affinity ranking across lipid classes . hard . skill 4 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Water affinity ranking across lipid classes$q$,
    $q$A chemist compares the water affinity of four purified lipids. Compound 1 is glycerol esterified at all three positions to unbranched C16 chains. Compound 2 is glycerol bearing two unbranched C16 acyl chains and a phosphocholine head group at its third position. Compound 3 is the sodium salt of a single unbranched C16 carboxylic acid. Compound 4 consists of four fused hydrocarbon rings bearing one hydroxyl group and a short branched hydrocarbon tail. Which ordering ranks the compounds from greatest to least affinity for water?$q$,
    $q$[{"label":"A","text":"Compound 3 > Compound 2 > Compound 4 > Compound 1"},{"label":"B","text":"Compound 2 > Compound 3 > Compound 4 > Compound 1"},{"label":"C","text":"Compound 3 > Compound 2 > Compound 1 > Compound 4"},{"label":"D","text":"Compound 1 > Compound 4 > Compound 2 > Compound 3"}]$q$::jsonb,
    'A',
    $q$Lipids questions of this type ask for a comparative ranking of water affinity across the major lipid classes, reasoned from structure alone. The answer is A because water affinity tracks the balance between polar or charged surface and hydrophobic surface. Compound 3, a fatty acid salt, pairs a fully ionized carboxylate with only a single hydrocarbon chain, the highest polar-to-nonpolar ratio in the set; salts of this type even show measurable monomer solubility in water. Compound 2 carries a zwitterionic phosphocholine head, but that single head must offset two full-length acyl chains, so its affinity for water is lower than the salt's. Compound 4, a steroid, offers just one hydroxyl on a bulky fused-ring hydrocarbon frame, making it only weakly amphipathic. Compound 1 sits last because it has no charge and no hydrogen bond donor anywhere; its ester oxygens are buried near the crowded glycerol center, leaving an effectively uniform hydrocarbon surface. That places it below even the steroid, whose hydroxyl can both donate and accept hydrogen bonds at an exposed molecular surface. (Choice B) This swaps the top pair by counting the two charges of the zwitterionic head as if charge number alone decided the ranking; the head group must be weighed against the doubled hydrophobic chain area it drags along, and per chain the single-tail carboxylate is better solvated. (Choice C) This ranks the triacylglycerol above the steroid by tallying its six ester oxygens against a single hydroxyl, but ester oxygens are weak hydrogen bond acceptors with no donor capacity and little solvent exposure, whereas the steroid hydroxyl is a surface-exposed donor and acceptor. (Choice D) This inverts the entire series, ordering the compounds from most hydrophobic to least; it describes the ranking of affinity for a nonpolar solvent, not for water. This is a Data-based and Statistical Reasoning question because it requires converting four structural descriptions into an ordered comparison, weighing head group chemistry against hydrophobic surface area to place each molecule on a relative water affinity scale.$q$,
    'hard',
    '5D',
    $q$Lipids$q$,
    'biochemistry',
    4,
    110
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'partial_truth', $q$head group counted, chain burden ignored$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$oxygen counting mistaken for polarity$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$full ranking inversion$q$ FROM q;

-- Q3 . Amphipathic structure and micelle dispersal . medium . skill 2 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Amphipathic structure and micelle dispersal$q$,
    $q$A student shakes a small sample of each of four lipids into separate flasks of water. Compound W is a C16 fatty acid esterified to a single unbranched C30 alcohol. Compound X is glycerol esterified at all three positions to unbranched C18 chains. Compound Y is the potassium salt of a C14 fatty acid, and compound Z is a C30 branched hydrocarbon assembled from isoprene units. Which compound disperses through the water as micelles rather than collecting as a separate oily layer?$q$,
    $q$[{"label":"A","text":"Compound W"},{"label":"B","text":"Compound X"},{"label":"C","text":"Compound Y"},{"label":"D","text":"Compound Z"}]$q$::jsonb,
    'C',
    $q$Lipids questions on amphipathic versus purely hydrophobic structure test whether a molecule carries a polar region and what that region predicts about behavior in water. The answer is C because compound Y, the potassium salt of a C14 fatty acid, is the only structure in the set with a genuinely polar head: a fully ionized carboxylate attached to a single hydrocarbon tail. Above a threshold concentration, single-chain amphiphiles of this kind self-assemble into micelles, spherical aggregates that bury the tails in a dry hydrophobic core while presenting the ionic heads to the surrounding water, so the lipid disperses throughout the flask instead of pooling. This is the physical chemistry that makes soap work. The other three structures possess no ionized or strongly hydrogen bonding region, so water molecules maximize their own hydrogen bonding by driving the intruders together, and each collects as a distinct oily phase. Dispersal behavior in water therefore reports directly on whether a described lipid is amphipathic or purely hydrophobic. (Choice A) Compound W is a wax, the kind of ester a soap could be made from, but micelle-forming behavior appears only after saponification hydrolyzes the ester and liberates the fatty acid as its salt; choosing the intact ester confuses the precursor with the product of that reaction. (Choice B) Free glycerol is highly water soluble, but in compound X all three of its hydroxyls are consumed by ester bonds to long chains, so the backbone's native polarity is masked and the molecule presents only hydrocarbon to water. (Choice D) Branched isoprene construction affects how the pure hydrocarbon packs against its own kind, but packing has nothing to do with water affinity; with no polar region at all, compound Z is the least dispersible molecule in the set. This is a Scientific Reasoning and Problem Solving question because it requires applying the structural requirement for amphipathicity to four described molecules and predicting from structure which one can disperse in water as micelles.$q$,
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
  SELECT q.id, 'A', 'process_step_confusion', $q$saponification precursor versus product$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$backbone polarity assumed to survive esterification$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$packing conflated with solubility$q$ FROM q;

-- Q4 . Wax versus triacylglycerol backbone identity . easy . skill 1 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Wax versus triacylglycerol backbone identity$q$,
    $q$Molecule 1 is glycerol esterified to three long unbranched hydrocarbon chains. Molecule 2 is a single long-chain carboxylic acid esterified to a single long-chain unbranched alcohol. Although both molecules contain only ester linkages, molecule 2 belongs to which lipid class?$q$,
    $q$[{"label":"A","text":"Triacylglycerol"},{"label":"B","text":"Phospholipid"},{"label":"C","text":"Sphingolipid"},{"label":"D","text":"Wax"}]$q$::jsonb,
    'D',
    $q$Lipids questions on class discrimination test whether the student assigns a lipid to its class by backbone identity rather than by linkage type. The answer is D because molecule 2 joins one long-chain fatty acid to one long-chain monohydric alcohol through a single ester bond, and that architecture is the definition of a wax. Both molecules are fatty acid esters, so the linkage itself cannot separate them; the discriminating feature is the identity of the alcohol. In molecule 1 the alcohol is glycerol, a three-carbon triol, and esterifying all three hydroxyls with long chains yields a triacylglycerol. In molecule 2 the alcohol is itself a long unbranched hydrocarbon, so the product is a two-chain ester with essentially no polar surface, which is why waxes serve organisms as waterproof coatings on leaves, feathers, and cuticles. The classification matters because backbone identity, not linkage chemistry, is what organizes the ester-built lipid classes, and the same principle later separates glycerophospholipids, built on glycerol, from sphingolipids, built on a long-chain amino alcohol. (Choice A) A triacylglycerol requires the glycerol backbone carrying three acyl chains; molecule 2 has a single acyl chain on a non-glycerol alcohol, so calling every fatty acid ester a fat overextends the class. (Choice B) Phospholipids of the glycerol type also build on a glycerol backbone, but they additionally require a phosphate-linked head group, and molecule 2 contains neither glycerol nor phosphorus. (Choice C) Sphingolipids do use a long-chain amino alcohol backbone, which superficially matches the description, but sphingosine binds its fatty acid through an amide rather than an ester and carries a polar head group at its terminal carbon, neither of which molecule 2 shows. This is a Knowledge of Scientific Concepts and Principles question because it asks the student to recall the defining backbones of the ester-built lipid classes and apply that knowledge to classify a structure supplied only as a prose description.$q$,
    'easy',
    '5D',
    $q$Lipids$q$,
    'biochemistry',
    1,
    70
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$linkage type mistaken for class identity$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', $q$neighboring ester class without its required head group$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$backbone similarity without linkage match$q$ FROM q;

-- Q5 . Glycerol versus sphingosine backbone classification . medium . skill 2 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Glycerol versus sphingosine backbone classification$q$,
    $q$Analysis of a membrane extract identifies two phosphate-bearing lipids. Lipid 1 carries a phosphocholine head group on a three-carbon alcohol scaffold whose remaining two positions are esterified to long-chain fatty acids. Lipid 2 carries a phosphocholine head group on a long-chain amino alcohol whose single fatty acid is attached through an amide bond. How should the two lipids be classified?$q$,
    $q$[{"label":"A","text":"Both lipids are glycerophospholipids"},{"label":"B","text":"Lipid 1 is a sphingolipid and Lipid 2 is a glycerophospholipid"},{"label":"C","text":"Lipid 1 is a glycerophospholipid and Lipid 2 is a sphingolipid"},{"label":"D","text":"Lipid 1 is a glycerophospholipid and Lipid 2 is a glycosphingolipid"}]$q$::jsonb,
    'C',
    $q$This Lipids question tests the classification of phosphate-bearing membrane lipids, which is decided by the backbone each lipid is built on rather than by its head group. The answer is C because the described linkages identify the two backbones. A three-carbon alcohol scaffold that accepts fatty acids through ester bonds is glycerol, so Lipid 1, with two esterified fatty acids and a phosphocholine group on the third position, is a glycerophospholipid, specifically phosphatidylcholine. A long-chain amino alcohol that binds its single fatty acid through an amide bond is sphingosine, because only an amine nitrogen can supply that amide linkage; a lipid built on sphingosine is a sphingolipid. Since this particular sphingolipid also carries phosphocholine, it is sphingomyelin, the major phosphate-containing member of the sphingolipid family. The two families can therefore present identical head groups, and the only reliable discriminator is the ester-to-glycerol versus amide-to-sphingosine backbone chemistry. (Choice A) A phosphate head group does not define the glycerophospholipid class. Sphingomyelin carries phosphocholine yet is a sphingolipid, because classification follows the backbone, not the head group; two lipids with the same head group can sit in different families. (Choice B) This reverses the two assignments. Ester bonds to a three-carbon scaffold require the hydroxyl groups of glycerol, and the amide bond requires the amine of sphingosine, so Lipid 1 must be the glycerophospholipid and Lipid 2 the sphingolipid. (Choice D) Lipid 2 is placed on the correct sphingosine backbone, but a glycosphingolipid carries one or more sugars as its head group instead of phosphate. A sphingosine-based lipid bearing phosphocholine is a phosphosphingolipid, better known as sphingomyelin. This is a Scientific Reasoning and Problem Solving question because it requires translating described bond types into backbone identities and then assigning each unnamed lipid to its structural class.$q$,
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
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', NULL FROM q;

-- Q6 . Terpene versus steroid structural discrimination . medium . skill 2 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Terpene versus steroid structural discrimination$q$,
    $q$Three newly characterized plant molecules are described below.

I. A 30-carbon branched hydrocarbon whose five-carbon repeating units are joined in a single continuous chain with no rings
II. A molecule whose core consists of three six-membered rings and one five-membered ring, each sharing an edge with its neighbor
III. A ten-carbon molecule assembled from two five-carbon branched units, with one end closed into a single ring that is not fused to any other ring

Which of the molecules should be classified as terpenes?$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"I and III"},{"label":"C","text":"II and III"},{"label":"D","text":"I, II, and III"}]$q$::jsonb,
    'B',
    $q$This Lipids question tests the structural boundary between terpenes and steroids within the isoprenoid family. The answer is B because molecules I and III are isoprene assemblies while molecule II carries the defining steroid scaffold. Terpenes are built by joining five-carbon isoprene units, and the class tolerates a wide range of final shapes: fully open chains, single rings, and partially cyclized frameworks all qualify as long as the molecule remains an isoprene assembly rather than a fused tetracyclic nucleus. Molecule I, a 30-carbon chain of five-carbon repeating units, matches squalene, a triterpene assembled from six isoprene units. Molecule III, ten carbons from two isoprene units with one non-fused ring, matches a cyclic monoterpene such as limonene; closing a single ring does not remove a molecule from the terpene class. Molecule II, in contrast, presents three six-membered rings and one five-membered ring fused edge to edge, which is the steroid nucleus, so it is classified as a steroid regardless of its biosynthetic ancestry. (Choice A) Molecule I is correctly included, but this choice wrongly excludes molecule III on the grounds that it contains a ring. Partial cyclization is common among terpenes, and one non-fused ring does not create a steroid. (Choice C) This selection reverses the defining criterion: it counts the fused tetracyclic molecule II as a terpene while rejecting the open-chain assembly I, which is the clearest terpene of the three. (Choice D) It is true that steroids are ultimately assembled from isoprene units, since squalene cyclizes on the pathway to sterols, but classification follows the finished architecture. Once a molecule displays the fused four-ring nucleus it is a steroid, not a terpene. This is a Scientific Reasoning and Problem Solving question because it requires applying the isoprene-assembly versus fused-ring criterion to three described structures and sorting each one into the correct lipid class.$q$,
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
  SELECT q.id, 'A', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', NULL FROM q;

-- Q7 . Triacylglycerol backbone structure . easy . skill 1 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Triacylglycerol backbone structure$q$,
    $q$Adipocytes hold nearly all of their stored lipid as droplets of a single class of neutral lipid. Which description matches the covalent structure of one molecule of that lipid?$q$,
    $q$[{"label":"A","text":"Three fatty acids, each joined through an ester bond to one hydroxyl group of glycerol"},{"label":"B","text":"Two fatty acids joined through ester bonds to glycerol, with a phosphate-containing group on the third carbon"},{"label":"C","text":"One fatty acid joined through an amide bond to the amine of a long-chain amino alcohol"},{"label":"D","text":"One long-chain fatty acid joined through an ester bond to a single long-chain alcohol"}]$q$::jsonb,
    'A',
    $q$This Lipids question tests the covalent structure of triacylglycerol, the neutral lipid that fills adipocyte droplets. The answer is A because a triacylglycerol consists of a glycerol backbone whose three hydroxyl groups are each esterified to a fatty acid. Glycerol supplies the three-carbon scaffold, each ester bond forms between one glycerol hydroxyl and the carboxyl group of a fatty acid, and the finished molecule carries no phosphate or other charged group. That absence of a polar head group is what makes triacylglycerols neutral lipids, and it explains why they cluster into the hydrophobic droplets seen in fat cells rather than spreading into membranes. The three fatty acids attached to one glycerol are often different from one another, but the triester architecture itself is constant. (Choice B) Two ester-linked fatty acids on glycerol with a phosphate-containing group on the third carbon describes a glycerophospholipid. The glycerol-ester backbone is correct as far as it goes, but the phosphate head group creates an amphipathic membrane lipid, not the neutral lipid of storage droplets. (Choice C) A single fatty acid joined through an amide bond to a long-chain amino alcohol describes a ceramide, the simplest lipid built on the sphingosine backbone. Sphingosine-based lipids reside in membranes and are never the droplet storage form. (Choice D) One fatty acid esterified to one long-chain alcohol describes a wax, the protective coating found on plant surfaces and in the ear canal, not the lipid stored inside adipocytes. This is a Knowledge of Scientific Concepts and Principles question because it asks for direct recall of the glycerol-plus-three-ester architecture that defines a triacylglycerol.$q$,
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
  SELECT q.id, 'B', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', NULL FROM q;

-- Q8 . Steroid nucleus recognition in novel isolates . hard . skill 4 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Steroid nucleus recognition in novel isolates$q$,
    $q$A natural products laboratory reports the ring systems of four uncharacterized isolates. Isolate 1 contains four six-membered rings, each fused to the next along a shared edge. Isolate 2 is a 30-carbon branched chain assembled from five-carbon units, with one end closed into a single six-membered ring and the remainder left as open chain. Isolate 3 contains three six-membered rings fused along shared edges, with a five-membered ring attached to the terminal ring through a single carbon-carbon bond. Isolate 4 contains three six-membered rings and one five-membered ring, each fused to its neighbor along a shared edge. Which isolate contains a steroid nucleus?$q$,
    $q$[{"label":"A","text":"Isolate 1"},{"label":"B","text":"Isolate 2"},{"label":"C","text":"Isolate 3"},{"label":"D","text":"Isolate 4"}]$q$::jsonb,
    'D',
    $q$This Lipids question tests recognition of the steroid nucleus inside unfamiliar molecules described only by their reported ring data. The answer is D because Isolate 4 satisfies both requirements of the steroid nucleus: the correct ring inventory of three six-membered rings plus one five-membered ring, and full fusion, with every ring holding an edge in common with its neighbor. Recognizing a steroid in an uncharacterized molecule demands checking these two independent structural criteria in sequence. First, the inventory must be exactly three six-membered rings and one five-membered ring; second, all four rings must be fused, meaning that adjacent rings share an edge and the two carbons on it. Only Isolate 4 passes both tests, and applying the same two-step screen eliminates each remaining isolate on exactly one criterion, which is why an incomplete definition leaves several options looking acceptable. (Choice A) Isolate 1 is fully fused and tetracyclic, so it survives a screen based only on the popular shorthand that a steroid is four fused rings. Its rings are all six-membered, however, and the steroid nucleus requires that one of the four be five-membered. (Choice B) Isolate 2 is a partially cyclized assembly of five-carbon units, which identifies it as a terpene. Terpenes are the biosynthetic relatives of steroids, and a 30-carbon isoprenoid resembles squalene, but a mostly open chain bearing one ring is nothing like a fused tetracyclic nucleus. (Choice C) Isolate 3 has the correct ring inventory of three six-membered rings and one five-membered ring, so it survives a screen based only on counting. Its five-membered ring hangs from the fused system by a single rotatable bond rather than a shared edge, so the four rings never form the single fused nucleus that defines a steroid. This is a Data-based and Statistical Reasoning question because it requires evaluating reported structural data for four unknown molecules and testing each described ring system against the defining criteria of the steroid nucleus.$q$,
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
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', NULL FROM q;

-- Q9 . Triacylglycerol complete hydrolysis stoichiometry . easy . skill 2 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Triacylglycerol complete hydrolysis stoichiometry$q$,
    $q$A neutral storage lipid consists of a three-carbon backbone in which each backbone carbon bears an ester linkage to a long hydrocarbon chain. What does complete acid-catalyzed hydrolysis of one mole of this lipid yield, accounting for water?$q$,
    $q$[{"label":"A","text":"One mole of glycerol and three moles of free fatty acids, with three moles of water released"},{"label":"B","text":"One mole of glycerol and one mole of free fatty acid, with one mole of water consumed"},{"label":"C","text":"One mole of glycerol and three moles of free fatty acids, with three moles of water consumed"},{"label":"D","text":"One mole of glyceraldehyde and three moles of free fatty acids, with three moles of water consumed"}]$q$::jsonb,
    'C',
    $q$This Lipids question tests the structure of a triacylglycerol and the stoichiometry of its complete hydrolysis. The answer is C because a three-carbon backbone carrying three ester-linked hydrocarbon chains is a triacylglycerol: one molecule of glycerol joined to three fatty acids through three ester bonds. Hydrolysis is the reverse of the dehydration reaction that originally built those bonds. Each ester bond that is cleaved incorporates one molecule of water, splitting the linkage into an alcohol group, which is returned to the backbone, and a carboxylic acid group, which leaves with the hydrocarbon chain. Because the molecule contains exactly three ester bonds, complete hydrolysis of one mole of the lipid consumes three moles of water and liberates one mole of glycerol together with three moles of free fatty acids. Under acidic conditions the acid is only a catalyst, and the fatty acids are released in their neutral, protonated form. (Choice A) reverses the direction of the water balance. Water is released when the ester bonds are formed during condensation of glycerol with three fatty acids; the question asks about the cleavage direction, in which each bond broken requires that a water molecule be consumed, not produced. (Choice B) undercounts the linkages. One fatty acid and one water would account for hydrolysis of a single ester bond, but the backbone described bears a chain on each of its three carbons, so three separate bonds must be cleaved and the products scale accordingly. (Choice D) misidentifies the backbone. A three-carbon unit that anchors an ester linkage at every carbon must supply three hydroxyl groups, which marks it as glycerol, a triol. Glyceraldehyde is the three-carbon aldose: one of its carbons is an aldehyde carbonyl, leaving only two hydroxyls available, so it could not carry the three ester-linked chains the stem describes. This is a Scientific Reasoning and Problem Solving question because it requires recognizing an unnamed structure as a triacylglycerol and then applying ester hydrolysis stoichiometry to predict both the organic products and the water consumed.$q$,
    'easy',
    '5D',
    $q$Lipids$q$,
    'biochemistry',
    2,
    65
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'scale_unit_error', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', NULL FROM q;

-- Q10 . Saponification product identification . medium . skill 2 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Saponification product identification$q$,
    $q$A soap maker refluxes solid beef fat with excess concentrated sodium hydroxide until no neutral lipid remains, then lets the mixture cool. Which organic products dominate the final mixture?$q$,
    $q$[{"label":"A","text":"Glycerol and three equivalents of long-chain fatty acid carboxylate salts"},{"label":"B","text":"Three equivalents of glycerol and one equivalent of a long-chain fatty acid carboxylate salt"},{"label":"C","text":"Diacylglycerol and one equivalent of a long-chain fatty acid carboxylate salt"},{"label":"D","text":"A three-carbon tricarboxylate salt and three equivalents of long-chain fatty alcohols"}]$q$::jsonb,
    'A',
    $q$This Lipids question tests saponification, the base-driven cleavage of the ester bonds in a fat. The answer is A because beef fat is composed of triacylglycerols, each built from a single glycerol backbone esterified to three fatty acids. Hot, excess sodium hydroxide attacks each of the three ester bonds, so complete reaction returns the intact glycerol backbone plus three freed acyl chains, and because the medium still contains excess strong base, those chains persist as long-chain carboxylate salts, which is precisely what soap is. The final mixture is therefore dominated by glycerol and three equivalents of fatty acid carboxylate salts for every molecule of fat consumed. (Choice B) inverts the stoichiometric ratio. Each fat molecule contains one three-carbon backbone carrying three chains, so cleavage releases backbone and chains in a one to three ratio; three glycerols per single chain would require three backbones sharing one fatty acid, the opposite of triacylglycerol connectivity. (Choice C) describes a reaction stopped after a single cleavage. A diacylglycerol still carries two ester bonds and is itself a neutral lipid, so its persistence contradicts the condition that the reaction ran until no neutral lipid remained; excess base drives all three esters to cleavage. (Choice D) swaps the identities of the two ester partners. In a fat, the backbone contributes the alcohol oxygens and the chains contribute the carbonyl carbons, so cleavage frees the chains as carboxylates and the backbone as a triol; a backbone-derived carboxylate paired with fatty alcohols reverses that assignment. This is a Scientific Reasoning and Problem Solving question because it requires mapping triacylglycerol connectivity onto the identity and ratio of the products released when every ester bond is cleaved by excess base.$q$,
    'medium',
    '5D',
    $q$Lipids$q$,
    'biochemistry',
    2,
    70
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'scale_unit_error', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', NULL FROM q;

-- Q11 . Irreversibility of base-mediated ester cleavage . hard . skill 2 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Irreversibility of base-mediated ester cleavage$q$,
    $q$When a fatty acid ester is warmed with aqueous acid, hydrolysis settles into an equilibrium mixture that still contains appreciable ester. When the same ester is warmed with aqueous sodium hydroxide, cleavage goes essentially to completion. What property of the basic conditions accounts for the difference?$q$,
    $q$[{"label":"A","text":"Hydroxide is a stronger nucleophile than water, so the forward cleavage step is faster"},{"label":"B","text":"Basic conditions protonate the released alcohol, blocking its return attack on the acyl carbon"},{"label":"C","text":"Hydroxide serves as a regenerated catalyst that accelerates the forward and reverse steps equally"},{"label":"D","text":"The released acid is deprotonated to a carboxylate that cannot re-form the ester, removing the reverse step"}]$q$::jsonb,
    'D',
    $q$This Lipids question tests why saponification, unlike acid-catalyzed hydrolysis, drives ester cleavage to completion. The answer is D because the two conditions differ in the fate of the carboxylic acid product. Acid-catalyzed hydrolysis is genuinely reversible: the freed acid retains its electrophilic carbonyl, the alcohol can attack it and re-form the ester, and the system settles wherever that reversible interconversion dictates, leaving appreciable ester behind. Under basic conditions, every acid molecule released is immediately stripped of its proton by hydroxide, giving a resonance-stabilized carboxylate anion. That anion is a very poor electrophile and cannot be re-esterified by a neutral alcohol under the reaction conditions, so the reverse step is effectively removed. With product continuously siphoned into an unreactive form, cleavage proceeds until the ester is exhausted, which is also why saponification consumes hydroxide stoichiometrically rather than catalytically. (Choice A) is true but answers the wrong question. Hydroxide is indeed the stronger nucleophile, which makes the forward step faster, but a rate enhancement alone cannot change where a reversible process ultimately settles; only shutting down the reverse step explains completion. (Choice B) applies acid-base logic in the wrong direction to the wrong species. Basic conditions cannot protonate an alcohol; if anything, hydroxide deprotonates a small fraction of it, and the alcohol is not the product whose ionization controls the outcome. (Choice C) misidentifies the role of hydroxide. A regenerated catalyst accelerates both directions and leaves the final composition untouched, whereas hydroxide here is consumed, one equivalent per ester cleaved, in forming the carboxylate. This is a Scientific Reasoning and Problem Solving question because it requires connecting the acid-base speciation of a reaction product to the reason a normally reversible cleavage is driven to completion.$q$,
    'hard',
    '5D',
    $q$Lipids$q$,
    'biochemistry',
    2,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', NULL FROM q;

-- Q12 . Saponification assay for lipid linkage type . medium . skill 3 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Saponification assay for lipid linkage type$q$,
    $q$A researcher purifies a neutral storage lipid from bovine adipose tissue and a second neutral lipid from an archaeon that joins its hydrocarbon chains to a backbone through ether linkages. Both samples are refluxed in concentrated potassium hydroxide, acidified, and shaken with an organic solvent. Which extraction result supports the hypothesis that the adipose lipid joins its chains through ester linkages?$q$,
    $q$[{"label":"A","text":"Long-chain fatty acids are recovered from both samples"},{"label":"B","text":"Long-chain fatty acids are recovered from the adipose sample but not the archaeal sample"},{"label":"C","text":"Long-chain fatty acids are recovered from the archaeal sample but not the adipose sample"},{"label":"D","text":"Long-chain fatty alcohols are recovered from the adipose sample but not the archaeal sample"}]$q$::jsonb,
    'B',
    $q$This Lipids question tests the use of saponification as a diagnostic experiment for ester linkages. The answer is B because base-driven hydrolysis is chemistry specific to the ester bond. Refluxing an ester-linked storage lipid in concentrated potassium hydroxide cleaves all of its ester bonds and releases the chains as carboxylates; acidifying then protonates them to free fatty acids, which partition into the organic solvent. Ether bonds, by contrast, are far more robust and survive hot base, which is one reason organisms in harsh environments favor them. The archaeal sample should therefore yield no freed chains, and it functions as a negative control showing that the workup itself does not generate fatty acids from a lipid lacking ester bonds. The informative pattern is the asymmetry: fatty acids from the adipose lipid, nothing from the archaeal lipid. (Choice A) would undermine the experiment rather than support the hypothesis. Recovery from both samples would imply that the treatment cleaves ether linkages as readily as esters, contrary to their known resistance to base, and would strip the assay of any power to discriminate between the two linkage types. (Choice C) reverses the expected pattern. It assigns base-labile behavior to the ether-linked lipid and base resistance to the putatively ester-linked one, the opposite of what the hypothesis predicts. (Choice D) names the wrong product class. When an ester is cleaved by base, the chain departs as the carboxylate because the acyl carbonyl belongs to the chain; long-chain alcohols would instead point to cleavage of an ether linkage or to a reductive workup, neither of which applies here. This is a Reasoning about the Design and Execution of Research question because it asks which outcome of a paired experiment with a built-in negative control would support the hypothesized linkage chemistry of the storage lipid.$q$,
    'medium',
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
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', NULL FROM q;

-- Q13 . Soap micelle self-assembly geometry . easy . skill 2 . 2A
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Soap micelle self-assembly geometry$q$,
    $q$Boiling a triacylglycerol with concentrated sodium hydroxide yields glycerol plus the sodium salt of a long-chain fatty acid, a molecule joining one charged head to a single flexible hydrocarbon tail. Dispersed in water above a threshold amount, these salts spontaneously aggregate. Which arrangement do the aggregates adopt?$q$,
    $q$[{"label":"A","text":"Extended double-layered sheets in which two rows of tails meet in the middle, with heads on both outer faces"},{"label":"B","text":"Hollow shells that enclose an internal pool of water behind a single curved wall of molecules"},{"label":"C","text":"Compact spheres whose tails pack together in a water-free core while the ionic groups line the outer surface facing the solvent"},{"label":"D","text":"Compact spheres whose ionic groups cluster at the center while the tails extend outward into the water"}]$q$::jsonb,
    'C',
    $q$This Lipids question tests how the two-part architecture of a soap molecule, an ionic head joined to a single hydrocarbon tail, dictates the geometry of the aggregates it forms in water. The answer is C because a fatty-acid salt is a classic single-chain amphiphile. The charged carboxylate head interacts favorably with water, while the long hydrocarbon tail cannot, so above a threshold level the molecules arrange themselves to hide every tail from solvent while keeping every head solvated. A single flexible tail tapering away from a comparatively bulky ionic head gives each molecule a roughly cone-shaped profile, and cones pack most naturally into a small, sharply curved sphere. The product is a micelle: a compact ball whose interior is an essentially anhydrous mass of intertwined tails and whose exterior is a shell of charged heads in full contact with the water. (Choice A) Extended double-layered sheets are the signature arrangement of two-tailed lipids such as glycerophospholipids; a second tail widens the molecule into a roughly cylindrical shape that packs side by side into flat layers, whereas the cone profile of a one-tailed soap is a poor fit for a planar sheet and instead favors high curvature. (Choice B) A wall enclosing an internal pool of water describes a vesicle or liposome, which requires a double-layered boundary presenting heads to both an inner and an outer aqueous space; an aggregate of single-tailed soap molecules has no aqueous interior at all, because the buried tails completely fill its core. (Choice D) This choice inverts the orientation of the monomer. Sequestering the charged heads in a dry core would sacrifice their strong ion-dipole interactions with the solvent while simultaneously forcing every hydrocarbon chain into maximal contact with water, so this arrangement maximizes exactly the unfavorable exposure that aggregation exists to eliminate. This is a Scientific Reasoning and Problem Solving question because it requires predicting the geometry of a self-assembled aggregate from the polarity and shape of its monomer rather than recalling a memorized diagram.$q$,
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
  SELECT q.id, 'A', 'adjacent_fact', $q$wrong lipid class geometry$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$micelle-liposome conflation$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$inverted orientation$q$ FROM q;

-- Q14 . Entropic driving force of micellization . hard . skill 2 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Entropic driving force of micellization$q$,
    $q$Calorimetry shows that a sodium alkanoate soap aggregates into micelles at 25 degrees Celsius with an enthalpy change close to zero, yet the process is strongly spontaneous. Which of the statements below account for the spontaneity?

I. Water molecules held in ordered, cage-like arrangements around each dispersed hydrocarbon chain are released into bulk solvent when the chains bury one another.
II. The soap molecules themselves gain positional freedom when they leave free solution and pack into an aggregate.
III. The total entropy of the system rises enough to make the free energy change negative even without an enthalpic contribution.$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"I and III"},{"label":"C","text":"II and III"},{"label":"D","text":"I, II, and III"}]$q$::jsonb,
    'B',
    $q$This Lipids question probes the thermodynamic driving force behind micelle formation by soaps, the hydrophobic effect. The answer is B because statements I and III are correct while statement II is not. When a hydrocarbon chain sits alone in water, the surrounding water cannot hydrogen-bond to it and instead organizes into ordered, cage-like shells that preserve water-to-water hydrogen bonding at the cost of positional freedom, a state with fewer available microstates. When the chains cluster into a micelle core, much of that structured water is liberated into bulk solvent, where far more microstates are available, so the entropy of the water rises sharply, exactly as statement I describes. Because the measured enthalpy change is near zero, this solvent entropy gain is what drives the free energy change negative, which is the content of statement III. Statement II carries the wrong sign for the amphiphile itself: a soap molecule that leaves free solution and packs into a defined aggregate loses translational and conformational freedom, so its own entropy falls. Micellization proceeds because the entropy gained by the released water outweighs the entropy lost by the confined amphiphiles. (Choice A) Statement I is accurate but incomplete on its own; without statement III the reasoning never connects the release of ordered water to the negative free energy change that the calorimetric data demand an entropic term to supply. (Choice C) This pairing keeps the correct thermodynamic conclusion but attributes the entropy gain to the soap molecules; the amphiphiles become more ordered upon aggregation, not less, so statement II cannot be part of the explanation. (Choice D) Including all three statements imports the same error, since II asserts an entropy increase for molecules that are in fact surrendering freedom as they pack into an organized aggregate. This is a Scientific Reasoning and Problem Solving question because it requires partitioning an overall entropy change between solvent and solute and using thermodynamic sign logic to identify which contributions can drive a spontaneous process when the enthalpy change is negligible.$q$,
    'hard',
    '5D',
    $q$Lipids$q$,
    'biochemistry',
    2,
    95
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$true but incomplete numeral set$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$solute-entropy error$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$over-inclusive numeral set$q$ FROM q;

-- Q15 . Grease sequestration cleaning mechanism evidence . medium . skill 3 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Grease sequestration cleaning mechanism evidence$q$,
    $q$A detergent researcher proposes that aqueous soap lifts olive oil from cotton by enclosing oil droplets within the nonpolar interior of self-assembled particles whose anionic exteriors keep them suspended, so rinse water carries the assemblies away. A rival proposal holds that the soap solution instead cleaves the ester linkages of the oil. Which finding in the collected rinse water most strongly favors the first proposal over the rival?$q$,
    $q$[{"label":"A","text":"The oil is recovered chemically unchanged and co-fractionates with the surfactant rather than pooling as a separate layer"},{"label":"B","text":"Glycerol and free long-chain carboxylic acids appear in the rinse water in place of the intact oil"},{"label":"C","text":"The rinse water exhibits a markedly lower surface tension than pure water does"},{"label":"D","text":"The rinse water conducts an electric current far more readily than pure water does"}]$q$::jsonb,
    'A',
    $q$This Lipids question examines the physical mechanism by which soap cleans and asks which experimental observation would distinguish it from a chemical alternative. The answer is A because the sequestration mechanism makes two linked predictions: the grease should survive washing with its covalent structure intact, and it should travel with the surfactant assemblies rather than remain as a distinct oily phase. Recovering unchanged oil that co-fractionates with the surfactant satisfies both predictions at once, and it simultaneously undercuts the rival ester-cleavage proposal, which requires the oil to emerge chemically altered. A discriminating experiment is one whose predicted outcome differs between the hypotheses, and this observation meets that standard. In practice the fractionation could be run by centrifuging or dialyzing the rinse water and assaying which fraction the oil travels with, so the prediction is directly testable. (Choice B) Finding glycerol and free long-chain acids in place of intact oil is evidence in the wrong direction: those are precisely the hydrolysis products the rival proposal predicts, so this result would count for ester cleavage and against encapsulation. (Choice C) Lowered surface tension is a genuine property of any surfactant solution, but it arises from molecules accumulating at the air-water boundary and would be observed whether the oil ends up encapsulated or hydrolyzed, so it cannot separate the two proposals. (Choice D) Better conduction of current merely confirms that the soap dissociates into ions in water; both hypotheses invoke the same ionic soap, so this measurement carries no information about how the oil is removed. This is a Reasoning about the Design and Execution of Research question because it asks which observable result would discriminate between two competing mechanistic hypotheses rather than which result is merely consistent with one of them.$q$,
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
  SELECT q.id, 'B', 'reversed_relationship', $q$evidence for the rival hypothesis$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$true but non-discriminating result$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$irrelevant true property$q$ FROM q;

-- Q16 . Critical micelle concentration monomer plateau . hard . skill 4 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Critical micelle concentration monomer plateau$q$,
    $q$A researcher adds a single-chain sulfonate surfactant to water in steps and, after each step, measures how much of it remains singly dispersed.

| Total added (mM) | Singly dispersed (mM) |
|---|---|
| 2 | 2.0 |
| 5 | 5.0 |
| 8 | 7.9 |
| 12 | 8.0 |
| 20 | 8.0 |

What accounts for the behavior of the system past a total of 8 mM?$q$,
    $q$[{"label":"A","text":"The solution has reached its solubility limit, so molecules added past that point precipitate out of solution as a solid"},{"label":"B","text":"Aggregates formed near 8 mM swell to absorb the later additions, each one holding progressively more molecules"},{"label":"C","text":"Newly formed aggregates progressively strip molecules from the dispersed pool, which will steadily shrink as more is added"},{"label":"D","text":"Material added past that point assembles into additional micelles, leaving the level of free monomers pinned at the critical micelle concentration"}]$q$::jsonb,
    'D',
    $q$This Lipids question presents titration-style surfactant data and tests interpretation of the critical micelle concentration. The answer is D because the table shows two regimes. Through the first three rows the free pool tracks the total nearly one to one, and the small dip to 7.9 mM at a total of 8 mM signals that aggregation is just beginning. Past that point the free pool stops responding entirely, holding at 8.0 mM even as the total climbs to 20 mM, which places the breakpoint at about 8 mM. That plateau marks the critical micelle concentration: once free monomers reach this level, self-association becomes favorable, and essentially every molecule added afterward partitions into micelles instead of the free pool. Because micelles of a given surfactant assemble with a characteristic aggregation number, continued addition multiplies the number of micelles in solution while the free monomer level, in dynamic exchange with them, stays fixed. (Choice A) A true solubility limit would also cap the free pool, but a saturated solution sheds its excess as a visible solid phase; a surfactant past its transition instead stays fully in solution as soluble aggregates, which is why such solutions remain clear and keep gaining cleaning capacity with further addition. (Choice B) Growth of existing aggregates could in principle absorb added material, but the balance of head repulsion and tail packing sets a preferred aggregate size for a given surfactant, so later additions generate more micelles of similar size rather than ever-larger ones; the mode of accommodation, number versus size, is what this choice gets wrong. (Choice C) This choice predicts the wrong trajectory for the free pool: if aggregates steadily drained material that had already dissolved, the plateau would slope downward, whereas the values hold flat at 8.0 mM from 12 through 20 mM, indicating steady-state exchange rather than depletion. This is a Data-based and Statistical Reasoning question because it requires locating the breakpoint in a saturation curve and inferring the molecular partitioning that keeps one measured quantity constant while the total keeps rising.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$CMC confused with solubility limit$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$right process, wrong mode$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', $q$wrong direction of change$q$ FROM q;

-- Q17 . Wax ester structure and inertness . medium . skill 2 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Wax ester structure and inertness$q$,
    $q$The leaves of a desert shrub are coated with a lipid in which a straight, fully saturated 26-carbon fatty acid is joined through a single ester bond to a straight, fully saturated 30-carbon alcohol. The coating is a firm solid that liquid water cannot penetrate. Which feature of this lipid most directly produces both properties?$q$,
    $q$[{"label":"A","text":"Its single ester group is ionized at physiological pH, and attraction between the charged groups locks neighboring molecules into a rigid ionic lattice."},{"label":"B","text":"Nearly the whole molecule is nonpolar hydrocarbon, so neighboring chains pack tightly and present essentially no polar region for water to bind."},{"label":"C","text":"Its chains pack closely, but the solid is held together mainly by hydrogen bonds that the ester oxygens donate to adjacent molecules."},{"label":"D","text":"Covalent cross-links form between adjacent molecules, creating a continuous polymer network like that of a plastic."}]$q$::jsonb,
    'B',
    $q$This Lipids question tests how the structure of a wax, a single ester formed between a long-chain fatty acid and a long-chain alcohol, produces its characteristic hardness and water impermeability. The answer is B because nearly every atom in this lipid belongs to one of two long, straight, saturated hydrocarbon chains, with only one small ester group interrupting them. Straight saturated chains maximize surface contact with their neighbors, so cumulative dispersion attractions between chains hold the solid together and push its melting point well above any temperature the plant will experience. At the same time, the molecule gives water almost nothing to grip: one ester group among more than fifty carbons cannot offset the overwhelming hydrophobic character of the two tails, so water can neither dissolve the material nor pass through it. Compare a triacylglycerol, which carries three esters on a glycerol backbone: a wax carries a single ester between two hydrocarbon tails, which is why waxes are even more inert and water repellent than storage fats. (Choice A) Ester groups do not ionize at physiological pH. A free carboxylic acid could lose a proton, but esterification consumes that acidic proton, so no charged head groups exist and no ionic lattice can form. (Choice C) The packing claim is sound, but the cohesion claim fails: a wax ester contains no O-H or N-H group, so the molecule has no hydrogen bond donor. Its ester oxygens could only accept hydrogen bonds that nothing in the solid can supply, leaving chain-to-chain dispersion attractions as the true cohesive force. (Choice D) Wax molecules remain discrete; they associate through noncovalent packing, not covalent bonds. A covalently cross-linked network describes a polymer such as cutin, the polyester scaffold of the plant cuticle, not the wax deposited on and in it. This is a Scientific Reasoning and Problem Solving question because it requires connecting the bonding pattern and chain composition of a described, unfamiliar molecule to two macroscopic properties rather than recalling a memorized fact about waxes.$q$,
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
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', NULL FROM q;

-- Q18 . Wax barrier against water loss . easy . skill 2 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Wax barrier against water loss$q$,
    $q$A barley mutant cannot attach very long-chain fatty acids to very long-chain alcohols, so its leaf cuticle lacks the ester lipids normally deposited there. When wild-type and mutant seedlings are exposed to dry, moving air, which outcome is most likely for the mutant relative to the wild type?$q$,
    $q$[{"label":"A","text":"More rapid escape of moisture from the tissues beneath the surface"},{"label":"B","text":"Greater injury from ultraviolet radiation reaching the cells below"},{"label":"C","text":"Overheating, because the missing layer normally serves as the plant's chief insulation against heat exchange"},{"label":"D","text":"Swelling of interior tissues, because the missing layer normally provides the route through which water vapor exits"}]$q$::jsonb,
    'A',
    $q$This Lipids question tests the barrier role of waxes and asks the student to derive that role from wax structure. The answer is A because the cuticular esters, each formed from one very long fatty acid chain joined to one very long alcohol chain, build an almost purely hydrocarbon layer over the leaf. Tightly packed, saturated, nonpolar chains give a polar molecule like water no favorable route across, so an intact coating holds interior moisture in. A mutant unable to form these esters lacks that seal, and in dry moving air its wet interior tissues lose water by evaporation far faster than those of the wild type. The inference runs from structure to function: the same features that make a wax inert and solid, two long saturated tails joined through a single small ester group, are exactly what make the deposit an effective seal against water movement. The identical logic explains the water-repellent wax coatings on the feathers of aquatic birds and in the mammalian ear canal, where extreme nonpolarity blocks water traffic in whichever direction matters. (Choice B) Some cuticle components do absorb or scatter ultraviolet light, but that role is incidental to the chemistry described here, and the stem's stress is dry moving air, which threatens the plant with drying out, not with irradiation. (Choice C) A thin lipid film is not a meaningful thermal insulator, and nothing in the scenario involves temperature stress. This choice imports a heat-regulation role that the wax layer does not perform. (Choice D) This reverses the layer's relationship to water. The wax is a barrier that keeps water in, not the conduit through which water leaves; removing a barrier speeds water escape and cannot make water back up and accumulate inside the leaf. This is a Scientific Reasoning and Problem Solving question because it requires predicting the physiological outcome of a structural deficit by reasoning from the chemistry of the missing lipid layer to its barrier function.$q$,
    'easy',
    '5D',
    $q$Lipids$q$,
    'biochemistry',
    2,
    60
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', NULL FROM q;

-- Q19 . Isoprene unit counting in terpenes . medium . skill 4 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Isoprene unit counting in terpenes$q$,
    $q$Squalene, an open-chain hydrocarbon abundant in shark liver oil and human skin surface lipids, contains 30 carbon atoms and is assembled entirely from isoprene units. How many isoprene units are incorporated into one molecule of squalene?$q$,
    $q$[{"label":"A","text":"Two"},{"label":"B","text":"Three"},{"label":"C","text":"Six"},{"label":"D","text":"Fifteen"}]$q$::jsonb,
    'C',
    $q$This Lipids question tests the isoprene counting convention for terpenes and other isoprenoid lipids. The answer is C because an isoprene unit contains five carbon atoms, so a 30 carbon isoprenoid must be built from 30 divided by 5, or six, units. Isoprene itself is 2-methyl-1,3-butadiene, a branched five carbon diene. Cells never polymerize free isoprene; they condense the activated five carbon donors isopentenyl pyrophosphate and dimethylallyl pyrophosphate, generating the ten carbon geranyl, fifteen carbon farnesyl, and twenty carbon geranylgeranyl intermediates. Two fifteen carbon farnesyl groups then join tail to tail to give the thirty carbon squalene, and the biosynthetic route confirms the arithmetic: three units in each half, six in all. Keeping the two counting systems separate matters, because terpene class names are based on ten carbon blocks while isoprene accounting uses five carbon units, and a question can ask for either. (Choice A) Two is the number of isoprene units in a monoterpene, the C10 class that includes many plant fragrance compounds. Extending that pairing to every terpene ignores the larger classes entirely; a thirty carbon compound holds three times the carbons of a monoterpene. (Choice B) Three comes from dividing 30 by 10, counting monoterpene-sized blocks rather than isoprene units. That arithmetic explains why squalene is classified as a triterpene, but each such classification block contains two isoprene units, so the requested count is twice three, not three. (Choice D) Fifteen comes from dividing 30 by 2, as though the chain grew by two carbon increments. Growth in two carbon steps describes fatty acid synthesis from acetyl groups, a completely separate assembly line; isoprenoid chains lengthen five carbons at a time. This is a Data-based and Statistical Reasoning question because it requires taking the carbon count supplied in the stem and converting that quantitative datum into a number of building blocks using the correct unit size.$q$,
    'medium',
    '5D',
    $q$Lipids$q$,
    'biochemistry',
    4,
    70
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'scale_unit_error', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', NULL FROM q;

-- Q20 . Hard water soap failure experiment . hard . skill 3 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Hard water soap failure experiment$q$,
    $q$A student's sodium stearate soap lathers and removes grease in distilled water, but in local well water it lathers poorly and leaves a gray, insoluble residue. She hypothesizes that dissolved divalent cations in the well water are inactivating the soap. Which procedure would most directly test her hypothesis?$q$,
    $q$[{"label":"A","text":"Boil a portion of the well water, let it cool, and test whether newly added soap performs better in it"},{"label":"B","text":"Acidify a portion of distilled water until added soap stops working, demonstrating that the soap can be inactivated in solution"},{"label":"C","text":"Collect the gray residue and assay it for glycerol released as the soap decomposed"},{"label":"D","text":"Treat a fresh portion of the well water with a chelating agent that binds doubly charged metal ions, then test whether newly added soap foams and cleans in it"}]$q$::jsonb,
    'D',
    $q$This Lipids question tests the hard water failure mode of soap inside an experimental design frame. The answer is D because a chelating agent selectively sequesters doubly charged metal ions such as calcium and magnesium while leaving every other property of the well water unchanged, so it manipulates exactly one variable, the one named in the hypothesis. Soap cleans because each stearate anion is amphipathic: the charged carboxylate head keeps it dispersed in water while the long hydrocarbon tail buries grease inside micelles. Calcium and magnesium ions bridge pairs of carboxylate heads to form an insoluble salt, the familiar gray scum, stripping the surfactant out of solution. If chelation restores foaming and cleaning, divalent cations were the cause; if performance stays poor, the hypothesis is undermined. Either result is interpretable, the mark of a well designed test. (Choice A) Boiling can soften water, but only temporary hardness, the fraction paired with bicarbonate, precipitates on heating, and boiling also changes dissolved gas content and concentrates the remaining solutes. With several variables moving at once, neither outcome would cleanly implicate or clear divalent cations. (Choice B) Acidifying distilled water demonstrates a real but different failure mode: protonating the carboxylate head erases the charge that makes soap amphipathic. Showing that acid can disable soap in a separate sample establishes nothing about what the well water contains, so it cannot test this hypothesis. (Choice C) The gray residue is a calcium or magnesium salt of the fatty acid anion. Glycerol separates from the fatty acid salts during soap manufacture and is not regenerated when soap precipitates, so this assay probes a transformation that does not occur. This is a Reasoning about the Design and Execution of Research question because it asks which manipulation isolates the single hypothesized variable and yields an interpretable result about why the soap failed.$q$,
    'hard',
    '5D',
    $q$Lipids$q$,
    'biochemistry',
    3,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', NULL FROM q;

-- Q21 . Cholesterol's hydrophobic architecture . medium . skill 1 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Cholesterol's hydrophobic architecture$q$,
    $q$Lipids are defined operationally: a compound joins the class when it dissolves preferentially in nonpolar organic solvents rather than in water. Cholesterol, despite bearing one hydroxyl group, meets this standard. Which structural feature of cholesterol best accounts for this solvent behavior?$q$,
    $q$[{"label":"A","text":"Fused hydrocarbon rings and a short branched side chain form nearly the whole molecular surface, leaving the lone polar group heavily outweighed"},{"label":"B","text":"Its hydroxyl group makes no contribution to interactions with water, so no portion of the molecule is drawn toward a polar solvent"},{"label":"C","text":"The rigidity created by joining the rings into one fused unit is itself what excludes water, independent of which atoms compose the rings"},{"label":"D","text":"The hydroxyl group confers net polarity on the free molecule, which favors nonpolar solvents only once that group is esterified to a fatty acid"}]$q$::jsonb,
    'A',
    $q$Lipids, unlike proteins or nucleic acids, are grouped by how they behave in solvents rather than by a shared covalent backbone, and this question asks which feature of cholesterol's architecture places it firmly on the hydrophobic side of that dividing line. The answer is A because the four fused hydrocarbon rings, together with the short branched tail attached at carbon 17 and the methyl groups projecting from the ring junctions, account for nearly all of the molecule's surface. Almost every atom a solvent encounters is carbon or hydrogen, capable only of weak London dispersion interactions, so the molecule mixes readily with nonpolar media. The lone hydroxyl at carbon 3 does give cholesterol a faint polar character, enough to orient the molecule at a membrane surface, but one small oxygen-bearing group cannot anchor such a large hydrocarbon frame in water. Weighing that single group against the bulk of the molecule is the key step: the hydrocarbon portion wins decisively, so cholesterol stays with the lipids while remaining, at most, weakly amphipathic.

(Choice B) overstates the case in the opposite direction. The hydroxyl is not inert toward water; it hydrogen bonds with the aqueous phase and points outward when cholesterol sits in a bilayer leaflet. The correct picture is a weak polar contribution that is outweighed by the hydrocarbon bulk, not a polar contribution that is absent.

(Choice C) mistakes geometry for composition. Fusion of the rings makes cholesterol rigid and roughly planar, which matters for membrane packing, but rigidity itself does not repel water. A rigid molecule studded with polar groups, such as a sugar locked in its ring form, dissolves in water readily. It is the carbon and hydrogen content of the rings, not the fact that they are fused, that governs solvent preference.

(Choice D) reverses the actual balance of forces. The hydroxyl does not dominate the molecule or pull it into the aqueous phase, and free cholesterol needs no esterification to behave as a lipid. Esterifying the hydroxyl with a fatty acid does make the molecule even more hydrophobic, which is how cells package cholesterol for storage, but the unmodified molecule already favors the nonpolar phase overwhelmingly.

This is a Knowledge of Scientific Concepts and Principles question because it asks you to recall the structural makeup of cholesterol and apply the general principle that a molecule's solvent preference reflects the balance between its polar and nonpolar surface area.$q$,
    'medium',
    '5D',
    $q$Lipids$q$,
    'biochemistry',
    1,
    70
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'partial_truth', $q$overcorrection to zero polarity$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$rigidity equals hydrophobicity$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$small polar group dominates the frame$q$ FROM q;

-- Q22 . Squalene as hexaisoprenoid steroid precursor . hard . skill 2 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Squalene as hexaisoprenoid steroid precursor$q$,
    $q$In animal tissue, a linear thirty-carbon hydrocarbon assembled entirely from branched five-carbon units undergoes cyclization to yield a compound containing three six-membered rings and one five-membered ring fused together. This transformation supports which of the statements below?

I. The fused ring skeleton found in steroids originates from isoprene-derived building blocks.
II. The open-chain precursor contains six isoprene equivalents.
III. The open-chain precursor was assembled by the same stepwise two-carbon elongation that builds fatty acid chains.$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"II only"},{"label":"C","text":"I and II only"},{"label":"D","text":"I, II, and III"}]$q$::jsonb,
    'C',
    $q$This Lipids question tests the bridge between terpenes and steroids: the recognition that the steroid ring system is built from isoprene derived carbon. The answer is C because statements I and II are supported while statement III is not. The branched five carbon unit described in the stem is isoprene, and a thirty carbon chain constructed entirely from such units must contain 30 divided by 5, or six, isoprene equivalents, so statement II holds. Because this open chain hexaisoprenoid, squalene, cyclizes into the signature steroid pattern of three six membered rings and one five membered ring fused together, the steroid nucleus inherits its carbon skeleton from isoprene chemistry, so statement I holds as well: steroids belong to the same structural family as the terpenes. Statement III fails because stepwise two carbon elongation is the assembly logic of fatty acid chains and yields long unbranched skeletons; a branched skeleton composed of five carbon repeating units is the fingerprint of isoprenoid condensation, so the described precursor cannot have been put together by the fatty acid route. (Choice A) Selecting I alone accepts the isoprenoid origin but rejects the arithmetic; six five carbon units account exactly for thirty carbons, so statement II cannot be excluded. (Choice B) Selecting II alone accepts the carbon count but denies the conclusion it points to; a precursor made of isoprene units that closes into the steroid ring system establishes precisely the isoprenoid ancestry that statement I asserts. (Choice D) Including statement III imports the wrong assembly process: two carbon elongation belongs to fatty acid construction and produces straight chains, so it cannot generate the branched five carbon repeating pattern the stem specifies. This is a Scientific Reasoning and Problem Solving question because it requires the student to identify an unnamed precursor from its described architecture, verify its isoprene count quantitatively, and discriminate isoprenoid assembly from fatty acid assembly.$q$,
    'hard',
    '5D',
    $q$Lipids$q$,
    'biochemistry',
    2,
    105
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'scale_unit_error', $q$miscounted repeating units$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$steroids assumed fatty acid derived$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$wrong assembly pathway attached$q$ FROM q;

-- Q23 . Terpene unit counting convention . hard . skill 2 . 5D
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'Lipid Structure and Function',
    $q$Terpene unit counting convention$q$,
    $q$A chemist isolates a branched fifteen-carbon hydrocarbon from conifer resin and confirms that its skeleton is built entirely from isoprene units. Under the naming convention for this compound family, the molecule is classified as which of the following?$q$,
    $q$[{"label":"A","text":"A monoterpene"},{"label":"B","text":"A sesquiterpene"},{"label":"C","text":"A diterpene"},{"label":"D","text":"A triterpene"}]$q$::jsonb,
    'B',
    $q$This Lipids question tests the terpene naming convention, under which one terpene unit is defined as two isoprene units. The answer is B because a branched fifteen carbon isoprenoid contains 15 divided by 5, or three, isoprene units, and three isoprene units equal one and a half terpene units; the prefix sesqui means exactly one and a half, so C15 isoprenoids are sesquiterpenes. The counting must run in two stages: first convert the carbon count into isoprene units using five carbons per isoprene, then convert isoprene units into terpene units using two isoprenes per terpene. Skipping the second stage is the most common source of error with this convention. The same two stage logic generates the whole series, with monoterpenes at C10, sesquiterpenes at C15, diterpenes at C20, and triterpenes at C30, so any member of the family can be placed by carbon count alone once the convention is fixed. (Choice A) A monoterpene is the C10 member of the family, one full terpene unit built from two isoprenes; assigning a fifteen carbon molecule here truncates one and a half terpene units down to one, discarding an entire isoprene unit of carbon. (Choice C) A diterpene is a real neighboring class, the C20 member built from four isoprenes, but it belongs to molecules five carbons larger than the one described; placing a C15 compound there transfers a genuine fact about the series to the wrong member. (Choice D) Triterpene is the classic trap: it counts the three isoprene units directly as though each were a terpene unit, ignoring the pairing convention entirely; genuine triterpenes are C30 molecules such as squalene, twice the size of the compound described. This is a Scientific Reasoning and Problem Solving question because it requires converting a stated carbon count into isoprene units and then applying the two isoprenes per terpene convention to assign the molecule to its correct class.$q$,
    'hard',
    '5D',
    $q$Lipids$q$,
    'biochemistry',
    2,
    85
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'scale_unit_error', $q$rounded the unit count down$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$right series, wrong member$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$terpene equals isoprene error$q$ FROM q;

COMMIT;

-- Verification: expect 23 questions and 69 distractor rows.
SELECT
  (SELECT COUNT(*) FROM public.questions WHERE topic = 'Lipid Structure and Function') AS questions,
  (SELECT COUNT(*) FROM public.question_distractor_metadata m
     JOIN public.questions x ON x.id = m.question_id
   WHERE x.topic = 'Lipid Structure and Function') AS distractor_rows;
