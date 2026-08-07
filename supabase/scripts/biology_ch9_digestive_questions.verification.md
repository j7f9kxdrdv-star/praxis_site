# Biology Ch9: The Digestive System . Verification Report

**Batch 1 of 3: 25 questions (mouth to stomach).**
Chapter target is **75 questions**, deliberately below the usual 100. Reference texts:
`openstax-anatomy-physiology-2e.txt` (AP:) and `openstax-biology-2e.txt` (BIO:).
Scope authority: `aamc-content-outline-2026.txt`. Step 1 pre-flight record:
`biology_ch9_digestive_questions.plan.md`.
All questions: Foundation 3B . content category "Organ Systems" . discipline biology.

## Why 75

This is the most heavily raided chapter in the bank. A cross-subject scope check plus a boundary
audit against every live question found that most of the chemistry of digestion already belongs
elsewhere: fat digestion, bile, emulsification, micelles, pancreatic lipase and chylomicrons to
Biochem Ch11; the zymogen cascade to Biochem Ch11 and Ch2; enzyme activity versus pH to Biochem Ch2;
glycosidic hydrolysis and disaccharide composition to Biochem Ch4; glycogen and gluconeogenesis to
Biochem Ch10 and Ch12; autonomic control of motility to Bio Ch4; smooth muscle to Bio Ch11; portal
anatomy and lacteal routing to Bio Ch7; insulin, glucagon, ADH and aldosterone to Bio Ch5; gut flora
as innate defence to Bio Ch8; acid-base computation to GenChem Ch10.

Written naively this is a 110-concept chapter. After the audit it supports 75 genuinely distinct
answer-turning points, with a 5-item reserve so the verify pass can swap an item out rather than
invent one. Bio Ch6 Respiratory was forced to 100 against a real density of 85 to 90 and returned
about 30 percent redundant, because each deduplication round in a saturated space spawns new
collisions. Bio Ch8 Immune was sized honestly at 90 and landed exactly on target with no redundancy.

## What this chapter owns instead

The organ story rather than the chemistry: gut hormones, the enteric nervous system, motility and
sphincter mechanics, absorption transport mechanisms, gastric cell types, the exocrine pancreas, the
downstream biliary and bilirubin story, and colonic water handling with gut flora treated as a
metabolic organ.

## Batch 1 summary

| Metric | Result | Target |
|---|---|---|
| Difficulty | easy 7 . hard 8 . medium 10 | easy 7 . hard 8 . medium 10 |
| Answer letter | A 6 . B 6 . C 7 . D 6 | A 6 . B 6 . C 7 . D 6 |
| Cognitive skill | S1 4 . S2 13 . S3 3 . S4 5 | S1 4 . S2 13 . S3 3 . S4 5 |
| Confidence | conf4 5 . conf5 20 | only 4-5 ship |
| Roman numeral | 3 | 3 |
| Distractor categories | adjacent_fact 12 . misconception 23 . partial_truth 15 . process_step_confusion 10 . reversed_relationship 12 . scale_unit_error 3 | none dominant |
| Em/en dashes | 0 | 0 |
| Source citations in shipped explanations | 0 | 0 |

**Every quota landed exactly.** Per-slice targets were summed against the batch target before launch,
and the batch target was summed against the 75-question chapter target before that.

**Boundary scan:** an automated pass checked every key and stem against 17 forbidden territories.
One flag was raised and cleared by hand: Q10's stem states that bile salt and vitamin B12 recovery at
the far end of the small intestine are normal. That is a CONTROL, present to eliminate an
ileal-resection explanation, and the key turns on two-way flow at the ileocaecal junction. Using a
neighbouring chapter's content as scenery that rules out a competing answer is exactly the intended
pattern; only a key that turned on it would be a violation.

**Readback defence:** this chapter is dense with named anatomy, so both drafters and auditors were
told explicitly to hunt label-lookup items ("which cell secretes X") disguised as reasoning. No
question in this batch is a label lookup.

**Adversarial audit:** all 25 re-examined by an independent pass per slice that re-greped every
citation against OpenStax Anatomy and Physiology 2e and OpenStax Biology 2e.

---

## Q1 . Intracellular versus luminal digestion

**Stem.** A small freshwater invertebrate finishes digesting its meal only after individual cells have engulfed food fragments. A physiologist argues that no animal the size of a human could be fed by this arrangement. Which feature of the human alimentary canal removes that limitation?

- **A.** Chemical processing is carried to completion in a lumen open to the outside, so the epithelium needs only to take up single small molecules rather than particles of food.  <- **KEY**
- **B.** Each absorptive cell of the human tract carries far more lysosomes, letting one cell degrade a proportionally larger share of a meal once it has been taken in.
- **C.** The human tract is open at both ends rather than at one, so incoming material and waste residue never have to travel in the same direction.
- **D.** The absorptive cells of the human tract are replaced every few days, so they can internalize material far faster than the invertebrate cells manage.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic secondary / structural direct) |
| Estimated time | 65 s |
| Confidence | 5 |

**Correct answer (A): Chemical processing is carried to completion in a lumen open to the outside, so the epithelium needs only to take up single small molecules rather than particles of food.**

Citations: BIO:34612, BIO:44234, BIO:44239, AP:47086, AP:47409

**Distractors**

- **(B)** `process_step_confusion` . _more of the same organelle solves a size problem_: Confuses the limiting step: the strategy fails at getting bulk food across a single cell membrane, not at degrading it once it is already inside.
  - Citation: BIO:44239
- **(C)** `adjacent_fact` . _true anatomical fact offered as a causal explanation_: True of the human canal and useful for one way flow, but unrelated to why cell level digestion cannot scale to a large body.
  - Citation: BIO:44234
- **(D)** `misconception` . _fast turnover equals fast uptake_: Epithelial turnover repairs wear and does not increase the size of a particle a cell can internalize.
  - Citation: AP:47409

**Readback check.** Key content words of six or more letters: Chemical, processing, carried, completion, outside, epithelium, single, molecules, rather, particles. Stem words of six or more letters: freshwater, invertebrate, finishes, digesting, individual, engulfed, fragments, physiologist, argues, animal, alimentary, feature, removes, limitation, arrangement. No overlap; the stem never names the lumen, secretion, completion of breakdown, or absorption, so the key cannot be produced by restating the stem. Not a label lookup: no choice asks which cell or organ secretes a named substance.

**Explanation (as shipped).**

> This item falls under Organ Systems and tests the contrast between finishing a meal inside a cell and finishing it in a space that is continuous with the environment. The answer is A because a human carries chemical breakdown all the way to absorbable units inside a channel whose contents remain topologically outside the body, so the lining is never asked to swallow a piece of food. In the invertebrate arrangement, whatever the secreted enzymes fail to finish must still be brought bodily into a single cell, which caps the size of the largest fragment the animal can use and ties total throughput to the number of cells doing that swallowing. A human instead releases a small volume of concentrated catalyst from a few accessory organs into a long channel, where it acts on the whole meal at once, and the epithelium then moves only single small molecules across itself. That is precisely what makes bulk feeding on large items workable for a large animal. (Choice B) Lysosome number is not the bottleneck. A cell packed with them still has to get the food across its own membrane first, and that is the step that fails for a mouthful of steak, so multiplying the internal degrading machinery does not rescue the strategy. (Choice C) A tract open at both ends is genuinely a human feature and it does permit one way flow and regional specialization, but an animal could have two openings and still leave the final breakdown to its lining cells, so this does not address the size limitation being asked about. (Choice D) Rapid turnover of the lining is true of the human gut, yet a faster replacement schedule does not change how large a piece of food a cell can bring in, and turnover exists to repair wear rather than to feed the animal. This is a Knowledge of Scientific Concepts and Principles question because it asks the student to recall the defining difference between the two digestive strategies and apply it to why body size forces a large animal into one of them.

---

## Q2 . Physical breakup versus bond cleavage

**Stem.** A person's stomach generates only weak churning waves, so a protein rich meal is pushed onward as intact lumps rather than as a fine suspension. Secretion volumes and enzyme concentrations along the whole tract are normal, and transit time is unchanged. What is the most likely consequence for this meal?

- **A.** No change occurs, because the identity of the final products is fixed by which enzymes are present rather than by how the food is handled physically.
- **B.** The meal is left essentially untouched, since it is the pounding of the food that severs the links joining one amino acid to the next.
- **C.** Only a trivial fraction of the meal is processed, because a lump shields its own interior for the whole of its passage down the tract.
- **D.** A larger share of the meal is still unhydrolyzed when it reaches the colon, because catalysts can act only at the exposed boundary of each lump within the time available.  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 100 s |
| Confidence | 5 |
| Hard-tier gate | (a) combines mechanical processing with the fixed residence time of the gut; (b) requires a directional inference about extent of reaction rather than a lookup; (c) choices A and C both stay defensible until the student separates product identity from reaction extent and recognizes that lumps erode progressively. |

**Correct answer (D): A larger share of the meal is still unhydrolyzed when it reaches the colon, because catalysts can act only at the exposed boundary of each lump within the time available.**

Citations: AP:47409, AP:47417, AP:48236, AP:48520

**Distractors**

- **(A)** `partial_truth` . _final products identical therefore outcome identical_: Correct that physical handling never changes which products form, but incomplete because it ignores how much forms within a fixed transit window.
  - Citation: AP:47409
- **(B)** `misconception` . _chewing breaks chemical bonds_: Attributes covalent bond cleavage to mechanical force; grinding changes particle size and mobility only.
  - Citation: AP:47409
- **(C)** `scale_unit_error` . _treating a food mass as impenetrable_: Right mechanism at the wrong magnitude: boundaries are progressively stripped and lumps shrink during passage, so the shortfall is partial, not near total.
  - Citation: AP:47417

**Readback check.** Key content words of six or more letters: larger, unhydrolyzed, reaches, because, catalysts, exposed, boundary, available. Stem words of six or more letters: person, stomach, generates, churning, protein, pushed, onward, intact, rather, suspension, Secretion, volumes, enzyme, concentrations, normal, transit, unchanged, likely, consequence. No overlap; the stem says enzyme while the key says catalysts, and the stem states no outcome, so the key requires a prediction rather than a restatement. Option lengths are matched so the key is not the longest choice.

**Explanation (as shipped).**

> This item falls under Organ Systems and tests why physical breakup of food, which creates no new products of its own, still determines how much chemical breakdown gets finished. The answer is D because catalysts reach only the outer boundary of a solid mass, and the gut allows a fixed window of time before material is passed onward. Grinding and churning cut nothing chemically, so on their own they yield nothing absorbable and the meal would leave the body much as it entered. What they do accomplish is to convert one large mass into many small ones, multiplying the amount of food that lies at a boundary a catalyst can reach at any instant. Because residence time downstream is set by motility and not by how coarse the meal is, a fixed clock is running: whatever is not reached before the window closes moves on unhydrolyzed. Weak churning therefore does not change what the products would be, it changes how much of the meal ever becomes product. (Choice A) This is right about product identity, since no physical step alters which bonds an enzyme cleaves, but it wrongly treats the extent of reaction within a limited time as if it were guaranteed. Rate matters here precisely because transit time is stated to be fixed. (Choice B) This reverses the roles of the two kinds of processing. Physical handling changes size and position only, while the covalent links joining amino acids are broken by catalysts, so a meal delivered in lumps is still worked on, just less completely. (Choice C) The right mechanism is taken to the wrong magnitude. A lump does not shield its interior for the whole passage: its outer layer is steadily stripped away, fluid soaks in, and the mass shrinks as it travels, so a substantial fraction is still handled and the deficit is partial rather than near total. This is a Scientific Reasoning and Problem Solving question because it asks the student to hold enzyme supply and transit time constant and predict how a change in particle size alone shifts the completeness of digestion.

---

## Q3 . Consequence of staggered first attack

**Stem.** A child produces thick secretions that plug the duct delivering pancreatic juice into the small intestine, while salivary and gastric secretions are normal in volume and composition. Stool testing shows a large unabsorbed residue. Which dietary class contributes most of that residue, and for what reason?

- **A.** Carbohydrate, because the mouth supplies only a token amount of amylase and every later step depends entirely on the plugged duct.
- **B.** Protein, because the stomach contributes only mixing and acidification, leaving all chain shortening to the secretion that is now blocked.
- **C.** Fat, because essentially no cleaving of it had begun anywhere upstream, whereas the other two classes were each already worked on earlier along the route.  <- **KEY**
- **D.** Carbohydrate and protein together, because fat is already dealt with by enzymes that are released before the meal ever reaches the stomach.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 90 s |
| Confidence | 5 |

**Correct answer (C): Fat, because essentially no cleaving of it had begun anywhere upstream, whereas the other two classes were each already worked on earlier along the route.**

Citations: AP:49213, AP:47658, AP:48261, AP:49182, AP:48501

**Distractors**

- **(A)** `partial_truth` . _largest contributor mistaken for only contributor_: Correct that pancreatic amylase does the bulk of the starch work, but incomplete because starch also has an oral start and a brush border finish, so it is not the most stranded class.
  - Citation: AP:47658
- **(B)** `misconception` . _all protein digestion happens in the small intestine_: Denies gastric protein digestion, which the stem preserves; acid and pepsin shorten polypeptide chains in the stomach.
  - Citation: AP:49182
- **(D)** `reversed_relationship` . _early and late nutrient classes exchanged_: Swaps the classes: fat is the one with essentially no early processing, while carbohydrate is the one attacked before swallowing.
  - Citation: AP:49213

**Readback check.** Key content words of six or more letters: essentially, cleaving, anywhere, upstream, whereas, classes, already, worked, earlier. Stem words of six or more letters: produces, secretions, delivering, pancreatic, intestine, salivary, gastric, normal, volume, composition, testing, unabsorbed, residue, dietary, contributes, reason. No overlap; the stem never names fat, starch, protein, or any enzyme, so the key cannot be recognized by matching a word. The vignette supplies the blocked duct and the preserved secretions, so no prior knowledge of any named disease is required.

**Explanation (as shipped).**

> This item falls under Organ Systems and tests the consequence of the fact that the three dietary classes are first attacked at different points along the tract. The answer is C because triglycerides are the one class with no meaningful head start, so losing the pancreatic contribution leaves them with almost nothing else. Starch meets amylase in the mouth and keeps being worked on in the upper stomach until acid mixes through, and the brush border of the intestinal lining finishes disaccharides on its own. Polypeptides meet acid and pepsin in the stomach, so a good deal of chain shortening has already happened before the duct is reached, and brush border peptidases contribute as well. Triglycerides have neither advantage: the lipases available before the duodenum are quantitatively trivial, and the pancreas is effectively the only source that matters. When a single supply line carries the sole significant catalyst for one class and merely the largest share for the other two, that one class is the one that ends up in the stool. (Choice A) This is genuinely partly right, since pancreatic amylase does most of the starch work, but it overlooks that starch has two other routes, an early one in the mouth and a final one at the lining itself, so it is not the class left most stranded. (Choice B) This ignores what the stomach actually does. Acid and pepsin begin shortening polypeptide chains well before the blocked duct is reached, and the stem explicitly preserves gastric secretion, so protein is not the class without upstream processing. (Choice D) This reverses the actual sequence. Nothing of consequence acts on fat before the stomach, while carbohydrate is the class that does receive attention in the mouth, so the choice swaps which class enjoys the early head start. This is a Scientific Reasoning and Problem Solving question because it asks the student to combine where each class is first attacked with the loss of one secretion and infer which class suffers the largest deficit.

---

## Q4 . Quantitative distribution of digestive work

**Stem.** The table gives the percentage of each ingested foodstuff that has been reduced to absorbable units at three points along the gut of a healthy volunteer. Of the three, only starch meets a catalyst before the meal is swallowed.

| Sampling point | Starch | Protein | Triglyceride |
| --- | --- | --- | --- |
| Leaving the stomach | 30 | 15 | 8 |
| Mid small intestine | 92 | 84 | 90 |
| Entering the large intestine | 99 | 96 | 98 |

Which conclusion do these data support?

- **A.** Protein handling is essentially finished before the material enters the small intestine.
- **B.** Where a class is first attacked is a poor guide to where most of its breakdown actually gets done.  <- **KEY**
- **C.** Fat relies on the stomach more heavily than the other two classes do, since its value there is the lowest of the three.
- **D.** Starch is handled about twice as fast as protein everywhere in the tract, matching the ratio of the two at the first sampling point.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 105 s |
| Confidence | 5 |

**Correct answer (B): Where a class is first attacked is a poor guide to where most of its breakdown actually gets done.**

Citations: AP:48501, AP:49213, AP:47658, AP:49182

**Distractors**

- **(A)** `misconception` . _stomach does the protein job_: Treats fifteen percent as completion and ignores the sixty nine point gain recorded in the next segment.
  - Citation: AP:49182
- **(C)** `reversed_relationship` . _low value misread as high reliance_: Reads the lowest gastric value as heavy dependence on the stomach when it indicates the opposite.
  - Citation: AP:49213
- **(D)** `scale_unit_error` . _single ratio generalized into a constant rate_: Extends a ratio measured at one point into a rate across the whole tract, which the narrowing gap in the later rows contradicts.
  - Citation: AP:48501

**Readback check.** Key content words of six or more letters: attacked, breakdown, actually. Stem words of six or more letters: percentage, ingested, foodstuff, reduced, absorbable, points, healthy, volunteer, starch, catalyst, before, swallowed, Sampling, stomach, Protein, Triglyceride, intestine, conclusion, support. No overlap; the key is not any value in the table and requires comparing row to row gains, so it cannot be read off directly. The key is also not the longest option.

**Explanation (as shipped).**

> This item falls under Organ Systems and tests whether a student can separate the sequence in which foodstuffs are first attacked from the quantitative distribution of digestive work. The answer is B because starch, the only one of the three with a head start, still gains sixty nine of its ninety nine percentage points after the material has left the stomach. Reading down each column shows the same pattern for all three: single digit to low double digit values at the first sampling point, then values in the eighties and nineties one step later. The entire gain between the first and second rows belongs to the segment beyond the stomach, which means the great majority of the work happens in one place regardless of where a given foodstuff was first touched. Starch is the informative case, since the intuition that an early start implies most of the job is done early is exactly what its numbers contradict. The third row adds only a few more points for each, so even the later gut contributes little by comparison. (Choice A) Fifteen percent is not a finished job. This choice reads the first row as if it were an endpoint and ignores that protein climbs another sixty nine points in the very next segment, so it misjudges the magnitude of what the stomach accomplished. (Choice C) This inverts the relationship the numbers show. The lowest value at the stomach means fat gained the least there and therefore depends on the stomach least, not most, so the choice reads a small contribution as evidence of a large dependence. (Choice D) A two to one ratio at a single sampling point says nothing about relative rates elsewhere, and the two columns close from eight points apart at the middle sample to three points apart at the last, so a fixed speed ratio across the whole tract is not supported. This is a Data-based and Statistical Reasoning question because it asks the student to compare gains between successive rows rather than read single values, and to test a stated expectation about starch's head start against what the columns actually show.

---

## Q5 . Segmentation versus propulsive intestinal motility

**Stem.** A drug given to an anaesthetised animal abolishes the localised ring contractions that repeatedly divide and recombine the contents of the small intestine, while the slowly propagating waves that sweep along the same segment continue unchanged. Food residue reaches the large bowel considerably sooner than in untreated animals. Which further consequence is most likely?

- **A.** Enzymes released into the lumen lose their activity, because their release depends on those ring contractions.
- **B.** Less carbohydrate and protein crosses the lining, because chyme meets the secretions and the exchange surface less thoroughly and for less time.  <- **KEY**
- **C.** The stomach empties more slowly, because a receiving segment that cannot stir its load cannot accept a new one.
- **D.** Uptake of sugars and amino acids rises, because the contents now pass a greater length of wall each minute.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 85 s |
| Confidence | 5 |

**Correct answer (B): Less carbohydrate and protein crosses the lining, because chyme meets the secretions and the exchange surface less thoroughly and for less time.**

Citations: AP:47419, AP:47420, AP:48468, AP:48473

**Distractors**

- **(A)** `misconception` . _enzyme function wrongly made dependent on motility_: Students often assume luminal enzymes require mechanical agitation to be released or to remain active. Secretion and catalysis proceed independently of whether the contents are being shuttled back and forth, so abolishing the ring contractions cannot inactivate them.
  - Citation: AP:48473
- **(C)** `process_step_confusion` . _regulation assigned to the wrong step_: This attributes control of gastric delivery to the wrong stage. Delivery rate is governed by how loaded the receiving segment already is, not by whether that segment is stirring, and faster clearance would ease rather than tighten the brake.
  - Citation: AP:48194
- **(D)** `reversed_relationship` . _transit speed inverted against uptake_: It relates the right variables in the wrong direction: faster passage past more wall per minute shortens contact time at every point, which reduces rather than increases the fraction taken up.
  - Citation: AP:48473

**Readback check.** Content words of six or more letters in key B: carbohydrate, protein, crosses, lining, because, secretions, exchange, surface, thoroughly. None of these appears in the stem. The stem's distinctive words (anaesthetised, abolishes, localised, contractions, repeatedly, recombine, contents, intestine, propagating, segment, unchanged, residue, considerably, untreated, consequence) do not appear in the key. No stem phrase can be copied to produce B; the student must infer that loss of in place mixing costs both contact time and dispersal.

**Explanation (as shipped).**

> This item falls under Organ Systems and tests how two different contraction patterns of the small intestine contribute separately to nutrient uptake and to transit. The answer is B because a wall that can still propagate waves but can no longer shuttle its load back and forth delivers residue onward faster and stirs it far less, and both changes cut the amount of nutrient that gets across the lining. Uptake depends on two things the drug has removed: repeated mechanical contact between the load and the surface that takes up the products of digestion, and thorough dispersal of that load through the fluid released into the lumen. Localised ring contractions do not work by pushing material along; they isolate short pockets, squeeze them, then let them merge again, which is why a marker in that part of the tract barely advances even while contractions are vigorous. Propagating waves do the opposite, displacing the load but presenting each portion to a given stretch of wall only briefly. Deleting the first pattern while keeping the second converts a slow, well stirred exchange surface into a fast, poorly stirred conduit.
>
> (Choice A) Activity of the secreted enzymes does not depend on wall movement. They are released and act on whatever they encounter whether or not the load is being agitated, so nothing here inactivates them.
>
> (Choice C) The rate at which the stomach delivers its load onward is set by feedback from material that has already reached the receiving segment, chiefly how much is sitting there and what it contains. That feedback slows delivery when the segment is full, and this drug empties the segment faster, so if anything the brake is applied less rather than more.
>
> (Choice D) This has the relationship backwards. Passing more wall per minute means less time in contact with any of it, and shorter contact lowers rather than raises the fraction taken up.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to predict the absorptive cost of selectively deleting one of two motility patterns while the other is left intact.

---

## Q6 . Oesophageal transport independent of gravity

**Stem.** A volunteer hangs head down on an inversion table and swallows a barium bolus. Fluoroscopy shows the barium arriving in the stomach about eight seconds later, essentially the same interval recorded in that volunteer sitting upright. Which feature of the oesophageal wall accounts for this result?

- **A.** Reduced pressure inside the chest during the swallow draws the swallowed material along.
- **B.** Mucus lubrication lets the swallowed material slide along the wall against very little resistance.
- **C.** The whole length of the muscular wall shortens at the same moment, squeezing the swallowed material toward the far end.
- **D.** A ring of constriction forms behind the swallowed material and travels along at a set rate, mechanically displacing whatever lies ahead of it.  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 65 s |
| Confidence | 5 |

**Correct answer (D): A ring of constriction forms behind the swallowed material and travels along at a set rate, mechanically displacing whatever lies ahead of it.**

Citations: AP:47399, AP:47401, AP:47402, AP:47957

**Distractors**

- **(A)** `misconception` . _passive pressure gradient substituted for active propulsion_: A widely held but false belief that thoracic suction pulls swallowed loads downward. No such column exists during a swallow, and a pressure driven pull would not be orientation independent in any case.
  - Citation: AP:47401
- **(B)** `partial_truth` . _true accessory feature offered as the driving cause_: Lubrication genuinely occurs and genuinely reduces friction, but it only removes an obstacle to movement; it supplies no directed force, so it cannot explain movement upward against weight.
  - Citation: AP:47960
- **(C)** `process_step_confusion` . _correct machinery, sequence collapsed into simultaneity_: It keeps the right tissue and the right kind of contraction but collapses the sequence into one simultaneous event. Without a constriction that starts behind the load and then travels, the load is squeezed equally toward both ends and no direction is imposed.
  - Citation: AP:47957

**Readback check.** Content words of six or more letters in key D: constriction, behind, swallowed, material, travels, mechanically, displacing, whatever. Of these only swallowed and material recur from the stem, and both appear in all four choices as shared setup vocabulary rather than as a marker of the key. The stem's distinctive words (volunteer, inversion, barium, Fluoroscopy, arriving, stomach, seconds, essentially, interval, recorded, upright, oesophageal) are absent from the key. The result cannot be read off the stem: the observation given is a timing, the key is a mechanism.

**Explanation (as shipped).**

> This item falls under Organ Systems and tests the mechanism by which the oesophagus moves a swallowed load. The answer is D because an unchanged transit interval in an inverted subject can only hold if the force doing the work is generated by the wall and aimed along the tube, rather than supplied by weight. As the swallow starts, circular muscle just behind the load shortens and pinches the lumen shut, while the wall immediately ahead relaxes and widens to receive it. That closed ring then advances at its own pace, and since the lumen behind it is sealed, the load has nowhere to go but forward. Direction is therefore set by the order in which successive parts of the wall shorten, not by which way is down, so a subject who is inverted, flat or weightless moves the load at close to the same speed. The eight second figure is a property of the travelling ring, not of falling.
>
> (Choice A) Pressure inside the chest does fall during inspiration, but a swallow does not create a suction column that drags a load the whole length of the tube, and any such column would still depend on how the body is oriented.
>
> (Choice B) Lubrication is real and it does lower friction, but lowering resistance is not the same as supplying directed force. A slippery tube with no travelling ring would let an inverted load sit still or drift the wrong way.
>
> (Choice C) A squeeze applied everywhere at once raises pressure equally at both ends of the load and so pushes it in no particular direction. Direction comes from the constriction arising behind the load and then moving, which is exactly the feature this choice deletes by collapsing the sequence into a single simultaneous event.
>
> This is a Knowledge of Scientific Concepts and Principles question because it asks the student to identify the wall mechanism that makes transport through the oesophagus independent of body orientation.

---

## Q7 . Wall layer depth and lost function

**Stem.** An ischaemic injury destroys a complete ring of the jejunal wall and replaces it with inert fibrous tissue. The damage runs from the lumen outward and stops exactly at the outer border of the submucosa, leaving every layer external to that border structurally normal. Which of the following would be lost at that ring?
I. Release of mucus onto the surface facing the lumen
II. Uptake of sugars and amino acids out of the lumen
III. Circumferential narrowing that drives contents toward the colon

- **A.** I only
- **B.** III only
- **C.** I and II only  <- **KEY**
- **D.** I, II and III

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic secondary / structural multi_step) |
| Estimated time | 100 s |
| Confidence | 4 |
| Hard-tier gate | (a) combines wall layering with the separate functions of secretion, uptake and propulsion; (c) choices A and D each stay defensible until the student fixes where the muscle coats sit relative to the stated outer edge of the damage; (d) inverts the usual direction by giving the injury and asking which functions are consequently lost. |

**Correct answer (C): I and II only**

Citations: AP:47099, AP:47115, AP:47132, AP:47138

**Distractors**

- **(A)** `partial_truth` . _half the correct set selected_: Correct that mucus release is lost, but incomplete: the same destroyed sleeve carries the uptake surface, so limiting the loss to item I understates it and changes the answer.
  - Citation: AP:47115
- **(B)** `reversed_relationship` . _layer functions swapped inside out_: It reverses the mapping of layers onto functions, crediting the destroyed inner sleeves with the propulsive squeeze and the spared outer coats with secretion and uptake. The circumferential narrowing arises in the muscle coats external to the stated boundary and therefore survives.
  - Citation: AP:47138
- **(D)** `scale_unit_error` . _partial thickness injury generalised to transmural_: Applies otherwise sound reasoning at the wrong spatial extent, treating a lesion whose outer edge is explicitly fixed at one depth as though the full wall thickness had been destroyed.
  - Citation: AP:47157

**Readback check.** The key is the label string I and II only and contains no content words at all, so no six letter word can be shared with the stem. The stem states a lesion depth and never states what any layer does, so no listed function can be copied out of it. The student must supply the concentric ordering of the wall and then decide which listed functions lie inside and outside the damaged zone.

**Explanation (as shipped).**

> This item falls under Organ Systems and tests how deep a lesion must reach before propulsion itself fails. The answer is C because the destroyed zone takes in the innermost lining and the connective tissue plate beneath it but stops short of the muscle coats, so the secretory and absorptive work of that ring is gone while its ability to squeeze survives. The tube is built as concentric sleeves. The innermost sleeve carries the epithelium facing the lumen, which both releases mucus and provides the surface across which digested products enter. Immediately outside it lies a dense connective tissue plate carrying vessels and nerves. Outside that sit the muscle coats, whose circumferential shortening narrows the bore and drives the load onward. Converting the two inner sleeves to scar therefore silences items I and II. Item III would fail only if the injury reached the muscle coats, and the stem fixes the outer edge of the damage short of them, so the scarred ring is still squeezed on schedule and the segment stays passable even though nothing crosses it.
>
> (Choice A) Naming only the loss of mucus release is right as far as it goes and then stops halfway. The very sleeve that releases mucus also carries the surface through which sugars and amino acids enter, so the two functions are destroyed together and cannot be separated by this lesion.
>
> (Choice B) This swaps the jobs of the sleeves. It credits the destroyed inner layers with generating the squeeze, when the circumferential narrowing that moves the load is produced further out in the wall, in the part the described injury spares, and it leaves secretion and uptake to coats that do neither.
>
> (Choice D) This treats damage confined to one depth as if it compromised the entire thickness. The stem pins the outer edge of the injury, and functions belonging to layers beyond that edge continue, so scaling the loss up to the whole wall overshoots the level of organisation actually affected.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to map a stated lesion depth onto the specific functions that do and do not survive it.

---

## Q8 . Testing intramural signalling in isolated gut

**Stem.** A 10 cm length of small intestine is excised, flushed clean and suspended in a warmed, oxygenated bath with no remaining attachment to any other tissue. A balloon in the middle of the segment is inflated to a fixed volume. Transducers 3 cm oral and 3 cm aboral to the balloon record a contraction on the oral side and a relaxation on the aboral side, both beginning within a second of inflation. The investigator concludes that the signal coordinating this response is carried within the wall of the segment itself. Which manipulation would test that conclusion most directly?

- **A.** Cut the wall through its full thickness between the balloon and one transducer, repeat the inflation, and compare that side's response with the response on the uncut side.  <- **KEY**
- **B.** Move the balloon to the oral end of the segment and record from the aboral transducer alone, then compare with the original recording.
- **C.** Replace the bath fluid with a solution of identical osmolarity but no glucose, then repeat the inflation.
- **D.** Inflate the balloon to a series of progressively larger volumes and show that both responses grow as volume grows.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **medium** (topic secondary / structural two_step) |
| Estimated time | 95 s |
| Confidence | 5 |

**Correct answer (A): Cut the wall through its full thickness between the balloon and one transducer, repeat the inflation, and compare that side's response with the response on the uncut side.**

Citations: AP:47172, AP:47420, AP:48473

**Distractors**

- **(B)** `process_step_confusion` . _wrong variable manipulated in an otherwise sensible design_: Alters the stimulus location instead of the tissue lying between stimulus and recording site, and discards the two sided comparison, so the step manipulated is not the step under test.
  - Citation: AP:47399
- **(C)** `adjacent_fact` . _viability control offered as a mechanism test_: A true and reasonable viability check, but irrelevant to the question asked. Loss of response after substrate removal is uninformative about the route the signal followed.
  - Citation: AP:47420
- **(D)** `misconception` . _dose response mistaken for evidence of a pathway_: Assumes that a graded stimulus response relationship demonstrates conduction. Both competing accounts predict graded responses, so the observation cannot separate them.
  - Citation: AP:47172

**Readback check.** Content words of six or more letters in key A: through, thickness, between, balloon, transducer, inflation, compare, response, uncut. Only balloon, transducer and inflation recur from the stem, and each also appears in the distractors, so they are shared apparatus vocabulary rather than a marker pointing at the key. The stem never mentions cutting, interruption or a control comparison, so the key cannot be produced by restating the setup; the student must construct the discriminating manipulation.

**Explanation (as shipped).**

> This item falls under Organ Systems and tests how to isolate the route by which a coordinating signal travels in an isolated length of gut. The answer is A because the claim on trial is a claim about a route, and a route is tested by interrupting it at a defined point and asking whether the response beyond the interruption disappears while the response on the other side survives. Since nothing is attached to the specimen, any contribution from outside it is already excluded, so two accounts remain: something spreads through the wall from the stimulated point to sites on either side, or each recording site is activated on its own without anything passing between them. A cut through the full thickness of the wall between balloon and transducer severs every route running within the wall across that line, while leaving living, contractile tissue on both sides of the cut. If the response beyond the cut disappears while the response on the intact side is unchanged at the same inflation volume, then continuity of the wall between stimulus and recording site is necessary for the response, which is exactly what the conclusion asserts. The uncut side, tested in the same bath at the same moment, is a control built into the preparation, so a lost response cannot be dismissed as the specimen simply dying during the experiment.
>
> (Choice B) Relocating the stimulus and dropping one recording site changes where the stimulus is applied rather than what lies between stimulus and response, and it throws away the two sided comparison that gives the design its discriminating power.
>
> (Choice C) Removing a metabolic substrate probes whether the tissue remains viable. Viability matters, but a response that fails under those conditions would say nothing about which route the signal took to reach either transducer.
>
> (Choice D) Showing that larger inflations produce larger responses characterises how the stimulus is graded. Grading of that kind is equally expected whether something spreads through the wall or each site is activated independently, so the result cannot discriminate between the two accounts.
>
> This is a Reasoning about the Design and Execution of Research question because it asks the student to select the interruption and the internal control that together distinguish a signal conducted through the wall from independent local responses.

---

## Q9 . Reflux at the oesophagogastric junction

**Stem.** A patient reports burning chest discomfort that appears only while lying flat after a large meal and fades within a minute or two of sitting upright. Endoscopy shows a slack muscular ring at the junction, an eroded lining just above it, and a completely healthy lining below it. What accounts for the injury falling where it does?

- **A.** Lying down removes the downward pull of gravity, so swallowed food itself abrades the upper tube.
- **B.** Pressure inside the chest exceeds that in the belly when a person lies flat, so the gradient across the ring points downward and drags at the tube above it.
- **C.** A full abdomen sits at higher pressure than the chest, so contents travel backward through the lax ring into a tube that is not adapted to hold them.  <- **KEY**
- **D.** Enzymes made by the pancreas reach the upper tube and dissolve its surface.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic core / structural two_step) |
| Estimated time | 70 s |
| Confidence | 5 |

**Correct answer (C): A full abdomen sits at higher pressure than the chest, so contents travel backward through the lax ring into a tube that is not adapted to hold them.**

Citations: AP:47872; AP:47874; AP:47876; AP:47878

**Distractors**

- **(A)** `misconception`: Treats the injury as mechanical abrasion by food rather than chemical exposure from retrograde flow, and cannot explain why the lining below the ring is spared.
  - Citation: AP:47876
- **(B)** `reversed_relationship`: States the pressure gradient in the wrong direction; the abdominal compartment sits at the higher pressure, which is why a seal is needed there at all, and a downward gradient could not injure the tissue above the ring.
  - Citation: AP:47874
- **(D)** `adjacent_fact`: Pancreatic secretion is real but is delivered well downstream of the stomach and cannot reach the tube above it, so it explains neither the site nor the posture dependence.
  - Citation: AP:48320

**Readback check.** Content words of six or more letters in key C: abdomen, higher, pressure, contents, travel, backward, through, adapted. Stem words of six or more letters: patient, reports, burning, discomfort, appears, within, minute, sitting, upright, Endoscopy, muscular, junction, eroded, lining, completely, healthy, accounts, injury, falling. No overlap, so the key cannot be produced by copying a phrase from the stem. The stem never states a pressure relationship or a direction of flow; those must be supplied by the student. No banned pattern applies: this is not a label lookup, not a definition restatement, not a longest-option giveaway, not a stem-vocabulary echo, and not a question whose answer is visible in the numbers given.

**Explanation (as shipped).**

> Organ Systems, and specifically the ring that guards the top of the stomach and the direction in which material crosses it. The answer is C because a filled belly sits at a higher pressure than the chest cavity, and once the ring stops sealing, that difference drives gastric contents upward into a stretch of tube that is not built to hold them. Posture is the clue. Standing puts the chest above the belly and adds gravity to the forces keeping material down, so symptoms ease within a minute or two of sitting up. Lying flat removes that help, and a large meal raises the load in the abdomen further, so the moment the ring goes slack the gradient runs the wrong way and material crosses it. The damage sits on one side of the ring for the same reason: acid stays where it was made unless something pushes it, and only the tissue on the receiving end of that push meets something it never normally encounters. Nothing about the gastric lining itself has changed in this patient, which is why the picture below the ring is unremarkable.
>
> (Choice A) Removing the pull of gravity does not turn food into an abrasive. Solid material moves down the tube in seconds under the muscular wave, whether the person is upright or flat, and mechanical scraping would not produce a burning symptom that tracks meal size and posture so closely.
>
> (Choice B) This reverses the gradient. The chest cavity sits at a lower pressure than the abdomen through most of the breathing cycle, which is exactly why a competent ring is needed at all, and a downward gradient would move material away from the inflamed area rather than onto it.
>
> (Choice D) Pancreatic secretions are delivered into the segment just beyond the stomach, several stages away from the inflamed area, and they would have to cross two separate one way gates to arrive here. Their presence explains neither the posture dependence nor the sharp boundary between damaged and undamaged lining.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to take a postural pattern and a sharply bounded area of damage and work backward to the direction in which material must have been moving.

---

## Q10 . One way flow into the large intestine

**Stem.** An operation for a growth in the wall of the large intestine left the ring guarding its junction with the small intestine permanently open, although no length of small intestine was taken out and biopsy of the remaining bowel is normal. Over the following months the patient loses weight steadily and passes frequent watery stools. Output of digestive enzymes and of bile is measured as normal, and recovery of bile salts and of vitamin B12 at the far end of the small intestine is also normal. Which consequence of the open junction best explains these findings?

- **A.** Flow becomes two way, so residue moves on before the surface above has finished taking up nutrients, and colonic contents can wash back into a segment built for uptake.  <- **KEY**
- **B.** The large intestine can no longer reclaim water once the ring is held open, so fluid loss by itself accounts for both problems.
- **C.** Residue simply moves onward faster, and the only result is a larger fluid load arriving downstream.
- **D.** Returning contents reach the first stretch of small intestine, so it is the very beginning of that organ that is flooded and put out of action.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 85 s |
| Confidence | 4 |

**Correct answer (A): Flow becomes two way, so residue moves on before the surface above has finished taking up nutrients, and colonic contents can wash back into a segment built for uptake.**

Citations: AP:48344; AP:48492; AP:48496; AP:48560; AP:48712

**Distractors**

- **(B)** `misconception`: The large intestine retains its water reclaiming capacity; the problem is the volume and speed of delivery, and this option cannot account for progressive weight loss.
  - Citation: AP:48560
- **(C)** `partial_truth`: Correct that transit accelerates, but incomplete: it omits both the shortened absorptive contact time that drives weight loss and the loss of one way flow.
  - Citation: AP:48712
- **(D)** `process_step_confusion`: Names the wrong stage of the small intestine; the junction that has been left open sits at its far end, so backflow reaches the last stretch rather than the first.
  - Citation: AP:48344

**Readback check.** Content words of six or more letters in key A: becomes, residue, before, surface, finished, taking, nutrients, colonic, contents, segment, uptake. Stem words of six or more letters: operation, growth, intestine, guarding, junction, permanently, although, length, remaining, biopsy, normal, following, months, patient, steadily, passes, frequent, watery, stools, Output, digestive, enzymes, measured, recovery, vitamin, consequence, explains, findings. No overlap. The stem states findings only and never names a direction of flow, a contact time, or an absorptive consequence, so the key requires inference rather than recall or echo. Not a label lookup: no structure has to be named, only a functional consequence derived.

**Explanation (as shipped).**

> Organ Systems, tested here through the one way gate that separates the last stretch of small intestine from the large intestine. The answer is A because that gate does two jobs at once, holding residue back until the length above has finished taking up what it can, and preventing already processed material from returning into a region whose business is uptake rather than storage. Hold it permanently open and both jobs fail together. Material now crosses whenever a wave arrives, so contact time between residue and the absorptive surface falls, which is enough on its own to explain steady weight loss in a person whose enzyme and bile output is normal. At the same time nothing resists movement in the opposite direction, so watery material from downstream washes back into a region not built to hold it, adding to the fluid that eventually leaves the body. The stem deliberately closes off the competing explanations: chemical digestion is intact, no absorptive length was sacrificed, the lining itself is normal, and the specialised uptake that happens at the far end of the small intestine still works. What has been lost is control over timing and direction.
>
> (Choice B) The large intestine keeps its capacity to reclaim water after this operation. What changes is how fast material arrives and how much of it there is, so the load can exceed what the tissue can handle even though the tissue works normally. This choice also leaves the weight loss entirely unexplained.
>
> (Choice C) Faster onward movement is genuinely part of the story, but stopping there misses the consequence that matters most for body weight. A shorter dwell time above the junction means nutrients that would have been taken up are carried away instead, and the choice also ignores the loss of one way flow in the other direction.
>
> (Choice D) Backflow through an open junction reaches the last stretch of small intestine, not the first, because the junction sits at the far end of that organ. Naming the wrong end also gives the wrong prediction, since a region several metres upstream is untouched by anything crossing that gate.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to predict, from the loss of a single gate, two separate physiological consequences and then match them against a described clinical picture.

---

## Q11 . Voluntary and reflex control of evacuation

**Stem.** A spinal injury spares the sensory pathways and the local reflex circuits of the lower cord but abolishes every descending command to the striated muscle of the pelvic floor. The patient still feels the rectum filling. What follows when a mass movement delivers material into the rectum?

- **A.** Nothing is released, because both rings open only on a command from the brain.
- **B.** Wall stretch alone relaxes the inner ring, and the outer ring cannot be kept shut by choice, so contents pass involuntarily.  <- **KEY**
- **C.** The inner ring tightens as the wall distends, so material is retained until a deliberate effort opens the outer ring.
- **D.** The outer ring relaxes first and the inner one then closes, pushing material back up into the colon.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 80 s |
| Confidence | 5 |

**Correct answer (B): Wall stretch alone relaxes the inner ring, and the outer ring cannot be kept shut by choice, so contents pass involuntarily.**

Citations: AP:48631; AP:48632; AP:48749; AP:48750; AP:48752

**Distractors**

- **(A)** `misconception`: Assumes conscious control over both rings; the inner ring is smooth muscle that relaxes on a circuit within the cord with no command from the brain.
  - Citation: AP:48631
- **(C)** `reversed_relationship`: Reverses the response to distension: filling relaxes rather than tightens the inner ring, which is the origin of the urge itself.
  - Citation: AP:48750
- **(D)** `process_step_confusion`: Swaps the two steps of the reflex, which relaxes the inner ring while briefly tightening the outer one, and invents retrograde movement that does not occur.
  - Citation: AP:48750

**Readback check.** Content words of six or more letters in key B: stretch, relaxes, cannot, contents, involuntarily. Stem words of six or more letters: spinal, injury, spares, sensory, pathways, reflex, circuits, abolishes, descending, command, striated, muscle, pelvic, floor, patient, rectum, filling, follows, movement, delivers, material. No overlap; the words reflex, muscle and material were deliberately kept out of the key. The stem never states which ring is voluntary, so the student must supply that split. Not a label lookup: neither ring is named anatomically anywhere in the item, so no structure can be recalled by name.

**Explanation (as shipped).**

> Organ Systems, and the unusual case of a gate built from two rings under two different kinds of control. The answer is B because the inner ring answers only to the state of the wall around it and yields once the chamber fills, while the outer ring is the part a person consciously keeps closed, and that is precisely what this patient has lost. The normal sequence runs like this. Filling distends the wall, a circuit in the cord relaxes the inner ring and at the same moment briefly tightens the outer one, and the person then feels the urge and decides. Holding on beyond those first few seconds is an active choice made moment by moment with striated muscle. If the moment is inconvenient the walls relax to accommodate more, the urge fades, and the next mass movement raises the question again. Strip out the descending pathway and only the automatic half of the system survives. The brief guarding contraction still occurs, because the circuit that produces it lies below the injury, but nothing can sustain it once it fades, and the inner ring has already opened. Sensation is intact, so the patient knows what is happening, but knowing is not the same as being able to act on it.
>
> (Choice A) If a conscious command were required to open either ring, an intact person would never be caught out by an urgent one, and infants, who have no such control at all, could not empty. The inner ring is the involuntary half of the pair and needs no instruction from above.
>
> (Choice C) This inverts the response to filling. Distension relaxes the inner ring rather than tightening it, which is why an urge appears at all, and the outer ring is the structure a person opens deliberately rather than the one that yields last.
>
> (Choice D) The two steps are the wrong way round. The automatic response opens the inner ring while briefly tightening the outer one, which is what buys time for a decision, and it does not drive material backward against the wave that delivered it.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to separate the automatic and the deliberate halves of one control system and predict what survives when only the deliberate half is removed.

---

## Q12 . Meal composition and emptying rate

**Stem.** Four 500 mL test meals were given to healthy volunteers on separate days, and the time for half the meal to leave the stomach was recorded. Meals 2, 3 and 4 were matched at 250 kcal.

| Test meal | Composition | Half emptying time (min) |
| --- | --- | --- |
| 1 | water only | 12 |
| 2 | carbohydrate | 46 |
| 3 | protein | 58 |
| 4 | fat | 104 |

A second group of volunteers had earlier undergone surgery that left the stomach outlet permanently wide open, and each meal was repeated in that group. In the second group, for which meal would the rate at which contents reach the duodenum be expected to rise the most?

- **A.** Meal 1
- **B.** Meal 2
- **C.** Meal 3
- **D.** Meal 4  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 110 s |
| Confidence | 4 |
| Hard-tier gate | Hard tier, three conditions met. (a) It combines composition dependent feedback control of emptying with the consequence of losing that control. (b) It requires a quantitative comparison across four values, converting times into relative rates, plus a directional inference about which rises most. (c) Meals 2 and 3 stay defensible until the student applies the specific idea that the largest normal restraint leaves the largest possible gain. |

**Correct answer (D): Meal 4**

Citations: AP:48244; AP:48245; AP:48254; AP:48275; AP:48276

**Distractors**

- **(A)** `misconception`: Treats the fastest emptying meal as the one most affected, when a meal already leaving in twelve minutes has essentially no restraint left to remove.
  - Citation: AP:48245
- **(B)** `partial_truth`: Correctly recognises that meals carrying nutrients are slowed, but stops before comparing how much each class of nutrient slows emptying.
  - Citation: AP:48275
- **(C)** `partial_truth`: Identifies a genuinely restrained meal, yet its 58 minute value is only about half the 104 minute fat meal, so the largest rise in delivery rate does not occur here.
  - Citation: AP:48276

**Readback check.** The key is a meal label, so no content word can be copied from the stem into it. The stem supplies four half emptying times but never ranks restraint, never states that composition rather than volume or energy sets the rate, and never says what happens when the outlet is left open. The value 104 is the largest in the table, but the question does not ask for the slowest meal; it asks which rate of delivery rises most once the brake is gone, which requires reading a long half time as evidence of strong restraint and then inverting each time into a rate. Not a label lookup and not a definition restatement.

**Explanation (as shipped).**

> Organ Systems, examined through measurements of how quickly the stomach hands material on. The answer is D because the table shows that the brake on emptying is set by what is being delivered rather than by how much: all four meals were the same 500 mL, meals 2, 3 and 4 carried the same 250 kcal, and yet the fat meal was held back more than eight times longer than plain water and nearly twice as long as the protein meal matched to it for both volume and energy. An outlet held permanently open cannot apply a brake, so the meal whose delivery rate rises most is the one that was normally restrained most. Since rate of delivery runs inversely to half emptying time, the size of the gain for each meal is roughly its half time divided by the twelve minutes water takes. Water is already close to the fastest anything can leave, so opening the outlet buys almost nothing there. Carbohydrate at 46 minutes and protein at 58 minutes sit in the middle, gaining roughly fourfold and fivefold. Fat at 104 minutes owes almost all of its transit time to restraint, so its delivery rate rises by close to ninefold, the widest margin in the set, and it is also the meal most likely to arrive downstream faster than the next segment can handle it.
>
> (Choice A) Reading the table as a ranking of speed and assuming the quickest meal is the most affected gets the logic backwards. A meal that already leaves in twelve minutes has almost no held back fraction left to release, so the surgical change has its smallest effect here.
>
> (Choice B) The carbohydrate meal is genuinely restrained and its delivery would accelerate, but it is not the extreme case. Choosing it means noticing that meals carrying nutrients are slowed without going on to ask which class of nutrient slows them most.
>
> (Choice C) The protein meal is the closest competitor and stays defensible until the numbers are compared directly. At 58 minutes it is held back rather more than carbohydrate but only about half as long as the 104 minute fat meal, so the largest change does not appear here.
>
> This is a Data-based and Statistical Reasoning question because it asks the student to convert four half emptying times into relative rates of delivery and infer which meal gains most once the step that restrains delivery is removed.

---

## Q13 . Gastric proton pump energetics and blockade

**Stem.** An experimental compound concentrates inside the acidic secretory canaliculi of gastric gland cells, where it covalently locks the transporter that exchanges luminal potassium for cytoplasmic hydrogen ions. Twelve hours after a single dose, the fluid in the gastric lumen sits near pH 6 instead of its usual value below 2. Which of the following would be expected in this person?

I. The rate at which the affected cells hydrolyse ATP falls.
II. The bicarbonate output of the exocrine pancreas after the next meal falls.
III. Uptake of vitamin B12 at the terminal ileum stops within the same twelve hours.

- **A.** I only
- **B.** II only
- **C.** I and II only  <- **KEY**
- **D.** I, II, and III

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 105 s |
| Confidence | 5 |
| Hard-tier gate | (a) combines pump energetics with duodenal hormonal signalling and with the independence of intrinsic factor secretion; (b) requires directional inference about ATP turnover and about bicarbonate output rather than a lookup; (c) choices A and B each remain defensible until the student applies a specific discriminating fact about the other item; (d) inverts the usual direction by supplying a drug outcome and demanding the cellular and systemic causes. |

**Correct answer (C): I and II only**

Citations: AP:48056; AP:48060; AP:48953; AP:49441; BIO:7268; BIO:7273

**Distractors**

- **(A)** `partial_truth` . _correct-but-incomplete Roman numeral set_: Item I is genuinely true, but selecting it alone treats acid purely as a local digestive agent and misses that acid arriving in the duodenum is the stimulus for secretin and therefore for pancreatic bicarbonate release.
  - Citation: AP:48953
- **(B)** `partial_truth` . _correct-but-incomplete Roman numeral set_: Item II is genuinely true, but selecting it alone ignores that the blocked transporter was the cell's dominant consumer of ATP, so its inhibition must lower the cell's rate of ATP hydrolysis.
  - Citation: BIO:7273
- **(D)** `misconception` . _acid blockade equated with loss of all parietal cell output_: Item III is false. The glycoprotein that escorts vitamin B12 to the terminal ileum is secreted by the same cells but by a route independent of the ion exchanger, so an acute block of proton export does not stop B12 uptake within hours.
  - Citation: AP:49441

**Readback check.** Key text is 'I and II only', which contains no content word of six or more letters, so the key string itself cannot echo the stem. The judgement bearing content words of six or more letters inside the two true items are: hydrolyse, affected (item I) and bicarbonate, output, exocrine, pancreas (item II). Stem content words of six or more letters are: experimental, compound, concentrates, inside, acidic, secretory, canaliculi, gastric, covalently, transporter, exchanges, luminal, potassium, cytoplasmic, hydrogen, Twelve, single, instead, expected, person. None of the six judgement bearing words appears in the stem. Each item also requires an inference the stem never states: that the pump is ATP driven, that luminal acid triggers secretin release, and that intrinsic factor secretion is independent of the exchanger.

**Explanation (as shipped).**

> Organ Systems, tested here through the energy cost of gastric acid secretion and the events downstream of it. The answer is C because items I and II both follow from silencing an ATP consuming transporter whose product doubles as a signal to the small intestine, while item III does not follow. The cytoplasm of the secreting cell sits close to neutrality, whereas the fluid it delivers into the lumen is normally more than a hundred thousand fold richer in hydrogen ions, and no gradient already present in that cell is steep enough to pay for a climb of that size, so the transporter must couple ion movement directly to ATP hydrolysis rather than ride on an existing sodium or potassium gradient. Locking the transporter shut therefore retires a large and continuous ATP demand, and the rate at which those cells consume ATP falls, which is item I. Item II runs through a separate chain: the arrival of strongly acidic chyme in the first segment of the small intestine is the stimulus that releases secretin, and secretin is what instructs the pancreatic duct cells to deliver bicarbonate rich juice. With luminal contents sitting near pH 6, that stimulus is weak, so the pancreatic bicarbonate response to the next meal is blunted. Item III fails because the glycoprotein escort that vitamin B12 needs in order to be taken up at the terminal ileum is a separate secretory product of the same cells, released by exocytosis rather than by the blocked exchanger, so B12 handling does not halt within hours.
> (Choice A) Item I alone is correct but incomplete. Stopping there treats luminal acid as a purely local digestive agent and misses that the same acid is the trigger for the pancreatic bicarbonate response.
> (Choice B) Item II alone is likewise correct but incomplete, and it ignores the metabolic consequence of removing the dominant ATP sink from a highly specialised secretory cell.
> (Choice D) Adding item III reflects the common belief that any agent shutting off acid abolishes B12 uptake at once. Deficiency can develop slowly for other reasons over long periods, but an acute block of the exchanger does not stop the glycoprotein from being secreted, so uptake does not stop in twelve hours.
> This is a Scientific Reasoning and Problem Solving question because it asks the student to trace one molecular blockade outward into a metabolic consequence, a hormonal consequence, and a consequence that does not occur.

---

## Q14 . Alkaline tide and secretory stoichiometry

**Stem.** During a meal, blood leaving the stomach is transiently less acidic than the blood arriving in it, and the effect peaks while gastric acid output is maximal. Giving an inhibitor of the enzyme that hydrates carbon dioxide abolishes both the shift in the draining blood and most of the acid output. What do these paired observations indicate about how the secreting cells operate?

- **A.** Each hydrogen ion sent into the lumen is generated inside the cell together with one base equivalent, which is then handed to the bloodstream.  <- **KEY**
- **B.** The cells strip acid out of arriving blood and concentrate it in the lumen, leaving the departing blood depleted of it.
- **C.** Base released by the exocrine pancreas enters the bloodstream and lowers the acidity of blood draining neighbouring organs.
- **D.** Perfusion slows during secretion, so carbon dioxide builds up in the wall and its accumulation raises the pH of the departing blood.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic secondary / structural two_step) |
| Estimated time | 85 s |
| Confidence | 4 |

**Correct answer (A): Each hydrogen ion sent into the lumen is generated inside the cell together with one base equivalent, which is then handed to the bloodstream.**

Citations: AP:48056; AP:48959; AP:48960; BIO:7273

**Distractors**

- **(B)** `misconception` . _secretion as extraction from plasma_: Students commonly assume secreted acid is scavenged from the blood supply, but the enzyme inhibition result shows the acid is synthesised inside the cell, and scavenging would remove acid from blood without adding any base to it.
  - Citation: AP:48960
- **(C)** `adjacent_fact` . _correct physiology of the wrong organ_: It is true that the exocrine pancreas handles bicarbonate, but it sends that bicarbonate into its duct and leaves its own venous blood more acidic, so it cannot account for a change measured in blood draining the stomach.
  - Citation: AP:48959
- **(D)** `reversed_relationship` . _carbon dioxide accumulation given the wrong pH sign_: It relates the right variables in the wrong direction: retained carbon dioxide would acidify the draining blood rather than alkalinise it, and gastric perfusion increases during active secretion.
  - Citation: AP:48960

**Readback check.** Key content words of six or more letters: hydrogen, generated, inside, together, equivalent, handed, bloodstream. Stem content words of six or more letters: During, leaving, stomach, transiently, acidic, arriving, effect, gastric, output, maximal, Giving, inhibitor, enzyme, hydrates, carbon, dioxide, abolishes, draining, paired, observations, indicate, secreting, operate. There is no overlap between the two lists. The words bicarbonate, chloride and carbonic anhydrase appear only in the explanation and never in the stem, so the key cannot be produced by matching a distinctive stem word, and the key requires an inference about stoichiometry that the stem never states.

**Explanation (as shipped).**

> Organ Systems, examined through the transport stoichiometry that makes blood leaving an actively secreting stomach transiently alkaline. The answer is A because acid and base are manufactured together in one intracellular reaction, so every unit of acid exported to the lumen obliges the cell to unload a matching unit of base on its other face. Carbonic anhydrase inside the secreting cell joins water to carbon dioxide, and the product immediately yields a hydrogen ion and a bicarbonate ion. The hydrogen ion is the species driven into the lumen, while the bicarbonate has nowhere to go except across the opposite face of the cell into the interstitium and then the vein, typically traded there for a chloride ion that follows the hydrogen ion into the lumen as the counterion of the secreted acid. Because both ions arise from a single reaction, their quantities are matched one for one, which is exactly why the alkalinity of the draining blood tracks the rate of secretion in real time and vanishes when the enzyme is blocked. The pairing of the two observations also settles the mechanistic question: the acid is built on site inside the cell, not harvested from the blood supply.
> (Choice B) This is the intuitive picture, that a secreting organ pulls its product out of the circulation, but the second observation contradicts it. If acid were simply being extracted from plasma, blocking an intracellular synthetic enzyme would not abolish secretion, and the departing blood would be expected to lose acid without gaining any base.
> (Choice C) The exocrine pancreas does release bicarbonate, but into its duct and therefore into the intestinal lumen, and its own venous blood is left more acidic rather than less. It is a true statement about a different organ that cannot explain a change measured in blood leaving the stomach while the stomach is secreting.
> (Choice D) This reverses the direction of the relationship. Carbon dioxide accumulating in a tissue would make the blood draining it more acidic, not less, and perfusion of the gastric wall rises rather than falls when secretion is active.
> This is a Scientific Reasoning and Problem Solving question because it asks the student to combine the timing of the venous change with the consequence of removing one enzyme and infer the fixed one to one coupling that must link acid export to base release.

---

## Q15 . Limits of gastric absorption

**Stem.** A fasted volunteer swallows a modest dose of ethanol along with a starch meal. Ethanol is detectable in the blood within minutes, long before the pyloric sphincter has released any of the meal onward. Which feature of ethanol accounts for its arrival that early?

- **A.** It is cleaved by acid into fragments that carrier proteins in the lining recognise and import.
- **B.** It is small and uncharged, so it slips across the epithelium by simple diffusion without needing a carrier.  <- **KEY**
- **C.** It is reclaimed alongside water by the same route that recovers fluid from residue later in the tract.
- **D.** It dissolves into the mucous coat and departs in the lymphatic vessels of the wall.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 65 s |
| Confidence | 5 |

**Correct answer (B): It is small and uncharged, so it slips across the epithelium by simple diffusion without needing a carrier.**

Citations: AP:47992; AP:48233; AP:48694; AP:49387; BIO:6873

**Distractors**

- **(A)** `process_step_confusion` . _digestion step inserted before a passive uptake_: It applies the macronutrient sequence of chemical breakdown followed by carrier mediated uptake to a molecule that requires no breakdown, inserting a digestion step that does not exist for ethanol and that would slow rather than speed its arrival.
  - Citation: AP:48233
- **(C)** `adjacent_fact` . _true mechanism from the wrong segment_: Bulk water recovery from residue is a genuine process but it occurs far downstream and over a timescale of many hours, so it cannot explain detection in blood within minutes of swallowing.
  - Citation: AP:48694
- **(D)** `misconception` . _lymph routing overgeneralised to any absorbed substance_: Lymphatic departure applies to the large lipid particles packaged inside intestinal cells, which are too big for blood capillaries; a small water miscible molecule enters the capillary blood of the stomach wall directly.
  - Citation: AP:49387

**Readback check.** Key content words of six or more letters: uncharged, across, epithelium, simple, diffusion, without, needing, carrier. Stem content words of six or more letters: fasted, volunteer, swallows, modest, ethanol, starch, Ethanol, detectable, within, minutes, before, pyloric, sphincter, released, onward, feature, accounts, arrival. There is no overlap. The earlier draft used the phrase 'a small dose', which created a surface echo with the key word small; the stem now reads 'a modest dose' so no shared wording remains. The stem states only an observation about timing and never states any physical property of ethanol, so the key cannot be lifted from it.

**Explanation (as shipped).**

> Organ Systems, tested through the limits of what the stomach can and cannot take up. The answer is B because a small, electrically neutral, lipid soluble molecule dissolves straight through membranes on its own, and passage of that kind needs none of the protein machinery this part of the tract lacks. A sac that holds a meal for hours is built to contain a harsh fluid rather than to harvest from it. Its surface is coated in thick mucus, it is folded into ridges rather than fringed with the fine projections that multiply surface area further along, and it carries very few of the sugar, amino acid and short peptide carriers that make the next segment genuinely absorptive. Nutrients also arrive as polymers and are only partly broken down at this stage, so there would be little for a carrier to move even if one were present. Ethanol bypasses all of that because it partitions readily into membrane lipid and crosses passively down its own gradient, which is why a drink taken on an empty stomach registers so quickly, and why aspirin swallowed by mouth also begins to reach the blood before the stomach has emptied.
> (Choice A) Ethanol is not a substrate for digestion. There are no bonds in it for acid or an enzyme to break, and manufacturing fragments for a carrier would be a slower route than the direct one rather than a faster one, so this transplants the macronutrient sequence onto a small solvent molecule.
> (Choice C) Bulk recovery of water from residue is a real process, but it happens far downstream and over many hours, once most of the fluid load has already been taken up, so it cannot explain an appearance in blood within minutes of swallowing.
> (Choice D) Lymphatic routing is reserved for the large lipid particles assembled inside intestinal cells, which are too bulky to enter blood capillaries. A small water miscible molecule has no need of that pathway and enters the capillary blood of the stomach wall directly.
> This is a Knowledge of Scientific Concepts and Principles question because it asks the student to apply the general requirements for crossing an epithelium to one specific molecule at one specific site and to recognise why that site is otherwise a poor absorber.

---

## Q16 . Gastric mucosal barrier: acid load versus mucosal defense

**Stem.** A woman with arthritis takes a daily tablet that blocks synthesis of a local lipid messenger, one that normally drives the stomach lining to release alkali and a thick glycoprotein gel. After eight weeks she has shallow gastric erosions, yet her acid output after a test meal is identical to her pre-treatment value, and the erosions heal when a drug that shuts down the parietal cell proton pump is added while she keeps taking the tablet. What do these findings indicate about the origin of the erosions?

- **A.** Ordinary quantities of acid became injurious once the covering that keeps the cell surface near neutral pH stopped being renewed.  <- **KEY**
- **B.** The tablet must be pushing acid secretion above its usual level, since blocking that secretion allowed healing.
- **C.** The tablet injures the wall directly as each dose dissolves against it, independently of what the cavity contains.
- **D.** Release of the alkali and the gel is itself driven by acid arriving at the wall, so with acid output unchanged that layer cannot have been what changed.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 105 s |
| Confidence | 5 |
| Hard-tier gate | (a) combines two concepts, drug suppression of mucosal secretion and the acid load versus defense balance; (c) choices B and C stay defensible until the unchanged test meal output and the continued dosing during healing are applied; (d) inverts the usual direction, giving the outcome and asking for the cause. |

**Correct answer (A): Ordinary quantities of acid became injurious once the covering that keeps the cell surface near neutral pH stopped being renewed.**

Citations: AP:48203, AP:48219, AP:7242

**Distractors**

- **(B)** `misconception` . _treatment response mistaken for cause_: Rests on the common belief that an erosion proves acid oversecretion; the measured test meal output was unchanged, and response to a pump blocker shows only that lowering acid compensates for weak defense.
  - Citation: AP:48219
- **(C)** `partial_truth` . _true accessory mechanism promoted to sole cause_: Direct contact irritation is a real accessory mechanism, but it is independent of the acid load in the cavity, so it cannot explain healing that occurs while the tablet is still being taken.
  - Citation: AP:48220
- **(D)** `reversed_relationship` . _direction of control between defense and acid inverted_: Inverts the direction of control given in the stem by making acid the driver of the protective secretion; the stem states that the blocked messenger drives release of the gel and its alkali, so the layer fails even though acid output is flat.
  - Citation: AP:48204

**Readback check.** Key A content words of six or more letters: Ordinary, quantities, injurious, covering, surface, neutral, stopped, renewed. Stem content words of six or more letters: arthritis, tablet, blocks, synthesis, messenger, normally, drives, stomach, lining, release, alkali, glycoprotein, shallow, gastric, erosions, output, identical, treatment, parietal, proton, taking, findings, indicate, origin. No overlap, so no stem echo. The key cannot be produced by copying stem language: the stem reports an unchanged acid output and a treatment response, and the student must infer that an ordinary acid load turned damaging because the protective layer was no longer maintained.

**Explanation (as shipped).**

> This Organ Systems item examines the gastric mucosal barrier and how erosions appear when that barrier is undermined. The answer is A because damage developed while the amount of acid delivered to the cavity was unchanged, so the injury must reflect a defense that stopped being replenished rather than an oversupply of hydrogen ions. The wall is shielded by a viscous cover that holds base released by the epithelium against the cell surface, and that trapped base keeps the pH immediately at the cells far higher than the pH a fraction of a millimeter away. The tablet removes the signal that drives production of both the cover and the base held inside it, so the standing pH difference across it collapses and hydrogen ions that used to be neutralized in transit now arrive at living cells intact. The test meal figure fixes the direction of the reasoning: secretion never rose, so the variable that moved was on the protective side of the balance. Healing on a pump blocker fits the same picture, because dropping delivery below the usual amount compensates for a defense that can no longer handle even a usual amount.
>
> (Choice B) Blocking secretion relieves the lesion, but relief on treatment does not establish that secretion had been abnormal to begin with, and the test meal result rules that possibility out directly.
>
> (Choice C) Local contact injury from a dissolving dose is real for some agents, yet contact alone would not be undone by lowering the hydrogen ion load in the cavity, and it cannot explain a lesion that heals while the same dose continues.
>
> (Choice D) This reverses the control described in the stem: the tablet acts on the signal that drives release of the alkali and the gel, so that layer fails whether or not acid output moves, and an unchanged acid figure therefore says nothing about whether the layer was maintained.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to work backwards from a lesion that appeared with no change in secretory output and identify failure of mucosal protection, rather than excess secretion, as its origin.

---

## Q17 . Epithelial renewal as a component of gastric protection

**Stem.** A patient receives an intravenous agent that prevents cells from completing mitosis. Within a week the stomach lining shows scattered shallow erosions where the layer of cells facing the cavity is missing. Measurements made across that week show that acid output and the volume and alkali content of the secreted gel are unchanged from the values recorded before treatment, and the agent itself is not detectable in the stomach cavity. Which explanation best accounts for the erosions?

- **A.** Output of the alkaline gel fell first, so hydrogen ions reached living cells before any cells were lost.
- **B.** Cells that divide in the gastric glands are the source of the inactive form of the stomach's protein cutting enzyme, so losing them left the meal undigested and abrasive against the wall.
- **C.** The agent is corrosive on contact with the lining, which is why the loss is confined to the innermost cells.
- **D.** The surface population is worn away and replaced every few days from a dividing layer deeper in the gland, and that replacement has now stopped.  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic secondary / structural direct) |
| Estimated time | 75 s |
| Confidence | 5 |

**Correct answer (D): The surface population is worn away and replaced every few days from a dividing layer deeper in the gland, and that replacement has now stopped.**

Citations: AP:48206, AP:48207, AP:48203

**Distractors**

- **(A)** `process_step_confusion` . _barrier failure assigned to the wrong protective arm_: Places the failure at the secretion step when the stem measured that step and found it unchanged, so it reorders the sequence of events rather than following the data given.
  - Citation: AP:48203
- **(B)** `adjacent_fact` . _real cell population given the wrong secretory product_: Pairs a real cell population with the wrong product: the inactive protein cutting enzyme comes from a separate secretory cell type, not from the renewing population, and undigested food does not erode the lining.
  - Citation: AP:48063
- **(C)** `misconception` . _systemic drug effect attributed to local contact_: Attributes a systemic drug effect to local contact even though the agent was infused into a vein and the stem states it is not detectable in the cavity.
  - Citation: AP:48220

**Readback check.** Key D content words of six or more letters: surface, population, replaced, dividing, deeper, gland, replacement, stopped. Stem content words of six or more letters: patient, intravenous, prevents, completing, mitosis, stomach, lining, scattered, shallow, erosions, facing, cavity, missing, Measurements, across, output, volume, alkali, content, secreted, unchanged, values, recorded, before, treatment, agent, itself, detectable, explanation, accounts, erosions. No overlap, so no stem echo. The stem never states what maintains the layer facing the cavity; the student must connect a block on cell division to the loss of a surface that is normally restocked from below.

**Explanation (as shipped).**

> This Organ Systems item examines the part of gastric protection that depends on continuous replacement of the lining rather than on anything secreted. The answer is D because the stem removes one process only, the ability of cells to divide, and shows by direct measurement that the secretory arm of protection is untouched, which leaves loss of replacement as the only available route to a bare surface. The cells facing the cavity are constantly worn away and are normally restocked from a dividing layer deeper in the gland, so the whole surface is turned over in a matter of days. Stop the restocking and the loss continues at its usual rate with nothing arriving to fill the gaps, so within days there are patches where nothing living stands between ordinary gastric contents and the tissue beneath. Acid still does the eroding, but the reason it can is that the covering of living cells is no longer being rebuilt. The timing fits as well: this population turns over faster than almost any other in the body, so a block on cell division shows itself here within a week rather than over months.
>
> (Choice A) The stem states that the volume and alkali content of the gel were unchanged, so the secreted layer is not the arm of protection that failed here.
>
> (Choice B) The inactive form of the stomach's protein cutting enzyme comes from a distinct secretory population deeper in the gland, not from the cells that renew the surface, and undigested food is not what produces these lesions.
>
> (Choice C) The agent was given into a vein and is not detectable in the cavity, so a direct chemical attack on the lining from the cavity side is excluded by the stem.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to eliminate the secretory arm of gastric protection using the measurements supplied and attribute the lesions to a halt in epithelial replacement.

---

## Q18 . A second parietal cell product and the site of B12 uptake

**Stem.** Vitamin B12 uptake was measured in four adults. Each swallowed a fixed dose of the pure vitamin dissolved in water, and the percentage taken up into blood was determined. The measurement was then repeated with the same dose swallowed together with an extract of healthy human gastric juice from which the acid had been removed. Peak acid output was measured separately.

| Subject | Peak acid output (mmol/h) | B12 taken up, dose alone (%) | B12 taken up, dose plus extract (%) |
|---|---|---|---|
| Healthy control | 23 | 62 | 63 |
| Six months on a proton pump blocker | 2 | 55 | 57 |
| Selective destruction of the acid secreting cells | 1 | 6 | 58 |
| Final 60 cm of small intestine surgically removed | 22 | 4 | 5 |

What do the data indicate about why uptake fails in the third subject?

- **A.** The collapse in hydrogen ion output is itself what stops the vitamin from being taken up.
- **B.** The absorbing lining of the last stretch of small intestine has been destroyed in that subject as well.
- **C.** The lost cell population also supplies a carrier that B12 must travel with, and the absorbing surface itself is still functional.  <- **KEY**
- **D.** The carrier comes from the absorbing lining and the stomach is where B12 crosses into blood, so the third and fourth subjects have the same defect at different sites.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 105 s |
| Confidence | 5 |

**Correct answer (C): The lost cell population also supplies a carrier that B12 must travel with, and the absorbing surface itself is still functional.**

Citations: AP:48058, AP:48061, AP:48269

**Distractors**

- **(A)** `misconception` . _acid assumed to be the only relevant gastric product_: Treats loss of acid as the cause of failed uptake; the drug row shows acid output of 2 against a control of 23 with uptake still at 55 percent, so acid loss alone does not produce the deficit.
  - Citation: AP:48058
- **(B)** `adjacent_fact` . _finding true of one row transplanted onto another_: True of the fourth subject but not the third: the rescue from 6 percent to 58 percent with the extract shows the absorbing surface in the third subject is present and working.
  - Citation: AP:48269
- **(D)** `reversed_relationship` . _source of carrier and site of uptake interchanged_: Reverses which site supplies the carrier and which site does the absorbing; if the carrier came from the downstream lining, an extract of gastric juice could not have rescued the third subject and the fourth would have responded to it.
  - Citation: AP:48061

**Readback check.** Key C content words of six or more letters: population, supplies, carrier, travel, absorbing, surface, itself, functional. Stem and table content words of six or more letters: Vitamin, uptake, measured, adults, swallowed, dissolved, percentage, determined, measurement, repeated, together, extract, healthy, gastric, juice, removed, output, Subject, Healthy, control, months, proton, blocker, Selective, destruction, secreting, intestine, surgically, indicate, subject. No overlap, so no stem echo. The key is not a value read off the table: no row names a carrier or a secretory product, and the student must combine the rescue of the third subject by the acid free extract with the drug row and the resection row to conclude that the destroyed population supplies a non acid component required upstream of an intact absorbing surface.

**Explanation (as shipped).**

> This Organ Systems item uses paired uptake measurements to separate the acid producing job of a gastric cell population from a second product of those same cells. The answer is C because the subject whose acid secreting cells were destroyed takes up almost nothing from a dose given alone, 6 percent against 62 percent in the control, yet reaches 58 percent when the same dose is swallowed with an extract of normal gastric juice that has had its acid removed. Something in that extract, and not the acid, is what was missing. The row for the drug settles the alternative: acid output there is 2 against 23 in the control, a near total loss, and uptake is still 55 percent, so removing acid by itself does not block uptake. The final row shows the opposite pattern, acid output normal at 22 but uptake stuck at 4 percent alone and 5 percent with the extract, which is the signature of a lost absorbing surface that no added material can rescue. Reading the three rows against the control, the destroyed population must release something besides acid that B12 has to be bound to, and in the third subject the downstream surface that does the absorbing is intact and simply has nothing arriving in usable form.
>
> (Choice A) The drug row rules this out: hydrogen ion output there is essentially gone, 2 against 23, yet 55 percent of the dose is still taken up, so a collapse in acid output is not on its own enough to stop uptake.
>
> (Choice B) Destruction of the absorbing lining is what the fourth subject shows, where the extract changes nothing; for the third subject it is refuted by the rescue to 58 percent, because a missing absorptive surface cannot be restored by adding material to a swallowed dose.
>
> (Choice D) This swaps the two roles. If the carrier came from the downstream lining, adding an extract of gastric juice could not have rescued the third subject, and the fourth subject would have been the one rescued by it.
>
> This is a Data-based and Statistical Reasoning question because it requires comparing three affected rows against a control across two uptake columns to decide, for each one, whether the deficit lies in a missing secreted component or in the absorbing surface itself.

---

## Q19 . Gastric reservoir capacity and meal size

**Stem.** In one operation for gastric cancer the stomach is removed and a narrow loop of jejunum is sewn in to join the esophagus straight to the duodenum. The absorptive lining downstream is left untouched and pancreatic output is unchanged. After recovery the patient can no longer finish a meal of ordinary size and instead eats six small meals a day. Which property lost with the removed organ best accounts for the new eating pattern?

- **A.** The surface across which most of a meal's nutrients enter the blood
- **B.** A chamber that accepts a large load at low internal pressure and releases it forward gradually  <- **KEY**
- **C.** The fine projections that multiply contact area for nutrient uptake
- **D.** The enzyme that starts the breakdown of protein

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 70 s |
| Confidence | 5 |

**Correct answer (B): A chamber that accepts a large load at low internal pressure and releases it forward gradually**

Citations: AP:47984; AP:47999; AP:48273; AP:48355; AP:48375

**Distractors**

- **(A)** `misconception`: Students often assume the stomach is a major absorptive surface. It absorbs almost nothing of nutritional consequence, and the stem explicitly leaves the true absorptive lining intact.
  - Citation: AP:47999
- **(C)** `adjacent_fact`: True of the small intestine, but that segment was preserved, and projections raise contact area rather than holding capacity, so they are irrelevant to the meal size limit.
  - Citation: AP:48375
- **(D)** `partial_truth`: The gastric protease is genuinely lost, but pancreatic enzymes finish protein digestion and the stem states pancreatic output is normal, so this loss cannot cap portion size.
  - Citation: AP:48063

**Readback check.** Content words of six or more letters in key B: chamber, accepts, internal, pressure, releases, forward, gradually. Stem content words of six or more letters: operation, gastric, cancer, stomach, removed, narrow, jejunum, esophagus, straight, duodenum, absorptive, lining, downstream, untouched, pancreatic, output, unchanged, recovery, patient, longer, finish, ordinary, instead, pattern, property, accounts. No overlap, and the key names a mechanical property the stem never states, so the student must infer compliance from the meal size symptom.

**Explanation (as shipped).**

> This Organ Systems item tests the stomach as a holding chamber and contrasts that role with the arrangement that serves uptake further along the canal. The answer is B because only the missing organ could take in a whole meal at one sitting and hand it on in measured portions, and a slim loop of bowel sewn into its place can do neither. An empty stomach is about the size of a fist, yet its wall can take in several liters, because the ridges of the lining smooth out and the wall lengthens instead of being put under tension. Volume therefore climbs steeply while the pressure inside barely moves, which is why a healthy person can swallow a large plate of food in minutes without discomfort. Emptying is then metered forward over roughly two to four hours, so the next segment receives a trickle rather than a flood. A conduit of fixed width has neither behavior: it fills at once, tension in its wall rises immediately, and the person stops eating long before a normal portion is gone.
>
> (Choice A) Very little of a meal actually crosses the gastric lining. Water, alcohol and a few small drugs enter there, but essentially all carbohydrate, protein and fat uptake happens beyond it, and the stem states that this downstream lining was spared. Losing a surface that was never doing the absorbing cannot explain the change.
>
> (Choice C) The fine projections that multiply contact area sit in the segment that was deliberately preserved, so they were never lost. Their job is also the wrong one: they raise the area available for uptake per unit length, which is a very different thing from raising how much the canal can hold at one moment.
>
> (Choice D) Losing the protein splitting enzyme of the stomach is real, but proteases delivered into the duodenum complete protein breakdown perfectly well, and the stem tells you that pancreatic output is unchanged. A digestive shortfall of this kind would show up as poor nutrition over months, not as an immediate ceiling on how much food fits in one sitting.
>
> This is a Knowledge of Scientific Concepts and Principles question because it asks the student to apply the concept of a low pressure holding chamber to a case in which that chamber has been replaced by a tube of fixed width.

---

## Q20 . Two lesion routes to one deficiency

**Stem.** A patient develops anemia with abnormally large red cells together with numbness in the feet, traced to lack of one water soluble vitamin. The same picture appears after the entire stomach has been taken out, and it also appears after the last stretch of small bowel has been resected. In both cases injected replacement corrects the problem while swallowed doses of ordinary strength do not. Why do lesions at opposite ends of the canal converge on the identical deficiency?

- **A.** The nutrient is taken up along the whole length of the canal, so losing any long section drops total uptake below need
- **B.** Both operations speed the passage of material so that it sweeps past the absorbing surface too quickly
- **C.** Both operations remove tissue in which the nutrient is held in store between meals
- **D.** Uptake needs a carrier protein released at one site and a receptor present only at the other, so failure of either step closes the single route available  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 105 s |
| Confidence | 5 |
| Hard-tier gate | (a) It combines gastric secretory function with region specific absorption in the terminal ileum, two separate concepts. (c) Choices A and C remain defensible until the student applies the specific fact that uptake occurs only at the far end of the ileum and that reserves are hepatic. (d) It inverts the usual direction: the deficiency is given and the shared mechanism must be inferred. |

**Correct answer (D): Uptake needs a carrier protein released at one site and a receptor present only at the other, so failure of either step closes the single route available**

Citations: AP:48269; AP:48272; AP:49253; AP:49441; AP:34310; AP:34313

**Distractors**

- **(A)** `misconception`: Treats this vitamin like a nutrient absorbed diffusely along the small intestine. Uptake is confined to receptors at the terminal ileum, which is why a short resection there is catastrophic.
  - Citation: AP:49253
- **(B)** `adjacent_fact`: Accelerated transit genuinely lowers absorption of many nutrients, but it is not what either operation does here and it would not explain the selective failure of one vitamin or the success of injection.
  - Citation: AP:49250
- **(C)** `misconception`: Assigns storage to the gut wall. The reserve sits in the liver, untouched by either operation, and a lost store would deplete in days rather than after years.
  - Citation: AP:34313

**Readback check.** Content words of six or more letters in key D: Uptake, carrier, protein, released, receptor, present, failure, either, closes, single, available. Stem content words of six or more letters: patient, develops, anemia, abnormally, together, numbness, traced, soluble, vitamin, picture, appears, entire, stomach, resected, stretch, injected, replacement, corrects, swallowed, ordinary, strength, lesions, opposite, converge, identical, deficiency. No overlap. The stem never names intrinsic factor, a receptor, or a serial pathway, so the key cannot be produced by restating the stem.

**Explanation (as shipped).**

> This Organ Systems item tests the two station relay that moves vitamin B12 out of the gut, and it asks the student to reason backwards from a deficiency to either of two very different lesions. The answer is D because absorption of this vitamin depends on a glycoprotein made in the upper organ binding it and on a docking site restricted to the far end of the small bowel taking the pair up, so knocking out either station shuts the same and only pathway. Intrinsic factor is the one gastric product that nothing else in the body can supply, which is why total gastrectomy is survivable in every other digestive respect yet still ends in this deficiency. The complex it forms is then endocytosed at receptors confined to the terminal ileum, a site restriction that has no backup elsewhere in the canal. Because the vitamin is banked in the liver in quantities that cover ordinary needs for years, the deficiency surfaces long after the operation, which is exactly why the same late picture can follow two operations performed at opposite ends of the tube. Injection works in both patients because it bypasses the entire relay.
>
> (Choice A) If uptake were spread along the whole canal, then removing a short terminal length would matter little and removing a large midsection would matter most. The observed pattern is the reverse: a short terminal resection is devastating while much longer resections elsewhere are not, which shows the route is site restricted rather than distributed.
>
> (Choice B) Faster transit does shorten contact time and can reduce uptake of several nutrients, but it would blunt absorption broadly rather than singling out one vitamin, and it would not explain why an oral dose fails while an injected dose succeeds.
>
> (Choice C) The gut wall is not the storage depot for this vitamin. Reserves are held in the liver, which is untouched by either operation, and a lost store would be exhausted within days rather than producing the years long lag actually observed.
>
> This is a Scientific Reasoning and Problem Solving question because it hands the student an outcome shared by two anatomically opposite lesions and requires working backwards to the one serial pathway that both of them interrupt.

---

## Q21 . Localising a vitamin absorption defect

**Stem.** A patient absorbs almost none of a swallowed dose of one nutrient, and the fault could sit either in the stomach or in the far end of the small bowel. Investigators give a radiolabeled dose by mouth, follow it with an injected unlabeled dose large enough to saturate the body's binding sites so that whatever is taken up spills into the urine, and record the fraction of label excreted over 24 hours. Several days later they repeat the whole procedure with purified intrinsic factor swallowed alongside the same dose. Which pattern of results would point to the stomach rather than the bowel as the site of the fault?

- **A.** Little label in the first run and just as little in the second
- **B.** Ample label in the first run and little in the second
- **C.** Little label in the first run and an amount inside the normal range in the second  <- **KEY**
- **D.** Little label in the first run and even less in the second

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **medium** (topic secondary / structural two_step) |
| Estimated time | 100 s |
| Confidence | 5 |

**Correct answer (C): Little label in the first run and an amount inside the normal range in the second**

Citations: AP:48061; AP:49441; AP:49253; AP:34313

**Distractors**

- **(A)** `adjacent_fact`: This is the correct signature of the intestinal lesion, not the gastric one. It is a true outcome pattern but answers the opposite question to the one asked.
  - Citation: AP:49441
- **(B)** `process_step_confusion`: Swaps the two runs. It contradicts the stated baseline of near zero absorption and puts the rescue condition before the failure it is meant to rescue.
  - Citation: AP:49441
- **(D)** `reversed_relationship`: Relates the supplied component to uptake in the wrong direction. Adding a limiting carrier can restore uptake or leave it unchanged, but there is no mechanism by which it drives absorption lower.
  - Citation: AP:48061

**Readback check.** Content words of six or more letters in key C: Little, amount, inside, normal, second. Stem content words of six or more letters: patient, absorbs, almost, swallowed, nutrient, either, stomach, bowel, Investigators, radiolabeled, follow, injected, unlabeled, enough, saturate, binding, whatever, spills, urine, record, fraction, excreted, several, repeat, procedure, purified, intrinsic, factor, alongside, pattern, results. No overlap. The stem supplies no outcome values, so the key must be constructed from the design logic rather than read off the stem.

**Explanation (as shipped).**

> This Organ Systems item tests the logic of a two condition test built to separate a secretory fault from an uptake fault, using urinary appearance of a label as the readout. The answer is C because the second run supplies from outside the body exactly the one thing a diseased stomach fails to make, so if the label now appears normally the missing piece must have been that secreted product and the downstream wall must be healthy. The design changes one variable only between runs, which is what makes the comparison interpretable: the dose, the route, the saturating injection and the collection window are all held constant while the added glycoprotein is switched on. A wall that lacks working docking sites cannot use supplied carrier either, so in that patient the supplement changes nothing. Each patient therefore serves as their own control, removing between person differences in body reserves that would otherwise blur the readout. Note that the urinary measure is only a proxy for absorption, so it assumes stable kidney function across the two runs, an assumption worth checking before either result is trusted.
>
> (Choice A) This is precisely the result expected from the alternative lesion. Supplying carrier to a wall that cannot bind and internalise the complex leaves the block untouched, so an unchanged result points away from the organ named in the question rather than towards it.
>
> (Choice B) Ample label on the first run contradicts the premise that almost nothing is absorbed, and a fall after adding carrier reverses the direction the manipulation should push. The order of events is scrambled: the supplement is meant to rescue a failed run, not spoil a successful one.
>
> (Choice D) A further drop would mean the added carrier actively worsened uptake, which the mechanism gives no reason to expect. Supplying a limiting component can restore or fail to restore a process, but it should not push it below the level seen without it.
>
> This is a Reasoning about the Design and Execution of Research question because it asks the student to interpret a within patient two condition comparison in which a single supplied component is the only manipulated variable and to map each possible outcome onto a candidate lesion.

---

## Q22 . Feed forward gastrin release by peptides

**Stem.** Three test loads plus a saline control, all of equal volume and all buffered to the same starting pH, were placed directly into the stomachs of fasted volunteers through a tube that bypassed the mouth. Plasma concentration of the antral hormone and acid output were then measured over the following hour.

| Instilled load | Plasma hormone (pg/mL) | Acid output (mmol/h) |
| --- | --- | --- |
| Saline only | 25 | 2 |
| Peptone, a partly broken down egg albumin | 95 | 22 |
| Glucose | 28 | 3 |
| Long chain lipid emulsion | 27 | 3 |

What does this pattern indicate about how the stomach sets its acid output?

- **A.** Acid delivery is scaled to the class of food that acid is required to break down, so the arriving meal commissions its own digestive capacity.  <- **KEY**
- **B.** Acid delivery tracks the total energy content of the instilled load, independent of what that load is made of.
- **C.** Acid delivery is driven by mechanical stretch of the gastric wall rather than by the chemical composition of what arrives.
- **D.** The hormone rises because acid already formed in the lumen feeds back to increase further release of that hormone.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **easy** (topic core / structural two_step) |
| Estimated time | 85 s |
| Confidence | 5 |

**Correct answer (A): Acid delivery is scaled to the class of food that acid is required to break down, so the arriving meal commissions its own digestive capacity.**

Citations: AP:48179, AP:48094, AP:32833

**Distractors**

- **(B)** `misconception` . _calories drive everything_: The glucose and lipid loads both carried energy yet produced hormone values of 28 and 27 pg/mL against a saline control of 25 pg/mL, so caloric content is dissociated from the response in this very data set.
  - Citation: AP:48094
- **(C)** `adjacent_fact` . _true stimulus, held constant by design_: Distension really does stimulate gastric secretion, but the protocol matched instilled volume across all four conditions, so stretch was constant and cannot generate a difference between rows.
  - Citation: AP:32833
- **(D)** `reversed_relationship` . _loop run backwards_: Acid suppresses rather than amplifies release of the antral hormone, so the described positive loop would make acid secretion self reinforcing, which is the opposite of the observed self limiting behaviour.
  - Citation: AP:48190

**Readback check.** Content words of six or more letters in key A: delivery, scaled, required, arriving, commissions, digestive, capacity. Stem words of six or more letters: control, buffered, starting, placed, stomachs, fasted, volunteers, through, bypassed, plasma, concentration, antral, hormone, measured, following, instilled, saline, peptone, partly, broken, albumin, glucose, emulsion, pattern, indicate, stomach, output. No overlap. The key names no structure or hormone that appears in the stem, and the correct choice cannot be produced by reading any single table value, since it requires comparing the peptone row against three matched controls.

**Explanation (as shipped).**

> This item sits in Organ Systems and tests feed forward control of gastric acid secretion by the hormone released from antral endocrine cells. The answer is A because only the load that acid is needed to process raised both the hormone value and the acid measurement, while equally large volumes of the other two loads left both essentially at control level. Every instillation was matched for volume and for starting pH, and every one bypassed the mouth, so wall stretch, lumen acidity and anticipation were all held constant across the four conditions. The one variable left free is the chemical class of the load, and only the partly broken down egg albumin, which supplies short peptides and free amino acids, moved either number. Those peptides act on antral endocrine cells to release gastrin, which drives the proton pump of parietal cells to secrete hydrochloric acid. Note the direction of the arrangement: the products of protein breakdown announce that protein has arrived and call up the acid that will finish the job, so the stomach builds capacity for work still to come rather than correcting a shortfall after the fact. A purely corrective loop would have to wait for evidence that digestion was already falling behind.
>
> (Choice B) Energy content cannot be the variable. Glucose and the lipid emulsion both carry calories, yet neither moved the hormone value more than 3 pg/mL above the saline control, so caloric load and the response come apart cleanly in this data set.
>
> (Choice C) Stretch is a genuine stimulus in an intact stomach, but the design deliberately matched the instilled volumes, so distension was identical in all four conditions and cannot explain an elevenfold difference in the acid measurement.
>
> (Choice D) This runs the loop backwards. Accumulating acid does not amplify release of this hormone; falling luminal pH is the signal that shuts release down, which is why acid secretion in a healthy stomach is self limiting rather than runaway.
>
> This is a Data-based and Statistical Reasoning question because the student must read four measured conditions against one another, notice which variables the protocol already held constant, and isolate the single remaining variable that accounts for the pattern.

---

## Q23 . Acid negative feedback on gastrin release

**Stem.** Luminal pH was clamped at each of three values by controlled infusion while blood was sampled for the antral hormone. One patient with recurrent duodenal ulceration was studied alongside healthy volunteers; imaging and biopsy showed a normal parietal cell mass in both groups.

| Clamped luminal pH | Hormone, healthy (pg/mL) | Hormone, patient (pg/mL) |
| --- | --- | --- |
| 5.5 | 90 | 420 |
| 3.0 | 45 | 430 |
| 1.5 | 15 | 425 |

Which additional finding should be expected in this patient?

- **A.** Acid formation will be low despite the raised hormone value, because the target cells have become unresponsive to that hormone.
- **B.** Acid formation continues near its maximum for hours after a meal has left, because nothing switches the drive off.  <- **KEY**
- **C.** The raised hormone value will settle into the healthy range after a day of fasting.
- **D.** Acid formation will peak after eating and then fall back on the usual timetable, with only the resting value altered.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 105 s |
| Confidence | 5 |
| Hard-tier gate | Meets (b), since the student must read a ten thousand fold change in hydrogen ion concentration against a flat hormone curve and infer direction; (c), since choices A and D both remain defensible until the normal parietal cell mass and the flat curve are applied; and (d), since the item supplies an outcome, flat hormone plus ulceration, and demands the underlying lesion and its forward consequence. |

**Correct answer (B): Acid formation continues near its maximum for hours after a meal has left, because nothing switches the drive off.**

Citations: AP:48190, AP:48179, AP:48094

**Distractors**

- **(A)** `reversed_relationship` . _target resistance instead of missing brake_: This treats the high hormone value as a consequence of target cells failing rather than as a cause of excess acid, but the stem reports a normal parietal cell mass and downstream ulceration, both of which require acid to be high rather than low.
  - Citation: AP:48179
- **(C)** `misconception` . _assumes the drive is meal dependent_: The patient's value is already maximal at pH 1.5, a condition under which healthy release has essentially ceased, so removing the meal cannot restore a feedback limb that is structurally absent.
  - Citation: AP:48190
- **(D)** `partial_truth` . _correct rise, wrong fall_: It is true that the stimulatory rise is preserved, but the fall depends on the acid sensing limb the data show to be missing, so the offset cannot follow a normal timetable.
  - Citation: AP:48190

**Readback check.** Content words of six or more letters in key B: formation, continues, maximum, switches. Stem words of six or more letters: luminal, clamped, values, controlled, infusion, sampled, antral, hormone, patient, recurrent, duodenal, ulceration, studied, alongside, healthy, volunteers, imaging, biopsy, showed, normal, parietal, groups, additional, finding, should, expected. No overlap. The key is a prediction about a time course that appears nowhere in the table, so it cannot be read off any cell.

**Explanation (as shipped).**

> This item sits in Organ Systems and tests the negative feedback limb that terminates release of the antral hormone once gastric contents become sufficiently acidic. The answer is B because the patient's value is flat across a ten thousand fold change in hydrogen ion concentration, which means the acidity signal never reaches the cells that release the hormone, so nothing in the system ever calls a halt. In the healthy volunteers the value falls from 90 to 15 pg/mL as pH is driven from 5.5 down to 1.5, the signature of a closed loop in which the product of a response cancels the stimulus for that response. Losing that limb does not weaken the drive. It deletes the only thing that ever stopped it. With a normal parietal cell mass being pushed continuously by an unopposed signal, acid formation persists close to its ceiling long after the meal that started it has gone, and the duodenum receives an acid load it was never built to buffer, which is why recurrent ulceration is the presenting complaint. The general lesson is worth holding: an open loop of this kind does not run low or oscillate, it runs flat out.
>
> (Choice A) This inverts cause and effect. Unresponsive target cells would give a high hormone value with a low acid measurement, but the study explicitly reports a normal parietal cell mass, and a stomach making little acid would not ulcerate the intestine downstream of it.
>
> (Choice C) Fasting removes the meal related stimulus, not the defect. The patient already sits at 425 pg/mL at pH 1.5, conditions under which a healthy volunteer has switched release almost entirely off, so an empty stomach cannot normalise the value either.
>
> (Choice D) A normal timetable requires an intact off switch, and the data show precisely that switch missing. The rise after eating can still occur, but the fall depends on the limb that is absent, so recovery cannot follow the usual schedule.
>
> This is a Data-based and Statistical Reasoning question because the student must compare two response curves across a clamped independent variable, recognise a flat curve as a missing feedback limb rather than as a raised set point, and project that reading forward to a consequence not shown in the table.

---

## Q24 . Gut somatostatin as secretory brake

**Stem.** Endocrine cells scattered through the mucosa of the stomach and duodenum release gut somatostatin, which diffuses a short distance to neighbouring cells and restrains them. A compound is developed that abolishes release of gut somatostatin throughout the gut while leaving every stimulatory pathway intact. A healthy volunteer takes the compound and then eats a standard meal.

Which of the following would be expected?

I. The stomach would deliver chyme into the duodenum faster than in the untreated state.
II. Pancreatic enzyme delivery to the duodenum for the same meal would be greater than in the untreated state.
III. The stomach would fail to increase its secretion when the meal arrived.

- **A.** I only
- **B.** II only
- **C.** I and II only  <- **KEY**
- **D.** I, II and III

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic secondary / structural multi_step) |
| Estimated time | 95 s |
| Confidence | 4 |
| Hard-tier gate | Meets (a), since it joins gastric paracrine inhibition to the control of both gastric emptying and exocrine pancreatic output; (b), since the student must infer the direction of change at two effector organs with no values supplied; and (c), since choices A and B each capture one true target organ and stay defensible until the student recognises that the releasing cells are distributed across stomach and duodenum. |

**Correct answer (C): I and II only**

Citations: AP:48132, AP:48140, AP:48190

**Distractors**

- **(A)** `partial_truth` . _one target organ only, stomach_: Faster gastric emptying is correct but incomplete, because the same mucosal signal is released in the duodenum and restrains the exocrine pancreas, so pancreatic output rises too.
  - Citation: AP:48140
- **(B)** `partial_truth` . _one target organ only, pancreas_: Greater pancreatic enzyme delivery is correct but incomplete, because the same signal also restrains gastric motility and emptying, so handover to the duodenum accelerates as well.
  - Citation: AP:48132
- **(D)** `misconception` . _any inhibitor loss abolishes regulation_: Statement III requires the stimulatory arm to fail, but the stem specifies that arm is untouched, so a meal still drives gastric secretion and drives it higher than before.
  - Citation: AP:48179

**Readback check.** The key is the label 'I and II only' and contains no content words at all, so no stem echo is possible in the key itself. Checking the numbered statements instead: statements I and II use deliver, untreated, Pancreatic, enzyme, delivery, greater, none of which appear in the stem, whose six letter words are Endocrine, scattered, through, mucosa, stomach, duodenum, somatostatin, diffuses, distance, neighbouring, restrains, compound, developed, abolishes, release, throughout, leaving, stimulatory, pathway, intact, healthy, volunteer, standard, following, expected. Shared words are limited to duodenum and stomach, which name the setting rather than the discriminator, and they appear in the false statement as well as the true ones. The item cannot be answered by matching a phrase, since each statement must be evaluated against the consequences of removing a distributed inhibitory signal.

**Explanation (as shipped).**

> This item sits in Organ Systems and tests what a single inhibitory signal contributes when it restrains more than one organ at once. The answer is C because the brake released by these mucosal cells holds back both the emptying of the stomach and the exocrine output of the pancreas, so subtracting it releases both, yet it cannot abolish a response driven by pathways the compound never touched. Statement I holds because the cells releasing the brake sit in the wall of the stomach and duodenum, exactly where the rate of handover between them is set, and with the restraint gone the stomach pushes its contents onward faster than the intestine would normally allow. Statement II holds because the same signal, released from the duodenal mucosa, damps the exocrine pancreas, so removing it leaves a larger enzyme delivery for an identical meal. Statement III fails on the stated terms of the experiment, since every stimulatory pathway is untouched and a meal will still recruit secretion, in fact more of it than usual. The general point is that losing a brake is not the same as losing a response: a disinhibited system is more responsive, not less, and one paracrine restraint distributed along the mucosa lets several organs be pulled back together rather than one at a time.
>
> (Choice A) Statement I alone is incomplete. It captures the faster handover to the intestine but stops at the stomach, ignoring that the same signal is released from duodenal mucosa and restrains the exocrine pancreas as well.
>
> (Choice B) Statement II alone is incomplete in the mirror image way. It captures the larger enzyme delivery but ignores that the brake also holds back gastric emptying, which is the step immediately upstream of it.
>
> (Choice D) Including statement III contradicts the premise of the experiment. The compound was specified to leave stimulatory pathways intact, so responsiveness to a meal is preserved and, if anything, exaggerated rather than lost.
>
> This is a Scientific Reasoning and Problem Solving question because the student must take a stated lesion in one arm of a control system and predict the direction of the change at two separate effector organs, while rejecting the claim that removing an inhibitor removes the response itself.

---

## Q25 . Cephalic phase anticipatory gastric secretion

**Stem.** An investigator asks whether the gastric mucosa can be switched on by something other than the meal itself. Fasted dogs are fitted with a cannula that drains gastric juice, and the rate of drainage is recorded each minute. Four protocols are proposed. Which one can settle the question?

- **A.** Deliver the meal through the cannula while the dog neither sees nor tastes it, and compare drainage with a resting baseline.
- **B.** Compare drainage during an inert saline load with drainage during an equal load of real food, both delivered through the cannula.
- **C.** Let the dog eat normally and record whether drainage rises within the first minute after the first bite.
- **D.** Let the dog see, smell and chew a favoured meal while a diversion keeps every mouthful out of the stomach, then compare drainage with a resting baseline.  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 90 s |
| Confidence | 5 |

**Correct answer (D): Let the dog see, smell and chew a favoured meal while a diversion keeps every mouthful out of the stomach, then compare drainage with a resting baseline.**

Citations: AP:48168, AP:48169, AP:48158

**Distractors**

- **(A)** `process_step_confusion` . _isolates the later stage instead_: This protocol tests the response to food already inside the organ, which is the stage after the one under investigation, and it removes precisely the cues the investigator wants to evaluate.
  - Citation: AP:48158
- **(B)** `adjacent_fact` . _valid control for a different question_: Contrasting an inert load with a real one addresses chemical versus mechanical drive, and since both arms deliver material to the organ, neither can reveal a response occurring before delivery.
  - Citation: AP:48179
- **(C)** `partial_truth` . _early timing without a clean cut_: An early rise is consistent with anticipation but does not establish it, because swallowed food has already begun to arrive, leaving anticipation and arrival confounded within the first minute.
  - Citation: AP:48168

**Readback check.** Content words of six or more letters in key D: favoured, diversion, mouthful, stomach, compare, drainage, resting, baseline. Stem words of six or more letters: investigator, whether, gastric, mucosa, switched, something, itself, Fasted, fitted, cannula, drains, juice, drainage, recorded, minute, protocols, proposed, settle, question. The word drainage is the measured variable and appears in all four choices equally, so it carries no discriminating information; every other key word is absent from the stem. The correct choice names no structure or phase mentioned in the stem, and cannot be reached by restating it.

**Explanation (as shipped).**

> This item sits in Organ Systems and tests the design logic required to show that gastric juice production begins before the meal reaches the organ that produces it. The answer is D because it is the only protocol in which nothing whatever reaches the target organ, so any rise in drainage must have been generated by seeing, smelling and chewing the food rather than by its arrival. That is the substance of the cephalic phase: secretion is commissioned on a prediction that food is coming, not as a response to food that has come, and the only way to demonstrate anticipation is to make arrival impossible while leaving the anticipatory cues fully in place. Comparing against the same fasted dog at rest supplies the baseline drainage against which the rise is judged. The causal chain is cut at a known point, so arrival is excluded by construction and anticipation is the only explanation left standing.
>
> (Choice A) Delivering the meal while the dog neither sees nor tastes it isolates the opposite half of the system. It is a clean test of the response to arrival, and it deliberately strips out the very cues whose contribution the investigator set out to measure.
>
> (Choice B) Comparing an inert load with a real one asks whether the response depends on what arrived rather than on how much arrived. That is a useful control for a different question, and in both conditions material reaches the target organ, so neither arm can speak to anticipation.
>
> (Choice C) Timing the rise after the first bite is suggestive but not decisive. Some of the food has already been swallowed by then, so an early rise cannot be assigned to anticipation rather than to the first material to arrive, and the two candidate causes remain confounded.
>
> This is a Reasoning about the Design and Execution of Research question because the student must select, from four protocols, the one whose control structure eliminates the rival explanation and leaves anticipation as the only surviving cause of the measured rise.

---



---

# BATCH 2 of 3 (25 questions): control signalling, exocrine pancreas, absorption

Units: the gut's own nerve network and the enterogastric reflex . the two duodenal hormones .
anticipatory and appetite signals . the exocrine pancreas as two cell populations . failure of the
autodigestion safeguard . saliva and absorptive surface area . how sugars cross the absorptive cell.

## Batch 2 summary

| Metric | Batch 2 | Combined (50) | Target |
|---|---|---|---|
| Difficulty | easy 7 . hard 8 . medium 10 | easy 14 . hard 16 . medium 20 | easy 7 . hard 8 . medium 10 |
| Answer letter | A 7 . B 6 . C 6 . D 6 | A 13 . B 12 . C 13 . D 12 | A 7 . B 6 . C 6 . D 6 |
| Cognitive skill | S1 4 . S2 13 . S3 4 . S4 4 | S1 8 . S2 26 . S3 7 . S4 9 | S1 4 . S2 13 . S3 4 . S4 4 |
| Confidence | conf4 5 . conf5 20 | conf4 10 . conf5 40 | only 4-5 ship |
| Roman numeral | 3 | 6 | 3 per batch |
| Distractor categories | adjacent_fact 10 . misconception 24 . partial_truth 17 . process_step_confusion 9 . reversed_relationship 11 . scale_unit_error 4 | | none dominant |
| Em/en dashes | 0 | 0 | 0 |
| Source citations in shipped explanations | 0 | 0 | 0 |

**Every quota landed exactly, for the second batch running.**

**Boundary scan:** one flag raised and cleared by hand. B2-Q9 supplies plasma insulin in a data table.
Bio Ch5 owns insulin and the endocrine pancreas, so the drafter was instructed that insulin could
appear ONLY as a measured readout. The delivered item honours that: two sugar loads are given, one
swallowed and one infused into a vein with the infusion rate adjusted continuously so the blood sugar
curves match point for point, and the insulin response is nonetheless roughly double on the swallowed
day. The key is that passage through the gut lumen liberates a circulating messenger acting in
addition to blood sugar itself. Insulin is the ruler, never the answer, and the matched glucose curves
are what make the inference airtight.

**Cross-batch:** no subtopic is duplicated within batch 2 or against batch 1, and no key is a
near-duplicate of a batch 1 key.

**Adversarial audit:** all 25 re-examined by an independent pass per slice, with every citation
re-greped against OpenStax Anatomy and Physiology 2e and OpenStax Biology 2e.

---

## B2-Q1 . Complete reflex arcs within the gut wall

**Stem.** A length of small intestine is transplanted into a recipient, and the nerve trunks that formerly ran to it from elsewhere in the body are cut at surgery. In this procedure those trunks never re-establish contact with the graft. Within weeks the graft is moving material along its length in an orderly, propagated fashion. Which feature of the intestinal wall accounts for this?

- **A.** The muscle coats of the graft become continuous with those of the recipient's own bowel at the surgical join, which carries each wave across.
- **B.** Signals reaching the graft in the bloodstream drive each individual contraction as it occurs.
- **C.** The wall itself holds sensory, integrating and motor neurons together, so a complete arc can be closed locally with no input from beyond the organ.  <- **KEY**
- **D.** Fibres from the recipient regrow into the graft and restore the divided connections.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 65 s |
| Confidence | 5 |

**Correct answer (C): The wall itself holds sensory, integrating and motor neurons together, so a complete arc can be closed locally with no input from beyond the organ.**

Citations: AP:47169; AP:47170; AP:47494

**Distractors**

- **(A)** `misconception`: Mechanical or electrical continuity at the surgical join could only import activity from the host bowel; it cannot produce a sequence that originates and terminates inside the graft.
  - Citation: AP:47494
- **(B)** `partial_truth`: Circulating signals genuinely modulate gut activity, but they reach all parts simultaneously and cannot generate the spatial ordering of shortening ahead of relaxation.
  - Citation: AP:47513
- **(D)** `misconception`: The behaviour is present although the divided trunks never reconnect, so restored outside innervation cannot be the explanation.
  - Citation: AP:47177

**Readback check.** Content words of six or more letters in key C: sensory, integrating, neurons, together, complete, closed, locally, beyond. The stem uses length, small, intestine, transplanted, recipient, trunks, formerly, elsewhere, surgery, procedure, establish, contact, graft, moving, material, orderly, propagated, fashion, feature, intestinal, accounts. No word is shared between stem and key, and no stem sentence states the composition of the wall's neuron population, so the key cannot be copied out of the stem.

**Explanation (as shipped).**

> This Organ Systems item tests how the nervous tissue of the digestive tube is arranged and what that arrangement lets the tube accomplish unaided. The answer is C because the wall carries detecting, integrating and commanding elements side by side, so a full arc can be closed inside the tissue with no traffic to or from the central nervous system. The tube from oesophagus to anus holds on the order of a hundred million nerve cells embedded in its own layers, and that population is not purely motor: it includes cells that read the state of the lumen, cells that integrate those readings, and cells that instruct the muscle coats and the glands. Because all three classes sit within the tissue, a stimulus arising at one point can be detected, processed and answered on the spot. Connections from outside adjust how vigorously the wall works, but they are not needed to generate the basic ordered sequence, which is precisely why a graft cut off from them still propels its load.
>
> (Choice A) Continuity of the muscle layers across a join could at best conduct activity from the recipient's own bowel into the graft. It cannot explain an ordered sequence that begins and ends inside the graft itself, and the same behaviour appears in preparations with no such continuity at all.
>
> (Choice B) Bloodborne messengers do reach the graft and do modulate how briskly it works, but a circulating signal arrives at every part of the graft at once. It cannot specify that one point shortens while the point just ahead of it yields, and spatial sequencing of that kind demands a circuit built into the tissue.
>
> (Choice D) Regrowth of severed fibres is a common assumption, but the stem removes that possibility, and the behaviour appears anyway. Treating outside innervation as indispensable inverts the actual dependence: the local circuitry is the engine and the outside supply is the throttle.
>
> This is a Knowledge of Scientific Concepts and Principles question because it asks the student to recall how the neural equipment of the digestive tube is composed and to apply that composition to an organ deliberately isolated from every connection outside itself.

---

## B2-Q2 . Positional inference for two wall networks

**Stem.** A toxin selectively destroys the neurons of the nerve network lying in the layer of dense connective tissue that separates the mucosal lining of the small intestine from the muscle coats. The separate network lying between the circular and the longitudinal muscle coats is left untouched, and both muscle coats and the mucosal lining remain structurally normal. Which of the following outcomes would be expected?

I. The watery fluid released into the lumen after a meal is reduced in volume.
II. Rhythmic propulsion of material along the segment is abolished.
III. The force developed by the two muscle coats during mixing is reduced.

- **A.** I only  <- **KEY**
- **B.** I and II only
- **C.** II and III only
- **D.** I, II, and III

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 90 s |
| Confidence | 5 |

**Correct answer (A): I only**

Citations: AP:47135; AP:47172; AP:47173; AP:47174

**Distractors**

- **(B)** `partial_truth`: Statement I is correct, but pairing it with loss of propulsion ignores that the network between the muscle coats and the coats themselves were both spared.
  - Citation: AP:47173
- **(C)** `reversed_relationship`: Swaps the two networks, attributing control of contraction to the network under the lining and control of secretion to the intermuscular one.
  - Citation: AP:47174
- **(D)** `misconception`: Treats a lesion confined to one of two anatomically distinct neuron populations at different depths as though it disabled the entire wall.
  - Citation: AP:47135

**Readback check.** The key is the numeral set, so the echo check applies to statement I. Content words of six or more letters in I: watery, released, reduced, volume. The stem contains selectively, destroys, neurons, network, dense, connective, tissue, separates, mucosal, lining, intestine, muscle, coats, separate, between, circular, longitudinal, untouched, structurally, normal, following, outcomes, expected. No overlap. The stem never says what either network controls; it gives only the layer each occupies, so the student must supply the functional mapping.

**Explanation (as shipped).**

> This Organ Systems item tests the division of labour between the two intramural nerve networks, inferred from where each one sits rather than from a memorised label. The answer is A because a network embedded in the connective tissue just under the lining is positioned to reach the glands and the absorptive surface, whereas the network sandwiched between the two muscle coats is the one wired to the contractile machinery, and that second network is spared here. Position dictates access. Neurons whose processes end among the glands and the vascular bed of that connective tissue layer can modulate how much fluid and enzyme is delivered into the lumen and can respond to what the lining detects. Neurons whose cell bodies and processes lie in the plane separating the circular and longitudinal coats are the ones able to set the rhythm and the force of shortening in those coats. Because the lesion spares that second plane entirely, everything that depends on the muscle continues, and only the output aimed at the lining is lost.
>
> (Choice B) This adds a motor loss to a correct secretory loss. Propulsion depends on the network left intact and on muscle that the stem states is structurally normal, so ordered movement along the segment persists.
>
> (Choice C) This assigns motility to the network that was destroyed and drops the one genuine consequence. It reverses the mapping between depth in the wall and function, which is the single inference the item is built around.
>
> (Choice D) Selecting everything treats damage to one network as damage to the whole wall. The two networks are anatomically separate populations at different depths, and a lesion confined to one of them cannot abolish functions served by the other.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to predict which functions survive a lesion by reasoning from the anatomical layer each network occupies to the structures its processes can actually reach.

---

## B2-Q3 . Feedback braking of gastric outflow

**Stem.** In an animal preparation the pathway carrying signals from stretch receptors in the wall of the first part of the small intestine back to the gastric musculature is interrupted. Acid output per meal, measured directly, is unchanged from baseline, and no other pathway is disturbed. Over several weeks these animals develop erosions in the lining a short distance beyond the stomach. Which change most directly accounts for the erosions?

- **A.** The stomach now produces more acid per meal, so the total amount reaching the intestine rises.
- **B.** The stomach now empties more slowly, holding its contents against the lining for longer before release.
- **C.** The gate at the stomach outlet loses its tone, so intestinal contents wash backward into the stomach.
- **D.** Each emptying event now delivers a larger bolus, so material arrives faster than the receiving tissue can neutralise and absorb it.  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 105 s |
| Confidence | 5 |
| Hard-tier gate | Meets (b), (c) and (d). (b) The key requires a directional inference about handover rate rather than a lookup. (c) Choices A and B both stay defensible until the student applies the unchanged acid output measurement and the sign of the feedback limb. (d) The item is inverted: the outcome, downstream erosion, is given and the causal change must be reconstructed. |

**Correct answer (D): Each emptying event now delivers a larger bolus, so material arrives faster than the receiving tissue can neutralise and absorb it.**

Citations: AP:48196; AP:48245; AP:48246; AP:48254

**Distractors**

- **(A)** `misconception`: Attributes downstream injury to excess secretion, which the stated unchanged acid output per meal directly excludes.
  - Citation: AP:48254
- **(B)** `reversed_relationship`: Removing an inhibitory feedback limb accelerates rather than slows handover, and slower handover would be protective.
  - Citation: AP:48196
- **(C)** `process_step_confusion`: Substitutes retrograde flow for the forward handover the reflex actually governs, and misplaces the injury to the organ built to tolerate its own secretion.
  - Citation: AP:48246

**Readback check.** Content words of six or more letters in key D: emptying, delivers, larger, material, arrives, faster, receiving, tissue, neutralise, absorb. The stem contains preparation, pathway, carrying, signals, stretch, receptors, intestine, gastric, musculature, interrupted, output, measured, directly, unchanged, baseline, disturbed, several, animals, develop, erosions, lining, distance, beyond, stomach, change, accounts. No word of six or more letters is shared. The stem never states the delivery rate or the downstream processing limit; both must be supplied by the student.

**Explanation (as shipped).**

> This Organ Systems item tests a negative feedback loop that matches the rate of delivery out of one organ to the processing capacity of the next, and asks the student to work backwards from an injury to the loop that failed. The answer is D because interrupting the feedback removes the brake on outflow, and unbraked outflow overwhelms a downstream segment that can only handle a small parcel at a time. Under normal conditions the arrival of a parcel in the first portion of the intestine is sensed by wall receptors, and that sensing feeds back to slow the pump and tighten the outlet, so the next parcel waits until the previous one has been dealt with. Only about three millilitres are handed over per cycle, and that trickle is what allows incoming acid to be buffered and nutrients to be broken down and taken up. Remove the feedback limb and the pump empties without restraint, so the delivered flux rises even though the amount of acid made is identical. The lesion is therefore a rate problem, not a production problem, which is exactly why the unchanged acid measurement is the discriminating fact rather than a throwaway detail.
>
> (Choice A) The stem reports acid output per meal as unchanged, so the total load is the same; what has altered is how quickly it is handed over. Students who assume any downstream ulceration means excess secretion skip the measurement that rules it out.
>
> (Choice B) This has the direction backwards. Losing the inhibitory feedback speeds handover rather than slowing it, and slower handover would protect the downstream lining rather than damage it.
>
> (Choice C) Backward washing would expose the stomach, which is built to withstand its own secretion, and it would not concentrate injury just beyond the outlet. The reflex arm in question governs forward handover, not retrograde flow.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to infer, from an observed pattern of injury plus one measurement that eliminates the obvious alternative, which direction a disrupted feedback loop must have shifted the rate of delivery.

---

## B2-Q4 . Ruling out a purely muscular explanation

**Stem.** An excised loop of small intestine is suspended in a warmed, oxygenated bath. Gentle distension applied at one point of the wall reliably evokes shortening on the upstream side and lengthening on the downstream side, and the pattern is reproducible across trials. The investigators conclude that the ordered response is neurally driven. Which control is most necessary before that conclusion is accepted?

- **A.** Confirm that the bath stayed oxygenated and at body temperature for the whole protocol.
- **B.** Apply the identical stimulus again after abolishing conduction in the neurons of the preparation, since the contractile layers acting alone would yield the same observation.  <- **KEY**
- **C.** Set the distending force to several different magnitudes and record how the reaction scales with it.
- **D.** Show that direct stimulation of the muscle coats on their own evokes no shortening, which would exclude a muscular contribution.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **medium** (topic secondary / structural two_step) |
| Estimated time | 95 s |
| Confidence | 5 |

**Correct answer (B): Apply the identical stimulus again after abolishing conduction in the neurons of the preparation, since the contractile layers acting alone would yield the same observation.**

Citations: AP:47169; AP:47480; AP:47494

**Distractors**

- **(A)** `partial_truth`: Viability monitoring is good practice, but the positive, reproducible reaction already demonstrates a live preparation; it does not address the competing mechanism.
  - Citation: AP:47480
- **(C)** `adjacent_fact`: A stimulus-magnitude series characterises the reaction but leaves both the neural and the non-neural explanations equally viable.
  - Citation: AP:47480
- **(D)** `reversed_relationship`: Silences the wrong element and requires a result that contradicts the observed shortening, so it can neither support nor refute the claim about nerve cells.
  - Citation: AP:47173

**Readback check.** Content words of six or more letters in key B: identical, stimulus, abolishing, conduction, neurons, preparation, contractile, layers, acting, observation. The stem contains excised, intestine, suspended, warmed, oxygenated, Gentle, distension, applied, reliably, evokes, shortening, upstream, lengthening, downstream, pattern, reproducible, trials, investigators, conclude, ordered, response, neurally, driven, control, necessary, conclusion, accepted. None of the key's words appears in the stem, and the stem never names the non-neural alternative that the key exists to eliminate, so the control cannot be read off the stem.

**Explanation (as shipped).**

> This Organ Systems item tests experimental logic: whether the stated conclusion is the only account of the result, and what manipulation is needed to eliminate the competing account. The answer is B because the observation as it stands does not separate a response built by nerve cells from one generated by the contractile layers on their own, and only silencing signalling in the neurons of the preparation can tell those two mechanisms apart. A local deformation that is answered by shortening on one side and yielding on the other looks like a circuit at work, but a wholly non-neural mechanism intrinsic to the coats could produce the same directional pattern, and nothing in the protocol so far excludes it. The decisive test is therefore to abolish conduction in the nerve cells and repeat the identical stimulus: if the ordered reaction vanishes, nerve cells are required, and if it survives unchanged, the investigators' conclusion is wrong. Without this manipulation the data are compatible with two mechanisms and cannot select between them.
>
> (Choice A) Viability matters, but a vigorous, reproducible reaction is already evidence that the tissue was alive and working. This control guards against a false negative, whereas the threat to this conclusion is a false attribution of a positive result.
>
> (Choice C) Varying the magnitude of the stimulus describes how the reaction scales with input. It is a useful characterisation but it leaves both candidate mechanisms standing, because a non-neural reaction would also vary with the stimulus.
>
> (Choice D) This inverts which element should be silenced, and it demands an outcome that contradicts the data already in hand. The wall visibly shortens, so the muscle coats plainly can contract; showing that they cannot would falsify the observation rather than test its cause.
>
> This is a Reasoning about the Design and Execution of Research question because it asks the student to identify the rival non-neural explanation left open by the existing protocol and to select the specific manipulation that discriminates between the two.

---

## B2-Q5 . Self-limiting feedback in secretin release

**Stem.** In an anaesthetised animal, a catheter delivers acid into the lumen of the first segment of the small intestine at a steady rate while a strong buffer holds that lumen at pH 3.0 no matter what the animal secretes. Pancreatic duct output and blood secretin are followed for one hour, and duct output rises promptly and stays raised. Over that hour, blood secretin will most likely do which of the following?

- **A.** Return toward its starting value within a few minutes, since bicarbonate reaches the lumen normally
- **B.** Rise only once the fat portion of a meal reaches the same region
- **C.** Stay high throughout, because the alkaline load it calls for can no longer erase the signal that caused its own release  <- **KEY**
- **D.** Fall steadily as the cells that release it are exhausted by the constant stimulus

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 100 s |
| Confidence | 5 |
| Hard-tier gate | Hard is justified: (a) combines negative feedback logic with pancreatic ductal bicarbonate secretion; (b) requires a directional inference about a time course under a manipulation, not a lookup; (d) inverts the usual direction, giving an experimental outcome and asking what the signal must be doing. Three of the four conditions hold. |

**Correct answer (C): Stay high throughout, because the alkaline load it calls for can no longer erase the signal that caused its own release**

Citations: AP:32834, AP:48953, BIO:45304

**Distractors**

- **(A)** `partial_truth`: Bicarbonate really is delivered, but delivery ends release only by raising luminal pH, which the buffer prevents.
  - Citation: AP:48953
- **(B)** `adjacent_fact`: Fat is the trigger for the other duodenal peptide, and no meal is given in this preparation.
  - Citation: AP:48433
- **(D)** `misconception`: Gut endocrine cells do not exhaust within an hour of continuous stimulation.
  - Citation: AP:47509

**Readback check.** Content words of six or more letters in key C: throughout, alkaline, signal, caused, release. Stem words include anaesthetised, catheter, delivers, lumen, segment, intestine, steady, buffer, secretes, pancreatic, output, secretin, followed, promptly. No overlap. The stem never states what terminates release, so the key cannot be copied out; the student must infer that the pH clamp severs the feedback arm.

**Explanation (as shipped).**

> This Organ Systems item tests negative feedback in the hormonal control of exocrine pancreatic secretion. The answer is C because holding the lumen at pH 3.0 removes the one event that would normally switch the loop off. Acid arriving from the stomach triggers release of this peptide from cells in the intestinal wall, and the peptide calls for a watery, bicarbonate rich juice from the duct cells of the pancreas. That juice raises luminal pH, and a raised pH is exactly the condition under which further release stops. The loop therefore closes on itself: the response abolishes the very stimulus that produced it. That is why the normal burst is brief, and why the quantity released tracks the acid load delivered rather than running on indefinitely. In this preparation the buffer fixes pH regardless of how much base the duct cells deliver, so the off switch never arrives and release continues for as long as acid is infused. The effector arm is working perfectly, as the sustained duct output shows. It is the feedback arm alone that the experiment has cut, and separating those two arms is the whole point of the manipulation.
>
> (Choice A) Bicarbonate does reach the lumen here, and in an intact animal that delivery would end the episode within minutes. It ends the episode only by changing pH, however, and pH cannot change in this preparation, so delivery by itself is not sufficient to shut off release.
>
> (Choice B) Fat arriving in this region triggers a different duodenal peptide, the one that calls for enzyme rich juice and gallbladder emptying. This animal is receiving acid alone and no meal, so that trigger is never engaged.
>
> (Choice D) Endocrine cells of the gut wall do not fatigue over a single hour of stimulation. A falling level would require the stimulus to be withdrawn or the cells to be destroyed, and neither occurs in this setup.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to predict how a hormone's time course changes when an experimental manipulation prevents that hormone's own effect from acting back on the signal that released it.

---

## B2-Q6 . Duodenal acid restrains gastric acid output

**Stem.** In a perfused preparation, the stomach and the first segment of the small intestine share one blood supply, but their lumens are sealed off from one another so that nothing placed in either can pass into the other. A protein rich mixture is placed in the stomach and the acid the stomach produces is collected and titrated. The run is then repeated with the same mixture in the stomach while dilute acid is perfused through the lumen of the intestinal segment. Compared with the first run, acid output from the stomach during the second run will most likely be which of the following?

- **A.** Lower, since acid bathing the duodenum releases a peptide into the blood that restrains the parietal cells  <- **KEY**
- **B.** Higher, since a duodenum held at low pH calls for a faster supply of acid to keep digestion moving
- **C.** Unchanged, since the parietal cells answer only to conditions inside the stomach itself
- **D.** Lower, since bicarbonate called for by the duodenum reaches the stomach and neutralises the acid before it is collected

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 90 s |
| Confidence | 5 |

**Correct answer (A): Lower, since acid bathing the duodenum releases a peptide into the blood that restrains the parietal cells**

Citations: AP:32834, AP:47509, AP:48953

**Distractors**

- **(B)** `reversed_relationship`: Reverses the sign of the feedback: acid downstream calls for less acid delivery, not more.
  - Citation: AP:32834
- **(C)** `misconception`: Treats gastric acid output as answering only to local stimuli, ignoring the blood borne signal from downstream.
  - Citation: AP:47509
- **(D)** `process_step_confusion`: Puts pancreatic bicarbonate in the wrong compartment; it enters the intestinal lumen, and the sealed lumens block any transfer.
  - Citation: AP:48953

**Readback check.** Content words of six or more letters in key A: bathing, duodenum, releases, peptide, restrains, parietal. Stem words include perfused, preparation, stomach, supply, lumens, sealed, nothing, placed, protein, mixture, produces, collected, titrated, repeated, dilute, through, segment, intestine, compared, output. No overlap. The stem never states that anything downstream can act on the stomach, so the key must be built from the shared blood supply plus the sealed lumens.

**Explanation (as shipped).**

> This Organ Systems item tests the cross organ arm of the acid triggered duodenal signal. The answer is A because the acid perfused through the intestinal lumen releases a peptide that circulates back to the stomach and cuts acid production there, and the shared blood supply is the only route left by which the two organs can still influence each other. Acid arriving in the first segment of the small intestine is sensed by endocrine cells in its wall, which put secretin into the blood. The best known job of that peptide is to call for a watery, bicarbonate rich juice from the duct cells of the pancreas, which titrates the acid already delivered. It has a second job as well: it acts back on the stomach and damps the output of hydrochloric acid. The two jobs pull in the same direction. One removes acid that has already arrived; the other cuts the supply at its source, so that less acid arrives in the first place. This preparation is built to expose the second job on its own. The stomach's own stimulus, protein sitting in its lumen, is identical in both runs, and no fluid can move between the lumens, so any fall in the acid the stomach produces must have been carried by the blood.
>
> (Choice B) This reverses the sign of the signal. Acid persisting in the intestinal lumen reports that the load already delivered exceeds what has been neutralised, and the useful response is to slow the supply rather than to raise it.
>
> (Choice C) Distension and protein in the stomach are genuine stimuli for acid output, but they are not the only inputs. Conditions downstream feed back on the stomach as well, which is exactly what this preparation is designed to reveal.
>
> (Choice D) Pancreatic bicarbonate is delivered into the intestinal lumen, not into the stomach, and the sealed lumens forbid any movement between the two here. What is measured is also the acid the stomach produces, not the acid that survives downstream.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to attribute a change in one organ's output to a blood borne signal after the design has closed off every other route between the two organs.

---

## B2-Q7 . Dual organ targets of one signal

**Stem.** A researcher infuses a synthetic peptide into a fasting animal. Within minutes the muscular sac tucked beneath the liver squeezes down, and fluid entering the small intestine proves rich in digestive enzymes yet no more alkaline than before. Which luminal event does this peptide most likely reproduce?

- **A.** A drop in pH as gastric contents cross into the small intestine
- **B.** Stretch of the stomach wall as meal volume builds
- **C.** Glucose accumulating in the lumen as starch is broken down
- **D.** Fatty acids and amino acids arriving from a meal rich in fat and protein  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 65 s |
| Confidence | 5 |

**Correct answer (D): Fatty acids and amino acids arriving from a meal rich in fat and protein**

Citations: AP:48433, AP:48888, AP:50663, BIO:45306

**Distractors**

- **(A)** `adjacent_fact`: Names the real trigger for the neighbouring duodenal hormone, whose secretion would have raised alkalinity rather than enzyme content.
  - Citation: AP:48953
- **(B)** `process_step_confusion`: Steps back to the gastric phase: distension drives gastrin and acid output, not gallbladder contraction, and the fasting animal has nothing in the stomach to stretch.
  - Citation: AP:32834
- **(C)** `misconception`: Assumes a carbohydrate load calls for bile and enzyme delivery, which it does not.
  - Citation: AP:50663

**Readback check.** Content words of six or more letters in key D: arriving, protein. Stem words include researcher, infuses, synthetic, peptide, fasting, animal, minutes, muscular, tucked, squeezes, entering, intestine, digestive, enzymes, alkaline, luminal, reproduce. No overlap; the stem word peptide forced the key to read amino acids rather than short peptides. The stem names no hormone and no trigger, so the answer must be reconstructed from the pattern of effects.

**Explanation (as shipped).**

> This Organ Systems item tests recognition of the duodenal signal that coordinates two separate deliveries from two separate organs. The answer is D because contraction of the gallbladder paired with an enzyme rich but not notably alkaline secretion is the fingerprint of the signal released by the fat and protein content of a meal. Cells in the wall of the duodenum respond to fatty acids and amino acids in the lumen by releasing cholecystokinin into the blood. That hormone acts on two targets at once. At the pancreas it drives the acinar cells, which supply the digestive enzymes, rather than the duct cells, which supply the watery bicarbonate. At the gallbladder it drives contraction of the smooth muscle of the wall, pushing the stored contents down the duct system into the duodenum. Both deliveries are worth making only when fat and protein are actually present, which is why their arrival, and not the arrival of a meal in general, is the trigger. The absence of any rise in alkalinity is the detail that separates this signal from the acid triggered one.
>
> (Choice A) A falling pH is the trigger for the other duodenal peptide, and the secretion that follows it is watery and rich in bicarbonate. The fluid described here gained no alkalinity at all, which rules that trigger out.
>
> (Choice B) This steps back to the gastric phase. Distension of the stomach wall drives gastrin release and gastric acid output; it does not empty the gallbladder, and this animal is fasting with nothing in the stomach to stretch it.
>
> (Choice C) Products of starch breakdown do not command gallbladder contraction. A glucose load in the lumen calls for none of the deliveries observed in this experiment.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to infer an upstream trigger from the specific combination of downstream responses that were observed.

---

## B2-Q8 . Fat load, CCK and stomach exit rate

**Stem.** Four test meals of equal volume and equal energy content were given to the same volunteers on separate days, differing only in the share of energy supplied as fat. Blood CCK at 30 minutes and the time needed to clear half the meal from the stomach were measured.

| Meal | Fat (% of energy) | CCK in blood (pmol/L) | Time to clear half the meal (min) |
|---|---|---|---|
| 1 | 5 | 2 | 45 |
| 2 | 20 | 6 | 78 |
| 3 | 40 | 11 | 120 |
| 4 | 60 | 15 | 155 |

Meal 4 is then repeated while the volunteers receive a drug that prevents CCK from acting on its target tissues. Which result best fits the pattern in the table?

- **A.** Roughly 155 min to clear half the meal, with CCK near 15 pmol/L
- **B.** Roughly 50 min to clear half the meal, with CCK near 15 pmol/L  <- **KEY**
- **C.** Roughly 50 min to clear half the meal, with CCK near 2 pmol/L
- **D.** Roughly 120 min to clear half the meal, with CCK near 11 pmol/L

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 110 s |
| Confidence | 4 |

**Correct answer (B): Roughly 50 min to clear half the meal, with CCK near 15 pmol/L**

Citations: AP:47511, AP:48254, AP:50663

**Distractors**

- **(A)** `misconception`: Assumes fat retards stomach clearance physically, so that silencing the hormone's action would change nothing.
  - Citation: AP:48254
- **(C)** `reversed_relationship`: Treats the hormone level as a result of slow clearance rather than its cause, so it wrongly predicts the level falls.
  - Citation: AP:50663
- **(D)** `partial_truth`: Right direction but incomplete: it shifts the result one table row instead of removing the response entirely.
  - Citation: AP:47511

**Readback check.** Content words of six or more letters in key B: roughly. The phrase clear half the meal is shared by all four choices as scaffolding and therefore discriminates nothing. The key's clearance value of about 50 min appears nowhere in the table, so it cannot be read off; the retained value of 15 pmol/L must be justified by reasoning about where in the chain the drug acts.

**Explanation (as shipped).**

> This Organ Systems item tests the use of paired measurements to identify a hormone as the mediator of an observed effect. The answer is B because the drug cuts the last link in the chain while leaving the first two links untouched. Across the four meals, fat share, hormone level and stomach clearance time rise together, which is consistent with a chain running from luminal fat to hormone release to a restraining influence on the stomach. Silencing the target tissues does not stop the lining of the duodenum from sensing fat and putting the hormone into the blood, so a meal with 60 percent of its energy as fat should still push the measured level to about 15 pmol/L. What the drug removes is the ability of the target tissue to respond, so the restraint disappears and the meal should leave at roughly the pace of the fat poor meal, near 45 to 50 min. That is the physiological point of the loop: the more fat that has already arrived, the slower the rate at which the rest is permitted to follow, so delivery stays matched to the capacity available to process it.
>
> (Choice A) This predicts no change at all, which would mean fat slows clearance by its bulk or its physical properties rather than through a signal. If that were true, silencing the hormone's action could not matter, yet the tight pairing of hormone level with clearance time across the table points to a mediated effect.
>
> (Choice C) This treats the hormone level as a downstream consequence of slow clearance rather than its cause. The drug acts on the tissues receiving the message, not on the cells sending it, so the measured level should not collapse.
>
> (Choice D) This concedes only a partial effect, shifting the response one row up the table as though the drug had reduced the fat content of the meal. Silencing the response removes it rather than scaling it back by one step, and the fat delivered is unchanged.
>
> This is a Data-based and Statistical Reasoning question because it asks the student to read a trend across two paired columns and then predict both values for a condition that does not appear in the table.

---

## B2-Q9 . Route dependent amplification of nutrient signalling

**Stem.** On two separate days, healthy volunteers took in sugar by two different routes. On one day they swallowed 50 g of sugar. On the other day sugar was delivered into a forearm vein, and the infusion rate was adjusted continuously so that the blood sugar curve reproduced the swallowed day point for point. Plasma insulin was measured as the readout.

| Time (min) | Blood sugar, swallowed (mg/dL) | Blood sugar, vein (mg/dL) | Insulin, swallowed (uU/mL) | Insulin, vein (uU/mL) |
|---|---|---|---|---|
| 0 | 88 | 88 | 9 | 9 |
| 30 | 141 | 140 | 74 | 38 |
| 60 | 128 | 129 | 62 | 30 |
| 120 | 96 | 95 | 21 | 12 |

Which conclusion do these paired curves support?

- **A.** The swallowed load was taken up faster, so it drove a higher peak blood sugar level than the vein load did.
- **B.** Starch breakdown beginning in the mouth released extra absorbable sugar that the vein route could not supply.
- **C.** Passage of the load through the gut lumen liberates a circulating messenger that acts in addition to the rise in blood sugar itself.  <- **KEY**
- **D.** Blood sugar concentration is the only stimulus at work, and the swallowed day simply exposed the target to that stimulus for longer.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 105 s |
| Confidence | 5 |
| Hard-tier gate | (b) requires a quantitative and directional inference from paired curves rather than a lookup; (c) choices A and D remain defensible until the student notices that the two sugar columns are deliberately matched; (d) inverts the usual direction of reasoning by supplying an outcome gap and asking for its cause. |

**Correct answer (C): Passage of the load through the gut lumen liberates a circulating messenger that acts in addition to the rise in blood sugar itself.**

Citations: AP:48437 (intestinal gland K cells secreting glucose dependent insulinotropic peptide), AP:32915 (gut derived GIP and GLP-1 acting on pancreatic beta cells to release insulin)

**Distractors**

- **(A)** `misconception`: Students commonly assume the oral route gives a sharper sugar spike, but the infusion was titrated so the two sugar curves match at every time point (141 against 140, 128 against 129).
  - Citation: AP:48437
- **(B)** `adjacent_fact`: Salivary starch digestion is true but irrelevant here: the load was already sugar, and extra absorbed sugar would have raised the swallowed day curve above the vein day curve, which it did not.
  - Citation: AP:48437
- **(D)** `partial_truth`: Sugar level is a genuine stimulus, but the choice claims it is the only one; it was matched in magnitude and duration on both days, so exclusivity predicts identical readouts rather than the persistent twofold difference observed.
  - Citation: AP:32915

**Readback check.** Key content words of six or more letters: Passage, through, liberates, circulating, messenger, addition, itself. None appears in the stem. Stem words of six or more letters include separate, healthy, volunteers, different, routes, swallowed, delivered, forearm, infusion, adjusted, continuously, reproduced, plasma, insulin, measured, readout, conclusion, paired, curves, support. No overlap; the key cannot be produced by copying stem language, and no value in the table is itself the answer. The key states a causal inference the stem never asserts.

**Explanation (as shipped).**

> This Organ Systems item tests the incretin principle: using two routes of nutrient delivery to isolate a contribution that originates in the gut rather than in the bloodstream. The answer is C because the two blood sugar curves are essentially superimposable while the measured readout on the swallowed day runs roughly twice as high, so the extra output cannot be attributed to the sugar level and must arise from a factor generated when the load travelled along the gut lumen. The design deliberately clamps one variable: by titrating the infusion until the vein day traced the swallowed day point for point, the investigators removed sugar concentration as a possible explanation for any difference that remained. At 30 minutes both days sit near 140 mg/dL, yet the readout is 74 against 38, and a similar twofold gap persists at 60 and at 120 minutes. A difference that survives after the stimulus has been matched in both magnitude and duration points to a second, additive stimulus present on one day only. Cells scattered through the lining of the upper small bowel discharge peptides when nutrients physically transit past them, and those peptides travel in the blood to reach their target, which is exactly the extra input this paired design exposes. (Choice A) Faster uptake would show up as higher values in the second column, and it does not: 141 against 140 at 30 minutes, then 128 against 129 at 60 minutes. The matched curves were engineered specifically to exclude this reading. (Choice B) Salivary breakdown of starch is real, but the material given here was already sugar, and any extra absorbable sugar it released would have lifted the swallowed day curve above the vein day curve. The table shows no such separation. (Choice D) This choice is false rather than merely incomplete, because it asserts that sugar concentration is the only stimulus at work. Sugar concentration was matched in both level and duration across the two days, so an exclusive account predicts identical readouts, yet the readouts differ roughly twofold at every sampling point after baseline. This is a Data-based and Statistical Reasoning question because it asks the student to identify which column was experimentally held equal, quantify the gap in the column that was not, and infer an unmeasured circulating signal from the size and persistence of that gap.

---

## B2-Q10 . Anticipatory stomach signal versus fuel gauge

**Stem.** Volunteers on a fixed meal schedule had a peptide made in the stomach lining measured every 20 minutes. Its level climbed steadily between meals, reached its highest value in the sample drawn immediately ahead of each scheduled meal, and fell by more than half within an hour of the first bite. On a separate day the volunteers were told that the next meal would be served two hours later than usual, and the high point shifted to match the new time. What does this pattern indicate about the quantity the peptide reports?

- **A.** It encodes a prediction of when food will arrive, so it can drive food seeking in advance of any shortfall in stored fuel.  <- **KEY**
- **B.** It reports how much fuel is on hand, rising as reserves run down and falling once they are replenished.
- **C.** It operates over weeks, setting long term body mass rather than the timing of any one meal.
- **D.** It is released only once nutrients reach the small bowel, so the rise ahead of a meal is the tail of the previous one.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic secondary / structural two_step) |
| Estimated time | 85 s |
| Confidence | 5 |

**Correct answer (A): It encodes a prediction of when food will arrive, so it can drive food seeking in advance of any shortfall in stored fuel.**

Citations: AP:48117 (ghrelin from stomach mucosa, secreted in the fasting state with levels increasing just prior to meals, acting on the hypothalamus to regulate food intake), BIO:45004 (signals of hunger and satiety controlled in the hypothalamus)

**Distractors**

- **(B)** `misconception`: The widely held fuel gauge reading cannot explain a high point that moves when only the announced meal time changes, nor a fall that is more than half complete within an hour of the first bite.
  - Citation: AP:48117
- **(C)** `scale_unit_error`: Correct logic applied at the wrong timescale: the measured pattern resolves tens of minutes and is locked to individual meals, not to week by week regulation of body mass.
  - Citation: BIO:45004
- **(D)** `process_step_confusion`: Names the wrong stage of the tract and the wrong trigger; the signal originates proximally in the stomach lining and is highest when the tract is empty, not after material moves downstream.
  - Citation: AP:48117

**Readback check.** Key content words of six or more letters: encodes, prediction, arrive, seeking, advance, shortfall, stored. None appears in the stem. Stem words of six or more letters include Volunteers, schedule, peptide, stomach, lining, measured, minutes, climbed, steadily, between, reached, highest, sample, immediately, scheduled, within, separate, served, shifted, pattern, indicate, quantity, reports. No overlap, and the key supplies an interpretation (a prediction driving intake ahead of a deficit) that the stem never states.

**Explanation (as shipped).**

> This Organ Systems item tests what the time course of a hormone reveals about the variable it encodes, using a stomach derived appetite signal. The answer is A because the high point relocates when the only thing that changed was the announced timing of the next meal, and an announcement alters nothing about the body's stored fuel. Two features of the record separate a forecast from a measurement. A gauge of stored fuel can change only when stored fuel changes, so it should be completely indifferent to being told that the meal has moved, and it should keep falling for several hours after eating while absorption slowly rebuilds the reserve. Neither holds here: the whole waveform moves with the expectation, and the decline begins essentially at the first bite and is more than half complete within an hour. The controlled variable is therefore the predicted delivery of food rather than the present state of the body's supply, which is the signature of a feed forward, anticipatory arm of control that prepares the animal to seek and take in food ahead of any registered deficit. (Choice B) This is the intuitive reading, and the climb between meals is consistent with it. It fails the decisive test: no account based on depletion of reserves can explain why merely announcing a later meal moves the high point, since the announcement changes no reserve. (Choice C) Long term regulation of body mass is a real control problem, but it is handled over weeks by different signals. The record here resolves changes over tens of minutes and is locked to individual meals, so the timescale in this choice is wrong by orders of magnitude. (Choice D) This misplaces both the site and the trigger of release. The peptide is made proximally, in the stomach lining, not in the small bowel, and its highest values occur when the tract is emptiest rather than after material has moved downstream. This is a Scientific Reasoning and Problem Solving question because it asks the student to use the shape of the rise and fall, together with the effect of moving the announced meal time, to decide between two competing meanings for one hormonal signal.

---

## B2-Q11 . Why the final digestive phase inhibits

**Stem.** The last phase of gastric control is set off when chyme distends the duodenum, and on balance it slows emptying and damps secretion rather than driving them. A student objects that ending a control sequence with a phase made mostly of brakes wastes an opportunity. What is the strongest functional justification for the arrangement?

- **A.** Holding material back gives the stomach longer to reduce the meal to fine particles, the step that limits the whole process.
- **B.** The receiving segment can neutralise and work on only so much material per minute, so it must be able to throttle what is sent to it.  <- **KEY**
- **C.** Quicker delivery would raise the fraction of a meal taken up, so the brakes exist to hold total uptake down.
- **D.** The braking signals act over days, setting how often meals are taken rather than governing the meal presently in transit.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 65 s |
| Confidence | 5 |

**Correct answer (B): The receiving segment can neutralise and work on only so much material per minute, so it must be able to throttle what is sent to it.**

Citations: AP:48193 (the intestinal phase of gastric secretion has both excitatory and inhibitory elements; when the intestine distends with chyme the enterogastric reflex inhibits secretion and closes the pyloric sphincter), BIO:45260 (three overlapping phases of gastric control)

**Distractors**

- **(A)** `partial_truth`: Extra mechanical reduction really does occur during the delay, but the brake is triggered by what has reached the receiving segment rather than by particle size, and it is applied even to an already liquid meal.
  - Citation: AP:48193
- **(C)** `reversed_relationship`: Relates the variables in the wrong direction: restraint preserves uptake rather than limiting it, because material delivered faster than it can be handled escapes processing.
  - Citation: AP:48193
- **(D)** `scale_unit_error`: Right reasoning at the wrong timescale; this feedback acts within a single meal, minute by minute, not over days to set meal frequency.
  - Citation: BIO:45260

**Readback check.** Key content words of six or more letters: receiving, segment, neutralise, material, minute, throttle. None appears in the stem. Stem words of six or more letters include gastric, control, distends, duodenum, balance, emptying, secretion, driving, student, objects, ending, sequence, brakes, mostly, wastes, opportunity, strongest, functional, justification, arrangement. No overlap, and the stem never states the throughput matching argument that the key supplies.

**Explanation (as shipped).**

> This Organ Systems item tests the design logic of the terminal phase of gastric control, in which inhibition rather than stimulation predominates. The answer is B because the compartment that receives the material has a ceiling on how fast it can buffer, dilute and act on what arrives, and the dependable way to defend that ceiling is a signal running backwards from the consumer to the supplier. Any control system feeding a rate limited downstream stage needs negative feedback from the stage that carries the load. The stomach can present material far faster than the next compartment can cope with: acid has to be buffered, a concentrated load has to be diluted with secreted fluid, and enzymes have to be delivered and given time to act. If delivery outran that ceiling, poorly buffered and poorly diluted material would sweep past the surface where it could be handled, and net uptake would fall even though the meal was moving faster. Braking is therefore not a wasted opportunity but the mechanism that matches supply to throughput, and it belongs last because only the receiving compartment can register how much has already arrived. (Choice A) Extra mechanical reduction does continue while material is retained, so this is a genuine side benefit rather than the justification. The brake is generated by what has reached the receiving segment rather than by particle size in the stomach, and it is applied even to a meal that is already liquid and needs no further mechanical reduction. (Choice C) This reverses the purpose of the restraint. Slowing delivery protects uptake rather than limiting it, because material presented faster than it can be handled passes the absorbing surface in a form that cannot be taken up. (Choice D) The feedback here operates minute by minute during a single meal and is generated by material currently in the tract. Setting how frequently meals are taken is a far slower control problem handled by separate signals. This is a Knowledge of Scientific Concepts and Principles question because it asks the student to apply the general principle that a downstream compartment with a limited processing rate must be able to govern its own rate of input.

---

## B2-Q12 . Division of secretory labour within pancreas

**Stem.** The exocrine pancreas is built from grape-like end clusters whose cells are packed with secretory granules of digestive enzymes, and these clusters empty into a branching tree of fine tubes lined by a flatter cell type. In a healthy adult, a meal rich in fat and amino acids drives heavy granule release from the end clusters, whereas a strongly acidic load drives a large watery, alkaline flow from the tube lining. What does this separation of control allow the gland to do?

- **A.** Vary the ratio of catalyst to buffer in what it delivers, not merely how much juice it delivers.  <- **KEY**
- **B.** Raise the granule content of the juice when acid arrives, and raise its volume when fat and amino acids arrive.
- **C.** Change only the total quantity of juice delivered, since both cell types are always recruited together.
- **D.** Generate, from the tube lining, the pressure that opens the muscular gate at the intestinal opening.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 70 s |
| Confidence | 5 |

**Correct answer (A): Vary the ratio of catalyst to buffer in what it delivers, not merely how much juice it delivers.**

Citations: AP:48920; AP:48936; AP:48953; AP:48955

**Distractors**

- **(B)** `reversed_relationship`: It pairs the right two stimuli with the wrong two outputs. Acid recruits the fluid and buffer arm, and fat plus amino acids recruit the granule arm, so this choice inverts the direction of both relationships.
  - Citation: AP:48953
- **(C)** `misconception`: Students often assume a gland has one secretion whose volume is the only variable. If both populations were locked together the composition would be fixed, which is precisely what the described architecture avoids.
  - Citation: AP:48936
- **(D)** `adjacent_fact`: Control of outflow into the intestine belongs to a smooth muscle sphincter at the shared opening, not to the secretory epithelium, and this statement does not address why the organ needs two cell types.
  - Citation: AP:48923

**Readback check.** Key A content words of six or more letters: catalyst, buffer, delivers. None of these appears in the stem, whose long words are exocrine, pancreas, clusters, secretory, granules, digestive, enzymes, branching, flatter, healthy, amino, acids, granule, release, strongly, acidic, watery, alkaline, lining, separation, control. No overlap, and the key names a consequence of separate control, a variable ratio of product to fluid, that the stem never states.

**Explanation (as shipped).**

> This Organ Systems item tests the functional logic behind splitting exocrine pancreatic secretion across two separately controlled cell populations. The answer is A because two independently driven arms let one gland change what its juice is made of, not merely how much of it arrives. The granule filled end clusters contribute the catalytic component of the juice, while the flatter cells lining the fine tubes contribute the watery, buffer rich fluid that carries it. Since fat and amino acids recruit the first population and acid recruits the second, the organ can send out a large, weakly catalytic, strongly buffering flow when a very acidic load arrives, and a smaller, catalytically dense flow when the load is mostly substrate. If one cell type performed both jobs, the only available adjustment would be to turn a single fixed recipe up or down, so the proportion of catalyst to buffer would be locked no matter what the intestine received. The two population design is therefore not redundancy, it is the mechanism by which a single duct can carry two different things in two different proportions. (Choice B) reverses the pairing given in the setup, since the acidic stimulus drives the fluid arm and the nutrient stimulus drives the granule arm, and swapping them would flood an acidic intestine with catalyst and a protein rich one with plain fluid. (Choice C) asserts the opposite of what separate control means, and a gland built that way could vary only how much juice it made, never what was in it. (Choice D) describes a plumbing function that belongs to the smooth muscle gate at the shared intestinal opening rather than to the secretory epithelium, and even if it were true it would say nothing about why two distinct cell types exist. This is a Knowledge of Scientific Concepts and Principles question because it asks the student to apply the general principle that separately regulated secretory populations give a gland control over the makeup of its product rather than only over its quantity.

---

## B2-Q13 . Timing of alkaline delivery to duodenum

**Stem.** A researcher perfuses an anaesthetised animal's proximal duodenum with acidic chyme at a constant rate through an indwelling catheter and leaves the gut free to contract. A dose of pancreatic protease labelled with a non-absorbable dye is delivered through that same catheter at time zero. Sodium bicarbonate is then delivered through the catheter either at time zero or twenty minutes later. With simultaneous delivery, the dyed segment measures pH 7.3. With the delay, the dyed segment still measures pH 2.4 at every sampling point after the bicarbonate went in, while a segment nearer the stomach reads pH 7.6 at those same sampling points. What explains the failure of the late dose to reach the dyed segment?

- **A.** Bicarbonate crosses the duodenal wall within seconds of entering, so a late dose is taken up before it can act on anything.
- **B.** Luminal contents advance steadily in one direction, so a dose given later trails behind the tagged bolus and never mixes back into it.  <- **KEY**
- **C.** The continuous acid perfusion consumed the entire late dose before it could raise pH anywhere in the gut.
- **D.** Chyme is normally brought to neutral pH while still in the stomach, so bicarbonate placed beyond it acts at the wrong stage whatever the timing.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 100 s |
| Confidence | 4 |

**Correct answer (B): Luminal contents advance steadily in one direction, so a dose given later trails behind the tagged bolus and never mixes back into it.**

Citations: AP:48936; AP:48938; AP:48524

**Distractors**

- **(A)** `misconception`: Instant absorption of luminal bicarbonate is not what happens, and the claim is directly contradicted by the pH 7.6 zone recorded in the same animal at the same sampling points.
  - Citation: AP:48936
- **(C)** `partial_truth`: Some of the late dose is indeed consumed by the incoming acid, but not all of it, since a zone at pH 7.6 was still detectable, so consumption cannot be the whole account.
  - Citation: AP:48938
- **(D)** `process_step_confusion`: It assigns the correction of pH to the gastric stage. Acidification happens there and the upward adjustment happens after emptying, so this reverses the order of two steps and does not address the spatial separation observed.
  - Citation: AP:48524

**Readback check.** Key B content words of six or more letters: Luminal, contents, advance, steadily, direction, behind, tagged. None appears in the stem, whose long words are researcher, perfuses, anaesthetised, animal's, proximal, duodenum, acidic, chyme, constant, through, indwelling, catheter, contract, pancreatic, protease, labelled, absorbable, delivered, sodium, bicarbonate, twenty, minutes, simultaneous, delivery, segment, measures, sampling, stomach, explains, failure. The stem says labelled and dyed where the key says tagged, so there is no lexical overlap, and the key must be inferred from the misplaced alkaline zone rather than read off.

**Explanation (as shipped).**

> This Organ Systems item tests the delivery problem created by the fact that the buffering arm and the granule arm of pancreatic juice leave the gland through one opening, and it is answered from the geometry of a moving lumen rather than from any chemical property of what was instilled. The answer is B because gut contents travel as a one way procession, so material added twenty minutes late joins a different parcel of that column and simply follows the earlier parcel downstream. The dye marks one parcel and travels with it. During the twenty minute wait that parcel is carried well past the catheter tip, so the alkali is deposited into fluid that is behind it and moving in the same direction at roughly the same speed, which is why it never catches up. The reading of pH 7.6 nearer the stomach is the decisive observation, because the alkali plainly did raise pH somewhere, just in the wrong parcel of fluid. This is why the alkaline component of pancreatic juice must be delivered with, or ahead of, the granule component through the same opening, since a buffer that arrives afterwards is chasing contents it can no longer overtake. (Choice A) states a common belief about how bicarbonate is handled but is refuted by the data, because a dose that vanished into the wall within seconds could not have produced a zone at pH 7.6. (Choice C) is defensible until that same measurement is applied, since a dose fully neutralised by the incoming acid would leave no alkaline zone anywhere, and one was found. (Choice D) puts neutralisation at the wrong stage, since the gastric compartment is where the load is acidified and the correction happens downstream of it, so moving that step upstream does not explain a spatial separation within the gut. This is a Scientific Reasoning and Problem Solving question because it asks the student to use one internal contradiction in the measurements, an alkaline zone in the wrong place, to reject the chemical explanations and settle on a transport and timing explanation.

---

## B2-Q14 . Anion exchange and blocked ductal secretion

**Stem.** Duct cells of the exocrine pancreas run a carrier on the duct face that expels one buffering anion into the fluid for every chloride ion it draws into the cell, and a second protein in that same face feeds chloride back out to keep the carrier stocked. When that second protein is absent from the membrane, the gland's secretion becomes thick and clogs the small ducts, and the granule products made upstream are held back inside the organ. An experimental compound inserts an unrelated anion channel into the duct face of cells that lack the missing protein. What change in secretion is predicted, and on what basis?

- **A.** Output volume falls, because the added anion flow drives the carrier backwards and pulls the buffering anion into the cell.
- **B.** Output volume is unchanged, because water crosses this epithelium through dedicated pores whose flow is set independently of solute movement.
- **C.** Output volume rises, because the swap can resume once its partner ion is available in the duct fluid again, and water follows the osmotic load.  <- **KEY**
- **D.** Output volume rises only after several weeks, because the compound acts by raising synthesis of the carrier rather than by changing ion flow.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic secondary / structural multi_step) |
| Estimated time | 110 s |
| Confidence | 4 |
| Hard-tier gate | Hard on three counts. (a) It combines secondary active anion exchange with osmotic water flow across an epithelium. (b) It demands a directional prediction about secretion volume, not a lookup. (c) Choices A and B stay defensible until the student decides which substrate the exchanger needs and whether water moves independently of solute. |

**Correct answer (C): Output volume rises, because the swap can resume once its partner ion is available in the duct fluid again, and water follows the osmotic load.**

Citations: AP:4688; AP:48936; AP:48938; AP:54942

**Distractors**

- **(A)** `reversed_relationship`: It treats the incoming substrate of the exchanger as if it were the product, so restoring duct side chloride is predicted to reverse the carrier when in fact it is exactly what drives it forward.
  - Citation: AP:4688
- **(B)** `misconception`: Epithelial water flow is not set independently of solutes. Water follows the osmotic gradient created by the exported anion, so a change in that export necessarily changes fluid output.
  - Citation: AP:48936
- **(D)** `scale_unit_error`: The reasoning is applied at the wrong level and timescale. Inserting a conductance alters ion flux in minutes, whereas this choice describes a change in protein synthesis playing out over weeks.
  - Citation: AP:4688

**Readback check.** Key C content words of six or more letters: Output, volume, resume, partner, available, osmotic. None appears in the stem, whose long words are exocrine, pancreas, carrier, expels, buffering, chloride, protein, membrane, secretion, granule, products, upstream, experimental, compound, inserts, unrelated, channel, predicted. No overlap, and the prediction requires chaining exchange to water movement rather than restating the setup.

**Explanation (as shipped).**

> This Organ Systems item tests the ion exchange that generates the watery alkaline arm of pancreatic juice and the failure that follows when its supporting anion channel is lost. The answer is C because the carrier is an exchanger, so it can only export one anion if the partner anion keeps arriving on the duct side, and any route that resupplies that partner restores the whole sequence. In an intact duct cell the missing protein is a recycling loop: it returns chloride to the duct fluid so the exchanger can pick it up again and push out another buffering anion. Remove that loop and chloride on the duct side is quickly exhausted, the exchanger stalls, the alkaline solute stops entering the fluid, and the water that would have followed that solute osmotically never appears. What remains in the duct is the concentrated granule product with too little fluid to carry it, which is why the secretion thickens and the ducts plug. Restoring any luminal anion conductance re-establishes the recycling step, the exchanger turns over again, solute enters, and water flow returns, which is the logic behind supplying a replacement conductance when the native one is missing. (Choice A) links the right variables in the wrong direction, since supplying the exchanger's incoming substrate promotes forward turnover rather than reversing it. (Choice B) rests on the belief that epithelial water movement is independently regulated, whereas water follows the osmotic gradient that the transported solute creates. (Choice D) applies correct reasoning at the wrong timescale and the wrong level, because inserting a channel changes ion flux within minutes and does not work by altering how much carrier protein the cell builds. This is a Scientific Reasoning and Problem Solving question because it asks the student to trace a directional chain from one restored ion supply through exchanger turnover to osmotic water flow and predict the effect on secretion volume.

---

## B2-Q15 . Attributing a juice change to one cell arm

**Stem.** An investigator tests whether a new compound stimulates the granule secreting cell population of the exocrine pancreas. Juice is sampled from the gland's duct after a standard meal, once without the compound and once during it, and the level of a granule protein in that juice is reported for each run. The level doubles under the compound, and the investigator concludes that the granule cells were stimulated. What additional measurement is required before that conclusion can stand?

- **A.** Confirm that the compound actually reaches the gland by assaying it in pancreatic tissue, since a substance absent from the organ cannot act on it.
- **B.** Confirm that a second granule marker rose by the same factor, since two markers moving together establish that those cells were the source.
- **C.** Confirm that the compound leaves the sample's pH unchanged, since protein readings are not valid in an alkaline sample.
- **D.** Track the volume of juice obtained over the same interval, since a fall in the watery arm alone would raise a dissolved solute's level with no extra output from the cells in question.  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **medium** (topic secondary / structural two_step) |
| Estimated time | 95 s |
| Confidence | 4 |

**Correct answer (D): Track the volume of juice obtained over the same interval, since a fall in the watery arm alone would raise a dissolved solute's level with no extra output from the cells in question.**

Citations: AP:48920; AP:48936; AP:48938; AP:48953

**Distractors**

- **(A)** `adjacent_fact`: Verifying that the compound reaches the organ is good practice but is silent on the actual ambiguity, because a compound that is present in the tissue could still be acting on the fluid arm rather than the granule arm.
  - Citation: AP:48920
- **(B)** `partial_truth`: Two markers rising together does show the change is not an artefact of one assay, but a reduction in fluid concentrates all dissolved granule products equally, so marker agreement is predicted by the rival explanation too and cannot discriminate.
  - Citation: AP:48936
- **(C)** `misconception`: It rests on a false premise, since pancreatic juice is normally mildly alkaline and protein quantitation in such a sample is routine, so pH is not the obstacle to the investigator's conclusion.
  - Citation: AP:48938

**Readback check.** Key D content words of six or more letters: volume, obtained, interval, watery, dissolved, solute's, output, question. None appears in the stem, whose long words are investigator, whether, compound, stimulates, granule, secreting, population, exocrine, pancreas, sampled, gland's, standard, without, during, protein, reported, doubles, concludes, stimulated, additional, measurement, required, conclusion. The key names a dilution confound that the stem never raises, so it cannot be read off the setup.

**Explanation (as shipped).**

> This Organ Systems item tests whether a measured change in pancreatic juice can be attributed to one of the two exocrine cell populations, which turns out to be a question about what the measurement actually is. The answer is D because the quantity reported is an amount per unit of fluid, so it rises whenever the numerator rises or the denominator falls, and only the fluid collected over the same interval separates those two possibilities. The gland's two arms are driven separately, so the watery, buffer rich arm can slow while the granule arm holds steady. When that happens, the same amount of granule product is dissolved in less fluid, and its level in the sample doubles even though the cells under test released nothing extra. Adding the fluid measurement converts the reading into an output per unit time, which is the quantity the investigator's conclusion is actually about. Without it, a compound that merely suppressed the fluid arm would be reported as a stimulant of the granule arm, which is the opposite of the truth. (Choice A) proposes a sensible general control, confirming that the compound reaches the organ, but a positive result there is compatible with both explanations and so does not resolve the ambiguity in the reading. (Choice B) is the most tempting option, since agreement between two markers feels like corroboration, yet a drop in fluid concentrates every dissolved granule product by the same factor, so two markers rising together is exactly what the rival explanation also predicts. (Choice C) rests on a false premise, because pancreatic juice is normally alkaline and protein measurements are not invalidated by that, so this adds nothing about the source of the change. This is a Reasoning about the Design and Execution of Research question because it asks the student to recognise that a concentration measurement confounds amount with dilution and to name the additional measurement that removes the confound.

---

## B2-Q16 . Gastric self-digestion and the maintained lining

**Stem.** The wall of the stomach is itself built from protein, and it sits in a fluid containing both a strong acid and a protein splitting activity capable of breaking that wall down. A patient takes a drug for several weeks that thins the slippery film covering the wall and also slows division of the stem cells that renew its innermost sheet of cells. Shallow erosions appear. Which arrangement best accounts for why this damage does not normally occur and for why it occurs now?

- **A.** The wall is made of a protein that the gastric protein splitting activity cannot cleave, and the drug converts it into a cleavable form.
- **B.** The film is impermeable to acid, so the cells beneath it never encounter a low pH, and the drug simply opens gaps in an otherwise permanent shield.
- **C.** A sheet of dead, hardened cells covers the innermost layer and absorbs the damage, and the drug prevents that sheet from forming.
- **D.** The lining has no chemical resistance of its own: a buffer loaded coating blunts the corrosive strength right at the surface, and cells lost anyway are replaced within days, so integrity depends on continuous upkeep.  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 100 s |
| Confidence | 5 |
| Hard-tier gate | (a) combines the composition of gastric juice with the turnover of the surface epithelium, two separate concepts; (c) choices B and C both stay defensible until the student notices that a fixed shield model cannot explain why slowing cell division causes injury; (d) inverts the usual direction by supplying the failure and demanding the normal arrangement. |

**Correct answer (D): The lining has no chemical resistance of its own: a buffer loaded coating blunts the corrosive strength right at the surface, and cells lost anyway are replaced within days, so integrity depends on continuous upkeep.**

Citations: AP:48201; AP:48202; AP:48204; AP:48207; AP:48215

**Distractors**

- **(A)** `misconception`: Assumes the tissue is chemically immune to its own secretions; the wall is ordinary protein and would be broken down if exposed, which is why an active defence exists.
  - Citation: AP:48201
- **(B)** `partial_truth`: The secreted layer is real but is treated as an impermeable permanent shield, which ignores its buffering action and leaves the drug's effect on cell renewal unexplained.
  - Citation: AP:48204
- **(C)** `adjacent_fact`: A sacrificial hardened dead layer genuinely protects other surfaces of the body, but this lining is a living secretory sheet protected by rapid replacement instead.
  - Citation: AP:48207

**Readback check.** Content words of six or more letters in key D: lining, chemical, resistance, buffer, loaded, coating, blunts, corrosive, strength, surface, replaced, within, integrity, depends, continuous, upkeep. Stem words of six or more letters: stomach, itself, protein, containing, strong, splitting, activity, capable, breaking, patient, several, weeks, slippery, covering, division, renew, innermost, sheet, Shallow, erosions, arrangement, accounts, damage, normally, occur, occurs. No overlap. The stem names two things the drug does but never states what either one is for, so the key cannot be produced by restating the stem.

**Explanation (as shipped).**

> This question falls under Organ Systems and tests why an organ built of protein survives daily immersion in a fluid designed to break protein down, and what happens when the arrangement that permits this is interfered with. The answer is D because the wall is not chemically special, so it must be defended by two active, ongoing processes rather than by any fixed property of the tissue itself. The first is a thick secreted layer carrying dissolved buffer, which does not have to exclude acid completely: it only has to keep the corrosive strength low in the thin zone immediately against the cells. The second is replacement, since the innermost sheet of cells is shed and rebuilt over a matter of days, so damage that does occur is outrun by construction. Both are maintenance, and maintenance can be starved. The drug in this patient degrades both at once, which is why erosions follow, and it also explains the pattern of the injury: shallow at first, because the loss begins at the exposed surface and works inward only as the deficit persists. Read the other way, if either defence alone were sufficient, a drug that impaired only one of them would be harmless, and it is not.
>
> (Choice A) Tissue protein is not exempt from attack. The stomach wall is ordinary protein and would be broken down exactly like a meal if it were exposed, which is precisely why an ongoing defence is needed at all.
>
> (Choice B) Half right, and the half it omits is what the question turns on. A secreted layer does contribute, but it works by neutralising within itself rather than by being a sealed wall, and treating it as a permanent shield leaves no reason why slowing the renewal of cells should matter, when in this patient it clearly does.
>
> (Choice C) This borrows a genuine feature of other linings. Surfaces built to take mechanical abuse do carry a sacrificial hardened layer, but the surface in question here is a living secretory sheet, and its protection comes from being rebuilt rather than from being dead.
>
> This is a Scientific Reasoning and Problem Solving question because it asks you to work backwards from a drug that disables two maintenance processes at once to the arrangement that must ordinarily be keeping an organ from consuming itself.

---

## B2-Q17 . Separating enzyme loss from bile loss

**Stem.** Two adults are evaluated for bulky, greasy stools. Neither has had abdominal surgery, both eat the same standardised diet, and both have a normal small intestinal biopsy. Laboratory results are shown below.

| Measurement | Reference | Patient 1 | Patient 2 |
|---|---|---|---|
| Faecal fat (g/day) | under 7 | 24 | 22 |
| Faecal nitrogen (g/day) | under 2 | 6.1 | 1.6 |
| Undigested starch granules | absent | present | absent |

Which conclusion is best supported by these results?

- **A.** Both have the same underlying deficiency, and patient 2 is simply at an earlier and milder stage of it.
- **B.** Patient 1 has lost a gland supplying catalysts for protein and carbohydrate as well as lipid, whereas patient 2 has lost a secretion that assists lipid handling alone.  <- **KEY**
- **C.** Patient 1 has lost a secretion that assists lipid handling alone, whereas patient 2 has lost a gland supplying catalysts for several classes of nutrient.
- **D.** The normal nitrogen value in patient 2 shows that protein handling is finished in the stomach rather than beyond it.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic secondary / structural multi_step) |
| Estimated time | 110 s |
| Confidence | 5 |
| Hard-tier gate | (a) combines the exocrine contribution of one organ with the non catalytic contribution of the biliary route; (b) requires a directional inference across three markers rather than a lookup; (c) choices A and C both stay defensible until the student notices that patient 2's nitrogen is inside the reference range while the two fat values are nearly equal. |

**Correct answer (B): Patient 1 has lost a gland supplying catalysts for protein and carbohydrate as well as lipid, whereas patient 2 has lost a secretion that assists lipid handling alone.**

Citations: AP:48936; AP:48866; AP:49165; AP:49193; AP:49214

**Distractors**

- **(A)** `partial_truth`: Correctly notes that both patients have similar fat elevation, then wrongly concludes one disease of differing severity; a milder version of the same defect could not leave nitrogen normal while fat is three times the limit.
  - Citation: AP:49214
- **(C)** `reversed_relationship`: Correct variables related in the wrong direction: the assignments of the two patients to the two sources are swapped, which contradicts the normal nitrogen and absent starch in patient 2.
  - Citation: AP:49165
- **(D)** `misconception`: A common belief that protein digestion is a gastric job; much of it occurs past the stomach, so a normal nitrogen result cannot support that claim.
  - Citation: AP:49193

**Readback check.** Content words of six or more letters in key B: supplying, catalysts, protein, carbohydrate, whereas, secretion, assists, handling. Stem words of six or more letters: adults, evaluated, greasy, stools, Neither, abdominal, surgery, standardised, intestinal, biopsy, Laboratory, results, Measurement, Reference, Faecal, nitrogen, Undigested, starch, granules, absent, conclusion, supported. No content overlap; the key deliberately says carbohydrate where the table says starch and says catalysts where no such word appears. The word patient appears in both, but only as the unavoidable label for the table columns. No value in the key is read directly off the table.

**Explanation (as shipped).**

> This question falls under Organ Systems and tests the difference between fat loss in the stool caused by a missing set of catalysts and fat loss caused by a missing biliary contribution. The answer is B because the two patients lose fat to the same degree but differ on every other marker, and only one of the two candidate sources contributes to the handling of all three classes of nutrient. The pancreas supplies the catalysts that act on lipid, on protein and on starch, so when that gland fails all three markers move together, exactly the pattern in patient 1: fat high, nitrogen triple the upper limit, and starch granules surviving into the stool. The biliary contribution, by contrast, is a mixture of salts, pigments and lipids that carries no catalytic activity at all, so its absence can degrade lipid handling while leaving protein and starch handling untouched, which is the isolated fat elevation seen in patient 2. The normal biopsies rule out a defect of the absorbing surface itself in both, and identical diets rule out an intake difference, so it is the pattern across markers, not the fat value, that assigns each patient to an organ. A practical corollary is that oral replacement of the missing catalysts would correct patient 1 but not patient 2.
>
> (Choice A) A single deficiency of differing severity would scale all markers together. Patient 2 has fat almost as high as patient 1 yet nitrogen inside the reference range, which is a qualitative difference in pattern, not a difference in degree.
>
> (Choice C) This assigns the two patients to the wrong sources. It predicts that the person with normal nitrogen and no starch granules has lost the multi nutrient catalyst supply, which contradicts both of those normal markers.
>
> (Choice D) Protein handling is not finished in the stomach; a large share happens beyond it. Patient 2's normal nitrogen shows that whatever is missing in that patient does not touch protein, not that the stomach completes the job.
>
> This is a Data-based and Statistical Reasoning question because it asks you to compare three measured markers across two patients and use the overall pattern, rather than the single shared abnormal value, to assign each patient to a different failing source.

---

## B2-Q18 . Membrane anchored final digestion step

**Stem.** An investigator asks whether the catalysts responsible for the last step of sugar and small peptide breakdown are released into the gut fluid or held on the surface of the absorbing cells. Three observations from an animal model are available.

I. Fluid drawn from the gut and cleared of all cells splits almost none of an added disaccharide.
II. Membrane fragments stripped from the epithelial surface and washed repeatedly still split the disaccharide.
III. Monosaccharide appears in the venous blood draining an intact loop after a disaccharide is placed inside that loop.

Which observations distinguish between the two possibilities?

- **A.** I only
- **B.** II only
- **C.** I and II only  <- **KEY**
- **D.** I and III only

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **medium** (topic secondary / structural two_step) |
| Estimated time | 90 s |
| Confidence | 5 |

**Correct answer (C): I and II only**

Citations: AP:48387; AP:49165; AP:49193; AP:49221

**Distractors**

- **(A)** `partial_truth`: Observation I is genuinely discriminating but incomplete on its own, since it excludes the free fluid location without demonstrating a surface location.
  - Citation: AP:49193
- **(B)** `partial_truth`: Observation II is genuinely discriminating but incomplete on its own, since adsorbed released material could in principle explain membrane associated activity unless I is also known.
  - Citation: AP:48387
- **(D)** `adjacent_fact`: Observation III is a true finding about the intact loop but is predicted equally by both hypotheses, so adding it to I contributes nothing to distinguishing them.
  - Citation: AP:49165

**Readback check.** The choice text consists only of numeral combinations and the word only, so it carries no content words of six or more letters at all and cannot echo the stem. The reasoning burden sits in observations I and II, and the stem never labels either observation as decisive, never states which hypothesis wins, and never uses the words anchored, surface location or discriminating in connection with any single observation. No phrase can be copied out to produce the answer.

**Explanation (as shipped).**

> This question falls under Organ Systems and tests whether the final step of carbohydrate and small peptide breakdown happens free in the lumen or on the absorbing cell surface, and how an experiment could tell the two apart. The answer is C because observation I removes the free fluid hypothesis and observation II places the activity on the washed membrane, while observation III is compatible with either arrangement and therefore settles nothing. Cell free fluid that fails to split the disaccharide shows that nothing capable of the final cut is dissolved in the gut contents, which is the prediction the free fluid hypothesis makes and fails. Washed membrane fragments that keep the activity show the opposite: the activity travels with the membrane through repeated washes, which is what anchoring means operationally. Together the two observations force the conclusion that the last cut is made at the surface itself, which leaves the products of that cut a fraction of a micrometre from the machinery that carries them inward. Breakdown and uptake are therefore not sequential events in separate places but neighbouring events at one location, so the monomer released never has to survive a trip across the lumen.
>
> (Choice A) Observation I alone is correct but incomplete. It shows that the free fluid is inactive, yet on its own it leaves open the possibility that the disaccharide is taken up whole and split somewhere inside the cell, so it cannot establish a surface location.
>
> (Choice B) Observation II alone is also incomplete. A membrane preparation could in principle carry adsorbed material that had originally been released into the fluid, so without observation I the free fluid alternative is not excluded.
>
> (Choice D) Observation III is a true result but does not discriminate. Monomer reaching the blood after disaccharide is placed in an intact loop is expected whether the cut happens in the fluid, on the surface, or inside the cell, so pairing it with I adds no discriminating power.
>
> This is a Reasoning about the Design and Execution of Research question because it asks you to judge which of three results actually discriminate between two competing locations for an enzymatic step and which one merely confirms that the overall process works.

---

## B2-Q19 . Starch relay across the acidic compartment

**Stem.** A patient's salivary glands are lost to radiation, so food leaving the mouth carries no starch splitting enzyme. Over a standard meal, measured starch digestion is nonetheless close to normal. Which explanation best accounts for this result?

- **A.** The enzyme added in the mouth is inactivated soon after the meal is acidified, and a gland emptying further down the tract does most of the work anyway.  <- **KEY**
- **B.** Starch is taken up whole by the absorbing cells and split apart inside them.
- **C.** The gastric lining releases its own starch splitting enzyme that takes over whenever the oral supply is missing.
- **D.** The oral contribution handles only a minor share of a meal, so the assay is not sensitive enough to register its loss.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic core / structural two_step) |
| Estimated time | 70 s |
| Confidence | 5 |

**Correct answer (A): The enzyme added in the mouth is inactivated soon after the meal is acidified, and a gland emptying further down the tract does most of the work anyway.**

Citations: AP:47658; AP:48261; AP:49164; AP:49165

**Distractors**

- **(B)** `misconception`: Students sometimes believe polysaccharides can be imported and processed inside the cell; only single sugar units cross the absorbing membrane.
  - Citation: AP:49165
- **(C)** `process_step_confusion`: Names the wrong stage as the source of rescue; the gastric compartment ends the oral enzyme's action rather than replacing it with an equivalent one.
  - Citation: AP:48261
- **(D)** `partial_truth`: Correctly notes the small size of the oral contribution but attributes the normal result to a blunt assay rather than to genuine completion by a downstream gland.
  - Citation: AP:49164

**Readback check.** Content words of six or more letters in key A: inactivated, acidified, emptying, further. Stem words of six or more letters: patient, salivary, glands, radiation, leaving, splitting, enzyme, standard, measured, starch, digestion, nonetheless, explanation, accounts, result. No overlap on any six letter or longer content word. The stem states neither where the enzyme is inactivated nor that a second source exists, so the key cannot be produced by restating the stem.

**Explanation (as shipped).**

> This question falls under Organ Systems and tests the relay by which starch breakdown is begun at one site, halted at a second, and resumed at a third. The answer is A because the enzyme released with saliva survives only until the meal is acidified in the stomach, so even in a healthy person its window of action is brief, and the bulk of starch breakdown is performed by a similar enzyme delivered into the small bowel from an accessory gland. Losing the oral source therefore removes a short opening contribution rather than the main one, and the total measured over a whole meal barely changes. The sequence matters more than the chemistry: site one starts the job, the acidic compartment ends that first attempt, and the third site restarts the same job with a fresh supply delivered into surroundings where it keeps working until the job is done. This organisation is why losing saliva causes swallowing difficulty and dental problems rather than carbohydrate malnutrition, and it is why the patient who passes undigested starch is the one who has lost the downstream accessory gland, not the salivary glands.
>
> (Choice B) Starch is far too large to cross the absorbing membrane, and no route exists for importing an intact polysaccharide for later breakdown inside the cell. Only the single sugar products are transported.
>
> (Choice C) This names the wrong stage as the rescuer. The stomach contributes a protein splitting activity and an acidic environment, and that acidity ends starch breakdown for the duration of gastric residence rather than continuing it.
>
> (Choice D) The premise is right and the conclusion is wrong. The oral contribution is indeed a minor share, but the reason the measurement stays normal is that another gland genuinely completes the job, not that the measurement is too blunt to notice a real shortfall.
>
> This is a Scientific Reasoning and Problem Solving question because it asks you to explain a preserved outcome after one contributor is removed by tracing where along the tract the same job is started, stopped, and taken up again.

---

## B2-Q20 . Consequence of losing salivary secretion

**Stem.** Radiation treatment for a neck tumour destroys most of a patient's salivary tissue. She now finds that dry foods are hard to gather and move around inside her mouth and that her oral lining feels raw after meals, yet a starch-rich breakfast still raises her blood glucose on a normal time course. Which single account fits both the mechanical difficulty and the preserved glucose response?

- **A.** What was lost is mainly water and mucin, which wet the meal and hold the fragments together, whereas the enzymatic step begun in the mouth is duplicated further along by the exocrine pancreas.  <- **KEY**
- **B.** Most dietary starch is normally digested in the mouth, so the intact glucose response indicates that a substantial amount of secreting tissue survived the treatment.
- **C.** The buffering of oral pH is the function that was lost; the secretion's principal job is protecting tooth enamel rather than handling the meal itself.
- **D.** The deficit is one of total fluid volume for the whole tract, so the same dryness will slow the movement of intestinal contents to an equal degree.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 70 s |
| Confidence | 5 |

**Correct answer (A): What was lost is mainly water and mucin, which wet the meal and hold the fragments together, whereas the enzymatic step begun in the mouth is duplicated further along by the exocrine pancreas.**

Citations: AP:47630, AP:47656, AP:47658, AP:47661, AP:49164

**Distractors**

- **(B)** `misconception`: Overstates how much starch is digested in the mouth; contact time is short and the activity is stopped by gastric acid, so a normal glucose curve does not imply surviving glandular tissue.
  - Citation: AP:47659
- **(C)** `adjacent_fact`: Buffering and enamel protection are genuine properties of the same fluid but concern a different consequence; they do not explain the mechanical difficulty with dry food or the abraded lining.
  - Citation: AP:47661
- **(D)** `misconception`: Generalises a strictly oral fluid deficit to the entire tract; downstream segments supply their own copious watery secretions, so intestinal contents stay fluid.
  - Citation: AP:48506

**Readback check.** Content words of six or more letters in key A independently listed: mainly, together, fragments, enzymatic, duplicated, exocrine, pancreas. (water and mucin are five letters.) Stem words of six or more letters: Radiation, treatment, tumour, patient, salivary, tissue, inside, around, lining, starch-rich, breakfast, glucose, normal, course, mechanical, difficulty, preserved, response, gather. No word appears on both lists, so there is no stem echo. The key cannot be produced by copying any stem phrase: the student must recognise that the enzymatic role is duplicated downstream while the wetting and cohesion role is not, a fact stated nowhere in the stem.

**Explanation (as shipped).**

> This item sits in the Organ Systems category and tests what the fluid bathing the oral cavity contributes to a meal apart from the enzyme it carries. The answer is A because that fluid is overwhelmingly water carrying mucin, so its loss removes wetting and cohesion immediately, while the carbohydrate-splitting activity it supplies is reproduced further along the tract by pancreatic secretion. Between one and one and a half litres are produced daily and about ninety-nine percent of that volume is water; the mucin fraction is what makes chewed fragments stick into a single soft mass and what keeps the mucosal surfaces sliding past one another without abrasion. No other gland replaces that mechanical service in the oral cavity, which is why dryness shows up first as difficulty manipulating dry food and as a sore, easily abraded lining. The enzyme carried in that fluid, by contrast, is redundant: an equivalent starch-splitting activity is delivered into the small intestine by the exocrine pancreas, and it is there that most carbohydrate is actually reduced to absorbable units, so a normal post-meal glucose curve is exactly what one should expect. The pattern of symptoms therefore separates the irreplaceable role from the duplicated one. (Choice B) This overstates oral digestion. Food spends far too little time in the mouth for more than a small fraction of dietary starch to be broken down there, and the activity is halted once the material meets gastric acid, so a normal glucose response is not evidence that glandular tissue survived. (Choice C) Buffering does occur and does help protect enamel, but this is a true statement about a different consequence of the same fluid and does nothing to explain why the patient cannot manage a dry cracker or why her lining is raw. (Choice D) This generalises a local defect to the whole tract. The fluid in question is delivered into the oral cavity only; downstream segments receive their own copious watery secretions, so intestinal contents remain fluid even when the mouth is dry. This is a Knowledge of Scientific Concepts and Principles question because it asks the student to recall which of this secretion's several jobs has no substitute elsewhere in the tract and therefore surfaces as a symptom when the secretion is gone.

---

## B2-Q21 . Multiplicative tiers of absorptive surface

**Stem.** Model a length of small intestine first as a smooth-walled cylinder. The permanent ridges of its wall raise the inner surface about threefold; the small vascularised projections carried on those ridges raise it about tenfold beyond that; and the finer extensions on the exposed face of every absorptive cell raise it roughly twentyfold again. Approximately how much greater is the real absorptive surface than that of the smooth cylinder?

- **A.** About 33 times greater
- **B.** About 200 times greater
- **C.** About 600 times greater  <- **KEY**
- **D.** About 6,000 times greater

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 85 s |
| Confidence | 5 |

**Correct answer (C): About 600 times greater**

Citations: AP:48355, AP:48369, AP:48375, AP:48387

**Distractors**

- **(A)** `misconception`: Adds the three factors instead of multiplying them, treating each tier as separate extra lining rather than as an elaboration stacked on the tier beneath it.
  - Citation: AP:48355
- **(B)** `partial_truth`: Multiplies only the two finer tiers and discards the gross wall folding, understating the total by the threefold contribution that folding supplies.
  - Citation: AP:48369
- **(D)** `scale_unit_error`: Correct multiplicative logic carried out at the wrong magnitude; the combined amplification is a few hundredfold, not several thousandfold.
  - Citation: AP:48355

**Readback check.** Content words of six or more letters in key C independently listed: greater. (times is five; 600 is a numeral.) The word greater also appears in the lead-in, but it appears identically in all four choices, so it cannot discriminate between them. Stem words of six or more letters: cylinder, permanent, ridges, surface, threefold, vascularised, projections, carried, tenfold, beyond, extensions, exposed, absorptive, roughly, twentyfold, Approximately, greater, absorptive, smooth. The numerical value 600 appears nowhere in the stem; the three input factors are supplied only as words and must be combined arithmetically, so the key cannot be read off the stem.

**Explanation (as shipped).**

> This item sits in the Organ Systems category and tests how nested structural elaborations of a lining combine to amplify absorptive area. The answer is C because each tier operates on the surface generated by the tier above it, so the three factors compose by multiplication: three times ten times twenty gives roughly six hundred. The reason the amplification is multiplicative rather than additive is geometric. The ridges enlarge the wall of the tube; the projections then stand on that already enlarged wall, so they multiply whatever area the ridges produced rather than adding a fixed increment to it; and the finest extensions decorate the exposed face of each cell covering those projections, multiplying again. Ordering the tiers by size makes the nesting explicit: a ridge is a gross fold of the wall, a projection is roughly half a millimetre to a millimetre long, and the finest extensions are on the order of a micrometre, with about two hundred million of them per square millimetre. A single tube a few centimetres in diameter therefore presents an absorptive surface out of all proportion to its external dimensions, which is what permits a meal to be taken up during a transit of only a few hours. (Choice A) Adding the three factors gives 33 and treats each tier as an independent patch of extra lining bolted onto a smooth tube. That misreads the geometry: the tiers are stacked on one another, not laid side by side, so their contributions compound. (Choice B) Multiplying only the two finer tiers gives 200 and silently discards the gross folding of the wall. That folding is a real and independent contribution, and dropping it understates the total by the same factor of three it supplies. (Choice D) This carries an extra factor of ten and lands an order of magnitude above the true amplification. Anchoring the estimate matters, because the accepted figure for the combined effect of the three tiers is a few hundredfold rather than several thousandfold. This is a Scientific Reasoning and Problem Solving question because it asks the student to decide whether three nested amplification factors combine by addition or by multiplication and then to carry that combination through to a numerical estimate.

---

## B2-Q22 . Surface loss and membrane-stage digestion

**Stem.** An immune reaction to a dietary protein progressively flattens the finger-like projections of the duodenal and upper jejunal lining, while output from the exocrine pancreas stays normal. After a bowl of oatmeal a patient with this condition passes watery stools, and hydrogen appears in her breath, a gas produced when colonic bacteria ferment sugars that were never taken up further upstream. Which failure best accounts for the sugar reaching the colon?

- **A.** The lesion shrinks the area available for water reclamation, and that reduction by itself accounts for everything she passes.
- **B.** The meal's starch is never reduced to two-sugar units at all, because the flattened lining can no longer release its secretions into the lumen.
- **C.** The affected region moves its contents along too rapidly for uptake, so transit speed rather than any chemical step is limiting.
- **D.** The last cleavage step, which turns two-sugar units into transportable single units, is done by enzymes anchored in the cell-surface membrane the lesion removes, so digestion halts one stage short.  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic secondary / structural multi_step) |
| Estimated time | 105 s |
| Confidence | 5 |
| Hard-tier gate | (a) It combines two separate concepts: the amplification of absorptive surface by the lining's projections and the location of the final, membrane-anchored stage of carbohydrate breakdown. (c) Choices A and C stay defensible until the student applies the discriminating fact that an exhaled fermentation gas requires intact fermentable sugar in the lumen, which neither a water-handling defect nor accelerated transit predicts. (d) It inverts the usual direction of reasoning: the outcome is supplied and the student must infer which upstream step failed. |

**Correct answer (D): The last cleavage step, which turns two-sugar units into transportable single units, is done by enzymes anchored in the cell-surface membrane the lesion removes, so digestion halts one stage short.**

Citations: AP:48387, AP:48536, AP:48541, AP:49165, AP:49167

**Distractors**

- **(A)** `partial_truth`: Reduced water reclamation genuinely adds to stool volume, but it is incomplete: it cannot account for fermentable sugar surviving to the colon or for the exhaled gas.
  - Citation: AP:49446
- **(B)** `process_step_confusion`: Names the wrong stage. The luminal phase of starch breakdown depends on a gland outside the intestinal wall, and the stem states that its output is normal.
  - Citation: AP:49164
- **(C)** `misconception`: Attributes the failure to transit speed, which the stem gives no evidence for, and which would not selectively spare one catalytic step while leaving the sugar chemically intact.
  - Citation: AP:48369

**Readback check.** Content words of six or more letters in key D independently listed: cleavage, transportable, single, enzymes, anchored, cell-surface, membrane, lesion, removes, digestion. Stem words of six or more letters: immune, reaction, dietary, protein, progressively, flattens, finger-like, projections, duodenal, jejunal, lining, output, exocrine, pancreas, normal, oatmeal, patient, condition, passes, watery, stools, hydrogen, appears, breath, produced, colonic, bacteria, ferment, sugars, upstream, failure, accounts, reaching, colon. No word appears on both lists. The key names a catalytic step and a location stated nowhere in the stem, so it must be inferred from the combination of normal exocrine output plus intact fermentable sugar arriving distally. Two distractors also avoid stem vocabulary, so no choice is marked out by its wording alone.

**Explanation (as shipped).**

> This item sits in the Organ Systems category and tests where the final stage of carbohydrate breakdown physically happens and what fails when that site is lost. The answer is D because the enzymes that split two-sugar units are fixed to the membrane covering the finest extensions of the absorptive cells, so destroying that membrane removes the final catalytic step even when everything upstream of it is intact. The stem supplies the two facts needed to localise the fault. Pancreatic output is normal, so the luminal phase of starch breakdown proceeds and delivers short sugar units to the lining as usual; and fermentable sugar reaches the colon, so the material clearly was not taken up. Since the pancreas contributes enzymes to the lumen but not to the cell surface, the failure has to lie at the membrane-bound stage that follows. Unabsorbed sugar then holds water osmotically in the lumen, producing watery stools, and bacterial fermentation of that sugar releases hydrogen, some of which is taken into the blood and exhaled. The same injury also removes an enormous amount of absorptive area, but it is the loss of the membrane-anchored catalytic step that specifically explains why a digestible sugar arrives intact in the colon. (Choice A) Reduced water reclamation is real and does contribute to stool volume, but it is incomplete in a way that changes the answer: a pure water-handling defect would not leave fermentable sugar in the lumen, and it cannot explain the exhaled gas. (Choice B) This misplaces the failed stage. The stem states that exocrine output is normal, and that secretion comes from a gland lying outside the intestinal wall, so the luminal phase of starch breakdown is unaffected by loss of the lining's surface elaborations. (Choice C) Rapid transit can limit uptake in other settings, but nothing here indicates accelerated movement, and speed alone would leave partially processed sugars of every size rather than the specific failure of one catalytic step. This is a Scientific Reasoning and Problem Solving question because it asks the student to work backwards from an unabsorbed sugar and an exhaled fermentation product to the one digestive step that the destroyed surface had been performing.

---

## B2-Q23 . Energy source behind uphill sugar uptake

**Stem.** Absorptive intestinal cells are grown as a sealed sheet on a porous filter, so that the bath on the lumen facing side and the bath on the blood facing side can be sampled and changed independently. Sugar is supplied to the lumen facing bath, and after an hour the cells hold sugar at roughly ten times the level measured in either bath. Investigators wish to show that this build up draws on an energy supply rather than on the properties of the sugar carrier alone.

Which of the numbered manipulations would be expected to abolish the build up?

I. Adding a blocker of the ion pump to the blood facing bath only
II. Replacing the sodium of the lumen facing bath with an equal amount of a cation the cells cannot transport
III. Adding a blocker of the sugar carrier in the blood facing membrane

- **A.** I only
- **B.** I and II only  <- **KEY**
- **C.** II and III only
- **D.** I, II, and III

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 105 s |
| Confidence | 5 |
| Hard-tier gate | (a) combines the energetics of secondary active transport with the logic of a two compartment experimental design; (b) requires a directional inference, namely that blocking exit raises internal sugar rather than lowering it; (c) items II and III both remain defensible until the student applies the specific fact that the far membrane step runs downhill; (d) inverts the usual reasoning direction by making a manipulation applied to the far bath, rather than the near bath, the decisive test of near membrane entry. |

**Correct answer (B): I and II only**

Citations: AP:49346, AP:49356, AP:53072, AP:4604, BIO:9205

**Distractors**

- **(A)** `partial_truth` . _incomplete_set_: Correctly identifies the pump manipulation as informative but omits removal of the coupling ion, which abolishes the build up just as completely and controls for a direct action of the blocker on the sugar carrier.
  - Citation: AP:53072
- **(C)** `process_step_confusion` . _wrong_step_targeted_: Swaps the energy consuming entry step for the passive exit step, treating a block at the blood facing membrane as though it interrupted the uphill work, which occurs entirely at the opposite face.
  - Citation: AP:49356
- **(D)** `misconception` . _any_block_lowers_all_: Assumes any interruption of the lumen to blood route reduces intracellular sugar, when blocking exit traps sugar inside and increases the very build up the manipulation was supposed to abolish.
  - Citation: AP:49356

**Readback check.** Key text is 'I and II only', which contains no content word of six or more letters, so a verbatim echo of the stem is structurally impossible. Independently checking the reasoning demanded rather than the wording: the student must infer that blocking the far membrane carrier raises rather than lowers internal sugar, a directional inference stated nowhere in the stem, and must infer that a pump acting on ions rather than sugar is nonetheless the energy source. Neither inference is recoverable by matching words. No label lookup is involved, since no structure has to be named.

**Explanation (as shipped).**

> This Organ Systems question tests where the free energy for uphill sugar entry at the lumen facing membrane of an absorptive cell actually originates. The answer is B because manipulations I and II each strip away part of the ion driving force, whereas manipulation III acts on a later step and would leave the cells holding more sugar rather than less. The carrier at the lumen facing membrane does not split ATP itself. It binds an ion and a sugar together, and the downhill slide of that ion into the cell supplies the work that drags sugar inward even after the lumen has been picked nearly clean. That slide exists only because a pump on the opposite membrane keeps expelling the ion, so the pump is the ultimate energy source even though it never touches a sugar molecule. This is why a blocker placed only in the blood facing bath shuts down entry occurring at the opposite face of the cell, which is the classic fingerprint of an energy supply that arrives secondhand. Removing the coupling ion from the lumen bath attacks the same dependence from the other end and is equally decisive.
>
> (Choice A) Manipulation I alone does demonstrate a dependence on the pump, but stopping there understates the experiment. Manipulation II removes the coupling ion at the site of entry and abolishes the build up just as surely, and running both closes the loophole that the pump blocker acted on the sugar carrier directly.
>
> (Choice C) Manipulation II belongs in the answer, but pairing it with III mistakes a downstream event for the one that requires work. The step that consumes free energy is the one at the lumen facing membrane, and it stays fully intact when the far membrane is blocked.
>
> (Choice D) Including III assumes that anything interrupting the path from lumen to blood must lower the sugar held inside. Closing the exit instead traps sugar in the cytoplasm, so the level inside would rise, which is the opposite of abolishing the build up.
>
> This is a Reasoning about the Design and Execution of Research question because it asks the student to judge which experimental manipulations genuinely test the proposed energy dependence and which one perturbs a step that carries no energetic burden.

---

## B2-Q24 . Ceiling on uncoupled monosaccharide uptake

**Stem.** Sealed loops of small intestine were filled on the lumen side with 5.0 mM of monosaccharide P, and a matched set was filled with 5.0 mM of monosaccharide Q. Sodium was present in every loop. The fluid bathing the blood facing side was left undisturbed, so nothing was carried away from it. Lumen fluid and epithelial cells were sampled at intervals.

| Time (min) | P in lumen (mM) | P in cell (mM) | Q in lumen (mM) | Q in cell (mM) |
| --- | --- | --- | --- | --- |
| 0 | 5.0 | 0.0 | 5.0 | 0.0 |
| 15 | 2.1 | 6.8 | 2.8 | 2.6 |
| 30 | 0.9 | 9.1 | 2.7 | 2.7 |
| 60 | 0.4 | 9.6 | 2.7 | 2.7 |

If the loops were left for several more hours, which outcome is best supported by these results?

- **A.** P would fall closer to zero in the lumen fluid, while Q would stay near the point it has already reached.  <- **KEY**
- **B.** Both sugars would end up near zero in the lumen fluid, Q merely taking longer to get there.
- **C.** Q would climb inside the cells until it matched P, since sodium was supplied to both sets of loops.
- **D.** Q would drain back out of the cells until its lumen figure returned toward 5.0 mM.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 95 s |
| Confidence | 4 |

**Correct answer (A): P would fall closer to zero in the lumen fluid, while Q would stay near the point it has already reached.**

Citations: AP:49346, AP:49356, AP:49305, BIO:9205

**Distractors**

- **(B)** `misconception` . _rate_versus_endpoint_: Treats a plateau as mere slowness, when the data show Q fell almost as fast as P over the first 15 minutes and then stopped; a carrier with no energy behind it never moves solute past the point where the two sides match, so added time cannot clear the lumen.
  - Citation: AP:49356
- **(C)** `adjacent_fact` . _everything_is_coupled_: Correctly notes that sodium was available in both sets of loops, a true detail from the stem, but any coupling to that ion would have pushed Q past the matching point, which the flat 2.7 pair rules out.
  - Citation: AP:49346
- **(D)** `reversed_relationship` . _backflux_prediction_: Reverses the direction of net flux by predicting backflow out of the cell, when equal figures on both sides mean zero net movement in either direction and the unchanged 30 and 60 minute values show no drift.
  - Citation: BIO:9205

**Readback check.** Content words of six or more letters in the key: closer, reached, already. None appears in the stem, the table headers, or the question sentence, which use only sealed, loops, small, intestine, filled, monosaccharide, matched, sodium, present, bathing, facing, undisturbed, nothing, carried, epithelial, sampled, intervals, several, outcome, supported, results. The key is not a value read off the table: no row shows what happens after 60 minutes, so the student must first judge that Q has plateaued while P has not, then project both trends forward. The stopping condition for Q is never stated in words anywhere in the stem.

**Explanation (as shipped).**

> This Organ Systems item tests what sets the limit on a membrane crossing that has no energy input behind it. The answer is A because P is still being carried inward at 60 minutes while the lumen holds only a small fraction of what the cell holds, whereas Q stopped changing after 15 minutes and has no gradient left to exploit. Follow each sugar across the sampling times. P drops from 2.1 to 0.9 to 0.4 in the lumen while the cell figure climbs to 9.6, so P is being taken up at a moment when the source fluid holds roughly one part for every twenty four parts at the destination. Nothing but an outside supply of free energy can sustain that arrangement, and here it is the inward slide of an ion on the shared carrier, paid for in the end by the pump that keeps expelling that ion. Q instead flattens at 2.7 on both sides and does not budge between 30 and 60 minutes, which is exactly what a plain facilitating protein does: it speeds passage in both directions and stalls the instant the two sides match. Because the fluid on the blood side is never drained, nothing can re establish a gradient for Q, so more time buys nothing. The physiological consequence is that a heavy dietary load of a sugar carried this way leaves a residue in the gut and passes onward, whereas a coupled sugar is taken up essentially to completion.
>
> (Choice B) Speed and stopping point are different properties, and only the second is at issue. Q was not even markedly slower over the first 15 minutes, since its lumen figure fell 2.2 mM while P fell 2.9 mM. Q simply ran out of gradient, and a protein with no energy behind it never carries anything past the point where the two sides match, so extra hours cannot close the gap.
>
> (Choice C) Sodium was indeed supplied to both sets of loops, but that fact alone settles nothing. Had Q been coupled to the ion, it would have been dragged past the matching point as P was, even if less far. The flat pair of 2.7 values shows that no additional pull was acting on Q at all.
>
> (Choice D) This reverses the direction of net movement. Where the two sides match there is no net flux either way, so Q has no tendency to run back into the lumen, and the unchanging pair of figures between 30 and 60 minutes rules out any such drift.
>
> This is a Data-based and Statistical Reasoning question because it asks the student to read a time course, distinguish a carrier that has plateaued from one that is still working, and extrapolate each trend beyond the final sampling point.

---

## B2-Q25 . Why the exit step needs no coupling

**Stem.** In an intestinal cell that is actively absorbing, the carrier at the lumen facing membrane admits sodium and sugar together, and it keeps drawing sugar in long after the fluid in the lumen has been picked nearly clean. A student argues that the protein handling sugar exit at the blood facing membrane must therefore also be tied to sodium entry. Which objection to that argument is strongest?

- **A.** Proteins that bind sodium can only bring material into a cell and cannot carry anything the other way.
- **B.** The fluid on the blood side holds more sugar than the cell does, so exit would have to be driven uphill as well.
- **C.** Exit does need a protein, but the cell simply reuses the one from the lumen facing membrane at the other face.
- **D.** Sugar has piled up inside the cell, so its passage outward at that face runs downhill and needs no extra push behind it.  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 70 s |
| Confidence | 5 |

**Correct answer (D): Sugar has piled up inside the cell, so its passage outward at that face runs downhill and needs no extra push behind it.**

Citations: AP:49356, AP:49346, BIO:7501, BIO:9205

**Distractors**

- **(A)** `misconception` . _coupling_is_import_only_: Falsely claims ion coupled proteins cannot export solutes; coupled exchangers routinely move material outward, so a supposed restriction on their direction is not the reason coupling is unnecessary at that face.
  - Citation: AP:4604
- **(B)** `reversed_relationship` . _inverted_gradient_: Inverts the actual arrangement of sugar across the blood facing membrane, where the absorbing cell holds far more than the fluid beyond it, making exit downhill rather than uphill.
  - Citation: AP:49356
- **(C)** `process_step_confusion` . _same_protein_both_faces_: Treats the entry protein as though it could serve the exit step, conflating two stages that face opposite energetic demands and are served by different proteins at different faces of the cell.
  - Citation: AP:49346

**Readback check.** Content words of six or more letters in the key: inside, passage, outward, downhill. Checked one by one against the stem, which contains intestinal, actively, absorbing, carrier, sodium, together, drawing, picked, student, argues, protein, handling, membrane, therefore, objection, argument, strongest. None of the four key words appears there; the stem uses inward, which is a different word from outward. The stem deliberately does not state the sugar levels on either side of the blood facing membrane, so the downhill direction of exit cannot be lifted from the text and must be derived from the fact that the cell keeps absorbing out of a nearly empty lumen. No structure has to be named, so this is not a label lookup.

**Explanation (as shipped).**

> This Organ Systems item tests why the two faces of an absorptive cell confront different transport problems and therefore use different machinery. The answer is D because a cell that keeps collecting sugar from an almost empty lumen must end up holding far more sugar than the fluid it delivers into, so the final step is a downhill one that needs nothing more than a protein that lets the molecule slide. Uphill work is demanded only at the lumen facing membrane, where sugar has to be taken from a source that has been stripped nearly bare. Coupling to an ion solves that specific problem, and the cell pays for it indirectly through the pump that restores the ion gradient. Repeating the same arrangement at the far membrane would be wasted expense, and worse than wasted: a protein that brought an ion inward there would tend to drag sugar back into the cell instead of releasing it toward the blood. The general principle is that a transport protein is matched to the direction and the steepness of the task in front of it, not to the identity of the molecule it happens to move.
>
> (Choice A) Ion coupled proteins are perfectly capable of running outward as well as inward, and exchangers that expel one solute while admitting an ion are common in many tissues. The reason coupling is unnecessary at the blood facing face is the favorable arrangement of sugar across it, not a restriction on what such proteins can do.
>
> (Choice B) This inverts the actual situation. The absorbing cell builds sugar up to a level well above that of the fluid beyond the blood facing membrane, which is precisely why exit poses no energetic difficulty and why the cell can unload sugar continuously into the circulation.
>
> (Choice C) The two faces carry distinct proteins suited to distinct jobs, and reusing the entry protein would not help. A protein tuned to admit sugar alongside an ion, working at a face where that ion is not being replenished from outside, is poorly matched to the task of releasing sugar outward.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to compare the energetic demands at two faces of a single cell and to decide which one requires an added driving force.

---



---

# BATCH 3 of 3, FINAL (25 questions): absorption, liver and bile, colon and vitamins

Units: peptide uptake and a missing brush-border enzyme . the diffusion barrier and carrier limits .
the biliary tree as a plumbing system . bilirubin from liver to stool . the water budget and why it
fails . gut bacteria as a metabolic organ . the vitamin machinery.

**This batch completes Biology Chapter 9 at 75 questions.**

## Batch 3 summary

| Metric | Batch 3 | FULL CHAPTER (75) | Target |
|---|---|---|---|
| Difficulty | easy 6 . hard 9 . medium 10 | easy 20 . hard 25 . medium 30 | easy 20 . medium 30 . hard 25 |
| Answer letter | A 6 . B 7 . C 6 . D 6 | A 19 . B 19 . C 19 . D 18 | A 19 . B 19 . C 19 . D 18 |
| Cognitive skill | S1 4 . S2 13 . S3 3 . S4 5 | S1 12 . S2 39 . S3 10 . S4 14 | S1 12 . S2 39 . S3 10 . S4 14 |
| Confidence | conf4 4 . conf5 21 | conf4 14 . conf5 61 | only 4-5 ship |
| Roman numeral | 3 | 9 | 9 |
| Distractor categories | adjacent_fact 13 . misconception 22 . partial_truth 13 . process_step_confusion 11 . reversed_relationship 10 . scale_unit_error 6 | | none dominant |
| Em/en dashes | 0 | 0 | 0 |

## Final chapter position

**Every distribution target was hit exactly**, across all three batches and across the finished
chapter: difficulty 20 easy / 30 medium / 25 hard against a 27/40/33 percent target; answer letters
19 / 19 / 19 / 18; cognitive skills 12 / 39 / 10 / 14; Roman numeral format 9 items. Per-slice quotas
were summed against the batch target before each launch, and each batch target was summed against the
75-question chapter target before that, so no arithmetic was left to inspection.

All 75 pass every structural gate: choice blocks present and ordered, the literal "The answer is X
because" sentence matching the key, the exact skill-closer sentence matching the assigned cognitive
skill, hard-tier gate conditions named on every hard item, confidence 4 or 5 throughout, valid
distractor categories on all 225 rows, zero em or en dashes, and zero source citations in shipped
explanations.

## The boundary result

An automated pass checked all 75 keys against every forbidden territory. **No boundary term appears in
any key.** Two flags were raised across the chapter and both were cleared by hand as correct usage:

1. Batch 1 Q10 states that bile salt and vitamin B12 recovery at the far end of the small intestine
   are normal. That is a CONTROL eliminating an ileal-resection explanation; the key turns on two-way
   flow at the ileocaecal junction.
2. Batch 2 Q9 supplies plasma insulin in a data table. Insulin is the READOUT; the key is that passage
   through the gut lumen liberates a circulating messenger, and the two glucose curves are matched
   point for point by design so the inference is airtight.

Both illustrate the pattern that made this chapter possible: a neighbouring chapter's content used as
scenery that rules out a competing answer, never as the thing being tested.

## Deconfliction of the two flagged collision risks

The Step 1 plan flagged batch 3 as the highest internal-duplication risk in the chapter, because
several items converge on vitamin K and several on fluid loss. Each slice brief named the angle that
belonged to it and named the angles belonging to others. The delivered set is genuinely distinct:

| Question | Route to the same clinical picture |
|---|---|
| Uptake failure behind a bleeding tendency | bile absent, so ABSORPTION fails; the liver's ability to use the vitamin is intact |
| Antibiotic loss of bacterial vitamin production | bacteria killed, so SYNTHESIS fails |
| Which fat soluble vitamin fails first | which vitamin runs short soonest, keyed on stores and turnover |

Fluid loss is likewise split four ways with no overlap: the daily fluid budget and colonic reserve,
driving force versus route for colonic water, a fasting test separating osmotic from secretory loss,
and the sugar-salt coupling that makes rehydration fluid work.

**Duplication:** 75 distinct subtopics, no near-duplicate keys anywhere in the chapter. Sizing the
chapter at 75 rather than forcing it to 100 is what avoided the redundancy spiral that cost Bio Ch6
Respiratory a long deduplication marathon.

**Adversarial audit:** all 25 re-examined by an independent pass per slice, with every citation
re-greped against OpenStax Anatomy and Physiology 2e and OpenStax Biology 2e.

---

## B2-Q1 . Peptide uptake outpacing free amino acids

**Stem.** An investigator perfuses an isolated loop of jejunum with three solutions in turn, each supplying an identical load of glycine presented in a different form. Venous drainage from the loop is collected for 30 minutes after each perfusion, and its total glycine content, free plus peptide bound, is measured. Flow rate and perfusate volume are the same in all three runs.

| Solute perfused | Glycine units supplied (mmol) | Glycine units in drainage over 30 min (mmol) |
| --- | --- | --- |
| Free glycine | 30 | 12 |
| Glycylglycine | 30 | 21 |
| Glycylglycylglycine | 30 | 25 |

What accounts for the ordering of the three drainage values?

- **A.** Every bond in the chained forms is broken at the brush border before anything crosses into the cell, so all three solutions are ultimately handled by the same free amino acid carriers.
- **B.** The chained forms enter the cell intact on a carrier separate from the free amino acid carriers, energised by an inward hydrogen ion gradient, and are split into single units only after entry.  <- **KEY**
- **C.** The chained forms enter the cell intact and pass unchanged into the blood, where circulating enzymes release the individual units.
- **D.** The difference reflects the greater molecular mass of the chained forms rather than any difference in how many units were taken up.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic secondary / structural multi_step) |
| Estimated time | 105 s |
| Confidence | 5 |
| Hard-tier gate | (a) combines transport energetics with the location of the final hydrolysis step; (b) requires a directional inference across three values measured against a fixed supplied load rather than a lookup; (c) choices A and D stay defensible until the student notices that the load was equalised in units of substance, not in mass, and that the values fail to converge. Three conditions met, so hard is supported. |

**Correct answer (B): The chained forms enter the cell intact on a carrier separate from the free amino acid carriers, energised by an inward hydrogen ion gradient, and are split into single units only after entry.**

Citations: AP:49364, AP:49232, AP:49087

**Distractors**

- **(A)** `misconception` . _everything-is-broken-down-first_: Rests on the common belief that all protein must be reduced to single amino acids before any uptake occurs; that model predicts three equal drainage values, which the data contradict.
  - Citation: AP:49364
- **(C)** `process_step_confusion` . _right-process-wrong-compartment_: Keeps the correct process but moves the cleavage step from the cytosol of the absorptive cell to the bloodstream; the chains are in fact split before they leave the cell.
  - Citation: AP:49364
- **(D)** `scale_unit_error` . _mass-versus-moles_: Attributes the difference to molecular mass when both columns are expressed as amount of substance, so molecular size cannot generate the larger collected quantity.
  - Citation: AP:49232

**Readback check.** Content words of six or more letters in key B: chained, carrier, separate, carriers, energised, inward, hydrogen, gradient, single, entry. Stem and table words of six or more letters: investigator, perfuses, isolated, jejunum, solutions, supplying, identical, glycine, presented, different, venous, drainage, collected, minutes, perfusion, peptide, content, measured, perfusate, volume, solute, perfused, supplied, ordering, values, glycylglycine, glycylglycylglycine. No overlap, so no rewrite needed. The key is not a value read off the table; it is the mechanism inferred from the rank order.

**Explanation (as shipped).**

> This item sits in Organ Systems and tests the absorptive step that follows protein digestion in the small intestine. The answer is B because the two unit and three unit chains cross the apical membrane intact on a carrier of their own, driven by an inward hydrogen ion gradient rather than by the sodium gradient that serves free amino acids, and they are cleaved to single units only once inside the cell, so a single carrier cycle moves two or three units inward instead of one. Compare the third column against an identical supplied load: 12, then 21, then 25 units out of 30. If every bond had to be broken at the surface before anything crossed, the three solutions would be indistinguishable by the moment transport began, and the three values would converge on one number. They do not converge, and recovery climbs with chain length, which points to a parallel route with its own capacity that competes neither for binding sites nor for the sodium gradient used by the free amino acid carriers. The hydrolysis step has not been skipped; it has been relocated to the cytosol.
>
> (Choice A) If surface hydrolysis preceded all uptake, the three solutions would present the same species to the same carriers, and the three collected values would be equal. A clear rank order appears instead, so this cannot be the explanation.
>
> (Choice C) The cleavage step is real but is placed one compartment too far downstream. Peptidases inside the absorptive cell split the chains before they leave it, so what reaches the blood is already free amino acid. Note that the assay counts glycine whether free or peptide bound, so the measurement itself cannot rescue this choice; it fails on where the cleavage happens.
>
> (Choice D) Mass was not the quantity measured. Both the supplied load and the collected load are reported in the same units of substance, so a heavier molecule cannot by itself inflate the third column.
>
> This is a Data-based and Statistical Reasoning question because it asks the student to compare three collection values measured against one identical supplied load and to infer from their rank order which absorptive route the chained forms must be using.

---

## B2-Q2 . Two lumen consequences of disaccharidase loss

**Stem.** An adult reports bloating and loose stools within two hours of drinking milk. Testing shows that her intestinal brush border no longer produces the enzyme that acts on the sugar in milk, while her pancreatic secretions and bile output are normal. What accounts for her symptoms?

- **A.** The undigested disaccharide remains in the lumen, retains fluid there osmotically, and reaches colonic bacteria that ferment it into gas and small organic acids.  <- **KEY**
- **B.** The disaccharide is taken up intact by the epithelium and cannot be metabolised, so it builds up inside the absorptive cells and injures them.
- **C.** The disaccharide is split normally in the lumen, but the freed single sugars cannot be picked up by their carriers and build up instead.
- **D.** The defect shortens the microvilli and lowers total absorptive surface, so every class of nutrient is absorbed poorly.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 65 s |
| Confidence | 5 |

**Correct answer (A): The undigested disaccharide remains in the lumen, retains fluid there osmotically, and reaches colonic bacteria that ferment it into gas and small organic acids.**

Citations: AP:48530, AP:48536, AP:49169

**Distractors**

- **(B)** `misconception` . _disaccharide-crosses-membrane_: Assumes the intact two unit sugar can cross the absorptive membrane; the sugar carriers accept single sugars only, so no intracellular accumulation is possible.
  - Citation: AP:49355
- **(C)** `process_step_confusion` . _transport-blamed-for-hydrolysis-loss_: Locates the failure at the transport step rather than at the cleavage step that immediately precedes it; the carriers are intact and simply have no substrate.
  - Citation: AP:49169
- **(D)** `adjacent_fact` . _surface-loss-substituted-for-enzyme-loss_: Describes a genuine cause of poor absorption, loss of surface area, but that is a different lesion; a single missing membrane enzyme leaves the absorptive surface intact.
  - Citation: AP:48370

**Readback check.** Content words of six or more letters in key A: undigested, disaccharide, remains, retains, osmotically, reaches, colonic, bacteria, ferment, organic, acids. Stem words of six or more letters: reports, bloating, stools, within, drinking, testing, intestinal, brush, border, longer, produces, enzyme, pancreatic, secretions, output, normal, accounts, symptoms. No overlap. The stem states that an enzyme is missing; the key states a two part downstream consequence that must be inferred, so no phrase can be copied across.

**Explanation (as shipped).**

> This item sits in Organ Systems and tests the consequence of losing a membrane anchored step of carbohydrate handling. The answer is A because a sugar that is never cleaved cannot be picked up by any single sugar carrier, so it stays behind as an osmotically active particle and is delivered onward to the microbial population of the large bowel. Two consequences follow from that one failure. Solute retained in the lumen raises the osmolarity of the intestinal contents, so water moves down its own gradient into the lumen rather than out of it, and the volume arriving downstream exceeds what can be reclaimed there. The intact sugar is also a ready substrate for resident microbes, and their fermentation of it yields gas plus small organic acids, so the bowel distends and further osmotically active particles are added to the load. Because the pancreatic and biliary contributions are stated to be intact, fat and protein handling are untouched, which is why the picture is confined to what follows a milk load.
>
> (Choice B) Nothing is taken up intact here. Two sugar units joined together are not substrates for the single sugar carriers of the absorptive membrane, so the sugar never reaches the interior of the cell and no intracellular accumulation occurs.
>
> (Choice C) This puts the failure one step too late. The cleavage itself is what has been lost, so there are no freed single sugars waiting for a carrier; the carriers themselves are working normally.
>
> (Choice D) Losing one membrane enzyme does not remodel the absorptive surface. Surface area is unchanged, and uptake of amino acids, other sugars and fat breakdown products proceeds normally, which is why the trouble is specific to this one dietary sugar.
>
> This is a Knowledge of Scientific Concepts and Principles question because it asks the student to apply the concepts of osmotic solute retention and microbial fermentation to predict what an unabsorbed luminal sugar will do.

---

## B2-Q3 . Redundant bulk uptake versus unique distal recovery

**Stem.** A surgeon removes 50 cm of small intestine from the jejunum of one patient and 50 cm from the far end of the ileum of another. Both patients go on to absorb the bulk of a mixed meal normally, but only the second develops specific nutrient deficiencies over the following months. Which difference between the two regions explains this outcome?

- **A.** The far end holds most of the intestine's absorptive area, so taking it costs more capacity than taking an equal length from further up.
- **B.** Contact between contents and epithelium lasts longest in the final segment, so losing it shortens exposure equally for every nutrient.
- **C.** Capacity for bulk uptake is duplicated along a long proximal stretch, whereas a few dedicated recovery mechanisms sit only in a short terminal zone and exist nowhere else.  <- **KEY**
- **D.** Chemical breakdown of food is completed in the final segment, so losing it leaves nutrients incompletely broken down when they arrive in the large bowel.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic secondary / structural two_step) |
| Estimated time | 85 s |
| Confidence | 4 |

**Correct answer (C): Capacity for bulk uptake is duplicated along a long proximal stretch, whereas a few dedicated recovery mechanisms sit only in a short terminal zone and exist nowhere else.**

Citations: AP:49253, AP:48318, AP:48370, AP:49442

**Distractors**

- **(A)** `reversed_relationship` . _surface-gradient-flipped_: Inverts the real gradient of absorptive surface, which is greatest proximally and falls off distally, so the segment whose removal caused deficiencies is not the one carrying most area.
  - Citation: AP:48370
- **(B)** `adjacent_fact` . _transit-time-substituted-for-specificity_: Transit and contact time are real variables, but a uniform reduction in exposure would impair every nutrient slightly rather than produce a short and specific list of deficiencies.
  - Citation: AP:48475
- **(D)** `process_step_confusion` . _digestion-finished-at-the-end_: Places the completion of chemical breakdown at the wrong stage; digestion is essentially finished upstream and what leaves the small intestine is already indigestible residue.
  - Citation: AP:49253

**Readback check.** Content words of six or more letters in key C: capacity, duplicated, proximal, stretch, dedicated, recovery, mechanisms, terminal, nowhere. Stem words of six or more letters: surgeon, removes, intestine, jejunum, patient, another, patients, absorb, normally, develops, specific, nutrient, deficiencies, following, months, difference, regions, explains, outcome. No overlap, so no rewrite needed. The stem reports two surgical outcomes and the key states the structural difference that must be inferred from them.

**Explanation (as shipped).**

> This item sits in Organ Systems and tests how absorptive work is distributed along the length of the small intestine. The answer is C because the machinery for taking up sugars, amino acids and fat breakdown products is spread redundantly over metres of upper intestine, so losing a short piece of it costs almost nothing, whereas a small number of specialised uptake mechanisms are confined to the last stretch and have no backup upstream. The pattern in the two patients is exactly what redundancy predicts: remove one copy of a widely duplicated function and the remaining copies take up the work, but remove the only copy of a unique function and that function is simply gone. Vitamin B12 is the clearest instance. It is too large to cross by simple diffusion, so it is carried by a binding partner made further up the tract and is taken into the epithelium by receptors that occur only in the terminal segment. Capacity for that route is set by the number of those receptors, not by sheer surface area, so nothing is gained by spreading it out, and no amount of remaining proximal intestine can substitute once the receptor bearing segment is gone.
>
> (Choice A) This reverses the actual distribution. Absorptive area is greatest in the upper intestine, where the mucosal folds are present and the villi are tallest and most crowded, and it declines toward the end, so the region whose removal caused deficiencies is not the region carrying the most surface.
>
> (Choice B) Even if residence time were longer in the last segment, a uniform loss of exposure would blunt uptake of everything a little rather than knock out a short list of substances while leaving the bulk of the meal absorbed normally. The observed selectivity rules out a uniform effect.
>
> (Choice D) This misplaces a stage. Cleavage of the meal is essentially finished well before the end of the small intestine, and the material entering the large bowel is already residue, so the deficiencies cannot come from unfinished breakdown.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to work backwards from two contrasting surgical outcomes to the underlying difference in how absorptive functions are distributed along the organ.

---

## B2-Q4 . Aqueous diffusion barrier at the absorptive surface

**Stem.** A poorly mixed sheet of fluid sits against the intestinal lining and turns over only slowly, so any solute must cross it by random thermal motion before it can touch the membrane. A hydrophobic drug given as free molecules arrives at the brush border far more slowly than its very high measured permeability through artificial lipid bilayers would predict. Which of the following would increase the rate at which drug molecules reach the brush border?

I. Delivering the drug in a preparation that keeps a much higher amount of it dissolved close to the epithelium
II. Modifying the drug so that its partition coefficient into membrane lipid doubles
III. Increasing local agitation right at the mucosal face so the stagnant zone becomes thinner

- **A.** I only
- **B.** I and III only  <- **KEY**
- **C.** II and III only
- **D.** I, II, and III

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic secondary / structural two_step) |
| Estimated time | 90 s |
| Confidence | 5 |

**Correct answer (B): I and III only**

Citations: BIO:6922; BIO:6935; BIO:6939; AP:49284

**Distractors**

- **(A)** `partial_truth`: Item I is a genuine intervention, but the choice omits item III, which manipulates the other determinant of diffusive delivery, the thickness of the stagnant film. It is right as far as it goes and wrong because it is incomplete.
  - Citation: BIO:6939
- **(C)** `misconception`: Rests on the common belief that the lipid bilayer is the obstacle for a hydrophobic molecule. The stem states that the compound crosses artificial bilayers readily, so improving partitioning further does not raise the overall rate, and this choice also drops the solubility intervention.
  - Citation: BIO:6935
- **(D)** `misconception`: Assumes that any change which sounds favorable must increase delivery. It fails to distinguish the rate limiting aqueous step from the already fast membrane step and so includes item II incorrectly.
  - Citation: AP:49284

**Readback check.** Content words of six or more letters in the key (choice B, which selects items I and III): Delivering, preparation, higher, amount, dissolved, epithelium, Increasing, agitation, mucosal, stagnant, thinner, becomes. None of these appears in the stem. The stem's long words of six or more letters are poorly, sheet, against, intestinal, lining, solute, random, thermal, motion, membrane, hydrophobic, molecules, permeability, artificial, bilayers, predict, border. The only deliberate overlap is membrane with distractor item II, which is a trap rather than a cue. No banned readback pattern applies: the stem never states which of the two steps limits the rate, so the student must infer it before any item can be scored.

**Explanation (as shipped).**

> This Organ Systems item tests the poorly mixed film of fluid that stands between the gut contents and the absorptive cell, and how to work out which step in a two stage journey sets the overall rate. The answer is B because only items I and III act on the step that is actually limiting, which is passage through water rather than passage through lipid. Movement across a stagnant film is diffusive, so the number of molecules delivered per second rises with the concentration difference that drives the diffusion and falls as the film gets deeper. A greasy compound holds only a very small amount in true aqueous solution, so the concentration term is minute no matter how eagerly the compound partitions into lipid once it arrives. That is precisely why such a compound is given in a vehicle that keeps it dissolved: the vehicle does not push it through the membrane, it simply keeps far more of it available in the watery gap immediately outside. Item I raises the driving concentration, item III shortens the path, and both therefore raise delivery. Item II speeds a step that was never the bottleneck, and speeding a step that is not rate limiting leaves the overall rate essentially where it was.
> (Choice A) Item I does belong in the answer, but this choice stops halfway. Delivery across a diffusive gap depends on two terms, the driving concentration and the thickness of the gap, and item III manipulates the second of them. Naming only one of two valid interventions is correct as far as it goes but incomplete.
> (Choice C) Item III belongs, yet pairing it with item II reflects the common assumption that the lipid bilayer must be the obstacle for a fat loving molecule. The stem already reports that the compound crosses artificial bilayers readily, so the membrane step is fast, and making a fast step faster changes little. This choice also discards the solubility intervention that matters most.
> (Choice D) This choice adds item II to the two correct interventions. It treats every plausible sounding change as helpful rather than asking which single step governs the rate, and it therefore fails the discrimination the question is built around.
> This is a Scientific Reasoning and Problem Solving question because it asks the student to identify which of two sequential steps limits delivery and then predict which manipulations act on that step rather than on the step that is already fast.

---

## B2-Q5 . Designing a test for carrier mediated uptake

**Stem.** Investigators perfuse matched loops of rat jejunum with a water soluble vitamin at graded luminal doses and record how much reaches the venous effluent each minute. The rate climbs steeply over the low range, then flattens so completely that raising the dose further adds nothing. A reviewer counters that the flat portion may only mean the strongest solutions injured the loops. Which single follow up experiment would answer the reviewer and at the same time support a protein assisted route?

- **A.** Warm the perfusate by ten degrees and show that transfer of the test solute rises at every dose in the series, including the doses on the flat portion
- **B.** At the top dose, show that an inert passively absorbed tracer still crosses the loops at exactly the rate it shows at the lowest dose
- **C.** Repeat the entire dose series in a second species and confirm that transfer flattens at the same point on the curve in both preparations
- **D.** At the top dose, strip sodium from the perfusate and show that transfer of the test solute collapses while an inert passively absorbed tracer crosses at its usual rate  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 105 s |
| Confidence | 5 |
| Hard-tier gate | Condition (a) holds: the item combines the energetics of a coupled transport route with the logic of an internal control, requiring the student to hold the mechanism claim and the artifact claim in view at once. Condition (c) holds: choice B is a legitimate viability control and stays defensible until the student applies the requirement that one experiment must also probe mechanism, and choice C survives until reproducibility is distinguished from causal inference. Two conditions are met, so hard is justified. |

**Correct answer (D): At the top dose, strip sodium from the perfusate and show that transfer of the test solute collapses while an inert passively absorbed tracer crosses at its usual rate**

Citations: AP:49346; BIO:7347; BIO:7023; BIO:6926

**Distractors**

- **(A)** `misconception`: Treats temperature sensitivity as diagnostic of a protein assisted route. Unassisted diffusion through lipid also speeds up when warmed, so the result discriminates nothing between the two mechanisms, and it leaves the injury objection untouched.
  - Citation: BIO:6926
- **(B)** `partial_truth`: A valid viability control that does answer the reviewer, but it stops there. Showing that the loops are intact does not establish that the route depends on a protein or on a supplied ion gradient, so the mechanism claim remains untested.
  - Citation: BIO:7023
- **(C)** `adjacent_fact`: Replication in a second species establishes reliability, which is a true virtue but a different one. It cannot exclude tissue injury and provides no evidence about the energy source or the protein, so it addresses neither part of the question.
  - Citation: BIO:7347

**Readback check.** Content words of six or more letters in the key (choice D): sodium, perfusate, transfer, solute, collapses, passively, absorbed, tracer, crosses. The stem's long words of six or more letters are Investigators, perfuse, matched, jejunum, soluble, vitamin, graded, luminal, doses, record, reaches, venous, effluent, minute, climbs, steeply, flattens, completely, raising, further, nothing, reviewer, counters, portion, strongest, solutions, injured, assisted, experiment. The only shared root is perfuse and perfusate, which names the fluid rather than the mechanism. The load bearing word, sodium, appears nowhere in the stem, and the stem supplies a plateau and an objection but never names an energy source or a control, so the key cannot be recovered by restatement.

**Explanation (as shipped).**

> This Organ Systems item tests the difference between a route that depends on a protein and on a supplied energy source and unassisted movement through lipid, and how to build a follow up study that separates a real mechanism from an artifact. The answer is D because it collects two readings from the same loops at the same top dose: a viability reading that stays normal if the tissue is healthy, and an energy source reading that only a protein coupled route can fail. Many nutrients cross the apical surface bound to a protein that simultaneously carries sodium down its steep inward electrochemical gradient, so the sodium gradient, not the nutrient gradient, supplies the work. Take the sodium out of the lumen and that gradient disappears, and transfer disappears with it. Unassisted passage through the lipid of the membrane has no such dependence, so it would continue regardless of which ion sits in the lumen. Injured tissue would also stop taking up a solute, which is exactly why the flat portion on its own is ambiguous. The inert tracer crossing at its usual rate in the very same loops shows the epithelium is intact, so the collapse cannot be blamed on damage. One experiment therefore settles both the objection and the mechanism.
> (Choice A) Raising the temperature accelerates almost everything that depends on molecular motion, unassisted diffusion through lipid included. A higher rate at every dose is therefore compatible with either mechanism, and this design also says nothing about whether the strongest solutions damaged the tissue.
> (Choice B) This is a sound viability control and it does dispose of the reviewer's objection, so it is attractive. It stops short, though, because a flat response in a demonstrably intact loop still leaves the cause open. Ruling out injury is necessary but not sufficient, and nothing here shows that the route depends on a protein or on an energy supply.
> (Choice C) Reproducing the flattening in another species speaks to reliability rather than to cause. A reproducible artifact is still an artifact, so this design neither excludes tissue damage nor provides evidence about mechanism, and reproducibility alone cannot arbitrate between the two competing explanations.
> This is a Reasoning about the Design and Execution of Research question because it asks the student to select the follow up whose internal control eliminates an alternative explanation while the same manipulation independently tests the proposed transport mechanism.

---

## B2-Q6 . Shared carrier competition between similar nutrients

**Stem.** In an isolated brush border preparation, leucine uptake falls by half when isoleucine is added at high concentration, but is unaffected when equal concentrations of lysine or glucose are added. A student swallows a purified leucine capsule with water alone on one day, and in the middle of a large steak dinner on another day. Compared with the water only day, leucine appearing in the bloodstream over the next hour on the steak day will most likely be:

- **A.** reduced, because the meal releases chemically similar molecules that vie for a limited number of binding sites  <- **KEY**
- **B.** unchanged, because a protein assisted route always operates at its maximum rate whenever its substrate is present
- **C.** raised, because the extra amino acids liberated by the meal drive the transport step to run faster
- **D.** reduced, but only after the amino acids liberated by the meal have been cleared from the lumen

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic secondary / structural direct) |
| Estimated time | 70 s |
| Confidence | 5 |

**Correct answer (A): reduced, because the meal releases chemically similar molecules that vie for a limited number of binding sites**

Citations: AP:49363; AP:50842; BIO:7023

**Distractors**

- **(B)** `misconception`: Holds that an assisted route runs at maximum rate whenever substrate is present, ignoring that the rate depends on how the finite sites are shared. The stem's own data, showing depressed leucine uptake with isoleucine present, refute it.
  - Citation: BIO:7023
- **(C)** `reversed_relationship`: Correct variables, wrong direction. Additional molecules recognized by the same site compete for occupancy rather than accelerating the route, and the preparation showed suppression, not stimulation.
  - Citation: AP:50842
- **(D)** `process_step_confusion`: Recasts simultaneous competition as a sequential queue in which the supplement waits until meal derived molecules are gone. Competing molecules contend for the same sites at the same moment, so the reduction occurs during the meal rather than after it.
  - Citation: AP:49363

**Readback check.** Content words of six or more letters in the key (choice A): reduced, releases, chemically, similar, molecules, limited, number, binding. The stem's long words of six or more letters are isolated, border, preparation, leucine, uptake, isoleucine, concentration, unaffected, concentrations, lysine, glucose, student, swallows, purified, capsule, another, dinner, Compared, appearing, bloodstream. There is no overlap. The stem gives a competition result in a dish but never says what a steak contains and never names a shared route, so the key requires an inference rather than a restatement.

**Explanation (as shipped).**

> This Organ Systems item tests what it means for two nutrients to share one uptake route and how that plays out when a supplement meets a full meal. The answer is A because the preparation data show a shape selective interaction: one branched neutral amino acid interferes with another, while a charged amino acid and a sugar do not. That pattern points to a finite set of sites that recognize a particular shape rather than to a general slowdown, since a general slowdown would have been produced by lysine and glucose too. Digesting a steak floods the lumen with the very class of molecules that interfered in the dish, so the supplement now has to share those sites and a smaller fraction of the dose is picked up in any given interval. Notice that the student is never told which molecules a steak yields, so the inference runs from the selectivity pattern to the composition of the meal to the predicted outcome.
> (Choice B) This assumes that an assisted route runs flat out whenever anything it recognizes is nearby. Occupancy is what sets the rate, and occupancy is shared, so when several recognized molecules are present at once each one gets a smaller share of the available sites. The data in the stem already contradict this, since leucine uptake was measurably depressed.
> (Choice C) This has the right variables pointing the wrong way. Extra molecules that fit the same site do not recruit the site to work harder, they occupy it. A route of this kind has no mechanism for being urged along by a rival substrate, and the isolated preparation showed suppression rather than stimulation.
> (Choice D) This turns a simultaneous contest into an orderly queue. Molecules do not wait their turn in the lumen, they arrive at the sites at rates set by their relative amounts and by how tightly each is bound, so the interference is happening during the meal rather than afterward. The direction is right but the timing and the mechanism are misplaced.
> This is a Scientific Reasoning and Problem Solving question because it asks the student to read a selectivity pattern from a laboratory preparation and use it to predict how a real meal will change the uptake of a supplement taken with it.

---

## B2-Q7 . Storage capacity from bile concentration

**Stem.** A fasting volunteer's bile is sampled from the tube leaving the liver and from inside the gallbladder during the same procedure, and the liver's output rate and the gallbladder's holding volume are recorded.

| Measurement | Value |
| --- | --- |
| Bile salt concentration, bile leaving the liver | 30 mmol/L |
| Bile salt concentration, gallbladder bile | 300 mmol/L |
| Rate of bile formation by the liver | 600 mL per day |
| Volume the gallbladder holds when full | 50 mL |

When completely full, the gallbladder contains approximately what share of the bile salt the liver puts out in one day?

- **A.** About 8 percent
- **B.** About 17 percent
- **C.** About 83 percent  <- **KEY**
- **D.** About 0.8 percent

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **medium** (topic secondary / structural multi_step) |
| Estimated time | 105 s |
| Confidence | 5 |

**Correct answer (C): About 83 percent**

Citations: AP:48975; AP:48889; AP:48887

**Distractors**

- **(A)** `scale_unit_error`: Compares volumes in millilitres as though millilitres measured amount of bile salt, so it ignores the tenfold difference in concentration that determines how much solute the stored volume actually carries.
  - Citation: AP:48975
- **(B)** `process_step_confusion`: This is the complementary quantity, the fraction of the daily output left unstored, produced by carrying the calculation one step past what was asked.
  - Citation: AP:48975
- **(D)** `reversed_relationship`: Assigns the concentrated value to the fluid coming from the liver and the dilute value to the stored fluid, reversing which sample the water absorbing lining has acted upon.
  - Citation: AP:48889

**Readback check.** Key text is 'About 83 percent'. Content words of six or more letters in the key: percent. The word percent appears nowhere in the stem, and it appears in every option, so it cannot discriminate. No numeric value in the table equals 83 or any simple readback of it; the key must be computed from four separate table entries.

**Explanation (as shipped).**

> This question sits in the Organ Systems category and tests how a small storage organ accommodates the continuous output of a much larger secretory one. The answer is C because a full gallbladder holds 50 mL at 300 mmol/L, which is 15 mmol of bile salt, while the liver delivers 600 mL at 30 mmol/L, or 18 mmol, across a day, and 15 out of 18 is five sixths, or about 83 percent. The two concentration figures differ by a factor of ten, and that factor carries the whole argument: the lining of the storage organ pulls water and small ions out of the fluid it receives, so the volume collapses while the solutes left behind rise in proportion. Storage capacity therefore has to be judged in amount of solute, not in millilitres. Judging by volume alone would suggest the organ could bank only a sliver of a day's production, whereas stripping out roughly nine tenths of the water lets it bank most of it. The same reasoning predicts that stored fluid is not simply fresh fluid in a smaller container: compared with fresh fluid it is far richer in whatever the lining cannot reabsorb and correspondingly poorer in water and in the ions that leave with it.
>
> (Choice A) About 8 percent is the ratio of the two volumes, 50 mL against 600 mL. It treats millilitres as though they measured amount of bile salt and discards the tenfold concentration difference the table supplies.
>
> (Choice B) About 17 percent is the leftover share, the portion of a day's output that one filling could not accommodate. It is the complement of the quantity asked for rather than the quantity itself.
>
> (Choice D) About 0.8 percent comes from attaching the higher concentration to the fluid leaving the liver and the lower one to the stored fluid. That reversal contradicts the measurements, since the water absorbing lining sits downstream of the liver and acts on fluid that has already left it.
>
> This is a Data-based and Statistical Reasoning question because it requires converting two concentrations and two volumes into amounts of solute and then forming a ratio, rather than reading any single value off the table.

---

## B2-Q8 . Pump failure versus open outlet in bile delivery

**Stem.** In an anaesthetised animal, a drug is infused that abolishes contraction of the gallbladder wall while leaving the smooth muscle ring at the shared outlet into the duodenum free to relax normally. The liver goes on forming bile at its usual rate. A fatty meal stimulus is then delivered into the duodenum. What is the most likely result?

- **A.** Delivery into the gut is unchanged, because relaxation of the outlet ring by itself paces the arrival of bile
- **B.** Bile still trickles into the gut at the rate the liver forms it, but no concentrated surge arrives and duct pressure stays low  <- **KEY**
- **C.** Pressure climbs steeply inside the bile ducts and bile backs up toward the liver
- **D.** No bile whatever reaches the gut, because every drop of delivery depends on the squeezing wall

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 75 s |
| Confidence | 5 |

**Correct answer (B): Bile still trickles into the gut at the rate the liver forms it, but no concentrated surge arrives and duct pressure stays low**

Citations: AP:48973; AP:48330; AP:48887

**Distractors**

- **(A)** `misconception`: Rests on the belief that opening the outlet is by itself sufficient for normal delivery, when an open path supplies no force to expel the stored volume.
  - Citation: AP:48330
- **(C)** `adjacent_fact`: Correctly describes what happens when the outlet is held shut, which is a different lesion from the one given, and cannot occur while the exit relaxes normally.
  - Citation: AP:48330
- **(D)** `partial_truth`: Right that the stored surge is lost, but wrong that delivery stops entirely, since bile formed continuously by the liver can still pass an outlet that opens.
  - Citation: AP:48887

**Readback check.** Key text is 'Bile still trickles into the gut at the rate the liver forms it, but no concentrated surge arrives and duct pressure stays low'. Content words of six or more letters in the key: trickles, concentrated, arrives, pressure. None of these appears in the stem, which uses abolishes, contraction, relax, infused, stimulus and delivered. The stem states only which structure is disabled; the delivery and pressure consequences must be inferred, and pressure is discussed in more than one option so it cannot serve as a matching cue.

**Explanation (as shipped).**

> This Organ Systems item tests how a reservoir and a gated outlet divide the work of delivering bile. The answer is B because moving fluid along a tube needs two separate things, a driving force and an open path, and this preparation has removed only the first of the two big contributions to the driving force while leaving the path wide open. The liver secretes bile continuously and its own secretion pressure still pushes that fluid forward, so a slow trickle keeps arriving in the gut. What is lost is the stored volume, which normally leaves as a concentrated surge when the wall squeezes, so the meal is not met by any surge at all. Because the exit is open, nothing dams up behind it and the pressure inside the ducts stays at its low resting value. The mirror image lesion, a wall that squeezes normally against an outlet held shut, also fails to deliver the stored volume, but there the effort is converted into pressure instead of flow and the ducts distend. That pressure difference is the practical way to tell a pump problem from an outlet problem.
>
> (Choice A) This treats the outlet ring as the sole determinant of delivery. Relaxing the ring supplies a path but supplies no force to move the stored volume through it, so the meal receives only the liver's ongoing trickle rather than the usual surge, and delivery is therefore not unchanged.
>
> (Choice C) This is the picture produced by the opposite lesion, an outlet that will not open. Pressure can only build when the fluid has nowhere to go, and here the exit relaxes normally, so there is no obstruction for the liver's output to back up against.
>
> (Choice D) This overstates the role of the reservoir. The wall is needed to expel stored bile, but it is not the only source of forward pressure, since bile leaving the liver can still travel through an open outlet on its own.
>
> This is a Knowledge of Scientific Concepts and Principles question because it asks the student to apply the principle that flow requires both a driving force and an open exit to a specific pairing of a muscular reservoir with a gated outlet in the biliary system.

---

## B2-Q9 . One duct lesion, two downstream consequences

**Stem.** A patient develops a stone firmly lodged in the single duct that carries bile from the liver and gallbladder into the small intestine, so that nothing passes it. The liver cells, the gut lining and the lifespan of the patient's red blood cells are all normal. Over the next several days, blood work and the appearance of the patient's bowel movements are recorded. Which pair of findings is expected, and why?

- **A.** Blood pigment rises, and the stools darken beyond their usual colour, because the trapped pigment is redirected into the gut
- **B.** Blood pigment stays normal, and the stools turn pale, because the liver has stopped making the pigment
- **C.** Blood pigment rises, and the stools keep their usual colour, because gut bacteria manufacture the brown colouring themselves
- **D.** Blood pigment rises, and the stools turn pale, because the block traps the pigment upstream and starves the gut of it  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 110 s |
| Confidence | 5 |
| Hard-tier gate | (a) it combines two separate ideas, retention of an excreted substance behind a block and failure of delivery beyond it; (b) it requires a directional inference running in two opposite directions from one lesion; (c) choices A and C stay defensible until the student applies the specific fact that gut bacteria convert rather than synthesise the brown pigment. |

**Correct answer (D): Blood pigment rises, and the stools turn pale, because the block traps the pigment upstream and starves the gut of it**

Citations: AP:48882; AP:48883; AP:48884; AP:34223; AP:48845

**Distractors**

- **(A)** `reversed_relationship`: Gets the upstream consequence right but reverses the downstream one, treating reduced delivery to the gut as something that intensifies rather than removes stool colour.
  - Citation: AP:48883
- **(B)** `partial_truth`: The pale stools are correct, but the stated cause is wrong and it therefore misses the blood finding: the stem specifies normal liver cells and normal red cell turnover, so production has not stopped.
  - Citation: AP:48882
- **(C)** `misconception`: Rests on the false belief that intestinal bacteria generate the brown pigment from scratch, when they only convert pigment that has been delivered to them.
  - Citation: AP:34223

**Readback check.** Key text is 'Blood pigment rises, and the stools turn pale, because the block traps the pigment upstream and starves the gut of it'. Content words of six or more letters in the key: pigment, stools, upstream, starves. None appears in the stem, which speaks of a stone, a duct, blood work and bowel movements and never names bile pigment, colour or bacteria. Every option opens with a blood finding and a stool finding, so no option can be picked by matching a stem phrase.

**Explanation (as shipped).**

> This Organ Systems question tests the reasoning that a single interruption in a one way excretory route produces paired consequences, one upstream of the block and one downstream of it. The answer is D because that duct is the only route by which this pigment reaches the gut, so plugging it both traps the pigment behind the plug, where it spills into the circulation, and prevents it from reaching the bacteria that convert it into the brown compound responsible for normal stool colour. The upstream half follows from the fact that liver cells go on processing and exporting the pigment whether or not the exit is open, so with nowhere to go it accumulates and enters the blood, which is what yellows the skin and the whites of the eyes. The downstream half follows from the fact that the intestinal bacteria are converters rather than producers: they act on pigment that arrives from above, so if nothing arrives, nothing is made and the stools lose their colour. Because the stem rules out any change in red cell turnover and any failure of the liver cells themselves, both findings must be traced to the mechanical block rather than to overproduction or to failed synthesis. Once the liver has processed it the pigment is water soluble, so some of the retained material leaves in the urine and darkens it, but that is a leak around the edges and not an alternative route into the gut. Recognising that one lesion explains two seemingly unrelated observations is the point of the item.
>
> (Choice A) The upstream half is right and the downstream half is inverted. Stool colour depends on how much pigment arrives in the gut, not on how much is held back, and a duct that admits nothing cannot redirect anything into the intestine.
>
> (Choice B) This keeps the pale stools but attributes them to a halt in production. The stem specifies normal liver cells and a normal red cell lifespan, so production continues and the retained material has to appear somewhere, which is why blood levels do not stay normal.
>
> (Choice C) This treats the gut bacteria as the source of the pigment rather than as the step that modifies it. They work on material delivered from above, so blocking delivery removes their substrate and the stools cannot keep their normal colour.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to derive two consequences running in opposite directions, retention behind the block and deprivation beyond it, from one anatomical lesion while excluding the alternative causes that the stem rules out.

---

## B2-Q10 . Consequence of being the first processing stop

**Stem.** A drug taken by mouth crosses the intestinal lining without being altered, and every molecule absorbed must pass through the liver before it can reach any other tissue. The identical dose given directly into a vein produces a peak level in the general circulation several times higher than the swallowed dose does, and far more of the unaltered drug is later recovered in the urine after the injected dose than after the swallowed one. Which property of the liver do these observations demonstrate?

- **A.** It can chemically modify a large share of an ingested substance before the rest of the body is exposed to it  <- **KEY**
- **B.** It slows the rate at which molecules cross the gut lining into the blood
- **C.** It holds the drug temporarily and later releases it unchanged, so total exposure is the same by either route
- **D.** It passes onward more of the unchanged drug than it receives

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic secondary / structural two_step) |
| Estimated time | 95 s |
| Confidence | 4 |

**Correct answer (A): It can chemically modify a large share of an ingested substance before the rest of the body is exposed to it**

Citations: AP:48849; AP:48850; AP:4911

**Distractors**

- **(B)** `adjacent_fact`: Describes a property of the absorptive surface rather than of the organ asked about, and a change in absorption rate cannot reduce the total amount of unaltered drug ever recovered.
  - Citation: AP:48849
- **(C)** `partial_truth`: Temporary retention is a genuine liver capability, but it would shift the timing of appearance without lowering total recovery of the unaltered form, so it fails to explain the data given.
  - Citation: AP:48850
- **(D)** `reversed_relationship`: Reverses the direction of the change across the organ, claiming enrichment of unaltered drug where the data indicate depletion.
  - Citation: AP:4911

**Readback check.** Key text is 'It can chemically modify a large share of an ingested substance before the rest of the body is exposed to it'. Content words of six or more letters in the key: chemically, modify, ingested, substance, exposed. None of these appears anywhere in the stem, which uses altered, absorbed, swallowed, injected and recovered instead. The key is not a one line textbook function readback, because the student must infer that conversion is occurring from the combination of a lower peak and reduced recovery of the unaltered molecule.

**Explanation (as shipped).**

> This Organ Systems question tests the functional payoff of the liver occupying the first processing position for material taken up from the gut. The answer is A because the two routes differ in exactly one respect, whether the dose passes the liver before entering the general circulation, and the route that does pass it yields both a lower peak and less unaltered drug recovered afterwards, which is the signature of chemical conversion rather than of delay or of storage. Loss of material, not merely rearrangement of its timing, is what the recovery figure reports, and only a step that changes the molecule can destroy the original form. A substantial fraction is therefore converted on the way through, so the rest of the body sees a smaller and chemically different load than the gut delivered. That positional advantage is what allows the liver to intercept ingested toxins before they are distributed, and it is also why the effective swallowed dose of many compounds must exceed the injected dose.
>
> (Choice B) This locates the limitation at the wrong step. Slowing absorption would flatten and delay the rise in blood level without destroying any drug, so the amount of unaltered drug eventually recovered would still match the injected dose, and the stem separately states that the lining passes the molecule unchanged.
>
> (Choice C) Temporary holding is a real capability of the organ, but it cannot account for the data. Storage followed by release shifts when the drug appears without removing any of it, so total recovery of the unaltered form would be preserved, which contradicts the urine finding.
>
> (Choice D) This states the relationship backwards. Blood leaving after the first pass carries less unaltered drug than it brought in, which is precisely why the swallowed route produces the lower peak at an equal dose.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to compare two routes of administration that differ in a single respect and to infer, from a lower peak combined with reduced recovery of the unaltered molecule, that conversion rather than delay explains the difference.

---

## B2-Q11 . Hepatic modification enabling pigment excretion

**Stem.** Hepatocytes attach two sugar-acid groups to bilirubin before pumping it into the bile canaliculus. In a newborn whose enzyme for this step is still immature, the pigment builds up in blood bound to albumin and very little of it reaches bile. Which property of the pigment does this hepatic step alter so that the molecule can leave the body in a watery secretion?

- **A.** It lowers the pigment's toxicity so that cells lining the gut are not injured on contact.
- **B.** It splits the pigment's four-ring backbone into fragments small enough to cross the membrane.
- **C.** It makes the pigment hydrophilic enough to stay dissolved in bile without a carrier protein.  <- **KEY**
- **D.** It strengthens the pigment's binding to albumin so that more can be delivered per unit of blood.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 65 s |
| Confidence | 5 |

**Correct answer (C): It makes the pigment hydrophilic enough to stay dissolved in bile without a carrier protein.**

Citations: AP:34221, AP:48850, AP:48882, AP:58722

**Distractors**

- **(A)** `misconception` . _detoxification-instead-of-solubility_: Reducing toxicity is a genuine downstream benefit but is not the property that allows a molecule to be carried in a watery fluid; a nontoxic yet insoluble pigment would still be unexcretable in bile.
  - Citation: AP:58722
- **(B)** `process_step_confusion` . _right-process-wrong-stage_: Ring cleavage happens before the liver stage, during heme degradation, and further breakdown happens after excretion when colonic bacteria act; the hepatocyte adds groups rather than breaking the tetrapyrrole apart.
  - Citation: AP:34221, AP:34223
- **(D)** `reversed_relationship` . _binding-direction-inverted_: The modification weakens rather than strengthens albumin binding, because a water soluble product no longer requires a plasma carrier; tight albumin binding characterises the unmodified pigment.
  - Citation: AP:34221, AP:48882

**Readback check.** Content words of six or more letters in the key, listed independently: pigment, hydrophilic, dissolved, without, carrier, protein. Content words of six or more letters in the stem: Hepatocytes, attach, sugar-acid, bilirubin, before, pumping, canaliculus, newborn, whose, enzyme, immature, pigment, builds, albumin, little, reaches, property, hepatic, molecule, watery, secretion. The only shared item is 'pigment', the unavoidable subject noun; every decisive term in the key (hydrophilic, dissolved, carrier, protein) is absent from the stem. The stem states a failure and its consequence and never states the solubility principle, so the key cannot be copied out of it.

**Explanation (as shipped).**

> This Organ Systems item tests what the liver does chemically to bile pigment and why the unaltered form cannot appear in a watery secretion at all. The answer is C because the sugar-acid groups added inside the hepatocyte make the pigment hydrophilic, so it stays dissolved in bile on its own rather than depending on a protein to hold it in solution. Bilirubin as it arrives at the liver is a flat, largely nonpolar molecule that is essentially insoluble in body water, which is exactly why it must travel bound to albumin and why the free level in blood stays vanishingly low. Attaching two glucuronic acid units hangs charged, hydroxyl-rich sugars onto the molecule and converts it into a species that dissolves readily in an aqueous fluid. Only after that change can the hepatocyte pump it into the bile canaliculus and have it remain in solution all the way to the duodenum. When the conjugating enzyme is immature, the unaltered form accumulates on albumin instead, and albumin-bound material is not pumped into bile, so essentially none of it appears downstream, which is the picture described. (Choice A) Handling the pigment does reduce its ability to enter cells and do harm, and the unaltered form is genuinely neurotoxic in a newborn, but toxicity is not the property that permits secretion. A harmless molecule that is still insoluble could not be carried away in a watery fluid, so this choice names a real benefit that does not answer what was asked. (Choice B) The four-ring backbone is not cleaved in the liver. Ring opening happens earlier, when heme is degraded, and further breakdown happens later, once bacteria in the colon attack what has been excreted, so this choice moves a real event to the wrong stage. (Choice D) The relationship runs the opposite way. The modified pigment binds albumin far more weakly, precisely because a water soluble product no longer needs a carrier, and it is the unmodified form that is tightly held by albumin. This is a Knowledge of Scientific Concepts and Principles question because it asks the student to name the chemical property a hepatic modification changes and to state why that change is the prerequisite for putting the pigment into an aqueous secretion.

---

## B2-Q12 . Pattern separating obstruction from red cell loss

**Stem.** Three adults were evaluated for yellow sclerae and the panel below was obtained. Laboratory reference limits are a water-soluble fraction below 0.3 mg/dL and an albumin-bound fraction below 0.8 mg/dL.

| Adult | Water-soluble fraction (mg/dL) | Albumin-bound fraction (mg/dL) | Urine urobilinogen | Stool colour |
|---|---|---|---|---|
| J | 0.2 | 4.8 | raised | dark brown |
| K | 5.4 | 0.5 | absent | pale grey |
| L | 0.2 | 0.6 | normal | brown |

Adults J and K both have a raised total. Which reasoning correctly identifies the one whose duct is blocked?

- **A.** J, because a high albumin-bound fraction shows that export out of the liver cell has failed.
- **B.** K, because material that the liver has processed is backing up while none of it reaches colonic bacteria.  <- **KEY**
- **C.** K, because the sum of the two fractions is larger than the sum in the other adult's row.
- **D.** J, because dark stool shows that the pigment is being concentrated upstream of a narrowing.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 105 s |
| Confidence | 5 |
| Hard-tier gate | Hard on three counts. (a) It combines two separate concepts, hepatic modification of the pigment and bacterial conversion in the colon. (c) Choices A and C stay defensible until the student applies the specific facts that the modification precedes the export step and that totals do not localise. (d) It inverts the usual direction of reasoning by giving the outcome, a laboratory pattern, and demanding the cause. |

**Correct answer (B): K, because material that the liver has processed is backing up while none of it reaches colonic bacteria.**

Citations: AP:34223, AP:34235, AP:48845, AP:48850, AP:48883

**Distractors**

- **(A)** `reversed_relationship` . _fraction-assigned-to-wrong-side-of-the-liver_: A failure of export from the hepatocyte would raise the water-soluble fraction, since the modification has already happened; a high albumin-bound fraction places the problem before that step, not at the duct.
  - Citation: AP:48850
- **(C)** `partial_truth` . _magnitude-substituted-for-pattern_: The totals genuinely are higher for K, but a magnitude does not localise a lesion; the same total could arise from either mechanism, so the reasoning does not support the conclusion it reaches.
  - Citation: AP:34235
- **(D)** `misconception` . _stool-colour-inverted_: Dark stool proves pigment is still arriving in the colon and being converted by bacteria; obstruction removes the brown pigment and gives pale stool, so the colour is being read in the wrong direction.
  - Citation: AP:34235, AP:48883

**Readback check.** Content words of six or more letters in the key, listed independently: because, material, processed, backing, reaches, colonic, bacteria. Content words of six or more letters in the stem and table: adults, evaluated, yellow, sclerae, obtained, Laboratory, reference, limits, water-soluble, fraction, albumin-bound, urobilinogen, colour, raised, absent, normal, reasoning, correctly, identifies, blocked. There is no overlap. No table value is itself the answer; the key is a causal conclusion drawn from the joint pattern of three columns, and both J and K carry raised totals so the numbers alone do not select a row.

**Explanation (as shipped).**

> This Organ Systems item tests the pattern of findings that separates a closed outflow route from a heavy load arriving at a working liver. The answer is B because adult K's row shows the form that the liver has finished handling piling up in blood at the same time that the gut receives none of it, a combination that is only possible if the route from liver to intestine is shut. Once the hepatocyte adds sugar-acid groups it pumps the water soluble product into bile. If the duct is obstructed that product cannot leave, so it refluxes into blood and the water-soluble fraction climbs while the albumin-bound fraction stays within its reference limit, exactly as in row K. Because nothing arrives in the colon, resident bacteria make no urobilinogen and no stercobilin, so the faeces lose their brown pigment and turn pale, and the urine loses the urobilinogen that is normally reabsorbed from the colon and cleared by the kidney. Adult J shows the mirror image: the albumin-bound fraction is high, yet the liver is plainly still delivering pigment downstream, since urobilinogen is raised and the stool is dark. The magnitude of the total is therefore useless for localising the lesion; only the split between the two fractions read together with the evidence of intestinal delivery does the job. (Choice A) This inverts the direction of the reasoning. A failure to export from the hepatocyte would raise the water-soluble fraction, because the sugar-acid groups have already been added by that point, so a high albumin-bound fraction points to a step earlier than the modification, not to the duct. (Choice C) This reaches the right adult by the wrong route. The sums are 5.9 for K and 5.0 for J, so the statement is numerically true, but a total concentration is only a magnitude, and magnitude alone cannot tell you where along the path the pigment is stuck. (Choice D) Dark stool is positive evidence that pigment is reaching the colon and being converted there by bacteria. A blocked duct produces the opposite finding, the pale grey stool seen in row K, so this choice reads the colour backwards. This is a Data-based and Statistical Reasoning question because it asks the student to compare rows of a laboratory panel and decide which combination of fraction split and downstream colour, rather than which single largest number, localises the lesion.

---

## B2-Q13 . Germ-free gut and pigment colour loss

**Stem.** A colony of laboratory mice is reared so that no microbes ever settle in the large intestine. Bile flow, liver function and diet are all normal, and the animals are otherwise well. Which of the following would be expected in these mice?

I. Faeces that are yellow-green rather than brown
II. A fall in the quantity of pigment excreted by the kidneys
III. Retention of pigment in the blood with yellowing of the tissues

- **A.** I only
- **B.** III only
- **C.** I and III only
- **D.** I and II only  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic secondary / structural multi_step) |
| Estimated time | 95 s |
| Confidence | 4 |
| Hard-tier gate | Hard on three counts. (a) It combines colonic bacterial metabolism with renal handling of the reabsorbed product. (b) It demands a directional inference, that urinary pigment output falls, from a change made two organs upstream. (c) Item III keeps choices B and C defensible until the student applies the specific fact that hepatic excretion is untouched in these animals. |

**Correct answer (D): I and II only**

Citations: AP:34223, AP:34224, AP:34230, AP:34235, AP:48883

**Distractors**

- **(A)** `partial_truth` . _gut-only-endpoint_: Correct about stool colour but stops at the gut lumen, missing that part of the bacterial product is reabsorbed and later cleared by the kidney, so urinary pigment falls too.
  - Citation: AP:34230
- **(B)** `process_step_confusion` . _bacterial-step-moved-upstream-of-clearance_: Places the bacterial step before hepatic clearance rather than after it; the liver has already finished removing the pigment from blood by the time colonic bacteria act, so deleting the microbes cannot cause plasma accumulation.
  - Citation: AP:34223, AP:48882
- **(C)** `misconception` . _lumen-effect-generalised-to-plasma_: Assumes that any pigment colour change must mean the pigment is accumulating systemically; the stool change here reflects a missing conversion in the lumen, and hepatic excretion into bile is untouched.
  - Citation: AP:34235

**Readback check.** The key text is 'I and II only' and contains no content word of six or more letters, so direct copying is impossible. Checking the Roman numeral items against the stem: content words of six or more letters in the stem are colony, laboratory, reared, microbes, settle, intestine, function, normal, animals, otherwise, expected, following. The numerals introduce faeces, yellow-green, quantity, pigment, excreted, kidneys, Retention, yellowing, tissues, none of which the stem supplies. The stem gives only an experimental condition, never a result, so every item must be derived rather than read back.

**Explanation (as shipped).**

> This Organ Systems item tests what colonic bacteria do to the excreted bile pigment and which of the body's visible colours depend on that conversion. The answer is D because items I and II both follow from removing the bacterial step, whereas item III would require a defect in a pathway that these animals still have fully intact. The brown of normal faeces is not the colour of the pigment the liver excretes; it is the colour of stercobilin, the end product of bacterial attack on that pigment in the colon. Strip the colon of microbes and the pigment leaves in the stool close to the state in which it arrived, so the faeces take on the yellow-green shade of the unconverted material, which makes item I correct. Item II is correct for a less obvious reason: bacteria first convert the pigment to urobilinogen, a portion of which is taken back up from the colon, returns in the blood, and is cleared by the kidneys, where it is oxidised to urobilin, one of the pigments that contributes to the colour of urine. With no bacteria there is no urobilinogen, so the amount of this pigment leaving in the urine falls. Item III fails because nothing in this animal blocks the liver: uptake, the addition of sugar-acid groups, and pumping into bile all proceed normally, so pigment is cleared from blood at the usual rate and no yellowing occurs. (Choice A) This stops at the stool and misses the renal consequence. It treats the bacterial product as if it were confined to the gut lumen, ignoring the portion that is reabsorbed and later excreted in urine. (Choice B) This assumes that bacteria are needed for the body to clear the pigment at all. Clearance is a hepatic job that is finished once the pigment has been pumped into bile, and the bacterial step comes only after that, so removing it cannot cause the pigment to back up into blood. (Choice C) This pairs a correct prediction about stool with the same false claim about yellowing. It is the most tempting wrong choice, because a student who sees a colour change may assume any colour change implies the pigment is accumulating somewhere. This is a Scientific Reasoning and Problem Solving question because it asks the student to remove one step from a multi-organ pathway and predict which two downstream observations change while a third does not.

---

## B2-Q14 . Uptake failure behind a bleeding tendency

**Stem.** An adult has had a stone lodged in the common bile duct for eight weeks and now bruises easily and clots slowly. A large oral dose of the fat-soluble vitamin that several clotting factors require changes nothing, but the same substance given by injection restores normal clotting within a day. The person has taken no antibiotic and the resident microbes of the large bowel have not been disturbed. What does the contrast between the two routes of delivery establish?

- **A.** Uptake across the intestinal wall has failed, while the liver's ability to use the nutrient is intact.  <- **KEY**
- **B.** Microbes in the large bowel are the body's only meaningful source and they have stopped producing it.
- **C.** The liver's synthetic machinery has been destroyed, so factors cannot be assembled at all.
- **D.** Stomach acid destroyed the swallowed dose before it could reach the absorptive surface.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 85 s |
| Confidence | 5 |

**Correct answer (A): Uptake across the intestinal wall has failed, while the liver's ability to use the nutrient is intact.**

Citations: AP:34685, AP:47452, AP:48684, AP:48845

**Distractors**

- **(B)** `adjacent_fact` . _synthesis-route-substituted-for-absorption-route_: Bowel bacteria do supply some of this vitamin, but they are not the only source and the stem states they are undisturbed; a synthesis shortfall would also have responded to the oral dose, which it did not.
  - Citation: AP:48684, AP:34685
- **(C)** `misconception` . _hepatic-synthetic-failure_: Directly contradicted by the result: if the liver could not assemble the factors, delivering the vitamin by injection would not have corrected the clotting time within a day.
  - Citation: AP:34685
- **(D)** `process_step_confusion` . _failure-relocated-upstream_: Places the loss in the stomach rather than at the intestinal uptake step; this vitamin is not acid labile, and a very large swallowed dose would in any case have outrun such a loss.
  - Citation: AP:34685, AP:48845

**Readback check.** Content words of six or more letters in the key, listed independently: Uptake, across, intestinal, failed, ability, nutrient, intact. Content words of six or more letters in the stem: lodged, common, weeks, bruises, easily, slowly, fat-soluble, vitamin, several, clotting, factors, require, changes, nothing, substance, injection, restores, normal, within, antibiotic, resident, microbes, disturbed, contrast, between, routes, delivery, establish. There is no overlap. The stem reports two experimental outcomes and never states where the defect lies, so the key is an inference and not a restatement.

**Explanation (as shipped).**

> This Organ Systems item tests how a difference between two routes of delivery localises a defect along a nutrient's path from lumen to plasma. The answer is A because the same substance works when it bypasses the gut and fails when it must cross the gut, which places the failure at the step of moving it from the lumen into the body rather than at any step after that. The stem supplies everything needed to run the argument: the substance is fat soluble, several clotting factors depend on it, and the injection corrects the problem quickly. A stone sitting in the common duct for weeks keeps bile out of the intestinal lumen, and a fat soluble substance is poorly taken up when bile is absent, so a swallowed dose travels along the tract and leaves again largely untaken however large it is. Delivered by injection the substance reaches hepatocytes directly, the clotting factors can be finished, functional factors appear in plasma, and the clotting time normalises within a day. That correction is the discriminating observation, because a defect anywhere downstream of absorption would not be repaired simply by changing how the substance is delivered. The stem also closes off the competing explanation on purpose, since the bowel microbes are undisturbed and so a shortfall of what they make cannot be the cause. (Choice B) This is a true statement about a different situation. Bowel bacteria do contribute some of this vitamin, but it is also obtained from the diet, the stem explicitly leaves the microbes undisturbed, and a bacterial shortfall would have responded to a swallowed dose, which is precisely what did not happen here. (Choice C) The injection result refutes this directly. If the liver could no longer assemble the factors, no route of delivery would help, so the prompt correction after injection is evidence that the hepatic machinery is intact. (Choice D) This relocates the failure to the wrong stage. The vitamin survives the stomach perfectly well, and if acid were the problem then a very large swallowed dose would have overwhelmed such a loss, whereas the dose given here achieved nothing at all. This is a Scientific Reasoning and Problem Solving question because it asks the student to treat the difference between an oral and an injected dose as a natural experiment and infer which single step in the pathway has been lost.

---

## B2-Q15 . Daily fluid load and colonic reserve

**Stem.** The table lists one day of water handling in a healthy adult, along with the greatest amount the colon can take up in 24 hours.

| Item | Litres per day |
| --- | --- |
| Swallowed in food and drink | 2.0 |
| Added as digestive juices | 7.0 |
| Delivered to the colon | 1.5 |
| Leaving in stool | 0.15 |
| Ceiling on colonic uptake | 4.5 |

Uptake by the small intestine now begins to fail, with nothing else altered. At what point does stool turn liquid?

- **A.** As soon as the small intestine leaves behind more than about 0.15 L per day, because that is the entire margin available.
- **B.** Straight away and in proportion to the failure, because the colon takes up a set percentage of what it is given rather than a set amount.
- **C.** Once roughly 3 L per day more than usual arrives at the colon, since that is where its reserve runs out.  <- **KEY**
- **D.** Not at all from a small intestinal fault alone, because colonic reserve is greater than the whole amount handled each day.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 105 s |
| Confidence | 5 |
| Hard-tier gate | (a) combines the split of the daily load between two segments with the separate idea of an absolute absorptive ceiling; (b) requires summing inputs and subtracting to obtain a spare capacity, then expressing that capacity as a fraction of the load; (c) choices A and B stay defensible until the student recognises that the 4.5 L figure is a maximum amount rather than a percentage. |

**Correct answer (C): Once roughly 3 L per day more than usual arrives at the colon, since that is where its reserve runs out.**

Citations: AP:49445; AP:49251; AP:48694

**Distractors**

- **(A)** `adjacent_fact`: Lifts a real tabulated number, the 0.15 L normal stool output, and treats it as the system's spare capacity, understating the true tolerance by roughly twenty times.
  - Citation: AP:49445
- **(B)** `misconception`: Treats colonic uptake as a fixed fraction of the delivered load rather than as an absolute daily maximum, so it predicts stool changes with no threshold at all.
  - Citation: AP:48694
- **(D)** `partial_truth`: Correctly notes that the colon holds reserve, but 4.5 L is only half of the 9.0 L presented each day, so a large upstream failure can still overwhelm it.
  - Citation: AP:49445

**Readback check.** Content words of six or more letters in key C: roughly, arrives, reserve. None appears anywhere in the stem or table, which uses swallowed, digestive, delivered, ceiling, colonic, intestine, healthy, greatest, handling, amount, altered, liquid. The key is not readable off the table: 3 L appears nowhere as a tabulated value and must be computed as 4.5 minus 1.5, then weighed against the 9.0 L total that must itself be summed from two separate rows.

**Explanation (as shipped).**

> This Organ Systems item tests the size of the daily fluid load moving through the gut and how large a failure upstream can be tolerated before stool changes. The answer is C because the colon is given 1.5 L a day but can handle up to 4.5 L, so it holds about 3 L of unused capacity, and only a shortfall bigger than that reaches the stool. Start with the input side: 2.0 L arrives by mouth and 7.0 L is added by the gut itself, so 9.0 L is presented to the small intestine, and most of that is the body's own secretion rather than anything drunk. Because 1.5 L passes on, the small intestine has already recovered 7.5 L, close to 83 percent of the load. The colon then keeps 1.35 L of the 1.5 L it receives, and the 0.15 L that escapes is under 2 percent of the original 9.0 L. The ceiling supplied is an absolute daily amount, not a proportion, so the correct comparison is 4.5 L minus 1.5 L, a spare 3.0 L, which is about a third of the whole 9.0 L load.
>
> (Choice A) The 0.15 L figure is a genuine value in the table, but it is what the system lets go under ordinary conditions, not the margin it holds in hand. Reading an output as a tolerance understates the true buffer by roughly twentyfold.
>
> (Choice B) This treats colonic uptake as a fixed percentage of whatever arrives, which would mean every extra litre delivered produced extra stool at once. The number supplied is a maximum daily amount instead, and a system with headroom soaks up shortfalls silently until that headroom is used up.
>
> (Choice D) The reserve is real but limited. Even the full ceiling of 4.5 L is only half of the 9.0 L handled each day, so a severe small intestinal fault can certainly exceed it and produce liquid stool.
>
> This is a Data-based and Statistical Reasoning question because it asks the student to convert several tabulated daily amounts into a spare capacity and then judge that capacity as a fraction of the total load.

---

## B2-Q16 . Driving force versus route for colonic water

**Stem.** An isolated loop of colon is kept alive in a bath, and its lumen is filled with a salt solution at the same total particle concentration as the bath. A toxin applied to the inner surface blocks sodium entry into the lining cells without killing them and without changing how easily water can cross them. Compared with an untreated loop, what happens to the volume of liquid left in the lumen over the next two hours?

- **A.** Almost nothing is taken up, because the route for fluid stays open but the gradient that would drive fluid through it is never built.  <- **KEY**
- **B.** Almost nothing is taken up, because a poisoned carrier also shuts the pores that let fluid cross.
- **C.** Uptake carries on near its usual rate, since fluid crosses the wall down its own concentration difference regardless of ion handling.
- **D.** Fluid is driven into the lumen instead, since a blocked carrier runs in reverse and expels salt outward.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 85 s |
| Confidence | 5 |

**Correct answer (A): Almost nothing is taken up, because the route for fluid stays open but the gradient that would drive fluid through it is never built.**

Citations: AP:49406; AP:48694; AP:49445

**Distractors**

- **(B)** `process_step_confusion`: Collapses two separate steps, the ion carrier and the water route, into one, so it blames a closed pathway that the stem explicitly states is unchanged.
  - Citation: AP:49406
- **(C)** `misconception`: Treats water movement as independent of ion movement, but the two compartments begin at the same particle concentration, so no gradient exists once transport is blocked.
  - Citation: AP:49445
- **(D)** `reversed_relationship`: Reverses the direction of the blocked step, claiming an inhibited carrier expels salt into the lumen rather than simply ceasing to bring it in.
  - Citation: AP:49406

**Readback check.** Content words of six or more letters in key A: Almost, nothing, because, gradient, through. The stem contains isolated, filled, solution, particle, concentration, applied, surface, blocks, sodium, lining, without, killing, changing, easily, untreated, compared, volume, liquid, hours. No overlap. The stem never states that water follows solute or that transport builds the gradient, so the key cannot be recovered by restatement; the mechanism must be supplied by the student, and the choice between A and B turns on noticing which control the stem provides.

**Explanation (as shipped).**

> This Organ Systems item tests how the large intestine recovers fluid and which part of that machinery the experiment has actually removed. The answer is A because no epithelium in the gut handles water as cargo: it moves ions out of the lumen, and the volume shift is a passive consequence of the concentration difference that ion movement creates. Sodium is brought from the lumen into the cell and then driven onward into the space behind the epithelium at the expense of ATP, which raises particle concentration on that side and lowers it in the lumen. Because the loop was filled at the same total particle concentration as the bath, there is no head start: every bit of the driving force has to be manufactured by transport itself. Block the entry step and that difference is never manufactured, so even a completely open and fully permeable route carries no net movement and the loop finishes with close to the volume it started with. The discrimination that matters here is between a shut route and an absent driving force, two failures that look identical from the outside and can be told apart only by what the setup rules out.
>
> (Choice B) This reaches the right outcome by a mechanism the setup forbids. The toxin is stated not to change how easily water can cross the cells, so the pores are intact, and the failure has to be traced to the missing driving force rather than to a closed route.
>
> (Choice C) Water does move down its own concentration difference, but that difference does not exist on its own. The two compartments start out matched, so with ion movement blocked neither side becomes more concentrated than the other and no net volume shift follows.
>
> (Choice D) Blocking an entry pathway simply stops entry. Carriers do not run backwards and expel their cargo when inhibited, and net movement into the lumen would require a separate outward route being switched on, which nothing in this experiment has done.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to predict the result of removing one transport step and then to decide which of two outwardly identical failure modes the stated controls have eliminated.

---

## B2-Q17 . Fasting test separating two fluid losses

**Stem.** A patient has had several litres of liquid stool a day for a week. Two mechanisms are under consideration: material left in the lumen that cannot be taken up and holds fluid there, and lining cells actively driving fluid outward into the lumen. Stool output can be measured accurately on the ward. Which plan best tells the two apart?

- **A.** Give a known oral dose of a poorly taken up sugar and confirm that output climbs.
- **B.** Draw blood before and after a day of losses and compare the electrolyte readings.
- **C.** Give a drug that slows transit through the gut and see whether output falls.
- **D.** Stop all food and drink for 48 hours, give fluid by vein, and keep weighing what is put out.  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 90 s |
| Confidence | 5 |

**Correct answer (D): Stop all food and drink for 48 hours, give fluid by vein, and keep weighing what is put out.**

Citations: AP:48757; AP:49445; AP:49406

**Distractors**

- **(A)** `partial_truth`: Correctly identifies that unabsorbed material draws fluid into the lumen, but adding such a load raises output under either mechanism, so nothing is distinguished.
  - Citation: AP:49445
- **(B)** `adjacent_fact`: Plasma chemistry is genuinely deranged by heavy losses, but that is true of both mechanisms and says nothing about the origin of the luminal fluid.
  - Citation: AP:48757
- **(C)** `misconception`: Assumes a fall in output identifies the mechanism, but slowing transit lengthens contact time and lowers output on either hypothesis, so the result is the same either way.
  - Citation: AP:48757

**Readback check.** Content words of six or more letters in key D: weighing. The stem contains several, litres, liquid, mechanisms, consideration, material, cannot, lining, actively, driving, outward, output, measured, accurately. No overlap. The stem never mentions eating, fasting, intake or intravenous replacement, so the discriminating manipulation is absent from the stem in every form and must be constructed by the student.

**Explanation (as shipped).**

> This Organ Systems item tests experimental discrimination between two routes to fluid loss from the gut. The answer is D because withholding intake removes the only thing that can hold fluid in the lumen osmotically, so a loss that persists must be generated by the epithelium itself. If unabsorbed material is responsible, the load disappears once nothing is eaten and output falls sharply within a day or so. If instead the cells are pushing ions and fluid outward, that process is driven from the blood side and continues whether or not the patient eats, so output stays high. Replacing losses through a vein is not decorative: it keeps the patient safe over 48 hours and, crucially, avoids reintroducing the very oral load the test is trying to withdraw. Weighing every stool converts a subjective impression into the quantitative endpoint that lets the two predictions be separated, since the whole design rests on the two hypotheses predicting different numbers at the end of the fast.
>
> (Choice A) An osmotically active load raises output under either mechanism, since anyone given enough poorly absorbed material passes more fluid. A manoeuvre whose predicted result is the same on both hypotheses carries no discriminating information.
>
> (Choice B) Blood chemistry documents the consequences of losing fluid and electrolytes, but the two mechanisms produce overlapping derangements. This measures how sick the patient is, not where the fluid in the lumen came from.
>
> (Choice C) Slowing transit lengthens the time contents spend against the wall and lowers output whichever mechanism is at work, so a fall says nothing about origin. It also treats the symptom rather than probing the cause, which is what a discriminating test has to do.
>
> This is a Reasoning about the Design and Execution of Research question because it asks the student to choose the manipulation whose outcome differs between two competing mechanisms and to see why each alternative predicts the same result under both.

---

## B2-Q18 . Sugar salt coupling in rehydration fluid

**Stem.** In an outbreak of profuse liquid stool, a drink containing only salts gives little benefit, whereas the same drink with a small amount of glucose added sharply cuts net losses. In this illness the epithelium pours chloride and fluid into the lumen but is otherwise undamaged. What best accounts for the effect of the added glucose?

- **A.** It is burned by the intestinal cells to supply energy that the ion pump otherwise lacks.
- **B.** It is carried in only alongside sodium, and the extra solute taken up draws fluid after it.  <- **KEY**
- **C.** It pulls fluid across by osmosis on its own, so the salts in the drink play no part.
- **D.** It shuts the outward anion route, stopping the secretion at its source.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 65 s |
| Confidence | 5 |

**Correct answer (B): It is carried in only alongside sodium, and the extra solute taken up draws fluid after it.**

Citations: AP:49297; AP:53075; AP:49406

**Distractors**

- **(A)** `misconception`: Confuses the sugar's role as transported cargo with a role as metabolic fuel; the energy for uptake comes from the sodium gradient maintained by the ATP driven pump.
  - Citation: AP:53075
- **(C)** `partial_truth`: Recognises that osmosis moves the fluid but drops the coupling, since sugar left in the lumen adds particles there and would retain fluid rather than recover it.
  - Citation: AP:49297
- **(D)** `process_step_confusion`: Names the wrong stage, treating the drink as a block on outward secretion when it works by strengthening the parallel absorptive route instead.
  - Citation: AP:49406

**Readback check.** Content words of six or more letters in key B: carried, alongside, sodium, solute. The stem contains outbreak, profuse, liquid, containing, benefit, whereas, glucose, sharply, losses, illness, epithelium, chloride, otherwise, undamaged, accounts. No overlap; the key deliberately avoids the stem word glucose and uses no term the stem supplies. The coupling requirement is stated nowhere in the stem, so the answer cannot be produced by restatement.

**Explanation (as shipped).**

> This Organ Systems item tests why an effective rehydration fluid must supply a sugar as well as a salt. The answer is B because the small intestine takes up certain sugars on a carrier that will not work unless it binds sodium at the same time, so offering the sugar forces sodium uptake alongside it. That absorbed sodium raises the particle concentration on the blood side of the epithelium and lowers it in the lumen, and fluid then follows passively. The important insight is that absorption and secretion are separate machineries running in parallel: the illness has switched on outward movement, but the coupled uptake pathway remains fully intact and can be recruited simply by supplying its partner molecule. A salt only drink offers sodium with nothing to drag it in efficiently, so recovery stays modest, while net balance turns favourable once the absorptive route is driven hard enough to exceed the ongoing loss.
>
> (Choice A) The energy for this uptake step comes from the sodium gradient maintained by the ATP driven pump on the far side of the cell, not from oxidising the newly arrived sugar. Cells with an active secretory process running are not energy starved in the first place.
>
> (Choice C) Sugar alone in the lumen would simply add particles there and, if anything, hold fluid back. Its benefit depends entirely on being taken up together with sodium, so the salts are indispensable rather than incidental.
>
> (Choice D) This describes plugging the leak rather than opening the drain. Nothing about the sugar interferes with the outward pathway; the loss continues unchanged and is simply outweighed by an absorptive route that has been driven harder.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to explain a clinical observation by inferring which transport process the illness has left untouched and how supplying one substrate recruits it.

---

## B2-Q19 . Colonic mucosa fuelled by luminal fermentation

**Stem.** During abdominal surgery a loop of colon is left in place with its arterial circulation intact but is excluded from the stream of contents leaving the small intestine. Over the following weeks the mucosa of that isolated loop becomes thin and inflamed, even though the patient eats well and perfusion of the loop is unimpaired. What accounts for the deterioration?

- **A.** Its absorptive cells are incapable of taking up glucose from capillary blood, so they must always be given nutrients on the cavity side.
- **B.** Amino acids taken up further upstream are normally passed forward along the cavity to nourish this segment, and exclusion cuts off that delivery.
- **C.** Renewal of the epithelium is driven mainly by mechanical stimulation from bulk passing over it, and exclusion removes that stimulus entirely.
- **D.** It draws most of its fuel from small acids that gut microbes make out of carbohydrate the host cannot cleave, and that feedstock no longer arrives.  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 85 s |
| Confidence | 5 |

**Correct answer (D): It draws most of its fuel from small acids that gut microbes make out of carbohydrate the host cannot cleave, and that feedstock no longer arrives.**

Citations: AP:48681, AP:48731, AP:48732, AP:48641

**Distractors**

- **(A)** `misconception` . _absolute-inability overstatement_: Colonic absorptive cells can and do take up glucose from blood; their dependence on luminal fermentation products is a matter of preference and supply, not of an inability to use circulating fuel.
  - Citation: AP:48641
- **(B)** `adjacent_fact` . _true statement about the wrong route_: Absorbed amino acids leave the gut in the blood draining toward the liver; they are never passed onward through the gut cavity to feed downstream segments, so this delivery route does not exist.
  - Citation: AP:49282
- **(C)** `misconception` . _mechanical rather than metabolic cause_: Epithelial turnover is not limited by mechanical stimulation from passing bulk; supplying the missing fermentation acids alone restores an excluded loop with no bulk flow at all.
  - Citation: AP:48731

**Readback check.** Content words of six or more letters in the key: microbes, carbohydrate, cannot, cleave, feedstock, arrives. Long words in the stem: abdominal, surgery, arterial, circulation, excluded, stream, contents, leaving, intestine, following, mucosa, isolated, becomes, inflamed, patient, perfusion, unimpaired, accounts, deterioration. No shared term, and the key cannot be produced by restating the stem; the student must supply the fermentation mechanism. Option lengths were levelled so the key is no longer the longest choice.

**Explanation (as shipped).**

> This item falls under Organ Systems and tests where the lining of the large bowel gets its energy. The answer is D because the cells of that lining take most of their ATP from short chain acids produced by microbial fermentation on the cavity side, and excluding the loop removes the fermentable starting material. Dietary fibre is a carbohydrate that no human enzyme can cleave, so it arrives in the large bowel essentially untouched. Organisms living there ferment it into small acids such as butyrate, acetate and propionate, and the absorptive cells sitting immediately above them oxidise those acids in preference to anything arriving by blood. That is a striking arrangement: a tissue nourished mainly from the cavity it faces rather than from the capillaries behind it, which is exactly why a loop with a perfect blood supply and a well fed patient still wastes away once the flow of unabsorbed carbohydrate stops. Instilling the missing acids into such a loop reverses the change, which pins the cause on fuel rather than on bulk or stimulation.
>
> (Choice A) These cells can certainly import glucose from capillary blood, and they do so; the point is that this supply does not cover their demand once their preferred fuel disappears. Stating an absolute inability overshoots the physiology and would predict rapid death of the tissue rather than slow thinning.
>
> (Choice B) Amino acids taken up upstream enter the blood draining the gut and travel to the liver. Nothing routes them forward through the gut cavity to feed downstream segments, so exclusion interrupts no such delivery, and this choice describes a pathway that does not exist.
>
> (Choice C) Turnover of this epithelium is rapid and continuous, but the limiting input in an excluded loop is chemical, not mechanical. Restoring fermentation products alone repairs the tissue without restoring any bulk moving through it, which separates the two explanations cleanly.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to infer, from an experimental exclusion and the tissue damage that follows, which side of an epithelium supplies its energy.

---

## B2-Q20 . Antibiotic loss of bacterial vitamin production

**Stem.** A man completes six weeks of broad spectrum antibiotics for a bone infection, eating an unrestricted diet throughout. In the final week he bruises easily and his clotting time is prolonged, and both resolve once vitamin K is given. One physician proposes that killing the organisms of the large bowel removed a source of the vitamin. A colleague counters that the antibiotic molecule itself interfered with the liver step that uses the vitamin to finish clotting proteins. Which findings would favour the first explanation over the second?

I. The concentration of vitamin K measured in his plasma was low while he was bleeding.
II. Clotting time returned to normal about two weeks after the last dose, tracking the recovery of bacterial counts in stool rather than the clearance of the drug from blood within two days.
III. A sample drawn before the antibiotic course began showed a normal clotting time.

- **A.** I only
- **B.** I and II only  <- **KEY**
- **C.** II and III only
- **D.** I, II and III

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 105 s |
| Confidence | 5 |
| Hard-tier gate | Hard. Condition (a) holds because it joins microbial vitamin manufacture to the separate skill of reading a plasma concentration as evidence about supply versus utilisation. Condition (c) holds because choices C and D remain defensible until the student recognises that a normal baseline is common ground between the two proposals. Condition (d) holds because the reasoning runs from a bleeding outcome back to which of two mechanisms produced it. |

**Correct answer (B): I and II only**

Citations: AP:48681, AP:48684, AP:48642, AP:34685, AP:34687

**Distractors**

- **(A)** `partial_truth` . _one valid item, stops short_: Item I does favour loss of supply, but on its own it rests on a single snapshot measurement and leaves the timing evidence in item II unused, and that second line is what makes the conclusion secure.
  - Citation: AP:34687
- **(C)** `adjacent_fact` . _true finding that answers a different question_: A normal pre-treatment clotting time establishes only that the antibiotic course caused the defect, which both proposals already assume, so it cannot favour either; this choice also discards the informative item I.
  - Citation: AP:34685
- **(D)** `misconception` . _more evidence is always better_: Adding item III adds a finding that both explanations predict equally, so it dilutes rather than strengthens the discrimination between failed microbial manufacture and a blocked liver step.
  - Citation: AP:34685

**Readback check.** The key text is 'I and II only', which contains no content words at all, so no echo with the stem is possible. The words production, synthesis and fermentation are kept out of the option set, and the discriminating logic lives entirely in the Roman numeral items, which the student must evaluate one at a time against two named rival mechanisms.

**Explanation (as shipped).**

> This item falls under Organ Systems and tests the microbial contribution to the host's vitamin supply. The answer is B because items I and II each point at loss of supply rather than at a blocked liver step, while item III is expected under both explanations and therefore separates nothing. Organisms in the large bowel manufacture several vitamins the host makes in insufficient amount, chiefly vitamin K and biotin, and the absorptive cells of that lining take them up. Vitamin K is what the liver requires to finish several clotting proteins, so wiping out the producing population with weeks of broad spectrum treatment can leave a person bruising and bleeding on a normal diet. Now compare the two proposals. If the drug had blocked the liver step, the vitamin itself would still have been made and absorbed, so its plasma concentration would be normal or even raised; a low plasma level, item I, therefore fits removal of the source and not a blockade downstream of it. Item II adds an independent timing argument: recovery that waits two weeks for the bacterial population to return, long after the drug has left the blood, matches regrowth of a producer and does not match relief of a direct chemical blockade.
>
> (Choice A) Item I alone genuinely favours loss of supply, so this choice is defensible until the timing evidence is weighed. It stops short, because a single plasma measurement is a snapshot that could be pushed around by intake or by laboratory variation, and item II supplies the independent line of evidence that makes the conclusion secure.
>
> (Choice C) This choice keeps a genuinely discriminating item and pairs it with one that is not, and it discards item I. A normal clotting time before treatment shows only that something about the antibiotic course caused the problem, which is common ground between the two proposals rather than a reason to prefer either.
>
> (Choice D) Item III looks persuasive because a clean baseline feels like strong evidence. It is strong evidence for a different claim, that the course was responsible at all, and adding a finding that both explanations predict equally dilutes rather than strengthens the case for one of them.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to sort candidate observations by whether each one actually separates two competing causes of the same clinical outcome.

---

## B2-Q21 . Colonic transport machinery versus nutrient uptake

**Stem.** In a research setting the same solution of glucose, amino acids and sodium chloride is infused through a fine tube directly into the large bowel of one volunteer and into the jejunum of another. Both regions are equally well perfused. In the jejunal subject the glucose and the amino acids appear in the blood within minutes, while in the colonic subject almost none of either appears. Which property of the colonic lining accounts for the difference?

- **A.** It is well supplied with transport proteins for ions but has neither the amplified surface nor the specific carriers that upstream segments use to take up dissolved nutrients.  <- **KEY**
- **B.** The mucus released there forms a layer that dissolved molecules are unable to cross.
- **C.** Contents move through that region far too quickly for any uptake to take place.
- **D.** The infused molecules must first be cleaved by pancreatic enzymes, and none of those enzymes are still active that far along.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 65 s |
| Confidence | 5 |

**Correct answer (A): It is well supplied with transport proteins for ions but has neither the amplified surface nor the specific carriers that upstream segments use to take up dissolved nutrients.**

Citations: AP:48636, AP:48637, AP:48642, AP:48694

**Distractors**

- **(B)** `misconception` . _mucus as an impermeable seal_: The mucus layer lubricates and protects but is freely crossed by water and ions, so treating it as impermeable would wrongly abolish the salt and water recovery that is this segment's main job.
  - Citation: AP:48640
- **(C)** `reversed_relationship` . _transit time in the wrong direction_: Contents linger in the large bowel for roughly twelve to twenty four hours, longer than in any other segment, so contact time there is unusually long and cannot be what limits uptake.
  - Citation: AP:48694
- **(D)** `adjacent_fact` . _true digestion fact, wrong target_: Glucose and free amino acids are already end products that need no enzymatic cleaving, as their immediate uptake from the jejunum demonstrates, so the absence of pancreatic enzymes is irrelevant here.
  - Citation: AP:48731

**Readback check.** Content words of six or more letters in the key: supplied, transport, proteins, neither, amplified, surface, specific, carriers, upstream, segments, dissolved, nutrients. Long words in the stem: research, setting, solution, glucose, sodium, chloride, infused, through, volunteer, jejunum, another, regions, equally, perfused, jejunal, subject, appear, within, minutes, colonic, almost, either, appears, property, lining, accounts, difference. No shared term. The stem deliberately does not state that the colonic subject absorbed the salt and water, so the key cannot be assembled by paraphrasing the stem; the student must supply the structural facts about folds, villi and carrier populations.

**Explanation (as shipped).**

> This item falls under Organ Systems and tests what the lining of the large bowel is and is not equipped to move. The answer is A because that epithelium is built for salt and water recovery and carries almost none of the specialised uptake apparatus that handles sugars and the products of protein breakdown. Two features go together. First, the surface itself is flat: there are no circular folds and no villi, so the area available is a small fraction of what the jejunum offers. Second, the cells there are dominated by pumps and channels that move sodium and let water follow osmotically, together with mucus secreting cells. That combination describes a tissue able to reclaim a litre or more of fluid a day while returning almost no nutrient value to the body, and it predicts exactly the result described, a nutrient load delivered to the wrong place and never seen in blood.
>
> (Choice B) Mucus does coat this surface and does protect it, but it is a lubricating and shielding layer, not a seal. Water and sodium cross it continuously in large quantities, so a barrier argument would have to block those too, and it plainly does not.
>
> (Choice C) This inverts the actual timing. Material dwells in the large bowel typically for twelve to twenty four hours, far longer than anywhere else in the tract, so contact time is generous rather than limiting and cannot be the reason uptake fails.
>
> (Choice D) Pancreatic enzymes act on food polymers, and glucose and free amino acids are already the finished products of digestion that need no further cleaving, as their rapid uptake from the jejunum shows. The choice imports a true fact about digestion into a setting where it does not apply.
>
> This is a Knowledge of Scientific Concepts and Principles question because it asks the student to apply what the lining of the large bowel is structurally equipped to move to a case where two delivery sites give opposite results.

---

## B2-Q22 . Colonic residence time and stool consistency

**Stem.** Three adults were studied on a metabolic ward. The table gives, for each one, the volume of fluid passing from the small bowel into the colon each day, the volume of fluid still present in the stool passed each day, and the time contents dwell in the colon before being expelled.

| Subject | Fluid entering colon (mL/day) | Fluid in stool (mL/day) | Dwell time in colon (h) |
| --- | --- | --- | --- |
| P | 1,200 | 96 | 14 |
| Q | 900 | 90 | 10 |
| R | 2,000 | 100 | 30 |

Whose colon recovers the greatest share of the fluid presented to it, and what consistency follows for that person's stool?

- **A.** Q, since Q's stool holds the least fluid of the three, and that stool will therefore be firm.
- **B.** P, whose stool will be firm, because a dwell time in the middle of the range gives the best recovery.
- **C.** R, whose stool will be firm and hard to pass.  <- **KEY**
- **D.** R, whose stool will be loose, because fluid seeps back over so long a dwell.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 95 s |
| Confidence | 5 |

**Correct answer (C): R, whose stool will be firm and hard to pass.**

Citations: AP:48694, AP:48756, AP:48757, AP:49251

**Distractors**

- **(A)** `scale_unit_error` . _absolute volume read as a share_: Q's 90 mL is the smallest raw volume but comes from the smallest delivered load of 900 mL, giving the lowest fractional recovery of the three, so treating the absolute figure as if it were a proportion inverts the ranking.
  - Citation: AP:48694
- **(B)** `misconception` . _imagined optimum in the middle_: There is no peak at intermediate dwell time; fluid recovery rises steadily with contact, so P's 92 percent is exceeded by R's 95 percent.
  - Citation: AP:48756
- **(D)** `reversed_relationship` . _long contact framed as fluid return_: Extended contact continues to withdraw water from the residue rather than returning it, so a very long dwell produces a hard, difficult stool, not a loose one.
  - Citation: AP:48757

**Readback check.** The key text is 'R, whose stool will be firm and hard to pass.' It contains no content word of six or more letters at all, since stool and whose are five letters and firm and hard are four. Nothing in the key is copied from the stem, and the answer cannot be read off the table, because the delivered loads differ across subjects and the subject with the smallest stool volume, Q, is not the subject with the greatest fractional recovery. The student must compute three shares and then map the extreme onto a consistency the table never reports.

**Explanation (as shipped).**

> This item falls under Organ Systems and tests how long the colon holds material and what that holding time does to the product. The answer is C because R reclaims 1,900 of the 2,000 mL delivered, about 95 percent, against 1,104 of 1,200 mL for P, about 92 percent, and 810 of 900 mL for Q, about 90 percent, and the longest contact naturally yields the driest and hardest product. The three loads differ, so the comparison has to be made as a share of what each colon received and cannot be read off the stool column alone. Doing it that way reverses the impression that column gives: Q passes the smallest absolute volume of fluid, 90 mL, yet recovers the smallest share of what it was handed. The underlying relationship is monotonic, since sodium is pumped out of the cavity and water follows osmotically, so the more hours the residue spends against that lining, the more fluid is reclaimed. This is why the large bowel, which typically holds material for twelve to twenty four hours compared with a few hours in the small bowel, is where liquid residue is converted into a semisolid mass, and why an unusually long dwell such as R's produces the driest stool of the three.
>
> (Choice A) This choice reads the raw stool column instead of a proportion. Q's 90 mL is indeed the smallest volume of fluid passed, but it came from the smallest delivered load, so Q's share recovered is the lowest of the three rather than the highest, and a 10 hour dwell is the shortest contact in the table.
>
> (Choice B) P is a plausible looking middle case, and 92 percent recovery is respectable. But there is no optimum in the middle of the range; recovery keeps climbing with contact time, so P is beaten by R on the very measure the question asks about.
>
> (Choice D) This gets the subject right and the direction wrong. Prolonged contact continues to remove fluid rather than returning it, so an unusually long dwell hardens the residue and makes it difficult to expel, which is precisely the situation produced when defecation is repeatedly postponed.
>
> This is a Data-based and Statistical Reasoning question because it asks the student to convert three stool volumes into fractions of three different delivered loads, notice that the ranking by share disagrees with the ranking by raw volume, and then translate the winning share into a physical property of the product.

---

## B2-Q23 . Pancreatic step in the B12 relay

**Stem.** Swallowed vitamin B12 is bound in the mouth by a salivary glycoprotein that survives gastric acid. That salivary glycoprotein must then be stripped off by proteases in the lumen of the duodenum before intrinsic factor can attach, and only B12 carried by intrinsic factor is absorbed by endocytosis in the terminal ileum. A patient with end stage chronic pancreatitis has normal gastric acid output, normal intrinsic factor concentration in gastric juice, and a structurally normal ileum on biopsy, yet serum B12 has fallen steadily over two years. What best accounts for the fall in serum B12?

- **A.** Intrinsic factor is broken down in the stomach before it can meet B12.
- **B.** B12 enters the mucosal cell normally but is not passed onward into the blood.
- **C.** B12 must be held in solution by bile, and bile delivery is impaired as well.
- **D.** B12 is still occupied by the binder it picked up in the mouth.  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 100 s |
| Confidence | 5 |
| Hard-tier gate | (a) combines the multistep binding protein relay with a specific organ lesion, and requires the separate fact that the exocrine pancreas supplies the duodenal proteases, which the stem withholds; (c) choices A and B stay defensible until the student applies the fact that the pancreatic contribution acts in the lumen between the two sites reported as normal; (d) works backwards from a deficiency plus three normal findings to the single failing step, rather than forwards from a named lesion to its consequence. |

**Correct answer (D): B12 is still occupied by the binder it picked up in the mouth.**

Citations: AP:49439; AP:49441; AP:48061; AP:49253

**Distractors**

- **(A)** `misconception` . _blames the wrong protein in the chain_: Assumes the gastric binding protein is acid labile and that this is the limiting event; the stem reports it present at normal concentration, and pancreatic disease would not degrade it.
  - Citation: AP:48061
- **(B)** `process_step_confusion` . _right process, wrong stage_: Moves the block one stage too late, to exit from the enterocyte into the blood, whereas pancreatic secretion acts in the lumen before uptake occurs at all.
  - Citation: AP:49441
- **(C)** `adjacent_fact` . _imports the fat absorption story into a water soluble nutrient_: True of the lipid soluble vitamins but not of B12, which is water soluble and needs no bile for solubilisation.
  - Citation: AP:49429

**Readback check.** Content words of six or more letters in key D: occupied, binder, picked. The stem contains swallowed, vitamin, salivary, glycoprotein, survives, gastric, stripped, proteases, duodenum, before, intrinsic, factor, attach, carried, absorbed, endocytosis, terminal, patient, chronic, pancreatitis, normal, output, concentration, structurally, biopsy, steadily, accounts, serum. No overlap: occupied, binder and picked appear nowhere in the stem. The stem was deliberately edited so that it never names the pancreas as the source of the duodenal proteases, so the key cannot be produced by matching the word pancreatitis to a stem clause; the student must supply the fact that the exocrine pancreas provides those proteases, then eliminate the two sites the stem reports as normal.

**Explanation (as shipped).**

> This Organ Systems item tests the relay of binding proteins that escorts B12 along the gut and what happens when one link in that relay fails. The answer is D because the exocrine pancreas is the source of the luminal proteases that act in the duodenum, so in end stage pancreatic disease the salivary binder is never removed and B12 arrives at the far small intestine still occupied, unable to pair with intrinsic factor and therefore unable to dock at the mucosal receptor. Uptake of this molecule is unusual in requiring three organs in series: the salivary glands supply a protein that shields it from acid, the exocrine pancreas supplies the proteases that liberate it in the duodenum, and the stomach supplies the factor that ileal receptors actually recognise. Failure of any one of the three is sufficient to produce deficiency, which is why a healthy stomach and a healthy ileum together do not guarantee normal uptake. Every test of stomach and ileum offered here is normal, so the broken link must lie in the step that sits between them, and the stem does not name which organ supplies that step. Deficiency arising by this route is corrected by supplying the missing digestive enzymes with meals rather than by treating the stomach or the ileum.
>
> (Choice A) The gastric factor named in the stem is measured at normal concentration in gastric juice, and it is comparatively resistant to acid; acid destruction of that factor is therefore neither supported by the data nor an event that pancreatic disease would cause.
>
> (Choice B) A blocked exit from the mucosal cell into the blood would be a defect of the epithelium itself, and nothing in pancreatic disease acts on the epithelium. The step that pancreatic secretion controls happens in the lumen, before any cell is entered.
>
> (Choice C) This nutrient is water soluble and is carried in the aqueous phase of the lumen, so it does not need bile for solubilisation the way vitamins A, D, E and K do. Reduced delivery of bile would not by itself account for the deficiency described.
>
> This is a Scientific Reasoning and Problem Solving question because it supplies an outcome plus three normal findings and asks the student to identify which organ in a three step relay must be the failing one.

---

## B2-Q24 . Which fat soluble vitamin fails first

**Stem.** Bile flow into the intestine stops completely in an adult whose liver synthetic capacity, kidney function and diet all remain normal. Uptake of dietary lipid and of the fat soluble vitamins falls to nearly zero from the day the blockage begins. Three weeks later the patient is reassessed. Which abnormality is most likely to have appeared first?

- **A.** Impaired dark adaptation
- **B.** Prolonged clotting times  <- **KEY**
- **C.** A fall in serum calcium with bone pain
- **D.** Anaemia from oxidative injury to red cell membranes

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic secondary / structural two_step) |
| Estimated time | 95 s |
| Confidence | 4 |
| Hard-tier gate | (a) combines the absorption lesion with the separate concept of body stores and turnover rate; (b) requires a quantitative comparison of reserve size against daily consumption in order to rank four latencies against a stated three week interval; (c) choices A, C and D all name genuine deficiency states and stay defensible until store size is applied. |

**Correct answer (B): Prolonged clotting times**

Citations: AP:51221; AP:51223; AP:34685; AP:34686; AP:49429; AP:26042; AP:10478

**Distractors**

- **(A)** `scale_unit_error` . _right deficiency, wrong latency_: Correct physiology for vitamin A and visual pigment regeneration, but hepatic stores cover many months, so this is the right consequence placed on a far too short timescale.
  - Citation: AP:26042
- **(C)** `partial_truth` . _true endpoint that hormonal buffering delays_: Vitamin D deficiency does eventually reduce intestinal calcium uptake, but parathyroid hormone holds serum calcium up by drawing on bone, and vitamin D stores plus cutaneous synthesis last months, so serum calcium is usually still normal at three weeks and bone pain is later still.
  - Citation: AP:10478
- **(D)** `scale_unit_error` . _real deficiency syndrome with the longest lag_: Oxidative red cell injury is a genuine consequence of vitamin E deficiency, but its adipose reserve is the largest of the four and depletion in an adult takes years, not weeks.
  - Citation: AP:51223

**Readback check.** Content words of six or more letters in key B: prolonged, clotting. Neither appears in the stem, which contains intestine, completely, synthetic, capacity, function, remain, normal, dietary, soluble, vitamins, nearly, blockage, begins, reassessed, abnormality, likely, appeared. No coagulation vocabulary is present anywhere in the stem, so the key cannot be matched lexically. The stem also states that all four fat soluble vitamins stop being absorbed at the same moment, so no vitamin is singled out; the student must supply the unstated fact that vitamin K has the smallest body store relative to daily use and rank four latencies against three weeks.

**Explanation (as shipped).**

> This Organ Systems item tests why the four fat soluble vitamins do not run short at the same rate once their absorption stops. The answer is B because vitamin K, which the liver needs in order to finish several coagulation factors, is held in the smallest body reserve of the four and turns over within days to a couple of weeks, so a bleeding tendency is the first measurable failure. Reserve size divided by daily consumption, not the severity of the absorption block, sets the order in which these deficiencies surface. The liver holds enough vitamin A to cover many months of zero intake, vitamin D and its metabolites sit in liver and adipose stores that also last months and are further buffered by synthesis in sunlit skin, and vitamin E in body fat is measured in years. Three weeks of complete failure to absorb therefore reads out only on the fastest turning pool. The stem also closes off the obvious confounder by stating that liver synthetic capacity is normal, so a prolonged clotting time here reflects the missing vitamin rather than failure of the organ that assembles the factors.
>
> (Choice A) Impaired dark adaptation does follow depletion of vitamin A, which supplies the retinal that visual pigment needs, but hepatic stores of that vitamin cover many months of zero intake. This is the right consequence on far too short a timescale.
>
> (Choice C) A fall in serum calcium is a late change. Vitamin D stores last months, synthesis in sunlit skin continues, and parathyroid hormone defends the circulating calcium concentration by drawing on bone long after intestinal calcium uptake begins to slip, so serum calcium is commonly still normal at three weeks. Bone pain is later still.
>
> (Choice D) Red cell membranes are protected from oxidation by vitamin E, whose adipose reserve is the largest of the four, so oxidative destruction of red cells after only three weeks of malabsorption would be extraordinary. In adults this deficiency takes years to become apparent.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to rank four deficiencies by latency, weighing each vitamin's stored quantity against its daily rate of use, rather than to recall that all four share one absorption route.

---

## B2-Q25 . Positive control in a bile diversion study

**Stem.** Investigators divert bile away from the small intestine in rats and then measure intestinal uptake of a radiolabelled B vitamin, expecting uptake to be unchanged because this vitamin is taken up straight from the watery contents of the lumen. Uptake in the operated rats matches uptake in unoperated rats. A reviewer objects that this result on its own does not support the conclusion. Which additional measurement would best answer the objection?

- **A.** Uptake of the labelled B vitamin at twice the administered dose
- **B.** Uptake of the labelled B vitamin in unoperated rats fed a fat free diet
- **C.** Uptake in the same operated rats of a second labelled vitamin that needs the fat phase  <- **KEY**
- **D.** Uptake of the labelled B vitamin in a sham operated group

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **medium** (topic secondary / structural two_step) |
| Estimated time | 90 s |
| Confidence | 5 |

**Correct answer (C): Uptake in the same operated rats of a second labelled vitamin that needs the fat phase**

Citations: AP:51226; AP:49439; AP:49429; AP:49441

**Distractors**

- **(A)** `scale_unit_error` . _dose response substituted for a validity control_: Doubling the dose tests transport capacity, a different question at a different scale, and says nothing about whether the surgical manipulation had any effect.
  - Citation: AP:49439
- **(B)** `adjacent_fact` . _a control for the wrong comparison_: Rats that never had surgery cannot demonstrate that the operation worked, and changing dietary fat introduces a second manipulated variable rather than validating the first.
  - Citation: AP:51226
- **(D)** `partial_truth` . _a legitimate control that answers a different threat_: A sham group correctly controls for surgical trauma and improves the study, but it still cannot show that bile diversion abolished fat dependent absorption, which is the reviewer's actual objection.
  - Citation: AP:49429

**Readback check.** Content words of six or more letters in key C: operated, second, labelled, vitamin. Labelled and vitamin appear in the stem but appear identically in all four choices, so they carry no discriminating signal, and operated appears in every choice except A. The discriminating content of the key is the phrase needs the fat phase, and the stem was rewritten to describe the tested vitamin as taken up straight from the watery contents of the lumen, so the words fat phase appear nowhere in the stem. Nothing in the stem states that a positive control is needed or what one would look like, so the answer cannot be produced by copying. The stem was also rewritten to drop the restriction to the diverted animals, so choices B and D are no longer eliminable on a technicality and must be beaten on design logic.

**Explanation (as shipped).**

> This Organ Systems item tests what an unchanged measurement can and cannot establish, and why the water soluble vitamins survive a lesion that ruins fat uptake. The answer is C because an unchanged result is uninterpretable until the experiment shows that the surgery actually removed something that some absorptive route depended on, and a nutrient that must travel in the fat phase provides exactly that internal positive control. If uptake of that comparison nutrient collapses in the same operated rats while uptake of the B vitamin holds steady, the diversion is proven effective and the contrast between the two routes is established in one preparation. Without it, an equally good reading of the data is that the operation failed, that bile was still reaching the lumen, and that nothing was ever tested. The underlying physiology is that most water soluble vitamins cross the epithelium directly from the aqueous contents of the lumen, by simple diffusion or by membrane carriers, so they never enter the fat phase and are indifferent to whether bile arrives. The one water soluble vitamin handled differently, B12, needs a protein escort rather than a fat phase, so it too would be spared by this lesion.
>
> (Choice A) Doubling the dose probes the capacity of the uptake route rather than whether the surgical manipulation worked, and a transport step that is already unimpaired will simply carry more. The objection concerns the validity of the manipulation, not saturation.
>
> (Choice B) Rats that never had surgery cannot show that the surgery did anything, and taking fat out of the diet changes a second variable at the same time. This addresses a question the reviewer did not ask.
>
> (Choice D) A sham operated group is a sensible control for the trauma of surgery, and it strengthens the study, but it still cannot demonstrate that diverting bile abolished absorption by the fat dependent route. It leaves the reviewer's objection standing.
>
> This is a Reasoning about the Design and Execution of Research question because it asks the student to choose the positive control that makes an unchanged experimental measurement interpretable.

---

