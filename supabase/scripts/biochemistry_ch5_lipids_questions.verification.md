# Biochem Ch5: Lipid Structure and Function . Verification Report

**Batch 1 of 2: 23 questions (lipid chemistry).**
Chapter target is **45 questions**. Reference texts: `libretexts-biochemistry.txt` (BC:) and
`openstax-biology-2e.txt` (BIO:). Step 1 record: `biochemistry_ch5_lipids_questions.plan.md`.
All questions: content category "Lipids" . discipline biochemistry . foundation assigned per
question from 5D (default), 2A (membrane), 3A (steroid/terpene), 1D (saturation).

## Why 45

The chapter's traditional load was claimed before it was built: Biochem Ch11 owns fatty-acid
nomenclature and properties, every energetic comparison, digestion, bile and micelle-ferrying,
lipoproteins, and cholesterol synthesis; Bio Ch5 Endocrine saturated steroid-hormone mechanism;
Bio Ch9 closed the vitamin-K vignettes one week before this build. Counting answer-turning points
surviving both the scope check and the boundary audit gives 45; padding to Ch3/Ch4's 72 would force
roughly 27 re-keys of owned material.

**Forward reservation recorded:** batch 2 claims cholesterol-as-fluidity-buffer and bilayer-versus-
micelle geometry; the future Biochem Ch8 Membranes pre-flight must treat those as taken, and Ch8
keeps bilayer dynamics, the fluid mosaic model, rafts, asymmetry, membrane proteins and transport.

**Figure-free deviation from the plan:** Ch4's figures came from a purpose-built parametric
generator; no equivalent exists for lipids, so structures are described in words throughout.

## Batch 1 summary

| Metric | Result | Target |
|---|---|---|
| Difficulty | easy 6 . hard 8 . medium 9 | easy 6 . medium 9 . hard 8 |
| Answer letter | A 6 . B 6 . C 6 . D 5 | A 6 . B 6 . C 6 . D 5 |
| Cognitive skill | S1 4 . S2 12 . S3 3 . S4 4 | S1 4 . S2 12 . S3 3 . S4 4 |
| Foundation | 2A 1 . 5D 22 | mostly 5D |
| Roman numeral | 3 | 3 |
| Confidence | conf4 4 . conf5 19 | only 4-5 ship |
| Em/en dashes | 0 | 0 |
| Source citations in shipped explanations | 0 | 0 |

**One duplicate caught and replaced before shipping, and this one traced to the PLAN rather than a
writer:** the plan listed "solubility as the defining property" (Unit 1) and "why steroids are
classified as lipids" (Unit 5), which converge on the same key. The writers executed both
faithfully; Q1 and the original Q21 keyed near-identical "dissolves preferentially in nonpolar
solvents" statements. The replacement inverts Q21's framing: the stem now supplies the criterion and
states that cholesterol qualifies, and the key is the STRUCTURAL feature that earns it (the fused
hydrocarbon frame overwhelming the lone hydroxyl). Pinned to the retired item's metadata; post-swap
checks confirmed all distributions unchanged and zero shared distinctive words between the two keys.
Lesson recorded: sound-alike collisions can be planted at planning time, so unit lists are now
scanned for converging keys before slicing.

**Boundary scan:** zero forbidden ideas in any key across the 17-rule list (energetics, digestion,
lipoproteins, hormone mechanism, nomenclature, synthesis, vitamin homeostasis, IMF naming).

**Adversarial audit:** all 23 re-examined by an independent pass per slice, citations re-greped
against LibreTexts Biochemistry and OpenStax Biology 2e.

---

## Q1 . Solubility as the lipid class criterion

**Stem.** Triacylglycerols contain ester groups, steroids consist of fused hydrocarbon rings often bearing a hydroxyl group, and many terpenes are pure hydrocarbons. Despite sharing no common functional group, all three are classified as lipids. Membership in the lipid class is assigned on the basis of which criterion?

- **A.** Presence of at least one ester linkage to a fatty acid
- **B.** Preferential dissolution in nonpolar solvents rather than in water  <- **KEY**
- **C.** Ability to form micelles when dispersed in aqueous solution
- **D.** Preferential dissolution in water rather than in nonpolar solvents

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 60 s |
| Confidence | 5 |

**Correct answer (B): Preferential dissolution in nonpolar solvents rather than in water**

Citations: BC:43922-43923 (lipids defined as organic molecules soluble in organic solvents, largely insoluble in water); BC:4566 (triacylglycerols, cholesterol esters, waxes among nonpolar biomolecules); BC:4769 (nonpolar substances do not readily mix with water)

**Distractors**

- **(A)** `misconception` . _lipids equal fats equal fatty acid esters_: The common student belief that all lipids are fatty acid esters fails for steroids and terpene hydrocarbons, which contain no fatty acid ester yet are lipids.
  - Citation: BC:43922
- **(C)** `partial_truth` . _subset behavior mistaken for class definition_: Micelle formation is a genuine behavior of some lipids, but only amphipathic ones; purely hydrophobic lipids cannot form micelles yet remain lipids, so it cannot be the class criterion.
  - Citation: BC:44041
- **(D)** `reversed_relationship` . _direction of partitioning inverted_: This states the exact opposite partitioning preference; water-preferring molecules are hydrophilic and are excluded from the lipid class.
  - Citation: BC:43922

**Readback check.** Key content words of six or more letters: preferential, dissolution, nonpolar, solvents. None appears in the stem. The stem never states the solubility criterion, so the key is not a restated definition; identifying it requires recall plus an inference from the listed structural diversity.

**Explanation (as shipped).**

> Lipids questions like this one test the criterion that defines the lipid class, which is solubility behavior rather than shared covalent architecture. The answer is B because a molecule earns membership in the lipid class by partitioning preferentially into nonpolar solvents such as chloroform or hexane while dissolving poorly in water. Because the defining test is a physical property and not a functional group, the class sweeps in molecules with very different skeletons: ester-linked acylglycerols, fused-ring steroids, and hydrocarbon terpenes all pass the same partitioning test. This is why lipids are chemically heterogeneous in a way that carbohydrates and proteins are not; those classes are defined structurally, as polyhydroxy carbonyl compounds and amide-linked amino acid polymers respectively, so their members resemble one another. Any structural criterion chosen for lipids would either exclude true lipids or admit non-lipids, which is why the physical definition is the one that survives. (Choice A) An ester linkage to a fatty acid is present in triacylglycerols, waxes, and glycerophospholipids, but steroids and many terpenes contain no fatty acid ester at all, so this criterion would expel molecules that are unambiguously lipids from the class. (Choice C) Micelle formation requires an amphipathic structure with a polar head group. Purely hydrophobic lipids such as triacylglycerols and terpene hydrocarbons cannot form micelles, yet they remain lipids, so this behavior identifies only a subset of the class rather than the class itself. (Choice D) This reverses the actual partitioning behavior. A molecule that preferred water to nonpolar solvents would be hydrophilic, and hydrophilicity is precisely what excludes a molecule from the lipid class. This is a Knowledge of Scientific Concepts and Principles question because it asks the student to recall that lipid classification rests on a shared solubility property rather than a shared functional group and to recognize that structural diversity follows directly from that physical definition.

---

## Q2 . Water affinity ranking across lipid classes

**Stem.** A chemist compares the water affinity of four purified lipids. Compound 1 is glycerol esterified at all three positions to unbranched C16 chains. Compound 2 is glycerol bearing two unbranched C16 acyl chains and a phosphocholine head group at its third position. Compound 3 is the sodium salt of a single unbranched C16 carboxylic acid. Compound 4 consists of four fused hydrocarbon rings bearing one hydroxyl group and a short branched hydrocarbon tail. Which ordering ranks the compounds from greatest to least affinity for water?

- **A.** Compound 3 > Compound 2 > Compound 4 > Compound 1  <- **KEY**
- **B.** Compound 2 > Compound 3 > Compound 4 > Compound 1
- **C.** Compound 3 > Compound 2 > Compound 1 > Compound 4
- **D.** Compound 1 > Compound 4 > Compound 2 > Compound 3

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 110 s |
| Confidence | 4 |
| Hard-tier gate | (b) Directional inference: the ranking requires weighing polar head strength against hydrophobic surface area across a four-member series. (c) Two distractors stay defensible until a discriminating fact applies: choice B holds until chain count per head group is weighed (two chains per zwitterion versus one chain per carboxylate), and choice C holds until the student recalls that buried ester oxygens lack hydrogen bond donor capacity while the steroid hydroxyl is an exposed donor. |

**Correct answer (A): Compound 3 > Compound 2 > Compound 4 > Compound 1**

Citations: BC:44041 (fatty acid salts as micelle-forming single-chain amphiphiles with monomer solubility); BC:4769 (nonpolar triacylglycerols and waxes do not mix with water); BIO:6589 (phospholipid phosphate-linked head group; cholesterol as four fused carbon rings); BIO:4152 (four fused hydrocarbon rings comprise steroids)

**Distractors**

- **(B)** `partial_truth` . _head group counted, chain burden ignored_: The phosphocholine head truly carries two charges, but ranking by charge count alone ignores that the head must solvate twice the hydrophobic chain area; per chain, the single-tail carboxylate salt has higher water affinity.
  - Citation: BC:44041
- **(C)** `misconception` . _oxygen counting mistaken for polarity_: Counting the triacylglycerol's six ester oxygens as polarity ignores that they are weak, buried acceptors with no donor capacity, whereas the steroid's exposed hydroxyl both donates and accepts hydrogen bonds.
  - Citation: BC:4769
- **(D)** `reversed_relationship` . _full ranking inversion_: This is the exact inverse series; it ranks affinity for a nonpolar solvent, not for water.
  - Citation: BC:4769

**Readback check.** The key is an ordering of numbered compound labels; it contains no content words of six or more letters other than the shared label Compound, which appears identically in the stem and all four options and carries no discriminating content. The ranking cannot be read off the stem; it must be inferred by weighing head group polarity against hydrophobic area for each structure.

**Explanation (as shipped).**

> Lipids questions of this type ask for a comparative ranking of water affinity across the major lipid classes, reasoned from structure alone. The answer is A because water affinity tracks the balance between polar or charged surface and hydrophobic surface. Compound 3, a fatty acid salt, pairs a fully ionized carboxylate with only a single hydrocarbon chain, the highest polar-to-nonpolar ratio in the set; salts of this type even show measurable monomer solubility in water. Compound 2 carries a zwitterionic phosphocholine head, but that single head must offset two full-length acyl chains, so its affinity for water is lower than the salt's. Compound 4, a steroid, offers just one hydroxyl on a bulky fused-ring hydrocarbon frame, making it only weakly amphipathic. Compound 1 sits last because it has no charge and no hydrogen bond donor anywhere; its ester oxygens are buried near the crowded glycerol center, leaving an effectively uniform hydrocarbon surface. That places it below even the steroid, whose hydroxyl can both donate and accept hydrogen bonds at an exposed molecular surface. (Choice B) This swaps the top pair by counting the two charges of the zwitterionic head as if charge number alone decided the ranking; the head group must be weighed against the doubled hydrophobic chain area it drags along, and per chain the single-tail carboxylate is better solvated. (Choice C) This ranks the triacylglycerol above the steroid by tallying its six ester oxygens against a single hydroxyl, but ester oxygens are weak hydrogen bond acceptors with no donor capacity and little solvent exposure, whereas the steroid hydroxyl is a surface-exposed donor and acceptor. (Choice D) This inverts the entire series, ordering the compounds from most hydrophobic to least; it describes the ranking of affinity for a nonpolar solvent, not for water. This is a Data-based and Statistical Reasoning question because it requires converting four structural descriptions into an ordered comparison, weighing head group chemistry against hydrophobic surface area to place each molecule on a relative water affinity scale.

---

## Q3 . Amphipathic structure and micelle dispersal

**Stem.** A student shakes a small sample of each of four lipids into separate flasks of water. Compound W is a C16 fatty acid esterified to a single unbranched C30 alcohol. Compound X is glycerol esterified at all three positions to unbranched C18 chains. Compound Y is the potassium salt of a C14 fatty acid, and compound Z is a C30 branched hydrocarbon assembled from isoprene units. Which compound disperses through the water as micelles rather than collecting as a separate oily layer?

- **A.** Compound W
- **B.** Compound X
- **C.** Compound Y  <- **KEY**
- **D.** Compound Z

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 80 s |
| Confidence | 5 |

**Correct answer (C): Compound Y**

Citations: BC:44002 (single-chain amphiphile behavior when added to water); BC:44041 (fatty acid salts are common micelle-forming single-chain amphiphiles); BC:42798 (base-catalyzed hydrolysis of fatty acid esters yields soaps in saponification); BC:43043 (cone-shaped single-chain amphiphiles pack into micelles)

**Distractors**

- **(A)** `process_step_confusion` . _saponification precursor versus product_: The wax is the ester precursor a soap is made from; micelle behavior emerges only after saponification cleaves the ester and releases the fatty acid salt, so this choice confuses the starting material with the product.
  - Citation: BC:42798
- **(B)** `partial_truth` . _backbone polarity assumed to survive esterification_: Glycerol itself is hydrophilic, but full esterification consumes all three hydroxyls, leaving the triacylglycerol with no free polar head to face water.
  - Citation: BC:4769
- **(D)** `misconception` . _packing conflated with solubility_: Branching alters hydrocarbon packing, but packing is not water affinity; a pure hydrocarbon has no polar region and cannot form micelles.
  - Citation: BC:44041

**Readback check.** The key names a compound label only; the shared word Compound appears identically in the stem and every option and carries no content. The stem describes four structures but never states which is amphipathic or ionized, so the answer requires a two-step inference from structure to interfacial behavior.

**Explanation (as shipped).**

> Lipids questions on amphipathic versus purely hydrophobic structure test whether a molecule carries a polar region and what that region predicts about behavior in water. The answer is C because compound Y, the potassium salt of a C14 fatty acid, is the only structure in the set with a genuinely polar head: a fully ionized carboxylate attached to a single hydrocarbon tail. Above a threshold concentration, single-chain amphiphiles of this kind self-assemble into micelles, spherical aggregates that bury the tails in a dry hydrophobic core while presenting the ionic heads to the surrounding water, so the lipid disperses throughout the flask instead of pooling. This is the physical chemistry that makes soap work. The other three structures possess no ionized or strongly hydrogen bonding region, so water molecules maximize their own hydrogen bonding by driving the intruders together, and each collects as a distinct oily phase. Dispersal behavior in water therefore reports directly on whether a described lipid is amphipathic or purely hydrophobic. (Choice A) Compound W is a wax, the kind of ester a soap could be made from, but micelle-forming behavior appears only after saponification hydrolyzes the ester and liberates the fatty acid as its salt; choosing the intact ester confuses the precursor with the product of that reaction. (Choice B) Free glycerol is highly water soluble, but in compound X all three of its hydroxyls are consumed by ester bonds to long chains, so the backbone's native polarity is masked and the molecule presents only hydrocarbon to water. (Choice D) Branched isoprene construction affects how the pure hydrocarbon packs against its own kind, but packing has nothing to do with water affinity; with no polar region at all, compound Z is the least dispersible molecule in the set. This is a Scientific Reasoning and Problem Solving question because it requires applying the structural requirement for amphipathicity to four described molecules and predicting from structure which one can disperse in water as micelles.

---

## Q4 . Wax versus triacylglycerol backbone identity

**Stem.** Molecule 1 is glycerol esterified to three long unbranched hydrocarbon chains. Molecule 2 is a single long-chain carboxylic acid esterified to a single long-chain unbranched alcohol. Although both molecules contain only ester linkages, molecule 2 belongs to which lipid class?

- **A.** Triacylglycerol
- **B.** Phospholipid
- **C.** Sphingolipid
- **D.** Wax  <- **KEY**

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic secondary / structural direct) |
| Estimated time | 70 s |
| Confidence | 5 |

**Correct answer (D): Wax**

Citations: BIO:4090 (waxes are long fatty acid chains esterified to long-chain alcohols); BIO:4751 (triacylglycerol consists of three fatty acids linked to a glycerol); BC:4566 (waxes listed among nonpolar biomolecules); BIO:6589 (phospholipid requires a phosphate-linked head group); BC:43399 (sphingolipids contain a sphingosine backbone with the fatty acid linked through an amide bond)

**Distractors**

- **(A)** `misconception` . _linkage type mistaken for class identity_: The belief that any fatty acid ester is a fat fails here; a triacylglycerol specifically requires a glycerol backbone bearing three acyl chains, and molecule 2 has one chain on a non-glycerol alcohol.
  - Citation: BIO:4751
- **(B)** `adjacent_fact` . _neighboring ester class without its required head group_: Phospholipids are another ester-built class, but they require a glycerol backbone plus a phosphate-linked head group, neither of which molecule 2 possesses.
  - Citation: BIO:6589
- **(C)** `partial_truth` . _backbone similarity without linkage match_: Sphingolipids genuinely use a long-chain amino alcohol backbone, which tempts a match, but the fatty acid attaches by an amide rather than an ester and a polar head group is present, unlike molecule 2.
  - Citation: BC:43399

**Readback check.** Key content word: Wax, only three letters, and no content words of six or more letters appear in the key. The stem never names or defines the wax class, so the answer is not a restated definition; classification requires recalling class backbones and applying them to the described structure.

**Explanation (as shipped).**

> Lipids questions on class discrimination test whether the student assigns a lipid to its class by backbone identity rather than by linkage type. The answer is D because molecule 2 joins one long-chain fatty acid to one long-chain monohydric alcohol through a single ester bond, and that architecture is the definition of a wax. Both molecules are fatty acid esters, so the linkage itself cannot separate them; the discriminating feature is the identity of the alcohol. In molecule 1 the alcohol is glycerol, a three-carbon triol, and esterifying all three hydroxyls with long chains yields a triacylglycerol. In molecule 2 the alcohol is itself a long unbranched hydrocarbon, so the product is a two-chain ester with essentially no polar surface, which is why waxes serve organisms as waterproof coatings on leaves, feathers, and cuticles. The classification matters because backbone identity, not linkage chemistry, is what organizes the ester-built lipid classes, and the same principle later separates glycerophospholipids, built on glycerol, from sphingolipids, built on a long-chain amino alcohol. (Choice A) A triacylglycerol requires the glycerol backbone carrying three acyl chains; molecule 2 has a single acyl chain on a non-glycerol alcohol, so calling every fatty acid ester a fat overextends the class. (Choice B) Phospholipids of the glycerol type also build on a glycerol backbone, but they additionally require a phosphate-linked head group, and molecule 2 contains neither glycerol nor phosphorus. (Choice C) Sphingolipids do use a long-chain amino alcohol backbone, which superficially matches the description, but sphingosine binds its fatty acid through an amide rather than an ester and carries a polar head group at its terminal carbon, neither of which molecule 2 shows. This is a Knowledge of Scientific Concepts and Principles question because it asks the student to recall the defining backbones of the ester-built lipid classes and apply that knowledge to classify a structure supplied only as a prose description.

---

## Q5 . Glycerol versus sphingosine backbone classification

**Stem.** Analysis of a membrane extract identifies two phosphate-bearing lipids. Lipid 1 carries a phosphocholine head group on a three-carbon alcohol scaffold whose remaining two positions are esterified to long-chain fatty acids. Lipid 2 carries a phosphocholine head group on a long-chain amino alcohol whose single fatty acid is attached through an amide bond. How should the two lipids be classified?

- **A.** Both lipids are glycerophospholipids
- **B.** Lipid 1 is a sphingolipid and Lipid 2 is a glycerophospholipid
- **C.** Lipid 1 is a glycerophospholipid and Lipid 2 is a sphingolipid  <- **KEY**
- **D.** Lipid 1 is a glycerophospholipid and Lipid 2 is a glycosphingolipid

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 80 s |
| Confidence | 5 |

**Correct answer (C): Lipid 1 is a glycerophospholipid and Lipid 2 is a sphingolipid**

Citations: BC:43122-43123, BC:43243, BC:43395-43420

**Distractors**

- **(A)** `misconception`: Assumes a phosphate head group automatically means glycerophospholipid; sphingomyelin carries phosphocholine on a sphingosine backbone, so head group does not determine class.
  - Citation: BC:43417-43420
- **(B)** `reversed_relationship`: Swaps the two assignments; the ester-linked three-carbon scaffold is glycerol and the amide-forming amino alcohol is sphingosine, so the pairing runs the other way.
  - Citation: BC:43122-43123
- **(D)** `partial_truth`: Correct sphingosine backbone for Lipid 2, but glycosphingolipids carry sugar head groups; a phosphocholine-bearing sphingolipid is a phosphosphingolipid (sphingomyelin).
  - Citation: BC:43417-43420

**Readback check.** Key content words of six or more letters (glycerophospholipid, sphingolipid) never appear in the stem, which names neither class nor backbone; the student must infer glycerol from the ester-bearing three-carbon scaffold and sphingosine from the amide-linked amino alcohol before classifying.

**Explanation (as shipped).**

> This Lipids question tests the classification of phosphate-bearing membrane lipids, which is decided by the backbone each lipid is built on rather than by its head group. The answer is C because the described linkages identify the two backbones. A three-carbon alcohol scaffold that accepts fatty acids through ester bonds is glycerol, so Lipid 1, with two esterified fatty acids and a phosphocholine group on the third position, is a glycerophospholipid, specifically phosphatidylcholine. A long-chain amino alcohol that binds its single fatty acid through an amide bond is sphingosine, because only an amine nitrogen can supply that amide linkage; a lipid built on sphingosine is a sphingolipid. Since this particular sphingolipid also carries phosphocholine, it is sphingomyelin, the major phosphate-containing member of the sphingolipid family. The two families can therefore present identical head groups, and the only reliable discriminator is the ester-to-glycerol versus amide-to-sphingosine backbone chemistry. (Choice A) A phosphate head group does not define the glycerophospholipid class. Sphingomyelin carries phosphocholine yet is a sphingolipid, because classification follows the backbone, not the head group; two lipids with the same head group can sit in different families. (Choice B) This reverses the two assignments. Ester bonds to a three-carbon scaffold require the hydroxyl groups of glycerol, and the amide bond requires the amine of sphingosine, so Lipid 1 must be the glycerophospholipid and Lipid 2 the sphingolipid. (Choice D) Lipid 2 is placed on the correct sphingosine backbone, but a glycosphingolipid carries one or more sugars as its head group instead of phosphate. A sphingosine-based lipid bearing phosphocholine is a phosphosphingolipid, better known as sphingomyelin. This is a Scientific Reasoning and Problem Solving question because it requires translating described bond types into backbone identities and then assigning each unnamed lipid to its structural class.

---

## Q6 . Terpene versus steroid structural discrimination

**Stem.** Three newly characterized plant molecules are described below.

I. A 30-carbon branched hydrocarbon whose five-carbon repeating units are joined in a single continuous chain with no rings
II. A molecule whose core consists of three six-membered rings and one five-membered ring, each sharing an edge with its neighbor
III. A ten-carbon molecule assembled from two five-carbon branched units, with one end closed into a single ring that is not fused to any other ring

Which of the molecules should be classified as terpenes?

- **A.** I only
- **B.** I and III  <- **KEY**
- **C.** II and III
- **D.** I, II, and III

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic secondary / structural two_step) |
| Estimated time | 90 s |
| Confidence | 5 |

**Correct answer (B): I and III**

Citations: BC:43690-43691, BC:43758, BIO:4140-4146

**Distractors**

- **(A)** `partial_truth`: Correctly includes the open-chain assembly but wrongly excludes the partially cyclized monoterpene, assuming any ring disqualifies a terpene.
  - Citation: BC:43690-43691
- **(C)** `reversed_relationship`: Reverses the classification criterion by admitting the fused tetracyclic steroid and rejecting the open-chain isoprenoid, the clearest terpene present.
  - Citation: BIO:4140-4146
- **(D)** `adjacent_fact`: Leans on the true adjacent fact that steroids derive biosynthetically from isoprene units via squalene, but a finished fused tetracyclic molecule is classified as a steroid, not a terpene.
  - Citation: BC:43758

**Readback check.** The key is the Roman numeral set 'I and III' and contains no content words at all; the stem never names terpene criteria or the steroid nucleus, so selection requires supplying the isoprene-assembly versus fused-tetracycle rule and applying it to each description.

**Explanation (as shipped).**

> This Lipids question tests the structural boundary between terpenes and steroids within the isoprenoid family. The answer is B because molecules I and III are isoprene assemblies while molecule II carries the defining steroid scaffold. Terpenes are built by joining five-carbon isoprene units, and the class tolerates a wide range of final shapes: fully open chains, single rings, and partially cyclized frameworks all qualify as long as the molecule remains an isoprene assembly rather than a fused tetracyclic nucleus. Molecule I, a 30-carbon chain of five-carbon repeating units, matches squalene, a triterpene assembled from six isoprene units. Molecule III, ten carbons from two isoprene units with one non-fused ring, matches a cyclic monoterpene such as limonene; closing a single ring does not remove a molecule from the terpene class. Molecule II, in contrast, presents three six-membered rings and one five-membered ring fused edge to edge, which is the steroid nucleus, so it is classified as a steroid regardless of its biosynthetic ancestry. (Choice A) Molecule I is correctly included, but this choice wrongly excludes molecule III on the grounds that it contains a ring. Partial cyclization is common among terpenes, and one non-fused ring does not create a steroid. (Choice C) This selection reverses the defining criterion: it counts the fused tetracyclic molecule II as a terpene while rejecting the open-chain assembly I, which is the clearest terpene of the three. (Choice D) It is true that steroids are ultimately assembled from isoprene units, since squalene cyclizes on the pathway to sterols, but classification follows the finished architecture. Once a molecule displays the fused four-ring nucleus it is a steroid, not a terpene. This is a Scientific Reasoning and Problem Solving question because it requires applying the isoprene-assembly versus fused-ring criterion to three described structures and sorting each one into the correct lipid class.

---

## Q7 . Triacylglycerol backbone structure

**Stem.** Adipocytes hold nearly all of their stored lipid as droplets of a single class of neutral lipid. Which description matches the covalent structure of one molecule of that lipid?

- **A.** Three fatty acids, each joined through an ester bond to one hydroxyl group of glycerol  <- **KEY**
- **B.** Two fatty acids joined through ester bonds to glycerol, with a phosphate-containing group on the third carbon
- **C.** One fatty acid joined through an amide bond to the amine of a long-chain amino alcohol
- **D.** One long-chain fatty acid joined through an ester bond to a single long-chain alcohol

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 60 s |
| Confidence | 5 |

**Correct answer (A): Three fatty acids, each joined through an ester bond to one hydroxyl group of glycerol**

Citations: BC:43118, BC:43148-43151

**Distractors**

- **(B)** `partial_truth`: The glycerol-ester backbone is right, but a phosphate-containing group on the third carbon makes a glycerophospholipid, an amphipathic membrane lipid rather than the neutral storage lipid.
  - Citation: BC:43243
- **(C)** `adjacent_fact`: An amide-linked fatty acid on a long-chain amino alcohol describes a ceramide on the sphingosine backbone, a membrane lipid, not the droplet storage lipid.
  - Citation: BC:43395-43397
- **(D)** `adjacent_fact`: One fatty acid esterified to one long-chain alcohol is a wax, a protective surface coating, not the lipid stored in adipocyte droplets.
  - Citation: BC:43071-43076

**Readback check.** Key content words of six or more letters (glycerol, hydroxyl) never appear in the stem, which names neither the lipid nor its backbone; the student must recall that the adipocyte storage lipid is triacylglycerol and supply its glycerol-triester architecture unaided.

**Explanation (as shipped).**

> This Lipids question tests the covalent structure of triacylglycerol, the neutral lipid that fills adipocyte droplets. The answer is A because a triacylglycerol consists of a glycerol backbone whose three hydroxyl groups are each esterified to a fatty acid. Glycerol supplies the three-carbon scaffold, each ester bond forms between one glycerol hydroxyl and the carboxyl group of a fatty acid, and the finished molecule carries no phosphate or other charged group. That absence of a polar head group is what makes triacylglycerols neutral lipids, and it explains why they cluster into the hydrophobic droplets seen in fat cells rather than spreading into membranes. The three fatty acids attached to one glycerol are often different from one another, but the triester architecture itself is constant. (Choice B) Two ester-linked fatty acids on glycerol with a phosphate-containing group on the third carbon describes a glycerophospholipid. The glycerol-ester backbone is correct as far as it goes, but the phosphate head group creates an amphipathic membrane lipid, not the neutral lipid of storage droplets. (Choice C) A single fatty acid joined through an amide bond to a long-chain amino alcohol describes a ceramide, the simplest lipid built on the sphingosine backbone. Sphingosine-based lipids reside in membranes and are never the droplet storage form. (Choice D) One fatty acid esterified to one long-chain alcohol describes a wax, the protective coating found on plant surfaces and in the ear canal, not the lipid stored inside adipocytes. This is a Knowledge of Scientific Concepts and Principles question because it asks for direct recall of the glycerol-plus-three-ester architecture that defines a triacylglycerol.

---

## Q8 . Steroid nucleus recognition in novel isolates

**Stem.** A natural products laboratory reports the ring systems of four uncharacterized isolates. Isolate 1 contains four six-membered rings, each fused to the next along a shared edge. Isolate 2 is a 30-carbon branched chain assembled from five-carbon units, with one end closed into a single six-membered ring and the remainder left as open chain. Isolate 3 contains three six-membered rings fused along shared edges, with a five-membered ring attached to the terminal ring through a single carbon-carbon bond. Isolate 4 contains three six-membered rings and one five-membered ring, each fused to its neighbor along a shared edge. Which isolate contains a steroid nucleus?

- **A.** Isolate 1
- **B.** Isolate 2
- **C.** Isolate 3
- **D.** Isolate 4  <- **KEY**

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 100 s |
| Confidence | 5 |
| Hard-tier gate | (a) combines two concepts: steroid-nucleus recognition and terpene discrimination are both required to clear the option set; (c) two distractors stay defensible until a discriminating fact applies: Isolate 1 survives the four-fused-rings shorthand until the ring-size inventory is checked, and Isolate 3 survives the ring-count check until the edge-fusion requirement is applied. |

**Correct answer (D): Isolate 4**

Citations: BIO:4140-4152, BC:43690-43691

**Distractors**

- **(A)** `misconception`: Relies on the shorthand that any four fused rings make a steroid; all four rings are six-membered, and the nucleus requires exactly one five-membered ring.
  - Citation: BIO:4140-4152
- **(B)** `adjacent_fact`: A partially cyclized 30-carbon isoprenoid is a terpene, the true biosynthetic relative of steroids, but it lacks the fused tetracyclic nucleus entirely.
  - Citation: BC:43690-43691
- **(C)** `partial_truth`: Correct ring inventory, but the five-membered ring is attached by a single bond instead of a shared edge, so the system is not a fused tetracycle.
  - Citation: BIO:4140-4152

**Readback check.** The key is the bare data label 'Isolate 4' and shares no content words with the discriminating criteria; the stem supplies ring descriptions but never states what a steroid nucleus requires, so answering demands supplying the definition and testing all four descriptions against it, with no value readable directly off the data.

**Explanation (as shipped).**

> This Lipids question tests recognition of the steroid nucleus inside unfamiliar molecules described only by their reported ring data. The answer is D because Isolate 4 satisfies both requirements of the steroid nucleus: the correct ring inventory of three six-membered rings plus one five-membered ring, and full fusion, with every ring holding an edge in common with its neighbor. Recognizing a steroid in an uncharacterized molecule demands checking these two independent structural criteria in sequence. First, the inventory must be exactly three six-membered rings and one five-membered ring; second, all four rings must be fused, meaning that adjacent rings share an edge and the two carbons on it. Only Isolate 4 passes both tests, and applying the same two-step screen eliminates each remaining isolate on exactly one criterion, which is why an incomplete definition leaves several options looking acceptable. (Choice A) Isolate 1 is fully fused and tetracyclic, so it survives a screen based only on the popular shorthand that a steroid is four fused rings. Its rings are all six-membered, however, and the steroid nucleus requires that one of the four be five-membered. (Choice B) Isolate 2 is a partially cyclized assembly of five-carbon units, which identifies it as a terpene. Terpenes are the biosynthetic relatives of steroids, and a 30-carbon isoprenoid resembles squalene, but a mostly open chain bearing one ring is nothing like a fused tetracyclic nucleus. (Choice C) Isolate 3 has the correct ring inventory of three six-membered rings and one five-membered ring, so it survives a screen based only on counting. Its five-membered ring hangs from the fused system by a single rotatable bond rather than a shared edge, so the four rings never form the single fused nucleus that defines a steroid. This is a Data-based and Statistical Reasoning question because it requires evaluating reported structural data for four unknown molecules and testing each described ring system against the defining criteria of the steroid nucleus.

---

## Q9 . Triacylglycerol complete hydrolysis stoichiometry

**Stem.** A neutral storage lipid consists of a three-carbon backbone in which each backbone carbon bears an ester linkage to a long hydrocarbon chain. What does complete acid-catalyzed hydrolysis of one mole of this lipid yield, accounting for water?

- **A.** One mole of glycerol and three moles of free fatty acids, with three moles of water released
- **B.** One mole of glycerol and one mole of free fatty acid, with one mole of water consumed
- **C.** One mole of glycerol and three moles of free fatty acids, with three moles of water consumed  <- **KEY**
- **D.** One mole of glyceraldehyde and three moles of free fatty acids, with three moles of water consumed

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic core / structural two_step) |
| Estimated time | 65 s |
| Confidence | 5 |

**Correct answer (C): One mole of glycerol and three moles of free fatty acids, with three moles of water consumed**

Citations: BIO:3974-3993 (glycerol plus three fatty acids joined by ester bonds; three waters exchanged); BC:43148-43159 (triacylglycerol as glycerol backbone with three esterified fatty acids)

**Distractors**

- **(A)** `reversed_relationship`: States that water is released, which is the condensation (ester-forming) direction; hydrolysis consumes water, one molecule per ester bond cleaved.
- **(B)** `scale_unit_error`: Counts only one ester bond; the described lipid has a chain on each of three backbone carbons, so three fatty acids and three waters are involved.
- **(D)** `adjacent_fact`: Names the three-carbon aldose instead of the triol; glyceraldehyde has an aldehyde carbonyl at one carbon and only two hydroxyls, so it cannot bear three ester linkages.

**Readback check.** Key content words of six or more letters: glycerol, consumed. Neither appears in the stem, which names the backbone only as a three-carbon unit; identifying it as glycerol and working out the three-water stoichiometry both require inference.

**Explanation (as shipped).**

> This Lipids question tests the structure of a triacylglycerol and the stoichiometry of its complete hydrolysis. The answer is C because a three-carbon backbone carrying three ester-linked hydrocarbon chains is a triacylglycerol: one molecule of glycerol joined to three fatty acids through three ester bonds. Hydrolysis is the reverse of the dehydration reaction that originally built those bonds. Each ester bond that is cleaved incorporates one molecule of water, splitting the linkage into an alcohol group, which is returned to the backbone, and a carboxylic acid group, which leaves with the hydrocarbon chain. Because the molecule contains exactly three ester bonds, complete hydrolysis of one mole of the lipid consumes three moles of water and liberates one mole of glycerol together with three moles of free fatty acids. Under acidic conditions the acid is only a catalyst, and the fatty acids are released in their neutral, protonated form. (Choice A) reverses the direction of the water balance. Water is released when the ester bonds are formed during condensation of glycerol with three fatty acids; the question asks about the cleavage direction, in which each bond broken requires that a water molecule be consumed, not produced. (Choice B) undercounts the linkages. One fatty acid and one water would account for hydrolysis of a single ester bond, but the backbone described bears a chain on each of its three carbons, so three separate bonds must be cleaved and the products scale accordingly. (Choice D) misidentifies the backbone. A three-carbon unit that anchors an ester linkage at every carbon must supply three hydroxyl groups, which marks it as glycerol, a triol. Glyceraldehyde is the three-carbon aldose: one of its carbons is an aldehyde carbonyl, leaving only two hydroxyls available, so it could not carry the three ester-linked chains the stem describes. This is a Scientific Reasoning and Problem Solving question because it requires recognizing an unnamed structure as a triacylglycerol and then applying ester hydrolysis stoichiometry to predict both the organic products and the water consumed.

---

## Q10 . Saponification product identification

**Stem.** A soap maker refluxes solid beef fat with excess concentrated sodium hydroxide until no neutral lipid remains, then lets the mixture cool. Which organic products dominate the final mixture?

- **A.** Glycerol and three equivalents of long-chain fatty acid carboxylate salts  <- **KEY**
- **B.** Three equivalents of glycerol and one equivalent of a long-chain fatty acid carboxylate salt
- **C.** Diacylglycerol and one equivalent of a long-chain fatty acid carboxylate salt
- **D.** A three-carbon tricarboxylate salt and three equivalents of long-chain fatty alcohols

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 70 s |
| Confidence | 5 |

**Correct answer (A): Glycerol and three equivalents of long-chain fatty acid carboxylate salts**

Citations: BC:42798 (base-catalyzed hydrolysis of fatty acid esters forms soaps in a saponification reaction); BC:43148-43159 (triacylglycerol connectivity); BIO:3974-3993 (ester bonds between glycerol and fatty acids)

**Distractors**

- **(B)** `scale_unit_error`: Inverts the backbone to chain ratio; each triacylglycerol holds one glycerol esterified to three fatty acids, so products emerge in a one to three ratio, not three to one.
- **(C)** `process_step_confusion`: Stops after one of three cleavages; diacylglycerol is still a neutral lipid with two intact esters, contradicting the stated completion of the reaction.
- **(D)** `reversed_relationship`: Swaps the acid and alcohol partners of the ester: the backbone supplies the alcohol oxygens and the chains the carbonyl carbons, so the chains leave as carboxylates, not alcohols.

**Readback check.** Key content words of six or more letters: glycerol, equivalents, carboxylate. None appears in the stem, which names the starting material only as beef fat; supplying glycerol and the ionized carboxylate form requires knowing what saponification releases.

**Explanation (as shipped).**

> This Lipids question tests saponification, the base-driven cleavage of the ester bonds in a fat. The answer is A because beef fat is composed of triacylglycerols, each built from a single glycerol backbone esterified to three fatty acids. Hot, excess sodium hydroxide attacks each of the three ester bonds, so complete reaction returns the intact glycerol backbone plus three freed acyl chains, and because the medium still contains excess strong base, those chains persist as long-chain carboxylate salts, which is precisely what soap is. The final mixture is therefore dominated by glycerol and three equivalents of fatty acid carboxylate salts for every molecule of fat consumed. (Choice B) inverts the stoichiometric ratio. Each fat molecule contains one three-carbon backbone carrying three chains, so cleavage releases backbone and chains in a one to three ratio; three glycerols per single chain would require three backbones sharing one fatty acid, the opposite of triacylglycerol connectivity. (Choice C) describes a reaction stopped after a single cleavage. A diacylglycerol still carries two ester bonds and is itself a neutral lipid, so its persistence contradicts the condition that the reaction ran until no neutral lipid remained; excess base drives all three esters to cleavage. (Choice D) swaps the identities of the two ester partners. In a fat, the backbone contributes the alcohol oxygens and the chains contribute the carbonyl carbons, so cleavage frees the chains as carboxylates and the backbone as a triol; a backbone-derived carboxylate paired with fatty alcohols reverses that assignment. This is a Scientific Reasoning and Problem Solving question because it requires mapping triacylglycerol connectivity onto the identity and ratio of the products released when every ester bond is cleaved by excess base.

---

## Q11 . Irreversibility of base-mediated ester cleavage

**Stem.** When a fatty acid ester is warmed with aqueous acid, hydrolysis settles into an equilibrium mixture that still contains appreciable ester. When the same ester is warmed with aqueous sodium hydroxide, cleavage goes essentially to completion. What property of the basic conditions accounts for the difference?

- **A.** Hydroxide is a stronger nucleophile than water, so the forward cleavage step is faster
- **B.** Basic conditions protonate the released alcohol, blocking its return attack on the acyl carbon
- **C.** Hydroxide serves as a regenerated catalyst that accelerates the forward and reverse steps equally
- **D.** The released acid is deprotonated to a carboxylate that cannot re-form the ester, removing the reverse step  <- **KEY**

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 100 s |
| Confidence | 5 |
| Hard-tier gate | (a) combines ester reaction reversibility with acid-base speciation of the carboxylic acid product; (c) choice A stays defensible until the discriminating fact that a faster forward rate changes kinetics but not where a reversible reaction settles is applied; (d) inverts the usual reasoning direction by asking why completion occurs rather than what the products are. |

**Correct answer (D): The released acid is deprotonated to a carboxylate that cannot re-form the ester, removing the reverse step**

Citations: BC:42798 (base-catalyzed hydrolysis of fatty acid esters releases fatty acids as soaps in a saponification reaction); BC:43148-43159 (ester connectivity of the parent storage lipid)

**Distractors**

- **(A)** `partial_truth`: A correct kinetic fact that cannot explain the outcome: faster forward cleavage changes how quickly the system reacts, not the final position of a reversible reaction.
- **(B)** `reversed_relationship`: Runs the acid-base logic backward on the wrong species: base cannot protonate the alcohol, and the alcohol's ionization is not what shuts off the reverse reaction.
- **(C)** `misconception`: Treats hydroxide as a regenerated catalyst; it is consumed stoichiometrically in forming the carboxylate, and a true catalyst could not shift the final composition anyway.

**Readback check.** Key content words of six or more letters: released, deprotonated, carboxylate, re-form, removing, reverse. None appears in the stem, which describes only the observed extents of reaction; the acid-base fate of the product and its consequence must be inferred.

**Explanation (as shipped).**

> This Lipids question tests why saponification, unlike acid-catalyzed hydrolysis, drives ester cleavage to completion. The answer is D because the two conditions differ in the fate of the carboxylic acid product. Acid-catalyzed hydrolysis is genuinely reversible: the freed acid retains its electrophilic carbonyl, the alcohol can attack it and re-form the ester, and the system settles wherever that reversible interconversion dictates, leaving appreciable ester behind. Under basic conditions, every acid molecule released is immediately stripped of its proton by hydroxide, giving a resonance-stabilized carboxylate anion. That anion is a very poor electrophile and cannot be re-esterified by a neutral alcohol under the reaction conditions, so the reverse step is effectively removed. With product continuously siphoned into an unreactive form, cleavage proceeds until the ester is exhausted, which is also why saponification consumes hydroxide stoichiometrically rather than catalytically. (Choice A) is true but answers the wrong question. Hydroxide is indeed the stronger nucleophile, which makes the forward step faster, but a rate enhancement alone cannot change where a reversible process ultimately settles; only shutting down the reverse step explains completion. (Choice B) applies acid-base logic in the wrong direction to the wrong species. Basic conditions cannot protonate an alcohol; if anything, hydroxide deprotonates a small fraction of it, and the alcohol is not the product whose ionization controls the outcome. (Choice C) misidentifies the role of hydroxide. A regenerated catalyst accelerates both directions and leaves the final composition untouched, whereas hydroxide here is consumed, one equivalent per ester cleaved, in forming the carboxylate. This is a Scientific Reasoning and Problem Solving question because it requires connecting the acid-base speciation of a reaction product to the reason a normally reversible cleavage is driven to completion.

---

## Q12 . Saponification assay for lipid linkage type

**Stem.** A researcher purifies a neutral storage lipid from bovine adipose tissue and a second neutral lipid from an archaeon that joins its hydrocarbon chains to a backbone through ether linkages. Both samples are refluxed in concentrated potassium hydroxide, acidified, and shaken with an organic solvent. Which extraction result supports the hypothesis that the adipose lipid joins its chains through ester linkages?

- **A.** Long-chain fatty acids are recovered from both samples
- **B.** Long-chain fatty acids are recovered from the adipose sample but not the archaeal sample  <- **KEY**
- **C.** Long-chain fatty acids are recovered from the archaeal sample but not the adipose sample
- **D.** Long-chain fatty alcohols are recovered from the adipose sample but not the archaeal sample

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 3 |
| Difficulty | **medium** (topic secondary / structural two_step) |
| Estimated time | 90 s |
| Confidence | 4 |

**Correct answer (B): Long-chain fatty acids are recovered from the adipose sample but not the archaeal sample**

Citations: BC:42798 (base-catalyzed hydrolysis of ester-linked fatty acids yields soaps, distinguishing lipids that saponify from those that do not); BC:35801 (ether links, more stable in reactive environments, replace ester links in archaea); BC:45349-45350 (plasmalogens carry ether-linked rather than ester-linked fatty acids); BC:42842 (fatty acids attach by ester or amide link)

**Distractors**

- **(A)** `misconception`: Presumes hot base cleaves ether linkages as readily as esters; ethers resist saponification, and symmetric recovery would destroy the assay's ability to discriminate.
- **(C)** `reversed_relationship`: Assigns base lability to the ether-linked control and base resistance to the putative ester lipid, exactly inverting the predicted pattern.
- **(D)** `adjacent_fact`: Fatty alcohols are the fragment an ether cleavage or a reductive step would give; ester saponification frees the chain as the carboxylic acid component.

**Readback check.** Key content words of six or more letters: recovered, adipose, archaeal, sample. Adipose, archaeal, and sample appear in the stem but also identically in all four options as sample labels, so they carry no discriminating signal; the discriminating content, the identity of the recovered product and the asymmetric recovery pattern, appears nowhere in the stem.

**Explanation (as shipped).**

> This Lipids question tests the use of saponification as a diagnostic experiment for ester linkages. The answer is B because base-driven hydrolysis is chemistry specific to the ester bond. Refluxing an ester-linked storage lipid in concentrated potassium hydroxide cleaves all of its ester bonds and releases the chains as carboxylates; acidifying then protonates them to free fatty acids, which partition into the organic solvent. Ether bonds, by contrast, are far more robust and survive hot base, which is one reason organisms in harsh environments favor them. The archaeal sample should therefore yield no freed chains, and it functions as a negative control showing that the workup itself does not generate fatty acids from a lipid lacking ester bonds. The informative pattern is the asymmetry: fatty acids from the adipose lipid, nothing from the archaeal lipid. (Choice A) would undermine the experiment rather than support the hypothesis. Recovery from both samples would imply that the treatment cleaves ether linkages as readily as esters, contrary to their known resistance to base, and would strip the assay of any power to discriminate between the two linkage types. (Choice C) reverses the expected pattern. It assigns base-labile behavior to the ether-linked lipid and base resistance to the putatively ester-linked one, the opposite of what the hypothesis predicts. (Choice D) names the wrong product class. When an ester is cleaved by base, the chain departs as the carboxylate because the acyl carbonyl belongs to the chain; long-chain alcohols would instead point to cleavage of an ether linkage or to a reductive workup, neither of which applies here. This is a Reasoning about the Design and Execution of Research question because it asks which outcome of a paired experiment with a built-in negative control would support the hypothesized linkage chemistry of the storage lipid.

---

## Q13 . Soap micelle self-assembly geometry

**Stem.** Boiling a triacylglycerol with concentrated sodium hydroxide yields glycerol plus the sodium salt of a long-chain fatty acid, a molecule joining one charged head to a single flexible hydrocarbon tail. Dispersed in water above a threshold amount, these salts spontaneously aggregate. Which arrangement do the aggregates adopt?

- **A.** Extended double-layered sheets in which two rows of tails meet in the middle, with heads on both outer faces
- **B.** Hollow shells that enclose an internal pool of water behind a single curved wall of molecules
- **C.** Compact spheres whose tails pack together in a water-free core while the ionic groups line the outer surface facing the solvent  <- **KEY**
- **D.** Compact spheres whose ionic groups cluster at the center while the tails extend outward into the water

| | |
|---|---|
| Foundation | 2A |
| Content category | Lipids |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 65 s |
| Confidence | 5 |

**Correct answer (C): Compact spheres whose tails pack together in a water-free core while the ionic groups line the outer surface facing the solvent**

Citations: BC:42798, BC:43029, BC:43040, BC:2634

**Distractors**

- **(A)** `adjacent_fact` . _wrong lipid class geometry_: Bilayer sheets are the real aggregate of two-tailed cylindrical lipids, a true fact misapplied to a one-tailed cone-shaped soap; differs from the key along the single dimension of overall aggregate geometry.
  - Citation: BC:43029
- **(B)** `misconception` . _micelle-liposome conflation_: Students routinely picture micelles as water-filled vesicles; a single-chain micelle has a tail-filled, water-free core; differs from the key along the single dimension of interior contents.
  - Citation: BC:43040
- **(D)** `reversed_relationship` . _inverted orientation_: Flips which end is buried: putting ionic heads inside and tails outside maximizes unfavorable hydrocarbon-water contact; differs from the key along the single dimension of monomer orientation.
  - Citation: BC:4805

**Readback check.** Key content words of six or more letters: compact, spheres, together, groups, surface, facing, solvent. None appears in the stem, whose six-plus-letter words are boiling, triacylglycerol, concentrated, sodium, hydroxide, glycerol, molecule, joining, charged, single, flexible, hydrocarbon, dispersed, threshold, amount, spontaneously, aggregate, arrangement. No echo; the key requires inferring geometry from monomer shape, not restating the stem.

**Explanation (as shipped).**

> This Lipids question tests how the two-part architecture of a soap molecule, an ionic head joined to a single hydrocarbon tail, dictates the geometry of the aggregates it forms in water. The answer is C because a fatty-acid salt is a classic single-chain amphiphile. The charged carboxylate head interacts favorably with water, while the long hydrocarbon tail cannot, so above a threshold level the molecules arrange themselves to hide every tail from solvent while keeping every head solvated. A single flexible tail tapering away from a comparatively bulky ionic head gives each molecule a roughly cone-shaped profile, and cones pack most naturally into a small, sharply curved sphere. The product is a micelle: a compact ball whose interior is an essentially anhydrous mass of intertwined tails and whose exterior is a shell of charged heads in full contact with the water. (Choice A) Extended double-layered sheets are the signature arrangement of two-tailed lipids such as glycerophospholipids; a second tail widens the molecule into a roughly cylindrical shape that packs side by side into flat layers, whereas the cone profile of a one-tailed soap is a poor fit for a planar sheet and instead favors high curvature. (Choice B) A wall enclosing an internal pool of water describes a vesicle or liposome, which requires a double-layered boundary presenting heads to both an inner and an outer aqueous space; an aggregate of single-tailed soap molecules has no aqueous interior at all, because the buried tails completely fill its core. (Choice D) This choice inverts the orientation of the monomer. Sequestering the charged heads in a dry core would sacrifice their strong ion-dipole interactions with the solvent while simultaneously forcing every hydrocarbon chain into maximal contact with water, so this arrangement maximizes exactly the unfavorable exposure that aggregation exists to eliminate. This is a Scientific Reasoning and Problem Solving question because it requires predicting the geometry of a self-assembled aggregate from the polarity and shape of its monomer rather than recalling a memorized diagram.

---

## Q14 . Entropic driving force of micellization

**Stem.** Calorimetry shows that a sodium alkanoate soap aggregates into micelles at 25 degrees Celsius with an enthalpy change close to zero, yet the process is strongly spontaneous. Which of the statements below account for the spontaneity?

I. Water molecules held in ordered, cage-like arrangements around each dispersed hydrocarbon chain are released into bulk solvent when the chains bury one another.
II. The soap molecules themselves gain positional freedom when they leave free solution and pack into an aggregate.
III. The total entropy of the system rises enough to make the free energy change negative even without an enthalpic contribution.

- **A.** I only
- **B.** I and III  <- **KEY**
- **C.** II and III
- **D.** I, II, and III

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 95 s |
| Confidence | 5 |
| Hard-tier gate | (a) combines micelle self-assembly with entropy bookkeeping split across solvent and solute; (b) directional inference about which entropy terms rise and which fall given a near-zero enthalpy; (d) inverts the usual intuition that a solute becoming more ordered should oppose spontaneity. |

**Correct answer (B): I and III**

Citations: BC:4744, BC:4749, BC:4751, BC:4753

**Distractors**

- **(A)** `partial_truth` . _true but incomplete numeral set_: Statement I is genuinely correct, but alone it omits the thermodynamic conclusion in III that links the water entropy gain to the negative free energy change; differs from the key only by dropping III.
  - Citation: BC:4753
- **(C)** `misconception` . _solute-entropy error_: Swaps true statement I for false statement II, the common belief that the aggregating molecules themselves gain entropy; they lose freedom when packed into a micelle; differs from the key only by which entropy claim is included.
  - Citation: BC:4744
- **(D)** `partial_truth` . _over-inclusive numeral set_: Contains both correct statements but adds false statement II, so the set as a whole misassigns an entropy increase to the confined amphiphiles; differs from the key only by adding II.
  - Citation: BC:4751

**Readback check.** The key is the numeral combination I and III and contains no content words of six or more letters, so no stem echo is possible; selecting it requires evaluating the entropy sign of solvent and solute separately, an inference the stem never states.

**Explanation (as shipped).**

> This Lipids question probes the thermodynamic driving force behind micelle formation by soaps, the hydrophobic effect. The answer is B because statements I and III are correct while statement II is not. When a hydrocarbon chain sits alone in water, the surrounding water cannot hydrogen-bond to it and instead organizes into ordered, cage-like shells that preserve water-to-water hydrogen bonding at the cost of positional freedom, a state with fewer available microstates. When the chains cluster into a micelle core, much of that structured water is liberated into bulk solvent, where far more microstates are available, so the entropy of the water rises sharply, exactly as statement I describes. Because the measured enthalpy change is near zero, this solvent entropy gain is what drives the free energy change negative, which is the content of statement III. Statement II carries the wrong sign for the amphiphile itself: a soap molecule that leaves free solution and packs into a defined aggregate loses translational and conformational freedom, so its own entropy falls. Micellization proceeds because the entropy gained by the released water outweighs the entropy lost by the confined amphiphiles. (Choice A) Statement I is accurate but incomplete on its own; without statement III the reasoning never connects the release of ordered water to the negative free energy change that the calorimetric data demand an entropic term to supply. (Choice C) This pairing keeps the correct thermodynamic conclusion but attributes the entropy gain to the soap molecules; the amphiphiles become more ordered upon aggregation, not less, so statement II cannot be part of the explanation. (Choice D) Including all three statements imports the same error, since II asserts an entropy increase for molecules that are in fact surrendering freedom as they pack into an organized aggregate. This is a Scientific Reasoning and Problem Solving question because it requires partitioning an overall entropy change between solvent and solute and using thermodynamic sign logic to identify which contributions can drive a spontaneous process when the enthalpy change is negligible.

---

## Q15 . Grease sequestration cleaning mechanism evidence

**Stem.** A detergent researcher proposes that aqueous soap lifts olive oil from cotton by enclosing oil droplets within the nonpolar interior of self-assembled particles whose anionic exteriors keep them suspended, so rinse water carries the assemblies away. A rival proposal holds that the soap solution instead cleaves the ester linkages of the oil. Which finding in the collected rinse water most strongly favors the first proposal over the rival?

- **A.** The oil is recovered chemically unchanged and co-fractionates with the surfactant rather than pooling as a separate layer  <- **KEY**
- **B.** Glycerol and free long-chain carboxylic acids appear in the rinse water in place of the intact oil
- **C.** The rinse water exhibits a markedly lower surface tension than pure water does
- **D.** The rinse water conducts an electric current far more readily than pure water does

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 3 |
| Difficulty | **medium** (topic secondary / structural two_step) |
| Estimated time | 80 s |
| Confidence | 4 |

**Correct answer (A): The oil is recovered chemically unchanged and co-fractionates with the surfactant rather than pooling as a separate layer**

Citations: BC:42798, BC:43029, BC:4805

**Distractors**

- **(B)** `reversed_relationship` . _evidence for the rival hypothesis_: Hydrolysis products are exactly what the ester-cleavage proposal predicts, so this finding supports the rival rather than the encapsulation mechanism; differs from the key along the single dimension of which hypothesis the evidence favors.
  - Citation: BC:42798
- **(C)** `partial_truth` . _true but non-discriminating result_: Surfactants really do lower surface tension, but the effect occurs regardless of the fate of the oil, so it cannot distinguish the mechanisms; differs from the key along the single dimension of discriminating power.
  - Citation: BC:43029
- **(D)** `adjacent_fact` . _irrelevant true property_: Soap solutions do conduct because the salt dissociates, but ionic dissociation is shared scenery in both proposals and says nothing about oil removal; differs from the key along the single dimension of relevance to the tested mechanism.
  - Citation: BC:42798

**Readback check.** Key content words of six or more letters: recovered, chemically, unchanged, fractionates, surfactant, pooling, separate. None appears in the stem, whose six-plus-letter words include researcher, proposes, aqueous, enclosing, droplets, nonpolar, interior, assembled, particles, anionic, exteriors, suspended, assemblies, proposal, cleaves, linkages, finding, collected, strongly, favors. No echo; the key is a predicted experimental outcome, not a restatement.

**Explanation (as shipped).**

> This Lipids question examines the physical mechanism by which soap cleans and asks which experimental observation would distinguish it from a chemical alternative. The answer is A because the sequestration mechanism makes two linked predictions: the grease should survive washing with its covalent structure intact, and it should travel with the surfactant assemblies rather than remain as a distinct oily phase. Recovering unchanged oil that co-fractionates with the surfactant satisfies both predictions at once, and it simultaneously undercuts the rival ester-cleavage proposal, which requires the oil to emerge chemically altered. A discriminating experiment is one whose predicted outcome differs between the hypotheses, and this observation meets that standard. In practice the fractionation could be run by centrifuging or dialyzing the rinse water and assaying which fraction the oil travels with, so the prediction is directly testable. (Choice B) Finding glycerol and free long-chain acids in place of intact oil is evidence in the wrong direction: those are precisely the hydrolysis products the rival proposal predicts, so this result would count for ester cleavage and against encapsulation. (Choice C) Lowered surface tension is a genuine property of any surfactant solution, but it arises from molecules accumulating at the air-water boundary and would be observed whether the oil ends up encapsulated or hydrolyzed, so it cannot separate the two proposals. (Choice D) Better conduction of current merely confirms that the soap dissociates into ions in water; both hypotheses invoke the same ionic soap, so this measurement carries no information about how the oil is removed. This is a Reasoning about the Design and Execution of Research question because it asks which observable result would discriminate between two competing mechanistic hypotheses rather than which result is merely consistent with one of them.

---

## Q16 . Critical micelle concentration monomer plateau

**Stem.** A researcher adds a single-chain sulfonate surfactant to water in steps and, after each step, measures how much of it remains singly dispersed.

| Total added (mM) | Singly dispersed (mM) |
|---|---|
| 2 | 2.0 |
| 5 | 5.0 |
| 8 | 7.9 |
| 12 | 8.0 |
| 20 | 8.0 |

What accounts for the behavior of the system past a total of 8 mM?

- **A.** The solution has reached its solubility limit, so molecules added past that point precipitate out of solution as a solid
- **B.** Aggregates formed near 8 mM swell to absorb the later additions, each one holding progressively more molecules
- **C.** Newly formed aggregates progressively strip molecules from the dispersed pool, which will steadily shrink as more is added
- **D.** Material added past that point assembles into additional micelles, leaving the level of free monomers pinned at the critical micelle concentration  <- **KEY**

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 100 s |
| Confidence | 5 |
| Hard-tier gate | (b) quantitative inference from the plateau and its breakpoint in supplied data; (c) choices A and B both stay defensible until the discriminating facts apply, namely that micelles are fully soluble aggregates and that they form at a roughly fixed aggregation number, so added surfactant raises micelle number rather than micelle size. |

**Correct answer (D): Material added past that point assembles into additional micelles, leaving the level of free monomers pinned at the critical micelle concentration**

Citations: BC:44105, BC:44109, BC:45887, BC:43958

**Distractors**

- **(A)** `misconception` . _CMC confused with solubility limit_: Treats the plateau as saturation followed by precipitation; above the CMC the surfactant remains dissolved as soluble micelles with no solid phase; differs from the key along the single dimension of the fate of the added material.
  - Citation: BC:43958
- **(B)** `partial_truth` . _right process, wrong mode_: Correctly places added material into aggregates but claims existing ones swell without limit; aggregation number is roughly fixed, so micelle number grows instead; differs from the key along the single dimension of number versus size.
  - Citation: BC:45887
- **(C)** `reversed_relationship` . _wrong direction of change_: Predicts a falling free pool, but the data hold constant at 8.0 mM across the last two rows, showing exchange equilibrium rather than depletion; differs from the key along the single dimension of the free pool trajectory.
  - Citation: BC:44109

**Readback check.** Key content words of six or more letters: material, assembles, additional, micelles, leaving, monomers, pinned, critical, concentration. None appears in the stem or table, whose six-plus-letter words are researcher, single-chain, sulfonate, surfactant, measures, remains, singly, dispersed, accounts, behavior, system. No echo, and the key states a mechanism inferred from the plateau, not a value read off the table.

**Explanation (as shipped).**

> This Lipids question presents titration-style surfactant data and tests interpretation of the critical micelle concentration. The answer is D because the table shows two regimes. Through the first three rows the free pool tracks the total nearly one to one, and the small dip to 7.9 mM at a total of 8 mM signals that aggregation is just beginning. Past that point the free pool stops responding entirely, holding at 8.0 mM even as the total climbs to 20 mM, which places the breakpoint at about 8 mM. That plateau marks the critical micelle concentration: once free monomers reach this level, self-association becomes favorable, and essentially every molecule added afterward partitions into micelles instead of the free pool. Because micelles of a given surfactant assemble with a characteristic aggregation number, continued addition multiplies the number of micelles in solution while the free monomer level, in dynamic exchange with them, stays fixed. (Choice A) A true solubility limit would also cap the free pool, but a saturated solution sheds its excess as a visible solid phase; a surfactant past its transition instead stays fully in solution as soluble aggregates, which is why such solutions remain clear and keep gaining cleaning capacity with further addition. (Choice B) Growth of existing aggregates could in principle absorb added material, but the balance of head repulsion and tail packing sets a preferred aggregate size for a given surfactant, so later additions generate more micelles of similar size rather than ever-larger ones; the mode of accommodation, number versus size, is what this choice gets wrong. (Choice C) This choice predicts the wrong trajectory for the free pool: if aggregates steadily drained material that had already dissolved, the plateau would slope downward, whereas the values hold flat at 8.0 mM from 12 through 20 mM, indicating steady-state exchange rather than depletion. This is a Data-based and Statistical Reasoning question because it requires locating the breakpoint in a saturation curve and inferring the molecular partitioning that keeps one measured quantity constant while the total keeps rising.

---

## Q17 . Wax ester structure and inertness

**Stem.** The leaves of a desert shrub are coated with a lipid in which a straight, fully saturated 26-carbon fatty acid is joined through a single ester bond to a straight, fully saturated 30-carbon alcohol. The coating is a firm solid that liquid water cannot penetrate. Which feature of this lipid most directly produces both properties?

- **A.** Its single ester group is ionized at physiological pH, and attraction between the charged groups locks neighboring molecules into a rigid ionic lattice.
- **B.** Nearly the whole molecule is nonpolar hydrocarbon, so neighboring chains pack tightly and present essentially no polar region for water to bind.  <- **KEY**
- **C.** Its chains pack closely, but the solid is held together mainly by hydrogen bonds that the ester oxygens donate to adjacent molecules.
- **D.** Covalent cross-links form between adjacent molecules, creating a continuous polymer network like that of a plastic.

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 80 s |
| Confidence | 5 |

**Correct answer (B): Nearly the whole molecule is nonpolar hydrocarbon, so neighboring chains pack tightly and present essentially no polar region for water to bind.**

Citations: BC:43073-43113 (waxes as very long-chain fatty acids and long-chain alcohol derivatives including esters; extremely nonpolar; insolubility and high melting point arise from long chains, few electronegative atoms, no C=C); BIO:4088-4091 (hydrophobic wax coverings)

**Distractors**

- **(A)** `misconception`: Esters have no acidic proton and do not ionize at physiological pH; the student confuses the esterified acid with a free carboxylic acid. Differs from the key only in the proposed cohesive force (ionic vs hydrophobic packing).
- **(C)** `partial_truth`: Tight packing is correct, but a wax ester has no O-H or N-H donor, so hydrogen bonding cannot be the cohesive force; dispersion between chains is. Differs from the key only in the attributed force.
- **(D)** `adjacent_fact`: Covalent cross-linking describes the cutin polyester polymer of plant cuticle, an adjacent real structure; wax molecules are discrete and associate only noncovalently. Differs from the key only in covalent versus noncovalent association.

**Readback check.** Key six-plus-letter content words (nearly, molecule, nonpolar, hydrocarbon, neighboring, chains, tightly, essentially, region) appear nowhere in the stem. The stem describes structure only; the key is an inference from bonding pattern to macroscopic properties, not a restatement or supplied definition.

**Explanation (as shipped).**

> This Lipids question tests how the structure of a wax, a single ester formed between a long-chain fatty acid and a long-chain alcohol, produces its characteristic hardness and water impermeability. The answer is B because nearly every atom in this lipid belongs to one of two long, straight, saturated hydrocarbon chains, with only one small ester group interrupting them. Straight saturated chains maximize surface contact with their neighbors, so cumulative dispersion attractions between chains hold the solid together and push its melting point well above any temperature the plant will experience. At the same time, the molecule gives water almost nothing to grip: one ester group among more than fifty carbons cannot offset the overwhelming hydrophobic character of the two tails, so water can neither dissolve the material nor pass through it. Compare a triacylglycerol, which carries three esters on a glycerol backbone: a wax carries a single ester between two hydrocarbon tails, which is why waxes are even more inert and water repellent than storage fats. (Choice A) Ester groups do not ionize at physiological pH. A free carboxylic acid could lose a proton, but esterification consumes that acidic proton, so no charged head groups exist and no ionic lattice can form. (Choice C) The packing claim is sound, but the cohesion claim fails: a wax ester contains no O-H or N-H group, so the molecule has no hydrogen bond donor. Its ester oxygens could only accept hydrogen bonds that nothing in the solid can supply, leaving chain-to-chain dispersion attractions as the true cohesive force. (Choice D) Wax molecules remain discrete; they associate through noncovalent packing, not covalent bonds. A covalently cross-linked network describes a polymer such as cutin, the polyester scaffold of the plant cuticle, not the wax deposited on and in it. This is a Scientific Reasoning and Problem Solving question because it requires connecting the bonding pattern and chain composition of a described, unfamiliar molecule to two macroscopic properties rather than recalling a memorized fact about waxes.

---

## Q18 . Wax barrier against water loss

**Stem.** A barley mutant cannot attach very long-chain fatty acids to very long-chain alcohols, so its leaf cuticle lacks the ester lipids normally deposited there. When wild-type and mutant seedlings are exposed to dry, moving air, which outcome is most likely for the mutant relative to the wild type?

- **A.** More rapid escape of moisture from the tissues beneath the surface  <- **KEY**
- **B.** Greater injury from ultraviolet radiation reaching the cells below
- **C.** Overheating, because the missing layer normally serves as the plant's chief insulation against heat exchange
- **D.** Swelling of interior tissues, because the missing layer normally provides the route through which water vapor exits

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 60 s |
| Confidence | 5 |

**Correct answer (A): More rapid escape of moisture from the tissues beneath the surface**

Citations: BC:43109-43113 (extremely nonpolar waxes make great barriers preventing water loss through leaves and water penetration into the ear; hydrophobic barrier function arises from structure); BIO:4088-4091 (hydrophobic wax covers aquatic bird feathers and leaf surfaces)

**Distractors**

- **(B)** `adjacent_fact`: Cuticle components can scatter some ultraviolet light, a real but secondary attribute; the described hydrocarbon layer is defined by water impermeability, and the stated stress is dry air. Differs from the key only in which environmental threat is invoked.
- **(C)** `misconception`: A thin surface lipid film is not a significant thermal insulator, and no temperature stress is described; the student substitutes a heat-regulation role for the barrier role. Differs from the key only in the function attributed to the layer.
- **(D)** `reversed_relationship`: Treats the wax as the exit route for water rather than the barrier against its exit; removing a barrier accelerates loss, it cannot cause accumulation. Differs from the key only in the direction of the layer's effect on water movement.

**Readback check.** Key six-plus-letter content words (escape, moisture, tissues, beneath, surface) appear nowhere in the stem. The stem never states the barrier function of the missing lipids; the student must infer water loss from the loss of a hydrophobic seal, so the key is not a readback.

**Explanation (as shipped).**

> This Lipids question tests the barrier role of waxes and asks the student to derive that role from wax structure. The answer is A because the cuticular esters, each formed from one very long fatty acid chain joined to one very long alcohol chain, build an almost purely hydrocarbon layer over the leaf. Tightly packed, saturated, nonpolar chains give a polar molecule like water no favorable route across, so an intact coating holds interior moisture in. A mutant unable to form these esters lacks that seal, and in dry moving air its wet interior tissues lose water by evaporation far faster than those of the wild type. The inference runs from structure to function: the same features that make a wax inert and solid, two long saturated tails joined through a single small ester group, are exactly what make the deposit an effective seal against water movement. The identical logic explains the water-repellent wax coatings on the feathers of aquatic birds and in the mammalian ear canal, where extreme nonpolarity blocks water traffic in whichever direction matters. (Choice B) Some cuticle components do absorb or scatter ultraviolet light, but that role is incidental to the chemistry described here, and the stem's stress is dry moving air, which threatens the plant with drying out, not with irradiation. (Choice C) A thin lipid film is not a meaningful thermal insulator, and nothing in the scenario involves temperature stress. This choice imports a heat-regulation role that the wax layer does not perform. (Choice D) This reverses the layer's relationship to water. The wax is a barrier that keeps water in, not the conduit through which water leaves; removing a barrier speeds water escape and cannot make water back up and accumulate inside the leaf. This is a Scientific Reasoning and Problem Solving question because it requires predicting the physiological outcome of a structural deficit by reasoning from the chemistry of the missing lipid layer to its barrier function.

---

## Q19 . Isoprene unit counting in terpenes

**Stem.** Squalene, an open-chain hydrocarbon abundant in shark liver oil and human skin surface lipids, contains 30 carbon atoms and is assembled entirely from isoprene units. How many isoprene units are incorporated into one molecule of squalene?

- **A.** Two
- **B.** Three
- **C.** Six  <- **KEY**
- **D.** Fifteen

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 4 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 70 s |
| Confidence | 5 |

**Correct answer (C): Six**

Citations: BC:43690-43704 (isoprenoids/terpenes built from isoprene, a small branched alkadiene; biological polymerization uses C5 DMAPP and IPP); BC:43696-43758 (geranyl C10, farnesyl C15, geranylgeranyl C20; two farnesyl C15 units join tail to tail to form squalene, each isoprene unit is 5 carbons)

**Distractors**

- **(A)** `misconception`: Two is correct only for a monoterpene (C10); the student overgeneralizes the memorized monoterpene pairing to every terpene. Differs from the key only in which class rule is applied.
- **(B)** `scale_unit_error`: Divides 30 by 10, using the ten carbon monoterpene classification block as the counting unit instead of the five carbon isoprene unit; this yields the triterpene class number, not the isoprene count. Differs from the key only in unit size.
- **(D)** `process_step_confusion`: Divides 30 by 2, importing the two carbon elongation steps of fatty acid synthesis into isoprenoid assembly, which grows five carbons at a time. Differs from the key only in which biosynthetic increment is assumed.

**Readback check.** The key is a bare numeral with no content words to echo. The stem supplies the carbon count but never the unit size, so the answer cannot be read off the data: the student must supply the five carbon isoprene unit and perform the division.

**Explanation (as shipped).**

> This Lipids question tests the isoprene counting convention for terpenes and other isoprenoid lipids. The answer is C because an isoprene unit contains five carbon atoms, so a 30 carbon isoprenoid must be built from 30 divided by 5, or six, units. Isoprene itself is 2-methyl-1,3-butadiene, a branched five carbon diene. Cells never polymerize free isoprene; they condense the activated five carbon donors isopentenyl pyrophosphate and dimethylallyl pyrophosphate, generating the ten carbon geranyl, fifteen carbon farnesyl, and twenty carbon geranylgeranyl intermediates. Two fifteen carbon farnesyl groups then join tail to tail to give the thirty carbon squalene, and the biosynthetic route confirms the arithmetic: three units in each half, six in all. Keeping the two counting systems separate matters, because terpene class names are based on ten carbon blocks while isoprene accounting uses five carbon units, and a question can ask for either. (Choice A) Two is the number of isoprene units in a monoterpene, the C10 class that includes many plant fragrance compounds. Extending that pairing to every terpene ignores the larger classes entirely; a thirty carbon compound holds three times the carbons of a monoterpene. (Choice B) Three comes from dividing 30 by 10, counting monoterpene-sized blocks rather than isoprene units. That arithmetic explains why squalene is classified as a triterpene, but each such classification block contains two isoprene units, so the requested count is twice three, not three. (Choice D) Fifteen comes from dividing 30 by 2, as though the chain grew by two carbon increments. Growth in two carbon steps describes fatty acid synthesis from acetyl groups, a completely separate assembly line; isoprenoid chains lengthen five carbons at a time. This is a Data-based and Statistical Reasoning question because it requires taking the carbon count supplied in the stem and converting that quantitative datum into a number of building blocks using the correct unit size.

---

## Q20 . Hard water soap failure experiment

**Stem.** A student's sodium stearate soap lathers and removes grease in distilled water, but in local well water it lathers poorly and leaves a gray, insoluble residue. She hypothesizes that dissolved divalent cations in the well water are inactivating the soap. Which procedure would most directly test her hypothesis?

- **A.** Boil a portion of the well water, let it cool, and test whether newly added soap performs better in it
- **B.** Acidify a portion of distilled water until added soap stops working, demonstrating that the soap can be inactivated in solution
- **C.** Collect the gray residue and assay it for glycerol released as the soap decomposed
- **D.** Treat a fresh portion of the well water with a chelating agent that binds doubly charged metal ions, then test whether newly added soap foams and cleans in it  <- **KEY**

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 3 |
| Difficulty | **hard** (topic secondary / structural multi_step) |
| Estimated time | 100 s |
| Confidence | 4 |
| Hard-tier gate | (a) combines two concepts: carboxylate precipitation chemistry of soaps and variable-isolation experimental logic; (c) two distractors stay defensible until a discriminating fact applies: boiling (A) genuinely softens water but only the bicarbonate-paired fraction and while changing several variables at once, and acidification (B) genuinely inactivates soap but by a different mechanism in the wrong sample. |

**Correct answer (D): Treat a fresh portion of the well water with a chelating agent that binds doubly charged metal ions, then test whether newly added soap foams and cleans in it**

Citations: BC:42797-42799 (base-catalyzed hydrolysis of fatty acid lipids releases fatty acid salts, soaps, in saponification); BC:2633-2644 (amphiphiles with polar head and nonpolar tail self-associate into micelles). Divalent cation precipitation of carboxylate soaps (hard water scum) and protonation of the carboxylate head are standard soap physical chemistry consistent with these sources.

**Distractors**

- **(A)** `partial_truth`: Boiling does soften some hard water, but only the temporary bicarbonate-paired fraction, and it simultaneously alters gases and solute concentration, so it does not isolate divalent cations as the single variable. Differs from the key only in the specificity of the manipulation.
- **(B)** `adjacent_fact`: Demonstrates the other real soap failure mode, protonation of the carboxylate head in acid, but does so in distilled water, so it tests a different mechanism in the wrong sample and cannot address the cation hypothesis. Differs from the key only in which inactivation mechanism is probed.
- **(C)** `misconception`: Assumes the scum is soap hydrolyzed back to glycerol-containing fat; scum is actually a calcium or magnesium carboxylate salt, and glycerol was removed during manufacture and is not regenerated. Differs from the key only in the assumed identity of the precipitate.

**Readback check.** Key six-plus-letter content words (portion, chelating, doubly, charged, cleans) do not appear in the stem except as required option-frame words; the stem states the hypothesis but never mentions chelation or ion sequestration, so choosing the key requires designing the discriminating manipulation, not reading one back.

**Explanation (as shipped).**

> This Lipids question tests the hard water failure mode of soap inside an experimental design frame. The answer is D because a chelating agent selectively sequesters doubly charged metal ions such as calcium and magnesium while leaving every other property of the well water unchanged, so it manipulates exactly one variable, the one named in the hypothesis. Soap cleans because each stearate anion is amphipathic: the charged carboxylate head keeps it dispersed in water while the long hydrocarbon tail buries grease inside micelles. Calcium and magnesium ions bridge pairs of carboxylate heads to form an insoluble salt, the familiar gray scum, stripping the surfactant out of solution. If chelation restores foaming and cleaning, divalent cations were the cause; if performance stays poor, the hypothesis is undermined. Either result is interpretable, the mark of a well designed test. (Choice A) Boiling can soften water, but only temporary hardness, the fraction paired with bicarbonate, precipitates on heating, and boiling also changes dissolved gas content and concentrates the remaining solutes. With several variables moving at once, neither outcome would cleanly implicate or clear divalent cations. (Choice B) Acidifying distilled water demonstrates a real but different failure mode: protonating the carboxylate head erases the charge that makes soap amphipathic. Showing that acid can disable soap in a separate sample establishes nothing about what the well water contains, so it cannot test this hypothesis. (Choice C) The gray residue is a calcium or magnesium salt of the fatty acid anion. Glycerol separates from the fatty acid salts during soap manufacture and is not regenerated when soap precipitates, so this assay probes a transformation that does not occur. This is a Reasoning about the Design and Execution of Research question because it asks which manipulation isolates the single hypothesized variable and yields an interpretable result about why the soap failed.

---

## Q21 . Cholesterol's hydrophobic architecture

**Stem.** Lipids are defined operationally: a compound joins the class when it dissolves preferentially in nonpolar organic solvents rather than in water. Cholesterol, despite bearing one hydroxyl group, meets this standard. Which structural feature of cholesterol best accounts for this solvent behavior?

- **A.** Fused hydrocarbon rings and a short branched side chain form nearly the whole molecular surface, leaving the lone polar group heavily outweighed  <- **KEY**
- **B.** Its hydroxyl group makes no contribution to interactions with water, so no portion of the molecule is drawn toward a polar solvent
- **C.** The rigidity created by joining the rings into one fused unit is itself what excludes water, independent of which atoms compose the rings
- **D.** The hydroxyl group confers net polarity on the free molecule, which favors nonpolar solvents only once that group is esterified to a fatty acid

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 1 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 70 s |
| Confidence | 5 |

**Correct answer (A): Fused hydrocarbon rings and a short branched side chain form nearly the whole molecular surface, leaving the lone polar group heavily outweighed**

Citations: BC:43890-43891 (cholesterol as a mostly planar amphiphile), BC:43922-43923 (lipids defined by organic-solvent solubility and hydrophobic nature), BC:44924 (cholesterol's polar OH orientation), BC:934 (rigid planar ring system), BC:4566 (cholesterol esters as nonpolar biomolecules) from /Users/mikkonieveras/praxis-prep/reference-textbooks/biochemistry/libretexts-biochemistry.txt

**Distractors**

- **(B)** `partial_truth` . _overcorrection to zero polarity_: True that the hydroxyl cannot make cholesterol water-soluble, but false that it contributes nothing: the OH hydrogen bonds with water and orients cholesterol at the bilayer surface, making the molecule weakly amphipathic rather than purely hydrophobic.
  - Citation: BC:44924
- **(C)** `misconception` . _rigidity equals hydrophobicity_: Attributes solvent preference to ring fusion and rigidity per se rather than to hydrocarbon composition; a rigid molecule bearing polar groups, such as a cyclic sugar, dissolves readily in water, so fusion alone cannot explain the behavior.
  - Citation: BC:934
- **(D)** `reversed_relationship` . _small polar group dominates the frame_: Reverses which portion of the molecule dominates: the single hydroxyl does not confer net polarity, and free unesterified cholesterol already dissolves preferentially in nonpolar media; esterification only intensifies an existing hydrophobic character.
  - Citation: BC:4566

**Readback check.** Stem content words of six or more letters (lipids, defined, operationally, compound, dissolves, preferentially, nonpolar, organic, solvents, rather, cholesterol, despite, bearing, hydroxyl, standard, structural, feature, accounts, solvent, behavior) share no word with key content words of six or more letters (hydrocarbon, branched, nearly, molecular, surface, leaving, heavily, outweighed). Verified programmatically: intersection is empty. Pass: the key states the structural explanation without echoing the stem's stated premise.

**Explanation (as shipped).**

> Lipids, unlike proteins or nucleic acids, are grouped by how they behave in solvents rather than by a shared covalent backbone, and this question asks which feature of cholesterol's architecture places it firmly on the hydrophobic side of that dividing line. The answer is A because the four fused hydrocarbon rings, together with the short branched tail attached at carbon 17 and the methyl groups projecting from the ring junctions, account for nearly all of the molecule's surface. Almost every atom a solvent encounters is carbon or hydrogen, capable only of weak London dispersion interactions, so the molecule mixes readily with nonpolar media. The lone hydroxyl at carbon 3 does give cholesterol a faint polar character, enough to orient the molecule at a membrane surface, but one small oxygen-bearing group cannot anchor such a large hydrocarbon frame in water. Weighing that single group against the bulk of the molecule is the key step: the hydrocarbon portion wins decisively, so cholesterol stays with the lipids while remaining, at most, weakly amphipathic.
>
> (Choice B) overstates the case in the opposite direction. The hydroxyl is not inert toward water; it hydrogen bonds with the aqueous phase and points outward when cholesterol sits in a bilayer leaflet. The correct picture is a weak polar contribution that is outweighed by the hydrocarbon bulk, not a polar contribution that is absent.
>
> (Choice C) mistakes geometry for composition. Fusion of the rings makes cholesterol rigid and roughly planar, which matters for membrane packing, but rigidity itself does not repel water. A rigid molecule studded with polar groups, such as a sugar locked in its ring form, dissolves in water readily. It is the carbon and hydrogen content of the rings, not the fact that they are fused, that governs solvent preference.
>
> (Choice D) reverses the actual balance of forces. The hydroxyl does not dominate the molecule or pull it into the aqueous phase, and free cholesterol needs no esterification to behave as a lipid. Esterifying the hydroxyl with a fatty acid does make the molecule even more hydrophobic, which is how cells package cholesterol for storage, but the unmodified molecule already favors the nonpolar phase overwhelmingly.
>
> This is a Knowledge of Scientific Concepts and Principles question because it asks you to recall the structural makeup of cholesterol and apply the general principle that a molecule's solvent preference reflects the balance between its polar and nonpolar surface area.

---

## Q22 . Squalene as hexaisoprenoid steroid precursor

**Stem.** In animal tissue, a linear thirty-carbon hydrocarbon assembled entirely from branched five-carbon units undergoes cyclization to yield a compound containing three six-membered rings and one five-membered ring fused together. This transformation supports which of the statements below?

I. The fused ring skeleton found in steroids originates from isoprene-derived building blocks.
II. The open-chain precursor contains six isoprene equivalents.
III. The open-chain precursor was assembled by the same stepwise two-carbon elongation that builds fatty acid chains.

- **A.** I only
- **B.** II only
- **C.** I and II only  <- **KEY**
- **D.** I, II, and III

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic secondary / structural multi_step) |
| Estimated time | 105 s |
| Confidence | 5 |
| Hard-tier gate | (a) combines two concepts: recognizing the branched C5 unit as isoprene and the described ring pattern as the steroid nucleus; (b) quantitative inference converting the C30 count into six isoprene equivalents; additionally (c) statement III stays defensible until the branched versus unbranched chain discriminator is applied. |

**Correct answer (C): I and II only**

Citations: BC:43756-43758 (two farnesyl pyrophosphate C15 units join tail to tail to form squalene, a precursor of cholesterol, with each five carbon isoprene unit identified); BC:43791 (squalene labeled C30); BC:43690-43691 (isoprenoid lipids contain no fatty acids; isoprene, a small branched alkadiene, polymerizes into isoprenoids often called terpenes); BIO:4139-4146 (steroids characterized by a fused ring structure of four linked carbon rings)

**Distractors**

- **(A)** `scale_unit_error` . _miscounted repeating units_: Rejects statement II by failing the unit arithmetic: thirty carbons divided by five carbons per isoprene gives exactly six equivalents, so the count is fully supported.
  - Citation: BC:43758
- **(B)** `misconception` . _steroids assumed fatty acid derived_: Accepts the arithmetic but denies statement I, reflecting the belief that steroid carbon comes from fatty acid machinery rather than isoprene; the cyclization of an all isoprenoid chain into the steroid ring pattern establishes the isoprenoid ancestry directly.
  - Citation: BC:43756-43758
- **(D)** `process_step_confusion` . _wrong assembly pathway attached_: Statement III attaches the fatty acid assembly process to an isoprenoid: stepwise two carbon elongation produces long unbranched chains and cannot generate a branched five carbon repeating skeleton.
  - Citation: BC:43690-43691

**Readback check.** The key is the option letter C (I and II only), which contains no content words. The narrative portion of the stem never names isoprene, squalene, or steroid; those names appear only inside the Roman numeral statements the student must evaluate, so the student still has to verify that the branched five carbon unit is isoprene, that thirty carbons contain six such units, and that two carbon elongation belongs to fatty acid chains rather than to this precursor. Nothing in the narrative stem or the option text gives away which statements survive.

**Explanation (as shipped).**

> This Lipids question tests the bridge between terpenes and steroids: the recognition that the steroid ring system is built from isoprene derived carbon. The answer is C because statements I and II are supported while statement III is not. The branched five carbon unit described in the stem is isoprene, and a thirty carbon chain constructed entirely from such units must contain 30 divided by 5, or six, isoprene equivalents, so statement II holds. Because this open chain hexaisoprenoid, squalene, cyclizes into the signature steroid pattern of three six membered rings and one five membered ring fused together, the steroid nucleus inherits its carbon skeleton from isoprene chemistry, so statement I holds as well: steroids belong to the same structural family as the terpenes. Statement III fails because stepwise two carbon elongation is the assembly logic of fatty acid chains and yields long unbranched skeletons; a branched skeleton composed of five carbon repeating units is the fingerprint of isoprenoid condensation, so the described precursor cannot have been put together by the fatty acid route. (Choice A) Selecting I alone accepts the isoprenoid origin but rejects the arithmetic; six five carbon units account exactly for thirty carbons, so statement II cannot be excluded. (Choice B) Selecting II alone accepts the carbon count but denies the conclusion it points to; a precursor made of isoprene units that closes into the steroid ring system establishes precisely the isoprenoid ancestry that statement I asserts. (Choice D) Including statement III imports the wrong assembly process: two carbon elongation belongs to fatty acid construction and produces straight chains, so it cannot generate the branched five carbon repeating pattern the stem specifies. This is a Scientific Reasoning and Problem Solving question because it requires the student to identify an unnamed precursor from its described architecture, verify its isoprene count quantitatively, and discriminate isoprenoid assembly from fatty acid assembly.

---

## Q23 . Terpene unit counting convention

**Stem.** A chemist isolates a branched fifteen-carbon hydrocarbon from conifer resin and confirms that its skeleton is built entirely from isoprene units. Under the naming convention for this compound family, the molecule is classified as which of the following?

- **A.** A monoterpene
- **B.** A sesquiterpene  <- **KEY**
- **C.** A diterpene
- **D.** A triterpene

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic peripheral / structural two_step) |
| Estimated time | 85 s |
| Confidence | 5 |
| Hard-tier gate | (a) combines two concepts: five carbons per isoprene and the separate two isoprenes per terpene convention; (b) quantitative two stage inference from C15 to three isoprenes to 1.5 terpene units; additionally (c) triterpene remains fully defensible from the count of three units until the pairing convention is applied. |

**Correct answer (B): A sesquiterpene**

Citations: BC:43690-43691 (isoprene, a small branched alkadiene, polymerizes into isoprenoids often called terpenes); BC:43694-43695 and BC:43755 (the isoprenoid series at C10, C15, and C20 built from C5 units); BC:47651 (diterpene as a named class member); BC:43757-43758 and BC:43791 (squalene formed from two C15 units joined tail to tail, labeled C30)

**Distractors**

- **(A)** `scale_unit_error` . _rounded the unit count down_: Monoterpenes are C10; selecting it truncates 1.5 terpene units down to one full unit, an error of one whole isoprene unit in the size accounting.
  - Citation: BC:43694-43695
- **(C)** `adjacent_fact` . _right series, wrong member_: Diterpene is a genuine class in the same series but describes C20 molecules built from four isoprenes; the fact is real but belongs to the next member up, not to a C15 compound.
  - Citation: BC:47651
- **(D)** `misconception` . _terpene equals isoprene error_: Counts the three isoprene units directly as three terpene units, the standard error of equating one terpene with one isoprene; real triterpenes are C30 molecules such as squalene.
  - Citation: BC:43791

**Readback check.** Key content words of six or more letters: sesquiterpene only. The stem never contains it, nor any terpene class name; stem words of six or more letters (chemist, isolates, branched, fifteen, hydrocarbon, conifer, skeleton, isoprene, naming, convention, compound, family, molecule, classified) do not appear in the key. The answer cannot be read off the stem; it requires the two stage unit conversion.

**Explanation (as shipped).**

> This Lipids question tests the terpene naming convention, under which one terpene unit is defined as two isoprene units. The answer is B because a branched fifteen carbon isoprenoid contains 15 divided by 5, or three, isoprene units, and three isoprene units equal one and a half terpene units; the prefix sesqui means exactly one and a half, so C15 isoprenoids are sesquiterpenes. The counting must run in two stages: first convert the carbon count into isoprene units using five carbons per isoprene, then convert isoprene units into terpene units using two isoprenes per terpene. Skipping the second stage is the most common source of error with this convention. The same two stage logic generates the whole series, with monoterpenes at C10, sesquiterpenes at C15, diterpenes at C20, and triterpenes at C30, so any member of the family can be placed by carbon count alone once the convention is fixed. (Choice A) A monoterpene is the C10 member of the family, one full terpene unit built from two isoprenes; assigning a fifteen carbon molecule here truncates one and a half terpene units down to one, discarding an entire isoprene unit of carbon. (Choice C) A diterpene is a real neighboring class, the C20 member built from four isoprenes, but it belongs to molecules five carbons larger than the one described; placing a C15 compound there transfers a genuine fact about the series to the wrong member. (Choice D) Triterpene is the classic trap: it counts the three isoprene units directly as though each were a terpene unit, ignoring the pairing convention entirely; genuine triterpenes are C30 molecules such as squalene, twice the size of the compound described. This is a Scientific Reasoning and Problem Solving question because it requires converting a stated carbon count into isoprene units and then applying the two isoprenes per terpene convention to assign the molecule to its correct class.

---



---

# BATCH 2 of 2, FINAL (22 questions): membrane and signaling lipids

**This batch completes Biochem Ch5 at 45 questions.**

| Metric | Batch 2 | FULL CHAPTER (45) | Target |
|---|---|---|---|
| Difficulty | easy 6 . hard 7 . medium 9 | easy 12 . hard 15 . medium 18 | easy 12 . medium 18 . hard 15 |
| Answer letter | A 5 . B 5 . C 6 . D 6 | A 11 . B 11 . C 12 . D 11 | A 11 . B 11 . C 12 . D 11 |
| Cognitive skill | S1 3 . S2 11 . S3 3 . S4 5 | S1 7 . S2 23 . S3 6 . S4 9 | S1 7 . S2 23 . S3 6 . S4 9 |
| Roman numeral | 3 | 6 | 6 |
| Foundation | 2A 2 . 5D 20 | 2A 3 . 5D 42 | mostly 5D |
| Em/en dashes | 0 | 0 | 0 |

**Every distribution target across the finished chapter landed exactly.** All 45 pass every
structural gate; 45 distinct subtopics with no semantic key overlap; zero forbidden ideas in any key
across the 17-rule boundary list.

**Two duplicates caught and replaced before shipping, both writer substitutions.** The slice A
writer skipped its phosphatidic-acid naming brief and reproduced slice C's sphingomyelin
classification key from the opposite direction (same-batch dup); the slice B writer skipped its
cholesterol-orientation design brief and re-keyed batch 1's CMC threshold as a dye-solubilisation
experiment (CROSS-BATCH dup, the kind only the assembled-chapter check can see). Both were replaced
with the exact items the writers had skipped, pinned to the retired metadata: a membrane-impermeant
labeling design establishing that cholesterol's hydroxyl faces the water, and phosphatidic acid as
the parent behind the phosphatidyl-X naming series. Post-swap verification confirmed all
distributions unchanged.

**The contested trans-fat key** (Ch11 owns cis-to-fluidity; Ch5 was granted exactly one adjacent
key) shipped as planned: trans-unsaturated chains pack like saturated ones, with the cis kink as
premise only.

**Forward reservation honoured and recorded again:** this batch claims cholesterol orientation,
cholesterol-as-fluidity-buffer and bilayer-versus-micelle geometry; the future Biochem Ch8
Membranes pre-flight must treat these as TESTED_ELSEWHERE.

**Adversarial audit:** all 22 re-examined by an independent pass per slice against LibreTexts
Biochemistry and OpenStax Biology 2e.

---

## Q1 . Head versus tail solubility contributions

**Stem.** A chemist splits phosphatidylcholine into two pieces. Piece 1 keeps the glycerol, the phosphate, and the choline but lacks both hydrocarbon chains; piece 2 keeps the glycerol and both chains but lacks the phosphate and choline. When each piece is stirred into water, what behavior is expected?

- **A.** Piece 1 clumps away from the water, while piece 2 dissolves readily.
- **B.** Both pieces dissolve readily, because each retains part of an amphipathic molecule.
- **C.** Piece 1 dissolves readily, while piece 2 clumps away from the water.  <- **KEY**
- **D.** Neither piece dissolves, because a lipid stays insoluble no matter which portion is removed.

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic core / structural two_step) |
| Estimated time | 70 s |
| Confidence | 5 |

**Correct answer (C): Piece 1 dissolves readily, while piece 2 clumps away from the water.**

Citations: BIO:4121 (a phospholipid is amphipathic with a hydrophobic and a hydrophilic part); BIO:4128 (hydrophilic head groups face the aqueous solution, hydrophobic tails are sequestered away); BC:43208 (amphiphilic membrane lipids have two nonpolar tails connected to a polar head)

**Distractors**

- **(A)** `reversed_relationship` . _role reversal of head and tail_: Swaps the roles of the two regions, assigning water avoidance to the charged head fragment and water affinity to the acyl-chain fragment.
- **(B)** `partial_truth` . _property of whole misapplied to parts_: Piece 1 does dissolve, but amphipathicity belongs to the intact molecule; the tail-only fragment has no polar region and does not dissolve.
- **(D)** `misconception` . _lipid always insoluble_: Treats insolubility as a permanent property of anything lipid-derived; in fact the insolubility resides in the tails, and the head fragment is freely soluble.

**Readback check.** Key content words of six or more letters: dissolves, readily, clumps. None appears in the stem. The key states an inferred solubility outcome for each fragment, not a restatement of any stem sentence, and the stem never mentions dissolving or aggregation.

**Explanation (as shipped).**

> This Lipids question examines the division of labor within phospholipid architecture, in which the polar phosphate-bearing head supplies the molecule's affinity for water and the two hydrocarbon tails supply its tendency to hide from water. The answer is C because each region carries its characteristic property with it when the molecule is cut apart. Piece 1, containing glycerol, the phosphate, and the choline, is a small, highly polar and charged species with essentially no nonpolar surface, so water solvates it well and it dissolves freely. Piece 2 is a diacylglycerol whose structure is dominated by two long nonpolar chains; water cannot interact favorably with those chains, so the hydrophobic effect drives such molecules to aggregate away from the aqueous phase. The intact parent lipid is amphipathic precisely because it stitches these two opposite tendencies into one covalent structure, and separating the regions separates the behaviors. (Choice A) This reverses the assignment of properties: it treats the charged phosphocholine unit as the water-avoiding region and the acyl chains as the water-loving region, exactly backwards from the roles each region plays in the intact lipid. (Choice B) Amphipathicity is a property of the whole molecule, not of its halves; once the pieces are separated, neither one contains both a polar region and a nonpolar region, so only the polar piece dissolves while the tail-bearing piece self-associates. (Choice D) Bulk water insolubility is not an indelible label attached to anything derived from a lipid; nearly all of phosphatidylcholine's insoluble character resides in its tails, and removing them leaves a small polar fragment that dissolves as easily as other water-soluble metabolites. This is a Scientific Reasoning and Problem Solving question because it asks the student to predict the aqueous behavior of two novel fragments by reasoning about which region of the parent phospholipid contributes polarity and which contributes hydrophobic character.

---

## Q2 . Phosphodiester linkage to head group

**Stem.** An enzyme acting on phosphatidylethanolamine releases free ethanolamine, leaving a lipid in which two fatty acyl chains and one phosphate group remain bonded to glycerol. Which type of linkage did the enzyme hydrolyze?

- **A.** A glycosidic linkage
- **B.** A phosphodiester linkage  <- **KEY**
- **C.** A carboxylic acid ester linkage
- **D.** An amide linkage

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 60 s |
| Confidence | 5 |

**Correct answer (B): A phosphodiester linkage**

Citations: BC:43273 (head groups attached to a phosphate attached to carbon 3 of glycerol); BC:43275 (phosphatidic acid listed among the common glycerophospholipids); BIO:4118 (two fatty acids and a modified phosphate group attached to a glycerol backbone)

**Distractors**

- **(A)** `misconception` . _wrong-family linkage_: Assumes head groups attach the way sugars do; glycosidic bonds involve an anomeric carbon of a carbohydrate, which this lipid lacks.
- **(C)** `partial_truth` . _right bond, wrong location_: Such esters really are in the molecule, but they hold the fatty acyl chains; cleaving them would release fatty acids, not ethanolamine.
- **(D)** `adjacent_fact` . _sphingolipid linkage transplanted_: Amide linkage is how sphingolipids attach their fatty acid to sphingosine; glycerophospholipids contain no amide, and the head group is oxygen-linked.

**Readback check.** Key content words of six or more letters: phosphodiester, linkage. Linkage is the category word the stem's own question asks for and is shared by all four options; phosphodiester appears nowhere in the stem. The stem names only the hydrolysis products (ethanolamine, phosphate, glycerol, fatty acyl chains) and never names any linkage type, so the identity must be inferred from which product was released and which group was retained.

**Explanation (as shipped).**

> This Lipids question tests recognition of the phosphodiester linkage, the bond system that attaches a head group alcohol to the glycerophospholipid backbone. The answer is B because in phosphatidylethanolamine the central phosphate is esterified twice, once to the oxygen on carbon 3 of glycerol and once to the hydroxyl oxygen of ethanolamine, and two ester bonds on a single phosphorus define a phosphodiester. Cleaving the outer of these two phosphoester bonds detaches the ethanolamine head group while leaving the phosphate still attached to glycerol; the remaining lipid, glycerol bearing two fatty acyl chains and a phosphate, is phosphatidic acid. The observed products, a free amino alcohol plus a lipid that keeps its phosphate, therefore point directly at the phosphorus-centered linkage rather than at any bond involving the fatty acyl chains. (Choice A) A glycosidic linkage joins a sugar through its anomeric carbon to another group; carbohydrates do serve as head groups in glycolipids, but no sugar is present in phosphatidylethanolamine, and glycosidic cleavage could not release an amino alcohol from a phosphate. (Choice C) Carboxylic acid ester bonds are genuinely present in this lipid, but they connect the two fatty acyl chains to carbons 1 and 2 of glycerol; hydrolyzing them would release free fatty acids and leave the head group attached, the opposite of the observed result. (Choice D) An amide linkage joins a fatty acid to the backbone nitrogen in sphingolipids, a different lipid family; glycerophospholipids contain no amide bond, and ethanolamine in this lipid is bound through its oxygen, not its nitrogen. This is a Knowledge of Scientific Concepts and Principles question because it asks the student to identify the specific covalent linkage joining a head group to a glycerophospholipid backbone from the products its hydrolysis generates.

---

## Q3 . Head group charge and electrophoretic migration

**Stem.** Three synthetic glycerophospholipids carry identical fatty acyl chains on a diacylglycerol phosphate core and differ only in the group joined through the second bond on the core's phosphorus. In lipid 1 that group is choline, whose quaternary nitrogen holds a permanent positive charge. In lipid 2 it is serine, which at pH 7.4 presents one protonated amino group and one deprotonated carboxylate. Lipid 3 has no added group, leaving the core's ionized phosphate fully exposed. The three lipids are spotted on a strip and an electric field is imposed at pH 7.4; a species travels toward the anode, the positively charged pole, only if it bears net negative charge. Which result is predicted?

- **A.** All three lipids migrate toward the anode.
- **B.** Only lipid 3 migrates toward the anode; lipids 1 and 2 remain stationary.
- **C.** Lipid 1 migrates toward the cathode, while lipids 2 and 3 migrate toward the anode.
- **D.** Lipids 2 and 3 migrate toward the anode, while lipid 1 remains stationary.  <- **KEY**

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic secondary / structural multi_step) |
| Estimated time | 100 s |
| Confidence | 4 |
| Hard-tier gate | (a) combines two concepts: phosphate ionization chemistry and amino acid functional group ionization; (b) quantitative charge summation per lipid plus a directional migration inference; (c) choices B and C stay defensible until the full charge inventory, including the bridging phosphate, is tallied for each lipid. |

**Correct answer (D): Lipids 2 and 3 migrate toward the anode, while lipid 1 remains stationary.**

Citations: BC:43309 (all head groups include a negatively charged phosphate; PS has two additional charged atoms that effectively cancel); BC:43311 (PC quaternary amine is positive at all pH, giving a positive and negative charge but zero net charge); BC:43275 (phosphatidic acid among the common glycerophospholipids)

**Distractors**

- **(A)** `misconception` . _single group substituted for net charge_: Assumes any phosphate-containing lipid must be net negative; ignores that choline's fixed positive charge cancels the phosphate in lipid 1.
- **(B)** `process_step_confusion` . _wrong pairing in charge summation_: Performs the cancellation step on the wrong pair, canceling serine's charges against the phosphate instead of against each other, so lipid 2's net minus one is missed.
- **(C)** `partial_truth` . _incomplete charge inventory_: Choline's positive nitrogen is real, but omitting the phosphate's negative charge from lipid 1's total wrongly predicts cathode migration instead of zero net movement.

**Readback check.** Key content words of six or more letters: migrate, remains, stationary; none appears in the stem, which uses travels and imposed instead. Lipid 1/2/3 are unavoidable data labels. The predicted migration pattern is stated nowhere in the supplied data and can only be obtained by completing a three-way charge summation, so the key is an inference, not a value read off the data.

**Explanation (as shipped).**

> This Lipids question requires data-based reasoning about how head group identity sets a glycerophospholipid's net charge and therefore its movement in an electric field. The answer is D because summing every ionized group in each lipid at pH 7.4 gives a net charge of zero for lipid 1 and a net negative charge for lipids 2 and 3. In all three lipids the bridging phosphate contributes one negative charge. Lipid 1 adds choline's permanently positive nitrogen, so plus one and minus one cancel; the molecule is a net neutral zwitterion and does not travel in the field. Lipid 2 adds serine, whose protonated amine and deprotonated carboxylate cancel each other, leaving the phosphate's negative charge unopposed; the lipid carries net minus one and moves toward the anode. Lipid 3 is phosphatidic acid, whose bare phosphate has no attached group to offset it and is ionized at pH 7.4, so it likewise moves toward the anode. (Choice A) Every lipid does contain an ionized phosphate, but migration follows net charge rather than the presence of any single group; in lipid 1 the choline cation exactly offsets the phosphate anion, so lipid 1 does not travel. (Choice B) This choice cancels serine's zwitterionic pair against the phosphate; in fact the amine and carboxylate cancel one another, the phosphate's charge survives the sum, and lipid 2 travels toward the anode. (Choice C) Choline's positive charge is real, but counting it while omitting the phosphate's negative charge wrongly assigns lipid 1 a net positive charge; the correct total is zero, so lipid 1 stays in place rather than moving toward the cathode. This is a Data-based and Statistical Reasoning question because it requires combining the described ionization state of each head group into a per-molecule charge total and translating each total into a predicted direction of movement in the applied field.

---

## Q4 . Sphingomyelin as a glycerol-free phospholipid

**Stem.** A lipid purified from neural tissue contains a long-chain amino alcohol serving as its structural core, a single fatty acid joined to that core's nitrogen through an amide bond, and a phosphate bridging the core's terminal hydroxyl group to choline. The molecule contains no glycerol. How should this lipid be classified?

- **A.** As a phospholipid, because the class is defined by the phosphate-containing head group, and here sphingosine substitutes for glycerol as the scaffold.  <- **KEY**
- **B.** As a glycolipid, because its head group is attached through the terminal hydroxyl group of the structural core.
- **C.** As a wax, because it combines a long-chain alcohol with a fatty acid.
- **D.** As a sphingolipid only, because a lipid that lacks glycerol cannot belong to the phospholipid class.

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic secondary / structural two_step) |
| Estimated time | 75 s |
| Confidence | 5 |

**Correct answer (A): As a phospholipid, because the class is defined by the phosphate-containing head group, and here sphingosine substitutes for glycerol as the scaffold.**

Citations: BIO:4100 (phospholipids comprise fatty acid chains attached to a glycerol or sphingosine backbone); BC:43399 (sphingolipids contain a sphingosine backbone and a fatty acid linked through an amide bond); BC:43443 (the base sphingosine provides an amine to attach a fatty acid and an OH for attachment to the head group)

**Distractors**

- **(B)** `partial_truth` . _attachment site mistaken for class criterion_: The head group really is attached through the terminal hydroxyl, but glycolipids are defined by a carbohydrate head group, and this molecule carries phosphocholine, not a sugar.
- **(C)** `adjacent_fact` . _wax definition transplanted_: Waxes are real lipids pairing long-chain alcohols with fatty acids, but through an ester rather than an amide, and no wax carries a phosphate head group.
- **(D)** `misconception` . _glycerol required for phospholipid_: Treats glycerol as mandatory for phospholipids; the class is defined by the phosphate head group, so the sphingolipid and phospholipid labels apply simultaneously.

**Readback check.** Key content words of six or more letters not present in the stem: phospholipid, defined, containing, sphingosine, substitutes, scaffold. Phosphate, glycerol, and choline are unavoidable structural data labels from the stem; the key's actual inference, the class-defining criterion and the identification of the core as sphingosine, appears nowhere in the stem, which never names sphingosine, sphingolipid, or phospholipid.

**Explanation (as shipped).**

> This Lipids question examines what defines membership in the phospholipid class when the scaffold is not glycerol. The answer is A because the described molecule is sphingomyelin: its long-chain amino alcohol is sphingosine, which offers a nitrogen for amide attachment of one fatty acid and a terminal hydroxyl for attachment of the phosphocholine head group. Membership in the phospholipid class follows from possessing a phosphate-containing head group, not from the identity of the scaffold beneath it, so a sphingosine-based lipid bearing phosphocholine is simultaneously a sphingolipid, by its scaffold, and a phospholipid, by its head group. Glycerophospholipids and sphingomyelin therefore share one class despite being built on different cores, and both present the same overall plan of two hydrophobic chains beneath a polar phosphate-bearing head. (Choice B) A glycolipid is defined by a carbohydrate head group; attachment through a terminal hydroxyl does not create one, and this molecule carries phosphocholine rather than any sugar. (Choice C) Waxes are esters formed between a long-chain alcohol and a fatty acid; here the fatty acid is joined through an amide bond to nitrogen, and the polar phosphocholine unit has no counterpart in any wax. (Choice D) The sphingolipid assignment is correct as far as it goes, but the two categories are not exclusive; because the classification rests on the phosphate head group rather than on glycerol, sphingomyelin belongs to both families at once. This is a Scientific Reasoning and Problem Solving question because it asks the student to assign a described glycerol-free structure to the correct lipid class by applying the defining criterion for a phospholipid rather than matching a memorized glycerol template.

---

## Q5 . Tail number dictating micelle versus bilayer

**Stem.** A lab synthesizes two amphiphiles that share an identical charged head group. Amphiphile 1 carries a single 16-carbon tail, while amphiphile 2 carries two such tails. When amphiphile 2 is dispersed in water at high concentration, which aggregate should predominate?

- **A.** A spherical micelle, because the second tail sharpens the wedge shape that lets the assembly curve tightly around its core
- **B.** Free monomers in solution, because the second tail doubles the hydrophobic area and blocks any stable self-assembly
- **C.** A double-layered sheet, because head groups of adjacent amphiphiles fuse into a continuous covalent lattice
- **D.** A double-layered sheet, because the paired tails give the molecule a roughly cylindrical outline that packs side by side without needing a curved surface  <- **KEY**

| | |
|---|---|
| Foundation | 2A |
| Content category | Lipids |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 65 s |
| Confidence | 5 |

**Correct answer (D): A double-layered sheet, because the paired tails give the molecule a roughly cylindrical outline that packs side by side without needing a curved surface**

Citations: BC:42774; BC:43043; BC:43209; BC:43482

**Distractors**

- **(A)** `reversed_relationship` . _shape logic inverted_: Reverses the shape inference: a second tail widens the hydrophobic end and blunts the taper; a sharpened wedge is the single-tail geometry, and that is what favors micelles.
  - Citation: BC:43043
- **(B)** `misconception` . _hydrophobicity blocks assembly_: Greater hydrophobic surface drives aggregation rather than preventing it; clustering releases ordered water and is entropically favorable, so monomers do not stay dispersed.
  - Citation: BC:15136
- **(C)** `partial_truth` . _right structure wrong force_: Names the correct aggregate but the wrong driving force; the sheet is held together noncovalently by the hydrophobic effect, and no covalent lattice forms between head groups.
  - Citation: BC:43482

**Readback check.** Key content words of six or more letters: double-layered, paired, molecule, roughly, cylindrical, outline, needing, curved, surface. None appears in the stem, which uses amphiphile, carries, dispersed, concentration, aggregate. The key requires a shape-to-structure inference the stem never states.

**Explanation (as shipped).**

> This Lipids question tests how the molecular geometry of an amphiphile determines which aggregate it assembles into when dispersed in water. The answer is D because adding a second hydrocarbon tail changes the molecule's overall shape from a cone into an approximate cylinder, and cylinders pack side by side into flat, double-layered sheets rather than curling into spheres. A single-tailed amphiphile is wide at its charged head and narrow at its lone tail, giving it a tapered, cone-like profile. Cones fit together the way orange slices do, curving around a central point, so single-tailed amphiphiles bury their tails in the core of a small sphere, the micelle. Once a second tail of similar length is attached, the hydrophobic end becomes roughly as wide as the head, the taper disappears, and the molecule approximates a cylinder. Cylinders cannot wrap into a tightly curved sphere; the geometry that hides their hydrophobic surface most completely is two flat layers laid tail to tail, with head groups facing water on both faces. The same logic explains why two-tailed phospholipids build the bilayers of cell membranes while single-tailed soaps and detergents form micelles. (Choice A) reverses the geometric inference: a second tail widens the hydrophobic end and blunts the taper, whereas a sharpened wedge is the shape of a single-tailed amphiphile and is precisely what favors the tightly curved micelle. (Choice B) misstates the driving force. Enlarging the hydrophobic surface strengthens the tendency to aggregate, because clustering releases ordered water molecules and is entropically favorable; it does not keep monomers dispersed. (Choice C) names the right aggregate for the wrong reason. Self-assembly is entirely noncovalent; the sheet is held together by the hydrophobic effect acting on the buried tails, and no covalent bonds ever form between neighboring head groups. This is a Scientific Reasoning and Problem Solving question because it requires predicting the assembly behavior of an unfamiliar synthetic amphiphile from its molecular shape rather than recalling a memorized pairing of molecule and structure.

---

## Q6 . Trans double bond chain packing

**Stem.** Industrial partial hydrogenation of a vegetable oil converts many of its cis double bonds to the trans configuration. A cis double bond forces a rigid bend of about 30 degrees into an acyl tail. Which structural change explains why the processed fat is solid at room temperature while the starting oil is liquid?

- **A.** Hydrogenation eliminates every double bond, leaving the product with only fully saturated tails
- **B.** The trans arrangement bends each tail more sharply than cis does, and the interlocking bends bind neighboring tails together
- **C.** The trans geometry keeps each tail fully extended, so neighboring tails can stack as closely as saturated tails do  <- **KEY**
- **D.** The trans arrangement adds mass to each tail, and heavier tails require more thermal energy to melt

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 75 s |
| Confidence | 5 |

**Correct answer (C): The trans geometry keeps each tail fully extended, so neighboring tails can stack as closely as saturated tails do**

Citations: BC:42978; BC:42987; BC:43927

**Distractors**

- **(A)** `process_step_confusion` . _partial mistaken for complete_: Confuses partial with complete hydrogenation; the industrial process stops short of full saturation, and many double bonds persist in the product, isomerized to trans.
  - Citation: BC:42979
- **(B)** `reversed_relationship` . _cis and trans swapped_: Inverts the geometry: trans straightens the tail while cis is the arrangement that bends it, and no interlocking of bends binds tails in either configuration.
  - Citation: BC:42978
- **(D)** `misconception` . _melting tracks mass_: Cis to trans isomerization rearranges the same atoms without changing molecular weight; melting behavior in these fats tracks packing efficiency, not mass.
  - Citation: BC:43927

**Readback check.** Key content words of six or more letters: geometry, extended, neighboring, closely, saturated. None appears in the stem. The stem supplies only the cis-kink premise as allowed; the key is the inferred trans packing consequence, which the stem never states.

**Explanation (as shipped).**

> This Lipids question tests how the geometry of a carbon-carbon double bond controls how tightly acyl tails pack against their neighbors. The answer is C because a trans double bond places the two flanking segments of the tail on opposite sides of the rigid bond, so the tail continues along an essentially straight zigzag path, just as a fully saturated tail does. Straight tails can lie flush against adjacent tails along their entire length, maximizing intermolecular contact, so the processed fat packs densely, melts at a higher temperature, and behaves as a solid under room conditions. In the starting oil, every cis double bond bends its tail; bent tails cannot nest against one another, packing stays loose, and the material remains liquid. Partial hydrogenation therefore solidifies an oil in two complementary ways: it saturates a fraction of the double bonds outright, and it isomerizes many of the survivors from cis to trans; those trans tails pack nearly as well as saturated ones. Because tight packing is what raises melting temperature, the bulk consequence follows directly from the shape of the tails. (Choice A) confuses partial with complete hydrogenation. The industrial process deliberately stops short of full saturation, so many double bonds remain in the product; the solidification depends in large part on the ones that have flipped to trans. (Choice B) inverts the geometry. The trans arrangement removes the bend rather than deepening it; it is the cis arrangement that kinks the tail, and no interlocking of bends holds tails together in either configuration. (Choice D) attributes melting behavior to mass. Flipping a double bond from cis to trans rearranges the same atoms in space without changing molecular weight, and the melting differences among these fats track packing efficiency, not size. This is a Scientific Reasoning and Problem Solving question because it requires connecting the three-dimensional geometry of one double bond to the packing behavior of whole molecules and from there to a bulk physical property of the fat.

---

## Q7 . Cholesterol bidirectional fluidity buffering

**Stem.** Cholesterol inserts between membrane phospholipids with its lone hydroxyl group oriented toward the aqueous surface. Compared with an otherwise identical bilayer lacking it, a cholesterol-rich bilayer is expected to display which of the following?

I. Greater acyl-tail motion when both bilayers are held below the phospholipid transition temperature
II. Restricted acyl-tail motion when both bilayers are held above the phospholipid transition temperature
III. A transition temperature shifted far below that of the cholesterol-free bilayer

- **A.** I only
- **B.** I and II only  <- **KEY**
- **C.** II and III only
- **D.** I, II, and III

| | |
|---|---|
| Foundation | 2A |
| Content category | Lipids |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 95 s |
| Confidence | 4 |
| Hard-tier gate | (a) combines two concepts: gel-phase packing disruption and fluid-phase motional restraint; (b) directional inference required in two opposite temperature regimes; (d) inverts the commonly memorized one-way rule that cholesterol simply stiffens membranes. |

**Correct answer (B): I and II only**

Citations: BC:44923; BC:44925; BC:45045; BIO:6760

**Distractors**

- **(A)** `partial_truth` . _half of a two-way effect_: Statement I is genuinely true, but stopping there ignores the equally real restraining action above the transition temperature, so the bidirectional buffer is reduced to a one-way effect.
  - Citation: BC:44925
- **(C)** `misconception` . _cholesterol as pure stiffener_: Reflects the common belief that cholesterol only rigidifies membranes; it denies the disordering action in the gel state and accepts a transition shift that cholesterol does not produce.
  - Citation: BC:44925
- **(D)** `adjacent_fact` . _neighboring mechanism misassigned_: Imports the melting-temperature depression that genuinely results from cis-unsaturated tails and misattributes it to cholesterol, whose actual effect is to broaden and damp the transition.
  - Citation: BC:45045

**Readback check.** The key is the letter set I and II only and contains no content words of six or more letters. Each correct numeral requires a directional inference about packing on one side of the transition temperature; neither restates the stem's premise, which describes only cholesterol's orientation in the bilayer.

**Explanation (as shipped).**

> This Lipids question tests cholesterol's two-way modulation of membrane physical behavior on either side of the phospholipid transition temperature. The answer is B because statements I and II are both correct while statement III is not. Below the transition temperature, phospholipid tails settle into a tightly ordered, gel-like arrangement. Cholesterol's bulky fused-ring system wedges between the tails and physically prevents that orderly packing, so the tails retain more freedom of motion than they would in a pure bilayer; statement I is true. Above the transition temperature, the tails are already highly mobile, and the same rigid rings now act as a brace that restricts their rotation and reduces disorder; statement II is true. Acting in opposite directions on either side of the transition, cholesterol holds membrane behavior within a middle range across a broad span of temperatures. Statement III is false because cholesterol does not simply slide the transition downward and abolish the gel state that way; instead it blunts and broadens the cooperative transition itself, so the membrane changes character gradually rather than melting sharply. A substantially lowered transition temperature is the signature of introducing bent unsaturated tails, not of adding a sterol. (Choice A) captures only the fluidizing action in the cold, ordered state and misses the restraining action in the warm, disordered state, so it tells half the story. (Choice C) treats cholesterol as a pure stiffening agent plus a transition shift, denying its well-documented ability to disrupt gel-state packing from within. (Choice D) accepts statement III along with the two correct statements, wrongly assigning to cholesterol the melting-point depression that belongs to unsaturated acyl tails. This is a Scientific Reasoning and Problem Solving question because it requires applying one molecule's packing behavior across two different temperature regimes and predicting effects that run in opposite directions.

---

## Q8 . Cholesterol orientation in the bilayer

**Stem.** Cholesterol consists of a rigid, fused four-ring frame attached to a single polar group. A researcher preparing synthetic phospholipid bilayers wants to determine how inserted cholesterol is oriented: does its polar group face the surrounding water, or is it buried among the hydrophobic tails? Which of the following observations would best establish that the polar group faces the water?

- **A.** A membrane-impermeant reagent that reacts only with accessible hydroxyls covalently labels the sterol when added to intact, sealed liposomes  <- **KEY**
- **B.** Cholesterol dissolves uniformly into the hydrophobic core, with no portion of the molecule detectable at either aqueous surface of the bilayer
- **C.** Labeling experiments place the fused rings among the polar head groups at the surface, with the hydroxyl directed toward the bilayer center
- **D.** Inside cells, cholesterol can be stored after esterification of its hydroxyl to a fatty acid, forming cholesteryl esters found in lipid droplets

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 3 |
| Difficulty | **medium** (topic peripheral / structural two_step) |
| Estimated time | 80 s |
| Confidence | 5 |

**Correct answer (A): A membrane-impermeant reagent that reacts only with accessible hydroxyls covalently labels the sterol when added to intact, sealed liposomes**

Citations: BC:44924 (cholesterol fits into a leaflet with its polar OH pointed to the outside), BC:43891 (cholesterol is amphiphilic), BC:44928 (rigid ring of cholesterol among acyl chains), BC:934 (rigid planar ring system), BC:45372 (cholesteryl ester: fatty acid esterified to the cholesterol OH, in droplet interiors)

**Distractors**

- **(B)** `misconception` . _fully buried hydrophobe_: Treats cholesterol as wholly hydrophobic with nothing exposed; its hydroxyl actually remains at the aqueous surface among the head groups, and a finding of complete burial would refute, not establish, the tested orientation.
  - Citation: BC:43891, BC:44924
- **(C)** `reversed_relationship` . _inverted orientation_: Inverts the true arrangement: the nonpolar fused ring system buries in the hydrocarbon core and the hydroxyl faces the water, not the other way around, so this observation would support the opposite conclusion.
  - Citation: BC:44924, BC:44928
- **(D)** `adjacent_fact` . _true but irrelevant ester fact_: True statement about cholesteryl ester storage in lipid droplets, but esterification chemistry provides no information about where free cholesterol sits within a bilayer.
  - Citation: BC:45372

**Readback check.** Stem content words of six or more letters (cholesterol, consists, attached, single, researcher, preparing, synthetic, phospholipid, bilayers, determine, inserted, oriented, surrounding, buried, hydrophobic, observations, following, establish) share nothing with key A content words (membrane, impermeant, reagent, reacts, accessible, hydroxyls, covalently, labels, sterol, intact, sealed, liposomes); overlap verified empty by script. Cholesterol and sterol are distinct words, and the stem never uses hydroxyl, reagent, membrane, or liposome. The key is not restated in the stem; answering requires mapping impermeant-reagent logic onto exposure at the aqueous face.

**Explanation (as shipped).**

> Lipids: cholesterol's orientation in a bilayer follows from its weakly amphipathic structure, and the right experiment can localize its one polar group. The answer is A because a reagent that cannot cross the membrane can only reach groups exposed on the outer, water-facing surface of a sealed liposome; if that reagent covalently modifies the sterol at its hydroxyl, the hydroxyl must sit at the aqueous interface among the phospholipid head groups rather than deep in the hydrocarbon core. Cholesterol is built almost entirely from a rigid, planar set of fused hydrocarbon rings plus a short branched tail, with a single hydroxyl as its only polar feature. That architecture makes it weakly amphipathic: the ring system slips in among the fatty acyl chains of one leaflet, while the hydroxyl points outward to hydrogen bond with water and the head group region. The impermeant-reagent design turns this structural claim into a testable prediction, since the vesicles stay sealed and a positive labeling result can only mean the target group is accessible from the aqueous phase. (Choice B) reflects the misconception that cholesterol behaves as a wholly hydrophobic molecule, like a triacylglycerol dissolved in the middle of an oil droplet. Its rings are indeed buried, but its hydroxyl is not, and an observation of complete burial would contradict rather than establish the orientation being tested. (Choice C) describes the reverse arrangement. Packing the bulky nonpolar rings among the charged, hydrated head groups while pointing the lone polar group into the anhydrous core is energetically backwards, and such a finding would argue against the proposed orientation instead of supporting it. (Choice D) is a true statement about cholesterol handling in cells: esterifying the hydroxyl to a fatty acid yields cholesteryl esters, the neutral storage form packed inside lipid droplets and lipoprotein cores. Because esterification describes what can happen to the hydroxyl chemically, not where the free molecule sits in a membrane, it provides no evidence about orientation. This is a Reasoning about the Design and Execution of Research question because it asks which observation would justify a specific structural conclusion, which requires linking the logic of an impermeant labeling strategy, where only surface-exposed groups can react, to the position of a molecule within the bilayer.

---

## Q9 . Phosphatidic acid as parent structure in glycerophospholipid naming

**Stem.** During membrane lipid synthesis, a cell produces phosphatidylserine by joining the hydroxyl group of serine to the single open position on a simpler parent lipid. Which of the following identifies that parent?

- **A.** A phosphorylated intermediate that does not itself qualify as a glycerophospholipid until an alcohol head group is attached to its phosphate
- **B.** Diacylglycerol, a glycerol backbone carrying two fatty acyl chains with its third hydroxyl left free
- **C.** Phosphatidic acid, a glycerol backbone carrying two fatty acyl chains and a phosphate at the third carbon  <- **KEY**
- **D.** Serine itself, acting as the central scaffold and receiving a diacylglycerol phosphate unit as its polar head group

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 80 s |
| Confidence | 5 |

**Correct answer (C): Phosphatidic acid, a glycerol backbone carrying two fatty acyl chains and a phosphate at the third carbon**

Citations: BC:43264-43276 (glycerophospholipid architecture: fatty acids and PO4-alcohol on glycerol; PA listed among common glycerophospholipids); BC:43551 (glycerol-3-phosphate is the biosynthetic intermediate for phosphatidic acid, a glycerophospholipid); BC:48083 (phosphatidic acid with a negatively charged phosphate head group)

**Distractors**

- **(A)** `misconception` . _phosphate-not-a-head-group_: Assumes the bare phosphate cannot serve as a head group, so the parent would not be a real glycerophospholipid until an alcohol is added. Phosphatidic acid is itself the simplest complete glycerophospholipid; its ionized phosphate is its polar head.
  - Citation: BC:48083
- **(B)** `partial_truth` . _core-minus-phosphate_: Correct about the two fatty acyl chains on glycerol but omits the phosphate at carbon 3, which is part of the parent core and is the very site where serine's hydroxyl attaches; diacylglycerol is a neutral glycerolipid, not a phospholipid.
  - Citation: BC:43272-43274
- **(D)** `reversed_relationship` . _alcohol-as-scaffold_: Inverts the construction: the head-group alcohol is the small unit esterified onto the parent's phosphate, while the diacylglycerol phosphate framework is the scaffold. Serine does not carry a glycerolipid as its head group.
  - Citation: BC:43264-43270

**Readback check.** No content word of six or more letters is shared between stem and key. Stem: membrane, synthesis, produces, phosphatidylserine, joining, hydroxyl, serine, single, position, simpler, parent, following, identifies. Key: phosphatidic, glycerol, backbone, carrying, chains, phosphate, carbon. No overlaps; phosphatidylserine and phosphatidic are distinct words, and the key cannot be extracted by rereading the stem.

**Explanation (as shipped).**

> Lipids: glycerophospholipids follow a parent-plus-head-group construction pattern, and their names encode which alcohol has been added to the parent. The answer is C because glycerol esterified to two fatty acyl chains, with a phosphate on its third carbon, is phosphatidic acid, the simplest glycerophospholipid and the parent structure of the entire family. Esterifying the hydroxyl of a small alcohol onto that phosphate generates the named membrane lipids as a phosphatidyl-X series: serine gives phosphatidylserine, ethanolamine gives phosphatidylethanolamine, and choline gives phosphatidylcholine. The name itself records this logic: the phosphatidyl portion denotes the diacylglycerol phosphate core contributed by the parent, and the suffix names the alcohol esterified onto it. Because serine is attached through its hydroxyl at the one open position on the phosphate, conceptually removing serine returns the intact parent, phosphatidic acid, with two acyl tails and a bare phosphate remaining.
>
> (Choice A) This choice treats the bare phosphate as a mere attachment point rather than a true head group, implying the parent only becomes a glycerophospholipid once an alcohol caps it. In fact phosphatidic acid already possesses every defining feature of the class: a glycerol backbone, two fatty acyl chains, and a phosphate at carbon 3. Its ionized phosphate itself serves as the polar head, which is why phosphatidic acid functions as a genuine, negatively charged membrane lipid in its own right.
>
> (Choice B) Diacylglycerol correctly captures the two acyl chains on the glycerol backbone but omits the phosphate from the core. Without a phosphate at the third carbon there is nothing for serine's hydroxyl to attach to, and the molecule would be a neutral glycerolipid rather than a phospholipid.
>
> (Choice D) This choice reverses the construction pattern. Serine is the small alcohol added last onto the phosphate, not the scaffold; the glycerol phosphate framework carries the fatty acyl chains and receives serine, not the other way around.
>
> This is a Scientific Reasoning and Problem Solving question because it requires applying the general assembly and naming pattern of glycerophospholipids to deconstruct a specific membrane lipid and reason out which structural parent remains when its head-group alcohol is removed.

---

## Q10 . Sphingomyelin structure in myelin insulation

**Stem.** The myelin wrap that electrically insulates a vertebrate axon is exceptionally rich in one phospholipid that contains no glycerol. This lipid is built from:

- **A.** sphingosine carrying one amide-linked fatty acid, with a single galactose as its head group
- **B.** sphingosine carrying one amide-linked fatty acid, with a phosphocholine head group on its terminal hydroxyl  <- **KEY**
- **C.** sphingosine carrying one ester-linked fatty acid, with a phosphocholine head group on its terminal hydroxyl
- **D.** sphingosine carrying two amide-linked fatty acids, with a phosphocholine head group on its terminal hydroxyl

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 60 s |
| Confidence | 5 |

**Correct answer (B): sphingosine carrying one amide-linked fatty acid, with a phosphocholine head group on its terminal hydroxyl**

Citations: BC:43450-43451; BC:43398-43411; BC:43443-43444; BC:43462-43471

**Distractors**

- **(A)** `adjacent_fact` . _real myelin lipid, wrong class_: This is galactocerebroside, genuinely enriched in myelin, but it contains no phosphate and so fails the stem's phospholipid specification.
  - Citation: BC:43450-43451
- **(C)** `misconception` . _glycerolipid linkage transplanted_: Ester linkage belongs to glycerol-based lipids; sphingosine's amine attaches its fatty acid through an amide bond.
  - Citation: BC:43399-43411
- **(D)** `partial_truth` . _two tails misread as two fatty acids_: Sphingomyelin is double-tailed, but the second tail is sphingosine's own hydrocarbon chain; only one fatty acid is amide-linked.
  - Citation: BC:43243

**Readback check.** Key content words of six or more letters (sphingosine, carrying, amide-linked, phosphocholine, terminal, hydroxyl) appear nowhere in the stem, which names only the myelin context and the glycerol-free phospholipid clue; naming the lipid and its linkage chemistry is the inferential step. Conduction speed is never keyed; the stem states insulation as a premise only.

**Explanation (as shipped).**

> This Lipids question asks for the structure of the glycerol-free phospholipid concentrated in the myelin sheath. The answer is B because the lipid described is sphingomyelin, the one major phospholipid of human membranes that is not built on glycerol. Its backbone is sphingosine, a long-chain amino alcohol that contributes its own hydrocarbon tail to the molecule. The backbone amine holds a single fatty acid through an amide bond, and the terminal hydroxyl carries a phosphocholine head group through a phosphodiester bond. Because sphingosine supplies one tail and the amide-linked fatty acid supplies the other, the molecule presents two hydrophobic chains to the membrane interior while containing only one true fatty acid, and the phosphocholine head makes it a full member of the phospholipid class. The insulating membranes of the sheath are exceptionally enriched in sphingolipids of this kind. (Choice A) A single galactose attached to the backbone describes a cerebroside, another lipid genuinely abundant in myelin membranes. However, a sugar head attached with no phosphate anywhere in the molecule disqualifies it from the phospholipid class specified in the stem, so it cannot be the lipid in question. (Choice C) An ester linkage is the attachment chemistry of glycerolipids, in which fatty acids join the hydroxyls of glycerol. Sphingosine instead offers an amine at the acylation position, so its fatty acid is joined through an amide bond, not an ester. (Choice D) Only one fatty acid is amide-linked in sphingomyelin, because the backbone possesses a single amine to hold it. The second hydrophobic tail is sphingosine's own built-in hydrocarbon chain, so a molecule bearing two amide-linked fatty acids does not correspond to any major membrane sphingolipid. This is a Knowledge of Scientific Concepts and Principles question because it requires recalling the structural composition of sphingomyelin, the sphingosine-based phospholipid enriched in the insulating membranes of myelin.

---

## Q11 . Phosphate-free glycosidic heads of glycosphingolipids

**Stem.** Starting from the same ceramide, a neuron can produce either sphingomyelin or a single-sugar glycolipid of the cerebroside type. Which of the features listed distinguish the finished glycolipid from the finished sphingomyelin?

I. Its head group is attached through a glycosidic bond rather than through a phosphodiester bond
II. The completed molecule contains no phosphorus
III. Its sugar occupies the nitrogen position that holds the fatty acid in sphingomyelin

- **A.** I and II only  <- **KEY**
- **B.** I and III only
- **C.** II and III only
- **D.** I, II, and III

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 90 s |
| Confidence | 5 |

**Correct answer (A): I and II only**

Citations: BC:43417-43444; BC:43462-43471; BC:43398-43411

**Distractors**

- **(B)** `process_step_confusion` . _attachment site confused_: Accepts the false claim that the sugar displaces the amide-linked fatty acid at the nitrogen and drops the true phosphorus-free distinction.
  - Citation: BC:43443-43444
- **(C)** `partial_truth` . _right on phosphorus, wrong on linkage_: Correctly keeps the phosphorus distinction but rejects the true glycosidic-versus-phosphodiester contrast and accepts the false site claim.
  - Citation: BC:43417-43420
- **(D)** `misconception` . _every position assumed to differ_: Assumes the two products differ at all positions, but both retain the same amide-linked fatty acid on the amine, so III is false.
  - Citation: BC:43443-43444

**Readback check.** The key is the combination 'I and II only' and contains no content words of six or more letters, so no stem echo is possible; the stem supplies neither linkage chemistry nor phosphorus content, so evaluating each statement requires recalled structure, not readback.

**Explanation (as shipped).**

> This Lipids question probes what separates a glycosphingolipid from sphingomyelin when both arise from the same ceramide. The answer is A because statements I and II are true and statement III is false. Both products keep the entire ceramide core: a sphingosine backbone whose amine already holds one fatty acid in amide linkage. The two classes then diverge only at the terminal hydroxyl. Sphingomyelin caps that hydroxyl with phosphocholine through a phosphodiester bond, while a cerebroside-type glycolipid attaches a single sugar directly through a glycosidic bond with no phosphate intervening. Statement I is therefore correct, since the linkage chemistries of the two head groups differ in exactly this way. Statement II is also correct: because the sugar bonds directly to the hydroxyl, the finished glycolipid contains no phosphorus anywhere, which is the defining division between the glycosphingolipids and the phosphosphingolipids. Statement III fails because the nitrogen position is already occupied by the amide-linked fatty acid in both molecules; the sugar takes the same hydroxyl position that phosphocholine occupies in sphingomyelin, so the two products differ at the head position, not at the nitrogen. (Choice B) This combination keeps the correct linkage statement but discards the phosphorus-free point, the single most definitional difference between the classes, while accepting the false claim that glycosylation displaces the fatty acid from the amine. (Choice C) This combination correctly retains the phosphorus distinction but rejects the true statement about glycosidic versus phosphodiester linkage while accepting the false attachment-site claim. (Choice D) Accepting all three statements treats every position on the backbone as a point of difference, but the amide-linked fatty acid is shared by both products rather than distinguishing them, so statement III cannot be included. This is a Scientific Reasoning and Problem Solving question because it requires mapping two biosynthetic products onto a shared ceramide scaffold and reasoning out which structural positions differ and which are conserved.

---

## Q12 . Two-attribute sphingolipid classification from data

**Stem.** A membrane lipid fraction from nervous tissue yields three purified components, X, Y, and Z, whose structural features are summarized below.

| Component | Backbone | Fatty acid attachment | Phosphorus | Head group |
|---|---|---|---|---|
| X | sphingosine | one, amide-linked | present | choline joined through a phosphodiester bond |
| Y | sphingosine | one, amide-linked | absent | a single galactose unit |
| Z | sphingosine | one, amide-linked | absent | a branched oligosaccharide bearing sialic acid |

Which assignment correctly matches each component to its lipid class?

- **A.** X: cerebroside; Y: sphingomyelin; Z: ganglioside
- **B.** X: sphingomyelin; Y: ganglioside; Z: cerebroside
- **C.** X: ganglioside; Y: cerebroside; Z: sphingomyelin
- **D.** X: sphingomyelin; Y: cerebroside; Z: ganglioside  <- **KEY**

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 105 s |
| Confidence | 5 |
| Hard-tier gate | (a) combines two classification criteria, phosphate presence and single sugar versus sialylated oligosaccharide, which must be applied jointly; (c) choices B and D both survive the phosphate criterion and remain defensible until the sialic acid fact discriminates the two glycolipid classes. |

**Correct answer (D): X: sphingomyelin; Y: cerebroside; Z: ganglioside**

Citations: BC:43462-43471; BC:33884-33888; BC:48085; BC:43450-43451

**Distractors**

- **(A)** `reversed_relationship` . _phosphate criterion inverted_: Reverses which head chemistry carries the phosphate: cerebrosides are phosphorus-free and sphingomyelin is defined by its phosphodiester head.
  - Citation: BC:43462-43471
- **(B)** `partial_truth` . _passes phosphate test, fails sugar test_: Places X correctly but swaps the glycolipids; only the sialic-acid-bearing oligosaccharide head marks a ganglioside, not a single galactose.
  - Citation: BC:33884-33888
- **(C)** `misconception` . _acidic sugar mistaken for phosphate_: Treats sialic acid's acidity as if it were a phosphate head, but Z contains no phosphorus and cannot be a phospholipid.
  - Citation: BC:33884-33888

**Readback check.** Key content words of six or more letters (sphingomyelin, cerebroside, ganglioside) appear nowhere in the stem or table, which give only raw attributes (sphingosine, galactose, sialic acid, phosphodiester); mapping attributes to class names is the inferential step, so the answer is not a value read off the data.

**Explanation (as shipped).**

> This Lipids question requires classifying three sphingolipids from tabulated structural attributes. The answer is D because two criteria applied in sequence sort the components uniquely. Note first that all three components share the same ceramide core, a sphingosine backbone with one amide-linked fatty acid, so the backbone and linkage columns cannot discriminate among them; classification rests entirely on the head. The first criterion is phosphorus: component X is the only one with a phosphodiester-linked head, and among sphingosine-based lipids that head chemistry defines sphingomyelin, here with choline as the attached alcohol. The second criterion applies to the phosphate-free, sugar-headed components: Y carries one galactose unit, the single-sugar pattern of a cerebroside, while Z carries a branched oligosaccharide containing sialic acid, and the presence of sialic acid residues is the recognition mark of a ganglioside. Applying both attributes together yields X as sphingomyelin, Y as cerebroside-type, and Z as ganglioside-type. (Choice A) Assigning the phosphate-containing component to the cerebroside class and the galactose-headed component to sphingomyelin reverses the head chemistry of the two classes; a cerebroside never contains phosphorus, and sphingomyelin always does. (Choice B) This assignment passes the phosphorus test and places X correctly, but then swaps the two glycolipids: a single galactose cannot constitute the sialylated oligosaccharide of a ganglioside, and an oligosaccharide bearing sialic acid is far too elaborate to be a cerebroside head. (Choice C) Treating the sialic-acid-bearing component as sphingomyelin confuses an acidic sugar with a phosphate group; sialic acid carries a carboxylate rather than a phosphodiester, and the table lists Z as phosphorus-free, which excludes it from the phospholipid class outright. This is a Data-based and Statistical Reasoning question because it requires applying two structural criteria simultaneously to tabulated molecular attributes in order to sort each component into its correct sphingolipid class.

---

## Q13 . Retinal aldehyde as visual chromophore

**Stem.** Dietary vitamin A reaches the retina, where one of its derivatives binds the protein opsin to form a pigment that changes shape upon absorbing a photon, initiating vision. At its terminal carbon, this photon-absorbing derivative carries which functional group?

- **A.** A carboxylic acid
- **B.** An aldehyde  <- **KEY**
- **C.** A primary alcohol
- **D.** A fatty acid ester

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 60 s |
| Confidence | 5 |

**Correct answer (B): An aldehyde**

Citations: BC:41012; BC:49614-49616; BIO:44771; BIO:48262-48264

**Distractors**

- **(A)** `process_step_confusion` . _one oxidation step too far_: A carboxylic acid is the terminal group of retinoic acid, the product of one oxidation beyond the aldehyde; it acts on developing tissues, not in photoreception.
  - Citation: BIO:44771
- **(C)** `partial_truth` . _parent form mistaken for active form_: A primary alcohol is the terminal group of retinol, genuinely a vitamin A form, but the parent transport molecule, not the opsin-bound chromophore.
  - Citation: BIO:44771
- **(D)** `adjacent_fact` . _neighboring lipid linkage mistaken for the active group_: An ester joins an alcohol oxygen to a fatty acid, the linkage found in storage fats; an esterified terminus remains at the alcohol oxidation level and cannot be the photon-absorbing aldehyde.
  - Citation: BIO:3978

**Readback check.** Key content words of six or more letters: aldehyde. No form of this word appears in the stem; the stem supplies the role and the student must supply the oxidation state, an inferential step from function to structure.

**Explanation (as shipped).**

> This Lipids question tests the vitamin A family of fat-soluble isoprenoid derivatives and asks which oxidation state of the molecule's terminal carbon marks the light-absorbing component of the visual pigment. The answer is B because the derivative that binds opsin is retinal, in which the terminal carbon of the vitamin's long polyene chain has been oxidized from an alcohol to an aldehyde. Retinal's extended chain of alternating single and double bonds is the part of the molecule that actually captures the photon, and absorption flips the geometry of one of those double bonds; the resulting change in shape is passed to the surrounding opsin protein and launches the signal the brain interprets as light. The common vitamin A forms differ only in the oxidation state of that single terminal carbon: alcohol in retinol, aldehyde in retinal, and carboxylic acid in retinoic acid. All of them share the same hydrophobic isoprenoid skeleton, which is why the family travels and is stored with lipids, so matching each physiological role to its terminal group is the entire discriminating task. (Choice A) A carboxylic acid is the terminal group of retinoic acid, formed by one additional oxidation beyond the aldehyde; that derivative acts on developing tissues rather than participating in photoreception. (Choice C) A primary alcohol is the terminal group of retinol, the parent and transport form of the vitamin; it must be oxidized once before it can join opsin as the pigment's light-absorbing unit. (Choice D) A fatty acid ester forms when an alcohol oxygen condenses with a fatty acid, the same linkage that joins fatty acids to glycerol in dietary fats; an esterified terminus stays at the alcohol oxidation level and is not the group presented by the opsin-bound derivative. This is a Knowledge of Scientific Concepts and Principles question because it asks the student to recall which oxidation state of vitamin A's terminal carbon corresponds to the derivative serving as the photon-absorbing component of the visual pigment.

---

## Q14 . Retinoic acid supports epithelial development

**Stem.** The terminal carbon of vitamin A can be oxidized in two sequential steps, first from an alcohol to an aldehyde and then from the aldehyde to a carboxylic acid. In an experimental animal, the enzyme catalyzing only the second step is inactivated, while all other vitamin A handling remains normal. Which function is most directly lost?

- **A.** Transport of the vitamin's alcohol form through the blood on its plasma binding protein
- **B.** Photon capture by the pigment of rod photoreceptor cells
- **C.** Regeneration of the alcohol form from the aldehyde form
- **D.** Support of the growth and specialization of epithelial tissues such as the skin  <- **KEY**

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic secondary / structural two_step) |
| Estimated time | 80 s |
| Confidence | 4 |

**Correct answer (D): Support of the growth and specialization of epithelial tissues such as the skin**

Citations: BIO:44771; BIO:48262-48264; BC:15916

**Distractors**

- **(A)** `adjacent_fact` . _upstream process presented as the casualty_: Plasma transport uses the alcohol form of the vitamin carried on retinol binding protein, upstream of both oxidations, so a block at the second step cannot affect it.
  - Citation: BC:15916
- **(B)** `process_step_confusion` . _wrong branch of the metabolic fork_: Vision depends on the aldehyde derivative, the product of the first oxidation, which is still made when only the second step is blocked.
  - Citation: BIO:48262-48264
- **(C)** `reversed_relationship` . _direction of the reaction flipped_: Aldehyde back to alcohol is a reduction running in the opposite direction from the inactivated oxidation and uses different enzymes entirely.
  - Citation: BIO:44771

**Readback check.** Key content words of six or more letters: support, growth, specialization, epithelial, tissues. None appear in the stem, which describes only the oxidation chemistry and the enzymatic block; the student must infer which derivative and role vanish.

**Explanation (as shipped).**

> This Lipids question tests the division of labor among the vitamin A derivatives: the aldehyde-level molecule works in vision while the carboxylic acid-level molecule serves developing tissues. The answer is D because inactivating only the second oxidation removes a single product, retinoic acid, the carboxylic acid derivative. Retinoic acid is the family member that acts on developing tissues, supporting the proper formation and renewal of epithelial layers such as the skin; this is why vitamin A deficiency presents clinically with skin disorders in addition to night blindness. Because the first oxidation still runs, the aldehyde derivative is made normally, and every role served by the alcohol or the aldehyde is untouched. Each oxidation raises the terminal carbon one level, and only the final, acid-level product carries the developmental role, so the question is solved by tracing which end product disappears when the second step alone fails. A useful check is that any answer naming a role of the alcohol or the aldehyde must survive the block, leaving only the acid-dependent role as a casualty. (Choice A) Transport through the blood carries the alcohol form of the vitamin on its plasma binding protein; this lies upstream of both oxidations, so a block at the second step leaves it untouched. (Choice B) Photon capture in rod photoreceptors is performed by the aldehyde derivative, the product of the first oxidation; that molecule is still synthesized in normal amounts when only the second step fails. (Choice C) Returning the aldehyde to the alcohol is a reduction, the reverse of the first oxidation, and does not involve the inactivated enzyme at any point. This is a Scientific Reasoning and Problem Solving question because it requires the student to map a specific enzymatic block onto the branched metabolism of vitamin A and deduce which downstream physiological function is lost.

---

## Q15 . Conjugation length sets carotene color

**Stem.** Beta-carotene, a 40-carbon plant hydrocarbon containing 11 conjugated double bonds, absorbs maximally near 450 nm and gives carrots their orange color. A single enzymatic cut at its central bond yields two identical 20-carbon molecules, each ending in an aldehyde; this molecule, retinal, has 6 conjugated double bonds and absorbs maximally near 380 nm, just outside the visible range. A fully saturated hydrocarbon of either length absorbs only below 200 nm. These data best support which conclusion?

- **A.** The wavelength a polyene captures grows with the extent of its unbroken pi framework, so halving the framework shifts the peak below the band the eye detects  <- **KEY**
- **B.** The wavelength a polyene captures shrinks as its unbroken pi framework extends, which is why the parent molecule needs higher-energy light than its fragments
- **C.** The aldehyde created by the cut, not the pi framework, is the group that captures light in the visible band
- **D.** Because each fragment keeps the parent's ratio of double bonds to carbons, its peak stays at the parent's wavelength

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic secondary / structural multi_step) |
| Estimated time | 100 s |
| Confidence | 4 |
| Hard-tier gate | (a) combines two concepts: the conjugation-length dependence of absorption wavelength and the central cleavage of carotene into two vitamin A units; (b) quantitative and directional inference: mapping 11 versus 6 conjugated bonds onto 450 versus 380 nm and extrapolating the shift out of the visible band. |

**Correct answer (A): The wavelength a polyene captures grows with the extent of its unbroken pi framework, so halving the framework shifts the peak below the band the eye detects**

Citations: BIO:10585-10598; BC:49614-49616; BIO:24151-24154

**Distractors**

- **(B)** `reversed_relationship` . _direction of the structure-property trend flipped_: The trend in the data is the opposite: the longest conjugated run absorbs the longest wavelength and lowest energy, so extending the framework does not shrink the captured wavelength.
  - Citation: BIO:10585-10598
- **(C)** `misconception` . _salient functional group credited for a pi-system property_: The data refute an aldehyde-based explanation: the aldehyde-bearing fragment absorbs outside the visible band while the aldehyde-free parent is the colored species.
  - Citation: BC:49614-49616
- **(D)** `scale_unit_error` . _ratio mistaken for the operative absolute quantity_: Absorption depends on the absolute length of the continuous conjugated run, not the per-carbon density of double bonds; the peak measurably moves from 450 to 380 nm after cleavage.
  - Citation: BIO:10585-10598

**Readback check.** Key content words of six or more letters: wavelength, polyene, captures, extent, unbroken, framework, halving, shifts, detects. None appear in the stem, which supplies only structural counts and numerical absorption values; the conclusion must be built from the trend, not read off.

**Explanation (as shipped).**

> This Lipids question tests the link between beta-carotene's structure and its behavior as a pigment, and what happens to light absorption when the molecule is split into its two vitamin A halves. The answer is A because the data tie peak absorption to the length of the continuous run of alternating double bonds: eleven in sequence absorb at 450 nm, six absorb at 380 nm, and a chain with none at all absorbs only below 200 nm. Longer conjugation lets the pi electrons spread over a larger framework, which narrows the energy gap between their occupied and excited states, so more extended conjugated systems capture lower-energy, longer-wavelength photons. Reading the trend forward, cutting the eleven-bond run roughly in half drops the peak from the blue region into the near ultraviolet, and the fragments no longer remove any visible wavelength from reflected light. This is exactly why the central cleavage of one orange carotene molecule yields two retinal units whose peak absorption no longer falls in the visible band; each is nonetheless the aldehyde-bearing vitamin A derivative that can go on to serve as the light-sensing unit of the visual pigment. (Choice B) The data run opposite to this claim: the molecule with the most extended alternating framework absorbs at the longest wavelength and therefore the lowest photon energy, not the highest. (Choice C) The aldehyde cannot be the visible-light absorber, because the fragment carrying the aldehyde absorbs at 380 nm, outside the visible band, while the parent species with no aldehyde at all is the orange one. (Choice D) The fragments do retain a double-bond density close to the parent's, but absorption tracks the absolute extent of the unbroken conjugated run rather than its per-carbon density, and the measured peak in fact moves from 450 nm to 380 nm. This is a Data-based and Statistical Reasoning question because it requires the student to extract the relationship between conjugation length and absorption wavelength from comparative spectral data and extrapolate it to the products of carotene cleavage.

---

## Q16 . Vitamin D3 as a ring-opened steroid derivative

**Stem.** In the skin, ultraviolet light converts a derivative of cholesterol into vitamin D3. A student receives an unlabeled lipid sample known to be either pure cholesterol or pure vitamin D3. Analysis shows a single hydroxyl group, a branched hydrocarbon tail, and exactly three closed carbon rings, with the carbons that would close a fourth ring instead lying in an open chain. Which conclusion does the analysis best support?

- **A.** The sample is cholesterol, because the nucleus of cholesterol consists of three fused rings
- **B.** The sample is cholesterol, because only the intact parent compound possesses a branched hydrocarbon tail
- **C.** The sample is vitamin D3, because one ring of the fused steroid nucleus was broken during its synthesis while the rest of the skeleton remained intact  <- **KEY**
- **D.** The sample is vitamin D3, because the light-driven conversion removes the branched tail while leaving all four rings of the precursor closed

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 80 s |
| Confidence | 4 |

**Correct answer (C): The sample is vitamin D3, because one ring of the fused steroid nucleus was broken during its synthesis while the rest of the skeleton remained intact**

Citations: BIO:4140-4152; BIO:4156; BC:43852

**Distractors**

- **(A)** `misconception` . _miscounted defining feature of the steroid nucleus_: All steroids, cholesterol included, are built on four fused carbon rings, so a three-ring compound cannot be intact cholesterol.
  - Citation: BIO:4146
- **(B)** `partial_truth` . _shared feature treated as a discriminator_: Cholesterol does carry a short branched tail, but the tail survives the ring-opening conversion and appears in both molecules, so it cannot discriminate between them.
  - Citation: BIO:4146
- **(D)** `process_step_confusion` . _wrong bond change assigned to the photochemical step_: The conversion opens one ring and keeps the tail; the sample itself shows a branched tail and only three closed rings, the opposite of what this choice predicts.
  - Citation: BC:43852

**Readback check.** Key content words of six or more letters: steroid, nucleus, broken, during, synthesis, skeleton, remained, intact. None appear in the stem, which names the two candidate molecules and lists analytical findings; the student must supply the four-ring definition of the steroid nucleus and reason to the ring-opened identity.

**Explanation (as shipped).**

> This Lipids question tests the structural relationship between vitamin D3 and the steroid nucleus of its precursor. The answer is C because every steroid, cholesterol included, is built on a nucleus of four fused rings, so a compound presenting only three closed rings cannot be intact cholesterol. Vitamin D3 arises when ultraviolet light breaks open one ring of a cholesterol-derived precursor in the skin; the product keeps the other three rings, the single hydroxyl group, and the branched hydrocarbon tail of the steroid framework, while the atoms of the opened ring persist as an open stretch of chain. The sample's inventory matches that ring-opened pattern exactly: three closed rings plus the leftover chain that once completed a fourth. Solving the problem therefore takes two steps, first recalling the four-ring definition of the steroid nucleus to rule out cholesterol, then recognizing the three-ring remainder with its residual open segment as the signature of the light-opened vitamin. (Choice A) This choice rests on a miscount of the steroid nucleus; steroids are defined by four fused rings, not three, so a three-ring compound argues against cholesterol rather than for it. (Choice B) Cholesterol does possess a short branched tail, but the tail survives the ring-opening conversion and is present in both molecules, so its presence cannot distinguish the sample; the ring count is the discriminating observation. (Choice D) The light-driven conversion opens a ring and leaves the tail in place, and the analysis itself reports a branched tail with only three closed rings, the opposite of what this choice predicts. This is a Scientific Reasoning and Problem Solving question because it requires the student to combine the four-ring definition of the steroid nucleus with the reported ring count to deduce which of the two candidate molecules the sample must be.

---

## Q17 . Tocopherol chain-breaking site in membranes

**Stem.** A research team prepares liposomes from phospholipids with polyunsaturated tails, adds a lipid-soluble radical initiator, and tracks the accumulation of lipid peroxidation products over time. When a small amount of alpha-tocopherol is incorporated into the bilayer, almost no product forms until the tocopherol is used up, after which products accumulate rapidly. The team wishes to conclude that tocopherol halts the propagation of radicals by donating a hydrogen atom within the bilayer itself, rather than by reacting in the surrounding solution. Which additional condition would most directly support the proposed site of action?

- **A.** Repeating the experiment with liposomes built from fully saturated phospholipid tails
- **B.** Repeating the experiment with the radical initiator omitted to confirm that no products form spontaneously
- **C.** Running a parallel trial in which an equally potent water-soluble reducing agent is confined to the aqueous phase outside the vesicles  <- **KEY**
- **D.** Doubling the incorporated tocopherol and confirming that the delay before products appear lengthens proportionally

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 3 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 105 s |
| Confidence | 4 |
| Hard-tier gate | (a) combines radical chain chemistry with membrane compartmentalization; (c) choices B and D are defensible controls until the discriminating requirement, localizing the site of action rather than confirming the mechanism, is applied |

**Correct answer (C): Running a parallel trial in which an equally potent water-soluble reducing agent is confined to the aqueous phase outside the vesicles**

Citations: BC:42795 (lipids serve as antioxidants); BC:43840 (vitamin E among isoprenoid-containing lipid vitamins); BIO:44798 (vitamin E lessens oxidative damage of cells)

**Distractors**

- **(A)** `adjacent_fact` . _control that probes the substrate instead of the inhibitor_: A saturated-tail preparation tests whether polyunsaturated chains are the substrate for peroxidation, a true and useful control that answers a different question and says nothing about where tocopherol intervenes.
  - Citation: BC:42795
- **(B)** `process_step_confusion` . _control aimed at the wrong step of the process_: Omitting the initiator is a control on the initiation step of the radical chain, not on the propagation-blocking step where tocopherol acts, so it cannot address the inhibitor's compartment.
  - Citation: BC:42795
- **(D)** `partial_truth` . _evidence for the mechanism but not the location_: A dose-proportional delay genuinely supports stoichiometric radical scavenging by tocopherol, but it is equally consistent with scavenging in either compartment, so it fails to establish the membrane as the site of action.
  - Citation: BIO:44798

**Readback check.** Key content words of six or more letters in the credited choice (parallel, equally, potent, water-soluble, reducing, confined, aqueous, outside, vesicles) do not appear in the stem; answering requires the inferential step that only a compartment-restricted antioxidant comparison can localize the site of action, which no stem sentence states.

**Explanation (as shipped).**

> This Lipids question examines vitamin E's role as the chain-breaking antioxidant of membranes and asks how an experiment can localize that activity to the bilayer interior. The answer is C because the team's conclusion contains two separable claims: that tocopherol interrupts radical propagation, and that it does so from within the membrane rather than from the surrounding solution. The observed delay already establishes interruption, since products appear only after the tocopherol supply is exhausted, but the delay alone cannot distinguish where the interruption happens. Supplying an equally potent reducing agent that dissolves only in water, and showing that it fails to reproduce the protective delay, demonstrates that reducing power in the aqueous compartment is not sufficient; protection requires an antioxidant that resides among the hydrocarbon tails, where the propagating radicals are generated. That localization reflects tocopherol's design: its ring donates a hydrogen atom to a lipid radical, yielding a stabilized species too sluggish to continue the chain, while its long hydrophobic tail anchors it in the bilayer beside the polyunsaturated chains it protects, exactly where a water-soluble reducer cannot reach. (Choice A) Liposomes built from fully saturated tails would test whether polyunsaturated chains are the necessary substrate for peroxidation; that is a legitimate but different question, and its outcome would reveal nothing about the compartment in which tocopherol acts. (Choice B) Omitting the initiator is a baseline control for the initiation step, confirming that the measured products are radical-derived; it does not probe the inhibitor at all, let alone its location. (Choice D) A proportional lengthening of the protective delay supports stoichiometric consumption of the antioxidant by radicals, which strengthens the chain-breaking mechanism but remains silent on whether that chemistry occurs inside the bilayer or in solution. This is a Reasoning about the Design and Execution of Research question because it asks the student to select the control condition that isolates the membrane compartment as an antioxidant's site of action.

---

## Q18 . Vitamin K glutamate carboxylation chemistry

**Stem.** Hepatocytes secrete an inactive clotting-factor precursor whose amino-terminal region must be enzymatically altered before the protein can participate in coagulation. The responsible enzyme requires vitamin K, and mass spectrometry of the mature protein shows that several residues in this region have each gained 44 Da. Which change to the precursor accounts for these findings?

- **A.** Attachment of a phosphate group to the gamma carbon of selected glutamate side chains
- **B.** Attachment of a second carboxyl group to the gamma carbon of selected glutamate side chains  <- **KEY**
- **C.** Removal of the original carboxyl group from selected glutamate side chains
- **D.** Attachment of a second carboxyl group to the side chains of selected aspartate residues

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 85 s |
| Confidence | 5 |

**Correct answer (B): Attachment of a second carboxyl group to the gamma carbon of selected glutamate side chains**

Citations: BC:46385 (vitamin K-dependent enzyme carboxylates glutamate residues to gamma-carboxylated glutamic acid on clotting zymogens); BIO:53570 (many clotting factors require vitamin K); BIO:44805 (vitamin K essential to blood clotting)

**Distractors**

- **(A)** `scale_unit_error` . _wrong functional group betrayed by the mass scale_: Phosphorylation adds about 80 Da per site, not 44 Da; the mass datum alone excludes a phosphate transfer despite phosphorylation being the most familiar post-translational modification.
  - Citation: BC:46385
- **(C)** `reversed_relationship` . _direction of the modification reversed_: Decarboxylation is the exact reverse of the vitamin K-dependent chemistry; it would lower the residue mass and strip away the calcium-binding feature instead of building it.
  - Citation: BC:46385
- **(D)** `adjacent_fact` . _right chemistry transplanted onto the wrong residue_: Aspartate is a real acidic residue and its carboxylation would also add 44 Da, but the vitamin K-dependent carboxylase specifically targets glutamate side chains, not aspartate.
  - Citation: BC:46385

**Readback check.** Key content words of six or more letters (attachment, second is exactly six, carboxyl, carbon, selected, glutamate) are absent from the stem, which never names the residue, the group added, or the word carboxylation; the student must infer the identity of a 44 Da addition from the mass datum and the cofactor.

**Explanation (as shipped).**

> This Lipids question tests the chemistry of the post-translational modification performed by the vitamin K-dependent carboxylase. The answer is B because a mass gain of 44 Da corresponds to the incorporation of one molecule of carbon dioxide, and that is exactly what the vitamin K-dependent enzyme installs: a new carboxyl group attached to the gamma carbon of particular glutamate side chains after the polypeptide has already been synthesized. Each modified residue, known as gamma-carboxyglutamate, therefore bears two carboxylate groups where the original glutamate bore one. These modified residues cluster in the amino-terminal region of several clotting-factor precursors, including the precursor of thrombin, and the modification is what renders those proteins competent for coagulation; when the vitamin K cofactor is missing, the carboxylation step fails and the precursors remain inactive. The point under test is the chemistry itself: a carboxylation of an amino acid side chain within a finished protein, which is why it qualifies as a post-translational modification rather than an event of translation. (Choice A) A phosphate transfer would add roughly 80 Da per site, not 44 Da, so the measured mass increase rules out phosphorylation even though it is otherwise the most familiar post-translational modification. (Choice C) Removing the original carboxyl group runs in the wrong direction; a decarboxylation would decrease the residue mass rather than increase it, and it would dismantle, rather than construct, the doubled negative charge these proteins require. (Choice D) The vitamin K-dependent carboxylase acts on glutamate, not aspartate; although adding a carboxyl group to aspartate would also produce a 44 Da gain, the enzyme's residue specificity places the new group on glutamate's gamma carbon. This is a Scientific Reasoning and Problem Solving question because it asks the student to match a measured mass change and a cofactor requirement to the specific covalent chemistry of a side-chain carboxylation.

---

## Q19 . Doubled carboxylate calcium chelation logic

**Stem.** A synthetic peptide containing four glutamate residues binds calcium ions weakly, with a dissociation constant near 5 mM. After enzymatic modification, each of those side chains carries a pair of carboxylate groups on adjacent carbons, and the dissociation constant for calcium falls to 0.05 mM while sodium binding is essentially unchanged. Which property of the modified side chains best explains these measurements?

- **A.** Each of the two acid groups captures its own separate calcium ion, doubling the number of ions the peptide holds
- **B.** The second acid group makes the side chain more hydrophobic, favoring close approach to the ion
- **C.** The two acid groups, in their protonated neutral forms, hydrogen bond to the calcium ion
- **D.** Two closely spaced negative charges on a single side chain attract a doubly charged cation from both sides at once  <- **KEY**

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 4 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 70 s |
| Confidence | 5 |

**Correct answer (D): Two closely spaced negative charges on a single side chain attract a doubly charged cation from both sides at once**

Citations: BC:46385 (calcium ions bind the gamma-carboxylated glutamate residues of prothrombin's Gla region; Gla side chains interact with Ca2+ ions)

**Distractors**

- **(A)** `partial_truth` . _additive-sites reading that ignores cooperativity in the data_: More anionic groups can indeed hold more cations in aggregate, but independent sites would raise capacity roughly twofold without tightening any single site; the hundredfold drop in the dissociation constant shows the two charges cooperate on one ion.
  - Citation: BC:46385
- **(B)** `misconception` . _polarity of the modification inverted_: Adding an ionizable acid group increases polarity and negative charge; it does not make the side chain hydrophobic, and hydrophobicity would not attract a cation in water.
  - Citation: BC:46385
- **(C)** `reversed_relationship` . _charge state of the working form reversed_: Binding requires the deprotonated anionic form of the acids; protonation neutralizes the charges and abolishes the electrostatic attraction, the opposite of what this choice claims.
  - Citation: BC:46385

**Readback check.** Key content words of six or more letters in the credited choice (closely, spaced, negative, charges, single, attract, doubly, charged, cation) do not appear in the stem, which reports only dissociation constants and structural facts; the electrostatic chelation interpretation must be inferred from the data, not read back.

**Explanation (as shipped).**

> This Lipids question tests the electrostatic logic by which the doubled carboxylate of gamma-carboxyglutamate binds calcium. The answer is D because at physiological pH both acid groups on the modified side chain are ionized, so the residue presents two negative charges held close together on adjacent carbons. A calcium ion carries two positive charges and can sit between the paired anions, attracted by both simultaneously; the side chain closes around the ion like a claw, an arrangement commonly described as chelation of a divalent cation. The measurements match this geometry in two ways. Affinity improves one hundredfold, far more than the modest statistical gain expected if the modification had merely added a second independent binding site, which signals that the two charges cooperate on a single ion. And the improvement is selective for the doubly charged ion: a sodium ion, with only one positive charge, cannot take full advantage of the second contact, so its binding barely changes. This is the same chemistry that lets modified clotting proteins hold calcium ions along their amino-terminal regions. (Choice A) If each acid group captured its own separate ion, the peptide would hold more calcium overall, but the tightness of any individual site would be nearly unchanged; the large fall in the dissociation constant shows a change in grip on each ion, not merely a change in capacity. (Choice B) An added ionizable acid group makes the side chain more polar and more negatively charged, not more hydrophobic, and a hydrophobic surface offers no attraction for a cation dissolved in water. (Choice C) The attraction depends on the deprotonated, anionic form of the acids; in their protonated neutral form the charges vanish and the electrostatic pull is lost, so protonation would weaken binding rather than create it. This is a Data-based and Statistical Reasoning question because it asks the student to use the size of the affinity change and the unchanged sodium binding to infer that paired negative charges coordinate a single divalent cation.

---

## Q20 . Prostaglandin autocrine paracrine locality

**Stem.** A researcher isolates two signaling molecules. Molecule 1 is a twenty-carbon carboxylic acid with a five-membered ring, produced in nearly every organ from a fatty acid freed from membrane phospholipid. Molecule 2 is a peptide exported by one discrete gland into the bloodstream, which carries it to distant organs. Which of the following accurately characterizes molecule 1?

I. It acts on the cell that released it or on that cell's immediate neighbors

II. It must ride the general circulation before reaching any responsive cell

III. It can stimulate a given process in one location yet inhibit the same process elsewhere

- **A.** I only
- **B.** II only
- **C.** I and III only  <- **KEY**
- **D.** II and III only

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 80 s |
| Confidence | 5 |

**Correct answer (C): I and III only**

Citations: BC:31356-31383 (prostaglandins are twenty-carbon eicosanoids with a five-carbon ring, derived from arachidonic acid, acting as autocrine or paracrine factors with target cells near the secretion site, unlike endocrine hormones; the same prostaglandin can stimulate a reaction in one tissue and inhibit it in another depending on receptor type)

**Distractors**

- **(A)** `partial_truth`: Correctly keeps the local-action property but wrongly excludes statement III; receptor-dependent opposite effects in different tissues are a documented prostaglandin hallmark.
  - Citation: BC:31374-31377
- **(B)** `reversed_relationship`: Assigns the endocrine hormone's obligatory blood-borne delivery to the locally acting eicosanoid while rejecting both of its true properties, inverting the two signaling strategies.
  - Citation: BC:31377-31379
- **(D)** `misconception`: Pairs the true receptor-dependence statement with the false circulation requirement, the common belief that hormone-like effects imply hormone-like long-distance transport.
  - Citation: BC:31377-31379

**Readback check.** Keyed statements I and III contain the six-plus-letter content words immediate, neighbors, stimulate, process, location, inhibit, and elsewhere; none of these words appears in the descriptive portion of the stem, which uses exported, bloodstream, distant, and organs for the contrasting molecule.

**Explanation (as shipped).**

> This Lipids question tests the signaling range of prostaglandins, the family of twenty-carbon eicosanoid mediators, and the way their local action separates them from classical endocrine hormones. The answer is C because statements I and III are accurate while statement II is false. Molecule 1 matches the prostaglandin blueprint: twenty carbons including a five-membered ring, produced in nearly every organ from arachidonic acid liberated from membrane phospholipid. Prostaglandins operate as autocrine and paracrine factors, meaning their target cells are the secreting cell itself or cells lying immediately nearby, which makes statement I correct. Because the response depends on which receptor type a given target expresses, one and the same prostaglandin can stimulate a process in one location and inhibit that identical process somewhere else, which makes statement III correct as well. Statement II instead describes molecule 2 and the classical hormone strategy: release from a single dedicated gland followed by bulk transport in blood to remote organs. Prostaglandins are short-lived and act before any such journey could occur, so obligatory passage through the circulation is exactly the property they lack. (Choice A) is a partial truth: it accepts the local-action statement but wrongly rejects statement III, even though receptor-dependent variation in response is a hallmark of this lipid family and follows directly from its local mode of delivery. (Choice B) reverses the two signaling strategies, assigning the endocrine requirement for blood-borne delivery to the locally acting lipid while discarding both of its genuine properties. (Choice D) couples the true receptor-dependence statement to the false circulation requirement, reflecting the misconception that a molecule with hormone-like potency must also use hormone-like long-distance delivery. This is a Scientific Reasoning and Problem Solving question because it requires identifying an unnamed twenty-carbon lipid as a prostaglandin from structural clues and then applying the autocrine and paracrine signaling model to judge each claim about how far the signal travels before acting.

---

## Q21 . Enzyme blockade reveals mediator function

**Stem.** In a placebo-controlled trial, volunteers with acute joint sprains take a drug that irreversibly inactivates the enzyme converting arachidonic acid, a twenty-carbon fatty acid cut loose from membrane phospholipid, into prostaglandins. Compared with placebo, treated volunteers report milder pain, show less swelling at the sprain, and register lower fevers. Chemical assays confirm the drug binds only that enzyme and no receptor. These observations most strongly support which conclusion?

- **A.** The drug produced relief by directly numbing sensory neurons, independent of any change in lipid synthesis.
- **B.** The blocked products normally restrain inflammation, and their loss let alternative mediators resolve the injury sooner.
- **C.** Relief occurred because the unreacted fatty acid substrate, rather than any downstream product, is the true mediator of pain and fever.
- **D.** The lipid products of the targeted reaction normally act as causal promoters of inflammation, nociception, and an elevated thermal set point.  <- **KEY**

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 3 |
| Difficulty | **hard** (topic core / structural two_step) |
| Estimated time | 90 s |
| Confidence | 5 |
| Hard-tier gate | (b) directional inference: the student must reason from loss of the product to the sign of its normal action, concluding the products promote rather than suppress the responses; (d) inverts the usual reasoning direction: instead of predicting an outcome from a known function, the student infers physiological function from what disappears when synthesis is blocked. |

**Correct answer (D): The lipid products of the targeted reaction normally act as causal promoters of inflammation, nociception, and an elevated thermal set point.**

Citations: BC:31356-31383 (prostaglandins derive from arachidonic acid, are made by cyclooxygenases that NSAIDs target, and are involved in inflammation, pain, and triggering fever); BC:31460-31500 (NSAIDs inhibit the cyclooxygenase enzymes, aspirin by covalent acetylation of a serine, reducing prostaglandin production and thereby pain and fever)

**Distractors**

- **(A)** `misconception`: A direct neuronal anesthetic effect is ruled out by the stated binding data showing the drug interacts only with the biosynthetic enzyme.
  - Citation: BC:31460-31500
- **(B)** `reversed_relationship`: If prostaglandins suppressed inflammation, eliminating them would intensify swelling and fever; the observed relief shows they promote, not restrain, these responses.
  - Citation: BC:31379-31383
- **(C)** `process_step_confusion`: Attributes the activity to the substrate instead of the product; enzyme blockade raises substrate levels, so symptoms would worsen if arachidonic acid itself were the mediator.
  - Citation: BC:31356-31361

**Readback check.** Key content words of six or more letters are products, targeted, normally, causal, promoters, inflammation, nociception, elevated, and thermal; none appears in the stem, which uses swelling rather than inflammation, fevers rather than thermal, and inactivates rather than targeted.

**Explanation (as shipped).**

> This Lipids question examines how an enzyme-inhibition experiment reveals the physiological role of prostaglandins, the twenty-carbon lipid mediators built from arachidonic acid. The answer is D because removing a product and watching a response fade is the classic loss-of-function argument: if inactivating the synthetic enzyme relieves pain, swelling, and fever, the products that enzyme normally makes must have been actively driving those responses. The trial isolates the variable cleanly, since the assays show the drug touches only the biosynthetic enzyme and binds no receptor, so any clinical change must trace back to the missing lipid output rather than to some direct drug effect on the responding cells. Because all three findings moved downward together once synthesis stopped, the simplest supported conclusion is that prostaglandins generated at the injury and in thermoregulatory centers act as positive mediators of inflammation, nociceptive signaling, and the raised thermal set point. Note that this inference concerns what the products were doing, not how target cells transduce them; the experiment identifies the mediators, and working out any downstream mechanism would require separate studies. (Choice A) proposes direct action on sensory neurons, a misconception the design already excludes: the binding assays show the drug interacts with the enzyme alone, so a neuronal mechanism cannot account for the result. (Choice B) reverses the direction of prostaglandin action; if these lipids normally restrained inflammation, cutting off their supply should have worsened the swelling and fever rather than relieving them, the opposite of what was measured. (Choice C) confuses adjacent steps of the pathway: blocking the enzyme makes the fatty acid substrate accumulate, so if the substrate itself caused pain and fever, treated volunteers should have felt worse as it built up, again contradicting the data. This is a Reasoning about the Design and Execution of Research question because it asks the student to interpret a controlled loss-of-function intervention and decide what the disappearance of a response implies about the normal role of the molecules that were eliminated.

---

## Q22 . Fat solubility drives tissue accumulation

**Stem.** Two adults each ingest ten times the recommended daily amount of a different micronutrient for eight weeks. Compound X is water soluble; compound Y is lipid soluble. Week 8 data: the X user shows near-baseline plasma X with a fortyfold rise in urinary X, while the Y user shows mildly raised plasma Y, an eightfold rise in liver and adipose Y, and urinary Y below the assay's detection limit. Which conclusion do these data best support?

- **A.** Y dissolves preferentially into hydrophobic depots and evades renal removal, so sustained overconsumption will drive progressive buildup toward toxicity.  <- **KEY**
- **B.** The undetectable urinary signal indicates Y is completely degraded to inactive end products, leaving no reservoir that could ever reach harmful levels.
- **C.** The tissue enrichment of Y is transient because lipid-soluble compounds equilibrate with body water and wash out within days of stopping the doses.
- **D.** The fortyfold figure shows X deposits in fatty stores five times faster than Y accumulates, since forty divided by eight is five.

| | |
|---|---|
| Foundation | 5D |
| Content category | Lipids |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic secondary / structural multi_step) |
| Estimated time | 100 s |
| Confidence | 4 |
| Hard-tier gate | (a) combines two concepts: solubility-based partitioning into lipid compartments and the aqueous nature of renal clearance must both be applied; (b) quantitative and directional inference: the student must read the fortyfold urinary versus eightfold tissue contrast and project the trajectory forward under continued intake. |

**Correct answer (A): Y dissolves preferentially into hydrophobic depots and evades renal removal, so sustained overconsumption will drive progressive buildup toward toxicity.**

Citations: BIO:6874-6876 (fat-soluble vitamins A, D, E, and K readily pass through plasma membranes and lipid-soluble compounds gain easy entry into cells and tissues); BIO:45191-45193 (fat-soluble vitamins are absorbed the same way lipids are, while water-soluble vitamins are absorbed directly into the bloodstream); BIO:44658 (dietary fat is required to absorb fat-soluble vitamins)

**Distractors**

- **(B)** `misconception`: Complete catabolism is refuted by the data themselves: an eightfold rise in liver and adipose content is a reservoir, and the empty urine reflects blocked excretion, not destruction.
  - Citation: BIO:6874-6876
- **(C)** `reversed_relationship`: Inverts partitioning behavior; a lipid-favoring molecule resists equilibration with aqueous compartments, so the depot releases its load slowly rather than washing out in days.
  - Citation: BIO:6874-6876
- **(D)** `scale_unit_error`: Divides an excretion ratio by a storage ratio from two different subjects and compounds, manufacturing a meaningless rate; the fortyfold number measures urinary loss of X, not fat deposition.
  - Citation: BIO:45191-45193

**Readback check.** Key content words of six or more letters are dissolves, preferentially, hydrophobic, depots, evades, removal, sustained, overconsumption, progressive, buildup, and toxicity; none appears in the stem, which uses urinary, adipose, and detection instead of renal, depots, or excretion terms.

**Explanation (as shipped).**

> This Lipids question tests the partitioning consequence of fat solubility: lipid-soluble micronutrients distribute into hydrophobic tissue compartments rather than leaving the body in urine, so chronic excess builds up. The answer is A because the two disposal patterns in the data track solubility exactly as partitioning predicts. The water-soluble compound X stays near baseline in plasma while its urinary level climbs fortyfold, meaning the kidneys clear the surplus about as fast as it arrives; an overdose of X is simply flushed out in the aqueous waste stream. The lipid-soluble compound Y shows the mirror image: essentially nothing appears in urine, and the surplus instead piles up eightfold in liver and adipose tissue, the body's hydrophobic storage sites. Renal filtration hands water-soluble solutes to an aqueous exit route that is effectively closed to a molecule that partitions into lipid phases, so Y has no efficient way out, and every additional week of overdosing enlarges a growing reservoir. This is precisely why chronic excess of fat-soluble vitamins produces hypervitaminosis while comparable excess of water-soluble vitamins rarely does. (Choice B) claims complete degradation with no reservoir, a misconception directly contradicted by the measured eightfold rise in liver and adipose stores; absence from urine reflects failure to excrete, not successful destruction. (Choice C) reverses the partitioning logic: a molecule that favors lipid phases does not equilibrate freely with body water, so the depot drains slowly over weeks to months after dosing stops, not within days. (Choice D) commits a scale and unit error by dividing a urinary excretion ratio for one compound by a tissue storage ratio for a different compound; the two numbers describe different processes measured in different people and cannot be combined into any deposition rate, and the data show X does not deposit in fat at all. This is a Data-based and Statistical Reasoning question because it requires comparing paired plasma, tissue, and urinary measurements across two compounds and inferring from those numbers which disposal route each solubility class follows and what continued excess intake will therefore produce.

---

