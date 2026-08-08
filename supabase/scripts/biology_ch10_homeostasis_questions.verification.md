# Biology Ch10: Homeostasis . Verification Report

**Batch 1 of 3: 20 questions (renal architecture, glomerular filtration, the proximal tubule).**
Chapter target is **60 questions**. Reference text: `openstax-anatomy-physiology-2e.txt` (AP:).
Scope authority: `aamc-content-outline-2026.txt`. Step 1 record: `biology_ch10_homeostasis_questions.plan.md`.
All questions: Foundation 3B . content category "Organ Systems" . discipline biology.

## Why 60

A cross-subject scope check plus a boundary audit against every live question found **37 concepts
already owned by six other chapters**, the heaviest blocking of any chapter in the bank.

**The hormone axis is gone.** Bio Ch5 Endocrine has 100 questions and owns aldosterone as an answer
across five separate keys, the renin-angiotensin cascade, antidiuretic hormone and its source, atrial
natriuretic peptide, erythropoietin, and steroid-versus-peptide mechanism (the single most saturated
concept in the bank). Of roughly 15 natural renal-hormone questions, about 8 survive, and **none may
have a hormone name as its correct answer.** Where a hormone is needed it is supplied in the stem and
the question asks what the tubule does.

**The pressure balance is gone.** Bio Ch7 owns Starling forces with four numeric items and a data
table, the hydrostatic-versus-oncotic contrast, the filtration/reabsorption crossover, portal systems
and two capillary beds in series, efferent arteriolar resistance and filtration fraction. This chapter
gets exactly one numeric filtration item and its answer turns on Bowman's capsule hydrostatic
pressure, a term that appears nowhere in Ch7.

Also blocked: skin as a pathogen barrier and antigen presentation (Bio Ch8, which even runs its
resident-versus-recruited macrophage experiments in skin); skin thermoregulation and renal bicarbonate
handling (Bio Ch6); the bicarbonate buffer, blood pH and renal acid-base compensation (GenChem Ch10,
which carries the classic "the kidney regulates pH" item under a biology discipline tag, the most
surprising finding of the audit); the two-sphincter voluntary-override pattern (Bio Ch9, whose
defecation item is the same question with the organ swapped); smooth-versus-skeletal muscle, where
Bio Ch11 already uses the filling urinary bladder as its own scenario.

**What survives is better material than what was taken:** charge selectivity of the filtration
barrier, renal autoregulation, the countercurrent multiplier, transport maximum, and osmoreceptors are
all untouched anywhere else in the bank.

## Founder decisions recorded

  . Chapter sized at **60** rather than the planner's floor of 57, promoting three reserve items.
  . The named cutaneous receptors (Merkel, Meissner, Ruffini, Pacinian) are **kept in Ch10** rather
    than left to the future Psych/Soc Ch2 chapter. Constraint applied: Bio Ch4 owns receptor
    classification and intensity coding, so these must key on which receptor sits at which depth and
    what its construction suits it to detect, never on neuron type or intensity encoding.

## Batch 1 summary

| Metric | Result | Target |
|---|---|---|
| Difficulty | easy 5 . hard 7 . medium 8 | easy 5 . medium 8 . hard 7 |
| Answer letter | A 5 . B 5 . C 5 . D 5 | 5 each |
| Cognitive skill | S1 3 . S2 11 . S3 3 . S4 3 | S1 3 . S2 11 . S3 3 . S4 3 |
| Confidence | conf4 7 . conf5 13 | only 4-5 ship |
| Roman numeral | 3 | 3 |
| Distractor categories | adjacent_fact 9 . misconception 17 . partial_truth 14 . process_step_confusion 7 . reversed_relationship 10 . scale_unit_error 3 | none dominant |
| Em/en dashes | 0 | 0 |
| Source citations in shipped explanations | 0 | 0 |

**Boundary scan:** zero boundary terms appear in any of the 20 keys, across 12 forbidden territories.
The micturition trap was explicitly checked and avoided: no question in this batch touches the
internal/external sphincter pair.

## One duplicate caught and replaced before shipping

Two writers on different slices independently produced a charge-selectivity question. Q8 demonstrated
it with a table of charged tracers; Q10 demonstrated it by stripping the fixed charge and predicting
the result. Different presentation, identical discriminating idea, so a student meeting the second
would find it free.

The automated dedup missed it because it compares subtopic STRINGS, and "Charge selectivity of the
filtration barrier" and "Fixed anionic charge and charge selectivity" read as different. Two questions
can share an idea while sharing almost no words.

Tracing back, the slice that produced Q8 had been briefed to write two specific items, obligatory
filtration along the whole capillary and a filtrate-versus-plasma composition table, and silently
substituted its own choices. So the batch was simultaneously missing a planned item and carrying a
duplicate, from one slip.

Q8 was replaced with the planned filtrate-versus-plasma item, pinned to the retired question's exact
metadata (answer A, medium, skill 4, same three distractor categories) so the verified distribution
was not disturbed, and both writer and auditor were given the full text of every question it must not
resemble. The replacement keys on protein binding: every solute matches exactly across the barrier
except total calcium, and the only thing distinguishing calcium is that about half of it circulates
attached to albumin, so the bound fraction is held back while the free fraction passes unhindered.
Nothing else in the bank touches that idea.

Post-swap re-verification confirmed all four distributions unchanged, no key pair sharing three or
more distinctive words, and exactly one charge-selectivity question remaining.

**Adversarial audit:** all 20 re-examined by an independent pass per slice, with every citation
re-greped against OpenStax Anatomy and Physiology 2e.

---

## Q1 . Why the medullary gradient is regional

**Stem.** The interstitial fluid of a kidney sits near 300 mOsm/kg just beneath the outer capsule but reaches roughly 1200 mOsm/kg at the deepest points of the organ. Which arrangement of structures accounts for this difference?

- **A.** Sodium is moved out of the nephron by pumps only at depth; nearer the capsule solute leaves the nephron by diffusion alone.
- **B.** Blood moves through the deep vessels much faster than through the shallow ones, and that speed drives solute inward and packs it at the tip.
- **C.** Long hairpin tubule limbs lying beside equally long hairpin vessels are found only at depth; nearer the surface there are only coiled segments and a freely intermixing capillary bed.  <- **KEY**
- **D.** Only the deep zone contains collecting ducts, and urea leaking from their walls supplies the entire gradient on its own.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 80 s |
| Confidence | 5 |

**Correct answer (C): Long hairpin tubule limbs lying beside equally long hairpin vessels are found only at depth; nearer the surface there are only coiled segments and a freely intermixing capillary bed.**

Citations: AP:52555, AP:53211, AP:53217, AP:53260, AP:53272, AP:53305, AP:53311

**Distractors**

- **(A)** `misconception`: Students often assume the concentrated zone is the only place with active sodium transport. The proximal tubule in the outer zone does the largest single block of active reabsorption and still produces no standing gradient.
  - Citation: AP:53166
- **(B)** `reversed_relationship`: Flow in the deep vessels is deliberately slow. Fast flow would wash sodium and urea out and abolish the gradient, so the stated direction of the relationship is inverted.
  - Citation: AP:53307
- **(D)** `partial_truth`: Urea from the collecting duct does deepen the gradient, but ducts also traverse the outer zone where nothing accumulates, so urea alone cannot explain why the gradient is regional.
  - Citation: AP:53311

**Readback check.** Content words of six or more letters in key C: hairpin, tubule, equally, vessels, nearer, surface, coiled, segments, freely, intermixing, capillary. Stem content words of six or more letters: interstitial, kidney, beneath, capsule, reaches, roughly, deepest, points, arrangement, structures, accounts, difference. No overlap. The stem deliberately avoids the words vessel, tubule, capillary and surface so that no content word is shared with the key.

**Explanation (as shipped).**

> This question falls under Organ Systems and tests the structural precondition for a standing osmotic gradient inside the kidney. The answer is C because a gradient can be built and held only where long hairpin tubule limbs lie alongside equally long hairpin blood vessels, and that geometry exists only at depth. Every renal corpuscle and both convoluted portions of every nephron sit in the cortex, which is served by a peritubular network in which blood mixes freely and moves on quickly. Salt deposited into cortical interstitium is carried away about as fast as it arrives, so that tissue stays close to plasma osmolarity no matter how hard the proximal tubule is working. Deeper in the organ the arrangement changes: the long loops of juxtamedullary nephrons deposit salt at increasing depths, and the vasa recta that accompany them descend and ascend side by side, taking up solute on the way in and handing it back on the way out. Because those vessels flow slowly and in opposite directions, they trade solute with each other instead of flushing it into the general circulation, and the deposited salt accumulates to roughly four times plasma osmolarity at the deepest point. Geometry, not transport strength, is the limiting condition.
>
> (Choice A) Active sodium transport is not confined to the deep zone. The proximal convoluted tubule, which lies entirely in the outer tissue, performs the single largest block of active reabsorption in the whole nephron, and yet no standing gradient exists there. That is exactly the point: pumping alone is not sufficient.
>
> (Choice B) Flow through the deep vessels is unusually slow, not fast. Rapid flow is what destroys a deep gradient, because it would carry sodium and urea away faster than the loops could deposit them, leaving the interstitium near plasma osmolarity.
>
> (Choice D) Collecting ducts do release urea into the deep interstitium, and urea recycling genuinely deepens the gradient, but ducts begin in the outer tissue and simply pass through it, and no amount of urea can accumulate where the vasculature washes solute away. Paired hairpin geometry is the necessary condition; urea is an amplifier on top of it.
>
> This is a Knowledge of Scientific Concepts and Principles question because it asks the student to match a known anatomical layout to the physical condition that any standing concentration gradient requires.

---

## Q2 . Consequence of nephron segment order

**Stem.** Consider a nephron built with two of its segments in the wrong order: fluid reaches the water permeable terminal duct first and only afterward enters the salt pumping limb that discharges fluid at about 100 mOsm/kg. The deep interstitial gradient is normal and every transporter works normally. Which capacity is lost?

- **A.** Making urine more concentrated than plasma when water must be conserved.  <- **KEY**
- **B.** Reclaiming glucose completely at ordinary blood glucose levels.
- **C.** Making urine more dilute than blood when water intake is high.
- **D.** Forming filtrate at a normal rate across the barrier at the capsule.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 95 s |
| Confidence | 5 |

**Correct answer (A): Making urine more concentrated than plasma when water must be conserved.**

Citations: AP:53217, AP:53295, AP:53297, AP:53303, AP:53320, AP:53166

**Distractors**

- **(B)** `adjacent_fact`: Glucose reclamation is a true and important proximal function, but it happens upstream of both swapped segments and is irrelevant to the reordering described.
  - Citation: AP:53166
- **(C)** `reversed_relationship`: This names the ability the rearranged nephron retains rather than the one it loses; with the diluting limb last, watery urine becomes obligatory rather than impossible.
  - Citation: AP:53303
- **(D)** `process_step_confusion`: Filtration happens at the corpuscle, before either swapped segment, so the choice attaches the consequence to the wrong stage of the itinerary.
  - Citation: AP:52802

**Readback check.** Content words of six or more letters in key A: Making, concentrated, plasma, conserved. Stem content words of six or more letters: Consider, nephron, segments, permeable, terminal, afterward, pumping, discharges, interstitial, gradient, normal, transporter, normally, capacity. No overlap. The stem avoids the words plasma, concentrated and conserve entirely; the osmolarity in the stem is given as a number, not as a comparison to blood.

**Explanation (as shipped).**

> This question falls under Organ Systems and tests why the order in which fluid meets nephron segments determines what the kidney can do. The answer is A because the salt pumping limb leaves the fluid it discharges at roughly 100 mOsm/kg, so whatever segment sits downstream of it is the only structure that can ever raise that value again. In the real itinerary the diluting limb acts early and hands a hypotonic fluid to the terminal duct, which then sits inside an interstitium running up to about 1200 mOsm/kg. If that duct is water permeable, water leaves down the gradient and the fluid finishes hyperosmotic; if the duct is closed to water, the hypotonic fluid passes through unchanged. Both outcomes are available only because the diluting step comes first and the tunable step comes last. Swap them and the final thing that happens to the fluid is obligatory dilution, so the animal excretes a large watery volume whether or not it has water to spare. The gradient is still there, but nothing downstream can use it.
>
> (Choice B) Glucose is reclaimed in the proximal convoluted tubule, which lies upstream of both swapped segments and is untouched by the rearrangement. Its transport maximum is unchanged, so glucose handling is unaffected.
>
> (Choice C) The rearranged nephron keeps the ability to make watery urine; in fact it can do nothing else, since the last segment always discharges fluid well below plasma osmolarity. This choice states the surviving ability rather than the lost one.
>
> (Choice D) Filtration occurs at the corpuscle, before the fluid reaches either of the two segments in question. Rearranging plumbing downstream of the barrier does not change the rate at which fluid crosses it, so this names the wrong stage of the process.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to predict which physiological capability disappears when two steps of an established sequence are exchanged.

---

## Q3 . Renal oxygen supply versus transport work

**Stem.** A surgical patient is hypotensive for 40 minutes. A biopsy taken afterward shows dead tubular cells packed into one narrow band at a fixed depth inside the kidney, while tubules nearer the outer aspect look intact. Which pairing of features accounts for the location of the damage?

- **A.** Those cells sit in the most richly perfused region of the kidney, so the fall in pressure withdrew a larger absolute quantity of supply from them than from any other tubule.
- **B.** Those cells are the first to meet the filtrate, so they faced the largest solute load before any reabsorption had occurred.
- **C.** Those cells do very little transport work and hold few mitochondria, so even a brief interruption of supply kills them.
- **D.** Those cells carry the heaviest active pumping load while sitting where oxygen delivery is lowest.  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic secondary / structural multi_step) |
| Estimated time | 105 s |
| Confidence | 4 |
| Hard-tier gate | (a) it joins two separate concepts, segment specific transport workload and the countercurrent limitation on regional oxygen delivery; (c) choices A and B remain defensible until the student applies the specific fact that deep renal tissue receives a small share of renal flow and that the earliest tubule segments lie in the outer tissue, since A is a genuine and plausible perfusion argument rather than an obviously false one; (d) it inverts the usual direction of reasoning by supplying the outcome, a band of dead cells at one depth, and demanding the cause. |

**Correct answer (D): Those cells carry the heaviest active pumping load while sitting where oxygen delivery is lowest.**

Citations: AP:53211, AP:53272, AP:53297, AP:53307, AP:52687

**Distractors**

- **(A)** `reversed_relationship`: Deep renal tissue receives the smallest share of renal blood flow, not the largest, so the perfusion relationship is stated backwards and the choice describes the tissue that survived.
  - Citation: AP:53307
- **(B)** `process_step_confusion`: The segment that first receives filtrate is the proximal convoluted tubule, which lies in the outer tissue the biopsy found intact, so this names the wrong stage of the tubular itinerary.
  - Citation: AP:53211
- **(C)** `misconception`: The thick ascending limb is a metabolically active, mitochondria dense segment, so the premise of low transport work is simply false.
  - Citation: AP:52687

**Readback check.** Content words of six or more letters in key D: heaviest, active, pumping, sitting, oxygen, delivery, lowest. Stem content words of six or more letters: surgical, patient, hypotensive, minutes, biopsy, afterward, tubular, packed, narrow, kidney, tubules, nearer, aspect, intact, pairing, features, accounts, location, damage. No overlap. The stem never uses the words oxygen, pumping, transport or delivery, so the key cannot be recognized by word matching.

**Explanation (as shipped).**

> This question falls under Organ Systems and tests the mismatch between where the kidney does its hardest transport work and where its blood supply is thinnest. The answer is D because the thick ascending limb runs its sodium potassium ATPase at a very high rate, and that limb lies in the medulla, the least well supplied tissue in the organ. Deep renal tissue receives only a small fraction of total renal flow, and the vessels serving it are arranged as hairpins in which the descending and ascending arms lie against one another. Oxygen diffuses straight across from the incoming arm into the outgoing arm and is carried back out before it ever reaches the bottom of the loop, so oxygen tension at depth is low even in a healthy person. The cells there therefore work with almost no reserve. A drop in perfusion that a cortical tubule shrugs off pushes this segment below what its pumps require, and it dies first. That is why the injury appears as a band at one depth rather than as damage spread evenly through the organ, and why the kidney tolerates a fall in perfusion so poorly.
>
> (Choice A) The relationship runs the other way. The outer tissue, not the deep band, receives the great majority of renal blood flow, so the region that lost the largest absolute quantity of supply is precisely the region the biopsy found intact. Perfusion by itself cannot single out the cells that died; only the ratio of supply to demand can.
>
> (Choice B) The cells that meet filtrate first are proximal convoluted tubule cells, and those sit in the outer tissue, which the biopsy describes as intact. Naming that stage of the itinerary contradicts the location the question asks about.
>
> (Choice C) These cells are densely packed with mitochondria precisely because their pumping load is so large. A low workload would predict tolerance of a supply interruption, not vulnerability to one, so the reasoning points the wrong way.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to work backward from an observed pattern of injury to the combination of metabolic demand and regional supply that produced it.

---

## Q4 . Bladder compliance and upstream drainage

**Stem.** A urinary bladder taking in urine from 50 mL to 400 mL shows almost no rise in the pressure inside it. Suppose instead its wall were stiff, so that the pressure climbed in proportion to the volume held. What would follow upstream?

- **A.** Filtration at the capsule would increase, because a larger force downstream draws more fluid across the barrier.
- **B.** Ureteral drainage would be opposed during much of the storage interval, damming fluid back toward the kidneys.  <- **KEY**
- **C.** The lining cells would stay tall and columnar instead of flattening as the wall is stretched.
- **D.** Urine formation would halt until the next void, because the kidneys cannot work against a downstream force.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic secondary / structural two_step) |
| Estimated time | 80 s |
| Confidence | 5 |

**Correct answer (B): Ureteral drainage would be opposed during much of the storage interval, damming fluid back toward the kidneys.**

Citations: AP:52344, AP:52365, AP:52412, AP:52422, AP:52204

**Distractors**

- **(A)** `reversed_relationship`: A rise in downstream pressure raises the hydrostatic pressure opposing filtration at the capsule rather than encouraging it, so the direction of the effect is reversed.
  - Citation: AP:52829
- **(C)** `adjacent_fact`: The change in shape of the lining epithelium during stretch is true but concerns the wall itself, not the upstream consequence the question asks about.
  - Citation: AP:52365
- **(D)** `misconception`: Students commonly assume urine production pauses between voids; filtration is continuous, which is exactly why a low pressure store is needed.
  - Citation: AP:52204

**Readback check.** Content words of six or more letters in key B: Ureteral, drainage, opposed, during, storage, interval, damming, kidneys. Stem content words of six or more letters: urinary, bladder, taking, pressure, inside, Suppose, instead, climbed, proportion, volume, upstream, follow. No overlap. The stem never names the ureters, the kidneys or drainage, so the key cannot be matched by shared vocabulary.

**Explanation (as shipped).**

> This question falls under Organ Systems and tests compliance, the ability of a hollow store to accept volume without a matching rise in pressure, and what that property protects. The answer is B because the whole drainage path above the store operates on a very small pressure difference, and a stiff wall would cancel that difference long before the store was full. Urine is made continuously, so it has to keep moving away from the kidney at all times and not only at the moment of voiding. The ureters move it along with modest peristaltic waves that work against whatever pressure waits at the far end, and they do so without help from gravity. A highly compliant store takes on several hundred milliliters while the pressure inside it rises by only a few centimeters of water, so the far end stays near zero throughout the interval between voids and flow stays one way. Make the wall stiff and pressure climbs with every milliliter added, the ureters progressively lose the head they need, and fluid backs up into the collecting system of the kidney itself. That rising back pressure is what ultimately threatens the nephrons, which is why compliance is best understood as a protective property for the organs above the store rather than a convenience for the store itself.
>
> (Choice A) The relationship is inverted. Raising the pressure downstream of a filter opposes filtration rather than promoting it, since fluid must be driven into a space that is already pressurized.
>
> (Choice C) The lining epithelium does flatten as the wall is stretched, and that is a genuine feature of this organ, but it is a fact about the wall itself and says nothing about what happens upstream, which is what the question asked.
>
> (Choice D) The kidney does not switch itself off when downstream pressure rises. Filtration carries on and fluid accumulates in the tract above the obstruction, which is precisely the outcome that a compliant wall exists to prevent.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to remove one mechanical property from a downstream reservoir and infer the consequence for the organs that drain into it.

---

## Q5 . Capsular pressure in glomerular filtration

**Stem.** A physiologist advances micropipettes into a single rat nephron and records 55 mm Hg of blood hydrostatic pressure inside the glomerulus, 15 mm Hg of fluid pressure inside Bowman's space, and 30 mm Hg of colloid osmotic pressure in the glomerular blood. Protein is essentially absent from Bowman's space. What is the net pressure driving fluid across the wall, and which way does it act?

- **A.** 40 mm Hg, directed out of the vessel
- **B.** 25 mm Hg, directed out of the vessel
- **C.** 10 mm Hg, directed out of the vessel  <- **KEY**
- **D.** 10 mm Hg, directed into the vessel

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 75 s |
| Confidence | 5 |

**Correct answer (C): 10 mm Hg, directed out of the vessel**

Citations: AP:52871, AP:52850, AP:52828, AP:52885

**Distractors**

- **(A)** `partial_truth` . _omitted opposing term_: Correctly subtracts the capsular fluid pressure but omits the colloid osmotic term, overstating the outward force fourfold.
  - Citation: AP:52871
- **(B)** `misconception` . _ignored capsular back pressure_: Reflects the common belief that only blood pressure and plasma proteins matter and that the pressure inside the capsule is negligible.
  - Citation: AP:52871
- **(D)** `reversed_relationship` . _sign inversion_: Right magnitude, wrong sign; it reverses the direction of the net force even though the outward term exceeds the sum of the inward terms.
  - Citation: AP:52850

**Readback check.** Content words of six or more letters in the key: 'directed', 'vessel'. Neither appears in the stem, which uses 'driving fluid across the wall' and 'which way does it act'. The numeric value 10 appears nowhere in the stem and cannot be lifted from it; it requires summing the two opposing terms before subtracting.

**Explanation (as shipped).**

> This question sits in the Organ Systems category and tests the three way pressure balance that sets the rate of filtration in the renal corpuscle. The answer is C because the 55 mm Hg pushing outward is opposed both by the 15 mm Hg of fluid already sitting in the capsular space and by the 30 mm Hg of colloid osmotic pull from retained plasma proteins, so 55 minus 45 leaves 10 mm Hg acting outward. The two opposing terms are summed first and then subtracted as a single quantity, because both act inward on the same barrier. The capsular term matters here in a way it does not in most vascular beds: fluid that crosses the wall enters an enclosed chamber with one narrow exit, so it builds a back pressure of its own that the blood must overcome. The osmotic term is large precisely because almost no protein crosses; with the far side effectively protein free, the fluid there exerts virtually no osmotic pull of its own and contributes nothing to the outward side of the ledger. The surviving margin is only about 10 mm Hg, which is why a shift of a few mm Hg in any single term produces a large proportional change in the volume filtered each minute.
>
> (Choice A) 40 mm Hg results from subtracting only the fluid pressure in the capsular chamber and forgetting that retained plasma proteins also hold fluid back. This overstates the true driving force fourfold.
>
> (Choice B) 25 mm Hg comes from subtracting only the colloid osmotic term. That is the balance one would write for a bed draining into open interstitial space, but it ignores the enclosed chamber on the far side of this particular barrier, which pushes back with a substantial 15 mm Hg.
>
> (Choice D) A 10 mm Hg force acting inward has the right magnitude but the wrong sign. A corpuscle operating that way would reclaim fluid from the tubule rather than produce the roughly 180 liters of filtrate formed each day, and the arithmetic gives a positive outward remainder because 55 exceeds the sum of 15 and 30.
>
> This is a Data-based and Statistical Reasoning question because it asks the student to combine three separately measured pressures with the correct signs and report both the size and the direction of the result.

---

## Q6 . Downstream obstruction and filtration rate

**Stem.** A stone lodges in one ureter and completely blocks outflow from that kidney, while the opposite kidney is untouched. One hour later the mean arterial pressure, the plasma protein concentration, and the blood flow through the blocked kidney are all unchanged, yet the volume of fluid entering the tubules on that side has dropped to about a fifth of its former value. Which of the following occur in a nephron of the blocked kidney?

I. Fluid pressure inside the capsular space has risen.
II. The net pressure driving fluid out of the glomerular capillary has fallen.
III. Blood hydrostatic pressure inside the glomerular capillary has fallen below the blood colloid osmotic pressure.

- **A.** I only
- **B.** I and II only  <- **KEY**
- **C.** II and III only
- **D.** I, II, and III

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 100 s |
| Confidence | 4 |
| Hard-tier gate | (a) It combines the capsular hydrostatic term with the dependence of filtered volume on net driving pressure. (b) It demands a directional inference about which term moved, not a lookup. (d) It inverts the usual direction of reasoning: the outcome is given and the causal term must be identified. Choices C and D also stay defensible until the student applies the fact that the arterial supply pressure and the renal blood flow are both fixed. |

**Correct answer (B): I and II only**

Citations: AP:52871, AP:52233, AP:54579, BIO:54604

**Distractors**

- **(A)** `partial_truth` . _cause without consequence_: Correctly identifies the rise in capsular pressure but stops before the consequence that actually explains the fall in filtered volume.
  - Citation: AP:52871
- **(C)** `process_step_confusion` . _wrong side of the barrier_: Locates the pressure change at the wrong stage of the pathway, inside the blood rather than in the fluid that has already crossed the barrier.
  - Citation: AP:52871
- **(D)** `misconception` . _only blood side can change_: Assumes filtration can only stop when blood hydrostatic pressure drops below the colloid osmotic pressure, which contradicts the unchanged pressure and flow stated in the stem.
  - Citation: AP:52850

**Readback check.** The key text is 'I and II only', which contains no content word of six or more letters, so stem echo is structurally impossible for the key. The numeral statements were checked individually against the stem: the stem deliberately says 'the volume of fluid entering the tubules' rather than naming filtration or the capsular space, so neither statement I nor statement II shares a six letter content word with the stem. Selecting the key still requires rejecting statement III, which cannot be done by word matching.

**Explanation (as shipped).**

> This question sits in the Organ Systems category and tests how a mechanical block far downstream of the nephron feeds back on the balance of forces at the filtering surface. The answer is B because fluid that keeps crossing the barrier now has nowhere to drain, so it accumulates upstream of the stone and raises the pressure inside the capsular chamber, and that rising back pressure subtracts directly from the outward drive. Statement I is therefore the cause and statement II is its consequence. The instructive feature of this scenario is that nothing on the blood side has moved: arterial pressure, plasma protein concentration and renal blood flow are all held constant, so neither the outward hydrostatic term nor the inward colloid osmotic term has changed. Filtration nevertheless collapses, and the only remaining term that can account for it lies on the far side of the barrier. This is why an obstructed ureter can silence a kidney within hours in a patient whose blood pressure is entirely normal, and why relieving the obstruction restores function if it is done soon enough.
>
> (Choice A) Statement I is true but stops short of the outcome described. A rise in capsular pressure matters here only because it enters the balance as an opposing term, and naming the rise without carrying it through to the net outward drive leaves the fall in filtered volume unexplained.
>
> (Choice C) Pairing II with III places the pressure change on the wrong side of the barrier. A downstream blockage raises the pressure of fluid that has already crossed, not the pressure of the blood upstream of the filtering surface, which is set by an arterial supply whose mean pressure and flow the stem holds steady.
>
> (Choice D) This keeps the two correct statements but adds the same error as choice C. Statement III also contradicts the conditions given, since a fall in glomerular blood pressure large enough to abolish filtration could not occur while both the mean arterial pressure and the blood flow through that kidney remain at their former values.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to start from an observed collapse in filtered volume and work backwards to identify which single term in the pressure balance must have moved.

---

## Q7 . Barrier conductance as a determinant of filtration rate

**Stem.** In a rat model of glomerular injury, micropuncture of an affected nephron shows the blood hydrostatic pressure inside the glomerulus, the fluid pressure in Bowman's space, and the colloid osmotic pressure of the glomerular blood all at their usual values. Blood flow to that nephron is normal as well, yet the fluid it forms each minute is half of the control value. Which explanation is best supported?

- **A.** The fluid pressure in Bowman's space must in fact be raised, since filtration cannot fall while every measured pressure is normal.
- **B.** The colloid osmotic pressure of the blood must be higher than the sampled figure, since taking water out concentrates the proteins left behind.
- **C.** Fluid leaving the blood early in the bed is drawn back into it later in the bed, so the net amount collected is halved.
- **D.** The push across the wall is only one term; how much wall remains open and how readily it lets water pass also set the rate, and both have been reduced.  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic secondary / structural two_step) |
| Estimated time | 90 s |
| Confidence | 4 |

**Correct answer (D): The push across the wall is only one term; how much wall remains open and how readily it lets water pass also set the rate, and both have been reduced.**

Citations: AP:52604, AP:52629, AP:52776, AP:52871

**Distractors**

- **(A)** `misconception` . _pressure is the whole story_: Assumes the pressure balance is the only thing that can set filtration rate, so it rejects a normal capsular reading rather than admit a second determinant.
  - Citation: AP:52871
- **(B)** `partial_truth` . _true but non discriminating_: The stated effect on colloid osmotic pressure is real but occurs in healthy corpuscles as well, so it cannot account for the difference from control.
  - Citation: AP:52846
- **(C)** `adjacent_fact` . _behavior borrowed from another bed_: Imports a return of fluid to the blood that occurs in other vascular beds but cannot occur here, where the far side holds a positive pressure and essentially no protein.
  - Citation: AP:52846

**Readback check.** Content words of six or more letters in the key: 'remains', 'readily', 'reduced'. The stem's six letter and longer content words are: glomerular, injury, micropuncture, affected, nephron, hydrostatic, pressure, inside, glomerulus, Bowman's, colloid, osmotic, values, normal, minute, control, explanation, supported. There is no overlap. The key also cannot be lifted from the stem, which never mentions the barrier, its area or its permeability; the student must infer that the only unmeasured factor is the wall itself.

**Explanation (as shipped).**

> This question sits in the Organ Systems category and tests what sets the volume of filtrate a single corpuscle produces once the pressure balance has been accounted for. The answer is D because the rate at which fluid crosses the wall is the product of two independent things: the net pressure pushing it, and the ease with which the wall itself lets water by, which reflects both how much filtering surface is open and how leaky that surface is per unit of area. Every pressure term in this nephron is at its usual figure, so the net push is unchanged and cannot account for the loss, and the blood supply is normal as well. The remaining factor is the wall itself. Injury that scars part of the tuft, or that makes the supporting cells wrapped around the loops contract and take loops out of service, removes filtering surface without moving any pressure, and injury to the covering cells that form the slits lowers how easily water moves per unit of the surface that remains. Either change halves output while leaving every micropipette reading normal, which is why a corpuscle can fail quietly in a patient whose blood pressure is entirely ordinary.
>
> (Choice A) This insists that a pressure must have moved because nothing else could have, which is exactly the assumption the scenario is built to break. The value in the capsular space was measured directly and came back normal, so discarding the measurement in order to protect the assumption is the weaker inference.
>
> (Choice B) Removing water does concentrate the proteins left in the blood, so the colloid osmotic term genuinely climbs from one end of the bed to the other. That happens in a healthy corpuscle too, so it cannot explain why this one yields half as much fluid as a control in which the same concentrating effect occurs.
>
> (Choice C) Nothing in the corpuscle pulls fluid back out of the capsular space. The fluid there carries essentially no protein and so exerts no osmotic pull of its own, and its hydrostatic pressure stays well below the pressure in the glomerular blood along the whole length of the bed, so the movement never turns around.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to rule out every term in the pressure balance using the values supplied and then identify the property of the barrier that must have changed instead.

---

## Q8 . Protein binding and filtrate solute composition

**Stem.** A fine glass pipette is placed in Bowman's space of a single nephron in an anaesthetised rat, and fluid is collected at the instant it forms, on the far side of the corpuscular wall and before it has reached any tubular segment. Blood taken from the renal artery at the same moment is spun down and its cell free liquid is assayed.

| Substance | Blood, cell free liquid | Bowman's space fluid |
| --- | --- | --- |
| Sodium | 142 mmol/L | 142 mmol/L |
| Potassium | 4.3 mmol/L | 4.3 mmol/L |
| Glucose | 5.1 mmol/L | 5.1 mmol/L |
| Urea | 5.4 mmol/L | 5.4 mmol/L |
| Creatinine | 0.09 mmol/L | 0.09 mmol/L |
| Total calcium | 2.4 mmol/L | 1.3 mmol/L |
| Albumin | 42 g/L | 0.02 g/L |

Albumin is a 66 kDa protein; every other entry in the table is a small solute less than 1 nm wide. Which conclusion about the calcium rows is best supported by these readings?

- **A.** Roughly half of this ion travels docked to a macromolecule that the wall holds back, so its unattached form sits at the same level on either side.  <- **KEY**
- **B.** The corpuscular wall pumps this ion back into the blood as fluid crosses, keeping its level in Bowman's space below its level in blood.
- **C.** Part of this ion had already been taken back into the blood by the tubule before the sample was drawn, which is why less of it remains.
- **D.** The share of this ion that is bound to plasma protein is the share that crosses the wall, and the free share is the one held back.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **medium** (topic core / structural multi_step) |
| Estimated time | 105 s |
| Confidence | 5 |

**Correct answer (A): Roughly half of this ion travels docked to a macromolecule that the wall holds back, so its unattached form sits at the same level on either side.**

Citations: AP:52121, AP:52260, AP:52595, AP:52632, AP:53714, AP:54976

**Distractors**

- **(B)** `misconception` . _Treats the renal corpuscle as a selectively transporting epithelium rather than a passive sieve_: The corpuscular wall is a fenestrated endothelium, basement membrane and podocyte slit assembly that filters in bulk; it carries no pump that moves a solute back across itself. If a pump were removing calcium from the forming fluid, sodium, potassium and glucose would show gaps here too, and every one of them reads identically in the two columns.
  - Citation: AP:52632
- **(C)** `process_step_confusion` . _Attributes a filtration stage observation to the later tubular reabsorption stage_: The sample was drawn in Bowman's space before the fluid reached any tubular segment, so tubular recovery has not yet acted on it. Calcium reabsorption is real but happens downstream of the sampling point and cannot create a difference already present at the instant the fluid forms.
  - Citation: AP:52595
- **(D)** `reversed_relationship` . _Swaps which pool, bound or free, is the filterable one_: Binding to a large plasma protein is precisely what prevents a solute from being filtered, so the bound pool stays behind and the free pool passes. If the bound pool crossed, albumin would appear in Bowman's space at a substantial concentration, yet it reads only 0.02 g/L.
  - Citation: AP:53714

**Readback check.** Content words of six or more letters in key A: Roughly, travels, docked, macromolecule, unattached, either. Stem word inventory: pipette, placed, Bowman's, single, nephron, anaesthetised, collected, instant, before, reached, tubular, segment, corpuscular, artery, moment, liquid, assayed, Substance, Sodium, Potassium, Glucose, Creatinine, calcium, Albumin, protein, solute, conclusion, supported, readings. A programmatic whole word and substring scan of the stem, including the table, returned zero hits for Roughly, travels, docked, macromolecule, unattached and either, so the key cannot be produced by echoing stem language. The key is also not a table value: 2.4 and 1.3 mmol/L appear in the table but the key states neither number, asserting instead an unmeasured relationship, that the free concentrations match on both sides, which must be inferred from the size of the calcium gap set against the near absence of albumin and the exact match of every other solute.

**Explanation (as shipped).**

> This Organ Systems item tests what the composition of newly formed glomerular fluid reveals about which physical form of a solute is able to pass the corpuscular wall. The answer is A because a solute that circulates partly bound to a plasma protein presents only its free portion to the sieve, so its total concentration falls on the far side while its free concentration does not. Sodium, potassium, glucose, urea and creatinine read identically in both columns, the signature of water sweeping small solutes bodily through open pores rather than any selective handling. Albumin, at 42 g/L in blood and essentially nil in the sampled fluid, shows that the wall retains the large plasma protein, so what forms is otherwise a copy of the liquid phase of blood. Calcium is the lone outlier, 2.4 mmol/L against 1.3 mmol/L, and the one property that separates calcium from the other small solutes is that about half of it circulates attached to albumin. The attached portion leaves with the albumin, the free portion passes without hindrance, and the free calcium concentration is therefore the same in both compartments even though the totals are not.
>
> (Choice B) The renal corpuscle is a sieve, not a transporting epithelium: it presents fenestrated endothelium, a basement membrane and podocyte filtration slits, and no pump that drives a solute back across the wall. Had such a pump been at work, sodium, potassium and glucose, all of which are handled by carriers elsewhere in the nephron, would show gaps here as well, and they do not.
>
> (Choice C) The fluid was collected in Bowman's space before it reached any tubular segment, so reabsorption has had no opportunity to act on it. Calcium reabsorption in the proximal tubule and the loop is real, but it operates on fluid that has already left the sampling point and cannot produce a difference present at the moment of formation.
>
> (Choice D) This inverts which pool moves. Attachment to a large plasma protein is precisely what prevents a solute from crossing, so the attached pool stays behind and the free pool passes. If the attached pool crossed instead, albumin itself would have to appear in Bowman's space in quantity, yet it reads 0.02 g/L, a trace.
>
> This is a Data-based and Statistical Reasoning question because it asks the student to compare two columns of a table, locate the single row that breaks an otherwise perfect match, and infer the physical reason for that one departure rather than read any listed value off the table.

---

## Q9 . Size limit of the filtration barrier and routes into tubular fluid

**Stem.** Testing of a patient's urine reveals globulin molecules of roughly 150 kDa present at about one third of their concentration in plasma. No segment of the nephron possesses a carrier able to move intact molecules of that mass into the lumen. Which of the following accounts for this finding?

- **A.** Size selectivity at the renal corpuscle has been lost, admitting particles normally held inside the capillary.  <- **KEY**
- **B.** The transport maximum for glucose in the proximal convoluted tubule has been exceeded by the filtered load.
- **C.** Removal of water in the collecting duct has concentrated an amount of that protein that is ordinarily present.
- **D.** Secretion of creatinine into the distal portion of the nephron has risen sharply above its usual rate.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 65 s |
| Confidence | 5 |

**Correct answer (A): Size selectivity at the renal corpuscle has been lost, admitting particles normally held inside the capillary.**

Citations: AP:52624, AP:52628, AP:52846, AP:53081

**Distractors**

- **(B)** `adjacent_fact` . _true statement about a different solute_: A saturated transport maximum for glucose is a real phenomenon but concerns a sub 200 dalton sugar recovered in the proximal tubule; it has no bearing on the passage of a 150 kDa protein at the head of the nephron.
  - Citation: AP:53168
- **(C)** `partial_truth` . _correct mechanism, insufficient magnitude_: Water removal downstream genuinely concentrates the tubular fluid, but healthy filtrate contains large protein at a tiny fraction of one percent of the plasma level, so no achievable degree of concentration reaches one third of that level.
  - Citation: AP:52846
- **(D)** `adjacent_fact` . _real secretory pathway, wrong molecular class_: Creatinine really is added to the lumen from peritubular blood, but that pathway handles small organic solutes and cannot transfer an intact 150 kDa protein, a route the stem has already excluded.
  - Citation: AP:53081

**Readback check.** Content words of six or more letters in key A: selectivity, corpuscle, admitting, particles, normally, inside, capillary. Stem content words of six or more letters: Testing, patient, reveals, globulin, molecules, roughly, present, concentration, plasma, segment, nephron, possesses, carrier, intact, accounts, following, finding. No overlap. The key is not a restatement of any stem phrase: the stem supplies a downstream observation plus the exclusion of one entry route, and the student must run the inference backwards to the remaining route. Option lengths are balanced at 100 to 110 characters so the key is not the longest choice, and no option is a simple negation of another.

**Explanation (as shipped).**

> This item sits in the Organ Systems category and tests the size limit of the sieve that produces the initial filtrate. The answer is A because a globulin of roughly 150 kDa cannot cross that sieve in a healthy kidney, and the stem has closed off every other route by which such a molecule could reach the tubular fluid. The fluid captured at the head of the nephron differs from blood chiefly in that it contains no cells and no medium to large proteins, both of which stay behind in the capillary. Anything found downstream must therefore have arrived either at that entry point or by being handed into the lumen from the surrounding blood. The stem rules out the second route explicitly for a molecule of this mass, since no carrier moves an intact protein of that size across the tubular epithelium. Only entry at the front of the nephron remains, which means the sieve there is admitting particles it ordinarily rejects outright. (Choice B) The transport maximum for glucose governs a sugar of under 200 daltons that is ordinarily recovered in full early in the tubule. Saturating that system spills sugar into the urine and says nothing whatever about the handling of a molecule nearly a thousand times heavier. (Choice C) Removing water downstream does raise the concentration of everything already in the tubular fluid, but healthy filtrate carries only a trace of large protein, a tiny fraction of one percent of the plasma level. No degree of water removal the kidney can achieve would lift that trace to one third of the plasma value, so concentration alone cannot produce this result. (Choice D) Creatinine is genuinely added to the lumen from the peritubular blood, but that pathway serves small organic solutes and organic acids and bases. It has neither the capacity nor the mechanism to move an intact 150 kDa protein, and creatinine itself would not register as a globulin on testing. This is a Knowledge of Scientific Concepts and Principles question because it asks the student to apply the known size limit of the barrier at the head of the nephron in order to interpret an abnormal protein finding in urine.

---

## Q10 . Fixed anionic charge and charge selectivity

**Stem.** Rats are treated with an enzyme that strips the fixed negative charges lining the glomerular capillary wall, the basement membrane and the podocyte slits. Electron micrographs confirm that slit width and endothelial pore diameter are unchanged. The animals then receive two inert dextran tracers of identical 3.6 nm effective radius, small enough that neither is excluded on size alone: X carries a net negative charge and Y is electrically neutral. Compared with untreated animals, how should the two tracers appear in fluid collected from Bowman's capsule?

- **A.** X and Y both rise by the same proportion.
- **B.** Y rises steeply in the filtrate while X shifts hardly at all.
- **C.** X rises steeply in the filtrate while Y shifts hardly at all.  <- **KEY**
- **D.** X and Y both rise, with Y showing the larger increase.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic secondary / structural multi_step) |
| Estimated time | 105 s |
| Confidence | 5 |
| Hard-tier gate | Meets (a), (b) and (c). (a) It combines two separate selection mechanisms, size exclusion and fixed charge repulsion, which must be held apart rather than merged. (b) It demands a directional prediction about two tracers under a single manipulation, not a lookup. (c) Choices A and D both stay defensible until the student recognizes that a neutral species has no electrostatic restriction available to lose. |

**Correct answer (C): X rises steeply in the filtrate while Y shifts hardly at all.**

Citations: AP:52625, AP:52627, AP:52628, AP:52631

**Distractors**

- **(A)** `misconception` . _barrier is size only_: It treats the barrier as a pure size sieve on which charge is irrelevant; but if charge were irrelevant the enzyme would produce no change at all, so a uniform rise in both tracers cannot follow from the manipulation described.
  - Citation: AP:52631
- **(B)** `reversed_relationship` . _charge effect applied to the wrong tracer_: The electrostatic effect is assigned to the wrong species. A neutral tracer is unaffected by fixed charge and so cannot be the one released when that charge is removed; the negatively charged tracer is the one that was being repelled.
  - Citation: AP:52627
- **(D)** `partial_truth` . _right direction, wrong species dominates_: The direction of change is right but the magnitudes are assigned backwards. The neutral tracer was already crossing at nearly the rate its 3.6 nm radius allows and has little headroom, whereas the charged tracer was the one held back.
  - Citation: AP:52625

**Readback check.** Content words of six or more letters in key C: steeply, filtrate, shifts. Stem content words of six or more letters: treated, enzyme, strips, negative, charges, lining, glomerular, capillary, basement, membrane, podocyte, Electron, micrographs, confirm, endothelial, diameter, unchanged, animals, receive, tracers, identical, effective, radius, enough, neither, excluded, carries, electrically, neutral, Compared, untreated, collected, Bowman's, capsule. No overlap, and the word filtration does not appear in the stem. The labels X and Y and the word tracer recur by necessity but carry no answer information, since the same two labels appear in every option. The key cannot be produced by copying: the stem never states which species the fixed charge repels. All four options are 40 to 61 characters, so the key is not the longest.

**Explanation (as shipped).**

> This question belongs to the Organ Systems category and tests the separation of two independent selection mechanisms operating at the same barrier. The answer is C because the enzyme abolishes an obstacle that acted on one tracer only, and the tracer it never acted on has nothing to gain. The barrier can be treated as two filters applied to the same stream: a geometric one set by the dimensions of the endothelial windows and the gaps between neighboring foot processes, and an electrostatic one set by the fixed anionic groups lining those pathways. The stem states that both tracers sit below the geometric limit, so on dimensions alone both are admitted. In the untreated animal the anionic species is repelled by the like charges fixed along the wall of the pathway and therefore appears in far smaller amounts than the neutral species of identical size. Once the fixed charge is stripped, and with the micrographs certifying that no opening has widened, the repelled species loses the only thing that was holding it back and its passage climbs toward that of the neutral species. The neutral tracer was already crossing at close to the rate its size permits, so it has almost no headroom to increase. (Choice A) An equal proportional rise treats the barrier as if charge acted on both species alike. If the wall were a pure size sieve the enzyme would change nothing at all, and if charge matters then only the charged species can be released by removing it, so this option is internally inconsistent. (Choice B) This has the direction of the electrostatic effect backwards. The neutral tracer is by definition immune to a fixed charge, so it cannot be the species freed by removing that charge, whereas the negatively charged species is the one being repelled. (Choice D) This gets the direction of change right but assigns the larger response to the wrong species. Both could rise slightly if any nonspecific damage occurred, yet the tracer that stood to gain most is unambiguously the one whose exclusion depended on the charge that was just removed. This is a Scientific Reasoning and Problem Solving question because it asks the student to hold pore geometry constant, isolate charge as the single altered variable, and predict the differential response of two otherwise identical tracers.

---

## Q11 . Layer specific failure of the serial barrier

**Stem.** A mutation abolishes the protein that bridges the gap between adjacent podocyte foot processes. Electron microscopy and biochemical assay show the endothelial pores and the basement membrane to be entirely normal. Which of the following would be expected in the fluid entering the proximal convoluted tubule?

I. Plasma proteins present in appreciable amounts
II. Intact erythrocytes present
III. Glucose present at its plasma concentration

- **A.** I only
- **B.** II only
- **C.** I and II only
- **D.** I and III only  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 90 s |
| Confidence | 4 |

**Correct answer (D): I and III only**

Citations: AP:52598, AP:52604, AP:52624, AP:52845, AP:53101

**Distractors**

- **(A)** `partial_truth` . _correct leak, forgets the unchanged normal finding_: It captures the protein leak but omits statement III, implicitly treating unimpeded glucose entry as something the defect should abolish; glucose crosses all three elements freely in health and continues to do so.
  - Citation: AP:53101
- **(B)** `misconception` . _cells held by the wrong layer_: It credits the foot process bridge with retaining blood cells. Cells are arrested at the perforated endothelial layer, whose windows are two orders of magnitude smaller than an erythrocyte and which the stem reports as normal.
  - Citation: AP:52624
- **(C)** `process_step_confusion` . _serial barrier collapsed into a single filter_: It names the wrong stage of the series for cell retention, treating one element's failure as opening the barrier to every particle class at once rather than only to those the damaged element was responsible for.
  - Citation: AP:52631

**Readback check.** The options contain no content words at all, being Roman numeral combinations, so no stem echo is possible in the key. Within the numbered statements, the discriminating work lies in II and III, neither of which is settled by any phrase in the stem: the stem names the damaged structure but never states what that structure retains, nor what the intact layers retain. The student must supply the size hierarchy of the three elements. All four options are of equal length, so no length cue exists.

**Explanation (as shipped).**

> This question belongs to the Organ Systems category and tests which of the structures standing in series at the renal corpuscle holds back which class of particle. The answer is D because the mutation widens the narrowest restriction in the series while leaving intact the far coarser one that arrests cells, and small solutes were never restricted by any layer to begin with. Fluid crossing into the capsule passes three structures one after another, and each has a different effective limit, so a defect in one predicts a specific set of consequences rather than a general opening. The innermost layer is perforated by windows measured in tens of nanometers, which is ample to arrest a cell roughly a hundred times that size but far too coarse to detain a dissolved protein. The gaps between adjacent foot processes form the narrowest passage in the series and are among the structures that keep albumin sized proteins on the blood side, so abolishing the bridge that spans them lets appreciable protein through and statement I holds. An erythrocyte is stopped much earlier, at a layer the stem certifies as normal, so statement II fails. Glucose is a few hundred daltons and crosses every layer freely in health, entering the tubule at the same concentration it has in plasma, so statement III describes an ordinary event that the defect does not disturb. (Choice A) This correctly anticipates the protein leak but drops statement III, treating the ordinary free passage of a small sugar as though it should be disturbed by a defect in a protein sized restriction. Glucose entry is unchanged and is therefore expected. (Choice B) This assigns cell retention to the damaged element. Cells never reach the foot processes because they are held at the perforated inner layer, which the stem reports as structurally normal, so intact red cells should not appear. (Choice C) This pairs the correct protein prediction with the wrong layer for cells, treating the barrier as though a single failure opened it to everything at once rather than as a graded sequence in which the coarse restriction survives. This is a Scientific Reasoning and Problem Solving question because it asks the student to trace a defect localized to one element of a serial barrier forward to the precise set of particles that will and will not cross.

---

## Q12 . Clearance as a filtration rate marker

**Stem.** Substance Q is an inert polysaccharide that is freely filtered at the renal corpuscle and is neither reabsorbed nor secreted at any point in the nephron. Q is infused to a steady plasma level in a patient, and the clearances of Q and of three endogenous solutes are measured over the same collection period.

| Substance | Clearance (mL/min) |
|---|---|
| Q | 118 |
| R | 0 |
| S | 62 |
| T | 174 |

Which conclusion do these values support?

- **A.** R is added to the tubular fluid from the surrounding blood after it has been filtered.
- **B.** T is passed into the tubular fluid from the surrounding blood, beyond what arrives initially.  <- **KEY**
- **C.** S is held back entirely at the barrier and never enters the tubular fluid in the first place.
- **D.** S and T both have part of their load returned to the blood, S to a greater extent than T.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 95 s |
| Confidence | 5 |

**Correct answer (B): T is passed into the tubular fluid from the surrounding blood, beyond what arrives initially.**

Citations: AP:52905, AP:52907, AP:53081, AP:53101

**Distractors**

- **(A)** `reversed_relationship` . _secretion and reabsorption inverted_: Addition to the lumen raises clearance, so it can never yield a value of zero. A value of zero means every filtered molecule was returned to the blood, which is the opposite direction of transport.
  - Citation: AP:53081
- **(C)** `misconception` . _low clearance read as failure to filter_: A solute excluded from the initial filtrate and not otherwise added would give a value of zero, not 62. The intermediate value shows normal entry followed by recovery of roughly half the filtered load.
  - Citation: AP:52905
- **(D)** `partial_truth` . _one solute classified correctly, the other impossible_: It is correct that S undergoes net recovery, but T's value exceeds the reference set by Q, and a solute that is only filtered and then partly retrieved can never exceed that ceiling.
  - Citation: AP:52907

**Readback check.** Content words of six or more letters in key B: passed, tubular, surrounding, beyond, arrives, initially. Stem content words of six or more letters: Substance, polysaccharide, freely, filtered, corpuscle, neither, reabsorbed, secreted, nephron, infused, steady, plasma, patient, clearances, endogenous, solutes, measured, collection, period, Clearance, conclusion, values, support. No overlap. The key is not readable off the table: the number 174 appears in the table but the key states no number, and the conclusion requires comparing that value against a reference the student must first identify from Q's stated properties. Options run 85 to 93 characters, so the key carries no length cue, and the phrase surrounding blood appears in two options so it is not a unique marker.

**Explanation (as shipped).**

> This question belongs to the Organ Systems category and tests the use of a purely filtered marker as a yardstick against which other solutes are judged. The answer is B because Q fixes the yardstick at 118 mL/min, and only a solute that is put into the lumen by a second route can produce a value above that ceiling. Clearance expresses the volume of plasma stripped completely free of a solute each minute, so for a substance that enters the lumen only by filtration and is then left alone, clearance equals the volume of plasma filtered each minute. That makes Q's value the reference figure for this patient. A solute whose value falls below the reference must have had part of its filtered load returned to the blood, and a solute whose value is zero must have had all of it returned. A value above the reference cannot be explained by filtration at all, because filtration cannot deliver more than the reference volume; the excess must be transferred into the lumen from the peritubular blood, which is exactly what T's 174 mL/min shows. (Choice A) A value of zero is the signature of complete recovery, not of addition. Adding a solute to the lumen can only push the value upward, so R at zero indicates that everything filtered was taken back, as happens with glucose below its transport ceiling. (Choice C) A solute barred from the initial filtrate and not otherwise added would leave the plasma untouched and register a value of zero. S sits at roughly half the reference figure, which instead means it is filtered normally and then about half of the filtered load is retrieved. (Choice D) The first half of this is right, since S at 62 is below the reference and so is partly retrieved, but T at 174 exceeds the reference. A solute that is only filtered and then partly retrieved can never exceed the reference, so T cannot be undergoing net recovery at all. This is a Data-based and Statistical Reasoning question because it asks the student to establish a reference value from one row of a table and then classify the remaining measurements as above, below or at that reference in order to infer the direction of net transport.

---

## Q13 . Renal autoregulation across a pressure range

**Stem.** An anaesthetised animal has an adjustable clamp on the renal artery, and filtration rate for that kidney is recorded at a series of fixed arterial pressures. At 60 mmHg the filtration rate is 45 percent of its peak, but at every pressure from 80 to 180 mmHg it stays between 98 and 102 percent of peak. The investigator wants to know whether this flat stretch is produced by an active change in the calibre of the vessels feeding the glomeruli, or whether those vessels stay passive and the constancy is imposed somewhere past the filtration barrier. Which additional recording at each pressure would best separate the two possibilities?

- **A.** The protein content of fluid drawn from Bowman's capsule.
- **B.** The volume of blood leaving the organ's vein each minute.  <- **KEY**
- **C.** Urine output per unit time.
- **D.** A repeat series in which the clamp is opened to 180 mmHg in one abrupt jump.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 105 s |
| Confidence | 5 |
| Hard-tier gate | (b) requires a directional and roughly quantitative inference, that constant flow across a doubling of pressure forces resistance to have risen nearly in proportion; (c) choices C and D stay defensible until the student applies the specific facts that urine output is confounded by tubular handling and that the abrupt jump changes the stimulus rather than the recorded variable; (d) it inverts the usual direction of reasoning by giving the outcome, a flat curve, and asking what evidence would identify its cause. |

**Correct answer (B): The volume of blood leaving the organ's vein each minute.**

Citations: AP:53415, AP:53419, AP:53423, AP:53428

**Distractors**

- **(A)** `adjacent_fact` . _true statement about a different renal property_: Capsular protein content probes barrier selectivity, which is real physiology but is unchanged under both candidate explanations and therefore cannot separate them.
  - Citation: AP:52630
- **(C)** `partial_truth` . _downstream proxy mistaken for the target variable_: Urine output is a genuine renal output but sits past reabsorption and secretion, so it reflects tubular handling as much as vascular calibre and cannot isolate the supply vessels.
- **(D)** `process_step_confusion` . _manipulating stimulus timing instead of adding a measurement_: Changing the pressure ramp from graded to abrupt alters the protocol rather than the variable observed, and it destroys the graded series that revealed the flat stretch.

**Readback check.** Content words of six or more letters in key B: volume, leaving, minute. None appears in the stem, which uses anaesthetised, adjustable, clamp, renal, artery, filtration, recorded, series, arterial, pressures, percent, investigator, produced, active, calibre, vessels, feeding, glomeruli, passive, constancy, imposed, somewhere, barrier, additional, recording, separate, possibilities. The key cannot be produced by restating any stem phrase; the student must infer that flow, not filtration, discriminates active from passive resistance.

**Explanation (as shipped).**

> This item falls under Organ Systems and tests renal autoregulation, specifically what evidence separates an active adjustment of vessel calibre from a passive consequence of the plumbing. The answer is B because the volume of blood the organ receives each minute is the one quantity that reveals whether resistance upstream of the glomeruli is being raised in step with the driving pressure. A flat filtration curve on its own is silent about mechanism, since it is equally compatible with supply vessels that narrow progressively as pressure climbs and with supply vessels that stay wide while the constancy is imposed somewhere past the filtration barrier. Flow settles the matter. If flow through the organ is also flat while pressure more than doubles, then resistance in the supply vessels must have risen almost in proportion to pressure, which no passive tube can do, so the regulation lives in the vessel wall. If instead flow climbs roughly in a straight line with pressure while filtration stays flat, the supply vessels are plainly not adjusting, and the constancy has to be generated downstream of them. Notice that the two candidate explanations predict identical values for the variable already in hand, which is exactly why a second variable is needed. (Choice A) Protein in capsular fluid reports on the selectivity of the barrier, a separate property that neither candidate mechanism predicts would change, so it cannot discriminate between them. (Choice C) Urine output lies far downstream of filtration and is shaped by reabsorption and secretion along the whole tubule, so any pattern of urine output is consistent with either explanation and isolates nothing. (Choice D) An abrupt single jump alters only how fast the stimulus is applied, not which variable is recorded, and it discards the graded series that made the flat stretch visible in the first place, so it adds no discriminating information. This is a Reasoning about the Design and Execution of Research question because it asks the student to select the one additional recording that pulls apart two mechanisms that make identical predictions for the measurement already collected.

---

## Q14 . Macula densa position and luminal salt sensing

**Stem.** In a micropuncture experiment, the fluid running through the loop of a single nephron is switched to a solution in which dissolved salt is raised well above normal, delivered at exactly the previous rate. Within seconds the vessel supplying that same glomerulus narrows and that nephron's filtration rate falls, while every neighbouring nephron is unchanged. Where does the structure responsible for this response sit, and what does it register?

- **A.** In the wall of the distal convoluted tubule where it presses against the afferent arteriole, registering the sodium chloride concentration of the fluid in the tubule lumen.  <- **KEY**
- **B.** In the wall of the afferent arteriole itself, registering the sodium chloride concentration of the blood arriving at the glomerulus.
- **C.** In the layer of cells lining Bowman's capsule, registering the rate at which filtrate enters the nephron.
- **D.** In the wall of the distal convoluted tubule where it presses against the afferent arteriole, registering the wall tension of that vessel.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic secondary / structural two_step) |
| Estimated time | 85 s |
| Confidence | 5 |

**Correct answer (A): In the wall of the distal convoluted tubule where it presses against the afferent arteriole, registering the sodium chloride concentration of the fluid in the tubule lumen.**

Citations: AP:52635, AP:52638, AP:53434, AP:53437

**Distractors**

- **(B)** `misconception` . _sensor reads plasma rather than tubular fluid_: Students commonly assume salt sensing happens on the blood side, but only the fluid inside one tubule was altered and the response was confined to that nephron, which a blood borne reading cannot explain.
  - Citation: AP:52638
- **(C)** `adjacent_fact` . _a real structure at the wrong point in the flow path_: The capsular lining is genuine anatomy but lies upstream of the perfused segment, so it samples fluid before the manipulated change exists rather than after, and delivery rate was held constant anyway.
- **(D)** `process_step_confusion` . _correct site paired with the stimulus belonging to the other mechanism_: It borrows the adequate stimulus of the arteriole's own stretch sensitive smooth muscle and assigns it to the tubular sensor, even though no pressure change was imposed in this experiment.

**Readback check.** Content words of six or more letters in key A: convoluted, tubule, presses, against, afferent, arteriole, registering, sodium, chloride, concentration, lumen. None of these appears in the stem, which uses micropuncture, running, through, single, nephron, switched, solution, dissolved, raised, normal, delivered, exactly, previous, within, seconds, vessel, supplying, glomerulus, narrows, filtration, neighbouring, unchanged, structure, responsible, response, register. The stem does contain the four letter word salt, which is unavoidable because the manipulated variable has to be stated, but the key adds the two things the stem never supplies: the anatomical site of the sensor and the compartment it samples. Neither can be produced by restating the stem.

**Explanation (as shipped).**

> This item falls under Organ Systems and tests the position of the tubular salt sensor and the compartment it actually samples. The answer is A because the manipulation was confined to the fluid running through one nephron, so whatever triggered the vascular response must sit where it can sample that fluid at a point past the perfused segment, and the only place the tubule presses against its own supply vessel is where the early distal convoluted tubule contacts the afferent arteriole. The cells there read the salt concentration of the fluid sliding past their apical surface and release local paracrine signals that make the upstream vessel constrict, which lowers filtration in that one nephron. Two features of the result pin the answer down. First, the rate of delivery was deliberately held constant, so a sensor of flow rate had nothing new to detect and the change in salt concentration is the only candidate stimulus. Second, neighbouring nephrons were untouched: a sensor that read the blood, or any signal carried through the circulation, would have acted across the whole organ, whereas a sensor that reads one tubule's own fluid can only act on that tubule's own vessel. This one to one coupling between a single tubule and a single arteriole is the structural signature of the sensor's location. (Choice B) A sensor bathed by blood in the arteriole wall would be sampling a compartment that was never altered, and it could not explain why the effect was restricted to the perfused nephron rather than spread across the kidney. (Choice C) The capsular lining surrounds the filtration barrier and sits upstream of the perfused segment, so it cannot register a change generated further along the tubule, and the entry rate of filtrate was not what the investigator manipulated. (Choice D) The location here is right but the stimulus is wrong: wall tension is the adequate stimulus for the vessel's own stretch sensitive smooth muscle, a separate mechanism, and nothing in this experiment altered the pressure inside the arteriole, since the trigger originated inside the tubule. This is a Scientific Reasoning and Problem Solving question because it asks the student to work backwards from a deliberately localised experimental result to the anatomical position and the adequate stimulus of the sensor that must have produced it.

---

## Q15 . Isolating the arteriolar myogenic stretch response

**Stem.** A kidney is perfused in place with its nerve supply intact. A pipette allows the fluid inside the tubular segment that lies against one afferent arteriole to be perfused independently, while the pressure inside that arteriole is stepped upward. An investigator wants to show that the smooth muscle of the arteriole shortens as a direct response to being stretched, with no contribution from the salt sensor in the tubule wall and none from any signal originating outside the kidney. Which of the following steps are required?

I. Perfuse that tubular segment throughout at a fixed rate with a solution of unchanging salt content.
II. Cut the nerves running to the kidney and perfuse it with a fluid free of circulating messengers.
III. Interrupt delivery to that tubular segment entirely, so that nothing passes the sensor during each pressure step.

- **A.** I only
- **B.** II only
- **C.** I and II only  <- **KEY**
- **D.** I, II, and III

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **hard** (topic secondary / structural multi_step) |
| Estimated time | 100 s |
| Confidence | 4 |
| Hard-tier gate | (a) it combines two separate concepts, the vessel wall's intrinsic stretch response and the competing tubular salt sensing route, and requires the student to hold both in mind at once; (c) options A and D remain defensible until the student applies the specific facts that nerves and circulating signals are a distinct confound and that cutting delivery to zero drives the tubular sensor rather than silencing it. |

**Correct answer (C): I and II only**

Citations: AP:53422, AP:53423, AP:53426, AP:53440

**Distractors**

- **(A)** `partial_truth` . _a necessary control mistaken for a sufficient one_: Fixing the fluid delivered to the tubular sensor is genuinely required, but on its own it leaves the intact nerves and the perfusing fluid as untested alternative causes of constriction.
- **(B)** `partial_truth` . _the external control alone_: Excluding nerves and circulating messengers is required but does not address the sensor sitting in the tubule wall, which can drive the same arteriole in this preparation.
- **(D)** `misconception` . _belief that more manipulation always means better control_: Cutting delivery to zero is not a neutral setting for the tubular sensor: minimal salt arriving at it reduces its constricting signal and dilates the same arteriole, so step III replaces a held constant with a strong one way push.

**Readback check.** The key is the label 'I and II only' and contains no content words of six or more letters, so no stem echo is possible. The Roman numeral statements are the reasoning material, and none of them restates a stem fact: the student must judge each against the stated goal of excluding two named confounds, and must supply from knowledge the fact that zero salt delivery is itself a signal to the tubular sensor.

**Explanation (as shipped).**

> This item falls under Organ Systems and tests how to isolate the vessel wall's own stretch response from the other influences that converge on the same arteriole. The answer is C because a clean demonstration requires silencing every alternative source of constriction while leaving stretch as the only thing that varies, and steps I and II do exactly that while step III reintroduces the very influence the design is meant to remove. Statement I is required because the tubular sensor responds to the salt concentration and the flow rate of the fluid passing it, so holding both fixed guarantees that any narrowing seen after a pressure step cannot have come from that route. Statement II is required because the preparation still carries its nerves and is still perfused, so a constriction could otherwise be attributed to a command arriving from outside the organ rather than to the wall itself. Statement III is not required and is actively harmful: when almost no salt reaches that sensor it releases less of its constricting paracrine signal and the same arteriole dilates, so cutting delivery to zero does not silence the tubular route but drives it hard in one direction, and it destroys the very constancy that statement I was included to create. With I and II in place, the pressure step becomes the only manipulated variable and the wall's shortening can be attributed to stretch alone. (Choice A) Step I alone controls the tubular route but leaves nerves and circulating signals free to act on the same vessel, so a constriction could still have an origin outside the kidney. (Choice B) Step II alone excludes outside signals but leaves the tubular sensor free to respond to whatever the pressure step does to delivery along the nephron, which is a serious confound in this preparation. (Choice D) Adding step III swings the tubular sensor to one extreme instead of holding it still, so including it weakens rather than strengthens the design. This is a Reasoning about the Design and Execution of Research question because it asks the student to decide which controls are necessary to attribute an observed constriction to stretch of the vessel wall rather than to a competing sensor or to a signal arriving from outside the organ.

---

## Q16 . Dialysate composition and gradient design

**Stem.** A haemodialysis circuit runs a patient's blood along one face of a membrane that passes small solutes but holds back proteins and cells, with a prepared bath flowing along the other face. The bath is matched to plasma for sodium, bicarbonate and calcium, and holds no urea, but because of an error during preparation it also holds no glucose. What is the most likely result over a four hour run?

- **A.** Waste clearance speeds up, because the lighter solute load in the bath steepens every outward gradient.
- **B.** Nothing measurable happens, because a membrane sized to pass small wastes will not admit a particle of that size.
- **C.** The patient's circulating fluid falls sharply as water is dragged into the bath behind the absent solute.
- **D.** Blood sugar drops, since nothing on the far side opposes its outward diffusion.  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic peripheral / structural two_step) |
| Estimated time | 80 s |
| Confidence | 4 |

**Correct answer (D): Blood sugar drops, since nothing on the far side opposes its outward diffusion.**

Citations: BIO:54459, BIO:54460, BIO:54462

**Distractors**

- **(A)** `misconception` . _belief that total solute load rather than per solute gradient drives clearance_: Diffusion of each solute follows its own gradient, and urea's gradient was already maximal because the bath contained none, so removing an unrelated solute cannot accelerate its clearance.
- **(B)** `misconception` . _size exclusion invoked against the stated membrane property_: The stem specifies that small solutes cross, and the omitted substance is in that size class, so invoking exclusion contradicts the described barrier.
- **(C)** `scale_unit_error` . _correct osmotic direction at a wildly inflated magnitude_: One missing small solute contributes only a small share of plasma osmolarity, so the water shift it drives is minor and cannot be the dominant consequence of the error.

**Readback check.** Content words of six or more letters in key D: nothing, opposes, outward, diffusion. None appears in the stem, which uses haemodialysis, circuit, patient, membrane, passes, solutes, proteins, prepared, flowing, matched, plasma, sodium, bicarbonate, calcium, holds, error, during, preparation, glucose, likely, result. The key deliberately avoids repeating the word the stem uses for the omitted solute, and the answer cannot be produced by restatement: the student must supply the idea that a bath fixes an independent gradient for each crossable solute and that a zero concentration therefore behaves like a waste sink.

**Explanation (as shipped).**

> This item falls under Organ Systems and tests the logic behind the composition of the fluid on the far side of an artificial filtering membrane. The answer is D because a bath sets an independent gradient for every solute small enough to cross, and a solute held at zero on one side will move down its gradient until the two sides converge. The design principle is therefore symmetric in two directions. Substances the treatment is meant to remove, such as urea, are left out of the bath so that their gradient points steadily outward across the whole run. Substances the patient must keep, such as sodium, bicarbonate and calcium, are supplied at plasma levels so that their gradient is flat and no net movement occurs. Sugar belongs firmly in the second group, since it is small enough to cross freely, so omitting it turns a solute meant to be preserved into one that is removed exactly as if it were a waste product. Over hours of continuous exposure to a large volume of bath, that loss can become clinically serious rather than trivial. (Choice A) A bath carrying fewer solutes does not steepen the gradient for urea, because urea was already absent from the bath and its gradient was already maximal, so leaving out an unrelated substance cannot improve waste removal. (Choice B) The membrane is described as passing small solutes, and sugar is in that size class, so appealing to exclusion by size contradicts the stated property of the barrier. (Choice C) The osmotic pull created by one missing small solute is a tiny fraction of total plasma osmolarity, so the reasoning about direction is right but the predicted magnitude is far too large to describe the dominant outcome. This is a Scientific Reasoning and Problem Solving question because it asks the student to reason from the composition of a bath to the direction of net movement for each solute and then predict the consequence of a single omission.

---

## Q17 . Isosmotic bulk reabsorption in proximal tubule

**Stem.** In an isolated perfused kidney, the water channels lining the proximal convoluted tubule are blocked while sodium reabsorption there proceeds at its usual rate. Fluid is sampled at the point where that segment ends. How does that sample compare with fluid sampled at the same point in an untreated kidney?

- **A.** Iso-osmotic with blood, with flow above baseline
- **B.** Hypo-osmotic to blood, with flow above baseline  <- **KEY**
- **C.** Hyper-osmotic to blood, with flow above baseline
- **D.** Hypo-osmotic to blood, with flow at baseline

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 85 s |
| Confidence | 5 |

**Correct answer (B): Hypo-osmotic to blood, with flow above baseline**

Citations: AP:53135, AP:53165, AP:53195, BIO:54594

**Distractors**

- **(A)** `misconception`: Treats matched particle concentration as an intrinsic feature of the segment rather than a consequence of the water permeability the experiment abolishes, even while correctly raising the flow.
  - Citation: AP:53135
- **(C)** `reversed_relationship`: Concentration could only rise if water outran solute out of the lumen, the opposite of what a water-channel block produces.
  - Citation: AP:53195
- **(D)** `partial_truth`: Correctly infers dilution but ignores that unrecovered water must remain in the lumen and therefore raise the flow leaving the segment.
  - Citation: AP:53165

**Readback check.** Content words of six or more letters in key B: osmotic (within hypo-osmotic), baseline. Neither appears in the stem. Stem content words of six or more letters are isolated, perfused, kidney, channels, lining, proximal, convoluted, tubule, blocked, sodium, reabsorption, proceeds, sampled, segment, compare, untreated. No overlap with the key, and the key cannot be produced by restating any stem phrase because the stem never states what happens to concentration or to flow. All four choices share the same two-part grammar, so no choice is distinguishable by length or wording alone.

**Explanation (as shipped).**

> This Organ Systems item tests how the first stretch of the nephron reclaims a large share of what is filtered while handing on fluid whose particle concentration is unchanged, and what breaks when solute movement and water movement are uncoupled. The answer is B because sodium and the solutes carried alongside it keep leaving the lumen while water is prevented from following, so the fluid passed downstream is both dilute and larger in amount than usual. In an intact kidney this segment is unusually leaky to water, so each particle pumped into the surrounding interstitium is followed almost immediately by enough water to keep the two compartments matched. That tight coupling is why roughly two thirds of the filtered fluid can be recovered here without the remaining stream becoming any more or any less concentrated than blood. Once the water route is shut, the coupling fails: pumping continues, particles leave, but the water they would have dragged with them stays behind. The residual stream therefore holds fewer particles dispersed through nearly the original quantity of water, which is a dilute fluid arriving downstream at an elevated rate.
>
> (Choice A) This correctly anticipates the extra volume but keeps the concentration matched to blood. Matched concentration is not a fixed property of the segment; it is a consequence of the high water permeability that the experiment abolishes, so once water cannot follow the departing solute the remaining fluid must fall below blood in concentration.
>
> (Choice C) This reverses the direction of the change. Concentration would rise only if water left faster than particles did, which is what happens in a water-permeable stretch sitting in a salty interstitium, not in a segment whose water route has been closed while pumping continues.
>
> (Choice D) The dilution is right, but the flow is not. Every unit of water that fails to be recovered here stays in the lumen, so the quantity moving on must rise; a normal flow would imply water was still leaving despite the block.
>
> This is a Scientific Reasoning and Problem Solving question because the student must predict two linked downstream measurements, concentration and flow, from a single experimental lesion rather than recall what the segment normally does.

---

## Q18 . Filtered load sets urinary appearance

**Stem.** Substance Z is freely filtered at the glomerulus and is reclaimed by proximal carriers that together can move no more than 300 mg per minute. In subject J the blood level of Z is 250 mg/dL and the filtration rate is 90 mL/min, while in subject K, who is hyperfiltering, the blood level is 175 mg/dL and the filtration rate is 180 mL/min. In which subject or subjects does Z appear in the urine?

- **A.** J only
- **B.** Both J and K
- **C.** Neither J nor K
- **D.** K only  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 105 s |
| Confidence | 5 |
| Hard-tier gate | (a) combines filtered load with a saturable reclaiming ceiling; (b) requires a unit conversion plus two quantitative comparisons against that ceiling; (d) inverts the usual reasoning direction, since the subject with the higher blood concentration is the one that spills nothing. |

**Correct answer (D): K only**

Citations: AP:52776, AP:53165, BIO:54635

**Distractors**

- **(A)** `misconception`: Assumes the higher blood level determines urinary appearance, ignoring that the quantity presented to the carriers depends equally on the filtration rate.
  - Citation: AP:52776
- **(B)** `scale_unit_error`: Multiplies mg/dL by mL/min without converting, inflating both deliveries one hundredfold so that each appears to exceed the ceiling.
  - Citation: AP:53165
- **(C)** `partial_truth`: Recognizes the ceiling and rejects concentration as decisive, but fails to see that a doubled filtration rate can carry a lower concentration past that ceiling.
  - Citation: AP:52776

**Readback check.** Key D is the bare label 'K only' and contains no content word of six or more letters, so stem echo is structurally impossible. None of the four choices carries content vocabulary; the discrimination is entirely arithmetic. The stem never states either delivery rate and never states whether the ceiling is exceeded, so no phrase can be copied out of the stem to reach the key.

**Explanation (as shipped).**

> This Organ Systems item tests the quantity that actually reaches the carriers each minute, which is the product of the filtration rate and the blood level, and why that product rather than the blood level alone decides what ends up in urine. The answer is D because K delivers 315 mg of Z to the tubule every minute against a reclaiming ceiling of 300 mg per minute, while J delivers only 225 mg per minute and so loses none. Converting units first, 250 mg/dL is 2.5 mg/mL, and 2.5 multiplied by 90 gives 225 mg per minute for J. For K, 175 mg/dL is 1.75 mg/mL, and 1.75 multiplied by 180 gives 315 mg per minute. Everything up to the ceiling is pulled back, so J's entire delivery is recovered and K's excess of 15 mg per minute has nowhere to go but the urine. The instructive point is that the subject with the higher blood level spills nothing: doubling the rate at which plasma is strained more than compensates for a lower concentration, so the delivered quantity, not the concentration, is what the carriers actually face.
>
> (Choice A) This picks the subject with the higher blood level and stops there. Concentration alone says nothing about how many milligrams arrive per minute, and J's low filtration rate keeps the delivery comfortably under the ceiling.
>
> (Choice B) This follows from multiplying the given numbers without converting deciliters to milliliters, which inflates both deliveries by a factor of one hundred and puts each of them far above the ceiling. Checking that the answer has a plausible magnitude catches the slip.
>
> (Choice C) This is right that a ceiling exists and right that a raised blood level does not by itself force spillage, but it misses that the filtration rate is the other multiplier. A high enough filtration rate can push a modest concentration past the ceiling, which is exactly K's situation.
>
> This is a Scientific Reasoning and Problem Solving question because the student must convert units, compute two delivery rates, compare each against a fixed ceiling, and resist the intuition that the higher blood level identifies the spiller.

---

## Q19 . Proximal secretion adds to what is filtered

**Stem.** A small drug that does not bind plasma proteins passes freely into the filtrate at the glomerulus. In a steady state, the amount of drug leaving in the urine each minute is measured and found to be well above the amount entering the nephron in the filtrate each minute. Which handling step accounts for that difference?

- **A.** Cells of the proximal tubule move the drug out of the surrounding interstitial fluid and into the lumen  <- **KEY**
- **B.** The drug travels the whole length of the tubule untouched, so everything strained out simply continues onward
- **C.** Carriers pull the drug back out of the lumen, but they work at a fixed ceiling that the drug exceeds
- **D.** Water recovery downstream concentrates the drug in the urine, which raises the amount leaving each minute

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 60 s |
| Confidence | 5 |

**Correct answer (A): Cells of the proximal tubule move the drug out of the surrounding interstitial fluid and into the lumen**

Citations: AP:53713, AP:52685, BIO:54636

**Distractors**

- **(B)** `adjacent_fact`: Describes a real handling pattern, the untouched marker, but that pattern yields urinary output equal to the strained amount and so cannot produce the observed surplus.
  - Citation: BIO:54636
- **(C)** `reversed_relationship`: Runs transport the wrong way: recovery from the lumen can only lower urinary output, so a saturated recovery carrier still cannot push output above what was strained out.
  - Citation: AP:53165
- **(D)** `scale_unit_error`: Confuses concentration with amount per minute; removing water raises milligrams per milliliter while leaving milligrams per minute unchanged.
  - Citation: AP:53195

**Readback check.** Content words of six or more letters in key A: proximal, tubule, surrounding, interstitial. None appears in the stem, whose content words of six or more letters are plasma, proteins, passes, freely, filtrate, glomerulus, steady, amount, leaving, minute, measured, entering, nephron, handling, accounts, difference. The stem states only that urinary output exceeds what enters the filtrate; it never names a direction of transport, so the key must be inferred from the bookkeeping rather than copied. All four choices are full clauses of comparable length.

**Explanation (as shipped).**

> This Organ Systems item tests the three-way bookkeeping of the nephron, in which what leaves in the urine equals what is strained out, plus whatever the tubule adds to the lumen, minus whatever the tubule pulls back. The answer is A because the only step that can raise the urinary amount above the amount strained out is transport in the opposite direction, from the blood and interstitial fluid beside the tubule into the lumen, and the proximal tubule carries the carrier systems that do this for foreign compounds such as drugs. Straining at the glomerulus sets an upper limit on how much can reach the lumen that way, so no amount of straining alone explains the excess. Pulling material back out of the lumen can only lower the urinary amount, never raise it. That leaves addition to the lumen as the only possibility, and the excess measured is exactly the amount added.
>
> (Choice B) A substance that is strained out and then ignored by the tubule leaves in the urine at the same rate at which it enters the filtrate, not at a higher rate. This describes the ideal marker used to gauge the straining rate itself, which is precisely why it cannot account for a surplus.
>
> (Choice C) This runs the transport in the wrong direction. Carriers that recover material from the lumen subtract from the urinary amount, so even carriers working flat out at their ceiling can at best let the strained amount through untouched and can never push the urinary amount above it.
>
> (Choice D) This confuses how concentrated the urine is with how much drug leaves per minute. Recovering water downstream packs the same quantity of drug into a smaller volume, raising its concentration while leaving the milligrams per minute unchanged, so it cannot create the surplus.
>
> This is a Knowledge of Scientific Concepts and Principles question because the student must apply the standing relationship among straining, addition to the lumen and recovery from the lumen to decide which of the three steps can make urinary output exceed what was strained out.

---

## Q20 . Osmotic diuresis from unreabsorbed solute

**Stem.** A sugar that the tubule cannot pull back out of the forming urine is infused into a vein in anesthetized rats over thirty minutes, and urine flow climbs to roughly three times its starting value. The investigators conclude that the sugar stays in the fluid running down the nephron and holds water there, forcing more urine out. A reviewer replies that the infusion itself delivered fluid to the animals and may also have shifted their circulating water-conserving signals, either of which could explain the rise. Which added group would best isolate the mechanism the investigators propose?

- **A.** A group given an equal volume of solute-free water intravenously over the same thirty minutes
- **B.** A group given the same sugar at three rising doses, with urine flow plotted against dose
- **C.** A group given an equal volume of an equally concentrated sugar that the proximal segment recovers completely  <- **KEY**
- **D.** A group deprived of drinking water beforehand, so that water-conserving signals are already maximal when the sugar is given

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **hard** (topic secondary / structural multi_step) |
| Estimated time | 95 s |
| Confidence | 4 |
| Hard-tier gate | (a) combines the physiology of solute-driven water retention in the lumen with the logic of a matched control; (c) choices A and B stay defensible until the discriminating requirement is applied, that a control must match both delivered volume and particle load while varying only recoverability; (d) inverts the usual direction by asking what must be held constant rather than what result is expected. |

**Correct answer (C): A group given an equal volume of an equally concentrated sugar that the proximal segment recovers completely**

Citations: AP:53165, AP:53195, AP:53640, BIO:54635

**Distractors**

- **(A)** `partial_truth`: Matches the delivered fluid quantity but drops the particle load, so it varies two things at once and introduces a second driver of water loss.
  - Citation: AP:53195
- **(B)** `adjacent_fact`: A dose-response curve is a genuine strengthening observation but leaves the delivered fluid and circulating signal confounds untouched at every dose.
  - Citation: AP:53640
- **(D)** `misconception`: Treats maximal water conservation as a way to cancel a confound, when prior deprivation instead shifts the starting flow and the state of the tubule and makes the group baselines incomparable.
  - Citation: AP:53518

**Readback check.** Content words of six or more letters in key C: equally, concentrated, volume, proximal, segment, recovers, completely. None appears in the stem, whose content words of six or more letters are tubule, forming, infused, anesthetized, thirty, minutes, climbs, roughly, starting, investigators, conclude, running, nephron, forcing, reviewer, infusion, delivered, animals, circulating, conserving, signals, explain, isolate, mechanism, propose. The stem says only that the test sugar cannot be pulled back out; it never mentions a recoverable comparator, a matched volume or a matched concentration, so the key cannot be assembled from stem wording.

**Explanation (as shipped).**

> This Organ Systems item tests control design for an experiment on the diuresis caused by a solute that stays in the tubular fluid. The answer is C because it holds the delivered fluid quantity and the particle concentration constant while changing only whether the solute can be taken back out of the lumen, which is the single variable the investigators' explanation rests on. If the sugar is fully recovered in the early tubule, the water it would have held is recovered with it, so urine flow should stay near its starting value despite an identical fluid load. Any rise seen in the treated group but absent in this control cannot be blamed on the delivered fluid, since both groups received the same amount, nor on a general osmotic shift in the circulation, since both loads carried the same particle concentration. What remains as the difference is exactly the claim under test, namely that a solute left behind in the tubular fluid drags water past the recovering segments and out into the urine. A control that changes two things at once cannot do this work, which is what disqualifies the alternatives.
>
> (Choice A) This addresses the delivered fluid but nothing else. Solute-free water lowers the particle concentration of the circulation, which is itself a powerful stimulus for water loss, so this group changes two variables and cannot separate them.
>
> (Choice B) A dose-response relationship strengthens the case that the sugar is responsible, but every dose is still delivered as a fluid load, so the reviewer's objection about delivered fluid and circulating signals applies with equal force at each dose. Showing that more of a confounded treatment produces more of an effect does not remove the confound.
>
> (Choice D) Prior water deprivation loads a second large perturbation onto the design, altering the starting urine flow, the particle concentration of the circulation and the state of the tubule before the sugar even arrives. It also makes the baselines of the two groups incomparable, which is the opposite of what a control is for.
>
> This is a Reasoning about the Design and Execution of Research question because the student must identify which additional group varies only whether the infused solute can be recovered while matching the volume and the particle load that the reviewer flagged as confounds.

---



---

# BATCH 2 of 3 (20 questions): proximal tubule, loop of Henle, concentrating mechanism

## Batch 2 summary

| Metric | Result | Target |
|---|---|---|
| Difficulty | easy 6 . hard 6 . medium 8 | easy 6 . medium 8 . hard 6 |
| Answer letter | A 5 . B 5 . C 5 . D 5 | 5 each |
| Cognitive skill | S1 3 . S2 10 . S3 3 . S4 4 | S1 3 . S2 10 . S3 3 . S4 4 |
| Confidence | conf4 4 . conf5 16 | only 4-5 ship |
| Roman numeral | 3 | 3 |
| Distractor categories | adjacent_fact 7 . misconception 20 . partial_truth 14 . process_step_confusion 6 . reversed_relationship 11 . scale_unit_error 2 | none dominant |
| Em/en dashes | 0 | 0 |

**One duplicate caught and replaced before shipping, the second in this chapter.** Two writers on
different slices both produced a loop-length-multiplies-a-fixed-step question (Q10 as a Roman numeral
item, Q14 as prose over the same 200 mOsm/L single-level premise). Q14 was cut and replaced with the
equilibration-ceiling item: with the water-permeability signal saturated and transit slow, fluid
leaving the duct can approach the deepest surrounding tissue osmolarity (1,200 mOsm/L) but never
exceed it, because equilibration cannot pass the target it equilibrates with. The replacement was
pinned to the retired item exact metadata (answer A, medium, skill 2, same distractor categories),
and post-swap re-verification confirmed all distributions unchanged and the semantic dedup clean.

The writer that produced the duplicate had been briefed to write the dilute-urine item and
substituted its own choice, the third such substitution across Ch10; batch 3 prompts carry the same
stay-inside-your-brief warning batch 2 already carried.

**Boundary scan:** zero boundary terms in any of the 20 keys. No hormone name is the answer to any
question; where the collecting-duct signal is needed it is handed to the student in the stem.

**Adversarial audit:** all 20 re-examined by an independent pass per slice against OpenStax Anatomy
and Physiology 2e.

---

## Q1 . Saturable carrier ceiling and solute spillover

**Stem.** A solute crosses the glomerular filter without restriction and is pulled back out of the lumen by a carrier protein that becomes fully occupied once enough of the solute arrives. An investigator raises the solute's plasma level in steps from zero upward and, at each step, measures how much of the solute leaves the body in urine each minute. Which pattern does that measured output follow as plasma level is raised?

- **A.** Output climbs in direct proportion to plasma level across the entire range, beginning at the very lowest values tested.
- **B.** Output climbs with plasma level at first and then levels off at a fixed ceiling once the carrier is fully occupied.
- **C.** Output stays near zero up to a critical plasma level, then rises along a line whose slope eventually matches the rise in the quantity presented to the nephron.  <- **KEY**
- **D.** Output stays near zero up to a critical plasma level and then holds steady at a fixed rate however high plasma climbs.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 85 s |
| Confidence | 5 |

**Correct answer (C): Output stays near zero up to a critical plasma level, then rises along a line whose slope eventually matches the rise in the quantity presented to the nephron.**

Citations: AP:53166, AP:53168, AP:53170, AP:53172

**Distractors**

- **(A)** `misconception`: Describes a solute that is filtered and never reclaimed, which contradicts the stated presence of a recovery carrier; students who forget the reclamation step choose it.
  - Citation: AP:53166
- **(B)** `adjacent_fact`: States a true saturation curve, but for the wrong quantity: the amount recovered plateaus at the transport ceiling, while the amount voided has no upper bound at all.
  - Citation: AP:53168
- **(D)** `partial_truth`: Gets the threshold right but freezes output afterwards, ignoring that nothing removes the surplus once the carriers are fully engaged and more solute keeps arriving.
  - Citation: AP:53170

**Readback check.** Content words of six or more letters in key C: critical, plasma, matches, quantity, presented, nephron. Only 'plasma' also appears in the stem, and it appears in choices A, B and D as well, so it is not distinctive to the key. The word 'nephron' is absent from the stem. The discriminating content of the key, the parallel slope after the bend, appears nowhere in the stem and must be inferred from the finite capacity statement. No banned readback pattern applies: the stem states a property of the carrier, not the shape of the answer curve.

**Explanation (as shipped).**

> This Organ Systems item tests the ceiling that a saturable reclamation carrier places on tubular recovery and the threshold pattern that ceiling produces. The answer is C because a carrier with a finite number of binding sites removes essentially all of the solute offered to it until those sites are fully engaged, after which every additional molecule that arrives must continue down the tubule and leave the body. Below the critical plasma level, recovery keeps pace with arrival, so output sits at essentially zero and the plot hugs the horizontal axis. Once every site is engaged, recovery is locked at its maximum, a fixed number of molecules per minute that cannot grow no matter how much more arrives. Everything beyond that fixed amount escapes, so what is voided equals what arrives minus a constant, and the voided line therefore climbs with a slope that converges on the slope of the arrival line itself. The finished plot is a flat stretch, a bend at the threshold, and then a rising line running parallel to the amount presented.
>
> (Choice A) A straight proportional rise starting at the very lowest plasma levels describes a solute that crosses the filter and is then ignored by the tubule, the behavior of a marker used to gauge filtration rate. It leaves the reclamation step out of the picture altogether.
>
> (Choice B) A curve that rises and then flattens at a fixed ceiling is a genuine curve, but it belongs to the quantity recovered, not the quantity voided. Recovery is the process with an upper bound; what escapes has none.
>
> (Choice D) This choice correctly places the bend at a critical plasma level but then freezes output there. Nothing clears the surplus once the sites are all engaged, so output cannot remain constant while more and more solute keeps arriving.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to convert a statement about finite carrier capacity into the shape of an excretion curve across a whole range of plasma values.

---

## Q2 . Basolateral pump failure in proximal reabsorption

**Stem.** A toxin is infused into the vessels wrapping the first tubular segment of the nephron, where it shuts down the ATP driven ion pump sitting on the cell membrane that faces the interstitium. Glomerular filtration and every downstream segment are unaffected. What change in the fluid leaving that segment, and in the urine that is eventually voided, follows most directly?

- **A.** Glucose and amino acids escape reclamation there and appear in the voided urine.  <- **KEY**
- **B.** Water recovery proceeds as before, so the volume of fluid handed onward is unchanged.
- **C.** Organic solutes are still recovered, but wastes such as drug metabolites can no longer be added to the lumen and build up in blood.
- **D.** Sodium is driven into the lumen as the pump runs backwards, so the fluid handed onward becomes hypertonic.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 95 s |
| Confidence | 5 |
| Hard-tier gate | Hard on three counts: (a) it combines the energetics of one membrane surface with the reclamation profile of a whole segment; (b) it demands a directional inference about gradient collapse rather than a recalled fact; (c) choices B and C stay defensible until the student applies the discriminating facts that solute withdrawal drives water movement and that lumen secretion shares the same sodium gradient. |

**Correct answer (A): Glucose and amino acids escape reclamation there and appear in the voided urine.**

Citations: AP:53072, AP:53176, AP:53178

**Distractors**

- **(B)** `misconception`: Treats water recovery here as independent of solute recovery; water in fact follows the osmotic gradient that solute withdrawal creates, so the volume handed onward rises.
  - Citation: AP:53195
- **(C)** `reversed_relationship`: Reverses which function survives: it spares the coupled reclamation that actually fails and abolishes the lumen secretion that leans on the very same sodium gradient.
  - Citation: AP:53715
- **(D)** `process_step_confusion`: Turns a stopped pump into a reversed one and has sodium driven into the lumen, when a poisoned pump simply ceases to move ions and no reversal of flux occurs.
  - Citation: AP:53178

**Readback check.** Content words of six or more letters in key A: Glucose, escape, reclamation, appear, voided. None appears anywhere in the stem, which speaks only of a toxin, vessels, a pump, a membrane, the interstitium, filtration and downstream segments. The identity of the lost solutes is never hinted at and must be supplied by the student. The stem names a pump location but not what depends on it, so this is not a label lookup.

**Explanation (as shipped).**

> This Organ Systems item tests how the energy supply on the blood facing surface of a tubule cell sets what that segment can reclaim. The answer is A because the pump on that surface is what holds sodium inside the cell at a low level, and that low internal sodium is what makes sodium flow inward from the lumen and drag glucose and amino acids in with it. Shut the pump down and cell sodium rises within minutes, the inward gradient collapses, and the coupled uptake of organic solutes at the lumen facing surface stalls. Those solutes stay in the fluid, and because no later stretch of the nephron carries machinery to recover them, they travel the whole length of the tubule and leave the body. The recognizable picture is sugar and amino acids in a urine sample that normally contains neither, with the plasma levels of both entirely ordinary.
>
> (Choice B) Water follows solute osmotically in this segment rather than being moved on its own. When solute recovery falls, the osmotic pull weakens and more water stays in the lumen, so the volume handed onward rises rather than staying fixed.
>
> (Choice C) This inverts which job survives. Adding wastes to the lumen and recovering organic solutes both lean on the same sodium gradient, so neither is spared, and the choice describes only the process the question did not ask about.
>
> (Choice D) The pump does not reverse and pour sodium into the lumen. It simply stops, and the fluid handed onward is left richer in the solutes that were never withdrawn rather than turning hypertonic through added sodium.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to trace a single energetic failure at one membrane surface through to the specific substances that show up in a urine sample.

---

## Q3 . Composition of fluid leaving the proximal tubule

**Stem.** A physiologist samples tubular fluid at the very end of the first tubular segment of the nephron in a healthy person and compares that sample with the filtrate that entered the segment.

I. The volume passing the sampling point each minute is markedly smaller than the volume that entered
II. The osmolarity of the sample is close to that of the plasma from which the filtrate was formed
III. The sodium concentration of the sample is markedly lower than that of the entering filtrate

Which of the above will be observed?

- **A.** I only
- **B.** II and III only
- **C.** I and III only
- **D.** I and II only  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 70 s |
| Confidence | 5 |

**Correct answer (D): I and II only**

Citations: AP:53165, AP:53195, AP:53196

**Distractors**

- **(A)** `partial_truth`: Correct that volume falls but wrong to reject item II; it implies solute is removed without water, which would dilute the fluid rather than leave it near plasma osmolarity.
  - Citation: AP:53196
- **(B)** `misconception`: Denies the large fall in volume even though most of the filtered water is reclaimed in this segment, and accepts the false sodium statement as well.
  - Citation: AP:53165
- **(C)** `process_step_confusion`: Treats sodium reclamation as running ahead of water reclamation, when the two proceed in nearly equal proportion so the sodium concentration is left essentially unchanged.
  - Citation: AP:53165

**Readback check.** Content words of six or more letters in the keyed items I and II: volume, passing, sampling, markedly, smaller, entered, osmolarity, sample, plasma, filtrate, formed. The stem supplies physiologist, tubular, segment, nephron, healthy, person, compares, filtrate, entered. Only 'filtrate' and 'entered' are shared, and both also appear in the unkeyed item III, so neither is distinctive to the key. The discriminating facts, that volume falls sharply while osmolarity and sodium concentration do not, appear nowhere in the stem.

**Explanation (as shipped).**

> This Organ Systems item tests what the first stretch of tubule does to the volume, the tonicity and the sodium content of the fluid it passes onward. The answer is D because items I and II both describe that fluid correctly while item III does not. Roughly two thirds of the filtered water and of the filtered sodium are reclaimed before the fluid reaches the loop, so the volume arriving at the sampling point each minute is far smaller than the volume that entered, which makes item I correct. This segment is also freely permeable to water, so water follows the reclaimed solute out almost as fast as the solute leaves and the fluid never gets a chance to become dilute or concentrated. Its osmolarity therefore stays close to that of the plasma it came from, which makes item II correct. Item III fails for the same reason: sodium and water leave in nearly the same proportion, so what remains carries close to the sodium concentration it started with even though far less of it is left.
>
> (Choice A) This accepts the fall in volume but rejects the matching osmolarity, implying the segment strips solute while leaving water behind. That would hand on a dilute fluid, which is not what a freely water permeable epithelium produces.
>
> (Choice B) This drops the volume statement, yet a segment that reclaims most of the filtered water must pass on a much smaller volume each minute than it received.
>
> (Choice C) This accepts item III, treating sodium as though it were withdrawn ahead of water. Here the two leave together, so the sodium concentration barely moves.
>
> This is a Knowledge of Scientific Concepts and Principles question because it asks the student to state the volume, the osmolarity and the sodium concentration of fluid leaving the proximal tubule from recall of what that segment reclaims.

---

## Q4 . Distinguishing tubular secretion from tubular reabsorption for a test solute

**Stem.** A laboratory has made a new compound and needs to know whether the nephron adds it to the tubular fluid, removes it from the tubular fluid, or leaves it alone. The compound is small, uncharged, does not bind plasma proteins, and crosses the glomerular filter without restriction. The laboratory also holds a second substance that crosses the filter just as freely and is known to be neither added nor removed at any point along the nephron. Both can be infused to steady plasma levels and measured in plasma and in urine. Which comparison would settle the question most directly?

- **A.** The compound's concentration in urine against its concentration in plasma, treating a higher urinary value as evidence that the tubule added it.
- **B.** The volume of plasma freed of the compound each minute against the volume freed of the second substance each minute, treating a larger value as addition and a smaller value as removal.  <- **KEY**
- **C.** The compound's urinary output each minute before and after its plasma level is raised, treating a rise in output as evidence that the tubule added it.
- **D.** The mass of the compound appearing in urine over an hour against the mass of the second substance appearing over the same hour, treating the larger mass as evidence that the tubule added the compound.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **medium** (topic secondary / structural multi_step) |
| Estimated time | 100 s |
| Confidence | 5 |

**Correct answer (B): The volume of plasma freed of the compound each minute against the volume freed of the second substance each minute, treating a larger value as addition and a smaller value as removal.**

Citations: AP:52905, AP:52906, AP:53713, AP:53715

**Distractors**

- **(A)** `misconception`: Reads a urine to plasma concentration ratio as proof of tubular addition, ignoring that heavy water reclamation concentrates every solute in urine, including one the tubule never touches.
  - Citation: AP:53195
- **(C)** `partial_truth`: The predicted rise in output does occur, but it follows from the larger filtered load alone and so cannot distinguish addition, removal or indifference without a reference substance.
  - Citation: AP:52906
- **(D)** `scale_unit_error`: Compares raw masses excreted when the two substances were infused at unrelated doses; the amounts must be scaled to each substance's filtered load before any comparison is meaningful.
  - Citation: AP:52905

**Readback check.** Content words of six or more letters in key B: volume, plasma, compound, minute, against, second, substance, treating, larger, addition, smaller, removal. The stem contributes plasma, compound, second, substance, and each of those also appears in at least one unkeyed choice, so none is distinctive to the key. The discriminating element, normalising each substance to the volume of plasma cleared per minute and comparing it against the untouched reference, is stated nowhere in the stem and must be constructed by the student.

**Explanation (as shipped).**

> This Organ Systems item tests the design logic that separates what the tubule does to a substance from what filtration alone would already do to it. The answer is B because the volume of plasma freed of a substance each minute is the one measure that can be set directly against a reference substance the tubule never touches. That reference is removed from exactly the volume of plasma that gets filtered, so it supplies the yardstick the comparison needs. If the new compound is freed from a larger volume of plasma each minute than the reference, the nephron must be putting extra molecules into the lumen; if from a smaller volume, molecules must be coming back out of the lumen; and if the two match, the tubule is leaving the compound alone. Because both substances cross the filter equally freely, every difference between them belongs to what happens after filtration, which is precisely what was asked. The comparison also survives changes in urine flow and in the doses infused, since those influences act on both substances alike and cancel when the two are measured side by side in the same subject.
>
> (Choice A) Urine is a concentrated fluid because most of the filtered water is reclaimed on the way through. Even the untouched reference substance ends up many times more concentrated in urine than in plasma, so a high urinary concentration on its own says nothing about whether the tubule added anything.
>
> (Choice C) Raising the plasma level raises the amount delivered to the filter, and urinary output rises with it whatever the tubule is doing. The observation is real but it cannot separate addition from removal from indifference, because no reference is involved.
>
> (Choice D) The two substances are infused independently, so the masses recovered in urine reflect the doses chosen rather than the tubule's handling. Absolute amounts have to be scaled to how much of each was filtered before they can be set against one another at all.
>
> This is a Reasoning about the Design and Execution of Research question because it asks the student to choose, among four measurable comparisons, the one whose built in reference substance isolates what the tubule does from what the filter does.

---

## Q5 . Why regulated water exit comes last

**Stem.** In a hypothetical kidney, the tubule region whose water permeability can be turned on or off is repositioned so that fluid passes through it first, and the fluid then flows through a region that is always freely water permeable and that runs deep through the medulla before draining to the bladder. The medullary osmotic gradient and every transport protein are unchanged. What is the consequence for this kidney?

- **A.** Output would become permanently watery, since water could no longer be recovered anywhere past the loop.
- **B.** Regulation would be preserved, since the total water recovered along the whole tubule is unchanged.
- **C.** Urine osmolarity would be locked near that of the deep interstitium, leaving output volume essentially fixed.  <- **KEY**
- **D.** The medullary gradient would dissipate, since the hairpin geometry of the loop has been reversed.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 105 s |
| Confidence | 4 |
| Hard-tier gate | (a) combines two concepts, the fixed versus adjustable water permeability of different tubule stretches and the effect of serial ordering on a final output; (c) choices A and D each name a real renal phenomenon and stay defensible until the student applies the specific fact that the terminal stretch equilibrates with the medullary interstitium; (d) inverts the usual direction, giving a rearranged design and asking for the physiological outcome rather than asking for the normal order. |

**Correct answer (C): Urine osmolarity would be locked near that of the deep interstitium, leaving output volume essentially fixed.**

Citations: AP:53222, AP:53296, AP:53620, BIO:54642

**Distractors**

- **(A)** `reversed_relationship`: Reverses the direction of water movement in the terminal stretch. Because that stretch runs through hyperosmotic medulla, water leaves the fluid there, so output would be concentrated rather than watery.
  - Citation: AP:53295
- **(B)** `misconception`: Treats total water reabsorbed as the regulated variable. Even with unchanged total recovery, the ability to vary output from hour to hour is lost, and that variability is what the arrangement provides.
  - Citation: AP:53620
- **(D)** `adjacent_fact`: Invokes a real phenomenon, collapse of the medullary gradient, that the redesign does not cause. The hairpin and the transport that build the gradient are untouched, and the stem states the gradient is intact.
  - Citation: AP:53216

**Readback check.** Key content words of six or more letters: osmolarity, locked, interstitium, leaving, output, volume, essentially. None of these appears in the stem, whose long content words are hypothetical, kidney, tubule, region, permeability, turned, repositioned, through, always, freely, permeable, medulla, before, draining, bladder, medullary, osmotic, gradient, transport, protein, unchanged, consequence. No overlap, and the key cannot be produced by restating the stem: the stem gives an arrangement and the key states an unstated functional loss.

**Explanation (as shipped).**

> This Organ Systems item tests how fixed and adjustable water exit are arranged in series along the tubule, and what that arrangement buys the kidney. The answer is C because the last stretch of tubule the fluid passes through sets the final concentration, and a stretch that always lets water follow the surrounding gradient will pull its contents toward equilibrium with the deep interstitium every single time. Once that equilibration happens, whatever concentration the fluid carried when it arrived is erased, so turning the earlier region on or off changes nothing about what reaches the bladder. Output volume then becomes little more than the daily solute load divided by one fixed concentration. The real tubule is arranged the other way round: the stretch that is always open to water sits early, and the stretch whose permeability can be switched sits at the very end, so it has the last word on how much water leaves. That ordering is what lets one animal void a large volume of watery urine in the morning and a small volume of highly concentrated urine that evening using the identical set of transporters. The redesigned tubule keeps every transport protein and the medullary gradient intact and still loses all flexibility of output, which shows that the flexibility lives in the sequence rather than in the parts.
>
> (Choice A) This runs water the wrong way. The terminal stretch in the redesigned tubule passes through hyperosmotic medulla, so water leaves the fluid there instead of being trapped inside it, and the product would be concentrated rather than watery.
>
> (Choice B) Total water recovered is not the quantity that matters here. Even if the same volume were reclaimed overall, the animal would have lost the ability to change that volume from hour to hour, and adjustability, not total recovery, is what the arrangement exists to provide.
>
> (Choice D) Nothing in the redesign alters the hairpin geometry or the transport that builds the medullary gradient, and the stem states that the gradient is intact. Naming a collapsed gradient identifies the wrong failure: the machinery still works, but its product can no longer be tuned.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to predict the functional consequence of reordering two tubule regions rather than to recall their normal sequence.

---

## Q6 . Nitrogen waste toxicity versus water cost

**Stem.** A freshwater fish and a desert rodent catabolize dietary protein at similar rates. The fish releases its waste nitrogen in the cheapest chemical form directly across its gills, while the rodent expends ATP converting the same waste into a chemically different form before excreting it. The rodent's conversion is favored in its habitat mainly because:

- **A.** its product is tolerated at far higher concentrations, so the same load leaves in much less water.  <- **KEY**
- **B.** the conversion also recovers usable energy from the carbon skeleton of the amino acids.
- **C.** its product crosses cell membranes more freely, which speeds its removal from blood.
- **D.** its product is nearly insoluble and is voided as a paste with almost no water.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 70 s |
| Confidence | 5 |

**Correct answer (A): its product is tolerated at far higher concentrations, so the same load leaves in much less water.**

Citations: BIO:54847, BIO:54848, BIO:54851

**Distractors**

- **(B)** `misconception`: Claims the detoxification step yields energy. It consumes ATP; energy capture from the carbon skeleton happens in a separate earlier step after the amino group is removed.
  - Citation: BIO:54857
- **(C)** `reversed_relationship`: Assigns easy membrane permeation to the detoxified product. Ready diffusion into cells belongs to the cheap toxic form and is part of why it is damaging, and speed of clearance is not the constraint in a dry habitat.
  - Citation: BIO:54847
- **(D)** `adjacent_fact`: Describes the insoluble paste strategy of birds, reptiles and many terrestrial invertebrates, which is true of those groups but not of a mammal excreting waste dissolved in urine.
  - Citation: BIO:54852

**Readback check.** Key content words of six or more letters: product, tolerated, higher, concentrations, leaves. None appears in the stem, whose long content words are freshwater, desert, rodent, catabolize, dietary, protein, similar, releases, nitrogen, cheapest, chemical, directly, expends, converting, chemically, different, before, excreting, conversion, favored, habitat. No overlap, and the stem never states or defines the water cost of disposal, so the key requires an inference about why the energetic expense pays off.

**Explanation (as shipped).**

> This Organ Systems item tests the trade off that governs how animals package waste for disposal. The answer is A because the detoxified product can accumulate in body fluid to concentrations that would be lethal if the cheap form reached them, and that tolerance is what allows a fixed daily load to be voided in a small volume of urine rather than a flood. The cheap form is a base that raises the pH of body fluid and disturbs cells at very low concentrations, so an animal that keeps it must continuously flush it away with large quantities of fluid. A fish sitting in fresh water has an unlimited flushing medium on the other side of its gills and pays nothing for it. A desert mammal does not, so it spends ATP up front to make something it can carry safely at high concentration, and it recovers that cost many times over in fluid it does not have to drink and then void. Toxicity and water cost are two sides of one problem: the more damaging a waste is at a given concentration, the more solvent must be dedicated to keeping it dilute, and solvent is the resource a land animal cannot spare.
>
> (Choice B) The conversion consumes ATP rather than yielding it. Usable energy is harvested earlier, from the carbon skeleton left after the amino group is stripped off, and that step is entirely separate from the detoxification being described.
>
> (Choice C) This reverses the permeability relationship. The cheap form is a small uncharged molecule that slips across membranes into cells, which is a large part of why it is damaging, and in any case faster clearance from blood would do nothing about the volume of fluid needed to carry a day's nitrogen out of the body.
>
> (Choice D) A nearly insoluble waste voided as a paste describes the strategy of birds, reptiles and many terrestrial invertebrates, which conserves even more fluid but costs still more energy. Mammals do not use it, and the stem describes an animal that excretes its waste dissolved in urine.
>
> This is a Knowledge of Scientific Concepts and Principles question because it asks the student to state why detoxifying waste before excretion is worth its energetic cost in a habitat where water is scarce.

---

## Q7 . Descending limb volume loss at constant solute

**Stem.** Tubular fluid is drawn from the start of the loop of Henle and from its deepest point in the medulla of a rat deprived of drinking water overnight. Osmolarity at the deep site is about four times that at the start. Compared with the first sample, the deep sample most likely contains:

- **A.** roughly the same volume of fluid carrying about four times as much sodium.
- **B.** a smaller volume of fluid carrying proportionally less sodium.
- **C.** a smaller volume of fluid concentrated by sodium pumped in from the surrounding tissue.
- **D.** a smaller volume of fluid carrying nearly the same quantity of sodium.  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic core / structural two_step) |
| Estimated time | 80 s |
| Confidence | 5 |

**Correct answer (D): a smaller volume of fluid carrying nearly the same quantity of sodium.**

Citations: AP:53216, AP:53222, BIO:54638

**Distractors**

- **(A)** `reversed_relationship`: Explains the concentration rise by solute gain at constant volume, the reverse of what happens. Salt is not driven into this stretch from the interstitium against its gradient.
  - Citation: AP:53222
- **(B)** `misconception`: Assumes salt leaves along with the water. Proportional loss of both would keep the fluid isosmotic and no fourfold rise could be measured; that pattern belongs to the proximal tubule.
  - Citation: AP:53216
- **(C)** `process_step_confusion`: Places the active sodium pumping step in the wrong stretch and runs it in the wrong direction; that transport sits in the thick ascending limb and moves sodium out of the tubule.
  - Citation: AP:53298

**Readback check.** Key content words of six or more letters: smaller, volume, carrying, nearly, quantity, sodium. None appears in the stem, whose long content words are Tubular, drawn, deepest, medulla, deprived, drinking, overnight, Osmolarity, times, Compared, sample, likely, contains. No overlap. The stem supplies only a concentration ratio, so the key must be derived rather than read off, and no rule about permeability is stated in the stem for the key to echo.

**Explanation (as shipped).**

> This Organ Systems item tests what follows from a tubule wall that is open to water but closed to salt. The answer is D because the dominant event in this stretch is departure of water, so the solute already present stays behind and simply ends up dissolved in less fluid. Concentration is amount divided by volume. If the amount of sodium is held roughly constant and the concentration climbs about fourfold, the volume must have fallen to roughly a quarter of what entered. A fourfold rise between the top and the bottom of the loop is therefore a statement about water leaving rather than about salt arriving. The same reasoning explains why fluid at the bend of the loop is as concentrated as fluid anywhere in the tubule even though the rise owes almost nothing to new solute being added. Bulk removal of salt does not begin until the fluid rounds the bend and enters the ascending stretch, where the wall is closed to water instead.
>
> (Choice A) This attributes the rise to solute being added rather than water being removed. Salt is not driven from the interstitium into this part of the tubule against its own gradient, and if the volume were unchanged, the tubule would have had to gain roughly three extra ions for every one it started with.
>
> (Choice B) If salt left in proportion to the water, the fluid would stay isosmotic and the measured concentration would not climb at all. This describes what happens in the proximal tubule, where solute and water are recovered together, not what happens deep in the medulla.
>
> (Choice C) Active uptake of sodium from the surrounding tissue into the lumen belongs to no part of the loop. It confuses both the direction and the location of the pumping step, which sits in the ascending stretch and moves sodium out of the tubule rather than into it.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to convert a measured concentration change into a paired statement about volume and solute quantity.

---

## Q8 . Ascending limb dilution sets urine floor

**Stem.** An investigator blocks the salt carrier of the thick ascending limb in a rat while every other transport protein keeps working. After a large drink, the rat cannot produce urine more dilute than its blood. This failure follows most directly from which change?

- **A.** The medullary gradient has collapsed, so the collecting duct can no longer concentrate the filtrate.
- **B.** Solute is no longer stripped from a stretch whose wall is closed to water, so the fluid stays isosmotic with plasma.  <- **KEY**
- **C.** Proximal reabsorption has risen to compensate for the salt left behind downstream.
- **D.** Sodium can no longer be reclaimed at any point along the tubule.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 95 s |
| Confidence | 5 |

**Correct answer (B): Solute is no longer stripped from a stretch whose wall is closed to water, so the fluid stays isosmotic with plasma.**

Citations: AP:53296, AP:53298, AP:53300, BIO:54640

**Distractors**

- **(A)** `partial_truth`: True that the medullary gradient weakens, but that loss explains inability to concentrate urine, the opposite failure from the one described, so it is incomplete in a way that changes the answer.
  - Citation: AP:53295
- **(C)** `misconception`: Proximal reabsorption is isosmotic and is not raised by a downstream block; taking up more fluid early would shrink the delivered volume without making it thinner than blood.
  - Citation: AP:53216
- **(D)** `process_step_confusion`: Treats one carrier in one stretch as the only sodium transport step in the organ; sodium recovery in the proximal tubule, distal tubule and collecting duct runs by separate routes and is unaffected.
  - Citation: BIO:54642

**Readback check.** Key content words of six or more letters: Solute, stripped, stretch, closed, isosmotic, plasma. None appears in the stem, whose long content words are investigator, blocks, carrier, ascending, transport, protein, working, produce, dilute, urine, failure, follows, directly, change. No overlap. The stem reports only the observed failure; the key supplies the unstated mechanism, that solute is removed where water cannot follow, so it cannot be produced by paraphrasing the stem.

**Explanation (as shipped).**

> This Organ Systems item tests why one stretch of the tubule is the only place the kidney manufactures fluid thinner than blood. The answer is B because that stretch has a wall through which water cannot follow while salt is pulled out of the lumen, and removing solute from a compartment water cannot leave is the single event in the whole tubule that drives the fluid below the concentration of plasma. Block the carrier and the fluid arriving at the far end of the loop is still isosmotic with blood. Everything past that point can only take water away or leave it alone, and taking water away raises concentration rather than lowering it, so the thinnest product the kidney could then deliver is one that matches blood, and the surplus intake stays in the body. Getting rid of extra fluid is therefore not simply a matter of switching off recovery at the end of the tubule; it depends on thin fluid having been manufactured earlier. That stretch sets the floor of the kidney's range while the medullary gradient sets its ceiling, and the two failures sit at opposite ends of the same range.
>
> (Choice A) A weakened medullary gradient is a genuine consequence of blocking this carrier, but it explains the opposite failure. Losing the gradient means the animal cannot make urine saltier than blood, whereas the rat here is failing at the watery end of its range.
>
> (Choice C) Proximal recovery is isosmotic and is not driven up by events further along. Even if more fluid were taken up early, that would reduce the volume delivered downstream without ever making the remaining fluid thinner than blood.
>
> (Choice D) Sodium uptake elsewhere is untouched: the stem restricts the block to one carrier in one stretch, and the proximal tubule, the distal tubule and the collecting duct all keep reclaiming sodium by their own routes. This spreads a lesion in a single stretch across the entire organ.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to trace a single blocked transporter to a specific limitation on the range of urine the kidney can produce.

---

## Q9 . Ascending limb transport block and urine volume

**Stem.** A hospitalized patient is started on a drug that binds and disables the apical carrier that moves sodium, potassium and chloride together out of the fluid in the thick ascending limb. Over the next day the patient's urine output rises to several liters and the urine stays near the tonicity of plasma no matter how little the patient drinks. Which chain of events accounts for the rise in output?

- **A.** Salt retained in the filtrate drives glomerular filtration upward, so more fluid is delivered than later segments can reclaim.
- **B.** The salt held back in the tubule retains water osmotically within the loop itself, and that retained water is the whole of the extra volume.
- **C.** The tissue deep in the medulla no longer reaches a high solute concentration, so water lacks the gradient it needs to leave the collecting duct.  <- **KEY**
- **D.** Because the disabled carrier sits in the descending portion, water can no longer be drawn out of the tubule as fluid travels toward the bend.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 100 s |
| Confidence | 5 |
| Hard-tier gate | (a) combines segment specific transport with the deep concentrating environment and with water movement in a later segment; (b) requires a directional inference about volume rather than a lookup; (c) choices B and D stay defensible until the student applies which limb carries the blocked transporter and where most remaining water is reclaimed. Three conditions met, so the hard label holds. |

**Correct answer (C): The tissue deep in the medulla no longer reaches a high solute concentration, so water lacks the gradient it needs to leave the collecting duct.**

Citations: AP:53296, AP:53298, AP:53303, BIO:54698, BIO:54699

**Distractors**

- **(A)** `misconception`: Students commonly believe diuretics act by raising filtration, but salt already inside the tubule cannot push more fluid across the filter upstream, and no plausible filtration change yields several extra liters a day.
  - Citation: AP:53624
- **(B)** `partial_truth`: Osmotic retention inside the loop is real but small; it stops the causal chain one segment early and ignores the roughly one fifth of filtered water still available for reclaim at the collecting duct.
  - Citation: AP:53303
- **(D)** `process_step_confusion`: Assigns the salt carrier to the water permeable limb heading toward the bend, swapping the two limbs' properties and therefore misidentifying which step the drug interrupts.
  - Citation: AP:53296

**Readback check.** Content words of six or more letters in key C: tissue, medulla, longer, reaches, solute, concentration, gradient, collecting. Stem contains: hospitalized, patient, started, disables, apical, carrier, sodium, potassium, chloride, together, ascending, output, several, liters, tonicity, plasma, accounts. No overlap. The key names a structure and a consequence the stem never mentions, so it cannot be produced by restating the stem.

**Explanation (as shipped).**

> This item falls under Organ Systems and tests how blocking salt movement in one tubular segment propagates into a change in the volume of urine produced. The answer is C because the salt pumped out of that segment is what loads the deep tissue with solute, and once that tissue is no longer concentrated, water sitting in the collecting duct has nothing to move toward. The segment returning toward the cortex moves salt out of the tubule while holding water back, so it is the engine that builds the concentrated environment surrounding the deepest structures. Fluid running down the collecting duct passes through that environment, and water crosses out of the duct only because the fluid outside is more concentrated than the fluid inside. Disable the carrier and the surrounding tissue drifts back toward plasma values, so most of what arrives at the duct is carried onward to the bladder rather than being reclaimed. The ability to concentrate and the ability to dilute are lost together here, which is why the urine sits near plasma tonicity instead of becoming maximally dilute. (Choice A) What happens to salt already inside the tubule cannot push more fluid across the filter upstream, so unreabsorbed salt does not drive filtration upward, and no plausible change in filtration could account for several extra liters a day. (Choice B) Salt left in the tubule does hold some water with it, and this contributes, but the bulk of the effect lies downstream: about a fifth of the filtered water is still present when fluid reaches the collecting duct, and whether that water is reclaimed depends entirely on the environment the duct passes through. Naming only the loop stops the reasoning one segment too early. (Choice D) The two limbs do opposite jobs. The limb heading toward the bend is freely permeable to water and carries no salt pump to block, while the limb heading back toward the cortex moves salt and is sealed against water. Placing the carrier in the wrong limb reverses which step the drug interrupts. This is a Scientific Reasoning and Problem Solving question because it requires tracing a blocked membrane carrier through the loss of a tissue gradient to a specific change in the volume of urine produced.

---

## Q10 . Loop length multiplies a single level difference

**Stem.** The carriers of the thick ascending limb can hold the fluid inside the tubule roughly 200 mOsm/L below the fluid immediately outside it at any single horizontal level, and cannot exceed that difference. Compare two nephrons with identical carrier density: one whose bend sits just beneath the cortex, and one whose bend reaches the tip of a renal pyramid. Which of the following are correct?

I. Fluid at the bend of the deeper nephron can sit far more than 200 mOsm/L above plasma, because the difference established at each level adds to the difference already present above it.
II. The two nephrons must arrive at the same value at their bends, since their carriers are equally abundant and equally active.
III. Extending a nephron's bend further toward the tip would raise the value it can attain there.

- **A.** I and III only  <- **KEY**
- **B.** I only
- **C.** III only
- **D.** I, II and III

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 95 s |
| Confidence | 5 |

**Correct answer (A): I and III only**

Citations: AP:53210, AP:53211, AP:53212, AP:53263, BIO:54681

**Distractors**

- **(B)** `partial_truth`: Accepts that increments stack but denies the structural consequence; if the total is assembled level by level, adding levels necessarily raises the attainable total.
  - Citation: AP:53263
- **(C)** `partial_truth`: Accepts that depth matters but omits the mechanism that makes depth matter, leaving the fixed per level ceiling unexplained.
  - Citation: AP:53211
- **(D)** `misconception`: Includes the common belief that equal pump activity means equal end result, which directly contradicts the length dependence asserted by statement III in the same choice.
  - Citation: AP:53212

**Readback check.** The key text is the combination label 'I and III only', which contains no content word of six or more letters, so no stem echo is possible. Each numeral must be evaluated against the stipulated per level limit; none restates the stem, since the stem supplies only the single level ceiling and the two anatomies, never the end to end consequence.

**Explanation (as shipped).**

> This item falls under Organ Systems and tests what the multiplier in the loop actually multiplies, and why the axial extent of the anatomy, not the strength of any one pump, sets the ceiling. The answer is A because statement I correctly describes small per level differences stacking along the axis, statement III correctly follows from that stacking, and statement II denies the role of axial extent altogether. A single pass of transport is weak: it can separate the two sides of the tubule wall by only about a fifth of plasma tonicity. What makes the arrangement powerful is that fluid arriving at any level has already been worked on by every level above it, so each new increment is added on top of an already elevated starting value rather than starting fresh. Stack enough increments and fluid at the deepest bend approaches roughly four times plasma, even though no single pump ever produced more than a fraction of that. Statement II fails on exactly this point: equal carrier density guarantees equal work per level, not equal totals, and the shallow nephron simply has fewer levels over which to accumulate. Two conveyor belts of identical strength deliver very different totals if one runs three times as long. This is also why nephrons whose bends barely leave the cortex contribute little to the deep environment, while the animals that make the most concentrated urine are the ones whose loops run furthest toward the tip. (Choice B) Selecting I alone accepts the stacking idea but stops short of its structural consequence: if the total is built level by level, then adding levels must raise the total, which is exactly what III asserts. (Choice C) Selecting III alone accepts that depth matters but leaves the mechanism unstated; without the stacking described in I there is no reason depth should matter at all, since the per level limit is fixed. (Choice D) Including II contradicts the very reasoning that supports III, since II asserts that anatomy is irrelevant while III asserts that it is decisive. This is a Scientific Reasoning and Problem Solving question because it requires converting a fixed per level transport limit into a prediction about the total difference two nephrons of different lengths can achieve.

---

## Q11 . Medullary blood flow rate and gradient washout

**Stem.** In an isolated perfused kidney, an investigator raises the flow through the straight vessels running beside the deepest loops tenfold, and the most concentrated urine the preparation can make falls by half. She considers two accounts: the fast blood removes accumulated solute from the depths faster than the tubules can restore it, or the fast flow has damaged the tubular pumps themselves. Which measurement best separates the two accounts?

- **A.** Repeat the whole protocol in a second preparation and confirm the concentrating defect appears again at high flow.
- **B.** Compare the net rate at which salt and urea are carried away in the blood leaving the region, sampled shortly after each change in flow.  <- **KEY**
- **C.** Record how much urine the preparation makes per minute at each flow rate.
- **D.** Sample fluid at the bend of the deepest loops and compare its concentration at each flow rate.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **medium** (topic secondary / structural two_step) |
| Estimated time | 90 s |
| Confidence | 4 |

**Correct answer (B): Compare the net rate at which salt and urea are carried away in the blood leaving the region, sampled shortly after each change in flow.**

Citations: AP:53305, AP:53306, AP:53309, AP:53311, BIO:54682

**Distractors**

- **(A)** `adjacent_fact`: Replication is a genuine methodological virtue and establishes that the defect is real, but both rival accounts predict the identical repeatable defect, so a second run discriminates nothing.
  - Citation: AP:53309
- **(C)** `partial_truth`: Repeats the outcome variable already reported; both explanations predict poorer concentrating ability and therefore greater output, so it separates neither.
  - Citation: AP:53303
- **(D)** `misconception`: Assumes a depleted reading at the bend identifies the cause, but fluid there equilibrates with its surroundings and falls whether depletion arose from removal or from failed deposition.
  - Citation: AP:53215

**Readback check.** Content words of six or more letters in key B: Compare, carried, leaving, region, sampled, shortly, change. Stem contains: isolated, perfused, kidney, investigator, raises, through, straight, vessels, running, beside, deepest, tenfold, concentrated, preparation, considers, accounts, removes, accumulated, solute, depths, faster, tubules, restore, damaged, tubular, themselves, measurement, separates. No overlap. The key names a variable and a sampling time the stem never mentions.

**Explanation (as shipped).**

> This item falls under Organ Systems and tests how to design a comparison that discriminates between removal of solute by blood and failure of the transport that deposits it. The answer is B because the two accounts predict opposite things about how much material the blood carries off in the period right after the flow is raised: if fast blood is stripping solute out of the depths, the amount leaving per minute surges above its former value, whereas if the pumps have failed, less solute is being handed to the blood in the first place and the amount leaving falls. That opposition in direction is what makes the measurement discriminating; a good design does not merely confirm the phenomenon, it picks a variable on which the rival explanations disagree. Timing matters here, because once a new steady state settles the amount carried off must again match the amount deposited, so the informative comparison is made while the depths are still being emptied. The result also explains why these vessels normally run slowly. Their hairpin path lets solute enter on the way down and leave again on the way back up, so at low velocity the blood takes away only the water and salt that were reclaimed, leaving the accumulated environment intact. Speed removes that near cancellation, because blood spends too little time alongside the tubules for the returning limb to give back what the descending limb picked up. (Choice A) Reproducing the result in a second preparation is sound practice and strengthens the claim that the effect is real, but both accounts predict the same reproducible defect, so a repeat run says nothing about which mechanism produced it. (Choice C) Urine output per minute is essentially the observation already reported. Both accounts predict a preparation that concentrates poorly and therefore passes more fluid, so repeating the outcome variable adds nothing that separates them. (Choice D) The concentration of fluid at the bend falls under both accounts as well, since the fluid there equilibrates with whatever surrounds it, and what surrounds it is depleted whether the depletion came from washing or from failed deposition. It documents the effect without identifying its source. This is a Reasoning about the Design and Execution of Research question because it requires choosing the measured variable on which two competing explanations of the same result make predictions in opposite directions.

---

## Q12 . Loop depth versus maximal urine concentration

**Stem.** A comparative study recorded, for five mammals, an index of how far the longest loops descend toward the tip of the pyramid and the highest urine osmolarity each animal reached after two days without water.

| Species | Loop depth index | Highest urine osmolarity (mOsm/L) |
| --- | --- | --- |
| Beaver | 1.3 | 520 |
| Human | 3.0 | 1,400 |
| Dog | 4.3 | 2,400 |
| Cat | 4.8 | 3,100 |
| Kangaroo rat | 8.5 | 5,500 |

A sixth mammal, a desert gerbil, has a loop depth index of 6.5. What is the best estimate of the highest urine osmolarity it can reach?

- **A.** About 620 mOsm/L
- **B.** About 1,300 mOsm/L
- **C.** About 2,500 mOsm/L
- **D.** About 4,200 mOsm/L  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **easy** (topic secondary / structural direct) |
| Estimated time | 65 s |
| Confidence | 5 |

**Correct answer (D): About 4,200 mOsm/L**

Citations: BIO:38304, AP:53211, AP:53212, AP:53215

**Distractors**

- **(A)** `reversed_relationship`: Places the deepest looped animal but one at the value of the shallowest species in the table, which implies that a deeper loop concentrates worse and inverts the direction every row supports.
  - Citation: AP:53211
- **(B)** `misconception`: Treats the human ceiling as a mammalian standard, though three of the five tabulated species exceed it and the gerbil's index is more than twice the human's.
  - Citation: AP:53215
- **(C)** `partial_truth`: Uses the correct relationship but reads it at an index near 4.3 rather than 6.5, ignoring the two rows that actually bracket the value asked for.
  - Citation: BIO:38304

**Readback check.** The key is a numeric value with no content word of six or more letters, and the number 4,200 appears nowhere in the table or the stem, so the answer cannot be read off directly. The student must locate 6.5 between two tabulated rows and scale between them.

**Explanation (as shipped).**

> This item falls under Organ Systems and tests reading a structural measurement against a functional ceiling and estimating a value that does not appear in the table. The answer is D because a depth index of 6.5 lies between the cat at 4.8 and the kangaroo rat at 8.5, so the estimate must fall between their osmolarities of 3,100 and 5,500. Across the whole table, greater depth accompanies greater attainable concentration without exception, and over that last interval the rise is close to steady: about 2,400 mOsm/L is gained across 3.7 index units, which is roughly 650 mOsm/L per unit. The gerbil sits 1.7 units above the cat, so it gains about 1,100 on the cat's value, giving an estimate near 4,200. (Choice A) This value sits beside the beaver, the shallowest animal in the table, and would require the gerbil to concentrate less well than a human despite loops more than twice as deep, reversing the direction every row supports. (Choice B) This treats the human value as a standard that other mammals approach, but three of the five tabulated species already exceed it and the gerbil's index is more than double the human's. (Choice C) This is close to the dog's value and would be defensible only for an index near 4.3; stopping partway up the table ignores the two rows that actually bracket 6.5. This is a Data-based and Statistical Reasoning question because it requires extracting the rate at which the tabulated quantity changes and using it to estimate a value for an index absent from the table.

---

## Q13 . Reading an osmolarity profile along the nephron

**Stem.** Micropuncture samples of tubular fluid were collected at four successive sites along a single nephron in an animal that had been deprived of water for 18 hours. Site 1 is the earliest point sampled and site 4 the latest. The fluid immediately outside the tubule at site 2 measured about 1200 mOsm/L, and nowhere in this kidney does the fluid outside the tubule fall below about 300 mOsm/L.

| Sampling site | Fluid osmolarity (mOsm/L) |
|---|---|
| 1 | 300 |
| 2 | 1150 |
| 3 | 120 |
| 4 | 1000 |

Which segment does the tubule pass through between sites 2 and 3?

- **A.** The proximal convoluted tubule
- **B.** The descending limb of the loop of Henle
- **C.** The ascending limb of the loop of Henle  <- **KEY**
- **D.** The medullary collecting duct

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 100 s |
| Confidence | 5 |
| Hard-tier gate | (b) the answer requires a directional inference about which particle moved and in which direction, not a lookup; (c) the descending limb and the collecting duct both stay defensible until the student applies the stated floor of about 300 mOsm/L on the fluid outside the tubule; (d) the item inverts the usual direction of reasoning by giving the measured outcome and asking for the structure that produced it. |

**Correct answer (C): The ascending limb of the loop of Henle**

Citations: AP:53224, AP:53296, AP:53300, AP:52254

**Distractors**

- **(A)** `adjacent_fact`: True of the first convoluted segment, where salt and water leave together and osmolarity stays near the filtered value, but irrelevant to a fall far below that value.
  - Citation: AP:53224
- **(B)** `reversed_relationship`: The limb that descends raises fluid osmolarity as water leaves; this choice has the direction of the osmotic change inverted.
  - Citation: AP:53296
- **(D)** `process_step_confusion`: Names a later stage: the final duct explains the rise from site 3 to site 4, not the dilution that precedes it.
  - Citation: AP:52254

**Readback check.** Content words of six or more letters in the key: ascending. The stem contains micropuncture, samples, tubular, collected, successive, nephron, animal, deprived, earliest, sampled, latest, outside, tubule, measured, nowhere, kidney, sampling, osmolarity, segment, between. 'Ascending' appears nowhere in the stem, and the key is derived from the shape of the profile rather than read off any single row.

**Explanation (as shipped).**

> This item falls under Organ Systems and tests how the osmolarity profile of tubular fluid identifies where along the nephron a sample was taken. The answer is C because only a stretch that pulls salt out of the lumen while refusing to let water follow can drive the fluid far below the 300 mOsm/L at which it was filtered, and that is exactly what the drop from site 2 to site 3 shows. Filtrate begins as plasma stripped of protein, so the 300 at site 1 marks the start of the tubule. The climb to 1150 at site 2 requires water to have left the lumen into much saltier surroundings. Now consider what water movement alone could do between sites 2 and 3: water crossing the wall can only pull the fluid toward the value outside the tubule, and the stem states that this outside value never drops below about 300, so no amount of water entering the lumen could bring the sample to 120. The reading is therefore consistent only with sodium chloride being carried out across a wall that water cannot cross. The rise back to 1000 at site 4 then reflects water leaving the last stretch of tubule down the very gradient that the preceding salt transport helped to build.
>
> (Choice A) The first convoluted segment removes salt and water in roughly equal proportion, so fluid leaving it is still close to 300 mOsm/L. It can produce neither the peak at site 2 nor the trough at site 3.
>
> (Choice B) In the limb that dives toward the papilla, water leaves and osmolarity climbs. That accounts for the change from site 1 to site 2, not for the fall that follows it, so this choice has the direction of the change backwards.
>
> (Choice D) The final duct is where fluid is concentrated again during water deprivation, which fits the change from site 3 to site 4. Placing it between sites 2 and 3 puts the dilution step at the wrong stage of the pathway.
>
> This is a Data-based and Statistical Reasoning question because it asks the student to identify an unlabelled segment by reasoning from the shape of a measured osmolarity profile together with the osmolarity of the fluid surrounding the tubule.

---

## Q14 . Ceiling on maximal urine concentration

**Stem.** A patient who has had no access to drinking water for a prolonged period is being studied. In this state, the chemical signal that inserts water pores into the wall of the medullary collecting duct is present at saturating levels, so the duct wall is as permeable to water as it can possibly be, and flow through the duct is slow enough that the fluid inside reaches osmotic equilibrium with the surrounding tissue at every position it passes. Probe readings of the surrounding tissue give 1,200 mOsm/L at the innermost point the duct reaches, 300 mOsm/L where the duct begins, and 750 mOsm/L midway between those two. Fluid enters the duct at 100 mOsm/L. What is the highest osmolarity the fluid leaving this duct can attain?

- **A.** About 1,200 mOsm/L  <- **KEY**
- **B.** About 2,400 mOsm/L
- **C.** About 750 mOsm/L
- **D.** About 50 mOsm/L

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 90 s |
| Confidence | 5 |

**Correct answer (A): About 1,200 mOsm/L**

Citations: AP:53360; AP:53362; AP:52254; AP:53215; AP:53224

**Distractors**

- **(B)** `misconception` . _maximal driver assumed to overshoot equilibrium_: Assumes that saturating water permeability and unlimited transit time keep driving water out past the point of equality, doubling the deepest surrounding value. Osmotic water movement is self-limiting and ceases at equality, so no driver can push the fluid above the surrounding osmolarity.
  - Citation: AP:53362
- **(C)** `partial_truth` . _right principle applied at the wrong position_: Correctly recognizes that the surrounding fluid sets the limit but takes the reading from the midway position instead of the innermost one. The fluid re-equilibrates at each successive position as it descends, so the final value is fixed by the last surrounding value encountered.
  - Citation: AP:53360
- **(D)** `reversed_relationship` . _water flow direction inverted_: Treats the concentrated surroundings as drawing water into the duct, so the fluid would end up more dilute than the 100 mOsm/L it entered with. Water moves toward the more concentrated compartment, which lies outside the duct, so duct fluid loses water and becomes more concentrated, never less.
  - Citation: AP:53362

**Readback check.** Key text is "About 1,200 mOsm/L". Content words of six or more letters in the key: none (About is 5 letters, 1,200 is numeric, mOsm/L is a unit symbol). Because the key contains no content word of six or more letters, no such word can appear in the stem, so the key cannot be produced by copying any phrase from the stem. Numeric echo is also blocked three ways: 1,200 is not the largest option offered, since choice B (2,400) exceeds every value in the stem, so a largest-choice heuristic fails; the probe readings are listed out of order in the stem so that the last number mentioned is 750, which is a distractor, defeating a recency heuristic; and choosing among the three stem values requires knowing that equilibration caps the fluid at the deepest surrounding value it meets rather than at the entry value or an intermediate one.

**Explanation (as shipped).**

> This Organ Systems item tests what sets the upper limit on how concentrated urine can become. The answer is A because water leaves the duct only while the fluid inside is less concentrated than the fluid outside, so once the two match the driving force is gone, and the highest surrounding value the duct is ever exposed to, 1,200 mOsm/L, is the most the fluid inside can reach. Concentrating urine is a passive process: the permeable wall supplies only a path, while the driving force is the osmotic difference across that wall. Equilibration can carry the inside fluid up to the outside value, but nothing about equilibration can carry it past that value. That is why saturating the permeability signal, slowing transit further, or worsening the dehydration cannot push the number higher; each of those factors changes how completely equilibrium is reached, not where equilibrium sits. The deepest surrounding reading is therefore a hard ceiling that the fluid can approach but never exceed.
>
> (Choice B) 2,400 mOsm/L doubles the deepest surrounding reading, treating maximal wall permeability plus unlimited time as though continued exposure keeps adding concentration. Osmotic water movement is self-limiting: it halts at equality, so no amount of extra permeability or extra time produces a value above the surrounding fluid.
>
> (Choice C) 750 mOsm/L correctly recognizes that the surrounding fluid imposes the limit but reads that limit at the wrong position. The fluid does not stop midway; it continues into progressively saltier surroundings and re-equilibrates at each successive position, so the last position it passes, not an intermediate one, fixes the final value.
>
> (Choice D) 50 mOsm/L reverses the direction of water movement, treating the concentrated surroundings as drawing water into the duct and diluting its contents below the entering value. Water moves toward the more concentrated compartment, which here lies outside the duct, so the fluid loses water and rises above its entering value rather than falling below it.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to apply the limits of a passive equilibrium process to predict the maximum value an outcome can reach when every factor promoting that process has already been maximized.

---

## Q15 . Urea contribution to the medullary gradient

**Stem.** After several weeks on a very low protein diet, a subject is deprived of fluid for 14 hours. Vasopressin is measured and is appropriately high, yet urine osmolarity plateaus near 600 mOsm/L, compared with about 1150 mOsm/L when the same subject ate an ordinary diet. Which change best accounts for the lower ceiling?

- **A.** More osmotically active particles remain in the tubular fluid, and they hold water inside the duct
- **B.** The tubule responds poorly to the water-conserving hormone because its receptors cannot be built without dietary protein
- **C.** Protein restriction increases muscle breakdown, and the extra creatinine excreted obligates additional loss of fluid
- **D.** Less urea reaches the deep interstitium, so fewer osmoles are available there to draw water out of the collecting duct  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic secondary / structural direct) |
| Estimated time | 75 s |
| Confidence | 4 |

**Correct answer (D): Less urea reaches the deep interstitium, so fewer osmoles are available there to draw water out of the collecting duct**

Citations: AP:53271, AP:53277, AP:53281, AP:53085

**Distractors**

- **(A)** `reversed_relationship`: Reverses the effect of low nitrogen intake on particle load and would predict a large dilute urine rather than a lowered ceiling on concentration.
  - Citation: AP:53281
- **(B)** `misconception`: The stem states the signal is appropriately high, and moderate dietary restriction does not abolish receptor synthesis; the defect lies in the gradient the hormone acts against.
  - Citation: AP:53085
- **(C)** `adjacent_fact`: A statement about waste generation elsewhere in the body that does not bear on the maximum concentration the kidney can achieve.
  - Citation: AP:53277

**Readback check.** Content words of six or more letters in the key: interstitium, osmoles, available, collecting. The stem contains several, protein, subject, deprived, vasopressin, measured, appropriately, osmolarity, plateaus, compared, ordinary, accounts, ceiling. No six-letter-or-longer word is shared, and 'urea' is never named in the stem.

**Explanation (as shipped).**

> This item falls under Organ Systems and tests the contribution of the body's main nitrogen waste to the osmotic gradient deep in the kidney. The answer is D because the concentrating step is passive: water leaves the last stretch of tubule only if the fluid around it is more crowded with particles than the fluid inside, and a large share of those surrounding particles is the nitrogen waste itself rather than sodium chloride. The supply of that waste tracks how much amino acid the body is breaking down, so weeks of very low intake shrink the pool available for the kidney to deposit around the deepest tubules. With the deep gradient blunted, even a maximal hormonal signal that opens the water pathway can only pull the tubular fluid up to whatever the surrounding fluid measures, and 600 mOsm/L is the ceiling that this weaker surrounding fluid sets. The failure therefore lies in the osmotic environment the hormone acts against, not in the hormone itself.
>
> (Choice A) This has the direction backwards. Taking in less nitrogen means fewer, not more, particles pass along the tubule, and in any case particles retained inside the lumen would drive a large dilute urine rather than a ceiling on concentration.
>
> (Choice B) The stem already reports that the signal is appropriately high, and the defect described here sits outside the tubule rather than in its response machinery. Receptors that cannot be synthesised are a commonly imagined but incorrect consequence of moderate dietary restriction.
>
> (Choice C) Extra breakdown products would, if anything, add to the particle load the kidney handles. This statement concerns waste generation elsewhere in the body and does not address why the maximum achievable concentration falls.
>
> This is a Knowledge of Scientific Concepts and Principles question because it asks the student to attribute a measured drop in maximal urine concentration to the loss of a specific contributor to the osmotic gradient deep in the kidney.

---

## Q16 . Obligatory urine volume from solute load

**Stem.** An adult generates a fixed load of 900 mOsm of solute that must leave the body in the urine each day. Even under maximal water conservation, this person's kidneys cannot push urine osmolarity past 1200 mOsm/L, and the daily load does not change with dehydration. What is the smallest daily urine volume compatible with clearing the whole load?

- **A.** 0.075 L per day
- **B.** 0.75 L per day  <- **KEY**
- **C.** 1.3 L per day
- **D.** 3.0 L per day

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 85 s |
| Confidence | 5 |
| Hard-tier gate | (a) it combines a fixed metabolic solute load with a separate physiological ceiling on achievable concentration; (b) the answer requires a quantitative inference rather than a lookup, and the units must be tracked to avoid inverting the ratio. |

**Correct answer (B): 0.75 L per day**

Citations: AP:54764, AP:54768, AP:52254

**Distractors**

- **(A)** `scale_unit_error`: Correct reasoning carried out at the wrong order of magnitude; 75 mL per day is a tenfold slip.
  - Citation: AP:54768
- **(C)** `reversed_relationship`: Inverts the ratio, dividing the ceiling concentration by the load, which also yields the wrong units and predicts more urine for a better concentrating kidney.
  - Citation: AP:54764
- **(D)** `partial_truth`: Uses the right method but substitutes the plasma value for the maximum attainable concentration, giving an upper reference volume rather than the minimum.
  - Citation: AP:52254

**Readback check.** The key is a computed numeric value with no content words of six or more letters, so no stem word can be echoed. The number 0.75 does not appear in the stem and must be produced by dividing the two supplied quantities.

**Explanation (as shipped).**

> This item falls under Organ Systems and tests the arithmetic that sets a floor under daily urine output. The answer is B because volume is the load divided by the highest concentration attainable: 900 mOsm divided by 1200 mOsm per litre gives 0.75 L per day. The meaning matters more than the number. Concentration is a ratio, so once the numerator is fixed by metabolism and diet and the denominator has a hard upper bound set by how steep the kidney's deepest osmotic gradient can be, the volume of fluid carrying that load cannot fall below the quotient. No amount of thirst, water restriction or hormonal signalling can push output lower without leaving part of the load inside the body. This is why urine output can never fall to zero, and why a person with a blunted deep gradient, who tops out at a lower concentration, is forced to give up even more water each day for the same load.
>
> (Choice A) This is the correct quotient shifted by a factor of ten, a magnitude slip rather than a reasoning error. A daily output of 75 mL would be a small fraction of what any functioning kidney produces.
>
> (Choice C) Dividing 1200 by 900 inverts the relationship and yields a number with the wrong units. Litres come from milliosmoles divided by milliosmoles per litre, not the reverse, and inverting the ratio would perversely predict a larger volume for a kidney that concentrates better.
>
> (Choice D) This uses the method correctly but substitutes the osmolarity of plasma, near 300 mOsm/L, for the maximum the kidney can reach. It gives the output of someone excreting the load without concentrating at all, which is an upper reference point rather than the floor requested.
>
> This is a Data-based and Statistical Reasoning question because it asks the student to combine a fixed solute load with a ceiling concentration to compute a minimum volume and to interpret what that quotient represents physiologically.

---

## Q17 . Distal sodium delivery and potassium secretion

**Stem.** Principal cells of the late distal nephron take up sodium from the tubular fluid and release potassium into it, and the rate of potassium release tracks the rate of sodium uptake by those same cells. Consider three interventions in an otherwise healthy adult.

I. A drug that blocks the sodium potassium two chloride symporter of the thick ascending limb
II. Intravenous infusion of a sodium salt whose anion the proximal tubule cannot reclaim
III. A drug that blocks the luminal sodium channel of principal cells

Which interventions would be expected to raise urinary potassium loss?

- **A.** I only
- **B.** I and III only
- **C.** I and II only  <- **KEY**
- **D.** I, II, and III

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 100 s |
| Confidence | 5 |

**Correct answer (C): I and II only**

Citations: AP:53381, AP:53298, AP:53638, AP:53303

**Distractors**

- **(A)** `partial_truth`: Correctly credits the loop blocker with raising downstream sodium delivery but misses that an unreclaimable anion achieves the same delivery increase by a charge balance route, so the set is incomplete.
  - Citation: AP:53638
- **(B)** `reversed_relationship`: Blocking the luminal sodium channel of principal cells reduces sodium uptake and therefore reduces potassium release; this choice relates the two variables in the wrong direction.
  - Citation: AP:53381
- **(D)** `misconception`: Rests on the common belief that anything increasing urine flow must waste potassium, when agents acting at the final segment conserve it.
  - Citation: AP:53376

**Readback check.** Key text is 'I and II only'. It contains no content word of six or more letters, so no stem echo is possible. The Roman numeral statements themselves sit in the stem block, and the key is a combination label rather than a restatement of any of them, so identifying the answer requires evaluating each intervention's effect on downstream sodium delivery rather than matching a phrase. The stem hands the student the sodium to potassium coupling rule so that no hormone name is ever the discriminator; the reasoning work is predicting how much sodium each intervention delivers to the final segment.

**Explanation (as shipped).**

> This question sits in the Organ Systems content category and tests how the quantity of salt reaching the last segments of the nephron governs the loss of potassium in urine. The answer is C because interventions I and II both push extra sodium past the earlier segments and into the final tubule, whereas intervention III removes the very sodium entry step that drives potassium out of the cell. Sodium crosses the apical membrane of these cells down a steep electrochemical gradient that basolateral pumping maintains, and every ion of sodium withdrawn from the fluid leaves the lumen slightly more electrically negative. That growing negativity, together with the raised pump turnover it reflects, favors the exit of potassium from cell to lumen, so any manipulation that offers more sodium to these cells raises the potassium that ends up in urine. Blocking salt uptake in the thick ascending limb leaves in the fluid a large load that would otherwise have been reclaimed upstream, and it arrives downstream intact. An anion the early tubule cannot recover holds its sodium partner in the lumen for a different reason, charge balance, but the downstream consequence is identical. Both routes therefore converge on the same variable, and both raise potassium loss.
>
> (Choice A) Intervention I is correctly identified, but the reasoning stops one step short. An anion that cannot be reclaimed upstream is a second and entirely independent route to the same increase in downstream sodium delivery, so a set containing only I is incomplete.
>
> (Choice B) Intervention III inhibits sodium entry across the apical membrane of principal cells. With less sodium crossing, the electrical driving force and the pump turnover that favor potassium exit both fall, so urinary potassium declines rather than rises. This choice has the direction of the effect inverted.
>
> (Choice D) Treating every agent that increases urine flow as a potassium waster ignores the mechanism entirely. Drugs acting at the final segment itself spare potassium precisely because they cut the sodium uptake on which potassium release depends, so the effect of III opposes the effects of I and II.
>
> This is a Scientific Reasoning and Problem Solving question because the student must trace three unrelated pharmacological manipulations forward to a single shared downstream variable, the sodium load presented to the final tubule, and then predict the direction of potassium loss for each one.

---

## Q18 . Two requirements for concentrating urine

**Stem.** Four groups of rats are prepared. In each group the water permeability of the final duct is clamped pharmacologically at a high or a low value, and the osmolality of the deep medullary interstitium is set independently by controlling salt transport in the ascending limb. Plasma osmolality is 300 mOsm/kg in every animal.

| Group | Water permeability of final duct | Papillary interstitial osmolality (mOsm/kg) |
|---|---|---|
| 1 | High | 1200 |
| 2 | High | 300 |
| 3 | Low | 1200 |
| 4 | Low | 300 |

In how many of the four groups will the fluid leaving the duct be hyperosmotic to plasma?

- **A.** One  <- **KEY**
- **B.** Two
- **C.** Three
- **D.** Four

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 110 s |
| Confidence | 5 |
| Hard-tier gate | (a) it combines duct water permeability with the deep medullary osmotic gradient as two independently manipulated concepts; (b) it demands a directional osmotic inference for each condition combination rather than a lookup; (c) the counts of two and three remain defensible until the student applies the specific fact that osmotic water movement needs both an open path and a difference in osmolality. |

**Correct answer (A): One**

Citations: AP:53359, AP:53360, AP:53296, AP:53282

**Distractors**

- **(B)** `misconception`: Follows from the widespread belief that opening a water path is by itself enough to concentrate the fluid, or the mirror belief that a steep gradient alone suffices; each ignores one of the two necessary conditions.
  - Citation: AP:53361
- **(C)** `partial_truth`: Recognizes that both variables matter but treats them as substitutes rather than as conditions that must hold together, so it credits groups possessing only one.
  - Citation: AP:53360
- **(D)** `misconception`: Assumes the final duct always yields a product saltier than plasma, when the duct cannot exceed plasma osmolality unless water is actively withdrawn from it.
  - Citation: AP:53303

**Readback check.** Key text is 'One'. It contains no content word of six or more letters, so no term can be copied from the stem into the key. The table supplies conditions rather than outcomes, so the count cannot be read off any column; the student must convert each row into a predicted outcome before counting. Permeability is clamped pharmacologically in the stem so that no hormone name can serve as the discriminator.

**Explanation (as shipped).**

> This question falls in the Organ Systems content category and tests the recognition that a concentrated final product requires two separate conditions to hold at once. The answer is A because water can only leave the duct if a path exists and a driving force exists, and only group 1 supplies both. Water crosses the epithelium by osmosis, so an open path is useless when the fluid outside sits at the same osmolality as the fluid inside, and a steep surrounding gradient is equally useless when the epithelium will not let water through. Group 2 has an open path but faces an interstitium no saltier than plasma, so the fluid can at best equilibrate toward 300 mOsm/kg and never exceeds it. Group 3 faces a steep gradient it cannot exploit, so the dilute fluid handed to it by a fully active ascending limb passes straight through and emerges well below plasma osmolality. Group 4 fails both tests at once, with neither a path for water to cross nor a difference in osmolality to drive it, so whatever osmolality the fluid carries into the duct it carries out again and it never rises above that of plasma. Only group 1 lets water move down a large osmotic difference into the surrounding tissue, leaving behind a small volume of solute rich fluid.
>
> (Choice B) A count of two follows from treating an open water path as sufficient by itself, which credits groups 1 and 2, or from treating a steep gradient as sufficient by itself, which credits groups 1 and 3. Either version drops the requirement that both must be present, and each version is contradicted by the group it wrongly includes.
>
> (Choice C) A count of three follows from treating the two conditions as alternatives, so that any group possessing at least one of them concentrates its fluid. The reasoning is half right, since both variables genuinely matter, but they combine as a joint requirement rather than as substitutes, so groups 2 and 3 fail alongside group 4.
>
> (Choice D) A count of four assumes the final duct always delivers a product saltier than plasma. Urine at or below plasma osmolality is a normal and frequent output, and concentration is something the duct must actively achieve rather than a default state, so three of these four preparations lack one or both of the requirements for achieving it.
>
> This is a Scientific Reasoning and Problem Solving question because the student must apply a two condition rule independently to each of four experimentally defined combinations and then aggregate the four verdicts into a single count.

---

## Q19 . Designing a test for a local tubular sensor

**Stem.** Fluid leaving the thick ascending limb passes a patch of specialized tubular cells pressed against the arterioles that supply the glomerulus of that same nephron. One proposal holds that these cells read the salt content of the fluid beside them and adjust filtration in their own nephron on the spot. A competing proposal holds that any such adjustment is carried out by a substance travelling in the blood, which would reach every nephron in the kidney alike. Which experiment best distinguishes the two proposals?

- **A.** Infuse a salt load into a vein and record the filtration rate of the whole kidney, which pools all of its nephrons, before and after
- **B.** Compare average single nephron filtration rates in animals fed a high salt diet for two weeks with those fed a low salt diet
- **C.** Remove one kidney and record whether filtration per nephron rises in the kidney that remains
- **D.** Perfuse the tubule of one nephron with a salty fluid and compare filtration in that same nephron with filtration in its untouched neighbors  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **easy** (topic secondary / structural direct) |
| Estimated time | 70 s |
| Confidence | 4 |

**Correct answer (D): Perfuse the tubule of one nephron with a salty fluid and compare filtration in that same nephron with filtration in its untouched neighbors**

Citations: AP:52638, AP:52658, AP:53434, AP:53439

**Distractors**

- **(A)** `partial_truth`: It does change salt at the sensor, but it changes it at every sensor at once and reads the result out as a single pooled number, so both competing proposals predict the same finding.
  - Citation: AP:52658
- **(B)** `adjacent_fact`: A genuine and informative experiment about dietary salt and filtration, but it is systemic and averaged across nephrons, so it cannot reveal whether the signal stays inside one nephron.
  - Citation: AP:53434
- **(C)** `misconception`: Rests on the belief that whole organ compensation after tissue loss demonstrates a local sensor; it never varies salt at the sensor and probes a different phenomenon entirely.
  - Citation: AP:52638

**Readback check.** Content words of six or more letters in the key are Perfuse, tubule, nephron, filtration, untouched and neighbors. Of these, nephron and filtration do appear in the stem, but both also appear in the other options, so neither carries any discriminating signal; Perfuse, untouched and neighbors appear nowhere in the stem. The stem describes the cell patch rather than naming it, so no anatomical label can be matched, and the discriminating work is recognizing that only a single unit manipulation with untreated neighbors separates a local from a bloodborne signal.

**Explanation (as shipped).**

> This question falls in the Organ Systems content category and tests how an experiment must be built to separate a signal that acts where it is generated from one that travels in the blood to every target at once. The answer is D because only this design changes the input to a single sensor while leaving every other nephron in the same kidney untouched as a built in control. If the adjustment is local, filtration falls in the perfused nephron alone and its neighbors are unaffected, because the neighbors never saw the salty fluid. If instead the adjustment depends on something released into the blood, the perfused nephron and its neighbors share the same circulation and would have to move together. The two proposals therefore predict visibly different patterns, and one measurement settles the matter. Every other option changes salt at many sensors simultaneously or pools the readout across nephrons, and under those conditions the local and bloodborne accounts predict the very same result, which is why they cannot discriminate.
>
> (Choice A) Salt delivered into a vein reaches every nephron in the kidney, and a whole kidney measurement sums their responses. A change in that number is consistent with both proposals, so the experiment produces a real effect that carries no information about where the signal acts.
>
> (Choice B) Two weeks of altered diet is a systemic and slow manipulation, and averaging filtration across nephrons hides exactly the nephron to nephron difference that would identify a local signal. It is a legitimate experiment about the response to dietary salt, but it answers a different question than the one posed.
>
> (Choice C) Removing one kidney tests how the remaining organ compensates for lost tissue, which is a separate phenomenon driven by whole body demands. The manipulation never varies the salt content of the fluid arriving at the sensor, so neither proposal is put at risk by the result.
>
> This is a Reasoning about the Design and Execution of Research question because the student must choose the one manipulation that varies the input to a single sensor while leaving matched neighboring units untouched, which is the only arrangement in which the two competing accounts predict different outcomes.

---

## Q20 . Water deprivation then exogenous hormone challenge

**Stem.** Two adults with lifelong polyuria and a healthy control were deprived of water for eight hours, after which urine osmolality was measured. Each then received an injection of a synthetic analogue of the kidney's water conserving hormone, and urine osmolality was measured again one hour later.

| Subject | After deprivation (mOsm/kg) | After injection (mOsm/kg) |
|---|---|---|
| Control | 950 | 1005 |
| Patient J | 135 | 715 |
| Patient K | 140 | 155 |

Which conclusion is best supported by these results?

- **A.** Patient J's shortfall is in the tubular reaction, and patient K's is in supply of the molecule
- **B.** Patient J's shortfall is in supply of the molecule, and patient K's is in the tubular reaction  <- **KEY**
- **C.** Both patients fall short in supply of the molecule, and the dose reaching patient K was too small
- **D.** Both patients handle the molecule normally, and the low starting values reflect incomplete deprivation

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 95 s |
| Confidence | 5 |

**Correct answer (B): Patient J's shortfall is in supply of the molecule, and patient K's is in the tubular reaction**

Citations: AP:52209, AP:52211, AP:53359, AP:53363

**Distractors**

- **(A)** `reversed_relationship`: Swaps the two patients, assigning the responsive kidney to the reaction defect and the unresponsive one to a supply defect, which contradicts the large rise seen in patient J.
  - Citation: AP:52209
- **(C)** `misconception`: Blames patient K's flat result on an insufficient dose, but the same dose drove a large rise in patient J, so the dose was adequate.
  - Citation: AP:52211
- **(D)** `misconception`: Dismisses both low starting values as a short deprivation, which the control refutes by reaching 950 mOsm/kg under the identical protocol.
  - Citation: AP:53363

**Readback check.** Content words of six or more letters in the key are Patient, shortfall, supply, molecule, tubular and reaction. Of these only Patient appears in the stem, and it appears as a table row label in every option equally, so it carries no discriminating signal. Shortfall, supply, molecule, tubular and reaction appear nowhere in the stem, which uses deprived, osmolality, injection, synthetic, analogue and hormone. The hormone is handed to the student in the stem and is never named in any option, so no hormone name can be the answer; no value in the key can be read off the table, and the answer requires comparing the size of each subject's change against the control's ceiling.

**Explanation (as shipped).**

> This question sits in the Organ Systems content category and tests the interpretation of a challenge test that separates a missing chemical message from a target that cannot act on one. The answer is B because patient J concentrated the urine sharply once the substance was supplied from outside, which shows the kidney machinery was ready and only the substance was missing, while patient K barely moved despite receiving the same supply. Eight hours without water is a powerful natural stimulus, and the control shows what an intact system does with it, reaching a high value before the injection and gaining almost nothing afterwards because it was already near its ceiling. Both patients failed that natural stimulus, so the test cannot separate them until the substance is supplied artificially. Once it is, the two end points diverge by more than fourfold, and the divergence localizes each defect: a kidney that responds to an outside dose was never the problem, and a kidney that ignores an outside dose is the problem.
>
> (Choice A) This assigns each defect to the wrong patient. Patient J rose from 135 to 715 within an hour of the injection, which is only possible if the final duct can raise its water permeability and the surrounding tissue can pull water out, so the reaction apparatus is intact in J and impaired in K.
>
> (Choice C) Attributing patient K's flat result to an inadequate dose ignores the design of the test. Both patients received the same analogue on the same schedule, and patient J's large rise establishes that the dose was ample to drive a substantial response, so an unresponsive kidney rather than an underdose explains K's result.
>
> (Choice D) The control subject argues directly against this. Deprivation alone raised the control to 950 mOsm/kg, so eight hours is long enough to reveal a normal concentrating response, and both patients sat near 140 mOsm/kg under that same stimulus, which is a failure rather than an artifact of a short deprivation.
>
> This is a Data-based and Statistical Reasoning question because the student must compare two measurements taken before and after a defined intervention, use the control values to establish what an intact response looks like, and assign the two patients to different lesions on the basis of the size of the change rather than the raw values.

---



---

# BATCH 3 of 3, FINAL (20 questions): volume control, skin, thermoregulation, receptors

**This batch completes Biology Chapter 10 at 60 questions, and with it BIOLOGY: all 12 chapters.**

## Batch 3 and final chapter summary

| Metric | Batch 3 | FULL CHAPTER (60) | Target |
|---|---|---|---|
| Difficulty | easy 5 . hard 7 . medium 8 | easy 16 . hard 20 . medium 24 | easy 16 . medium 24 . hard 20 |
| Answer letter | A 5 . B 5 . C 5 . D 5 | A 15 . B 15 . C 15 . D 15 | 15 each |
| Cognitive skill | S1 4 . S2 10 . S3 2 . S4 4 | S1 10 . S2 31 . S3 8 . S4 11 | S1 10 . S2 31 . S3 8 . S4 11 |
| Roman numeral | 2 | 8 | 8 |
| Em/en dashes | 0 | 0 | 0 |

**Every distribution target across the finished chapter landed exactly.** All 60 pass every structural gate; no boundary term appears in any key (the chapter contains zero questions whose answer is a hormone name, honouring the Bio Ch5 boundary in full); 60 distinct subtopics with no semantic near-duplicates.

**A third duplicate was caught and replaced before shipping.** The batch 3 writer briefed to cover pressure natriuresis instead produced a castaway scenario re-testing batch 2 obligatory-urine-volume arithmetic under a renamed subtopic, slipping past the word-overlap dedup because the two keys share almost no vocabulary. Caught by eyeballing subtopics that SOUND alike, now a standing step. The replacement is the planned pressure-natriuresis item: a ten day fixed-vasoconstriction preparation in which the baroreflex has reset, isolating renal salt and water excretion as the only days-scale lever that can return pressure to baseline. Pinned to the retired item metadata; post-swap re-verification confirmed all distributions unchanged.

**Founder decisions honoured:** the named cutaneous receptors are covered here (his choice over leaving them to Psych/Soc Ch2), keyed on depth and physical construction, never on receptor taxonomy or intensity coding (Bio Ch4). Fever is keyed as a set point shift; shivering as an effector in a loop, never mechanistically (Biochem owns thermogenesis chemistry); evaporation keyed on heat flow direction, never on naming the three transfer modes.

**Adversarial audit:** all 20 re-examined by an independent pass per slice against OpenStax Anatomy and Physiology 2e.

---

## Q1 . Volume defence overriding osmolarity defence

**Stem.** A trauma patient loses 1.4 L of whole blood over twenty minutes and receives no fluid replacement. Plasma osmolarity measured immediately afterwards is unchanged from her baseline of 289 mOsm/L, while cardiac filling is clearly reduced. Over the next several hours, as she drinks freely, what happens to urine volume and to plasma concentration?

- **A.** Urine volume falls, and plasma concentration drifts below its set point.  <- **KEY**
- **B.** Urine volume falls, and plasma concentration drifts above its set point.
- **C.** Urine volume rises, and plasma concentration is held at its set point.
- **D.** Urine volume and plasma concentration both stay at baseline.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 100 s |
| Confidence | 5 |
| Hard-tier gate | (a) combines two concepts, the vascular filling signal and the osmotic signal, which are independent control inputs with a priority ordering between them; (b) requires a directional inference about two coupled variables from a stated isotonic loss plus free water intake; (d) inverts the usual reasoning direction, since the familiar case has a concentration error driving water conservation, whereas here conservation proceeds with concentration normal and manufactures a concentration error as its price. |

**Correct answer (A): Urine volume falls, and plasma concentration drifts below its set point.**

Citations: AP:39096; AP:53341; AP:53364; AP:54723

**Distractors**

- **(B)** `reversed_relationship` . _right volume response, inverted concentration consequence_: Water retained without a matching solute load must dilute the fluid it joins, so plasma concentration falls rather than rises.
  - Citation: AP:53364
- **(C)** `misconception` . _concentration control outranks volume control_: Treats the osmotic set point as the dominant priority, which would force a bleeding patient to excrete fluid she cannot spare.
  - Citation: AP:39096
- **(D)** `partial_truth` . _no osmotic error, therefore no response_: Correct that no osmotic correction is required, but incomplete: vascular filling is a separate input that triggers conservation on its own.
  - Citation: AP:53341

**Readback check.** Content words of six or more letters in the key: volume, plasma, concentration, drifts. The words volume, plasma and concentration appear in the stem only inside the question sentence that names the two variables being predicted, and they appear identically in all four choices, so they cannot discriminate. Drifts appears in choice B as well. No distinctive word is shared between the stem and the key alone. The key states a direction of change that is nowhere asserted in the stem, so no phrase can be copied out to produce it.

**Explanation (as shipped).**

> This item belongs to Organ Systems and tests how the kidney arbitrates when the signal reporting how much fluid there is and the signal reporting how concentrated that fluid is point in different directions. The answer is A because the body treats filling of the vascular compartment as the more urgent variable, so it conserves water even though concentration needs no correction, and the conserved water dilutes what remains. Whole blood carries cells, protein and dissolved particles away in the same proportions they occupy in the circulation, so removing it lowers the amount of fluid without changing the number of particles per litre of what is left behind. Sensors reporting concentration therefore register nothing unusual, while sensors reporting vascular filling are strongly engaged. The response driven by the filling signal is avid salt and water retention in the distal nephron and collecting duct, which cuts urine output sharply and keeps ingested water inside the body. Because that water is held back with no concentration deficit to correct, it is pure surplus as far as the concentration variable is concerned, and plasma concentration slides slightly under its normal set point. This is the physiological reason a patient who has bled heavily and then drinks freely commonly shows a low serum sodium: the body accepted a concentration error in order to protect perfusion. (Choice B) This gets the renal volume response right but reverses the concentration consequence. Holding on to water without holding on to a matching load of particles must lower, not raise, the concentration of the fluid that water joins. (Choice C) This assumes the concentration set point outranks filling. If that were true, a bleeding patient would pour out fluid to defend a number that is already correct, deepening the very deficit that threatens tissue perfusion, which is why the hierarchy runs the other way. (Choice D) It is true that no osmotic correction is called for, but that is only half of the input the kidney receives. Filling is monitored independently, and a large fall in it drives a renal response on its own even when concentration is untouched. This is a Scientific Reasoning and Problem Solving question because it asks the student to predict the direction of two coupled variables in the one situation where their two control signals disagree.

---

## Q2 . Tonicity of fluid lost predicts urine

**Stem.** Three subjects each lose 2.0 L of fluid over one hour and drink nothing afterwards. All three began with a plasma osmolarity of 290 mOsm/L and have normal kidneys. The table gives the osmolarity of the fluid each subject lost.

| Subject | Source of loss | Osmolarity of fluid lost (mOsm/L) |
| --- | --- | --- |
| 1 | isotonic fluid drained from the peritoneal cavity | 290 |
| 2 | eccrine sweat during exercise in heat | 95 |
| 3 | urine passed during an osmotic diuresis | 600 |

Which subject is predicted to pass the smallest volume of the most concentrated urine in the hours that follow?

- **A.** Subject 1
- **B.** Subject 2  <- **KEY**
- **C.** Subject 3
- **D.** All three alike, since each lost the same 2.0 L

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 105 s |
| Confidence | 5 |

**Correct answer (B): Subject 2**

Citations: AP:8366; AP:8369; AP:53341; AP:53364

**Distractors**

- **(A)** `partial_truth` . _volume signal alone, no reinforcing osmotic signal_: An isotonic loss does trigger conservation, but only one of the two inputs is engaged, so the urine is not driven to the concentrated extreme.
  - Citation: AP:53341
- **(C)** `reversed_relationship` . _concentrated loss assumed to concentrate the remainder_: Losing fluid richer in particles than the body fluid leaves the remainder more dilute, which opposes rather than reinforces water conservation.
  - Citation: AP:53364
- **(D)** `misconception` . _equal volume lost implies equal renal response_: Ignores composition entirely; identical volumes with different particle content produce different concentration signals and different urine.
  - Citation: AP:8366

**Readback check.** The key is a subject label, Subject 2, so it contains no content words of six or more letters at all and nothing can be copied from the stem to produce it. The table supplies osmolarity values only; the answer is a property of urine that is not in the table, so it cannot be read off directly. The student must convert a lost-fluid osmolarity below baseline into a rise in the concentration of the fluid remaining, which is the required inferential step.

**Explanation (as shipped).**

> This item belongs to Organ Systems and tests how the particle content of a lost fluid, and not merely its volume, shapes the urine the kidney then produces. The answer is B because sweat carries away far more water than particles, so the fluid left behind is concentrated up, and that concentration signal reinforces the volume signal instead of fighting it. Every one of the three has lost the same 2.0 L, so all three share a reduced circulating volume and all three will hold back salt and water to some degree. What separates them is what the loss did to the fluid that stayed. Subject 1 lost fluid at the same 290 mOsm/L as the starting value, so the particles per litre of what remains are unchanged and only the volume input is driving conservation. Subject 3 lost fluid at 600 mOsm/L, richer in particles than the body fluid it came from, which leaves the remainder thinner than normal; the concentration input therefore pushes toward getting rid of water and partly cancels the volume input. Subject 2 lost fluid at 95 mOsm/L, so almost all of what left was water; the remaining fluid is concentrated, and both inputs now demand maximum water recovery in the collecting duct. Aligned signals give the smallest, most concentrated urine. (Choice A) An isotonic loss engages only one of the two inputs. Conservation certainly occurs, but without a concentration deficit to add to it the urine will not be driven as far toward its concentrated extreme as in the sweating subject. (Choice C) This inverts the effect of losing a fluid richer in particles than the body fluid it came from. That loss dilutes the remainder, and a dilute remainder argues for excreting water, which works against maximal concentration. (Choice D) This treats volume as the only thing that matters. Equal volumes lost do not mean equal composition lost, and the composition determines whether the second input adds to the first or subtracts from it. This is a Data-based and Statistical Reasoning question because it requires comparing three measured osmolarity values against a common baseline to rank the urine profiles those losses produce.

---

## Q3 . Water load and collecting duct permeability

**Stem.** A healthy adult drinks 1.5 L of plain water within fifteen minutes. Forty minutes later her plasma osmolarity has fallen to 279 mOsm/L, and the medullary interstitium is as salty as it was before the drink. What becomes of the surplus water?

- **A.** It is drawn back into the circulation from the final tubule segment, and urine output falls.
- **B.** It leaves in urine that stays close to plasma in concentration, because the medullary gradient still pulls water out.
- **C.** It is cleared mainly by a rise in filtration at the glomerulus, with tubular handling unchanged.
- **D.** It runs through the final tubule segment without being reclaimed and leaves as a large volume of urine well below plasma in concentration.  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **easy** (topic core / structural two_step) |
| Estimated time | 70 s |
| Confidence | 5 |

**Correct answer (D): It runs through the final tubule segment without being reclaimed and leaves as a large volume of urine well below plasma in concentration.**

Citations: AP:52994; AP:53341; AP:53364; AP:52212

**Distractors**

- **(A)** `reversed_relationship` . _water recovery increased in a water-loaded subject_: Reclaiming water would deepen the measured dilution instead of correcting it, so the response runs in the wrong direction.
  - Citation: AP:53341
- **(B)** `partial_truth` . _gradient present, permeability ignored_: The medullary gradient is intact, but water cannot follow it across a segment whose water route has been closed, so urine does not stay near plasma concentration.
  - Citation: AP:53364
- **(C)** `misconception` . _filtration rate as the disposal lever_: Filtration is held steady across ordinary swings; surplus water is disposed of by reducing tubular recovery, not by filtering more.
  - Citation: AP:52994

**Readback check.** Content words of six or more letters in the key: through, segment, without, reclaimed, leaves, volume, plasma, concentration. Of these, only plasma and concentration appear in the stem, and both also appear in choice B, so neither is distinctive to the key; segment appears in choice A as well. The stem deliberately avoids naming the final tubule segment and avoids naming any hormone, so the key cannot be produced by echoing a structure named in the stem. The inferential step is recognising that an intact gradient is useless when the water route is closed.

**Explanation (as shipped).**

> This item belongs to Organ Systems and tests what the last segment of the nephron does when the body is carrying more water than it needs. The answer is D because the final water recovery step is the only one that can be switched on and off from minute to minute, and closing it leaves the water already inside the tubule with nowhere to go except out. About two thirds of filtered water is reclaimed early in the tubule regardless of what the body needs, and that fraction does not swing when someone drinks. What does change is the water permeability of the last stretch of tubule, the stretch that runs back down through the salty medulla. When that stretch is permeable, the concentrated surroundings pull water out of it and the urine ends up small in volume and concentrated. When permeability is withdrawn, the same fluid slides past the identical gradient sealed off from it, so the dilute fluid delivered onward from the ascending limb stays dilute and is voided in bulk. The gradient in this scenario is intact; what changed is access to it. (Choice A) This runs the control loop backwards. Reclaiming water from an adult who has just drunk a litre and a half would worsen the dilution already measured rather than correct it. (Choice B) The gradient is indeed still present, but a gradient can only move water across a membrane the water can cross. With the water route closed, an osmotic difference on the far side of an impermeable wall does nothing, so the urine is not held near plasma concentration. (Choice C) Filtration is deliberately stabilised against ordinary swings so that the tubule sees a steady load, and a drink of water does not push it upward. Excess water is disposed of by changing what the tubule gives back, not by changing what the glomerulus hands it. This is a Scientific Reasoning and Problem Solving question because it asks the student to trace a measured fall in plasma concentration through to the specific tubular step that is altered and the urine that results.

---

## Q4 . Obligatory urine volume caps water conservation

**Stem.** A castaway on a raft has no drinking water. Her tissues generate about 600 mOsm of waste solute each day, all of which must leave the body in urine, and her kidneys can concentrate urine to a maximum of 1200 mOsm/L. Water leaves through skin and breath at about 0.9 L per day and carries essentially no solute with it, while metabolism returns only about 0.25 L of water per day. Over the next two days, what happens to her urine volume and her plasma osmolarity?

- **A.** Urine output stops altogether, because water conservation at its ceiling closes the final tubule to all fluid loss.
- **B.** Urine volume settles near 0.5 L each day, and plasma osmolarity holds at baseline, because concentrating the urine matches every route of water loss.
- **C.** Urine volume settles near 0.5 L each day, but plasma osmolarity still climbs, because excreting the daily solute load obliges a water loss that conservation cannot abolish.  <- **KEY**
- **D.** Urine volume settles near 0.5 L each day, and plasma osmolarity falls, because the water she holds back is not matched by any solute she holds back.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 110 s |
| Confidence | 5 |

**Correct answer (C): Urine volume settles near 0.5 L each day, but plasma osmolarity still climbs, because excreting the daily solute load obliges a water loss that conservation cannot abolish.**

Citations: AP:52254; AP:54766; AP:54770; AP:54710

**Distractors**

- **(A)** `misconception` . _maximal conservation read as no urine at all_: Waste solute can leave only dissolved in water, so conservation makes urine minimal and concentrated rather than abolishing it.
  - Citation: AP:54770
- **(B)** `partial_truth` . _obligatory volume right, water balance ignored_: Correctly identifies the 0.5 L floor but ignores that 1.4 L still leaves against 0.25 L returning, a net water loss that must raise concentration.
  - Citation: AP:54710
- **(D)** `reversed_relationship` . _conservation assumed to dilute when there is no water intake_: Retention dilutes only when water is being taken in; with no intake the conserved water is water lost more slowly, so osmolarity rises rather than falls.
  - Citation: AP:52254

**Readback check.** Content words of six or more letters in the key: volume, settles, plasma, osmolarity, climbs, excreting, solute, obliges, conservation, cannot, abolish. Of these, solute and osmolarity appear in the stem, but solute also appears in choice D and osmolarity appears in choices B and D, so neither singles out the key; conservation appears in choice A. The stem supplies two numbers and states no direction of change, so the key cannot be lifted from it. The student must divide 600 by 1200 and then compare total water leaving against total water returning.

**Explanation (as shipped).**

> This item belongs to Organ Systems and tests the ceiling on what water conservation can achieve while the body still has waste to dispose of. The answer is C because the daily solute load can only leave dissolved in water, so dividing that load by the highest concentration the kidney can reach fixes a floor under urine volume that no amount of conservation can drop below. Take the floor first: 600 mOsm of solute divided by a maximum of 1200 mOsm per litre gives 0.5 L of urine per day, and that half litre must be passed even though the body can spare no water at all. Now total the books. Water out is the 0.5 L of obligatory urine plus 0.9 L through skin and breath, or 1.4 L, while water in is only the 0.25 L returned by metabolism, leaving a net shortfall of roughly 1.15 L each day. Total body solute, by contrast, does not change, because the 600 mOsm excreted is exactly what her tissues generated. A body losing water while holding its particle count steady must become more concentrated, so plasma osmolarity climbs day by day and the deficit compounds across the two days. (Choice A) Maximal conservation makes urine small and concentrated, not absent. Flow cannot stop, because the waste solute has no other exit and can travel only dissolved in water. (Choice B) This gets the obligatory volume right but stops one step short. Conservation slows the loss, it does not balance the books: 1.4 L leaving against 0.25 L returning is still a net water loss, and losing water alone raises concentration rather than holding it steady. (Choice D) This borrows reasoning that applies only when water is available to retain. Holding water back does dilute the body fluids when there is a supply to hold on to, but with no intake the conserved fraction is merely water that left more slowly, not water that was added. This is a Scientific Reasoning and Problem Solving question because it asks the student to convert a daily solute load and a maximum urine concentration into a floor on urine volume, then use that floor to decide which way plasma concentration must move.

---

## Q5 . Avascular epidermis fed by diffusion

**Stem.** A scrape that removes only the outermost 0.1 mm of forearm skin weeps clear fluid but never bleeds, and cells recovered from the outer surface of the removed material contain no nuclei. A cut 1 mm deep at the same site bleeds at once. Which account best explains both the absence of bleeding and the state of those surface cells?

- **A.** The surface layer of the skin holds no vessels of its own; its cells depend on nutrients diffusing upward from the tissue below, so cells far from that boundary cannot stay alive, and blood escapes only when an injury crosses into the tissue that carries the supply.  <- **KEY**
- **B.** Capillary loops run all the way to the skin surface but are too narrow for blood to escape from an injury that shallow.
- **C.** Cells lying deepest die first because they are farthest from atmospheric oxygen, while surface cells stay alive by taking oxygen directly from the air.
- **D.** Surface cells are dead because friction wears them down, and the scrape does not bleed because too little tissue was taken to open anything.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 85 s |
| Confidence | 5 |

**Correct answer (A): The surface layer of the skin holds no vessels of its own; its cells depend on nutrients diffusing upward from the tissue below, so cells far from that boundary cannot stay alive, and blood escapes only when an injury crosses into the tissue that carries the supply.**

Citations: AP:7932, AP:7947, AP:8069

**Distractors**

- **(B)** `misconception`: Students commonly picture capillaries reaching the skin surface. The outermost layer is genuinely avascular, and vessel calibre has nothing to do with whether a shallow wound bleeds.
  - Citation: AP:7932
- **(C)** `reversed_relationship`: It runs the supply gradient backwards: nutrients and oxygen arrive from the vascular tissue below, so the deepest cells are the living ones and the outermost are dead.
  - Citation: AP:7947
- **(D)** `partial_truth`: Surface cells are indeed shed by abrasion, but they are already dead before shedding, and the volume of tissue lost does not determine bleeding; depth does.
  - Citation: AP:8062

**Readback check.** Key content words of six or more letters: surface, vessels, depend, nutrients, diffusing, upward, tissue, boundary, injury, crosses, carries, supply. The stem contains scrape, removes, outermost, forearm, recovered, surface, removed, material, nuclei, absence, bleeding, account, explains. Overlap is limited to surface, which also appears in choices B, C and D, so it does not single out the key; the distinctive causal terms of the key (vessels, nutrients, diffusing, boundary) appear nowhere in the stem, and the key cannot be produced by restating any stem phrase.

**Explanation (as shipped).**

> This item sits in Organ Systems and tests how the outermost skin layer is supplied and what that predicts about the depth of an injury. The answer is A because that layer holds no vessels at all, so its cells live on nutrients and oxygen that diffuse upward from the vascularised tissue beneath, and blood can only escape once a wound crosses into that tissue. Distance from the supply therefore sets viability: cells sitting closest to the boundary occupy the steepest part of the gradient and remain metabolically active, while cells displaced far outward are progressively cut off from oxygen and nutrients and die, which is exactly why the most superficial cells of the scraped material contain no nuclei. The clear weeping is interstitial fluid seeping up through the boundary rather than blood, and weeping without bleeding is the signature of an injury that stopped short of the supplying tissue. A cut deep enough to reach that tissue opens vessels immediately, so depth rather than area decides whether a skin injury bleeds.
>
> (Choice B) No capillary loops enter the outermost layer. If vessels did reach the surface, the most superficial cells would be the best supplied rather than the least, and even the shallowest abrasion would bleed.
>
> (Choice C) This inverts the direction of the gradient. Oxygen for these cells arrives from below in tissue fluid, not from the atmosphere, so the cells nearest the deeper tissue are the living ones and the outwardly displaced cells are the ones that die.
>
> (Choice D) Mechanical wear does strip surface cells away, but it fails to explain why those cells are already dead before they are shed, and the amount of tissue removed is irrelevant to bleeding: a pinprick removes almost nothing yet bleeds freely because it crosses the boundary.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to infer a supply route and a viability gradient from two clinical observations about how deep an injury must go before blood appears.

---

## Q6 . Cornification as intracellular chemical transformation

**Stem.** A dye that binds DNA is applied to one living cell deep in the skin's outer layer, and that same cell is followed for four weeks as it is displaced toward the surface. Over that time the label disappears and the cell becomes flatter, drier and mechanically tougher, yet it is never swapped for a different cell. What has happened inside this one cell?

- **A.** It divided repeatedly on its way outward, so the label was diluted among its descendants and the toughening reflects how tightly those descendants are packed.
- **B.** It suffocated once it neared the surface, and the toughening is passive drying of a cytoplasm that is otherwise chemically unchanged.
- **C.** It secreted its contents outward and was left as an empty shell, with the toughness supplied by the thickened plasma membrane alone.
- **D.** Its nucleus and organelles were dismantled in place while cross linked fibrous protein and lipid granules accumulated, converting the interior into a tough, water resistant mass.  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 65 s |
| Confidence | 5 |

**Correct answer (D): Its nucleus and organelles were dismantled in place while cross linked fibrous protein and lipid granules accumulated, converting the interior into a tough, water resistant mass.**

Citations: AP:8040, AP:8047, AP:8058

**Distractors**

- **(A)** `process_step_confusion`: Substitutes proliferation for the intracellular conversion; dividing cells pass the nuclear label to their descendants rather than losing it, and the stem tracks a single cell.
  - Citation: AP:8047
- **(B)** `misconception`: Treats the end state as passive death by drying, but the protein loading and organelle breakdown are active, energy requiring events in a still living cell.
  - Citation: AP:8040
- **(C)** `partial_truth`: Lipid is genuinely discharged and the membrane does thicken, but the cell interior is packed with protein rather than emptied, so the toughness is not membrane derived.
  - Citation: AP:8044

**Readback check.** Key content words of six or more letters: nucleus, organelles, dismantled, fibrous, protein, granules, accumulated, converting, interior, resistant. The stem contains applied, living, displaced, surface, disappears, flatter, mechanically, tougher, swapped, different, happened. There is no overlap, so no distinctive content word is shared between stem and key and the key cannot be recovered by restating the stem.

**Explanation (as shipped).**

> This item belongs to Organ Systems and tests cornification as a chemical and structural conversion occurring inside a single cell. The answer is D because the changes described happen within one tracked cell rather than by exchange of one cell for another: the nucleus and the rest of the organelles are actively degraded, while fibrous protein is synthesised, cross linked into bundles, and packed into the cytoplasm alongside lipid rich granules that are discharged between neighbouring cells. Loss of the DNA label is the direct readout of nuclear breakdown, and it is decisive here because the cell was never exchanged for another one. The mechanical toughening and the dryness come from that accumulated protein scaffold, and the lipid discharged around the cells supplies the sealant that resists water movement. The cell therefore ends its life as a flattened, protein filled, anucleate unit that is still doing useful mechanical and sealing work, which is why this end state is best treated as a programmed conversion rather than as simple death.
>
> (Choice A) Division would not remove a nuclear label from a lineage, since each descendant would inherit both DNA and dye, and the stem explicitly follows one cell rather than a lineage.
>
> (Choice B) Suffocation with passive drying would leave organelles recognisable and would not account for the large gain in structural protein, which requires synthesis while the cell is still alive.
>
> (Choice C) The plasma membrane does thicken and lipid is released, but the interior is not emptied; it is filled with protein, and an empty shell would collapse rather than resist abrasion.
>
> This is a Knowledge of Scientific Concepts and Principles question because it asks the student to name the internal chemical and structural changes that convert a living cell of the outer skin into a tough surface unit.

---

## Q7 . Stratum corneum as the water barrier

**Stem.** Adhesive tape is pressed onto a patch of forearm skin and pulled off repeatedly, lifting away successive sheets of the outermost cells. Water crossing the patch is then measured at roughly ten times the rate measured before the procedure, the patch does not bleed, and the cell layers beneath appear structurally normal under the microscope.

Which of the following are supported by these observations?

I. Most of the water that normally crosses intact skin passes through the material the tape lifted away.
II. The layers left behind, by themselves, restrain water movement poorly.
III. The rise in water crossing the patch is caused by injury to the vessels supplying it.

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
| Estimated time | 100 s |
| Confidence | 5 |
| Hard-tier gate | Meets (a) by combining barrier localisation with the vascular depth of the injury; meets (b) because the tenfold magnitude relative to the thinness of the removed sheet drives the inference; meets (c) because statement III stays defensible until the no-bleeding observation is applied; also meets (d), reasoning from an outcome back to its site. |

**Correct answer (B): I and II only**

Citations: AP:8058, AP:8044, AP:54710

**Distractors**

- **(A)** `partial_truth`: Correctly accepts statement I but omits statement II, which the same measurement supports directly: structurally normal deeper layers are leaking water tenfold faster.
  - Citation: AP:8058
- **(C)** `misconception`: Endorses statement III, attributing the water loss to damaged vessels, which the absence of bleeding rules out, and abandons the correct localisation in statement I.
  - Citation: AP:7932
- **(D)** `partial_truth`: Gets statements I and II right but adds statement III, which cannot hold for an injury confined above the vascular tissue and would have produced bleeding.
  - Citation: AP:8062

**Readback check.** The key is the string 'I and II only', which contains no content words of six or more letters, so no stem word can appear in it and no phrase can be copied out of the stem to produce it. Selecting it requires evaluating three separate propositions against two independent observations: the magnitude of the change and the absence of bleeding.

**Explanation (as shipped).**

> This item falls under Organ Systems and tests which part of the skin actually limits water loss. The answer is B because a tenfold rise in water crossing the patch after only the most superficial cells are removed places the resistance in the removed material, and the fact that intact deeper layers cannot hold that water back shows those layers contribute little resistance on their own. Statement I follows from the size of the change relative to how little tissue was taken: if the deeper layers carried most of the resistance, stripping a thin superficial sheet could only produce a small increase. Statement II is the same measurement read from the other side, since the remaining layers are structurally normal yet now leak water at ten times the previous rate. Statement III fails on the observation that the patch does not bleed, which places the injury above the vascular tissue entirely; the escaping water is moving outward from tissue fluid across a surface that has lost its seal, not spilling from opened vessels. The practical consequence is that a person whose superficial layer is damaged loses water far faster than expected even though nothing deeper is wrong.
>
> (Choice A) This stops short. Accepting statement I while rejecting statement II ignores that the same measurement is direct evidence about how weakly the remaining layers resist water, since those layers are intact and still leaking.
>
> (Choice C) Including statement III contradicts the absence of bleeding, and dropping statement I leaves the tenfold rise without a source; taken together this choice misattributes a surface sealing failure to a vascular one.
>
> (Choice D) Statements I and II are sound, but statement III cannot be rescued: a stripping injury that never reaches vascular tissue cannot damage vessels, and vessel damage would produce bleeding rather than a quiet rise in water crossing the surface.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to localise the skin's water barrier by weighing the size of a measured change against how little tissue was removed and against the absence of bleeding.

---

## Q8 . Burn area scaling of fluid loss

**Stem.** Fluid lost through burned skin is collected from four patients whose burns have destroyed the surface seal over different fractions of the body surface, with no replacement given for the first several hours. Blood sodium in all four is 140 mmol/L at the time of collection.

| Fraction of body surface burned | Fluid lost through skin (mL/h) | Sodium in that fluid (mmol/L) |
|---|---|---|
| none | 25 | 15 |
| 10 percent | 130 | 15 |
| 25 percent | 300 | 15 |
| 40 percent | 470 | 15 |

What urine should the 40 percent patient produce after several unreplaced hours, and why?

- **A.** A large volume of dilute urine, because sodium leaving through the wound lowers the solute content of the blood.
- **B.** A reduced volume of urine whose solute content matches the blood closely, because water and sodium leave the wound in the same ratio in which the blood holds them.
- **C.** A small volume of urine considerably more concentrated than the blood it was filtered from, because the fluid leaving through the wound removes proportionally more water than salt.  <- **KEY**
- **D.** Urine settling at about 15 mmol/L of sodium, because urine ends up matching the fluid that is being lost.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **medium** (topic core / structural multi_step) |
| Estimated time | 110 s |
| Confidence | 4 |

**Correct answer (C): A small volume of urine considerably more concentrated than the blood it was filtered from, because the fluid leaving through the wound removes proportionally more water than salt.**

Citations: AP:8744, AP:8756, AP:54710

**Distractors**

- **(A)** `reversed_relationship`: Reverses the direction of the osmotic change: losing fluid far more dilute than blood raises the remaining solute concentration, so a dilute diuresis is the opposite of what follows.
  - Citation: AP:54710
- **(B)** `partial_truth`: Correct that volume falls, but it assumes the lost fluid matches blood in composition, which the 15 versus 140 mmol/L comparison contradicts.
  - Citation: AP:8744
- **(D)** `adjacent_fact`: Takes a genuine value from the table and applies it to the wrong compartment; urine composition is set by tubular handling, and 15 mmol/L would be near maximal dilution rather than the concentration the deficit demands.
  - Citation: AP:8746

**Readback check.** Key content words of six or more letters: volume, considerably, concentrated, filtered, leaving, through, removes, proportionally. The stem and table contain collected, patients, destroyed, surface, different, fractions, replacement, several, sodium, burned, produce, unreplaced. Overlap is limited to through, generic scenery shared with the other choices; the discriminating terms concentrated and proportionally appear nowhere in the stem, and no table value can be copied out to produce the key.

**Explanation (as shipped).**

> This item sits in Organ Systems and tests reading a scaling relationship out of a table and predicting the renal response to it. The answer is C because the table shows two things at once: the hourly loss climbs roughly in step with the burned fraction, reaching about nineteen times the intact rate at 40 percent, and every sample carries only 15 mmol/L of sodium against 140 mmol/L in the blood. Fluid that dilute is close to free water, so at 470 mL/h the patient sheds roughly 470 mL of water but only about 7 mmol of sodium each hour. Blood volume therefore falls while the sodium left behind is packed into a shrinking volume, and both changes push the tubule the same way: reclaim water while still excreting the day's obligatory solute load. The only way to clear that solute in very little water is to raise urine concentration well above that of blood, so the predicted output is scanty and strongly concentrated. Note that the ceiling on concentrating power sets a floor on urine volume, so output falls sharply but never to zero.
>
> (Choice A) This runs the direction backwards. The fluid escaping is far more dilute than blood, so the loss raises rather than lowers the solute concentration of what remains, and a dilute diuresis would deepen the deficit.
>
> (Choice B) Volume does fall, but the premise is wrong: 15 mmol/L against 140 mmol/L is not the ratio the blood holds, so the loss is disproportionately water and the urine must end up more concentrated than blood, not equal to it.
>
> (Choice D) This reads a number straight off the table and applies it to the wrong compartment. Urine concentration is set by what the tubule reabsorbs and secretes, not by the composition of fluid escaping elsewhere, and 15 mmol/L would represent near maximal dilution when the situation demands the opposite.
>
> This is a Data-based and Statistical Reasoning question because it asks the student to compare loss rates across burned fractions and to weigh the sodium content of the lost fluid against the blood value before predicting the direction of the renal response.

---

## Q9 . Sweat tonicity and rehydration osmolarity swing

**Stem.** A runner completes a 3 hour race in warm conditions, loses 3.0 L of sweat, and afterwards drinks 3.0 L of pure water. Values measured on this runner before the race are shown.

| Fluid | Sodium (mmol/L) | Osmolarity (mOsm/L) |
| --- | --- | --- |
| Plasma | 140 | 290 |
| Sweat | 45 | 105 |

How does plasma osmolarity compare with its pre-race value at the end of the race, and again once the water has been taken in?

- **A.** Higher than 290 mOsm/L at the end of the race, then back to 290 mOsm/L
- **B.** Lower than 290 mOsm/L at the end of the race, then higher than 290 mOsm/L
- **C.** Higher than 290 mOsm/L at the end of the race, then lower than 290 mOsm/L  <- **KEY**
- **D.** Still 290 mOsm/L at the end of the race, then lower than 290 mOsm/L

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 105 s |
| Confidence | 5 |
| Hard-tier gate | (a) combines two concepts, the tonicity of sweat and the effect of replacing lost volume with solute free fluid; (b) requires a directional and semi-quantitative inference from the tabulated concentrations rather than a lookup; (c) choices A and D both remain defensible until the student applies the specific fact that sweat osmolarity is roughly a third of plasma osmolarity. |

**Correct answer (C): Higher than 290 mOsm/L at the end of the race, then lower than 290 mOsm/L**

Citations: AP:8366; AP:8369; AP:54882

**Distractors**

- **(A)** `partial_truth` . _right first stage, wrong endpoint_: Gets the rise during sweating right but assumes restoring volume with plain water also restores the lost solute, so it predicts a return to baseline instead of an undershoot.
  - Citation: AP:8369
- **(B)** `reversed_relationship` . _both directions inverted_: Requires sweat to be hypertonic to plasma and pure water to raise osmolarity, both of which are the opposite of the tabulated and physiological facts.
  - Citation: AP:8369
- **(D)** `misconception` . _sweat treated as an isotonic plasma filtrate_: Treats sweat as if it were plasma leaving the body, which would leave osmolarity unchanged during the loss; the table shows sweat is far more dilute than plasma.
  - Citation: AP:8366

**Readback check.** Key text: 'Higher than 290 mOsm/L at the end of the race, then lower than 290 mOsm/L'. Content words of six or more letters in the key: 'Higher' only ('lower' is five letters, 'mOsm/L' is a unit token). 'Higher' does not appear in the stem and it also appears in choice A, so it carries no discriminating signal. The stem supplies no directional language at all. The value 290 is tabulated, but the key is not a lookup: the student must form the solute-to-water ratio of sweat against plasma and apply it twice, once to the loss and once to the solute free replacement.

**Explanation (as shipped).**

> This item sits in Organ Systems and tests how the tonicity of sweat sets the direction of the plasma osmolarity change at two different stages of a race. The answer is C because sweat carries proportionally more water than solute out of the body, so the fluid left behind becomes concentrated, and refilling that volume with solute free water afterwards dilutes it below where it started. Compare the two rows: every liter of plasma holds 290 mOsm of solute, while every liter of sweat carries only about 105 mOsm. Losing 3.0 L of sweat therefore removes 3.0 L of water but only about 315 mOsm of solute, far less than the roughly 870 mOsm that 3.0 L of plasma would have contained. The solute remaining in the body is now dissolved in a smaller total volume, so at the end of the race plasma osmolarity sits above 290 mOsm/L. Drinking 3.0 L of pure water then returns total body water to its starting point while returning none of the missing 315 mOsm, so the same body water now holds less solute than it did before the race and osmolarity settles below 290 mOsm/L. This two stage swing is the physiology behind the dilutional fall in plasma sodium seen in endurance athletes who cover large sweat losses with plain water.
>
> (Choice A) reads the first stage correctly but assumes that restoring volume also restores solute. Plain water supplies no sodium and no other osmotically active particles, so the endpoint cannot be the original value.
>
> (Choice B) reverses both stages. It would require sweat to be more concentrated than plasma, which the table contradicts, and it would require pure water to raise osmolarity rather than lower it.
>
> (Choice D) reflects the common assumption that sweat is essentially plasma leaving the body. If that were so, osmolarity would indeed hold steady while sweating, but at 105 mOsm/L the sweat is roughly a third as concentrated as the plasma it derives from, so the loss cannot be neutral.
>
> This is a Data-based and Statistical Reasoning question because it asks the student to compare the tabulated solute concentrations of sweat and plasma and use that comparison to predict the direction of the osmolarity change at two successive points in the scenario.

---

## Q10 . Cumulative sweat sodium loss and the limits of tubular conservation

**Stem.** Over an eight hour shift in a foundry a worker loses about 8 L of sweat containing 50 mmol/L of sodium. He replaces the volume exactly, drinking 8 L of a commercial drink containing 20 mmol/L of sodium. Blood drawn at the end of the shift shows a high circulating aldosterone level acting on the collecting duct, and glomerular filtration rate is unchanged from baseline. What is the state of this worker's total body sodium and plasma sodium concentration, and what can the tubule do about it?

- **A.** Total body sodium has fallen by roughly 240 mmol and plasma sodium concentration is below normal; the tubule can strip the urine of sodium almost completely, but that only halts further loss  <- **KEY**
- **B.** Total body sodium has fallen by roughly 240 mmol but plasma sodium concentration is above normal, because each liter of sweat removes proportionally more salt than it removes water
- **C.** Plasma sodium concentration is below normal, but raising tubular reabsorption on its own will return it to normal, because the sodium filtered each day far exceeds the amount lost in sweat
- **D.** Total body sodium is essentially unchanged, because a secretion of only 50 mmol/L is far too dilute to represent a meaningful salt loss across a single shift

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 100 s |
| Confidence | 4 |
| Hard-tier gate | (a) combines the composition of sweat with distal tubular sodium handling; (b) requires a two part quantitative step (8 L times 50 mmol/L against 8 L times 20 mmol/L) followed by a directional inference about concentration; (c) choices C and D both stay defensible until the student separates concentration from absolute amount and separates reabsorption from net gain. |

**Correct answer (A): Total body sodium has fallen by roughly 240 mmol and plasma sodium concentration is below normal; the tubule can strip the urine of sodium almost completely, but that only halts further loss**

Citations: AP:8369; AP:53374; AP:53376; AP:54882

**Distractors**

- **(B)** `reversed_relationship` . _tonicity of sweat inverted_: Claims sweat removes proportionally more salt than water, which would raise plasma sodium concentration; sweat is hypotonic to plasma, so the opposite holds.
  - Citation: AP:8369
- **(C)** `misconception` . _reabsorption mistaken for net acquisition_: Treats a large filtered load as a source of new sodium; reabsorption only returns sodium the body already holds and cannot replace what left through the skin.
  - Citation: AP:53376
- **(D)** `scale_unit_error` . _per liter concentration judged as total quantity_: Judges the loss by the per liter figure rather than by the accumulated volume, missing that eight hours of secretion multiplies a dilute concentration into a deficit of several hundred millimoles.
  - Citation: AP:54882

**Readback check.** Key text: 'Total body sodium has fallen by roughly 240 mmol and plasma sodium concentration is below normal; the tubule can strip the urine of sodium almost completely, but that only halts further loss'. Content words of six or more letters: 'sodium', 'roughly', 'plasma', 'concentration', 'normal', 'tubule', 'completely', 'further'. Only 'sodium' and 'plasma' appear in the stem, and 'sodium' appears in every choice, so neither is a distinctive stem-to-key echo. 'concentration', 'tubule' and 'completely' are absent from the stem. Aldosterone is handed to the student in the stem so that no hormone name can be the key. The stem never states the net sodium quantity, the direction of the concentration change, or the limit on renal recovery; all three must be inferred.

**Explanation (as shipped).**

> This item sits in Organ Systems and tests why a dilute secretion can still create a substantial salt deficit, and what tubular handling of that salt can and cannot correct. The answer is A because 8 L at 50 mmol/L carries away about 400 mmol of sodium while the replacement drink returns only 8 L at 20 mmol/L, or about 160 mmol, leaving a net deficit near 240 mmol with total body water back at its starting point. Concentration and amount are separate quantities: a fluid far more dilute than plasma can still, secreted for hours on end, remove a large absolute quantity. With sodium reduced and water restored, plasma sodium concentration must sit below its normal value. The high aldosterone level reaching the collecting duct raises sodium movement out of the tubular fluid, and the urine can be stripped of sodium almost completely, which is the appropriate renal response. That response only halts further loss, however, because the tubule reclaims sodium that has already been filtered from the blood and can do nothing about sodium carried off through the skin. Normal concentration returns when sodium is taken in, or when the surplus water is passed in urine.
>
> (Choice B) has the direction of the concentration change backwards. Sweat is hypotonic to plasma, so per liter it removes proportionally more water than salt, and the fall in concentration here comes from replacing that volume with a fluid poorer in sodium than what was lost.
>
> (Choice C) is right about the direction of the change but wrong about the remedy. The filtered load each day is indeed enormous, yet reabsorption only returns sodium that was already inside the body; no degree of reabsorption can add back sodium that has left through the skin.
>
> (Choice D) mistakes a modest concentration for a modest quantity. Fifty millimoles per liter is low next to plasma, but multiplied across eight liters it becomes a loss of several hundred millimoles, more than enough to call up maximal renal conservation.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to convert two per liter sodium concentrations into a net cumulative deficit and then decide which part of that deficit tubular reabsorption is actually able to reverse.

---

## Q11 . Distinguishing the two sweat gland populations by their deficits

**Stem.** Two people attend a dermatology clinic. Patient 1 was born without functional sweat glands over the general body surface. Patient 2 has a separate population of glands that has stopped working; those glands are confined to the axillae and groin, became active only at puberty, and empty into hair follicles. What consequences are expected for each?

- **A.** Both overheat readily in warm weather, because each gland population contributes to thermoregulatory secretion
- **B.** Patient 1 produces little body odor but tolerates heat normally, while Patient 2 overheats readily in warm weather
- **C.** Patient 1 overheats readily in warm weather and also produces little body odor, while Patient 2 is essentially unaffected
- **D.** Patient 1 overheats readily in warm weather, while Patient 2 produces little body odor but tolerates heat normally  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic secondary / structural direct) |
| Estimated time | 65 s |
| Confidence | 5 |

**Correct answer (D): Patient 1 overheats readily in warm weather, while Patient 2 produces little body odor but tolerates heat normally**

Citations: AP:8366; AP:8379; AP:6696; BIO:38267

**Distractors**

- **(A)** `misconception` . _both gland types treated as cooling glands_: Assumes the regional, follicle associated glands contribute meaningfully to cooling; their small surface coverage and viscous secretion make them negligible for heat loss.
  - Citation: AP:8379
- **(B)** `reversed_relationship` . _consequences assigned to the wrong patient_: Attaches the odor defect to the person missing the body wide glands and the heat intolerance to the person whose regional glands failed, which inverts both assignments.
  - Citation: AP:6696
- **(C)** `partial_truth` . _correct heat prediction, wrong odor source_: Correct that Patient 1 overheats, but wrongly makes the watery body wide secretion the source of odor; that secretion is mostly water and salt and offers bacteria little to act on.
  - Citation: AP:8369

**Readback check.** Key text: 'Patient 1 overheats readily in warm weather, while Patient 2 produces little body odor but tolerates heat normally'. Content words of six or more letters: 'Patient', 'overheats', 'readily', 'weather', 'produces', 'little', 'tolerates', 'normally' ('odor' is four letters). Only 'Patient' appears in the stem, and it appears in choices B and C as well, so it is not a distinctive echo. The words 'overheats', 'weather', 'tolerates' and 'odor' are all absent from the stem. The stem describes each gland population purely by distribution, timing of onset and outlet, and never names either secretion or what it does, so the key states a consequence that is nowhere present in the stem rather than restating a stem fact.

**Explanation (as shipped).**

> This item sits in Organ Systems and tests the division of labor between the two populations of sweat glands and what each one's absence would cost. The answer is D because the glands spread across the whole body surface produce the thin, watery secretion whose vaporization cools the skin, while the glands restricted to the axillae and groin release a thicker, organic rich fluid into hair follicles, where resident skin bacteria break it down and generate odor. Removing the first population takes away the principal route for shedding heat in warm conditions, so Patient 1 overheats. Removing the second takes away the material the bacteria act on, so Patient 2 loses body odor; because those glands occupy only small regions of the body and secrete a fluid poorly suited to vaporizing, their loss costs nothing in heat tolerance. The pubertal timing given in the stem fits the same split, since the follicle associated glands stay quiet through childhood while the body wide glands work from infancy onward.
>
> (Choice A) assumes both populations contribute to cooling. The follicle associated glands cover a small fraction of the total surface and secrete a viscous fluid, so their contribution to heat loss is negligible even when they are working normally.
>
> (Choice B) swaps the two consequences, assigning the odor defect to the person lacking the body wide glands and the heat intolerance to the person whose regional glands have failed.
>
> (Choice C) predicts overheating in Patient 1 correctly but wrongly attaches the loss of odor to the same person. The secretion of the body wide glands is largely water with a little salt and is not the substrate bacteria convert into odor.
>
> This is a Knowledge of Scientific Concepts and Principles question because it asks the student to hold the defining properties of each sweat gland population in mind and match each population to the specific deficit its absence would produce.

---

## Q12 . Direction of heat exchange when the surroundings are hotter than the skin

**Stem.** A foundry worker stands in a room where the air and every nearby surface sit at 45 degrees C, while his skin is at 35 degrees C. He is sweating heavily, and sweat is visibly running off his forearms and dripping to the floor. How does body heat change along each of the available routes of exchange?

- **A.** Sweat that runs off the skin removes heat just as well as sweat that leaves as vapor, so the rate of sweat production alone sets how much cooling he gets
- **B.** Every route that depends on a difference in warmth now delivers heat into the body, so the only net loss is the energy taken up when water changes to vapor at the skin  <- **KEY**
- **C.** Net heat loss continues along the difference in warmth, though more slowly than usual, so the change of water to vapor merely supplements it
- **D.** The energy removed as water changes to vapor is too small to matter in air this hot, so core temperature must climb whatever the sweating rate

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 85 s |
| Confidence | 4 |

**Correct answer (B): Every route that depends on a difference in warmth now delivers heat into the body, so the only net loss is the energy taken up when water changes to vapor at the skin**

Citations: AP:51086; AP:51107; AP:51109; AP:21211

**Distractors**

- **(A)** `misconception` . _sweat produced equated with sweat evaporated_: Assumes any sweat leaving the gland cools the body, ignoring that the large energy cost is paid only at the change of state; sweat that drips off removes almost no heat.
  - Citation: AP:51107
- **(C)** `partial_truth` . _gradient shrunk rather than reversed_: Recognises that the gradient has changed but treats it as merely smaller; the sign has flipped, making these routes a source of heat gain rather than slow loss.
  - Citation: AP:51086
- **(D)** `scale_unit_error` . _energy of the change of state underestimated_: Right that the other routes fail, but wrong about the magnitude of the energy carried off by the change of state, which is large enough to dominate heat loss during heavy exertion.
  - Citation: AP:51109

**Readback check.** Key text: 'Every route that depends on a difference in warmth now delivers heat into the body, so the only net loss is the energy taken up when water changes to vapor at the skin'. Content words of six or more letters: 'depends', 'difference', 'warmth', 'delivers', 'changes'. None appears in the stem, which uses only 'foundry', 'surface', 'degrees', 'sweating', 'visibly', 'running', 'forearms', 'dripping' and 'exchange'. The words 'temperature', 'vapor', 'energy' and 'evaporation' were deliberately kept out of the stem, and 'routes' in the stem is a neutral term shared with choice C. The stem states two numbers and a behaviour; the sign of the flow along each route and the exceptional status of the change of state must both be inferred.

**Explanation (as shipped).**

> This item sits in Organ Systems and tests the direction of heat flow along each exchange route once the surroundings are hotter than the body surface. The answer is B because every route other than vaporization moves heat down a gradient in warmth, and here that gradient runs the wrong way: air and surfaces at 45 degrees C are hotter than skin at 35 degrees C, so direct contact, air movement over the skin and infrared exchange all deposit heat into the body instead of drawing it out. Vaporization is the exception because it does not require the environment to be cooler at all. It consumes a large quantity of energy from the skin simply to lift water molecules out of the liquid state, and that energy leaves with the vapor regardless of how hot the surrounding air happens to be. This is why heavy sweating still works in a hot room, and why the thing that defeats it is high humidity, which stops water leaving the surface, rather than heat by itself.
>
> (Choice A) treats sweat production as if it were the same thing as sweat evaporation. The large energy cost is paid only at the moment molecules leave the liquid state, so sweat that beads up and falls to the floor carries away only the small amount of heat stored in the warm liquid itself and is essentially wasted.
>
> (Choice C) keeps the usual direction and merely slows it. The gradient has not simply shrunk, it has changed sign, so these routes represent a heat gain rather than a reduced heat loss, and vaporization is not a supplement but the whole of the net loss.
>
> (Choice D) underestimates the energy involved in the change of state. Converting water to vapor absorbs a large quantity of heat per gram, which is why a heavily sweating adult can shed heat at several times the resting rate as long as the vapor can escape.
>
> This is a Scientific Reasoning and Problem Solving question because it asks the student to assign a sign to the heat flow along each route using the two temperatures given and then identify the single route whose direction does not depend on that comparison.

---

## Q13 . Hypodermal fat depth and heat loss rate

**Stem.** Two adults with the same core temperature and the same cutaneous blood flow sit quietly in a 10 degree C room wearing identical clothing. One of them has a hypodermal fat layer of roughly twice the thickness of the other's. After twenty minutes the leaner adult's core reading has fallen further. Which of the following best explains the difference?

- **A.** Stored fat generates warmth on its own, so the adult carrying more of it adds heat internally at a higher rate.
- **B.** Heat travelling outward from the interior must cross the fatty layer, which conducts poorly, so a deeper layer slows escape at the same driving gradient.  <- **KEY**
- **C.** The heavier adult clamps down harder on the vessels of the skin, so less warmth is delivered to the outside of the body.
- **D.** Fat beneath the skin raises the ratio of surface to volume, so the heavier adult exchanges heat with the room more readily.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **medium** (topic core / structural two_step) |
| Estimated time | 85 s |
| Confidence | 5 |

**Correct answer (B): Heat travelling outward from the interior must cross the fatty layer, which conducts poorly, so a deeper layer slows escape at the same driving gradient.**

Citations: AP:8119, AP:8104, AP:6744

**Distractors**

- **(A)** `misconception`: Hypodermal white adipose is a storage and cushioning depot, not a tissue whose resting heat output exceeds that of surrounding tissue, so it cannot explain the slower cooling by adding warmth.
  - Citation: AP:8119
- **(C)** `adjacent_fact`: Cutaneous arteriolar calibre genuinely changes heat delivery to the surface, but the scenario states that blood flow to the skin is the same in both adults, so this mechanism is held constant and is irrelevant to the difference observed.
  - Citation: AP:8500
- **(D)** `reversed_relationship`: Added bulk lowers the ratio of surface to volume, and a raised ratio would accelerate exchange in the person who is in fact cooling more slowly, so both the geometry and the direction are backwards.
  - Citation: BIO:43134

**Readback check.** Content words of six or more letters in key B: travelling, outward, interior, conducts, poorly, deeper, escape, driving, gradient. Stem six-plus words: adults, temperature, cutaneous, quietly, degree, wearing, identical, clothing, hypodermal, roughly, thickness, twenty, minutes, leaner, reading, fallen, further, following, explains, difference. No overlap. The key cannot be produced by copying stem language; the student must infer that matching blood flow and clothing leaves shell depth as the operating variable.

**Explanation (as shipped).**

> This item sits in Organ Systems and tests the hypodermis as a physical barrier standing between the warm interior of the body and the environment. The answer is B because heat produced deep in the body can only leave through the shell that surrounds it, and adipose tissue passes heat poorly, so a deeper shell lowers the rate of escape even when everything driving that escape is identical. The scenario deliberately matches the two adults on the variables that set how much warmth arrives at the outside of the body: identical starting core readings, identical blood flow to the skin, identical clothing and identical room. What differs is only the depth of the fatty shell that heat must traverse on its way out. Body composition therefore acts as a variable in its own right, independent of how hard the circulatory or sweating effectors are working, and two people who look thermally identical on paper can drift apart in core reading at very different rates. (Choice A) White adipose tissue in the hypodermis is a storage depot and a cushion, not a furnace running at a higher rate than other tissue, so attributing the difference to extra warmth production inverts what the depot actually does. (Choice C) Differential constriction of skin vessels would indeed change how much heat reaches the outside, but the scenario holds cutaneous blood flow equal in the two adults, so this proposes a mechanism that has been experimentally excluded here. (Choice D) A larger, fatter body has a smaller, not a larger, ratio of surface to volume, and in any case a higher ratio would speed exchange in the person who is actually cooling more slowly, which reverses the observed direction. This is a Scientific Reasoning and Problem Solving question because the student must hold every driver of heat escape constant and reason that the remaining difference, the depth of the fatty shell, is what sets the rate at which the interior cools.

---

## Q14 . Piloerection and trapped still air

**Stem.** In a cold room the small muscles anchored to each hair follicle contract, and the visible result in a person is goose bumps. The identical reflex in a heavily coated mammal slows its loss of body warmth appreciably, whereas in the person the effect on warmth retention is close to nil. Which of the following best explains this difference?

- **A.** Standing the hairs upright holds a motionless pocket of air against the skin, and the depth of that pocket depends on how long and how dense the coat is.  <- **KEY**
- **B.** The contracting follicle muscles release warmth directly, and a coated animal has far more of these muscles per unit of body surface.
- **C.** Erect hairs enlarge the area available for exchange with the surroundings, which matters more in an animal covered in fur.
- **D.** The reflex exists to make a threatened animal appear larger, so any effect on warmth retention is incidental in both species.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 70 s |
| Confidence | 4 |

**Correct answer (A): Standing the hairs upright holds a motionless pocket of air against the skin, and the depth of that pocket depends on how long and how dense the coat is.**

Citations: AP:8306, AP:8308, AP:8420

**Distractors**

- **(B)** `misconception`: The arrector pili are minute smooth muscles whose contraction cannot supply a physiologically relevant amount of warmth, and the species difference lies in the coat itself, not in muscle density.
  - Citation: AP:8306
- **(C)** `reversed_relationship`: Increasing the area available for exchange would speed loss of body warmth, the opposite of the retention actually observed in the coated animal, and the reflex's real effect is to trap still air rather than to expand the exchanging surface.
  - Citation: AP:8308
- **(D)** `adjacent_fact`: The same reflex does make a frightened animal look larger, but that is a separate consequence and leaves unexplained why the coated animal genuinely conserves warmth in the cold.
  - Citation: AP:8309

**Readback check.** Content words of six or more letters in key A: standing, upright, motionless, pocket, against, depends. Stem six-plus words: anchored, follicle, contract, visible, result, person, identical, reflex, heavily, coated, mammal, warmth, appreciably, whereas, effect, retention, following, explains, difference. No overlap; coat and hairs fall under six letters and the stem never states that air is trapped or that insulation is the point, so the key is not recoverable by restatement.

**Explanation (as shipped).**

> This item sits in Organ Systems and tests what the arrector pili reflex actually accomplishes physically, and why the same reflex pays off in one species and not another. The answer is A because raising the hairs does not itself add warmth: it creates a still layer of air next to the skin, and air that is not moving is a poor carrier of warmth away from the body. The size of that motionless pocket scales with the length and density of the hair coat, which is why a dog or a cat gains real protection while a person, whose coat is sparse, gains almost none. The reflex in humans is a retained response whose insulating payoff has largely been lost, which is exactly why goose bumps are visible and useless at the same time. Nothing about the muscular contraction itself is different between the two species; only the structure it moves has changed. (Choice B) The tiny follicle muscles are far too small a mass for their contraction to be a meaningful source of warmth, and the difference between species lies in the hair coat rather than in muscle number. (Choice C) Raising the hairs does slightly change the outline of the surface, but the functional consequence is to hold air still rather than to enlarge exchange, and enlarging exchange would speed loss of warmth rather than slow it. (Choice D) Making the animal look bigger is a genuine consequence in a frightened cat, yet it is a separate use of the same reflex and cannot explain why the coated animal actually retains warmth better in the cold. This is a Knowledge of Scientific Concepts and Principles question because the student must recall what elevating the hair shafts does to the layer of air at the skin and apply that to a species whose coat can no longer hold such a layer.

---

## Q15 . Fever as an elevated set point

**Stem.** Over one hour after the onset of an infection, a patient's core reading climbs from 37.0 to 38.6 degrees C. Throughout that climb the skin is pale and cool to the touch, the patient piles on blankets, and the large muscles contract in rapid bursts. Which of the following best explains this presentation?

- **A.** Control of body warmth has broken down, and the responses seen during the climb are uncoordinated output from a damaged regulator.
- **B.** Cutaneous sensors are reporting the surrounding air rather than the interior, so the effectors are following the skin reading and ignoring the deep reading.
- **C.** The regulator's target value has been driven upward, so 38.6 still counts as too low and warmth conserving effectors run until the new target is met.  <- **KEY**
- **D.** Avenues of heat disposal are already open to their maximum, and the muscular bursts are an incidental by-product of the extra load being handled.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 95 s |
| Confidence | 5 |
| Hard-tier gate | Meets (a) it combines the comparator logic of negative feedback with the direction in which cutaneous, behavioural and muscular effectors are being driven; (c) choices A and B remain defensible until the student notices that the three responses are aligned rather than conflicting; (d) it inverts the usual direction of reasoning by giving the observed effector behaviour and asking what state of the controller produced it. |

**Correct answer (C): The regulator's target value has been driven upward, so 38.6 still counts as too low and warmth conserving effectors run until the new target is met.**

Citations: AP:1437, AP:1451, AP:51063, BIO:43875, BIO:43879

**Distractors**

- **(A)** `misconception`: Students commonly read fever as regulation failing, but failure would produce effectors pulling in conflicting directions, whereas all three responses here are coherently driving warmth upward.
  - Citation: AP:1451
- **(B)** `partial_truth`: Skin thermoreceptors genuinely feed the loop, but they cannot account for an hour of sustained rise in the deep reading, nor for why conserving responses persist once the deep value is already high.
  - Citation: BIO:47679
- **(D)** `reversed_relationship`: It places the surface route for heat disposal wide open when the pale cool skin reported in the scenario indicates the opposite, so the direction of the vascular response is inverted.
  - Citation: BIO:43879

**Readback check.** Content words of six or more letters in key C: regulator's, target, driven, upward, counts, warmth, conserving, effectors. Stem six-plus words: infection, patient's, reading, climbs, degrees, throughout, blankets, muscles, contract, bursts, following, explains, presentation. No overlap. The stem never uses the words set point, target, conserving or effector, and the key requires inferring the state of the regulator from the direction of three separate responses.

**Explanation (as shipped).**

> This item sits in Organ Systems and tests the logic of a regulated variable when the regulator's target itself is moved. The answer is C because a negative feedback loop compares the measured value with a target and drives its effectors in whichever direction closes the gap, so once the target is pushed above the current reading, the loop treats a perfectly warm body as too cool and recruits every warmth conserving response it has. That is precisely what the scenario shows: pale cool skin means the surface vessels are shut down so that warmth is held in, blanket seeking is the behavioural arm of the same drive, and rhythmic contraction of large muscles is the effector that raises internal warmth production. All three effectors point the same way, upward, which is the signature of an intact loop chasing a raised target rather than a broken one. This also explains the familiar sequence in which a person feels coldest while the reading is rising fastest, stops feeling cold once the reading reaches the new target, and finally feels hot and sweats when the target returns to normal and the same loop reverses to shed the surplus. (Choice A) Uncoordinated output from a damaged regulator would show effectors working against each other, whereas here the vascular, behavioural and muscular responses are aligned in a single direction, which is what an intact loop looks like. (Choice B) Sensors in the skin do contribute to the overall signal, but they cannot override a deep reading that is already well above the usual value for an entire hour, and this choice leaves unexplained why the target itself would have moved. (Choice D) The scenario states that the skin is pale and cool, which means the surface route for disposal is closed rather than wide open, so the premise of this choice contradicts the observation. This is a Scientific Reasoning and Problem Solving question because the student must read the direction in which several effectors are being driven and infer from that direction what has happened to the regulator's target.

---

## Q16 . Separating set point shift from heat overload

**Stem.** Two people arrive at a clinic, each with a core reading of 39.2 degrees C. One became unwell with a bacterial illness; the other collapsed after several hours of hard labour in a hot, poorly ventilated shed. An investigator wants to establish, for each person separately, whether the regulator's target has been pushed upward or whether the target is unchanged and warmth acquisition has simply outrun removal. Which of the following should the investigator do?

- **A.** Follow how high the core reading rises in each person over the next six hours.
- **B.** Count the circulating white cells in a blood sample from each person.
- **C.** Cool both people externally with ice packs and compare how quickly each core reading comes down.
- **D.** Record, before any treatment is given, whether each person's skin vessels and sweat glands are being driven toward retaining heat or toward unloading it.  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **medium** (topic secondary / structural two_step) |
| Estimated time | 100 s |
| Confidence | 4 |

**Correct answer (D): Record, before any treatment is given, whether each person's skin vessels and sweat glands are being driven toward retaining heat or toward unloading it.**

Citations: AP:1451, AP:51063, BIO:43879, AP:8500

**Distractors**

- **(A)** `misconception`: Peak height reflects how severe the disturbance is, not which mechanism produced it, and both a raised target and unchecked accumulation of warmth can reach comparable readings.
  - Citation: AP:51063
- **(B)** `adjacent_fact`: A white cell count reports on the presence of infection, which can accompany either situation, and gives no information about where the regulator's target currently sits.
  - Citation: BIO:43875
- **(C)** `partial_truth`: External cooling does lower the reading in both cases, but the rate of decline is governed by physical heat transfer and body build rather than by the target, and the intervention destroys the untouched state the investigator needs to read.
  - Citation: AP:1451

**Readback check.** Content words of six or more letters in key D: record, before, treatment, person's, vessels, glands, driven, toward, retaining, unloading. Stem six-plus words: people, arrive, clinic, reading, degrees, became, bacterial, illness, collapsed, several, labour, poorly, ventilated, investigator, establish, separately, whether, regulator's, target, pushed, upward, unchanged, warmth, acquisition, simply, outrun, removal, following, should. No six-plus content word is shared. The earlier draft's key contained warmth, which the stem also uses, so the key was reworded to retaining heat and unloading it; the key also avoids the stem's arrive by using before any treatment is given, and it cannot be produced by restating the stem.

**Explanation (as shipped).**

> This item sits in Organ Systems and tests how to design an observation that reveals the state of a controller rather than the value of the variable it controls. The answer is D because the core reading alone is identical in the two people and therefore carries no information about the target; what distinguishes them is the direction in which the loop is currently driving its output. If the target has been pushed upward, the loop reads 39.2 as still short of where it wants to be and keeps the surface vessels narrowed and sweating suppressed. If the target is unchanged and warmth has simply accumulated faster than it could be shed, the loop reads 39.2 as far too high and has the surface vessels open and the sweat glands running flat out. Reading the effectors at a fixed value of the controlled variable, before anything has been done to either person, is the manoeuvre that separates a moved target from a defeated one, because it removes the reading itself as a confounding difference between the two people. (Choice A) How far the reading eventually climbs is a matter of severity rather than of mechanism, and both a raised target and unchecked accumulation can reach similar peaks, so this observation does not discriminate. (Choice B) A white cell count can indicate that an infection is present, but infection and overwhelming heat exposure can coexist in the same person, and the count says nothing about where the regulator's target currently sits. (Choice C) External cooling removes warmth from both people by the same physical route, so the rate of decline mostly reports body size, surface contact and circulation rather than the position of the target, and applying an intervention also destroys the resting state the investigator needs to observe. This is a Reasoning about the Design and Execution of Research question because the student must choose the observation that isolates the controller's behaviour while holding the controlled variable itself constant across the two people.

---

## Q17 . Receptor depth and spatial resolution

**Stem.** Two closely spaced points pressed against a fingertip can be felt as separate only if each indentation deforms a different sensory ending. Mechanical deformation that must travel far through tissue spreads sideways as it descends, so at depth two small indentations merge into a single broad distortion. Which of the following cutaneous receptors are positioned so that two nearby indentations still reach them as distinct events?

I. Merkel discs
II. Meissner corpuscles
III. Pacinian corpuscles

- **A.** I only
- **B.** III only
- **C.** I and II only  <- **KEY**
- **D.** II and III only

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 1 |
| Difficulty | **easy** (topic core / structural direct) |
| Estimated time | 70 s |
| Confidence | 5 |

**Correct answer (C): I and II only**

Citations: AP:8463-8465; AP:25871-25875; BIO:47559-47564; BIO:47610

**Distractors**

- **(A)** `partial_truth` . _half the shallow pair_: Merkel discs are shallow, but Meissner corpuscles sit just as superficially in the dermal projections under the epidermis, so the answer is incomplete in a way that changes it.
  - Citation: BIO:47587
- **(B)** `reversed_relationship` . _deepest receptor chosen for finest detail_: Picks the deepest named receptor for the task that demands the shallowest position, relating depth and spatial resolution in the wrong direction.
  - Citation: BIO:47610
- **(D)** `adjacent_fact` . _sensitivity mistaken for resolution_: The Pacinian corpuscle's genuine, extreme sensitivity to tiny rapid displacements is a true fact about a different property; its depth still prevents it from resolving two nearby points.
  - Citation: BIO:47610-47613

**Readback check.** Key is the Roman numeral combination 'I and II only', which contains no content words of six or more letters, so no stem word can echo into it. The stem supplies the depth-to-detail physics but never states which receptor sits at which depth; that mapping is the tested step.

**Explanation (as shipped).**

> This Organ Systems question tests how the depth at which each named cutaneous receptor sits determines the spatial detail it can report. The answer is C because Merkel discs and Meissner corpuscles both lie at the very top of the skin: Merkel discs sit among the deepest epidermal cells, and Meissner corpuscles occupy the dermal projections immediately beneath the epidermis. A small contact at the surface reaches these endings after traveling almost no distance, so the mechanical distortion it produces is still narrow and local when it arrives. Two nearby contacts therefore deform two different shallow endings, which is the physical requirement the stem describes. Pacinian corpuscles, by contrast, lie in the deep dermis and the tissue beneath it. Deformation arriving from the surface spreads as it descends, so at that depth two contacts have already merged into one broad distortion, and no receptor there can tell them apart. That deep location instead suits the Pacinian corpuscle to stimuli that penetrate the whole tissue block, such as firm pressure and vibration. (Choice A) is incomplete. Merkel discs are indeed shallow, but Meissner corpuscles sit essentially at the same level, just under the epidermal border, and receive equally distinct deformation, so excluding them is unjustified. (Choice B) inverts the depth logic entirely: the Pacinian corpuscle is the deepest of the named receptors, so it is the one for which nearby contacts are least separable. (Choice D) pairs a correct choice with a wrong one. The Pacinian corpuscle's extreme sensitivity to tiny rapid displacements tempts students to credit it with spatial precision, but sensitivity and spatial resolution are independent properties, and depth abolishes the second no matter how great the first. This is a Knowledge of Scientific Concepts and Principles question because it asks the student to recall the depth at which each named skin receptor sits and to match that position against the physical requirement given in the stem.

---

## Q18 . Lamellar capsule as temporal filter

**Stem.** A mechanoreceptor located deep in the dermis is wrapped in dozens of concentric connective tissue layers separated by fluid. When a probe presses steadily into the overlying skin, the receptor's afferent fiber discharges briefly as the probe arrives, falls silent while the press is held, and discharges again when the probe lifts. Investigators propose that the wrapping is responsible: slow, held deformation is redistributed around the ending through the fluid layers and never reaches the axon terminal, while abrupt changes are transmitted through before redistribution can occur. To test this, they dissect the layers away and record from the bare ending. Which observation would support their proposal?

- **A.** During a held press, the bare ending generates a response that continues for as long as the press is maintained, unlike the intact receptor.  <- **KEY**
- **B.** The bare ending gives no response to any mechanical stimulus, whether held or abrupt.
- **C.** The bare ending responds only when the probe arrives and lifts, exactly as the intact receptor did.
- **D.** The bare ending responds during a held press only when the probe is driven several times deeper than before.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 3 |
| Difficulty | **medium** (topic secondary / structural two_step) |
| Estimated time | 90 s |
| Confidence | 4 |

**Correct answer (A): During a held press, the bare ending generates a response that continues for as long as the press is maintained, unlike the intact receptor.**

Citations: AP:8464; AP:25365; BIO:47610-47614

**Distractors**

- **(B)** `misconception` . _capsule as the transducer_: Assumes the capsule performs transduction, but the axon terminal is the transducing element; the layers only filter which deformations reach it, so the bare ending still responds.
  - Citation: BIO:47613
- **(C)** `adjacent_fact` . _rival hypothesis outcome_: This outcome would show the temporal behavior is intrinsic to the ending, a result relevant to the alternative explanation and therefore incapable of supporting the wrapping proposal.
  - Citation: BIO:47612
- **(D)** `scale_unit_error` . _magnitude for timescale_: Treats the wrapping as setting the required stimulus size rather than the required rate of change, swapping a magnitude property for the temporal property actually under test.
  - Citation: BIO:47612-47613

**Readback check.** Content words of six or more letters in the key: generates, response, continues, maintained, intact, receptor. Of these, 'response' and 'receptor' also appear in the stem but recur across the other options, so neither marks the key; 'generates', 'continues', and 'maintained' appear nowhere in the stem. The answer cannot be found by phrase matching; it requires deducing which firing pattern the filtering hypothesis predicts for the stripped preparation.

**Explanation (as shipped).**

> This Organ Systems question tests whether the student can identify the experimental result that would implicate the layered capsule of the deep dermal vibration receptor, the Pacinian corpuscle, as a mechanical filter. The answer is A because the proposal makes a specific prediction: the silence during a held press is imposed by the wrapping, not by the nerve ending itself. If that is true, then stripping the wrapping away should unmask an ending that signals steadily whenever it is deformed, while only the intact preparation confines its activity to the moments of change. Observing a continuous response from the bare ending during a held press, alongside onset and offset responses from the intact corpuscle, is exactly the dissociation the proposal predicts. The fluid filled layers absorb and redistribute slow deformation so that only rapid change gets through to the terminal, and this construction is why the intact receptor answers vibration while ignoring a steady load. (Choice B) reflects the misconception that the capsule itself performs the sensory transduction. The terminal of the afferent fiber is the transducing element; the layers merely govern which deformations reach it, so their removal should not abolish responsiveness altogether. (Choice C) is the result predicted by the rival account, in which the decline during a held stimulus is intrinsic to the ending itself. If the bare ending behaved identically to the intact receptor, the wrapping would be contributing nothing temporal, and the proposal would be undermined rather than supported. (Choice D) recasts the wrapping as a device that sets how large a stimulus must be rather than how fast it must change. A deeper press differs in magnitude, not in time course, so this observation would speak to stimulus strength, which is not the property the proposal claims the layers control. This is a Reasoning about the Design and Execution of Research question because it asks the student to determine which recorded outcome of a dissection experiment would support one proposed mechanism over its alternative.

---

## Q19 . Deficit pattern localizing receptor loss

**Stem.** A patient with a selective fingertip neuropathy undergoes quantitative sensory testing, with results shown below.

| Test | Affected hand | Unaffected hand |
| --- | --- | --- |
| Two-point threshold, sustained caliper | 14 mm | 3 mm |
| Detection of gentle 30 Hz flutter | Normal | Normal |
| Detection of 250 Hz vibration | Normal | Normal |
| Detection of skin stretch across the digit | Normal | Normal |

Loss of which receptor population best accounts for this pattern?

- **A.** Free nerve endings
- **B.** Meissner corpuscles
- **C.** Pacinian corpuscles
- **D.** Merkel discs  <- **KEY**

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 4 |
| Difficulty | **hard** (topic core / structural multi_step) |
| Estimated time | 100 s |
| Confidence | 5 |
| Hard-tier gate | (b) requires directional inference from a data pattern rather than a lookup; (c) Meissner and Pacinian remain defensible until the flutter and vibration rows and the sustained nature of the caliper are specifically applied; (d) reasoning is inverted, from an observed deficit back to the receptor that must be missing. |

**Correct answer (D): Merkel discs**

Citations: BIO:47561-47564; BIO:47587-47591; BIO:47599-47601; BIO:47610-47613

**Distractors**

- **(A)** `adjacent_fact` . _wrong modality receptor_: Free nerve endings serve pain and temperature, modalities not tested in the table; their loss cannot explain a spatial discrimination deficit for blunt touch.
  - Citation: AP:25364-25365
- **(B)** `partial_truth` . _the other shallow receptor_: Correctly shallow and touch related, but preserved 30 Hz flutter detection shows Meissner corpuscles are working, and their rapid adaptation silences them during a held press, so the sustained caliper task cannot rest on them.
  - Citation: BIO:47587-47591
- **(C)** `partial_truth` . _vibration receptor misapplied_: A genuine touch mechanoreceptor, but preserved 250 Hz vibration detection shows it is intact, and its deep position rules it out as the substrate of two-point separation regardless.
  - Citation: BIO:47610-47613

**Readback check.** Key is 'Merkel discs'; the word Merkel appears nowhere in the stem or table, and no table row names any receptor, so no row can be read off as the answer. The student must map each preserved test to the receptor it exonerates and the failed test to the receptor it implicates.

**Explanation (as shipped).**

> This Organ Systems question tests whether a pattern of preserved and lost sensory capacities can be traced back to the one receptor class whose position and construction fit the missing function. The answer is D because the only failed test is fine spatial discrimination under a steadily applied stimulus, and that job belongs to Merkel discs. They sit at the base of the epidermis, shallow enough that the deformation from each caliper tip is still narrow when it arrives, and each ending reports from a small, sharply bounded patch of skin, so two tips a few millimetres apart normally engage separate endings. They are also slowly adapting, continuing to signal for as long as a stimulus is held, which is exactly what a sustained caliper demands. With Merkel discs gone, the held tips cannot be resolved until they are far apart, while every other tested capacity persists because its receptor class remains intact. (Choice A) Free nerve endings mediate pain and temperature; their loss would blunt pinprick and thermal sensation, neither of which was tested here, and they contribute nothing to separating two blunt points. (Choice B) Meissner corpuscles are also shallow and serve fine touch, so they are tempting, but the normal detection of gentle low frequency flutter shows they are functioning, and they adapt rapidly, falling silent while a stimulus is held, so a sustained caliper press must be reported by slowly adapting endings rather than by them. (Choice C) Pacinian corpuscles are excluded twice over: normal detection of 250 Hz vibration shows they work, and their position deep in the dermis means the deformation reaching them from two nearby tips has already merged, so they could not support two-point separation even when healthy. This is a Data-based and Statistical Reasoning question because it requires reading a table of spared and impaired sensory results and inferring which single receptor loss is consistent with every row at once.

---

## Q20 . Supranuclear pigment cap geometry

**Stem.** In the deepest layer of the epidermis, the only epidermal cells that still divide accumulate pigment clustered in a cap on the side of the nucleus facing the skin surface. Compared with the same quantity of pigment spread evenly through all layers of the epidermis, what advantage does this placement provide?

- **A.** It positions the pigment to catch rays that have already passed the nuclei, shielding the underlying dermis from injury.
- **B.** It interposes an absorbing shield between arriving rays and the genomes of the cells whose uncorrected damage would be inherited by every cell they subsequently produce.  <- **KEY**
- **C.** It keeps the pigment out of superficial cells, which are continuously shed, so the investment in pigment lasts longer before being lost.
- **D.** It brings the pigment close enough to the genetic material of dividing cells to speed the enzymatic correction of any injury that occurs.

| | |
|---|---|
| AAMC Foundation | 3B |
| Content category | Organ Systems |
| Cognitive skill | 2 |
| Difficulty | **hard** (topic secondary / structural two_step) |
| Estimated time | 90 s |
| Confidence | 5 |
| Hard-tier gate | (a) combines radiation shielding geometry with epidermal renewal biology; (c) choices A and C remain defensible until the direction of the light path and the disposability of superficial cells are applied; (d) reasoning runs from an observed arrangement back to the function that explains it. |

**Correct answer (B): It interposes an absorbing shield between arriving rays and the genomes of the cells whose uncorrected damage would be inherited by every cell they subsequently produce.**

Citations: AP:7990-7996; AP:8155-8158

**Distractors**

- **(A)** `reversed_relationship` . _shield behind the target_: Places the protective function after the rays have passed the nucleus, inverting the source-to-target geometry that makes a shield effective, and protects a tissue whose injuries division does not multiply.
  - Citation: AP:8157
- **(C)** `partial_truth` . _true premise, wrong conclusion_: Superficial cells really are shed, but that fact makes their protection unnecessary rather than making pigment economy the reason for deep placement; the geometry serves shielding of persistent dividing cells.
  - Citation: AP:8155-8158
- **(D)** `misconception` . _pigment as repair enzyme_: Melanin prevents injury by absorbing and dissipating energy; it has no catalytic role in correcting genetic damage, which is handled by dedicated repair enzymes.
  - Citation: AP:8157-8158

**Readback check.** Content words of six or more letters in the key: interposes, absorbing, shield, arriving, genomes, uncorrected, damage, inherited, subsequently, produce. None appears in the stem, which never mentions light, damage, or protection mechanisms; the student must supply the external mutagen and the consequence of division to select the key.

**Explanation (as shipped).**

> This Organ Systems question tests why melanin accumulates as a cap above the nucleus inside the dividing basal cells of the epidermis rather than being distributed indiscriminately. The answer is B because the threat the pigment counters, ultraviolet light, arrives from outside the body, and the cells that most need defending are the ones that go on dividing. A basal cell that acquires an unrepaired change to its genetic sequence copies that change into both daughters, and their descendants replace the entire overlying epidermis, so a single injured basal cell can seed a permanent and expanding population of altered cells, including the ones from which skin cancers arise. Cells above the basal layer face the opposite fate: they have left the cycle, are moving outward, and will be shed within weeks, so injury to them departs with them. An absorbing cap parked between the incoming light and the basal nucleus therefore concentrates protection exactly where injury would be perpetuated, a far better use of a fixed amount of pigment than diluting it through layers whose cells are disposable. (Choice A) reverses the geometry: a shield is useful only when it sits between the source and the target, and rays that have already passed a basal nucleus have already done whatever harm they will do to it. The dermis is also the wrong target, since its injuries are not multiplied by epidermal division. (Choice C) starts from a true observation, that superficial cells are shed, but draws the wrong conclusion from it: shedding is precisely why superficial cells need little protection, and the point of the deep placement is to guard the cells that persist, not to economize on pigment turnover. (Choice D) assigns the pigment a repair function it does not have. It absorbs and dissipates incoming energy before injury occurs, while correction of injury that does occur is carried out by enzymes unrelated to pigment. This is a Scientific Reasoning and Problem Solving question because it requires connecting the geometry of an absorbing structure to the renewal biology of the epidermis to explain why one arrangement protects better than another.

---

