# Biology Ch12 — Genetics & Evolution · Batch 3 Verification Audit
**Subtopics:** Mutations · Hardy-Weinberg Equilibrium · Genetic Drift & Population Change  
**Source:** OpenStax Biology 2e · Foundation 1C

25/25 shipped. Hardy-Weinberg calculations re-worked by verifiers. Letters 6/7/6/6, difficulty 7E/10M/8H.

---

## Q1 — Mutations · **easy** · Skill 2 · 75s · conf 5
**Stem:** A geneticist sequencing the human β-globin gene in a healthy individual finds a single-base substitution at the third nucleotide of one codon, yet the codon still specifies the same amino acid as the reference sequence. Which outcome is this substitution most likely to have on the encoded β-globin protein?

- **A.** No change in the amino acid sequence ✅
- **B.** Replacement of one amino acid by another
- **C.** Early termination of the protein
- **D.** A shifted translational reading frame

**Correct (A):** openstax-biology-2e.txt lines 17484-17486: "Some point mutations are not detectable in the final product; these are known as silent mutations. Silent mutations are usually due to a substitution in the third base of a codon, which often represents the same amino acid as the original codon." Supported by lines 17944-17945: "Codons that specify the same amino acid typically only differ by one nucleotide."

**Distractors:**
- **B** — _adjacent_fact_: This is the outcome of a non-silent point mutation, not a silent one. OpenStax lines 17486-17487 state 'Other point mutations can result in the replacement of one amino acid by another, which may alter the function of the protein,' but the stem specifies the codon still encodes the SAME amino acid, so no replacement occurs.  
  ↳ openstax-biology-2e.txt lines 17486-17487: "Other point mutations can result in the replacement of one amino acid by another, which may alter the function of the protein."
- **C** — _adjacent_fact_: This describes a nonsense mutation that creates a premature stop codon, a different point-mutation outcome. OpenStax lines 17487-17488 state 'Point mutations that generate a stop codon can terminate a protein early,' but a silent third-base substitution does not create a stop codon.  
  ↳ openstax-biology-2e.txt lines 17487-17488: "Point mutations that generate a stop codon can terminate a protein early."
- **D** — _process_step_confusion_: A frameshift results only from an insertion or deletion that alters the reading frame, not from a single-base substitution. OpenStax lines 17492-17494 tie frameshifts to insertions/deletions, so a substitution cannot shift the reading frame.  
  ↳ openstax-biology-2e.txt lines 17492-17494: "Mutations can also be the result of the addition of a base, known as an insertion, or the removal of a base, also known as deletion. If an insertion or deletion results in the alteration of the translational reading frame (a frameshift mutation), the resultant protein is usually nonfunctional."

**Explanation:** This is a Biology question that falls under the content category 'Transmission of Heritable Information from Generation to Generation.' The answer is A because a single-base substitution in the third base of a codon that still specifies the same amino acid is a silent mutation, which the textbook describes as a point mutation that is "not detectable in the final product." OpenStax states that "Silent mutations are usually due to a substitution in the third base of a codon, which often represents the same amino acid as the original codon," so the β-globin protein's amino acid sequence is unchanged. This redundancy reflects the degeneracy of the genetic code, in which "codons that specify the same amino acid typically only differ by one nucleotide." (Choice A) is correct: because the substituted codon encodes the same amino acid, the protein sequence is not altered and the mutation is silent. (Choice B) describes a different point-mutation outcome — "Other point mutations can result in the replacement of one amino acid by another, which may alter the function of the protein" — but that requires the codon to specify a new amino acid, which is not the case here. (Choice C) describes a nonsense outcome, since "Point mutations that generate a stop codon can terminate a protein early," but a silent substitution does not create a stop codon. (Choice D) describes a frameshift, which arises only from an insertion or deletion that alters the reading frame, not from a single-base substitution. This is a Scientific Reasoning and Problem Solving question because you must apply the definition of a silent mutation and the degeneracy of the genetic code to predict the protein-level consequence of a specific third-base substitution.

---

## Q2 — Mutations · **medium** · Skill 2 · 105s · conf 5
**Stem:** A child with beta-thalassemia carries a hemoglobin allele in which a single base substitution changes the codon CAG (glutamine) to UAG within the coding region, so the ribosome releases a truncated beta-globin chain. This single-base change is best classified as which type of mutation?

- **A.** Silent mutation
- **B.** Nonsense mutation ✅
- **C.** Frameshift mutation
- **D.** Chromosomal translocation

**Correct (B):** openstax-biology-2e.txt lines 17487-17488: "Point mutations that generate a stop codon can terminate a protein early." Lines 17929-17930: stop codons (UAA, UAG, UGA) "terminate protein synthesis and release the polypeptide from the translation machinery. These triplets are called nonsense codons, or stop codons."

**Distractors:**
- **A** — _adjacent_fact_: A silent mutation does not change the protein product; OpenStax says silent mutations are 'not detectable in the final product' and 'often represents the same amino acid as the original codon.' Here the protein is truncated, so the change is detectable and not silent.  
  ↳ openstax-biology-2e.txt lines 17484-17486: "Some point mutations are not detectable in the final product; these are known as silent mutations. Silent mutations are usually due to a substitution in the third base of a codon, which often represents the same amino acid as the original codon."
- **C** — _process_step_confusion_: A frameshift is caused by an insertion or deletion that alters the reading frame, not by a single base substitution. The scenario changes one base within a codon without shifting the frame, so it cannot be a frameshift.  
  ↳ openstax-biology-2e.txt lines 17492-17494: "If an insertion or deletion results in the alteration of the translational reading frame (a frameshift mutation), the resultant protein is usually nonfunctional."
- **D** — _scale_unit_error_: A translocation is a chromosome-level rearrangement in which a DNA segment moves to another chromosome or region, not a single-base codon change. The scenario describes one base substitution, which is a point-level event.  
  ↳ openstax-biology-2e.txt lines 17494-17496: "Sometimes a piece of DNA from one chromosome may get translocated to another chromosome or to another region of the same chromosome; this is also known as translocation."

**Explanation:** This is a Biology question that falls under the content category 'Transmission of Heritable Information from Generation to Generation.' The answer is B because the substitution converts a codon that specified an amino acid (CAG, glutamine) into UAG, one of the three stop codons, so translation halts and a shortened protein is released. OpenStax states that "Point mutations that generate a stop codon can terminate a protein early" (openstax-biology-2e.txt, lines 17487-17488), and that the nonsense codons UAA, UAG, and UGA "terminate protein synthesis and release the polypeptide from the translation machinery" (lines 17929-17930). Because only one base pair is altered, this is a point mutation, and the specific outcome of a premature stop codon defines it as a nonsense mutation. (Choice A) Silent mutations are "usually due to a substitution in the third base of a codon, which often represents the same amino acid as the original codon" and are "not detectable in the final product" (lines 17484-17486); here the protein is clearly altered (truncated), so it is not silent. (Choice B) is correct: a point mutation that generates a stop codon terminates the protein early, matching the CAG-to-UAG change that releases a truncated chain (lines 17487-17488). (Choice C) A frameshift requires an insertion or deletion that alters "the translational reading frame," and "the resultant protein is usually nonfunctional" (lines 17492-17494); a single base substitution does not shift the reading frame, so this is not a frameshift. (Choice D) A translocation occurs when "a piece of DNA from one chromosome may get translocated to another chromosome or to another region of the same chromosome" (lines 17494-17496); a single base substitution within one codon is not a chromosome-level rearrangement. This is a Scientific Reasoning and Problem Solving question because you must apply the definitions of mutation types to a specific codon change to infer the mechanism that produced the truncated protein.

---

## Q3 — Mutations · **hard** · Skill 2 · 150s · conf 5
**Stem:** A researcher studying a human disease gene compares two mutant alleles: allele 1 carries a single-nucleotide insertion early in the coding sequence, and allele 2 carries a three-nucleotide insertion at the same position. Allele 1 produces a nonfunctional protein, whereas allele 2 produces a nearly full-length, partially functional protein. Which mechanism best accounts for why the single-nucleotide insertion is the more deleterious of the two?

- **A.** It substitutes one amino acid for another
- **B.** It silently alters a third-base codon position
- **C.** It shifts the reading frame for every downstream codon ✅
- **D.** It translocates the gene to another chromosome

**Correct (C):** OpenStax Biology 2e, lines 17492-17493: "If an insertion or deletion results in the alteration of the translational reading frame (a frameshift mutation), the resultant protein is usually nonfunctional." Lines 17914-17917: "The insertion of one or two nucleotides completely changed the triplet reading frame, thereby altering the message for every subsequent amino acid... Though insertion of three nucleotides caused an extra amino acid to be inserted during translation, the integrity of the rest of the protein was maintained." Lines 17514-17515: "A frameshift mutation that results in the insertion of three nucleotides is often less deleterious than a mutation that results in the insertion of one nucleotide."

**Distractors:**
- **A** — _adjacent_fact_: Replacing one amino acid with another describes a point-mutation substitution, not an insertion, and it typically changes a single residue rather than every downstream codon, so it does not explain why the single insertion is dramatically more deleterious than the +3 insertion.  
  ↳ OpenStax Biology 2e, lines 17486-17487: 'Other point mutations can result in the replacement of one amino acid by another, which may alter the function of the protein.'
- **B** — _reversed_relationship_: A silent third-base substitution often encodes the same amino acid and is undetectable in the final product, which would make the protein LESS affected, not more deleterious; this reverses the direction of the effect.  
  ↳ OpenStax Biology 2e, lines 17484-17486: 'Some point mutations are not detectable in the final product; these are known as silent mutations. Silent mutations are usually due to a substitution in the third base of a codon, which often represents the same amino acid as the original codon.'
- **D** — _misconception_: Moving a piece of DNA to another chromosome is translocation, a separate mutation type; a single-nucleotide insertion does not relocate the gene, so this misidentifies the mechanism behind the frameshift.  
  ↳ OpenStax Biology 2e, lines 17494-17496: 'Sometimes a piece of DNA from one chromosome may get translocated to another chromosome or to another region of the same chromosome; this is also known as translocation.'

**Explanation:** This is a Biology question that falls under the content category 'Transmission of Heritable Information from Generation to Generation.' The answer is C because a single-nucleotide insertion alters the translational reading frame, so that every codon downstream of the insertion is misread, and the resulting protein is usually nonfunctional. OpenStax states that "If an insertion or deletion results in the alteration of the translational reading frame (a frameshift mutation), the resultant protein is usually nonfunctional" (Biology 2e, lines 17492-17493). By contrast, an insertion of three nucleotides preserves the reading frame: "Though insertion of three nucleotides caused an extra amino acid to be inserted during translation, the integrity of the rest of the protein was maintained" (lines 17916-17917), which is why "A frameshift mutation that results in the insertion of three nucleotides is often less deleterious than a mutation that results in the insertion of one nucleotide" (lines 17514-17515). The insertion of one or two nucleotides "completely changed the triplet reading frame, thereby altering the message for every subsequent amino acid" (lines 17914-17915). (Choice A) is incorrect: substituting one amino acid for another describes a point-mutation substitution, not an insertion, and a single substitution typically affects only one residue rather than the entire downstream sequence (lines 17486-17487). (Choice B) is incorrect: a silent third-base substitution often specifies the same amino acid and is "not detectable in the final product," so it would make the protein less deleterious, not more (lines 17484-17486). (Choice C) is correct: shifting the reading frame causes every subsequent codon to be misread, usually yielding a nonfunctional protein, while keeping the frame intact (the +3 insertion) preserves the rest of the protein (lines 17492-17493, 17914-17917). (Choice D) is incorrect: relocation of DNA to another chromosome describes translocation, a distinct mutation type, and is not what an insertion of one nucleotide does (lines 17494-17496). This is a Scientific Reasoning and Problem Solving question because you must apply the relationship between insertion length and reading-frame integrity to explain why two similar mutations differ so sharply in their effect on protein function.

---

## Q4 — Mutations · **medium** · Skill 2 · 105s · conf 5
**Stem:** A patient with sickle-cell anemia produces a full-length hemoglobin beta chain in which the glutamate normally found at position six is replaced by valine, and this is the only difference from the normal beta-chain sequence. On the basis of this single amino acid change in an otherwise intact chain, the underlying DNA alteration is most consistent with

- **A.** a silent change leaving protein unchanged
- **B.** a frameshift from a deleted base
- **C.** a point mutation creating a stop codon
- **D.** a base substitution swapping one amino acid ✅

**Correct (D):** openstax-biology-2e.txt lines 4371-4385: "valine in the β chain substitutes the amino acid glutamic... a single base change (point mutation)... In normal hemoglobin, the amino acid at position six is glutamate. In sickle cell hemoglobin glutamate is replaced by valine." Lines 17480, 17486-17487: "substitutions, in which one base is replaced by another... Other point mutations can result in the replacement of one amino acid by another, which may alter the function of the protein."

**Distractors:**
- **A** — _misconception_: A silent mutation leaves the amino acid sequence unchanged, but sickle-cell clearly substitutes valine for glutamate, so the change cannot be silent.  
  ↳ openstax-biology-2e.txt lines 17484-17486: "Some point mutations are not detectable in the final product; these are known as silent mutations. Silent mutations are usually due to a substitution in the third base of a codon, which often represents the same amino acid as the original codon."
- **B** — _process_step_confusion_: A deletion causing a frameshift alters the reading frame and usually yields a nonfunctional protein with many altered residues, not a single amino acid swap in an otherwise normal full-length chain.  
  ↳ openstax-biology-2e.txt lines 17491-17493: "If an insertion or deletion results in the alteration of the translational reading frame (a frameshift mutation), the resultant protein is usually nonfunctional."
- **C** — _adjacent_fact_: A point mutation that generates a stop codon terminates the protein early, producing a truncated chain, whereas the patient makes a full-length beta chain.  
  ↳ openstax-biology-2e.txt line 17488: "Point mutations that generate a stop codon can terminate a protein early."

**Explanation:** This is a Biology question that falls under the content category 'Transmission of Heritable Information from Generation to Generation.' The answer is D because sickle-cell hemoglobin arises from a point mutation, a single-base substitution in which one base is replaced by another, and the textbook states that such point mutations 'can result in the replacement of one amino acid by another, which may alter the function of the protein.' The textbook specifies that 'In normal hemoglobin, the amino acid at position six is glutamate. In sickle cell hemoglobin glutamate is replaced by valine,' a 'single amino acid substitution' produced by 'a single base change (point mutation).' Because exactly one amino acid changes and the rest of the beta chain is intact and full length, the data point to a base substitution that swaps one amino acid for another, not a shift in reading frame or an early termination. (Choice A) is incorrect because silent mutations are 'not detectable in the final product' and leave the amino acid unchanged, yet here glutamate is clearly replaced by valine. (Choice B) is incorrect because a frameshift from a deleted base 'results in the alteration of the translational reading frame,' making the 'resultant protein usually nonfunctional' with many downstream residues altered, not a single substitution in an otherwise full-length chain. (Choice C) is incorrect because a point mutation that generates a stop codon would 'terminate a protein early,' producing a truncated chain rather than the full-length beta chain described. (Choice D) is correct: a single-base substitution replaced glutamate with valine, the classic point-mutation mechanism of sickle-cell hemoglobin. This is a Scientific Reasoning and Problem Solving question because you must apply the definitions of point, silent, frameshift, and nonsense mutations to reason from the observed single amino acid change to the underlying DNA alteration.

---

## Q5 — Mutations · **easy** · Skill 1 · 70s · conf 5
**Stem:** A geneticist examines a patient's karyotype and finds that a segment that normally belongs to chromosome 9 has detached and reattached to chromosome 22, a different, nonhomologous chromosome. This chromosomal mutation is classified as a

- **A.** translocation. ✅
- **B.** inversion.
- **C.** duplication.
- **D.** point mutation.

**Correct (A):** OpenStax Biology 2e, Section 13.2 (Chromosomal Basis of Inherited Disorders), lines 16430-16435: "Translocations / A translocation occurs when a chromosome segment dissociates and reattaches to a different, nonhomologous chromosome. Translocations can be benign or have devastating effects depending on how the positions of genes are altered with respect to regulatory sequences."

**Distractors:**
- **B** — _adjacent_fact_: An inversion keeps the segment on the same chromosome; it is detached, rotated 180 degrees, and reinserted, changing only gene orientation, not the chromosome it sits on. The stem describes a segment moving to chromosome 22, so it cannot be an inversion.  
  ↳ OpenStax Biology 2e, Section 13.2, lines 16362-16366: "Chromosome Inversions / A chromosome inversion is the detachment, 180° rotation, and reinsertion of part of a chromosome... Unless they disrupt a gene sequence, inversions only change gene orientation."
- **C** — _adjacent_fact_: A duplication produces an extra copy of a chromosomal segment; the original segment in the stem is relocated, not copied, so no gain of genetic material occurs as described.  
  ↳ OpenStax Biology 2e, Section 13.2, lines 16337-16339: "Duplications and Deletions / In addition to losing or gaining an entire chromosome, a chromosomal segment may duplicate or lose itself. Duplications and deletions often produce offspring that survive but exhibit abnormalities."
- **D** — _scale_unit_error_: A point mutation acts at the single-base-pair level, not at the scale of a whole chromosome segment; the stem describes relocation of a multi-gene segment between chromosomes, which is far larger than a single base change.  
  ↳ OpenStax Biology 2e, Section 14.6, line 17479: "Point mutations are those mutations that affect a single base pair."

**Explanation:** This is a Biology question that falls under the content category 'Transmission of Heritable Information from Generation to Generation.' The answer is A because a translocation occurs when a chromosome segment dissociates and reattaches to a different, nonhomologous chromosome, which is exactly what happens when a segment moves from chromosome 9 to chromosome 22. The textbook states that "A translocation occurs when a chromosome segment dissociates and reattaches to a different, nonhomologous chromosome" and that such rearrangements can be benign or damaging depending on how gene positions shift relative to regulatory sequences. (Choice A) is correct: the defining feature of a translocation is the transfer of a segment to a nonhomologous chromosome, matching the 9-to-22 movement described. (Choice B) is wrong because a chromosome inversion is "the detachment, 180° rotation, and reinsertion of part of a chromosome"; the segment stays on its own chromosome and only changes orientation rather than moving to a different chromosome. (Choice C) is wrong because in a duplication "a chromosomal segment may duplicate," producing an extra copy of genetic material, whereas the patient's segment was relocated without being copied. (Choice D) is wrong because a point mutation is a mutation that "affect[s] a single base pair," a change at the nucleotide level rather than a relocation of a whole chromosome segment. This is a Knowledge of Scientific Concepts and Principles question because you must recall the definition of a translocation and distinguish it from other chromosomal and point mutations.

---

## Q6 — Mutations · **medium** · Skill 1 · 100s · conf 5
**Stem:** A cytogeneticist analyzing a patient's karyotype identifies a single chromosome in which a segment has been detached, rotated 180°, and reinserted at its original location, reversing the order of the genes it carries without any net gain or loss of genetic material. This structural rearrangement is best classified as a chromosome:

- **A.** reciprocal translocation
- **B.** inversion ✅
- **C.** segmental deletion
- **D.** segmental duplication

**Correct (B):** openstax-biology-2e.txt lines 16363-16367: "A chromosome inversion is the detachment, 180° rotation, and reinsertion of part of a chromosome... Unless they disrupt a gene sequence, inversions only change gene orientation and are likely to have more mild effects than aneuploid errors."

**Distractors:**
- **A** — _adjacent_fact_: A reciprocal translocation moves a segment to a different, nonhomologous chromosome rather than reversing it in place; the stem keeps the segment on the same chromosome with reversed orientation.  
  ↳ openstax-biology-2e.txt lines 16431-16435: "A translocation occurs when a chromosome segment dissociates and reattaches to a different, nonhomologous chromosome... Reciprocal translocations result from exchanging chromosome segments between two nonhomologous chromosomes such that there is no genetic information gain or loss."
- **C** — _adjacent_fact_: A deletion removes genetic material (a segment loses itself), but the stem specifies no net loss of genetic material—only a reversal of orientation.  
  ↳ openstax-biology-2e.txt lines 16337-16342: "a chromosomal segment may duplicate or lose itself. Duplications and deletions often produce offspring that survive but exhibit abnormalities... Cri-du-chat... result[s] from a deletion of most 5p."
- **D** — _adjacent_fact_: A duplication adds genetic material by copying a segment, but the stem specifies no net gain of genetic material—only a reversal of gene order.  
  ↳ openstax-biology-2e.txt lines 16337-16340: "a chromosomal segment may duplicate or lose itself. Duplications and deletions often produce offspring that survive but exhibit abnormalities. Duplicated chromosomal segments may fuse to existing chromosomes or may be free in the nucleus."

**Explanation:** This is a Biology question that falls under the content category 'Transmission of Heritable Information from Generation to Generation.' The answer is B because the textbook defines a chromosome inversion as "the detachment, 180° rotation, and reinsertion of part of a chromosome," which reverses the order of the affected genes within the same chromosome; "unless they disrupt a gene sequence, inversions only change gene orientation" and involve no net gain or loss of genetic material. The described event—reversal of gene order on a single chromosome with no material lost or added—matches this definition exactly. (Choice A) A reciprocal translocation "occurs when a chromosome segment dissociates and reattaches to a different, nonhomologous chromosome," moving the segment to another chromosome rather than flipping it in place. (Choice B) is correct: the segment is excised, rotated 180°, and reinserted into the same chromosome, reversing gene orientation with no net change in genetic content. (Choice C) A segmental deletion is when "a chromosomal segment may...lose itself," removing genetic material, but here no material is lost. (Choice D) A segmental duplication is when a chromosomal segment "may duplicate," adding genetic material, but here no material is gained. This is a Knowledge of Scientific Concepts and Principles question because you must recall the textbook definitions of inversion, translocation, deletion, and duplication and match the described event to the correct category.

---

## Q7 — Mutations · **hard** · Skill 2 · 150s · conf 4
**Stem:** In the corn snake Pantherophis guttatus, amelanism (a skin pattern lacking dark pigment) results when a transposable element inserts into the OCA2 pigment gene. Researchers find that the resulting OCA2 protein is nonfunctional. The transposable element most likely produces this nonfunctional protein by acting as which type of mutation?

- **A.** A silent third-base substitution
- **B.** An inversion changing only gene orientation
- **C.** An insertion disrupting the gene's normal sequence ✅
- **D.** A translocation moving the gene elsewhere

**Correct (C):** openstax-biology-2e.txt lines 19715-19718: "In the corn snake Pantherophis guttatus, there are several different color variants, including amelanistic snakes whose skin patterns display only red and yellow pigments. The cause of amelanism in these snakes was recently identified as the insertion of a transposable element into an intron in the OCA2 (oculocutaneous albinism) gene. How might the insertion of extra genetic material into an intron lead to a nonfunctional protein?" and lines 17491-17494: "Mutations can also be the result of the addition of a base, known as an insertion... If an insertion or deletion results in the alteration of the translational reading frame (a frameshift mutation), the resultant protein is usually nonfunctional."

**Distractors:**
- **A** — _misconception_: A silent third-base substitution is a point mutation that usually encodes the same amino acid and leaves the protein functional, so it cannot explain the observed nonfunctional OCA2 protein; it also does not describe inserting new DNA into the gene.  
  ↳ openstax-biology-2e.txt lines 17484-17486: "Some point mutations are not detectable in the final product; these are known as silent mutations. Silent mutations are usually due to a substitution in the third base of a codon, which often represents the same amino acid as the original codon."
- **B** — _partial_truth_: Transposable elements can facilitate inversions, but an inversion that does not disrupt a gene only changes gene orientation and has milder effects; here new genetic material is inserted into the OCA2 gene rather than a segment being flipped, so reorientation alone does not produce a nonfunctional protein.  
  ↳ openstax-biology-2e.txt lines 16364-16367: "Inversions may occur in nature as a result of mechanical shear, or from transposable elements' action... Unless they disrupt a gene sequence, inversions only change gene orientation and are likely to have more mild effects than aneuploid errors."
- **D** — _adjacent_fact_: Translocation moves an existing piece of DNA to another chromosome or region; it relocates DNA rather than inserting new material into the OCA2 gene, so it does not match an element jumping into and disrupting this gene.  
  ↳ openstax-biology-2e.txt lines 17494-17495: "Sometimes a piece of DNA from one chromosome may get translocated to another chromosome or to another region of the same chromosome; this is also known as translocation."

**Explanation:** This is a Biology question that falls under the content category 'Transmission of Heritable Information from Generation to Generation.' The answer is C because a transposable element ('jumping gene') is a DNA sequence that moves into a new location, and when it lands inside a gene it adds extra genetic material—an insertion—into that gene's normal sequence. OpenStax describes amelanism in the corn snake as caused by 'the insertion of a transposable element into an intron in the OCA2 (oculocutaneous albinism) gene' and asks 'How might the insertion of extra genetic material into an intron lead to a nonfunctional protein?' The textbook explains that inserting extra bases can shift 'the translational reading frame (a frameshift mutation),' after which 'the resultant protein is usually nonfunctional,' and that disrupting a gene's splicing likewise tends to 'produce a nonfunctional protein.' Because the inserted element adds material to the OCA2 gene and disrupts its normal processing, the pigment protein cannot be made correctly. (Choice A) A silent third-base substitution is a point mutation that 'often represents the same amino acid as the original codon,' so it would leave the protein functional, not nonfunctional—the opposite of what is observed, and it does not describe inserting new DNA. (Choice B) An inversion that does not disrupt a gene sequence only changes gene orientation and is 'likely to have more mild effects'; here a new element is added into the gene rather than a segment being flipped, so reorientation does not explain a nonfunctional protein. (Choice C) is correct: inserting extra genetic material into the gene disrupts its normal sequence and processing, and such insertions usually yield a nonfunctional protein. (Choice D) A translocation is when a piece of DNA 'may get translocated to another chromosome or to another region of the same chromosome'—it relocates existing DNA rather than inserting new material into this gene, which is not what disrupts OCA2 here. This is a Scientific Reasoning and Problem Solving question because you must apply the definition of a transposable element and the consequences of insertion mutations to reason from the observed nonfunctional protein back to the underlying mutation mechanism.

---

## Q8 — Mutations · **easy** · Skill 1 · 75s · conf 5
**Stem:** In a laboratory study, a researcher exposes a culture of human skin cells to ultraviolet (UV) light and then sequences their DNA to identify newly arising changes in the nucleotide sequence. The mutations the researcher detects in the UV-exposed cells are best classified as which of the following?

- **A.** Silent mutations
- **B.** Spontaneous mutations
- **C.** Point mutations
- **D.** Induced mutations ✅

**Correct (D):** openstax-biology-2e.txt lines 17538-17539 (glossary): "induced mutation mutation that results from exposure to chemicals or environmental agents"; line 17474 (body): "Induced mutations are those that result from an exposure to chemicals, UV rays, x-rays, or some other environmental agent."

**Distractors:**
- **A** — _adjacent_fact_: A silent mutation is defined by its protein-level effect ('mutation that is not expressed'), not by its environmental cause; it describes whether the mutation alters the amino acid, which is a separate axis from whether the mutation was induced by UV.  
  ↳ openstax-biology-2e.txt line 17537 (glossary): 'silent mutation mutation that is not expressed'; line 17484 (body): 'Some point mutations are not detectable in the final product; these are known as silent mutations.'
- **B** — _reversed_relationship_: A spontaneous mutation is explicitly one that occurs 'without exposure to any external agent,' the reverse of this scenario in which UV light (an external environmental agent) is deliberately applied; choosing B reverses the induced/spontaneous relationship.  
  ↳ openstax-biology-2e.txt lines 17544-17547 (glossary): 'spontaneous mutation mutation that takes place in the cells as a result of chemical reactions taking place naturally without exposure to any external agent'; line 17476 (body): 'Spontaneous mutations occur without any exposure to any environmental agent.'
- **C** — _scale_unit_error_: 'Point mutation' classifies a mutation by its structural scale (affecting a single base pair) rather than by its cause; a UV-induced change is correctly called induced regardless of whether it happens to be a point mutation, so C answers the wrong question.  
  ↳ openstax-biology-2e.txt line 17479 (body): 'Point mutations are those mutations that affect a single base pair.'

**Explanation:** This is a Biology question that falls under the content category 'Transmission of Heritable Information from Generation to Generation.' The answer is D because the textbook defines an induced mutation as a "mutation that results from exposure to chemicals or environmental agents," and it specifically lists "UV rays" as an environmental agent that produces this type of mutation. Because the changes in this study arise from deliberate exposure to UV light (an external environmental agent), they are induced rather than arising from natural internal reactions. (Choice A) Silent mutations are point mutations "not expressed" in the protein, usually due to a substitution in the third base of a codon; this describes a possible effect on the protein, not the cause of the mutation, and a UV-induced change may or may not be silent. (Choice B) Spontaneous mutations "take place in the cells as a result of chemical reactions taking place naturally without exposure to any external agent" — the opposite of what occurs here, since UV is an external agent. (Choice C) Point mutations are "those mutations that affect a single base pair"; this categorizes a mutation by its structural scale rather than by its environmental cause, so it does not capture the defining feature of UV exposure. (Choice D) is correct: the mutations result from exposure to UV light, an environmental agent, which is the textbook definition of an induced mutation. This is a Knowledge of Scientific Concepts and Principles question because you must recall the definition of an induced mutation and distinguish it from spontaneous mutations and from terms describing a mutation's structural scale or protein-level effect.

---

## Q9 — Mutations · **medium** · Skill 2 · 105s · conf 5
**Stem:** Alkaptonuria is a recessively inherited condition in which a mutation disables an enzyme, so the amino acids phenylalanine and tyrosine are not properly metabolized and an intermediate accumulates. A genetic counselor is reviewing the molecular basis of this inborn error of metabolism with a family. Which of the following statements about this condition is/are accurate?

I. Affected individuals are homozygous for the nonfunctional allele.
II. Heterozygous carriers express a milder form of the disorder.
III. The functional enzyme is encoded by the recessive allele.

- **A.** I only ✅
- **B.** III only
- **C.** I and III only
- **D.** II and III only

**Correct (A):** openstax-biology-2e.txt lines 14879-14885: "Alkaptonuria is a recessive genetic disorder in which two amino acids, phenylalanine and tyrosine, are not properly metabolized... individuals with the disorder... have the genotype aa. Unaffected individuals... have the genotype AA or Aa." Lines 15131-15134: "a nonfunctional allele for an essential gene can arise by mutation... The wild-type allele functions at a capacity sufficient to sustain life and is therefore considered to be dominant over the nonfunctional allele."

**Distractors:**
- **B** — _reversed_relationship_: States that the recessive allele encodes the functional enzyme (statement III). This reverses the textbook relationship: the nonfunctional allele is recessive and the wild-type allele, which encodes the functional enzyme, is dominant over it. Statement III is therefore false, and I (the true statement) is omitted.  
  ↳ openstax-biology-2e.txt lines 15131-15136: "a nonfunctional allele for an essential gene can arise by mutation... The wild-type allele... is therefore considered to be dominant over the nonfunctional allele... we would expect to observe individuals that are homozygous recessive for the nonfunctional allele."
- **C** — _partial_truth_: Correctly includes the true statement I but adds the reversed statement III. Because III incorrectly assigns the functional enzyme to the recessive allele, the combination is wrong even though one of its members is accurate.  
  ↳ openstax-biology-2e.txt lines 14881-14882: "individuals with the disorder are indicated in blue and have the genotype aa. Unaffected individuals... have the genotype AA or Aa." Lines 17486-17487: point mutations "can result in the replacement of one amino acid by another, which may alter the function of the protein."
- **D** — _misconception_: Includes statement II, the misconception that heterozygous carriers show a milder phenotype. The textbook states recessive alleles can be 'carried' and not expressed by heterozygous 'carriers,' so heterozygotes (Aa) are phenotypically unaffected, not mildly affected; it also includes the reversed statement III.  
  ↳ openstax-biology-2e.txt lines 14893-14894: "in the presence of the dominant allele, the recessive allele is hidden and makes no contribution to the phenotype. Therefore, recessive alleles can be 'carried' and not expressed by individuals. Such heterozygous individuals are sometimes referred to as 'carriers.'"

**Explanation:** This is a Biology question that falls under the content category 'Transmission of Heritable Information from Generation to Generation.' The answer is A because only statement I is consistent with the textbook description of alkaptonuria. OpenStax states that alkaptonuria is a recessive genetic disorder in which two amino acids, phenylalanine and tyrosine, are not properly metabolized, that affected individuals have the genotype \(aa\), and that unaffected individuals have the genotype \(AA\) or \(Aa\). Because a nonfunctional allele arises by mutation and the wild-type, functional copy is dominant over the nonfunctional allele, the disorder appears only in individuals who are homozygous recessive for the nonfunctional allele (statement I). (Choice A) is correct: statement I alone matches the source, since affected \(aa\) individuals carry two copies of the nonfunctional, recessive allele. (Choice B) III only is wrong because the recessive allele is the nonfunctional one; the functional enzyme is encoded by the dominant wild-type allele, so III is false. (Choice C) I and III only is wrong because it pairs the true statement I with the reversed statement III. (Choice D) II and III only is wrong because the textbook explains that recessive alleles can be 'carried' and not expressed by heterozygous 'carriers,' so heterozygotes are phenotypically unaffected rather than showing a milder form (II is false), and III remains reversed. This is a Scientific Reasoning and Problem Solving question because you must apply the relationship between a recessive nonfunctional allele, genotype, and phenotype to evaluate each statement.

---

## Q10 — Hardy-Weinberg Equilibrium · **easy** · Skill 1 · 75s · conf 5
**Stem:** A large population of beetles is in Hardy-Weinberg equilibrium at a locus that controls shell color, with allele frequencies \(p\) and \(q\) holding steady across generations. The allele frequencies would be expected to begin changing from one generation to the next if which of the following conditions started to occur?

- **A.** Beetles continue to mate at random
- **B.** Darker beetles survive predation more often ✅
- **C.** The population still numbers in the millions
- **D.** No beetles enter or leave the population

**Correct (B):** OpenStax Biology 2e, lines 22819-22820: "The Hardy-Weinberg principle assumes an infinitely large population and conditions with no mutations, migration, emigration, or selective pressure for or against genotype." Lines 22797-22801: "Natural selection can alter the population's genetic makeup. An example is if a given allele confers a phenotype that allows an individual to better survive or have more offspring... Over time, the allele will spread throughout the population."

**Distractors:**
- **A** — _misconception_: Random mating is one of the conditions the Hardy-Weinberg principle requires, so it preserves equilibrium rather than disrupting it; it is nonrandom mating that acts as an evolutionary force.  
  ↳ OpenStax Biology 2e, lines 22942-22943: 'genetic drift, gene flow, mutation, nonrandom mating, and environmental variation.' Lines 23097-23098: 'If individuals nonrandomly mate with their peers, the result can be a changing population.'
- **C** — _reversed_relationship_: A very large population is precisely the assumption needed to keep allele frequencies stable (it minimizes genetic drift), so it maintains equilibrium; a small population would be the disruptive case.  
  ↳ OpenStax Biology 2e, line 22819: 'The Hardy-Weinberg principle assumes an infinitely large population.'
- **D** — _reversed_relationship_: No migration or emigration is a stated Hardy-Weinberg assumption, so individuals staying put keeps frequencies constant; it is gene flow, the movement of alleles into and out of a population, that would disrupt equilibrium.  
  ↳ OpenStax Biology 2e, line 22820: 'conditions with no mutations, migration, emigration, or selective pressure for or against genotype.' Lines 23070-23071: 'gene flow: the flow of alleles in and out of a population due to the migration of individuals.'

**Explanation:** This is a Biology question that falls under the content category 'Transmission of Heritable Information from Generation to Generation.' The answer is B because the Hardy-Weinberg principle assumes 'an infinitely large population and conditions with no mutations, migration, emigration, or selective pressure for or against genotype' (OpenStax Biology 2e, lines 22819-22820); when one of those conditions fails, the population evolves and allele frequencies change. When the five assumptions hold, \(p\) and \(q\) stay constant, so the genetic structure \(p^2 + 2pq + q^2 = 1\) reproduces unchanged each generation. A survival advantage for darker beetles is selective pressure for a genotype: the favored allele is passed on at a higher rate, so its frequency rises while \(q\) falls, and the equilibrium values of \(p\) and \(q\) shift. The textbook notes that 'if the frequencies of alleles or genotypes deviate from the value expected from the Hardy-Weinberg equation, then the population is evolving' (lines 22869-22870). (Choice A) is incorrect: random mating is one of the required assumptions, so it preserves rather than disrupts equilibrium; nonrandom mating is listed separately as an evolutionary force (lines 22942-22943). (Choice B) is correct: selective pressure for or against a genotype is explicitly excluded by the Hardy-Weinberg assumptions, so it drives \(p\) and \(q\) away from their constant values (lines 22819-22820, 22797-22801). (Choice C) is incorrect: a very large ('infinitely large') population is exactly the condition the principle requires to avoid genetic drift, so it maintains equilibrium (line 22819). (Choice D) is incorrect: no migration or emigration is one of the stated assumptions, so the absence of movement keeps frequencies stable; it is gene flow, the movement of alleles in and out, that disrupts equilibrium (lines 22820, 23070-23071). This is a Knowledge of Scientific Concepts and Principles question because you must recall the Hardy-Weinberg assumptions and identify which scenario violates them.

---

## Q11 — Hardy-Weinberg Equilibrium · **easy** · Skill 4 · 75s · conf 5
**Stem:** In a large population at Hardy-Weinberg equilibrium, cystic fibrosis (an autosomal recessive disorder) affects only individuals homozygous for the recessive allele. A researcher records the following genotype/phenotype frequencies for this single locus:

| Phenotype | Genotype | Frequency |
|---|---|---|
| Unaffected | homozygous dominant + heterozygous | \(0.96\) |
| Affected | homozygous recessive (\(q^2\)) | \(0.04\) |

Assuming equilibrium holds, the frequency of the recessive allele (\(q\)) in this population is closest to which value?

- **A.** \(0.04\)
- **B.** \(0.32\)
- **C.** \(0.2\) ✅
- **D.** \(0.8\)

**Correct (C):** openstax-biology-2e.txt lines 22832-22839: "If we observe the phenotype, we can know only the homozygous recessive allele's genotype... the frequency of qq individuals is q2... p2 + 2pq + q2 = 1." Combined with line 22827: "p + q = 1." Thus q = sqrt(q^2) = sqrt(0.04) = 0.2.

**Distractors:**
- **A** — _process_step_confusion_: 0.04 is the homozygous-recessive genotype frequency q^2 read straight from the affected phenotype; reporting it as q skips the required square-root step. The text specifies 'the frequency of qq individuals is q2,' so 0.04 = q^2, not q.  
  ↳ openstax-biology-2e.txt line 22838: "the frequency of qq individuals is q2"
- **B** — _adjacent_fact_: 0.32 is the heterozygous-carrier frequency 2pq = 2(0.8)(0.2), the wrong genotype class; the question asks for the recessive allele frequency q, not the frequency of carriers. The text gives 'the frequency of pq individuals is 2pq.'  
  ↳ openstax-biology-2e.txt line 22838: "the frequency of pq individuals is 2pq"
- **D** — _reversed_relationship_: 0.8 is p, the dominant allele frequency (1 - q), not the recessive allele frequency q; this reverses which allele is being requested. The text states 'p + q = 1,' so p = 0.8 while q = 0.2.  
  ↳ openstax-biology-2e.txt line 22827: "If these are the only two possible alleles for a given locus in the population, p + q = 1."

**Explanation:** This is a Biology question that falls under the content category 'Transmission of Heritable Information from Generation to Generation.' The answer is C because only the homozygous recessive class can be read directly from phenotype, and its frequency equals \(q^2\); the recessive allele frequency is therefore the square root of that genotype frequency. The textbook states that 'the frequency of qq individuals is q2' and that 'If we observe the phenotype, we can know only the homozygous recessive allele's genotype.' Here \(q^2 = 0.04\), so \(q = \sqrt{0.04} = 0.2\), and the dominant allele frequency is \(p = 1 - q = 0.8\) since \(p + q = 1\). (Choice A) \(0.04\) is the homozygous-recessive genotype frequency \(q^2\) itself, mistakenly reported as the allele frequency without taking the square root. (Choice B) \(0.32\) is the carrier (heterozygote) frequency \(2pq = 2(0.8)(0.2)\), which is the wrong genotype class for an allele-frequency question. (Choice C) is correct: \(q = \sqrt{q^2} = \sqrt{0.04} = 0.2\). (Choice D) \(0.8\) is \(p\), the dominant allele frequency \(1 - q\), not the recessive allele frequency \(q\). This is a Data-based and Statistical Reasoning question because you must interpret the genotype-frequency table and compute \(q\) from the observed \(q^2\) value.

---

## Q12 — Hardy-Weinberg Equilibrium · **medium** · Skill 2 · 110s · conf 5
**Stem:** In a large, randomly mating human population at Hardy-Weinberg equilibrium, cystic fibrosis (an autosomal recessive disorder) is observed at the genotype frequency shown below. Assuming only two alleles segregate at this locus, the expected frequency of unaffected carriers (heterozygotes) in this population is closest to which value?

| Genotype | Frequency |
|----------|-----------|
| Homozygous dominant (\(p^2\)) | unknown |
| Heterozygous carrier (\(2pq\)) | unknown |
| Homozygous recessive, affected (\(q^2\)) | \(0.04\) |

- **A.** \(0.16\)
- **B.** \(0.04\)
- **C.** \(0.64\)
- **D.** \(0.32\) ✅

**Correct (D):** openstax-biology-2e.txt lines 22837-22839: "the frequency of pp individuals is simply p2; the frequency of pq individuals is 2pq; and the frequency of qq individuals is q2. Again, if p and q are the only two possible alleles for a given trait in the population, these genotypes frequencies will sum to one: p2 + 2pq + q2 = 1." Cystic fibrosis is listed as a recessive trait in openstax-biology-2e.txt line 14759 (Table 12.4, Recessive Traits).

**Distractors:**
- **A** — _process_step_confusion_: \(0.16\) is \(pq = (0.8)(0.2)\) computed without the required factor of 2. The heterozygote frequency is \(2pq\) because there are two ways to inherit one of each allele; dropping the 2 undercounts carriers by half.  
  ↳ openstax-biology-2e.txt line 22838: "the frequency of pq individuals is 2pq" — the factor of 2 is part of the heterozygote term.
- **B** — _misconception_: \(0.04\) is \(q^2\), the frequency of homozygous recessive (affected) individuals given in the table, not the carriers. This confuses carriers (heterozygotes) with affected homozygotes.  
  ↳ openstax-biology-2e.txt line 22838: "the frequency of qq individuals is q2" — \(q^2\) is the affected homozygous recessive class, not the heterozygous carriers.
- **C** — _adjacent_fact_: \(0.64\) is \(p^2 = (0.8)^2\), the frequency of unaffected homozygous dominant individuals, not the heterozygous carriers. It applies the wrong genotype term from the same equation.  
  ↳ openstax-biology-2e.txt line 22837: "the frequency of pp individuals is simply p2" — \(p^2\) is the homozygous dominant class, distinct from the \(2pq\) carrier class.

**Explanation:** This is a Biology question that falls under the content category 'Transmission of Heritable Information from Generation to Generation.' The answer is D because the carrier (heterozygote) frequency is \(2pq\), and the factor of 2 must be included. The textbook states that for two alleles, "the frequency of pp individuals is simply \(p^2\); the frequency of pq individuals is \(2pq\); and the frequency of qq individuals is \(q^2\)" with \(p^2 + 2pq + q^2 = 1\). Because affected individuals are homozygous recessive, \(q^2 = 0.04\), so \(q = \sqrt{0.04} = 0.2\); then from \(p + q = 1\), \(p = 0.8\). The carrier frequency is \(2pq = 2(0.8)(0.2) = 0.32\). (Choice A) \(0.16\) is the product \(pq\) without the factor of 2, which represents only one of the two reciprocal heterozygote combinations and undercounts carriers. (Choice B) \(0.04\) is \(q^2\), the frequency of affected homozygous recessive individuals, not the carriers. (Choice C) \(0.64\) is \(p^2\), the frequency of unaffected homozygous dominant individuals, not the heterozygotes. (Choice D) is correct: carriers are heterozygotes whose frequency is \(2pq = 2(0.8)(0.2) = 0.32\). This is a Scientific Reasoning and Problem Solving question because you must apply the Hardy-Weinberg equation, derive \(p\) and \(q\) from the observed \(q^2\), and compute \(2pq\) including the factor of 2.

---

## Q13 — Hardy-Weinberg Equilibrium · **hard** · Skill 4 · 150s · conf 5
**Stem:** A recessive metabolic disorder caused by a single autosomal allele affects 1 in 2,500 newborns in a population that is assumed to be in Hardy-Weinberg equilibrium for this locus. The table summarizes what is observed and what is sought.

| Quantity | Symbol | Value |
|---|---|---|
| Frequency of affected (homozygous recessive) individuals | \(q^2\) | \(0.0004\) |
| Frequency of the recessive allele | \(q\) | ? |
| Frequency of the dominant allele | \(p\) | ? |
| Frequency of homozygous dominant individuals | \(p^2\) | ? |

Based on these data, the expected frequency of homozygous dominant individuals in this population is closest to which value?

- **A.** \(0.9604\) ✅
- **B.** \(0.0392\)
- **C.** \(0.98\)
- **D.** \(0.0004\)

**Correct (A):** openstax-biology-2e.txt lines 22827, 22832, 22837-22839: "p + q = 1" ... "If we observe the phenotype, we can know only the homozygous recessive allele's genotype." ... "the frequency of pp individuals is simply p2; the frequency of pq individuals is 2pq; and the frequency of qq individuals is q2." Chain: q^2=0.0004 -> q=0.02 -> p=0.98 -> p^2=0.9604.

**Distractors:**
- **B** — _partial_truth_: \(0.0392\) is the heterozygote (carrier) frequency \(2pq = 2(0.98)(0.02)\), a genuine Hardy-Weinberg genotype frequency but not the homozygous dominant class the question asks for.  
  ↳ openstax-biology-2e.txt line 22838: "the frequency of pq individuals is 2pq" — this gives carriers, not homozygous dominant individuals (p2).
- **C** — _process_step_confusion_: \(0.98\) is the dominant allele frequency \(p\) itself; the solver stops at the allele level after computing \(p = 1 - q\) and forgets to square it to get the genotype frequency \(p^2\).  
  ↳ openstax-biology-2e.txt lines 22827, 22837: "p + q = 1" gives p=0.98, but "the frequency of pp individuals is simply p2" requires squaring p.
- **D** — _reversed_relationship_: \(0.0004\) is the given homozygous recessive frequency \(q^2\) (the affected individuals); reporting it as the homozygous dominant frequency reverses the two homozygous genotype classes.  
  ↳ openstax-biology-2e.txt lines 22832, 22838: the observed affected fraction is "the homozygous recessive allele's genotype" (q2 = 0.0004), distinct from p2 for homozygous dominant individuals.

**Explanation:** This is a Biology question that falls under the content category 'Transmission of Heritable Information from Generation to Generation.' The answer is A because the homozygous dominant genotype frequency equals \(p^2\), which must be reached by chaining the Hardy-Weinberg relationships. Because affected individuals are homozygous recessive, the observed phenotype gives \(q^2 = 0.0004\); the textbook notes that from the phenotype "we can know only the homozygous recessive allele's genotype" (line 22832), so \(q = \sqrt{0.0004} = 0.02\). Since \(p + q = 1\) (line 22827), \(p = 1 - 0.02 = 0.98\), and the frequency of homozygous dominant individuals \(p^2 = (0.98)^2 = 0.9604\), consistent with "the frequency of pp individuals is simply p2" (line 22837). (Choice A) is correct: \(p^2 = (0.98)^2 = 0.9604\). (Choice B) \(0.0392\) is the heterozygote (carrier) frequency \(2pq = 2(0.98)(0.02)\), a real Hardy-Weinberg quantity but the wrong genotype. (Choice C) \(0.98\) is the dominant allele frequency \(p\) itself, stopping one step early and failing to square it. (Choice D) \(0.0004\) is the given homozygous recessive frequency \(q^2\), which describes affected individuals, not homozygous dominant ones. This is a Data-based and Statistical Reasoning question because you must interpret the tabulated genotype-frequency data and propagate them through the Hardy-Weinberg equation to compute \(p^2\).

---

## Q14 — Hardy-Weinberg Equilibrium · **hard** · Skill 2 · 150s · conf 5
**Stem:** A geneticist studies an autosomal recessive metabolic disorder in an island population of 2,500 people that meets Hardy-Weinberg conditions. Affected (homozygous recessive) individuals are counted directly, giving the genotype data below. Based on these frequencies, approximately how many people in this population are expected to be heterozygous carriers?

| Genotype | Frequency |
|----------|-----------|
| Homozygous dominant (\(p^2\)) | \(0.64\) |
| Heterozygous (\(2pq\)) | ? |
| Affected, homozygous recessive (\(q^2\)) | \(0.04\) |

- **A.** About 100 individuals
- **B.** About 800 individuals ✅
- **C.** About 400 individuals
- **D.** About 1,600 individuals

**Correct (B):** OpenStax Biology 2e, /Users/mikkonieveras/praxis-prep/reference-textbooks/biology/openstax-biology-2e.txt, lines 22837-22839: "the frequency of pp individuals is simply p2; the frequency of pq individuals is 2pq; and the frequency of qq individuals is q2. Again, if p and q are the only two possible alleles for a given trait in the population, these genotypes frequencies will sum to one: p2 + 2pq + q2 = 1." Worked-count example at lines 22857-22859: "If p = 0.8 and q = 0.2 in a population of 500 plants, how many individuals would you expect to be homozygous dominant (VV), heterozygous (Vv), and homozygous recessive (vv)?" confirms multiplying a genotype frequency by population size to obtain expected numbers of individuals.

**Distractors:**
- **A** — _misconception_: Multiplies q^2 (0.04) by 2,500 to get 100, which is the number of AFFECTED homozygous recessive individuals, not carriers. The textbook assigns q2 to qq (homozygous recessive) individuals, not heterozygotes.  
  ↳ OpenStax Biology 2e, lines 22837-22839: "the frequency of qq individuals is q2"; and line 22832: "If we observe the phenotype, we can know only the homozygous recessive allele's genotype."
- **C** — _process_step_confusion_: Drops the factor of 2 in the heterozygote term, using pq = 0.16 (so 400) instead of 2pq = 0.32. The textbook explicitly states the heterozygote frequency is 2pq, not pq.  
  ↳ OpenStax Biology 2e, lines 22837-22839: "the frequency of pq individuals is 2pq."
- **D** — _adjacent_fact_: Multiplies p^2 (0.64) by 2,500 to get 1,600, which is the expected number of HOMOZYGOUS DOMINANT individuals, not heterozygous carriers. p2 is a real genotype frequency but the wrong one for this question.  
  ↳ OpenStax Biology 2e, lines 22837-22839: "the frequency of pp individuals is simply p2."

**Explanation:** This is a Biology question that falls under the content category 'Transmission of Heritable Information from Generation to Generation.' The answer is B because the heterozygous carrier frequency is \(2pq\), and multiplying that frequency by the population size gives the expected number of carriers. The textbook states that for two alleles at a locus, \(p + q = 1\) and the genotype frequencies are \(p^2\) for homozygous dominant, \(2pq\) for heterozygous, and \(q^2\) for homozygous recessive, which sum to \(p^2 + 2pq + q^2 = 1\). Because only the homozygous recessive genotype can be observed directly from phenotype, start from \(q^2 = 0.04\), so \(q = \sqrt{0.04} = 0.2\) and \(p = 1 - 0.2 = 0.8\); then \(2pq = 2(0.8)(0.2) = 0.32\), and \(0.32 \times 2{,}500 = 800\) carriers. (Choice A) About 100 uses \(q^2 = 0.04 \times 2{,}500 = 100\), which counts affected homozygous recessives, not carriers. (Choice B) is correct: \(2pq \times N = 0.32 \times 2{,}500 = 800\) heterozygous carriers. (Choice C) About 400 forgets the factor of 2 in \(2pq\), using \(pq = 0.16 \times 2{,}500 = 400\) instead. (Choice D) About 1,600 uses \(p^2 = 0.64 \times 2{,}500 = 1{,}600\), the count of homozygous dominant individuals rather than heterozygotes. This is a Scientific Reasoning and Problem Solving question because you must apply the Hardy-Weinberg genotype equations to observed data and convert the carrier frequency into an expected count.

---

## Q15 — Hardy-Weinberg Equilibrium · **hard** · Skill 2 · 165s · conf 5
**Stem:** In a beetle population, a dark-body allele \(A\) is dominant over a light-body allele \(a\). Researchers sample 1,000 beetles and record the genotype counts below. Treating the Hardy-Weinberg equation as the baseline for a non-evolving population, the researchers compare these observed counts to the counts expected from the allele frequencies in this same sample.

| Genotype | AA | Aa | aa |
|----------|------|------|------|
| Observed count | 600 | 100 | 300 |

The data most strongly support which conclusion about this population?

- **A.** It is in Hardy-Weinberg equilibrium
- **B.** Its allele frequencies cannot be determined
- **C.** It is evolving at this locus ✅
- **D.** Genetic drift CANNOT be acting on it

**Correct (C):** openstax-biology-2e.txt lines 22869-22870: "If the frequencies of alleles or genotypes deviate from the value expected from the Hardy-Weinberg equation, then the population is evolving." Also lines 23401-23403: "...scientists can conclude that the population is not in Hardy-Weinberg equilibrium, and is thus evolving." Calculation per lines 22837-22839: "the frequency of pp individuals is simply p2; the frequency of pq individuals is 2pq; and the frequency of qq individuals is q2... these genotypes frequencies will sum to one: p2 + 2pq + q2 = 1."

**Distractors:**
- **A** — _partial_truth_: Hardy-Weinberg equilibrium holds only when observed genotype counts match the expected p^2 + 2pq + q^2 distribution; here observed heterozygotes (100) fall far below the expected ~455, so the population is NOT in equilibrium. This is the 510-tempting trap for a student who computes q but skips the observed-vs-expected comparison.  
  ↳ openstax-biology-2e.txt lines 22817-22819: 'the Hardy-Weinberg principle of equilibrium, states that a population's allele and genotype frequencies are inherently stable—unless some kind of evolutionary force is acting upon the population, neither the allele nor the genotypic frequencies would change.'
- **B** — _misconception_: Allele frequencies ARE directly computable from genotype counts because each individual carries two alleles per gene; here q = (2*300 + 100)/2000 = 0.35. The claim that they cannot be determined contradicts the text.  
  ↳ openstax-biology-2e.txt lines 22833-22835: 'Since each individual carries two alleles per gene, if we know the allele frequencies (p and q), predicting the genotypes' frequencies is a simple mathematical calculation...'
- **D** — _adjacent_fact_: Genetic drift is the effect of chance on a population's gene pool and can act on any real (finite) population; the data give no basis to exclude it, and drift is in fact one force that could produce the observed deviation. The exception framing (CANNOT) makes the false absolute claim tempting.  
  ↳ openstax-biology-2e.txt lines 22806-22807: 'Sometimes, allele frequencies within a population change randomly with no advantage to the population... We call this phenomenon genetic drift.' Glossary lines 23389-23390: 'genetic drift effect of chance on a population's gene pool.'

**Explanation:** This is a Biology question that falls under the content category 'Transmission of Heritable Information from Generation to Generation.' The answer is C because the observed genotype counts deviate sharply from the Hardy-Weinberg expectation, and OpenStax states that 'if the frequencies of alleles or genotypes deviate from the value expected from the Hardy-Weinberg equation, then the population is evolving' (lines 22869-22870) and that such a population 'is not in Hardy-Weinberg equilibrium, and is thus evolving' (lines 23401-23403). First compute the allele frequency of \(a\) from the counts: \(q = \frac{2(300) + 100}{2(1000)} = \frac{700}{2000} = 0.35\), so \(p = 1 - 0.35 = 0.65\). The expected genotype frequencies are \(p^2 = (0.65)^2 = 0.4225\) (about 423 AA), \(2pq = 2(0.65)(0.35) = 0.455\) (about 455 Aa), and \(q^2 = (0.35)^2 = 0.1225\) (about 123 aa). The observed 100 heterozygotes versus 455 expected is a large deviation, so the population fails Hardy-Weinberg and is evolving. (Choice A) is incorrect because equilibrium would require the observed counts to match the expected \(p^2 + 2pq + q^2\) distribution (lines 22817-22819); the marked heterozygote deficit shows they do not, making this a tempting trap only if the comparison is skipped. (Choice B) is incorrect because allele frequencies are directly calculable from genotype counts, since each individual carries two alleles per gene (lines 22833-22835). (Choice C) is correct: the genotype counts deviate from the Hardy-Weinberg expectation, which by definition indicates the population is evolving (lines 22869-22870, 23401-23403). (Choice D) is incorrect because genetic drift is the effect of chance on a population's gene pool and can act on any real population (lines 22806-22807, 23389-23390); nothing in the data rules it out. This is a Scientific Reasoning and Problem Solving question because you must apply the Hardy-Weinberg equation to the observed counts, compute the expected genotype distribution, and reason from the deviation to the conclusion that the population is evolving.

---

## Q16 — Hardy-Weinberg Equilibrium · **medium** · Skill 1 · 105s · conf 5
**Stem:** A researcher tracks a recessive disease allele in an isolated human village and wants to confirm that the locus is at Hardy-Weinberg equilibrium so that genotype frequencies can be predicted from allele frequencies. For the locus to remain at equilibrium, which of the following conditions must hold?

I. Heterozygous carriers survive and reproduce better than either homozygote.
II. The locus has one allele that is dominant over the other.
III. No individuals migrate into or out of the village.

- **A.** I only
- **B.** III only ✅
- **C.** I and III only
- **D.** II and III only

**Correct (B):** openstax-biology-2e.txt lines 22819-22820: "The Hardy-Weinberg principle assumes an infinitely large population and conditions with no mutations, migration, emigration, or selective pressure for or against genotype." (no migration/emigration is a required equilibrium condition, matching statement III)

**Distractors:**
- **A** — _misconception_: Choice A selects only statement I (heterozygote advantage), which is a form of selective pressure favoring one genotype. Selection is an evolutionary force that drives a locus AWAY from equilibrium; it is not a condition that must hold to maintain equilibrium. The textbook lists 'no...selective pressure for or against genotype' as an assumption, so requiring selection is the reverse of the truth.  
  ↳ openstax-biology-2e.txt lines 22819-22820: 'conditions with no mutations, migration, emigration, or selective pressure for or against genotype'
- **C** — _partial_truth_: Choice C correctly includes the true condition III but also includes statement I. Statement I (heterozygote advantage) is selection, a force that violates rather than maintains Hardy-Weinberg equilibrium, so combining it with III as a co-requirement is wrong. This is a partial-truth trap: one true statement bundled with one false one.  
  ↳ openstax-biology-2e.txt lines 22819-22820: 'no mutations, migration, emigration, or selective pressure for or against genotype'; lines 22941-22943 list selection and other forces (genetic drift, gene flow, mutation, nonrandom mating) as causes of allele-frequency change
- **D** — _adjacent_fact_: Choice D pairs the true condition III with statement II (one allele dominant over the other). Dominance is a real genetics concept but is irrelevant to equilibrium: the relations \(p + q = 1\) and \(p^2 + 2pq + q^2 = 1\) hold for any two alleles regardless of dominance. The principle's assumptions concern population size, mutation, migration, and selection—not dominance relationships.  
  ↳ openstax-biology-2e.txt lines 22833-22839: genotype frequencies are \(p^2\), \(2pq\), \(q^2\) summing to one for the two alleles; lines 22819-22820 list the actual assumptions, which do not mention dominance

**Explanation:** This is a Biology question that falls under the content category 'Transmission of Heritable Information from Generation to Generation.' The answer is B because Hardy-Weinberg equilibrium holds only under a specific set of assumptions, and of the three statements, only III (no migration in or out) is one of those required conditions. OpenStax states that 'The Hardy-Weinberg principle assumes an infinitely large population and conditions with no mutations, migration, emigration, or selective pressure for or against genotype.' Because the locus is described by \(p + q = 1\) and the genotype frequencies \(p^2 + 2pq + q^2 = 1\), these frequencies stay constant from generation to generation only when no evolutionary force (no migration/gene flow, no mutation, no selection, no drift, random mating) perturbs the gene pool. Migration would add or remove alleles and shift \(p\) and \(q\), so the absence of migration in statement III is genuinely required. (Choice A) Statement I describes heterozygote advantage, a form of selective pressure favoring one genotype; selection is a force that violates equilibrium rather than maintaining it, so I is not a required condition. (Choice B) is correct: only statement III, the absence of migration and emigration, is among the listed Hardy-Weinberg conditions that must hold. (Choice C) pairs the true condition III with the false condition I, so it incorrectly treats heterozygote advantage as required. (Choice D) pairs III with II, but equilibrium does not require any particular dominance relationship at the locus—the equations hold for any allele frequencies regardless of which allele is dominant. This is a Knowledge of Scientific Concepts and Principles question because you must recall the set of assumptions that define Hardy-Weinberg equilibrium and distinguish a genuine equilibrium condition from evolutionary forces and irrelevant genetic facts.

---

## Q17 — Hardy-Weinberg Equilibrium · **medium** · Skill 2 · 105s · conf 5
**Stem:** A recessive metabolic disorder affects \(4\%\) of newborns in a large, randomly mating human population that is in Hardy-Weinberg equilibrium, so the homozygous-recessive genotype frequency \(q^2 = 0.04\). Assuming only two alleles segregate at this locus, what fraction of the population is expected to be homozygous dominant?

- **A.** \(0.04\)
- **B.** \(0.32\)
- **C.** \(0.80\)
- **D.** \(0.64\) ✅

**Correct (D):** openstax-biology-2e.txt lines 22837-22839: "the frequency of pp individuals is simply p2; the frequency of pq individuals is 2pq; and the frequency of qq individuals is q2. Again, if p and q are the only two possible alleles for a given trait in the population, these genotypes frequencies will sum to one: p2 + 2pq + q2 = 1." and lines 22827-22828: "If these are the only two possible alleles for a given locus in the population, p + q = 1."

**Distractors:**
- **A** — _reversed_relationship_: \(0.04\) is \(q^2\), the homozygous-recessive (affected) genotype frequency that was given in the stem; it is the opposite homozygote, not the homozygous-dominant fraction \(p^2 = 0.64\). The student confuses which homozygote the term \(p^2\) refers to.  
  ↳ openstax-biology-2e.txt lines 22837-22838: "the frequency of pp individuals is simply p2; ... the frequency of qq individuals is q2."
- **B** — _process_step_confusion_: \(0.32\) is \(2pq = 2(0.8)(0.2)\), the heterozygous (carrier) frequency, not the homozygous-dominant frequency \(p^2\). The student computes the heterozygote term instead of the pp term.  
  ↳ openstax-biology-2e.txt line 22838: "the frequency of pq individuals is 2pq."
- **C** — _scale_unit_error_: \(0.80\) is \(p\), the dominant allele frequency, not the genotype frequency; the student forgets to square \(p\), reporting the allele frequency where the genotype frequency \(p^2 = 0.64\) is required.  
  ↳ openstax-biology-2e.txt line 22837: "the frequency of pp individuals is simply p2"; line 22827: "p + q = 1."

**Explanation:** This is a Biology question that falls under the content category 'Transmission of Heritable Information from Generation to Generation.' The answer is D because the homozygous-dominant genotype frequency equals \(p^2\), and the three genotype frequencies must satisfy \(p^2 + 2pq + q^2 = 1\). The textbook states that "the frequency of pp individuals is simply p2; the frequency of pq individuals is 2pq; and the frequency of qq individuals is q2... these genotypes frequencies will sum to one: p2 + 2pq + q2 = 1" (lines 22837-22839). Given \(q^2 = 0.04\), take the square root to get \(q = 0.2\); since \(p + q = 1\), \(p = 0.8\) (lines 22827-22828). The homozygous-dominant fraction is therefore \(p^2 = (0.8)^2 = 0.64\), and as a check \(0.64 + 2(0.8)(0.2) + 0.04 = 0.64 + 0.32 + 0.04 = 1.00\). (Choice A) \(0.04\) is \(q^2\), the homozygous-recessive (affected) frequency, not the homozygous-dominant frequency. (Choice B) \(0.32\) is \(2pq\), the heterozygous (carrier) frequency, not the homozygous-dominant frequency. (Choice C) \(0.80\) is \(p\), the dominant allele frequency, not the genotype frequency \(p^2\). (Choice D) is correct: \(p^2 = (0.8)^2 = 0.64\). This is a Scientific Reasoning and Problem Solving question because you must apply the Hardy-Weinberg equation to genotype data to compute an unobserved genotype frequency.

---

## Q18 — Hardy-Weinberg Equilibrium · **hard** · Skill 2 · 150s · conf 5
**Stem:** A recessive allele causes a metabolic disorder in a large, randomly mating human population at Hardy-Weinberg equilibrium. A survey records the phenotype frequencies shown below.

| Phenotype | Frequency |
|---|---|
| Dominant (unaffected) | \(0.84\) |
| Recessive (affected) | \(0.16\) |

Assuming the locus is at equilibrium, the frequency of heterozygous carriers in this population is closest to which value?

- **A.** \(0.40\)
- **B.** \(0.48\) ✅
- **C.** \(0.24\)
- **D.** \(0.16\)

**Correct (B):** OpenStax Biology 2e, Section 19.2 Population Genetics, lines 22837-22839: \"the frequency of pp individuals is simply p2; the frequency of pq individuals is 2pq; and the frequency of qq individuals is q2. Again, if p and q are the only two possible alleles for a given trait in the population, these genotypes frequencies will sum to one: p2 + 2pq + q2 = 1.\" and line 22827: \"If these are the only two possible alleles for a given locus in the population, p + q = 1.\"

**Distractors:**
- **A** — _process_step_confusion_: 0.40 is q, the recessive allele frequency obtained from sqrt(q^2) = sqrt(0.16) = 0.4. The student stops at the allele frequency and reports it as the carrier (heterozygote) frequency, skipping the required 2pq computation. The textbook distinguishes allele frequency (p, q) from genotype frequencies (p^2, 2pq, q^2).  
  ↳ OpenStax Biology 2e, Section 19.2, lines 22833-22838: "if we know the allele frequencies (p and q), predicting the genotypes' frequencies is a simple mathematical calculation... the frequency of pq individuals is 2pq"
- **C** — _scale_unit_error_: 0.24 = pq = (0.6)(0.4) omits the factor of 2 in the heterozygote term. The textbook explicitly states the frequency of heterozygous (pq) individuals is 2pq, not pq, because a heterozygote can be formed two ways when drawing two alleles at random.  
  ↳ OpenStax Biology 2e, Section 19.2, line 22838: "the frequency of pq individuals is 2pq"
- **D** — _misconception_: 0.16 is q^2, the frequency of homozygous recessive (affected) individuals given directly in the table. The student confuses the affected/homozygous-recessive frequency with the carrier (heterozygote) frequency; the textbook assigns q^2 to qq individuals, the phenotype we can read directly, not to carriers.  
  ↳ OpenStax Biology 2e, Section 19.2, lines 22832-22838: "If we observe the phenotype, we can know only the homozygous recessive allele's genotype... the frequency of qq individuals is q2"

**Explanation:** This is a Biology question that falls under the content category 'Transmission of Heritable Information from Generation to Generation.' The answer is B because only the affected (homozygous recessive) phenotype directly reveals a genotype frequency, and the textbook gives the frequency of \(qq\) individuals as \(q^2\) (OpenStax Biology 2e: \"the frequency of pp individuals is simply p2; the frequency of pq individuals is 2pq; and the frequency of qq individuals is q2\"). The affected frequency is \(q^2 = 0.16\), so \(q = \sqrt{0.16} = 0.4\); because \(p + q = 1\), \(p = 0.6\). The heterozygote (carrier) frequency is \(2pq = 2(0.6)(0.4) = 0.48\). (Choice A) \(0.40\) is the value of \(q\) (the recessive allele frequency) itself, not the heterozygote genotype frequency, so it skips the \(2pq\) step. (Choice B) is correct: \(2pq = 2(0.6)(0.4) = 0.48\). (Choice C) \(0.24\) is \(pq = (0.6)(0.4)\), which forgets the factor of \(2\) that the textbook places in the \(2pq\) term. (Choice D) \(0.16\) is \(q^2\), the homozygous recessive (affected) frequency, which the textbook identifies as the affected phenotype rather than the carrier frequency. This is a Scientific Reasoning and Problem Solving question because you must apply the Hardy-Weinberg equation to allele- and genotype-frequency data to deduce \(q\) from \(q^2\) and then compute \(2pq\).

---

## Q19 — Genetic Drift & Population Change · **easy** · Skill 1 · 75s · conf 5
**Stem:** A herpetologist is comparing two isolated lizard colonies on neighboring islands: one colony of roughly 12 individuals and one of roughly 1,200 individuals. She observes that allele frequencies in one colony shift noticeably from one generation to the next purely by chance, even though no allele appears to confer any survival or reproductive advantage. In which type of colony is this chance-driven change in allele frequencies expected to have the STRONGEST effect?

- **A.** The small colony of about 12 ✅
- **B.** The large colony of about 1,200
- **C.** The colony under stronger natural selection
- **D.** The colony with greater gene flow

**Correct (A):** openstax-biology-2e.txt lines 22985-22989: "Small populations are more susceptible to the forces of genetic drift. Large populations, alternatively, are buffered against the effects of chance. If one individual of a population of 10 individuals happens to die at a young age before it leaves any offspring to the next generation, all of its genes—1/10 of the population's gene pool—will be suddenly lost. In a population of 100, that's only 1 percent of the overall gene pool; therefore, it is much less impactful on the population's genetic structure."

**Distractors:**
- **B** — _reversed_relationship_: This reverses the textbook relationship. Large populations are explicitly 'buffered against the effects of chance,' so genetic drift has its weakest, not strongest, effect in the colony of about 1,200.  
  ↳ openstax-biology-2e.txt lines 22985-22986: "Small populations are more susceptible to the forces of genetic drift. Large populations, alternatively, are buffered against the effects of chance."
- **C** — _adjacent_fact_: Natural selection acts on traits that confer a survival or reproductive advantage, but the stem specifies the change confers 'no advantage.' This describes a different evolutionary force, not the chance sampling that defines drift.  
  ↳ openstax-biology-2e.txt lines 22806-22807: "Sometimes, allele frequencies within a population change randomly with no advantage to the population over existing allele frequencies. We call this phenomenon genetic drift."
- **D** — _adjacent_fact_: Gene flow is the migration-driven movement of alleles in and out of a population, a separate evolutionary force from genetic drift; it does not describe chance change in allele frequencies within an isolated colony.  
  ↳ openstax-biology-2e.txt lines 23070-23072: "Another important evolutionary force is gene flow: the flow of alleles in and out of a population due to the migration of individuals" (glossary lines 23385-23386 confirm).

**Explanation:** This is a Biology question that falls under the content category 'Transmission of Heritable Information from Generation to Generation.' The answer is A because the chance-driven change described is genetic drift, defined as 'the effect of chance' on a population's gene pool, and the textbook states plainly that 'Small populations are more susceptible to the forces of genetic drift. Large populations, alternatively, are buffered against the effects of chance.' The text illustrates this with the math of loss: if one individual in a population of 10 dies before reproducing, '1/10 of the population's gene pool' is suddenly lost, whereas in a population of 100 the same loss is 'only 1 percent of the overall gene pool' and 'much less impactful.' A colony of about 12 therefore loses a far larger fraction of its alleles per individual than a colony of about 1,200, so drift hits the small colony hardest. (Choice A) is correct: a colony of roughly 12 is the small, drift-susceptible population in which each individual represents a large fraction of the gene pool. (Choice B) is wrong because large populations are explicitly 'buffered against the effects of chance,' so drift is weakest there, not strongest. (Choice C) describes natural selection, which acts on advantageous traits; the stem specifies the change confers 'no advantage,' so selection, not drift, would be the operative force here. (Choice D) describes gene flow, 'the flow of alleles in and out of a population due to the migration of individuals,' a separate evolutionary force from the chance sampling that defines drift. This is a Knowledge of Scientific Concepts and Principles question because you must recall that genetic drift exerts a stronger effect in small populations while large populations are buffered against chance.

---

## Q20 — Genetic Drift & Population Change · **medium** · Skill 2 · 105s · conf 5
**Stem:** A genetic counselor notes that a small religious community, descended from roughly 30 settlers who emigrated three centuries ago, shows a much higher frequency of a rare recessive disease allele than the large source population they left. The allele confers no survival or reproductive advantage in the community's environment, and there has been almost no migration in or out since settlement. Which evolutionary force most likely explains the community's atypical allele frequency?

- **A.** Bottleneck effect from a catastrophe
- **B.** Founder effect from unrepresentative settlers ✅
- **C.** Gene flow from neighboring populations
- **D.** Natural selection favoring the allele

**Correct (B):** openstax-biology-2e.txt, lines 23010-23020: "those individuals are an unlikely representation of the entire population, which results in the founder effect. The founder effect occurs when the genetic structure changes to match that of the new population's founding fathers and mothers." and line 23378 (glossary): "founder effect event that initiates an allele frequency change in part of the population, which is not typical of the original population."

**Distractors:**
- **A** — _adjacent_fact_: The bottleneck effect is the magnification of genetic drift when a catastrophe suddenly kills much of an EXISTING population; here a small group emigrated to found a NEW population, which is the founder effect, not a bottleneck. Both are forms of drift, making this a tempting near-miss.  
  ↳ openstax-biology-2e.txt, lines 23001-23002 and line 23367 (glossary): "bottleneck effect magnification of genetic drift as a result of natural events or catastrophes"
- **C** — _reversed_relationship_: Gene flow is the movement of alleles INTO or out of a population via migration; the stem states there has been almost no migration since settlement, so gene flow is explicitly ruled out rather than being the cause.  
  ↳ openstax-biology-2e.txt, line 23071 and line 23385 (glossary): "gene flow flow of alleles in and out of a population due to the individual or gamete migration"
- **D** — _misconception_: Natural selection increases an allele's frequency only when the allele improves survival or reproduction; the stem specifies the allele confers no advantage, so selection cannot be the mechanism and chance (drift via the founders) must be.  
  ↳ openstax-biology-2e.txt, lines 22797-22800: "An example is if a given allele confers a phenotype that allows an individual to better survive or have more offspring... Over time, the allele will spread throughout the population."

**Explanation:** This is a Biology question that falls under the content category 'Transmission of Heritable Information from Generation to Generation.' The answer is B because a small group of settlers leaving to start a new population is an unlikely representation of the original population, so the new community's allele frequencies come to match those of its few founders rather than the source population. OpenStax states that when "some portion of the population leaves to start a new population in a new location... those individuals are an unlikely representation of the entire population, which results in the founder effect," and gives the Afrikaner settlers as an example showing "unusually high incidences" of disease because "a higher-than-normal proportion of the founding colonists carried these mutations" (openstax-biology-2e.txt, lines 23010-23020). Because the allele confers no advantage and there is essentially no migration, chance sampling among the ~30 founders, not selection or gene flow, drove the elevated frequency. (Choice A) is incorrect: the bottleneck effect is the "magnification of genetic drift as a result of natural events or catastrophes" that suddenly wipe out much of an existing population (lines 23001-23002, 23367), but here a small group emigrated to found a new population rather than a disaster reducing the original one. (Choice B) is correct: the founder effect is an "event that initiates an allele frequency change in part of the population, which is not typical of the original population" (line 23378), exactly the unrepresentative-settler scenario described. (Choice C) is incorrect: gene flow is the "flow of alleles in and out of a population due to the migration of individuals or gametes" (line 23071), but the community had almost no migration after settlement, so gene flow cannot account for the divergence. (Choice D) is incorrect: natural selection raises an allele's frequency only when it "allows an individual to better survive or have more offspring" (lines 22797-22800), yet the stem specifies the allele confers no survival or reproductive advantage. This is a Scientific Reasoning and Problem Solving question because you must apply the definitions of the evolutionary forces to a specific population scenario and reason from the given conditions to the mechanism responsible.

---

## Q21 — Genetic Drift & Population Change · **easy** · Skill 1 · 75s · conf 5
**Stem:** A wildfire sweeps through a forest and kills, at random, all but a dozen members of a large beetle population. The few survivors reproduce, and their reduced set of alleles now constitutes the genetic structure of the entire rebuilt population. This change in the gene pool is best attributed to which evolutionary phenomenon?

- **A.** Gene flow into the population
- **B.** The founder effect
- **C.** Inbreeding depression
- **D.** The bottleneck effect ✅

**Correct (D):** openstax-biology-2e.txt, lines 23000-23003: "Natural events, such as an earthquake disaster that kills—at random—a large portion of the population, can magnify genetic drift. Known as the bottleneck effect, it results in suddenly wiping out a large portion of the gene pool... At once, the survivors' genetic structure becomes the entire population's genetic structure, which may be very different from the pre-disaster population." Glossary lines 23367-23368: "bottleneck effect magnification of genetic drift as a result of natural events or catastrophes."

**Distractors:**
- **A** — _adjacent_fact_: Gene flow is a real evolutionary force, but it is "flow of alleles in and out of a population due to the individual or gamete migration" (lines 23385-23386). The wildfire scenario involves no migration in or out; the gene pool shrinks in place because of random deaths, not movement of alleles.  
  ↳ openstax-biology-2e.txt, lines 23385-23386 (glossary): "gene flow flow of alleles in and out of a population due to the individual or gamete migration"; line 23071: "Another important evolutionary force is gene flow: the flow of alleles in and out of a population due to the migration..."
- **B** — _misconception_: The founder effect also magnifies genetic drift, but it applies when "some portion of the population leaves to start a new population in a new location," so the change matches the breakaway founding group (lines 23010-23014). Here no group emigrates; a catastrophe reduces the existing population in place, which is the bottleneck effect, not the founder effect.  
  ↳ openstax-biology-2e.txt, lines 23010-23014: "if some portion of the population leaves to start a new population in a new location... which results in the founder effect"; glossary lines 23378-23379: "founder effect event that initiates an allele frequency change in part of the population, which is not typical of the original population"
- **C** — _adjacent_fact_: Inbreeding depression is the "increase in abnormalities and disease in inbreeding populations" caused by mating among close relatives, which brings together deleterious recessive alleles (lines 22930-22939). It describes a consequence of nonrandom mating, not a random catastrophe that culls the gene pool, so it does not name the phenomenon in the scenario.  
  ↳ openstax-biology-2e.txt, lines 22930-22939: "inbreeding, the mating of closely related individuals... a phenomenon that scientists call inbreeding depression"; glossary lines 23370-23371: "inbreeding depression increase in abnormalities and disease in inbreeding populations"

**Explanation:** This is a Biology question that falls under the content category 'Transmission of Heritable Information from Generation to Generation.' The answer is D because the scenario describes a natural catastrophe that randomly kills most of a population, leaving survivors whose reduced gene pool becomes the entire population's genetic structure. OpenStax states that natural events such as a disaster that kills at random a large portion of the population can magnify genetic drift: "Known as the bottleneck effect, it results in suddenly wiping out a large portion of the gene pool... At once, the survivors' genetic structure becomes the entire population's genetic structure, which may be very different from the pre-disaster population" (openstax-biology-2e.txt, lines 23000-23003). The glossary defines the bottleneck effect as "magnification of genetic drift as a result of natural events or catastrophes" (lines 23367-23368), which exactly matches the random wildfire here. (Choice A) is incorrect because gene flow is "flow of alleles in and out of a population due to the individual or gamete migration" (lines 23385-23386); no individuals are migrating in or out in this scenario. (Choice B) is incorrect because the founder effect occurs when "some portion of the population leaves to start a new population in a new location," so the genetic change matches that of a breakaway founding group (lines 23010-23014); here no group emigrates, the population is reduced in place by a disaster. (Choice C) is incorrect because inbreeding depression is the "increase in abnormalities and disease in inbreeding populations" from the mating of closely related individuals (lines 22930-22939, 23370-23371), which describes consequences of mate choice rather than a catastrophe randomly culling the gene pool. (Choice D) is correct: a chance catastrophe wiped out most of the gene pool and the survivors' genetic structure became the whole population's, the defining outcome of the bottleneck effect (lines 23000-23003). This is a Knowledge of Scientific Concepts and Principles question because you must recall the definition of the bottleneck effect and distinguish it from the other forces that change a population's gene pool.

---

## Q22 — Genetic Drift & Population Change · **medium** · Skill 2 · 105s · conf 5
**Stem:** Two populations of a lizard species live on neighboring islands and have evolved slightly different allele frequencies at several loci. A storm deposits floating debris that lets a number of lizards drift from one island and breed with residents of the other. As this migration continues across generations, it most directly affects the recipient population's gene pool by:

- **A.** reshaping it to match a few founding migrants
- **B.** randomly eliminating alleles by chance sampling
- **C.** introducing alleles and reducing between-population differences ✅
- **D.** abruptly shrinking variation after a catastrophe

**Correct (C):** OpenStax Biology 2e, lines 23071-23078: "Another important evolutionary force is gene flow: the flow of alleles in and out of a population due to the migration of individuals or gametes... This variable flow of individuals in and out of the group not only changes the population's gene structure, but it can also introduce new genetic variation to populations in different geological locations and habitats." Also lines 22117-22123: ongoing gene flow keeps an allele's frequency "similar" across a range, while blocking it lets frequencies "gradually become increasingly different."

**Distractors:**
- **A** — _adjacent_fact_: This describes the founder effect, where a small group starting a NEW population reshapes the gene pool to match its founders; the scenario has migrants joining an EXISTING population, which is gene flow, not founding.  
  ↳ OpenStax Biology 2e, lines 23012-23014: 'The founder effect occurs when the genetic structure changes to match that of the new population's founding fathers and mothers.'
- **B** — _adjacent_fact_: This describes genetic drift, the random chance-based loss of alleles; gene flow instead directionally moves alleles via migration and adds variation rather than eliminating it by chance.  
  ↳ OpenStax Biology 2e, lines 22956-22980: 'genetic drift... is simply the effect of chance' and 'can lead to eliminating an allele from a population by chance.'
- **D** — _adjacent_fact_: This describes the bottleneck effect, a catastrophe that suddenly destroys much of the gene pool and reduces variation; gene flow does the opposite by introducing new alleles.  
  ↳ OpenStax Biology 2e, lines 23000-23003: 'Known as the bottleneck effect, it results in suddenly wiping out a large portion of the gene pool... which may be very different from the pre-disaster population.'

**Explanation:** This is a Biology question that falls under the content category 'Transmission of Heritable Information from Generation to Generation.' The answer is C because gene flow is the flow of alleles in and out of a population due to the migration of individuals or gametes; OpenStax states this "variable flow of individuals in and out of the group not only changes the population's gene structure, but it can also introduce new genetic variation to populations in different geological locations and habitats" (lines 23071-23078). Because migrants carry alleles from the source island into the recipient island, gene flow adds new variation to the recipient pool while making the two geographically separated groups' allele frequencies more similar — the textbook notes that ongoing gene flow keeps an allele's frequency at one end of a range "similar to the allele's frequency at the other end," whereas blocking that flow lets frequencies "gradually become increasingly different" (lines 22117-22123). (Choice A) describes the founder effect, in which "the genetic structure changes to match that of the new population's founding fathers and mothers" when a small group starts a new population (lines 23012-23014); here migrants are joining an existing population, not founding a new one. (Choice B) describes genetic drift, "simply the effect of chance," which removes alleles by random sampling rather than by directed migration (lines 22956-22980). (Choice C) is correct: migration of individuals moves alleles into the recipient pool, adding variation and homogenizing allele frequencies between the separated islands (lines 23071-23078, 22117-22123). (Choice D) describes the bottleneck effect, in which a catastrophe such as an earthquake "results in suddenly wiping out a large portion of the gene pool," reducing variation rather than adding it (lines 23000-23003). This is a Scientific Reasoning and Problem Solving question because you must apply the definition of gene flow to predict its specific effect on a recipient population's alleles and distinguish it from drift, founder, and bottleneck effects.

---

## Q23 — Genetic Drift & Population Change · **hard** · Skill 2 · 150s · conf 5
**Stem:** In an isolated human community, a rare autosomal recessive disorder appears far more often than in the surrounding region, even though the frequency of the disease allele in the community's gene pool is no higher. Most affected children are born to parents who are closely related. The increased incidence of affected children in this community is best explained by inbreeding raising the probability that:

- **A.** two carriers mate, yielding homozygous recessive offspring ✅
- **B.** a new disease allele arises by mutation
- **C.** the recessive allele's frequency increases overall
- **D.** deleterious alleles migrate in from neighbors

**Correct (A):** openstax-biology-2e.txt lines 22928-22939: "inbreeding, the mating of closely related individuals, which can have the undesirable effect of bringing together deleterious recessive mutations that can cause abnormalities and susceptibility to disease... it will only manifest itself when an individual carries two copies of the allele... if a family of carriers begins to interbreed with each other, this will dramatically increase the likelihood of two carriers mating and eventually producing diseased offspring, a phenomenon that scientists call inbreeding depression." Lines 22837-22838: "the frequency of pq individuals is 2pq; and the frequency of qq individuals is q2."

**Distractors:**
- **B** — _misconception_: Inbreeding produces no new alleles; it only redistributes existing ones into homozygous combinations. The textbook states mutation, 'a change in DNA, is the ultimate source of new alleles, or new genetic variation,' so generating a new disease allele is the role of mutation, not of mating between relatives.  
  ↳ openstax-biology-2e.txt lines 21767-21768: "Mutation, a change in DNA, is the ultimate source of new alleles, or new genetic variation in any population." Line 23087: "The appearance of new mutations is the most common way to introduce novel genotypic and phenotypic variability."
- **C** — _reversed_relationship_: This reverses what inbreeding changes: it raises the frequency of homozygous recessive genotypes, not the frequency of the recessive allele in the gene pool. The text explicitly says the rare disease allele 'maintains itself at low levels in the gene pool,' and the stem stipulates the allele frequency is unchanged, so the allele frequency does not rise.  
  ↳ openstax-biology-2e.txt lines 22936-22937: "it will not happen frequently enough for natural selection to be able to swiftly eliminate the allele from the population, and as a result, the allele maintains itself at low levels in the gene pool."
- **D** — _adjacent_fact_: The in-migration of deleterious alleles from a neighboring population describes gene flow, a separate evolutionary force from inbreeding. The community is isolated and the affected children come from related parents within it, so no migration is occurring; this option swaps inbreeding for gene flow.  
  ↳ openstax-biology-2e.txt lines 23071-23072: "gene flow: the flow of alleles in and out of a population due to the migration of individuals or gametes." Line 23350: "gene flow, often do the opposite: introducing deleterious alleles to the population's gene pool."

**Explanation:** This is a Biology question that falls under the content category 'Transmission of Heritable Information from Generation to Generation.' The answer is A because inbreeding, the mating of closely related individuals, has the undesirable effect of "bringing together deleterious recessive mutations," and a disease caused by a rare recessive allele "will only manifest itself when an individual carries two copies of the allele." A heterozygous carrier (frequency \(2pq\)) shows no symptoms, so the rare allele is normally hidden; only a homozygous recessive individual (frequency \(q^2\)) is affected. In an outbred population the chance that two carriers mate is low, but when relatives interbreed, "this will dramatically increase the likelihood of two carriers mating and eventually producing diseased offspring," the phenomenon called inbreeding depression. Crucially, inbreeding does not change the allele frequencies \(p\) and \(q\); it only reshuffles existing alleles into more homozygous combinations, which is why the gene-pool frequency stays the same while the incidence of affected (\(q^2\)) offspring rises. (Choice A) is correct: pairing two heterozygous carriers raises the share of offspring that are homozygous recessive and therefore affected, exactly as the textbook describes for inbreeding depression. (Choice B) is wrong because mutation, "a change in DNA, is the ultimate source of new alleles"; inbreeding generates no new alleles, it only combines alleles already present. (Choice C) is wrong because it reverses the relationship: inbreeding alters genotype frequencies (more homozygotes), not allele frequencies, and the text notes the rare allele "maintains itself at low levels in the gene pool." (Choice D) is wrong because the in-migration of deleterious alleles from a neighboring population is gene flow, "the flow of alleles in and out of a population due to the migration of individuals," a different evolutionary force than inbreeding within an isolated community. This is a Scientific Reasoning and Problem Solving question because you must apply the carrier-to-homozygous-recessive logic to a population scenario and distinguish a genotype-frequency change from an allele-frequency change.

---

## Q24 — Genetic Drift & Population Change · **hard** · Skill 2 · 150s · conf 5
**Stem:** In a small, isolated population of island lizards, the frequency of a particular coat-pattern allele rises from \(0.30\) to \(0.55\) over three generations. Researchers find that lizards carrying this allele survive and reproduce no better than lizards lacking it, and no migrants have entered the population. This allele-frequency change is most consistent with which evolutionary force?

- **A.** Gene flow from a neighboring population
- **B.** Directional natural selection on the allele
- **C.** A founder effect during colonization
- **D.** Genetic drift acting by chance ✅

**Correct (D):** openstax-biology-2e.txt lines 22806-22807: "Sometimes, allele frequencies within a population change randomly with no advantage to the population over existing allele frequencies. We call this phenomenon genetic drift." Also lines 22957-22959: genetic drift is "simply the effect of chance ... not due to an advantage conferred by some genetically-encoded trait," and line 22985: "Small populations are more susceptible to the forces of genetic drift." Glossary line 23389: "genetic drift effect of chance on a population's gene pool."

**Distractors:**
- **A** — _adjacent_fact_: Gene flow is a real force that changes allele frequencies, but it requires migration of individuals or gametes, which the stem explicitly excludes ('no migrants have entered the population'). It is a 510-tempting trap because gene flow also changes allele frequency without a fitness advantage, but the no-migration condition rules it out.  
  ↳ openstax-biology-2e.txt glossary lines 23385-23386: "gene flow flow of alleles in and out of a population due to the individual or gamete migration."
- **B** — _reversed_relationship_: Directional natural selection would raise an allele's frequency only if the favored genotype had higher fitness, but the data show carriers 'survive and reproduce no better' than non-carriers. Choosing this reverses the key inference: it treats any allele-frequency increase as evidence of selection, when an increase with no fitness difference indicates drift, not selection.  
  ↳ openstax-biology-2e.txt lines 22798-22801: natural selection occurs when 'a given allele confers a phenotype that allows an individual to better survive or have more offspring ... the allele will spread throughout the population.'
- **C** — _process_step_confusion_: The founder effect is also a chance/drift-related force in a small isolated population, making it tempting given the island framing, but the textbook defines it as the event that occurs when 'some portion of the population leaves to start a new population' and is 'not typical of the original population.' The stem describes ongoing change within an already-established population over three generations, not the founding of a new colony, so the founder effect does not apply.  
  ↳ openstax-biology-2e.txt glossary lines 23378-23380: "founder effect event that initiates an allele frequency change in part of the population, which is not typical of the original population"; body lines 23010-23013: the founder effect occurs 'if some portion of the population leaves to start a new population in a new location.'

**Explanation:** This is a Biology question that falls under the content category 'Transmission of Heritable Information from Generation to Generation.' The answer is D because the textbook states that 'Sometimes, allele frequencies within a population change randomly with no advantage to the population over existing allele frequencies. We call this phenomenon genetic drift,' and that with drift some individuals have more offspring 'not due to an advantage conferred by some genetically-encoded trait, but just because one [individual] happened to be in the right place at the right time.' Here the carriers reproduce no better than non-carriers (no fitness advantage), the population is small, and no migration occurred, so the rise from \(0.30\) to \(0.55\) reflects chance sampling rather than selection. The textbook adds that 'small populations are more susceptible to the forces of genetic drift,' which makes drift the strongest fit for an isolated island population. (Choice A) is incorrect because gene flow is the 'flow of alleles in and out of a population due to the individual or gamete migration,' but the stem specifies that no migrants entered the population. (Choice B) is incorrect because directional natural selection requires that the favored allele confer higher survival or reproduction, yet carriers 'survive and reproduce no better' than non-carriers, so there is no differential fitness to drive selection. (Choice C) is incorrect because the founder effect is an 'event that initiates an allele frequency change in part of the population, which is not typical of the original population' when 'some portion of the population leaves to start a new population'; here the change occurs within an already-established population over three generations, not at the founding of a new colony. (Choice D) is correct: with no fitness advantage and no migration in a small, established population, a random change in allele frequency is the definition of genetic drift, 'the effect of chance on a population's gene pool.' This is a Scientific Reasoning and Problem Solving question because you must apply the distinction between drift, selection, and the founder effect to allele-frequency data to identify the operating evolutionary force.

---

## Q25 — Genetic Drift & Population Change · **medium** · Skill 1 · 105s · conf 5
**Stem:** A conservation team manages a small captive population of an endangered fox in which a rare deleterious recessive allele causes a fatal metabolic disorder. To safeguard the population, the team imports unrelated foxes from a separate reserve, deliberately increasing the colony's genetic variability. Which of the following correctly describe(s) how raising genetic variability lessens the disorder's impact?

I. It lowers the probability that two carriers of the same deleterious recessive allele will mate.
II. It removes the deleterious recessive allele from the colony's gene pool within one generation.
III. Even when two carriers do mate, only 25% of their offspring inherit two copies of the disorder allele.

- **A.** I only
- **B.** III only
- **C.** I and III only ✅
- **D.** II and III only

**Correct (C):** OpenStax Biology 2e, lines 22929-22935: "genetic variability to preserve as much of the phenotypic diversity as possible. This also helps reduce associated risks of inbreeding... bringing together deleterious recessive mutations that can cause abnormalities and susceptibility to disease... the chance that two carriers will mate is low, and even then, only 25 percent of their offspring will inherit the disease allele from both parents."

**Distractors:**
- **A** — _partial_truth_: Includes the correct statement I but omits the equally correct statement III. OpenStax confirms BOTH the lowered chance of carriers mating AND the \(25\%\) recessive offspring ratio (Biology 2e, lines 22934-22935), so 'I only' is incomplete.  
  ↳ OpenStax Biology 2e, lines 22934-22935: "the chance that two carriers will mate is low, and even then, only 25 percent of their offspring will inherit the disease allele from both parents."
- **B** — _partial_truth_: Includes the correct statement III but drops statement I, the core mechanism. The textbook's primary point is that increasing variability lowers the likelihood two carriers mate, so excluding I removes the main reason variability lessens the disorder.  
  ↳ OpenStax Biology 2e, lines 22929-22934: "This also helps reduce associated risks of inbreeding... the chance that two carriers will mate is low."
- **D** — _misconception_: Pairs true statement III with false statement II. Statement II claims outbreeding removes the allele in one generation, but OpenStax states the allele 'maintains itself at low levels in the gene pool' because selection cannot swiftly eliminate it—variability reduces expression, not allele presence.  
  ↳ OpenStax Biology 2e, lines 22936-22937: "natural selection to be able to swiftly eliminate the allele from the population, and as a result, the allele maintains itself at low levels in the gene pool."

**Explanation:** This is a Biology question that falls under the content category 'Transmission of Heritable Information from Generation to Generation.' The answer is C because raising genetic variability (here, by out-crossing to unrelated foxes) works through two textbook-supported effects: it makes carrier-by-carrier matings rarer, and—when such a mating does occur—the basic recessive cross still affects only one quarter of the offspring. OpenStax states that increasing a population's genetic variability "helps reduce associated risks of inbreeding... bringing together deleterious recessive mutations," noting that "the chance that two carriers will mate is low, and even then, only 25 percent of their offspring will inherit the disease allele from both parents" (Biology 2e, lines 22929-22935); a monohybrid \(Aa \times Aa\) cross indeed yields \(\tfrac{1}{4}\) (\(25\%\)) affected \(aa\) offspring. So statements I and III are both correct. Statement II is false: the same passage explains the allele "maintains itself at low levels in the gene pool" precisely because selection "[cannot] swiftly eliminate the allele" (lines 22936-22937)—variability dilutes the risk of expression, it does not purge the allele. (Choice A) is wrong because it includes the true statement I but discards the equally correct statement III about the \(25\%\) recessive ratio. (Choice B) is wrong because it includes the true statement III but discards statement I, the central mechanism by which variability lowers the chance two carriers meet. (Choice C) is correct: statements I and III are both directly supported, while the false statement II is excluded. (Choice D) is wrong because it pairs true statement III with false statement II, which overstates outbreeding as eliminating the allele rather than reducing the frequency of its expression. This is a Knowledge of Scientific Concepts and Principles question because you must recall how increasing genetic variability reduces the expression of deleterious recessive alleles without removing them from the gene pool.

---
